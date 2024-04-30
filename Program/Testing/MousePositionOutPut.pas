PROGRAM MousePositionOutPut;
  uses dos, crt;

  var x : LONGINT;
    //reg : registers;
    //myloc : byte absolute $0000:$0417;
  procedure init;
  var reg : registers;
  begin
    reg.AX=$0013;
    intr($10,reg);
  end;

  begin
  end.
