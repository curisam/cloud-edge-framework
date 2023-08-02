<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>


<?php
include "parsedown/Parsedown.php";
include "parsedown-extra/ParsedownExtra.php";

$Parsedown = new ParsedownExtra();
//$Parsedown->setSyntaxHighlight(true);
$Parsedown->setUrlsLinked(true);

$src_arg = "help_e2e_adapter_server.md";
if(isset($_GET['src'])) {
	if($_GET['src'] != '') {
		$src_arg = $_GET['src'];	
	}
}


if( $src_arg != null ) {
	//require($folder.'/markdown.php');
	
	$src = $src_arg;
    $text =	@file_get_contents($src);

	if( $text != false ){
		//echo $Parsedown->text('Hello _Parsedown_!');
		//echo $Parsedown->text( utf8_decode('2 안녕하세요 #hello ```python def ab: dfdf ``` '));
		//echo $Parsedown->text( utf8_decode('안녕하세요 '));

		$myfile = fopen($src, "r") or die("Unable to open file!");
		$text=fread($myfile,filesize($src)) ;
		fclose($myfile);
		echo $Parsedown->text($text);
	} else {

		$title 	=	'Could not find "'.$src.'"';
		$html	=	'<p>The file could not be found; please check that the file directory is correct</p>';
    }

} 
else 
if(isset($file_tmp) && $file_tmp != '') 
{
	require($folder.'/markdown.php');
	$title 	=	'<code>'.$file_name.'</code>';
	$text	= 	file_get_contents($file_tmp);
	$html	=	Markdown($text);
}
else {

	$title	=	'No src Defined';
	$html	= 	'<h1>'.$title.'</h1>'.
				'<p>Please make sure you have the query <code>src=FOLDER/FILE</code> in the URL</p>';
}




?>


</body>

</html>