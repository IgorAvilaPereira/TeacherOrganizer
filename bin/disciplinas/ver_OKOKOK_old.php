<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	//require_once "../../lib/html2pdf/html2pdf.class.php";
	//ob_start();
	
	$template = new Template("../../view/disciplinas/ver.html");
	
	$query = "select * from avaliacoes where disciplina_id = $1 order by bimestre";
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

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
	}	
	
	$query = "select * from disciplinas where id = $1";	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	// $result = pg_query($query);	
	
	$registro = pg_fetch_array($result);
	
	$template->id_disciplina = $registro['id'];
	$template->nome_disciplina = utf8_decode($registro['nome']);
	$template->email = $registro['email'];
	$template->ano = $registro['ano'];
	$template->semestre = $registro['semestre'];
	$template->creditos = $registro['creditos'];
	$creditos = (($registro['creditos'] > 0)? $registro['creditos']: 1);
	$template->creditos_por_dia = $registro['creditos_por_dia'];	
	$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	$total = (($registro['eh_semestral'] == 't') ? 2 : 4);
	
	
	$query = "SELECT * FROM creditos WHERE disciplina_id = $1";	
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	if (pg_affected_rows($result)>0){		
		while ($registro = pg_fetch_array($result)) {
			$template->nr = $registro['nr_creditos'];
			$template->block("blococreditos");	
		}
	}
	
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
					where disciplina_id = $1 and bimestre = $2";
		// $result = pg_query($query);
		$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'], $bimestre)) or die ($query);

		//if (pg_affected_rows($result) > 0){
			$aulas[$bimestre] = pg_affected_rows($result);	
		//}	
		$template->aulas = round(pg_affected_rows($result)*$creditos_por_dia);
		$template->bimestre = $bimestre;
		$template->block("aulasDadas");	
	}
	$query = "select max(bimestre) as bimestre from presencas 
					where disciplina_id = $1";
		// $result = pg_query($query);
		$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
		$max_bimestre =  pg_fetch_array($result);
		$template->max_bimestre = (($max_bimestre['bimestre'] > 0) ? $max_bimestre['bimestre'] : 1) ;		
	 		
	
	$query = "select alunos.id, alunos.nome, alunos.matricula, alunos.observacao from disciplinas inner join alunos on(alunos.disciplina_id = disciplinas.id) where disciplinas.id = $1 order by matricula";
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
	$template->totalAlunos = pg_affected_rows($result);	
	$i = 1;	
	
	while ($registro = pg_fetch_array($result)){
		$template->id = $registro['id'];
		$nome  = explode(" ",trim(strtoupper(utf8_decode($registro['nome']))));
		if (count($nome)>1){
			$template->nome = $nome[0]." ".$nome[count($nome)-1];
		} else {
			$template->nome = utf8_decode($registro['nome']);
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
		
		// notas e presencas por bimestre	
		for ($bimestre = 0; $bimestre <= $total; $bimestre++) {
				if ($bimestre > 0) { 						
				$sql = "select count(*) as presencas from presencas 
					where 
						aluno_id = $1 and 
						disciplina_id = $2 and resultado = 1 and bimestre = $3";
				// $resultadoX =  pg_query($sql);
				$result = pg_query_params($conexao, $sql, array($registro['id'], $_GET['id_disciplina'], $bimestre)) or die ($query);

				$x = pg_fetch_array($resultadoX);
				
				$template->bimestre = $bimestre;
				//$template->bimestre_nome = $bimestre;
				//$template->bimestre_nome = (($bimestre > 0) ? $bimestre : "Exame");
				
				// MEXER AQUI PARA DISCIPLINAS QUE POSSUEM CREDITOS DIFERENTES....				
				$template->presencas = round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
				$presencas+=round((($x['presencas'] > 0) ? $x['presencas'] : 0) * $creditos_por_dia);
				$porcentagem = ($x['presencas']*100)/(($aulas[$bimestre] > 0)? $aulas[$bimestre] : 1);
				$template->porcentagem = number_format($porcentagem, 0, '.', '');
				
				$template->alerta = (($porcentagem < 75)? "" : "");
										
				$sql = "select count(*) as faltas from presencas 
					where aluno_id = ".$registro['id']." and disciplina_id = ".$_GET['id_disciplina']." and resultado = 0 and bimestre = ".$bimestre;
				$resultadoX =  pg_query($sql);
				$x = pg_fetch_array($resultadoX);			
				// MEXER AQUI PARA DISCIPLINAS QUE POSSUEM CREDITOS DIFERENTES....				
				$template->faltas = round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);
				$faltas += 	round((($x['faltas'] > 0) ? $x['faltas'] : 0) * $creditos_por_dia);					
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
		// porcentagem total de presencas
		if ($presencas > 0) {
			$template->alert = ((number_format($presencas/($presencas+$faltas),2) < 0.75) ? "red" : "green");
			$template->porc = number_format(($presencas/($presencas+$faltas))*100,2)."%";
			$porcentagem = number_format($presencas/($presencas+$faltas),2);
		} else {
			$template->alert = "red";
			$template->porc = "0%";
			$porcentagem = 0;
		}				
		// situacao - aprovado ou reprovado??
		$sql = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre > 0"; 
		$resultadoX =  pg_query($sql) or die($sql);
		$x = pg_fetch_array($resultadoX);		
		//$template->soma = "Soma:".$x['nota'];
		$template->soma = "";  		
		if (/*$x['nota'] >= 28 && */strcmp($eh_semestral, 'Anual') == 0){
			// considerando o exame
			$sqlz = "select sum(obtido) as nota from notas inner join avaliacoes on (notas.avaliacao_id = avaliacoes.id) where aluno_id = ".$registro['id']." and bimestre >= 0"; 
			$resultadoz =  pg_query($sqlz) or die($sqlz);
			if (pg_affected_rows($resultadoz)>0){
				$z = pg_fetch_array($resultadoz);
				if ($z['nota']/5 >= 5){
					$template->situacao = (($porcentagem >= 0.75) ? "Aprovado" : "Reprovado por frequencia");	
				} else {
					if($z['nota'] >= 6.7) {
						$template->situacao = (($porcentagem >= 0.75) ? "Exame <br> Precisa ".((50 - $z['nota']*1.5)/4): "Reprovado por frequencia");	
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
					$template->situacao = (($porcentagem >= 0.75) ? "Aprovado" : "Reprovado por frequencia");	
				} else {
					if($z['nota'] >= 6.7) {
						$template->situacao = (($porcentagem >= 0.75) ? "Exame <br> Precisa ".((25 - $z['nota']*1.5)/2): "Reprovado por frequencia");	
					} else {						
						$template->situacao = "Reprovado. Nota insuficiente";
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
    //$html2pdf->Output('tabela_frequencia.pdf');		
	$template->show();
?>