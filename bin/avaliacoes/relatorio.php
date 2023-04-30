<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	//ob_start();
	
	$template = new Template("../../view/avaliacoes/relatorio.html");
	
	// qtde de alunos
	$query = "select count(*) as total from alunos where disciplina_id=".$_GET['id_disciplina'];
	// $result = pg_query($query) or die("erro");	
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	$a = pg_fetch_array($result);
	$template->total = $a['total'];	

	// Avaliacoes	
	$query = "select * from avaliacoes where disciplina_id = $1 order by bimestre, data_hora";
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	
	
	if (pg_affected_rows($result) == 0) die('<h1>Nenhuma Atividade Avaliada cadastrada para a Disciplina</h1> <a href="javascript: onclick(history.go(-1))"> Voltar </a>');
	
	$cor =  array('AliceBlue', 'LightGray', 'PaleGreen', 'yellow', 'pink');
	while ($registro = pg_fetch_array($result)){			
		//$template->id_avaliacao = $registro['id'];
		$template->titulo_avaliacao = $registro['titulo'];
		$template->bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre']." Bim." : "Exame" );
		$template->bimestre_cor = $cor[$registro['bimestre']];
		$template->valor_avaliacao = $registro['valor'];
		if (!empty($registro['data_hora'])) {
			$data_hora = $registro['data_hora'];
			$data_hora = explode(" ", $data_hora);
			$data = explode("-",$data_hora[0]);		
			$hora = substr(trim($data_hora[1]), 0, 5); 
			$template->data_hora = $data[2]."/".$data[1]."/".$data[0]." ".$hora;
		} else {
			$template->data_hora = "";
		}			 
		$sql = "select * from notas where avaliacao_id = $1";
		// $x = pg_query($sql);
		$x = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

		$linhas = pg_affected_rows($x);
		if ($linhas == 0){
			//$template->corrigir = "red";
			//$template->pendente = "pendente";
		} else {
			//$template->corrigir = "green";
			//$template->pendente = "corrigido";
		}		
		$template->block("avaliacoes");
	}	

	
	// // Anotacoes
	// $query = "select * from anotacoes where disciplina_id=".$_GET['id_disciplina'];
	// $result = pg_query($query);		
	// while ($registro = pg_fetch_array($result)){			
	// 	$template->id_anotacao = $registro['id'];
	// 	$template->anotacao = nl2br($registro['anotacao']);
	// 	$template->block("anotacoes");
	// }		


	$dia = array('Domingo', 'Segunda', 'Ter&ccedil;a', 'Quarta', 'Quinta', 'Sexta', 'S&aacute;bado');	
	$query = "select * from disciplinas where id = $1";	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
	$registro = pg_fetch_array($result);
	
	//$template->curso_id = $registro['curso_id'];
	//$template->id_disciplina = $registro['id'];
	//$template->nome_disciplina = utf8_decode($registro['nome']); 
	$template->nome_disciplina = $registro['nome']; 
	//$template->email = $registro['email'];
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	if (!empty($registro['creditos_por_dia'])){
		$template->creditos = $registro['creditos'];		
		$template->creditos_por_dia = $registro['creditos_por_dia'];	
		$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	} /*else {		*/
		$queryCreditosPorDia = "select * from creditos where disciplina_id = $1";	
		$resultCreditosPorDia =  pg_query_params($conexao, $queryCreditosPorDia, array($_GET['id_disciplina'])) or die ($queryCreditosPorDia);
		$str = "<br>";
		$totalCreditos = 0;
		while ($registroCreditosPorDia = pg_fetch_array($resultCreditosPorDia)){
			$str.= $dia[$registroCreditosPorDia['dia_semana']].":".$registroCreditosPorDia['nr_creditos']."<br>";
			$totalCreditos+=$registroCreditosPorDia['nr_creditos'];
		}
		if ($totalCreditos > 0){
			$template->creditos = $totalCreditos;	
			$template->creditos_por_dia = $str;
		}
	/*}*/
	$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	$total = (($registro['eh_semestral'] == 't') ? 2 : 4);
	
	// combo de creditos - disciplinas com varios creditos
	// $query = "SELECT * FROM creditos WHERE disciplina_id = ".$_GET['id_disciplina'];	
	// $result = pg_query($query);
	// if (pg_affected_rows($result)>0){
	// 	if (pg_affected_rows($result) > 1) {	
	// 		$template->nr = 0;
	// 		$template->block("blococreditos");
	// 	}		
	// 	while ($registro = pg_fetch_array($result)) {
	// 		$template->nr = $registro['nr_creditos'];
	// 		$template->block("blococreditos");	
	// 	}
	// }
	
	// for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
	// 	$template->bimestre = $bimestre;
	// 	$template->block("rotulo_presencas");	
	// }
	// for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
	// 	$template->bimestre = $bimestre;
	// 	$template->bimestre_nome = (($bimestre > 0) ? $bimestre." Bim" : "Exame");
	// 	$template->block("rotulo_notas");	
	// }					
	
	// for ($bimestre = 1; $bimestre <= $total; $bimestre++) {	
	// 	$sql = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = ".$_GET['id_disciplina'];
	// 	$resultado  = pg_query($sql);
	// 	if (pg_affected_rows($resultado) > 0){
	// 		$sql = "select distinct data, creditos from presencas 
	// 				where 
	// 				aluno_id in (select id from alunos where disciplina_id = ".$_GET['id_disciplina']." limit 1) and 
	// 				disciplina_id = ".$_GET['id_disciplina']." and bimestre = ".$bimestre;					
	// 			$resultado =  pg_query($sql);
	// 			$aulasX = 0;
	// 			while($x = pg_fetch_array($resultado)){						
	// 					$aulasX+= $x['creditos'];
	// 			}
	// 		$template->aulas = $aulasX;
	// 		$aulas[$bimestre] = $aulasX;				
	// 	} 
	// 	else {
	// 		$query = "select distinct data from presencas 
	// 			where disciplina_id = ".$_GET['id_disciplina']." and bimestre = ".$bimestre;
	// 		$result = pg_query($query);
	// 		$template->aulas = round(pg_affected_rows($result)*$creditos_por_dia);
	// 		$aulas[$bimestre] = pg_affected_rows($result);
	// 	}
	// 	$template->bimestre = $bimestre;
	// 	$template->block("aulasDadas");	
	// }
	// $query = "select max(bimestre) as bimestre from presencas 
	// 				where disciplina_id = ".$_GET['id_disciplina'];
	// 	$result = pg_query($query);
	// 	$max_bimestre =  pg_fetch_array($result);
	// 	$template->max_bimestre = (($max_bimestre['bimestre'] > 0) ? $max_bimestre['bimestre'] : 1) ;		
	 		
	
	// $query = "select alunos.id, alunos.nome, alunos.matricula, alunos.observacao from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id=".$_GET['id_disciplina']." order by matricula";
	// $result = pg_query($query);	
	// $template->totalAlunos = pg_affected_rows($result);	
	// $i = 1;	
	
	// while ($registro = pg_fetch_array($result)){
	// 	$template->id = $registro['id'];
	// 	$nome  = explode(" ",trim(strtoupper($registro['nome'])));
	// 	if (count($nome)>1){
	// 		$template->nome = $nome[0]." ".$nome[count($nome)-1];
	// 	} else {
	// 		$template->nome = $registro['nome'];
	// 	}	
	// 	$template->matricula = trim($registro['matricula']);
	// 	if ($i % 2 == 0) {
	// 		$template->cor = "aliceblue";
	// 	}	else {
	// 		$template->cor = "white";
	// 	}			
	// 	//$sql = "select aluno_id, 
	// 	//sum(resultado)*(select creditos_por_dia from disciplinas 
	// 	//where id =".$_GET['id_disciplina'].") as presenca, 
	// 	//(count(*) - sum(resultado))*(select creditos_por_dia from disciplinas where id = ".$_GET['id_disciplina'].") as falta,  
	// 	//cast(cast((cast(sum(resultado)*(select creditos_por_dia from disciplinas where id = ".$_GET['id_disciplina'].") as real)/cast(count(*)*(select creditos_por_dia from disciplinas where id = ".$_GET['id_disciplina'].") as real)) as numeric(3,2))*100 as integer) 
	// 	//as porcentagem from presencas where disciplina_id = ".$_GET['id_disciplina']." and aluno_id =".$registro['id']." group by aluno_id ";
			
	// 	$presencas = 0;
	// 	$faltas = 0;		
	// 	$totalPresenca = 0;
	// 	$totalFaltas = 0;
	// 	// notas e presencas por bimestre	
	// 	for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
	// 			if ($bimestre > 0) { 						
	// 			$sql = "select count(*) as presencas from presencas 
	// 				where 
	// 					aluno_id = ".$registro['id']." and 
	// 					disciplina_id = ".$_GET['id_disciplina']." and resultado = 1 and bimestre = ".$bimestre;
	// 			$resultadoX =  pg_query($sql);
	// 			$x = pg_fetch_array($resultadoX);
				
	// 			$template->bimestre = $bimestre;
	// 			//$template->bimestre_nome = $bimestre;
	// 			//$template->bimestre_nome = (($bimestre > 0) ? $bimestre : "Exame");
				
	// 			// DISCIPLINAS QUE POSSUEM CREDITOS DIFERENTES....				
	// 			$sqlCreditos = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = ".$_GET['id_disciplina'];
	// 			$resultadoCreditos = pg_query($sqlCreditos);
	// 			if (pg_affected_rows($resultadoCreditos) == 0){	
	// 				$template->presencas = round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
	// 				//$presencas+=round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
	// 				$totalPresenca+=round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					
	// 				$porcentagem = ($x['presencas']*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);
	// 				$template->porcentagem = number_format($porcentagem, 0, '.', '');				
	// 				$template->alerta = (($porcentagem < 75)? "" : "");
					
	// 				$sql = "select count(*) as faltas from presencas 
	// 					where aluno_id = ".$registro['id']." and disciplina_id = ".$_GET['id_disciplina']." and resultado = 0 and bimestre = ".$bimestre;
	// 				$resultadoX =  pg_query($sql);
	// 				$x = pg_fetch_array($resultadoX);			
	// 				$template->faltas = round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
	// 				$totalFaltas += 	round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
	// 			} else {						
	// 				$sqlPresenca = "select * from presencas 
	// 				where 
	// 					aluno_id = ".$registro['id']." and 
	// 					disciplina_id = ".$_GET['id_disciplina']." and resultado = 1 and bimestre = ".$bimestre;
	// 				$resultadoPresenca =  pg_query($sqlPresenca);					
	// 				$presencas = 0;
	// 				$faltas = 0;
	// 				while($xPresenca = pg_fetch_array($resultadoPresenca)){
	// 					$presencas += $xPresenca['creditos'];
	// 				}			
	// 				$totalPresenca+=round((($presencas > 0) ? $presencas : 0));  
	// 				$template->presencas = round((($presencas > 0) ? $presencas : 0));					
					
	// 				$porcentagem = ($presencas*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);					
	// 				$template->porcentagem = number_format($porcentagem, 0, '.', '');				
	// 				$template->alerta = (($porcentagem < 75)? "" : "");
					
					
	// 				$template->faltas = $aulas[$bimestre] - $presencas;
	// 				$totalFaltas += 	$aulas[$bimestre] - $presencas;
							
								
	// 			}													
	// 			$template->block("bloco_presenca");
	// 		} 
		
	// 		// bloco de notas - com exame
	// 		$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre = ".$bimestre; 
	// 		$resultadoX =  pg_query($sql) or die($sql);
	// 		$x = pg_fetch_array($resultadoX);
	// 		$template->bimestre = (($bimestre > 0) ? $bimestre : "Exame");
									
	// 		if ($x['nota'] > 0) {
	// 			$template->nota = $x['nota'];				
	// 		} else if ($bimestre == 0){
	// 			$template->nota = "-";
	// 		}	else {				
	// 			$template->nota = 0;
	// 		}									
	// 		$template->block("bloco_nota");			 
	// 	}
	// 	// porcentagem total de presencas
	// 	if ($totalPresenca > 0) {
	// 		$template->alert = ((number_format($totalPresenca/($totalPresenca+$totalFaltas),2) < 0.75) ? "red" : "green");
	// 		$template->porc = number_format(($totalPresenca/($totalPresenca+$totalFaltas))*100,2)."%";
	// 		$porcentagem = number_format($totalPresenca/($totalPresenca+$totalFaltas),2);
	// 	} else {
	// 		$template->alert = "red";
	// 		$template->porc = "0%";
	// 		$porcentagem = 0;
	// 	}				
	// 	// situacao - aprovado ou reprovado??
	// 	$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre > 0"; 
	// 	$resultadoX =  pg_query($sql) or die($sql);
	// 	$x = pg_fetch_array($resultadoX);		
	// 	if (strcmp($eh_semestral, 'Anual') == 0){
	// 		if (!isset($x['nota'])){
	// 			$teste = 0;
	// 		} else {
	// 			$teste = $x['nota'];
	// 		}
	// 		$queryPrecisa = "SELECT * FROM tabela_nota_exame WHERE somatorio = ".trim($teste)."::real AND modalidade = 'ANUAL'";
	// 		$resultPrecisa = pg_query($queryPrecisa) or die($queryPrecisa);
	// 		$vetPrecisa = pg_fetch_array($resultPrecisa);
	// 		if ($x['nota'] >= 28.0 ) {
	// 			$template->soma = "Aprovado"; 
	// 		} else if ($x['nota'] >= 6.7 && pg_affected_rows($resultPrecisa)>0) {
	// 			$template->soma = "Somou: ".$x['nota']." <br> Precisa no Exame: ".$vetPrecisa['precisa'];
	// 		} else {
	// 			$template->soma = "Nao obteve nem o minimo para o exame";
	// 		}			
	// 	} else {
	// 		if ($x['nota'] >= 14.0) {
	// 			$template->soma = "Aprovado"; 
	// 		} else if ( ((25 - $x['nota']*1.5)/2) >= 0 && ((25 - $x['nota']*1.5)/2) <= 10.0)  {
	// 			$template->soma = "Somou:".$x['nota']." <br> Precisa no Exame: ".((25 - $x['nota']*1.5)/2);
	// 		} else {
	// 			$template->soma = "Nao obteve nem o minimo para o exame";			
	// 		}			
	// 	}
	// 	$template->situacao = "";
		//$template->soma = "";  
		/*		
		if (strcmp($eh_semestral, 'Anual') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre >= 0"; 
			$resultadoz =  pg_query($sqlz) or die($sqlz);
			if (pg_affected_rows($resultadoz)>0){
				$z = pg_fetch_array($resultadoz);
				if ($z['nota']/5 >= 5){
					$template->situacao = (($porcentagem >= 0.75) ? $x['nota'] : utf8_decode("Reprovado por frequência"));	
				} else {
					if($z['nota'] >= 6.7) {
						$template->situacao = (($porcentagem >= 0.75) ? "Exame (".((50 - $z['nota']*1.5)/4).")": utf8_decode("Reprovado por frequência"));	
					} else {						
						$template->situacao = "Reprovado. Nota insuficiente";
					}	
				}			
			} else {
				$template->situacao = "-";
			}	
		} else if ($x['nota'] >= 14 && strcmp($eh_semestral, 'Semestral') == 0){
			$template->situacao = "Aprovado";
		} else if (strcmp($eh_semestral, 'Semestral') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre >= 0"; 
			$resultadoz =  pg_query($sqlz) or die($sqlz);
			if (pg_affected_rows($resultadoz)>0){
				$z = pg_fetch_array($resultadoz);
				if ($z['nota']/3 >= 5){
					$template->situacao = (($porcentagem >= 0.75) ? $x['nota'] : utf8_decode("Reprovado por frequência"));	
				} else {
					if($z['nota'] >= 6.7) {
						$template->situacao = (($porcentagem >= 0.75) ? "Exame (".((25 - $z['nota']*1.5)/2).")": utf8_decode("Reprovado por frequência"));	
					} else {						
						$template->situacao = "Reprovado. Nota insuficiente";
					}	
				}
			} else {
				$template->situacao = "-";				
			}	
		} else {
			$template->situacao = "Reprovado";
		}*/		
	// 	$i++;
	// 	$template->block("alunos");						
	// }

	// $html2pdf = new HTML2PDF('P','A4','pt', false, 'ISO-8859-15', 2);
    // $html2pdf->WriteHTML($template->parse());
    // $html2pdf->Output('avaliacoes.pdf');		
	$template->show();
	// echo $template->parse();
?>