<?php
	require_once "../../lib/conexao.php";

	$query = "select * from avaliacoes where id = ".$_GET['id_avaliacao'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$avaliacao = pg_fetch_array($result);
	$bimestre = $avaliacao['bimestre'];
	
	$sql = "UPDATE avaliacoes 
			SET da_substitutiva = FALSE 
			WHERE bimestre =".$bimestre." AND 
			disciplina_id = ".$_GET['id_disciplina'];
	$result = pg_query_params($conexao,$sql, array()) or die ($sql);

	$sql = "UPDATE avaliacoes 
			SET da_substitutiva = TRUE 
			WHERE id = ".$_GET['id_avaliacao'].";";
			$result = pg_query_params($conexao,$sql, array()) or die ($sql);
	
	// $result = pg_query("BEGIN;".$sql."COMMIT;") or die($sql);
	

	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);	
?>
