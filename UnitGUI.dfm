object ApplicationGUIForm: TApplicationGUIForm
  Left = 0
  Top = 0
  Caption = 'test ICD'
  ClientHeight = 299
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbCriteria: TLabel
    Left = 24
    Top = 16
    Width = 43
    Height = 13
    Caption = 'lbCriteria'
  end
  object lbResults: TLabel
    Left = 24
    Top = 95
    Width = 35
    Height = 13
    Caption = 'Results'
  end
  object lbNResults: TLabel
    Left = 104
    Top = 95
    Width = 63
    Height = 13
    Caption = 'Top results : '
  end
  object edCriteria: TEdit
    Left = 73
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'chol'#233'ra'
  end
  object btSearch: TButton
    Left = 24
    Top = 62
    Width = 170
    Height = 27
    Caption = 'Search'
    TabOrder = 1
    OnClick = btSearchClick
  end
  object cbLng: TComboBox
    Left = 24
    Top = 35
    Width = 170
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = 'Fran'#231'ais'
    Items.Strings = (
      'Fran'#231'ais'
      'N'#233'erlandais')
  end
  object memoResults: TMemo
    Left = 192
    Top = 234
    Width = 65
    Height = 57
    TabOrder = 3
    Visible = False
  end
  object edNResults: TEdit
    Left = 168
    Top = 95
    Width = 33
    Height = 21
    TabOrder = 4
    Text = '10'
  end
  object lbxResults: TListBox
    Left = 24
    Top = 114
    Width = 121
    Height = 167
    ItemHeight = 13
    TabOrder = 5
    OnClick = lbxResultsClick
  end
end
