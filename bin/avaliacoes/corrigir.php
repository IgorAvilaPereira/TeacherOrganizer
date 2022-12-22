<?php
    require_once "../../lib/conexao.php";
    require_once "../../lib/upload.php";
    require_once "../../lib/caracteres_sem_acento.php";

    // echo $_GET['id_disciplina'];
    $sql = "select * from notas where avaliacao_id = $1";
    $result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);    
    // echo (pg_affected_rows($result) == 0);
    if (pg_affected_rows($result) === 0) {
        $sql = "select id from alunos where disciplina_id = $1";        
        $result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);  
        while ($registro =  pg_fetch_array($result)) {
           /* try {
                $sql = "insert into notas 
				(avaliacao_id, aluno_id, obtido) 
				values 
				($1, $2, $3);";
                pg_query_params($conexao, $sql, array($_GET['id_avaliacao'], $registro['id'], 0));
            } catch(Exception $erro){*/
                $sql = "DELETE FROM notas WHERE avaliacao_id = $1 and aluno_id = $2;";
                pg_query_params($conexao, $sql, array($_GET['id_avaliacao'], $registro['id'])) or die ($sql);

                $sql = "insert into notas 
				(avaliacao_id, aluno_id, obtido) 
				values 
				($1, $2, $3);";
                // pg_query_params($conexao, $sql, array($_GET['id_avaliacao'], $registro['id'], 0)) or die ($sql);
                pg_query_params($conexao, $sql, array($_GET['id_avaliacao'], $registro['id'], 0)) or die ($sql);
            //}            
        }
        // $result = pg_query("begin;".$sql."commit;");
    }
    $sql = "";
    if (isset($_POST['vetNota'])) {
        foreach ($_POST['vetNota'] as $aluno_id => $nota) {
            if (isset($_FILES['vetArquivo']["name"][$aluno_id]) && strlen($_FILES['vetArquivo']["tmp_name"][$aluno_id]) > 0) {
                $tmp_name = $_FILES['vetArquivo']["tmp_name"][$aluno_id];
                $type = $_FILES['vetArquivo']["type"][$aluno_id];
                $name = basename($_FILES['vetArquivo']["name"][$aluno_id]);
				$extensao = ((strlen(array_search($type, $mime_types))>0) ? array_search($type, $mime_types): explode(".", $name)[1]);
                
                // com nome do aluno no nome do arquivo
                $sql = "SELECT * FROM alunos WHERE id = ".$aluno_id;
                // $result = pg_query($sql) or die('erro');
                $result = pg_query_params($conexao, $sql, array()) or die ($sql);
                $aluno = pg_fetch_array($result);
                $aluno_nome = explode(" ", strtolower(strtr(trim($aluno['nome']), $caracteres_sem_acento)))[0];
                $novo_nome = $aluno_nome."_".$_GET['id_disciplina']."_".$_GET['id_avaliacao']."_".$aluno_id.".".$extensao;

                // nome do arquivo sem nome do aluno
                // $novo_nome = $aluno_id."_".$_GET['id_avaliacao'].".".$extensao;
                move_uploaded_file($tmp_name, DIR."/bin/avaliacoes/arquivos/".$novo_nome);
                
                $sql = "update notas 
				set 
					obtido = $1,
					comentario = $2,
					arquivo = $3
				where 
					aluno_id = $4 and avaliacao_id = $5";
                // $result = pg_query($sql) or die('erro');
                // $result = pg_query_params($conexao, $sql, array()) or die ($sql);
                pg_query_params($conexao, $sql, array($nota,$_POST['vetComentario'][$aluno_id], $novo_nome, $aluno_id, $_GET['id_avaliacao'])) or die ($sql);

            } else {
                $sql = "update notas 
					set 
						obtido = $1,
						comentario = $2
					where 
						aluno_id = $3 and avaliacao_id = $4";
                // $result = pg_query($sql) or die('erro');
                pg_query_params($conexao, $sql, array($nota,$_POST['vetComentario'][$aluno_id], $aluno_id, $_GET['id_avaliacao'])) or die ($sql);
            }
        }
    }
    dump(); // gerar dump
    header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);
?>