<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/planos/tela_importar_csv.html");

    $template->disciplina_id = $_GET['disciplina_id'];

    $template->show();


?>