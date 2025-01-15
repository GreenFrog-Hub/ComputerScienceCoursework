unit teacherProcedures;
  interface

    USES crt, sysutils, FileProcedures;

    TYPE
        TeacherRecord = RECORD
                          TeacherID : STRING[3];
                          FName : string[20];
                          SName : string[20];
                          Form  : string[5];
                          Uname : STRING[40];
                          PWord : STRING[20];
                        end;

    type
        TeacherFile = Class(Files)
            private
                dataFile: File OF TeacherRecord;
                dataTextFile : TextFile;
                indexArray: ARRAY[0..50] OF LONGINT;
                recordArray: ARRAY[0..50] OF TeacherRecord;
            public
                data : TeacherRecord;
                constructor Create;
                destructor Destroy; override;
                procedure SetData(TeacherID : LONGINT; FirstName: STRING; SurName : STRING; SForm : STRING; SUname : String; SPword : String);
                procedure DisplayData;
                procedure extractToTextFile;
                procedure writeToFile;
                procedure readHere;
                procedure readFile(readFromPosition : LONGINT);
                procedure sort;
                procedure search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray: ARRAY OF LONGINT; switchLowerCase: BOOLEAN);

        end;

    IMPLEMENTATION

    constructor TeacherFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\Teachers.dta');
            ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\outTeachers.txt');
            RESET(dataFile);
            RESET(dataTextFile);
            for a := 0 TO 139 DO
              begin
                indexArray[a] := a;
              end;
        end;

    destructor TeacherFile.Destroy;
        begin
            close(dataFile);
            close(dataTextFile);
            inherited Destroy;
        end;

    procedure TeacherFile.SetData(TeacherID : LONGINT;
                          FirstName : STRING;
                          SurName : STRING;
                          SForm : STRING;
                          SUname : String;
                          SPword : String);

        begin
            with data do
                begin
                    TeacherID := TeacherID;
                    FName := FirstName;
                    SName := SurName;
                    Form := SForm;
                    Uname := SUname;
                    Pword := SPword;
                end;
        end;

    procedure TeacherFile.DisplayData;
        begin
        with data do
            begin
                writeln(TeacherID);
                writeln(FName);
                writeln(SName);
                writeln(Form);
                writeln(Uname);
                writeln(PWord);
                writeln('-------------------------------------------------------------------------');
            end;
        end;

    procedure TeacherFile.extractToTextFile;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not eof(dataFile) do
                begin
                    read(dataFile, data);
                    writeln(dataTextFile, data.TeacherID);
                    writeln(dataTextFile, data.FName);
                    writeln(dataTextFile, data.SName);
                    writeln(dataTextFile, data.Form);
                    writeln(dataTextFile, data.Uname);
                    writeln(dataTextFile, data.PWord);
                    writeln(dataTextFile, '');
                end;
        end;

    procedure TeacherFile.writeToFile;
        begin
            write(dataFile, data);
        end;


    procedure TeacherFile.readHere;
        begin
            if FilePos(dataFile) < FileSize(dataFile) then
                begin
                    read(dataFile,data);
                end;
        end;

    procedure TeacherFile.readFile(readFromPosition : LONGINT);
        begin
            if readFromPosition < FileSize(dataFile) then
                begin
                    SEEK(dataFile,readFromPosition);
                    read(dataFile,data);
                end;
        end;

    procedure TeacherFile.sort;
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 50;
          for a := 0 TO 50 DO
            begin
              READ(dataFile,data);
              dataArray[a] := data.teacherID;
              recordArray[a] := data;
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 50 DO
            begin
                WRITE(dataFile,recordArray[indexArray[a]]);
                indexArray[a] := a;
            end;

        end;

        procedure TeacherFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT; switchLowerCase : BOOLEAN);
            var a, searchResult: LONGINT;
            begin
                RESET(dataFile);
                for a := 0 TO 50 DO
                    begin
                        read(dataFile, data);
                        fileArray[0,a] := data.TeacherID;
                        fileArray[1,a] := data.FName;
                        fileArray[2,a] := data.SName;
                        fileArray[4,a] := data.Form;
                        fileArray[5,a] := data.Uname;
                        fileArray[6,a] := data.PWord;
                        returnArray[a] := -1;
                    end;
                Files.search(50,7,searchValues, searchFields, returnArray, switchLowerCase);
            end;


    END.


