<?php
	require_once "../../lib/conexao.php";	
	
	$query = "SELECT * FROM provas WHERE provas.id = $1";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);
	
	$registro = pg_fetch_array($result);
	echo $registro['exercicios'];
?>