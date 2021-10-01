object Form1: TForm1
  Left = 0
  Top = 0
  Width = 251
  Height = 115
  Caption = 'Basic WARP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 161
    Height = 21
    TabOrder = 0
    Text = 'DELTARUNE.exe'
  end
  object Button1: TButton
    Left = 0
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Enable'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 80
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 160
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Disable'
    TabOrder = 3
    OnClick = Button3Click
  end
  object ComboBox1: TComboBox
    Left = 168
    Top = 0
    Width = 65
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 4
    Text = 'None'
    Items.Strings = (
      'None'
      '9_1'
      '9_2'
      '9_3'
      '10_0'
      '10_1'
      '11_0'
      '11_1')
  end
  object CheckBox1: TCheckBox
    Left = 0
    Top = 24
    Width = 233
    Height = 17
    Caption = 'Disable feature level upgrade'
    TabOrder = 5
  end
end
