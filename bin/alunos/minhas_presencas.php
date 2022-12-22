<?php
    require_once "../../lib/conexao.php";
    require_once "../../lib/Template.php";
    use raelgc\view\Template;
    // require_once "../../lib/html2pdf/html2pdf.class.php";
    // ob_start();

    $template = new Template("../../view/alunos/minhas_presencas.html");

    $query = "select * from disciplinas where id = " . $_GET['id_disciplina'];
    // $result = pg_query($query);
    $result = pg_query_params($conexao, $query, array()) or die ($query);
    $registro = pg_fetch_array($result);
    $disciplina = utf8_decode($registro['nome']);
    $creditos_por_dia = $registro['creditos_por_dia'];
    $creditos = $registro['creditos'];
    $eh_semestral = (($registro['eh_semestral'] == 't') ? true : false);

    //$html.= "Disciplina: ".utf8_decode($disciplina)."<br>";
    $html = "";
    $html .= (($eh_semestral == true) ? "Semestral" : "Anual") . "<br>";

    $dia = array('Domingo', 'Segunda', 'Ter&ccedil;a', 'Quarta', 'Quinta', 'Sexta', 'S&aacute;bado');
    $queryCreditosPorDia = "select * from creditos where disciplina_id = " . $_GET['id_disciplina'];
    // $resultCreditosPorDia = pg_query($queryCreditosPorDia);
    $resultCreditosPorDia = pg_query_params($conexao, $queryCreditosPorDia, array()) or die ($queryCreditosPorDia);
    $str = "<br>";
    $totalCreditos = 0;
    while ($registroCreditosPorDia = pg_fetch_array($resultCreditosPorDia)) {
        $str .= "* " . $dia[$registroCreditosPorDia['dia_semana']] . ":" . $registroCreditosPorDia['nr_creditos'] . "<br>";
        $totalCreditos += $registroCreditosPorDia['nr_creditos'];
    }
    if ($totalCreditos > 0) {
        $html .= "Cr&eacute;ditos por Semana: " . $totalCreditos . "<br>";
        $html .= "Cr&eacute;ditos por Aula:" . $str;
    } else if ($creditos_por_dia > 0) {
        $html .= "Cr&eacute;ditos por Semana: " . $creditos . "<br>";
        $html .= "Cr&eacute;ditos por Aula:" . $creditos_por_dia . "<br>";
    }
    $template->html_creditos = $html;

    $sql = "select *, cursos.nome as curso,
            disciplinas.nome as disciplina,
            disciplinas.ano,
            disciplinas.semestre,
            disciplinas.eh_semestral,
            alunos.nome as aluno,
            alunos.observacao,
            alunos.matricula
        from
            disciplinas
        inner join
            cursos
        on
            (disciplinas.curso_id = cursos.id)
        inner join
            alunos
        on
            (alunos.disciplina_id =  disciplinas.id)
        where
            disciplinas.id = " . $_GET['id_disciplina'] . " and alunos.id = " . $_GET['id_aluno'] . ";";
    // $result = pg_query($sql);
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);

    $registro = pg_fetch_array($result);
    $template->curso = $registro['curso'];
    $template->disciplina = $registro['disciplina'];
    $template->ano = $registro['ano'];
    $template->semestre = $registro['semestre'];
    $template->aluno = $registro['aluno'];
    $template->observacao = $registro['observacao'];
    $template->matricula = $registro['matricula'];
    $eh_semestral = (($registro['eh_semestral'] == 't') ? true : false);
    $total = (($registro['eh_semestral'] == 't') ? 2 : 4);

    // avaliacoes/notas
    for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
        //  old 21/09/21 => listava ateh avaliacoes ainda n corrigidas       
        $sql = "select
                bimestre,
                titulo,
                valor,
                obtido
                    from
                        notas
                        inner join
                        avaliacoes
                    on
                        (avaliacoes.id = notas.avaliacao_id)
                    where
                        avaliacao_id in (select id from avaliacoes where disciplina_id = " . $_GET['id_disciplina'] . " )
                        and aluno_id =" . $_GET['id_aluno'] . " and avaliacoes.bimestre = " . $bimestre . " order
                        by avaliacoes.bimestre, avaliacoes.titulo, avaliacoes.id;";  
                   
        // agora soh lista/computa avaliacoes avaliadas ateh o momento
        // $sql = "
        // select 
        //     bimestre, 
        //     titulo, 
        //     valor, 
        //     obtido 
        // from 
        //     notas inner join avaliacoes on (avaliacoes.id = notas.avaliacao_id) 
        // where 
        //     avaliacao_id in (
        //         select distinct avaliacoes.id from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) 
        //             where 
        //                 disciplina_id = " . $_GET['id_disciplina'] . "
        //         except
        //             select distinct avaliacoes.id from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) 
        //         where 
        //             disciplina_id = " . $_GET['id_disciplina'] . " 
        //         and 
        //             comentario = '<br>' and obtido = 0
        //     )        
        // and 
        //     aluno_id =" . $_GET['id_aluno'] . "
        // and 
        //     avaliacoes.bimestre = " . $bimestre . "
        // order by 
        //     avaliacoes.bimestre, 
        //     avaliacoes.titulo, 
        //     avaliacoes.id;";
        // $result = pg_query($sql);
        $result = pg_query_params($conexao, $sql, array()) or die ($sql);
        $i = 1;
        $nota = 0;
        if (pg_affected_rows($result) > 0) {
            while ($avaliacao = pg_fetch_array($result)) {
                $template->bimestre = (($avaliacao['bimestre'] > 0) ? $avaliacao['bimestre'] : "Exame");
                $template->titulo = $avaliacao['titulo'];
                $template->valor = $avaliacao['valor'];
                $template->obtido = $avaliacao['obtido'];
                $nota += $avaliacao['obtido'];
                if ($i % 2 == 0) {
                    $template->cor = 'aliceblue';
                } else {
                    $template->cor = 'white';
                }
                $i++;
                $template->block("avaliacoes");
            }
            $template->bimestre = (($bimestre > 0) ? $bimestre : "Exame");
            $template->nota = $nota;
            $template->block("bimestres");
        } else {
            $template->bimestre = (($bimestre > 0) ? $bimestre : "Exame");
            $template->nota = 0;
            $template->block("bimestres");
        }
    }

    // aulas datas
    $query = "select * from disciplinas where id = " . $_GET['id_disciplina'];
    // $result = pg_query($query);
    $result = pg_query_params($conexao, $query, array()) or die ($query);

    $registro = pg_fetch_array($result);
    $disciplina = $registro['nome'];
    $eh_semestral = (($registro['eh_semestral'] == 't') ? true : false);
    $total = (($eh_semestral == 't') ? 2 : 4);

    $query = "select distinct data from presencas where disciplina_id = " . $_GET['id_disciplina'];
    // $result = pg_query($query);
    $result = pg_query_params($conexao, $query, array()) or die ($query);
    $creditos = (($registro['creditos'] > 0) ? $registro['creditos'] : 1);
    //$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
    $creditos_por_dia = $registro['creditos_por_dia'];
    // total de aulas dadas
    $aulas = round(pg_affected_rows($result) * $creditos_por_dia);

    // rotulos do cabecalho
    $vetData = array();
    while ($registro = pg_fetch_array($result)) {
        $data = explode("-", $registro['data']);
        $vetData[] = $data[2] . "/" . $data[1];
    }

    // total de aula por bimestre
    $aulas = array();
    for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
        $sql = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = " . $_GET['id_disciplina'];
        // $resultado = pg_query($sql);
        $resultado = pg_query_params($conexao, $sql, array()) or die ($sql);
        if (pg_affected_rows($resultado) > 0) {
            $sql = "select distinct data, creditos from presencas
                        where
                        aluno_id in (select id from alunos where disciplina_id = " . $_GET['id_disciplina'] . " limit 1) and
                        disciplina_id = " . $_GET['id_disciplina'] . " and bimestre = " . $bimestre;
            // $resultado = pg_query($sql);
            $resultado = pg_query_params($conexao, $sql, array()) or die ($sql);
            $aulasX = 0;
            while ($x = pg_fetch_array($resultado)) {
                $aulasX += $x['creditos'];
            }
            $aulas[$bimestre] = $aulasX;
        } else {
            $query = "select distinct data from presencas
                    where disciplina_id = " . $_GET['id_disciplina'] . " and bimestre = " . $bimestre;
            // $result = pg_query($query);
            $result = pg_query_params($conexao, $query, array()) or die ($query);
            $aulas[$bimestre] = round(pg_affected_rows($result) * $creditos_por_dia); //pg_affected_rows($result);
        }
    }
    $template->aulas_dadas = array_sum($aulas);

    $sql = "select * from alunos where disciplina_id = " . $_GET['id_disciplina'] . " and id = " . $_GET['id_aluno'];
    // $result = pg_query($sql);
    $result = pg_query_params($conexao, $sql, array()) or die ($sql);
    while ($registro = pg_fetch_array($result)) {
        $nome = explode(" ", $registro['nome']);
        $matriz[$registro['matricula']]['Nome'] = $nome[0];
        $matricula = $registro['matricula'];
        for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
            $sql2 = "select * from presencas where aluno_id = " . $registro['id'] . " and bimestre = " . $bimestre . " order by data";
            // $result2 = pg_query($sql2);
            $result2 = pg_query_params($conexao, $sql2, array()) or die ($sql2);

            if (pg_affected_rows($result2) > 0) {
                while ($registro2 = pg_fetch_array($result2)) {
                    $data = explode("-", $registro2['data']);
                    $matriz[$registro['matricula']][$bimestre]['data'][$data[2] . "/" . $data[1]] = (($registro2['resultado'] == 1) ? "*" : "F");
                    $id = $registro['matricula'];
                }
            } else {
                // caso nao haja nenhuma presenca ou falta no bimestre
                $matriz[$registro['matricula']][$bimestre]['data'] = array();
            }
            $sqlPresenca = "select * from presencas
                where
                    aluno_id = " . $registro['id'] . " and
                    disciplina_id = " . $_GET['id_disciplina'] . " and resultado = 1 and bimestre = " . $bimestre;
            // $resultadoPresenca = pg_query($sqlPresenca);
            $resultadoPresenca = pg_query_params($conexao, $sqlPresenca, array()) or die ($sqlPresenca);
            $presencas = 0;
            $faltas = 0;
            while ($xPresenca = pg_fetch_array($resultadoPresenca)) {
                $presencas += $xPresenca['creditos'];
            }
            $matriz[$registro['matricula']][$bimestre]['Presen&ccedil;as'] = round((($presencas > 0) ? $presencas : 0));
            $matriz[$registro['matricula']][$bimestre]['Faltas'] = $aulas[$bimestre] - $presencas;
        }
    }

    $html = "";
    for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
        $i = 1;
        $html .= "<h4> " . $bimestre . " - Ciclo Letivo </h4>";
        $html .= "<table border='1'>";
        //$html.= "<tr style='background-color:aliceblue; font-weight: bold;'> <td> Matr&iacute;cula </td> <td> ".implode("</td> <td> ", array_keys($matriz[$matricula][$bimestre]['data']))."</td>";
        $html .= "<tr style='background-color:aliceblue; font-weight: bold;'>
                    <td> Matr&iacute;cula </td> " . ((count(array_keys($matriz[$matricula][$bimestre]['data'])) > 0) ? "<td> " . implode("</td> <td> ", array_keys($matriz[$matricula][$bimestre]['data'])) . "</td>" : "");
        //$html.="<td> p($bimestre) </td> <td> f($bimestre) </td>";
        //$html.="<td> Presen&ccedil;as </td> <td> Faltas </td>";
        $html .= "<td> P </td> <td> F </td>";
        $html .= "</tr>";
        foreach ($matriz as $matricula => $vetor) {
            $html .= (($i % 2 == 0) ? "<tr style='background-color:aliceblue'> <td> " . $matricula . "</td>" : "<tr> <td> " . $matricula . "</td>");
            if (count($matriz[$matricula][$bimestre]['data']) > 0) {
                $html .= "<td> " . implode("</td> <td> ", $matriz[$matricula][$bimestre]['data']) . "</td>";
            }
            $html .= "<td style='color:green;font-weight:bold;'>" . round($matriz[$matricula][$bimestre]['Presen&ccedil;as']) . "</td>";
            $html .= "<td style='color:red;font-weight:bold;'>" . round($matriz[$matricula][$bimestre]['Faltas']) . "</td>";
            $html .= "</tr>";
            $i++;
        }
        $html .= "</table>";
    }
    $template->html = $html; // inserindo a tabela de presencas e faltas na view minhas_presencas
    // gerando o pdf
    //$html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
    //$html2pdf->WriteHTML($template->parse()); // todo o html gerado eh parametro para a funcao que gera o pdf
    //$html2pdf->Output('aluno_'.$matricula.'.pdf');
    // echo $template->parse();
    $template->show();
?>
