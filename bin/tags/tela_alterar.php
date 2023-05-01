<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/tags/tela_alterar.html");
	
	$sql = "select * from tags WHERE id = $1";
	// $result = pg_query($sql) or die($sql);	
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);

	$registro = pg_fetch_array($result);
	$template->tag = nl2br($registro['tag']);
	$template->id = $registro['id'];
	$template->show();
?>