<?php

require_once "../../lib/conexao.php";
if ($_POST['template'] == 'beamer') {
    include_once "gerar_beamer.php";
} else {
    include_once "gerar_beamer_modificado.php";
}
?>
