<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/disciplinas/index.html");

	$query = "select * from cursos where id = ".(!isset($_GET['id']) ? 2 : $_GET['id']);
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$curso  =  pg_fetch_array($result);
	$template->curso = $curso['nome'];
	$template->id_curso = (!isset($_GET['id']) ? 1: $_GET['id']);
	
	// escurecer disciplinas antigas
	/*
	$query = "SELECT MAX(ano) as ano, MAX(semestre) as semestre FROM disciplinas WHERE disciplinas.curso_id = ".$_GET['id'];
	$result = pg_query($query);
	if (pg_affected_rows($result) > 0) {
		$data  =  pg_fetch_array($result);	
		$ano = $data['ano'];
		$semestre =  $data['semestre'];	
	} else {*/
		$data = date("Y-m-d");
		$data = explode("-", $data);
		$ano = (int) $data[0];
		//print_r($data[1]);
		//print_r("<hr>");
		$semestre =  (((int)$data[1] <= 6) ? 1 : 2);
	//}
		
	$query = "select * from disciplinas where curso_id=".(!isset($_GET['id']) ? 2: $_GET['id'])." order by ano desc, semestre desc, nome";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	if (pg_affected_rows($result) > 0 ){	
		while($registro = pg_fetch_array($result)) {
			$template->id_disciplina = $registro['id'];
			//  se eh orientacao!!
			$template->nome = (($registro['id'] ==  69) ? "<span style='background-color:blue; color: white;'>".$registro['nome']."</span>" : $registro['nome']);
			$template->ano = $registro['ano'];
			//  se eh orientacao!!
			$template->cor = (($registro['ano'] == $ano && $registro['semestre'] == $semestre || $registro['id'] == 69) ? "black" : "#C0C0C0");
			$template->semestre = $registro['semestre'];			
			$template->block("disciplinas");
		}
	} else {
		$template->mensagem = "Nenhuma Disciplina cadastrada";
	}	
	$template->show();
?>