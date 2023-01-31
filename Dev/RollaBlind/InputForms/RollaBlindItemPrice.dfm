inherited RollaBlindItemPriceGUI: TRollaBlindItemPriceGUI
  Left = 193
  Top = 146
  Caption = 'Item Price'
  ClientHeight = 442
  ClientWidth = 452
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    Width = 452
    Height = 442
    inherited Bevel1: TBevel
      Width = 420
      Height = 314
    end
    object Label1: TLabel [1]
      Left = 32
      Top = 88
      Width = 73
      Height = 15
      Caption = 'Item Number'
      Transparent = True
    end
    object Label2: TLabel [2]
      Left = 32
      Top = 136
      Width = 46
      Height = 15
      Caption = 'Heading'
      Transparent = True
    end
    object Label3: TLabel [3]
      Left = 32
      Top = 184
      Width = 109
      Height = 15
      Caption = 'Cut-out Description'
      Transparent = True
    end
    object Label4: TLabel [4]
      Left = 32
      Top = 232
      Width = 122
      Height = 15
      Caption = 'Price List Description'
      Transparent = True
    end
    object Label5: TLabel [5]
      Left = 32
      Top = 280
      Width = 39
      Height = 15
      Caption = 'Length'
      Transparent = True
    end
    object Label6: TLabel [6]
      Left = 32
      Top = 328
      Width = 69
      Height = 15
      Caption = 'Colour Code'
      Transparent = True
    end
    object Label7: TLabel [7]
      Left = 160
      Top = 328
      Width = 22
      Height = 15
      Caption = 'Unit'
      Transparent = True
    end
    object Label8: TLabel [8]
      Left = 296
      Top = 88
      Width = 21
      Height = 15
      Caption = 'List'
      Transparent = True
    end
    object Label9: TLabel [9]
      Left = 296
      Top = 136
      Width = 36
      Height = 15
      Caption = 'Kanga'
      Transparent = True
    end
    object Label10: TLabel [10]
      Left = 296
      Top = 184
      Width = 34
      Height = 15
      Caption = 'Group'
      Transparent = True
    end
    object Label11: TLabel [11]
      Left = 296
      Top = 232
      Width = 37
      Height = 15
      Caption = 'Export'
      Transparent = True
    end
    object Label12: TLabel [12]
      Left = 296
      Top = 280
      Width = 41
      Height = 15
      Caption = 'Branch'
      Transparent = True
    end
    object Label13: TLabel [13]
      Left = 296
      Top = 328
      Width = 26
      Height = 15
      Caption = 'Cost'
      Transparent = True
    end
    inherited pnlTitle: TDNMPanel
      Left = 72
      Width = 305
      TabOrder = 16
    end
    inherited btnSave: TDNMSpeedButton
      Left = 77
      Top = 401
      TabOrder = 13
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 287
      Top = 401
      TabOrder = 15
    end
    inherited btnNew: TDNMSpeedButton
      Left = 182
      Top = 401
      TabOrder = 14
    end
    object edtItemNumber: TwwDBEdit
      Left = 32
      Top = 104
      Width = 249
      Height = 23
      DataField = 'ItemNumber'
      DataSource = dsMain
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
    object cboGroupHeading: TwwDBLookupCombo
      Left = 32
      Top = 152
      Width = 249
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'Heading'
      DataSource = dsMain
      LookupTable = qryPriceGroups
      LookupField = 'Heading'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object edtCutoutDescription: TwwDBEdit
      Left = 32
      Top = 200
      Width = 249
      Height = 23
      DataField = 'Description'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtPriceListDescription: TwwDBEdit
      Left = 32
      Top = 248
      Width = 249
      Height = 23
      DataField = 'Description2'
      DataSource = dsMain
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
    object edtLength: TwwDBEdit
      Left = 32
      Top = 296
      Width = 249
      Height = 23
      DataField = 'Length'
      DataSource = dsMain
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
    object cboColourCode: TwwDBLookupCombo
      Left = 32
      Top = 344
      Width = 113
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'ColourCode'
      DataSource = dsMain
      LookupTable = qryColourCodes
      LookupField = 'ColourCode'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 5
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object edtUnit: TwwDBEdit
      Left = 160
      Top = 344
      Width = 121
      Height = 23
      DataField = 'Unit'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtList: TwwDBEdit
      Left = 296
      Top = 104
      Width = 121
      Height = 23
      DataField = 'List'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtKanga: TwwDBEdit
      Left = 296
      Top = 152
      Width = 121
      Height = 23
      DataField = 'Kanga'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtGroup: TwwDBEdit
      Left = 296
      Top = 200
      Width = 121
      Height = 23
      DataField = 'Group'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtExport: TwwDBEdit
      Left = 296
      Top = 248
      Width = 121
      Height = 23
      DataField = 'Export'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtBranch: TwwDBEdit
      Left = 296
      Top = 296
      Width = 121
      Height = 23
      DataField = 'Branch'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtCost: TwwDBEdit
      Left = 296
      Top = 344
      Width = 121
      Height = 23
      DataField = 'Cost'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblrollaitemprices')
    object qryMainItemPriceID: TIntegerField
      FieldName = 'ItemPriceID'
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainItemNumber: TStringField
      FieldName = 'ItemNumber'
      Size = 255
    end
    object qryMainColourCode: TStringField
      DisplayWidth = 10
      FieldName = 'ColourCode'
      Size = 255
    end
    object qryMainHeading: TStringField
      DisplayWidth = 20
      FieldName = 'Heading'
      Size = 255
    end
    object qryMainDescription: TStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryMainDescription2: TStringField
      FieldName = 'Description2'
      Size = 200
    end
    object qryMainLength: TStringField
      FieldName = 'Length'
      Size = 255
    end
    object qryMainColour: TStringField
      DisplayWidth = 20
      FieldName = 'Colour'
      Size = 50
    end
    object qryMainUnit: TStringField
      FieldName = 'Unit'
      Size = 255
    end
    object qryMainList: TFloatField
      FieldName = 'List'
      currency = True
    end
    object qryMainKanga: TFloatField
      FieldName = 'Kanga'
      currency = True
    end
    object qryMainGroup: TFloatField
      FieldName = 'Group'
      currency = True
    end
    object qryMainExport: TFloatField
      FieldName = 'Export'
      currency = True
    end
    object qryMainBranch: TFloatField
      FieldName = 'Branch'
      currency = True
    end
    object qryMainCost: TFloatField
      FieldName = 'Cost'
      currency = True
    end
    object qryMainSheetID: TIntegerField
      FieldName = 'SheetID'
    end
    object qryMainFlag: TStringField
      FieldName = 'Flag'
      FixedChar = True
      Size = 1
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object qryPriceGroups: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrollapricegroups')
    Left = 72
    Top = 40
    object qryPriceGroupsHeading: TStringField
      DisplayWidth = 25
      FieldName = 'Heading'
      Size = 255
    end
  end
  object qryColourCodes: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrollacolourcodes')
    Left = 104
    Top = 40
    object qryColourCodesColourCode: TStringField
      DisplayWidth = 10
      FieldName = 'ColourCode'
      Size = 50
    end
  end
end
