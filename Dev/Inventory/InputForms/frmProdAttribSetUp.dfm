inherited fmProdAttribSetUp: TfmProdAttribSetUp
  Left = 103
  Top = 98
  HelpContext = 62000
  Caption = 'Product Attribute Setup'
  ClientHeight = 403
  ClientWidth = 835
  Color = 16769217
  ExplicitLeft = 103
  ExplicitTop = 98
  ExplicitWidth = 851
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 403
    Width = 835
    HelpContext = 62002
    ExplicitTop = 403
    ExplicitWidth = 835
  end
  object SubForm: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 835
    Height = 403
    HelpContext = 62001
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    ExplicitTop = -6
    DesignSize = (
      831
      399)
    object Bevel2: TBevel
      Left = 403
      Top = 326
      Width = 361
      Height = 66
      HelpContext = 62003
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 32
      Top = 326
      Width = 361
      Height = 66
      HelpContext = 62004
      Shape = bsFrame
    end
    object Bevel3: TBevel
      Left = 32
      Top = 11
      Width = 732
      Height = 90
      HelpContext = 62005
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 718
      Top = 55
      Width = 35
      Height = 15
      HelpContext = 62006
      Caption = 'Active'
      Transparent = True
    end
    object Label2: TLabel
      Left = 41
      Top = 25
      Width = 70
      Height = 15
      HelpContext = 62007
      Caption = 'Group Name'
      Transparent = True
    end
    object Label3: TLabel
      Left = 32
      Top = 105
      Width = 92
      Height = 15
      HelpContext = 62008
      Caption = 'Attribute Names'
      Transparent = True
    end
    object Label4: TLabel
      Left = 403
      Top = 105
      Width = 90
      Height = 15
      HelpContext = 62009
      Caption = 'Attribute Values'
      Transparent = True
    end
    object Label7: TLabel
      Left = 170
      Top = 55
      Width = 63
      Height = 15
      HelpContext = 62010
      Caption = 'X Attribute '
      Transparent = True
    end
    object Label8: TLabel
      Left = 40
      Top = 55
      Width = 62
      Height = 15
      HelpContext = 62011
      Caption = 'Y Attribute '
      Transparent = True
    end
    object Label34: TLabel
      Left = 428
      Top = 53
      Width = 95
      Height = 18
      HelpContext = 62012
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Product Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label5: TLabel
      Left = 428
      Top = 26
      Width = 116
      Height = 15
      HelpContext = 62013
      Caption = 'Product Description '
      Transparent = True
    end
    object Label6: TLabel
      Left = 299
      Top = 55
      Width = 49
      Height = 15
      HelpContext = 62014
      Caption = 'Order by'
      Transparent = True
    end
    object Label9: TLabel
      Left = 39
      Top = 329
      Width = 67
      Height = 18
      HelpContext = 62015
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Comments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label10: TLabel
      Left = 412
      Top = 329
      Width = 67
      Height = 18
      HelpContext = 62016
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Instructions'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object dbgAttribName: TwwDBGrid
      Left = 32
      Top = 123
      Width = 361
      Height = 197
      HelpContext = 62017
      ControlType.Strings = (
        'isOnYAxis;CheckBox;T;F'
        'IsonXaxis;CheckBox;T;F')
      Selected.Strings = (
        'Name'#9'46'#9'Name'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akBottom]
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol]
      ParentFont = False
      TabOrder = 6
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      OnEnter = dbgAttribNameEnter
      OnExit = dbgAttribNameExit
    end
    object grdListValues: TwwDBGrid
      Left = 403
      Top = 123
      Width = 361
      Height = 197
      HelpContext = 62018
      Selected.Strings = (
        'Value'#9'35'#9'Value'#9'F'
        'Abbreviation'#9'10'#9'Abbreviation'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alCustom
      DataSource = DSDetailsDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      ParentFont = False
      TabOrder = 5
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      OnEnter = grdListValuesEnter
      OnExit = grdListValuesExit
    end
    object DBCheckBox1: TwwCheckBox
      Left = 730
      Top = 74
      Width = 14
      Height = 17
      HelpContext = 62019
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
      Caption = 'Active'
      Color = 14211288
      DataField = 'Active'
      DataSource = DSMaster
      ParentColor = False
      TabOrder = 4
      OnClick = DBCheckBox1Click
    end
    object edtTitle: TwwDBEdit
      Left = 119
      Top = 21
      Width = 255
      Height = 23
      HelpContext = 62020
      DataField = 'Name'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboXAxisAttribute: TwwDBLookupCombo
      Left = 40
      Top = 71
      Width = 126
      Height = 23
      HelpContext = 62021
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'20'#9'Name'#9'F')
      DataField = 'XAxisAttribute'
      DataSource = DSMaster
      LookupTable = qrynames
      LookupField = 'PAN_ID'
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnEnter = cboXAxisAttributeEnter
      OnNotInList = cboXAxisAttributeNotInList
    end
    object cboYAxisAttribute: TwwDBLookupCombo
      Left = 169
      Top = 71
      Width = 126
      Height = 23
      HelpContext = 62022
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'20'#9'Name'#9'F')
      DataField = 'YAxisAttribute'
      DataSource = DSMaster
      LookupTable = qrynames
      LookupField = 'PAN_ID'
      TabOrder = 7
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnEnter = cboXAxisAttributeEnter
      OnNotInList = cboXAxisAttributeNotInList
    end
    object cboOrderbyAttribute: TwwDBLookupCombo
      Left = 299
      Top = 71
      Width = 126
      Height = 23
      HelpContext = 62023
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'20'#9'Name'#9'F')
      DataField = 'OrderbyAttribute'
      DataSource = DSMaster
      LookupTable = qrynames
      LookupField = 'PAN_ID'
      TabOrder = 8
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnEnter = cboXAxisAttributeEnter
      OnNotInList = cboXAxisAttributeNotInList
    end
    object cboProductType: TwwDBLookupCombo
      Left = 428
      Top = 71
      Width = 269
      Height = 23
      HelpContext = 62024
      Anchors = [akTop]
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TypeDesc'#9'30'#9'TypeDesc'#9'T')
      DataField = 'PARTTYPE'
      DataSource = DSMaster
      LookupTable = qryProductTypeLookup
      LookupField = 'TypeCode'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnEnter = cboProductTypeEnter
    end
    object wwDBEdit1: TwwDBEdit
      Left = 547
      Top = 22
      Width = 205
      Height = 23
      HelpContext = 62025
      DataField = 'ProdDesc'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
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
    object txtComments: TDBMemo
      Left = 39
      Top = 350
      Width = 345
      Height = 37
      HelpContext = 62026
      Anchors = [akLeft, akBottom]
      DataField = 'Notes'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 9
    end
    object DBMemo1: TDBMemo
      Left = 412
      Top = 350
      Width = 345
      Height = 37
      HelpContext = 62027
      Anchors = [akLeft, akBottom]
      DataField = 'SpecialInstructions'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 10
    end
  end
  object qrygroups: TERPQuery
    Connection = fmProdAttribMain.MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblproductattributegroups')
    Left = 566
    Top = 196
    object qrygroupsPAG_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PAG_ID'
      Origin = 'tblproductattributegroups.PAG_ID'
    end
    object qrygroupsName: TWideStringField
      FieldName = 'Name'
      Origin = 'tblproductattributegroups.Name'
      OnSetText = FieldSetTextStripBlanks
      Size = 255
    end
    object qrygroupsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblproductattributegroups.Active'
      FixedChar = True
      Size = 1
    end
    object qrygroupsXAxisAttribute: TLargeintField
      FieldName = 'XAxisAttribute'
    end
    object qrygroupsYAxisAttribute: TLargeintField
      FieldName = 'YAxisAttribute'
    end
    object qrygroupsOrderbyAttribute: TLargeintField
      FieldName = 'OrderbyAttribute'
    end
    object qrygroupsPartType: TWideStringField
      FieldName = 'PartType'
      Size = 13
    end
    object qrygroupsglobalref: TWideStringField
      FieldName = 'globalref'
      Size = 255
    end
    object qrygroupsProdDesc: TWideStringField
      FieldName = 'ProdDesc'
      Size = 100
    end
    object qrygroupsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qrygroupsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qrygroupsCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object qrygroupsCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object qrygroupsCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object qrygroupsCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object qrygroupsCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qrygroupsCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object qrygroupsCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object qrygroupsCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object qrygroupsCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object qrygroupsCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object qrygroupsCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object qrygroupsCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object qrygroupsCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object qrygroupsCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object qrygroupsCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object qrygroupsCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
    end
    object qrygroupsCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
    end
    object qrygroupsCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
    end
    object qrygroupsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qrygroupsSpecialInstructions: TWideStringField
      FieldName = 'SpecialInstructions'
      Size = 255
    end
  end
  object qrynames: TERPQuery
    Connection = fmProdAttribMain.MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblproductattributenames')
    Left = 597
    Top = 196
    object qrynamesName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Origin = 'tblproductattributenames.Name'
      OnSetText = FieldSetTextStripBlanks
      Size = 255
    end
    object qrynamesPAN_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PAN_ID'
      Origin = 'tblproductattributenames.PAN_ID'
      Visible = False
    end
    object qrynamesPAG_ID: TIntegerField
      FieldName = 'PAG_ID'
      Origin = 'tblproductattributenames.PAG_ID'
      Visible = False
    end
    object qrynamesActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblproductattributenames.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrynamesglobalref: TWideStringField
      FieldName = 'globalref'
      Size = 255
    end
    object qrynamesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object DSDetailsDetails: TDataSource
    DataSet = qryvalues
    Left = 631
    Top = 224
  end
  object DSMaster: TDataSource
    DataSet = qrygroups
    Left = 567
    Top = 224
  end
  object qryvalues: TERPQuery
    Connection = fmProdAttribMain.MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblproductattributevalues')
    Left = 629
    Top = 196
    object qryvaluesPAV_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PAV_ID'
      Origin = 'tblproductattributevalues.PAV_ID'
    end
    object qryvaluesPAN_ID: TIntegerField
      FieldName = 'PAN_ID'
      Origin = 'tblproductattributevalues.PAN_ID'
    end
    object qryvaluesValue: TWideStringField
      FieldName = 'Value'
      Origin = 'tblproductattributevalues.Value'
      OnSetText = FieldSetTextStripBlanks
      Size = 255
    end
    object qryvaluesAbbreviation: TWideStringField
      FieldName = 'Abbreviation'
      Origin = 'tblproductattributevalues.Abbreviation'
      OnSetText = FieldSetTextStripBlanks
      Size = 30
    end
    object qryvaluesActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblproductattributevalues.Active'
      FixedChar = True
      Size = 1
    end
    object qryvaluesglobalref: TWideStringField
      FieldName = 'globalref'
      Size = 255
    end
    object qryvaluesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object DSDetails: TDataSource
    DataSet = qrynames
    Left = 597
    Top = 224
  end
  object qryProductTypeLookup: TERPQuery
    Connection = fmProdAttribMain.MyConnection
    SQL.Strings = (
      'SELECT ID, TypeCode, TypeDesc'
      'FROM tblparttypes'
      'order by TypeDesc')
    Left = 662
    Top = 196
  end
end
