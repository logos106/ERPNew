<?php

$path    = '.';
$exclude = array( ".","..","list.php" );

$files = scandir($path);
foreach ($files as $file) {
	if(!in_array($file,$exclude)){
		echo $file."\r\n";
	}
}	

?>