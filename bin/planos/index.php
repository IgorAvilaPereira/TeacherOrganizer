<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/planos/index.html");
	
	$cor =  array('AliceBlue', 'LightGray', 'PaleGreen', 'yellow', 'pink');
	
	$sql = "select *, cursos.nome as curso, disciplinas.nome as disciplina from disciplinas inner join cursos on (disciplinas.curso_id = cursos.id) where disciplinas.id = $1";
	$result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);

	$registro = pg_fetch_array($result);	
	
	$template->curso = $registro['curso'];
	$template->disciplina = $registro['disciplina'];
	$template->id_disciplina = $_GET['id_disciplina'];
	$template->semestre = $registro['semestre'];
	$template->ano = $registro['ano'];
	
	$sql = "select *, planos.id as id from planos inner join disciplinas on (disciplinas.id = planos.disciplina_id) where disciplina_id = $1 ORDER BY data desc";
	$result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);
	
	while ($registro = pg_fetch_array($result)){
		$template->texto = nl2br($registro['texto']);
		$data = explode("-", $registro['data']);
		$template->data = $data[2]."/".$data[1]."/".$data[0];
		$template->bimestre = $registro['bimestre'];
		$sqlCreditos = "SELECT creditos FROM presencas WHERE data = $1 and disciplina_id = $2 limit 1;";
		// $resultadoCreditos = pg_query($sqlCreditos);
		$resultadoCreditos = pg_query_params($conexao, $sqlCreditos, array($registro['data'], $_GET['id_disciplina'])) or die ($sql);
		$registroCreditos = pg_fetch_array($resultadoCreditos);
		$template->creditos = $registroCreditos['creditos'];
		$template->id = $registro['id'];
		$template->block("planos");
	}	
	$template->show();
?>