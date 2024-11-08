% reverse_words_in_file(+InputFile, +OutputFile) — обращает слова в каждой строке исходного файла и записывает результат в новый файл.
reverse_words_in_file(InputFile, OutputFile) :-
    open(InputFile, read, InStream),
    open(OutputFile, write, OutStream),
    process_lines(InStream, OutStream),
    close(InStream),
    close(OutStream).

% process_lines(+InStream, +OutStream) — читает строки, обрабатывает и записывает в выходной поток.
process_lines(InStream, OutStream) :-
    read_line_to_string(InStream, Line),
    ( Line \= end_of_file ->
        split_string(Line, " ", "", Words),
        maplist(reverse_atom, Words, ReversedWords),
        atomic_list_concat(ReversedWords, " ", NewLine),
        writeln(OutStream, NewLine),
        process_lines(InStream, OutStream)
    ; true
    ).

% reverse_atom(+Atom, -ReversedAtom) — обращает строку (слово).
reverse_atom(Atom, ReversedAtom) :-
    atom_chars(Atom, Chars),
    reverse(Chars, ReversedChars),
    atom_chars(ReversedAtom, ReversedChars).

% main predicate to run the program
reverse_file_words :-
    writeln('Введите имя исходного файла:'),
    read(InputFile),
    writeln('Введите имя выходного файла:'),
    read(OutputFile),
    reverse_words_in_file(InputFile, OutputFile),
    writeln('Слова в файле обращены и записаны в новый файл.').

?- reverse_file_words.

% Введите имя исходного файла:
% |: input.txt.
% Введите имя выходного файла:
% |: output.txt.
% Слова в файле обращены и записаны в новый файл.
