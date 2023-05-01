<?php
    require "conexao.php";
    $path_back = DIR."zip/";
    shell_exec("zip -r  ".$path_back."docente". date("dmY_Hi").".zip ".DIR);
    
    // removendo dumps velhos (Mantem somente os ultimos)
    $vetArquivo = explode("\n",shell_exec("cd ".$path_back." && ls -alt | grep \"docente*\" | awk '{print $(NF)}'") ?? '');
    $x = 15;
    if (count($vetArquivo) > $x){
        for ($i=$x; $i < count($vetArquivo); $i++) { 
            if (strlen($vetArquivo[$i]) > 0){                
                unlink($path_back.trim($vetArquivo[$i]));
            }
        }
    }
    echo "ok";
    // echo "<a href='./../zip/". $banco . date("dmY") . ".sql"."'> ".$banco . date("dmY") . ".sql </a>";
?>