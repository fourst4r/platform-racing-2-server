Keyboard Focus Notes (PR2 clientsrc)

Core flow:
1) `Keys.initialize(stage)` registers `KEY_DOWN`, `KEY_UP`, `DEACTIVATE`, and `FOCUS_OUT` on `Main.stage`.
2) `Keys` only tracks pressed keys if those stage events fire; it clears the map on `DEACTIVATE` and `FOCUS_OUT`.
3) Camera movement in `GamePage.keyScroll` is blocked whenever `Main.stage.focus` is a `TextField`.

Important implications:
- Focus changes clear key state:
  - `Keys.resetKeys` runs on `Event.DEACTIVATE` and `FocusEvent.FOCUS_OUT`.
  - If focus leaves the stage (or a focused component changes), held movement keys are cleared and won't be recognized until pressed again.
- `GamePage.keyScroll` explicitly ignores movement when any `TextField` has focus.
- `LocalCharacter.updateKeys` only ignores input when focus is the race chat box (`RaceChat.textBox`), not any `TextField`.

Where focus is explicitly set:
- `page/GamePage.as` sets `Main.stage.focus = Main.stage` during `initialize()`.
- `package_6/TestCourse.as` calls `Main.stage.focus = Main.stage` every frame in `go()`.
- `package_6/RaceChat.as`:
  - Pressing Enter focuses the chat input.
  - Clicking outside the chat input or sending a message returns focus to the stage.
- `levelEditor/TextObject.as`:
  - Entering text edit mode sets focus to the editable `TextField`.
  - Exiting edit mode resets focus to the stage.
- `levelEditor/LevelEditorMenu.as` sets focus to the stage after changing zoom.
- Various UI/popups (`ui/PageNavigation.as`, `ui/GameSound.as`, `package_4/Popup.as`) also restore focus to the stage.

Why this matters for camera control:
- Camera free-scroll uses `GamePage.keyScroll`, which is gated by `!(Main.stage.focus is TextField)`.
- If any UI widget keeps focus on a `TextField` (including hidden/leftover focus targets), key-based camera movement will not trigger, even though `Keys` may still be tracking keys.

TestCourse-specific note:
- Test Course includes FL controls (stat sliders/text boxes) that can hold focus. If focus stays on a `TextField`, `GamePage.keyScroll` will refuse to move the camera.
- `TestCourse` listens for `P` and toggles free camera via `toggleKeyScroll(...)`, explicitly clearing focus to the stage when toggling so camera movement isn't blocked by text focus.
