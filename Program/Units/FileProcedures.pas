PROGRAM FileProcedures;
{$M+}
    //interface

    USES crt, sysutils;

    TYPE
        StudentsRecord = RECORD
                          StudentID : LONGINT;
                          FName : STRING;
                          SName : String;
                          Year : LONGINT;
                          Form : STRING;
                          Uname : String;
                          Pword : String;
                          Attendance : real;
                        end;




        StudentFile = class
            protected
                dataStore1 : StudentsRecord;
                dataStore2 : StudentsRecord;
                dataFile: File OF StudentsRecord;
                indexArray: ARRAY[0..139] OF LONGINT;

            public
                constructor Create;
                procedure SetData(StudentId : LONGINT; FirstName: STRING; SurName : STRING; SYear : LONGINT; SForm : STRING; SUname : String; SPword : String; SAttendance : real);
                procedure DisplayData;
                procedure writeToFile;
                procedure readHere;
                procedure readFile(readFromPosition : LONGINT);
                procedure sort;
                procedure createstudentIdArray;

        end;

    //IMPLEMENTATION

    constructor StudentFile.Create;
        begin
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\Students.dta');
            for a := 0 TO 139 DO
                indexArray[a] := a;
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
            with dataStore1 do
                begin
                    StudentID := StudentId;
                    FName := FirstName;3
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
        with dataStore1 do
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
            write(dataFile, data)
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

    procedure createstudentIdArray;
        begin

        end;

    procedure StudentFile.Sort;
        var upper : LONGINT;
            swaps : BOOLEAN;
        begin
            RESET(dataFile);
            upper := FILEPOS(SEEKEOF(dataFile));
            REPEAT
                Swaps:= false;
                FOR i := 0 TO upper DO
                BEGIN
                    IF UserArray[i] > UserArray[i+1] THEN
                    BEGIN
                        Temp := UserArray[i];
                        UserArray[i] := UserArray[i+1];
                        UserArray[i+1] := Temp;
                        Swaps := true;
                    END;
                END;
                upper := upper -1;
            UNTIL (NOT Swaps) OR (upper < 0);
        end;


    begin
        Student := StudentFile.Create;
        Student.printArray;
    END.


