UNIT writeDesign;
  interface
  uses crt, sysutils, vputils;
  procedure DrawDesign(path: STRING; delayWrite : LONGINT);
  var Character : STRING;
      DesignTextFile : TextFile;
  implementation
  procedure DrawDesign(path: STRING; delayWrite : LONGINT);
    var a : LONGINT;
    begin
      HideCursor;
      ClrScr;
      ASSIGN(DesignTextFile,path);
      reset(DesignTextFile);
      for a := 0 to 28 DO
        begin
          readln(DesignTextFile, Character);
          writeln(Character);
          Delay(delayWrite);
        end;
      ShowCursor;

    end;
end.
