<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "DELETE FROM questoes_tags WHERE tag_id = $1";	
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);

	$sql = "DELETE FROM tags WHERE id = $1";	
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);


	header("Location: index.php");
?>