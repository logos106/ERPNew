inherited frmClassificationExtraPayRates: TfrmClassificationExtraPayRates
  Left = 230
  Top = 185
  HelpContext = 569000
  Caption = 'frmClassificationExtraPayRates'
  ClientHeight = 501
  ClientWidth = 817
  OldCreateOrder = True
  ExplicitLeft = 230
  ExplicitTop = 185
  ExplicitWidth = 833
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 501
    Width = 817
    HelpContext = 569008
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 48
    Top = 40
    Width = 610
    Height = 227
    HelpContext = 569001
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object grdExtraPayRates: TwwDBGrid
      Left = 1
      Top = 1
      Width = 608
      Height = 225
      HelpContext = 569002
      ControlType.Strings = (
        'PayRateType;CustomEdit;cboTypeID;F'
        'SuperInc;CustomEdit;chkSuper;F'
        'ExtraPayRate;CustomEdit;ExtraPayRate;F'
        'Amount;CustomEdit;edAmount;F'
        'Worked;CustomEdit;edWorked;F')
      Selected.Strings = (
        'ExtraPayRate'#9'18'#9'Pay Rate'#9'F'
        'PayRateType'#9'20'#9'Type'#9'F'
        'Worked'#9'13'#9'Hours'#9'F'
        'Amount'#9'19'#9'Amount'#9'F'
        'SuperInc'#9'7'#9'Super'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSExtraRates
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      object btnClassificationExtraPayrates: TwwIButton
        Left = 0
        Top = 0
        Width = 23
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnClassificationExtraPayratesClick
        HelpContext = 569009
      end
    end
    object ExtraPayRate: TwwDBLookupCombo
      Left = 119
      Top = 31
      Width = 70
      Height = 23
      HelpContext = 569003
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'100'#9'Description'#9#9)
      DataField = 'PayRate'
      DataSource = DSExtraRates
      LookupTable = qryExtraPayRates
      LookupField = 'RateID'
      Style = csDropDownList
      DropDownWidth = 100
      ParentFont = False
      TabOrder = 1
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboTypeID: TwwDBLookupCombo
      Left = 218
      Top = 32
      Width = 61
      Height = 23
      HelpContext = 569004
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'50'#9'Description'#9#9)
      DataField = 'PayRateType'
      DataSource = DSExtraRates
      LookupTable = qryPayRateType
      LookupField = 'TypeID'
      Style = csDropDownList
      DropDownCount = 4
      DropDownWidth = 100
      ParentFont = False
      TabOrder = 2
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object edAmount: TwwDBEdit
      Left = 136
      Top = 152
      Width = 81
      Height = 23
      HelpContext = 569005
      DataField = 'Amount'
      DataSource = DSExtraRates
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edWorked: TwwDBEdit
      Left = 392
      Top = 120
      Width = 73
      Height = 23
      HelpContext = 569006
      DataField = 'Worked'
      DataSource = DSExtraRates
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object chkSuper: TwwCheckBox
      Left = 280
      Top = 136
      Width = 25
      Height = 17
      HelpContext = 569007
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      DataField = 'SuperInc'
      DataSource = DSExtraRates
      TabOrder = 5
    end
  end
  object DSExtraRates: TDataSource
    Left = 697
    Top = 186
  end
  object qryPayRateType: TERPQuery
    SQL.Strings = (
      'Select TypeID, Description'
      'FROM tblPayRateType')
    Left = 706
    Top = 103
  end
  object qryExtraPayRates: TERPQuery
    SQL.Strings = (
      'Select RateID, Description, Multiplier'
      'FROM tblPayRates '
      'WHERE Description <> '#39'Normal Hours'#39
      'AND Active='#39'T'#39)
    Left = 713
    Top = 31
  end
end
