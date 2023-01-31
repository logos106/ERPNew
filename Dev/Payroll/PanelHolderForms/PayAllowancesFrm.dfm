inherited frmPayAllowances: TfrmPayAllowances
  Left = 339
  Top = 257
  HelpContext = 572000
  Caption = 'frmPayAllowances'
  ClientHeight = 592
  ClientWidth = 993
  OldCreateOrder = True
  ExplicitLeft = 339
  ExplicitTop = 257
  ExplicitWidth = 1009
  ExplicitHeight = 631
  DesignSize = (
    993
    592)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 592
    Width = 993
    HelpContext = 572013
    ExplicitTop = 592
    ExplicitWidth = 993
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 18
    Top = 46
    Width = 922
    Height = 289
    HelpContext = 572001
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      922
      289)
    object Bevel1: TBevel
      Left = 9
      Top = 9
      Width = 904
      Height = 271
      HelpContext = 572002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object grdAllowances: TwwDBGrid
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 898
      Height = 202
      HelpContext = 572003
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 11
      ControlType.Strings = (
        'AllowanceDept;CustomEdit;AllowDept;T'
        'Allowance;CustomEdit;cboAllowance;F'
        'Area;CustomEdit;cboAreaCode;T'
        'BasedOnID;CustomEdit;AllowBasedOn;T'
        'AllowanceJob;CustomEdit;AllowJob;F'
        'SuperInc;CustomEdit;chkAllowSuper;F'
        'TaxExempt;CustomEdit;chkAllowTaxExempt;F'
        'BasedOn;CustomEdit;AllowBasedOn;T'
        'Qty;CustomEdit;AllowQty;T'
        'Amount;CustomEdit;AllowanceAmount;F'
        'CalcBy;CustomEdit;cboAllowCalcBy;F'
        'ClassName;CustomEdit;cboAllowDepart;F')
      Selected.Strings = (
        'Allowance'#9'20'#9'Allowance'#9'F'
        'Qty'#9'4'#9'Qty'#9'F'
        'Area'#9'17'#9'Area'#9'F'
        'Amount'#9'7'#9'Amount'#9'F'
        'CalcBy'#9'5'#9'$/%'#9'F'
        'BasedOn'#9'12'#9'Based On'#9'F'
        'SuperInc'#9'5'#9'Super'#9'F'
        'TaxExempt'#9'10'#9'Tax Exempt'#9'F'
        'AllowanceJob'#9'14'#9'Customer Job'#9'F'
        'ClassName'#9'20'#9'Department'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = DSPayAllowances
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgProportionalColResize, dgFixedProportionalResize]
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
      OnEnter = grdAllowancesEnter
      FooterColor = 15785701
      FooterCellColor = 15785701
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnAllowanceDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 23
        Height = 25
        HelpContext = 572014
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
        OnClick = btnAllowanceDeleteClick
      end
    end
    object cboAllowance: TwwDBLookupCombo
      Left = 28
      Top = 68
      Width = 139
      Height = 24
      HelpContext = 572004
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'150'#9'Description'#9#9)
      DataField = 'Allowance'
      DataSource = DSPayAllowances
      LookupTable = qryAllowances
      LookupField = 'AllowanceID'
      Style = csDropDownList
      DropDownWidth = 125
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboAllowanceCloseUp
    end
    object AllowQty: TwwDBEdit
      Left = 192
      Top = 87
      Width = 36
      Height = 24
      HelpContext = 572005
      DataField = 'Qty'
      DataSource = DSPayAllowances
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object AllowBasedOn: TwwDBLookupCombo
      Left = 242
      Top = 76
      Width = 166
      Height = 24
      HelpContext = 572006
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'BasedOn'#9'25'#9'BasedOn'#9#9)
      DataField = 'BasedOnID'
      DataSource = DSPayAllowances
      LookupTable = qryBasedOn
      LookupField = 'BasedOnID'
      DropDownWidth = 50
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object AllowanceAmount: TwwDBEdit
      Left = 346
      Top = 103
      Width = 61
      Height = 24
      HelpContext = 572007
      DataField = 'Amount'
      DataSource = DSPayAllowances
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboAllowCalcBy: TwwDBComboBox
      Left = 425
      Top = 96
      Width = 38
      Height = 24
      HelpContext = 572008
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      AutoDropDown = True
      DataField = 'CalcBy'
      DataSource = DSPayAllowances
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        '$'#9'$'
        '%'#9'%')
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
    end
    object chkAllowSuper: TwwCheckBox
      Left = 483
      Top = 108
      Width = 44
      Height = 21
      HelpContext = 572009
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'Yes'
      DisplayValueUnchecked = 'No'
      NullAndBlankState = cbUnchecked
      Indents.ButtonX = 10
      Color = clWindow
      DataField = 'SuperInc'
      DataSource = DSPayAllowances
      ParentColor = False
      TabOrder = 6
    end
    object chkAllowTaxExempt: TwwCheckBox
      Left = 554
      Top = 100
      Width = 82
      Height = 21
      HelpContext = 572010
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'Yes'
      DisplayValueUnchecked = 'No'
      NullAndBlankState = cbUnchecked
      Indents.ButtonX = 25
      Color = clWindow
      DataField = 'TaxExempt'
      DataSource = DSPayAllowances
      ParentColor = False
      TabOrder = 7
    end
    object AllowJob: TwwDBLookupCombo
      Left = 587
      Top = 57
      Width = 158
      Height = 24
      HelpContext = 572011
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'Company'#9'40'#9'Company'#9'F')
      DataField = 'AllowanceJob'
      DataSource = DSPayAllowances
      LookupTable = qryJobs
      LookupField = 'ClientID'
      Style = csDropDownList
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAllowDepart: TwwDBLookupCombo
      Left = 730
      Top = 84
      Width = 162
      Height = 24
      HelpContext = 572012
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Department'#9'F')
      DataField = 'ClassName'
      DataSource = DSPayAllowances
      LookupTable = qryDepartment
      LookupField = 'ClassName'
      Style = csDropDownList
      TabOrder = 9
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAreaCode: TwwDBLookupCombo
      Left = 145
      Top = 74
      Width = 94
      Height = 26
      HelpContext = 572015
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AreaCode'#9'10'#9'Code'#9'F'
        'AreaName'#9'20'#9'Name'#9'F')
      DataField = 'Area'
      LookupTable = QryAreaCodes
      LookupField = 'AreaCode'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object pnlJobKeepersTopup: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 236
      Width = 898
      Height = 41
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 11
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 11
      object Label1: TLabel
        Left = 12
        Top = 13
        Width = 174
        Height = 15
        HelpContext = 272059
        Caption = 'JobKeeper Topping-up Amount'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edRegion: TDBEdit
        Left = 192
        Top = 9
        Width = 99
        Height = 23
        HelpContext = 272066
        DataField = 'TopUptoJobKeepersAllowance'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004801340210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object DSPayAllowances: TDataSource
    Left = 490
    Top = 2
  end
  object qryAllowances: TERPQuery
    SQL.Strings = (
      
        'Select AllowanceID, Description, SuperInc, TaxExempt, PayrollTax' +
        'Exempt, '
      
        'WorkcoverExempt, DisplayIn, Amount, Percentage, BasedOnID, Activ' +
        'e,'
      'Percentage AS Qty, CalcBy'
      'FROM tblAllowances'
      'WHERE Active='#39'T'#39
      ''
      '')
    Left = 687
    Top = 8
    object qryAllowancesDescription: TWideStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Size = 150
    end
    object qryAllowancesAllowanceID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AllowanceID'
      ReadOnly = True
      Visible = False
    end
    object qryAllowancesSuperInc: TWideStringField
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Visible = False
    end
    object qryAllowancesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
    end
    object qryAllowancesBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
    object qryAllowancesCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
  end
  object qryJobs: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass'
      'FROM tblclients'
      
        'WHERE Active = '#39'T'#39' AND Customer='#39'T'#39' AND (Company NOT LIKE '#39'Table' +
        '%'#39')'
      'ORDER BY Company')
    Left = 556
    Top = 2
  end
  object qryDepartment: TERPQuery
    SQL.Strings = (
      'Select ClassID, ClassName, Active'
      'FROM tblClass WHERE Active = "T"'
      'ORDER BY ClassName')
    Left = 606
  end
  object qryBasedOn: TERPQuery
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 655
    Top = 9
    object qryBasedOnBasedOn: TWideStringField
      DisplayWidth = 25
      FieldName = 'BasedOn'
      Size = 25
    end
    object qryBasedOnBasedOnID: TAutoIncField
      FieldName = 'BasedOnID'
      ReadOnly = True
      Visible = False
    end
  end
  object QryAreaCodes: TERPQuery
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 719
    Top = 194
    object QryAreaCodesAreaCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodesAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'AreaName'
      Size = 100
    end
  end
  object DSPays: TDataSource
    Left = 338
    Top = 290
  end
end
