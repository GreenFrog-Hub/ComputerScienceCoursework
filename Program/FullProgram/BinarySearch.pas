UNIT BinarySearch;
  INTERFACE

  USES CRT, SYSUTILS;


  PROCEDURE BinarySearchFunction(low, high : LONGINT; searchValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF INTEGER; var numberDone : LONGINT);
    VAR
      i, mid : LONGINT;
      shouldEnd : BOOLEAN;

    IMPLEMENTATION

  PROCEDURE BinarySearchFunction(low, high : LONGINT; searchValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF INTEGER; var numberDone : LONGINT);
    VAR
      i, mid : LONGINT;
      shouldEnd : BOOLEAN;
    BEGIN
      REPEAT
        mid := (low+high)DIV 2;
        IF UserArray[mid] <> searchValue THEN
          BEGIN
                IF UserArray[mid] < searchValue THEN
                  BEGIN
                    low := mid +1;
                  END
                ELSE
                  BEGIN
                    high := mid -1;
                  END;
              END
        ELSE
          BEGIN
            returnArray[0] := mid;
            shouldEnd := true;
          END;
      UNTIL (shouldEnd = true) OR (low > high);

    END;


  END.

