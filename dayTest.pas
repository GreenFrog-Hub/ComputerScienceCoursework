program dayTest;
  uses crt,sysutils;
  var tdate : TDateTime;
    day : LONGINT;


  begin
    tdate := Date;
    day := DayOfWeek(tDate);
    writeln(day);
    readln;
  end.
