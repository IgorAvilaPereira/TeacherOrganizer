<?php
	require_once "../../lib/conexao.php";
	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/cursos/tela_alterar.html");
	
	$query = "select * from cursos where id = ".$_GET['id'];
	
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	
	$registro = pg_fetch_array($result);
			$template->id = $registro['id'];
			$template->nome = $registro['nome'];
	//		$template->block("cursos");
	//}
	$template->show();
?>