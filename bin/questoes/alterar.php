<?php
	require_once "../../lib/conexao.php";	
	
	// atualizando colunas de questao
	$sql = "UPDATE questoes SET 
		questao = '".$_POST['questao']."', 
		resposta = '".$_POST['resposta']."' 
		WHERE id = ".$_POST['id'];
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);


	// deletando todas as tags
	// $result = pg_query("BEGIN;
	// 				DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id'].";
	// 		COMMIT;") or die("BEGIN;
	// 				DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id'].";
	// 		COMMIT;");

	$result = pg_query_params($conexao, "DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id'], array()) 
	or die ("DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id']);

	
	// colocando novamente as tags
	$sql = "";
	$vetTag = $_POST['vetTag'];

	if (count($vetTag) > 0){
		foreach ($vetTag as $chave => $tag_id) {
			$sql = "
			INSERT INTO questoes_tags (questao_id, tag_id) values (".$_POST['id'].",".$tag_id.");";	
			$result = pg_query_params($conexao, $sql, array()) or die ($sql);
		}
		// $result = pg_query("BEGIN;".$sql.";COMMIT;") or die ($sql);
		

	}
	header("Location: ./../../view/questoes/pagination.html");
?>