<?php
	require_once "../../lib/conexao.php";

	$query = "select * FROM creditos where disciplina_id = ".$_GET['id_disciplina']." and dia_semana=".$_GET['dia_semana'];
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	echo pg_affected_rows($result);
	
?>