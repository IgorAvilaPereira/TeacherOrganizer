<?php
	require_once "../../lib/conexao.php";

	$query = "select * from avaliacoes where id = $1";
	$result = pg_query_params($conexao, $query, array($_GET['id_avaliacao'])) or die ($query);
	$avaliacao = pg_fetch_array($result);
	$bimestre = $avaliacao['bimestre'];

 	$query = "UPDATE avaliacoes 
            SET 
                corrigida = $1
			WHERE 
                id = $2";
	
	$result = pg_query_params($conexao, $query, array(
		(($avaliacao['corrigida'] == 't') ? FALSE : TRUE),
		$_GET['id_avaliacao']
	)) or die ($query);

	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);	
?>
