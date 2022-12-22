<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	
	$template = new Template("../../view/provas/tela_criar.html");
	
	/*
	$sql = "SELECT * FROM provas WHERE provas.id = ".$_GET['id'];
	$result = pg_query($sql);	
	$registro = pg_fetch_array($result);
	
	$template->exercicios = $registro['exercicios'];
	$template->nome = $registro['nome'];
	$template->id = $registro['id'];
	*/
	$template->show();
?>