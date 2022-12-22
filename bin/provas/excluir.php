<?php
	require_once "../../lib/conexao.php";	
	
	$query = "DELETE FROM provas WHERE provas.id = ".$_GET['id'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	
	header("Location: index.php");
?>