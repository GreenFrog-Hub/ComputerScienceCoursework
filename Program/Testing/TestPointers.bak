PROGRAM TestPointers;
  uses crt, sysutils;
  type
    testRecord = record
                  a : LONGINT;
                  b : STRING[5];
                end;
  var
    testRec : testRecord;
    testRecArray: ARRAY[0..5] of testRecord;
    point: ^testRecord;
    pArr : ARRAY[0..5] OF ^testRecord;

  begin
    testRec.a := 0;
    testRec.b := 'bcdde';
    testRecArray[0] := testRec;

    pArr[0] := @testRecArray[0];

    testRec.a := 1;
    testRec.b := 'fdsfd';
    testRecArray[1] := testRec;
    pArr[1] := @testRecArray[1];
    point := pArr[0];
    pArr[0]^ := pArr[1]^;
    pArr[1]^ := point^;
    writeln(pArr[1]^.a);
    readln;
  end.
