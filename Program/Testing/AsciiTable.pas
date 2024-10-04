PROGRAM AciiTable;
  //{$codePage ascii}
  uses crt,sysutils,vputils,CursorGrid;
  var i,a,b : LONGINT;
    specChar : string;

  begin
    a := 1;
    b:=1;
    for i := 0 TO 256 DO
      begin
        GoToXY(b,a);
        write(i,': ',char(i));
        a := a + 1;
        if a > 29 THEN
          begin
            a := 1;
            b := b + 10;
            GoToXY(1,1);
          end;

      end;
    //CursorGrid.start(10,1,1,1);
    read(specChar);
    clrscr;
    writeln(specChar);
    readln;
  end.
