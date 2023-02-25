# Teacher Organizer

Sistema de Gerenciamento para Professores

## Requisitos:

* PHP 8
* PostgreSQL
* php-pgsql 
* Bootstrap

## Instalação:

1) Restaurar ***dump*** no PostgreSQL:

No terminal:
```sh
psql -h localhost -U postgres
\i docente22122022.sql
```
2) Iniciar o Teacher Organizer:

No terminal:
```sh
./start.sh
```

3) Acessar http://localhost:8081


## Observações:

* Desenvolvido no Linux Mint 21 x86_64 
* PHP 8.1.2
* PostgreSQL 14.5
* Ajustar o php.ini para receber arquivos via upload

