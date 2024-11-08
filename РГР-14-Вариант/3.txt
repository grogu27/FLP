% Определяем динамический предикат для хранения данных о рейсах
:- dynamic flight/4.

% add_flight(+Number, +Destination, +DepartureTime, +Price) — добавляет рейс
add_flight(Number, Destination, DepartureTime, Price) :-
    assertz(flight(Number, Destination, DepartureTime, Price)).

% flights_within_6_hours(+Destination, +CurrentTime, -Flights) — находит все рейсы до указанного города, вылетающие в ближайшие 6 часов
flights_within_6_hours(Destination, CurrentTime, Flights) :-
    findall([Number, DepartureTime, Price],
        (flight(Number, Destination, DepartureTime, Price),
         departure_within_6_hours(CurrentTime, DepartureTime)),
        Flights).

% departure_within_6_hours(+CurrentTime, +DepartureTime) — проверяет, что вылет произойдет в ближайшие 6 часов
departure_within_6_hours(CurrentTime, DepartureTime) :-
    CurrentHour is CurrentTime // 100,
    DepartureHour is DepartureTime // 100,
    ( (DepartureHour >= CurrentHour, DepartureHour =< CurrentHour + 6)
    ; (DepartureHour + 24 =< CurrentHour + 6)  % Учет перехода на следующие сутки
    ).

% find_min_price_flight(+Flights, -MinPriceFlights) — находит рейсы с минимальной ценой из списка
find_min_price_flight(Flights, MinPriceFlights) :-
    maplist(third_element, Flights, Prices),
    min_list(Prices, MinPrice),
    include(has_price(MinPrice), Flights, MinPriceFlights).

third_element([_, _, Price], Price).
has_price(Price, [_, _, Price]).

% main predicate to run the program
manage_flights :-
    writeln('Меню:'),
    writeln('1. Добавить рейс'),
    writeln('2. Найти рейсы до города'),
    writeln('3. Выйти'),
    read(Choice),
    (Choice = 1 -> 
        writeln('Введите номер рейса:'),
        read(Number),
        writeln('Введите пункт назначения:'),
        read(Destination),
        writeln('Введите время отправления (формат ЧЧММ):'),
        read(DepartureTime),
        writeln('Введите стоимость билета:'),
        read(Price),
        add_flight(Number, Destination, DepartureTime, Price),
        writeln('Рейс добавлен'), 
        manage_flights
    ; Choice = 2 -> 
        writeln('Введите пункт назначения:'),
        read(Destination),
        writeln('Введите текущее время (формат ЧЧММ):'),
        read(CurrentTime),
        flights_within_6_hours(Destination, CurrentTime, Flights),
        (Flights \= [] ->
            find_min_price_flight(Flights, MinPriceFlights),
            writeln('Рейсы с минимальной стоимостью в ближайшие 6 часов:'),
            writeln(MinPriceFlights)
        ; writeln('Нет рейсов, удовлетворяющих условиям')
        ),
        manage_flights
    ; Choice = 3 -> 
        writeln('Выход из программы')
    ).

?- manage_flights.

% Меню:
% 1. Добавить рейс
% 2. Найти рейсы до города
% 3. Выйти
% |: 1.
% Введите номер рейса:
% |: 101.
% Введите пункт назначения:
% |: Москва.
% Введите время отправления (формат ЧЧММ):
% |: 1430.
% Введите стоимость билета:
% |: 4500.
% Рейс добавлен
% Меню:
% 1. Добавить рейс
% 2. Найти рейсы до города
% 3. Выйти
% |: 2.
% Введите пункт назначения:
% |: Москва.
% Введите текущее время (формат ЧЧММ):
% |: 0930.
% Рейсы с минимальной стоимостью в ближайшие 6 часов:
% [[101, 1430, 4500]]
% Меню:
% 1. Добавить рейс
% 2. Найти рейсы до города
% 3. Выйти
% |: 3.
% Выход из программы
