<?php
	require_once "../../lib/conexao.php";
	
	$query = "delete from anotacoes where id = $1";
	$result = pg_query_params($conexao, $query, array($_GET['id_anotacao'])) or die ($query);	
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);
?>	