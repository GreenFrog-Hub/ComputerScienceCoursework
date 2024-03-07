PROGRAM POinterPractice;
  uses crt, sysutils;

  type intp = ^integer;

  var
    a : intp;
    ama : ^word;
    n : integer;

  begin
    n := 200;
    a := @n;
    ama := addr(a^);
    writeln(ama^);
    readln;
  end.
