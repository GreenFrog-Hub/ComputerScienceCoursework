PROGRAM classTesting;
  uses crt, sysutils, logInProcedures, classTestingUnit;
  const number = 1;
  var logIn : logInFile;
    returnArray : ARRAY[0..190] OF LONGINT;
    searchValues : ARRAY[0..number] OF STRING;
    searchindexs : ARRAY[0..number] OF BYTE;
    a : LONGINT;
  begin
    login := logInFile.create;
    for a := 0 to 190 do
      begin
        returnArray[a] := -1;
      end;
    //login.setData('923','BobStarck','IronMan');
    //login.DisplayData;
    //login.writeToFile;
    //login.readHere;
    //login.displayData;
    //login.readFile(3);
    //login.displaydata;
    //login.sort;
    for a := 0 to number do
      begin
        write('Enter search value: ');
        readln(searchValues[a]);
        write('Enter search index: ');
        readln(searchindexs[a]);
        writeln;
      end;
    login.search(searchValues,searchindexs,returnArray, false);
    a := 0;
    writeln('Found at positions: ');
    while (returnArray[a] <> -1) and  (a <= 190) do
      begin
        writeln(returnArray[a]);
        login.readFile(returnArray[a]);
        login.displayData;
        writeln;
        a := a + 1;
      end;
    login.extractToTextFile;
    login.free;
    classTestingUnit.testFileClass;
    readln;
  end.

