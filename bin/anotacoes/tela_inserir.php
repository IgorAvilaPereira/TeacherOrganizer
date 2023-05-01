<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/anotacoes/tela_inserir.html");

	$template->id_disciplina = $_GET['id_disciplina'];
	$template->show();
?>