<?php
    require_once "../../lib/conexao.php";  
    // etapa;data;creditos;atividade;
    $vetDiario = explode("\n", trim($_POST['diario']));    
    $disciplina_id = $_POST['disciplina_id'];    
    $vetData = [];
    $vetPlano = [];    
    $vetPresenca = [];    
    if (count($vetDiario) > 0) {
        foreach ($vetDiario as $linha) {    
            $linha = explode(";", trim($linha));
            $etapa = $linha[0];        
            $data = $linha[1];
            $data = explode("/", $data);
            $data = $data[2]."-".$data[1]."-".$data[0];
            $creditos = $linha[2];           
            $atividade = $linha[3];
            $vetPlano[] ="INSERT INTO planos(data, texto, disciplina_id, bimestre) VALUES ('".$data."', '".$atividade."', $disciplina_id, $etapa);";
            $resultado = pg_query_params($conexao, "select * from alunos where disciplina_id = $1", array($disciplina_id)) or die ($q);
            while ($aluno = pg_fetch_array($resultado)){
                $vetPresenca[] = "INSERT INTO presencas(data, aluno_id, disciplina_id, resultado, bimestre, creditos) VALUES ('".$data."', ".$aluno['id'].", $disciplina_id, 1, ". $etapa.", ".$creditos.");";             
            }      
        }
        // cria todos os planos
        if (count($vetPlano)>0) {
            foreach($vetPlano as $i => $q) {
                $resultado = pg_query_params($conexao, $q, array()) or die ($q);
            }      
        }
        // dá presença para todos os alunos
        if (count($vetPresenca)>0) {
            foreach($vetPresenca as $i => $q) {
                $resultado = pg_query_params($conexao, $q, array()) or die ($q);
            }      
        }
    }
    header("Location: index.php?id_disciplina=".$disciplina_id);
?>