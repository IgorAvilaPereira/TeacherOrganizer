<?php
    require_once "../../lib/conexao.php";
    
    $query = "";
    $query = "UPDATE presencas SET resultado = 0 WHERE disciplina_id = $1";
    $result = pg_query_params($conexao, $query, array($_POST['disciplina_id'])) or die ($query);

    $vetPresenca = ((isset($_POST['vetPresenca'])) ? $_POST['vetPresenca']:[]);
    
    if (count($vetPresenca) > 0) {
        foreach ($vetPresenca as $data => $vetAluno) {
            // $query.= "UPDATE presencas SET resultado = 0 
            // WHERE data = ".$data." AND disciplina_id = ".$_POST['disciplina_id']."; ";
            $query = "UPDATE presencas SET resultado = 1 
            WHERE data = $1 AND aluno_id in (".implode(",", $vetAluno).") AND disciplina_id = $2";
            $result = pg_query_params($conexao, $query, array($data, $_POST['disciplina_id'])) or die ($query);
        }
    }
    // die($query);
    // $resultado = pg_query($query);   
    

    header("Location: ../disciplinas/ver.php?id_disciplina=" . $_POST['disciplina_id']);
?>
