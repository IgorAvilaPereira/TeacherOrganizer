<?php
	require_once "../../lib/conexao.php";	
	
	$query = "UPDATE provas 
		SET 
			exercicios = '".$_POST['prova']."', 
			data_hora = now(), 
			nome = '".$_POST['nome']."'
			WHERE provas.id = ".$_POST['id'];
	// $result = pg_query($sql) or die($sql);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	//echo "oi";
	header("Location: index.php");
?>