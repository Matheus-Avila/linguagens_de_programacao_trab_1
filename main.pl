:-module(
  estudante,
  [
    add_estudante/2, % +Nome:atom, +Curso:atom
    retract_estudante/2, % -Nome:atom, -Curso:atom
    current_estudante/2 % ?Nome:atom, ?Curso:atom
  ]
).
use_module(disciplina).
use_module(nota).
use_module(curso).

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
 

disciplinasFaltamAluno(Aluno, Curso, Disciplinas) :- matriz(DisciplinasMatriz, Curso), historicoSemNota(Aluno, Historico), subtract(DisciplinasMatriz,Historico, Disciplinas).

alunoCursouDisciplinaAux(Aluno, Disciplina) :- estudante(Aluno, _), nota:nota(Aluno, Disciplina, _).

alunoCursouDisciplina(Alunos, Disciplina) :- findall(Aluno, alunoCursouDisciplinaAux(Aluno, Disciplina), Alunos).

alunoCursouDisciplinaNotaMin(Alunos, Disciplina, ValorMin) :- findall(Aluno, filtroPorNota(Aluno, _, Disciplina, ValorMin), Alunos).

filtraIraAux(Aluno, Curso, IraMin) :- estudanteIra(Aluno, Curso, IraResultado), IraResultado >= IraMin.

alunosCursoIraMinimo(Alunos, Curso, IraMin) :- findall(Aluno, filtraIraAux(Aluno, Curso, IraMin), Alunos).

filtroPorNota(Aluno, Curso, Disciplina, ValorMin) :- estudante(Aluno, Curso), nota:nota(Aluno, Disciplina, Valor), Valor>=ValorMin.

alunosCursoDisciplinaNotaMinima(Alunos, Curso, Disciplina, ValorMin) :- findall(Aluno, filtroPorNota(Aluno, Curso, Disciplina, ValorMin), Alunos).

cursosComDisciplina(Disciplina, Cursos) :- findall(Curso, disciplina:disciplina(Disciplina, Curso), Cursos).

matriz(DisciplinasMatriz, Curso) :- findall(Disciplinas, disciplina:disciplina(Disciplinas, Curso), DisciplinasMatriz).

historicoComNota(Aluno, Lista) :- findall(Disciplinas/Valor, nota:nota(Aluno, Disciplinas, Valor), Lista).

historicoSemNota(Aluno, Lista) :- findall(Disciplinas, nota:nota(Aluno, Disciplinas, _), Lista).

estudanteIra(Aluno, Curso, Ira) :- estudante(Aluno, Curso), ira(Aluno, Ira).

ira(Aluno, IraResultado) :- findall(Valor, nota:nota(Aluno, _, Valor), Notas), sumlist(Notas, Soma), length(Notas, Tamanho), dif(Tamanho,0) -> IraResultado is Soma/Tamanho; IraResultado is 0.

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
    write('9: Realizar remoção de algum conhecimento'),nl,
    read(Escolha),
    executaEscolha(Escolha).

executaEscolha(1) :- write('Digite o nome do aluno entre aspas simples'),nl,
    read(Nome),nl,
    estudante:estudanteIra(Nome, Curso, IraResultado),
    write(IraResultado),nl,
    menu.

executaEscolha(2) :- write('Digite o nome do curso entre aspas simples'),nl,
    read(Curso),nl,
    estudante:matriz(DisciplinasMatriz, Curso),
    write(DisciplinasMatriz),nl,
    menu.

executaEscolha(3) :- write('Digite o nome do aluno entre aspas simples'),nl,
    read(Nome),nl,
    estudante:historicoComNota(Nome, Historico),
    write(Historico),nl,
    menu.

executaEscolha(4) :- write('Qual é o critério desejado?'),nl,
    write('1: Nota mínima em disciplina'),nl,
    write('2: IRA mínimo'),nl,
    read(Opcao),
    estudante:alunosCurso(Opcao),
    menu.

alunosCurso(1) :- write('Qual é a disciplina desejada como critério?'),nl,
    read(Disciplina),nl,
    write('Qual é o curso?'),nl,
    read(Curso),nl,
    write("Qual a nota mínima?"),nl,
    read(Nota),nl,
    estudante:alunosCursoDisciplinaNotaMinima(Alunos, Curso, Disciplina, Nota),
    write(Alunos),nl,
    menu.

alunosCurso(2) :- write('Qual é IRA mínimo?'),nl,
    read(Ira),nl,
    write('Qual é o curso?'),nl,
    read(Curso),nl,
    estudante:alunosCursoIraMinimo(Alunos, Curso, Ira),
    write(Alunos),nl,
    menu.

alunosCurso(3) :- write('Qual é o curso?'),nl,
    read(Curso),nl,
    estudante:estudantesCurso(Alunos, Curso),
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
    estudante:alunoCursouDisciplina(Alunos, Disciplina),
    write(Alunos),
    menu.

