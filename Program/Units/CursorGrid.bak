UNIT CursorGrid;
  interface
  uses crt, sysutils, vputils;

  var stepx , stepY, movePos : LONGINT;

  procedure moveUp;
  procedure moveDown;
  procedure moveLeft;
  procedure moveRight;
  procedure start(moveStepX, moveStepY, startX, startY : LONGINT);

  implementation
  procedure moveUp;
    begin
      movePos := WhereY - stepy;
      GoToXY(WhereX, movePos);
    end;

  procedure moveDown;
    begin
      movePos := WhereY + stepy;
      GoToXY(WhereX, movePos);
    end;

  procedure moveLeft;
    begin
      movePos := WhereX - stepx;
      GoToXY(movePos, WhereY);
    end;

  procedure moveRight;
    begin
      movePos := WhereX + stepX;
      GoToXY(movePos, WhereY);
    end;

  procedure start(moveStepX, moveStepY, startX, startY : LONGINT);
    var keyPress : char;
    begin
      stepX := moveStepX;
      stepY := moveStepY;
      //HideCursor;
      GoToXY(startX,startY);
      TextColor(green);
      repeat
        keyPress := readkey;
        if keyPress = #0 then
          begin
            case readKey of
              'H' : moveUp;
              'P' : moveDown;
              'K' : moveLeft;
              'M' : moveRight;
            end;
          end;
      until keyPress = #13;
    end;

  end.

