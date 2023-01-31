inherited frmAwardClassifications: TfrmAwardClassifications
  Left = 172
  Top = 165
  HelpContext = 563000
  Caption = 'frmAwardClassifications'
  ClientHeight = 513
  ClientWidth = 895
  OldCreateOrder = True
  ExplicitLeft = 172
  ExplicitTop = 165
  ExplicitWidth = 911
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 513
    Width = 895
    ExplicitTop = 513
    ExplicitWidth = 895
    HelpContext = 563010
  end
  object pnlAwardClassifications: TDNMPanel [4]
    Left = 32
    Top = 61
    Width = 799
    Height = 420
    HelpContext = 563001
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      799
      420)
    object Bevel1: TBevel
      Left = 1
      Top = 171
      Width = 797
      Height = 39
      HelpContext = 563002
      Align = alTop
      Shape = bsFrame
      ExplicitLeft = 0
      ExplicitWidth = 796
    end
    object grdClassification: TwwDBGrid
      Tag = 1
      Left = 1
      Top = 1
      Width = 797
      Height = 170
      HelpContext = 563003
      ControlType.Strings = (
        'Type;CustomEdit;ClassificationType;T'
        'Description;CustomEdit;AdvanceID;T'
        'Description;CustomEdit;AdvanceID;F'
        'AdvanceID;CustomEdit;cboAdvanceID;F'
        'AdvanceIDName;CustomEdit;cboAdvanceID;F'
        'AdvanceToClassification;CustomEdit;cboNextLevel;F')
      Selected.Strings = (
        'Classification'#9'20'#9'~~Classification'#9'F'
        'Type'#9'20'#9'~~Type'#9'F'
        'FullTime'#9'15'#9'Full Time'#9'F'#9'Rates'
        'PartTime'#9'15'#9'Part Time'#9'F'#9'Rates'
        'Casual'#9'15'#9'Casual'#9'F'#9'Rates'
        'CasualLoading'#9'20'#9'~Casual~Loading %'#9'F'
        'AdvanceIDName'#9'20'#9'Advance to~Next Level from~Start Date/ DOB'#9'F'
        'AdvanceToClassification'#9'15'#9'~~Next Level'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdClassificationRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alTop
      DataSource = DSClassificationDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgProportionalColResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 3
      TitleButtons = True
      UseTFields = False
      FooterColor = clWhite
      object btnClassification: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 48
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
        OnClick = btnClassificationClick
        HelpContext = 563011
      end
    end
    object ClassificationType: TwwDBLookupCombo
      Left = 338
      Top = 75
      Width = 58
      Height = 23
      HelpContext = 563005
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'20'#9'Description'#9'F')
      DataField = 'Type'
      DataSource = DSClassificationDetails
      LookupTable = qryPayRateType
      LookupField = 'Description'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAdvanceID: TwwDBLookupCombo
      Left = 575
      Top = 68
      Width = 70
      Height = 23
      HelpContext = 563006
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'25'#9'Description'#9#9)
      DataField = 'AdvanceIDName'
      DataSource = DSClassificationDetails
      LookupTable = qryAwardAdvance
      LookupField = 'Description'
      Style = csDropDownList
      DropDownWidth = 75
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object cboNextLevel: TwwDBLookupCombo
      Left = 671
      Top = 76
      Width = 70
      Height = 23
      HelpContext = 563007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'Classification'#9'30'#9'Classification'#9'T')
      DataField = 'AdvanceToClassification'
      DataSource = DSClassificationDetails
      LookupTable = qryNextClassifications
      LookupField = 'Classification'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object sbPrefs: TScrollBox
      Left = 1
      Top = 210
      Width = 797
      Height = 209
      HelpContext = 563008
      HorzScrollBar.Visible = False
      Align = alClient
      BevelInner = bvNone
      BevelKind = bkSoft
      BorderStyle = bsNone
      TabOrder = 4
    end
    object pnlButtons: TDNMPanel
      Left = 3
      Top = 174
      Width = 793
      Height = 35
      HelpContext = 563009
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 5
      Transparent = False
    end
  end
  object DSClassificationDetails: TDataSource
    Left = 200
    Top = 32
  end
  object qryPayRateType: TERPQuery
    SQL.Strings = (
      'Select TypeID, Description'
      'FROM tblPayRateType')
    Left = 498
    Top = 65535
  end
  object qryAwardAdvance: TERPQuery
    SQL.Strings = (
      'Select AdvanceID, Description'
      'FROM tblAwardAdvance')
    Left = 467
    Top = 65535
    object qryAwardAdvanceDescription: TWideStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 25
    end
    object qryAwardAdvanceAdvanceID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AdvanceID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryNextClassifications: TERPQuery
    SQL.Strings = (
      'Select ClassificationID,Classification '
      'from tblawardclassificationdetails '
      'WHERE AwardID = :xAwardID'
      'AND ClassificationID<>:xClassificationID;')
    Left = 578
    Top = 7
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
  end
  object MyConnection1: TERPConnection
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Left = 88
    Top = 376
  end
end
