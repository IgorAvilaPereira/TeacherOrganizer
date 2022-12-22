<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	ob_start();
	//pg_set_client_encoding($conexao, "iso-8859-1");

	$template = new Template("../../view/planos/index_relatorio.html");
	
	$query = "select *, cursos.nome as curso, disciplinas.nome as disciplina from disciplinas inner join cursos on (disciplinas.curso_id = cursos.id) where disciplinas.id = ".$_GET['id_disciplina'];
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array()) or die ($query);

	//pg_set_client_encoding($conexao, "iso-8859-1");
	$registro = pg_fetch_array($result);	
	
	$template->curso = $registro['curso'];
	$template->disciplina = utf8_decode($registro['disciplina']);
	//$template->id_disciplina = $_GET['id_disciplina'];
	$template->semestre = $registro['semestre'];
	$template->ano = $registro['ano'];
	
	$sql = "select *, planos.id as id from planos inner join disciplinas on (disciplinas.id = planos.disciplina_id) where disciplina_id = ".$_GET['id_disciplina']." ORDER BY data desc";
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	while ($registro = pg_fetch_array($result)){
		$template->texto = nl2br(utf8_decode($registro['texto']));
		$data = explode("-", $registro['data']);
		$template->data = $data[2]."/".$data[1]."/".$data[0];
		$template->bimestre = $registro['bimestre'];
		
	//	$template->id = $registro['id'];

		$sqlCreditos = "SELECT creditos FROM presencas WHERE data = '".$registro['data']."' and disciplina_id = ".$_GET['id_disciplina']." limit 1;";
		// $resultadoCreditos = pg_query($sqlCreditos);
		$resultadoCreditos = pg_query_params($conexao, $sqlCreditos, array()) or die ($sqlCreditos);

		$registroCreditos = pg_fetch_array($resultadoCreditos);
		$template->creditos = $registroCreditos['creditos'];
		$template->block("planos");
	}	
	//$html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
    //$html2pdf->WriteHTML($template->parse());
    echo utf8_encode($template->parse());
    //pg_set_client_encoding($conexao, "UTF-8");
    //$html2pdf->Output('diario_classe.pdf');	
	//$template->show();
?>