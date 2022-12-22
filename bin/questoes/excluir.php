<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "DELETE FROM questoes_tags WHERE questao_id = ".$_GET['id'].";";	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	$sql = "DELETE FROM questoes WHERE questoes.id = ".$_GET['id'].";";	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);
	

	// header("Location: ./../../view/questoes/pagination.html");
	header("Location: index.php");
?>