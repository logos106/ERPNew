inherited frmPayrollRateSelectorGUI: TfrmPayrollRateSelectorGUI
  Left = 399
  Top = 289
  HelpContext = 320000
  Caption = 'Hourly Rate Selector'
  ClientHeight = 329
  ClientWidth = 457
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 320001
  end
  object grdRates: TwwDBGrid [1]
    Left = 0
    Top = 104
    Width = 457
    Height = 145
    HelpContext = 320002
    Selected.Strings = (
      'Rate'#9'15'#9'Rate')
    IniAttributes.Delimiter = ';;'
    TitleColor = clwhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsRates
    ReadOnly = True
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDblClick = grdRatesDblClick
  end
  object DNMPanel2: TDNMPanel [2]
    Left = 0
    Top = 250
    Width = 457
    Height = 79
    HelpContext = 320003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      457
      79)
    object Label2: TLabel
      Left = 56
      Top = 11
      Width = 99
      Height = 15
      HelpContext = 320004
      Caption = 'New Hourly Rate :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnSave: TDNMSpeedButton
      Left = 184
      Top = 36
      Width = 87
      Height = 27
      HelpContext = 320005
      Anchors = [akLeft, akBottom]
      Caption = '&Select'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object txtNewRate: TEdit
      Left = 168
      Top = 8
      Width = 121
      Height = 23
      HelpContext = 320006
      TabOrder = 1
      Text = '0.00'
      OnExit = txtNewRateExit
      OnKeyPress = txtNewRateKeyPress
    end
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 52
    Width = 457
    Height = 50
    HelpContext = 320007
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14221420
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 455
      Height = 48
      HelpContext = 320008
      Align = alTop
      AutoSize = False
      Caption = '- x -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
  end
  object pnlTitle: TDNMPanel [4]
    Left = 70
    Top = 4
    Width = 308
    Height = 39
    HelpContext = 320009
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Invoice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 306
      Height = 37
      HelpContext = 320010
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
        Width = 306
        Height = 37
        HelpContext = 320011
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Hourly Rate Selector'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 368
    Top = 59
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 422
  end
  inherited MyConnection: TERPConnection
    Left = 28
    Top = 21
  end
  inherited DataState: TDataState
    Left = 9
    Top = 14
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 73
    Top = 40
  end
  object qryEmployeeRates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EPR.EmployeeRateID, EPR.HourlyRate AS Rate, '
      'EPR.ClassID, EPR.LineTotal, EPR.Qty'
      'FROM tblemployeepayrates AS EPR'
      'INNER JOIN tblpayrates AS PR on EPR.PayRateID = PR.RateID'
      'WHERE EPR.EmployeeID = :xEmpID AND PR.Multiplier = 1'
      'ORDER BY HourlyRate')
    Left = 338
    Top = 59
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xEmpID'
      end>
    object qryEmployeeRatesRate: TFloatField
      DisplayWidth = 15
      FieldName = 'Rate'
      currency = True
    end
    object qryEmployeeRatesEmployeeRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'EmployeeRateID'
      ReadOnly = True
      Visible = False
    end
    object qryEmployeeRatesClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryEmployeeRatesLineTotal: TFloatField
      FieldName = 'LineTotal'
    end
    object qryEmployeeRatesQty: TFloatField
      FieldName = 'Qty'
    end
  end
  object dsRates: TDataSource
    DataSet = qryEmployeeRates
    Left = 338
    Top = 91
  end
end
