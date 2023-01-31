inherited frmAwards: TfrmAwards
  Left = 191
  Top = 139
  HelpContext = 230000
  Caption = 'Award'
  ClientHeight = 558
  ClientWidth = 998
  OldCreateOrder = True
  OnMouseWheel = FormMouseWheel
  ExplicitLeft = 191
  ExplicitTop = 139
  ExplicitWidth = 1014
  ExplicitHeight = 597
  DesignSize = (
    998
    558)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 558
    Width = 998
    HelpContext = 230018
    ExplicitTop = 558
    ExplicitWidth = 998
  end
  object Label1: TLabel [1]
    Left = 199
    Top = 36
    Width = 41
    Height = 15
    HelpContext = 230002
    Caption = 'Search'
    Transparent = True
    Visible = False
  end
  object Bevel1: TBevel [2]
    Left = 177
    Top = 0
    Width = 9
    Height = 558
    HelpContext = 230003
    Anchors = [akLeft, akTop, akBottom]
    Shape = bsLeftLine
  end
  object Label2: TLabel [3]
    Left = 185
    Top = 10
    Width = 48
    Height = 15
    HelpContext = 230004
    Alignment = taCenter
    AutoSize = False
    Caption = 'Scroll'
    Transparent = True
    Visible = False
  end
  object imgPrefs: TImage [4]
    Left = 185
    Top = 28
    Width = 48
    Height = 105
    HelpContext = 230005
    Visible = False
  end
  object Label4: TLabel [5]
    Left = 934
    Top = 525
    Width = 35
    Height = 15
    HelpContext = 230019
    Anchors = [akRight, akBottom]
    Caption = 'Active'
    Transparent = True
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    Left = 192
    Top = 517
    HelpContext = 230001
    ExplicitLeft = 192
    ExplicitTop = 517
  end
  object cboSearch: TwwDBComboBox [10]
    Left = 247
    Top = 26
    Width = 133
    Height = 23
    HelpContext = 230011
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    AutoDropDown = True
    ShowMatchText = True
    DropDownCount = 8
    DropDownWidth = 400
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    Sorted = True
    TabOrder = 0
    UnboundDataType = wwDefault
    Visible = False
    OnCloseUp = cboSearchCloseUp
  end
  object Shader1: TShader [11]
    Left = 185
    Top = 54
    Width = 800
    Height = 31
    HelpContext = 230012
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 5
    FromColor = clBtnFace
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = clBtnFace
    Steps = 10
    Direction = False
    Version = '1.4.0.0'
    object pnlActiveForm: TLabel
      Left = 0
      Top = 0
      Width = 800
      Height = 31
      HelpContext = 230013
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object AdvPicture1: TAdvPicture
      Left = 3
      Top = 6
      Width = 25
      Height = 23
      HelpContext = 230014
      Animate = True
      Picture.Stretch = False
      Picture.Frame = 0
      PicturePosition = bpTopLeft
      StretchMode = smShrink
      Version = '1.4.0.0'
    end
  end
  object pnlTitle: TDNMPanel [12]
    Left = 394
    Top = 6
    Width = 392
    Height = 45
    HelpContext = 230015
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 388
      Height = 41
      HelpContext = 230016
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
        Width = 388
        Height = 41
        HelpContext = 230017
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Award'
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
  object chkActive: TwwCheckBox [13]
    Left = 971
    Top = 525
    Width = 13
    Height = 13
    HelpContext = 230020
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
    Anchors = [akRight, akBottom]
    DataField = 'Active'
    DataSource = DSAwards
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object sbPrefs: TScrollBox [14]
    Left = 185
    Top = 92
    Width = 801
    Height = 419
    HelpContext = 230008
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    TabOrder = 4
  end
  object sbButtons: TScrollBox [15]
    Left = 0
    Top = 0
    Width = 177
    Height = 557
    HelpContext = 230006
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akBottom]
    BorderStyle = bsNone
    TabOrder = 3
    object pnlButtons: TDNMPanel
      Left = 0
      Top = 0
      Width = 177
      Height = 557
      HelpContext = 230007
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
  end
  object btnOK: TDNMSpeedButton [16]
    Left = 452
    Top = 521
    Width = 87
    Height = 27
    HelpContext = 230009
    Anchors = [akLeft, akBottom]
    Caption = 'Save'
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [17]
    Left = 643
    Top = 521
    Width = 87
    Height = 27
    HelpContext = 230010
    Anchors = [akRight, akBottom]
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
  end
  inherited tmrProcessMessage: TTimer
    Left = 229
    Top = 397
  end
  inherited tmrdelay: TTimer
    Left = 305
    Top = 397
  end
  inherited popSpelling: TPopupMenu
    Left = 192
    Top = 397
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 457
    Top = 397
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 419
    Top = 397
  end
  inherited MyConnection: TERPConnection
    Left = 571
    Top = 397
  end
  inherited DataState: TDataState
    Left = 533
    Top = 397
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 495
    Top = 397
  end
  inherited imgsort: TImageList
    Left = 267
    Top = 397
    Bitmap = {
      494C0101020030003C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 194
    Top = 360
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 343
    Top = 397
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 381
    Top = 397
  end
  inherited qryMemTrans: TERPQuery
    Left = 223
    Top = 360
  end
  object ImageScroll: TImageScroll
    Enabled = False
    Left = 601
    Top = 397
  end
  object qryawardclassificationdetails: TERPQuery
    SQL.Strings = (
      'Select * from tblawardclassificationdetails '
      'WHERE AwardID = :xAwardID;')
    Left = 458
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end>
    object qryawardclassificationdetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryawardclassificationdetailsClassificationID: TAutoIncField
      FieldName = 'ClassificationID'
    end
    object qryawardclassificationdetailsAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object qryawardclassificationdetailsClassification: TWideStringField
      FieldName = 'Classification'
      Size = 50
    end
    object qryawardclassificationdetailsType: TWideStringField
      FieldName = 'Type'
      FixedChar = True
      Size = 35
    end
    object qryawardclassificationdetailsFullTime: TFloatField
      FieldName = 'FullTime'
      DisplayFormat = '$#0.00##'
    end
    object qryawardclassificationdetailsPartTime: TFloatField
      FieldName = 'PartTime'
      DisplayFormat = '$#0.00##'
    end
    object qryawardclassificationdetailsCasual: TFloatField
      FieldName = 'Casual'
      DisplayFormat = '$#0.00##'
    end
    object qryawardclassificationdetailsCasualLoading: TFloatField
      FieldName = 'CasualLoading'
      DisplayFormat = '###0.00%'
      EditFormat = '###0.00%'
    end
    object qryawardclassificationdetailsAdvanceIDName: TWideStringField
      FieldName = 'AdvanceIDName'
      Size = 255
    end
    object qryawardclassificationdetailsAdvanceID: TIntegerField
      FieldName = 'AdvanceID'
    end
    object qryawardclassificationdetailsFTHourlyRate: TFloatField
      FieldName = 'FTHourlyRate'
    end
    object qryawardclassificationdetailsPTHourlyRate: TFloatField
      FieldName = 'PTHourlyRate'
    end
    object qryawardclassificationdetailsCHourlyRate: TFloatField
      FieldName = 'CHourlyRate'
    end
    object qryawardclassificationdetailsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryawardclassificationdetailsAdvanceToClassification: TWideStringField
      FieldName = 'AdvanceToClassification'
      Size = 255
    end
  end
  object qryclassificationallowances: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblclassificationallowances '
      
        'WHERE AwardID= :xAwardID AND ClassificationID = :xClassification' +
        'ID')
    Left = 252
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
    object qryclassificationallowancesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryclassificationallowancesAllowanceID: TAutoIncField
      FieldName = 'AllowanceID'
    end
    object qryclassificationallowancesClassificationID: TIntegerField
      FieldName = 'ClassificationID'
    end
    object qryclassificationallowancesAllowID: TIntegerField
      FieldName = 'AllowID'
    end
    object qryclassificationallowancesAmount: TFloatField
      FieldName = 'Amount'
      DisplayFormat = '#0.00'
      EditFormat = '#0.00'
    end
    object qryclassificationallowancesCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryclassificationallowancesBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryclassificationallowancesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryclassificationallowancesAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object qryclassificationallowanceslookupAllowance: TWideStringField
      FieldKind = fkLookup
      FieldName = 'lookupAllowance'
      LookupDataSet = qryAllowances
      LookupKeyFields = 'AllowanceID'
      LookupResultField = 'Description'
      KeyFields = 'AllowID'
      Size = 35
      Lookup = True
    end
    object qryclassificationallowanceslookupBasedOn: TWideStringField
      FieldKind = fkLookup
      FieldName = 'lookupBasedOn'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 35
      Lookup = True
    end
  end
  object qryAllowances: TERPQuery
    SQL.Strings = (
      
        'Select AllowanceID, Description, SuperInc, TaxExempt, PayrollTax' +
        'Exempt, '
      'WorkcoverExempt, DisplayIn, Amount, CalcBy, BasedOnID, Active'
      'FROM tblAllowances'
      'WHERE Active='#39'T'#39)
    Left = 547
    Top = 360
    object qryAllowancesDescription: TWideStringField
      DisplayWidth = 150
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
    object qryAllowancesPayrollTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'PayrollTaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesWorkcoverExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'WorkcoverExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesDisplayIn: TWideStringField
      DisplayWidth = 31
      FieldName = 'DisplayIn'
      Visible = False
      FixedChar = True
      Size = 31
    end
    object qryAllowancesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
    end
    object qryAllowancesCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryAllowancesBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
    object qryAllowancesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryBasedOn: TERPQuery
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 606
    Top = 360
  end
  object qryClassificationDeductions: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblclassificationdeductions '
      
        'WHERE AwardID = :xAwardID AND ClassificationID = :xClassificatio' +
        'nID')
    Left = 429
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
    object qryClassificationDeductionsAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      DisplayFormat = '#0.00'
      EditFormat = '#0.00'
    end
    object qryClassificationDeductionsCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryClassificationDeductionsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      FixedChar = True
      Size = 255
    end
    object qryClassificationDeductionsDeductionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeductionID'
      Visible = False
    end
    object qryClassificationDeductionsClassificationID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassificationID'
      Visible = False
    end
    object qryClassificationDeductionsDeductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeductID'
      Visible = False
    end
    object qryClassificationDeductionsBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
    object qryClassificationDeductionsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClassificationDeductionsAwardID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AwardID'
      Visible = False
    end
    object qryClassificationDeductionsDeductionLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'DeductionLookup'
      LookupDataSet = qryDeductions
      LookupKeyFields = 'DeductionID'
      LookupResultField = 'Description'
      KeyFields = 'DeductID'
      Size = 25
      Lookup = True
    end
    object qryClassificationDeductionsBasedOnLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'BasedOnLookup'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 25
      Lookup = True
    end
  end
  object qryDeductions: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tbldeductions WHERE Active = '#39'T'#39)
    Left = 576
    Top = 360
    object qryDeductionsDescription: TWideStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 150
    end
    object qryDeductionsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryDeductionsDeductionID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'DeductionID'
      ReadOnly = True
      Visible = False
    end
    object qryDeductionsTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsUnionFees: TWideStringField
      DisplayWidth = 1
      FieldName = 'UnionFees'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDeductionsDisplayIn: TWideStringField
      FieldName = 'DisplayIn'
      FixedChar = True
      Size = 31
    end
    object qryDeductionsAmount: TFloatField
      FieldName = 'Amount'
    end
    object qryDeductionsBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryDeductionsCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
  end
  object qryClassificationExtraPayRates: TERPQuery
    SQL.Strings = (
      'Select *'
      'From tblClassificationExtraPayRates'
      
        'WHERE AwardID=:xAwardID AND ClassificationID = :xClassificationI' +
        'D')
    Left = 282
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassificationID'
      end>
    object qryClassificationExtraPayRatesRateID: TAutoIncField
      FieldName = 'RateID'
      ReadOnly = True
    end
    object qryClassificationExtraPayRatesClassificationID: TIntegerField
      FieldName = 'ClassificationID'
    end
    object qryClassificationExtraPayRatesPayRate: TIntegerField
      FieldName = 'PayRate'
    end
    object qryClassificationExtraPayRatesTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object qryClassificationExtraPayRatesPayRateType: TWideStringField
      FieldKind = fkLookup
      FieldName = 'PayRateType'
      LookupDataSet = qryPayRateType
      LookupKeyFields = 'TypeID'
      LookupResultField = 'Description'
      KeyFields = 'TypeID'
      Lookup = True
    end
    object qryClassificationExtraPayRatesWorked: TFloatField
      FieldName = 'Worked'
    end
    object qryClassificationExtraPayRatesAmount: TFloatField
      FieldName = 'Amount'
      currency = True
    end
    object qryClassificationExtraPayRatesSuperInc: TWideStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryClassificationExtraPayRatesExtraPayRate: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ExtraPayRate'
      LookupDataSet = qryExtraPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRate'
      Lookup = True
    end
    object qryClassificationExtraPayRatesAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object qryClassificationExtraPayRatesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object qryPayRateType: TERPQuery
    SQL.Strings = (
      'Select TypeID, Description'
      'FROM tblPayRateType')
    Left = 311
    Top = 360
  end
  object qryExtraPayRates: TERPQuery
    SQL.Strings = (
      'Select RateID, Description, Multiplier'
      'FROM tblPayRates '
      'WHERE Description <> '#39'Normal Hours'#39
      'AND Active='#39'T'#39)
    Left = 400
    Top = 360
  end
  object qryAwardLeave: TERPQuery
    SQL.Strings = (
      'select *  from tblawardsleave WHERE AwardID=:xAwardID')
    Left = 341
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end>
    object qryAwardLeaveGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryAwardLeaveLeaveID: TAutoIncField
      FieldName = 'LeaveID'
      ReadOnly = True
    end
    object qryAwardLeaveAwardID: TIntegerField
      FieldName = 'AwardID'
    end
    object qryAwardLeaveType: TWideStringField
      FieldName = 'Type'
      FixedChar = True
      Size = 50
    end
    object qryAwardLeaveAccrueAfterNo: TFloatField
      FieldName = 'AccrueAfterNo'
    end
    object qryAwardLeaveAccrueAfterPeriod: TWideStringField
      FieldName = 'AccrueAfterPeriod'
      FixedChar = True
      Size = 28
    end
    object qryAwardLeaveAccrueNo: TFloatField
      FieldName = 'AccrueNo'
    end
    object qryAwardLeaveAccruePeriod: TWideStringField
      FieldName = 'AccruePeriod'
      FixedChar = True
      Size = 28
    end
    object qryAwardLeaveAccrueHours: TFloatField
      FieldName = 'AccrueHours'
      DisplayFormat = '0.#####'
    end
    object qryAwardLeaveEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryAwardLeaveAwardStartDate: TDateField
      FieldName = 'AwardStartDate'
    end
    object qryAwardLeaveAwardEndDate: TDateField
      FieldName = 'AwardEndDate'
    end
    object qryAwardLeaveUseStartEndDates: TWideStringField
      FieldName = 'UseStartEndDates'
      FixedChar = True
      Size = 1
    end
    object qryAwardLeaveLeaveLoading: TFloatField
      FieldName = 'LeaveLoading'
    end
  end
  object qryAwards: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblAwards'
      'WHERE AwardID=:xAwardID')
    Left = 488
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xAwardID'
      end>
    object qryAwardsAwardID: TAutoIncField
      FieldName = 'AwardID'
      ReadOnly = True
    end
    object qryAwardsAwardName: TWideStringField
      FieldName = 'AwardName'
      Size = 150
    end
    object qryAwardsArea: TWideStringField
      FieldName = 'Area'
      Size = 50
    end
    object qryAwardsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryAwardsPayPeriod: TWideStringField
      FieldName = 'PayPeriod'
      FixedChar = True
      Size = 37
    end
    object qryAwardsSuperType: TWideStringField
      FieldName = 'SuperType'
      FixedChar = True
      Size = 17
    end
    object qryAwardsAnnualLeaveLoading: TFloatField
      FieldName = 'AnnualLeaveLoading'
      DisplayFormat = '##0.00%'
    end
    object qryAwardsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryAwardsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryAwardsSuperValue: TFloatField
      FieldName = 'SuperValue'
    end
    object qryAwardsMealBreakHours: TFloatField
      FieldName = 'MealBreakHours'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryAwardsMealBreakThreshold: TFloatField
      FieldName = 'MealBreakThreshold'
    end
    object qryAwardsPaySuperOnLeaveLoading: TWideStringField
      FieldName = 'PaySuperOnLeaveLoading'
      FixedChar = True
      Size = 1
    end
    object qryAwardsUseCompanySuperThreshold: TWideStringField
      FieldName = 'UseCompanySuperThreshold'
      FixedChar = True
      Size = 1
    end
    object qryAwardsSuperThresholdAmount: TFloatField
      FieldName = 'SuperThresholdAmount'
      currency = True
    end
    object qryAwardsSickLeaveDaysThreshold: TIntegerField
      FieldName = 'SickLeaveDaysThreshold'
    end
  end
  object qryAwardShifts: TERPQuery
    SQL.Strings = (
      'select * from tblawardshifts')
    Left = 370
    Top = 360
    object qryAwardShiftsPayRate: TWideStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'PayRate'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRateID'
      Size = 255
      Lookup = True
    end
    object qryAwardShiftsStartDay: TWideStringField
      DisplayLabel = '~Day'
      DisplayWidth = 10
      FieldName = 'StartDay'
      FixedChar = True
      Size = 68
    end
    object qryAwardShiftsStartTime: TDateTimeField
      DisplayLabel = 'Start Time'
      DisplayWidth = 12
      FieldName = 'StartTime'
    end
    object qryAwardShiftsEndDay: TWideStringField
      DisplayWidth = 10
      FieldName = 'EndDay'
      FixedChar = True
      Size = 68
    end
    object qryAwardShiftsEndTime: TDateTimeField
      DisplayWidth = 12
      FieldName = 'EndTime'
    end
    object qryAwardShiftsRate1AfterHours: TFloatField
      DisplayWidth = 10
      FieldName = 'Rate1AfterHours'
    end
    object qryAwardShiftsRate1PayRate: TIntegerField
      DisplayWidth = 10
      FieldName = 'Rate1PayRate'
    end
    object qryAwardShiftsRate2AfterHours: TFloatField
      DisplayWidth = 10
      FieldName = 'Rate2AfterHours'
    end
    object qryAwardShiftsRate2PayRate: TIntegerField
      DisplayWidth = 10
      FieldName = 'Rate2PayRate'
    end
    object qryAwardShiftsSuperInc: TWideStringField
      DisplayWidth = 5
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 45
    end
    object qryAwardShiftsShiftID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShiftID'
      Visible = False
    end
    object qryAwardShiftsAwardID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AwardID'
      Visible = False
    end
    object qryAwardShiftsPayRateID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayRateID'
      Visible = False
    end
    object qryAwardShiftsPayRate1: TWideStringField
      FieldKind = fkLookup
      FieldName = 'PayRate1'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'Rate1PayRate'
      Size = 255
      Lookup = True
    end
  end
  object qryPayRates: TERPQuery
    SQL.Strings = (
      'Select RateID, Description, Multiplier'
      'FROM tblPayRates')
    Left = 517
    Top = 360
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
  object DSAwards: TDataSource
    DataSet = qryAwards
    Left = 488
    Top = 330
  end
end
