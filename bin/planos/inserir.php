<?php

		require_once "../../lib/conexao.php";
	
	
		$query = "INSERT INTO planos(bimestre, data, texto, disciplina_id)
    	VALUES (
    		$1,
    		$2,
    		$3,
    		$4);";
		// $result = pg_query($sql) or die($sql);
		$result = pg_query_params($conexao, $query, array($_POST['bimestre'], $_POST['data'], trim($_POST['texto']), $_POST['id_disciplina'])) or die ($query);

		
		dump(); // realiza o dump com as presencas/ausencias do dia mais o plano recem cadastrado
		
		header("Location: ../disciplinas/ver.php?id_disciplina=".$_POST['id_disciplina']);
		
			
?>		