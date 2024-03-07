PROGRAM CraeteFiles;
  uses crt, sysutils, search,sorting, loading;

  type
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
                          ClassID : STRING[6];
                          Year : LONGINT;
                          subjectID : STRING[2];
                          NoOfStudents : LONGINT;
                        end;

    subjectRecord = RECORD
                          SubjectID : STRING[2];
                          SubjectName : STRING[20];
                        end;

    registerRecord = RECORD
                          RegisterID : STRING[13];
                          LessonNo : LONGINT;
                          Date : TDateTime;
                          ClassID : STRING[6];
                          RegisterMark : ARRAY[0..50,0..1] OF STRING[20];
                          isOfstedRegister : BOOLEAN;
                        end;

    studentClassResolverRecord = RECORD
                          StudentID : LONGINT;
                          ClassID : STRING[6];
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

    FileFormFromFile : TextFile;
    Form : FormRecord;
    FormFile : FILE OF FormRecord;

    Register : registerRecord;
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
      ASSIGN(FileFormFromFile,'C:\ComputerScienceCoursework\Program\files\TForms.txt');
      ASSIGN(FormFile,'C:\ComputerScienceCoursework\Program\files\Forms.dta');
      total := total + 20;

      ASSIGN(RegisterFile,'C:\ComputerScienceCoursework\Program\files\Registers.dta');
      total := total + 1500;

      ASSIGN(StudentFNameFile,'C:\ComputerScienceCoursework\Program\files\Names.txt');
      ASSIGN(StudentFile,'C:\ComputerScienceCoursework\Program\files\Students.dta');
      total := total + 900;

      ASSIGN(TeacherFileFromFile,'C:\ComputerScienceCoursework\Program\files\Tnames.txt');
      ASSIGN(TeacherFile,'C:\ComputerScienceCoursework\Program\files\Teachers.dta');
      total := total + 100;

      ASSIGN(classFile,'C:\ComputerScienceCoursework\Program\files\classes.dta');
      total := total + 30;

      ASSIGN(subjectFile,'C:\ComputerScienceCoursework\Program\files\subjects.dta');
      total := total + 10;

      ASSIGN(studentClassResolverFile,'C:\ComputerScienceCoursework\Program\files\studentClassResolver.dta');
      total := total + 900;

      ASSIGN(teacherSubjectResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherSubjectResolver.dta');
      total:= total + 100;

      ASSIGN(teacherClassResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherClassResolver.dta');
      total := total + 100;
    end;

  procedure addForms;
    var formLn : STRING;
      i : LONGINT;
    begin
      RESET(FileFormFromFile);
      REWRITE(FormFile);
      for i := 0 to 20 DO
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
      formArray : ARRAY[0..20] OF formRecord;
      d,r,randomNumber,randomMark : longint;
    begin
      reset(classFile);
      reset(formFile);
      reset(studentClassResolverFile);
      REWRITE(registerFile);
      for a := 0 to 30 DO
        begin
          read(classFile, classArray[a]);
          classIdArray[a] := classArray[a].classId;
        end;

      for a := 0 TO 20 DO
        READ(formFile, formArray[a]);

      for a := 0 to 2700 DO
        begin
          read(studentClassResolverFile, studentClassResolver);
          studentClassIdArray[a] := studentClassResolver.classId;
          returnArray[a] := -1;
        end;

      days := 0;
      startDate := StrToDateTime('13/09/2024');
      while days <= 10 DO
        begin
        if (LongDayNames[DayOfWeek(startDate)] <> 'Saturday') OR (LongDayNames[DayOfWeek(startDate)] <> 'Sunday') then
          begin
            date := startDate + 1;
            dateArray[days] := date;
            days := days + 1;
          end;
      end;
      for d := 0 TO 10 DO
        begin
          for c := 0 TO 30 DO
            begin
              for r := 1 TO 5 DO
                begin
                  numberDone := numberDone + 1;
                  percentDone := numberDone / total;
                  for a := 0 to 2700 DO
                    returnArray[a] := -1;
                  i := 0;
                  register.lessonNo := r;
                  register.date := dateArray[d];
                  register.classId := classIdArray[c];
                  Search.SearchFunctions('L',0,2700,classIdArray[c],studentClassIdArray,returnArray,empty);

                  while returnArray[i] <> -1 Do
                    begin
                      SEEK(studentClassResolverFile,returnArray[i]);
                      read(studentClassResolverFile, studentClassResolver);
                      register.RegisterMark[i,0] := IntToStr(studentClassResolver.studentID);
                      randomNumber := RANDOM(10);
                      if randomNumber = 10 THEN
                        randomMark := 0
                      else
                        randomMark := 1;
                      register.RegisterMark[i,1] := IntToStr(randomMark);
                      i := i + 1;
                    end;
                  if r = 4 THEN
                    register.isOfstedRegister := true
                  else
                    register.isOfstedRegister := false;
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
      while not EOF(StudentFNameFile) DO
        begin
          i := i +1;
          numberDone := numberDone + 1;
          percentDone := numberDone / total;
          //Delay(1);
          READLN(StudentFNameFile,ffname);
          READLN(StudentFnameFile, fsname);
          READLN(StudentFnameFile, fyear);
          READLN(StudentFnameFile, fform);
          READLN(StudentFnameFile, fattendance);
          with student DO
            begin
              StudentID := i;
              Fname := ffname;
              sname := fsname;
              year := StrToInt(fyear);
              form := fform;
              uname := fsname[1]+ffname;
              Pword := 'ABC123';
              attendance := StrToFloat(fattendance);
            end;
          WRITE(StudentFile, student);
        end;
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
      const subjID : ARRAY[0..9] OF STRING[2] = ('Cs','Ma','Mu','En','Gg','Ch','Ph','Bi','DT','Dr');
            subjNm : ARRAY[0..9] OF STRING[20] = ('Computer Science','Maths','Music','English','Geography','Chemistry','Physics','Biology','Design Technology','Drama');
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
      VAR i, randNum : LONGINT;
      randChar : CHAR;
      begin
        REWRITE(classFile);
        for i := 0 to 30 DO
          begin
          numberDone := numberDone + 1;
          percentDone := numberDone / total;
          //Delay(1);
          randNum := Random(7) + 7;
          randChar:= Chr(Random(4) + 65);
          Seek(SubjectFile,Random(5));
          READ(SubjectFile, subject);
          with sClass do
              begin
                ClassID :=  IntToStr(randNum) + randChar +'/'+subject.subjectID;
                SubjectID := subject.subjectID;
                year := randNum;
                NoOfStudents := 0;
              end;
          WRITE(classFile,sClass);
      end;
    end;

  procedure createClassStudentResolver;
    var classArray : ARRAY[0..30] OF classRecord;
        returnArray : ARRAY[0..30] OF LONGINT;
        yearArray : ARRAY[0..30] OF LONGINT;
        stringArray : ARRAY[0..30] OF STRING;
        studentYear, i, noOfClassInYear, randClassNo : LONGINT;
        oldClass, newClass : STRING;
    begin
      RESET(StudentFile);
      RESET(classFile);
      REWRITE(studentClassResolverFile);
      for i := 0 TO 30 DO
        begin
          READ(classFile, classArray[i]);
          yearArray[i] := classArray[i].year;
          returnArray[i] := -1;
        oldClass:= '-1';

        end;
          While NOT EOF(StudentFile) DO
            begin
              for a := 0 to 30 DO
                returnArray[a] := -1;
              READ(StudentFile, Student);
              studentYear := Student.Year;
              studentClassResolver.studentID := student.StudentID;
              numberDone := numberDone +1;
              percentDone := numberDone / total;
              //Delay(1);
              noOfClassInYear := 0;
              for a := 0 TO 30 DO
                  str(yearArray[a],stringArray[a]);
              Search.SearchFunctions('L',0,30,IntToStr(studentYear),stringArray,returnArray,empty);
              i := 0;
              while returnArray[i] <> -1 DO
                begin
                  i := i +1;
                  noOfClassInYear := noOfClassInYear +1;
                end;
              for b := 0 to noOfClassInYear DO
                begin
                  while (newClass = oldClass) AND (noOfClassInYear<>1) DO
                    begin
                      newClass := classArray[returnArray[b]].ClassID;
                    end;
                  studentClassResolver.classID := newClass;
                  for a := 0 to 30 DO
                    stringArray[a] := classArray[a].classId;
                  Search.SearchFunctions('L',0,30,studentClassResolver.classID,stringArray,returnArray,empty);
                  SEEK(ClassFile, returnArray[0]);
                  read(classfile, sClass);
                  sClass.noOfStudents := sClass.noOfStudents +1;
                  SEEK(classFile, FilePos(classFile)-1);
                  WRITE(classFile, sClass);
                  WRITE(StudentClassResolverFile,studentClassResolver);
                  oldClass := newClass;
                  newClass := '1';
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
    loading.startLoading('P',percentDone);
    addForms;
    addStudents;
    addTeachers;
    createSubjects;
    createClasses;
    createClassStudentResolver;
    assignTeacherToSubject;
    assignTeacherToClass;
    createRegisters;
    readln;

  end.
