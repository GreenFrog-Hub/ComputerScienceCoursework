PROGRAM CursorGridTest;
  uses sysutils, crt, CursorGrid, opcrt;
  var a, x, y : longint;
    name : string[20];
  begin
    //name := 'bob';
    //write(name ,' ' ,name);
    BlockCursor;
    cursorGrid.startGrid(1,2,5,4,[1,1,10,10], x, y);
    readln;
  end.
