inherited fmSchemaObjectEdit: TfmSchemaObjectEdit
  Caption = 'Schema Object'
  ClientWidth = 996
  ExplicitWidth = 1002
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1667002
  inherited lblSkingroupMsg: TLabel
    Width = 996
    ExplicitWidth = 996
    HelpContext = 1667003
  end
  inherited shapehint: TShape
    Left = 9
    ExplicitLeft = 9
  end
  inherited imgGridWatermark: TImage
    Top = -5
    ExplicitTop = -5
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  object Label3: TLabel [5]
    Left = 25
    Top = 75
    Width = 33
    Height = 15
    Caption = 'Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    HelpContext = 1667004
  end
  object Label1: TLabel [6]
    Left = 24
    Top = 104
    Width = 29
    Height = 15
    Caption = 'Desc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    HelpContext = 1667005
  end
  object lblTableName: TLabel [7]
    Left = 472
    Top = 75
    Width = 30
    Height = 15
    Caption = 'Table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    HelpContext = 1667006
  end
  object lblTableFilter: TLabel [8]
    Left = 472
    Top = 104
    Width = 28
    Height = 15
    Caption = 'Filter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    HelpContext = 1667007
  end
  object lblERPVersion: TLabel [9]
    Left = 472
    Top = 133
    Width = 43
    Height = 15
    Caption = 'Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    HelpContext = 1667008
  end
  object Label2: TLabel [10]
    Left = 8
    Top = 171
    Width = 100
    Height = 15
    Caption = 'Object Properties'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1667009
  end
  object pnlTitle: TDNMPanel [11]
    Left = 258
    Top = 9
    Width = 481
    Height = 45
    HelpContext = 1667010
    Anchors = [akTop]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 477
      Height = 41
      HelpContext = 1667011
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
        Width = 477
        Height = 41
        HelpContext = 1667012
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Schema Object'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 295
      end
    end
  end
  object btnOK: TDNMSpeedButton [12]
    Left = 397
    Top = 497
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'Save'
    Default = True
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnOKClick
    HelpContext = 1667013
  end
  object btnCancel: TDNMSpeedButton [13]
    Left = 511
    Top = 497
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
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
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelClick
    HelpContext = 1667014
  end
  object edtObjectName: TwwDBEdit [14]
    Left = 68
    Top = 72
    Width = 378
    Height = 23
    DataField = 'ObjectName'
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
    HelpContext = 1667015
  end
  object memDescription: TDBMemo [15]
    Left = 68
    Top = 101
    Width = 378
    Height = 60
    DataField = 'Description'
    DataSource = dsMain
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    HelpContext = 1667016
  end
  object edtTableFilter: TwwDBEdit [16]
    Left = 522
    Top = 101
    Width = 375
    Height = 23
    DataField = 'TableFilter'
    DataSource = dsMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    HelpContext = 1667017
  end
  object edtErpVersion: TwwDBEdit [17]
    Left = 522
    Top = 130
    Width = 217
    Height = 23
    DataField = 'ERPVersion'
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
    HelpContext = 1667018
  end
  object chkVisible: TwwCheckBox [18]
    Left = 818
    Top = 130
    Width = 79
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Visible'
    DataField = 'Visible'
    DataSource = dsMain
    TabOrder = 7
    HelpContext = 1667019
  end
  object grdDetails: TwwDBGrid [19]
    Left = 8
    Top = 192
    Width = 980
    Height = 289
    ControlType.Strings = (
      'Visible;CheckBox;T;F'
      'FieldAllowNull;CheckBox;T;F'
      'PropertyType;CustomEdit;cboPropertyType;F')
    Selected.Strings = (
      'PropertyName'#9'15'#9'Property Name'#9#9
      'PropertyType'#9'10'#9'PropertyType'#9'F'#9
      'FieldType'#9'8'#9'Data Type'#9'F'#9
      'Description'#9'20'#9'Description'#9#9
      'FieldName'#9'15'#9'Field Name'#9#9
      'FieldDefault'#9'10'#9'Default Value'#9#9
      'FieldAllowNull'#9'1'#9'Allow Null'#9#9
      'FieldFilter'#9'15'#9'Field Filter'#9#9
      'ERPVersion'#9'19'#9'ERP Version'#9#9
      'Visible'#9'1'#9'Visible'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsDetail
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDblClick = grdDetailsDblClick
    HelpContext = 1667020
  end
  object btnUpdateFields: TDNMSpeedButton [20]
    Left = 623
    Top = 497
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Update fields'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btnUpdateFieldsClick
    HelpContext = 1667021
  end
  object chkMaxVersion: TwwCheckBox [21]
    Left = 471
    Top = 161
    Width = 137
    Height = 17
    TabStop = False
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Show Max Version'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = chkMaxVersionClick
    HelpContext = 1667022
  end
  object chkVisibleOnly: TwwCheckBox [22]
    Left = 642
    Top = 161
    Width = 135
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Show VisibleOnly'
    TabOrder = 11
    OnClick = chkVisibleOnlyClick
    HelpContext = 1667023
  end
  object cboTableName: TComboBox [23]
    Left = 522
    Top = 72
    Width = 375
    Height = 23
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnChange = cboTableNameChange
    HelpContext = 1667024
  end
  object cboPropertyType: TwwDBComboBox [24]
    Left = 760
    Top = 368
    Width = 121
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Items.Strings = (
      'Field'#9'0'
      'Object'#9'1'
      'Object List'#9'2')
    Sorted = False
    TabOrder = 13
    UnboundDataType = wwDefault
    HelpContext = 1667025
  end
  inherited tmrProcessMessage: TTimer
    Top = 65528
  end
  inherited tmrdelay: TTimer
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Top = 65528
  end
  inherited tmrdelayMsg: TTimer
    Top = 65520
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 65528
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 65528
  end
  inherited MyConnection: TERPConnection
    Database = 'erpdocumentaion'
    Connected = True
  end
  inherited DataState: TDataState
    Top = 65528
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 65528
  end
  inherited imgsort: TImageList
    Top = 65528
  end
  inherited QryCustomField: TERPQuery
    Top = 65528
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Top = 65528
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 65528
  end
  inherited qryMemTrans: TERPQuery
    Top = 65528
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblErpSchemaObject')
    Left = 640
    Top = 16
    object qryMainID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
    end
    object qryMainERPVersion: TWideStringField
      DisplayWidth = 255
      FieldName = 'ERPVersion'
      Size = 255
    end
    object qryMainVisible: TWideStringField
      DisplayWidth = 1
      FieldName = 'Visible'
      FixedChar = True
      Size = 1
    end
    object qryMainDescription: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Description'
      BlobType = ftWideMemo
    end
    object qryMainObjectName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ObjectName'
      Size = 255
    end
    object qryMainTableName: TWideStringField
      DisplayWidth = 255
      FieldName = 'TableName'
      Size = 255
    end
    object qryMainTableFilter: TWideStringField
      DisplayWidth = 255
      FieldName = 'TableFilter'
      Size = 255
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
    end
  end
  object qryDetail: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblErpSchemaProperty')
    AfterInsert = qryDetailAfterInsert
    OnCalcFields = qryDetailCalcFields
    Left = 680
    Top = 16
    object qryDetailPropertyName: TWideStringField
      DisplayLabel = 'Property Name'
      DisplayWidth = 15
      FieldName = 'PropertyName'
      Origin = 'tblerpschemaproperty.PropertyName'
      Size = 255
    end
    object qryDetailPropertyType: TIntegerField
      DisplayWidth = 10
      FieldName = 'PropertyType'
      Origin = 'tblerpschemaproperty.PropertyType'
    end
    object qryDetailFieldType: TWideStringField
      DisplayLabel = 'Data Type'
      DisplayWidth = 8
      FieldName = 'FieldType'
      Origin = 'tblerpschemaproperty.FieldType'
      Size = 255
    end
    object qryDetailDescription: TWideMemoField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblerpschemaproperty.Description'
      BlobType = ftWideMemo
    end
    object qryDetailFieldName: TWideStringField
      DisplayLabel = 'Field Name'
      DisplayWidth = 15
      FieldName = 'FieldName'
      Origin = 'tblerpschemaproperty.FieldName'
      Size = 255
    end
    object qryDetailFieldDefault: TWideStringField
      DisplayLabel = 'Default Value'
      DisplayWidth = 10
      FieldName = 'FieldDefault'
      Origin = 'tblerpschemaproperty.FieldDefault'
      Size = 255
    end
    object qryDetailFieldAllowNull: TWideStringField
      DisplayLabel = 'Allow Null'
      DisplayWidth = 1
      FieldName = 'FieldAllowNull'
      Origin = 'tblerpschemaproperty.FieldAllowNull'
      FixedChar = True
      Size = 1
    end
    object qryDetailFieldFilter: TWideStringField
      DisplayLabel = 'Field Filter'
      DisplayWidth = 15
      FieldName = 'FieldFilter'
      Origin = 'tblerpschemaproperty.FieldFilter'
      Size = 255
    end
    object qryDetailERPVersion: TWideStringField
      DisplayLabel = 'ERP Version'
      DisplayWidth = 19
      FieldName = 'ERPVersion'
      Origin = 'tblerpschemaproperty.ERPVersion'
      Size = 255
    end
    object qryDetailVisible: TWideStringField
      DisplayWidth = 1
      FieldName = 'Visible'
      Origin = 'tblerpschemaproperty.Visible'
      FixedChar = True
      Size = 1
    end
    object qryDetailPropertyTypeName: TStringField
      DisplayLabel = 'Property Type'
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'PropertyTypeName'
      Visible = False
      Calculated = True
    end
    object qryDetailObjectName: TWideStringField
      DisplayWidth = 10
      FieldName = 'ObjectName'
      Origin = 'tblerpschemaproperty.ObjectName'
      Visible = False
      Size = 255
    end
    object qryDetailID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblerpschemaproperty.ID'
      Visible = False
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 640
    Top = 56
  end
  object dsDetail: TDataSource
    DataSet = qryDetail
    Left = 688
    Top = 56
  end
end
