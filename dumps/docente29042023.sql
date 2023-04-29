--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

-- Started on 2023-04-29 10:22:39 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE docente;
--
-- TOC entry 3527 (class 1262 OID 52781)
-- Name: docente; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE docente WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE docente OWNER TO postgres;

\connect docente

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 52782)
-- Name: alternativas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alternativas (
    id integer NOT NULL,
    descricao text,
    certa boolean,
    questao_id integer
);


ALTER TABLE public.alternativas OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 52787)
-- Name: alternativas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alternativas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alternativas_id_seq OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 210
-- Name: alternativas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alternativas_id_seq OWNED BY public.alternativas.id;


--
-- TOC entry 211 (class 1259 OID 52788)
-- Name: alunos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alunos (
    id integer NOT NULL,
    nome text,
    matricula text,
    disciplina_id integer,
    observacao text
);


ALTER TABLE public.alunos OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 52793)
-- Name: alunos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alunos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alunos_id_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 212
-- Name: alunos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alunos_id_seq OWNED BY public.alunos.id;


--
-- TOC entry 213 (class 1259 OID 52794)
-- Name: anotacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anotacoes (
    id integer NOT NULL,
    anotacao text,
    disciplina_id integer
);


ALTER TABLE public.anotacoes OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 52799)
-- Name: anotacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.anotacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.anotacoes_id_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 214
-- Name: anotacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.anotacoes_id_seq OWNED BY public.anotacoes.id;


--
-- TOC entry 215 (class 1259 OID 52800)
-- Name: avaliacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacoes (
    id integer NOT NULL,
    titulo text,
    descricao text,
    valor real,
    disciplina_id integer,
    bimestre integer,
    data_hora timestamp without time zone,
    da_substitutiva boolean DEFAULT false,
    corrigida boolean DEFAULT false
);


ALTER TABLE public.avaliacoes OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN avaliacoes.da_substitutiva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.avaliacoes.da_substitutiva IS 'a avaliacao utilizada pra uma futura substitutiva ';


--
-- TOC entry 216 (class 1259 OID 52807)
-- Name: avaliacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avaliacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.avaliacoes_id_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 216
-- Name: avaliacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.avaliacoes_id_seq OWNED BY public.avaliacoes.id;


--
-- TOC entry 217 (class 1259 OID 52808)
-- Name: creditos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.creditos (
    id integer NOT NULL,
    disciplina_id integer,
    nr_creditos integer,
    dia_semana integer
);


ALTER TABLE public.creditos OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN creditos.dia_semana; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.creditos.dia_semana IS '0 = > Domingo 1 => Segunda 2 => Terça ... ... 6 => Sábado';


--
-- TOC entry 218 (class 1259 OID 52811)
-- Name: creditos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.creditos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.creditos_id_seq OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 218
-- Name: creditos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.creditos_id_seq OWNED BY public.creditos.id;


--
-- TOC entry 219 (class 1259 OID 52812)
-- Name: cursos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cursos (
    id integer NOT NULL,
    nome text
);


ALTER TABLE public.cursos OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 52817)
-- Name: cursos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cursos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cursos_id_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 220
-- Name: cursos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cursos_id_seq OWNED BY public.cursos.id;


--
-- TOC entry 221 (class 1259 OID 52818)
-- Name: disciplinas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplinas (
    id integer NOT NULL,
    nome text,
    creditos integer,
    curso_id integer,
    ano integer,
    semestre integer,
    ementa text,
    creditos_por_dia real,
    eh_semestral boolean DEFAULT true,
    email text,
    programa text,
    bibliografia text,
    codigo_ifrs integer,
    carga_horaria double precision,
    serie_semestre_curso integer,
    objetivos text,
    horario_atendimento text,
    recuperacao_paralela text,
    horario_aulas_sincronas text,
    metodologia text,
    avaliacao text,
    ssh_wiki text
);


ALTER TABLE public.disciplinas OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 52824)
-- Name: disciplinas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.disciplinas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplinas_id_seq OWNER TO postgres;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 222
-- Name: disciplinas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.disciplinas_id_seq OWNED BY public.disciplinas.id;


--
-- TOC entry 223 (class 1259 OID 52825)
-- Name: tabela_nota_exame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabela_nota_exame (
    id integer NOT NULL,
    somatorio real,
    precisa real,
    modalidade text
);


ALTER TABLE public.tabela_nota_exame OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 52830)
-- Name: nota_exame2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nota_exame2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nota_exame2_id_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 224
-- Name: nota_exame2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nota_exame2_id_seq OWNED BY public.tabela_nota_exame.id;


--
-- TOC entry 225 (class 1259 OID 52831)
-- Name: notas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notas (
    id integer NOT NULL,
    obtido real,
    avaliacao_id integer,
    aluno_id integer,
    comentario text,
    arquivo text
);


ALTER TABLE public.notas OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 52836)
-- Name: notas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notas_id_seq OWNER TO postgres;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 226
-- Name: notas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notas_id_seq OWNED BY public.notas.id;


--
-- TOC entry 227 (class 1259 OID 52837)
-- Name: planos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planos (
    id integer NOT NULL,
    data date,
    texto text,
    disciplina_id integer,
    bimestre integer DEFAULT 1
);


ALTER TABLE public.planos OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 52843)
-- Name: planos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planos_id_seq OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 228
-- Name: planos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planos_id_seq OWNED BY public.planos.id;


--
-- TOC entry 229 (class 1259 OID 52844)
-- Name: presencas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.presencas (
    id integer NOT NULL,
    data date,
    aluno_id integer,
    disciplina_id integer,
    resultado integer,
    bimestre integer DEFAULT 1,
    creditos integer
);


ALTER TABLE public.presencas OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 52848)
-- Name: presencas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.presencas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.presencas_id_seq OWNER TO postgres;

--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 230
-- Name: presencas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.presencas_id_seq OWNED BY public.presencas.id;


--
-- TOC entry 231 (class 1259 OID 52849)
-- Name: provas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provas (
    id integer NOT NULL,
    exercicios text,
    gabarito text,
    data_hora timestamp without time zone,
    nome text
);


ALTER TABLE public.provas OWNER TO postgres;

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN provas.data_hora; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.provas.data_hora IS 'Data';


--
-- TOC entry 232 (class 1259 OID 52854)
-- Name: provas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provas_id_seq OWNER TO postgres;

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 232
-- Name: provas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provas_id_seq OWNED BY public.provas.id;


--
-- TOC entry 233 (class 1259 OID 52855)
-- Name: questoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questoes (
    id integer NOT NULL,
    questao text,
    resposta text
);


ALTER TABLE public.questoes OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 52860)
-- Name: questoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questoes_id_seq OWNER TO postgres;

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 234
-- Name: questoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questoes_id_seq OWNED BY public.questoes.id;


--
-- TOC entry 235 (class 1259 OID 52861)
-- Name: questoes_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questoes_tags (
    id integer NOT NULL,
    questao_id integer,
    tag_id integer
);


ALTER TABLE public.questoes_tags OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 52864)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag text
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 52869)
-- Name: questoes_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questoes_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questoes_tags_id_seq OWNER TO postgres;

--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 237
-- Name: questoes_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questoes_tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 238 (class 1259 OID 52870)
-- Name: questoes_tags_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questoes_tags_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questoes_tags_id_seq1 OWNER TO postgres;

--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 238
-- Name: questoes_tags_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questoes_tags_id_seq1 OWNED BY public.questoes_tags.id;


