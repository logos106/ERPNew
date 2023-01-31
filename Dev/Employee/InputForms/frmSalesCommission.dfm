inherited fmSalesCommission: TfmSalesCommission
  Left = 272
  Top = 222
  HelpContext = 691000
  Caption = 'Sales Commission Update'
  ClientHeight = 356
  ClientWidth = 574
  OldCreateOrder = True
  ExplicitTop = 8
  ExplicitWidth = 580
  ExplicitHeight = 384
  DesignSize = (
    574
    356)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 71
    Width = 574
    HelpContext = 691027
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 71
    Width = 574
    Height = 285
    HelpContext = 691004
    Align = alBottom
    Anchors = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      574
      285)
    object Label1: TLabel
      Left = 10
      Top = 21
      Width = 110
      Height = 15
      HelpContext = 691005
      Caption = 'Last Update Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 48
      Top = 56
      Width = 144
      Height = 15
      HelpContext = 691006
      Caption = 'Commission Calulated By'
      Transparent = True
    end
    object Label3: TLabel
      Left = 46
      Top = 88
      Width = 146
      Height = 15
      HelpContext = 691007
      Caption = 'Commission Calulated On'
      Transparent = True
    end
    object Label5: TLabel
      Left = 46
      Top = 120
      Width = 159
      Height = 15
      HelpContext = 691008
      Caption = 'Commission Calulated From'
      Transparent = True
    end
    object Label6: TLabel
      Left = 46
      Top = 152
      Width = 143
      Height = 15
      HelpContext = 691009
      Caption = 'Commission Calulated To'
      Transparent = True
    end
    object Label8: TLabel
      Left = 390
      Top = 120
      Width = 93
      Height = 15
      HelpContext = 691010
      Caption = 'Whole Database'
      Transparent = True
    end
    object Panel4: TDNMPanel
      Left = 1
      Top = 176
      Width = 572
      Height = 108
      HelpContext = 691011
      Align = alBottom
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel1: TBevel
        Left = 10
        Top = 26
        Width = 264
        Height = 71
        HelpContext = 691012
      end
      object Label9: TLabel
        Left = 39
        Top = 42
        Width = 29
        Height = 15
        HelpContext = 691013
        Caption = '&From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 162
        Top = 42
        Width = 13
        Height = 15
        HelpContext = 691014
        Caption = '&To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 10
        Top = 8
        Width = 209
        Height = 15
        HelpContext = 691015
        Caption = 'Calculate Commission for the period '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 94
        Top = 72
        Width = 93
        Height = 15
        HelpContext = 691016
        Caption = 'Whole Database'
        Transparent = True
      end
      object dtFrom: TwwDBDateTimePicker
        Left = 75
        Top = 38
        Width = 82
        Height = 22
        HelpContext = 691017
        TabStop = False
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 4
        CalendarAttributes.PopupYearOptions.StartYear = 1980
        Date = 37432.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 0
        UnboundDataType = wwDTEdtDate
      end
      object dtTo: TwwDBDateTimePicker
        Left = 179
        Top = 38
        Width = 82
        Height = 22
        HelpContext = 691018
        TabStop = False
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 6
        Date = 37432.000000000000000000
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        UnboundDataType = wwDTEdtDate
      end
      object btnDoCalc: TDNMSpeedButton
        Left = 291
        Top = 48
        Width = 155
        Height = 27
        Hint = 'Calculate the Sales Commission'
        HelpContext = 691019
        Caption = 'Calculate Commission'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        TabStop = False
        OnClick = btnDoCalcClick
      end
      object cmdClose: TDNMSpeedButton
        Left = 463
        Top = 48
        Width = 87
        Height = 27
        Hint = '"Close The Form"'
        HelpContext = 691020
        Caption = '&Close'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ModalResult = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        TabStop = False
        OnClick = cmdCloseClick
      end
      object chkAll: TCheckBox
        Left = 72
        Top = 70
        Width = 17
        Height = 17
        HelpContext = 691021
        TabOrder = 4
        OnClick = chkAllClick
      end
    end
    object wwDBEdit1: TwwDBEdit
      Left = 224
      Top = 52
      Width = 323
      Height = 23
      HelpContext = 691022
      DataField = 'EmployeeName'
      DataSource = dsMain
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit2: TwwDBEdit
      Left = 224
      Top = 84
      Width = 121
      Height = 23
      HelpContext = 691023
      DataField = 'CommissionCalculatedOn'
      DataSource = dsMain
      ReadOnly = True
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit3: TwwDBEdit
      Left = 224
      Top = 116
      Width = 121
      Height = 23
      HelpContext = 691024
      DataField = 'DateFrom'
      DataSource = dsMain
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit4: TwwDBEdit
      Left = 224
      Top = 148
      Width = 121
      Height = 23
      HelpContext = 691025
      DataField = 'Dateto'
      DataSource = dsMain
      ReadOnly = True
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object chkignoredaterange: TwwCheckBox
      Left = 367
      Top = 121
      Width = 15
      Height = 17
      HelpContext = 691026
      TabStop = False
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akBottom]
      Caption = 'chkApplycredits'
      DataField = 'IgnoredateRange'
      DataSource = dsMain
      TabOrder = 5
      ReadOnly = True
    end
  end
  object pnlHeader: TPanel [5]
    Left = 63
    Top = 5
    Width = 463
    Height = 49
    HelpContext = 691001
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 461
      Height = 47
      HelpContext = 691002
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 461
        Height = 47
        HelpContext = 691003
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Sales Commission Update'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200A000AC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select '
      
        'SC.*  , concat_ws('#39' '#39' , `E`.`FirstName`,`E`.`MiddleName`,`E`.`La' +
        'stName`) as EmployeeName'
      'from tblsalescommissionupdates SC'
      'inner join tblEmployees e on E.employeeId = SC.EmployeeId'
      'Order by CommissionCalculatedOn desc'
      'Limit 1')
    Filtered = True
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    IndexFieldNames = 'CommissionCalculatedOn'
    Left = 239
    Top = 105
    object qryMainglobalref: TWideStringField
      FieldName = 'globalref'
      Origin = 'tblsalescommissionupdates.globalref'
      Size = 255
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblsalescommissionupdates.ID'
    end
    object qryMainCommissionCalculatedOn: TDateTimeField
      FieldName = 'CommissionCalculatedOn'
      Origin = 'tblsalescommissionupdates.CommissionCalculatedOn'
    end
    object qryMainDateFrom: TDateTimeField
      FieldName = 'DateFrom'
      Origin = 'tblsalescommissionupdates.DateFrom'
    end
    object qryMainDateto: TDateTimeField
      FieldName = 'Dateto'
      Origin = 'tblsalescommissionupdates.Dateto'
    end
    object qryMainemployeeID: TIntegerField
      FieldName = 'employeeID'
      Origin = 'tblsalescommissionupdates.employeeID'
    end
    object qryMainmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblsalescommissionupdates.mstimestamp'
    end
    object qryMainEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = '.EmployeeName'
      Size = 122
    end
    object qryMainIgnoredateRange: TWideStringField
      FieldName = 'IgnoredateRange'
      FixedChar = True
      Size = 1
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 206
    Top = 104
  end
end
