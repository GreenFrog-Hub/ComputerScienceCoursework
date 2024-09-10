PROGRAM FileProcedures;
{$M+}
    //interface

    USES crt, sysutils;

    TYPE
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

        Files = class
            protected
                test : LONGINT;
                indexArray: ARRAY[0..139] OF LONGINT;
                dataArray: ARRAy[0..139] OF STRING;

            public
              constructor Create;
              procedure display;
              procedure sort;
            end;
    type
        StudentFile = Class(Files)
            protected
                data : StudentsRecord;
                dataStore2 : StudentsRecord;
                dataFile: File OF StudentsRecord;
                indexArray: ARRAY[0..139] OF LONGINT;
                dataArray: ARRAY[0..139] OF STRING;

            public
                constructor Create;
                procedure SetData(StudentId : LONGINT; FirstName: STRING; SurName : STRING; SYear : LONGINT; SForm : STRING; SUname : String; SPword : String; SAttendance : real);
                procedure DisplayData;
                procedure writeToFile;
                procedure readHere;
                procedure readFile(readFromPosition : LONGINT);
                procedure sort;

        end;

    //IMPLEMENTATION
    var Student: StudentFile;
    constructor Files.Create;
      begin
      end;

    procedure Files.display;
        var a : LONGINT;
        begin
            //for a := 0 TO 139 DO
                //writeln(indexArray[a]);
        end;

    procedure Files.sort;
        begin
            
        end;


    constructor StudentFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\Students.dta');
            for a := 0 TO 139 DO
              begin
                self.indexArray[a] := a;
              end;
        end;

    procedure StudentFile.SetData(StudentId : LONGINT;
                          FirstName : STRING;
                          SurName : STRING;
                          SYear : LONGINT;
                          SForm : STRING;
                          SUname : String;
                          SPword : String;
                          SAttendance : real);
        begin
            with data do
                begin
                    StudentID := StudentId;
                    FName := FirstName;
                    SName := SurName;
                    Year := SYear;
                    Form := SForm;
                    Uname := SUname;
                    Pword := SPword;
                    Attendance := SAttendance;
                end;
        end;

    procedure StudentFile.DisplayData;
        begin
        with data do
            begin
                writeln(StudentID);
                writeln(FName);
                writeln(SName);
                writeln(Year);
                writeln(Form);
                writeln(Uname);
                writeln(Attendance);
            end;
        end;

    procedure StudentFile.writeToFile;
        begin
            write(dataFile, data);
        end;


    procedure StudentFile.readHere;
        begin
            read(dataFile,data);
        end;

    procedure StudentFile.readFile(readFromPosition : LONGINT);
        begin
            if readFromPosition < FileSize(dataFile) then
                begin
                    SEEK(dataFile,readFromPosition);
                    read(dataFile,data);
                end;
        end;

    procedure StudentFile.sort;
        var a : LONGINT;
        begin
          writeln('a');
          RESET(dataFile);
          indexArray := self.indexArray;
          for a := 0 TO 139 DO
            begin
              READ(dataFile,data);
              self.dataArray[a] := IntToStr(data.StudentID);
            end;
          dataArray := self.dataArray;
          Files.display;
        end;


    begin
        Student := StudentFile.Create;
        student.sort;
        readln;
    END.


