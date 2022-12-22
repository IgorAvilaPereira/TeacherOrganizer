<?php
	require_once "../../lib/conexao.php";

	$query = "select * FROM creditos where disciplina_id = ".$_GET['id_disciplina']." and dia_semana=".$_GET['dia_semana'];
	$result = pg_query($query);
	echo pg_affected_rows($result);
	
?>