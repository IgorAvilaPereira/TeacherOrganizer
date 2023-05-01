<?php
    require_once "../../lib/conexao.php";
    require_once "../../lib/caracteres_sem_acento.php";
    require_once '../../lib/odsPhpGenerator-0.0.3/src/ods.php';
    require_once '../../lib/odsPhpGenerator-0.0.3//src/odsTable.php';
    require_once '../../lib/odsPhpGenerator-0.0.3/src/odsTableCell.php';
    require_once '../../lib/odsPhpGenerator-0.0.3/src/odsTableColumn.php';
    require_once '../../lib/odsPhpGenerator-0.0.3/src/odsTableRow.php';
    require_once '../../lib/odsPhpGenerator-0.0.3/src/odsFontFace.php';
    require_once '../../lib/odsPhpGenerator-0.0.3/src/odsStyle.php';

    use odsPhpGenerator\ods;
    use odsPhpGenerator\odsTable;
    use odsPhpGenerator\odsTableRow;
    use odsPhpGenerator\odsTableCellString;
    use odsPhpGenerator\odsTableCellFloat;

    $avaliacao_id = $_POST['id_avaliacao'];
    $disciplina_id = $_POST['id_disciplina'];
    $qtde = $_POST['qtde'];

    $alfabeto = [];
    foreach (range('A', 'Z') as $letra) {
        $alfabeto[] = $letra;
    }
    
    $query = "select * from avaliacoes where id = $1";    
    $result = pg_query_params($conexao, $query, array($avaliacao_id)) or die ($query);

    $registro = pg_fetch_array($result);
    $titulo_nome_planilha = strtr(strtolower(str_replace("-", "_", str_replace(" ","_",$registro['titulo']))), $caracteres_sem_acento);    
    $titulo = $registro['titulo'];    
    $descricao = $registro['descricao'];    
    $ciclo = $registro['bimestre'];
    $valor = $registro['valor'];  

    $ods  = new ods();
    $table1 = new odsTable('Alunos');    

    $query = "select * from alunos where disciplina_id = $1 order by matricula";    
    $result = pg_query_params($conexao, $query, array($disciplina_id)) or die ($query);
    
    // primeira planilha

    // primeira planilha => primeira linha
    $row   = new odsTableRow();
    $row->addCell(new odsTableCellString("Matrícula"));
    $row->addCell(new odsTableCellString("Nome"));
    for ($x = 0; $x < $qtde; $x++) {
        $row->addCell(new odsTableCellString("Requisito".($x+1)));
    }
    $row->addCell(new odsTableCellString("Total"));
    $table1->addRow($row);

    // linha para cada aluno
    $i = 2;
    $coluna = $alfabeto[$i+$qtde-1];
    while ($registro = pg_fetch_array($result)) {
        $row   = new odsTableRow();
        $row->addCell(new odsTableCellString($registro['matricula']));
        $row->addCell(new odsTableCellString($registro['nome']));
        for ($x = 0; $x < $qtde; $x++) {
            $row->addCell(new odsTableCellFloat(0));
        }
        $cell = new odsTableCellString("");
        $row->addCell($cell);
        $cell->setFormula('SUM(C'.$i.':'.$coluna.''.$i.')');
        $table1->addRow($row);
        $i++;
    }
    $ods->addTable($table1);

    // segunda planilha 
    $table2 = new odsTable('Avaliação');    
    $row   = new odsTableRow();
    $row->addCell(new odsTableCellString("Título:"));
    $row->addCell(new odsTableCellString($titulo));
    $table2->addRow($row);

    // $row   = new odsTableRow();
    // $row->addCell(new odsTableCellString("Descrição:"));
    // $row->addCell(new odsTableCellString(substr(trim($descricao),0, 100)."..."));
    // $table2->addRow($row);
    
    $row   = new odsTableRow();
    $row->addCell(new odsTableCellString("Ciclo:"));
    $ciclo = ($ciclo == 0) ? 'Exame' : $ciclo;
    $row->addCell(new odsTableCellString($ciclo));
    $table2->addRow($row);

    $row   = new odsTableRow();
    $row->addCell(new odsTableCellString("Valor:"));
    $row->addCell(new odsTableCellString($valor));
    $table2->addRow($row);

    for ($x = 0; $x < $qtde; $x++) {
        $row   = new odsTableRow();
        $row->addCell(new odsTableCellString("Requisito".($x+1).":"));
        $table2->addRow($row);
    }    

    $ods->addTable($table2);        
    $ods->downloadOdsFile($titulo_nome_planilha.".ods");
?>