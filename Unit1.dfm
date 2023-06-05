object Form1: TForm1
  Left = 338
  Top = 354
  BorderStyle = bsDialog
  Caption = 'WARP Enforcer'
  ClientHeight = 286
  ClientWidth = 202
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
    Width = 201
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 0
    Top = 24
    Width = 201
    Height = 21
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 185
    Height = 97
    Caption = 'WARP'
    TabOrder = 2
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Enable'
      TabOrder = 0
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 40
      Width = 169
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
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
    object CheckBox2: TCheckBox
      Left = 8
      Top = 72
      Width = 169
      Height = 17
      Caption = 'Disable Feature Level Upgrade'
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 152
    Width = 185
    Height = 97
    Caption = 'CPU'
    TabOrder = 3
    object CheckBox3: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Enable'
      TabOrder = 0
    end
    object ComboBox2: TComboBox
      Left = 8
      Top = 40
      Width = 169
      Height = 21
      ItemHeight = 13
      ItemIndex = 3
      TabOrder = 1
      Text = 'Normal'
      Items.Strings = (
        'Realtime'
        'High'
        'Above normal'
        'Normal'
        'Below normal'
        'Low')
    end
    object CheckBox4: TCheckBox
      Left = 24
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 2
    end
    object CheckBox5: TCheckBox
      Left = 40
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 3
    end
    object CheckBox6: TCheckBox
      Left = 56
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 4
    end
    object CheckBox7: TCheckBox
      Left = 72
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 5
    end
    object CheckBox8: TCheckBox
      Left = 88
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 6
    end
    object CheckBox9: TCheckBox
      Left = 104
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 7
    end
    object CheckBox10: TCheckBox
      Left = 120
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 8
    end
    object CheckBox11: TCheckBox
      Left = 136
      Top = 72
      Width = 17
      Height = 17
      TabOrder = 9
    end
  end
  object Button1: TButton
    Left = 8
    Top = 256
    Width = 185
    Height = 25
    Caption = 'Launch'
    TabOrder = 4
    OnClick = Button1Click
  end
end
