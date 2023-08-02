<?php

//require_once __DIR__ . "/vendor/autoload.php"; //comment this line if you don't have Composer, and uncomment the 4 lines below
require_once __DIR__ . "/src/ApiStruct.php";
require_once __DIR__ . "/src/Api.php";
require_once __DIR__ . "/src/EasyVars.php";
require_once __DIR__ . "/src/Client.php";
use TuriBot\Client;

$TOKEN ='689122441:AAFLOkYjy5PM3J1OBiq5JS5xCtFri0e9MPw';
$client = new Client($TOKEN);
$offset = 0;

while (true) {
    $updates = $client->getUpdates($offset, $timeout = 0);
    if ($updates->ok == true) {
        foreach ($updates->result as $update) {
            $offset = $update->update_id + 1;
            $easy = new \TuriBot\EasyVars($update);

            if (isset($update->message)) {
                $chat_id = $update->message->chat->id;
                if ($easy->text == "ping") {
                    $client->sendMessage($chat_id, "pong");
                } else {
                    $client->sendMessage($chat_id, $easy->message_id);
                }
                //$client->sendPhoto($chat_id, $client->inputFile("photo.png"));
            }

        }
    } else {
        exit($updates->description);
    }
}
