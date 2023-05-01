<?php
	require_once "../../lib/conexao.php";

	$query = "SELECT * FROM planos WHERE id = $1";
	// $result = pg_query($sql) or die($sql);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);

	$registro = pg_fetch_array($result);	
	$data = $registro['data'];
	$id_disciplina = $registro['disciplina_id'];

	$sql = "DELETE FROM planos WHERE id = $1";
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);

	$sql = "DELETE FROM presencas WHERE data = $1 AND disciplina_id = $2";
	// $result = pg_query("BEGIN;".$sql."COMMIT;") or die($sql);
	$result = pg_query_params($conexao, $sql, array(trim($data), $id_disciplina)) or die ($sql);


	dump(); // realiza o dump SEM as presencas/ausencias do dia + o plano recem EXCLUIDO
	
	// volta a tela principal de detalhamento da disciplina
	header("Location: ../disciplinas/ver.php?id_disciplina=".$id_disciplina);				
?>		