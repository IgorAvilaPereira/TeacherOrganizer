<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/anotacoes/tela_inserir.html");

	$template->id_disciplina = $_GET['id_disciplina'];
	/*
	$query = "select * from disciplinas where id  = ".$_GET['id_disciplina'];
	$result = pg_query($query);
	$disciplina =  pg_fetch_array($result);
	$template->disciplina_nome  = utf8_decode($disciplina['nome']);
	//die($disciplina['eh_semestral']);
	//$total = (($disciplina['eh_semestral'] == 't' || $disciplina['eh_semestral'] == true) ? 2 : 4);
	$total = ((strcmp($disciplina['eh_semestral'], 't')) ? 4 : 2);
	
	for ($bimestre = 0; $bimestre <= $total; $bimestre++){
		$template->bimestre = $bimestre;
		$template->bimestre_nome = (($bimestre > 0) ? $bimestre." Bimestre" : "Exame");
		$template->block("bimestres");	
	}*/
	$template->show();
?>