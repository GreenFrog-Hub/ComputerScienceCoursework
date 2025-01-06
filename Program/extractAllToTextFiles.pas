program extractAllToTextFiles;
  uses crt, sysutils, attendancProcedures, classProcedures, LogInProcedures,
  registerProcedures, studentClassProcedures, studentProcedures, teacherProcedures,
  timeTableProcedures;


  var
    attendance : attendanceFile;
    sClass : classFile;
    login : logInFile;
    registerF : registerFile;
    studentClass : studentClassFile;
    student : StudentFile;
    teacher : TeacherFile;
    timetable : TimeTableFile;

  begin
    attendance := attendanceFile.create;
    sClass := classFile.create;
    login := logInFile.create;
    registerF := registerFile.create;
    studentClass := studentClassFile.create;
    student := StudentFile.create;
    teacher := TeacherFile.create;
    timetable := TimeTableFile.create;

    attendance.sort;
    sClass.sort;
    login.sort;
    registerF.sort;
    studentClass.sort;
    student.sort;
    teacher.sort;
    timetable.sort;

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

    readln;
  end.

