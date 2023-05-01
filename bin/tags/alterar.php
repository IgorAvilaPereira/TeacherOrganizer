<?php
	require_once "../../lib/conexao.php";	
	
	$sql = "UPDATE tags SET tag = $1 WHERE id = $2";
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array($_POST['tag'], $_POST['id'])) or die ($sql);

	header("Location: index.php");
?>