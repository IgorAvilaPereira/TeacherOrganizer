<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	require_once "../../lib/html2pdf/html2pdf.class.php";
	ob_start();
	
	$template = new Template("../../view/disciplinas/ver_relatorio.html");
/**
 
	
	$query = "select * from avaliacoes where disciplina_id=".$_GET['id_disciplina']." order by id";
	$result = pg_query($query);	

	while ($registro = pg_fetch_array($result)){			
		$template->id_avaliacao = $registro['id'];
		$template->titulo_avaliacao = utf8_decode($registro['titulo']);
		$template->bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre'] : "Exame" );
		$template->valor_avaliacao = $registro['valor'];
		
		$sql = "select * from notas where avaliacao_id=".$registro['id'];
		$x = pg_query($sql);
		$linhas = pg_affected_rows($x);
		if ($linhas == 0){
			$template->corrigir = "red";
			$template->pendente = "pendente";
		} else {
			$template->corrigir = "green";
			$template->pendente = "corrigido";
		}		
		$template->block("avaliacoes");
	}	
 */	
	$query = "select * from disciplinas where id=".$_GET['id_disciplina'];	
	$result = pg_query($query);	
	$registro = pg_fetch_array($result);
	
//	$template->id_disciplina = $registro['id'];
	$template->nome_disciplina = utf8_decode($registro['nome']);
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	$template->creditos = $registro['creditos'];
	$creditos = (($registro['creditos'] > 0)? $registro['creditos']: 1);
	$template->creditos_por_dia = $registro['creditos_por_dia'];	
	$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	$total = (($registro['eh_semestral'] == 't') ? 2 : 4);
	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->block("rotulo_presencas");	
	}
	for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->bimestre_nome = (($bimestre > 0) ? $bimestre." Bim" : "Exame");
		$template->block("rotulo_notas");	
	}					
	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {			
		$query = "select distinct data from presencas 
					where disciplina_id = ".$_GET['id_disciplina']." and bimestre = ".$bimestre;
		$result = pg_query($query);
		$aulas[$bimestre] = pg_affected_rows($result);	
		$template->aulas = round(pg_affected_rows($result)*$creditos_por_dia);
		$template->bimestre = $bimestre;
		$template->block("aulasDadas");	
	}
	$query = "select max(bimestre) as bimestre from presencas 
					where disciplina_id = ".$_GET['id_disciplina'];
		$result = pg_query($query);
		$max_bimestre =  pg_fetch_array($result);
		//$template->max_bimestre = (($max_bimestre['bimestre'] > 0) ? $max_bimestre['bimestre'] : 1) ;		
	 		
	
	$query = "select alunos.id, alunos.nome, alunos.matricula from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id=".$_GET['id_disciplina']." order by matricula";
	$result = pg_query($query);	
	$i = 1;	
	while ($registro = pg_fetch_array($result)){
		//$template->id = $registro['id'];
		$nome  = explode(" ",trim(strtoupper(utf8_decode($registro['nome']))));
		$template->nome = $nome[0]." ".$nome[count($nome)-1];
		$template->matricula = trim($registro['matricula']);
		if ($i % 2 == 0) {
			$template->cor = "aliceblue";
		}	else {
			$template->cor = "white";
		}			
		for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
				if ($bimestre > 0) { 						
				$sql = "select count(*) as presencas from presencas 
					where 
						aluno_id = ".$registro['id']." and 
						disciplina_id = ".$_GET['id_disciplina']." and resultado = 1 and bimestre = ".$bimestre;
				$resultadoX =  pg_query($sql);
				$x = pg_fetch_array($resultadoX);
				
				$template->bimestre = $bimestre;
				//$template->bimestre_nome = $bimestre;
				//$template->bimestre_nome = (($bimestre > 0) ? $bimestre : "Exame");
				$template->presencas = round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
				$porcentagem = ($x['presencas']*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);
				$template->porcentagem = number_format($porcentagem, 0, '.', '');
				$template->alerta = (($porcentagem < 75)? "red" : "green");
										
				$sql = "select count(*) as faltas from presencas 
					where aluno_id = ".$registro['id']." and disciplina_id = ".$_GET['id_disciplina']." and resultado = 0 and bimestre = ".$bimestre;
				$resultadoX =  pg_query($sql);
				$x = pg_fetch_array($resultadoX);			
				$template->faltas = round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
				
				$template->block("bloco_presenca");
			} 
		
			// bloco de notas - com exame
			$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre = ".$bimestre; 
			$resultadoX =  pg_query($sql) or die($sql);
			$x = pg_fetch_array($resultadoX);

			$template->bimestre = (($bimestre > 0) ? $bimestre : "Exame");
			if ($x['nota'] > 0) {
				$template->nota = $x['nota'];
			} else if ($bimestre == 0){
				$template->nota = "-";
			}	else {
				$template->nota = 0;
			}						
			
			$template->block("bloco_nota");			 
		}	
				
		// situacao - aprovado ou reprovado??
		$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre > 0"; 
		$resultadoX =  pg_query($sql) or die($sql);
		$x = pg_fetch_array($resultadoX);
		if ($x['nota'] >= 28 && strcmp($eh_semestral, 'Anual') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre >= 0"; 
			$resultadoz =  pg_query($sqlz) or die($sqlz);
			$z = pg_fetch_array($resultadoz);
			if ($z['nota']/5 >= 5){
				$template->situacao = (($porcentagem >= 75) ? "Aprovado" : "Reprovado por frequencia");	
			} else {
				$template->situacao = "Reprovado";	
			}			
		} else if ($x['nota'] >= 14 && strcmp($eh_semestral, 'Semestral') == 0){
			$template->situacao = "Aprovado";
		} else if (strcmp($eh_semestral, 'Semestral') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre >= 0"; 
			$resultadoz =  pg_query($sqlz) or die($sqlz);
			$z = pg_fetch_array($resultadoz);
			if ($z['nota']/3 >= 5){
				$template->situacao = (($porcentagem >= 75) ? "Aprovado" : "Reprovado por frequencia");	
			} else {
				$template->situacao = "Reprovado";	
			}	
		} else {
			$template->situacao = "Reprovado";
		}

		$i++;
		$template->block("alunos");						
	}
	$html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
    $html2pdf->WriteHTML($template->parse());
    $html2pdf->Output('notas.pdf');		
	//$template->show();
?>