object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = ' KC Log'
  ClientHeight = 441
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 416
    Top = 16
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object LabelDirectory: TLabel
    Left = 24
    Top = 16
    Width = 48
    Height = 15
    Caption = 'Directory'
    FocusControl = EditDirectory
  end
  object Memo: TMemo
    Left = 416
    Top = 37
    Width = 369
    Height = 388
    Lines.Strings = (
      'Memo')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ButtonObrada: TButton
    Left = 24
    Top = 183
    Width = 369
    Height = 25
    Caption = 'Obrada'
    TabOrder = 1
    OnClick = ButtonObradaClick
  end
  object EditDirectory: TEdit
    Left = 24
    Top = 37
    Width = 369
    Height = 23
    TabOrder = 2
    Text = 'D:\KC\SURADNICI\'
  end
end
