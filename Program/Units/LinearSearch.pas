UNIT LinearSearch;
  INTERFACE

  USES CRT, SYSUTILS;


  PROCEDURE LinearSearchFunction(low, high : LONGINT; searchValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF INTEGER; var numberDone : LONGINT);
    VAR
      i, a,checkItem: LONGINT;

    IMPLEMENTATION

  PROCEDURE LinearSearchFunction(low, high : LONGINT; searchValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF INTEGER; var numberDone : LONGINT);
    BEGIN
      i := -1;
      a := 0;
      REPEAT
        i := i+1;
        numberDone := numberDone +1;
        if userArray[i] = searchValue THEN
        begin
          returnArray[a] := i;
          a := a + 1;
        end;
      UNTIL (i = high);
    END;

  END.
