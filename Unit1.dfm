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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 161
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 72
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Launch'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 168
    Top = 0
    Width = 65
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
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
    TabOrder = 3
  end
end
