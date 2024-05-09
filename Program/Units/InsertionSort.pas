UNIT InsertionSort;
  interface
  uses crt, sysutils;

  PROCEDURE InsertionSortFunction(VAR UserArray : ARRAY OF STRING; low, upper: LONGINT);
    VAR
      i,position : LONGINT;
      temp : STRING;

    IMPLEMENTATION

  PROCEDURE InsertionSortFunction(VAR UserArray : ARRAY OF STRING; low, upper: LONGINT);
    BEGIN
        FOR i := 0 TO upper DO
          BEGIN
            temp := UserArray[i];
            position := i;
            while (position >= 0) AND (userArray[position-1] > temp) DO
              begin
                userarray[position] := userarray[position-1];
                position := position -1;
              end;
            userarray[position] := temp;
          end;
    end;
  end.
