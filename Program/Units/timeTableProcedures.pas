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
            public
                data : TimeTableRecord;
                dataFile: File OF TimeTableRecord;
                indexArray: ARRAY[0..320] OF LONGINT;
                recordArray: ARRAY[0..320] OF TimeTableRecord;
                recordIdArray: ARRAY[0..320] OF STRING;
                constructor Create;
                procedure SetData(iDay : LONGINT;
                          iLessonNo : LONGINT;
                          iClassID : STRING);
                procedure DisplayData;
                procedure displayFile;
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
            RESET(dataFile);
            for a := 0 TO 320 DO
              begin
                indexArray[a] := a;
              end;
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
          upper:= 320;
          for a := 0 TO 320 DO
            begin
              READ(dataFile,data);
              recordArray[a] := data;
              dataArray[a] := IntToStr(data.day);
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 319 DO
            begin
                data := recordArray[indexArray[a]];
                WRITE(dataFile,recordArray[indexArray[a]]);
            end;
        end;

        procedure TimeTableFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT);
            var a, searchResult: LONGINT;
            begin
                RESET(dataFile);
                for a := 0 TO 319 DO
                    begin
                        read(dataFile, data);
                        Str(data.day, fileArray[0,a]);
                        Str(data.LessonNo, fileArray[1,a]);
                        fileArray[2,a] := data.ClassID;
                        returnArray[a] := -1;
                    end;
                Files.search(319,3,searchValues, searchFields, returnArray);
            end;


    END.


