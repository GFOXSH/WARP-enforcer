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
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  fll:integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
reg: TRegistry;
begin
reg := TRegistry.create;
try
reg.rootKey := HKEY_CURRENT_USER;
reg.openKey('Software\Microsoft\Direct3D\Application0', true);
reg.writeString('D3DBehaviors', 'FeatureLevelLimit=' + IntToStr(fll) + ';ForceWARP=1');
reg.writeString('Name', Edit1.Text);
finally
reg.free;
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
reg: TRegistry;
begin
reg := TRegistry.create;
try
reg.rootkey := HKEY_CURRENT_USER;
reg.openkey('Software\Microsoft\Direct3D\Application0', true);
reg.writestring('D3DBehaviors', 'FeatureLevelLimit=0;ForceWARP=0');
reg.writestring('Name', '');
finally
reg.free;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
shellexecute(0, nil, PChar(Edit1.Text), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
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
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
fll:=0;
end;

end.
