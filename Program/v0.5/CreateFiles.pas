PROGRAM CraeteFiles;
  uses crt, sysutils, search,sorting, loading, DisplayErrorScrn;

  type
    TimeTableRecord = RECORD
                          Day : LONGINT;
                          LessonNo : LONGINT;
                          ClassID : STRING[8];
                        end;
    FormRecord = RECORD
                          Form : STRING[5];
                        end;


    StudentsRecord = RECORD
                          StudentID : LONGINT;
                          FName : STRING[20];
                          SName : String[20];
                          Year : LONGINT;
                          Form : STRING[5];
                          Uname : String[40];
                          Pword : String[20];
                          Attendance : real;
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
                          SubjectID : STRING[2];
                          SubjectName : STRING[20];
                        end;

    studentRegisterMarkRecord = RECORD
                          studentID : LONGINT;
                          registerMark : BOOLEAN;
                        end;

    registerRecord = RECORD
                          RegisterID : STRING[17];
                          LessonNo : LONGINT;
                          Date : TDateTime;
                          ClassID : STRING[6];
                          RegisterMarks : ARRAY[0..50] OF studentRegisterMarkRecord;
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
                          ClassID : STRING[6];
                        end;

  VAR
    numberDone, total : LONGINT;

    TimeTable : TimeTableRecord;
    TimeTableTextFile : TextFile;
    TimeTableFile : FILE OF TimeTableRecord;
    TimeTableInfoFromFile : STRING;

    FileFormFromFile : TextFile;
    Form : FormRecord;
    FormFile : FILE OF FormRecord;

    Register : registerRecord;
    studentRegisterMark : studentRegisterMarkRecord;
    RegisterFile : File OF registerRecord;

    StudentFName : STRING;
    StudentFNameFile : TextFile;
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

    empty : LONGINT;
    percentDone : REAL;



  procedure initialiseFiles;
    begin
      percentDone := 0.0;
      total := 0;
      ASSIGN(TimeTableTextFile,'C:\ComputerScienceCoursework\Program\files\TimeTableText.txt');
      ASSIGN(TimeTableFile,'C:\ComputerScienceCoursework\Program\files\TimeTable.dta');

      {ASSIGN(FileFormFromFile,'C:\ComputerScienceCoursework\Program\files\TForms.txt');
      ASSIGN(FormFile,'C:\ComputerScienceCoursework\Program\files\Forms.dta');
      total := total + 20;

      ASSIGN(RegisterFile,'C:\ComputerScienceCoursework\Program\files\Registers.dta');
      total := total + 1500;
      }
      ASSIGN(StudentFNameFile,'C:\ComputerScienceCoursework\Program\files\Names.txt');
      ASSIGN(StudentFile,'C:\ComputerScienceCoursework\Program\files\Students.dta');
      total := total + 900;
       {
      ASSIGN(TeacherFileFromFile,'C:\ComputerScienceCoursework\Program\files\Tnames.txt');
      ASSIGN(TeacherFile,'C:\ComputerScienceCoursework\Program\files\Teachers.dta');
      total := total + 100;
      }
      ASSIGN(classFile,'C:\ComputerScienceCoursework\Program\files\classes.dta');
      total := total + 30;

      ASSIGN(subjectFile,'C:\ComputerScienceCoursework\Program\files\subjects.dta');
      total := total + 10;

      ASSIGN(studentClassResolverFile,'C:\ComputerScienceCoursework\Program\files\studentClassResolver.dta');
      total := total + 900;
      {
      ASSIGN(teacherSubjectResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherSubjectResolver.dta');
      total:= total + 100;

      ASSIGN(teacherClassResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherClassResolver.dta');
      total := total + 100;}
    end;

  procedure CreateTimeTable;
    begin
      reset(TimeTableTextFile);
      rewrite(TimeTableFile);
      while not EOF(TimeTableTextFile) do
        begin
          readln(TimeTableTextFile,TimeTableInfoFromFile);
          TimeTable.ClassId := TimeTableInfoFromFile;
          repeat
            readln(TimeTableTextFile,TimeTableInfoFromFile);
            //writeln(TimeTableInfoFromFile);
            TimeTable.LessonNo := StrToInt(TimeTableInfoFromFile);
            readln(TimeTableTextFile,TimeTableInfoFromFile);
            TimeTable.Day := StrToInt(TimeTableInfoFromFile);
            readln(TimeTableTextFile,TimeTableInfoFromFile);
            //writeln(TimeTableInfoFromFile);
            try
              write(TimeTableFile,TimeTable);
            finally
            end;

          until TimeTableInfoFromFile = 'Q';
          //readln;
        end;
    end;

  procedure addForms;
    var formLn : STRING[5];
      i : LONGINT;
    begin
      RESET(FileFormFromFile);
      REWRITE(FormFile);
      for i := 0 to 19 DO
        begin
          numberDone := numberDone + 1;
          percentDone := numberDone / total;
          //Delay(1);
          READLN(FileFormFromFile,formLn);
          form.form := formLn;
          WRITE(FormFile,form);
        end;
      end;

  procedure createRegisters;
    var days, i : LONGINT;
      startDate, endDate, date : TDateTime;
      dateArray : ARRAY[0..9] OF TDateTime;
      classArray : ARRAY[0..30] OF classRecord;
      classIdArray : ARRAY[0..30] OF STRING;
      returnArray : ARRAY[0..2700] OF LONGINT;
      studentClassIdArray : ARRAY[0..2700] OF STRING;
      formArray : ARRAY[0..19] OF formRecord;
      d,r,randomNumber,randomMark : longint;
      dayName : LONGINT;
    begin
      reset(classFile);
      reset(formFile);
      reset(studentClassResolverFile);
      REWRITE(RegisterFile);
      reset(RegisterFile);
      for a := 0 to 30 DO
        begin
          read(classFile, classArray[a]);
          classIdArray[a] := classArray[a].classId;
        end;

      for a := 0 TO 19 DO
        READ(FormFile, formArray[a]);

      for a := 0 to 2700 DO
        begin
          read(studentClassResolverFile, studentClassResolver);
          studentClassIdArray[a] := studentClassResolver.classId;
          returnArray[a] := -1;
        end;

      days := 0;
      startDate := StrToDateTime('13/09/2024');
      date := startDate;
      while days <= 10 DO
        begin
        if (DayOfWeek(Date) = 7) OR (DayOfWeek(Date) = 1) THEN
          begin
            date := date + 1;
          end
          else
            begin
              dateArray[days]:=date;
              date := date + 1;
              days := days + 1;
            end;
      end;
      for d := 0 TO 9 DO
        begin
          for c := 0 TO 30 DO
            begin
              for r := 1 TO 5 DO
                begin
                  studentRegisterMark.studentId := -1;
                  studentRegisterMark.registerMark := true;

                  for a := 0 to 50 DO
                    register.registerMarks[a] := studentRegisterMark;

                  numberDone := numberDone + 1;
                  percentDone := numberDone / total;
                  i := 0;
                  register.lessonNo := r;
                  register.date := dateArray[d];
                  register.classId := classIdArray[c];
                  Search.SearchFunctions('L',0,2700,classIdArray[c],studentClassIdArray,returnArray,empty);

                  while returnArray[i] <> -1 Do
                    begin
                      SEEK(studentClassResolverFile,returnArray[i]);
                      read(studentClassResolverFile, studentClassResolver);
                      studentRegisterMark.studentID := studentClassResolver.studentID;
                      randomNumber := RANDOM(10);
                      if randomNumber = 9 THEN
                        studentRegisterMark.registerMark := false
                      else
                        studentRegisterMark.registerMark := true;
                      returnArray[i] := -1;
                      register.registerMarks[i] := studentRegisterMark;
                      i := i + 1;
                    end;
                  if r = 4 THEN
                    register.isOfstedRegister := true
                  else
                    register.isOfstedRegister := false;
                  register.registerID := IntToStr(r) + DateToStr(dateArray[d]) + classIdArray[c];
                  WRITE(RegisterFile, register);

                end;
            end;
        end;
    end;


  procedure addStudents;
    var i : LONGINT;
      ffname, fsname, fyear, fform, fattendance : STRING;
    begin
      i := 0;
      RESET(StudentFNameFile);
      REWRITE(StudentFile);
      writeln('a');
      for i := 0 to 119 DO
        begin
          Student.StudentID := i;
          READLN(StudentFNameFile, student.fname);
          READLN(StudentFnameFile, student.sname);
          student.year := 9;
          student.uname := student.fname+student.sname;
          student.pword := 'ABC123';
          student.Attendance := 100;
          write(StudentFile,student);
        end;
      for i := 120 to 172 DO
        begin
          Student.StudentID := i;
          READLN(StudentFNameFile, student.fname);
          READLN(StudentFnameFile, student.sname);
          student.year := 12;
          student.uname := student.fname+student.sname;
          student.pword := 'ABC123';
          student.Attendance := 100;
          write(StudentFile,student);
        end;
        writeln('end student');
    end;

  procedure addTeachers;
    var i : LONGINT;
      ffname, fsname, fform : STRING;
    begin
      reset(TeacherFileFromFile);
      rewrite(TeacherFile);
      while not EOF(TeacherFileFromFile) DO
        begin
          numberDone := numberDone + 1;
          percentDone := numberDone / total;
          //Delay(1);
          READLN(TeacherFileFromFile, ffname);
          READLN(TeacherFileFromFile, fsname);
          READLN(TeacherFileFromFile, fform);
          with teacher do
            begin
              TeacherID := ffname[1]+fsname[1]+fsname[2];
              Fname := ffname;
              Sname := fsname;
              uname := ffname + fsname;
              pword := 'ABC123';
            end;
          if fform = 'nil' THEN
            begin
            teacher.form := '';
            end
          else
            teacher.form := fform;
          WRITE(TeacherFile, teacher);
          end;
        end;

    PROCEDURE createSubjects;
      const subjID : ARRAY[0..18] OF STRING[3] = ('Cs','Ma','Mu','Enl','Gg','Ch','Ph','Bi','DT','Dr',
                                                  'Lf','Rpe','Fr','Hi','Gm','Bs','Ar','Py','Pe');
            subjNm : ARRAY[0..18] OF STRING[20] = ('Computer Science','Maths','Music','English','Geography','Chemistry','Physics','Biology','Design Technology','Drama',
                                                  'Life Skills','Religion, Philosophy & Ethics','French','History','German','Business Studies','Art','Physcology','Physical Education');
      var i : LONGINT;
      begin
        reset(SubjectFile);
        REWRITE(SubjectFile);
        for i := 0 TO 9 do
          begin
            numberDone := numberDone +1;
            percentDone := numberDone / total;
            //Delay(1);
            with subject do
              begin
                subjectID := subjID[i];
                SubjectName := subjNm[i];
              end;
              WRITE(SubjectFile, subject);
            end;
        end;

    PROCEDURE createClasses;
    const yNineClassArray : ARRAY[0..43] OF STRING = ('9AT1/Ch', '9AT2/Ch', '9AT1/Bi', '9AT2/Bi', '9AT1/Ph', '9AT2/Ph', '9AAX/Ma', '9AAX/Enl', '9AAX/Lf', '9AAX/RPE', '9AAY/Ma',
          '9AAY/Enl', '9AAY/Lf', '9AAY/RPE', '9AP1/Pe', '9AP2/Pe', '9BT1/Ch', '9BT2/Ch', '9BT1/Bi', '9BT2/Cp', '9BT1/Ph', '9BT2/Ph',
          '9BAX/Ma', '9BAX/Enl', '9BAX/Lf', '9BAX/RPE', '9BAY/Ma', '9BAY/Enl', '9BAY/Lf', '9BAY/RPE', '9BP1/Pe', '9BP2/Pe', '9B/Fr1', '9B/Dt1', '9B/Gg1', '9B/Hi1', '9C/Dr1', '9C/Ar1', '9C/Py1',
          '9C/Dt1', '9D/Cp1', '9D/Bs1', '9D/Mu1', '9D/Gm1');
          yTwelveClassArray : ARRAY[0..7] OF STRING = ('12C/Gg1','12D/Mu1','12C/Cp1','12D/Cp1','12A/Py1','12C/Py1','12A/Ph1','12B/Ph1');
      VAR i : LONGINT;
      begin
        rewrite(classFile);

        for i := 0 TO 44 DO
          begin
            sClass.ClassID := yNineClassArray[i];
            sClass.year := 9;
            sClass.NoOfStudents := 0;
            write(classFile, sClass);
          end;
        for i := 0 TO 8 DO
          begin
            sClass.ClassId := yTwelveClassArray[i];
            sClass.year := 12;
            sClass.NoOfStudents := 0;
            write(classFile, sClass);
          end;
      end;

  procedure createClassStudentResolver;
    const yNineClassArray : ARRAY[0..43] OF STRING = ('9AT1/Ch', '9AT2/Ch', '9AT1/Bi', '9AT2/Bi', '9AT1/Ph', '9AT2/Ph', '9AAX/Ma', '9AAY/Ma', '9AAX/Enl', '9AAY/Enl', '9AAX/Lf', '9AAY/Lf',
          '9AAX/RPE', '9AAY/RPE', '9AP1/Pe', '9AP2/Pe', '9BT1/Ch', '9BT2/Ch', '9BT1/Bi', '9BT2/Cp', '9BT1/Ph', '9BT2/Ph',
          '9BAX/Ma', '9BAY/Ma', '9BAX/Enl', '9BAY/Enl', '9BAX/Lf', '9BAY/Lf', '9BAX/RPE', '9BAY/RPE', '9BP1/Pe', '9BP2/Pe', '9B/Fr1', '9B/Dt1', '9B/Gg1', '9B/Hi1', '9C/Dr1', '9C/Ar1', '9C/Py1',
          '9C/Dt1', '9D/Cp1', '9D/Bs1', '9D/Mu1', '9D/Gm1');
          yTwelveClassArray : ARRAY[0..7] OF STRING = ('12A/Ph1','12A/Py1','12B/Ph1','12C/Gg1','12C/Cp1','12C/Py1','12D/Mu1','12D/Cp1');
    var classArray : ARRAY[0..50] OF classRecord;
        classIDArray : ARRAY[0..50] OF STRING;
        returnArray : ARRAY[0..50] OF LONGINT;
        yearArray : ARRAY[0..30] OF LONGINT;
        stringArray : ARRAY[0..30] OF STRING;
        studentYear, d, i, startPoint, randClassNo,randomSide, numberInASide, numberInBSide, randomChoiceClass : LONGINT;
        oldClass, newClass : STRING;

    begin
      RESET(StudentFile);
      RESET(classFile);
      rewrite(studentClassResolverFile);
      for i := 0 to 50 do
        begin
          READ(classFile, classArray[i]);
          classIDArray[i] := classArray[i].classID;
        end;
      numberInASide := 0;
      numberInBSide := 0;
      randomSide := RANDOM(2);
      while not(eof(StudentFile)) do
        begin
          READ(StudentFile,student);
          studentClassResolver.studentID := student.StudentID;
          if student.year = 9 THEN
            begin
              if (numberInASide < 60) AND (numberInBSide < 60) THEN
                randomSide := RANDOM(2)
              else if (numberInASide < 60) THEN
                randomSide := 0
              else if (numberInBSide < 60) THEN
                randomSide := 1;
              if randomSide = 0 THEN //a or b side
                begin
                    numberInASide := numberInASide + 1;
                    //Science
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[0+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    a := 0;
                    startPoint := returnArray[0];
                    while a <= 4 do
                      begin
                        studentClassResolver.classID := yNineClassArray[0+randomChoiceClass+a];
                        write(studentClassResolverFile, studentClassResolver);
                        SEEK(classFile, startPoint + a);
                        read(classFile, sClass);
                        SEEK(classFile, FilePos(classFile)-1);
                        sClass.NoOfStudents := sClass.NoOfStudents + 1;
                        write(classFile, sClass);
                        a := a + 2;
                      end;
                    //Maths
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[6+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    studentClassResolver.classID := yNineClassArray[6+randomChoiceClass];
                    write(studentClassResolverFile,studentClassResolver);
                    SEEK(classFile, FilePos(classFile)-1);
                    read(classFile, sClass);
                    SEEK(classFile, FilePos(classFile)-1);
                    sClass.NoOfStudents := sClass.NoOfStudents + 1;
                    write(classFile, sClass);
                    //Englishs
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[8+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    a := 0;
                    startPoint := returnArray[0];
                    while a <= 2 do
                      begin
                        studentClassResolver.classID := yNineClassArray[8+randomChoiceClass+a];
                        write(studentClassResolverFile, studentClassResolver);
                        SEEK(classFile, startPoint + a);
                        read(classFile, sClass);
                        SEEK(classFile, FilePos(classFile)-1);
                        sClass.NoOfStudents := sClass.NoOfStudents + 1;
                        write(classFile, sClass);
                        a := a + 1;
                      end;
                    //Pe
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[14+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    studentClassResolver.classID := yNineClassArray[14+randomChoiceClass];
                    write(studentClassResolverFile,studentClassResolver);
                    SEEK(classFile, FilePos(classFile)-1);
                    read(classFile, sClass);
                    SEEK(classFile, FilePos(classFile)-1);
                    sClass.NoOfStudents := sClass.NoOfStudents + 1;
                    write(classFile, sClass);
                end
                else if randomSide = 1 THEN //a or b side
                  begin
                    //Science
                    numberInBSide := numberInBSide + 1;
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[16+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    a := 0;
                    startPoint := returnArray[0];
                    while a <= 4 do
                      begin
                        studentClassResolver.classID := yNineClassArray[16+randomChoiceClass+a];
                        write(studentClassResolverFile, studentClassResolver);
                        SEEK(classFile, startPoint + a);
                        read(classFile, sClass);
                        SEEK(classFile, FilePos(classFile)-1);
                        sClass.NoOfStudents := sClass.NoOfStudents + 1;
                        write(classFile, sClass);
                        a := a + 2;
                      end;
                    //Maths
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[22+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    studentClassResolver.classID := yNineClassArray[22+randomChoiceClass];
                    write(studentClassResolverFile,studentClassResolver);
                    SEEK(classFile, FilePos(classFile)-1);
                    read(classFile, sClass);
                    SEEK(classFile, FilePos(classFile)-1);
                    sClass.NoOfStudents := sClass.NoOfStudents + 1;
                    write(classFile, sClass);
                    //Englishs
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[24+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    a := 0;
                    startPoint := returnArray[0];
                    while a <= 2 do
                      begin
                        studentClassResolver.classID := yNineClassArray[24+randomChoiceClass+a];
                        write(studentClassResolverFile, studentClassResolver);
                        SEEK(classFile, startPoint + a);
                        read(classFile, sClass);
                        SEEK(classFile, FilePos(classFile)-1);
                        sClass.NoOfStudents := sClass.NoOfStudents + 1;
                        write(classFile, sClass);
                        a := a + 1;
                      end;
                    //Pe
                    repeat
                      randomChoiceClass := RANDOM(2);
                      Search.SearchFunctions('L',0,50,yNineClassArray[30+randomChoiceClass],classIDArray,returnArray,empty);
                      SEEK(classFile, returnArray[0]);
                      read(classFile, sClass);
                    until sClass.NoOfStudents < 30;
                    studentClassResolver.classID := yNineClassArray[30+randomChoiceClass];
                    write(studentClassResolverFile,studentClassResolver);
                    SEEK(classFile, FilePos(classFile)-1);
                    read(classFile, sClass);
                    SEEK(classFile, FilePos(classFile)-1);
                    sClass.NoOfStudents := sClass.NoOfStudents + 1;
                    write(classFile, sClass);
                end
                else
                  begin
                    writeln('A: ',numberInASide, '  B: ',numberInBSide);
                    Delay(3000);
                    DisplayErrorScrn.ErrScr;
                  end;
              d:=0;
              for a := 0 to 8 do
                begin
                  repeat
                    d := d + 1;
                    if d > 100 then
                      begin
                        writeln;
                      end;
                    randomChoiceClass := RANDOM(4);
                    Search.SearchFunctions('L',0,50,yNineClassArray[32+a+randomChoiceClass],classIDArray,returnArray,empty);
                    SEEK(classFile, returnArray[0]);
                    read(classFile, sClass);
                  until sClass.NoOfStudents < 30;
                  d := 0;
                  studentClassResolver.classID := yNineClassArray[32+a+randomChoiceClass];
                  SEEK(classFile, FilePos(classFile)-1);
                  read(classFile, sClass);
                  SEEK(classFile, FilePos(classFile)-1);
                  sClass.NoOfStudents := sClass.NoOfStudents + 1;
                  write(classFile,sClass);
                  a := a + 3;
                end;
            end;
        end;
    end;

  PROCEDURE assignTeacherToSubject;
    var SubjectArray : ARRAY[0..9] OF subjectRecord;
    begin
      RESET(TeacherFile);
      reset(subjectFile);
      REWRITE(teacherSubjectResolverFile);
      for a := 0 TO 9 DO
          READ(subjectFile, subjectArray[a]);
      while not EOF(TeacherFile) DO
        begin
          numberDone := numberDone+ 1;
          percentDone := numberDone / total;
          //Delay(1);
          read(teacherfile,teacher);
          with teacherSubjectResolver DO
            begin
              teacherID := teacher.teacherID;
              subjectID := subjectArray[RANDOM(10)].subjectID;
            end;
          WRITE(teacherSubjectResolverFile, teacherSubjectResolver);
        end;
      end;

  PROCEDURE assignTeacherToClass;
    var classArray : ARRAY[0..30] OF classRecord;
      classIDArray : ARRAY[0..30] OF STRING;
      teachersIDArray : ARRAY[0..99] OF STRING;
      returnArray : ARRAY[0..99] OF LONGINT;
      teacherSubject : STRING;
      subjectArray : ARRAY[0..9] OF subjectRecord;
      subjectIdArray : ARRAY[0..99] OF STRING;
      i, noOfClass, randClassNo, noOfTeachersForSubject : LONGINT;
    begin
      RESET(classFile);
      RESET(teacherFile);
      RESET(subjectFile);
      reset(teacherSubjectResolverFile);
      REWRITE(teacherClassResolverFile);
      for a := 0 TO 9 DO
        begin
          READ(subjectFile, subjectArray[a]);
        end;
      for a := 0 TO 30 DO
        begin
          READ(classFile, classArray[a]);
          classIDArray[a] := classArray[a].subjectId;
          returnArray[a] := -1;
        end;
      for a := 0 TO 99 DO
          begin
            READ(teacherFile,teacher);
            teachersIDArray[a] := teacher.teacherID;
            READ(teacherSubjectResolverFile, teacherSubjectResolver);
            subjectIdArray[a] := teacherSubjectResolver.subjectId;

          end;
      RESET(teacherSubjectResolverFile);
      RESET(teacherFile);
      while not EOF(teacherFile) DO
        begin
          numberDone := numberDone + 1;
          percentDone := numberDone / total;
          //Delay(1);
          Read(teacherFile,teacher);
          teacherClassResolver.teacherId := teacher.teacherID;
          Search.SearchFunctions('L',0,99,teacher.teacherID,teachersIDArray,returnArray,empty);
          SEEK(teacherSubjectResolverFile,returnArray[0]);
          READ(teacherSubjectResolverFile, teacherSubjectResolver);
          teacherSubject := teacherSubjectResolver.subjectID;

          Search.SearchFunctions('L',0,99,teacherSubject,subjectIdArray,returnArray,empty);

          i := 0;
          noOfTeachersForSubject:=0;
          while returnArray[i] <> -1 DO
            begin
              noOfTeachersForSubject := noOfTeachersForSubject + 1;
              i := i +1;
            end;

          Search.SearchFunctions('L',0,30,teacherSubjectResolver.subjectID,classIDArray,returnArray,empty);
          i := 0;
          noOfClass := 0;
          while returnArray[i] <> -1 DO
            begin
              noOfClass := noOfClass + 1;
              i := i + 1;
            end;

          randClassNo := RANDOM(noOfClass);
          teacherClassResolver.classID := classArray[returnArray[randClassNo]].classID;
          WRITE(teacherClassResolverFile, teacherClassResolver);

         for a := 0 to 30 DO
          returnArray[a] := -1;
        end;
      end;




  begin
    randomize;
    initialiseFiles;
    CreateTimeTable;
    //loading.startLoading('P',percentDone);
    {addForms;}
    addStudents;
    {addTeachers;}
    writeln('start subj');
    createSubjects;
    writeln('end subj');
    writeln('start class');
    createClasses;
    writeln('end class');
    writeln('start resolver');
    createClassStudentResolver;
    {assignTeacherToSubject;
    assignTeacherToClass;
    createRegisters;}
    writeln('END!');
    readln;

  end.
