<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	// ob_start();
	
	$template = new Template("../../view/disciplinas/ver_relatorio2.html");
	
	
	$query = "select ano, semestre, cursos.nome as curso, disciplinas.nome as disciplina from disciplinas inner join cursos on(cursos.id = disciplinas.curso_id) where disciplinas.id=".$_GET['id_disciplina'];
	$result = pg_query($query);
	$registro = pg_fetch_array($result);	
	$disciplina = utf8_decode($registro['disciplina']);
	$template->disciplina = utf8_decode($disciplina);
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	$template->curso = utf8_decode($registro['curso']);
	
	
	/*
	while ($registro = pg_fetch_array($result)){			
		
		$template->id_avaliacao = $registro['id'];
		$template->titulo_avaliacao = utf8_decode($registro['titulo']);
		$template->bimestre = $registro['bimestre'];
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
	}*/	
	
	$query = "select * from disciplinas where id=".$_GET['id_disciplina'];	
	$result = pg_query($query);	
	$registro = pg_fetch_array($result);
	/*
	$template->id_disciplina = $registro['id'];
	$template->nome_disciplina = utf8_decode($registro['nome']);
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	$template->creditos = $registro['creditos'];*/
	$creditos = (($registro['creditos'] > 0)? $registro['creditos']: 1);
	//$template->creditos_por_dia = $registro['creditos_por_dia'];	
	$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	//$template->eh_semestral = ($registro['eh_semestral'] ?  'Semestral': 'Anual');
	$total = (($registro['eh_semestral'] == true) ? 2 : 4);
	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->block("rotulo_presencas");	
	}
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->block("rotulo_notas");	
	}		
	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {			
		$query = "select distinct data from presencas 
					where disciplina_id = ".$_GET['id_disciplina']." and bimestre = ".$bimestre;
		$result = pg_query($query);
		$aulas[$bimestre] = pg_affected_rows($result);	
		//$template->aulas = pg_affected_rows($result)*$creditos_por_dia;
		//$template->bimestre = $bimestre;
		//$template->block("aulasDadas");	
	} 		
	
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
			
		for ($bimestre = 1; $bimestre <= $total; $bimestre++) {						
			$sql = "select count(*) as presencas from presencas 
				where 
					aluno_id = ".$registro['id']." and 
					disciplina_id = ".$_GET['id_disciplina']." and resultado = 1 and bimestre = ".$bimestre;
			$resultadoX =  pg_query($sql);
			$x = pg_fetch_array($resultadoX);
			
			$template->bimestre = $bimestre;
			$template->presencas = round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					
			$porcentagem = ($x['presencas']*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);
			
			$template->porcentagem = number_format($porcentagem, 2, '.', '');
			$template->alerta = (($porcentagem < 75)? "red" : "green");
						
			$sql = "select count(*) as faltas from presencas 
				where aluno_id = ".$registro['id']." and disciplina_id = ".$_GET['id_disciplina']." and resultado = 0 and bimestre = ".$bimestre;
			$resultadoX =  pg_query($sql);
			$x = pg_fetch_array($resultadoX);			
			$template->faltas = round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
			
			$template->block("bloco_presenca");
			
			$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre = ".$bimestre; 
			$resultadoX =  pg_query($sql) or die($sql);
			$x = pg_fetch_array($resultadoX);
			
	//		$template->bimestre = $bimestre;
			$template->nota = (($x['nota'] > 0) ? $x['nota'] : 0);			
			
			$template->block("bloco_nota");
			 
		}	
		$i++;
		$template->block("alunos");						
	}

	// $html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
    // $html2pdf->WriteHTML($template->parse());
    // $html2pdf->Output('relatorio_'.$disciplina.'.pdf');		
	$template->show();
?>