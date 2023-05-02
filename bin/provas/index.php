<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/provas/index.html");
	
	$query = "select * FROM provas;";
	$result = pg_query_params($conexao, $query, array()) or die ($query);	

	while ($registro = pg_fetch_array($result)){
		$template->nome = substr(strip_tags($registro['nome']), 0, 100)."...";
		$template->data_hora = $registro['data_hora'];
		$template->id = $registro['id'];
		$template->block("provas");
	}	
	$template->show();
?>