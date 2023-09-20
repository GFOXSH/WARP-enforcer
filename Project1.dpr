program Project1;

{$SetPEFlags $0001}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FlushFileCache in 'FlushFileCache.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'WARP Enforcer';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
