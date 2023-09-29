<?php

use ApiBase;
use Curl\Curl;

class Request extends ApiBase {
    public function execute() {
        $params = $this->extractRequestParams();
        $address = $params['address'];
        $port = $params['port'];

        $apiUrl = "https://motd.imc.re/api?host=" . $address . ":" . $port;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $apiUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $response = curl_exec($ch);
    
        if (curl_errno($ch)) {
            throw new Exception("Request failed: " . curl_error($ch) . ".");
        } else {
            $data = json_decode($response, true);
            $result = array(
                'status' => $data['status'],
                'online' => $data['online'],
                'max' => $data['max'],
                'version' => $data['version'],
                'motd' => $data['motd']
            );
        }
        curl_close($ch);
    
        return $result;
    }
    
    public function getAllowedParams() {
        return [
            'address' => [
                ApiBase::PARAM_TYPE => 'string',
                ApiBase::PARAM_REQUIRED => true,
            ],
            'port' => [
                ApiBase::PARAM_TYPE => 'string',
                ApiBase::PARAM_REQUIRED => true,
            ]
        ];
    }
}