<?php
	require_once "../../lib/conexao.php";
				
	$query = "";
	if (isset($_POST['vetPresenca'])){
		$vetPresenca = $_POST['vetPresenca'];
	}
	else {
		$vetPresenca = array();	
	}

	if (is_array($vetPresenca)){		
		if (count($vetPresenca) > 0){
			$query = "update presencas set resultado = 0 where aluno_id = $1";
			$result = pg_query_params($conexao, $query, array($_POST['id'])) or die ($query);
			foreach ($vetPresenca as $id => $resultado) {
				$query = "update presencas set resultado = 1 where id = $1";		
				$result = pg_query_params($conexao, $query, array($id)) or die ($query);
			}
		} else {
			$query = "update presencas set resultado = 0 where aluno_id = $1";
			$result = pg_query_params($conexao, $query, array($_POST['id'])) or die ($query);
		}	
	} else {
		$query = "update presencas set resultado = 0 where aluno_id = $1";
		$result = pg_query_params($conexao, $query, array($_POST['id'])) or die ($query);
	}

	$query = "update alunos set nome = $1, matricula = $2, observacao = $3 where id = $4";		
	$result = pg_query_params($conexao, $query, array(strtoupper($_POST['nome']), trim($_POST['matricula']), trim($_POST['observacao']), $_POST['id'])) or die ($query);

		
	if (isset($_GET['tela']) && ($_GET['tela'] == $_POST['disciplina_id'])){
		header("Location: ../../bin/disciplinas/ver.php?id_disciplina=".$_POST['disciplina_id']);
	} else {
		header("Location: ../../bin/alunos/index.php?disciplina_id=".$_POST['disciplina_id']);
	}
?>