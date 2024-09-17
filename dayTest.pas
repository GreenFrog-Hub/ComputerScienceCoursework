program dayTest;
  uses crt,sysutils;
  var date : TDateTime;
    day : LONGINT;


  begin
    date := Now;
    day := DayOfWeek(date);
    writeln(day);
    readln;
  end.
