<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "BEGIN; DELETE FROM questoes_tags WHERE tag_id = ".$_GET['id'].";DELETE FROM tags WHERE id = ".$_GET['id'].";COMMIT;";
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);


	header("Location: index.php");
?>