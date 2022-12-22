<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	// ob_start();
	
	$template = new Template("../../view/avaliacoes/corrigir_relatorio.html");
	
	$query = "select * from avaliacoes where id=".$_GET['id_avaliacao'];
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$registro = pg_fetch_array($result);
		//$template->id_avaliacao = $registro['id'];
		$template->titulo_avaliacao = utf8_decode($registro['titulo']);
		$template->descricao_avaliacao = utf8_decode(nl2br($registro['descricao']));
		$template->valor_avaliacao = $registro['valor'];
		$template->bimestre =  (($registro['bimestre'] > 0) ? $registro['bimestre'].' Bimestre' : 'Exame'); 
		//$template->block("avaliacoes");
	//}	
	
	$query = "select disciplinas.id, disciplinas.nome, disciplinas.ano, disciplinas.semestre, disciplinas.eh_semestral from disciplinas inner join avaliacoes on (disciplinas.id = avaliacoes.disciplina_id) where avaliacoes.id =".$_GET['id_avaliacao'];	
	// $result = pg_query($query) or die ($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$registro = pg_fetch_array($result);
	//$template->id_disciplina = $registro['id'];
	$template->nome_disciplina = utf8_decode($registro['nome']);
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	
	
	//$query = "select distinct data from presencas where disciplina_id = ".$_GET['id'];
	//$result = pg_query($query);	
	//$aulas = pg_affected_rows($result);
	//$template->aulas = pg_affected_rows($result);
	$eh_semestral = false;
	if ($template->bimestre > 0) {
		$query = "select alunos.id, alunos.nome, alunos.matricula from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id = ".$registro['id'];
	} else {		
		if ($registro['eh_semestral'] == true) {
			$eh_semestral = true;
			$query = "select alunos.id, alunos.matricula, alunos.nome, sum(obtido) from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id)
inner join disciplinas on (disciplinas.id = avaliacoes.disciplina_id) inner join alunos on  (notas.aluno_id = alunos.id)
where disciplinas.id = ".$registro['id']." group by alunos.id, alunos.matricula, alunos.nome
having sum(obtido) < 14 order by alunos.id;"; 
		} else {
			$query = "select alunos.id, alunos.matricula, alunos.nome, sum(obtido) from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id)
inner join disciplinas on (disciplinas.id = avaliacoes.disciplina_id) inner join alunos on  (notas.aluno_id = alunos.id)
where disciplinas.id = ".$registro['id']." group by alunos.id, alunos.matricula, alunos.nome
having sum(obtido) < 28 order by alunos.id"; 
		}	
	}
	// $result = pg_query($query) or die($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	while ($registro = pg_fetch_array($result)){
		//$template->id = $registro['id'];
		$template->nome = utf8_decode($registro['nome']);
		$template->matricula = $registro['matricula'];
		
		$sql = "select obtido from notas where aluno_id = ".$registro['id']." and avaliacao_id = ".$_GET['id_avaliacao'];
		// $resultadoX =  pg_query($sql);
		$resultadoX = pg_query_params($conexao, $sql, array()) or die ($sql);
		$x = pg_fetch_array($resultadoX);
		$template->obtido = (($x['obtido'] > 0) ? $x['obtido'] : 0);
		
		// se for exame
		if ($template->bimestre == 0 ){
			$sqly = "select sum(obtido) as soma from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre > 0 ";
		//	die ($sqly);			
			// $resultadoy =  pg_query($sqly);
			$resultadoy = pg_query_params($conexao, $sqly, array()) or die ($sqly);
			$y = pg_fetch_array($resultadoy);		
			if ($eh_semestral == true) {
				$template->precisa = ((((25-((float)$y['soma'])*1.5)/2) > 10) ? "Reprovado" :  "Precisa de:".((25-((float)$y['soma'])*1.5)/2));
			} else {
				$template->precisa = "??";
			}			
			$template->mostra = true;
						
		} else {
			$template->precisa = "-";
			$template->mostra = "none";
		}
				
		$template->block("alunos");						
	}		
	$template->show();
	// $html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
    // $html2pdf->WriteHTML($template->parse()); // todo o html gerado eh parametro para a funcao que gera o pdf
    // $html2pdf->Output('avaliacao_correcao.pdf');
?>