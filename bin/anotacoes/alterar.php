<?php
	require_once "../../lib/conexao.php";
	
	$query = "update anotacoes set anotacao = $1 where id = $2";
	$result = pg_query_params($conexao, $query, array($_POST['anotacao'], $_POST['id'])) or die ($query);

	header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);
?>	