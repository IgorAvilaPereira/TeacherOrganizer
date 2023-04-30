<?php
	require_once "../../lib/conexao.php";
    require_once "../../lib/TextTable.php";

    $id_disciplina = $_GET['id_disciplina'];  
    $query = "select * from disciplinas where id = $1";
    // $result = pg_query($query);
    $result = pg_query_params($conexao, $query, array($id_disciplina)) or die ($query);

    $registro = pg_fetch_array($result);
    $total = (($registro['eh_semestral'] == 't') ? 2 : 4);
    $html = "## ".$registro['nome']."<br><br>";    
    
    $columns = ["Matr&iacute;cula"];
    $columns[] = "Nome";
    $columns[] = "Faltas";
    
    for ($bimestre = 1; $bimestre <= $total; $bimestre++) {     
        $query = "select presencas.bimestre, alunos.matricula, alunos.nome, sum(presencas.creditos) - sum(presencas.creditos * presencas.resultado) as faltas from alunos inner join presencas 
        on (presencas.aluno_id = alunos.id)
    where alunos.disciplina_id = $id_disciplina and presencas.bimestre = $bimestre
    group by presencas.bimestre, alunos.matricula, alunos.nome, alunos.id
    order by presencas.bimestre, alunos.id";
        // $result = pg_query($query);
        $result = pg_query_params($conexao, $query, array()) or die ($query);

    
        $html .= "## " . $bimestre . "º Ciclo <br><br>";      
    
        $rowsFinal = [];
        while ($registro = pg_fetch_array($result)) {
            $row = [$registro['matricula']];
            $row[] = $registro['nome'];
            $row[] = $registro['faltas'];
            $rowsFinal[] = $row;
        }       
        $t = new TextTable($columns, $rowsFinal);
        $t->setAlgin(['L', 'L', 'C']);
        $html .= nl2br($t->render()) . "<br><br>";
        
        $html .= "*** <br><br>";
    }
    echo $html;
?>