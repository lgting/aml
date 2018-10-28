<?php

	//$SaveImage base64图片信息
	//$topUrl 图片前缀
	//$paths 图片存储路径
	//$urlName 指定图片名称
	function SaveImage($SaveImage,$topUrl,$paths = '',$urlName=''){
			//  $base_img是获取到前端传递的src里面的值，也就是我们的数据流文件
//			$base_img = str_replace('data:image/jpg;base64,', '', $base_img);
			//  设置文件路径和文件前缀名称			
			$path = "../img/";
			if($paths!=''){
				$timestr = date('Ymd', time());
				if($urlName==''){
					$path = $paths.$timestr.'/';
					$topUrl = $topUrl.$timestr.'/';
				}
				else{
					$path = $paths;
				}
				
			}
			
			$path = iconv("UTF-8", "GBK", $path);
	        if (!file_exists($path)){
	            mkdir ($path,0777,true);
	        }
			
			$prefix='nx_';
			$baseimgArr = explode(',',$SaveImage);
			$houzArr = explode(';',$baseimgArr[0]);
			$houzArr = explode('/',$houzArr[0]);
//			echo 'arr='.$baseimgArr[0].'<br>';
//			return;
			$houZ = $houzArr[1];
			if($houZ == 'jpeg'){
				$houZ = 'jpg';
			}
			
			
			if($urlName==''){
				$output_file = $prefix.time().rand(100,999).'.'.$houZ;
			}
			else{
				$output_file = $urlName.'.'.$houZ;
			}
			
			$path = $path.$output_file;
			//创建将数据流文件写入我们创建的文件内容中
			$ifp = fopen( $path, "wb" );
			fwrite( $ifp, base64_decode( $baseimgArr[1]) );
			fclose( $ifp );
			
			$backtopUrl = $topUrl.$output_file;
			return array('0'=>$path,'1'=>$output_file,'2'=>$backtopUrl);
	}
	
	function HtmlSaveImage($htmlText){
		preg_match_all('/<img.+src=\"?(.+\.(jpg|gif|bmp|bnp|png))\"?.+>/i',$str,$match);
		var_dump($match);
	}
?>