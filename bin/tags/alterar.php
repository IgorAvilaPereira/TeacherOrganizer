<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "UPDATE tags SET tag = '".$_POST['tag']."' WHERE id = ".$_POST['id'];
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	header("Location: index.php");
?>