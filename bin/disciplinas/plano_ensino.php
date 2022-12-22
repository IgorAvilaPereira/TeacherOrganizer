<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	//require_once "../../lib/html2pdf/html2pdf.class.php";
	//ob_start();
	
	$template = new Template("../../view/disciplinas/plano_ensino.html");

	// Disciplina - creditos
	$query = "select * from disciplinas where id = $1";	
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$registro = pg_fetch_array($result);	
	$template->id_curso = $registro['curso_id'];
	$template->curso = (($registro['curso_id'] == 1) ? "(X) Integrado () Subsequente () PROEJA () Superior":  "() Integrado () Subsequente () PROEJA (X) Superior");	
	$template->turma = (($registro['curso_id'] == 1) ? "Nível Técnico":  "Nível Graduação");
	$template->id_disciplina = $registro['id'];
	$template->nome_disciplina = $registro['nome']  ;
	$template->ementa = trim($registro['ementa']);
	$template->horario_atendimento = trim($registro['horario_atendimento']);
	$template->recuperacao_paralela = trim($registro['recuperacao_paralela']);
	$template->horario_aulas_sincronas = trim($registro['horario_aulas_sincronas']);	
	$template->metodologia = trim($registro['metodologia']);	
	$template->avaliacao = trim($registro['avaliacao']);	
	$template->objetivos = trim($registro['objetivos']);
	$template->programa = trim($registro['programa']);	
	$template->bibliografia = trim($registro['bibliografia']);
	$template->ano = $registro['ano'];
	$template->codigo_ifrs = $registro['codigo_ifrs'];
	$template->carga_horaria = 	((is_numeric($registro['carga_horaria'])) ? $registro['carga_horaria']."h" : "");
	$template->semestre = $registro['semestre'];
	//$template->serie_semestre_curso = (($registro['serie_semestre_curso'] == 0) ? "OPTATIVA" : $registro['serie_semestre_curso']);
	if (is_null($registro['serie_semestre_curso'])){
			$template->serie_semestre_curso = "";
		} else {
			$template->serie_semestre_curso = (($registro['serie_semestre_curso'] == 0) ? "OPTATIVA" :  $registro['serie_semestre_curso']);
		}
	/*
	if (!empty($registro['creditos_por_dia'])){
		$template->creditos = $registro['creditos'];		
		$template->creditos_por_dia = $registro['creditos_por_dia'];	
		$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	} else {		
		$queryCreditosPorDia = "select * from creditos where disciplina_id=".$_GET['id_disciplina'];	
		$resultCreditosPorDia = pg_query($queryCreditosPorDia);
		$str = "<br>";
		$totalCreditos = 0;
		while ($registroCreditosPorDia = pg_fetch_array($resultCreditosPorDia)){
			$str.= $dia[$registroCreditosPorDia['dia_semana']].":".$registroCreditosPorDia['nr_creditos']."<br>";
			$totalCreditos+=$registroCreditosPorDia['nr_creditos'];
		}
		$template->creditos = $totalCreditos;	
		$template->creditos_por_dia = $str;
	}
	$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	//$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	//$total = (($registro['eh_semestral'] == 't') ? 2 : 4);*/
	$template->show();
?>