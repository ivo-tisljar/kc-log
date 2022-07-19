object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = ' KC Log'
  ClientHeight = 449
  ClientWidth = 812
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object LabelLogFiles: TLabel
    Left = 416
    Top = 16
    Width = 46
    Height = 15
    Caption = 'Log Files'
    FocusControl = MemoLogFiles
  end
  object LabelDirectory: TLabel
    Left = 24
    Top = 16
    Width = 48
    Height = 15
    Caption = 'Directory'
    FocusControl = EditDirectory
  end
  object MemoLogFiles: TMemo
    Left = 416
    Top = 37
    Width = 369
    Height = 388
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ButtonLoadAndImport: TButton
    Left = 24
    Top = 207
    Width = 369
    Height = 25
    Caption = 'Load new log files and import them to SQL database'
    TabOrder = 1
    OnClick = ButtonLoadAndImportClick
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
