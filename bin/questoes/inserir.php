<?php
	require_once "../../lib/conexao.php";	
	
	$query = "INSERT INTO questoes (questao, resposta) values ('".$_POST['questao']."','".$_POST['resposta']."') RETURNING id";
	// $result = pg_query($sql) or die("ERRO NO INSERT DA QUESTAO...");	
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	
	if (pg_affected_rows($result) > 0) {
		$registro = pg_fetch_array($result);
		$id = $registro['id'];
	} else {
		$id = 0;
	}

	$sql = "";	
	$vetTag = ((isset($_POST['vetTag'])) ? $_POST['vetTag'] : array());

	if (count($vetTag) > 0 && $id > 0){
		foreach ($vetTag as $chave => $tag_id) {
			$sql.= "
			INSERT INTO questoes_tags (questao_id, tag_id) values (".$id.",".$tag_id.");";	
		}
		// $result = pg_query("BEGIN;".$sql.";COMMIT;");
		$result = pg_query_params($conexao, "BEGIN;".$sql.";COMMIT;", array()) or die ("BEGIN;".$sql.";COMMIT;");

	}
	header("Location: ./../../view/questoes/pagination.html");
?>