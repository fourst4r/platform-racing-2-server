<?php

namespace pr2\multi;

class PR2Client extends \chabot\SocketServerClient
{
    private const TRANSPORT_RAW = 'raw';
    private const TRANSPORT_WEBSOCKET = 'websocket';
    private const WEBSOCKET_GUID = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11';

    public static $ip_array = array();
    private $subtracted_ip = false;

    private $rec_num = -1;
    private $send_num = 0;
    private $disconnect_handled = false;
    private $intentional_disconnect = false;
    private $transport_mode = null;
    private $app_read_buffer = '';
    public $last_user_action = 0;
    public $last_action = 0;
    public $login_id;
    public $process = false;
    public $ip;
    public $id;
    public $player;

    public function __construct($socket)
    {
        parent::__construct($socket);
        $this->id = spl_object_id($socket);
        $time = time();
        $this->last_action = $time;
        $this->last_user_action = $time;
        output(" --- Creating PR2Client --- ");
    }

    private function handleRequest($string)
    {
        global $verbose;
        if ($verbose === true) {
            output('READ: ' . $string);
        }
        try {
            $array = explode('`', $string);
            if ($this->process) {
                $call = $array[0];
                $function = "process_$call";
                array_splice($array, 0, 1);
                $data = join('`', $array);
            } else {
                $hash = $array[0];
                $send_num = (int) $array[1];
                $call = $array[2];
                $function = "client_$call";

                array_splice($array, 0, 3);
                $data = join('`', $array);

                $str_to_hash = SALT . $send_num . '`' . $call . '`' . $data;
                $local_hash = md5($str_to_hash);
                $sub_hash = substr($local_hash, 0, 3);

                // if ($sub_hash !== $hash) {
                //     $this->close();
                //     $this->onDisconnect();
                //     throw new \Exception("The received hash doesn't match. Recieved: $hash | Local: $sub_hash");
                // }

                if ($send_num > 2 && $send_num !== $this->rec_num + 1 && $send_num !== 13) {
                    $this->close();
                    $this->onDisconnect();
                    throw new \Exception('A command was recieved out of order.');
                }

                $this->rec_num = $send_num;
            }

            if (!function_exists($function)) {
                throw new \Exception("$function is not a function.");
            }

            $function($this, $data);

            $time = time();
            $this->last_action = $time;
            if ($function !== 'client_ping') {
                $this->last_user_action = $time;
            }
        } catch (\Exception $e) {
            output('Error: '.$e->getMessage());
        }
    }

    public function onRead()
    {
        if ($this->transport_mode === null) {
            if ($this->isWebSocketHandshake($this->read_buffer)) {
                if (!$this->performWebSocketHandshake()) {
                    return;
                }
            } else {
                $this->transport_mode = self::TRANSPORT_RAW;
            }
        }

        if ($this->transport_mode === self::TRANSPORT_WEBSOCKET) {
            $this->consumeWebSocketFrames();
        } else {
            $this->consumeRawTransport();
        }

        // prevent a data attack
        if ((strlen($this->read_buffer) > 5000 || strlen($this->app_read_buffer) > 5000) && !$this->process) {
            $this->read_buffer = '';
            $this->app_read_buffer = '';
            output(" --- KILLED READ BUFFER --- ");
            $this->close();
            $this->onDisconnect();
        }
    }

    public function write($buffer, $length = 4096)
    {
        if (!$this->process) {
            $buffer = $this->send_num . '`' . $buffer;
            $str_to_hash = SALT . $buffer;
            $hash_bit = substr(md5($str_to_hash), 0, 3);
            $buffer = $hash_bit . '`' . $buffer;
        }
        global $verbose;
        if ($verbose === true) {
            output('WRITE: ' . $buffer);
        }
        $buffer .= chr(0x04);
        if ($this->transport_mode === self::TRANSPORT_WEBSOCKET) {
            parent::write($this->encodeWebSocketFrame($buffer), $length);
        } else {
            parent::write($buffer, $length);
        }
        $this->send_num++;
    }

    public function onConnect()
    {
        $ip = $this->remote_address;
        $this->ip = $ip;

        $ip_count = @PR2Client::$ip_array[$ip];
        $ip_count = !isset($ip_count) ? 1 : ++$ip_count;
        PR2Client::$ip_array[$ip] = $ip_count;

        if ($ip_count > 9) {
            $this->close();
            $this->onDisconnect();
        } else {
            $time = time();
            $this->last_action = $time;
            $this->last_user_action = $time;
        }
    }


    public function onDisconnect()
    {
        if ($this->disconnect_handled) {
            return;
        }
        $this->disconnect_handled = true;

        if (isset($this->player)) {
            $player = $this->player;
            $this->player = null;

            if ($this->intentional_disconnect) {
                if (isset($player->socket) && $player->socket === $this) {
                    $player->socket = null;
                }
                $player->remove();
            } else {
                $player->handleUnexpectedDisconnect($this);
            }
        }

        if (isset($this->login_id)) {
            global $login_array;
            $login_array[$this->login_id] = null;
            $this->login_id = null;
        }

        if (!$this->subtracted_ip) {
            $this->subtracted_ip = true;
            $ip = $this->remote_address;
            if (isset(PR2Client::$ip_array[$ip])) {
                PR2Client::$ip_array[$ip]--;
                if (PR2Client::$ip_array[$ip] <= 0) {
                    unset(PR2Client::$ip_array[$ip]);
                }
            }
        }

        $this->disconnected = true;
    }

