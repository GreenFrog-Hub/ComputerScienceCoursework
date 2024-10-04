PROGRAM Main;
  USES Crt, Sysutils, LogInScreen, loading, LogInProcedures, studentProcedures,
  teacherProcedures, StudentsMenu, TeachersMenu, timeTableProcedures, studentClassProcedures,
  attendancProcedures;
  var userType : STRING;
      intUserID : LONGINT;

  function start:STRING;
    var i, ErrCode : LONGINT;
      userId : STRING;
      userDetailsArray : ARRAY[0..1] OF STRING;
      userDetailsReturnArray : ARRAY[0..1] OF LONGINT;
      logIn : logInFile;
      student : StudentFIle;
      teacher : TeacherFile;
      percentDone : REAL;
      logedIn : BOOLEAN;
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
    logedIn := false;
    while logedIn = false do
      begin
        ClrScr;
        LogInScreen.startLogIn(userDetailsArray);
        logIn.search(userDetailsArray,[1,2], userDetailsReturnArray);
        loading.startLoading('L', percentDone);
        // Delay(2000);
        loading.silentKillLoading;
        Delay(100);
        if userDetailsReturnArray[0] = -1 THEN
          begin
            writeln('UserName Or Password is incorrect.');
            readkey;
          end
        else
          begin
            logedIn := true;
            login.readFile(userDetailsReturnArray[0]);
            {LogIn.displayData;}
            userId := Trim(login.data.PersonID);
            {writeln(userID);
            readln;       }
            val(userid,intUserID,ErrCode);
            if ErrCode <> 0 THEN
              begin
                start := 'T';
              end
            else
              begin
                start := 'S';
              end;
          end;
    end;
  end;

  begin
    userType := start;
    if userType = 'T' THEN
      TeachersMenu.startTeacher
    else
      StudentsMenu.startStudent(intUserID);
  end.
