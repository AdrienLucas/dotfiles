<?php

$amodBt = function($limit = null) {
	$bt = debug_backtrace();
	if(!is_null($limit)) {
		$bt = array_slice($bt, 0, $limit);
	}
    foreach($bt as $trace) {
        echo $trace['class'].'::'.$trace['function'].'@'.$trace['file'].':'.$trace['line']."\n";
    }
}
