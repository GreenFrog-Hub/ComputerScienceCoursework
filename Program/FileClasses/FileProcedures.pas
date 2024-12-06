unit FileProcedures;
//allows constructors
{$M+}

    interface

    USES crt, sysutils;

    TYPE
        //declare class structure
        Files = class
            protected
              upper : LONGINT;
              dataArray: ARRAY[0..1400] OF STRING;
              fileArray: ARRAY[0..7,0..1400] OF STRING;
            public
              constructor Create;
              destructor Destroy; override;
              procedure sort(var indexArray : ARRAY OF LONGINT);
              procedure search(max, fields : LONGINT; searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT);
            end;

    IMPLEMENTATION

    constructor Files.Create;
      begin
      end;

    destructor Files.Destroy;
        begin
        end;

    //sort algorithm for the files
    procedure Files.sort(var indexArray : ARRAY OF LONGINT);
        var TempIndex, i, code, tmp1, tmp2 : LONGINT;
            TempStr : STRING;
            Swaps: BOOLEAN;
        begin
            //bubble sort
            upper := upper-1;
            REPEAT
                Swaps:= false;
                FOR i := 0 TO upper DO
                BEGIN
                    //checks done with the data array
                    IF dataArray[i] > dataArray[i+1] THEN
                    BEGIN
                        TempStr := dataArray[i];
                        dataArray[i] := dataArray[i+1];
                        dataArray[i+1] := TempStr;
                        Swaps := true;
                        //swap data in index array
                        TempIndex := indexArray[i];
                        indexArray[i] := indexArray[i+1];
                        indexArray[i+1] := TempIndex;
                    END;
                END;
                upper := upper -1;
            UNTIL (NOT Swaps) OR (upper < 0);
        end;

    //search algorithm
    procedure Files.search(max, fields : LONGINT; searchValues:ARRAY OF STRING; searchFields: ARRAY OF BYTE; var returnArray : ARRAY OF LONGINT);
        var found : BOOLEAN;
            a, b, c, returnIndex : LONGINT;
            data : STRING;
        begin
            //linear search
            a := -1;
            returnIndex := 0;
            //check every value in the 2d array
            while a < max do
                begin
                a := a + 1;
								//check each item in the record
                for b := 0 TO (fields-1) DO
                    begin
                      data := LowerCase(fileArray[b,a]);
											//check if one piece of data matches
                        if data = LowerCase(searchValues[0]) THEN
                          begin
                            found := true;
														//check each peice of data in record against data to search for
                            for c := 0 to (SizeOf(searchFields)-1) do
                                begin
                                    data := LowerCase(FileArray[searchFields[c],a]);
																		//if not all data matches continue search and dont return result
                                    if LowerCase(searchValues[c]) <> data THEN
                                    begin
                                        found := false;
                                        break;
                                    end;
                                end;
														//if all data matches add index to the array of found matches
                            if found = true THEN
                                begin
                                    returnArray[returnIndex] := a;
                                    returnIndex := returnIndex+1;
                                    break
                                end;
                          end;
                    end;
            end;
        end;

    END.


