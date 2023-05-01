<?php
	require_once "../../lib/conexao.php";	
	
	$query = "DELETE FROM provas WHERE provas.id = $1";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);
	
	header("Location: index.php");
?>