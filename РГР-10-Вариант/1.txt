% 1.10. В непустой список, упорядоченный по неубыванию, добавьте новый элемент таким образом, чтобы сохранилась упорядоченность.
% insert_sorted(+List, +Element, -Result) — вставляет Element в отсортированный список List, чтобы сохранить порядок.
insert_sorted([], Elem, [Elem]).  % Если список пуст, результат — список с одним элементом.
insert_sorted([H|T], Elem, [Elem, H|T]) :- Elem =< H.  % Вставляем элемент перед первым большим или равным.
insert_sorted([H|T], Elem, [H|R]) :- Elem > H, insert_sorted(T, Elem, R).  % Идем дальше по списку, если Elem больше.

% main predicate to run the program
add_element_to_sorted_list :-
    writeln('Введите отсортированный список: '),
    read(List),
    writeln('Введите элемент для вставки: '),
    read(Elem),
    insert_sorted(List, Elem, Result),
    format('Новый список: ~w~n', [Result]).

?- add_element_to_sorted_list.

% Введите отсортированный список:
% |: [1, 3, 5, 7].
% Введите элемент для вставки:
% |: 4.
% Новый список: [1, 3, 4, 5, 7].
