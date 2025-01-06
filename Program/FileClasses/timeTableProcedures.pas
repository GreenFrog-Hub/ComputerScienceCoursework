unit timeTableProcedures;
  interface

    USES crt, sysutils, FileProcedures;

    TYPE
        TimeTableRecord = RECORD
                          Day : LONGINT;
                          LessonNo : LONGINT;
                          ClassID : STRING[8];
                        end;

    type
        TimeTableFile = Class(Files)
            private
                dataFile: File OF TimeTableRecord;
                dataTextFile : TextFile;
                indexArray: ARRAY[0..320] OF LONGINT;
                recordArray: ARRAY[0..320] OF TimeTableRecord;
                recordIdArray: ARRAY[0..320] OF STRING;
            public
                data : TimeTableRecord;
                constructor Create;
                destructor Destroy; override;
                procedure SetData(iDay : LONGINT;
                          iLessonNo : LONGINT;
                          iClassID : STRING);
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

    constructor TimeTableFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\TimeTable.dta');
            ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outTimeTable.txt');
            RESET(dataFile);
            RESET(dataTextFile);
            for a := 0 TO 319 DO
              begin
                indexArray[a] := a;
              end;
        end;

    destructor TimeTableFile.Destroy;
        begin
            close(dataFile);
            close(dataTextFile);
            inherited Destroy;
        end;
    
    procedure TimeTableFile.SetData(iDay : LONGINT;
                          iLessonNo : LONGINT;
                          iClassID : STRING);

        begin
            with data do
                begin
                    Day := iDay;
                    LessonNo := iLessonNo;
                    ClassID := iClassID;
                end;
        end;

    procedure TimeTableFile.DisplayData;
        begin
        with data do
            begin
                writeln(day);
                writeln(lessonNo);
                writeln(ClassID);
                writeln('-------------------------------------------------------------------------');
            end;
        end;

    procedure TimeTableFile.extractToTextFile;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not eof(dataFile) do
                begin
                    read(dataFile, data);
                    writeln(dataTextFile, data.day);
                    writeln(dataTextFile, data.lessonNo);
                    writeln(dataTextFile, data.ClassID);
                    writeln(dataTextFile, '');
                end; 
        end;

    procedure TimeTableFile.displayFile;
        var a : LONGINT;
        begin
            reset(dataFile);
            while not (eof(dataFile)) do
                begin
                    READ(dataFile,data);
                    with data do
                        begin
                            writeln(day);
                            writeln(lessonNo);
                            writeln(ClassID);
                            writeln('-------------------------------------------------------------------------');
                        end;
                end;
        end;

    procedure TimeTableFile.writeToFile;
        begin
            write(dataFile, data);
        end;


    procedure TimeTableFile.readHere;
        begin
            if FIlePos(dataFile) < FileSize(dataFile) then
                begin
                    read(dataFile,data);
                end;
        end;

    procedure TimeTableFile.readFile(readFromPosition : LONGINT);
        begin
            if readFromPosition < FileSize(dataFile) then
                begin
                    SEEK(dataFile,readFromPosition);
                    read(dataFile,data);
                end;
        end;

    procedure TimeTableFile.sort;
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 319;
          for a := 0 TO 319 DO
            begin
              READ(dataFile,data);
              recordArray[a] := data;
              dataArray[a] := IntToStr(data.day);
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 319 DO
            begin
                WRITE(dataFile,recordArray[indexArray[a]]);
                indexArray[a] := a;
            end;

        end;

        procedure TimeTableFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT);
            var a, searchResult: LONGINT;
            begin
                RESET(dataFile);
                for a := 0 TO 319 DO
                    begin
                        read(dataFile, data);
                        if a > 310 THEN
                          write;
                        Str(data.day, fileArray[0,a]);
                        Str(data.LessonNo, fileArray[1,a]);
                        fileArray[2,a] := data.ClassID;
                        returnArray[a] := -1;
                    end;
                Files.search(319,3,searchValues, searchFields, returnArray);
            end;


    END.


