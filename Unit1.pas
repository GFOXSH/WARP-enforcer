unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, ShellAPI;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  ingame = class(TThread)
  private
    procedure Button;
  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  reg:TRegistry;
  exeinf: TShellExecuteInfo;
  isactive:Boolean;

implementation

{$R *.dfm}

procedure ingame.Execute;
begin
if ShellExecuteEx(@exeinf) then
begin
isactive:=true;
Synchronize(Button);
WaitforSingleObject(exeinf.hProcess, INFINITE);
CloseHandle(exeinf.hProcess);
end;
reg:=TRegistry.Create;
try
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey('Software\Microsoft\Direct3D\Application0', true);
reg.WriteString('D3DBehaviors', 'FeatureLevelLimit=0;ForceWARP=0;DisableFLUpgrade=0');
reg.WriteString('Name', '');
finally
reg.Free;
end;
isactive:=false;
Synchronize(Button);
end;

procedure ingame.Button;
begin
if isactive then
Form1.Button1.Caption:='Break'
else
Form1.Button1.Caption:='Launch';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
config:TextFile;
fll,res:Integer;
cfll,flu:Byte;
name:String;
begin
if isactive then
TerminateProcess(exeinf.hProcess, 0)
else
begin
name:=Edit1.Text;
if name='' then
exit;
cfll:=ComboBox1.ItemIndex;
case cfll of
0:fll:=0;
1:fll:=StrToInt('$9100');
2:fll:=StrToInt('$9200');
3:fll:=StrToInt('$9300');
4:fll:=StrToInt('$a000');
5:fll:=StrToInt('$a100');
6:fll:=StrToInt('$b000');
7:fll:=StrToInt('$b100');
else fll:=0;
end;
if CheckBox1.Checked then
flu:=1
else
flu:=0;
reg:=TRegistry.Create;
try
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey('Software\Microsoft\Direct3D\Application0', true);
reg.WriteString('D3DBehaviors', 'FeatureLevelLimit='+IntToStr(fll)+';ForceWARP=1;DisableFLUpgrade='+IntToStr(flu));
reg.WriteString('Name', name);
finally
reg.Free;
end;
FillChar(exeinf,SizeOf(exeinf), 0);
with exeinf do
begin
cbSize:=SizeOf(exeinf);
fMask:=SEE_MASK_NOCLOSEPROCESS;
lpFile:=PChar(name);
nShow:=SW_SHOWNORMAL;
end;
ingame.Create(false);
AssignFile(config, 'config.inf');
{$I-}
ReWrite(config);
{$I+}
res:=IOResult;
if res<>0 then
Exit;
WriteLn(config, name);
WriteLn(config, cfll);
WriteLn(config, flu);
CloseFile(config);
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
config:TextFile;
name:String;
cfll,flu:Byte;
res:Integer;
begin
isactive:=false;
AssignFile(config, 'config.inf');
{$I-}
Reset(config);
{$I+}
res:=IOResult;
if res<>0 then
Exit;
name:='';
cfll:=0;
flu:=0;
Try
ReadLn(config, name);
ReadLn(config, cfll);
ReadLn(config, flu);
Except
CloseFile(config);
Exit;
end;
CloseFile(config);
if name <> '' then
Edit1.Text:=name
else
exit;
if cfll in [0, 1, 2, 3, 4, 5, 6, 7] then
ComboBox1.ItemIndex:=cfll
else
exit;
if flu = 1 then
CheckBox1.Checked:=true;
end;

end.
