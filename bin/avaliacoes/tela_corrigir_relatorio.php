<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	// ob_start();
	
	$template = new Template("../../view/avaliacoes/tela_corrigir_relatorio.html");
	

	$query = "select * from avaliacoes where disciplina_id = ".$_GET['id_disciplina']. " and id = " . $_GET['id_avaliacao'];
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	// pg_set_client_encoding($conexao, "iso-8859-1");

	if (pg_affected_rows($result) == 0) die('<h1>Sem disciplina com o id da requisicao</h1> <a href="javascript: onclick(history.go(-1))"> Voltar </a>');
	$cor =  array('AliceBlue', 'LightGray', 'PaleGreen', 'yellow', 'pink');	
	
	$registro = pg_fetch_array($result);			
		$template->id_avaliacao = $registro['id'];
		$template->titulo_avaliacao = $registro['titulo'];
		$template->bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre']." Bim." : "Exame" );
		$template->valor_avaliacao = $registro['valor'];
		
	
	$dia = array('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');	
	$query = "select * from disciplinas where id=".$_GET['id_disciplina'];	
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$registro = pg_fetch_array($result);	
	//$template->id_disciplina = $registro['id'];
	$template->nome_disciplina = $registro['nome'];
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	if (!empty($registro['creditos_por_dia'])){	
		$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	} else {		
	$queryCreditosPorDia = "select * from creditos where disciplina_id=".$_GET['id_disciplina'];	
	// $resultCreditosPorDia = pg_query($queryCreditosPorDia);
	$resultCreditosPorDia = pg_query_params($conexao, $queryCreditosPorDia, array()) or die ($queryCreditosPorDia);
		$str = "<br>";
		$totalCreditos = 0;
		while ($registroCreditosPorDia = pg_fetch_array($resultCreditosPorDia)){
			$str.= $dia[$registroCreditosPorDia['dia_semana']].":".$registroCreditosPorDia['nr_creditos']."<br>";
			$totalCreditos+=$registroCreditosPorDia['nr_creditos'];
		}
		//$template->creditos = $totalCreditos;	
		//$template->creditos_por_dia = $str;
	}
	$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	$total = (($registro['eh_semestral'] == 't') ? 2 : 4);
	
	// combo de creditos - disciplinas com varios creditos
	//$query = "SELECT * FROM creditos WHERE disciplina_id = ".$_GET['id_disciplina'];	
	//$result = pg_query($query);
	//if (pg_affected_rows($result)>0){		
		//while ($registro = pg_fetch_array($result)) {
		//	$template->nr = $registro['nr_creditos'];
		//	$template->block("blococreditos");	
		//}
	//}
		
	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {	
		$sql = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = ".$_GET['id_disciplina'];
		// $resultado  = pg_query($sql);
		$resultado = pg_query_params($conexao, $sql, array()) or die ($sql);
		if (pg_affected_rows($resultado) > 0){
			$sql = "select distinct data, creditos from presencas 
					where 
					aluno_id in (select id from alunos where disciplina_id = ".$_GET['id_disciplina']." limit 1) and 
					disciplina_id = ".$_GET['id_disciplina']." and bimestre = ".$bimestre;					
				// $resultado =  pg_query($sql);
				$resultado = pg_query_params($conexao, $sql, array()) or die ($sql);
				$aulasX = 0;
				while($x = pg_fetch_array($resultado)){						
						$aulasX+= $x['creditos'];
				}
			//$template->aulas = $aulasX;
			$aulas[$bimestre] = $aulasX;				
		} 
		else {
			$query = "select distinct data from presencas 
				where disciplina_id = ".$_GET['id_disciplina']." and bimestre = ".$bimestre;
			// $result = pg_query($query);
			$result = pg_query_params($conexao, $query, array()) or die ($query);
			//$template->aulas = round(pg_affected_rows($result)*$creditos_por_dia);
			$aulas[$bimestre] = pg_affected_rows($result);
		}
		//$template->bimestre = $bimestre;
		//$template->block("aulasDadas");	
	}
	
	$query = "select max(bimestre) as bimestre from presencas 
					where disciplina_id = ".$_GET['id_disciplina'];
		// $result = pg_query($query);
		$result = pg_query_params($conexao, $query, array()) or die ($query);
		$max_bimestre =  pg_fetch_array($result);
	 		
	
	$query = "select alunos.id, alunos.nome, alunos.matricula, alunos.observacao from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id=".$_GET['id_disciplina']." order by matricula";
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$i = 1;		
	while ($registro = pg_fetch_array($result)){
		//$template->id = $registro['id'];
		$nome  = explode(" ",trim(strtoupper($registro['nome'])));
		if (count($nome)>1){
			$template->nome = $nome[0]." ".$nome[count($nome)-1];
		} else {
			$template->nome = utf8_decode($registro['nome']);
		}	
		$template->matricula = trim($registro['matricula']);
			
		$presencas = 0;
		$faltas = 0;		
		$totalPresenca = 0;
		$totalFaltas = 0;
		// notas e presencas por bimestre	
		for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
				if ($bimestre > 0) { 						
				$sql = "select count(*) as presencas from presencas 
					where 
						aluno_id = ".$registro['id']." and 
						disciplina_id = ".$_GET['id_disciplina']." and resultado = 1 and bimestre = ".$bimestre;
				// $resultadoX =  pg_query($sql);
				$resultadoX = pg_query_params($conexao, $sql, array()) or die ($sql);
				$x = pg_fetch_array($resultadoX);
				
				//$template->bimestre = $bimestre;
				//$template->bimestre_nome = $bimestre;
				//$template->bimestre_nome = (($bimestre > 0) ? $bimestre : "Exame");
				
				// DISCIPLINAS QUE POSSUEM CREDITOS DIFERENTES....				
				$sqlCreditos = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = ".$_GET['id_disciplina'];
				// $resultadoCreditos = pg_query($sqlCreditos);
				$resultadoCreditos = pg_query_params($conexao, $sqlCreditos, array()) or die ($sqlCreditos);
				if (pg_affected_rows($resultadoCreditos) == 0){	
				//	$template->presencas = round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					//$presencas+=round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					$totalPresenca+=round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					
					$porcentagem = ($x['presencas']*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);
					//$template->porcentagem = number_format($porcentagem, 0, '.', '');				
					//$template->alerta = (($porcentagem < 75)? "" : "");
					
					$sql = "select count(*) as faltas from presencas 
						where aluno_id = ".$registro['id']." and disciplina_id = ".$_GET['id_disciplina']." and resultado = 0 and bimestre = ".$bimestre;
					// $resultadoX =  pg_query($sql);
					$resultadoX = pg_query_params($conexao, $sql, array()) or die ($sql);
					$x = pg_fetch_array($resultadoX);			
					//$template->faltas = round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
					$totalFaltas += 	round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
				} else {						
					$sqlPresenca = "select * from presencas 
					where 
						aluno_id = ".$registro['id']." and 
						disciplina_id = ".$_GET['id_disciplina']." and resultado = 1 and bimestre = ".$bimestre;
					// $resultadoPresenca =  pg_query($sqlPresenca);					
					$resultadoPresenca = pg_query_params($conexao, $sqlPresenca, array()) or die ($sqlPresenca);
					$presencas = 0;
					$faltas = 0;
					while($xPresenca = pg_fetch_array($resultadoPresenca)){
						$presencas += $xPresenca['creditos'];
					}			
					$totalPresenca+=round((($presencas > 0) ? $presencas : 0));  
					//$template->presencas = round((($presencas > 0) ? $presencas : 0));					
					
					$porcentagem = ($presencas*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);					
					//$template->porcentagem = number_format($porcentagem, 0, '.', '');				
					//$template->alerta = (($porcentagem < 75)? "" : "");
					
					
					///$template->faltas = $aulas[$bimestre] - $presencas;
					$totalFaltas += 	$aulas[$bimestre] - $presencas;
							
								
				}													
				//$template->block("bloco_presenca");
			} 
		
			// bloco de notas - com exame
			$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre = ".$bimestre; 
			// $resultadoX =  pg_query($sql) or die($sql);
			$resultadoX = pg_query_params($conexao, $sql, array()) or die ($sql);

			$x = pg_fetch_array($resultadoX);
			//$template->bimestre = (($bimestre > 0) ? $bimestre : "Exame");						
			if ($x['nota'] > 0) {
				//$template->nota = $x['nota'];				
			} else if ($bimestre == 0){
				//$template->nota = "-";
			}	else {				
				//$template->nota = 0;
			}			 
		}
		// porcentagem total de presencas
		if ($totalPresenca > 0) {
			$porcentagem = number_format($totalPresenca/($totalPresenca+$totalFaltas),2);
		} else {
			$porcentagem = 0;
		}				
				
		$sql = "select obtido, comentario from notas where aluno_id = " . $registro['id'] . " and avaliacao_id = " . $_GET['id_avaliacao'];
		// $resultadoX = pg_query($sql);
		$resultadoX = pg_query_params($conexao, $sql, array()) or die ($sql);
		$x = pg_fetch_array($resultadoX);
		$template -> obtido = (($x['obtido'] > 0) ? $x['obtido'] : 0);
		$template -> comentario = nl2br(utf8_encode($x['comentario']));		
		
		/*
		// precisa - aprovado ou reprovado??
		$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre > 0"; 
		$resultadoX =  pg_query($sql) or die($sql);
		$x = pg_fetch_array($resultadoX);		
		
		if (strcmp($eh_semestral, 'Anual') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre >= 0"; 
			$resultadoz =  pg_query($sqlz) or die($sqlz);
			if (pg_affected_rows($resultadoz)>0){
				$z = pg_fetch_array($resultadoz);
				if ($z['nota']/5 >= 5){
					$template->precisa = (($porcentagem >= 0.75) ? "Aprovado" : utf8_decode("Reprovado por frequência"));	
				} else {
					if($z['nota'] >= 6.7) {
						$template->precisa = (($porcentagem >= 0.75) ? "Exame (".((50 - $z['nota']*1.5)/4).")": utf8_decode("Reprovado por frequência"));	
					} else {						
						$template->precisa = "Reprovado. Nota insuficiente";
					}	
				}			
			} else {
				$template->precisa = "-";
			}	
		} else if ($x['nota'] >= 14 && strcmp($eh_semestral, 'Semestral') == 0){
			$template->precisa = "Aprovado";
		} else if (strcmp($eh_semestral, 'Semestral') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre >= 0"; 
			$resultadoz =  pg_query($sqlz) or die($sqlz);
			if (pg_affected_rows($resultadoz)>0){
				$z = pg_fetch_array($resultadoz);
				if ($z['nota']/3 >= 5){
					$template->precisa = (($porcentagem >= 0.75) ? "Aprovado" : utf8_decode("Reprovado por frequência"));	
				} else {
					if($z['nota'] >= 6.7) {
						$template->precisa = (($porcentagem >= 0.75) ? "Exame (".((25 - $z['nota']*1.5)/2).")": utf8_decode("Reprovado por frequência"));	
					} else {						
						$template->precisa = "Reprovado. Nota insuficiente";
					}	
				}
			} else {
				$template->precisa = "-";				
			}	
		} else {
			$template->precisa = "Reprovado";
		}*/
		
		// situacao - aprovado ou reprovado??
		$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre > 0"; 
		// $resultadoX =  pg_query($sql) or die($sql);
		$resultadoX = pg_query_params($conexao, $sql, array()) or die ($sql);
		$x = pg_fetch_array($resultadoX);		
		if (strcmp($eh_semestral, 'Anual') == 0){			
			$queryPrecisa = "SELECT * FROM tabela_nota_exame WHERE somatorio = ".trim($x['nota'])."::real AND modalidade = 'ANUAL'";
			// $resultPrecisa = pg_query($queryPrecisa) or die($queryPrecisa);
			$resultPrecisa = pg_query_params($conexao, $queryPrecisa, array()) or die ($queryPrecisa);
			$vetPrecisa = pg_fetch_array($resultPrecisa);
			if ($x['nota'] >= 28.0 ) {
				$template->precisa = "Aprovado"; 
			} else if ($x['nota'] >= 6.7 && pg_affected_rows($resultPrecisa)>0) {
				$template->precisa = "Somou: ".$x['nota']." <br> Precisa no Exame: ".$vetPrecisa['precisa'];
			} else {
				$template->precisa = "-";
			}			
		} else {
			if ($x['nota'] >= 14.0) {
				$template->precisa = "Aprovado"; 
			} else if ( ((25 - $x['nota']*1.5)/2) >= 0 && ((25 - $x['nota']*1.5)/2) <= 10.0)  {
				$template->precisa = "Somou:".$x['nota']." <br> Precisa no Exame: ".((25 - $x['nota']*1.5)/2);
			} else {
				$template->precisa = "-";			
			}			
		}		
		$i++;
		$template->block("alunos");						
	}    
// se for exame - mostrar quanto precisa
if ($template->bimestre == 0) {
	$template -> mostra = true;
} else {
	$template -> mostra = "none";
}
//$template->show();
//$html2pdf = new HTML2PDF('L', 'A4', 'pt', false, 'ISO-8859-15', 2);
//$html2pdf -> WriteHTML($template -> parse());
// todo o html gerado eh parametro para a funcao que gera o pdf
//$html2pdf -> Output('correcao.pdf');
// echo $template -> parse();
$template -> show();
?>