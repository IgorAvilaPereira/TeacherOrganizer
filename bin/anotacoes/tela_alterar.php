<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/anotacoes/tela_alterar.html");
	
	$query = "select * from anotacoes where id = $1";
	$result = pg_query_params($conexao, $query, array($_GET['id_anotacao'])) or die ($query);
	$registro = pg_fetch_array($result);
		
	$template->id = $registro['id'];
	$template->anotacao = $registro['anotacao'];
	$template->id_disciplina = $registro['disciplina_id'];
	$template->show();
?>