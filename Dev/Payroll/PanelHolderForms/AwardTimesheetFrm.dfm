inherited frmAwardTimesheet: TfrmAwardTimesheet
  Left = 263
  Top = 160
  Width = 914
  Height = 528
  HelpContext = 566000
  Caption = 'frmAwardTimesheet'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel2: TDNMPanel
    Left = 24
    Top = 66
    Width = 799
    Height = 308
    HelpContext = 566001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      799
      308)
    object Bevel2: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 293
      HelpContext = 566002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object wwDBGrid1: TwwDBGrid
      Left = 16
      Top = 16
      Width = 766
      Height = 276
      HelpContext = 566003
      ControlType.Strings = (
        'PayRate;CustomEdit;PayRate;F'
        'Rate1PayRate;CustomEdit;PayRate1;F'
        'PayRate1;CustomEdit;PayRate1;F')
      Selected.Strings = (
        'PayRate'#9'12'#9'PayRate'#9'F'
        'StartDay'#9'7'#9'~Day'#9'F'#9'Shift Start'
        'StartTime'#9'7'#9'Start Time'#9'F'#9'Shift Start'
        'EndDay'#9'7'#9'EndDay'#9'F'#9'Shift End'
        'EndTime'#9'7'#9'EndTime'#9'F'#9'Shift End'
        'Rate1AfterHours'#9'7'#9'After~Hours'#9'F'
        'PayRate1'#9'29'#9'PayRate1'#9'F'
        'Rate2AfterHours'#9'7'#9'Rate2AfterHours'#9'F'
        'Rate2PayRate'#9'7'#9'Rate2PayRate'#9'F'
        'SuperInc'#9'7'#9'SuperInc'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clwhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSAwardShifts
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 4
      TitleButtons = True
      UseTFields = False
    end
    object PayRate: TwwDBLookupCombo
      Left = 100
      Top = 126
      Width = 74
      Height = 23
      HelpContext = 566004
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'100'#9'Description'#9#9)
      DataField = 'PayRate'
      DataSource = DSAwardShifts
      LookupTable = qryPayRates
      LookupField = 'RateID'
      DropDownWidth = 100
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object PayRate1: TwwDBLookupCombo
      Left = 373
      Top = 126
      Width = 60
      Height = 23
      HelpContext = 566005
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'100'#9'Description'#9#9)
      DataField = 'Rate1PayRate'
      DataSource = DSAwardShifts
      LookupTable = qryPayRatesOnly
      LookupField = 'RateID'
      DropDownWidth = 100
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
  object DSAwardShifts: TDataSource
    Left = 256
    Top = 8
  end
  object qryPayRates: TERPQuery
    SQL.Strings = (
      'Select RateID, Description, Multiplier'
      'FROM tblPayRates')
    Left = 460
    Top = 15
    object qryPayRatesDescription: TWideStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Size = 100
    end
    object qryPayRatesRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'RateID'
      ReadOnly = True
      Visible = False
    end
    object qryPayRatesMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'Multiplier'
      Visible = False
    end
  end
  object qryPayRatesOnly: TERPQuery
    SQL.Strings = (
      'SELECT RateID,Description FROM tblpayrates'
      'WHERE IsPayRate = '#39'T'#39)
    Left = 635
    Top = 23
  end
end
