<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/avaliacoes/tela_inserir.html");

	$template->id_disciplina = $_GET['id_disciplina'];
	
	$query = "select * from disciplinas where id  = $1";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$disciplina =  pg_fetch_array($result);
	$template->disciplina_nome  = $disciplina['nome'];	
	$total = ((strcmp($disciplina['eh_semestral'], 't')) ? 4 : 2);

	$query = "select * from avaliacoes where disciplina_id  = $1 order by id desc limit 1";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$b = 1;
	if (pg_affected_rows($result)>0) {
		$avaliacao =  pg_fetch_array($result);
		$b = $avaliacao['bimestre'];
	}	
	for ($bimestre = 0; $bimestre <= $total; $bimestre++){
		$template->bimestre = $bimestre;
		$template->bimestre_nome = (($bimestre > 0) ? $bimestre." Bimestre" : "Exame");
		$template->checked = (($b == $bimestre) ? "checked" : "");
		$template->block("bimestres");	
	}
	$template->show();
?>