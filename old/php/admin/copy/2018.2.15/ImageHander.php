<?php
	function SaveImage($SaveImage,$paths = ''){
			//  $base_img是获取到前端传递的src里面的值，也就是我们的数据流文件
//			$base_img = str_replace('data:image/jpg;base64,', '', $base_img);
			//  设置文件路径和文件前缀名称
			$path = "../../img/";
			if($paths!=''){
				$path = $paths;
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
			
			$output_file = $prefix.time().rand(100,999).'.'.$houZ;
			$path = $path.$output_file;
			//创建将数据流文件写入我们创建的文件内容中
			$ifp = fopen( $path, "wb" );
			fwrite( $ifp, base64_decode( $baseimgArr[1]) );
			fclose( $ifp );
			return array('0'=>$path,'1'=>$output_file);
	}
	
	function HtmlSaveImage($htmlText){
		preg_match_all('/<img.+src=\"?(.+\.(jpg|gif|bmp|bnp|png))\"?.+>/i',$str,$match);
		var_dump($match);
	}
?>