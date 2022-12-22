<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/provas/tela_alterar.html");
	
	$query = "SELECT * FROM provas WHERE provas.id = ".$_GET['id'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	
	$registro = pg_fetch_array($result);
	
	$template->exercicios = $registro['exercicios'];
	$template->nome = $registro['nome'];
	$template->id = $registro['id'];

	$template->show();
?>