--
-- TOC entry 3277 (class 2604 OID 52871)
-- Name: alternativas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alternativas ALTER COLUMN id SET DEFAULT nextval('public.alternativas_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 52872)
-- Name: alunos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alunos ALTER COLUMN id SET DEFAULT nextval('public.alunos_id_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 52873)
-- Name: anotacoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anotacoes ALTER COLUMN id SET DEFAULT nextval('public.anotacoes_id_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 52874)
-- Name: avaliacoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacoes ALTER COLUMN id SET DEFAULT nextval('public.avaliacoes_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 52875)
-- Name: creditos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creditos ALTER COLUMN id SET DEFAULT nextval('public.creditos_id_seq'::regclass);


--
-- TOC entry 3284 (class 2604 OID 52876)
-- Name: cursos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos ALTER COLUMN id SET DEFAULT nextval('public.cursos_id_seq'::regclass);


--
-- TOC entry 3286 (class 2604 OID 52877)
-- Name: disciplinas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas ALTER COLUMN id SET DEFAULT nextval('public.disciplinas_id_seq'::regclass);


--
-- TOC entry 3288 (class 2604 OID 52878)
-- Name: notas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas ALTER COLUMN id SET DEFAULT nextval('public.notas_id_seq'::regclass);


--
-- TOC entry 3290 (class 2604 OID 52879)
-- Name: planos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planos ALTER COLUMN id SET DEFAULT nextval('public.planos_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 52880)
-- Name: presencas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presencas ALTER COLUMN id SET DEFAULT nextval('public.presencas_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 52881)
-- Name: provas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provas ALTER COLUMN id SET DEFAULT nextval('public.provas_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 52882)
-- Name: questoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questoes ALTER COLUMN id SET DEFAULT nextval('public.questoes_id_seq'::regclass);


--
-- TOC entry 3295 (class 2604 OID 52883)
-- Name: questoes_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questoes_tags ALTER COLUMN id SET DEFAULT nextval('public.questoes_tags_id_seq1'::regclass);


--
-- TOC entry 3287 (class 2604 OID 52884)
-- Name: tabela_nota_exame id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabela_nota_exame ALTER COLUMN id SET DEFAULT nextval('public.nota_exame2_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 52885)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.questoes_tags_id_seq'::regclass);


--
-- TOC entry 3492 (class 0 OID 52782)
-- Dependencies: 209
-- Data for Name: alternativas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3494 (class 0 OID 52788)
-- Dependencies: 211
-- Data for Name: alunos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.alunos VALUES (1103, 'ALUNO 1', '11030181', 73, '');
INSERT INTO public.alunos VALUES (1104, 'ALUNO 2', '11030207', 73, '');
INSERT INTO public.alunos VALUES (1240, 'ALUNO 1', '2015001204', 123, '');
INSERT INTO public.alunos VALUES (1239, 'ALUNO 2', '2017006068', 123, '');
INSERT INTO public.alunos VALUES (1251, 'ALUNO 1', '2016002430', 122, '');
INSERT INTO public.alunos VALUES (1248, 'ALUNO 2', '2019012467', 122, '');
INSERT INTO public.alunos VALUES (1247, 'ALUNO 3', '2019012500', 122, '');
INSERT INTO public.alunos VALUES (1250, 'ALUNO 4', '2021006841', 122, '');


--
-- TOC entry 3496 (class 0 OID 52794)
-- Dependencies: 213
-- Data for Name: anotacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.anotacoes VALUES (84, ' sadfsdaf', 122);


--
-- TOC entry 3498 (class 0 OID 52800)
-- Dependencies: 215
-- Data for Name: avaliacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.avaliacoes VALUES (905, 'Atividade 1', '<br>', 10, 123, 1, '2022-12-12 18:50:00', false, false);
INSERT INTO public.avaliacoes VALUES (906, 'Atividade 2', '<br>', 10, 123, 2, '2022-12-12 18:50:00', false, false);
INSERT INTO public.avaliacoes VALUES (907, 'Exame', '<br>', 10, 123, 0, '2022-12-12 18:50:00', false, false);
INSERT INTO public.avaliacoes VALUES (908, 'Exame', '<br>', 10, 73, 0, '2022-12-12 13:51:00', false, false);
INSERT INTO public.avaliacoes VALUES (909, 'Atividade 1', '<br>', 10, 73, 1, '2022-12-12 13:51:00', false, false);
INSERT INTO public.avaliacoes VALUES (910, 'Atividade 2', '<br>', 10, 73, 2, '2022-12-12 18:50:00', false, false);
INSERT INTO public.avaliacoes VALUES (911, 'Atividade 3', '<br>', 10, 73, 3, '2022-12-21 00:00:00', false, false);
INSERT INTO public.avaliacoes VALUES (912, 'Atividade 4', '<br>', 10, 73, 4, '2022-12-21 00:00:00', false, false);
INSERT INTO public.avaliacoes VALUES (913, 'Exame', '<br>', 10, 122, 0, '2022-12-22 00:00:00', false, false);
INSERT INTO public.avaliacoes VALUES (914, 'Atividade 1', '<br>', 10, 122, 1, '2022-12-22 00:00:00', true, false);
INSERT INTO public.avaliacoes VALUES (915, 'Atividade 2', '<br>', 10, 122, 2, '2022-12-22 00:00:00', false, false);
INSERT INTO public.avaliacoes VALUES (916, NULL, NULL, NULL, 126, NULL, NULL, false, false);
INSERT INTO public.avaliacoes VALUES (917, 'Exame', '<br>', 10, 127, 0, NULL, false, false);


--
-- TOC entry 3500 (class 0 OID 52808)
-- Dependencies: 217
-- Data for Name: creditos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.creditos VALUES (187, 123, 4, 3);
INSERT INTO public.creditos VALUES (188, 122, 4, 2);
INSERT INTO public.creditos VALUES (190, 73, 4, 5);
INSERT INTO public.creditos VALUES (191, 126, 4, 5);
INSERT INTO public.creditos VALUES (192, 127, 4, 5);


--
-- TOC entry 3502 (class 0 OID 52812)
-- Dependencies: 219
-- Data for Name: cursos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cursos VALUES (1, 'Nível Técnico');
INSERT INTO public.cursos VALUES (2, 'Nível Graduação');


--
-- TOC entry 3504 (class 0 OID 52818)
-- Dependencies: 221
-- Data for Name: disciplinas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.disciplinas VALUES (123, 'Disciplina 1', 4, 2, 2022, 2, 'Modelo relacional. Linguagem para definição, manipulação e consulta de
dados. Normalização. Noções de programação em bancos de dados.', 4, true, '', '1º Bim.
    • Modelo Relacional
    • Dicionário de Dados
    • Conversão entre Modelos ER e Relacional - Herança
    • SQL: CREATE DATABASE, CREATE TABLE, PK, FK, INSERT, DELETE, UPDATE e SELECT (Básico) e etc.
    • SQL: JOIN''s
    • SQL: union, intersect e except
2º Bim.
    • views
    • schemas
    • Herança em Bancos Relacionais (caso especial PostgreSQL)
    • pgAdmin
    • DCL: Comandos relacionados ao controle de segurança em BD''s Relacionais
    • Normalização', 'Bibliografia básica
● DATE, C. J. Introdução a sistemas de bancos de dados. Rio de
Janeiro, RJ: Elsevier, c2004. [xxiv], 865 p. ISBN 9788535212730.
● SILBERSCHATZ, Abraham; KORTH, Henry F.; SUDARSHAN, S. Sistema de
banco de dados. Rio de Janeiro, RJ: Elsevier, 2006. xxiii, 781 p. ISBN
8535211071.
● ELMASRI, Ramez; NAVATHE, Sham. Sistemas de banco de dados. 6.
ed. São Paulo, SP: Pearson Education do Brasil, c2011. xviii, 788 p. ISBN
9788579360855.

Bibliografia complementar
● HEUSER, Carlos Alberto. Projeto de banco de dados. 6. ed. Porto
Alegre, RS: Bookman, 2009. 282 p. (Livros didáticos informática UFRGS;
4). ISBN 9788577803828.
● GONZAGA, Jorge Luiz. Dominando o PostgreSQL: incluindo curso
completo da linguagem SQL. Rio de Janeiro, RJ: Ciência Moderna, 2007.
xiii, 228p. ISBN 9788573935592.
● MILANI, André. PostgreSQL: guia do programador. São Paulo, SP:
Novatec, c2008. 392 p. ISBN 9788575221570.
● ANGELOTTI, Elaini Simoni. Banco de dados. Curitiba, PR: Editora do Livro
Técnico, 2010. 119 p. ISBN 9788563687029.
● TAHAGHOGHI, Seyed M. M.; WILLIAMS, Hugh E. Aprendendo MySQL. Rio
de Janeiro, RJ: Alta Books, 2007. 523 p. ISBN 9788576081470.
● ROB, Peter; CORONEL, Carlos. Sistemas de banco de dados: projeto,
implementação e gerenciamento. Rio de Janeiro, RJ: Cengage Learning,
2011. xxi, 711 p. ISBN 8522107866.
● OLIVEIRA, Celso H. Poderoso de. SQL: curso prático. São Paulo, SP:
Novatec, c.2002. 272 p. ISBN 8575220241.', NULL, 66, 3, 'Implementar e manipular bancos de dados relacionais.  ', 'a) via e-mail/discord, b) nos encontros presenciais c) por demanda, em data e horário combinado entre professor e estudantes.', 'a) acompanhamento nas aulas e atendimentos,  
b) trabalhos e projeto final permitem a recuperação de conteúdos durante o componente e 
c) negociação do prazo de entrega, se possível.', '', '• Aulas Expositivas
    • Aulas Práticas
    • Trabalhos/Avaliações em grupo
    • Trabalhos/Avaliações individuais', 'A avaliação da aprendizagem deverá ocorrer ao longo da disciplina e no decorrer dos trabalhos. Haverá, durante a disciplina questionamentos, possibilitando aos alunos, quando for o caso, o retorno dos temas propostos anteriormente. Ao final de cada aula, materiais de apoio serão encaminhados para turma;
Pesos aproximados: 60% atividade presencial, 40% atividades extra-classe (trabalhos).', '');
INSERT INTO public.disciplinas VALUES (122, 'Disciplina 2', 4, 2, 2022, 2, 'Conceitos de projeto: hierarquia, abstração, modularização e
encapsulamento. Decisões de projeto quanto ao uso de herança,
composição e delegação. Princípios de projeto de software, como o SOLID
e outros. Refatoração. Padrões de projeto de software GoF e emergentes.
Anti-padrões. Noções de princípios e padrões de arquitetura.', 4, true, '', 'Revisão O.O
Introdução a Padrões de Projeto
Padrões de Projeto de Software: Criacional
Padrões de Projeto de Software: Comportamental
Padrões de Projeto de Software: Estrutural
Testes Unitários
Boas Práticas de Programação', 'Bibliografia básica
● GAMMA, Erich et al. Padrões de projeto: soluções reutilizáveis de
software orientado a objetos. Porto Alegre, RS: Bookman, 2000. xii, 364 p.
ISBN 9788573076103.
● KERIEVSKY, Joshua. Refatoração para padrões. Porto Alegre, RS:
Bookman, 2008. 400p. ISBN 9788577802449.
● MARTIN, Robert C. Princípios, padrões e práticas ágeis em C#. Porto Alegre, RS: Bookman, 2011. 735 p. ISBN 9788577808410.

Bibliografia complementar
● EVANS, Eric. Domain-Driven Design: atacando as complexidades no
coração do software. 3.ed. Rio de Janeiro, RJ : Alta Books, 2016. 528
p.ISBN: 9788550800653.
● LARMAN, Craig. Utilizando UML e padrões: uma introdução à análise e
ao projeto orientados a objetos e ao desenvolvimento iterativo. 3. ed.
Porto Alegre, RS: Bookman, 2007. 695 p. ISBN 9788560031528.
● MARTIN, Robert C. et al. Código Limpo: habilidades práticas do Agile
Software. Rio de Janeiro, RJ: Alta Books, 2011. 422 p. ISBN
9788576082675.
● FREEMAN, Eric; FREEMAN, Elizabeth. Padrões de projetos: design
patterns. 2. ed. rev. Rio de Janeiro, RJ: Alta Books, 2009. XXIV, 478 p. (Use
a Cabeça!). ISBN 9788576081746.
● FOWLER, Martin; BECK, Kent; BRANT, John; OPDYKE, William; ROBERTS,
Don. Refatoração: aperfeiçoando o projeto de código existente. Porto
Alegre, RS: Bookman, 2004. 365 p. ISBN 8536303956.', NULL, 66, 4, 'Projetar e implementar sistemas considerando os princípios e padrões de
projeto.', 'a) via e-mail/discord, b) nos encontros presenciais c) por demanda, em data e horário combinado entre professor e estudantes.', 'a) acompanhamento nas aulas e atendimentos,  
b) trabalhos e projeto final permitem a recuperação de conteúdos durante o componente e 
c) negociação do prazo de entrega, se possível.', '', '• Aulas Expositivas
    • Aulas Práticas
    • Trabalhos/Avaliações em grupo
    • Trabalhos/Avaliações individuais', 'A avaliação da aprendizagem deverá ocorrer ao longo da disciplina e no decorrer dos trabalhos. Haverá, durante a disciplina questionamentos, possibilitando aos alunos, quando for o caso, o retorno dos temas propostos anteriormente. Ao final de cada aula, materiais de apoio serão encaminhados para turma;
