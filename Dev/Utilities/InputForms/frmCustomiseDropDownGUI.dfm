inherited CustomiseDropDownGUI: TCustomiseDropDownGUI
  Left = 1543
  Top = 107
  HelpContext = 87000
  Caption = 'Customise DropDown Lists'
  ClientHeight = 571
  ClientWidth = 671
  OldCreateOrder = True
  DesignSize = (
    671
    571)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 80
    Top = 468
    Width = 499
    Height = 54
    HelpContext = 87002
    Anchors = [akLeft, akRight, akBottom]
  end
  object Label3: TLabel [1]
    Left = 108
    Top = 478
    Width = 42
    Height = 15
    HelpContext = 87003
    Anchors = [akLeft, akBottom]
    Caption = 'X - axis'
    Transparent = True
  end
  object Label4: TLabel [2]
    Left = 370
    Top = 478
    Width = 41
    Height = 15
    HelpContext = 87004
    Anchors = [akRight, akBottom]
    Caption = 'Y - axis'
    Transparent = True
  end
  object Label139: TLabel [3]
    Left = 100
    Top = 449
    Width = 116
    Height = 17
    HelpContext = 87005
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Use Ordering Matrix'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label5: TLabel [4]
    Left = 126
    Top = 503
    Width = 86
    Height = 17
    HelpContext = 87006
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Alpha Order X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label6: TLabel [5]
    Left = 388
    Top = 503
    Width = 91
    Height = 17
    HelpContext = 87007
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Alpha Order Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label8: TLabel [6]
    Left = 234
    Top = 503
    Width = 86
    Height = 17
    HelpContext = 87008
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = ' Priority'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label9: TLabel [7]
    Left = 495
    Top = 503
    Width = 72
    Height = 17
    HelpContext = 87009
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = ' Priority'
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
    HelpContext = 87001
  end
  object dbgComboName: TwwDBGrid [9]
    Left = 50
    Top = 72
    Width = 258
    Height = 365
    HelpContext = 87010
    Selected.Strings = (
      'ComboName'#9'30'#9'Combo Name'#9'T')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akBottom]
    DataSource = DSMaster
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    UseTFields = False
  end
  object cboX: TwwDBLookupCombo [10]
    Left = 153
    Top = 474
    Width = 139
    Height = 26
    HelpContext = 87011
    Anchors = [akLeft, akBottom]
    AutoSize = False
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ComboName'#9'30'#9'ComboName'#9'T')
    DataField = 'XaxisComboName'
    LookupTable = qryDescAttribX
    LookupField = 'ComboName'
    TabOrder = 4
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = True
    OnChange = cboXChange
    OnCloseUp = cboXCloseUp
    OnNotInList = cboXNotInList
  end
  object cboY: TwwDBLookupCombo [11]
    Left = 415
    Top = 474
    Width = 139
    Height = 26
    HelpContext = 87012
    Anchors = [akRight, akBottom]
    AutoSize = False
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ComboName'#9'30'#9'ComboName'#9'F'#9)
    DataField = 'YaxisComboName'
    LookupTable = qryDescAttribY
    LookupField = 'ComboName'
    TabOrder = 5
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = True
    OnChange = cboYChange
    OnCloseUp = cboYCloseUp
    OnNotInList = cboYNotInList
  end
  object chkUseOrderingMatrix: TwwCheckBox [12]
    Left = 82
    Top = 448
    Width = 15
    Height = 17
    HelpContext = 87013
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akLeft, akBottom]
    Caption = 'chkUseOrderingMatrix'
    DataField = 'UseOrderingMatrix'
    TabOrder = 6
    OnClick = chkUseOrderingMatrixClick
  end
  object AlphaOrderX: TwwCheckBox [13]
    Left = 108
    Top = 502
    Width = 15
    Height = 17
    HelpContext = 87014
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akLeft, akBottom]
    Caption = 'chkTOSLaybys'
    DataField = 'OrderingMartixAplhaOrderX'
    TabOrder = 7
    OnClick = AlphaOrderXClick
  end
  object AlphaOrderY: TwwCheckBox [14]
    Left = 370
    Top = 502
    Width = 15
    Height = 17
    HelpContext = 87015
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akRight, akBottom]
    Caption = 'chkTOSLaybys'
    DataField = 'OrderingMartixAplhaOrderY'
    TabOrder = 8
    OnClick = AlphaOrderYClick
  end
  object DNMPanel1: TDNMPanel [15]
    Left = 350
    Top = 72
    Width = 258
    Height = 365
    HelpContext = 87016
    Anchors = [akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 23
      Top = 20
      Width = 98
      Height = 15
      HelpContext = 87017
      Caption = 'Drop Down Name'
      Transparent = True
    end
    object Label1: TLabel
      Left = 191
      Top = 22
      Width = 35
      Height = 15
      HelpContext = 87018
      Caption = 'Active'
      Transparent = True
    end
    object Label7: TLabel
      Left = 16
      Top = 64
      Width = 232
      Height = 41
      HelpContext = 87019
      AutoSize = False
      Caption = 
        'If Not Alpha Ordering                                           ' +
        '     - Enter these as you want displayed'
      Color = clBtnText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object edtTitle: TDBEdit
      Left = 23
      Top = 36
      Width = 153
      Height = 23
      HelpContext = 87020
      DataField = 'ComboName'
      DataSource = DSMaster
      TabOrder = 1
    end
    object grdListValues: TwwDBGrid
      Left = 9
      Top = 109
      Width = 240
      Height = 245
      HelpContext = 87021
      Selected.Strings = (
        'DescriptionAttribValue'#9'28'#9'List Value'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alCustom
      DataSource = DSDetails
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      UseTFields = False
      OnExit = grdListValuesExit
      object btnDelete: TwwIButton
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
        OnClick = btnDeleteClick
      end
    end
    object DBCheckBox1: TwwCheckBox
      Left = 201
      Top = 39
      Width = 13
      Height = 17
      HelpContext = 87022
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
      TabOrder = 0
      OnClick = DBCheckBox1Click
    end
  end
  object cmdCancel: TDNMSpeedButton [16]
    Left = 470
    Top = 537
    Width = 87
    Height = 27
    HelpContext = 87023
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    TabOrder = 1
    OnClick = cmdCancelClick
  end
  object rbtnXAxis: TRadioButton [17]
    Left = 217
    Top = 504
    Width = 15
    Height = 17
    HelpContext = 87024
    Anchors = [akLeft, akBottom]
    Caption = 'Priority'
    Checked = True
    TabOrder = 9
    TabStop = True
  end
  object rbtnYAxis: TRadioButton [18]
    Left = 478
    Top = 504
    Width = 15
    Height = 17
    HelpContext = 87025
    Anchors = [akRight, akBottom]
    Caption = 'rbtnYAxis'
    TabOrder = 10
  end
  object cmdOK: TDNMSpeedButton [19]
    Left = 109
    Top = 536
    Width = 87
    Height = 26
    HelpContext = 87026
    Anchors = [akBottom]
    Caption = '&Save'
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    TabOrder = 2
    OnClick = cmdOKClick
  end
  object pnlTitle: TDNMPanel [20]
    Left = 126
    Top = 6
    Width = 404
    Height = 45
    HelpContext = 87027
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 400
      Height = 41
      HelpContext = 87028
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
        Width = 400
        Height = 41
        HelpContext = 87029
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customise DropDown Lists'
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
  object tblMaster: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT DescriptionAttribID, ComboName, Active, EditedFlag ,Globa' +
        'lRef '
      'FROM tbldescriptionattribsetup')
    AfterScroll = tblMasterAfterScroll
    Left = 546
    Top = 4
    object tblMasterDescriptionAttribID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'DescriptionAttribID'
      ReadOnly = True
    end
    object tblMasterComboName: TStringField
      DisplayWidth = 40
      FieldName = 'ComboName'
      Size = 255
    end
    object tblMasterActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterGlobalRef: TStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 546
    Top = 32
  end
  object tblDetails: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      
        'DescriptionAttribLineID, DescriptionAttribID, DescriptionAttribV' +
        'alue,  '
      'EditedFlag, GlobalRef  '
      'FROM tbldescriptionattriblines'
      'WHERE DescriptionAttribID = :ID'
      'ORDER BY DescriptionAttribLineID')
    BeforePost = tblDetailsBeforePost
    Left = 575
    Top = 4
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblDetailsDescriptionAttribLineID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'DescriptionAttribLineID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsDescriptionAttribID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DescriptionAttribID'
      Visible = False
    end
    object tblDetailsEditedFlag: TStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsGlobalRef: TStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsDescriptionAttribValue: TStringField
      FieldName = 'DescriptionAttribValue'
      Size = 255
    end
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 575
    Top = 32
  end
  object qryDescAttribs: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribID, ComboName'
      'FROM tbldescriptionattribsetup Where Active='#39'T'#39';'
      '')
    Left = 605
    Top = 4
  end
  object qryDescAttribY: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribID, ComboName'
      'FROM tbldescriptionattribsetup '
      'WHERE Active='#39'T'#39' AND DescriptionAttribID <> :xID'
      ''
      '')
    Left = 313
    Top = 427
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
        Size = -1
      end>
  end
  object qryDescAttribX: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribID, ComboName'
      'FROM tbldescriptionattribsetup '
      'WHERE Active='#39'T'#39' AND DescriptionAttribID <> :xID'
      '')
    Left = 313
    Top = 395
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
        Size = -1
      end>
  end
end
