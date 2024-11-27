:- dynamic student/3.

% Загрузка базы данных из файла при запуске
initialize_database :-
    exists_file('students_db.pl'),
    consult('students_db.pl'),
    writeln('База данных загружена.');
    writeln('Файл базы данных не найден. Создана новая база.').

% Сохранение базы данных в файл
save_database :-
    tell('students_db.pl'),
    listing(student),
    told.

% Добавление записи
add_student(Name, ID, Grades) :-
    assertz(student(Name, ID, Grades)).

% Удаление записи
remove_student(ID) :-
    retract(student(_, ID, _)),
    writeln('Запись удалена.');
    writeln('Запись не найдена.').

% Проверка условий задачи
qualified_student(Name, ID) :-
    student(Name, ID, Grades),
    \+ member(2, Grades),
    include(grade_is_4_or_5, Grades, HighGrades),
    length(HighGrades, Count),
    Count >= 3.

grade_is_4_or_5(Grade) :- Grade == 4; Grade == 5.

% Поиск подходящих студентов
find_qualified_students(Students) :-
    findall(Name-ID, qualified_student(Name, ID), Students).

% Просмотр содержимого базы данных
view_all_students :-
    findall(Name-ID-Grades, student(Name, ID, Grades), Students),
    ( Students = [] ->
        writeln('База данных пуста.');
        writeln('Содержимое базы данных:'),
        writeln(Students)
    ).

% Главное меню
manage_students_session :-
    writeln('Меню:'),
    writeln('1. Просмотреть базу данных'),
    writeln('2. Добавить записи'),
    writeln('3. Удалить записи'),
    writeln('4. Показать подходящих студентов'),
    writeln('5. Выйти и сохранить базу данных'),
    read(Choice),
    handle_choice(Choice).

% Обработка выбора в меню
handle_choice(1) :-
    view_all_students,
    manage_students_session.
handle_choice(2) :-
    writeln('Добавление записей. Введите "stop.", чтобы завершить.'),
    repeat,
    writeln('Введите имя студента (или "stop." для выхода):'),
    read(Name),
    ( Name == stop -> ! ;
        writeln('Введите ID студента:'),
        read(ID),
        writeln('Введите оценки студента (список из 5 элементов):'),
        read(Grades),
        add_student(Name, ID, Grades),
        writeln('Запись добавлена.'),
        fail
    ),
    manage_students_session.
handle_choice(3) :-
    writeln('Удаление записей. Введите "stop.", чтобы завершить.'),
    repeat,
    writeln('Введите ID студента для удаления (или "stop." для выхода):'),
    read(ID),
    ( ID == stop -> ! ;
        remove_student(ID),
        fail
    ),
    manage_students_session.
handle_choice(4) :-
    find_qualified_students(Students),
    writeln('Подходящие студенты:'),
    writeln(Students),
    manage_students_session.
handle_choice(5) :-
    save_database,
    writeln('База данных сохранена. Выход из программы.').

% Запуск программы
:- initialize_database, manage_students_session.
