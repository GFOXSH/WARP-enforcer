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
fll,flu:Integer;
name:String;
begin
if isactive then
TerminateProcess(exeinf.hProcess, 0)
else
begin
name:=Edit1.Text;
case ComboBox1.ItemIndex of
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
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
filename:String;
begin
isactive:=false;
filename:=ExtractFileName(Application.ExeName);
case filename[1] of
'0':ComboBox1.ItemIndex:=0;
'1':ComboBox1.ItemIndex:=1;
'2':ComboBox1.ItemIndex:=2;
'3':ComboBox1.ItemIndex:=3;
'4':ComboBox1.ItemIndex:=4;
'5':ComboBox1.ItemIndex:=5;
'6':ComboBox1.ItemIndex:=6;
'7':ComboBox1.ItemIndex:=7;
'8':ComboBox1.ItemIndex:=0;
'9':ComboBox1.ItemIndex:=1;
'A':ComboBox1.ItemIndex:=2;
'B':ComboBox1.ItemIndex:=3;
'C':ComboBox1.ItemIndex:=4;
'D':ComboBox1.ItemIndex:=5;
'E':ComboBox1.ItemIndex:=6;
'F':ComboBox1.ItemIndex:=7;
end;
if filename[1] in ['8', '9', 'A', 'B', 'C', 'D', 'E', 'F'] then
CheckBox1.Checked:=true;
Edit1.Text:=Copy(filename, 2, Length(filename));

end;

end.
