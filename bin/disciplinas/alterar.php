<?php
	require_once "../../lib/conexao.php";

	$query = "update disciplinas set 
	nome = $1,
	email = $2,
	ementa = $3, 
	avaliacao = $4, 
	metodologia = $5, 
	horario_atendimento = $6, 
	recuperacao_paralela = $7, 
	horario_aulas_sincronas = $8, 
	objetivos = $9, 
	programa = $10, 
	bibliografia = $11, 
	ano = $12, 
	carga_horaria = $13,
	codigo_ifrs = $14,
	serie_semestre_curso = $15,
	semestre = $16,
	creditos_por_dia = $17,
	eh_semestral = $18,
	creditos = $19 
	where id = $20";		

	// $result = pg_query($query) or die("ERRO:".$query);
	$result = pg_query_params($conexao, $query, array(
		trim($_POST['nome']),
		trim($_POST['email']),
		trim($_POST['ementa']), trim($_POST['avaliacao']), 
		trim($_POST['metodologia']), 
		trim($_POST['horario_atendimento']), 
		trim($_POST['recuperacao_paralela']), 
		trim($_POST['horario_aulas_sincronas']), 
		trim($_POST['objetivos']), 
		trim($_POST['programa']), 
		trim($_POST['bibliografia']), 
		$_POST['ano'], 
		((empty($_POST['carga_horaria'])) ? NULL : $_POST['carga_horaria']),
		((empty($_POST['codigo_ifrs'])) ? NULL : $_POST['codigo_ifrs']),
		$_POST['serie_semestre_curso'],
		$_POST['semestre'],
		$_POST['creditos'],
		$_POST['eh_semestral'],
		$_POST['creditos'],
		$_POST['id']
	)) or die ($query);


	// ajustando a nova distribuicao de creditos por semana
	if (isset($_POST['vetDiaSemana'])){
		$query = "DELETE FROM creditos WHERE disciplina_id = $1";
		$result = pg_query_params($conexao, $query, array($_POST['id'])) or die ($query);

		foreach ($_POST['vetDiaSemana'] as $dia_semana => $nr_creditos){
			if ($nr_creditos > 0){
				$query = "INSERT INTO creditos (disciplina_id, nr_creditos, dia_semana) 
					VALUES ($1, $2, $3);";	
						$result = pg_query_params($conexao, $query, array($_POST['id'], $nr_creditos, $dia_semana)) or die ($query);
		
			}		
		}
	}

	// cade as presencas e os planos??? FALTA FAZER devido as mudancas de credito

	// $query = "SELECT * FROM planos where disciplina_id = ".$_POST['id'];
	// $query = "UPDATE presencas 
	// 		 SET creditos = ? 
   	// 				disciplina_id=? ";

	// $result = pg_query($query) or die($query);

	header("Location: index.php?id=".$_POST['id_curso']);
?>	
