<?php
	require_once "../../lib/conexao.php";
	//var_dump($_POST);
	//die();
	$data =(!isset($_POST['data']) || empty($_POST['data']) ? date('Y-m-d') : $_POST['data']);
	//$data = explode("/", $data);
	//$data = $data[2]."-".$data[1]."-".$data[0];
	$hora = (!isset($_POST['hora']) || empty($_POST['hora']) ? "00:00:00":  $_POST['hora'].":00");
	//var_dump($data);
	//var_dump($hora);
	//die();
	$query = "insert into avaliacoes 
			(
				disciplina_id, 
				titulo, 
				descricao,
				bimestre,
				valor,
				data_hora
			) 
			values 
			(
				$1,
				$2,
				$3,
				$4,
				$5,
				$6);";

	$result = pg_query_params($conexao, $query, array(
		$_POST['id_disciplina'], 
		$_POST['titulo'], 
		$_POST['descricao'],
		$_POST['bimestre'],				
		(($_POST['valor'] > 0) ? $_POST['valor'] : 10),
		$data." ".$hora
	)) or die ($query);
	
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);	
?>