program extractAllToTextFiles;
  uses crt, sysutils, attendancProcedures, classProcedures, LogInProcedures,
  registerProcedures, studentClassProcedures, studentProcedures, teacherProcedures,
  timeTableProcedures;

  type FormRecord = RECORD
                          FormID : STRING[5];
                          NumberInForm : LONGINT;
                        end;

        subjectRecord = RECORD
                          SubjectID : STRING[3];
                          SubjectName : STRING[20];
                        end;

        teacherClassResolverRecord = RECORD
                          TeacherID : STRING[3];
                          ClassID : STRING[8];
                        end;

        teacherSubjectResolverRecord = RECORD
                          TeacherID : STRING[3];
                          SubjectID : STRING[2];
                        end;

  var
    attendance : attendanceFile;
    sClass : classFile;
    login : logInFile;
    registerF : registerFile;
    studentClass : studentClassFile;
    student : StudentFile;
    teacher : TeacherFile;
    timetable : TimeTableFile;

    Form : FormRecord;
    FormFile : FILE OF FormRecord;

    subject : subjectRecord;
    subjectFile : FILE OF subjectRecord;

    teacherSubjectResolver : teacherSubjectResolverRecord;
    teacherSubjectResolverFile : FILE OF teacherSubjectResolverRecord;

    teacherClassResolver : teacherClassResolverRecord;
    teacherClassResolverFile : FILE OF teacherClassResolverRecord;

    dataTextFile : TextFile;

  begin
    attendance := attendanceFile.create;
    sClass := classFile.create;
    login := logInFile.create;
    registerF := registerFile.create;
    studentClass := studentClassFile.create;
    student := StudentFile.create;
    teacher := TeacherFile.create;
    timetable := TimeTableFile.create;

    {attendance.sort;
    sClass.sort;
    login.sort;
    registerF.sort;
    studentClass.sort;
    student.sort;
    teacher.sort;
    timetable.sort;
    }
    attendance.extractToTextFile;
    sClass.extractToTextFile;
    login.extractToTextFile;
    registerF.extractToTextFile;
    studentClass.extractToTextFile;
    student.extractToTextFile;
    teacher.extractToTextFile;
    timetable.extractToTextFile;

    attendance.free;
    sClass.free;
    login.free;
    registerF.free;
    studentClass.free;
    student.free;
    teacher.free;
    timetable.free;

    ASSIGN(FormFile,'C:\ComputerScienceCoursework\Program\files\forms.dta');
    ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outForms.txt');
    rewrite(dataTextFile);
    reset(formFile);
    while not eof(FormFile) do
      begin
        read(FormFile, Form);
        writeln(dataTextFile, Form.FormID);
        writeln(dataTextFile, Form.NumberInForm);
        writeln(dataTextFile,'');
      end;
    close(dataTextFile);

    ASSIGN(subjectFile,'C:\ComputerScienceCoursework\Program\files\subjects.dta');
    ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outSubjects.txt');
    rewrite(dataTextFile);
    reset(subjectFile);
    while not eof(subjectFile) do
      begin
        read(subjectFile, subject);
        writeln(dataTextFile, subject.SubjectID);
        writeln(dataTextFile, subject.SubjectName);
        writeln(dataTextFile,'');
      end;
    close(dataTextFile);

    ASSIGN(teacherClassResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherClassResolver.dta');
    ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outTeacherClass.txt');
    rewrite(dataTextFile);
    reset(teacherClassResolverFile);
    while not eof(teacherClassResolverFile) do
      begin
        read(teacherClassResolverFile, teacherClassResolver);
        writeln(dataTextFile, teacherClassResolver.TeacherID);
        writeln(dataTextFile, teacherClassResolver.ClassID);
        writeln(dataTextFile,'');
      end;
    close(dataTextFile);

    ASSIGN(teacherSubjectResolverFile,'C:\ComputerScienceCoursework\Program\files\teacherSubjectResolver.dta');
    ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outTeacherSubject.txt');
    rewrite(dataTextFile);
    reset(teacherSubjectResolverFile);
    while not eof(teacherSubjectResolverFile) do
      begin
        read(teacherSubjectResolverFile, teacherSubjectResolver);
        writeln(dataTextFile, teacherSubjectResolver.TeacherID);
        writeln(dataTextFile, teacherSubjectResolver.SubjectID);
        writeln(dataTextFile,'');
      end;
    close(dataTextFile);
    write('Done');
    readln;
  end.

