<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	// ob_start();
	
	$template = new Template("../../view/disciplinas/ver_relatorio_alunos.html");
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
	$query = "select * from disciplinas where id = $1";	
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$registro = pg_fetch_array($result);
	
//	$template->id_disciplina = $registro['id'];
	$template->nome_disciplina = $registro['nome'];
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	//$template->creditos = $registro['creditos'];
	$creditos = (($registro['creditos'] > 0)? $registro['creditos']: 1);
	//$template->creditos_por_dia = $registro['creditos_por_dia'];	
	$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	$total = (($registro['eh_semestral'] == 't') ? 2 : 4);
	/*
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->block("rotulo_presencas");	
	}*/
	for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->bimestre_nome = (($bimestre > 0) ? $bimestre." Bim" : "Exame");
		$template->block("rotulo_notas");	
	}					
	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {			
		$query = "select distinct data from presencas 
					where disciplina_id = $1 and bimestre = $2";
		// $result = pg_query($query);
		$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'], $bimestre)) or die ($query);

		$aulas[$bimestre] = pg_affected_rows($result);	
		//$template->aulas = pg_affected_rows($result)*$creditos_por_dia;
		//$template->aulas = "";
		//$template->bimestre = $bimestre;
		//$template->block("aulasDadas");	
	}
	$query = "select max(bimestre) as bimestre from presencas 
					where disciplina_id = $1";
		// $result = pg_query($query);
		$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

		$max_bimestre =  pg_fetch_array($result);
		//$template->max_bimestre = (($max_bimestre['bimestre'] > 0) ? $max_bimestre['bimestre'] : 1) ;		
	 		
	
	$query = "select alunos.id, alunos.nome, alunos.matricula from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id = $1 order by alunos.matricula";
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$i = 1;	
	while ($registro = pg_fetch_array($result)){
		//$template->id = $registro['id'];
		$nome  = explode(" ",trim(strtoupper($registro['nome'])));
		//$template->nome = $nome[0]." ".$nome[count($nome)-1];
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
						aluno_id = $1 and 
						disciplina_id = $2 and resultado = 1 and bimestre = $3";
				// $resultadoX =  pg_query($sql);
				$resultadoX = pg_query_params($conexao, $sql, array($registro['id'], $_GET['id_disciplina'], $bimestre)) or die ($sql);

				$x = pg_fetch_array($resultadoX);
				
				$template->bimestre = $bimestre;
				//$template->bimestre_nome = $bimestre;
				//$template->bimestre_nome = (($bimestre > 0) ? $bimestre : "Exame");
				//$template->presencas = (($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia;
				$porcentagem = ($x['presencas']*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);
				//$template->porcentagem = number_format($porcentagem, 0, '.', '');
				//$template->alerta = (($porcentagem < 75)? "red" : "green");
										
				//$sql = "select count(*) as faltas from presencas where aluno_id = ".$registro['id']." and disciplina_id = ".$_GET['id_disciplina']." and resultado = 0 and bimestre = ".$bimestre;
				//$resultadoX =  pg_query($sql);
				//$x = pg_fetch_array($resultadoX);			
				//$template->faltas = (($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia;
				
				//$template->block("bloco_presenca");
			} 
		
			// bloco de notas - com exame
			$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = $1 and bimestre = $2"; 
			// $resultadoX =  pg_query($sql) or die($sql);
			$resultadoX = pg_query_params($conexao, $sql, array($registro['id'], $bimestre)) or die ($sql);

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
			/*	
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
		}*/
		
		$i++;
		$template->block("alunos");						
	}
	// $html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
 //    $html2pdf->WriteHTML($template->parse());
 //    $html2pdf->Output('notas.pdf');		

	$html = $template->parse();

	 $query = "select distinct(titulo), avaliacoes.id, avaliacoes.bimestre, avaliacoes.data_hora, valor from avaliacoes inner join disciplinas on (disciplinas.id = avaliacoes.disciplina_id) 
     	inner join notas on (avaliacoes.id = notas.avaliacao_id)
     	where disciplinas.id = $1 order by avaliacoes.bimestre desc, avaliacoes.data_hora desc";
    // $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);


	if (pg_affected_rows($result) > 0){
		$html.= "<br>";
    	$html.= "<h3> Trabalhos Avaliados (computados até o momento) </h3>";
    	$html.= "<ul>";
		while($registro = pg_fetch_array($result)){

			$sql = "select (select count(*) as t from notas 
			where avaliacao_id = $1 and comentario = '<br>' and obtido = 0),
			(select count(*) as v from notas where avaliacao_id = $2)";
			// $x = pg_query($sql);
			$x = pg_query_params($conexao, $sql, array($registro['id'],  $registro['id'])) or die ($sql);

			$linhas = pg_fetch_array($x);
            if ($linhas['t'] != $linhas['v']) {
                $html.= "<li> ".(($registro['bimestre'] != 0) ? $registro['bimestre']."º bim. - " : "").$registro['titulo']." (".$registro['valor'].")</li>";
            }
		}		
		$html.= "</ul>";
	}
	echo $html;
?>