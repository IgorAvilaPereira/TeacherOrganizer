<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/disciplinas/tela_add_aluno.html");
	
	$query = "select * from disciplinas where id = $1";	
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);

	
	$registro = pg_fetch_array($result);
			$template->id = $registro['id'];
			$template->nome = $registro['nome'];
			//$template->ano = $registro['ano'];
		//	$template->semestre = $registro['semestre'];			
		
	$template->show();
?>