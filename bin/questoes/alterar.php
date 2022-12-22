<?php
	require_once "../../lib/conexao.php";	
	
	// atualizando colunas de questao
	$sql = "UPDATE questoes SET 
		questao = '".pg_escape_string($_POST['questao'])."', 
		resposta = '".pg_escape_string($_POST['resposta'])."' 
		WHERE id = ".$_POST['id'];
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);


	// deletando todas as tags
	// $result = pg_query("BEGIN;
	// 				DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id'].";
	// 		COMMIT;") or die("BEGIN;
	// 				DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id'].";
	// 		COMMIT;");

	$result = pg_query_params($conexao, "BEGIN;
	DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id'].";
COMMIT;", array()) or die ("BEGIN;
DELETE FROM questoes_tags WHERE questao_id = ".$_POST['id'].";
COMMIT;");

	
	// colocando novamente as tags
	$sql = "";
	$vetTag = $_POST['vetTag'];

	if (count($vetTag) > 0){
		foreach ($vetTag as $chave => $tag_id) {
			$sql.= "
			INSERT INTO questoes_tags (questao_id, tag_id) values (".$_POST['id'].",".$tag_id.");";	
		}
		// $result = pg_query("BEGIN;".$sql.";COMMIT;") or die ($sql);
		$result = pg_query_params($conexao, "BEGIN;".$sql.";COMMIT;", array()) or die ("BEGIN;".$sql.";COMMIT;");

	}
	header("Location: ./../../view/questoes/pagination.html");
?>