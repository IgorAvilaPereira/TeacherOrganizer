<?php
	define('DELIMITADOR',';');
	require_once "../../lib/conexao.php";	
	
	$query = "select * from disciplinas where id = $1";	
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);

	$registro = pg_fetch_array($result);	

	$vetAluno = explode("\n", $_POST['alunos']);
	$insert = "";
	if (count($vetAluno) > 0) {
		foreach ($vetAluno as $aluno) {
			$x = explode(DELIMITADOR,$aluno);
			if (count($x)  >= 2) {
				$matricula = trim($x[0]);
				$nome = trim($x[1]);
				
				// insere novo aluno
				$insert = "insert into alunos (nome, matricula, disciplina_id) values ($1, $2, $3) 
				returning id;";
				// $result = pg_query($insert);
				$result = pg_query_params($conexao, $insert, array(strtoupper($nome), $matricula, $_GET['id'])) or die ($insert);

								
				// obtem o id				
				$aluno_id = pg_fetch_array($result);
				$aluno_id =  $aluno_id['id'];
				
				// CORRIGIR por causa dos creditos... registra as faltas - caso a disciplina ja esteja ocorrendo... e adicionei um aluno novo que nao havia adicionado
				$presencas = "select distinct data, bimestre, creditos from presencas where disciplina_id = $1 order by data;";
				// $result = pg_query($presencas);
				$result = pg_query_params($conexao, $presencas, array($_GET['id'])) or die ($presencas);

				while ($registro = pg_fetch_array($result)){ // o aluno "ganha" todas as presencas anteriores
					$sql = "insert into presencas(data, aluno_id, disciplina_id, resultado, bimestre, creditos)
    VALUES ($1, $2, $3, 1, $4, $5);";
					// $resultPresenca = pg_query($sql) or die(pg_errormessage());
					$resultPresenca = pg_query_params($conexao, $sql, array($registro['data'], $aluno_id, $_GET['id'], $registro['bimestre'], $registro['creditos'])) or die ($insert);

					//select distinct data from presencas where disciplina_id = 30;
//INSERT INTO presencas(data, aluno_id, disciplina_id, resultado, bimestre)
  //  VALUES (?, 821, 30, 1, 1); 
				}		
				// atribui zero para todas as avaliacoes anteriormente realizadas (antes da adicao do novo aluno)
				$avaliacoes = " select distinct avaliacoes.id from avaliacoes 
 inner join notas on (notas.avaliacao_id = avaliacoes.id) where disciplina_id = $1 order by avaliacoes.id;"; 
				// $resultAvaliacoes = pg_query($avaliacoes);
				$resultAvaliacoes = pg_query_params($conexao, $avaliacoes, array($_GET['id'])) or die ($avaliacoes);

				while ($avaliacao = pg_fetch_array($resultAvaliacoes)){						
						$sql = "insert into notas(obtido, avaliacao_id, aluno_id, comentario) 
						VALUES (0, $1, $2, 'Adicionado depois na disciplina');";
						// $resultNota = pg_query($sql) or die(pg_errormessage());
						$resultNota = pg_query_params($conexao, $sql, array($avaliacao['id'], $aluno_id)) or die ($sql);

				}				
			} else {
				echo "<pre>";
					print_r($x);
				echo "</pre>";	
			}	  
		}	
		//$result = pg_query("begin;".$insert."commit;") or die("erro");	
	} else {
		echo "<pre>";
			print_r($vetAluno);
		echo "</pre>";	
	}		
	// adicionado depois da funcao importar planos em csv => n funcionou como esperado
	// $delete = "delete from presencas where disciplina_id = ".$_GET['id']." and aluno_id is null";	
	// $result = pg_query($delete);	

	//echo "<pre>";
	//	print_r($vetAluno);
	//echo "</pre>";	
	
	dump();
	header("Location: ver.php?id_disciplina=".$_GET['id']);			
?>