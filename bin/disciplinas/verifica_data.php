<?php
	require_once "../../lib/conexao.php";

	$query = "select * FROM creditos where disciplina_id = $1 and dia_semana = $2";
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'], $_GET['dia_semana'])) or die ($query);
	echo pg_affected_rows($result);
	
?>