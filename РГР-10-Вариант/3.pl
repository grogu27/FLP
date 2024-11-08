% Задача 3.10: База данных о сессии студентов
% Определяем динамический предикат для хранения данных о студентах
:- dynamic student/3.

% add_student(+Name, +ID, +Grades) — добавляет запись о студенте
add_student(Name, ID, Grades) :-
    assertz(student(Name, ID, Grades)).

% qualified_student(+Name, +ID) — проверяет, соответствует ли студент условиям
qualified_student(Name, ID) :-
    student(Name, ID, Grades),
    % Проверяем, что студент не имеет двоек
    \+ member(2, Grades),
    % Считаем количество оценок 4 и 5
    include(grade_is_4_or_5, Grades, HighGrades),
    length(HighGrades, Count),
    Count >= 3.

grade_is_4_or_5(Grade) :-
    Grade == 4; Grade == 5.

% find_qualified_students(-Students) — находит всех студентов, соответствующих условиям
find_qualified_students(Students) :-
    findall(Name-ID, qualified_student(Name, ID), Students).

% main predicate to run the program
manage_students_session :-
    writeln('Меню:'),
    writeln('1. Добавить студента'),
    writeln('2. Показать подходящих студентов'),
    writeln('3. Выйти'),
    read(Choice),
    (Choice = 1 -> 
        writeln('Введите имя студента:'),
        read(Name),
        writeln('Введите ID студента:'),
        read(ID),
        writeln('Введите оценки студента (список из 5 элементов):'),
        read(Grades),
        add_student(Name, ID, Grades),
        writeln('Студент добавлен'), 
        manage_students_session
    ; Choice = 2 -> 
        find_qualified_students(Students),
        writeln('Подходящие студенты:'),
        writeln(Students),
        manage_students_session
    ; Choice = 3 -> 
        writeln('Выход из программы')
    ).

?- manage_students_session.
% Меню:
% 1. Добавить студента
% 2. Показать подходящих студентов
% 3. Выйти
% |: 1.
% Введите имя студента:
% |: Алексей.
% Введите ID студента:
% |: 123.
% Введите оценки студента (список из 5 элементов):
% |: [5, 3, 4, 4, 5].
% Студент добавлен
% Меню:
% 1. Добавить студента
% 2. Показать подходящих студентов
% 3. Выйти
% |: 2.
% Подходящие студенты:
% [Алексей-123]
% Меню:
% 1. Добавить студента
% 2. Показать подходящих студентов
% 3. Выйти
% |: 3.
% Выход из программы
