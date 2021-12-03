% Cadastro e Remoção de estudantes
:- module(
  estudante,
  [
    add_estudante/2, % +Nome:atom, +Curso:atom
    retract_estudante/2, % -Nome:atom, -Curso:atom
    current_estudante/2 % ?Nome:atom, ?Curso:atom
  ]
).

:- use_module(library(persistency)).

:- persistent(estudante(nome:atom,curso:atom)).

:- initialization(db_attach('estudante_db', [])).

add_estudante(Nome,Curso):-
  with_mutex(estudante_db, assert_estudante(Nome,Curso)).

retract_estudante(Nome,Curso):-
 with_mutex(estudante_db, retract_estudante(Nome, Curso)).

current_estudante(Nome,Curso):-
  with_mutex(estudante_db, estudante(Nome,Curso)).

% Cadastro e Remoção de Disciplinas
:- module(
  disciplina,
  [
    add_disciplina/2, % +Nome:atom, +Curso:atom
    retract_disciplina/2, % -Nome:atom, -Curso:atom
    current_disciplina/2 % ?Nome:atom, ?Curso:atom
  ]
).

:- use_module(library(persistency)).

:- persistent(disciplina(nome:atom,curso:atom)).

:- initialization(db_attach('estudante_db', [])).

add_disciplina(Nome,Curso):-
  with_mutex(disciplina_db, assert_disciplina(Nome,Curso)).

retract_disciplina(Nome,Curso):-
 with_mutex(disciplina_db, retract_disciplina(Nome, Curso)).

current_disciplina(Nome,Curso):-
  with_mutex(disciplina_db, disciplina(Nome,Curso)).  

%estudantes de Ciencia da Computação

nota('Matheus','Algoritmos',70).
nota('Matheus','Calculo 1',90).
nota('Matheus','Calculo 2',40).

nota('André','Calculo 1',80).
nota('Thiago','Calculo 2',70).

nota('Lucas','Calculo 1',40).

% disciplinas de Ciência da computação
 %1°periodo
disciplina('Algoritmos','Ciência da computação').
disciplina('Calculo 1','Ciência da computação').
disciplina('Lógica e Fundamentos da Computação','Ciência da computação').
disciplina('Geom. Anal e Sist. Lineares','Ciência da computação').
disciplina('Lab. C.C','Ciência da computação').
disciplina('Lab de Prog.','Ciência da computação').
disciplina('Introd. Á C.C','Ciência da computação').
%2°periodo
disciplina('Algebra Linear','Ciência da computação').
disciplina('Calculo 2','Ciência da computação').
disciplina('Fisica 1','Ciência da computação').
disciplina('Lab. Fisica 1','Ciência da computação').
disciplina('Estrutura de Dados','Ciência da computação').
disciplina('Lab. de Prog. 2','Ciência da computação').
%3°periodo
disciplina('Int. A Teoria da dos Numeros','Ciência da computação').
disciplina('Calculo 3','Ciência da computação').
disciplina('Teoria dos Grafos','Ciência da computação').
disciplina('Circuitos Digitais','Ciência da computação').
disciplina('Orientação a Objetos','Ciência da computação').
disciplina('Inf & Socied.','Ciência da computação').
%4°periodo
disciplina('Equacões Diferenciais I','Ciência da computação').
disciplina('Introdução a Estatistica','Ciência da computação').
disciplina('Organização de Computadores','Ciência da computação').
disciplina('Estrutura de Dados II','Ciência da computação').
disciplina('Modelagem de Sistemas','Ciência da computação').
%5°periodo
disciplina('Calculo de Probabilidades','Ciência da computação').
disciplina('Inteligencia Artificial','Ciência da computação').
disciplina('Sistemas Operacionais','Ciência da computação').
disciplina('Banco de Dados','Ciência da computação').
disciplina('Engenharia de Software','Ciência da computação').
%6°periodo
disciplina('Pesquisa Operacional','Ciência da computação').
disciplina('Linguagens Formais','Ciência da computação').
disciplina('Redes de Computadores','Ciência da computação').
disciplina('Calculo Numérico','Ciência da computação').
disciplina('Interação Humano Computador','Ciência da computação').
%7°periodo
disciplina('Segurança em Sis. de Computação','Ciência da computação').
disciplina('Teoria da Computação','Ciência da computação').
disciplina('Analise e Projeto de Algoritimos','Ciência da computação').
disciplina('Computação Grafica','Ciência da computação').
%8°periodo
disciplina('Linguagens de Programação','Ciência da computação').
disciplina('Teoria dos Compiladores','Ciência da computação').
disciplina('Sistemas Distribuídos','Ciência da computação').

