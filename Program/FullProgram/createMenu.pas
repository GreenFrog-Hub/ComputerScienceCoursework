unit createMenu;

  interface

  uses crt, sysutils, CursorGrid, VPUtils;

  function writeMenu(startPos : ARRAY OF LONGINT; numberOfChoices : LONGINT; menuChoices: ARRAY OF STRING; optionStart : LONGINT) : LONGINT;

  implementation

  function writeMenu(startPos : ARRAY OF LONGINT; numberOfChoices : LONGINT; menuChoices: ARRAY OF STRING; optionStart : LONGINT) : LONGINT;
    var a, x, y : LONGINT;
    begin
      HideCursor;
      
      //write each menu option
      for a := 0 TO numberOfChoices -1 DO
        begin
          //make sure it is alawys writing where it needs to
          GOTOXY(startPos[0],startPos[1]+a);
          writeln(a+1,': ',menuChoices[a]);
        end;
      ShowCursor;
      Delay(100);
      //start the cursor grid script with set boundary conditions and steps to allow control with arrow keys
      CursorGrid.startGrid(0,1,startPos[0],startPos[1]+optionStart,[startPos[0],startPos[1],startPos[0],numberOfChoices+startPos[1]-1],x,y);
      ClrScr;
      writeMenu := optionStart + y;
    end;

  end.
