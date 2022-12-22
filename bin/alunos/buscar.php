<?php
    require_once "../../lib/conexao.php";
    // $result = pg_query("select disciplinas.id as disciplina_id, alunos.id as aluno_id, alunos.matricula, alunos.nome as aluno_nome, ano, semestre, disciplinas.nome as disciplina_nome from alunos inner join disciplinas on (disciplinas.id = alunos.disciplina_id) where alunos.nome ilike '%".$_POST['nome']."%' or alunos.matricula ilike '%".$_POST['nome']."%' order by ano desc, semestre desc, disciplina_nome, aluno_nome;");
    $query = "select disciplinas.id as disciplina_id, alunos.id as aluno_id, alunos.matricula, alunos.nome as aluno_nome, ano, semestre, disciplinas.nome as disciplina_nome from alunos inner join disciplinas on (disciplinas.id = alunos.disciplina_id) where alunos.nome ilike '%".$_POST['nome']."%' or alunos.matricula ilike '%".$_POST['nome']."%' order by ano desc, semestre desc, disciplina_nome, aluno_nome;";
    $result = pg_query_params($conexao, $query, array()) or die ($query);
    echo "<h1> Resultado da Busca</h1>";
    $rows = pg_affected_rows($result);
    echo "<h2>".$rows." resultado(s) encontrado(s).</h2>";
    while ($registro = pg_fetch_array($result)) {        
        // echo "* ".$registro['ano']."/".$registro['semestre']." - ".strtoupper($registro['disciplina_nome'])." - ".$registro['matricula']. " - ". strtoupper($registro['aluno_nome'])."<br>";
        echo "* ".$registro['ano']."/".$registro['semestre']." - <a href='./../disciplinas/ver.php?id_disciplina=".$registro['disciplina_id']."' target='__blank'>".strtoupper($registro['disciplina_nome'])."</a> - ".$registro['matricula']. " - <a href='minhas_presencas.php?id_disciplina=".$registro['disciplina_id']."&id_aluno=".$registro['aluno_id']."' target='__blank'>". strtoupper($registro['aluno_nome'])."</a><br>";
    }
    echo "<br>";
    echo "<a href='javascript:void(0)' onclick='history.go(-1)'> Voltar </a>";
?>