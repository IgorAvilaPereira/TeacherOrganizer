<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/disciplinas/tela_inserir.html");
	
	$query = "select * from cursos where id = $1";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);

	$curso  =  pg_fetch_array($result);
	$template->curso = $curso['nome'];
	$template->id_curso = $_GET['id'];		
	
	$vetDiaSemana = array(0 => "Domingo",1 => "Segunda", 2 => "Terça", 3 => "Quarta", 4 => "Quinta", 5=> "Sexta", 6 => "Sábado");
	
	foreach ($vetDiaSemana as $chave => $valor) {
		$template->chave = $chave;
		$template->valor = $valor;
		$template->block("diaSemana");		
	}
	
	$template->show();
	
	
?>