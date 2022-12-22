<?php
	require_once "../../lib/conexao.php";

    // caso especifico do semestre remoto de 2021 
    $id_disciplina = $_GET['id_disciplina'];    
    $query = "select * from disciplinas where id = ".$id_disciplina;
    // $result = pg_query($query);
    $result = pg_query_params($conexao, $query, array()) or die ($query);

    $registro = pg_fetch_array($result);

    $vetSemana = array('Semana 0', 'Semana 1', 'Semana 2', 'Semana 3', 'Semana 4', 'Semana 5', 'Semana 6', 'Semana 7', 'Semana 8', 'Semana 9', 'Semana 10', 'Semana 11', 'Semana 12', 'Semana 13');
    
    echo "# ".$registro['nome']." - Faltas por Semana <br><br>";

    foreach ($vetSemana as $semana) {
        echo "## $semana <br>";
        $query = "select * from planos inner join disciplinas on (disciplinas.id = planos.disciplina_id) 
        where disciplina_id = ".$id_disciplina." and texto like '%".$semana."%' limit 1";
        // $result = pg_query($query);
        $result = pg_query_params($conexao, $query, array()) or die ($query);

        if (pg_affected_rows($result)) {
            $registro = pg_fetch_array($result);
            $sql = "select presencas.creditos, presencas.id as presenca_id, alunos.nome, resultado 
		    from presencas inner join alunos on (alunos.id = presencas.aluno_id) 
		    where presencas.disciplina_id = ".$id_disciplina." and data = '".$registro['data']."' 
		    and resultado = 0 order by alunos.nome";
            // $result = pg_query($sql);
            $result = pg_query_params($conexao, $sql, array()) or die ($sql);

            while ($registro = pg_fetch_array($result)) {
                echo "* ".nl2br($registro['nome'])."<br>";
            }
            echo "<br> *** <br> <br>";
        }
    }
?>