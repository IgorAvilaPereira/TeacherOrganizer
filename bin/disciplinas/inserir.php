<?php
	require_once "../../lib/conexao.php";

	// echo "<pre>";
	// 	print_r($_POST);
	// echo "</pre>";
	// die();
	
	// inserindo a nova disciplina
	$query = "insert into disciplinas (nome, ementa, avaliacao, metodologia, horario_aulas_sincronas, horario_atendimento, recuperacao_paralela, objetivos, programa, bibliografia, ano, codigo_ifrs, carga_horaria, serie_semestre_curso, semestre, creditos, creditos_por_dia, eh_semestral, email, curso_id) 
	values 
		(
			$1,
			$2,
			$3,
			$4,
			$5,
			$6,
			$7,
			$8,
			$9,
			$10,
			$11,
			$12,
			$13,
			$14,
			$15, 
			$16, 
			$17, 
			$18, 
			$19, 
			$20) RETURNING id;";	
	// $result = pg_query($query) or die($query);	
	$result = pg_query_params($conexao, $query, array(
		$_POST['nome'], 
		trim(($_POST['ementa'])), 
		trim(($_POST['avaliacao'])), 
		trim(($_POST['metodologia'])), 
		trim(($_POST['horario_aulas_sincronas'])), 
		trim(($_POST['horario_atendimento'])), 
		trim(($_POST['recuperacao_paralela'])), 
		trim(($_POST['objetivos'])), 
		trim(($_POST['programa'])),
		trim(($_POST['bibliografia'])),
		$_POST['ano'], 
		( (!isset($_POST['codigo_ifrs']) || empty($_POST['codigo_ifrs']))  ? NULL : $_POST['codigo_ifrs']),
		( (!isset($_POST['carga_horaria']) || empty($_POST['carga_horaria']))  ? NULL : $_POST['carga_horaria']),
		( (!isset($_POST['serie_semestre_curso']) || empty($_POST['serie_semestre_curso']))  ? NULL : $_POST['serie_semestre_curso']),
		$_POST['semestre'], 
		$_POST['creditos'], 
		( (!isset($_POST['creditos_por_dia']) || empty($_POST['creditos_por_dia']))  ? NULL : $_POST['creditos_por_dia']),
		$_POST['eh_semestral'], 
		$_POST['email'], 
		$_POST['id_curso'])) or die ($query);
	$registro = pg_fetch_array($result);
		
	// inserindo os creditos
	$query  = "";
	foreach ($_POST['vetDiaSemana'] as $dia_semana => $nr_creditos){
		if ($nr_creditos > 0){
				$query = "INSERT INTO creditos (disciplina_id, nr_creditos, dia_semana)
    				VALUES ($1, $2, $3);";			
						$result = pg_query_params($conexao, $query, array($registro['id'], $nr_creditos,$dia_semana)) or die ($query);

		}		
	}
	// $result = pg_query("begin;".$query."commit;") or die($query);
	// $result = pg_query_params($conexao, "begin;".$query."commit;", array()) or die ("begin;".$query."commit;");
	// inserindo as provas - padrao		

	// exame
	$query = "INSERT INTO avaliacoes (
            titulo, valor, disciplina_id, bimestre)
    VALUES ('Exame', 10, ".$registro['id'].", 0);";		
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$total = (($_POST['eh_semestral'] == 'true') ? 2 : 4);	
		
	//for ($bimestre  = 1; $bimestre <= (($_POST['eh_semestral'] == "true" || $_POST['eh_semestral'] == 't'  || $_POST['eh_semestral'] == true) ? 2 : 4); $bimestre++){
	
	// provas presenciais de cada bimestre
	for ($bimestre  = 1; $bimestre <= $total; $bimestre++){
		$nome = "Atividade Presencial (".$bimestre." bim.)";
		$query = "INSERT INTO avaliacoes (
            titulo, valor, disciplina_id, bimestre)
    	VALUES ('".$nome."', 10, ".$registro['id'].", ".$bimestre.");";		
			$result = pg_query_params($conexao, $query, array()) or die ($query);

	}	
	// ou funciona tudo - ou nao funciona nada
	// $result = pg_query("begin;".$query."commit;") or die($query);	
	// $result = pg_query_params($conexao, "begin;".$query."commit;", array()) or die ("begin;".$query."commit;");

	

	header("Location: index.php?id=".$_POST['id_curso']);
?>	