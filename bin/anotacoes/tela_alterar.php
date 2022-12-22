<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/anotacoes/tela_alterar.html");
	
	$query = "select * from anotacoes where id = ".$_GET['id_anotacao'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$registro = pg_fetch_array($result);
		
	$template->id = $registro['id'];
	$template->anotacao = $registro['anotacao'];
	$template->id_disciplina = $registro['disciplina_id'];
	$template->show();
?>