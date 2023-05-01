<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "DELETE FROM questoes_tags WHERE questao_id = $1";	
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);

	$sql = "DELETE FROM questoes WHERE questoes.id = $1";	
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);
	

	// header("Location: ./../../view/questoes/pagination.html");
	header("Location: index.php");
?>