    // once every 2 seconds
    public function onTimer()
    {
        if ($this->last_action !== 0) {
            $time = time();
            $action_elapsed = $time - $this->last_action;
            $user_elapsed = $time - $this->last_user_action;
            if ($action_elapsed > 60 || $user_elapsed > 1800) {
                $this->close();
                $this->onDisconnect();
            }
        }
    }

    public function getPlayer()
    {
        if (!isset($this->player)) {
            throw new \Exception('This socket does not have a player.');
        }
        return $this->player;
    }

    public function markIntentionalDisconnect(): void
    {
        $this->intentional_disconnect = true;
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
        return false;
    }

    private function consumeRawTransport(): void
    {
        if ($this->read_buffer === '<policy-file-request/>'.chr(0x00)) {
            $this->read_buffer = '';
            $this->write_buffer = '<cross-domain-policy>'.
                '<allow-access-from domain="*" to-ports="*" />'.
                '</cross-domain-policy>'.chr(0x00);
            $this->doWrite();
            return;
        }

        $this->consumeAppCommands($this->read_buffer);
    }

    private function consumeAppCommands(&$buffer): void
    {
        $end_char = strpos($buffer, chr(0x04));
        while ($end_char !== false) {
            $info = substr($buffer, 0, $end_char);
            $this->handleRequest($info);
            $buffer = substr($buffer, $end_char + 1);
            $end_char = strpos($buffer, chr(0x04));
        }
    }

    private function isWebSocketHandshake(string $buffer): bool
    {
        return strncmp($buffer, 'GET ', 4) === 0 || stripos($buffer, 'Upgrade: websocket') !== false;
    }

    private function performWebSocketHandshake(): bool
    {
        $header_end = strpos($this->read_buffer, "\r\n\r\n");
        if ($header_end === false) {
            return false;
        }

        $headers = substr($this->read_buffer, 0, $header_end + 4);
        $this->read_buffer = (string) substr($this->read_buffer, $header_end + 4);

        if (!preg_match('/Sec-WebSocket-Key:\s*(.+)\r\n/i', $headers, $matches)) {
            $this->close();
            $this->onDisconnect();
            return false;
        }

        $key = trim($matches[1]);
        $accept = base64_encode(sha1($key . self::WEBSOCKET_GUID, true));
        $response = "HTTP/1.1 101 Switching Protocols\r\n"
            ."Upgrade: websocket\r\n"
            ."Connection: Upgrade\r\n"
            ."Sec-WebSocket-Accept: $accept\r\n\r\n";

        parent::write($response, strlen($response));
        $this->transport_mode = self::TRANSPORT_WEBSOCKET;
        return true;
    }

    private function consumeWebSocketFrames(): void
    {
        while (true) {
            $frame = $this->decodeWebSocketFrame($this->read_buffer);
            if ($frame === null) {
                break;
            }

            $this->read_buffer = (string) substr($this->read_buffer, $frame['consumed']);
            $opcode = $frame['opcode'];
            $payload = $frame['payload'];

            if ($opcode === 0x8) {
                $this->close();
                $this->onDisconnect();
                return;
            }

            if ($opcode === 0x9) {
                parent::write($this->encodeWebSocketFrame($payload, 0xA), strlen($payload) + 16);
                continue;
            }

            if ($opcode !== 0x1 && $opcode !== 0x2 && $opcode !== 0x0) {
                continue;
            }

            $this->app_read_buffer .= $payload;
            $this->consumeAppCommands($this->app_read_buffer);
        }
    }

    private function decodeWebSocketFrame(string $buffer): ?array
    {
        $buffer_len = strlen($buffer);
        if ($buffer_len < 2) {
            return null;
        }

        $byte1 = ord($buffer[0]);
        $byte2 = ord($buffer[1]);
        $payload_len = $byte2 & 0x7F;
        $offset = 2;

        if ($payload_len === 126) {
            if ($buffer_len < 4) {
                return null;
            }
            $payload_len = unpack('n', substr($buffer, 2, 2))[1];
            $offset = 4;
        } elseif ($payload_len === 127) {
            if ($buffer_len < 10) {
                return null;
            }
            $parts = unpack('Nhigh/Nlow', substr($buffer, 2, 8));
            $payload_len = ($parts['high'] << 32) | $parts['low'];
            $offset = 10;
        }

        $masked = ($byte2 & 0x80) !== 0;
        $mask = '';
        if ($masked) {
            if ($buffer_len < $offset + 4) {
                return null;
            }
            $mask = substr($buffer, $offset, 4);
            $offset += 4;
        }

        if ($buffer_len < $offset + $payload_len) {
            return null;
        }

        $payload = substr($buffer, $offset, $payload_len);
        if ($masked) {
            $unmasked = '';
            for ($i = 0; $i < $payload_len; $i++) {
                $unmasked .= $payload[$i] ^ $mask[$i % 4];
            }
            $payload = $unmasked;
        }

        return [
            'consumed' => $offset + $payload_len,
            'opcode' => $byte1 & 0x0F,
            'payload' => $payload,
        ];
    }

    private function encodeWebSocketFrame(string $payload, int $opcode = 0x2): string
    {
        $payload_len = strlen($payload);
        $header = chr(0x80 | ($opcode & 0x0F));

        if ($payload_len < 126) {
            $header .= chr($payload_len);
        } elseif ($payload_len <= 0xFFFF) {
            $header .= chr(126) . pack('n', $payload_len);
        } else {
            $header .= chr(127) . pack('NN', 0, $payload_len);
        }

        return $header . $payload;
    }
}
