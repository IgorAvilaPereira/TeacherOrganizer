<?php
	require_once "../../lib/conexao.php";
	
	$sql = "delete from notas where avaliacao_id = ".$_GET['id_avaliacao'].";";	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);
	$sql = "delete from avaliacoes where id = ".$_GET['id_avaliacao'].";";
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);
	
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);
?>	