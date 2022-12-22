<?php
	require_once "../../lib/conexao.php";

	// novo ano e semestre
	$ano = date("Y");
	$semestre = ((date("m") <= 6) ? 1 : 2);	

	// obtendo a disciplina que sera usada como base
	$query = "select * from disciplinas WHERE id = ".$_POST['id'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$disciplina_base = pg_fetch_array($result);
	$eh_semestral = (($disciplina_base['eh_semestral'] == 't') ? 1: 0);

	// inserindo a nova disciplina => nao coloquei o ssh_wiki pois eh unico (poderia fazer o mesmo para o email)
	$query = "insert into disciplinas (nome, ementa, avaliacao, metodologia, horario_aulas_sincronas, horario_atendimento, recuperacao_paralela, objetivos, programa, bibliografia, ano, codigo_ifrs, carga_horaria, serie_semestre_curso, semestre, creditos, creditos_por_dia, eh_semestral, email, curso_id) 
	values 
		(
			'".strtoupper($disciplina_base['nome']." - ".date("d/m/Y - H:i:s"))."', 
			'".trim(pg_escape_string($disciplina_base['ementa']))."', 			
			'".trim(pg_escape_string($disciplina_base['avaliacao']))."', 
			'".trim(pg_escape_string($disciplina_base['metodologia']))."', 
			'".trim(pg_escape_string($disciplina_base['horario_aulas_sincronas']))."', 			
			'".trim(pg_escape_string($disciplina_base['horario_atendimento']))."', 
			'".trim(pg_escape_string($disciplina_base['recuperacao_paralela']))."', 
			'".trim(pg_escape_string($disciplina_base['objetivos']))."', 
			'".trim(pg_escape_string($disciplina_base['programa']))."',
			'".trim(pg_escape_string($disciplina_base['bibliografia']))."',
			".$ano.", 
			".( (!isset($disciplina_base['codigo_ifrs']) || empty($disciplina_base['codigo_ifrs']))  ? 'NULL' : $disciplina_base['codigo_ifrs']).",
			".( (!isset($disciplina_base['carga_horaria']) || empty($disciplina_base['carga_horaria']))  ? 'NULL' : $disciplina_base['carga_horaria']).",
			".( (!isset($disciplina_base['serie_semestre_curso']) || empty($disciplina_base['serie_semestre_curso']))  ? 'NULL' : $disciplina_base['serie_semestre_curso']).",
			".$semestre.", 
			".$disciplina_base['creditos'].", 
			".( (!isset($disciplina_base['creditos_por_dia']) || empty($disciplina_base['creditos_por_dia']))  ? 'NULL' : $disciplina_base['creditos_por_dia']).",
			".(($eh_semestral == 1) ? 'TRUE':'FALSE').",
			'".$disciplina_base['email']."' , 
			".$disciplina_base['curso_id'].") RETURNING id;";	

	// $result = pg_query($query) or die($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	// disciplina recem adicionada
	$nova_disciplina = pg_fetch_array($result);		

	// inserindo os creditos
	$query  = "SELECT * FROM creditos WHERE disciplina_id = ".$disciplina_base['id'];
	// $result = pg_query($query) or die($query);		
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	if (pg_affected_rows($result)>0){		
		$query  = "";
		while ($registro = pg_fetch_array($result)){
				$query.= "INSERT INTO creditos (disciplina_id, nr_creditos, dia_semana)
    				VALUES (".$nova_disciplina['id'].", ".$registro['nr_creditos'].", ".$registro['dia_semana'].");";			
		}		
	}
	// $result = pg_query("begin;".$query."commit;") or die($query);
	$result = pg_query_params($conexao, "begin;".$query."commit;", array()) or die ("begin;".$query."commit;");


	// inserindo as provas
	$query  = "SELECT * FROM avaliacoes WHERE disciplina_id = ".$disciplina_base['id'];
	// $result = pg_query($query) or die($query);		
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	if (pg_affected_rows($result)>0){		
		$query  = "";
		while ($registro = pg_fetch_array($result)){
			$query.= "INSERT INTO avaliacoes (titulo, descricao, valor, disciplina_id, bimestre, da_substitutiva) VALUES 
			(	'".$registro['titulo']."', 
				'".pg_escape_string($registro['descricao'])."',
				".$registro['valor'].", 
				".$nova_disciplina['id'].", 
				".$registro['bimestre'].",
				".(($registro['da_substitutiva'] == 't') ? 'TRUE': 'FALSE').");";				
		}		
	}
	// $result = pg_query("begin;".$query."commit;") or die($query);
	$result = pg_query_params($conexao, "begin;".$query."commit;", array()) or die ("begin;".$query."commit;");



	// poderia ser os planos e, ateh mesmo, os alunos
	//  ....

	header("Location: ver.php?id_disciplina=".$nova_disciplina['id']);
?>	