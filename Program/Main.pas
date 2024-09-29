PROGRAM Main;
  USES Crt, Sysutils, LogInScreen, LogInProcedures, studentProcedures, teacherProcedures, StudentsMenu, TeachersMenu;
  var i, empty, ErrCode : LONGINT;
      userId : STRING;
      userDetailsArray : ARRAY[0..1] OF STRING;
      userDetailsReturnArray : ARRAY[0..1] OF LONGINT;
      logIn : logInFile;
      student : StudentFIle;
      teacher : TeacherFile;
  begin
    {studentsmenu.startStudent;}
    logIn := logInFile.create;
    logIn.sort;
    for i := 0 TO 1 DO
      userDetailsReturnArray[i] := -1;
    teacher := teacherFile.create;
    teacher.readHere;
    teacher.DisplayData;
    readln;
    ClrScr;
    LogInScreen.startLogIn(userDetailsArray);
    logIn.search(userDetailsArray,[1,2], userDetailsReturnArray);
    if userDetailsReturnArray[0] = -1 THEN
      writeln('UserName Or Password is incorrect.')
    else
      begin
        login.readFile(userDetailsReturnArray[0]);
        {LogIn.displayData;}
        userId := Trim(login.data.PersonID);
        {writeln(userID);
        readln;       }
        val(userid,empty,ErrCode);
        if ErrCode <> 0 THEN
          begin
            TeachersMenu.startTeacher;
          end
        else
          begin
            StudentsMenu.startStudent;
          end;
      end;
  end.
