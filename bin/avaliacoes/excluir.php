<?php
	require_once "../../lib/conexao.php";	
	$sql = "select * from notas where avaliacao_id = ".$_GET['id_avaliacao'].";";		
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);
	while($registro = pg_fetch_array($result)){
		if (!empty($registro['arquivo'])){
			unlink(DIR."/bin/avaliacoes/arquivos/".$registro['arquivo']);
		}
	}	
	$sql = "delete from notas where avaliacao_id = ".$_GET['id_avaliacao'].";";		
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);
	$sql = "delete from avaliacoes where id = ".$_GET['id_avaliacao'].";";
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);	
	header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);
?>	