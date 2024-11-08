% 4. Предикат для нахождения наиболее часто встречающихся элементов в списке
most_frequent :-
    writeln('Введите список: '),
    read(List),
    count_frequencies(List, FreqList),
    find_max_count(FreqList, MaxCount),
    find_elements_with_max_count(FreqList, MaxCount, Result),
    format('Наиболее частые элементы: ~w~n', [Result]).

count_frequencies([], []).
count_frequencies([H|T], FreqList) :-
    count_frequencies(T, FreqT),
    update_frequency(H, FreqT, FreqList).

update_frequency(X, [], [[X,1]]).
update_frequency(X, [[X,N]|T], [[X,N1]|T]) :-
    N1 is N + 1.
update_frequency(X, [[Y,N]|T], [[Y,N]|T1]) :-
    X \= Y,
    update_frequency(X, T, T1).

find_max_count([[_,N]], N).
find_max_count([[_,N]|T], Max) :-
    find_max_count(T, MaxTail),
    Max is max(N, MaxTail).

find_elements_with_max_count([], _, []).
find_elements_with_max_count([[X,N]|T], N, [X|Result]) :-
    find_elements_with_max_count(T, N, Result).
find_elements_with_max_count([[_,N1]|T], N, Result) :-
    N1 \= N,
    find_elements_with_max_count(T, N, Result).

?- most_frequent.

% >>>>>>>>>>> этот же код но с комментариями <<<<<<<<<<<<<<<

% Предикат most_frequent - главный предикат, который находит наиболее частые элементы в списке.
% Он запрашивает ввод у пользователя и вызывает вспомогательные предикаты для решения задачи.
most_frequent :-
    % Запрашиваем у пользователя ввод списка
    writeln('Введите список: '),
    read(List),
    
    % Создаем список частот FreqList, где каждый элемент состоит из элемента исходного списка
    % и количества его вхождений в список.
    count_frequencies(List, FreqList),
    
    % Находим максимальную частоту вхождения элементов в список
    find_max_count(FreqList, MaxCount),
    
    % Находим все элементы, у которых частота вхождения равна максимальной
    find_elements_with_max_count(FreqList, MaxCount, Result),
    
    % Выводим наиболее частые элементы
    format('Наиболее частые элементы: ~w~n', [Result]).

% Предикат count_frequencies - подсчитывает количество вхождений каждого элемента в список.
% Возвращает список пар вида [Элемент, Количество].
count_frequencies([], []).  % Базовый случай: пустой список дает пустой список частот.

count_frequencies([H|T], FreqList) :-
    % Рекурсивно обрабатываем оставшуюся часть списка T и получаем частоты для него в FreqT.
    count_frequencies(T, FreqT),
    
    % Обновляем частоту элемента H в списке частот FreqT.
    update_frequency(H, FreqT, FreqList).

% Предикат update_frequency - обновляет частоту элемента в списке частот.
% Если элемент еще не встречался, добавляем его с частотой 1.
update_frequency(X, [], [[X,1]]).  % Если список частот пуст, добавляем элемент X с частотой 1.

update_frequency(X, [[X,N]|T], [[X,N1]|T]) :-
    % Если элемент X уже есть в списке частот, увеличиваем его частоту на 1.
    N1 is N + 1.

update_frequency(X, [[Y,N]|T], [[Y,N]|T1]) :-
    % Если элемент X не равен Y, продолжаем поиск в оставшейся части списка.
    X \= Y,
    update_frequency(X, T, T1).

% Предикат find_max_count - находит максимальную частоту среди всех частот.
find_max_count([[_,N]], N).  % Базовый случай: если осталась одна пара, ее частота - максимальная.

find_max_count([[_,N]|T], Max) :-
    % Рекурсивно находим максимальную частоту MaxTail в оставшейся части списка T.
    find_max_count(T, MaxTail),
    
    % Выбираем максимальное значение между текущей частотой N и MaxTail.
    Max is max(N, MaxTail).

% Предикат find_elements_with_max_count - находит все элементы с заданной частотой.
find_elements_with_max_count([], _, []).  % Базовый случай: если список пуст, возвращаем пустой список.

find_elements_with_max_count([[X,N]|T], N, [X|Result]) :-
    % Если частота элемента X равна искомой частоте N, добавляем X в результат.
    find_elements_with_max_count(T, N, Result).

find_elements_with_max_count([[_,N1]|T], N, Result) :-
    % Если частота N1 не равна искомой частоте N, пропускаем этот элемент.
    N1 \= N,
    find_elements_with_max_count(T, N, Result).

?- most_frequent.
