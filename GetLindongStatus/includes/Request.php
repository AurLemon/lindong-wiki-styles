<?php

use ApiBase;

class Request extends ApiBase {
    public function execute() {
        $params = $this->extractRequestParams();
        $address = $params['address'];
        $port = $params['port'];
    
        $apiUrl = "https://motd.imc.re/api?host=" . $address . ":" . $port;
    
        $ch = curl_init($apiUrl);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $response = curl_exec($ch);
    
        if ($response === false) {
            $result = [
                'status' => 'CURL Error: ' . curl_error($ch)
            ];
        } else {
            $responseData = json_decode($response, true);
    
            if ($responseData === null) {
                $result = [
                    'status' => 'JSON Decoding Error'
                ];
            } else {
                $result = [
                    'status' => $responseData['status'],
                    'online' => $responseData['online'],
                    'max' => $responseData['max'],
                    'version' => $responseData['version'],
                    'motd' => $responseData['motd'],
                    'delay' => $responseData['delay']
                ];
            }
        }
        
        curl_close($ch);
        $this->getResult()->addValue(null, $this->getModuleName(), $result);
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