<?php
	require_once "../../lib/conexao.php";
	
	$query  = "insert into cursos (nome) values ('".$_POST['nome']."');";
	
	// $result =  pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	
	header("Location: index.php");
	
?>