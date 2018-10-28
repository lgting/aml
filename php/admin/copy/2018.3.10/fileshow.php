<?php

getfiles("./img","[.png,.jpg,.jpeg,.gif]");
/*
 * $path目录
   $allowFiles 目录筛选
 * */
function getfiles($path, $allowFiles, &$files = array())
{
    if (!is_dir($path)) return null;
    if(substr($path, strlen($path) - 1) != '/') $path .= '/';
    $handle = opendir($path);
    while (false !== ($file = readdir($handle))) {
        if ($file != '.' && $file != '..') {
            $path2 = $path . $file;
            if (is_dir($path2)) {
            	echo 'path2='.$path2;
                getfiles($path2, $allowFiles, $files);
            } else {
                //if (preg_match("/\.(".$allowFiles.")$/i", $file)) {
                    /*$files[] = array(
                        'url'=> substr($path2, strlen($_SERVER['DOCUMENT_ROOT'])),
                        'mtime'=> filemtime($path2)
                    );*/
                //}
                
                $files[] = array(
                    'url'=> $path2,
                    'mtime'=> filemtime($path2)
                );
            }
        }
    }
	var_dump($files);
    return $files;
}
?>