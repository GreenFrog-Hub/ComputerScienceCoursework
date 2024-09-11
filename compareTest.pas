program compareTest;
{$ifdef fpc}{$mode delphi}{$H+}{$endif}
  type TByteArray = array [Word] of byte;
  var a : LONGINT;
    bill : TByteArray;
    tmp : STRING[3];

  procedure bob(var arr);
    begin
    end;

  begin
    if 'ba' > 'b' then
      writeln('true')
    else
      writeln('false');
    //readln;
    for a := 0 TO 0 DO
      writeln(a);
    bill[0] := 1;
    tmp := '1';
    writeln(Length(tmp));
    //writeln(bill[0]);
    readln;
  end.
