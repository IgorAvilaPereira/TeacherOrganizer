<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	// ob_start();
	
	$template = new Template("../../view/disciplinas/ver_relatorio.html");
	/*
	$query = "select * from avaliacoes where disciplina_id=".$_GET['id_disciplina']." order by bimestre";
	$result = pg_query($query);	
	$cor =  array('AliceBlue', 'LightGray', 'PaleGreen', 'yellow', 'pink');
	while ($registro = pg_fetch_array($result)){			
		$template->id_avaliacao = $registro['id'];
		$template->titulo_avaliacao = utf8_decode($registro['titulo']);
		$template->bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre']." Bim." : "Exame" );
		$template->bimestre_cor = $cor[$registro['bimestre']];
		$template->valor_avaliacao = $registro['valor'];
		//$data_hora = $registro['data_hora'];
		//$data_hora = explode(" ", $data_hora);
		//$template->data = $data_hora[0];
		//$template->hora = $data_hora[1];
		$template->data_hora = $registro['data_hora']; 
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
	//$dia = array('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');
	$dia = array('Domingo', 'Segunda', 'Ter&ccedil;a', 'Quarta', 'Quinta', 'Sexta', 'S&aacute;bado');
	
		$query = "select ano, semestre, creditos_por_dia, creditos, eh_semestral, disciplinas.nome as nome_disciplina, cursos.nome as curso_nome from disciplinas inner join cursos on (cursos.id = disciplinas.curso_id) where disciplinas.id = $1";	
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

		pg_set_client_encoding($conexao, "iso-8859-1");

	$registro = pg_fetch_array($result);
	
	//$template->id_disciplina = $registro['id'];
	//$template->nome_disciplina = utf8_decode($registro['nome']);
	$template->nome_disciplina = $registro['nome_disciplina'];
	$template->curso_nome = $registro['curso_nome'];
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	if (!empty($registro['creditos_por_dia'])){
		$template->creditos = $registro['creditos'];		
		$template->creditos_por_dia = $registro['creditos_por_dia'];	
		$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	} else {		
		$queryCreditosPorDia = "select * from creditos where disciplina_id = $1";	
		// $resultCreditosPorDia = pg_query($queryCreditosPorDia);
		$resultCreditosPorDia = pg_query_params($conexao, $queryCreditosPorDia, array($_GET['id_disciplina'])) or die ($queryCreditosPorDia);

		$str = "<br>";
		$totalCreditos = 0;
		while ($registroCreditosPorDia = pg_fetch_array($resultCreditosPorDia)){
			$str.= $dia[$registroCreditosPorDia['dia_semana']]." : ".$registroCreditosPorDia['nr_creditos']." <br>";
			$totalCreditos+=$registroCreditosPorDia['nr_creditos'];
		}
		$template->creditos = $totalCreditos;	
		$template->creditos_por_dia = $str;
	}
	$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	$total = (($registro['eh_semestral'] == 't') ? 2 : 4);
	
	// combo de creditos - disciplinas com varios creditos
	/*
	$query = "SELECT * FROM creditos WHERE disciplina_id = ".$_GET['id_disciplina'];	
	$result = pg_query($query);
	if (pg_affected_rows($result)>0){		
		while ($registro = pg_fetch_array($result)) {
			$template->nr = $registro['nr_creditos'];
			$template->block("blococreditos");	
		}
	}
*/	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->block("rotulo_presencas");	
	}
	for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
		$template->bimestre = $bimestre;
		$template->bimestre_nome = (($bimestre > 0) ? $bimestre."º Ciclo" : "Exame");
		$template->block("rotulo_notas");	
	}					
	
	for ($bimestre = 1; $bimestre <= $total; $bimestre++) {	
		$sql = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = $1";
		// $resultado  = pg_query($sql);
		$resultado = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);

		if (pg_affected_rows($resultado) > 0){
			$sql = "select distinct data, creditos from presencas 
					where 
					aluno_id in (select id from alunos where disciplina_id = $1 limit 1) and 
					disciplina_id = $2 and bimestre = $3";					
				// $resultado =  pg_query($sql);
				$resultado = pg_query_params($conexao, $sql, array($_GET['id_disciplina'], $_GET['id_disciplina'], $bimestre)) or die ($sql);

				$aulasX = 0;
				while($x = pg_fetch_array($resultado)){						
						$aulasX+= $x['creditos'];
				}
			$template->aulas = $aulasX;
			$aulas[$bimestre] = $aulasX;				
		} 
		else {
			$query = "select distinct data from presencas 
				where disciplina_id = $1 and bimestre = $2";
			// $result = pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'], $bimestre)) or die ($query);

			$template->aulas = round(pg_affected_rows($result)*$creditos_por_dia);
			$aulas[$bimestre] = pg_affected_rows($result);
		}
		$template->bimestre = $bimestre;
		$template->block("aulasDadas");	
	}
	$query = "select max(bimestre) as bimestre from presencas 
					where disciplina_id = $1";
		// $result = pg_query($query);
		$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

		$max_bimestre =  pg_fetch_array($result);
		//$template->max_bimestre = (($max_bimestre['bimestre'] > 0) ? $max_bimestre['bimestre'] : 1) ;		
	 		
	
	$query = "select alunos.id, alunos.nome, alunos.matricula, alunos.observacao from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id = $1 order by matricula";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
	
	//$template->totalAlunos = pg_affected_rows($result);	
	$i = 1;	
	
	while ($registro = pg_fetch_array($result)){
		//$template->id = $registro['id'];
		$nome  = explode(" ",trim(strtoupper(utf8_encode($registro['nome']))));
		if (count($nome)>1){
			$template->nome = $nome[0]." ".$nome[count($nome)-1];
		} else {
			$template->nome = $registro['nome'];
		}	
		$template->matricula = trim($registro['matricula']);
		if ($i % 2 == 0) {
			$template->cor = "aliceblue";
		}	else {
			$template->cor = "white";
		}			
		//$sql = "select aluno_id, 
		//sum(resultado)*(select creditos_por_dia from disciplinas 
		//where id =".$_GET['id_disciplina'].") as presenca, 
		//(count(*) - sum(resultado))*(select creditos_por_dia from disciplinas where id = ".$_GET['id_disciplina'].") as falta,  
		//cast(cast((cast(sum(resultado)*(select creditos_por_dia from disciplinas where id = ".$_GET['id_disciplina'].") as real)/cast(count(*)*(select creditos_por_dia from disciplinas where id = ".$_GET['id_disciplina'].") as real)) as numeric(3,2))*100 as integer) 
		//as porcentagem from presencas where disciplina_id = ".$_GET['id_disciplina']." and aluno_id =".$registro['id']." group by aluno_id ";
			
		$presencas = 0;
		$faltas = 0;		
		$totalPresenca = 0;
		$totalFaltas = 0;
		// notas e presencas por bimestre	
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
				
				// DISCIPLINAS QUE POSSUEM CREDITOS DIFERENTES....				
				$sqlCreditos = "SELECT id, disciplina_id, nr_creditos, dia_semana  FROM creditos WHERE disciplina_id = $1";
				// $resultadoCreditos = pg_query($sqlCreditos);
				$resultadoCreditos = pg_query_params($conexao, $sqlCreditos, array($_GET['id_disciplina'])) or die ($sqlCreditos);

				if (pg_affected_rows($resultadoCreditos) == 0){	
					$template->presencas = round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					//$presencas+=round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					$totalPresenca+=round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
					
					$porcentagem = ($x['presencas']*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);
					// $template->porcentagem = number_format($porcentagem, 0, '.', '');				
					$template->porcentagem = "";				
					$template->alerta = (($porcentagem < 75)? "red" : "green");
					
					$sql = "select count(*) as faltas from presencas 
						where aluno_id = $1 and disciplina_id = $2 and resultado = 0 and bimestre = $3";
					// $resultadoX =  pg_query($sql);
					$resultadoX = pg_query_params($conexao, $sql, array($registro['id'], $_GET['id_disciplina'], $bimestre)) or die ($sql);

					$x = pg_fetch_array($resultadoX);			
					$template->faltas = round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
					$totalFaltas += 	round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
				} else {						
					$sqlPresenca = "select * from presencas 
					where 
						aluno_id = $1 and disciplina_id = $2 and resultado = 1 and bimestre = $3";
					// $resultadoPresenca =  pg_query($sqlPresenca);					
					$resultadoPresenca = pg_query_params($conexao, $sqlPresenca, array($registro['id'], $_GET['id_disciplina'],  $bimestre)) or die ($sqlPresenca);

					$presencas = 0;
					$faltas = 0;
					while($xPresenca = pg_fetch_array($resultadoPresenca)){
						$presencas += $xPresenca['creditos'];
					}			
					$totalPresenca+=round((($presencas > 0) ? $presencas : 0));  
					$template->presencas = round((($presencas > 0) ? $presencas : 0));					
					
					$porcentagem = ($presencas*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);					
					// $template->porcentagem = number_format($porcentagem, 0, '.', '');				
					$template->porcentagem = "";				
					$template->alerta = (($porcentagem < 75)? "red" : "green");
					
					
					$template->faltas = $aulas[$bimestre] - $presencas;
					$totalFaltas += 	$aulas[$bimestre] - $presencas;
							
								
				}													
				$template->block("bloco_presenca");
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
		// porcentagem total de presencas
		if ($totalPresenca > 0) {
			//$template->alert = ((number_format($totalPresenca/($totalPresenca+$totalFaltas),2) < 0.75) ? "red" : "green");
			//$template->porc = number_format(($totalPresenca/($totalPresenca+$totalFaltas))*100,2)."%";
			$porcentagem = number_format($totalPresenca/($totalPresenca+$totalFaltas),2);
		} else {
			//$template->alert = "red";
			//$template->porc = "0%";
			$porcentagem = 0;
		}				
		// situacao - aprovado ou reprovado??
		$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = $1 and bimestre > 0"; 
		// $resultadoX =  pg_query($sql) or die($sql);
		$resultadoX = pg_query_params($conexao, $sql, array($registro['id'])) or die ($sql);

		$x = pg_fetch_array($resultadoX);		
		//$template->soma = "Soma:".$x['nota'];
		//$template->soma = "";  		
		if (/*$x['nota'] >= 28 && */strcmp($eh_semestral, 'Anual') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = $1 and bimestre >= 0"; 
			// $resultadoz =  pg_query($sqlz) or die($sqlz);
			$resultadoz = pg_query_params($conexao, $sqlz, array($registro['id'])) or die ($sqlz);

			if (pg_affected_rows($resultadoz)>0){
				$z = pg_fetch_array($resultadoz);
				if ($z['nota'] >= 28){
					$template->situacao = (($porcentagem >= 0.75) ? "Aprovado" : "Reprovado<br> por frequencia");	
				} else {
					if($z['nota'] >= 6.7) {
						$template->situacao = (($porcentagem >= 0.75) ? "Exame <br> Precisa ".((50 - $z['nota']*1.5)/4): "Reprovado por frequencia");	
					} else {						
						$template->situacao = "Reprovado <br> Nota insuficiente";
					}	
				}			
			} else {
				$template->situacao = "-";
			}	
		} else if ($x['nota'] >= 14 && strcmp($eh_semestral, 'Semestral') == 0){
			$template->situacao = "Aprovado";
		} else if (strcmp($eh_semestral, 'Semestral') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = $1 and bimestre >= 0"; 
			// $resultadoz =  pg_query($sqlz) or die($sqlz);
			$resultadoz = pg_query_params($conexao, $sqlz, array($registro['id'])) or die ($sqlz);

			if (pg_affected_rows($resultadoz)>0){
				$z = pg_fetch_array($resultadoz);
				if ($z['nota']/3 >= 5){
					$template->situacao = (($porcentagem >= 0.75) ? "Aprovado" : "Reprovado<br> por frequencia");	
				} else {
					if($z['nota'] >= 6.7) {
						$template->situacao = (($porcentagem >= 0.75) ? "Exame <br> Precisa ".((25 - $z['nota']*1.5)/2): "Reprovado<br> por frequencia");	
					} else {						
						$template->situacao = "Reprovado<br> Nota insuficiente";
					}	
				}
			} else {
				$template->situacao = "-";				
			}	
		} else {
			$template->situacao = "Reprovado";
		}		
		$i++;
		$template->block("alunos");						
	}
	//$html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
    //$html2pdf->WriteHTML($template->parse());
    //$html2pdf->Output('notas.pdf');		
	$template->show();
?>