<?php
require_once __DIR__ . '/vendor/autoload.php';

use AfricasTalking\SDK\AfricasTalking;

class SMSHelper {
    protected $AT;

    function __construct() {
        $this->AT = new AfricasTalking('sandbox', 'atsk_ccf98921c873af7dd65c414dd0ac6912a69b149500cf9c5e18a2247f7ffff1e8496dcc1c');
    }

    public function sendSMS($message, $recipients) {
        $sms = $this->AT->sms();
        try {
            $result = $sms->send([
                'to'      => $recipients,
                'message' => $message
            ]);
            error_log("Africa's Talking SDK SMS Response: " . json_encode($result));
            return $result;
        } catch (Exception $e) {
            error_log("Africa's Talking SDK Error: " . $e->getMessage());
            return false;
        }
    }
}

function sendRealSMS($to, $message) {
    $smsHelper = new SMSHelper();
    $smsHelper->sendSMS($message, $to);
}
?> 