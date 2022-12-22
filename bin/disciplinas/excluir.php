<?php
    require_once "../../lib/conexao.php";
    
    //  listar todos os trabalhos/avaliacoes da disciplina correspondente
    $sql_notas_arquivo = "select arquivo from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where arquivo is not null and disciplina_id = ".$_GET['id_disciplina'].";";
    // $result = pg_query($sql_notas_arquivo) or die($sql_notas_arquivo);
    $result = pg_query_params($conexao, $sql_notas_arquivo, array()) or die ($sql_notas_arquivo);

    $vetArquivo = [];
    if (pg_affected_rows($result)>0) {
        while ($registro = pg_fetch_array($result)) {
            $vetArquivo[] = $registro['arquivo'];
            // preferi n apagar aqui para que os arquivos sejam removidos somente depois do sucesso da transicao
            // unlink(DIR."/bin/avaliacoes/arquivos/".$arquivo);
        }
    }

    $sql = "delete from presencas where disciplina_id = ".$_GET['id_disciplina'].";";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    $sql = "delete from anotacoes where disciplina_id = ".$_GET['id_disciplina'].";";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    $sql = "delete from creditos where disciplina_id = ".$_GET['id_disciplina'].";";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    $sql = "delete from planos where disciplina_id = ".$_GET['id_disciplina'].";";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    $sql = "delete from notas where aluno_id in (select id from alunos where disciplina_id = ".$_GET['id_disciplina'].");";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    $sql = "delete from avaliacoes where disciplina_id = ".$_GET['id_disciplina'].";";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    $sql = "delete from alunos where disciplina_id = ".$_GET['id_disciplina'].";";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    $sql = "delete from disciplinas where id = ".$_GET['id_disciplina'].";";
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    // $sql.= "begin;".$sql."commit;";
    // $result = pg_query($sql) or die($sql);
    


    // opcao mais segura => remover os arquivos somente depois de todos os deletes terem dado certo
    if (count($vetArquivo)>0) {
        foreach ($vetArquivo as $arquivo) {
            unlink(DIR."/bin/avaliacoes/arquivos/".$arquivo);
        }
    }

    header("Location: index.php?id=".$_GET['id_curso']);
?>	