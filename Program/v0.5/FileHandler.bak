UNIT FileHandler;
  INTERFACE
  USES CRT, SYSUTILS,Search;

  TYPE
    StudentsRecord = RECORD
                       StudentID : LONGINT;
                       FName : STRING;
                       SName : String;
                       Year : LONGINT;
                       Form : STRING;
                       Uname : String;
                       Pword : String;
                       Attendance : real;
                    END;

    StudentRecordFile = FILE OF StudentsRecord;

  VAR
    Student : StudentsRecord;
    StudentsFile : StudentRecordFile;

  PROCEDURE InitialiseFile(FilePath : STRING);
  PROCEDURE DisplayFile;
  PROCEDURE DisplayProductCount;
  PROCEDURE DisplayRecord;
  PROCEDURE NeedreOrder;
  PROCEDURE FindRecord;
    VAR
      Found : BOOLEAN;
      IDtoFind : STRING[7];
  PROCEDURE AddProduct;
  PROCEDURE CloseFile;

  IMPLEMENTATION

  PROCEDURE InitialiseFile(FilePath : STRING);
    BEGIN
      ASSIGN(StudentsFile, FilePath);
    END;

  PROCEDURE DisplayFile();
    BEGIN
      RESET(StockFile);
      WHILE NOT EOF(StockFile) DO
        BEGIN
          READ(StockFile, Stock);
          WITH Stock DO
            BEGIN
              WRITELN('Code:',Barcode);
              WRITELN('Decription:', Description);
              WRITELN('Cost:', Price:1:2);
              WRITELN('Number in stock:', NoInStock);
              WRITELN('Reorder level:', ReorderLevel);
              WRITELN('Supplier code:', SupplierCode);
            END;
        END;
    END;

  PROCEDURE DisplayProductCount;
    BEGIN
      RESET(StockFile);
      ProductCount := 0;

      WHILE NOT EOF(StockFile) DO
        BEGIN
          READ(StockFile, Stock);
          ProductCount := ProductCount +1;
        END;
      WRITELN('The total numbe rof products is: ', ProductCount);
    END;

  PROCEDURE DisplayRecord;
    BEGIN
      WITH Stock DO
        BEGIN
          WRITELN('Code:',Barcode);
          WRITELN('Decription:', Description);
          WRITELN('Cost:', Price:1:2);
          WRITELN('Number in stock:', NoInStock);
          WRITELN('Reorder level:', ReorderLevel);
          WRITELN('Supplier code:', SupplierCode);
        END;
      END;

  PROCEDURE NeedReorder;
    BEGIN
      RESET(StockFile);
      REPEAT
        READ(StockFile, Stock);
        IF Stock.NoInStock <= Stock.ReorderLevel THEN
          BEGIN
            WRITELN('This product needs reordering: ');
            DisplayRecord;
          END;
      UNTIL EOF(StockFile);
    END;

  PROCEDURE FindRecord;
    BEGIN
      RESET(StockFile);
      Found := false;
      WRITE('What is the id you are looking for: ');
      READLN(IDtoFind);
      REPEAT
        READ(StockFile, Stock);
        IF Stock.Barcode = IDtoFind THEN
          BEGIN
            Found := true;
            DisplayRecord;
          END;
      UNTIL (EOF(StockFile)) OR (Found);
    END;

  PROCEDURE AddProduct;
    BEGIN
      SEEK(StockFile, FILESIZE(StockFile));
      WITH Stock DO
        BEGIN
          WRITE('What is the ID: ');
          READLN(Barcode);
          WRITE('What is the description: ');
          READLN(Description);
          WRITE('What is the price: ');
          READLN(Price);
          WRITE('How many in stock: ');
          READLN(NoInStock);
          WRITE('What is the reorder level: ');
          READLN(ReorderLevel);
          WRITE('What is the supplier code: ');
          READLN(SupplierCode);
        END;
      WRITE(StockFile, Stock);
    END;


  PROCEDURE CloseFile;
    BEGIN
      CLOSE(StockFile);
    END;


  END.
