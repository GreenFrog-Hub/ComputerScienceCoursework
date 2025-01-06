UNIT StudentsMenu;
  interface
  uses crt, sysutils, VPUtils, studentProcedures, timeTableProcedures,
  attendancProcedures, studentClassProcedures,createMenu, writeDesign;

  //declaration of all procedures and functions
  procedure startStudent(inputStudentId : LONGINT);
  procedure CompleteTimeTable(inputDate : TDateTime);
  procedure TimeTableMenu;
  procedure AttendanceMenu;
  procedure LogOutMenu;
  procedure mainMenu;


  implementation
  //declare variables local to this unit
  var studentID : LONGINT;
      student : StudentFIle;
      attendance : AttendanceFile;
      timetable : TimeTableFile;
      studentClassC : studentClassFile;
      studentClassReturnArray : ARRAY[0..1400] OF LONGINT;
      timetableReturnArray: ARRAY[0..321] OF LONGINT;
      mainMenuOptions : ARRAY[0..2] OF STRING = ('Attendance','Timetable', 'Log Out');
      animationTimeTable : BOOLEAN;

  //Menu for viewing attendance
  procedure AttendanceMenu;
    begin
      Writeln('Attendance');
      readln;
    end;

  //fill timetable with the data
  procedure CompleteTimeTable(inputDate : TDateTime);
    var a, b, c, day, NumberOfDays, timeDelay : LONGINT;
        CurrentDate : TDateTime;
        week : STRING;
        stringStudentId : STRING;
        //dateArray : ARRAY OF STRING;
    begin
      //draw basic timetable outline
      if animationTimeTable = true THEN
        begin
          timeDelay := 100;
        end
      else
        begin
          timeDelay := 0;
        end;
      writeDesign.DrawDesign('C:\ComputerScienceCoursework\Program\files\TimeTableLayout.txt', timeDelay);
      CurrentDate := inputDate;
      day := DayOfWeek(CurrentDate-2);
      HideCursor;
      //write the dates with current date highlighted
      for a := 0 to 4 DO
        begin
          GOTOXY(5,7+a*4);
          if CurrentDate-day+a = Date THEN
            TextColor(Yellow)
          else
            TextColor(White);
          write(DateToStr(CurrentDate-day+a));
          Delay(timeDelay);
        end;
      TextColor(White);
      //calcualte if it is week A or week B
      NumberOfDays := 0;
      while StrToDateTime('13/09/2024') + NumberOfDays <> CurrentDate-day+a-1 DO
        NumberOfDays := NumberOfDays +1;
      NumberOfDays := NumberOfDays DIV 7;
      GOTOXY(7,2);
      if (NumberOfDays mod 2 = 0 )THEN
        week := 'A'
      else
        week := 'B';
      WRITE(week);
      //write lessons in timetable
      stringStudentId := IntToStr(studentID);
      //get all classes which the student is in
      studentClassC.search([stringStudentId],[1],studentClassReturnArray);
      b := 0;
      //for every class
      while studentClassReturnArray[b] <> -1 DO
        begin
          //get the class id
          studentClassC.readFile(studentClassReturnArray[b]);
          for a := 0 to 320 DO
            timetableReturnArray[a] := -1;
          //find every time and day that class is on
          timetable.search([studentClassC.data.ClassID],[2], timetableReturnArray);
          c := 0;
          while timetableReturnArray[c] <> -1 DO
            begin
              //get the day and time for that one time that one class is
              timetable.readFile(timetableReturnArray[c]);
              //test for the current week
              if week = 'A' THEN
                begin
                  //test if the class is on the correct week
                  if timetable.data.day < 6 THEN
                    begin
                      //got to position and write class id
                      GOTOXY((10*timetable.data.LessonNo+19),( 4*(timetable.data.Day-1)+7));
                      WRITE(Trim(TimeTable.data.ClassID));
                      Delay(timeDelay);
                    end;
                end
              else
                begin
                  //test if the class is on the correct week
                  if timetable.data.day > 5 THEN
                    begin
                      //got to position and write class id
                      GOTOXY((10*timetable.data.LessonNo+19),( 4*(timetable.data.Day-6)+7));
                      WRITE(Trim(TimeTable.data.ClassID));
                      Delay(timeDelay);
                    end;
                end;
              c := c + 1;
            end;
          b := b + 1;
        end;
      //write the form data in
      for a := 0 TO 4 DO
        begin
          GOTOXY(19, 4*a+7);
          write(student.data.Form);
          Delay(timeDelay);
        end;
        animationTimeTable := false;
    end;

  //Draw and populate timetable
  procedure TimeTableMenu;
    var StartDate : TDateTime;
    begin
      StartDate := Date;
      CompleteTimeTable(StartDate);
      readln;
    end;

  procedure LogOutMenu;
    begin
      writeln('Logging out');
      Delay(1000);
    end;

  //main menu
  procedure mainMenu;
    var choice : LONGINT;
    begin
      GOTOXY(0,0);
      choice := 0;
      //get student and attendance data at the start
      student.readFile(studentID);
      attendance.readFile(studentID);
      //main menu display until logout selected
      repeat
        ClrScr;
        HideCursor;
        //messages welcoming and displaying overall attendance
        writeln('welcome ', student.data.fname, ' ', student.data.sname, ' ');
        GOTOXY(1,3);
        writeln('Attendance: ', Format('%.2f', [attendance.data.attendance*100]),'%');

        //create the menu and start to control it
        choice := createMenu.writeMenu([1,5],3,mainMenuOptions, choice);
        //test for each menu choice
        case choice of
          0 : AttendanceMenu;
          1 : TimeTableMenu;
          2 : LogOutMenu;
        end;
      until choice = 2;

    end;


  //declaration of global variables
  procedure startStudent(inputStudentId : LONGINT);
    var a : LONGINT;
    begin
      animationTimeTable := true;
      //populate arrays with -1
      for a := 0 TO 1400 DO
        studentClassReturnArray[a] := -1;
      for a := 0 to 320 DO
        begin
        timetableReturnArray[a] := -1;
        end;
      //declare file objects for this unit
      timetable := TimeTableFile.create;
      studentClassC := studentClassFile.create;
      studentID := inputStudentId;
      attendance := AttendanceFile.create;
      student := StudentFile.create;
      mainMenu;
    end;

  end.
