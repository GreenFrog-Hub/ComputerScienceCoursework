UNIT Search;

  INTERFACE
  USES CRT, SYSUTILS, BinarySearch, LinearSearch;

  PROCEDURE SearchFunctions(SearchType : CHAR; x, y : LONGINT; findValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF LONGINT; var numberDone : LONGINT);

  IMPLEMENTATION

  PROCEDURE SearchFunctions(SearchType : CHAR; x, y : LONGINT; findValue : STRING; UserArray : ARRAY OF STRING; var returnArray : ARRAY OF LONGINT; var numberDone : LONGINT);
    BEGIN
      IF SearchType = 'L' THEN
        LinearSearch.LinearSearchFunction(x,y,FindValue,UserArray,returnArray,numberDone);
      IF SearchType = 'B' THEN
        //BinarySearch.BinarySearchFunction(UserArray,ReturnArray,x,y,FindValue);
    END;

  END.
