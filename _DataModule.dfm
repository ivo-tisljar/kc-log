object DataLink: TDataLink
  Height = 480
  Width = 640
  PixelsPerInch = 96
  object FDConnection: TFDConnection
    Params.Strings = (
      'Server=DAWN\SQLDEV'
      'Database=KCLog'
      'OSAuthent=Yes'
      'ApplicationName=Enterprise/Architect/Ultimate'
      'Workstation=DAWN'
      'MARS=yes'
      'DriverID=MSSQL')
    Left = 144
    Top = 160
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 368
    Top = 160
  end
end
