<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/questoes/tela_gerar_prova.html");	
	$sql = "select * from tags";
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	while ($registro = pg_fetch_array($result)){
		$template->tag = $registro['tag'];
		$template->id = $registro['id'];
		$template->block("tags");
	}	
	$sql = "select * from disciplinas order by ano desc, semestre desc";
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	while ($registro = pg_fetch_array($result)){
		$template->nome = $registro['ano']."/".$registro['semestre']."-".$registro['nome'];
		$template->value = $registro['nome'];
		$template->id = $registro['id'];
		$template->block("disciplinas");
		$template->block("disciplinas_checkbox");
	}	
	$template->show();
?>