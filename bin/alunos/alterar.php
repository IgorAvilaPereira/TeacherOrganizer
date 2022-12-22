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
			$query = "update presencas set resultado = 0 where aluno_id = ".$_POST['id'].";";
			$result = pg_query_params($conexao, $query, array()) or die ($query);
			foreach ($vetPresenca as $id => $resultado) {
				$query = "update presencas set resultado = 1 where id = ".$id.";";		
				$result = pg_query_params($conexao, $query, array()) or die ($query);
			}
		} else {
			$query = "update presencas set resultado = 0 where aluno_id = ".$_POST['id'].";";
			$result = pg_query_params($conexao, $query, array()) or die ($query);
		}	
	} else {
		$query = "update presencas set resultado = 0 where aluno_id = ".$_POST['id'].";";
		$result = pg_query_params($conexao, $query, array()) or die ($query);
	}

	$query = "update alunos set nome = '".strtoupper($_POST['nome'])."', matricula = '".trim($_POST['matricula'])."', observacao = '".$_POST['observacao']."' where id = ".$_POST['id'].";";		
	// $result = pg_query("begin;".$query."commit;") or die("Problemas em alterar...");
	$result = pg_query_params($conexao, $query, array()) or die ($query);

		
	if (isset($_GET['tela']) && ($_GET['tela'] == $_POST['disciplina_id'])){
		header("Location: ../../bin/disciplinas/ver.php?id_disciplina=".$_POST['disciplina_id']);
	} else {
		header("Location: ../../bin/alunos/index.php?disciplina_id=".$_POST['disciplina_id']);
	}
?>