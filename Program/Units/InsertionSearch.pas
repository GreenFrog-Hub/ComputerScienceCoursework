UNIT InsertionSort;
  interface
  uses crt, sysutils;

  PROCEDURE InsertionSortFunction(VAR UserArray : ARRAY OF LONGINT; low, upper: LONGINT);
    VAR
      i, position : LONGINT;

    IMPLEMENTATION

  PROCEDURE InsertionSortFunction(VAR UserArray : ARRAY OF LONGINT; low, upper: LONGINT);
    BEGIN
      upper := upper-1;
        FOR i := 0 TO upper DO
          BEGIN
            position := i;
            while (position > 0) AND (userArray[position-1] > userArray[i]) DO
              begin
                userarray[position] := userarray[position-1];
                position := position -1;
              end;
            userarray[position] := userarray[i];
          end;
    end;
  end.
