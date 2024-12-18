% 2. Предикат для нахождения чисел Фибоначчи по их номерам (с циклом repeat)

fib_numbers :-
    repeat,
    writeln('Введите номер числа Фибоначчи (отрицательное число для завершения): '),
    read(N),
    (N < 0 -> ! ; (
        fibonacci(N, Fib),
        format('Число Фибоначчи под номером ~d: ~d~n', [N, Fib]),
        fail
    )).

fibonacci(0, 1).
fibonacci(1, 1).
fibonacci(N, F) :-
    N > 1,
    N1 is N - 1, N2 is N - 2,
    fibonacci(N1, F1), fibonacci(N2, F2),
    F is F1 + F2.

?- fib_numbers.

% >>>>>>>>>>> этот же код но с комментариями <<<<<<<<<<<<<<<

% Основной предикат, который организует ввод и вывод чисел Фибоначчи с помощью repeat.
% Выполняется до тех пор, пока не будет введено отрицательное число.
fib_numbers :-
    repeat,  % Начинает цикл, который будет повторяться
    writeln('Введите номер числа Фибоначчи (отрицательное число для завершения): '),
    read(N),  % Считывает введённое значение N
    (N < 0 -> ! ;  % Если N отрицательное, то прерывает цикл с помощью `!`
     (
        % Если N неотрицательное, находит и выводит N-е число Фибоначчи
        fibonacci(N, Fib),  % Вычисляет число Фибоначчи с номером N
        format('Число Фибоначчи под номером ~d: ~d~n', [N, Fib]),  % Выводит результат
        fail  % Возвращает выполнение к `repeat` для повторного запроса
     )
    ).

% Рекурсивный предикат для вычисления N-го числа Фибоначчи
fibonacci(0, 1).  % Определение начального условия: F(0) = 1
fibonacci(1, 1).  % Определение начального условия: F(1) = 1
fibonacci(N, F) :-  % Определение для всех остальных значений N > 1
    N > 1,
    N1 is N - 1, N2 is N - 2,  % Определение двух предыдущих индексов
    fibonacci(N1, F1), fibonacci(N2, F2),  % Рекурсивный вызов для N1 и N2
    F is F1 + F2.  % Вычисление F(N) как суммы F(N-1) и F(N-2)

?- fib_numbers.
