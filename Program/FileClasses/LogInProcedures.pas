unit LogInProcedures;
{$M+}
  interface

    USES crt, sysutils, FileProcedures;

    TYPE
        //record type for this file
        dataRecord = RECORD
                          PersonID: STRING[5];
                          Username: STRING[40];
                          Passwowrd: String[20];
                         end;

    type
        //declaration of class, attributes and methods
        logInFile = Class(Files)
              protected
                dataFile: File OF dataRecord;
                dataTextFile : TextFile;
                indexArray: ARRAY[0..190] OF LONGINT;
                recordArray: ARRAY[0..190] OF dataRecord;
              public
                data : dataRecord;
                constructor Create;
                destructor Destroy; override;
                procedure SetData(iPersonID: STRING; iUsername: STRING; iPasswowrd: String);
                procedure DisplayData;
                procedure extractToTextFile;
                procedure writeToFile;
                procedure readHere;
                procedure readFile(readFromPosition : LONGINT);
                procedure sort;
                procedure search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray: ARRAY OF LONGINT; switchLowerCase: BOOLEAN);

        end;

    IMPLEMENTATION
    //constructor and destructor
    constructor logInFile.Create;
        var a : longint;
        begin
            inherited Create;
            ASSIGN(dataFile,'C:\ComputerScienceCoursework\Program\files\LogInDetails.dta');
            ASSIGN(dataTextFile,'C:\ComputerScienceCoursework\Program\fileOuts\logInOut.txt');
            RESET(dataFile);
            RESET(dataTextFile);
            for a := 0 TO 190 DO
              begin
                indexArray[a] := a;
              end;
        end;

    destructor LogInFile.Destroy;
        begin
            close(dataFile);
            close(dataTextFile);
            inherited Destroy;
        end;

    //update data attribute
    procedure logInFile.SetData(iPersonID: STRING;
                          iUsername: STRING;
                          iPasswowrd: String);

        begin
            with data do
                begin
                    PersonID := iPersonID;
                    Username:=iUsername;
                    Passwowrd:=iPasswowrd;
                end;
        end;
    //display data attribute
    procedure logInFile.DisplayData;
        begin
        with data do
            begin
                writeln(PersonID);
                writeln(Username);
                writeln(Passwowrd);
                writeln('-------------------------------------------------------------------------');
            end;
        end;
    //write all data in file to text file
    procedure logInFile.extractToTextFile;
        begin
            reset(dataFile);
            rewrite(dataTextFile);
            while not eof(dataFile) DO
                begin
                    read(dataFile, data);
                    writeln(dataTextFile, data.PersonID);
                    writeln(dataTextFile, data.Username);
                    writeln(dataTextFile, data.Passwowrd);
                    writeln(dataTextFile, '');
                end;
        end;
    //write data attribute to file
    procedure logInFile.writeToFile;
        begin
            write(dataFile, data);
        end;

    //read data from file at current position
    procedure logInFile.readHere;
        begin
            if FIlePos(dataFile) < FileSize(dataFile) then
                begin
                    read(dataFile,data);
                end;
        end;
    //read data from file at specified position
    procedure logInFile.readFile(readFromPosition : LONGINT);
        begin
            if readFromPosition < FileSize(dataFile) then
                begin
                    SEEK(dataFile,readFromPosition);
                    read(dataFile,data);
                end;
        end;
    //sort the file
    procedure logInFile.sort;
        var a,b : LONGINT;
            maxStrLen : STRING;
        begin
          RESET(dataFile);
          upper:= 190;
          //extrat the data into an array
          for a := 0 TO 190 DO
            begin
              READ(dataFile,data);
              recordArray[a] := data;
              dataArray[a] := data.Username
            end;
        Files.sort(indexArray);
        RESET(dataFile);
        //write the data back to the file
        for a := 0 TO 190 DO
            begin
                WRITE(dataFile,recordArray[indexArray[a]]);
                indexArray[a] := a;
            end;

        end;
    //search the file
        procedure logInFile.search(searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT; switchLowerCase : BOOLEAN);
            var a, searchResult: LONGINT;
            begin
                RESET(dataFile);
                for a := 0 TO 190 DO
                    begin
                        read(dataFile, data);
                        fileArray[0,a] := data.PersonID;
                        fileArray[1,a] := data.Username;
                        fileArray[2,a] := data.Passwowrd;
                    end;
                Files.search(190,3,searchValues, searchFields, returnArray, switchLowerCase);
            end;
    END.


