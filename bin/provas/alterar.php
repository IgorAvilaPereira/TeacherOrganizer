<?php
	require_once "../../lib/conexao.php";	
	
	$query = "UPDATE provas SET exercicios = $1, data_hora = now(), nome = $2 WHERE id = $3";
	$result = pg_query_params($conexao, $query, array($_POST['prova'], $_POST['nome'], $_POST['id'])) or die ($query);	
	header("Location: index.php");
?>