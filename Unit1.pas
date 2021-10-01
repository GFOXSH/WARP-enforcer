unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, ShellAPI;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
reg:TRegistry;
fll,flu:Integer;
begin
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
reg.WriteString('D3DBehaviors', 'FeatureLevelLimit='+inttostr(fll)+';ForceWARP=1;DisableFLUpgrade='+inttostr(flu));
reg.WriteString('Name', Edit1.Text);
finally
reg.Free;
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
reg:TRegistry;
begin
reg:=TRegistry.Create;
try
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey('Software\Microsoft\Direct3D\Application0', true);
reg.WriteString('D3DBehaviors', 'FeatureLevelLimit=0;ForceWARP=0;DisableFLUpgrade=0');
reg.WriteString('Name', '');
finally
reg.Free;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ShellExecute(0, nil, PChar(Edit1.Text), nil, nil, SW_SHOWNORMAL);
end;

end.
