implement main
    open core, console

domains
    genderType = female; male.

class facts
    person : (string NameofPerson, genderType Gender).
    parent : (string Child, string Parent).
    married : (string Husband, string Wife).

class predicates
    father : (string Person, string Father) nondeterm anyflow.
    mother : (string Person, string Mother) nondeterm anyflow.
    son : (string Person, string Son) nondeterm anyflow.
    daughter : (string Person, string Daughter) nondeterm anyflow.
    brother : (string Person, string Brother) nondeterm anyflow.
    sister : (string Person, string Sister) nondeterm anyflow.
    cousinBrother : (string Person, string CousinBrother) nondeterm anyflow.
    cousinSister : (string Person, string CousinSister) nondeterm anyflow.
    grandFather : (string Person, string GrandFather) nondeterm anyflow.
    grandMother : (string Person, string GrandMother) nondeterm anyflow.
    %grandSon : (string Person, string GrandSon) nondeterm anyflow.
    %grandDaughter : (string Person, string GrandDaughter) nondeterm anyflow.
    %brothersNephew : (string Person, string BrothersNephew) nondeterm anyflow.
    %brothersNiece : (string Person, string BrothersNiece) nondeterm anyflow.
    %sistersNephew : (string Person, string SistersNephew) nondeterm anyflow.
    %sistersNiece : (string Person, string SistersNiece) nondeterm anyflow.
    brothersWife : (string Person, string BrothersWife) nondeterm anyflow.
    %wife : (string Person, string Wife) nondeterm anyflow.
    %child : (string Person, string Child, genderType Gender) nondeterm anyflow.
    niece : (string Person, string Niece) nondeterm anyflow.
    grandNiece : (string Person, string GrandNiece) nondeterm anyflow.
    fatherInLow : (string Person, string FatherInLow) nondeterm anyflow.

