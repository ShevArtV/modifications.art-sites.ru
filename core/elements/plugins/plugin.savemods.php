<?php

switch($modx->event->name){
    case 'OnDocFormSave':
        if($resource->get('class_key') === 'msProduct'){
            $linkId = 1;
            if($resource->get('template') === 2){
                $master = $id;
            }else{
                if(!$link = $modx->getObject('msProductLink', ['slave' => $id, 'link' => $linkId])){
                    return true;
                }
                $master = $link->get('master');
                $resource = $modx->getObject('modResource', $master);
            }
            $output = [];
            $optionsKeys = "('colors', 'age', 'max-weight')";
            $q = $modx->newQuery('msProductLink');
            $q->select('slave');
            $q->where(['master' => $master, 'link' => $linkId]);
            $q->groupby('slave');
            $q->prepare();
            $sql = $q->toSQL();
            if($statement = $modx->query($sql)){
                $modifications = $statement->fetchAll(PDO::FETCH_COLUMN);
                foreach($modifications as $modification){
                    $sql = "SELECT `key`, `value` FROM `modx_ms2_product_options` WHERE `product_id` = $modification AND `key` IN $optionsKeys";
                    if($statement = $modx->query($sql)){
                        $options = $statement->fetchAll(PDO::FETCH_ASSOC);
                        foreach($options as $item){
                            $output[$item['key']][$item['value']][] = $modification;
                        }
                    }
                }
            }
            if(!empty($output)){
                $resource->setTVValue('modifications', json_encode($output, JSON_UNESCAPED_UNICODE));
            }
        }
        break;
}