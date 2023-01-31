inherited AssessmentLabelsGUI: TAssessmentLabelsGUI
  Left = 318
  Top = 179
  HelpContext = 19000
  Caption = 'Assessment Labels'
  ClientHeight = 420
  ClientWidth = 618
  OldCreateOrder = True
  DesignSize = (
    618
    420)
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 19001
  end
  object Bevel1: TBevel [1]
    Left = 23
    Top = 64
    Width = 571
    Height = 310
    HelpContext = 19002
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object btnSave: TDNMSpeedButton [2]
    Left = 182
    Top = 381
    Width = 87
    Height = 27
    HelpContext = 19003
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
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [3]
    Left = 367
    Top = 382
    Width = 85
    Height = 27
    HelpContext = 19004
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
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object grdData: TwwDBGrid [4]
    Left = 39
    Top = 79
    Width = 541
    Height = 281
    HelpContext = 19005
    ControlType.Strings = (
      'Active;CustomEdit;chkActive;F'
      'OtherOption;CustomEdit;chkOtherOpt;F'
      'Category;CustomEdit;cboCategory;F')
    Selected.Strings = (
      'Label'#9'30'#9'Label'
      'Category'#9'22'#9'Category'
      'OtherOption'#9'10'#9'Other Option'
      'Active'#9'5'#9'Active')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowInsert]
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
  object chkActive: TwwCheckBox [5]
    Left = 208
    Top = 107
    Width = 39
    Height = 18
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
    Indents.ButtonX = 12
    Anchors = [akRight, akBottom]
    Checked = True
    Color = clWhite
    DataField = 'Active'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    State = cbChecked
    TabOrder = 2
  end
  object chkOtherOpt: TwwCheckBox [6]
    Left = 187
    Top = 135
    Width = 76
    Height = 18
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
    Indents.ButtonX = 30
    Anchors = [akRight, akBottom]
    Color = clWhite
    DataField = 'OtherOption'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 4
  end
  object pnlTitle: TDNMPanel [7]
    Left = 160
    Top = 6
    Width = 304
    Height = 45
    HelpContext = 19006
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 300
      Height = 41
      HelpContext = 19007
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
        Width = 300
        Height = 41
        HelpContext = 19008
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Assessment Labels'
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
  object cboCategory: TwwDBComboBox [8]
    Left = 153
    Top = 181
    Width = 121
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = False
    AutoDropDown = True
    DataField = 'Category'
    DataSource = DSMaster
    DropDownCount = 8
    ItemHeight = 0
    Items.Strings = (
      'Passenger Consideration'
      'Driving Ability')
    ItemIndex = 0
    Sorted = False
    TabOrder = 6
    UnboundDataType = wwDefault
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 69
    Top = 5
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 38
    Top = 3
  end
  inherited MyConnection: TERPConnection
    Left = 5
    Top = 1
  end
  inherited DataState: TDataState
    Left = 37
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 99
    Top = 5
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblassessmentlabels')
    Options.FlatBuffers = True
    Left = 2
    Top = 68
    object tblMasterLabel: TWideStringField
      DisplayWidth = 30
      FieldName = 'Label'
      Origin = 'tblassessmentlabels.Label'
      Size = 40
    end
    object tblMasterCategory: TWideStringField
      AutoGenerateValue = arDefault
      DefaultExpression = 'Passenger Consideration'
      DisplayWidth = 22
      FieldName = 'Category'
      Origin = 'tblassessmentlabels.Category'
      Size = 255
    end
    object tblMasterOtherOption: TWideStringField
      DisplayLabel = 'Other Option'
      DisplayWidth = 10
      FieldName = 'OtherOption'
      Origin = 'tblassessmentlabels.OtherOption'
      FixedChar = True
      Size = 1
    end
    object tblMasterActive: TWideStringField
      DisplayWidth = 5
      FieldName = 'Active'
      Origin = 'tblassessmentlabels.Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterLabelId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'LabelId'
      Origin = 'tblassessmentlabels.LabelId'
      Visible = False
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 3
    Top = 100
  end
end
