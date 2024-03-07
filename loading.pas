unit loading;
interface

uses sysutils, vputils, crt;

var loadingDone : BOOLEAN;

function loadingText(p : pointer) : LONGINT;
  var a : LONGINT;
  LoadingSymbols : String[4];
procedure StartLoading;
procedure EndLoading;

implementation


function loadingText(p : pointer) : LONGINT;
  var a : LONGINT;
    LoadingSymbols : String[4];
  begin
    HideCursor;
    LoadingSymbols := '/-\|';
    a := 1;
    ClrScr;
    while (not loadingDone) DO
      Begin
        WRITELN('Loading... ' + LoadingSymbols[a]);
        a := a+1;
        if a > 4 THEN
          a := 1;
        Delay(100);
        GoToXY(1,1);
        DelLine;
      end;

    end;

procedure StartLoading;
  begin
    loadingDone := false;
    VPBeginThread(loadingText,1,nil);
  End;

procedure EndLoading;
  begin
    KillThread(1);
    loadingDone := true;
    WRITELN('Done!');
    Delay(500);
    ClrScr;
    Show
Cursor;
    end;
end.
