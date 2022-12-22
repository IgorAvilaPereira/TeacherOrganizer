<?php
    require_once "../../lib/conexao.php";
    require_once "../../lib/Template.php";
    use raelgc\view\Template;
    // require_once "../../lib/html2pdf/html2pdf.class.php";

    $template = new Template("../../view/questoes/gerar_prova.html");
    $template->bimestre = ((empty($_POST['bimestre']) or !isset($_POST['bimestre'])) ? 1 : $_POST['bimestre']);
    $template->disciplina = $_POST['disciplina'];
    $template->valor = ((empty($_POST['valor']) or !isset($_POST['valor'])) ? 10 : $_POST['valor']);

    $vetQuestao = [];
    if (isset($_POST['vetTag'])) {
        /*if (count($_POST['vetTag']) > 0) {*/
        $sql = "select questao from questoes inner join questoes_tags on (questoes.id = questoes_tags.questao_id) WHERE 
					questao is not null and questao != '<br>' and questoes_tags.tag_id in(".implode(",", $_POST['vetTag']).") order by random() limit ".((empty($_POST['qtde']) or !isset($_POST['qtde'])) ? 10 : $_POST['qtde']*2);
					// $result = pg_query($sql) or die($sql);
                    $result = pg_query_params($conexao, $sql, array()) or die ($sql);

					// $vetQuestao[] = pg_fetch_all($result);
					// array_push($vetQuestao,pg_fetch_all($result));
					while ($registro = pg_fetch_array($result)) {
						if (strlen($registro['questao']) > 5) {
							$vetQuestao[] = nl2br($registro['questao']);
						}
					}
    } /*else {
        $sql = "select questao from questoes inner join questoes_tags on (questoes.id = questoes_tags.questao_id)
		where questao is not null and questao != '<br>' order by random() limit ".((empty($_POST['qtde']) or !isset($_POST['qtde'])) ? 10 : $_POST['qtde']*2);
    }*/
   
    if (isset($_POST['vetDisciplina'])) {
        // $result = pg_query("select descricao as questao from avaliacoes where descricao is not null and descricao != '<br>' and disciplina_id in(".implode(",", $_POST['vetDisciplina']).") order by random() limit ".((empty($_POST['qtde']) or !isset($_POST['qtde'])) ? 10 : $_POST['qtde']*2)) or die($sql);
        $result = pg_query_params($conexao, "select descricao as questao from avaliacoes where descricao is not null and descricao != '<br>' and disciplina_id in(".implode(",", $_POST['vetDisciplina']).") order by random() limit ".((empty($_POST['qtde']) or !isset($_POST['qtde'])) ? 10 : $_POST['qtde']*2), array()) or die ("select descricao as questao from avaliacoes where descricao is not null and descricao != '<br>' and disciplina_id in(".implode(",", $_POST['vetDisciplina']).") order by random() limit ".((empty($_POST['qtde']) or !isset($_POST['qtde'])) ? 10 : $_POST['qtde']*2));

        // $vetQuestao[] = pg_fetch_all($result);
        // array_push($vetQuestao, pg_fetch_all($result));
        while ($registro = pg_fetch_array($result)) {
            if (strlen($registro['questao']) > 5) {
                $vetQuestao[] = nl2br($registro['questao']);
            }
        }
    }
    shuffle($vetQuestao);    
    // $output = array_slice($vetQuestao, 0, $qtde);      
    if (count($vetQuestao) > 0) {		
		$qtde = ((empty($_POST['qtde']) or !isset($_POST['qtde'])) ? 10 : $_POST['qtde']);
		$qtde = ((count($vetQuestao) < $qtde) ? count($vetQuestao) : $qtde);
        for ($i = 0; $i < $qtde; $i++) {
            $template->questao = $vetQuestao[$i];
            $template->block("questoes");
        }
    }
    $template->show();

    // gerando o pdf
    //$html2pdf = new HTML2PDF('P','A4','pt', false, 'ISO-8859-15', 2);
    //$html2pdf->WriteHTML($template->parse());
    //$html2pdf->Output('prova.pdf');
?>

