UNIT CursorGrid;
  interface
  uses crt, sysutils, vputils;

  var stepx , stepY, movePos, minX, minY, maxX, maxY: LONGINT;

  procedure moveUp;
  procedure moveDown;
  procedure moveLeft;
  procedure moveRight;
  procedure startGrid(moveStepX, moveStepY, startX, startY : LONGINT; boundaries : ARRAY OF LONGINT; var x, y : LONGINT);

  implementation
  procedure moveUp;
    begin
      if WhereY <> minY THEN
        begin
          movePos := WhereY - stepy;
          GoToXY(WhereX, movePos);
        end;
    end;

  procedure moveDown;
    begin
      if WhereY <> maxY THEN
        begin
          movePos := WhereY + stepy;
          GoToXY(WhereX, movePos);
        end;
    end;

  procedure moveLeft;
    begin
      if WhereX <> minX THEN
        begin
          movePos := WhereX - stepx;
          GoToXY(movePos, WhereY);
        end;
    end;

  procedure moveRight;
    begin
      if WhereX <> maxX THEN
        begin
          movePos := WhereX + stepX;
          GoToXY(movePos, WhereY);
        end;
    end;

  procedure startGrid(moveStepX, moveStepY, startX, startY : LONGINT; boundaries : ARRAY OF LONGINT; var x, y : LONGINT);
    var keyPress : char;
    begin
      stepX := moveStepX;
      stepY := moveStepY;
      minX := boundaries[0];
      minY := boundaries[1];
      maxX := boundaries[2];
      maxY := boundaries[3];
      GoToXY(startX,startY);
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
      x := WhereX - startX;
      y := WhereY - startY;
    end;

  end.

