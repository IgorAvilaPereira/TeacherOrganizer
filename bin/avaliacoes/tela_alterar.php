<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/avaliacoes/tela_alterar.html");
	
	$query = "select * from avaliacoes where id = ".$_GET['id_avaliacao'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$registro = pg_fetch_array($result);
		
	$template->id = $registro['id'];
	$template->titulo = $registro['titulo'];
	$template->descricao = $registro['descricao'];
	$template->valor = $registro['valor'];
	$data_hora = $registro['data_hora'];
	if (!empty($data_hora)) {
		$data_hora = explode(" ", $data_hora);
		if (count($data_hora) == 2){
			$template->data = $data_hora[0];
			$template->hora = $data_hora[1];
		} else {
			$template->data = "";
			$template->hora = "";
		}
	} else {
		$template->data = "";
		$template->hora = "";
	}
	$template->id_disciplina = $registro['disciplina_id'];
		
	$query = "select * from disciplinas where id  = ".$registro['disciplina_id'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$disciplina =  pg_fetch_array($result);		
	$template->disciplina_nome = $disciplina['nome'];
	//$total = (($disciplina['eh_semestral'] == 't' || $disciplina['eh_semestral'] == true) ? 4 : 2);
	$total = ((strcmp($disciplina['eh_semestral'], 't')) ? 4 : 2);
	
	for ($bimestre = 0; $bimestre <= $total; $bimestre++){
		$template->bimestre = $bimestre;
		$template->bimestre_nome = (($bimestre > 0) ? $bimestre.' Bimestre' : 'Exame');
		$template->checked = (($registro['bimestre'] == $bimestre) ? 'checked' : '');
		$template->block("bimestres");	
	}	
	$template->show();
?>