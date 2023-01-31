inherited AssessmentTypeGUI: TAssessmentTypeGUI
  Left = 391
  Top = 145
  HelpContext = 22000
  Caption = 'Assessment Type'
  ClientHeight = 451
  ClientWidth = 567
  OldCreateOrder = True
  DesignSize = (
    567
    451)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 34
    Top = 65
    Width = 495
    Height = 336
    HelpContext = 22002
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object lblActive: TLabel [1]
    Left = 526
    Top = 412
    Width = 40
    Height = 17
    HelpContext = 22003
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 22001
  end
  object lblName: TLabel [3]
    Left = 73
    Top = 71
    Width = 27
    Height = 15
    HelpContext = 22004
    Caption = 'Type'
    FocusControl = edtType
    Transparent = True
  end
  object Label1: TLabel [4]
    Left = 73
    Top = 162
    Width = 38
    Height = 15
    HelpContext = 22005
    Caption = 'Labels'
    FocusControl = edtType
    Transparent = True
  end
  object Label2: TLabel [5]
    Left = 73
    Top = 116
    Width = 45
    Height = 15
    HelpContext = 22006
    Caption = 'Product'
    FocusControl = edtType
    Transparent = True
    Layout = tlBottom
  end
  object Label3: TLabel [6]
    Left = 72
    Top = 285
    Width = 79
    Height = 15
    HelpContext = 22007
    Anchors = [akLeft, akBottom]
    Caption = 'Other Options'
    FocusControl = edtType
    Transparent = True
  end
  object Label20: TLabel [7]
    Left = 299
    Top = 113
    Width = 102
    Height = 18
    HelpContext = 22008
    AutoSize = False
    Caption = 'Default Template'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlBottom
    WordWrap = True
  end
  object btnCancel: TDNMSpeedButton [8]
    Left = 396
    Top = 413
    Width = 85
    Height = 27
    HelpContext = 22009
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Cancel'
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
    NumGlyphs = 2
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object btnNew: TDNMSpeedButton [9]
    Left = 237
    Top = 413
    Width = 87
    Height = 27
    HelpContext = 22010
    Anchors = [akBottom]
    Caption = '&New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 4
    OnClick = btnNewClick
  end
  object chkActive: TwwCheckBox [10]
    Left = 540
    Top = 426
    Width = 13
    Height = 16
    HelpContext = 22011
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
    Anchors = [akRight, akBottom]
    Checked = True
    DataField = 'Active'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 6
  end
  object edtType: TDBEdit [11]
    Left = 73
    Top = 86
    Width = 314
    Height = 23
    HelpContext = 22012
    DataField = 'TypeName'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object grdData: TwwDBGrid [12]
    Left = 73
    Top = 176
    Width = 419
    Height = 99
    HelpContext = 22013
    ControlType.Strings = (
      'Label;CustomEdit;cboLabels;F')
    Selected.Strings = (
      'Label'#9'35'#9'Label'#9#9
      'Category'#9'30'#9'Category'#9'T'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DSDetails
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowInsert]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    object grdDataIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 20
      Height = 22
      AllowAllUp = True
      Glyph.Data = {
        C6030000424DC603000000000000360000002800000010000000130000000100
        18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
        666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
        99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
        CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
        333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
        99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
        C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
        C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
        77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
        8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
        B2B2B2808080333366000080333366777777777777333366000080333399C0C0
        C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
        0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
        CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
        0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
        868686808080666699333399333399000080333366666666808080969696C0C0
        C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
        8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
        B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
        80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
        CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
        99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
        D7CCCCCCCCCCCCCCCCCC}
      OnClick = grdDataIButtonClick
    end
  end
  object cboLabels: TwwDBLookupCombo [13]
    Left = 81
    Top = 222
    Width = 121
    Height = 23
    AutoSize = False
    DropDownAlignment = taLeftJustify
    DataField = 'Label'
    DataSource = DSDetails
    LookupTable = qrycboLabels
    LookupField = 'Label'
    TabOrder = 7
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnNotInList = cboLabelsNotInList
  end
  object cboProduct: TwwDBLookupCombo [14]
    Left = 73
    Top = 130
    Width = 166
    Height = 23
    HelpContext = 22014
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'PARTNAME'#9'20'#9'Name'#9'T'#9
      'PARTSDESCRIPTION'#9'35'#9'Description'#9'T'#9)
    DataField = 'ProductID'
    DataSource = DSMaster
    LookupTable = cboProductQry
    LookupField = 'PARTSID'
    Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
    Style = csDropDownList
    DropDownCount = 10
    ParentFont = False
    TabOrder = 2
    AutoDropDown = True
    ShowButton = True
    OrderByDisplay = False
    UseTFields = False
    AllowClearKey = False
  end
  object grdData2: TwwDBGrid [15]
    Left = 72
    Top = 299
    Width = 419
    Height = 83
    HelpContext = 22015
    ControlType.Strings = (
      'Label;CustomEdit;cboLabels2;F')
    Selected.Strings = (
      'Label'#9'35'#9'Label'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akRight, akBottom]
    DataSource = DSDetails2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowInsert]
    ParentFont = False
    TabOrder = 9
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    object grdData2IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 20
      Height = 22
      AllowAllUp = True
      Glyph.Data = {
        C6030000424DC603000000000000360000002800000010000000130000000100
        18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
        666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
        99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
        CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
        333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
        99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
        C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
        C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
        77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
        8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
        B2B2B2808080333366000080333366777777777777333366000080333399C0C0
        C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
        0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
        CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
        0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
        868686808080666699333399333399000080333366666666808080969696C0C0
        C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
        8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
        B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
        80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
        CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
        99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
        D7CCCCCCCCCCCCCCCCCC}
      OnClick = grdData2IButtonClick
    end
  end
  object cboLabels2: TwwDBLookupCombo [16]
    Left = 88
    Top = 345
    Width = 121
    Height = 23
    AutoSize = False
    DropDownAlignment = taLeftJustify
    DataField = 'Label'
    DataSource = DSDetails
    LookupTable = qrycboLabels2
    LookupField = 'Label'
    TabOrder = 8
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnNotInList = cboLabelsNotInList
  end
  object pnlTitle: TDNMPanel [17]
    Left = 126
    Top = 6
    Width = 291
    Height = 45
    HelpContext = 22016
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 287
      Height = 41
      HelpContext = 22017
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
        Width = 287
        Height = 41
        HelpContext = 22018
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Assessment Type'
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
  object btnSave: TDNMSpeedButton [18]
    Left = 80
    Top = 412
    Width = 87
    Height = 27
    HelpContext = 22019
    Anchors = [akBottom]
    Caption = '&Save'
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
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object cboInvoiceTemplate: TwwDBLookupCombo [19]
    Left = 299
    Top = 130
    Width = 180
    Height = 23
    HelpContext = 22020
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'TemplName'#9'20'#9'TemplName'#9'T')
    DataField = 'DefaultTemplateID'
    DataSource = DSMaster
    LookupTable = qryTemplates
    LookupField = 'TemplID'
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = True
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 80
    Top = 6
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 49
    Top = 5
  end
  inherited MyConnection: TERPConnection
    Left = 5
    Top = 2
  end
  inherited DataState: TDataState
    Left = 51
    Top = 38
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 111
    Top = 5
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblassessmenttypes'
      'Where TypeID =:xId;')
    Options.FlatBuffers = True
    Left = 143
    Top = 3
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xId'
      end>
    object tblMasterTypeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TypeID'
      Origin = 'tblassessmenttypes.TypeID'
      Visible = False
    end
    object tblMasterTypeName: TWideStringField
      FieldName = 'TypeName'
      Origin = 'tblassessmenttypes.TypeName'
      Size = 50
    end
    object tblMasterProductID: TIntegerField
      FieldName = 'ProductID'
      Visible = False
    end
    object tblMasterActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblassessmenttypes.Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterDefaultTemplateID: TLargeintField
      FieldName = 'DefaultTemplateID'
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 145
    Top = 35
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblassessmenttypesdetails'
      'WHERE TypeID= :xID;')
    BeforePost = tblDetailsBeforePost
    Options.FlatBuffers = True
    Left = 191
    Top = 4
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object tblDetailsLabel: TWideStringField
      DisplayWidth = 35
      FieldName = 'Label'
      Origin = 'tblassessmenttypesdetails.Label'
      OnChange = tblDetailsLabelChange
      Size = 50
    end
    object tblDetailsCategory: TWideStringField
      DisplayWidth = 30
      FieldName = 'Category'
      Size = 255
    end
    object tblDetailsTypeDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TypeDetailsID'
      Origin = 'tblassessmenttypesdetails.TypeDetailsID'
      Visible = False
    end
    object tblDetailsTypeID: TIntegerField
      FieldName = 'TypeID'
      Origin = 'tblassessmenttypesdetails.TypeID'
      Visible = False
    end
    object tblDetailsLabelID: TIntegerField
      FieldName = 'LabelID'
      Origin = 'tblassessmenttypesdetails.LabelID'
      Visible = False
    end
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 191
    Top = 36
  end
  object qrycboLabels: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblassessmentlabels'
      'WHERE OtherOption = '#39'F'#39' AND Active = '#39'T'#39';')
    AfterOpen = qrycboLabelsAfterOpen
    Options.FlatBuffers = True
    Left = 208
    Top = 220
    object qrycboLabelsLabelId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'LabelId'
      Origin = 'tblassessmentlabels.LabelId'
    end
    object qrycboLabelsLabel: TWideStringField
      FieldName = 'Label'
      Origin = 'tblassessmentlabels.Label'
      Size = 40
    end
    object qrycboLabelsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblassessmentlabels.Active'
      FixedChar = True
      Size = 1
    end
    object qrycboLabelsCategory: TWideStringField
      FieldName = 'Category'
      Size = 255
    end
  end
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'SUBSTRING_INDEX(p.PRODUCTGROUP,"^",1)  AS '#39'Manuf'#39' ,'
      
        'IF(INSTR(p.PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(SUBSTRING_INDEX' +
        '(p.PRODUCTGROUP,"^",2),"^",-1),"") AS '#39'Type'#39' ,'
      
        'IF(INSTR(IF(INSTR(p.PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(p.PROD' +
        'UCTGROUP,"^",2),""),"^")<>0, SUBSTRING_INDEX(p.PRODUCTGROUP,"^",' +
        '-1),"") AS '#39'Dept'#39' ,'
      'p.PARTNAME, p.PARTSID, p.PARTTYPE,'
      'p.PARTSDESCRIPTION'
      'FROM tblparts p'
      'WHERE p.Active = '#39'T'#39
      ''
      ''
      '')
    FilterOptions = [foCaseInsensitive]
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 189
    Top = 127
    object cboProductQryManuf: TWideStringField
      FieldName = 'Manuf'
      Size = 255
    end
    object cboProductQryType: TWideStringField
      FieldName = 'Type'
      Size = 255
    end
    object cboProductQryDept: TWideStringField
      FieldName = 'Dept'
      Size = 255
    end
    object cboProductQryPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 60
    end
    object cboProductQryPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object cboProductQryPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Size = 13
    end
    object cboProductQryPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Size = 255
    end
  end
  object qrycboLabels2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblassessmentlabels'
      'WHERE OtherOption = '#39'T'#39' AND Active = '#39'T'#39';')
    AfterOpen = qrycboLabels2AfterOpen
    Options.FlatBuffers = True
    Left = 199
    Top = 335
    object qrycboLabels2Labelid: TIntegerField
      FieldName = 'Labelid'
    end
    object qrycboLabels2Label: TWideStringField
      FieldName = 'Label'
      Size = 40
    end
    object qrycboLabels2Active: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object tblDetails2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblassessmenttypesotherdetails'
      'WHERE TypeID= :xID;')
    BeforePost = tblDetails2BeforePost
    Options.FlatBuffers = True
    Left = 239
    Top = 3
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object tblDetails2Label: TWideStringField
      DisplayWidth = 35
      FieldName = 'Label'
      OnChange = tblDetails2LabelChange
      Size = 50
    end
    object tblDetails2TypeOtherDetailsID: TLargeintField
      DisplayWidth = 15
      FieldName = 'TypeOtherDetailsID'
      Visible = False
    end
    object tblDetails2TypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeID'
      Visible = False
    end
    object tblDetails2LabelID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LabelID'
      Visible = False
    end
  end
  object DSDetails2: TDataSource
    DataSet = tblDetails2
    Left = 239
    Top = 35
  end
  object qryTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TypeID` = '#39 +
        '84'#39';')
    Options.LongStrings = False
    Left = 409
    Top = 128
  end
end
