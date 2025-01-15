PROGRAM dayTesting;
  uses crt, sysutils;

  var day, i : LONGINT;
    startDate : STRING;


  begin
    writeln(LowerCase('9ABC'));
    readln;
    startDate := '13/01/2025';
    for i := 0 TO 14 DO
      begin
        writeln(DateToStr(StrToDate(startDate)+i),':',DayOfWeek(StrToDate(startDate)+i-1)-1);
        //writeln('i: ', i);
      end;
    //day := DayOfWeek(Date-1);
    //writeln('day:' ,day);
    readln;
  end.
