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
                fileArray: ARRAY[0..7,0..139] OF STRING;

            public
              constructor Create;
              procedure display;
              procedure sort(var indexArray : ARRAY OF LONGINT);
              procedure strIntArrayToStr;
              function search(searchValue : STRING) : LONGINT;
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
                function search(searchValue : STRING) : LONGINT;

        end;

    //IMPLEMENTATION
    var Student: StudentFile;
        searchValue : LONGINT;
    constructor Files.Create;
      begin
      end;

    procedure Files.display;
        var a : LONGINT;
        begin
            //for a := 0 TO 139 DO
                //writeln(indexArray[a]);
        end;

    procedure Files.strIntArrayToStr;
        var a, b : LONGINT;
        begin
            for a := 0 TO 139 DO
                begin
                    for b := 1 TO (Length(dataArray[a])) DO
                        begin
                            dataArray[a][b] := Chr(StrToInt(dataArray[a][b])+97);
                        end;
                    //writeln(dataArray[a]);
                end;
        end;

    procedure Files.sort(var indexArray : ARRAY OF LONGINT);
        var TempIndex, i, code, tmp1, tmp2 : LONGINT;
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

    function Files.search(searchValue:STRING) : LONGINT;
        var found : BOOLEAN;
            c, b : LONGINT;
        begin
            found := false;
            c := -1;
            while found = false do
                begin
                c := c + 1;
                for b := 0 TO 7 DO
                    begin
                      writeln(c);
                        if fileArray[b,c] = LowerCase(searchValue) THEN
                          begin
                            writeln(fileArray[b,c]);
                            found := true;
                            search := c;
                          end;
                    end;
                if found = true THEN
                  begin
                    break
                  end;
            end;
            search := -1;
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
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 139;
          for a := 0 TO 139 DO
            begin
              READ(dataFile,data);
              studentArray[a] := data;
              maxStrLen :='3';
              dataArray[a] := Format('%'+maxStrLen+'s',[IntToStr(data.StudentID)]);
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        for a := 0 TO 139 DO
            begin
                data := studentArray[indexArray[a]];
                //DisplayData;
                //writeln(data.StudentID);
                WRITE(dataFile,studentArray[indexArray[a]]);
            end;

          //Files.display;
        end;

        function StudentFile.search(searchValue : STRING) : LONGINT;
            var a, searchResult: LONGINT;
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
                        Str(data.Attendance, fileArray[7,a]);
                    end;
                searchResult := Files.search(searchValue);
                search := searchResult;
            end;


    begin
        Student := StudentFile.Create;
        student.sort;
        searchValue := student.search('Robert');
        writeln(searchValue);
        //student.readFile(searchValue);
        //Student.DisplayData;
        readln;
    END.


