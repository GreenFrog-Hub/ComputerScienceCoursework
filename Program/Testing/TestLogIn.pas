PROGRAM TestLogIn;
  uses LogIn,crt;
  type userPassArray = ARRAY[0..1] OF STRING;

  var userPass : userPassArray;

  begin
    LogIn.startLogIn(userPass);
    writeln(userPass[0]);
    writeln(userPass[1]);
    readln;
  end.
