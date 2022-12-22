<?php
	require_once "../../lib/conexao.php";
	
	$query = "update anotacoes set anotacao = '".pg_escape_string($_POST['anotacao'])."' where id = ".$_POST['id'];
	// $result = pg_query($sql) or die($sql); 	
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);
?>	