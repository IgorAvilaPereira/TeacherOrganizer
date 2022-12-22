<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/TextTable.php";

	// Funcionando, mas n valeu muito a pena pois demora um pouco mais 
	// tem um botao la em ver.html para rodar.

	$query = "select * from disciplinas where id = ".$_GET['id_disciplina'];	
	$result = pg_query($query);	
	$registro = pg_fetch_array($result);
	
//	$template->id_disciplina = $registro['id'];

	//$template->nome_disciplina = utf8_decode($registro['nome']);
	$disciplina_id = $registro['id'];
	$disciplina = $registro['nome'];
	$ssh_wiki = $registro['ssh_wiki'];
	$ano_semestre = $registro['ano']."/".$registro['semestre'];

	//$template->ano = $registro['ano'];
	//$template->semestre = $registro['semestre'];
	//$template->creditos = $registro['creditos'];
	//$creditos = (($registro['creditos'] > 0)? $registro['creditos']: 1);
	//$template->creditos_por_dia = $registro['creditos_por_dia'];	
	//$creditos_por_dia = (($registro['creditos_por_dia'] > 0)? $registro['creditos_por_dia']: $registro['creditos']);
	//$template->eh_semestral = (($registro['eh_semestral'] == 't' )?  'Semestral': 'Anual');
	//$eh_semestral = (($registro['eh_semestral'] == 't') ?  'Semestral': 'Anual');
	
	$columns = ["Matrícula", "Exame", "1bim.", "2bim."];	
	if (!($registro['eh_semestral'] == 't')){
		$columns[] = "3bim.";
		$columns[] = "4bim.";
	}

	$query =  "SELECT 
		alunos.matricula AS matricula, 
		avaliacoes.bimestre AS periodo, 
		'-' AS nota 
		FROM alunos 
			INNER JOIN avaliacoes 
				ON (alunos.disciplina_id = avaliacoes.disciplina_id) 
			WHERE alunos.disciplina_id = ".$_GET['id_disciplina']."
		GROUP BY 
			alunos.matricula, avaliacoes.bimestre
		ORDER BY 
			alunos.matricula;";

	$result = pg_query($query);	
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
		avaliacoes.disciplina_id = ".$_GET['id_disciplina']."
	GROUP BY 
		alunos.matricula, 
		avaliacoes.bimestre";

	$result = pg_query($query);	
	if (pg_affected_rows($result) > 0){
		while($registro = pg_fetch_array($result)){
			$rows[$registro['matricula']][$registro['periodo']] = $registro['nota'];
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
	//$conteudo $t->render(['extra2' => ['g','h','i']]);
	$t->setAlgin(['L', 'C', 'R']);
	//$conteudo \PHP_EOL;
	//$conteudo $t->render();
		
	// exibindo markdown para download
    // header("Content-Type: plain/text");
    // header("Content-disposition: attachment; filename=notas.md");
    // header("Content-Transfer-Encoding: binary");
    // header("Pragma: no-cache");
    // header("Expires: 0");
    
    // $conteudo utf8_decode("### ".utf8_encode($disciplina)." - ".$ano_semestre."\n\n".$t->render());  


	// $conteudo "<html> <head> <title> ".$disciplina." - ".$ano_semestre." - Notas Markdown </title> </head> <body>";
    
    $conteudo = utf8_decode("## ".utf8_encode($disciplina)." - ".$ano_semestre."\n\n **Atualiza&ccedil;&atilde;o:** ".date("d/m/Y - H:i:s")."\n\n".utf8_encode($t->render())."\n".utf8_encode("_* No SIA, notas com duas casas decimais serão arredondadas para uma casa decimal._ \n \n _* No SIA, em situações onde ultrapassar a nota máxima (casos de ponto extra), a nota será truncada._"));

        $query = "select distinct(titulo), avaliacoes.bimestre, avaliacoes.data_hora, valor from avaliacoes inner join disciplinas on (disciplinas.id = avaliacoes.disciplina_id) 
     	inner join notas on (avaliacoes.id = notas.avaliacao_id)
     	where disciplinas.id = ".$_GET['id_disciplina']." order by avaliacoes.bimestre desc, avaliacoes.data_hora desc";
    $result = pg_query($query);	

	if (pg_affected_rows($result) > 0){
		$conteudo.= "\n\n";
    	$conteudo.="### Trabalhos Avaliados (computados até o momento) \n\n";
		while($registro = pg_fetch_array($result)){
			$conteudo.= "* ".(($registro['bimestre'] != 0) ? $registro['bimestre']."º bim. - " : "").$registro['titulo']." (".$registro['valor'].")\n\n";
		}		
	}		
	
	if (!empty($ssh_wiki) && strlen($ssh_wiki)>0) {
		$ssh_wiki = str_replace(URL_GIT, "", $ssh_wiki);
		$ssh_wiki = str_replace(".git", "", $ssh_wiki);
		$cmd = "cd ".DIR_GIT.$ssh_wiki."/ && git pull";
		$output = shell_exec($cmd);		
		if (file_exists(DIR_GIT.$ssh_wiki) !== false) {
			$arquivo = fopen(DIR_GIT.$ssh_wiki."/Notas.md", "w");
			fwrite($arquivo, $conteudo);	
			$cmd = "cd ".DIR_GIT.$ssh_wiki."/ && git add * && git commit -m 'notas.md:".date("d/m/Y - H:i:s")."' && git push";
			shell_exec($cmd);			
			fclose($arquivo);
			echo "<h2> Arquivo Notas.md atualizado com sucesso!!!! </h2>";
		 }
		 else {
             $cmd = "cd ".DIR_GIT." && git clone ".URL_GIT_SSH.$ssh_wiki.".git";
             $output = shell_exec($cmd);
             //if (file_exists(DIR_LOCAL_GIT.$ssh_wiki."/Notas.md") !== false) {
                 $arquivo = fopen(DIR_GIT.$ssh_wiki."/Notas.md", "w");
                 fwrite($arquivo, $conteudo);
                 $cmd = "cd ".DIR_GIT.$ssh_wiki."/ && git add * && git commit -m 'notas.md:".date("d/m/Y - H:i:s")."' && git push";
                 shell_exec($cmd);
                 fclose($arquivo);
                 echo "<h2> Arquivo Notas.md atualizado com sucesso!!!! </h2>";
             /*} else {
				echo "<h2> Erro. Permita git clone por ssh em seu computador!!!! </h2>";
			 }*/
         }
	} else {
		echo "<h1>Erro:</h1><br>";
		echo "<h2> <ol> <li> Cria a wiki no github</li> <li> Preencha o campo SSH_WIKI da disciplina!!!</li></ol></h2>";
		echo "<a href='tela_alterar.php?id=".$disciplina_id."'> Alterar </a> <br><br>";
	}
	echo "<a href='javascript: history.go(-1)'> Voltar </a>";
			
?>