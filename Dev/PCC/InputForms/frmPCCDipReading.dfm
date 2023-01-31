inherited PCCDipReading: TPCCDipReading
  Left = 297
  Top = 198
  Caption = 'Dip Reading'
  ClientHeight = 378
  ClientWidth = 607
  OldCreateOrder = True
  DesignSize = (
    607
    378)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 16
    Top = 64
    Width = 577
    Height = 49
    Shape = bsFrame
  end
  object Label1: TLabel [2]
    Left = 24
    Top = 68
    Width = 46
    Height = 15
    Caption = 'Tank No'
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 228
    Top = 68
    Width = 67
    Height = 15
    Caption = 'Dip Reading'
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 432
    Top = 68
    Width = 69
    Height = 15
    Caption = 'Date && Time'
    Transparent = True
  end
  object lblDesc: TLabel [5]
    Left = 16
    Top = 120
    Width = 577
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [6]
    Left = 557
    Top = 335
    Width = 35
    Height = 15
    Caption = 'Active'
    Transparent = True
  end
  object Bevel2: TBevel [7]
    Left = 16
    Top = 116
    Width = 577
    Height = 25
  end
  object btnOK: TDNMSpeedButton [8]
    Left = 158
    Top = 338
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'OK'
    Default = True
    DisableTransparent = False
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [9]
    Left = 371
    Top = 338
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancel'
    DisableTransparent = False
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object grdHoses: TwwDBGrid [10]
    Left = 16
    Top = 144
    Width = 577
    Height = 177
    Selected.Strings = (
      'DispenserNo'#9'15'#9'Dispenser No'#9#9
      'HoseNo'#9'15'#9'Hose No'#9#9
      'HoseMeterReading'#9'15'#9'Hose Meter Reading'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWindow
    FixedCols = 2
    ShowHorzScrollBar = True
    DataSource = dsDipReadingLines
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDrawFooterCell = grdHosesDrawFooterCell
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object wwDBEdit2: TwwDBEdit [11]
    Left = 228
    Top = 84
    Width = 153
    Height = 23
    DataField = 'DipReading'
    DataSource = dsDipReading
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBDateTimePicker1: TwwDBDateTimePicker [12]
    Left = 432
    Top = 84
    Width = 157
    Height = 23
    AutoFillDateAndTime = True
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'ReadingDateTime'
    DataSource = dsDipReading
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 2
    DisplayFormat = 'dd-mm-yyyy hh:nn:ss'
  end
  object cboTankNo: TwwDBLookupCombo [13]
    Left = 24
    Top = 84
    Width = 153
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'TankNo'#9'15'#9'TankNo'#9#9
      'TankDescription'#9'20'#9'TankDescription'#9#9)
    DataField = 'TankNo'
    DataSource = dsDipReading
    LookupTable = qryTanks
    LookupField = 'TankNo'
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnCloseUp = cboTankNoCloseUp
  end
  object cbActive: TwwCheckBox [14]
    Left = 567
    Top = 349
    Width = 15
    Height = 15
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbChecked
    Checked = True
    DataField = 'Active'
    DataSource = dsDipReading
    State = cbChecked
    TabOrder = 6
  end
  object pnlTitle: TDNMPanel [15]
    Left = 187
    Top = 6
    Width = 238
    Height = 45
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 234
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Dip Reading'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object qryDipReading: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCDipReading'
      'WHERE PCCDipReadingID = :PCCDipReadingID')
    Left = 496
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'PCCDipReadingID'
        Value = ''
      end>
    object qryDipReadingTankNo: TIntegerField
      FieldName = 'TankNo'
    end
    object qryDipReadingReadingDateTime: TDateTimeField
      FieldName = 'ReadingDateTime'
    end
    object qryDipReadingDipReading: TIntegerField
      FieldName = 'DipReading'
      EditFormat = '#########'
    end
    object qryDipReadingPCCDipReadingID: TIntegerField
      FieldName = 'PCCDipReadingID'
    end
    object qryDipReadingActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object qryDipReadingLines: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DRL.*, H.DispenserNo, HoseNo'
      'FROM tblPCCDipReadingLines DRL'
      'LEFT JOIN tblPCCHoses H Using(HoseID)'
      'WHERE DRL.PCCDipReadingID = :PCCDipReadingID')
    OnNewRecord = qryDipReadingLinesNewRecord
    Left = 544
    Top = 176
    ParamData = <
      item
        DataType = ftString
        Name = 'PCCDipReadingID'
        Value = ''
      end>
    object qryDipReadingLinesDispenserNo: TIntegerField
      DisplayLabel = 'Dispenser No'
      DisplayWidth = 15
      FieldName = 'DispenserNo'
      Origin = 'H.DispenserNo'
    end
    object qryDipReadingLinesHoseNo: TIntegerField
      DisplayLabel = 'Hose No'
      DisplayWidth = 15
      FieldName = 'HoseNo'
      Origin = 'H.HoseNo'
    end
    object qryDipReadingLinesHoseMeterReading: TLargeintField
      DisplayLabel = 'Hose Meter Reading'
      DisplayWidth = 20
      FieldName = 'HoseMeterReading'
      Origin = 'tblPCCDipReadingLines.HoseMeterReading'
      EditFormat = '###############'
    end
    object qryDipReadingLinesHoseID: TIntegerField
      DisplayWidth = 10
      FieldName = 'HoseID'
      Origin = 'tblPCCDipReadingLines.HoseID'
      Visible = False
    end
    object qryDipReadingLinesPCCDipReadingLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'PCCDipReadingLineID'
      Origin = 'tblPCCDipReadingLines.PCCDipReadingLineID'
      Visible = False
    end
    object qryDipReadingLinesPCCDipReadingID: TIntegerField
      DisplayWidth = 15
      FieldName = 'PCCDipReadingID'
      Origin = 'tblPCCDipReadingLines.PCCDipReadingID'
      Visible = False
    end
  end
  object dsDipReadingLines: TDataSource
    DataSet = qryDipReadingLines
    Left = 560
    Top = 200
  end
  object dsDipReading: TDataSource
    DataSet = qryDipReading
    Left = 520
    Top = 32
  end
  object qryTanks: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCTanks'
      'WHERE Active = "T"')
    Left = 72
    Top = 80
    object qryTanksTankNo: TIntegerField
      DisplayWidth = 15
      FieldName = 'TankNo'
    end
    object qryTanksTankDescription: TStringField
      DisplayWidth = 20
      FieldName = 'TankDescription'
      Size = 255
    end
  end
end
