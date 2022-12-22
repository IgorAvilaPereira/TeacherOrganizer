<?php
    // neste arquivo importado, tem alem da conexao com o bd, ha a funcao geradora de dumps
    require "conexao.php";
    dump();
    echo "<h1> Dump gerado! </h1>";            
    echo "<a href='./../dumps/". $banco . date("dmY") . ".sql"."'> ".$banco . date("dmY") . ".sql </a>";
    // echo "<a href='javascript:void(0)' onclick='history.go(-1)'> Voltar </a>";
?>