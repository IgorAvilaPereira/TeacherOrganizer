<?php
require_once "../../lib/conexao.php";
// require_once "../../lib/html2pdf/html2pdf.class.php";

// informacoes basicas da disciplina
$query = "select disciplinas.nome, ano, semestre, eh_semestral, cursos.nome as n, creditos, creditos_por_dia from disciplinas inner join cursos on (cursos.id = disciplinas.curso_id) where disciplinas.id = $1";
// $result = pg_query($query);
$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

$registro = pg_fetch_array($result);
$disciplina = utf8_decode($registro['nome']);
$ano = $registro['ano'];
$semestre = $registro['semestre'];
$eh_semestral = (($registro['eh_semestral'] == 't') ? true : false);
$total = (($eh_semestral == true) ? 2 : 4);
$curso = utf8_decode($registro['n']);
$creditos = (($registro['creditos'] > 0) ? $registro['creditos'] : 1);
$creditos_por_dia = $registro['creditos_por_dia'];

// datas das aulas
$query = "select distinct data, bimestre from presencas where disciplina_id = $1 order by bimestre, data;";
// $result = pg_query($query);
$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

$vetData = array();
while ($registro = pg_fetch_array($result)) {
    $data = explode("-", $registro['data']);
    $vetData[$registro['bimestre']][] = $data[2] . "/" . $data[1];
}

// total de aula por bimestre
$aulas = array();
for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
    $sql = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = $1";
    // $resultado = pg_query($sql);
    $resultado = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);

    if (pg_affected_rows($resultado) > 0) {
        $sql = "select distinct data, creditos from presencas
					where
					aluno_id in (select id from alunos where disciplina_id = $1 limit 1) and
					disciplina_id = $2 and bimestre = $3";
        // $resultado = pg_query($sql);
        $resultado = pg_query_params($conexao, $sql, array($_GET['id_disciplina'], $_GET['id_disciplina'], $bimestre)) or die ($sql);

        $aulasX = 0;
        while ($x = pg_fetch_array($resultado)) {
            $aulasX += $x['creditos'];
        }
        $aulas[$bimestre] = $aulasX;
    } else {
        $query = "select distinct data from presencas
				where disciplina_id = $1 and bimestre = $2";
        // $result = pg_query($query);
        $result = pg_query_params($conexao, $query, array($_GET['id_disciplina'],  $bimestre)) or die ($query);

        $aulas[$bimestre] = round(pg_affected_rows($result) * $creditos_por_dia); //pg_affected_rows($result);
    }
}


$sql = "select * from alunos where disciplina_id = $1 order by matricula";
// $result = pg_query($sql);
$result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);

while ($registro = pg_fetch_array($result)) {
    $nome = explode(" ", $registro['nome']);
    $matriz[$registro['matricula']]['Nome'] = $nome[0];
    $matricula = $registro['matricula'];
    
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
		$sql2 = "select * from presencas where aluno_id = $1 and bimestre = $2 order by data";
        // $result2 = pg_query($sql2);
        $result2 = pg_query_params($conexao, $sql2, array($registro['id'], $bimestre)) or die ($sql2);

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
			where aluno_id = $1 and disciplina_id = $2 and resultado = 1 and bimestre = $3" ;
        // $resultadoPresenca = pg_query($sqlPresenca);
        $resultadoPresenca = pg_query_params($conexao, $sqlPresenca, array($registro['id'], $_GET['id_disciplina'], $bimestre)) or die ($sqlPresenca);

        $presencas = 0;
        $faltas = 0;
        while ($xPresenca = pg_fetch_array($resultadoPresenca)) {
            $presencas += $xPresenca['creditos'];
        }

        $matriz[$registro['matricula']][$bimestre]['Presen&ccedil;as'] = round((($presencas > 0) ? $presencas : 0));
        $matriz[$registro['matricula']][$bimestre]['Faltas'] = $aulas[$bimestre] - $presencas;
    }
}


