<?php
	require_once "../../lib/conexao.php";

	$query = "select * from avaliacoes where id = ".$_GET['id_avaliacao'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$avaliacao = pg_fetch_array($result);
	$bimestre = $avaliacao['bimestre'];

    // echo "<pre>";
    //     print_r(var_dump($avaliacao));
    // echo "</pre>";
    // die();

	$query = "UPDATE avaliacoes 
            SET 
                corrigida = ".( ($avaliacao['corrigida'] == 't') ? "FALSE" : "TRUE")."
			WHERE 
                id = ".$_GET['id_avaliacao'].";";
	
	// $result = pg_query("BEGIN;".$sql."COMMIT;") or die($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);	
?>
