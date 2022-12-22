<?php
	require_once "../../lib/conexao.php";
	// DELETAR TODAS AS DISCIPLINAS DO CURSO ANTES
	$query  = "delete from cursos where id = ".$_GET['id'];
	
	// $result =  pg_query($query) or die(pg_errormessage());
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	
	header("Location: index.php");
	
?>