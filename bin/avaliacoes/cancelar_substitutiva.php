<?php
	require_once "../../lib/conexao.php";

	//$query = "select * from avaliacoes where id = ".$_GET['id_avaliacao'];
	//$result = pg_query($query);
	//$avaliacao = pg_fetch_array($result);
	//$bimestre = $avaliacao['bimestre'];
	
	$query = "UPDATE avaliacoes 
			SET da_substitutiva = FALSE 
			WHERE disciplina_id = $1";
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);	
?>
