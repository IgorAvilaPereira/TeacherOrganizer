<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/provas/tela_alterar.html");
	
	$query = "SELECT * FROM provas WHERE id = $1";	
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);
	
	$registro = pg_fetch_array($result);
	
	$template->exercicios = $registro['exercicios'];
	$template->nome = $registro['nome'];
	$template->id = $registro['id'];

	$template->show();
?>