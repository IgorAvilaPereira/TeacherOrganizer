<?php
	require_once "../../lib/conexao.php";

	// echo "<pre>";
	// 	print_r($_POST);
	// echo "</pre>";
	// die();
	
	// inserindo a nova disciplina
	$query = "insert into disciplinas (nome, ementa, ssh_wiki, avaliacao, metodologia, horario_aulas_sincronas, horario_atendimento, recuperacao_paralela, objetivos, programa, bibliografia, ano, codigo_ifrs, carga_horaria, serie_semestre_curso, semestre, creditos, creditos_por_dia, eh_semestral, email, curso_id) 
	values 
		(
			'".$_POST['nome']."', 
			'".trim(pg_escape_string($_POST['ementa']))."', 
			'".trim(pg_escape_string($_POST['ssh_wiki']))."', 
			'".trim(pg_escape_string($_POST['avaliacao']))."', 
			'".trim(pg_escape_string($_POST['metodologia']))."', 
			'".trim(pg_escape_string($_POST['horario_aulas_sincronas']))."', 
			'".trim(pg_escape_string($_POST['horario_atendimento']))."', 
			'".trim(pg_escape_string($_POST['recuperacao_paralela']))."', 
			'".trim(pg_escape_string($_POST['objetivos']))."', 
			'".trim(pg_escape_string($_POST['programa']))."',
			'".trim(pg_escape_string($_POST['bibliografia']))."',
			".$_POST['ano'].", 
			".( (!isset($_POST['codigo_ifrs']) || empty($_POST['codigo_ifrs']))  ? 'NULL' : $_POST['codigo_ifrs']).",
			".( (!isset($_POST['carga_horaria']) || empty($_POST['carga_horaria']))  ? 'NULL' : $_POST['carga_horaria']).",
			".( (!isset($_POST['serie_semestre_curso']) || empty($_POST['serie_semestre_curso']))  ? 'NULL' : $_POST['serie_semestre_curso']).",
			".$_POST['semestre'].", 
			".$_POST['creditos'].", 
			".( (!isset($_POST['creditos_por_dia']) || empty($_POST['creditos_por_dia']))  ? 'NULL' : $_POST['creditos_por_dia']).",
			".$_POST['eh_semestral'].", 
			'".$_POST['email']."' , 
			".$_POST['id_curso'].") RETURNING id;";	
	// $result = pg_query($query) or die($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$registro = pg_fetch_array($result);
		
	// inserindo os creditos
	$query  = "";
	foreach ($_POST['vetDiaSemana'] as $dia_semana => $nr_creditos){
		if ($nr_creditos > 0){
				$query.= "INSERT INTO creditos (disciplina_id, nr_creditos, dia_semana)
    				VALUES (".$registro['id'].", ".$nr_creditos.", ".$dia_semana.");";			
		}		
	}
	// $result = pg_query("begin;".$query."commit;") or die($query);
	$result = pg_query_params($conexao, "begin;".$query."commit;", array()) or die ("begin;".$query."commit;");
	// inserindo as provas - padrao		

	// exame
	$query = "INSERT INTO avaliacoes (
            titulo, valor, disciplina_id, bimestre)
    VALUES ('Exame', 10, ".$registro['id'].", 0);";	
	$total = (($_POST['eh_semestral'] == 'true') ? 2 : 4);	
		
	//for ($bimestre  = 1; $bimestre <= (($_POST['eh_semestral'] == "true" || $_POST['eh_semestral'] == 't'  || $_POST['eh_semestral'] == true) ? 2 : 4); $bimestre++){
	
	// provas presenciais de cada bimestre
	for ($bimestre  = 1; $bimestre <= $total; $bimestre++){
		$nome = "Atividade Presencial (".$bimestre." bim.)";
		$query.= "INSERT INTO avaliacoes (
            titulo, valor, disciplina_id, bimestre)
    	VALUES ('".$nome."', 10, ".$registro['id'].", ".$bimestre.");";		
	}	
	// ou funciona tudo - ou nao funciona nada
	// $result = pg_query("begin;".$query."commit;") or die($query);	
	$result = pg_query_params($conexao, "begin;".$query."commit;", array()) or die ("begin;".$query."commit;");

	

	header("Location: index.php?id=".$_POST['id_curso']);
?>	