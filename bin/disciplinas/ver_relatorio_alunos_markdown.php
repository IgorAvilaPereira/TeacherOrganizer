<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/TextTable.php";

	//https://gist.github.com/dapepe/9956717
	$query = "select * from disciplinas where id = $1";	
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	if (pg_affected_rows($result) == 0) die("<h2> Disciplina inexistente </h2>");
	$registro = pg_fetch_array($result);
	
//	$template->id_disciplina = $registro['id'];
	//$template->nome_disciplina = utf8_decode($registro['nome']);
	$disciplina = $registro['nome'];
	$ano_semestre = $registro['ano']."/".$registro['semestre'];

	//$template->ano = $registro['ano'];
	//$template->semestre = $registro['semestre'];
	//$template->creditos = $registro['creditos'];
	//$creditos = (($registro['creditos'] > 0)? $registro['creditos']: 1);
	//$template->creditos_por_dia = $registro['creditos_por_dia'];	
	//$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	//$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	//$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	
	$columns = ["Matrícula", "Exame", "Unid.1", "Unid.2"];	
	if (!($registro['eh_semestral'] == 't')){
		$columns[] = "Unid.3";
		$columns[] = "Unid.4";
	}

	$query =  "SELECT 
		alunos.matricula AS matricula, 
		avaliacoes.bimestre AS periodo, 
		'-' AS nota 
		FROM alunos 
			INNER JOIN avaliacoes 
				ON (alunos.disciplina_id = avaliacoes.disciplina_id) 
			WHERE alunos.disciplina_id = $1 GROUP BY 
			alunos.matricula, avaliacoes.bimestre
		ORDER BY 
			alunos.matricula;";

	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$rows = [];
	if (pg_affected_rows($result) > 0){
		while($registro = pg_fetch_array($result)){
			$rows[$registro['matricula']][$registro['periodo']] = $registro['nota'];
		}
	}


	$query = "
	SELECT 
		alunos.matricula, 
		avaliacoes.bimestre AS periodo, 
		sum(notas.obtido) AS nota 
	FROM notas 
		INNER JOIN avaliacoes ON (avaliacoes.id = notas.avaliacao_id)
		INNER JOIN alunos ON (notas.aluno_id = alunos.id)
	WHERE 
		avaliacoes.disciplina_id = $1 GROUP BY 
		alunos.matricula, 
		avaliacoes.bimestre";

	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	if (pg_affected_rows($result) > 0){
		while($registro = pg_fetch_array($result)){
			$rows[$registro['matricula']][$registro['periodo']] = number_format($registro['nota'],1);
		}		
	}

	$rowsFinal = [];
	foreach ($rows as $matricula => $vetNota) {
		$row = [$matricula];
		foreach ($vetNota as $bim => $obtido) {
			$row[$bim+1] = $obtido;
		}		
		$rowsFinal[] = $row;
	}
	
	
	$t = new TextTable($columns, $rowsFinal);
	//$t->addData(['extra1' => ['j','k','l']]);
	//echo $t->render(['extra2' => ['g','h','i']]);
	$t->setAlgin(['L', 'C', 'R']);
	//echo \PHP_EOL;
	//echo $t->render();
		
	// exibindo markdown para download
    // header("Content-Type: plain/text");
    // header("Content-disposition: attachment; filename=notas.md");
    // header("Content-Transfer-Encoding: binary");
    // header("Pragma: no-cache");
    // header("Expires: 0");
    
    // echo utf8_decode("### ".utf8_encode($disciplina)." - ".$ano_semestre."\n\n".$t->render());  


	echo "<html> <head> <title> ".$disciplina." - ".$ano_semestre." - Notas Markdown </title> </head> <body>";
    
    echo utf8_decode("## ".utf8_encode($disciplina)." - ".$ano_semestre."<br><br> **Atualiza&ccedil;&atilde;o:** ".date("d/m/Y - H:i:s")."<br><br>".utf8_encode(nl2br($t->render()))."<br>".utf8_encode("_* No SIA, notas com duas casas decimais serão arredondadas para uma casa decimal._ <br> <br> _* No SIA, em situações onde ultrapassar a nota máxima (casos de ponto extra), a nota será truncada._"));

   

     $query = "select  distinct(titulo), avaliacoes.id, avaliacoes.bimestre, avaliacoes.data_hora, valor from avaliacoes inner join disciplinas on (disciplinas.id = avaliacoes.disciplina_id) 
     	inner join notas on (avaliacoes.id = notas.avaliacao_id)
     	where disciplinas.id = $1 order by avaliacoes.bimestre desc, avaliacoes.data_hora desc";
    // die($query);
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);


	if (pg_affected_rows($result) > 0){

		echo "<br><br>";

    	echo "### Trabalhos Avaliados (computados até o momento) <br> <br>";

	

		while($registro = pg_fetch_array($result)){

			$sql = "select (select count(*) as t from notas 
			where avaliacao_id = $1 and comentario = '<br>' and obtido = 0),
			(select count(*) as v from notas where avaliacao_id = $2)";
			// $x = pg_query($sql);
			$x = pg_query_params($conexao, $sql, array($registro['id'], $registro['id'])) or die ($sql);

			$linhas = pg_fetch_array($x);
            if ($linhas['t'] != $linhas['v']) {
                echo "* ".(($registro['bimestre'] != 0) ? $registro['bimestre']."º bim. - " : "").$registro['titulo']." (".$registro['valor'].")<br><br>";
            }
		}		
	}



   echo "</body> </html>";



?>