%Sistemas de Informação

%discplinas de Sistemas de Informação
 %1°periodo
disciplina('Algoritmos','Sistemas de Informação').
disciplina('Calculo 1','Sistemas de Informação').
disciplina('Lógica e Fundamentos da Computação','Sistemas de Informação').
disciplina('Geom. Anal e Sist. Lineares','Sistemas de Informação').
disciplina('Lab de Prog.','Sistemas de Informação').
disciplina('Introd. Á Sistemas de Informação','Sistemas de Informação').
 %2°periodo
disciplina('Laboratorio de Program. Web','Sistemas de Informação').
disciplina('Calculo 2','Sistemas de Informação').
disciplina('Estrutura de Dados','Sistemas de Informação').
disciplina('Principios Gerais de Administraçao I','Sistemas de Informação').
disciplina('Lab de Prog. II','Sistemas de Informação').
disciplina('Aspectos Legais da Informatica','Sistemas de Informação').
 %3°periodo
disciplina('Calculo de Prbabilidades I','Sistemas de Informação').
disciplina('Orientação a Objetos','Sistemas de Informação').
disciplina('Teoria dos Grafos','Sistemas de Informação').
disciplina('Contabilidade Geral e Introdutória','Sistemas de Informação').
disciplina('Informatica e Sociedade','Sistemas de Informação').
 %4° periodo
disciplina('Organização de Compiladores','Sistemas de Informação').
disciplina('Modelagem de Sistemas','Sistemas de Informação').
disciplina('Aspectos Teoricos da Computação','Sistemas de Informação').
disciplina('Estrutura de Dados II','Sistemas de Informação').
 %5° periodo
disciplina('Sistemas Operacionais','Sistemas de Informação').
disciplina('Inteligencia Artificial','Sistemas de Informação').
disciplina('Engenharia de Software','Sistemas de Informação').
disciplina('Banco de Dados','Sistemas de Informação').
disciplina('Laboratorio de Programação de Sistemas Web','Sistemas de Informação').
 %6° periodo
disciplina('Redes de computadores','Sistemas de Informação').
disciplina('Pesquisa Operacional','Sistemas de Informação').
disciplina('Intreação Humano-Computador','Sistemas de Informação').
disciplina('Laboratorio de Programação de Sistemas Web II','Sistemas de Informação').
disciplina('Empreendimentos em Informatica','Sistemas de Informação').
 %7° periodo
disciplina('Gerencia de Projetos','Sistemas de Informação').
disciplina('Teste de Software','Sistemas de Informação').
disciplina('Aspectos Avançados de Eng. de Software','Sistemas de Informação').
disciplina('Aspectos  Avançados em Banco de Dados','Sistemas de Informação').
disciplina('Aspectos Organizacionais de SI','Sistemas de Informação').
disciplina('Metodologia Científica em Computação','Sistemas de Informação').
 %8° periodo
disciplina('Laboratorio de Programação para Dispostivos Móveis','Sistemas de Informação').
disciplina('Sistema de Apoio á Decisão','Sistemas de Informação').
disciplina('Segurança e Auditoria em Sistemas','Sistemas de Informação').

alunoCursouDisciplinaAux(Aluno, Disciplina) :- estudante(Aluno, _), nota(Aluno, Disciplina, _).

alunoCursouDisciplina(Alunos, Disciplina) :- findall(Aluno, alunoCursouDisciplinaAux(Aluno, Disciplina), Alunos).

alunoCursouDisciplinaNotaMin(Alunos, Disciplina, ValorMin) :- findall(Aluno, filtroPorNota(Aluno, _, Disciplina, ValorMin), Alunos).

filtraIraAux(Aluno, Curso, IraMin) :- estudanteIra(Aluno, Curso, IraResultado), IraResultado >= IraMin.

alunosCursoIraMinimo(Alunos, Curso, IraMin) :- findall(Aluno, filtraIraAux(Aluno, Curso, IraMin), Alunos).

filtroPorNota(Aluno, Curso, Disciplina, ValorMin) :- estudante(Aluno, Curso), nota(Aluno, Disciplina, Valor), Valor>=ValorMin.

