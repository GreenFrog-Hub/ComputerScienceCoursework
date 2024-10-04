PROGRAM classTesting;
  uses crt, sysutils, logInProcedures;

  var logIn : logInFile;

  begin
    login := logInFile.create;
    logIn.free;
//    classTestingUnit.testFileClass;
  end.