$html = "<html> <head> <title> " . utf8_encode($disciplina) . " - Tabela Frequ&ecirc;ncia </title> </head> <body>";
$html .= "<img src='../../imagens/logo.jpg'>";
// $html .= "<h1>[" . $curso . "] " . utf8_encode($disciplina) . " - ";
$html .= "<h1>". utf8_encode($disciplina) . " - ";
$html .= (($eh_semestral == true) ? $ano . "/" . $semestre : $ano) . "</h1>";
$html .= "<b>Atualiza&ccedil;&atilde;o:</b> " . date("d/m/Y - H:i:s") . "<br><br>";
/*if ($creditos_por_dia > 0) {
    $html .= "Total de Cr&eacute;ditos: " . $creditos . "<br><br>";
    $html .= "Cr&eacute;ditos por Aula/Encontro: " . $creditos_por_dia . "<br>";
} */
//else {
    $dia = array('Domingo', 'Segunda', 'Ter&ccedil;a', 'Quarta', 'Quinta', 'Sexta', 'S&aacute;bado');
    $queryCreditosPorDia = "select * from creditos where disciplina_id = $1";
    // $resultCreditosPorDia = pg_query($queryCreditosPorDia);
    $resultCreditosPorDia = pg_query_params($conexao, $queryCreditosPorDia, array($_GET['id_disciplina'])) or die ($queryCreditosPorDia);

    $str = "<br>";
    $totalCreditos = 0;
    while ($registroCreditosPorDia = pg_fetch_array($resultCreditosPorDia)) {
        $str .= "* ".$dia[$registroCreditosPorDia['dia_semana']] . ":" . $registroCreditosPorDia['nr_creditos'] . "<br>";
        $totalCreditos += $registroCreditosPorDia['nr_creditos'];
    }
    $html .= "Total de Cr&eacute;ditos Por Semana: " . $totalCreditos . "<br><br>";
    $html .= "Cr&eacute;ditos por Aula/Encontro: " . $str . "<br>";
//}

if (isset($matriz)) {
    for ($bimestre = 1; $bimestre <= count($vetData); $bimestre++) {
        $i = 1;
        $html .= "<h3> " . $bimestre . "º Ciclo </h3>";
        $html .= "<table style='page-break-inside:auto;'>";
        $html .= "<tr style='background-color:aliceblue; font-weight: bold; page-break-inside: avoid;'>
					<td style='border: 1px black solid;'> Matr&iacute;cula </td>
					" . ((count(($vetData[$bimestre])) > 0/*&& (strlen($vetData[$bimestre][] > 0))*/) ? "<td style='border: 1px black solid;'> " . implode("</td> <td style='border: 1px black solid;'> ", $vetData[$bimestre]) . "</td>" : "");
	    $html .= "<td style='border: 1px black solid;'> Presen&ccedil;as </td> <td style='border: 1px black solid;'> Faltas </td> ";
        $html .= "</tr>";
        foreach ($matriz as $matricula => $vetor) {
            $html .= (($i % 2 == 0) ? "<tr style='background-color:aliceblue; page-break-inside: avoid;'> <td style='border: 1px black solid;'> " . $matricula . "</td>" : "<tr style='page-break-inside: avoid;'> <td style='border: 1px black solid;'> " . $matricula . "</td>");
            if (count($matriz[$matricula][$bimestre]['data']) > 0) {
                $html .= "<td style='border: 1px black solid;'> " . implode("</td> <td style='border: 1px black solid;'> ", $matriz[$matricula][$bimestre]['data']) . "</td>";
            }
            $html .= "<td style='border: 1px black solid;'>" . round($matriz[$matricula][$bimestre]['Presen&ccedil;as']) . "</td>";
            $html .= "<td style='border: 1px black solid;'>" . round($matriz[$matricula][$bimestre]['Faltas']) . "</td>";
            $html .= "</tr>";
            $i++;
        }
        $html .= "</table> <br>";
    }
}

$html .= "<h2>Aulas Registradas (até o momento): </h2>";

for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
    $query = "select * from planos
            where disciplina_id = $1
            and bimestre = $2 order by data";
    // $result = pg_query($query);
    $result = pg_query_params($conexao, $query, array($_GET['id_disciplina'], $bimestre)) or die ($query);

    if (pg_affected_rows($result) > 0) {
        $html .= "<h3>" . $bimestre . "º Ciclo </h3>";
        while ($registro = pg_fetch_array($result)) {
            $data = explode("-", $registro['data']);
            $html .= "* " . $data[2] . "/" . $data[1] . "/" . $data[0] . " - " . trim($registro['texto']) . "<br><br>";
        }
    }
}
$html.="</body> </html>";
echo $html;
?>