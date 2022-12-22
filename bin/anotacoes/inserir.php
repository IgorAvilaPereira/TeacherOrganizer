<?php
	require_once "../../lib/conexao.php";
	
	
	$query = "insert into anotacoes (anotacao, disciplina_id) values ('".pg_escape_string($_POST['anotacao'])."',".$_POST['id_disciplina'].");";						
	// $result = pg_query($sql) or die($sql);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);	
?>