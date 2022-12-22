<?php
	require_once "../../lib/conexao.php";
	
	$query = "delete from anotacoes where id = ".$_GET['id_anotacao'].";";
	$result = pg_query_params($conexao, $query, array()) or die ($query);	
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);
?>	