<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";

	$template = new Template("../../view/alunos/lista_optativa.html");

	$query = "select * from disciplinas where id = $1";
	// $resultado = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
	//pg_set_client_encoding($conexao, "iso-8859-1");

	$disciplina = pg_fetch_array($result);
	$template->disciplina = $disciplina['nome'];
	$bimestres = (($disciplina['eh_semestral'] == 't') ? 2 : 4);

	
	$query = "select * from alunos where disciplina_id = $1 order by matricula";
	// $resultado = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	//while ($aluno = pg_fetch_array($resultado)){
	//	$template->matricula = $aluno['matricula'];
	//	$template->nome = strtoupper($aluno['nome']);
	//	$template->block("alunos");		
	//}

	$mes = explode("/",date("Y/m/d"))[1];
	// eh primeiro semestre? entao a 
	if ($bimestres == 4){
		if ($mes <= 7){
			$template->bim1 = "1 bim";
			$template->bim2 = "2 bim";			
			
			$query = "select * from avaliacoes where da_substitutiva = TRUE AND disciplina_id = $1 and bimestre = 1";
			// $result =  pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
			if (pg_affected_rows($result) > 0 ){
				$registro = pg_fetch_array($result);
				$template->valor1 = $registro['valor'];
			} else {
				$template->valor1 = "10";
			}


			$query = "select * from avaliacoes where da_substitutiva = TRUE AND disciplina_id = $1 and bimestre = 2";
			// $result =  pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
			if (pg_affected_rows($result) > 0 ){
				$registro = pg_fetch_array($result);
				$template->valor2 = $registro['valor'];
			} else {
				$template->valor2 = "10";
			}				
		} else {
			$query = "select * from avaliacoes where da_substitutiva = TRUE AND disciplina_id = $1 and bimestre = 3";
			// $result =  pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
			if (pg_affected_rows($result) > 0 ){
				$registro = pg_fetch_array($result);
				$template->valor1 = $registro['valor'];
			} else {
				$template->valor1 = "10";
			}

			$query = "select * from avaliacoes where da_substitutiva = TRUE AND disciplina_id = $1 and bimestre = 4";
			// $result =  pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
			if (pg_affected_rows($result) > 0 ){
				$registro = pg_fetch_array($result);
				$template->valor2 = $registro['valor'];
			} else {
				$template->valor2 = "10";
			}

			$template->bim1 = "3 bim";
			$template->bim2 = "4 bim";	
		}
	} else {
		$query = "select * from avaliacoes where da_substitutiva = TRUE AND disciplina_id = $1 and bimestre = 1";
			// $result =  pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
			if (pg_affected_rows($result) > 0 ){
				$registro = pg_fetch_array($result);
				$template->valor1 = $registro['valor'];
			} else {
				$template->valor1 = "10";
			}

			$query = "select * from avaliacoes where da_substitutiva = TRUE AND disciplina_id = $1 and bimestre = 2";
			// $result =  pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
			if (pg_affected_rows($result) > 0 ){
				$registro = pg_fetch_array($result);
				$template->valor2 = $registro['valor'];
			} else {
				$template->valor2 = "10";
			}
		$template->bim1 = "1 bim";
		$template->bim2 = "2 bim";
	}

	//$template->valor1 = "";
	//$template->valor2 = "";

	$query = "select * from alunos where disciplina_id = $1";
			// $result =  pg_query($query);
			$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
	while ($aluno = pg_fetch_array($result)){
		$template->matricula = $aluno['matricula'];
		$template->nome = strtoupper($aluno['nome']);
		$template->block("alunos");		
	}	
	$template->show();

	// gerando o pdf
	//$html2pdf = new HTML2PDF('P','A4','pt', false, 'ISO-8859-15', 2);
    //$html2pdf->WriteHTML($template->parse()); 
    //$html2pdf->Output('ata_recuperacao_paralela.pdf');
	// echo $template->parse();

?>