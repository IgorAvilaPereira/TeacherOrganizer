<?php

// All file is writen in UTF-8
require_once './../src/ods.php';
require_once './../src/odsTable.php';
require_once './../src/odsTableCell.php';
require_once './../src/odsTableColumn.php';
require_once './../src/odsTableRow.php';
require_once './../src/odsFontFace.php';
require_once './../src/odsStyle.php';

use odsPhpGenerator\ods;
use odsPhpGenerator\odsTable;
use odsPhpGenerator\odsTableRow;
use odsPhpGenerator\odsTableCellString;
use odsPhpGenerator\odsTableCellFloat;


// Create Ods object
$ods  = new ods();

// Create table named 'table 1'
$table = new odsTable('table 1');

// Create the first row
$row   = new odsTableRow();

// Create and add 2 cell 'Hello' and 'World'
$row->addCell( new odsTableCellString("42622") );
$row->addCell( new odsTableCellString("teste") );
$row->addCell( new odsTableCellFloat(1) );
$row->addCell( new odsTableCellFloat(2) );
$cell = new odsTableCellString("");
$row->addCell( $cell );
$cell->setFormula('sum(C1:D4)');

// Attach row to table
$table->addRow($row);

// Attach talble to ods
$ods->addTable($table);

// Download the file
$ods->downloadOdsFile("HelloWorld.ods");


?>
