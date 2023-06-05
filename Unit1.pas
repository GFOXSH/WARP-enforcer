unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, ShellAPI, IniFiles;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox2: TComboBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure ConfigRead;
    procedure OnProcessStart;
    procedure ConfigWrite;
  public
    { Public declarations }
  end;
  WaitForProcess = class(TThread)
  private
    procedure OnProcessEnd;
    procedure ButtonUpdate;
    procedure ProcessConfig;
  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  ExeInf: TShellExecuteInfo;
  IsActive: Boolean;
  PFileName, PDirectoryPath: PChar;
  ProcessPriority, ProcessAffinity: Dword;

implementation

{$R *.dfm}

procedure TForm1.ConfigRead;
var
  IniFile: TIniFile;
begin
  IniFile:=TIniFile.Create(GetCurrentDir+'\WARP.ini');
  Edit1.Text:=IniFile.ReadString('Main', 'FileName', 'DELTARUNE.exe');
  Edit2.Text:=IniFile.ReadString('Main', 'DirectoryPath', GetCurrentDir+ '\');
  CheckBox1.Checked:=IniFile.ReadBool('WARP', 'Enable', false);
  ComboBox1.ItemIndex:=IniFile.ReadInteger('WARP', 'FeatureLevelLimit', 0);
  CheckBox2.Checked:=IniFile.ReadBool('WARP', 'DisableFeatureLevelUpgrade', false);
  CheckBox3.Checked:=IniFile.ReadBool('CPU', 'Enable', false);
  ComboBox2.ItemIndex:=IniFile.ReadInteger('CPU', 'Priority', 3);
  CheckBox4.Checked:=IniFile.ReadBool('CPU', 'Core0', true);
  CheckBox5.Checked:=IniFile.ReadBool('CPU', 'Core1', true);
  CheckBox6.Checked:=IniFile.ReadBool('CPU', 'Core2', true);
  CheckBox7.Checked:=IniFile.ReadBool('CPU', 'Core3', true);
  CheckBox8.Checked:=IniFile.ReadBool('CPU', 'Core4', true);
  CheckBox9.Checked:=IniFile.ReadBool('CPU', 'Core5', true);
  CheckBox10.Checked:=IniFile.ReadBool('CPU', 'Core6', true);
  CheckBox11.Checked:=IniFile.ReadBool('CPU', 'Core7', true);
  IniFile.Free;
end;

procedure TForm1.OnProcessStart;
var
  FileName, DirectoryPath: AnsiString;
  FeatureLevelLimit, DisableFeatureLevelUpgrade: Integer;
  Registry: TRegistry;
  CpuSet: set of 0..31;
begin
  FileName:=Edit1.Text;
  GetMem(PFileName, Length(FileName) + 1);
  StrPLCopy(PFileName, FileName, Length(FileName) + 1);
  DirectoryPath:=Edit2.Text;
  GetMem(PDirectoryPath, Length(DirectoryPath) + 1);
  StrPLCopy(PDirectoryPath, DirectoryPath, Length(DirectoryPath) + 1);
  if CheckBox1.Checked then
  begin
    case ComboBox1.ItemIndex of
      0:FeatureLevelLimit:=0;
      1:FeatureLevelLimit:=StrToInt('$9100');
      2:FeatureLevelLimit:=StrToInt('$9200');
      3:FeatureLevelLimit:=StrToInt('$9300');
      4:FeatureLevelLimit:=StrToInt('$a000');
      5:FeatureLevelLimit:=StrToInt('$a100');
      6:FeatureLevelLimit:=StrToInt('$b000');
      7:FeatureLevelLimit:=StrToInt('$b100');
    else
      FeatureLevelLimit:=0;
    end;
    if CheckBox2.Checked then
      DisableFeatureLevelUpgrade:=1
    else
      DisableFeatureLevelUpgrade:=0;
    Registry:=TRegistry.Create;
    try
      Registry.RootKey:=HKEY_CURRENT_USER;
      Registry.OpenKey('Software\Microsoft\Direct3D\Application0', true);
      Registry.WriteString('Name', FileName);
      Registry.WriteString('D3DBehaviors', 'ForceWARP=1;FeatureLevelLimit='+IntToStr(FeatureLevelLimit)+';DisableFLUpgrade='+IntToStr(DisableFeatureLevelUpgrade));
    finally
      Registry.Free;
    end;
  end;
  if CheckBox3.Checked then
  begin
    case Combobox2.ItemIndex of
      0:ProcessPriority:=$00000100;
      1:ProcessPriority:=$00000080;
      2:ProcessPriority:=$00008000;
      3:ProcessPriority:=$00000020;
      4:ProcessPriority:=$00004000;
      5:ProcessPriority:=$00000040;
    else
      ProcessPriority:=$00000020;
    end;
    CpuSet:=[];
    if CheckBox4.Checked then
      Include(CpuSet, 0);
    if CheckBox5.Checked then
      Include(CpuSet, 1);
    if CheckBox6.Checked then
      Include(CpuSet, 2);
    if CheckBox7.Checked then
      Include(CpuSet, 3);
    if CheckBox8.Checked then
      Include(CpuSet, 4);
    if CheckBox9.Checked then
      Include(CpuSet, 5);
    if CheckBox10.Checked then
      Include(CpuSet, 6);
    if CheckBox11.Checked then
      Include(CpuSet, 7);
    ProcessAffinity:=Dword(CpuSet);
  end;
  FillChar(ExeInf,SizeOf(ExeInf), 0);
  with ExeInf do
  begin
    cbSize:=SizeOf(ExeInf);
    fMask:=SEE_MASK_NOCLOSEPROCESS;
    lpFile:=PFileName;
    lpDirectory:=PDirectoryPath;
    nShow:=SW_SHOWNORMAL;
  end;
  WaitForProcess.Create(false);
end;
  

procedure WaitForProcess.Execute;
begin
  if ShellExecuteEx(@ExeInf) then
  begin
    IsActive:=true;
    Synchronize(ButtonUpdate);
    Synchronize(ProcessConfig);
    WaitforSingleObject(ExeInf.hProcess, INFINITE);
    CloseHandle(ExeInf.hProcess);
    IsActive:=false;
    Synchronize(ButtonUpdate);
    Synchronize(OnProcessEnd);
  end;
end;

procedure WaitForProcess.ButtonUpdate;
begin
  if IsActive then
    Form1.Button1.Caption:='Break'
  else
    Form1.Button1.Caption:='Launch';
end;

procedure WaitForProcess.ProcessConfig;
begin
  if Form1.CheckBox3.Checked then
  begin
    SetPriorityClass(exeinf.hProcess, ProcessPriority);
    SetProcessAffinityMask(exeinf.hProcess, ProcessAffinity);
  end;
end;

procedure WaitForProcess.OnProcessEnd;
var
  Registry: TRegistry;
begin
  Registry:=TRegistry.Create;
  try
    Registry.RootKey:=HKEY_CURRENT_USER;
    Registry.DeleteKey('Software\Microsoft\Direct3D\Application0');
  finally
    Registry.Free;
  end;
  FreeMem(PFileName);
  FreeMem(PDirectoryPath);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  IsActive:=false;
  ConfigRead;
end;

procedure TForm1.ConfigWrite;
var
  IniFile: TIniFile;
begin
  IniFile:=TiniFile.Create(GetCurrentDir+'\WARP.ini');
  IniFile.WriteString('Main', 'FileName', Edit1.Text);
  IniFile.WriteString('Main', 'DirectoryPath', Edit2.Text);
  IniFile.WriteBool('WARP', 'Enable', CheckBox1.Checked);
  IniFile.WriteInteger('WARP', 'FeatureLevelLimit', ComboBox1.ItemIndex);
  IniFile.WriteBool('WARP', 'DisableFeatureLevelUpgrade', CheckBox2.Checked);
  IniFile.WriteBool('CPU', 'Enable', CheckBox3.Checked);
  IniFile.WriteInteger('CPU', 'Priority', ComboBox2.ItemIndex);
  IniFile.WriteBool('CPU', 'Core0', CheckBox4.Checked);
  IniFile.WriteBool('CPU', 'Core1', CheckBox5.Checked);
  IniFile.WriteBool('CPU', 'Core2', CheckBox6.Checked);
  IniFile.WriteBool('CPU', 'Core3', CheckBox7.Checked);
  IniFile.WriteBool('CPU', 'Core4', CheckBox8.Checked);
  IniFile.WriteBool('CPU', 'Core5', CheckBox9.Checked);
  IniFile.WriteBool('CPU', 'Core6', CheckBox10.Checked);
  IniFile.WriteBool('CPU', 'Core7', CheckBox11.Checked);
  IniFile.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if IsActive then
    TerminateProcess(ExeInf.hProcess, 0)
  else
  begin
    OnProcessStart;
    ConfigWrite;
  end;
end;

end.
