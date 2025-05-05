UNIT waitTime;

  interface
  uses crt, sysutils, vputils, math;

  procedure waitForTime(message : STRING; timeIndex : LONGINT);
    var a : LONGINT;
  implementation

  var waitArray : ARRAY[0..5] OF LONGINT = (30, 60, 300, 600, 1800, 3600);

  procedure waitForTime(message : String; timeIndex : LONGINT);
    var a : LONGINT;
    begin
      HideCursor;
      ClrScr;
      Writeln(message, ' please wait');
      for a := 0 TO waitArray[timeIndex] do
        begin
          
          if Ceil((waitArray[timeIndex]-a)/60) >= 10 then
            begin
              GOTOXY(1,2);
              write(Ceil((waitArray[timeIndex]-a)/60), ' minutes');
            end
          else if Ceil((waitArray[timeIndex]-a)/60) > 1 then
            begin
              GOTOXY(1,2);
              write('0');
              write(Ceil((waitArray[timeIndex]-a)/60), ' minutes');
            end
          else if waitArray[timeIndex]-a >= 10 then
            begin
              GOTOXY(1,2);
              DelLine;
              write(waitArray[timeIndex]-a, ' seconds');
            end
          else
            begin
              GOTOXY(1,2);
              DelLine;
              write('0');
              write(waitArray[timeIndex]-a, ' seconds');
            end;
          Delay(1000);
        end;
    end;

  end.
