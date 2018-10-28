<?php

// >= php 5.3.0
spl_autoload_register(function($class){
	
    $dir = dirname(__FILE__);
    $class = str_replace('\\', DIRECTORY_SEPARATOR, $class) . '.php';
    if (file_exists($class)) {
		
		require_once($dir.DIRECTORY_SEPARATOR.$class); 
    }
    
//  echo $class;
});