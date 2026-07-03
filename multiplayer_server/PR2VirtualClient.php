<?php

namespace pr2\multi;

// Placeholder socket used during the race reconnect grace window.
// It keeps packet-number bookkeeping alive after the real socket drops,
// while making writes no-ops until the player either resumes or expires.
class PR2VirtualClient
{
    public $player;
    public $ip;
    public $id;
    public $last_user_action = 0;
    public $last_action = 0;
    public $process = false;
    public $disconnected = false;

    private $send_num = 0;
    private $rec_num = -1;

    public function __construct(Player $player, PR2Client $sourceSocket)
    {
        $this->player = $player;
        $this->ip = $sourceSocket->ip;
        $this->id = 'virtual-' . $player->user_id . '-' . substr(md5((string) microtime(true)), 0, 8);
        $this->last_user_action = $sourceSocket->last_user_action;
        $this->last_action = $sourceSocket->last_action;
        $this->send_num = $sourceSocket->peekNextSendNum();
        $this->rec_num = $sourceSocket->peekLastReceivedNum();
    }

    public function write($buffer, $length = 4096)
    {
        unset($buffer, $length);
        $this->send_num++;
        $this->last_action = time();
    }

    public function close()
    {
        $this->disconnected = true;
    }

    public function onDisconnect()
    {
    }

    public function markIntentionalDisconnect(): void
    {
    }

    public function peekNextSendNum(): int
    {
        return (int) $this->send_num;
    }

    public function peekLastReceivedNum(): int
    {
        return (int) $this->rec_num;
    }

    public function isVirtual(): bool
    {
        return true;
    }
}
