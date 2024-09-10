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
                upper : LONGINT;
                dataArray: ARRAY[0..139] OF STRING;

            public
              constructor Create;
              procedure display;
              procedure sort(var indexArray : ARRAY OF LONGINT);
            end;
    type
        StudentFile = Class(Files)
            protected
                data : StudentsRecord;
                dataStore2 : StudentsRecord;
                dataFile: File OF StudentsRecord;
                indexArray: ARRAY[0..139] OF LONGINT;
                studentArray: ARRAY[0..139] OF StudentsRecord;
                studentIdArray: ARRAY[0..139] OF STRING;

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

    procedure Files.sort(var indexArray : ARRAY OF LONGINT);
        var TempIndex, i : LONGINT;
            TempStr : STRING;
            Swaps: BOOLEAN;
        begin
            upper := upper-1;
            REPEAT
                Swaps:= false;
                FOR i := 0 TO upper DO
                BEGIN
                    IF dataArray[i] > dataArray[i+1] THEN
                    BEGIN
                        TempStr := dataArray[i];
                        dataArray[i] := dataArray[i+1];
                        dataArray[i+1] := TempStr;
                        Swaps := true;
                        TempIndex := indexArray[i];
                        indexArray[i] := indexArray[i+1];
                        indexArray[i+1] := TempIndex;
                    END;
                END;
                upper := upper -1;
            UNTIL (NOT Swaps) OR (upper < 0);
        end;


    constructor StudentFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\Students.dta');
            RESET(dataFile);
            for a := 0 TO 139 DO
              begin
                indexArray[a] := a;
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
                writeln(PWord);
                writeln(Attendance);
                writeln('-------------------------------------------------------------------------');
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
          upper:= 139;
          for a := 0 TO 139 DO
            begin
              READ(dataFile,data);
              studentArray[a] := data;
              dataArray[a] := IntToStr(data.StudentID);
            end;
          //dataArray := studentIdArray;
        writeln('point');
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 139 DO
            begin
                data := studentArray[indexArray[a]];
                DisplayData;
                WRITE(dataFile,studentArray[indexArray[a]]);
            end;

          Files.display;
        end;


    begin
        Student := StudentFile.Create;
        student.sort;
        student.readFile(0);
        student.DisplayData;
        readln;
    END.


