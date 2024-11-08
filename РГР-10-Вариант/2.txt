% Задача 2.10: Найти слова минимальной длины в файле
% read_words(+FileName, -Words) — считывает все слова из файла и возвращает их в виде списка.
read_words(FileName, Words) :-
    open(FileName, read, Stream),
    read_stream_to_terms(Stream, Words),
    close(Stream).

% read_stream_to_terms(+Stream, -Words) — рекурсивно считывает слова из потока.
read_stream_to_terms(Stream, []) :-
    at_end_of_stream(Stream).
read_stream_to_terms(Stream, [Word|Words]) :-
    \+ at_end_of_stream(Stream),
    read(Stream, Word),
    read_stream_to_terms(Stream, Words).

% min_length_words(+Words, -MinWords) — находит все слова минимальной длины.
min_length_words(Words, MinWords) :-
    maplist(atom_length, Words, Lengths),
    min_list(Lengths, Min),
    include(length_is(Min), Words, MinWords).

length_is(Len, Word) :-
    atom_length(Word, Len).

% write_words(+FileName, +Words) — записывает слова в файл.
write_words(FileName, Words) :-
    open(FileName, write, Stream),
    forall(member(Word, Words), writeln(Stream, Word)),
    close(Stream).

% main predicate to run the program
find_min_length_words :-
    writeln('Введите имя исходного файла:'),
    read(InputFile),
    writeln('Введите имя выходного файла:'),
    read(OutputFile),
    read_words(InputFile, Words),
    min_length_words(Words, MinWords),
    write_words(OutputFile, MinWords),
    writeln('Слова минимальной длины записаны в файл').

?- find_min_length_words.
% Введите имя исходного файла:
% |: input.txt.
% Введите имя выходного файла:
% |: output.txt.
% Слова минимальной длины записаны в файл

