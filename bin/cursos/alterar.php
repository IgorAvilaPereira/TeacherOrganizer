<?php
	require_once "../../lib/conexao.php";
	
	$query  = "update cursos set nome = $1 where id = $2";	
	$result = pg_query_params($conexao, $query, array($_POST['nome'], $_POST['id'])) or die ($query);	
	header("Location: index.php");
	
?>