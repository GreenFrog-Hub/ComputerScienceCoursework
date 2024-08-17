PROGRAM CursorGridTest;
  uses sysutils, crt, CursorGrid;
  var a : longint;
    name : string[20];
  begin
    name := 'bob';
    write(name ,' ' ,name);
    cursorGrid.start(4,4,1,1);
    readln;
  end.
