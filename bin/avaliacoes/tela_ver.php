<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/avaliacoes/tela_ver.html");
	
	$query = "select * from avaliacoes inner join disciplinas on (disciplinas.id = avaliacoes.disciplina_id) where avaliacoes.id = ".$_GET['id_avaliacao'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$registro = pg_fetch_array($result);
	
	$template->id = $registro['id'];
	$template->titulo = $registro['titulo'];
	$template->descricao = $registro['descricao'];
	$template->valor = $registro['valor'];

	if (!empty($registro['data_hora'])){
		if (strlen($registro['data_hora'])>0){
			$template->data_hora = explode("-", explode(" ",$registro['data_hora'])[0])[2]."/".explode("-", explode(" ",$registro['data_hora'])[0])[1]."/".explode("-", explode(" ",$registro['data_hora'])[0])[0]." ".explode(" ",$registro['data_hora'])[1];
		} else {
			$template->data_hora = "";
		} 
	}

	
	$template->id_disciplina = $registro['disciplina_id'];
	$template->disciplina_nome = $registro['nome'];
	$template->bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre'] : "Exame");
	
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