<?php
	require_once "../../lib/conexao.php";
	$query = "delete from presencas where aluno_id = ".$_GET['id'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$query = "delete from notas where aluno_id = ".$_GET['id'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$query = "delete from alunos where id = ".$_GET['id'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	header("Location: ../../bin/alunos/index.php?disciplina_id=".$_GET['disciplina_id']);
?>