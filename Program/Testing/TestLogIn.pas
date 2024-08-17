PROGRAM TestLogIn;
  uses LogIn,crt; {importws modules to be used}
  type userPassArray = ARRAY[0..1] OF STRING; {set type that will be used to store the information}

  var userPass : userPassArray; {set the variab;es}

  begin
    LogIn.startLogIn(userPass); {call the login unit and tell it to start}
    writeln(userPass[0]); {display whats stored in the username variable}
    writeln(userPass[1]); {display whats stored in the password variable}
    readln; {debug: waits til i press anything to continue so i can read the output}
  end.
