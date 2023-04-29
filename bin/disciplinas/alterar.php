<?php
	require_once "../../lib/conexao.php";

	$query = "update disciplinas set 
	nome = '".trim($_POST['nome'])."',
	email = '".trim($_POST['email'])."',
	ementa = '".trim($_POST['ementa'])."', 
	ssh_wiki = '".trim($_POST['ssh_wiki'])."', 
	avaliacao = '".trim($_POST['avaliacao'])."', 
	metodologia = '".trim($_POST['metodologia'])."', 
	horario_atendimento = '".trim($_POST['horario_atendimento'])."', 
	recuperacao_paralela = '".trim($_POST['recuperacao_paralela'])."', 
	horario_aulas_sincronas = '".trim($_POST['horario_aulas_sincronas'])."', 
	objetivos = '".trim($_POST['objetivos'])."', 
	programa = '".trim($_POST['programa'])."', 
	bibliografia = '".trim($_POST['bibliografia'])."', 
	ano = ".$_POST['ano'].", 
	carga_horaria = ".((empty($_POST['carga_horaria'])) ? 'NULL' : $_POST['carga_horaria']).",
	codigo_ifrs = ".((empty($_POST['codigo_ifrs'])) ? 'NULL' : $_POST['codigo_ifrs']).",
	serie_semestre_curso = ".$_POST['serie_semestre_curso'].",
	semestre =".$_POST['semestre'].",
	creditos_por_dia = ".$_POST['creditos'].",
	eh_semestral =".$_POST['eh_semestral'].",
	creditos = ".$_POST['creditos']."
	where id =".$_POST['id'];		
	// $result = pg_query($query) or die("ERRO:".$query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);


	// ajustando a nova distribuicao de creditos por semana
	if (isset($_POST['vetDiaSemana'])){
		$query = "DELETE FROM creditos WHERE disciplina_id = ".$_POST['id'].";";
		$result = pg_query_params($conexao, $query, array()) or die ($query);

		foreach ($_POST['vetDiaSemana'] as $dia_semana => $nr_creditos){
			if ($nr_creditos > 0){
				$query = "INSERT INTO creditos (disciplina_id, nr_creditos, dia_semana) 
					VALUES (".$_POST['id'].", ".$nr_creditos.", ".$dia_semana.");";	
						$result = pg_query_params($conexao, $query, array()) or die ($query);
		
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
