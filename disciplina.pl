%Matheus Avila Moreira de Paula/201565191C Matheus Estevão Faria 201635080
:-module(
    disciplina,
    [
        add_disciplina/2, % +Nome:atom, +Curso:atom
        retract_disciplina/2, % -Nome:atom, -Curso:atom
        retractall_disciplina/2, % -Nome:atom, -Curso:atom
        current_disciplina/2 % ?Nome:atom, ?Curso:atom
    ]
).
:- use_module(library(persistency)).

:- persistent(disciplina(nome:atom,curso:atom)).

:- initialization(db_attach('disciplina_db', [])).

add_disciplina(Nome,Curso):-
  with_mutex(disciplina_db, assert_disciplina(Nome,Curso)).

retract_disciplina(Nome,Curso):-
persistency: db_retract(disciplina:disciplina(Nome,Curso)).

retractall_disciplina(Nome,Curso):-
persistency: db_retractall(disciplina:disciplina(Nome,Curso)).

current_disciplina(Nome,Curso):-
  with_mutex(disciplina_db, disciplina(Nome,Curso)). 