% square_every_third(+List, -Result) — возводит в квадрат каждый третий элемент списка List и возвращает результат в Result.
square_every_third(List, Result) :-
    square_every_third(List, 1, Result).

% square_every_third(+List, +Index, -Result) — вспомогательный предикат с индексом.
square_every_third([], _, []).  % Базовый случай: пустой список

square_every_third([H|T], Index, [H2|R]) :-
    (Index mod 3 =:= 0 -> H2 is H * H ; H2 = H),  % Если элемент третий, возводим его в квадрат
    NextIndex is Index + 1,
    square_every_third(T, NextIndex, R).

% main predicate to run the program
square_third_elements :-
    writeln('Введите список:'),
    read(List),
    square_every_third(List, Result),
    format('Результат: ~w~n', [Result]).

?- square_third_elements.

% Введите список:
% |: [1, 2, 3, 4, 5, 6, 7, 8, 9].
% Результат: [1, 2, 9, 4, 5, 36, 7, 8, 81]