clauses
    father(Person, Father) :-
        person(Father, male),
        parent(Person, Father).

    mother(Person, Mother) :-
        person(Mother, female),
        parent(Person, Mother).

    son(Person, Son) :-
        person(Son, male),
        father(Son, Person)
        or
        person(Son, male),
        mother(Son, Person).

    daughter(Person, Daughter) :-
        person(Daughter, female),
        father(Daughter, Person)
        or
        person(Daughter, female),
        mother(Daughter, Person).

    brother(Person, Brother) :-
        father(Person, Father),
        father(Brother, Father),
        mother(Person, Mother),
        mother(Brother, Mother),
        %not(Person = Brother).
        Person <> Brother.

    sister(Person, Sister) :-
        father(Person, Father),
        father(Sister, Father),
        mother(Person, Mother),
        mother(Sister, Mother),
        %not(Person = Sister).
        Person <> Sister.

    grandFather(Person, GrandFather) :-
        father(Father, GrandFather),
        parent(Person, Father)
        or
        father(Mother, GrandFather),
        parent(Person, Mother).

    grandMother(Person, GrandMother) :-
        mother(Father, GrandMother),
        parent(Person, Father)
        or
        mother(Mother, GrandMother),
        parent(Person, Mother).

    brothersWife(Person, BrothersWife) :-
        brother(Person, Brother),
        married(Brother, BrothersWife).

    %це племянница
    niece(Person, Niece) :-
        brother(Person, Brother),
        parent(Niece, Brother)
        or
        sister(Person, Sister),
        parent(Niece, Sister).

    grandNiece(Person, GrandNiece) :-
        person(GrandNiece, female),
        brother(Person, Brother),
        grandFather(GrandNiece, Brother)
        or
        person(GrandNiece, female),
        sister(Person, Sister),
        grandMother(GrandNiece, Sister).

    cousinBrother(Person, CousinBrother) :-
        person(CousinBrother, male),
        grandFather(Person, GrandFatherPerson),
        grandFather(CousinBrother, GrandFatherPerson),
        Person <> CousinBrother.

    cousinSister(Person, CousinSister) :-
        person(CousinSister, female),
        grandFather(Person, GrandFatherPerson),
        grandFather(CousinSister, GrandFatherPerson),
        Person <> CousinSister.

    fatherInLow(Person, FatherInLow) :-
        married(Person, Wife),
        father(Wife, FatherInLow).

    person("Henry", male).
    person("Ira", female).
    person("Adam", male).
    person("Eve", female).
    person("James", male).
    person("Mimi", female).
    person("Eriq", male).
    person("Laura", female).
    person("Jack", male).
    person("Megan", female).
    person("Sherry", female).
    person("Delhi", female).
    person("John", male).
    person("Sandy", female).
    person("William", male).
    person("Gloria", female).
    person("David", male).
    person("Lydia", female).
    person("Paul", male).
    person("Carol", female).
    person("Malik", male).
    person("Yulianna", female).
    person("Steven", male).
    person("Christina", female).
    person("George", male).
    person("Mark", male).
        %
        %
    parent("James", "Henry").
    parent("James", "Ira").
    parent("Eriq", "Henry").
    parent("Eriq", "Ira").
    parent("Megan", "Henry").
    parent("Megan", "Ira").
    parent("Jack", "Adam").
    parent("Jack", "Eve").
    parent("Delphi", "Adam").
    parent("Delphi", "Eve").
    parent("Sandy", "Adam").
    parent("Sandy", "Eve").
        %
    parent("Malik", "Mimi").
    parent("Malik", "Eriq").
    parent("Carol", "Eriq").
    parent("Carol", "Laura").
    parent("Paul", "Megan").
    parent("Paul", "Jack").
    parent("Lydia", "Megan").
    parent("Lydia", "Jack").
    parent("David", "Sherry").
    parent("David", "Jack").
    parent("William", "Sandy").
    parent("William", "John").
        %
    parent("Yulianna", "Malik").
    parent("Yulianna", "Lydia").
    parent("Steven", "Carol").
    parent("Steven", "David").
    parent("Christina", "David").
    parent("Christina", "Gloria").
    parent("George", "Gloria").
    parent("George", "William").
    parent("Mark", "Gloria").
    parent("Mark", "William").
        %
        %
    married("Henry", "Ira").
    married("Adam", "Eve").
    married("Eriq", "Mimi").
    married("Eriq", "Laura").
    married("Jack", "Megan").
    married("Jack", "Sherry").
    married("John", "Sandy").
    married("Malik", "Lydia").
    married("David", "Carol").
    married("David", "Gloria").
    married("William", "Gloria").

    run() :-
        console::init(),
        stdIO::write("\n++++++++++TREE++++++++++\n"),
        /*stdIO::write("\n--------Fathers---------\n"),
        father(X, Y),
        stdIO::writef("\n% is the father of %\n", Y, X),
        fail.
    run() :-
        stdIO::write("\n--------Mothers---------\n"),
        mother(X, Y),
        stdIO::writef("\n% is the mother of %\n", Y, X),
        fail.
    run() :-*/
        stdIO::write("\n------Who is grandfather of Steven------\n"),
        X = "Lydia",
        grandFather(X, Y),
        stdIO::writef("\n% is the grandfather of %\n", Y, X),
        fail.
    run() :-
        stdIO::write("\n------Who is brother's wife of Megan-----\n"),
        X = "Megan",
        brothersWife(X, Y),
        stdIO::writef("\n% is the brother's wife of %\n", Y, X),
        fail.
        %how to show it
        /*run() :-
        stdIO::write("\n------Is Yulianna Sherry's niece-----\n"),
        X = "Delphi",
        Y = "Lydia",
        niece(X, Y),
        !,
        stdIO::write("\nYes\n")
        or
        stdIO::write("\nNo\n").*/
    run() :-
        stdIO::write("\n------Who is grandNiece of Megan-----\n"),
        X = "Megan",
        grandNiece(X, Y),
        stdIO::writef("\n% is the grandNiece of %\n", Y, X),
        fail.
    run() :-
        stdIO::write("\n------Who is cousinSister of Carol-----\n"),
        X = "Lydia",
        cousinSister(X, Y),
        stdIO::writef("\n% is the cousinSister of %\n", Y, X),
        fail.
    run() :-
        stdIO::write("\n----------\n"),
        X = "Jack",
        fatherInLow(X, Y),
        stdIO::writef("\n% is the cousinSister of %\n", Y, X),
        fail.
    run() :-
        stdIO::write("\n+++++++++++++++++++++++++\n").

end implement main

goal
    mainExe::run(main::run).
