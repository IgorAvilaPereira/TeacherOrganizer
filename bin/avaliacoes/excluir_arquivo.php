<?php
	require_once "../../lib/conexao.php";	

    $aluno_id = $_GET['aluno_id'];
    $avaliacao_id = $_GET['avaliacao_id'];
    $disciplina_id = $_GET['disciplina_id'];

    $query = "SELECT * FROM notas WHERE aluno_id = $aluno_id and avaliacao_id = $avaliacao_id;";	
    // $result = pg_query($sql) or die($sql); 	
    $result = pg_query_params($conexao, $query, array()) or die ($query);

    $registro = pg_fetch_array($result);
    $arquivo = $registro['arquivo'];    
    
    unlink(DIR."/bin/avaliacoes/arquivos/".$arquivo);
    // shell_exec("git rm ".DIR."/bin/avaliacoes/arquivos/".$arquivo. " && git commit -m 'rm ".$arquivo."' && git push");  


	$query = "UPDATE notas SET arquivo = NULL WHERE aluno_id = $aluno_id AND avaliacao_id = $avaliacao_id;";
	// $result = pg_query($sql) or die($sql); 	
    $result = pg_query_params($conexao, $query, array()) or die ($query);


    header("Location: tela_corrigir.php?id_avaliacao=$avaliacao_id&id_disciplina=$disciplina_id");
?>	