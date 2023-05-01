<?php
require_once "../../lib/conexao.php";
require_once "../../lib/Template.php";
use raelgc\view\Template;

$template = new Template("../../view/disciplinas/tela_alterar.html");

$query = "select * from disciplinas where id = $1";
// $result = pg_query($query);
$result = pg_query_params($conexao, $query, array($_GET['id'])) or die($query);

$registro = pg_fetch_array($result);
$template->id = $registro['id'];
$template->nome = $registro['nome'];
$template->email = $registro['email'];
$template->semestre = $registro['semestre'];
$template->horario_atendimento = $registro['horario_atendimento'];
$template->recuperacao_paralela = $registro['recuperacao_paralela'];
$template->horario_aulas_sincronas = $registro['horario_aulas_sincronas'];
$template->metodologia = $registro['metodologia'];
$template->avaliacao = $registro['avaliacao'];

for ($i = 0; $i <= 6; $i++) {
    $template->serie_semestre_curso_valor = $i;
    $template->serie_semestre_curso_rotulo = (($i == 0) ? "OPTATIVA" : $i);
    if (!is_null($registro['serie_semestre_curso'])) {
        $template->serie_semestre_curso_marcado =
            (($registro['serie_semestre_curso'] == $i) ? "selected" : "");
    } else {
        $template->serie_semestre_curso_marcado = "";
    }
    $template->block("serie_semestre_curso_bloco");
}

$template->ano = $registro['ano'];
// $template->codigo_ifrs = $registro['codigo_ifrs'];
$template->carga_horaria = $registro['carga_horaria'];
$template->creditos = $registro['creditos'];
$template->creditos_por_dia = $registro['creditos_por_dia'];
$template->ementa = $registro['ementa'];
// $template->ssh_wiki = $registro['ssh_wiki'];
$template->objetivos = $registro['objetivos'];
$template->programa = $registro['programa'];
$template->bibliografia = $registro['bibliografia'];
$template->id_curso = $registro['curso_id'];
$template->eh_semestral = (($registro['eh_semestral'] == 't') ? "<tr> <td> <input type='radio' name='eh_semestral' value='true' checked='checked'> Semestral </td>
		<td> <input type='radio' name='eh_semestral' value='false'> Anual </td> </tr> " : " <tr> <td> <input type='radio'' name='eh_semestral' value='true' > Semestral </td> <td>
		<input type='radio' name='eh_semestral' value='false' checked='checked'> Anual </td> </tr>");

$vetDiaSemana = array(0 => "Domingo", 1 => "Segunda", 2 => "Terça", 3 => "Quarta", 4 => "Quinta", 5 => "Sexta", 6 => "Sábado");

foreach ($vetDiaSemana as $chave => $valor) {
    $template->chave = $chave;
    $template->valor = $valor;
    $sql = "SELECT * FROM creditos WHERE disciplina_id = $1 and dia_semana = $2";
    // $result = pg_query($sql);
    $result = pg_query_params($conexao, $sql, array($_GET['id'], $chave)) or die($sql);

    if (pg_affected_rows($result) > 0) {
        $registro = pg_fetch_array($result);
        if ($registro['nr_creditos'] == 1) {
            $template->marcado0 = "";
            $template->marcado1 = "selected";
            $template->marcado2 = "";
            $template->marcado3 = "";
            $template->marcado4 = "";
            $template->marcado5 = "";
            $template->marcado6 = "";
            $template->marcado7 = "";
            $template->marcado8 = "";
        } else if ($registro['nr_creditos'] == 2) {
            $template->marcado0 = "";
            $template->marcado1 = "";
            $template->marcado2 = "selected";
            $template->marcado3 = "";
            $template->marcado4 = "";
            $template->marcado5 = "";
            $template->marcado6 = "";
            $template->marcado7 = "";
            $template->marcado8 = "";
        } else if ($registro['nr_creditos'] == 3) {
            $template->marcado0 = "";
            $template->marcado1 = "";
            $template->marcado2 = "";
            $template->marcado3 = "selected";
            $template->marcado4 = "";
            $template->marcado5 = "";
            $template->marcado6 = "";
            $template->marcado7 = "";
            $template->marcado8 = "";
        } else if ($registro['nr_creditos'] == 4) {
            $template->marcado0 = "";
            $template->marcado1 = "";
            $template->marcado2 = "";
            $template->marcado3 = "";
            $template->marcado4 = "selected";
            $template->marcado5 = "";
            $template->marcado6 = "";
            $template->marcado7 = "";
            $template->marcado8 = "";
        } else if ($registro['nr_creditos'] == 5) {
            $template->marcado0 = "";
            $template->marcado1 = "";
            $template->marcado2 = "";
            $template->marcado3 = "";
            $template->marcado4 = "";
            $template->marcado5 = "selected";
            $template->marcado6 = "";
            $template->marcado7 = "";
            $template->marcado8 = "";
        } else if ($registro['nr_creditos'] == 6) {
            $template->marcado0 = "";
            $template->marcado1 = "";
            $template->marcado2 = "";
            $template->marcado3 = "";
            $template->marcado4 = "";
            $template->marcado5 = "";
            $template->marcado6 = "selected";
            $template->marcado7 = "";
            $template->marcado8 = "";

        } else if ($registro['nr_creditos'] == 7) {
            $template->marcado0 = "";
            $template->marcado1 = "";
            $template->marcado2 = "";
            $template->marcado3 = "";
            $template->marcado4 = "";
            $template->marcado5 = "";
            $template->marcado6 = "";
            $template->marcado7 = "selected";
            $template->marcado8 = "";
        } else if ($registro['nr_creditos'] == 8) {
            $template->marcado0 = "";
            $template->marcado1 = "";
            $template->marcado2 = "";
            $template->marcado3 = "";
            $template->marcado4 = "";
            $template->marcado5 = "";
            $template->marcado6 = "";
            $template->marcado7 = "";
            $template->marcado8 = "selected";
        }
    } else {
        $template->marcado1 = "";
        $template->marcado2 = "";
        $template->marcado3 = "";
        $template->marcado4 = "";
        $template->marcado5 = "";
        $template->marcado6 = "";
        $template->marcado7 = "";
        $template->marcado8 = "";
    }
    $template->block("diaSemana");
}

$template->show();

?>