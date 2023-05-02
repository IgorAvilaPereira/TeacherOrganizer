<?php
	require_once "../../lib/conexao.php";
	//require_once "../../lib/phpmailer/examples/test_smtp_gmail_basic.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;

	// dump();

	$template = new Template("../../view/cursos/index.html");


	$data = date("Y-m-d");
	$data = explode("-", $data);
	$ano  = $data[0];
	$mes = $data[1];
	$dia = $data[2];

	$semestre = 1;
	if ($mes > 7){
		$semestre = 2;
	}

	//$query = "SELECT * FROM disciplinas WHERE ano =".$ano." ORDER BY semestre desc; -- AND semestre = ".$semestre;
	$query = "SELECT cursos.nome as curso, disciplinas.curso_id, disciplinas.id, disciplinas.nome, disciplinas.semestre, disciplinas.ano, count(*) as total
	FROM disciplinas LEFT JOIN alunos
		ON (disciplinas.id = alunos.disciplina_id) 
		INNER JOIN cursos ON (disciplinas.curso_id =  cursos.id)
		WHERE ano = $1 /*and semestre = $semestre*/
	group by cursos.nome, disciplinas.id, disciplinas.nome, disciplinas.semestre, disciplinas.ano, disciplinas.curso_id
ORDER BY semestre desc, curso limit 6; -- AND semestre = 2";
	$result = pg_query_params($conexao, $query, array($ano)) or die ($query);
	while($registro = pg_fetch_array($result)) {
		$template->disciplina_id = $registro['id'];
		if (!strcmp($registro['curso'], "TADS") && $semestre == $registro['semestre']){
			$template->disciplina_nome = "<span style='background-color:orange; color: white;'>".strtoupper($registro['curso']. "/".$registro['nome'])."</span>";
		} else if (!strcmp($registro['curso'], "Integrado") && $semestre == $registro['semestre']) {
			$template->disciplina_nome = "<span style='background-color:green;; color: white;'>".strtoupper($registro['curso']. "/".$registro['nome'])."</span>";
		} else {
			$template->disciplina_nome = strtoupper($registro['curso']. "/".$registro['nome']);
		}

		$template->curso_id = $registro['curso_id'];
		$template->ano = $registro['ano'];
		$template->semestre = $registro['semestre'];

		$resultQtde = pg_query_params($conexao, "select count(*) as total from alunos where disciplina_id = $1", array($registro['id'])) or die ($query);
		$registroQtde = pg_fetch_array($resultQtde);		
		
		$template->total = $registroQtde['total'];
		$template->block("disciplinas");
	}

	// Disciplina de Orientacao
	$query = 
	"SELECT cursos.nome as curso, disciplinas.curso_id, disciplinas.id, upper(disciplinas.nome) as nome, disciplinas.semestre, disciplinas.ano, count(*) as total
	FROM disciplinas INNER JOIN alunos
		ON (disciplinas.id = alunos.disciplina_id) 
		INNER JOIN cursos ON (disciplinas.curso_id =  cursos.id)
		WHERE ano = 2017 /*and semestre = $semestre*/
	group by cursos.nome, disciplinas.id, disciplinas.nome, disciplinas.semestre, disciplinas.ano, disciplinas.curso_id
	having disciplinas.id = 69";
	$result = pg_query_params($conexao, $query, array()) or die ($query);


	while($registro = pg_fetch_array($result)) {
		$template->disciplina_id = $registro['id'];
		if (!strcmp($registro['curso'], "TADS")){
			$template->disciplina_nome = "<span style='background-color:blue; color: white;'>".strtoupper($registro['curso']. "/".$registro['nome'])."</span>";
		} else {
			$template->disciplina_nome = "<span style='background-color:green;; color: white;'>".strtoupper($registro['curso']. "/".$registro['nome'])."</span>";
		}
		$template->curso_id = $registro['curso_id'];
		$template->ano = $registro['ano'];
		$template->semestre = $registro['semestre'];
		$template->total = $registro['total'];
		$template->block("disciplinas");
	}


	$query = "select * from cursos order by nome";
	$result = pg_query_params($conexao, $query, array()) or die ($query);


	while($registro = pg_fetch_array($result)) {
			$template->id = $registro['id'];
			$template->nome = $registro['nome'];
			$template->block("cursos");
	}
	// gera o dump do dia
	//dump();
	// encaminha por email
	//email(); 
	$template->show();
?>
