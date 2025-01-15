PROGRAM ForLoopStep;
  var i : LONGINT;

  begin
    BlockCurosr;
    for i := 0 TO -1 DO
      begin
        writeln(i);
      end;
    readln;
  end.
