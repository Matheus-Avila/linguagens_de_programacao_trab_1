:- module(
  nota,
  [
    add_nota/3, % +Nome:atom, +Disciplina:atom, +Notav:float
    retract_nota/3, % -Nome:atom, -Disciplina:atom, -Notav:float
    current_nota/3 % ?Nome:atom, ?Disciplina:atom, ?Notav:float
  ]
).

:- persistent(nota(nome:atom, disciplina:atom, notav:float)).

:- initialization(db_attach('nota_db', [])).

add_nota(Nome, Disciplina, Notav):-
  with_mutex(nota_db, assert_nota(Nome, Disciplina, Notav)).

retract_nota(Nome, Disciplina, Notav):-
  persistency: db_retract(nota:nota(Nome, Disciplina, Notav)).

current_nota(Nome, Disciplina, Notav):-
  with_mutex(nota_db, nota(Nome, Disciplina, Notav)).