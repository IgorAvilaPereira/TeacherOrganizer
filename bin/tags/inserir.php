<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "INSERT INTO tags (tag) values ('".$_POST['tag']."');";	
	// $result = pg_query($sql) or die ($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);


	header("Location: index.php");
?>