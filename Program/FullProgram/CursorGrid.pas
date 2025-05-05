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
      //if the cursor will stay in the boundaries set
      if WhereY - stepy >= minY THEN
        begin
          movePos := WhereY - stepy;
          GoToXY(WhereX, movePos);
        end;
    end;

  procedure moveDown;
    begin
      //if the cursor will stay in the boundaries set
      if WhereY + stepy <= maxY THEN
        begin
          movePos := WhereY + stepy;
          GoToXY(WhereX, movePos);
        end;
    end;

  procedure moveLeft;
    begin
      //if the cursor will stay in the boundaries set
      if WhereX - stepx >= minX THEN
        begin
          movePos := WhereX - stepx;
          GoToXY(movePos, WhereY);
        end;
    end;

  procedure moveRight;
    begin
      //if the cursor will stay in the boundaries set
      if WhereX + stepx <= maxX THEN
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
      //key checking key presses until enter is pressed
      repeat
        keyPress := readkey;
        if keyPress = #0 then //check if an extended key or function key
          begin
            case readKey of //read its scan code to get which arrow key was pressed and call according procedure
              'H' : moveUp;
              'P' : moveDown;
              'K' : moveLeft;
              'M' : moveRight;
            end;
          end;
      until keyPress = #13;
      //corrects the return to a choice of menu option rather than spaces moved
      if stepX <> 0 THEN//stops divide by 0 error
          x := Round((WhereX - startX) / stepX) //round to change float to int
      ELSE
          x := startX;

      if stepY <> 0 THEN//stops divide by 0 error
        y := round((WhereY - startY) / stepY) //round to change float to int
      ELSE
        y := startY;
    end;

  end.

