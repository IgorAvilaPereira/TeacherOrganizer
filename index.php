<?php
	require_once "lib/conexao.php";	

	if (!isset($_SESSION['dump'])){
		$_SESSION['dump'] = 1;
		// gera o dump do dia
    	dump();
    	// encaminha por email
    	//email();
    }
	header("Location: bin/cursos/index.php");
?>
