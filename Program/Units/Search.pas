UNIT Search;

  INTERFACE
  USES CRT, SYSUTILS, BinarySearch, LinearSearch;

  PROCEDURE SearchFunctions(SearchType : CHAR; min, max : LONGINT; findValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF LONGINT; var numberDone : LONGINT);

  IMPLEMENTATION

  PROCEDURE SearchFunctions(SearchType : CHAR; min, max : LONGINT; findValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF LONGINT; var numberDone : LONGINT);
    BEGIN
      IF SearchType = 'L' THEN
        LinearSearch.LinearSearchFunction(min,max,FindValue,UserArray,returnArray,numberDone);
      IF SearchType = 'B' THEN
        BinarySearch.BinarySearchFunction(min,max, FindValue,UserArray,returnArray,numberDone);
    END;

  END.
