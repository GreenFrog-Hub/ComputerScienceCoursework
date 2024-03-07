PROGRAM textFileTesting;
  uses crt, sysutils;
  VAR myFile : Text;
    fName, textTmp : STRING;

  begin
    fName := 'C:\ComputerScienceCoursework\Program\files\Tnames.txt';
    ASSIGN(myFile, fName);
    reset(myFile);
    //repeat
      READLN(myFile, textTmp);
      WRITELN(textTmp);
    //UNTIL EOF(myFile);
    //close(myFile);
    readln;
  end.