alunosCursoDisciplinaNotaMinima(Alunos, Curso, Disciplina, ValorMin) :- findall(Aluno, filtroPorNota(Aluno, Curso, Disciplina, ValorMin), Alunos).

cursosComDisciplina(Disciplina, Cursos) :- findall(Curso, disciplina(Disciplina, Curso), Cursos).

matriz(DisciplinasMatriz, Curso) :- findall(Disciplinas, disciplina(Disciplinas, Curso), DisciplinasMatriz).

historicoComNota(Aluno, Lista) :- findall(Disciplinas/Valor, nota(Aluno, Disciplinas, Valor), Lista).

historicoSemNota(Aluno, Lista) :- findall(Disciplinas, nota(Aluno, Disciplinas, _), Lista).

estudanteIra(Aluno, Curso, Ira) :- estudante(Aluno, Curso), ira(Aluno, Ira).

ira(Aluno, IraResultado) :- findall(Valor, nota(Aluno, _, Valor), Notas), sumlist(Notas, Soma), length(Notas, Tamanho), dif(Tamanho,0) -> IraResultado is Soma/Tamanho; IraResultado is 0.

estudantesCurso(ListaAlunos, Curso) :- findall(Aluno, estudante(Aluno, Curso), ListaAlunos).

%verificar se escolha é válida antes de dar executaEscolha(Escolha).
menu :- repeat,
    write('Bem vindo ao sistema de gestão acadêmica! Escolha uma opção: '),nl,
    write('1: Calcular IRA de um aluno'),nl,
    write('2: Buscar matriz curricular de um curso'),nl,
    write('3: Buscar histórico de um aluno'),nl,
    write('4: Buscar alunos matriculados em um curso'),nl,
    write('5: Buscar alunos que já cursaram uma disciplina'),nl,
    write('6: Buscar relação de disciplinas que faltam serem cursadas para um dado estudante'),nl,
    write('7: Realizar um cadastro de algum conhecimento'),nl,
    write('8: Realizar edição de algum conhecimento'),nl,
    write('9: Realizar a edição de algum conhecimento'),nl,
    read(Escolha),
    executaEscolha(Escolha).

executaEscolha(1) :- write('Digite o nome do aluno entre aspas simples'),nl,
    read(Nome),nl,
    estudanteIra(Nome, Curso, IraResultado),
    write(IraResultado),nl,
    menu.

executaEscolha(2) :- write('Digite o nome do curso entre aspas simples'),nl,
    read(Curso),nl,
    matriz(DisciplinasMatriz, Curso),
    write(DisciplinasMatriz),nl,
    menu.

executaEscolha(3) :- write('Digite o nome do aluno entre aspas simples'),nl,
    read(Nome),nl,
    historicoComNota(Nome, Historico),
    write(Historico),nl,
    menu.

executaEscolha(4) :- write('Qual é o critério desejado?'),nl,
    write('1: Nota mínima em disciplina'),nl,
    write('2: IRA mínimo'),nl,
    read(Opcao),
    alunosCurso(Opcao),
    menu.

alunosCurso(1) :- write('Qual é a disciplina desejada como critério?'),nl,
    read(Disciplina),nl,
    write('Qual é o curso?'),nl,
    read(Curso),nl,
    write("Qual a nota mínima?"),nl,
    read(Nota),nl,
    alunosCursoDisciplinaNotaMinima(Alunos, Curso, Disciplina, Nota),
    write(Alunos),nl,
    menu.

alunosCurso(2) :- write('Qual é IRA mínimo?'),nl,
    read(Ira),nl,
    write('Qual é o curso?'),nl,
    read(Curso),nl,
    alunosCursoIraMinimo(Alunos, Curso, Ira),
    write(Alunos),nl,
    menu.

alunosCurso(3) :- write('Qual é o curso?'),nl,
    read(Curso),nl,
    estudantesCurso(Alunos, Curso),
    write(Alunos),nl,
    menu.

executaEscolha(5) :- write("Deseja critério por nota?"),nl,
    write("1: Não"),nl,
    write("2: Sim"),nl,
    read(Opcao),
    alunosDisciplina(Opcao),
    menu.

alunosDisciplina(1) :- write('Qual a disciplina?'),nl,
    read(Disciplina),nl,
    alunoCursouDisciplina(Alunos, Disciplina),
    write(Alunos),
    menu.
