<?php
	require_once "../../lib/conexao.php";
	
	$data = (!isset($_POST['data']) || empty($_POST['data']) ? NULL : $_POST['data']);
	$hora = (!isset($_POST['hora']) || empty($_POST['hora']) ? NULL:  $_POST['hora']);
	
	if ($data != NULL) {
		$query = "update avaliacoes set 
		titulo = '".$_POST['titulo']."', 
		descricao = '".$_POST['descricao']."',
		bimestre = ".$_POST['bimestre'].", 
		valor = ".$_POST['valor'].",
		data_hora = '".$data." ".$hora."' 
		where id = ".$_POST['id'];
	} else {
		$query = "update avaliacoes set 
		titulo = '".$_POST['titulo']."', 
		descricao = '".$_POST['descricao']."',
		bimestre = ".$_POST['bimestre'].", 
		valor = ".$_POST['valor']."		
		where id = ".$_POST['id'];
	}
	// $result = pg_query($sql) or die($sql); 	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);
?>	