<?php
	require_once "../../lib/conexao.php";
	
	$query = "select * FROM questoes order by id desc; --LIMIT 1;";
	// $result = pg_query($sql) or die($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);


	$resposta = "";
	while ($registro = pg_fetch_array($result)){
		$resposta.= $registro['id'].";";
		$resposta.= nl2br(substr(strip_tags(trim($registro['questao'])), 0, 400))."...";
		$resposta.="<QUESTAO><QUESTAO><QUESTAO>";
	}	
	echo $resposta;	
?>