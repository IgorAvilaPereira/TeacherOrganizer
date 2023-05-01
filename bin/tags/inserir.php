<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "INSERT INTO tags (tag) values ($1);";	
	// $result = pg_query($sql) or die ($sql);	
	$result = pg_query_params($conexao, $sql, array($_POST['tag'])) or die ($sql);


	header("Location: index.php");
?>