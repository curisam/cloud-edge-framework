<?php

if(isset($_SERVER['HTTP_ORIGIN'])) {
	header("Access-Control-Allow-Origin: ".$_SERVER['HTTP_ORIGIN']);
	header('Access-Control-Allow-Credentials: true');
	header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');
}

class KetiEncrypt {
	protected $ikey;
	function __construct($key) {
		$this->ikey = $key;
	}
    
    /*
	function encrypt_easy() {
        $key = $this->ikey;
        $key = hash("sha256", $key);
		return $key;
	}
	function validation_easy($key) {
		return ($this->encrypt_easy()==$_SERVER["HTTP_KETI_TOKEN"]?true:false);
	}
    */
	
	function encrypt() {
        $m = round(date("i"));
        $key = $this->ikey;
        for($i=0;$i<$m;$i++) {
            $key = hash("sha256", $key);
        }
        $subkey = hash("sha256", $key);

        $rtn["key"] = $key;
        $rtn["skey"] = $skey;
		return $rtn;
	}
	
	function validation() {
        $chk = $this->encrypt();
		return ($chk["key"]==$_SERVER["HTTP_KETI_TOKEN"] || $chk["skey"]==$_SERVER["HTTP_KETI_TOKEN"]?true:false);
	}
}

$key="test111";

$ke = new KetiEncrypt($key);

$rtn = array();
$rtn["err"] = $ke->validation();

echo json_encode($rtn);

?>

