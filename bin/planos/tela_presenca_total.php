<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;

   $template = new Template("../../view/planos/tela_presenca_total.html");
   $template->disciplina_id = $_GET['disciplina_id'];
   // $query = "select * from planos where disciplina_id = ".$_GET['disciplina_id']." order by data desc;";
   // die($query);
   $query = "select distinct planos.data, planos.texto, presencas.creditos from planos inner join presencas on (planos.data = presencas.data) where planos.disciplina_id = ".$_GET['disciplina_id']." order by planos.data desc;";
   // $result = pg_query($query);
   $result = pg_query_params($conexao, $query, array()) or die ($query);
	
   while ($registro = pg_fetch_array($result)) {      
      $template->data_formatada = explode("-",$registro['data'])[2]."/".explode("-",$registro['data'])[1]."/".explode("-",$registro['data'])[0];
      $template->data = $registro['data'];      
      $template->texto = $registro['texto'];
      $template->creditos = $registro['creditos'];
     
      $query = "SELECT alunos.id, alunos.matricula, alunos.nome, presencas.resultado FROM alunos inner join presencas on (presencas.aluno_id = alunos.id) WHERE presencas.data = '".$registro['data']."' and alunos.disciplina_id = ".$_GET['disciplina_id']." order by alunos.matricula";
      // $result_alunos = pg_query($query);	
      $result_alunos = pg_query_params($conexao, $query, array()) or die ($query);



      while ($registro = pg_fetch_array($result_alunos)) {
         $template->id = $registro['id'];
         $template->matricula = $registro['matricula'];
         $template->nome = $registro['nome'];
         $template->resultado = (($registro['resultado'] == 1) ? 'checked' : '');
         $template->block("alunos");
      }
      $template->block("presencas");
   }
	$template->show();
?>