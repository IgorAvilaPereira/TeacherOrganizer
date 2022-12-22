<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/anotacoes/tela_ver.html");
	
	$query = "select * from anotacoes inner join disciplinas on (disciplinas.id = anotacoes.disciplina_id) where anotacoes.id = ".$_GET['id_anotacao'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$registro = pg_fetch_array($result);
	
	$template->id = $registro['id'];
	//$template->titulo = $registro['titulo'];
	$template->anotacao = nl2br($registro['anotacao']);
	/*$template->valor = $registro['valor'];
		$template->data_hora = $registro['data_hora'];*/
	$template->id_disciplina = $registro['disciplina_id'];
	/*$template->disciplina_nome = $registro['nome'];
	$template->bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre'] : "Exame");*/
	
	/*
	$sql = "select * from alunos inner notas on (notas.aluno_id = alunos.id) where notas.disciplina_id = ".$registro['disciplina_id'];
	$result = pg_query($query);	
	while ($registro = pg_fetch_array($result)){
		$template->id = $registro['id'];
		$template->nome = utf8_decode($registro['nome']);
		$template->matricula = $registro['matricula'];
		$template->obtido =
		$template->block("alunos");
	}*/	
	$template->show();
?>