alunosDisciplina(2) :- write('Qual a disciplina?'),nl,
    read(Disciplina),nl,
    write('Qual a nota mínima?'),nl,
    read(Nota),nl,
    estudante:alunoCursouDisciplinaNotaMin(Alunos, Disciplina, Nota),
    write(Alunos),
    menu.

executaEscolha(6) :- write("Digite o nome do aluno:"),nl,
    read(Aluno),nl,
    write("Digite o curso do aluno:"),nl,
    read(Curso),nl,
    estudante:disciplinasFaltamAluno(Aluno, Curso, Disciplinas),
    write(Disciplinas),nl,
    menu.

executaEscolha(7) :- write('Qual dado deseja incluir?'),nl,
    write('1. Aluno'),nl,
    write('2. Nota em disciplina'),nl,
    write('3. Disciplina'),nl,
    write('4. Curso'),nl,
    read(Opcao),nl,
    incluir(Opcao),
    menu.

incluir(1) :- write("Digite o nome do aluno:"),nl,
    read(Aluno),nl,
    write("Digite o curso do aluno:"),nl,
    read(Curso),nl,
    estudante:add_estudante(Aluno, Curso),
    menu.

incluir(2) :- write("Digite o nome do aluno:"),nl,
    read(Aluno),nl,
    write("Digite o nome da disciplina:"),nl,
    read(Disciplina),nl,
    write("Digite a nota do aluno:"),nl,
    read(Nota),nl,
    nota:add_nota(Aluno, Disciplina, Nota),
    menu.

incluir(3) :- write("Digite o nome da disciplina"),nl,
    read(Disciplina),nl,
    write('Digite o curso associado a essa disciplina'),nl,
    read(Curso),
    disciplina:add_disciplina(Disciplina, Curso),
    menu.

incluir(4) :- write("Digite o nome do curso:"),nl,
    read(Curso),nl,
    curso:add_curso(Curso),
    menu.

executaEscolha(8) :- write('Qual dado deseja editar?'),nl,
    write('1. Nome do aluno e curso associado'),nl,
    write('2. Nota em disciplina'),nl,
    write('3. Nome da disciplina'),nl,
    write('4. Curso'),nl,
    read(Opcao),nl,
    editar(Opcao),
    menu.

editar(1) :- write("Digite o nome do aluno que deseja alterar:"),nl,
    read(Aluno),nl,
    write("Digite o curso do aluno desejado:"),nl,
    read(Curso),nl,
    estudante:retract_estudante(Aluno,Curso),
    write("Digite o nome correto do aluno:"),nl,
    read(AlunoNovo),nl,
    write("Digite o curso correto do aluno:"),nl,
    read(CursoNovo),nl,
    estudante:add_estudante(AlunoNovo, CursoNovo),
    menu.

editar(2) :- write("Digite o nome do aluno:"),nl,
    read(Aluno),nl,
    write("Digite o nome da disciplina:"),nl,
    read(Disciplina),nl,
    write("Digite a nova nota do aluno:"),nl,
    read(NotaNova),nl,
    retract_nota(Aluno, Disciplina, _),
    nota:add_nota(Aluno, Disciplina, NotaNova),
    menu.

editar(3) :- write("Digite o nome da disciplina"),nl,
    read(Disciplina),nl,
    write("Digite o nome do curso associado a disciplina:"),nl,
    read(Curso),nl,
    disciplina:retract_disciplina(Disciplina, Curso),
    write("Digite o novo nome da disciplina"),nl,
    read(DisciplinaNova),nl,
    disciplina:add_disciplina(DisciplinaNova, Curso),
    menu.

editar(4) :- write("Digite o nome do curso:"),nl,
    read(Curso),nl,
    curso:retract_curso(Curso),
    write("Digite o novo nome do curso:"),nl,
    read(CursoNovo),
    curso:add_curso(CursoNovo),
    menu.


executaEscolha(9) :- write("Qual dado deseja deletar?"),nl,
    write('1. Aluno'),nl,
    write('2. Nota de um aluno em disciplina'),nl,
    write('3. Retirar disciplina da grade de algum curso'),nl,
    write('4. Deletar curso'),nl,
    read(Opcao),nl,
    deletar(Opcao),
    menu.

deletar(1) :- write("Digite o nome do aluno que deseja deletar:"),nl,
    read(Aluno),nl,
    write("Digite o curso do aluno desejado:"),nl,
    read(Curso),nl,
    estudante:retract_estudante(Aluno,Curso),
    menu.

deletar(2) :- write("Digite o nome do aluno:"),nl,
    read(Aluno),nl,
    write("Digite o nome da disciplina:"),nl,
    read(Disciplina),nl,
    nota:retract_nota(Aluno, Disciplina, _),
    menu.

deletar(3) :- write("Digite o nome da disciplina"),nl,
    read(Disciplina),nl,
    write("Digite o nome do curso associado a disciplina:"),nl,
    read(Curso),nl,
    disciplina:retract_disciplina(Disciplina, Curso),
    menu.

deletar(4) :- write("Digite o nome do curso:"),nl,
    read(Curso),nl,
    curso:retract_curso(Curso),
    menu.
