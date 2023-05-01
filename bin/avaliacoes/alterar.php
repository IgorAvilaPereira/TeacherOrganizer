<?php
	require_once "../../lib/conexao.php";
	
	$data = (!isset($_POST['data']) || empty($_POST['data']) ? NULL : $_POST['data']);
	$hora = (!isset($_POST['hora']) || empty($_POST['hora']) ? NULL:  $_POST['hora']);
	
	if ($data != NULL) {

		$query = "update avaliacoes set 
		titulo = $1, 
		descricao = $2,
		bimestre = $3, 
		valor = $4,
		data_hora = $5 
		where id = $6";
		$result = pg_query_params($conexao, $query, array($_POST['titulo'], $_POST['descricao'], $_POST['bimestre'], $_POST['valor'], $data." ".$hora, $_POST['id'])) or die ($query);
	} else {
		$query = "update avaliacoes set 
		titulo = $1, 
		descricao = $2,
		bimestre = $3, 
		valor = $4		
		where id = $5";
		$result = pg_query_params($conexao, $query, array($_POST['titulo'], $_POST['descricao'], $_POST['bimestre'], $_POST['valor'], $_POST['id'])) or die ($query);
	}
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);
?>	