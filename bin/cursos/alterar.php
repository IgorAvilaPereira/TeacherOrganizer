<?php
	require_once "../../lib/conexao.php";
	
	$query  = "update cursos set nome = '".$_POST['nome']."' where id = ".$_POST['id'];
	
	// $result =  pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	
	header("Location: index.php");
	
?>