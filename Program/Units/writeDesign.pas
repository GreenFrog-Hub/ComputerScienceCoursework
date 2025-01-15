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
      //get the file to read from
      ASSIGN(DesignTextFile,path);
      reset(DesignTextFile);
      //read each line to a max of 28 (window size)
      for a := 0 to 28 DO
        begin
          readln(DesignTextFile, Character);
          //write each line
          writeln(Character);
          //delay for effects
          Delay(delayWrite);
        end;
      ShowCursor;

    end;
end.
