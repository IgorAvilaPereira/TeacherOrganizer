<?php
	require_once "../../lib/conexao.php";
	
	$query  = "insert into cursos (nome) values ('".$_POST['nome']."');";
	
	$result =  pg_query($query);
	
	header("Location: index.php");
	
?>