PROGRAM FileTasks;
  USES CRT, SYSUTILS, FileHandler;

  VAR MenuChoice : CHAR;

  PROCEDURE Menu;
    BEGIN
      REPEAT
        WRITELN;
        WRITELN;
        WRITELN('A: Display all products');
        WRITELN('B: Display count of products');
        WRITELN('C: Display items that need reordering');
        WRITELN('D: Find Product');
        WRITELN('E: Add Prodcut');
        WRITELN('X: Exit Program');

        WRITELN;
        WRITELN;

        WRITE('Enter Menu Choice: ');
        READLN(MenuChoice);
        MenuChoice := UPCASE(MenuChoice);

        CASE MenuChoice OF
          'A' : FileHandler.DisplayFile;
          'B' : FileHandler.DisplayProductCount;
          'C' : FileHandler.Needreorder;
          'D' : FileHandler.FindRecord;
          'E' : FileHandler.AddProduct;
          'X' : FileHandler.CloseFile;
        ELSE
          BEGIN
            WRITELN('Not a character in the list');
            WRITELN('Please enter again');
          END;
        END;
        UNTIL MenuChoice = 'X';
    END;

  BEGIN
    FileHandler.InitialiseFile('N:\Pascal\Files\Stock.dta');
    Menu;
    FileHandler.CloseFile;
  END.
