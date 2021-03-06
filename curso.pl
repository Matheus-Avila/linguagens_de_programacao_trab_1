%Matheus Avila Moreira de Paula/201565191C Matheus Estevão Faria 201635080
:-module(
    curso,
    [
        add_curso/1, % +Nome:atom
        retract_curso/1, % -Nome:atom
        retractall_curso/1, % -Nome:atom
        current_curso/1 % ?Nome:atom
    ]
).
:- use_module(library(persistency)).

:- persistent(curso(nome:atom)).

:- initialization(db_attach('curso_db', [])).

add_curso(Nome):-
  with_mutex(curso_db, assert_curso(Nome)).

retract_curso(Nome):-
 persistency: db_retract(curso:curso(Nome)).

retractall_curso(Nome):-
 persistency: db_retractall(curso:curso(Nome)).

current_curso(Nome):-
  with_mutex(curso_db, curso(Nome)). 