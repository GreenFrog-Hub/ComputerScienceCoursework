unit LogInScreen;
  interface
  uses crt, sysutils, vputils; {importing built in units to help with the layout}

  TYPE userPassArray = ARRAY[0..1] OF STRING; {Use one data structure to return from the unit}

  VAR Username, Password : STRING; {Declaring variables}
    y : LONGINT;
    userPass : userPassArray;

  procedure GetUsername; {declaring all the procedures in this unit and any local variables and parameters that they take}
  procedure GetPassword;
    var i, a : LONGINT;
    key : CHAR;
  procedure startLogIn(var userPassArrayr : ARRAY OF STRING);


  implementation

  PROCEDURE GetUsername; {The procedure that reads what the user types in for username}
      begin
        GotoXY(11,1);
        READLN(username);
      end;

  PROCEDURE GetPassword; 
    var i,a : LONGINT;
    key : CHAR;
    begin
      GoToXY(11,2); {Moves the cursor to the correct position}
      i := 0;
      HideCursor; {Hides the cursor}
      password := ''; {sets the password to an empty string}
      repeat {repeat until enter is pressed to submit}
        key := readkey; {read the key that is pressed}
          if (key = #8) THEN {Check if its the back space key}
            begin
              if i > 0 THEN {check if the password has more than 0 characters in it}
                begin
                  Delete(password,i,1); {if so remove the last charachter in password}
                  i := i -1; {decrease the length of the password by 1}
                end;
                {else do nothing}
            end

          else if ((key >= #33) and (key < #127) and (key <> #13)) OR (key = #156) THEN {check if it is a valid character and not a spcae}
            begin
              password := password + key; {add the key pressed to the password}
              i := i +1; {increase the length of password by 1}
            end;
          GoToXY(1,2); {go to the start of the password line}
          DelLine; {clears the line}
          Write('Password: '); {write the whole line again with the correct number of cogs}
          for a := 1 TO i DO
            write(#15);
    until key = #13;
      writeln;
    end;


  PROCEDURE DisplayInfo; {initial display of information that needs to be entered}
    Begin
      ClrScr;
      WRITELN('Username: ');
      WRITELN('Password: ');
      GoToXY(11,1); {go to the start of username}
    end; 

  procedure startLogIn(var userPassArrayr : ARRAY OF STRING);
    begin
      DisplayInfo; {Display intial information}
      GetUsername; {get the username}
      GetPassword; {get the password}
      ClrScr; {clear the screen for the next task}
      userPassArrayr[0] := username; {put the username and password into the array to be editied}
      userPassArrayr[1] := password;
    end;
  end.
