<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;	
	
	$template = new Template("../../view/planos/tela_inserir.html");		
	$template->id_disciplina = $_GET['id_disciplina'];	
	
	$query = "select max(bimestre) as bimestre from presencas where disciplina_id = ".$_GET['id_disciplina'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$max_bimestre =  pg_fetch_array($result);	
	$template->max_bimestre = (($max_bimestre['bimestre'] > 0) ? $max_bimestre['bimestre'] : 1) ;	
			
	if (isset($_GET['data'])) {
		$sql = "select * from planos where disciplina_id = ".$_GET['id_disciplina']." and data ='".$_GET['data']."';";
		// $result = pg_query($sql);
		$result = pg_query_params($conexao, $sql, array()) or die ($sql);

		if (pg_affected_rows($result) == 0){		
			$template->data = ((isset($_GET['data'])) ? "<input type='hidden' name='data' value='".$_GET['data']."'/>" : "Data: <input type='text' name='data' />");
			$template->show();	
		}	
		else {
			header("Location: ".URL."bin/disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);			
		} 
	} else {
		$template->data = ((isset($_GET['data'])) ? "<input type='hidden' name='data' value='".$_GET['data']."'/>" : "Data: <input type='text' name='data' />");
		$template->show();	
	}		
?>	