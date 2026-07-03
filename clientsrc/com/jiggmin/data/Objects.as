package com.jiggmin.data
{
   import blocks.*;
   import flash.display.DisplayObject;
   
   public class Objects
   {
      
      private static const STAMP_TREE:int = 0;
      
      private static const STAMP_TREE2:int = 1;
      
      private static const STAMP_TREE3:int = 2;
      
      private static const STAMP_PETRIFIED_TREE:int = 3;
      
      private static const STAMP_CACTUS:int = 4;
      
      private static const STAMP_ROCK:int = 5;
      
      private static const STAMP_ROCK2:int = 6;
      
      private static const STAMP_SPIRE:int = 7;
      
      private static const STAMP_SPIRE2:int = 8;
      
      private static const STAMP_BUILDING1:int = 9;
      
      public static const BLOCK_BASIC1:int = 100;
      
      public static const BLOCK_BASIC2:int = 101;
      
      public static const BLOCK_BASIC3:int = 102;
      
      public static const BLOCK_BASIC4:int = 103;
      
      public static const BLOCK_BRICK:int = 104;
      
      public static const BLOCK_ARROW_DOWN:int = 105;
      
      public static const BLOCK_ARROW_UP:int = 106;
      
      public static const BLOCK_ARROW_LEFT:int = 107;
      
      public static const BLOCK_ARROW_RIGHT:int = 108;
      
      public static const BLOCK_MINE:int = 109;
      
      public static const BLOCK_ITEM:int = 110;
      
      public static const BLOCK_START1:int = 111;
      
      public static const BLOCK_START2:int = 112;
      
      public static const BLOCK_START3:int = 113;
      
      public static const BLOCK_START4:int = 114;
      
      public static const BLOCK_ICE:int = 115;
      
      public static const BLOCK_FINISH:int = 116;
      
      public static const BLOCK_CRUMBLE:int = 117;
      
      public static const BLOCK_VANISH:int = 118;
      
      public static const BLOCK_MOVE:int = 119;
      
      public static const BLOCK_WATER:int = 120;
      
      public static const BLOCK_ROTATE_RIGHT:int = 121;
      
      public static const BLOCK_ROTATE_LEFT:int = 122;
      
      public static const BLOCK_PUSH:int = 123;
      
      public static const BLOCK_SAFETY:int = 124;
      
      public static const BLOCK_ITEM_INF:int = 125;
      
      public static const BLOCK_HAPPY:int = 126;
      
      public static const BLOCK_SAD:int = 127;
      
      public static const BLOCK_HEART:int = 128;
      
      public static const BLOCK_TIME:int = 129;
      
      public static const BLOCK_MINION_EGG:int = 130;
      
      public static const BLOCK_CUSTOM_STATS:int = 131;
      
      public static const BLOCK_TELEPORT:int = 132;

      public static const BLOCK_MUD:int = 150;
      public static const BLOCK_FREEZE:int = 151;
      
      public static const BG1Code:int = 201;
      
      public static const BG2Code:int = 202;
      
      public static const BG3Code:int = 203;
      
      public static const BG4Code:int = 204;
      
      public static const BG5Code:int = 205;
      
      public static const BG6Code:int = 206;
      
      public static const BG7Code:int = 207;
      
      public static const TextCode:int = 300;
       
      
      public function Objects()
      {
         super();
      }
      
      public static function getFromCode(param1:int) : DisplayObject
      {
         if(param1 == STAMP_TREE)
         {
            return new Tree();
         }
         if(param1 == STAMP_TREE2)
         {
            return new Tree2();
         }
         if(param1 == STAMP_TREE3)
         {
            return new Tree3();
         }
         if(param1 == STAMP_PETRIFIED_TREE)
         {
            return new PetrifiedTree();
         }
         if(param1 == STAMP_CACTUS)
         {
            return new Cactus();
         }
         if(param1 == STAMP_ROCK)
         {
            return new Rock();
         }
         if(param1 == STAMP_ROCK2)
         {
            return new Rock2();
         }
         if(param1 == STAMP_SPIRE)
         {
            return new Spire();
         }
         if(param1 == STAMP_SPIRE2)
         {
            return new Spire2();
         }
         if(param1 == STAMP_BUILDING1)
         {
            return new Building1();
         }
         if(param1 == BLOCK_BASIC1)
         {
            return new BasicBlock(BLOCK_BASIC1);
         }
         if(param1 == BLOCK_BASIC2)
         {
            return new BasicBlock(BLOCK_BASIC2);
         }
         if(param1 == BLOCK_BASIC3)
         {
            return new BasicBlock(BLOCK_BASIC3);
         }
         if(param1 == BLOCK_BASIC4)
         {
            return new BasicBlock(BLOCK_BASIC4);
         }
         if(param1 == BLOCK_BRICK)
         {
            return new BrickBlock();
         }
         if(param1 == BLOCK_CRUMBLE)
         {
            return new CrumbleBlock();
         }
         if(param1 == BLOCK_FINISH)
         {
            return new FinishBlock();
         }
         if(param1 == BLOCK_HAPPY)
         {
            return new HappyBlock();
         }
         if(param1 == BLOCK_ICE)
         {
            return new IceBlock();
         }
         if(param1 == BLOCK_ITEM_INF)
         {
            return new InfItemBlock();
         }
         if(param1 == BLOCK_ITEM)
         {
            return new ItemBlock();
         }
         if(param1 == BLOCK_MINE)
         {
            return new MineBlock();
         }
         if(param1 == BLOCK_MOVE)
         {
            return new MoveBlock();
         }
         if(param1 == BLOCK_PUSH)
         {
            return new PushBlock();
         }
         if(param1 == BLOCK_ROTATE_LEFT)
         {
            return new RotateLeftBlock();
         }
         if(param1 == BLOCK_ROTATE_RIGHT)
         {
            return new RotateRightBlock();
         }
         if(param1 == BLOCK_SAD)
         {
            return new SadBlock();
         }
         if(param1 == BLOCK_SAFETY)
         {
            return new SafetyBlock();
         }
         if(param1 == BLOCK_START1)
         {
            return new StartBlock(BLOCK_START1,1);
         }
         if(param1 == BLOCK_START2)
         {
            return new StartBlock(BLOCK_START2,2);
         }
         if(param1 == BLOCK_START3)
         {
            return new StartBlock(BLOCK_START3,3);
         }
         if(param1 == BLOCK_START4)
         {
            return new StartBlock(BLOCK_START4,4);
         }
         if(param1 == BLOCK_VANISH)
         {
            return new VanishBlock();
         }
         if(param1 == BLOCK_WATER)
         {
            return new WaterBlock();
         }
         if(param1 == BLOCK_ARROW_DOWN)
         {
            return new ArrowDownBlock();
         }
         if(param1 == BLOCK_ARROW_LEFT)
         {
            return new ArrowLeftBlock();
         }
         if(param1 == BLOCK_ARROW_RIGHT)
         {
            return new ArrowRightBlock();
         }
         if(param1 == BLOCK_ARROW_UP)
         {
            return new ArrowUpBlock();
         }
         if(param1 == BLOCK_HEART)
         {
            return new HeartBlock();
         }
         if(param1 == BLOCK_TIME)
         {
            return new TimeBlock();
         }
         if(param1 == BLOCK_MINION_EGG)
         {
            return new EggBlockGraphic();
         }
         if(param1 == BLOCK_CUSTOM_STATS)
         {
            return new CustomStatsBlock();
         }
         if(param1 == BLOCK_TELEPORT)
         {
            return new TeleportBlock();
         }
         if(param1 == BLOCK_FREEZE)
         {
            return new FreezeBlock();
         }
         if(param1 == BLOCK_MUD)
         {
            return new MudBlock();
         }
         if(param1 == BG1Code)
         {
            return new BG1();
         }
         if(param1 == BG2Code)
         {
            return new BG2();
         }
         if(param1 == BG3Code)
         {
            return new BG3();
         }
         if(param1 == BG4Code)
         {
            return new BG4();
         }
         if(param1 == BG5Code)
         {
            return new BG5();
         }
         if(param1 == BG6Code)
         {
            return new BG6();
         }
         if(param1 == BG7Code)
         {
            return new BG7();
         }
         if(param1 == TextCode)
         {
            return new TextObjectGraphic().textBox;
         }
         return null;
      }
   }
}
