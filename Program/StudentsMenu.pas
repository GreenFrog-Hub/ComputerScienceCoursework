UNIT StudentsMenu;
  interface
  uses crt, sysutils, VPUtils, studentProcedures, timeTableProcedures,
  attendancProcedures, studentClassProcedures,createMenu, writeTimeTableLayout;

  procedure startStudent(inputStudentId : LONGINT);
  procedure TimeTableMenu;
//  procedure TimeTableMenu;
  procedure AttendanceMenu;
  procedure LogOutMenu;
  procedure mainMenu;


  implementation

  var studentID : LONGINT;
      student : StudentFIle;
      attendance : AttendanceFile;
      timetable : TimeTableFile;
      studentClassC : studentClassFile;
      studentClassReturnArray : ARRAY[0..1400] OF LONGINT;
      timetableReturnArray: ARRAY[0..321] OF LONGINT;
      mainMenuOptions : ARRAY[0..2] OF STRING = ('Attendance','Timetable', 'Log Out');


  procedure AttendanceMenu;
    begin
      Writeln('Attendance');
      readln;
    end;

  procedure TimeTableMenu;
    var a, b, c, day, NumberOfDays : LONGINT;
        CurrentDate : TDateTime;
        week : STRING;
        stringStudentId : STRING;
        //dateArray : ARRAY OF STRING;
    begin
      writeTimeTableLayout.DrawTimeTable;
      CurrentDate := Date;//inputDate;
      day := DayOfWeek(CurrentDate-2);
      HideCursor;
      for a := 0 to 4 DO
        begin
          GOTOXY(5,7+a*4);
          if CurrentDate-day+a = Date THEN
            TextColor(Yellow)
          else
            TextColor(White);
          write(DateToStr(CurrentDate-day+a));
        end;
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
      stringStudentId := IntToStr(studentID);
      studentClassC.search(['0'],[1],studentClassReturnArray);
      b := 0;
      while studentClassReturnArray[b] <> -1 DO
        begin
          studentClassC.readFile(studentClassReturnArray[b]);
          for a := 0 to 320 DO
            timetableReturnArray[a] := -1;
          timetable.search([studentClassC.data.ClassID],[2], timetableReturnArray);
          c := 0;
          while timetableReturnArray[c] <> -1 DO
            begin
              timetable.readFile(timetableReturnArray[c]);
              if week = 'A' THEN
                begin
                  if timetable.data.day < 6 THEN
                    begin
                      GOTOXY((10*timetable.data.LessonNo+19),( 4*(timetable.data.Day-1)+7));
                      WRITE(Trim(TimeTable.data.ClassID));
                    end;
                end
              else
                begin
                  if timetable.data.day > 5 THEN
                    begin
                      GOTOXY((10*timetable.data.LessonNo+19),( 4*(timetable.data.Day-6)+7));
                      WRITE(Trim(TimeTable.data.ClassID));
                    end;
                end;
              c := c + 1;
            end;
          b := b + 1;
        end;
      for a := 0 TO 4 DO
        begin
          GOTOXY(19, 4*a+7);
          write(student.data.Form);
        end;
    end;

  {procedure TimeTableMenu;
    var TodayDate : TDateTime;
    begin
      TodayDate := Date;
      CompleteTimeTable(TodayDate);
      readln;
    end;}

  procedure LogOutMenu;
    begin
      writeln('Logging out');
      Delay(1000);
    end;


  procedure mainMenu;
    var choice : LONGINT;
    begin
      GOTOXY(0,0);
      choice := 0;
      student.readFile(studentID);
      attendance.readFile(studentID);
      repeat
        ClrScr;
        HideCursor;
        writeln('welcome ', student.data.fname, ' ', student.data.sname, ' ');
        GOTOXY(1,3);
        writeln('Attendance: ', Format('%.2f', [attendance.data.attendance*100]),'%');
        choice := createMenu.writeMenu([1,5],3,mainMenuOptions, choice);
        case choice of
          0 : AttendanceMenu;
          1 : TimeTableMenu;
          2 : LogOutMenu;
        end;
      until choice = 2;

    end;

  procedure startStudent(inputStudentId : LONGINT);
    var a : LONGINT;
        testArray: ARRAY[0..320] OF LONGINT;
    begin
      for a := 0 TO 1400 DO
        studentClassReturnArray[a] := -1;
      for a := 0 to 320 DO
        begin
        timetableReturnArray[a] := -1;
        testArray[a] := -1;
        end;
      timetable := TimeTableFile.create;
      studentClassC := studentClassFile.create;
      studentID := inputStudentId;
      attendance := AttendanceFile.create;
      student := StudentFile.create;
      //timetable.sort;
      writeln('here 0.5');
      readkey;
      student.search(['1'],[1], testArray);
      mainMenu;
    end;

  end.
