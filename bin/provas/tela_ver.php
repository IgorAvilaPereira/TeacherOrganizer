<?php
	require_once "../../lib/conexao.php";	
	
	$query = "SELECT * FROM provas WHERE provas.id = ".$_GET['id'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	
	$registro = pg_fetch_array($result);
	echo $registro['exercicios'];
?>