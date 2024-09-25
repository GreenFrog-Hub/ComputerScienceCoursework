PROGRAM dayTesting;
  uses crt, sysutils;

  var i : LONGINT;
    startDate : STRING;

  begin
    startDate := '23/09/2024';
    for i := 0 TO 14 DO
      begin
        writeln(DayOfWeek(StrToDate(startDate)+i-1));
        writeln('i: ', i);
      end;
    readln;
  end.
