<?php
	require_once "../../lib/conexao.php";
	
	$query  = "insert into cursos (nome) values ($1);";
	
	// $result =  pg_query($query);
	$result = pg_query_params($conexao, $query, array($_POST['nome'])) or die ($query);

	
	header("Location: index.php");
	
?>