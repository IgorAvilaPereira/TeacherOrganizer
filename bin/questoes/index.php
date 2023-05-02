<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	// paginacao
	if (isset($_GET["page"])) { $page  = $_GET["page"]; } else { $page=1; }; 
	$records = 20; // altere aqui o numero de registros por pagina
	$start_from = ($page-1) * $records;
	// $qry = pg_query("select count(*) as total from questoes"); 
	$qry = pg_query_params($conexao, "select count(*) as total from questoes", array()) or die ("select count(*) as total from questoes");

	$row_sql = pg_fetch_row($qry); 
	$total_records = $row_sql[0]; 
	$total_pages = ceil($total_records / $records);


	$template = new Template("../../view/questoes/index.html");	
	$sql = "select * FROM questoes order by id desc;";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	if (!isset($_POST['busca'])) {
		$sql = "select * FROM questoes order by id desc limit $records offset $start_from";		
	} else {
		$sql = "select * FROM questoes where questao ilike '%".$_POST['busca']."%'order by id desc -- limit $records offset $start_from";		
	}
	// $result = pg_query($sql) or die($sql);
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	while ($registro = pg_fetch_array($result)){
		$template->questao = (substr(strip_tags($registro['questao']), 0, 100))."...";
		$template->resposta = ($registro['resposta']);
		$template->id = $registro['id'];
		$template->block("questoes");
	}	
	// paginacao
	$html_paginacao = "";
	for ($i=1; $i<=$total_pages; $i++) { 
		$html_paginacao.= "<a href='../../bin/questoes/index.php?page=".$i."' ".(($page == $i) ? "class='btn btn-primary'" : "class='btn btn-default'").">".$i."</a>&nbsp;&nbsp;"; 
	}	
	$template->html_paginacao = $html_paginacao;
	$template->show();
?>