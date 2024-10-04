PROGRAM Controller;
  uses crt, sysutils;
 
  //MapArray : ARRAY[0..3,0..1] OF STRING; = ([0,],[1],[2],[3])

  begin
    while true do
      begin
        writeln(ord(readKey));
      end;
  end;