unit attendancProcedures;
  interface

    USES crt, sysutils, FileProcedures;

    TYPE
        dataRecord = RECORD
                          StudentID : LONGINT;
                          Attendance : REAL;
                          Total : LONGINT;
                          NumberPresent : LONGINT;
                          NumberLate : LONGINT;
                          NumberAbsent : LONGINT;
                        end;

    type
        AttendanceFile = Class(Files)
            private
                dataFile: File OF dataRecord;
                dataTextFile : TextFile;
                indexArray: ARRAY[0..139] OF LONGINT;
                recordArray: ARRAY[0..139] OF dataRecord;
                recordIdArray: ARRAY[0..139] OF STRING;
            public
                data : dataRecord;
                constructor Create;
                destructor Destroy; override;
                procedure SetData(iStudentID : LONGINT; iAttendance : REAL; iTotal : LONGINT; iNumberPresent : LONGINT; iNumberLate : LONGINT; iNumberAbsent : LONGINT);
                procedure DisplayData;
                procedure displayFile;
                procedure extractToTextFile;
                procedure writeToFile;
                procedure readHere;
                procedure readFile(readFromPosition : LONGINT);
                procedure sort;
                procedure search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray: ARRAY OF LONGINT);

        end;

    IMPLEMENTATION

    constructor AttendanceFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\attendanceFile.dta');
            ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\attendanceOut.txt');
            RESET(dataFile);
            for a := 0 TO 139 DO
              begin
                indexArray[a] := a;
              end;
        end;
    
    destructor AttendanceFile.Destroy;
        begin
            close(dataFile);
            inherited Destroy;
        end;

    procedure AttendanceFile.SetData(iStudentID : LONGINT; iAttendance : REAL; iTotal : LONGINT; iNumberPresent : LONGINT; iNumberLate : LONGINT; iNumberAbsent : LONGINT);

        begin
            with data do
                begin
                    StudentID := iStudentID;
                    Attendance := iAttendance;
                    Total := iTotal;
                    NumberPresent := iNumberPresent;
                    NumberLate := iNumberLate;
                    NumberAbsent := iNumberAbsent;
                end;
        end;



    procedure AttendanceFile.DisplayData;
        begin
        with data do
            begin
                writeln(StudentID);
                writeln(Attendance);
                writeln(Total);
                writeln(NumberPresent);
                writeln(NumberLate);
                writeln(NumberAbsent);
                writeln('-------------------------------------------------------------------------');
            end;
        end;

    procedure AttendanceFile.displayFile;
        var a : LONGINT;
        begin
            reset(dataFile);
            while not (eof(dataFile)) do
                begin
                    READ(dataFile,data);
                    with data do
                        begin
                            writeln(StudentID);
                            writeln(Attendance);
                            writeln(Total);
                            writeln(NumberPresent);
                            writeln(NumberLate);
                            writeln(NumberAbsent);
                            writeln('-------------------------------------------------------------------------');
                        end;
                end;
        end;
    
    procedure AttendanceFile.extractToTextFile;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not eof(dataFile) do
                begin
                    read(dataFile, data);
                    writeln(dataTextFile, data.StudentID);
                    writeln(dataTextFile, data.Attendance);
                    writeln(dataTextFile, data.Total);
                    writeln(dataTextFile, data.NumberPresent);
                    writeln(dataTextFile, data.NumberLate);
                    writeln(dataTextFile, data.NumberAbsent);
                    writeln(dataTextFile, '');
                end; 
        end;

    procedure AttendanceFile.writeToFile;
        begin
            write(dataFile, data);
        end;


    procedure AttendanceFile.readHere;
        begin
            if FIlePos(dataFile) < FileSize(dataFile) then
                begin
                    read(dataFile,data);
                end;
        end;

    procedure AttendanceFile.readFile(readFromPosition : LONGINT);
        begin
            if readFromPosition < FileSize(dataFile) then
                begin
                    SEEK(dataFile,readFromPosition);
                    read(dataFile,data);
                end;
        end;

    procedure AttendanceFile.sort;
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 139;
          for a := 0 TO 139 DO
            begin
              READ(dataFile,data);
              recordArray[a] := data;
              dataArray[a] := Format('%'+'3'+'s',[IntToStr(data.StudentID)]);
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 139 DO
            begin
                data := recordArray[indexArray[a]];
                WRITE(dataFile,recordArray[indexArray[a]]);
            end;

        end;

        procedure AttendanceFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT);
            var a, searchResult: LONGINT;
            begin
                RESET(dataFile);
                for a := 0 TO 139 DO
                    begin
                        read(dataFile, data);
                        Str(data.StudentID, fileArray[0,a]);
                        Str(data.Attendance, fileArray[1,a]);
                        Str(data.Total, fileArray[2,a]);
                        Str(data.NumberPresent, fileArray[3,a]);
                        Str(data.NumberLate, fileArray[4,a]);
                        Str(data.NumberAbsent, fileArray[5,a]);
                    end;
                Files.search(139,6,searchValues, searchFields, returnArray);
            end;


    END.


