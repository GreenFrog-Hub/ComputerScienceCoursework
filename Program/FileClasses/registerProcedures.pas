unit registerProcedures;
  interface

    USES crt, sysutils, FileProcedures;

    TYPE
        studentRegisterMarkRecord = RECORD
                          studentID : LONGINT;
                          registerMark : CHAR;
                        end;
        dataRecord = RECORD
                          RegisterID : STRING[17];
                          LessonNo : LONGINT;
                          Date : TDateTime;
                          ClassID : STRING[8];
                          RegisterMarks : ARRAY[0..100] OF studentRegisterMarkRecord;
                          isOfstedRegister : BOOLEAN;
                        end;

    type
        registerFile = Class(Files)
            private
                dataFile: File OF dataRecord;
                dataTextFile : TextFile;
                indexArray: ARRAY[0..1000] OF LONGINT;
                recordArray: ARRAY[0..1000] OF dataRecord;
                recordIdArray: ARRAY[0..1000] OF STRING;
                studentRegisterMark : studentRegisterMarkRecord;
            public
                data : dataRecord;
                constructor Create;
                destructor Destroy; override;
                procedure SetData(iRegisterID : STRING; iLessonNo : LONGINT; iDate : TDateTime; iClassID : STRING; iRegisterMarks : ARRAY OF studentRegisterMarkRecord; iisOfstedRegister : BOOLEAN);
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

    constructor registerFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\Registers.dta');
            ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\regOut.txt');
            RESET(dataFile);
            RESET(dataTextFile);
            for a := 0 TO 1000 DO
              begin
                indexArray[a] := a;
              end;
        end;

    destructor registerFile.Destroy;
        begin
            close(dataFile);
            close(dataTextFile);
            inherited Destroy;
        end;

    procedure registerFile.SetData(iRegisterID : STRING; iLessonNo : LONGINT; iDate : TDateTime; iClassID : STRING; iRegisterMarks : ARRAY OF studentRegisterMarkRecord; iisOfstedRegister : BOOLEAN);
        begin
            with data do
                begin
                    RegisterID := iRegisterID;
                    LessonNo := iLessonNo;
                    Date := iDate;
                    ClassID := iClassID;
                    //RegisterMarks := iRegisterMarks;
                    isOfstedRegister := iisOfstedRegister;
                end;
        end;



    procedure registerFile.DisplayData;
      var i : LONGINT;
        begin
            READ(dataFile,data);
            with data do
                begin
                    writeln(RegisterID);
                    writeln(LessonNo);
                    writeln(Date);
                    writeln(ClassID);
                    writeln('{');
                    for i := 0 TO 100 DO
                        begin
                            studentRegisterMark := RegisterMarks[i];
                            writeln(studentRegisterMark.studentID);
                            writeln(studentRegisterMark.RegisterMark);
                        end;
                    writeln('}');
                    writeln(isOfstedRegister);
                    writeln('-------------------------------------------------------------------------');
                end;
        end;

    procedure registerFile.displayFile;
        var a, i : LONGINT;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not (eof(dataFile)) do
                begin
                     READ(dataFile,data);
                    with data do
                        begin
                            writeln(RegisterID);
                            writeln(LessonNo);
                            writeln(Date);
                            writeln(ClassID);
                            writeln('{');
                            for i := 0 TO 101 DO
                                begin
                                    studentRegisterMark := data.RegisterMarks[i];
                                    writeln(studentRegisterMark.studentID);
                                    writeln(studentRegisterMark.RegisterMark);
                                end;
                            writeln('}');
                            writeln(isOfstedRegister);
                            writeln('-------------------------------------------------------------------------');
                        end;

                end;
        end;

    procedure registerFile.extractToTextFile;
        var i : LONGINT;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not eof(dataFile) do
                begin
                    read(dataFile, data);
                    writeln(dataTextFile, data.RegisterID);
                        writeln(dataTextFile, IntToStr(data.LessonNo));
                        writeln(dataTextFile, DateTimeToStr(data.Date));
                        writeln(dataTextFile, data.classID);
                        writeln(dataTextFile, '{');
                        for i := 0 TO 101 DO
                            begin
                                studentRegisterMark := data.RegisterMarks[i];
                                write(dataTextFile, '[');
                                write(dataTextFile, studentRegisterMark.studentID);
                                write(dataTextFile, ',');
                                write(dataTextFile, studentRegisterMark.RegisterMark);
                                writeln(dataTextFile, ']');
                            end;
                        writeln(dataTextFile, '}');
                        writeln(dataTextFile, data.isOfstedRegister);
                end;
        end;

    procedure registerFile.writeToFile;
        begin
            write(dataFile, data);
        end;


    procedure registerFile.readHere;
        begin
            if FIlePos(dataFile) < FileSize(dataFile) then
                begin
                    read(dataFile,data);
                end;
        end;

    procedure registerFile.readFile(readFromPosition : LONGINT);
        begin
            if readFromPosition < FileSize(dataFile) then
                begin
                    SEEK(dataFile,readFromPosition);
                    read(dataFile,data);
                end;
        end;

    procedure registerFile.sort;
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 1000;
          for a := 0 TO 1000 DO
            begin
              READ(dataFile,data);
              recordArray[a] := data;
              dataArray[a] := Format('%'+'20'+'s',[(data.RegisterID)]);
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 1000 DO
            begin
                WRITE(dataFile,recordArray[indexArray[a]]);
                indexArray[a] := a;
            end;

        end;

        procedure registerFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT);
            var a, searchResult: LONGINT;
            begin
                RESET(dataFile);
                for a := 0 TO 1000 DO
                    begin
                        read(dataFile, data);
                        fileArray[0,a] := data.RegisterID;
                        Str(data.LessonNo, fileArray[1,a]);
                        fileArray[2,a] := DateTimeToStr(data.Date);
                        fileArray[3,a] := data.classID;
                        returnArray[a] := -1;
                    end;
                Files.search(1000,4,searchValues, searchFields, returnArray);
            end;


    END.


