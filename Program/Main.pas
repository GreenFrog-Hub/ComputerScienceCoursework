PROGRAM Main;
  //declare all units to be used
  USES Crt, Sysutils, LogInScreen, loading, LogInProcedures,
  teacherProcedures, TeachersMenu, StudentsMenu;
  var userType : STRING;
      intUserID : LONGINT;


  //declare main program
  function start:STRING;
    var i, ErrCode : LONGINT;
      userId : STRING;
      userDetailsArray : ARRAY[0..1] OF STRING;
      userDetailsReturnArray : ARRAY[0..1] OF LONGINT;
      logIn : logInFile;
      teacher : TeacherFile;
      percentDone : REAL;
      logedIn : BOOLEAN;
  begin
    //declare login file
    logIn := logInFile.create;
    logIn.sort;
    for i := 0 TO 1 DO
      userDetailsReturnArray[i] := -1;

    //delete in write up (debug)
    teacher := teacherFile.create;
    teacher.readHere;
    teacher.DisplayData;
    readln;

    //while loop to keep running log in attempts
    logedIn := false;
    while logedIn = false do
      begin
        ClrScr;
        //login methods
        LogInScreen.startLogIn(userDetailsArray);
        logIn.search(userDetailsArray,[1,2], userDetailsReturnArray);
        loading.startLoading('L', percentDone);
        Delay(1000);
        loading.silentKillLoading;
        Delay(100);
        //test username and password are valid
        if userDetailsReturnArray[0] = -1 THEN
          begin
            writeln('UserName Or Password is incorrect.');
            readkey;
          end
        else
          begin

            logedIn := true;
            //get the user info
            login.readFile(userDetailsReturnArray[0]);
            //test if the username and password belong to a teacher or student
            userId := Trim(login.data.PersonID);
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
          //delete login file object
          logIn.free;
    end;
  end;

  begin
    //start login
    userType := start;
    if userType = 'T' THEN
      //teacher menu
      TeachersMenu.startTeacher
    else
      //student menu
      StudentsMenu.startStudent(intUserID);
  end.
