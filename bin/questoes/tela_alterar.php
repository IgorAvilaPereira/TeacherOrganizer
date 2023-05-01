<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/questoes/tela_alterar.html");
	
	$sql = "select * from questoes WHERE id = $1";
	// $result = pg_query($sql) or die($sql);	
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);

	$registro = pg_fetch_array($result);
	$template->questao = $registro['questao'];
	$template->resposta = nl2br($registro['resposta']);
	$template->questao_id = $registro['id'];

	$sql = "select tag_id FROM questoes_tags WHERE questao_id = $1";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);

	$vetTag = array();
	
	while ($registro = pg_fetch_array($result)){
		$vetTag[] = $registro['tag_id'];
	}	

	$sql = "select * from tags";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);


	while ($registro = pg_fetch_array($result)){
		$template->tag = $registro['tag'];
		$template->id = $registro['id'];
		$template->checked = ((in_array($registro['id'], $vetTag) == true) ? "checked" : "");
		$template->block("tags");
	}	

	$template->show();
?>