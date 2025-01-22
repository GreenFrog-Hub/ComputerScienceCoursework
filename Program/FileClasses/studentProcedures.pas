unit studentProcedures;
  interface

    USES crt, sysutils, FileProcedures;

    TYPE
        StudentsRecord = RECORD
                          StudentID : LONGINT;
                          FName : STRING[20];
                          SName : String[20];
                          Year : LONGINT;
                          Form : STRING[5];
                          Uname : String[40];
                          Pword : String[20];
                        end;

    type
        StudentFile = Class(Files)
            private
                dataFile: File OF StudentsRecord;
                dataTextFile : TextFile;
                indexArray: ARRAY[0..139] OF LONGINT;
                recordArray: ARRAY[0..139] OF StudentsRecord;
            public
                data : StudentsRecord;
                constructor Create;
                destructor Destroy; override;
                procedure SetData(StudentId : LONGINT; FirstName: STRING; SurName : STRING; SYear : LONGINT; SForm : STRING; SUname : String; SPword : String);
                procedure DisplayData;
                procedure displayFile;
                procedure extractToTextFile;
                procedure writeToFile;
                procedure readHere;
                procedure readFile(readFromPosition : LONGINT);
                procedure sort;
                procedure search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray: ARRAY OF LONGINT; switchLowerCase: BOOLEAN);

        end;

    IMPLEMENTATION

    constructor StudentFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\Students.dta');
            ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outStudents.txt');
            RESET(dataFile);
            RESET(dataTextFile);
            for a := 0 TO 139 DO
              begin
                indexArray[a] := a;
              end;
        end;

    destructor StudentFile.Destroy;
        begin
            close(dataFile);
            close(dataTextFile);
            inherited Destroy;
        end;

    procedure StudentFile.SetData(StudentId : LONGINT;
                          FirstName : STRING;
                          SurName : STRING;
                          SYear : LONGINT;
                          SForm : STRING;
                          SUname : String;
                          SPword : String);

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
                writeln('-------------------------------------------------------------------------');
            end;
        end;

    procedure StudentFile.displayFile;
        var a : LONGINT;
        begin
            reset(dataFile);
            while not (eof(dataFile)) do
                begin
                    READ(dataFile,data);
                    with data do
                        begin
                            writeln(StudentID);
                            writeln(FName);
                            writeln(SName);
                            writeln(Year);
                            writeln(Form);
                            writeln(Uname);
                            writeln(PWord);
                            writeln('-------------------------------------------------------------------------');
                        end;
                end;
        end;

    procedure StudentFile.extractToTextFile;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not eof(dataFile) do
                begin
                    read(dataFile, data);
                    writeln(dataTextFile, data.StudentID);
                    writeln(dataTextFile, data.FName);
                    writeln(dataTextFile, data.SName);
                    writeln(dataTextFile, data.Year);
                    writeln(dataTextFile, data.Form);
                    writeln(dataTextFile, data.Uname);
                    writeln(dataTextFile, data.PWord);
                    writeln(dataTextFile, '');
                end;
        end;

    procedure StudentFile.writeToFile;
        begin
            write(dataFile, data);
        end;


    procedure StudentFile.readHere;
        begin
            if FIlePos(dataFile) < FileSize(dataFile) then
                begin
                    read(dataFile,data);
                end;
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
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 139;
          for a := 0 TO 139 DO
            begin
              READ(dataFile,data);
              recordArray[a] := data;
              maxStrLen :='3';
              dataArray[a] := Format('%'+maxStrLen+'s',[IntToStr(data.StudentID)]);
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 139 DO
            begin
                WRITE(dataFile,recordArray[indexArray[a]]);
                indexArray[a] := a;
            end;

        end;

        procedure StudentFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT; switchLowerCase : BOOLEAN);
            var a: LONGINT;
            begin
                RESET(dataFile);
                for a := 0 TO 139 DO
                    begin
                        read(dataFile, data);
                        Str(data.StudentID, fileArray[0,a]);
                        fileArray[1,a] := data.FName;
                        fileArray[2,a] := data.SName;
                        Str(data.Year, fileArray[3,a]);
                        fileArray[4,a] := data.Form;
                        fileArray[5,a] := data.Uname;
                        fileArray[6,a] := data.PWord;
                        returnArray[a] := -1;
                    end;
                Files.search(139,7,searchValues, searchFields, returnArray, switchLowerCase);
            end;


    END.


