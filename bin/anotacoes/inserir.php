<?php
	require_once "../../lib/conexao.php";
	
	$query = "insert into anotacoes (anotacao, disciplina_id) values ($1, $2);";						
	$result = pg_query_params($conexao, $query, array($_POST['anotacao'],$_POST['id_disciplina'])) or die ($query);
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);	
?>