Pesos aproximados: 60% atividade presencial, 40% atividades extra-classe (trabalhos).', '');
INSERT INTO public.disciplinas VALUES (73, 'Disciplina 1', 4, 1, 2018, 1, 'Aplicações em diferentes plataformas de hardware e comunicação: desktops, web e dispositivos móveis (celulares e PDA''s). Sistemas em diferentes hardwares e plataformas computacionais: recursos, serviços para usuários locais e remotos. Integração de diferentes tecnologias para a disponibilização de serviços e facilidades. Tecnologias de desenvolvimento multifinalitárias e multiplataforma.', 4, false, '', '<!--[if gte mso 9]><xml><w:WordDocument><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery><w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery><w:DocumentKind>DocumentNotSpecified</w:DocumentKind><w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing><w:PunctuationKerning></w:PunctuationKerning><w:View>Normal</w:View><w:Compatibility><w:DontGrowAutofit/><w:BalanceSingleByteDoubleByteWidth/><w:DoNotExpandShiftReturn/></w:Compatibility><w:Zoom>0</w:Zoom></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml><w:LatentStyles DefLockedState="false"  DefUnhideWhenUsed="true"  DefSemiHidden="true"  DefQFormat="false"  DefPriority="99"  LatentStyleCount="260" >
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footer" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="caption" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of figures" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope return" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="line number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="page number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of authorities" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="macro" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toa heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Title" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Closing" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Default Paragraph Font" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Message Header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Subtitle" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Salutation" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Date" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Note Heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Block Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Hyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="FollowedHyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Strong" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Emphasis" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Document Map" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Plain Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="E-mail Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal (Web)" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Acronym" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Cite" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Code" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Definition" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Keyboard" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Preformatted" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Sample" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Typewriter" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Variable" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Table" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation subject" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="No List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Contemporary" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Elegant" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Professional" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Balloon Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Theme" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 6" ></w:LsdException>
</w:LatentStyles></xml><![endif]--><style>
@font-face{
font-family:"Times New Roman";
}

@font-face{
font-family:"宋体";
}

@font-face{
font-family:"Symbol";
}

@font-face{
font-family:"OpenSymbol";
}

@font-face{
font-family:"Arial";
}

@font-face{
font-family:"Tahoma";
}

@font-face{
font-family:"Luxi Sans";
}

@font-face{
font-family:"Liberation Mono";
}

@font-face{
font-family:"Courier New";
}

@font-face{
font-family:"Calibri";
}

@list l0:level1{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:36,0000pt;
mso-level-number-position:left;
margin-left:36,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level2{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:54,0000pt;
mso-level-number-position:left;
margin-left:54,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level3{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:72,0000pt;
mso-level-number-position:left;
margin-left:72,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level4{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:90,0000pt;
mso-level-number-position:left;
margin-left:90,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level5{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:108,0000pt;
mso-level-number-position:left;
margin-left:108,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level6{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:126,0000pt;
mso-level-number-position:left;
margin-left:126,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level7{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:144,0000pt;
mso-level-number-position:left;
margin-left:144,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level8{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:162,0000pt;
mso-level-number-position:left;
margin-left:162,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level9{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:180,0000pt;
mso-level-number-position:left;
margin-left:180,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

p.MsoNormal{
mso-style-name:Normal;
mso-style-parent:"";
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:11,0000pt;
}

p.MsoHeader{
mso-style-name:Cabeçalho;
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan no-line-numbers;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:8,0000pt;
}

p.NewStyle16{
mso-style-name:"Texto préformatado";
margin-top:0,0000pt;
margin-bottom:0,0000pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:''Liberation Mono'';
mso-fareast-font-family:''Courier New'';
font-size:10,0000pt;
}

span.msoIns{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:underline;
text-underline:single;
color:blue;
}

span.msoDel{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:line-through;
color:red;
}

table.MsoNormalTable{
mso-style-name:"Tabela normal";
mso-style-parent:"";
mso-style-noshow:yes;
mso-tstyle-rowband-size:0;
mso-tstyle-colband-size:0;
mso-padding-alt:0,0000pt 5,4000pt 0,0000pt 5,4000pt;
mso-para-margin:0pt;
mso-para-margin-bottom:.0001pt;
mso-pagination:widow-orphan;
font-family:''Times New Roman'';
font-size:10,0000pt;
mso-ansi-language:#0400;
mso-fareast-language:#0400;
mso-bidi-language:#0400;
}
@page{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}@page Section0{
}
div.Section0{page:Section0;}</style><!--StartFragment--><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">HTML</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CSS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">JS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">AJAX</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">PYTHON</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">FLASK</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">TEMPLATES</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CONECTIVIDADE COM O SGBD POSTGRES</span><o:p></o:p></p><!--EndFragment-->', '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">SANDERS,
Bill. Smashing HTML5: Técnicas para a Nova Geração</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">da
Web. Bookman, 2012. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">YANK,
Kevin E ADAMS, Cameron. Só JavaScript: Tudo o que você precisa
saber sobre JavaScript a partir do zero. Bookman, 2009. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">GOODMAN,
Dany. JavaScript e DHTML Guia Prático. 2a ed. Altabooks, 2008.</font></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Python
para Desenvolvedores</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf</font></font></font></a></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Flask</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="http://flask.pocoo.org/"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://flask.pocoo.org/</font></font></font></a></font><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">
</font></font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">HTML/CSS/JS</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://www.w3schools.com/</font></font></p>', NULL, 148, 4, '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<ul>
	<li>
<p class="western" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal;"><a name="docs-internal-guid-7dbb1c02-32ae-ea1a-cc"></a>
	<font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Colocar
	em prática os conhecimentos e habilidades adquiridos ao longo do
	curso como: Lógica de Programação, Desenvolvimento Baseado em
	Objetos, Engenharia de Software e Bancos de Dados.</font></font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Oferecer o “treinamento”
	necessário para que os alunos adquiram a competência de
	Programador Web Multidisciplinar.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Envolver os alunos em um
	ambiente profissional de desenvolvimento de software, fazendo com
	que tenham de desempenhar as suas atividades com profissionalismo e
	eficiência.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Propiciar o crescimento
	pessoal e amadurecimento através da apropriação de valores e
	atitudes, importantes para o egresso obter êxito em qual seja seu
	caminho após o curso.</font></p>
</li></ul>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
<font style="font-size: 10pt"><i>Especificamente na seguinte
estrutura CHA:</i></font></p>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Conhecimentos</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Arquitetura e bases da
	Internet e da Web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Linguagens e plataformas para
	desenvolvimento para Internet;</font></p>
</li></ul>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Habilidades</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber fazer:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Implementar princípios e
	padrões de projeto e implementação de front-ends para web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	back-ends de sistemas web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	subsistemas eficientes de acesso a bases de dados;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Integrar sistemas móveis,
	desktop e web usando protocolos de interoperação e arquitetura
	cliente/servidor;</font></p>
</li></ul>
<p class="western" style="margin-bottom: 0cm"><br>

</p>', '', '', '', '', '', '');
INSERT INTO public.disciplinas VALUES (125, 'DISCIPLINA 1 - 29/04/2023 - 10:16:29', 4, 1, 2023, 1, 'Aplicações em diferentes plataformas de hardware e comunicação: desktops, web e dispositivos móveis (celulares e PDA''s). Sistemas em diferentes hardwares e plataformas computacionais: recursos, serviços para usuários locais e remotos. Integração de diferentes tecnologias para a disponibilização de serviços e facilidades. Tecnologias de desenvolvimento multifinalitárias e multiplataforma.', 4, false, '', '<!--[if gte mso 9]><xml><w:WordDocument><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery><w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery><w:DocumentKind>DocumentNotSpecified</w:DocumentKind><w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing><w:PunctuationKerning></w:PunctuationKerning><w:View>Normal</w:View><w:Compatibility><w:DontGrowAutofit/><w:BalanceSingleByteDoubleByteWidth/><w:DoNotExpandShiftReturn/></w:Compatibility><w:Zoom>0</w:Zoom></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml><w:LatentStyles DefLockedState="false"  DefUnhideWhenUsed="true"  DefSemiHidden="true"  DefQFormat="false"  DefPriority="99"  LatentStyleCount="260" >
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footer" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="caption" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of figures" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope return" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="line number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="page number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of authorities" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="macro" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toa heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Title" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Closing" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Default Paragraph Font" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Message Header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Subtitle" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Salutation" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Date" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Note Heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Block Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Hyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="FollowedHyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Strong" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Emphasis" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Document Map" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Plain Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="E-mail Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal (Web)" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Acronym" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Cite" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Code" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Definition" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Keyboard" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Preformatted" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Sample" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Typewriter" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Variable" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Table" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation subject" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="No List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Contemporary" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Elegant" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Professional" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Balloon Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Theme" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 6" ></w:LsdException>
</w:LatentStyles></xml><![endif]--><style>
@font-face{
font-family:"Times New Roman";
}

@font-face{
font-family:"宋体";
}

@font-face{
font-family:"Symbol";
}

@font-face{
font-family:"OpenSymbol";
}

@font-face{
font-family:"Arial";
}

@font-face{
font-family:"Tahoma";
}

@font-face{
font-family:"Luxi Sans";
}

@font-face{
font-family:"Liberation Mono";
}

@font-face{
font-family:"Courier New";
}

@font-face{
font-family:"Calibri";
}

@list l0:level1{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:36,0000pt;
mso-level-number-position:left;
margin-left:36,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level2{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:54,0000pt;
mso-level-number-position:left;
margin-left:54,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level3{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:72,0000pt;
mso-level-number-position:left;
margin-left:72,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level4{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:90,0000pt;
mso-level-number-position:left;
margin-left:90,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level5{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:108,0000pt;
mso-level-number-position:left;
margin-left:108,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level6{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:126,0000pt;
mso-level-number-position:left;
margin-left:126,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level7{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:144,0000pt;
mso-level-number-position:left;
margin-left:144,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level8{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:162,0000pt;
mso-level-number-position:left;
margin-left:162,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level9{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:180,0000pt;
mso-level-number-position:left;
margin-left:180,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

p.MsoNormal{
mso-style-name:Normal;
mso-style-parent:"";
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:11,0000pt;
}

p.MsoHeader{
mso-style-name:Cabeçalho;
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan no-line-numbers;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:8,0000pt;
}

p.NewStyle16{
mso-style-name:"Texto préformatado";
margin-top:0,0000pt;
margin-bottom:0,0000pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:''Liberation Mono'';
mso-fareast-font-family:''Courier New'';
font-size:10,0000pt;
}

span.msoIns{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:underline;
text-underline:single;
color:blue;
}

span.msoDel{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:line-through;
color:red;
}

table.MsoNormalTable{
mso-style-name:"Tabela normal";
mso-style-parent:"";
mso-style-noshow:yes;
mso-tstyle-rowband-size:0;
mso-tstyle-colband-size:0;
mso-padding-alt:0,0000pt 5,4000pt 0,0000pt 5,4000pt;
mso-para-margin:0pt;
mso-para-margin-bottom:.0001pt;
mso-pagination:widow-orphan;
font-family:''Times New Roman'';
font-size:10,0000pt;
mso-ansi-language:#0400;
mso-fareast-language:#0400;
mso-bidi-language:#0400;
}
@page{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}@page Section0{
}
div.Section0{page:Section0;}</style><!--StartFragment--><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">HTML</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CSS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">JS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">AJAX</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">PYTHON</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">FLASK</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">TEMPLATES</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CONECTIVIDADE COM O SGBD POSTGRES</span><o:p></o:p></p><!--EndFragment-->', '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">SANDERS,
Bill. Smashing HTML5: Técnicas para a Nova Geração</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">da
Web. Bookman, 2012. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">YANK,
Kevin E ADAMS, Cameron. Só JavaScript: Tudo o que você precisa
saber sobre JavaScript a partir do zero. Bookman, 2009. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">GOODMAN,
Dany. JavaScript e DHTML Guia Prático. 2a ed. Altabooks, 2008.</font></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Python
para Desenvolvedores</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf</font></font></font></a></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Flask</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="http://flask.pocoo.org/"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://flask.pocoo.org/</font></font></font></a></font><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">
</font></font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">HTML/CSS/JS</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://www.w3schools.com/</font></font></p>', NULL, 148, 4, '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<ul>
	<li>
<p class="western" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal;"><a name="docs-internal-guid-7dbb1c02-32ae-ea1a-cc"></a>
	<font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Colocar
	em prática os conhecimentos e habilidades adquiridos ao longo do
	curso como: Lógica de Programação, Desenvolvimento Baseado em
	Objetos, Engenharia de Software e Bancos de Dados.</font></font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Oferecer o “treinamento”
	necessário para que os alunos adquiram a competência de
	Programador Web Multidisciplinar.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Envolver os alunos em um
	ambiente profissional de desenvolvimento de software, fazendo com
	que tenham de desempenhar as suas atividades com profissionalismo e
	eficiência.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Propiciar o crescimento
	pessoal e amadurecimento através da apropriação de valores e
	atitudes, importantes para o egresso obter êxito em qual seja seu
	caminho após o curso.</font></p>
</li></ul>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
<font style="font-size: 10pt"><i>Especificamente na seguinte
estrutura CHA:</i></font></p>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Conhecimentos</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Arquitetura e bases da
	Internet e da Web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Linguagens e plataformas para
	desenvolvimento para Internet;</font></p>
</li></ul>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Habilidades</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber fazer:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Implementar princípios e
	padrões de projeto e implementação de front-ends para web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	back-ends de sistemas web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	subsistemas eficientes de acesso a bases de dados;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Integrar sistemas móveis,
	desktop e web usando protocolos de interoperação e arquitetura
	cliente/servidor;</font></p>
</li></ul>
<p class="western" style="margin-bottom: 0cm"><br>

</p>', '', '', '', '', '', NULL);
INSERT INTO public.disciplinas VALUES (126, 'DISCIPLINA 1 - 29/04/2023 - 10:19:51', 4, 1, 2023, 1, 'Aplicações em diferentes plataformas de hardware e comunicação: desktops, web e dispositivos móveis (celulares e PDA''s). Sistemas em diferentes hardwares e plataformas computacionais: recursos, serviços para usuários locais e remotos. Integração de diferentes tecnologias para a disponibilização de serviços e facilidades. Tecnologias de desenvolvimento multifinalitárias e multiplataforma.', 4, false, '', '<!--[if gte mso 9]><xml><w:WordDocument><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery><w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery><w:DocumentKind>DocumentNotSpecified</w:DocumentKind><w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing><w:PunctuationKerning></w:PunctuationKerning><w:View>Normal</w:View><w:Compatibility><w:DontGrowAutofit/><w:BalanceSingleByteDoubleByteWidth/><w:DoNotExpandShiftReturn/></w:Compatibility><w:Zoom>0</w:Zoom></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml><w:LatentStyles DefLockedState="false"  DefUnhideWhenUsed="true"  DefSemiHidden="true"  DefQFormat="false"  DefPriority="99"  LatentStyleCount="260" >
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footer" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="caption" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of figures" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope return" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="line number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="page number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of authorities" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="macro" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toa heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Title" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Closing" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Default Paragraph Font" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Message Header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Subtitle" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Salutation" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Date" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Note Heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Block Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Hyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="FollowedHyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Strong" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Emphasis" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Document Map" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Plain Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="E-mail Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal (Web)" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Acronym" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Cite" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Code" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Definition" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Keyboard" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Preformatted" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Sample" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Typewriter" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Variable" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Table" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation subject" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="No List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Contemporary" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Elegant" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Professional" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Balloon Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Theme" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 6" ></w:LsdException>
</w:LatentStyles></xml><![endif]--><style>
@font-face{
font-family:"Times New Roman";
}

@font-face{
font-family:"宋体";
}

@font-face{
font-family:"Symbol";
}

@font-face{
font-family:"OpenSymbol";
}

@font-face{
font-family:"Arial";
}

@font-face{
font-family:"Tahoma";
}

@font-face{
font-family:"Luxi Sans";
}

@font-face{
font-family:"Liberation Mono";
}

@font-face{
font-family:"Courier New";
}

@font-face{
font-family:"Calibri";
}

@list l0:level1{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:36,0000pt;
mso-level-number-position:left;
margin-left:36,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level2{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:54,0000pt;
mso-level-number-position:left;
margin-left:54,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level3{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:72,0000pt;
mso-level-number-position:left;
margin-left:72,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level4{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:90,0000pt;
mso-level-number-position:left;
margin-left:90,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level5{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:108,0000pt;
mso-level-number-position:left;
margin-left:108,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level6{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:126,0000pt;
mso-level-number-position:left;
margin-left:126,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level7{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:144,0000pt;
mso-level-number-position:left;
margin-left:144,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level8{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:162,0000pt;
mso-level-number-position:left;
margin-left:162,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level9{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:180,0000pt;
mso-level-number-position:left;
margin-left:180,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

p.MsoNormal{
mso-style-name:Normal;
mso-style-parent:"";
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:11,0000pt;
}

p.MsoHeader{
mso-style-name:Cabeçalho;
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan no-line-numbers;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:8,0000pt;
}

p.NewStyle16{
mso-style-name:"Texto préformatado";
margin-top:0,0000pt;
margin-bottom:0,0000pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:''Liberation Mono'';
mso-fareast-font-family:''Courier New'';
font-size:10,0000pt;
}

span.msoIns{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:underline;
text-underline:single;
color:blue;
}

span.msoDel{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:line-through;
color:red;
}

table.MsoNormalTable{
mso-style-name:"Tabela normal";
mso-style-parent:"";
mso-style-noshow:yes;
mso-tstyle-rowband-size:0;
mso-tstyle-colband-size:0;
mso-padding-alt:0,0000pt 5,4000pt 0,0000pt 5,4000pt;
mso-para-margin:0pt;
mso-para-margin-bottom:.0001pt;
mso-pagination:widow-orphan;
font-family:''Times New Roman'';
font-size:10,0000pt;
mso-ansi-language:#0400;
mso-fareast-language:#0400;
mso-bidi-language:#0400;
}
@page{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}@page Section0{
}
div.Section0{page:Section0;}</style><!--StartFragment--><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">HTML</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CSS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">JS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">AJAX</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">PYTHON</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">FLASK</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">TEMPLATES</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CONECTIVIDADE COM O SGBD POSTGRES</span><o:p></o:p></p><!--EndFragment-->', '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">SANDERS,
Bill. Smashing HTML5: Técnicas para a Nova Geração</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">da
Web. Bookman, 2012. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">YANK,
Kevin E ADAMS, Cameron. Só JavaScript: Tudo o que você precisa
saber sobre JavaScript a partir do zero. Bookman, 2009. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">GOODMAN,
Dany. JavaScript e DHTML Guia Prático. 2a ed. Altabooks, 2008.</font></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Python
para Desenvolvedores</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf</font></font></font></a></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Flask</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="http://flask.pocoo.org/"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://flask.pocoo.org/</font></font></font></a></font><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">
</font></font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">HTML/CSS/JS</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://www.w3schools.com/</font></font></p>', NULL, 148, 4, '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<ul>
	<li>
<p class="western" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal;"><a name="docs-internal-guid-7dbb1c02-32ae-ea1a-cc"></a>
	<font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Colocar
	em prática os conhecimentos e habilidades adquiridos ao longo do
	curso como: Lógica de Programação, Desenvolvimento Baseado em
	Objetos, Engenharia de Software e Bancos de Dados.</font></font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Oferecer o “treinamento”
	necessário para que os alunos adquiram a competência de
	Programador Web Multidisciplinar.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Envolver os alunos em um
	ambiente profissional de desenvolvimento de software, fazendo com
	que tenham de desempenhar as suas atividades com profissionalismo e
	eficiência.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Propiciar o crescimento
	pessoal e amadurecimento através da apropriação de valores e
	atitudes, importantes para o egresso obter êxito em qual seja seu
	caminho após o curso.</font></p>
</li></ul>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
<font style="font-size: 10pt"><i>Especificamente na seguinte
estrutura CHA:</i></font></p>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Conhecimentos</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Arquitetura e bases da
	Internet e da Web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Linguagens e plataformas para
	desenvolvimento para Internet;</font></p>
</li></ul>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Habilidades</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber fazer:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Implementar princípios e
	padrões de projeto e implementação de front-ends para web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	back-ends de sistemas web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	subsistemas eficientes de acesso a bases de dados;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Integrar sistemas móveis,
	desktop e web usando protocolos de interoperação e arquitetura
	cliente/servidor;</font></p>
</li></ul>
<p class="western" style="margin-bottom: 0cm"><br>

</p>', '', '', '', '', '', NULL);
INSERT INTO public.disciplinas VALUES (127, 'DISCIPLINA 1 - 29/04/2023 - 10:21:01', 4, 1, 2023, 1, 'Aplicações em diferentes plataformas de hardware e comunicação: desktops, web e dispositivos móveis (celulares e PDA''s). Sistemas em diferentes hardwares e plataformas computacionais: recursos, serviços para usuários locais e remotos. Integração de diferentes tecnologias para a disponibilização de serviços e facilidades. Tecnologias de desenvolvimento multifinalitárias e multiplataforma.', 4, false, '', '<!--[if gte mso 9]><xml><w:WordDocument><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><w:DisplayHorizontalDrawingGridEvery>0</w:DisplayHorizontalDrawingGridEvery><w:DisplayVerticalDrawingGridEvery>2</w:DisplayVerticalDrawingGridEvery><w:DocumentKind>DocumentNotSpecified</w:DocumentKind><w:DrawingGridVerticalSpacing>7.8 磅</w:DrawingGridVerticalSpacing><w:PunctuationKerning></w:PunctuationKerning><w:View>Normal</w:View><w:Compatibility><w:DontGrowAutofit/><w:BalanceSingleByteDoubleByteWidth/><w:DoNotExpandShiftReturn/></w:Compatibility><w:Zoom>0</w:Zoom></w:WordDocument></xml><![endif]--><!--[if gte mso 9]><xml><w:LatentStyles DefLockedState="false"  DefUnhideWhenUsed="true"  DefSemiHidden="true"  DefQFormat="false"  DefPriority="99"  LatentStyleCount="260" >
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="heading 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toc 9" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footer" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="index heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="caption" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of figures" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="envelope return" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="footnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="line number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="page number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote reference" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="endnote text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="table of authorities" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="macro" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="toa heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Bullet 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Number 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Title" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Closing" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Default Paragraph Font" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="List Continue 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Message Header" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Subtitle" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Salutation" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Date" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text First Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Note Heading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Body Text Indent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Block Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Hyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="FollowedHyperlink" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Strong" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Emphasis" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Document Map" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Plain Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="E-mail Signature" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal (Web)" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Acronym" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Address" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Cite" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Code" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Definition" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Keyboard" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Preformatted" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Sample" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Typewriter" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="HTML Variable" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Normal Table" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="annotation subject" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="No List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Simple 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Classic 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Colorful 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Columns 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 7" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table List 8" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table 3D effects 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Contemporary" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Elegant" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Professional" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Subtle 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Web 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Balloon Text" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Table Theme" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 1" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 2" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 3" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 4" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 5" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Light Grid Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Shading 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium List 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 1 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 2 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Medium Grid 3 Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Dark List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Shading Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful List Accent 6" ></w:LsdException>
<w:LsdException Locked="false"  Priority="99"  SemiHidden="false"  Name="Colorful Grid Accent 6" ></w:LsdException>
</w:LatentStyles></xml><![endif]--><style>
@font-face{
font-family:"Times New Roman";
}

@font-face{
font-family:"宋体";
}

@font-face{
font-family:"Symbol";
}

@font-face{
font-family:"OpenSymbol";
}

@font-face{
font-family:"Arial";
}

@font-face{
font-family:"Tahoma";
}

@font-face{
font-family:"Luxi Sans";
}

@font-face{
font-family:"Liberation Mono";
}

@font-face{
font-family:"Courier New";
}

@font-face{
font-family:"Calibri";
}

@list l0:level1{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:36,0000pt;
mso-level-number-position:left;
margin-left:36,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level2{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:54,0000pt;
mso-level-number-position:left;
margin-left:54,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level3{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:72,0000pt;
mso-level-number-position:left;
margin-left:72,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level4{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:90,0000pt;
mso-level-number-position:left;
margin-left:90,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level5{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:108,0000pt;
mso-level-number-position:left;
margin-left:108,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level6{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:126,0000pt;
mso-level-number-position:left;
margin-left:126,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level7{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"";
mso-level-tab-stop:144,0000pt;
mso-level-number-position:left;
margin-left:144,0000pt;text-indent:-18,0000pt;font-family:Symbol;mso-bidi-font-family:OpenSymbol;}

@list l0:level8{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"◦";
mso-level-tab-stop:162,0000pt;
mso-level-number-position:left;
margin-left:162,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

@list l0:level9{
mso-level-number-format:bullet;
mso-level-suffix:tab;
mso-level-text:"▪";
mso-level-tab-stop:180,0000pt;
mso-level-number-position:left;
margin-left:180,0000pt;text-indent:-18,0000pt;font-family:OpenSymbol;}

p.MsoNormal{
mso-style-name:Normal;
mso-style-parent:"";
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:11,0000pt;
}

p.MsoHeader{
mso-style-name:Cabeçalho;
margin:0pt;
margin-bottom:.0001pt;
mso-hyphenate:none;
mso-pagination:widow-orphan no-line-numbers;
text-align:justify;
text-justify:inter-ideograph;
font-family:Arial;
mso-fareast-font-family:Tahoma;
mso-bidi-font-family:''Luxi Sans'';
font-size:8,0000pt;
}

p.NewStyle16{
mso-style-name:"Texto préformatado";
margin-top:0,0000pt;
margin-bottom:0,0000pt;
mso-hyphenate:none;
mso-pagination:widow-orphan;
text-align:justify;
text-justify:inter-ideograph;
font-family:''Liberation Mono'';
mso-fareast-font-family:''Courier New'';
font-size:10,0000pt;
}

span.msoIns{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:underline;
text-underline:single;
color:blue;
}

span.msoDel{
mso-style-type:export-only;
mso-style-name:"";
text-decoration:line-through;
color:red;
}

table.MsoNormalTable{
mso-style-name:"Tabela normal";
mso-style-parent:"";
mso-style-noshow:yes;
mso-tstyle-rowband-size:0;
mso-tstyle-colband-size:0;
mso-padding-alt:0,0000pt 5,4000pt 0,0000pt 5,4000pt;
mso-para-margin:0pt;
mso-para-margin-bottom:.0001pt;
mso-pagination:widow-orphan;
font-family:''Times New Roman'';
font-size:10,0000pt;
mso-ansi-language:#0400;
mso-fareast-language:#0400;
mso-bidi-language:#0400;
}
@page{mso-page-border-surround-header:no;
	mso-page-border-surround-footer:no;}@page Section0{
}
div.Section0{page:Section0;}</style><!--StartFragment--><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">HTML</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CSS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">JS</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">AJAX</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">PYTHON</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">FLASK</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">TEMPLATES</span><o:p></o:p></p><p class="NewStyle16"><!--[if !supportLists]--><span style="font-family: Symbol; font-variant-numeric: normal; font-variant-east-asian: normal;">· </span><!--[endif]--><span style="font-family: Calibri; font-variant-numeric: normal; font-variant-east-asian: normal;">CONECTIVIDADE COM O SGBD POSTGRES</span><o:p></o:p></p><!--EndFragment-->', '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">SANDERS,
Bill. Smashing HTML5: Técnicas para a Nova Geração</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">da
Web. Bookman, 2012. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">YANK,
Kevin E ADAMS, Cameron. Só JavaScript: Tudo o que você precisa
saber sobre JavaScript a partir do zero. Bookman, 2009. </font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">GOODMAN,
Dany. JavaScript e DHTML Guia Prático. 2a ed. Altabooks, 2008.</font></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Python
para Desenvolvedores</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">https://ark4n.files.wordpress.com/2010/01/python_para_desenvolvedores_2ed.pdf</font></font></font></a></font></p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Flask</font></font></p>
<p class="western" style="margin-bottom: 0cm"><font color="#000080"><a class="western" href="http://flask.pocoo.org/"><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://flask.pocoo.org/</font></font></font></a></font><font color="#000000"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">
</font></font></font>
</p>
<p class="western" style="margin-bottom: 0cm"><br>

</p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">HTML/CSS/JS</font></font></p>
<p class="western" style="margin-bottom: 0cm;"><font face="CALIBRI, sans-serif"><font style="font-size: 10pt">http://www.w3schools.com/</font></font></p>', NULL, 148, 4, '<style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.21cm; direction: ltr; color: #000000; text-align: justify; orphans: 2; widows: 2 }
		p.western { font-family: "Arial", sans-serif; font-size: 11pt; so-language: pt-BR }
		p.cjk { font-family: "Tahoma", sans-serif; font-size: 11pt; so-language: zh-CN }
		p.ctl { font-family: "Luxi Sans", "Times New Roman"; font-size: 12pt; so-language: pt-BR }
		a.western:visited { so-language: pt-BR }
		a.cjk:visited { so-language: zh-CN }
		a.ctl:visited { so-language: hi-IN }
	</style>


<p class="western" style="margin-bottom: 0cm"><br>

</p>
<ul>
	<li>
<p class="western" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal;"><a name="docs-internal-guid-7dbb1c02-32ae-ea1a-cc"></a>
	<font face="CALIBRI, sans-serif"><font style="font-size: 10pt">Colocar
	em prática os conhecimentos e habilidades adquiridos ao longo do
	curso como: Lógica de Programação, Desenvolvimento Baseado em
	Objetos, Engenharia de Software e Bancos de Dados.</font></font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Oferecer o “treinamento”
	necessário para que os alunos adquiram a competência de
	Programador Web Multidisciplinar.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Envolver os alunos em um
	ambiente profissional de desenvolvimento de software, fazendo com
	que tenham de desempenhar as suas atividades com profissionalismo e
	eficiência.</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Propiciar o crescimento
	pessoal e amadurecimento através da apropriação de valores e
	atitudes, importantes para o egresso obter êxito em qual seja seu
	caminho após o curso.</font></p>
</li></ul>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
<font style="font-size: 10pt"><i>Especificamente na seguinte
estrutura CHA:</i></font></p>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Conhecimentos</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Arquitetura e bases da
	Internet e da Web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Linguagens e plataformas para
	desenvolvimento para Internet;</font></p>
</li></ul>
<p class="western"><br>
<br>

</p>
<p class="western" align="justify" style="margin-bottom: 0cm; line-height: 120%">
<span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt"><b>Habilidades</b></font></font></span><span style="font-variant-numeric: normal; font-variant-east-asian: normal;"><font color="#000000"><font style="font-size: 10pt">,
ou o que o aluno deve saber fazer:</font></font></span></p>
<p class="western"><br>
<br>

</p>
<ul>
	<li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Implementar princípios e
	padrões de projeto e implementação de front-ends para web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	back-ends de sistemas web;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Projetar e implementar
	subsistemas eficientes de acesso a bases de dados;</font></p>
	</li><li>
<p class="western" align="justify" style="margin-bottom: 0cm; background: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; line-height: 120%;">
	<font style="font-size: 10pt">Integrar sistemas móveis,
	desktop e web usando protocolos de interoperação e arquitetura
	cliente/servidor;</font></p>
</li></ul>
<p class="western" style="margin-bottom: 0cm"><br>

</p>', '', '', '', '', '', NULL);


--
-- TOC entry 3508 (class 0 OID 52831)
-- Dependencies: 225
-- Data for Name: notas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.notas VALUES (5531, 0, 914, 1251, 'asdas', 'aluno_122_914_1251.uml');
INSERT INTO public.notas VALUES (5532, 0, 914, 1248, '<br>', NULL);
INSERT INTO public.notas VALUES (5533, 0, 914, 1247, '<br>', NULL);
INSERT INTO public.notas VALUES (5534, 0, 914, 1250, '<br>', NULL);


--
-- TOC entry 3510 (class 0 OID 52837)
-- Dependencies: 227
-- Data for Name: planos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.planos VALUES (508, '2018-02-19', 'Comentários Iniciais
       Setup
Introdução a Linguagem', 73, 1);


--
-- TOC entry 3512 (class 0 OID 52844)
-- Dependencies: 229
-- Data for Name: presencas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.presencas VALUES (10514, '2018-02-19', 1104, 73, 1, 1, 4);
INSERT INTO public.presencas VALUES (10513, '2018-02-19', 1103, 73, 1, 1, 4);


--
-- TOC entry 3514 (class 0 OID 52849)
-- Dependencies: 231
-- Data for Name: provas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.provas VALUES (14, '
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../../lib/bootstrap/css/bootstrap.min.css">
	</head>
	<body>			<img style="margin-left: 10px" src="../../imagens/logo.jpg">
			<table style="margin-left: 15px">
				<tbody><tr>
					<td style="width: 50%">  <b> Disciplina 1 </b> </td>
					<td style="text-align: left;"> <b> Nome: </b> </td> 
					<td style="border-bottom: 1px black solid; width: 200px;"> </td>
				</tr>
				<tr>
					<td> <b> 1 Bimestre </b> </td>
					<td style="text-align: left;"> <b> Matrícula: </b> </td> 
					<td style="border-bottom: 1px black solid; width: 200px;"> </td>
				</tr>			
				<tr> 
					<td> <b> Valor: 10 pontos </b> </td> 
				</tr>
			</tbody></table>
			<hr style="border-color: black;">
			<ol style="width: 90%">
				<li><div><ul><li>Desenvolver um sistema web para uma Garagem Coletiva<span style="background-color: transparent;">.</span></li></ul></div><div><br></div><div><b><u>Classes do Sistema:</u></b></div><div><span style="background-color: transparent;"><br></span></div><div><span style="background-color: transparent;"><b>Carro</b></span></div><div><div><ul><li><span style="background-color: transparent;">placa (String)</span></li><li><span style="background-color: transparent;">modelo (String)</span></li><li><span style="background-color: transparent;">ano (inteiro)</span></li><li><span style="background-color: transparent;">marca (String)</span></li></ul></div><div><b>Locação</b></div><div><ul><li><span style="background-color: transparent;">Box (objeto do tipo Box)</span></li><li><span style="background-color: transparent;">Carro (objeto do tipo Carro)</span></li><li><span style="background-color: transparent;">datahora_inicio (timestamp, calendar e etc)</span></li><li><span style="background-color: transparent;">datahora_fim (timestamp, calendar e etc)</span></li><li><span style="background-color: transparent;">valor (double) (por segundo, por hora, por dia)</span></li></ul></div><div><b>Box</b></div><div><ul><li><span style="background-color: transparent;">numero (inteiro)</span></li><li><span style="background-color: transparent;">ocupado? (booleano)</span></li></ul><div><br></div></div><div><b>Dica:</b> Construa as tabelas no SGBD e as classes de modelo.</div><div><br></div><div><b><u>Funcionalidades</u></b>:</div><div><br></div><div><ol><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Carros(0.2)&nbsp;</li><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Boxes(0.2)&nbsp;</li><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Locações(0.2)&nbsp;</li><li>Definir o valor total de uma locação (0.3)</li><li>Listar as Locações correntes (locações que estão em trâmite no momento) (0.3)</li></ol><div><div><b><u>Obervações</u></b>:</div></div></div><div><ul><li>Lembre que para excluir qualquer carro é preciso, anteriormente, excluir todas as locações do mesmo.</li></ul></div><div><ul><li>Lembre que para excluir qualquer box é preciso, anteriormente, excluir todas as locações do mesmo.</li></ul></div><div><br></div><div><b>Valor Total:</b> 3 pontos</div><div><b>Individual</b></div><div><b>É permitido consultar material próprio</b></div></div> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><br class="Apple-interchange-newline">Desenvolva um sistem de vendas de ingressos de um cinema com uma única sala, utilizando Python/Flask com PostgreSQL.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Observações</span>:</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Esta sala tem 10 lugares.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Não é possível vender dois ingressos para o mesmo lugar em uma mesma sessão.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Durante um dia, é possível que um mesmo filme seja exibido mais de uma vez (em horários diferentes).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Durante a venda, só é possível vender ingressos em sessões de filmes disponíveis para exibição (dentro do período de exibição).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível reportar a quantidade de ingressos já vendidos por cada sessão (e se já esgotou).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">O cliente deve, no momento da compra, identificar as sessões e os vendidos e ainda disponíveis.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Uma Sessão tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>data/hora da sessão</li><li style="margin-top: 0.25em;">filme</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um Ingresso tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>nome do cliente</li><li style="margin-top: 0.25em;">lugar (cadeira)</li><li style="margin-top: 0.25em;">sessão</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um Filme tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;">título</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">sinopse</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">gênero</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">período de exibição</p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">data de início</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">data de fim</p></li></ul></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD de sessão</li><li style="margin-top: 0.25em;">CRUD de ingressos</li><li style="margin-top: 0.25em;">CRUD de filmes</li><li style="margin-top: 0.25em;">Venda de ingressos</li><li style="margin-top: 0.25em;">Cancelamento de pedidos de ingressos</li><li style="margin-top: 0.25em;">Verificação de não ser possível vender mais de ingresso para a mesma cadeira em uma mesma sessão</li><li style="margin-top: 0.25em;">Utilizar uma biblioteca css (ex: bootstrap ou materialize). É obrigatório utilizar pelo menos 10 recursos DIFERENTES de estilo em cada página.</li><li style="margin-top: 0.25em;">validar os formulários por js</li><li style="margin-top: 0.25em;">tanto arquivos js como css devem ser externos aos arquivos html</li><li style="margin-top: 0.25em;">desenvolver o sistema em 3 camadas: apresentação (html), modelo (classes lógicas) e persistência (dao).</li><li></li></ul> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Sistema administrativo de gerenciamento de uma revenda de carros</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>cada carro tem:</li><li style="margin-top: 0.25em;">marca</li><li style="margin-top: 0.25em;">modelo</li><li style="margin-top: 0.25em;">ano</li><li style="margin-top: 0.25em;">preço</li><li style="margin-top: 0.25em;">foto</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obs: As fotos podem ser removidas, adicionadas e alteradas</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Além disso, terá um administrador. O administrador tem login e senha:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>É possível alterar o login e a senha e cadastrar e remover demais administradores</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Haverá uma página pública com a listagem dos carros cadastrados. Nesta página é impossível realizar qualquer outro tipo de operação (Ex: alteração e exclusão)</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;">Utilize interceptadores para filtrar as rotas</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">Utilize sessão para testar se já há um administrador logado no sistema.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">É obrigatório a utilização do Java Bean Validation para validar os atributos de carro.</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Vale: 2&nbsp;</p> <br></li>
				<li><div>Descrição do Trabalho:</div><div><br></div><div>Desenvolver um sistema de Classificados, onde uma Usuário tem vários classificados em seu nome:</div><div><br></div><div>Cada Classificado possui:</div><div>- id</div><div>- contato</div><div>- descrição</div><div>- E pessoa dona do classificado</div><div><br></div><div>Cada Usuário possui:</div><div>- id</div><div>- nome</div><div>- A lista de classificados</div><div><br></div><div>Valor: 2.5 (2º bim)</div><div><br></div> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				<li><div>Uma turma do segundo ano do ensino médio resolveu formar um clube do livro. Como esses alunos são</div><div>do curso técnico em informática, ele resolveram desenvolver um sistema para controlar isso. O clube vai</div><div>funcionar assim</div><div> Cada aluno deve selecionar alguns livros que tenha em cada para disponibilizar ao clube.</div><div> Esses livros serão colocados em caixas separadas por área (romance, ficção, policial, etc.). É</div><div>interessante manter um cadastro de áreas.</div><div> Sobre o livro é necessário saber: nome do livro, nome do autor editora, ano de publicação e ISBN.</div><div> Não pode haver livros repetidos.</div><div> Sobre os alunos, precisa-se saber a matrícula do aluno, nome, telefone e turma a que pertence.</div><div> Os livros podem ser emprestados aos alunos cadastrados, sendo necessário registrar a data do</div><div>empréstimo e data da devolução. Deseja-se saber o histórico desses empréstimos, pois se o aluno</div><div>atrasar a devolução mais de uma vez ele será banido do grupo.</div> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Sistema administrativo de gerenciamento de uma revenda de carros</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>cada carro tem:</li><li style="margin-top: 0.25em;">marca</li><li style="margin-top: 0.25em;">modelo</li><li style="margin-top: 0.25em;">ano</li><li style="margin-top: 0.25em;">preço</li><li style="margin-top: 0.25em;">foto</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obs: As fotos podem ser removidas, adicionadas e alteradas</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Além disso, terá um administrador. O administrador tem login e senha:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>É possível alterar o login e a senha e cadastrar e remover demais administradores</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Haverá uma página pública com a listagem dos carros cadastrados. Nesta página é impossível realizar qualquer outro tipo de operação (Ex: alteração e exclusão)</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;">Utilize interceptadores para filtrar as rotas</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">Utilize sessão para testar se já há um administrador logado no sistema.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">É obrigatório a utilização do Java Bean Validation para validar os atributos de carro.</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Vale: 2&nbsp;</p> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				</ol>	
		</body></html>', NULL, '2023-04-29 09:23:54.30626', 'Disciplina 1');
INSERT INTO public.provas VALUES (15, '
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../../lib/bootstrap/css/bootstrap.min.css">
	</head>
	<body>			<img style="margin-left: 10px" src="../../imagens/logo.jpg">
			<table style="margin-left: 15px">
				<tbody><tr>
					<td style="width: 50%">  <b> Disciplina 1 </b> </td>
					<td style="text-align: left;"> <b> Nome: </b> </td> 
					<td style="border-bottom: 1px black solid; width: 200px;"> </td>
				</tr>
				<tr>
					<td> <b> 1 Bimestre </b> </td>
					<td style="text-align: left;"> <b> Matrícula: </b> </td> 
					<td style="border-bottom: 1px black solid; width: 200px;"> </td>
				</tr>			
				<tr> 
					<td> <b> Valor: 10 pontos </b> </td> 
				</tr>
			</tbody></table>
			<hr style="border-color: black;">
			<ol style="width: 90%">
				<li><div><ul><li>Desenvolver um sistema web para uma Garagem Coletiva<span style="background-color: transparent;">.</span></li></ul></div><div><br></div><div><b><u>Classes do Sistema:</u></b></div><div><span style="background-color: transparent;"><br></span></div><div><span style="background-color: transparent;"><b>Carro</b></span></div><div><div><ul><li><span style="background-color: transparent;">placa (String)</span></li><li><span style="background-color: transparent;">modelo (String)</span></li><li><span style="background-color: transparent;">ano (inteiro)</span></li><li><span style="background-color: transparent;">marca (String)</span></li></ul></div><div><b>Locação</b></div><div><ul><li><span style="background-color: transparent;">Box (objeto do tipo Box)</span></li><li><span style="background-color: transparent;">Carro (objeto do tipo Carro)</span></li><li><span style="background-color: transparent;">datahora_inicio (timestamp, calendar e etc)</span></li><li><span style="background-color: transparent;">datahora_fim (timestamp, calendar e etc)</span></li><li><span style="background-color: transparent;">valor (double) (por segundo, por hora, por dia)</span></li></ul></div><div><b>Box</b></div><div><ul><li><span style="background-color: transparent;">numero (inteiro)</span></li><li><span style="background-color: transparent;">ocupado? (booleano)</span></li></ul><div><br></div></div><div><b>Dica:</b> Construa as tabelas no SGBD e as classes de modelo.</div><div><br></div><div><b><u>Funcionalidades</u></b>:</div><div><br></div><div><ol><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Carros(0.2)&nbsp;</li><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Boxes(0.2)&nbsp;</li><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Locações(0.2)&nbsp;</li><li>Definir o valor total de uma locação (0.3)</li><li>Listar as Locações correntes (locações que estão em trâmite no momento) (0.3)</li></ol><div><div><b><u>Obervações</u></b>:</div></div></div><div><ul><li>Lembre que para excluir qualquer carro é preciso, anteriormente, excluir todas as locações do mesmo.</li></ul></div><div><ul><li>Lembre que para excluir qualquer box é preciso, anteriormente, excluir todas as locações do mesmo.</li></ul></div><div><br></div><div><b>Valor Total:</b> 3 pontos</div><div><b>Individual</b></div><div><b>É permitido consultar material próprio</b></div></div> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><br class="Apple-interchange-newline">Desenvolva um sistem de vendas de ingressos de um cinema com uma única sala, utilizando Python/Flask com PostgreSQL.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Observações</span>:</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Esta sala tem 10 lugares.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Não é possível vender dois ingressos para o mesmo lugar em uma mesma sessão.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Durante um dia, é possível que um mesmo filme seja exibido mais de uma vez (em horários diferentes).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Durante a venda, só é possível vender ingressos em sessões de filmes disponíveis para exibição (dentro do período de exibição).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível reportar a quantidade de ingressos já vendidos por cada sessão (e se já esgotou).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">O cliente deve, no momento da compra, identificar as sessões e os vendidos e ainda disponíveis.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Uma Sessão tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>data/hora da sessão</li><li style="margin-top: 0.25em;">filme</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um Ingresso tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>nome do cliente</li><li style="margin-top: 0.25em;">lugar (cadeira)</li><li style="margin-top: 0.25em;">sessão</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um Filme tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;">título</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">sinopse</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">gênero</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">período de exibição</p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">data de início</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">data de fim</p></li></ul></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD de sessão</li><li style="margin-top: 0.25em;">CRUD de ingressos</li><li style="margin-top: 0.25em;">CRUD de filmes</li><li style="margin-top: 0.25em;">Venda de ingressos</li><li style="margin-top: 0.25em;">Cancelamento de pedidos de ingressos</li><li style="margin-top: 0.25em;">Verificação de não ser possível vender mais de ingresso para a mesma cadeira em uma mesma sessão</li><li style="margin-top: 0.25em;">Utilizar uma biblioteca css (ex: bootstrap ou materialize). É obrigatório utilizar pelo menos 10 recursos DIFERENTES de estilo em cada página.</li><li style="margin-top: 0.25em;">validar os formulários por js</li><li style="margin-top: 0.25em;">tanto arquivos js como css devem ser externos aos arquivos html</li><li style="margin-top: 0.25em;">desenvolver o sistema em 3 camadas: apresentação (html), modelo (classes lógicas) e persistência (dao).</li><li></li></ul> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Sistema administrativo de gerenciamento de uma revenda de carros</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>cada carro tem:</li><li style="margin-top: 0.25em;">marca</li><li style="margin-top: 0.25em;">modelo</li><li style="margin-top: 0.25em;">ano</li><li style="margin-top: 0.25em;">preço</li><li style="margin-top: 0.25em;">foto</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obs: As fotos podem ser removidas, adicionadas e alteradas</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Além disso, terá um administrador. O administrador tem login e senha:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>É possível alterar o login e a senha e cadastrar e remover demais administradores</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Haverá uma página pública com a listagem dos carros cadastrados. Nesta página é impossível realizar qualquer outro tipo de operação (Ex: alteração e exclusão)</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;">Utilize interceptadores para filtrar as rotas</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">Utilize sessão para testar se já há um administrador logado no sistema.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">É obrigatório a utilização do Java Bean Validation para validar os atributos de carro.</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Vale: 2&nbsp;</p> <br></li>
				<li><div>Descrição do Trabalho:</div><div><br></div><div>Desenvolver um sistema de Classificados, onde uma Usuário tem vários classificados em seu nome:</div><div><br></div><div>Cada Classificado possui:</div><div>- id</div><div>- contato</div><div>- descrição</div><div>- E pessoa dona do classificado</div><div><br></div><div>Cada Usuário possui:</div><div>- id</div><div>- nome</div><div>- A lista de classificados</div><div><br></div><div>Valor: 2.5 (2º bim)</div><div><br></div> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				<li><div>Uma turma do segundo ano do ensino médio resolveu formar um clube do livro. Como esses alunos são</div><div>do curso técnico em informática, ele resolveram desenvolver um sistema para controlar isso. O clube vai</div><div>funcionar assim</div><div> Cada aluno deve selecionar alguns livros que tenha em cada para disponibilizar ao clube.</div><div> Esses livros serão colocados em caixas separadas por área (romance, ficção, policial, etc.). É</div><div>interessante manter um cadastro de áreas.</div><div> Sobre o livro é necessário saber: nome do livro, nome do autor editora, ano de publicação e ISBN.</div><div> Não pode haver livros repetidos.</div><div> Sobre os alunos, precisa-se saber a matrícula do aluno, nome, telefone e turma a que pertence.</div><div> Os livros podem ser emprestados aos alunos cadastrados, sendo necessário registrar a data do</div><div>empréstimo e data da devolução. Deseja-se saber o histórico desses empréstimos, pois se o aluno</div><div>atrasar a devolução mais de uma vez ele será banido do grupo.</div> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Sistema administrativo de gerenciamento de uma revenda de carros</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>cada carro tem:</li><li style="margin-top: 0.25em;">marca</li><li style="margin-top: 0.25em;">modelo</li><li style="margin-top: 0.25em;">ano</li><li style="margin-top: 0.25em;">preço</li><li style="margin-top: 0.25em;">foto</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obs: As fotos podem ser removidas, adicionadas e alteradas</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Além disso, terá um administrador. O administrador tem login e senha:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>É possível alterar o login e a senha e cadastrar e remover demais administradores</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Haverá uma página pública com a listagem dos carros cadastrados. Nesta página é impossível realizar qualquer outro tipo de operação (Ex: alteração e exclusão)</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;">Utilize interceptadores para filtrar as rotas</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">Utilize sessão para testar se já há um administrador logado no sistema.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">É obrigatório a utilização do Java Bean Validation para validar os atributos de carro.</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Vale: 2&nbsp;</p> <br></li>
				<li><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"="">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, " segoe="" ui",="" helvetica,="" arial,="" sans-serif,="" "apple="" color="" emoji",="" "segoe="" ui="" symbol";="" font-size:="" 16px;"=""><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> <br></li>
				</ol>	
		</body></html>', NULL, '2023-04-29 09:24:25.505232', 'Disciplina 1');


--
-- TOC entry 3516 (class 0 OID 52855)
-- Dependencies: 233
-- Data for Name: questoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questoes VALUES (31, '<div>Construa um diagrama ER para um estabelecimento comercial onde se deseja:</div><div><br></div><div><ul><li>Registrar dados de produtos (código, nome, preço e quantidade em estoque).</li><li>Cada produto possui um fornecedor. É necessário registrar o nome, CNPJ e telefone do fornecedor.</li><li>Registrar vendas de produtos. Para cada venda existe uma nota fiscal associada. Cada nota deve possuir um ou mais itens, onde será registrada a quantidade comprada do produto.</li><li>Cada item está associado a um produto.</li><li>Cada venda é feita para um cliente, que deve ser cadastrado no sistema (registrando CPF, nome e telefone).</li></ul></div> ', '    ');
INSERT INTO public.questoes VALUES (26, '<div>O objetivo deste exercício é projetar um sistema de reservas para uma companhia de aviação. O sistema</div><div>contará com um banco de dados central, que será acessado por aplicações-clientes, rodando tanto dentro</div><div>da própria companhia quanto fora dela.</div><div>A transação central do sistema é a reserva. Uma reserva é identificada por um código gerado pelo</div><div>sistema em computador. A reserva é feita para um único passageiro, do qual se conhece apenas o nome. A</div><div>reserva compreende um conjunto de trechos de voos, que acontecerão em determinada data/hora. Para</div><div>cada trecho, a reserva é feita em uma classe (econômica, executiva, etc.).</div><div>Um voo é identificado por um código e possui uma origem e um destino. Por exemplo, o voo 595 sai</div><div>de Porto Alegre com destino a São Paulo. Um voo é composto de vários trechos, correspondendo às</div><div>escalas intermediárias do voo. Por exemplo, o voo 595 é composto de dois trechos, um de Porto Alegre a</div><div>Londrina, o outro de Londrina a São Paulo. Cabe salientar que há cidades que são servidas por vários</div><div>aeroportos. Por isso, é importante informar ao passageiro que faz a reserva em qual aeroporto o voo passa.</div><div>Às vezes, ao fazer a reserva, os clientes querem saber qual é o tipo de aeronave que será utilizada</div><div>em determinado trecho voo. Alguns poucos voos, principalmente internacionais, tem troca de aeronave em</div><div>determinadas escalas.</div><div><br></div> ', ' ');
INSERT INTO public.questoes VALUES (30, '<div>Uma turma do segundo ano do ensino médio resolveu formar um clube do livro. Como esses alunos são</div><div>do curso técnico em informática, ele resolveram desenvolver um sistema para controlar isso. O clube vai</div><div>funcionar assim</div><div> Cada aluno deve selecionar alguns livros que tenha em cada para disponibilizar ao clube.</div><div> Esses livros serão colocados em caixas separadas por área (romance, ficção, policial, etc.). É</div><div>interessante manter um cadastro de áreas.</div><div> Sobre o livro é necessário saber: nome do livro, nome do autor editora, ano de publicação e ISBN.</div><div> Não pode haver livros repetidos.</div><div> Sobre os alunos, precisa-se saber a matrícula do aluno, nome, telefone e turma a que pertence.</div><div> Os livros podem ser emprestados aos alunos cadastrados, sendo necessário registrar a data do</div><div>empréstimo e data da devolução. Deseja-se saber o histórico desses empréstimos, pois se o aluno</div><div>atrasar a devolução mais de uma vez ele será banido do grupo.</div> ', '   ');
INSERT INTO public.questoes VALUES (33, '<div>Construir um modelo ER para o banco de dados de uma empresa de locação de veículos. A empresa em</div><div>questão aluga automóveis, camionetas de passageiros e camionetas de carga.</div><div>Ela atende a dois mercados: o das pessoas físicas e o das pessoas jurídicas. Para acelerar o</div><div>atendimento, é importante conhecer os dados dos clientes que já tenham usado a locadora no passado.</div><div>Para cada pessoa física, é necessário conhecer seu nome, sexo, data de nascimento, endereço e CPF. Já</div><div>para as pessoas jurídicas, é necessário conhecer seu nome, CPF, inscrição estadual e endereço. Os</div><div>clientes são identificados por um código interno à locadora.</div><div>A empresa tem uma grande rede de filiais espalhadas pelo sul do país. Em um momento no tempo,</div><div>um veículo encontra-se sob responsabilidade de uma filial. Entretanto, como veículos podem ser alugados</div><div>para viagens em um sentido somente, eles podem mudar de filial. Um veículo é identificado pela sua placa.</div><div>Além disso, é necessário conhecer o número do chassi, o número do motor, o tipo de veículo e a cor de</div><div>cada veículo.</div><div>O sistema em computador deverá informar:</div><div> os veículos disponíveis em determinada filial na data corrente;</div><div> as reservas para veículos em uma filial, com previsão de que veículos estarão disponíveis em uma</div><div>data futura;</div><div> os veículos presentemente alugados pela filial, o ponto de entrega (caso seja diferente do de</div><div>locação) e data de entrega prevista.</div><div>Os veículos são classificados por uma tabela de tipos. Por exemplo, P3 corresponde a automóveis</div><div>pequenos, de quatro portas e com ar-condicionado e G4 a grandes automóveis de luxo. As reservas não</div><div>são feitas para uma marca ou modelo de veículo, mas para um tipo de veículo.</div><div>Para tipos de automóveis, os clientes desejam saber o tamanho, classificado em pequeno, médio e</div><div>grande, o número de passageiros, o número de portas, bem como se possui os seguintes acessórios: ar-</div><div>condicionado, rádio e direção hidráulica. Para tipos de caminhonetas de passageiros, as informações são</div><div>as mesmas que para automóveis. Já para tipos de caminhonetas de carga, as informações acima não são</div><div>relevantes. Neste caso, os clientes desejam saber a capacidade de carga da camioneta.</div><div>Para cada tipo de veículo, há um determinado número de horas necessário para limpeza e revisão</div><div>de entrega, entre uma reserva e outra.</div><div>A seguradora que segura os veículos exige que, para cada veículo alugado, seja mantida a</div><div>identificação do motorista, o número de sua habilitação e data de vencimento da mesma.</div> ', ' ');
INSERT INTO public.questoes VALUES (43, '<p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Sistema administrativo de gerenciamento de uma revenda de carros</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li>cada carro tem:</li><li style="margin-top: 0.25em;">marca</li><li style="margin-top: 0.25em;">modelo</li><li style="margin-top: 0.25em;">ano</li><li style="margin-top: 0.25em;">preço</li><li style="margin-top: 0.25em;">foto</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Obs: As fotos podem ser removidas, adicionadas e alteradas</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Além disso, terá um administrador. O administrador tem login e senha:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li>É possível alterar o login e a senha e cadastrar e remover demais administradores</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Haverá uma página pública com a listagem dos carros cadastrados. Nesta página é impossível realizar qualquer outro tipo de operação (Ex: alteração e exclusão)</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Utilize interceptadores para filtrar as rotas</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">Utilize sessão para testar se já há um administrador logado no sistema.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">É obrigatório a utilização do Java Bean Validation para validar os atributos de carro.</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Vale: 2&nbsp;</p> ', ' ');
INSERT INTO public.questoes VALUES (46, '<div>Descrição do Trabalho:</div><div><br></div><div>Desenvolver um sistema de Classificados, onde uma Usuário tem vários classificados em seu nome:</div><div><br></div><div>Cada Classificado possui:</div><div>- id</div><div>- contato</div><div>- descrição</div><div>- E pessoa dona do classificado</div><div><br></div><div>Cada Usuário possui:</div><div>- id</div><div>- nome</div><div>- A lista de classificados</div><div><br></div><div>Valor: 2.5 (2º bim)</div><div><br></div> ', ' ');
INSERT INTO public.questoes VALUES (51, '<p>Você foi contratado para gerenciar o Universo Marvel.</p>
<p>Sabe-se que:</p>
<ul><li>
<p>Há os defensores: punho de ferro, demolidor, jéssica jones, luke cage e etc.</p>
</li><li>
<p>Há os vingadores: thor, homem de ferro, viúva negra, gavião arqueiro, capitão américa e etc.</p>
</li></ul>
<p>Além disso, o importante é também determinar a equipe de cada herói.</p>
<ul><li>Ex: O Demolidor faz parte dos Defensores e Homem de Ferro atua nos Vingadores.</li></ul>
<p>Cada herói possui poderes/habilidades. Há um banco de dados de 
habilidades e cada personagem possui 1 ou várias habilidades. Há 
habilidades compartilhadas por mais de um herói. Ex: O homem de ferro e o
 Falcão ambos voam.</p>
<p>Um <strong>herói</strong> possui:</p>
<ul><li>
<p>Nome</p>
</li><li>
<p>Nome verdadeiro</p>
</li><li>
<p>E um conjunto de habilidades</p>
</li></ul>
<p>Uma <strong>habilidade</strong> tem:</p>
<ul><li>
<p>nome</p>
</li><li>
<p>nível de impacto. O impacto pode ser: leve, moderado e forte.</p>
</li><li>
<p>descrição</p>
</li></ul>
<p>Uma equipe possui vários heróis. Entretanto, cada herói participa de somente uma equipe.</p>
<p>Uma <strong>equipe</strong> possui:</p>
<ul><li>
<p>O nome</p>
</li><li>
<p>E a lista de super-heróis</p>
</li></ul>
<p><strong>Exigências:</strong></p>
<ul><li>
<p>CRUD de Herói, Habilidades e Equipes</p>
</li><li>
<p>O relacionamentos devem ser pensados em O.O. Observe atentamente os 
relacionamentos entre herói, habilidades e equipes (1:n, n:m). 
Implementar tudo isso em Ruby e com dataMapper.</p>
</li><li>
<p>As propridades/atributos devem ser declarados em classes Ruby e em dataMapper</p>
</li><li>
<p>Os campos nome, nome verdadeiro não devem ser nulos</p>
</li><li>
<p>As habilidades devem possui descrições com mais de 10 caracteres.</p>
</li><li>
<p>As validações devem ser feitos por dataMapper</p>
</li><li>
<p>Os relacionamentos devem ser feitos por dataMapper</p>
</li><li>
<p>Os cruds devem ser feitos por dataMapper</p>
</li><li>
<p>O sistema deve ser feito em Sinatra</p>
</li><li>
<p>O banco de dados deve ser PostgreSQL</p>
</li><li>
<p><strong>Desenvolva um exemplo de herança com dataMapper.</strong> Ex: há heróis e há subclasses de heróis Terrestres e Extraterrestres e etc (olhar o exemplo de herança com dataMapper)</p>
</li></ul>
 ', 'oi');
INSERT INTO public.questoes VALUES (49, '<div>O objetivo é desenvolver o Google Keep Tabajara</div><div><br></div><div>Cada nova anotação tem: Título, Data/Hora, Descrição e Cor&nbsp;</div><div><br></div><div>Funcionalidades:</div><div><span style="white-space:pre">	</span>- Cadastrar novas anotações. Quando uma nova anotação é criada será possível determinar a cor que aparecerá na listagem. (0.2)</div><div><span style="white-space:pre">	</span>- Excluir anotações.&nbsp;</div><div><span style="white-space:pre">		</span>- Além de excluir definitivamente qualquer anotação (0.2), o Google Keep Tabajara terá também a funcionalidade de envio de anotações para Lixeira (repositório de anotações excluídas) (0.2). Através da Lixeira será possível restaurar anotações deletadas (0.1) e excluir definitivamente qualquer anotação (0.1).</div><div><span style="white-space:pre">	</span>- Alterar anotações (0.2);</div><div><span style="white-space:pre">	</span>- Listar anotações (observação: cada anotação possui uma cor relacionada) (0.2);</div><div><span style="white-space:pre">	</span>- Copiar uma anotação existente (0.2);</div><div><span style="white-space:pre">	</span>- Ordenar por data/hora de criação (0.2);</div><div><span style="white-space:pre">	</span>- O acesso ao Google Keep Tabajara deverá ser somente feito mediante um processo de autenticação: login e senha (utilizar md5 para o armazenamento). Adicione o login na sessão. Não deverá ser possível acessar nenhuma página do sistema sem estar logado. Além da funcionalidade de autenticação, construa a operação logout (método invalidate() (0.5).</div><div><span style="white-space:pre">	</span>Dica: Crie uma lógica centralizada para verificação da senha. Utilize o &lt;%@include file="verifica_sessao.jsp" %&gt; no cabeçalho com o objetivo de centralizar o teste e a verificação do login e da senha.&nbsp;</div><div><br></div><div>Exigências:</div><div><span style="white-space:pre">	</span>- Utilizar o padrão DAO de persistência (0.2)</div><div><span style="white-space:pre">	</span>- Aplicar o paradigma O.O. Dica: Criar a classe Anotacao, criar a Classe Usuario, criar a classe AnotacaoDAO e etc. (0.2)</div>', '  ');
INSERT INTO public.questoes VALUES (57, '<p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;"><br class="Apple-interchange-newline">Descrição:</span></p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Você foi contratado para desenvolver um portal de notícias em Python/psycopg2/PostgreSQL especializado em&nbsp;<em>spoilers</em>.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Neste sistema, cada série cadastrada pode apresentar nenhum ou vários spoilers, dependendo da quantidade de spoilers vazados pela mídia ou cadastrados pelos próprios visitantes.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Um spoiler é composto de uma descrição, o episódio que o spoiler irá ocorrer, data de cadastro e a data da última modificação.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Um série é composta de um nome, quantidade total de temporadas, quantidade total de episódios e data de lançamento.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Deve ser possível elencar quais spoilers são de cada série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Quando a série é deletada, todos os spoilers da respectiva série devem também ser deletados. Um spoiler é exclusivo de uma única série.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Deve ser possível alterar todos os atributos de série e de spoiler. Ex: é possível alterar a série que detém um determinado spoiler.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Obviamente, é possível adicionar novos atributos/colunas tanto para série como para spoiler. Ex: índices, chaves e etc.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Exigências:</span></p><ol style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li>CRUD (criar, atualizar, listar e deletar) série.</li><li style="margin-top: 0.25em;">CRUD de spoilers</li><li style="margin-top: 0.25em;">Interação com usuário</li><li style="margin-top: 0.25em;">Validação/Máscara dos campos de data</li><li style="margin-top: 0.25em;">Integridade referencial (boas práticas de modelagem relacional)</li><li style="margin-top: 0.25em;">Aplicação em 3 camadas: aplicação, negócio (modelo) e persistência.</li><li style="margin-top: 0.25em;">Boas práticas de orientação a objetos: relacionamentos, atributos e etc. É imprescindível desenvolver o portal de acordo com as boas práticas O.O</li><li style="margin-top: 0.25em;">Uso correto do psycopg</li><li style="margin-top: 0.25em;">Sintaxe SQL correta.</li><li style="margin-top: 0.25em;">Tratamento de exceções em caso de bugs, erros e etc..</li><li style="margin-top: 0.25em;">Determine as séries com a maior e menor quantidade de spoilers.</li><li style="margin-top: 0.25em;">Exporte para um arquivo&nbsp;<em>csv</em>&nbsp;as séries cadastradas no PostgreSQL.</li></ol><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Exemplos:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Grey''s Anatomy:</span></p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Arizona e Torres irão se separar</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">O Derek morre</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">o bebê do jackson e da april terá problemas de saúde</p></li></ul></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">GOT:</span>&nbsp;o dragão derrubou a muralha de gelo</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Westworld:</span>&nbsp;o bernard também é um robô</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Prazo:</span>&nbsp;13/04</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Valor:</span>&nbsp;2</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Dica de Organização do Projeto:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Modelo:</span>&nbsp;classes&nbsp;<em>Serie</em>&nbsp;e&nbsp;<em>Spoiler</em>&nbsp;dentro do arquivo&nbsp;<em>modelo.py</em>. Dentro da classe&nbsp;<em>Serie</em>&nbsp;deve haver um vetor de objetos de&nbsp;<em>Spoiler</em>.</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Persistência:</span>&nbsp;classes&nbsp;<em>SerieDAO</em>&nbsp;e&nbsp;<em>SpoilerDAO</em>&nbsp;dentro do arquivo&nbsp;<em>persistencia.py</em>. Uma possibilidade é desenvolver o método&nbsp;<span style="font-weight: 600;">listar</span>&nbsp;da classe&nbsp;<span style="font-weight: 600;">SerieDAO</span>&nbsp;capaz de buscar tanto os atributos de série com também todos os objetos de spoilers (necessidade de um&nbsp;<span style="font-weight: 600;">inner join</span>ou duas consultas no mesmo método).</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><span style="font-weight: 600;">Apresentação:</span>&nbsp;<em>main.py</em></p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Leitura complementar:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980" rel="nofollow" style="color: rgb(3, 102, 214);">https://www.devmedia.com.br/tecnicas-de-mapeamento-objeto-relacional-revista-sql-magazine-40/6980</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional" rel="nofollow" style="color: rgb(3, 102, 214);">https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional</a></p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;"><a href="http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11" rel="nofollow" style="color: rgb(3, 102, 214);">http://www.guj.com.br/t/resolvido-o-que-afinal-e-orm/222371/11</a></p></li></ul> ', '     ');
INSERT INTO public.questoes VALUES (58, '<p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><br class="Apple-interchange-newline">Desenvolva um sistem de vendas de ingressos de um cinema com uma única sala, utilizando Python/Flask com PostgreSQL.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Observações</span>:</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Esta sala tem 10 lugares.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Não é possível vender dois ingressos para o mesmo lugar em uma mesma sessão.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Durante um dia, é possível que um mesmo filme seja exibido mais de uma vez (em horários diferentes).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Durante a venda, só é possível vender ingressos em sessões de filmes disponíveis para exibição (dentro do período de exibição).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Deve ser possível reportar a quantidade de ingressos já vendidos por cada sessão (e se já esgotou).</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">O cliente deve, no momento da compra, identificar as sessões e os vendidos e ainda disponíveis.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Uma Sessão tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li>data/hora da sessão</li><li style="margin-top: 0.25em;">filme</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Um Ingresso tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li>nome do cliente</li><li style="margin-top: 0.25em;">lugar (cadeira)</li><li style="margin-top: 0.25em;">sessão</li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Um Filme tem:</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li><p style="margin-top: 16px; margin-bottom: 16px;">título</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">sinopse</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">gênero</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">período de exibição</p><ul style="padding-left: 2em;"><li><p style="margin-top: 16px; margin-bottom: 16px;">data de início</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">data de fim</p></li></ul></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="font-weight: 600;">Exigências:</span></p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li>CRUD de sessão</li><li style="margin-top: 0.25em;">CRUD de ingressos</li><li style="margin-top: 0.25em;">CRUD de filmes</li><li style="margin-top: 0.25em;">Venda de ingressos</li><li style="margin-top: 0.25em;">Cancelamento de pedidos de ingressos</li><li style="margin-top: 0.25em;">Verificação de não ser possível vender mais de ingresso para a mesma cadeira em uma mesma sessão</li><li style="margin-top: 0.25em;">Utilizar uma biblioteca css (ex: bootstrap ou materialize). É obrigatório utilizar pelo menos 10 recursos DIFERENTES de estilo em cada página.</li><li style="margin-top: 0.25em;">validar os formulários por js</li><li style="margin-top: 0.25em;">tanto arquivos js como css devem ser externos aos arquivos html</li><li style="margin-top: 0.25em;">desenvolver o sistema em 3 camadas: apresentação (html), modelo (classes lógicas) e persistência (dao).</li><li></li></ul> ', ' ');
INSERT INTO public.questoes VALUES (59, '<p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Desenvolva uma galeria de fotos.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Uma foto pertence exclusivamente a uma galeria. Uma galeria possui n fotos.</p><ul style="padding-left: 2em; margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><li><p style="margin-top: 16px; margin-bottom: 16px;">Uma galeria tem: título, descrição e suas fotos</p></li><li style="margin-top: 0.25em;"><p style="margin-top: 16px; margin-bottom: 16px;">Uma foto tem: legenda.</p></li></ul><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Somente usuários previamente autorizados podem acessar a parte administrativa, ou seja, modificar galerias e as respectivas fotos.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;">Além disso, é preciso armazenar no banco de dados todas as url de acesso e todos os usuários. Motivo: segurança.</p><p style="margin-bottom: 16px; color: rgb(36, 41, 46); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-size: 16px;"><span style="background-color: transparent;">Utilize interceptadores, sessão e todo o aparato do vRaptor de upload e de download de arquivos.</span></p> ', ' ');
INSERT INTO public.questoes VALUES (50, '<div><ul><li>Desenvolver um sistema web para uma Garagem Coletiva<span style="background-color: transparent;">.</span></li></ul></div><div><br></div><div><b><u>Classes do Sistema:</u></b></div><div><span style="background-color: transparent;"><br></span></div><div><span style="background-color: transparent;"><b>Carro</b></span></div><div><div><ul><li><span style="background-color: transparent;">placa (String)</span></li><li><span style="background-color: transparent;">modelo (String)</span></li><li><span style="background-color: transparent;">ano (inteiro)</span></li><li><span style="background-color: transparent;">marca (String)</span></li></ul></div><div><b>Locação</b></div><div><ul><li><span style="background-color: transparent;">Box (objeto do tipo Box)</span></li><li><span style="background-color: transparent;">Carro (objeto do tipo Carro)</span></li><li><span style="background-color: transparent;">datahora_inicio (timestamp, calendar e etc)</span></li><li><span style="background-color: transparent;">datahora_fim (timestamp, calendar e etc)</span></li><li><span style="background-color: transparent;">valor (double) (por segundo, por hora, por dia)</span></li></ul></div><div><b>Box</b></div><div><ul><li><span style="background-color: transparent;">numero (inteiro)</span></li><li><span style="background-color: transparent;">ocupado? (booleano)</span></li></ul><div><br></div></div><div><b>Dica:</b> Construa as tabelas no SGBD e as classes de modelo.</div><div><br></div><div><b><u>Funcionalidades</u></b>:</div><div><br></div><div><ol><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Carros(0.2)&nbsp;</li><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Boxes(0.2)&nbsp;</li><li>Cadastrar(0.2)/Excluir(0.2)/Alterar(0.2)/Listar Locações(0.2)&nbsp;</li><li>Definir o valor total de uma locação (0.3)</li><li>Listar as Locações correntes (locações que estão em trâmite no momento) (0.3)</li></ol><div><div><b><u>Obervações</u></b>:</div></div></div><div><ul><li>Lembre que para excluir qualquer carro é preciso, anteriormente, excluir todas as locações do mesmo.</li></ul></div><div><ul><li>Lembre que para excluir qualquer box é preciso, anteriormente, excluir todas as locações do mesmo.</li></ul></div><div><br></div><div><b>Valor Total:</b> 3 pontos</div><div><b>Individual</b></div><div><b>É permitido consultar material próprio</b></div></div> ', '   ');


--
-- TOC entry 3518 (class 0 OID 52861)
-- Dependencies: 235
-- Data for Name: questoes_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questoes_tags VALUES (88, 43, 7);
INSERT INTO public.questoes_tags VALUES (89, 43, 8);
INSERT INTO public.questoes_tags VALUES (90, 43, 10);
INSERT INTO public.questoes_tags VALUES (98, 46, 7);
INSERT INTO public.questoes_tags VALUES (99, 46, 8);
INSERT INTO public.questoes_tags VALUES (115, 49, 7);
INSERT INTO public.questoes_tags VALUES (116, 49, 8);
INSERT INTO public.questoes_tags VALUES (55, 26, 11);
INSERT INTO public.questoes_tags VALUES (122, 31, 11);
INSERT INTO public.questoes_tags VALUES (67, 33, 11);
INSERT INTO public.questoes_tags VALUES (125, 30, 11);
INSERT INTO public.questoes_tags VALUES (133, 51, 8);
INSERT INTO public.questoes_tags VALUES (134, 51, 15);
INSERT INTO public.questoes_tags VALUES (161, 57, 7);
INSERT INTO public.questoes_tags VALUES (162, 57, 8);
INSERT INTO public.questoes_tags VALUES (163, 57, 9);
INSERT INTO public.questoes_tags VALUES (164, 57, 10);
INSERT INTO public.questoes_tags VALUES (165, 57, 15);
INSERT INTO public.questoes_tags VALUES (166, 58, 8);
INSERT INTO public.questoes_tags VALUES (167, 58, 9);
INSERT INTO public.questoes_tags VALUES (168, 59, 8);
INSERT INTO public.questoes_tags VALUES (174, 50, 8);


--
-- TOC entry 3506 (class 0 OID 52825)
-- Dependencies: 223
-- Data for Name: tabela_nota_exame; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tabela_nota_exame VALUES (1, 27.9, 2.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (2, 27.8, 2.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (3, 27.7, 2.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (4, 27.6, 2.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (5, 27.5, 2.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (6, 27.4, 2.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (7, 27.3, 2.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (8, 27.2, 2.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (9, 27.1, 2.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (10, 27, 2.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (11, 26.9, 2.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (12, 26.8, 2.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (13, 26.7, 2.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (14, 26.6, 2.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (15, 26.5, 2.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (16, 26.4, 2.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (17, 26.3, 2.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (18, 26.2, 2.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (19, 26.1, 2.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (20, 26, 2.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (21, 25.9, 2.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (22, 25.8, 2.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (23, 25.7, 2.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (24, 25.6, 2.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (25, 25.5, 3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (26, 25.4, 3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (27, 25.3, 3.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (28, 25.2, 3.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (29, 25.1, 3.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (30, 25, 3.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (31, 24.9, 3.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (32, 24.8, 3.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (33, 24.7, 3.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (34, 24.6, 3.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (35, 24.5, 3.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (36, 24.4, 3.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (37, 24.3, 3.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (38, 24.2, 3.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (39, 24.1, 3.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (40, 24, 3.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (41, 23.9, 3.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (42, 23.8, 3.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (43, 23.7, 3.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (44, 23.6, 3.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (45, 23.5, 3.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (46, 23.4, 3.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (47, 23.3, 3.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (48, 23.2, 3.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (49, 23.1, 3.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (50, 23, 3.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (51, 22.9, 4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (52, 22.8, 4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (53, 22.7, 4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (54, 22.6, 4.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (55, 22.5, 4.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (56, 22.4, 4.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (57, 22.3, 4.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (58, 22.2, 4.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (59, 22.1, 4.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (60, 22, 4.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (61, 21.9, 4.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (62, 21.8, 4.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (63, 21.7, 4.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (64, 21.6, 4.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (65, 21.5, 4.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (66, 21.4, 4.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (67, 21.3, 4.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (68, 21.2, 4.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (69, 21.1, 4.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (70, 21, 4.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (71, 20.9, 4.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (72, 20.8, 4.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (73, 20.7, 4.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (74, 20.6, 4.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (75, 20.5, 4.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (76, 20.4, 4.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (77, 20.3, 4.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (78, 20.2, 5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (79, 20.1, 5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (80, 20, 5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (81, 19.9, 5.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (82, 19.8, 5.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (83, 19.7, 5.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (84, 19.6, 5.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (85, 19.5, 5.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (86, 19.4, 5.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (87, 19.3, 5.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (88, 19.2, 5.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (89, 19.1, 5.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (90, 19, 5.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (91, 18.9, 5.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (92, 18.8, 5.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (93, 18.7, 5.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (94, 18.6, 5.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (95, 18.5, 5.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (96, 18.4, 5.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (97, 18.3, 5.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (98, 18.2, 5.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (99, 18.1, 5.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (100, 18, 5.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (101, 17.9, 5.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (102, 17.8, 5.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (103, 17.7, 5.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (104, 17.6, 5.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (105, 17.5, 6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (106, 17.4, 6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (107, 17.3, 6.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (108, 17.2, 6.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (109, 17.1, 6.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (110, 17, 6.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (111, 16.9, 6.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (112, 16.8, 6.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (113, 16.7, 6.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (114, 16.6, 6.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (115, 16.5, 6.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (116, 16.4, 6.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (117, 16.3, 6.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (118, 16.2, 6.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (119, 16.1, 6.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (120, 16, 6.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (121, 15.9, 6.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (122, 15.8, 6.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (123, 15.7, 6.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (124, 15.6, 6.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (125, 15.5, 6.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (126, 15.4, 6.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (127, 15.3, 6.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (128, 15.2, 6.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (129, 15.1, 6.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (130, 15, 6.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (131, 14.9, 7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (132, 14.8, 7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (133, 14.7, 7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (134, 14.6, 7.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (135, 14.5, 7.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (136, 14.4, 7.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (137, 14.3, 7.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (138, 14.2, 7.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (139, 14.1, 7.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (140, 14, 7.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (141, 13.9, 7.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (142, 13.8, 7.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (143, 13.7, 7.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (144, 13.6, 7.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (145, 13.5, 7.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (146, 13.4, 7.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (147, 13.3, 7.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (148, 13.2, 7.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (149, 13.1, 7.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (150, 13, 7.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (151, 12.9, 7.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (152, 12.8, 7.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (153, 12.7, 7.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (154, 12.6, 7.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (155, 12.5, 7.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (156, 12.4, 7.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (157, 12.3, 7.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (158, 12.2, 8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (159, 12.1, 8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (160, 12, 8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (161, 11.9, 8.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (162, 11.8, 8.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (163, 11.7, 8.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (164, 11.6, 8.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (165, 11.5, 8.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (166, 11.4, 8.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (167, 11.3, 8.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (168, 11.2, 8.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (169, 11.1, 8.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (170, 11, 8.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (171, 10.9, 8.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (172, 10.8, 8.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (173, 10.7, 8.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (174, 10.6, 8.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (175, 10.5, 8.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (176, 10.4, 8.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (177, 10.3, 8.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (178, 10.2, 8.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (179, 10.1, 8.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (180, 10, 8.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (181, 9.9, 8.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (182, 9.8, 8.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (183, 9.7, 8.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (184, 9.6, 8.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (185, 9.5, 9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (186, 9.4, 9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (187, 9.3, 9.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (188, 9.2, 9.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (189, 9.1, 9.1, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (190, 9, 9.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (191, 8.9, 9.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (192, 8.8, 9.2, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (193, 8.7, 9.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (194, 8.6, 9.3, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (195, 8.5, 9.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (196, 8.4, 9.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (197, 8.3, 9.4, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (198, 8.2, 9.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (199, 8.1, 9.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (200, 8, 9.5, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (201, 7.9, 9.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (202, 7.8, 9.6, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (203, 7.7, 9.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (204, 7.6, 9.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (205, 7.5, 9.7, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (206, 7.4, 9.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (207, 7.3, 9.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (208, 7.2, 9.8, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (209, 7.1, 9.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (210, 7, 9.9, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (211, 6.9, 10, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (212, 6.8, 10, 'ANUAL');
INSERT INTO public.tabela_nota_exame VALUES (213, 6.7, 10, 'ANUAL');


--
-- TOC entry 3519 (class 0 OID 52864)
-- Dependencies: 236
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tags VALUES (4, 'Observer');
INSERT INTO public.tags VALUES (6, 'TemplateMethod');
INSERT INTO public.tags VALUES (7, 'JSP');
INSERT INTO public.tags VALUES (8, 'WEB');
INSERT INTO public.tags VALUES (9, 'Python/Flask');
INSERT INTO public.tags VALUES (10, 'vRaptor');
INSERT INTO public.tags VALUES (11, 'ER');
INSERT INTO public.tags VALUES (12, 'JS');
INSERT INTO public.tags VALUES (13, 'Padrão de Projeto');
INSERT INTO public.tags VALUES (14, 'ORM');
INSERT INTO public.tags VALUES (15, 'Ruby');


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 210
-- Name: alternativas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alternativas_id_seq', 1, false);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 212
-- Name: alunos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alunos_id_seq', 1308, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 214
-- Name: anotacoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.anotacoes_id_seq', 84, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 216
-- Name: avaliacoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avaliacoes_id_seq', 917, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 218
-- Name: creditos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.creditos_id_seq', 192, true);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 220
-- Name: cursos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cursos_id_seq', 4, true);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 222
-- Name: disciplinas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.disciplinas_id_seq', 127, true);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 224
-- Name: nota_exame2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nota_exame2_id_seq', 213, true);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 226
-- Name: notas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notas_id_seq', 5534, true);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 228
-- Name: planos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planos_id_seq', 903, true);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 230
-- Name: presencas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.presencas_id_seq', 14383, true);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 232
-- Name: provas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provas_id_seq', 15, true);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 234
-- Name: questoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questoes_id_seq', 59, true);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 237
-- Name: questoes_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questoes_tags_id_seq', 15, true);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 238
-- Name: questoes_tags_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questoes_tags_id_seq1', 174, true);


--
-- TOC entry 3298 (class 2606 OID 52892)
-- Name: alternativas alternativas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alternativas
    ADD CONSTRAINT alternativas_pk PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 52894)
-- Name: alunos alunos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alunos
    ADD CONSTRAINT alunos_pk PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 52896)
-- Name: alunos alunos_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alunos
    ADD CONSTRAINT alunos_unique UNIQUE (matricula, disciplina_id);


--
-- TOC entry 3304 (class 2606 OID 52898)
-- Name: anotacoes anotacoes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anotacoes
    ADD CONSTRAINT anotacoes_pk PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 52900)
-- Name: avaliacoes avaliacoes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacoes
    ADD CONSTRAINT avaliacoes_pk PRIMARY KEY (id);


--
-- TOC entry 3308 (class 2606 OID 52902)
-- Name: creditos creditos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creditos
    ADD CONSTRAINT creditos_pk PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 52904)
-- Name: disciplinas disciplina_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT disciplina_unique UNIQUE (nome, ano, semestre);


--
-- TOC entry 3314 (class 2606 OID 52906)
-- Name: disciplinas disciplinas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT disciplinas_pk PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 52908)
-- Name: cursos id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 3316 (class 2606 OID 52910)
-- Name: tabela_nota_exame nota_exame; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabela_nota_exame
    ADD CONSTRAINT nota_exame PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 52912)
-- Name: tabela_nota_exame nota_exame_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabela_nota_exame
    ADD CONSTRAINT nota_exame_unique UNIQUE (somatorio, precisa, modalidade);


--
-- TOC entry 3321 (class 2606 OID 52914)
-- Name: notas notas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas
    ADD CONSTRAINT notas_pk PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 52916)
-- Name: notas notas_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas
    ADD CONSTRAINT notas_unique UNIQUE (avaliacao_id, aluno_id);


--
-- TOC entry 3325 (class 2606 OID 52918)
-- Name: planos plano_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planos
    ADD CONSTRAINT plano_pk PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 52920)
-- Name: planos planos_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planos
    ADD CONSTRAINT planos_unique UNIQUE (data, disciplina_id);


--
-- TOC entry 3330 (class 2606 OID 52922)
-- Name: presencas presencas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presencas
    ADD CONSTRAINT presencas_pk PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 52924)
-- Name: presencas presencas_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presencas
    ADD CONSTRAINT presencas_unique UNIQUE (aluno_id, disciplina_id, data);


--
-- TOC entry 3334 (class 2606 OID 52926)
-- Name: provas provas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provas
    ADD CONSTRAINT provas_pk PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 52928)
-- Name: questoes_tags questao_tag_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questoes_tags
    ADD CONSTRAINT questao_tag_pk PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 52930)
-- Name: questoes questoes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questoes
    ADD CONSTRAINT questoes_pk PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 52932)
-- Name: tags questoes_tags_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT questoes_tags_pk PRIMARY KEY (id);


--
-- TOC entry 3319 (class 1259 OID 52933)
-- Name: fki_notas_fk1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_notas_fk1 ON public.notas USING btree (aluno_id);


--
-- TOC entry 3328 (class 1259 OID 52934)
-- Name: fki_presenca_pk1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_presenca_pk1 ON public.presencas USING btree (disciplina_id);


--
-- TOC entry 3341 (class 2606 OID 52935)
-- Name: alternativas alternativas_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alternativas
    ADD CONSTRAINT alternativas_fk1 FOREIGN KEY (questao_id) REFERENCES public.questoes(id);


--
-- TOC entry 3342 (class 2606 OID 52940)
-- Name: alunos alunos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alunos
    ADD CONSTRAINT alunos_fk FOREIGN KEY (disciplina_id) REFERENCES public.disciplinas(id);


--
-- TOC entry 3343 (class 2606 OID 52945)
-- Name: anotacoes anotacoes_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anotacoes
    ADD CONSTRAINT anotacoes_fk1 FOREIGN KEY (disciplina_id) REFERENCES public.disciplinas(id);


--
-- TOC entry 3344 (class 2606 OID 52950)
-- Name: avaliacoes avaliacoes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacoes
    ADD CONSTRAINT avaliacoes_fk FOREIGN KEY (disciplina_id) REFERENCES public.disciplinas(id);


--
-- TOC entry 3345 (class 2606 OID 52955)
-- Name: disciplinas curso_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT curso_id FOREIGN KEY (curso_id) REFERENCES public.cursos(id);


--
-- TOC entry 3346 (class 2606 OID 52960)
-- Name: notas notas_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas
    ADD CONSTRAINT notas_fk FOREIGN KEY (avaliacao_id) REFERENCES public.avaliacoes(id);


--
-- TOC entry 3347 (class 2606 OID 52965)
-- Name: notas notas_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas
    ADD CONSTRAINT notas_fk1 FOREIGN KEY (aluno_id) REFERENCES public.alunos(id);


--
-- TOC entry 3348 (class 2606 OID 52970)
-- Name: planos plano_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planos
    ADD CONSTRAINT plano_fk FOREIGN KEY (disciplina_id) REFERENCES public.disciplinas(id);


--
-- TOC entry 3349 (class 2606 OID 52975)
-- Name: presencas presenca_pk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presencas
    ADD CONSTRAINT presenca_pk1 FOREIGN KEY (disciplina_id) REFERENCES public.disciplinas(id);


--
-- TOC entry 3350 (class 2606 OID 52980)
-- Name: presencas presencas_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presencas
    ADD CONSTRAINT presencas_fk FOREIGN KEY (aluno_id) REFERENCES public.alunos(id);


--
-- TOC entry 3351 (class 2606 OID 52985)
-- Name: questoes_tags questao_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questoes_tags
    ADD CONSTRAINT questao_fk FOREIGN KEY (questao_id) REFERENCES public.questoes(id);


--
-- TOC entry 3352 (class 2606 OID 52990)
-- Name: questoes_tags tag_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questoes_tags
    ADD CONSTRAINT tag_fk FOREIGN KEY (tag_id) REFERENCES public.tags(id);


-- Completed on 2023-04-29 10:22:39 -03

--
-- PostgreSQL database dump complete
--

