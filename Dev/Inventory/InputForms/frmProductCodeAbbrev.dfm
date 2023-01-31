inherited ProductCodeAbbrevGUI: TProductCodeAbbrevGUI
  Left = 305
  Top = 301
  HelpContext = 441000
  Caption = 'Product Code Abbreviations'
  ClientHeight = 476
  ClientWidth = 673
  OldCreateOrder = True
  DesignSize = (
    673
    476)
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 441001
  end
  object cmdOK: TDNMSpeedButton [1]
    Left = 157
    Top = 444
    Width = 87
    Height = 26
    HelpContext = 441002
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
  object wwDBGrid1: TwwDBGrid [2]
    Left = 50
    Top = 72
    Width = 258
    Height = 365
    HelpContext = 441003
    Selected.Strings = (
      'CatagoryName'#9'31'#9'Category Name'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 350
    Top = 72
    Width = 258
    Height = 365
    HelpContext = 441004
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
      Width = 119
      Height = 15
      HelpContext = 441005
      Caption = 'Code Category Name'
      Transparent = True
    end
    object Label1: TLabel
      Left = 191
      Top = 22
      Width = 35
      Height = 15
      HelpContext = 441006
      Caption = 'Active'
      Transparent = True
    end
    object DBCheckBox1: TDBCheckBox
      Left = 203
      Top = 39
      Width = 13
      Height = 17
      HelpContext = 441007
      Caption = 'Active'
      Color = 14211288
      DataField = 'Active'
      DataSource = DSMaster
      ParentColor = False
      TabOrder = 0
      ValueChecked = 'T'
      ValueUnchecked = 'F'
    end
    object edtTitle: TDBEdit
      Left = 23
      Top = 36
      Width = 153
      Height = 23
      HelpContext = 441008
      DataField = 'CatagoryName'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object wwDBGrid2: TwwDBGrid
      Left = 9
      Top = 85
      Width = 240
      Height = 269
      HelpContext = 441009
      ControlType.Strings = (
        'DescriptionAttribAbbrev;CustomEdit;edtAbbrev;F')
      Selected.Strings = (
        'DescriptionAttribValue'#9'22'#9'Entry Value'#9'F'#9
        'DescriptionAttribAbbrev'#9'3'#9'Abbrev'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alCustom
      DataSource = DSDetails
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab, dgAllowDelete, dgAllowInsert]
      ParentFont = False
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnExit = wwDBGrid2Exit
    end
  end
  object cmdCancel: TDNMSpeedButton [4]
    Left = 414
    Top = 444
    Width = 87
    Height = 27
    HelpContext = 441010
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
  object pnlTitle: TDNMPanel [5]
    Left = 118
    Top = 6
    Width = 422
    Height = 45
    HelpContext = 441011
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 418
      Height = 41
      HelpContext = 441012
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
        Width = 418
        Height = 41
        HelpContext = 441013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Product Code Abbreviations'
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
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT DescriptionAttribID, CatagoryName, Active, EditedFlag ,Gl' +
        'obalRef '
      'FROM tblproductcodeabbrevsetup')
    AfterScroll = tblMasterAfterScroll
    Left = 8
    Top = 412
    object tblMasterComboName: TWideStringField
      DisplayLabel = 'Category Name'
      DisplayWidth = 31
      FieldName = 'CatagoryName'
      Size = 255
    end
    object tblMasterDescriptionAttribID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'DescriptionAttribID'
      ReadOnly = True
      Visible = False
    end
    object tblMasterActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblMasterGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 8
    Top = 442
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT DescriptionAttribLineID, DescriptionAttribID, Description' +
        'AttribValue,  DescriptionAttribAbbrev,  EditedFlag, GlobalRef  '
      'FROM tblproductcodeabbrevlines'
      'Where DescriptionAttribID = :ID;')
    BeforePost = tblDetailsBeforePost
    OnPostError = tblDetailsPostError
    Left = 42
    Top = 412
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsDescriptionAttribValue: TWideStringField
      DisplayLabel = 'Entry Value'
      DisplayWidth = 22
      FieldName = 'DescriptionAttribValue'
      Size = 255
    end
    object tblDetailsDescriptionAttribAbbrev: TWideStringField
      DisplayLabel = 'Abbrev'
      DisplayWidth = 3
      FieldName = 'DescriptionAttribAbbrev'
      Required = True
      FixedChar = True
      Size = 3
    end
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
    object tblDetailsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 42
    Top = 442
  end
end
