unit studentClassProcedures;
  interface

    USES crt, sysutils, FileProcedures;

    TYPE
        dataRecord = RECORD
                          StudentID : LONGINT;
                          ClassID : STRING[8];
                        end;

    type
        studentClassFile = Class(Files)
            private
                dataTextFile : TextFile;
                dataFile: File OF dataRecord;
                indexArray: ARRAY[0..1384] OF LONGINT;
                recordArray: ARRAY[0..1384] OF dataRecord;
                recordIdArray: ARRAY[0..1384] OF STRING;
            public
                data : dataRecord;
                constructor Create;
                procedure SetData(iStudentID : LONGINT; iClassID : STRING);
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

    constructor studentClassFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\studentClassResolver.dta');
            ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outStudentClass.txt');
            RESET(dataFile);
            for a := 0 TO 1384 DO
              begin
                indexArray[a] := a;
              end;
        end;

    procedure studentClassFile.SetData(iStudentID : LONGINT; iClassID : STRING);
        begin
            with data do
                begin
                    ClassID := iClassID;
                    StudentID := iStudentID;
                end;
        end;



    procedure studentClassFile.DisplayData;
        begin
                writeln(data.ClassID);
                writeln(data.StudentID);
                writeln('-------------------------------------------------------------------------');
        end;

    procedure studentClassFile.displayFile;
        var a : LONGINT;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not (eof(dataFile)) do
                begin
                    READ(dataFile,data);
                    with data do
                        begin
                            writeln(ClassID);
                            writeln(StudentID);
                            writeln('-------------------------------------------------------------------------');
                        end;
                    writeln(dataTextFile, data.ClassID);
                    writeln(dataTextFile, IntToStr(data.StudentID));
                end;
            close(dataTextFile);
        end;
    
    procedure studentClassFile.extractToTextFile;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not eof(dataFile) do
                begin
                    read(dataFile, data);
                    writeln(dataTextFile, data.ClassID);
                    writeln(dataTextFile, data.StudentID);
                    writeln(dataTextFile, '');
                end; 
        end;

    procedure studentClassFile.writeToFile;
        begin
            write(dataFile, data);
        end;


    procedure studentClassFile.readHere;
        begin
            if FIlePos(dataFile) < FileSize(dataFile) then
                begin
                    read(dataFile,data);
                end;
        end;

    procedure studentClassFile.readFile(readFromPosition : LONGINT);
        begin
            if readFromPosition < FileSize(dataFile) then
                begin
                    SEEK(dataFile,readFromPosition);
                    read(dataFile,data);
                end;
        end;

    procedure studentClassFile.sort;
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 1384;
          for a := 0 TO 1384 DO
            begin
              READ(dataFile,data);
              recordArray[a] := data;
              dataArray[a] := Format('%'+'8'+'s',[(data.classID)]);
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 1384 DO
            begin
                data := recordArray[indexArray[a]];
                WRITE(dataFile,recordArray[indexArray[a]]);
            end;

        end;

        procedure studentClassFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT);
            var a, searchResult: LONGINT;
            begin
                RESET(dataFile);
                a := 0;
                while not EOF(dataFile) DO
                    begin
                        read(dataFile, data);
                        fileArray[0,a] := data.classID;
                        Str(data.StudentID, fileArray[1,a]);
                        returnArray[a] := -1;
                        a := a + 1;
                    end;
                Files.search(a+1,2,searchValues, searchFields, returnArray);
            end;


    END.


