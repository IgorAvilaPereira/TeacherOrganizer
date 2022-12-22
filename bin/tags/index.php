<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/tags/index.html");
	
	$sql = "select * from tags";
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);


	while ($registro = pg_fetch_array($result)){
		$template->tag = nl2br($registro['tag']);
		$template->id = $registro['id'];
		$template->block("tags");
	}	

	$template->show();
?>