<?php

function amod_bench($lbl)
{
    static $arg_t = array('start');
    if($lbl !== true) {
        $lbl = sizeof($arg_t).'-'.$lbl;
        $arg_t[$lbl] = microtime(true);
    } else {
        $tttime=round((end($arg_t)-$arg_t['start'])*1000,4);
        $aff="total time : ".$tttime."ms\n";
        $prv_cle='0-start';
        $prv_val=$arg_t['0-start'];

        foreach ($arg_t as $cle=>$val) {
            if($cle!='start') {
                $prcnt_t=round(((round(($val-$prv_val)*1000,4)/$tttime)*100),1);
                $aff.=$prv_cle.' -> '.$cle.' : '.$prcnt_t." %\n";
                $prv_val=$val;
                $prv_cle=$cle;
            }
        }
        echo $aff;
    }
}
