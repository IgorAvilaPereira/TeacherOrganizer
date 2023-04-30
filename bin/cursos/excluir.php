<?php
	require_once "../../lib/conexao.php";
	
	$sql = "select * from disciplinas where curso_id = $1";    
    $result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);
    
    if (pg_affected_rows($result)>0) {
        while ($registro = pg_fetch_array($result)) {	
			$sql = "delete from presencas where disciplina_id = $1";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

			$sql = "delete from anotacoes where disciplina_id = $1";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

			$sql = "delete from creditos where disciplina_id = $1";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

			$sql = "delete from planos where disciplina_id = $1";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

			$sql = "delete from notas where aluno_id in (select id from alunos where disciplina_id = $1);";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

			$sql = "delete from avaliacoes where disciplina_id = $1";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

			$sql = "delete from alunos where disciplina_id = $1";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

			$sql = "delete from disciplinas where id = $1";
			$result = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);
		}
	}
	$query  = "delete from cursos where id = $1";	
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);	
	header("Location: index.php");	
?>