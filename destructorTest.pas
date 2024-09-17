program destructorTest;
  uses crt, sysutils;

  type
    bob = class

      public
        number : LONGINT;
        constructor Create;
        //destructor Destroy;
        procedure add;


      end;

   var bill : bob;

    constructor bob.Create;
      begin
        writeln('create');
        //number := 1;
      end;

    {destructor bob.Destroy;
      begin
      end;       }

    procedure bob.add;
      begin
        number := 2;
      end;


    begin
      bill.create;
      bill.add;
      //bill.free;
      readln;
    end.
