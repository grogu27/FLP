:- use_module(library(lists)).

% read_words(+FileName, -Words) — считывает слова из файла.
read_words(FileName, Words) :-
    open(FileName, read, Stream),
    read_stream_to_words(Stream, Words),
    close(Stream).

% read_stream_to_words(+Stream, -Words) — считывает слова из всех строк файла.
read_stream_to_words(Stream, Words) :-
    read_lines(Stream, Lines),
    maplist(line_to_words, Lines, NestedWords),
    flatten(NestedWords, Words).

% read_lines(+Stream, -Lines) — читает строки из потока.
read_lines(Stream, []) :-
    at_end_of_stream(Stream).
read_lines(Stream, [Line|Lines]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, Line),
    read_lines(Stream, Lines).

% line_to_words(+Line, -Words) — разбивает строку на слова.
line_to_words(Line, Words) :-
    split_string(Line, " \t\n", "", Words).

% min_length_words(+Words, -MinWords) — находит слова минимальной длины.
min_length_words(Words, MinWords) :-
    maplist(string_length, Words, Lengths),
    min_list(Lengths, Min),
    include(length_is(Min), Words, MinWords).

length_is(Len, Word) :-
    string_length(Word, Len).

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
    (   catch(read_words(InputFile, Words), _, fail)
    ->  min_length_words(Words, MinWords),
        write_words(OutputFile, MinWords),
        writeln('Слова минимальной длины записаны в файл.')
    ;   writeln('Ошибка: невозможно открыть или прочитать файл.')
    ).

 ?- find_min_length_words.

Введите имя исходного файла:
|: 'D:\\Документы\\Prolog\\input.txt'.
Введите имя выходного файла:
|: 'D:\\Документы\\Prolog\\output.txt'.
