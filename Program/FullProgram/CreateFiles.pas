PROGRAM CreateFiles;
  uses crt, sysutils, search,sorting, loading, DisplayErrorScrn, math;

  type {declaring all record types}
    TimeTableRecord = RECORD
                          Day : LONGINT;
                          LessonNo : LONGINT;
                          ClassID : STRING[8];
                        end;
    FormRecord = RECORD
                          FormID : STRING[5];
                          NumberInForm : LONGINT;
                        end;

    AttendanceRecord = RECORD
                          StudentID : LONGINT;
                          Attendance : REAL;
                          Total : LONGINT;
                          NumberPresent : LONGINT;
                          NumberLate : LONGINT;
                          NumberAbsent : LONGINT;
                        end;


    StudentsRecord = RECORD
                          StudentID : LONGINT;
                          FName : STRING[20];
                          SName : String[20];
                          Year : LONGINT;
                          Form : STRING[5];
                          Uname : String[40];
                          Pword : String[20];
                        end;


    teacherRecord = RECORD
                          TeacherID : STRING[3];
                          fname : string[20];
                          sname : string[20];
                          form  : string[5];
                          Uname : STRING[40];
                          PWord : STRING[20];
                        end;

    classRecord = RECORD
                          ClassID : STRING[8];
                          Year : LONGINT;
                          subjectID : STRING[3];
                          NoOfStudents : LONGINT;
                        end;

    subjectRecord = RECORD
                          SubjectID : STRING[3];
                          SubjectName : STRING[20];
                        end;

    studentRegisterMarkRecord = RECORD
                          studentID : LONGINT;
                          registerMark : CHAR;
                        end;

    registerRecord = RECORD
                          RegisterID : STRING[17];
                          LessonNo : LONGINT;
                          Date : TDateTime;
                          ClassID : STRING[8];
                          RegisterMarks : ARRAY[0..40] OF studentRegisterMarkRecord;
                          isOfstedRegister : BOOLEAN;
                        end;

    studentClassResolverRecord = RECORD
                          StudentID : LONGINT;
                          ClassID : STRING[8];
                        end;
    teacherSubjectResolverRecord = RECORD
                          TeacherID : STRING[3];
                          SubjectID : STRING[2];
                        end;

    teacherClassResolverRecord = RECORD
                          TeacherID : STRING[3];
                          ClassID : STRING[8];
                        end;

    LogInDetailsRecord = RECORD
                          PersonID: STRING[5];
                          Username: STRING[40];
                          Passwowrd: String[20];
                         end;
  VAR {setting up all variables for records and files}
    numberDone, total : LONGINT;

    TimeTable : TimeTableRecord;
    TimeTableTextFile : TextFile;
    TimeTableFile : FILE OF TimeTableRecord;
    TimeTableInfoFromFile : STRING;

    Form : FormRecord;
    FormFile : FILE OF FormRecord;

    Register : registerRecord;
    studentRegisterMark : studentRegisterMarkRecord;
    RegisterFile : File OF registerRecord;


    Attendance : AttendanceRecord;
    AttendanceFile : FILE OF AttendanceRecord;
    StudentFName : STRING;
    NameFile : TextFile;
    Student : StudentsRecord;
    StudentFile : FILE OF StudentsRecord;

    TeacherFileFromFile : TextFile;
    TeacherFile : file of teacherRecord;
    TeacherFromFile : String;
    Teacher : teacherRecord;

    sClass : ClassRecord;
    classFile : FILE OF ClassRecord;

    subject : subjectRecord;
    subjectFile : FILE OF subjectRecord;

    studentClassResolver : studentClassResolverRecord;
    studentClassResolverFile : FILE OF studentClassResolverRecord;

    teacherSubjectResolver : teacherSubjectResolverRecord;
    teacherSubjectResolverFile : FILE OF teacherSubjectResolverRecord;

    teacherClassResolver : teacherClassResolverRecord;
    teacherClassResolverFile : FILE OF teacherClassResolverRecord;

    empty, ErrCode : LONGINT; {setting up other variables for functions that require an input}
    percentComplete : REAL; {variable for progress bar to track progress}

    LogInDetails: LogInDetailsRecord;
    LogInDetailsFile : FILE OF LogInDetailsRecord;

     {setting up common array across many functions}
    classIDArray : ARRAY[0..50] OF STRING;



  procedure initialiseFiles;
    begin
      percentComplete := 0.0; {initializing percentDone and total iterations}
      total := 0;
      {assigning a place on the drive to the files}
      ASSIGN(TimeTableTextFile,'C:\ComputerScienceCoursework\Program\files\TimeTableText.txt');
      ASSIGN(TimeTableFile,'C:\ComputerScienceCoursework\Program\files\TimeTable.dta');
      total:= total +51;

      ASSIGN(RegisterFile,'C:\ComputerScienceCoursework\Program\files\Registers.dta');
      total := total + 60;

      ASSIGN(NameFile,'C:\ComputerScienceCoursework\Program\files\Names.txt');
      ASSIGN(StudentFile,'C:\ComputerScienceCoursework\Program\files\Students.dta');
      total := total + 140;

      ASSIGN(TeacherFile,'C:\ComputerScienceCoursework\Program\files\Teachers.dta');
      total := total + 51;

      ASSIGN(classFile,'C:\ComputerScienceCoursework\Program\files\classes.dta');
      total := total + 51;

      ASSIGN(subjectFile,'C:\ComputerScienceCoursework\Program\files\subjects.dta');
      total := total + 21;

      ASSIGN(studentClassResolverFile,'C:\ComputerScienceCoursework\Program\files\studentClassResolver.dta');
      total := total + 140;

      ASSIGN(teacherSubjectResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherSubjectResolver.dta');
      total:= total + 51;

      ASSIGN(teacherClassResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherClassResolver.dta');
      total := total + 51;

      ASSIGN(FormFile,'C:\ComputerScienceCoursework\Program\files\forms.dta');
      total := total +5;

      ASSIGN(AttendanceFile,'C:\ComputerScienceCoursework\Program\files\attendanceFile.dta');

      ASSIGN(LogInDetailsFile,'C:\ComputerScienceCoursework\Program\files\LogInDetails.dta');
      total := total + 191;
    end;


  procedure closeAllFiles;
    begin
      {closing all files to confirm all changes are fully written and complete}
      close(TimeTableTextFile);
      close(TimeTableFile);
      close(RegisterFile);
      close(NameFile);
      close(StudentFile);
      close(TeacherFile);
      close(classFile);
      close(subjectFile);
      close(studentClassResolverFile);
      close(teacherSubjectResolverFile);
      close(teacherClassResolverFile);
      close(FormFile);
      close(AttendanceFile);
      close(LogInDetailsFile);
    end;

  procedure CreateTimeTable;

    begin
      reset(TimeTableTextFile); //set pointer to start of file
      rewrite(TimeTableFile); //clear all exiting data in timetable file
      while not EOF(TimeTableTextFile) do //iterate until all data is extracted
        begin
          numberDone := numberDone +1;
          percentComplete := numberDone/total;
          readln(TimeTableTextFile,TimeTableInfoFromFile); //get the class id
          TimeTable.ClassId := TimeTableInfoFromFile; //assign it to the record variable
          repeat
            readln(TimeTableTextFile,TimeTableInfoFromFile);
            TimeTable.LessonNo := StrToInt(TimeTableInfoFromFile);
            readln(TimeTableTextFile,TimeTableInfoFromFile);
            TimeTable.Day := StrToInt(TimeTableInfoFromFile);
            readln(TimeTableTextFile,TimeTableInfoFromFile);
            try
              write(TimeTableFile,TimeTable);
            finally
            end;
          until TimeTableInfoFromFile = 'Q'; {repeat until all dates are read and stored in the .dta file
                                              for that class marked by a Q in the text file}
        end;
    end;

  procedure addForms;
    var a, i : LONGINT;
    begin
      REWRITE(FormFile); {clear all exisiting data in the form file}
      for i := 0 to 3 DO {iterate for all 4, year 9 forms}
        begin
          numberDone := numberDone + 1;
          percentComplete := numberDone / total;
          form.formID := '9' + 'AA' + Chr(i +65); {create 4 unique for identifiers}
          form.NumberInForm := 0; {set Number of kids in form to 0}
          write(FormFile, form); {push data to file}
        end;
      numberDone := numberDone + 1;
      percentComplete := numberDone / total;
      form.formID := '12' + 'AAA'; {do the same for 1 year 12 form}
      form.NumberInForm := 0;
      write(FormFile,form);
      reset(FormFile); {set point to start of form file}
      for i := 0 to 4 DO {for every form}
        begin
        read(formFile,form);
        timetable.classid := form.formID; {get form id into a timetable class id variable}
          for a := 1 to 10 DO {add it to the file as lesson 0 for every morning in the 2 week timetabe}
            begin
              timetable.LessonNo := 0;
              timetable.Day := a;
              write(TimeTableFile, timetable); {add new data to timetable file}
            end;
        end;
    end;

  procedure createRegisters;
    var a,b,c,i,randomMark,day : LONGINT; {Initizlize iterative variables, arrays and other variables for this procedure}
        dayArray : ARRAY[0..320] OF STRING;
        dayReturnArray : ARRAY[0..320] OF LONGINT;
        studentClassResolverClassArray : ARRAY[0..1384] OF STRING;
        classReturnArray : ARRAY[0..1384] OF LONGINT;
        classId, startDate : STRING;
        studentFormIdArray : ARRAY[0..139] OF STRING;
        returnStudentFormIdArray : ARRAY[0..139] OF LONGINT;
        date : TDateTime;
    begin
      //set up files and reset file pointers
      reset(TimeTableFile);
      reset(studentClassResolverFile);
      RESET(StudentFIle);
      rewrite(RegisterFile);
      i := 0;
      startDate := '13/09/2024';
      //populating the arrays with the data from the files
      for i := 0 To 139 DO
        begin
          READ(StudentFile,Student);
          studentFormIdArray[i] := Student.Form;
          returnStudentFormIdArray[i] := -1;
        end;
      i := 0;
      while not(eof(TimeTableFile)) DO
        begin
          read(TimeTableFile,TimeTable);
          dayArray[i] := IntToStr(TimeTable.day);
          dayReturnArray[i] := -1;
          i := i +1;
        end;
      i := 0;
      while not(eof(studentClassResolverFile)) do
        begin
          read(studentClassResolverFile,studentClassResolver);
          studentClassResolverClassArray[i] := studentClassResolver.ClassID;
          classReturnArray[i] := -1;
          i := i +1;
        end;
      b := 0;

      // for loop for number of days with registers
      for i := 0 to 29 do
        begin
          //gets the number day of the week and corrects to monday being 0
          day := DayOfWeek(StrToDate(startDate)+b-1);
          if (day = 7) OR (day = 6) THEN //if weekend decrease for loop var by 1
            begin
              i := i -1;
            end
          else
            begin
              numberDone := numberDone +1;
              percentComplete := numberDone / total;
              //clear out array for searching for classes on that day
              for c := 0 TO 269 DO
                dayReturnArray[c] := -1;
              Search.SearchFunctions('L',0,269,IntToStr(DayOfWeek(StrToDate(startDate)+b-1)),dayArray,dayReturnArray,empty);
              a := 0;
              while dayReturnArray[a] <> -1 DO // for every class on that day
                begin
                  //find and get the data about one class
                  SEEK(TimeTableFile,dayReturnArray[a]);
                  read(TimeTableFile, TimeTable);
                  //set register data
                  Register.LessonNo := TimeTable.LessonNo;
                  Register.Date := StrToDate(startDate)+b;
                  if TimeTable.LessonNo = 4 THEN
                    Register.isOfstedRegister := true
                  else
                    Register.isOfstedRegister := false;
                  Register.classID := '';
                  Register.classID := TimeTable.classID;
                  register.registerID := IntToStr(register.lessonNo) + register.classID + DateTimeToStr(register.date);
                  classId := format('%s',[Register.classID]);
                  //clear out array for searching for students in that class
                  for c := 0 to 1384 DO
                    classReturnArray[c] := -1;
                  Search.SearchFunctions('L',0,1384,Register.ClassID,studentClassResolverClassArray,classReturnArray,empty);
                  c:=0;
                  //for every student in that class
                  while classReturnArray[c] <> -1 DO
                    begin
                      //get the class with the studenet in
                      SEEK(studentClassResolverFile, classReturnArray[c]);
                      read(studentClassResolverFile, studentClassResolver);
                      //get the student id
                      studentRegisterMark.studentID := studentClassResolver.studentID;
                      //get the data in the attendance file
                      SEEK(AttendanceFile,studentClassResolver.studentID);
                      read(AttendanceFile,Attendance);
                      Attendance.Total := Attendance.Total +1;
                      //randomly assign the student a mark
                      randomMark := RANDOM(100);
                      if randomMark <= 90 then
                        begin
                          studentRegisterMark.registerMark := 'P';
                          Attendance.NumberPresent := Attendance.NumberPresent + 1;
                        end
                      else if randomMark <= 97 then
                        begin
                          studentRegisterMark.registerMark := 'L';
                          Attendance.NumberLate := Attendance.NumberLate + 1;
                        end
                      else
                        begin
                          studentRegisterMark.registerMark := 'A';
                          Attendance.NumberAbsent := Attendance.NumberAbsent + 1;
                        end;
                      //write data back to register file
                      Register.registerMarks[c] := studentRegisterMark;
                      SEEK(AttendanceFile,FilePos(AttendanceFile)-1);
                      Attendance.Attendance := (Attendance.NumberPresent / Attendance.Total);
                      write(AttendanceFile,Attendance);
                      c := c +1;
                    end;
                  write(RegisterFile,Register);

                  a := a +1;
                end;
            end;
            b := b +1;
        end;


        b:= 0;
        for i := 0 to 29 DO //for loop for each form
          begin
            //gets the number day of the week and corrects to monday being 0
            day := DayOfWeek(StrToDate(startDate)+b-1);
            if (day = 7) OR (day = 6) THEN //if weekend decrease for loop var by 1
              begin
                i := i -1;
              end
            else
              begin
                numberDone := numberDone +1;
                percentComplete := numberDone / total;
                //clear out array for searching for forms on that day
                for c := 0 TO 320 DO
                  dayReturnArray[c] := -1;
                Search.SearchFunctions('L',269,320,IntToStr(DayOfWeek(StrToDate(startDate)+b-1)),dayArray,dayReturnArray,empty);
                a := 0;
                while dayReturnArray[a] <> -1 DO// for every form on that day
                  begin
                    SEEK(TimeTableFile,dayReturnArray[a]);
                    read(TimeTableFile, TimeTable);
                    if TimeTable.LessonNo = 0 THEN
                      begin
                        //set register data
                        Register.LessonNo := TimeTable.LessonNo;
                        Register.Date := StrToDate(startDate)+b;
                        Register.isOfstedRegister := true;
                        Register.classID := '';
                        Register.classID := TimeTable.classID;
                        register.registerID := IntToStr(register.lessonNo) + register.classID + DateTimeToStr(register.date);
                        //clear out array for searching for students in that form
                        classId := format('%s',[Register.classID]);
                        for c := 0 TO 139 DO
                          returnStudentFormIdArray[c] := -1;
                        Search.SearchFunctions('L',0,139,Register.ClassID,studentFormIdArray,returnStudentFormIdArray,empty);
                        c := 0;
                        //for every student in that form
                        while returnStudentFormIdArray[c] <> -1 DO
                          begin
                            //get the class with the studenet in
                            SEEK(StudentFile, returnStudentFormIdArray[c]);
                            read(StudentFile, Student);
                            //get the student id
                            studentRegisterMark.studentID := student.studentID;
                            //get the data in the attendance file
                            SEEK(AttendanceFile,student.studentID);
                            read(AttendanceFile,Attendance);
                            Attendance.Total := Attendance.Total +1;
                            //randomly assign the student a mark
                            randomMark := RANDOM(100);
                            if randomMark <= 90 then
                              begin
                                studentRegisterMark.registerMark := 'P';
                                Attendance.NumberPresent := Attendance.NumberPresent + 1;
                              end
                            else if randomMark <= 97 then
                              begin
                                studentRegisterMark.registerMark := 'L';
                                Attendance.NumberLate := Attendance.NumberLate + 1;
                              end
                            else
                              begin
                                studentRegisterMark.registerMark := 'A';
                                Attendance.NumberAbsent := Attendance.NumberAbsent + 1;
                              end;
                            //write data back to register file
                            Register.registerMarks[c] := studentRegisterMark;
                            SEEK(AttendanceFile,FilePos(AttendanceFile)-1);
                            Attendance.Attendance := (Attendance.NumberPresent / Attendance.Total);
                            write(AttendanceFile,Attendance);
                            c := c +1;
                          end;
                          write(RegisterFile,Register);

                      end;
                      a := a + 1;
                  end;
              end;
              b := b + 1;
          end;
    end;


  procedure addStudents;
    var i : LONGINT;
      ffname, fsname, fyear, fform, fattendance : STRING; {set up variables to read from text file into}
    begin
      i := 0;
      RESET(FormFile); {resets pointer in form file}
      read(formFIle, form); {gets the first form}
      RESET(NameFile);
      REWRITE(StudentFile); {clears both studenet and attendance file}
      REWRITE(AttendanceFile);
      for i := 0 to 119 DO {generate 120 year 9 students}
        begin
          if (i mod 30 = 0) and (i <> 0) THEN //changes the form every 30 students
            begin
              seek(formFile, (FilePos(formFile)-1));
              write(FormFile,form);
              READ(FormFile, form);
            end;
          numberDone:= numberDone +1; //update progress bar
          percentComplete := numberDone/total;
          Student.StudentID := i; //set student data
          READLN(NameFile, student.fname); //get a first and last name from a list of names
          READLN(NameFile, student.sname);
          student.year := 9;
          student.uname := student.fname+student.sname;
          student.pword := 'ABC123';
          student.form := form.formid;
          form.NumberInForm := form.NumberInForm + 1;
          //set attendance data
          Attendance.studentId := i;
          Attendance.Attendance := 1;
          Attendance.Total := 0;
          Attendance.NumberPresent := 0;
          Attendance.NumberLate := 0;
          Attendance.NumberAbsent := 0;
          write(StudentFile,student); //write student and attendance data to their respective files
          write(AttendanceFile, Attendance);
        end;
      seek(formFile, (FilePos(formFile)-1));
      write(FormFile,form);
      read(FormFile, form); {get the year 12 form}
      for i := 120 to 139 DO {generate 20 year 12 students}
        begin
          numberDone := numberDone +1; //update progress bar
          percentComplete := numberDone/total;
          Student.StudentID := i; //set student data
          READLN(NameFile, student.fname); //get a first and last name from a list of names
          READLN(NameFile, student.sname);
          student.year := 12;
          student.uname := student.fname+student.sname;
          student.pword := 'ABC123';
          form.NumberInForm := form.NumberInForm + 1;
          student.form := form.formid;
          //set attendance data
          Attendance.studentId := i;
          Attendance.Attendance := 1;
          Attendance.Total := 0;
          Attendance.NumberPresent := 0;
          Attendance.NumberLate := 0;
          Attendance.NumberAbsent := 0;
          write(StudentFile,student); //append this record to the end of the student file
          write(AttendanceFile, Attendance);
        end;
        //write changes to form file
        seek(formfile, filepos(formFile)-1);
        write(formfile,form);
    end;

  procedure addTeachers;
    var i : LONGINT;
      ffname, fsname, fform : STRING; {declare all variables to read from files into them}
    begin
      RESET(FormFile);
      rewrite(TeacherFile);
      for i := 0 TO 50 DO //create 51 teachers, 1 per class
        begin
            numberDone := numberDone + 1;
            percentComplete := numberDone / total;
            READLN(NameFile, teacher.Fname); //read first and surname form names file
            READLN(NameFile, teacher.Sname);
            Teacher.TeacherID := teacher.FName[1]+teacher.SName[1]+teacher.SName[2]; //create the teacher id as first letter of first name and forst two letters of surname
            Teacher.uname := teacher.FName + teacher.SName;
            Teacher.pword := 'ABC123';
            write(TeacherFile,teacher);
        end;
      //assign teachers to forms
      RESET(TeacherFile);
      for i := 0 to 4 DO
        begin
          read(TeacherFile,teacher);
          read(FormFile,form);
          teacher.form := form.formID;
          seek(TeacherFile,FilePos(TeacherFile)-1);
          write(TeacherFile,teacher);
        end;
    end;


  procedure createLogInFile;
      begin
        RESET(StudentFile); //reset file pointers for both files
        RESET(TeacherFile);
        REWRITE(LogInDetailsFile);
        //extract login information and student id and write it to a file
        while not EOF(StudentFile) do
          begin
            READ(StudentFile,student);
            //LogInDetails.PersonID := Format('%'+'5'+'s',[IntToStr(student.StudentID)]); // format the student id as a string
            LogInDetails.PersonID := IntToStr(student.StudentID);
            LogInDetails.Username := student.Uname;
            LogInDetails.Passwowrd := student.Pword;
            write(LogInDetailsFile,LogInDetails);
            numberDone := numberDone +1;
            percentComplete := numberDone/total;
          end;
        while not EOF(TeacherFile) do
          begin
            //extract login information and student id and write it to a file
            READ(TeacherFile,teacher);
            LogInDetails.PersonID := teacher.teacherID;
            LogInDetails.Username := teacher.Uname;
            LogInDetails.Passwowrd := teacher.Pword;
            write(LogInDetailsFile,LogInDetails);
            numberDone := numberDone +1;
            percentComplete := numberDone/total;
          end;

      end;


  PROCEDURE createSubjects;
    // create a constant array of all subjects and the subjects' id
    const subjID : ARRAY[0..20] OF STRING[3] = ('Cs','Ma','Mu','Enl','Gg','Ch','Ph','Bi','DT','Dr',
                                                'Lf','Rpe','Fr','Hi','Gm','Bs','Ar','Py','Pe','Sp','So');
          subjNm : ARRAY[0..20] OF STRING[20] = ('Computer Science','Maths','Music','English','Geography','Chemistry','Physics','Biology','Design Technology','Drama',
                                                'Life Skills','Religion, Philosophy & Ethics','French','History','German','Business Studies','Art','Physcology','Physical Education','Spanish','Sociology');
    var i : LONGINT;
    begin
      //clear subject file
      REWRITE(SubjectFile);
      //for every subject write subject name and id to a file
      for i := 0 TO 20 do
        begin
          numberDone := numberDone +1;
          percentComplete := numberDone / total;
          with subject do
            begin
              subjectID := subjID[i];
              SubjectName := subjNm[i];
            end;
            WRITE(SubjectFile, subject);
          end;
      end;

  PROCEDURE createClasses;
    //create arrays of all classes
    const yNineClassArray : ARRAY[0..43] OF STRING = ('9AT1/Ch', '9AT2/Ch', '9AT1/Bi', '9AT2/Bi', '9AT1/Ph', '9AT2/Ph', '9AAX/Ma', '9AAY/Ma', '9AAX/Enl', '9AAY/Enl', '9AAX/Lf', '9AAY/Lf',
          '9AAX/RPE', '9AAY/RPE', '9AP1/Pe', '9AP2/Pe', '9BT1/Ch', '9BT2/Ch', '9BT1/Bi', '9BT2/Cp', '9BT1/Ph', '9BT2/Ph',
          '9BAX/Ma', '9BAY/Ma', '9BAX/Enl', '9BAY/Enl', '9BAX/Lf', '9BAY/Lf', '9BAX/RPE', '9BAY/RPE', '9BP1/Pe', '9BP2/Pe', '9B/Fr1', '9B/Sp1', '9B/Gg1', '9B/Hi1', '9C/Dr1', '9C/Ar1', '9C/Py1',
          '9C/Dt1', '9D/So1', '9D/Bs1', '9D/Mu1', '9D/Gm1');
          yTwelveClassArray : ARRAY[0..6] OF STRING = ('12A/Ph1','12A/Py1','12B/Ph1','12C/Cp1','12C/Py1','12D/Mu1','12D/Cp1');
      VAR i : LONGINT;
          classArray : ARRAY[0..50] OF classRecord;
      begin
        rewrite(classFile);
        //for every year 9 class
        for i := 0 TO 43 DO
          begin
            numberDone := numberDone + 1;
            percentComplete := numberDone/total;
            //set year 9 class data
            sClass.ClassID := yNineClassArray[i];
            sClass.year := 9;
            sClass.NoOfStudents := 0;
            //generate the class id
            val(yNineClassArray[i][8],empty,ErrCode);
            if ErrCode <> 0 THEN
              begin
                sClass.subjectID := yNineClassArray[i][6]+yNineClassArray[i][7]+yNineClassArray[i][8];
                val(sClass.subjectID[1],empty,ErrCode);
                if ErrCode = 0 THEN
                  begin
                    sClass.subjectid := yNineClassArray[i][4]+yNineClassArray[i][5];
                  end;
              end
            else
              sClass.subjectID := yNineClassArray[i][6]+yNineClassArray[i][7];
            write(classFile, sClass);
            //delay(100);
          end;
        //generate year 12 classes
        for i := 0 TO 6 DO
          begin
            numberDone:= numberDone +1;
            percentComplete := numberDone/total;
            sClass.ClassId := yTwelveClassArray[i];
            sClass.year := 12;
            sClass.NoOfStudents := 0;
            sClass.subjectID := yTwelveClassArray[i][5]+yTwelveClassArray[i][6];
            write(classFile, sClass);
          end;
        reset(classFile);
        for i := 0 to 50 do
        begin
          READ(classFile, classArray[i]);
          classIDArray[i] := classArray[i].classID;
        end;
      end;

  procedure addRecordsStudentClassResolver(start, noOfAviablableClasses, maxStudents, ClasesToSortInto, year : LONGINT);
    const yNineClassArray : ARRAY[0..43] OF STRING = ('9AT1/Ch', '9AT2/Ch', '9AT1/Bi', '9AT2/Bi', '9AT1/Ph', '9AT2/Ph', '9AAX/Ma', '9AAY/Ma', '9AAX/Enl', '9AAY/Enl', '9AAX/Lf', '9AAY/Lf',
          '9AAX/RPE', '9AAY/RPE', '9AP1/Pe', '9AP2/Pe', '9BT1/Ch', '9BT2/Ch', '9BT1/Bi', '9BT2/Cp', '9BT1/Ph', '9BT2/Ph',
          '9BAX/Ma', '9BAY/Ma', '9BAX/Enl', '9BAY/Enl', '9BAX/Lf', '9BAY/Lf', '9BAX/RPE', '9BAY/RPE', '9BP1/Pe', '9BP2/Pe', '9B/Fr1', '9B/Sp1', '9B/Gg1', '9B/Hi1', '9C/Dr1', '9C/Ar1', '9C/Py1',
          '9C/Dt1', '9D/So1', '9D/Bs1', '9D/Mu1', '9D/Gm1');
          yTwelveClassArray : ARRAY[0..6] OF STRING = ('12A/Ph1','12A/Py1','12B/Ph1','12C/Cp1','12C/Py1','12D/Mu1','12D/Cp1');
    VAR startPoint, randomChoiceClass, i,d,l : LONGINT;
        returnArray : ARRAY[0..50] OF LONGINT;
    begin
      RESET(classFile);
      d := 0;
      repeat
        d := d + 1;
        randomChoiceClass := RANDOM(noOfAviablableClasses);  //randomly picks classes from the number of available class that student can be in
        if year = 9 THEN
          Search.SearchFunctions('L',0,50,yNineClassArray[start+randomChoiceClass],classIDArray,returnArray,empty) //checks the year 9 to find the class chosen
        else if year = 12 THEN
            Search.SearchFunctions('L',0,50,yTwelveClassArray[start+randomChoiceClass],classIDArray,returnArray,empty) //checks the year 12 to find the class chosen
        else
          DisplayErrorScrn.ErrScr;
        SEEK(classFile, returnArray[0]); //find the class in the file
        read(classFile, sClass);
        if d > 10000 THEN
          begin
            readln;
          end;
        until sClass.NoOfStudents < maxStudents; //only exit if there is a place for the student in that class
      l := 0;
      startPoint := returnArray[0];
      for l := 0 to (ClasesToSortInto * 2) -1 do //for every class connceted to that one class
        begin
          if year = 9 THEN
            studentClassResolver.classID := yNineClassArray[start+randomChoiceClass+l]
          else if year = 12 THEN
              studentClassResolver.classID := yTwelveClassArray[start+randomChoiceClass+l]
          else
            DisplayErrorScrn.ErrScr;
          write(studentClassResolverFile, studentClassResolver); //write each student and the class to the resolver file
          //update number of students in that class
          SEEK(classFile, startPoint + l);
          read(classFile, sClass);
          SEEK(classFile, FilePos(classFile)-1);
          sClass.NoOfStudents := sClass.NoOfStudents + 1;
          write(classFile, sClass);
          l := l + 1;
        end;
    end;

  procedure createClassStudentResolver;
    const yNineClassArray : ARRAY[0..43] OF STRING = ('9AT1/Ch', '9AT2/Ch', '9AT1/Bi', '9AT2/Bi', '9AT1/Ph', '9AT2/Ph', '9AAX/Ma', '9AAY/Ma', '9AAX/Enl', '9AAY/Enl', '9AAX/Lf', '9AAY/Lf',
          '9AAX/RPE', '9AAY/RPE', '9AP1/Pe', '9AP2/Pe', '9BT1/Ch', '9BT2/Ch', '9BT1/Bi', '9BT2/Cp', '9BT1/Ph', '9BT2/Ph',
          '9BAX/Ma', '9BAY/Ma', '9BAX/Enl', '9BAY/Enl', '9BAX/Lf', '9BAY/Lf', '9BAX/RPE', '9BAY/RPE', '9BP1/Pe', '9BP2/Pe', '9B/Fr1', '9B/Sp1', '9B/Gg1', '9B/Hi1', '9C/Dr1', '9C/Ar1', '9C/Py1',
          '9C/Dt1', '9D/So1', '9D/Bs1', '9D/Mu1', '9D/Gm1');
          yTwelveClassArray : ARRAY[0..6] OF STRING = ('12A/Ph1','12A/Py1','12B/Ph1','12C/Cp1','12C/Py1','12D/Mu1','12D/Cp1');
    var returnArray : ARRAY[0..51] OF LONGINT;
        studentYear,a, d, i, startPoint, noOfAlevels, noTakingFourAlevels, randClassNo, randomSide, numberInASide, numberInBSide, randomChoiceClass : LONGINT;
        oldClass, newClass : STRING;

    begin
      RESET(StudentFile);
      RESET(classFile);
      rewrite(studentClassResolverFile);
      //keep track of how many students on each side of the year
      numberInASide := 0;
      numberInBSide := 0;
      randomSide := RANDOM(2);
      noTakingFourAlevels := 0;
      while not(eof(StudentFile)) do //for every student
        begin
          numberDone := numberDone+1;
          percentComplete := numberDone/total;
          READ(StudentFile,student); //get the student data
          studentClassResolver.studentID := student.StudentID;
          if student.year = 9 THEN
            begin
              //pick a random side without overflowing one side
              if (numberInASide < 60) AND (numberInBSide < 60) THEN
                randomSide := RANDOM(2)
              else if (numberInASide < 60) THEN
                randomSide := 0
              else if (numberInBSide < 60) THEN
                randomSide := 1;
              if randomSide = 0 THEN //a or b side
                begin
                    //put students in each set of classes
                    numberInASide := numberInASide + 1;
                    //Science
                    addRecordsStudentClassResolver(0, 2, 30, 3, 9);
                    //Maths
                    addRecordsStudentClassResolver(6, 2, 30, 1, 9);
                    //Englishs
                    addRecordsStudentClassResolver(8, 2, 30, 3, 9);
                    //Pe
                    addRecordsStudentClassResolver(14, 2, 30, 1, 9);
                end
                else if randomSide = 1 THEN //a or b side
                  begin
                    //Science
                    numberInBSide := numberInBSide + 1;
                    addRecordsStudentClassResolver(16, 2, 30, 3, 9);
                    //Maths
                    addRecordsStudentClassResolver(22, 2, 30, 1, 9);
                    //Englishs
                    addRecordsStudentClassResolver(24, 2, 30, 3, 9);
                    //Pe
                    addRecordsStudentClassResolver(30, 2, 30, 1, 9);
                end
                else
                  begin
                    //error catching for random side assignment
                    writeln('A: ',numberInASide, '  B: ',numberInBSide);
                    Delay(3000);
                    DisplayErrorScrn.ErrScr;
                  end;
              //randomly pick the optional subjects
              for a := 0 to 8 do
                begin
                  addRecordsStudentClassResolver(32 + a, 4, 30, 1, 9);
                  a := a + 3;
                end;
            end
          else if (student.year = 12) THEN // year 12
            begin
              if noTakingFourAlevels < 5 THEN
                noOfAlevels := RANDOM(10);
              if noOfAlevels = 0 THEN //taking 4 a lvels
                begin
                  noTakingFourAlevels := noTakingFourAlevels + 1;
                  //block a
                  addRecordsStudentClassResolver(0, 2, 20, 1, 12);

                  //block b
                  addRecordsStudentClassResolver(2, 1, 5, 1, 12);


                  //block c
                  addRecordsStudentClassResolver(3, 2, 20, 1, 12);


                  //block d
                  addRecordsStudentClassResolver(5, 2, 20, 1, 12);
                end
              else
                begin
                  //block a
                  addRecordsStudentClassResolver(0, 2, 20, 1, 12);

                  //block c
                  addRecordsStudentClassResolver(3, 2, 20, 1, 12);


                  //block d
                  addRecordsStudentClassResolver(5, 2, 20, 1, 12);

                end;
            end;
        end;
    end;

  PROCEDURE assignTeacherToClass;
    begin
      reset(classFile);
      reset(teacherfile);
      REWRITE(teacherClassResolverFile);
      while not(eof(classFile)) DO //for each teacher
        begin
          numberDone := numberDone+1;
          percentComplete := numberDone / total;
          //assign one teacher per class
          read(classFile,sClass);
          read(teacherfile, teacher);
          teacherClassResolver.teacherID := teacher.teacherID;
          teacherClassResolver.classID := sClass.classId;
          write(teacherClassResolverFile,teacherClassResolver);
        end;
    end;

  PROCEDURE assignTeacherToSubject;
    var a, b : LONGINT;
    begin
      RESET(TeacherFile);
      reset(classFile);
      REWRITE(teacherSubjectResolverFile);
      while not EOF(TeacherFile) DO
        begin
          numberDone := numberDone+ 1;
          percentComplete := numberDone / total;
          read(TeacherFile,teacher);
          read(classFile,sClass);
          //find the class the teacher teaches and gets the subject id of that class and puts it in a resolver file
          teacherSubjectResolver.teacherId := teacher.teacherID;
          teacherSubjectResolver.subjectId := sClass.subjectID;
          write(teacherSubjectResolverFile, teacherSubjectResolver);
        end;
      end;






  begin
    //generates a random seed
    randomize;
    //run each procedure
    initialiseFiles;
    loading.startLoading('P',percentComplete);
    CreateTimetable;
    addForms;
    addStudents;
    addTeachers;
    createSubjects;
    createClasses;
    createClassStudentResolver;
    assignTeacherToClass;
    assignTeacherToSubject;
    createRegisters;
    createLogInFile;
    closeAllFiles;
    loading.EndLoading;
    readln;
  end.
