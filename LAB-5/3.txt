% 3. Предикат для разбиения списка на три подсписка по введённым числам

split_list :-
    writeln('Введите список: '),
    read(List),
    writeln('Введите первое число: '),
    read(A),
    writeln('Введите второе число: '),
    read(B),
    (A =< B -> Min = A, Max = B ; Min = B, Max = A),
    split_by_bounds(List, Min, Max, Less, Middle, Greater),
    format('Меньше ~w: ~w~n', [Min, Less]),
    format('От ~w до ~w: ~w~n', [Min, Max, Middle]),
    format('Больше ~w: ~w~n', [Max, Greater]).

split_by_bounds([], _, _, [], [], []).
split_by_bounds([H|T], Min, Max, [H|Less], Middle, Greater) :-
    H < Min, split_by_bounds(T, Min, Max, Less, Middle, Greater).
split_by_bounds([H|T], Min, Max, Less, [H|Middle], Greater) :-
    H >= Min, H =< Max, split_by_bounds(T, Min, Max, Less, Middle, Greater).
split_by_bounds([H|T], Min, Max, Less, Middle, [H|Greater]) :-
    H > Max, split_by_bounds(T, Min, Max, Less, Middle, Greater).

?- split_list.


% Предикат split_list - главный предикат, который разбивает список на три части
% по двум числам, введенным пользователем. Он запрашивает ввод у пользователя и
% вызывает вспомогательный предикат split_by_bounds для разбиения списка.
split_list :-
    % Запрашиваем у пользователя ввод списка
    writeln('Введите список: '),
    read(List),
    
    % Запрашиваем у пользователя первое число
    writeln('Введите первое число: '),
    read(A),
    
    % Запрашиваем у пользователя второе число
    writeln('Введите второе число: '),
    read(B),
    
    % Определяем минимальное и максимальное значение из двух введённых чисел
    % для использования в качестве границ.
    (A =< B -> Min = A, Max = B ; Min = B, Max = A),
    
    % Вызываем предикат split_by_bounds, который разбивает список List
    % на три подсписка: Less (меньше Min), Middle (от Min до Max), и Greater (больше Max).
    split_by_bounds(List, Min, Max, Less, Middle, Greater),
    
    % Выводим результат разбиения
    format('Меньше ~w: ~w~n', [Min, Less]),
    format('От ~w до ~w: ~w~n', [Min, Max, Middle]),
    format('Больше ~w: ~w~n', [Max, Greater]).

% Предикат split_by_bounds разбивает список на три подсписка в зависимости от
% значений Min и Max. Этот предикат рекурсивно обрабатывает каждый элемент
% списка, проверяя, в какой из трех категорий он попадает.

% Базовый случай: если исходный список пуст, то все три подсписка также будут пустыми.
split_by_bounds([], _, _, [], [], []).

% Случай 1: Если голова списка (первый элемент) меньше Min, то этот элемент
% добавляется в список Less. Продолжаем разбиение на оставшейся части списка.
split_by_bounds([H|T], Min, Max, [H|Less], Middle, Greater) :-
    H < Min,  % Проверяем, что элемент H меньше Min
    split_by_bounds(T, Min, Max, Less, Middle, Greater).  % Рекурсивно обрабатываем хвост списка T

% Случай 2: Если голова списка находится между Min и Max (включительно), то
% этот элемент добавляется в список Middle. Продолжаем разбиение на оставшейся части списка.
split_by_bounds([H|T], Min, Max, Less, [H|Middle], Greater) :-
    H >= Min, H =< Max,  % Проверяем, что элемент H находится между Min и Max
    split_by_bounds(T, Min, Max, Less, Middle, Greater).  % Рекурсивно обрабатываем хвост списка T

% Случай 3: Если голова списка больше Max, то этот элемент добавляется в
% список Greater. Продолжаем разбиение на оставшейся части списка.
split_by_bounds([H|T], Min, Max, Less, Middle, [H|Greater]) :-
    H > Max,  % Проверяем, что элемент H больше Max
    split_by_bounds(T, Min, Max, Less, Middle, Greater).  % Рекурсивно обрабатываем хвост списка T

?- split_list.

% >> Пример работы кода:
%    Введите список:
%    [1, 2, 3, 4, 5, 6, 7, 8].
%    Введите первое число:
%    2.
%    Введите второе число:
%    6.
%    Меньше 2: [1]
%    От 2 до 6: [2,3,4,5,6]
%    Больше 6: [7,8]
