<?php
require_once "../../lib/conexao.php";
// require_once "../../lib/Template.php";
// use raelgc\view\Template;
// require_once "../../lib/html2pdf/html2pdf.class.php";
// ob_start();

// $template = new Template("../../view/avaliacoes/tela_corrigir_relatorio_publicar.html");

$query = "select cursos.nome from cursos inner join disciplinas on (cursos.id = disciplinas.curso_id) inner join avaliacoes on(disciplinas.id = avaliacoes.disciplina_id) where avaliacoes.id = $1";
// $result = pg_query($query);
$result = pg_query_params($conexao, $query, array($_GET['id_avaliacao'])) or die ($query);
$registro = pg_fetch_array($result);
// $template->curso = $registro['nome'];

$query = "select * from avaliacoes where id = $1";
// $result = pg_query($query);
$result = pg_query_params($conexao, $query, array($_GET['id_avaliacao'])) or die ($query);
// pg_set_client_encoding($conexao, "iso-8859-1");
$registro = pg_fetch_array($result);
// $template -> titulo_avaliacao = $registro['titulo'];
//$template -> descricao_avaliacao = utf8_decode(nl2br($registro['descricao']));
// $template -> valor_avaliacao = $registro['valor'];
// $template -> bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre'] /*. ' Bimestre'*/ : 'Exame');
$bimestre = $registro['bimestre'];


$query = "select disciplinas.id, disciplinas.nome, disciplinas.ano, disciplinas.semestre, disciplinas.eh_semestral from disciplinas inner join avaliacoes on (disciplinas.id = avaliacoes.disciplina_id) where avaliacoes.id = $1";
// $result = pg_query($query) or die($query);
$result = pg_query_params($conexao, $query, array($_GET['id_avaliacao'])) or die ($query);
$registro = pg_fetch_array($result);
// $template -> nome_disciplina = $registro['nome'];
// $template -> ano = $registro['ano'];
// $template -> semestre = $registro['semestre'];
if ($registro['eh_semestral'] === true  || $registro['eh_semestral'] == 't') {
	$eh_semestral = true;
} else {
	$eh_semestral = false;

}

$query = "select alunos.id, alunos.nome, alunos.matricula from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id = $1 ORDER BY matricula";
// $result = pg_query($query) or die($query);
$result = pg_query_params($conexao, $query, array($registro['id'])) or die ($query);
$csv = "";
while ($registro = pg_fetch_array($result)) {
	$csv.= $registro['matricula'].";";
	$sql = "select obtido, comentario from notas where aluno_id = $1 and avaliacao_id = $2";
	// $resultadoX = pg_query($sql);
	$resultadoX = pg_query_params($conexao, $sql, array($registro['id'],  $_GET['id_avaliacao'])) or die ($sql);
	if (pg_affected_rows($resultadoX) > 0) {
		$x = pg_fetch_array($resultadoX);
		$csv.= (($x['obtido'] > 0) ? $x['obtido'] : "0").";";
		$csv.= utf8_encode(utf8_decode((nl2br(trim(strip_tags($x['comentario'])))))).";<br>";
	} else {
		$csv.=  "0;";
		$csv.= "-;<br>";
	}
	// se for exame
	if ($bimestre == 0) {
		$sqly = "select sum(obtido) as soma from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = $1 and bimestre > 0 ";
		// $resultadoy = pg_query($sqly);
		$resultadoy = pg_query_params($conexao, $sqly, array($registro['id'])) or die ($sqly);
		$y = pg_fetch_array($resultadoy);
		$soma = $y['soma'];
		if ($eh_semestral !== false) {
			if ($soma > 0) {
				if ($soma >= 14) {
					//$template -> precisa = "Aprovado";
				} else {
					$precisa = ((25 - ((float)$y['soma']) * 1.5) / 2);
					if ($precisa > 10) {
						//$template -> precisa = "Reprovado";
					} else {
						if ($x['obtido'] >= $precisa) { 
							//$template -> precisa = "Aprovado";
						} else if ($x['obtido'] > 0){
							//$template -> precisa = "Reprovado";
						} else {
							//$template -> precisa = "Exame ($precisa)";
						}
					}
				}
			} else {
				//$template -> precisa = "Aprovado";
			}
		} else {
			if ($soma > 0) {
				if ($soma > 0) {
					if ($soma >= 28) {
					//	$template -> precisa = "Aprovado";
					} else {
						$precisa = ((25 - ((float)$y['soma']) * 1.5) / 4);
						if ($precisa > 10) {
						//	$template -> precisa = "Reprovado";
						} else {
							if ($x['obtido'] >= $precisa) { 
								//$template -> precisa = "Aprovado";
							} else {
								//$template -> precisa = "Exame ($precisa)";
							}
						}
					}
				} else {
					//$template -> precisa = "";
				}
			} else {
				//$template -> precisa = "";
			}
		}
		//$template -> block("alunos_exame");
	} else {
		//$template -> precisa = "-";
	}
	// $template -> block("alunos");
}

//if ($bimestre == 0) {
	//$template -> block("alunos_exame_label");
//}
//$html2pdf = new HTML2PDF('L', 'A4', 'pt', false, 'ISO-8859-15', 2);
//$html2pdf -> WriteHTML($template -> parse());
// todo o html gerado eh parametro para a funcao que gera o pdf
//$html2pdf -> Output('correcao.pdf');
// echo $template -> parse();
// $template->show();
echo $csv;
?>