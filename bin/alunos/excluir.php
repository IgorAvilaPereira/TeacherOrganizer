<?php
	require_once "../../lib/conexao.php";
	$query = "delete from presencas where aluno_id = $1";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);
	$query = "delete from notas where aluno_id = $1";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);
	$query = "delete from alunos where id = $1";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);
	header("Location: ../../bin/alunos/index.php?disciplina_id=".$_GET['disciplina_id']);
?>