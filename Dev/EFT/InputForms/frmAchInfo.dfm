inherited fmAchInfo: TfmAchInfo
  Left = 777
  Top = 48
  HelpContext = 1061002
  Caption = 'ACH Infomation'
  ClientHeight = 325
  ClientWidth = 455
  ShowHint = True
  ExplicitLeft = 777
  ExplicitTop = 48
  ExplicitWidth = 471
  ExplicitHeight = 364
  DesignSize = (
    455
    325)
  PixelsPerInch = 96
  TextHeight = 15
  object Box20: TBevel [0]
    Left = 19
    Top = 49
    Width = 409
    Height = 216
    HelpContext = 1061003
  end
  inherited lblSkingroupMsg: TLabel
    Top = 325
    Width = 455
    HelpContext = 1061004
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 49
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 113
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object Label1: TLabel [5]
    Left = 175
    Top = 260
    Width = 31
    Height = 15
    HelpContext = 1061005
    Alignment = taRightJustify
    Caption = 'TaxID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Label2: TLabel [6]
    Left = 73
    Top = 190
    Width = 133
    Height = 15
    HelpContext = 1061006
    Alignment = taRightJustify
    Caption = 'Immediate Origin Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Address_Label: TLabel [7]
    Left = 61
    Top = 155
    Width = 145
    Height = 15
    HelpContext = 1061007
    Alignment = taRightJustify
    Caption = 'Immediate Origin Number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object CompanyName_Label: TLabel [8]
    Left = 29
    Top = 61
    Width = 94
    Height = 18
    HelpContext = 1061008
    AutoSize = False
    Caption = 'Company Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label3: TLabel [9]
    Left = 88
    Top = 121
    Width = 118
    Height = 15
    HelpContext = 1061009
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Company No'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblAccount: TLabel [10]
    Left = 29
    Top = 225
    Width = 177
    Height = 15
    HelpContext = 1061010
    Caption = 'Immediate Destination Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object txtAddress: TDBMemo [12]
    Left = 231
    Top = 152
    Width = 186
    Height = 23
    Hint = 
      'Ten digit company number eg IRS Federal Tax ID number or Bank Ro' +
      'uting number'
    HelpContext = 1061014
    DataField = 'ImmediateOriginNumber'
    DataSource = dsAchInfo
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object txtAddress2: TDBMemo [13]
    Left = 231
    Top = 187
    Width = 186
    Height = 23
    Hint = 'Bank Name'
    HelpContext = 1061015
    DataField = 'ImmediateOriginName'
    DataSource = dsAchInfo
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object txtAddress3: TDBMemo [14]
    Left = 231
    Top = 256
    Width = 186
    Height = 23
    HelpContext = 1061016
    DataField = 'TaxID'
    DataSource = dsAchInfo
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
  end
  object cmdClose: TDNMSpeedButton [15]
    Left = 96
    Top = 281
    Width = 93
    Height = 29
    HelpContext = 1061017
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
    OnClick = cmdCloseClick
  end
  object cmdCancel: TDNMSpeedButton [16]
    Left = 251
    Top = 281
    Width = 93
    Height = 29
    HelpContext = 1061018
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 6
    OnClick = cmdCancelClick
  end
  object txtCompanyName: TDBEdit [17]
    Left = 29
    Top = 81
    Width = 388
    Height = 23
    Hint = 'Company Name from Company Info card'
    HelpContext = 1061019
    DataField = 'CompanyName'
    DataSource = frmCompanyInformationSrc
    TabOrder = 0
  end
  object edtCompanyNumber: TDBEdit [18]
    Left = 231
    Top = 118
    Width = 136
    Height = 23
    Hint = 'Company Number from Company Info card'
    HelpContext = 1061020
    DataField = 'CompanyNumber'
    DataSource = frmCompanyInformationSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object cboAccount: TwwDBLookupCombo [19]
    Left = 231
    Top = 221
    Width = 186
    Height = 23
    HelpContext = 1061021
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'50'#9'AccountName'#9'F')
    DataField = 'ImmediateDestination_Accountname'
    DataSource = dsAchInfo
    LookupTable = cboAccountQry
    LookupField = 'AccountName'
    ParentFont = False
    TabOrder = 8
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object pnlTitle: TDNMPanel [20]
    Left = 19
    Top = 4
    Width = 409
    Height = 39
    HelpContext = 1061011
    
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 7
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 407
      Height = 37
      HelpContext = 1061012
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
        Width = 407
        Height = 37
        HelpContext = 1061013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'ACH Infomation'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 171
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 105
    Top = 225
  end
  inherited tmrdelay: TTimer
    Left = 233
    Top = 145
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 139
    Top = 225
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 275
    Top = 225
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 309
    Top = 225
  end
  inherited DataState: TDataState
    Left = 173
    Top = 225
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 343
    Top = 225
  end
  inherited imgsort: TImageList
    Left = 229
    Top = 225
    Bitmap = {
      494C010102007C00880010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 71
    Top = 225
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 377
    Top = 225
  end
  object qryAchInfo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblAchInfo')
    Left = 37
    Top = 225
    object qryAchInfoID: TIntegerField
      FieldName = 'ID'
    end
    object qryAchInfoGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryAchInfoImmediateOriginNumber: TWideStringField
      FieldName = 'ImmediateOriginNumber'
      Size = 15
    end
    object qryAchInfoImmediateOriginName: TWideStringField
      FieldName = 'ImmediateOriginName'
      Size = 255
    end
    object qryAchInfoTaxID: TWideStringField
      FieldName = 'TaxID'
      Size = 15
    end
    object qryAchInfomsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryAchInfomsupDatesiteCode: TWideStringField
      FieldName = 'msupDatesiteCode'
      Size = 3
    end
    object qryAchInfoImmediateDestination_AccountID: TIntegerField
      FieldName = 'ImmediateDestination_AccountID'
    end
    object qryAchInfoImmediateDestination_Accountname: TWideStringField
      FieldName = 'ImmediateDestination_Accountname'
      Size = 100
    end
  end
  object dsAchInfo: TDataSource
    DataSet = qryAchInfo
    Left = 37
    Top = 195
  end
  object CompanyInfo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCompanyInformation'
      'WHERE SetupID=:KeyID;')
    Left = 7
    Top = 225
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object CompanyInfoSetupID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'SetupID'
      Origin = 'tblCompanyInformation.SetupID'
      ReadOnly = True
    end
    object CompanyInfoCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Origin = 'tblCompanyInformation.CompanyName'
      Size = 200
    end
    object CompanyInfoTradingName: TWideStringField
      FieldName = 'TradingName'
      Origin = 'tblCompanyInformation.TradingName'
      Size = 200
    end
    object CompanyInfoContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'tblCompanyInformation.ContactName'
      Size = 255
    end
    object CompanyInfoContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Origin = 'tblCompanyInformation.ContactEmail'
      Size = 255
    end
    object CompanyInfoPhoneNumber: TWideStringField
      FieldName = 'PhoneNumber'
      Origin = 'tblCompanyInformation.PhoneNumber'
      EditMask = '(##)#### ####;0;_'
      Size = 255
    end
    object CompanyInfoFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblCompanyInformation.FaxNumber'
      EditMask = '(##)#### ####;0;_'
      Size = 255
    end
    object CompanyInfoABN: TWideStringField
      DisplayWidth = 15
      FieldName = 'ABN'
      Origin = 'tblCompanyInformation.ABN'
      EditMask = '## ### ### ###;0;_'
      Size = 15
    end
    object CompanyInfoEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblCompanyInformation.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object CompanyInfoPOBox: TWideStringField
      FieldName = 'POBox'
      Origin = 'tblCompanyInformation.POBox'
      Size = 255
    end
    object CompanyInfoPOBox2: TWideStringField
      FieldName = 'POBox2'
      Origin = 'tblCompanyInformation.POBox2'
      Size = 255
    end
    object CompanyInfoPOBox3: TWideStringField
      FieldName = 'POBox3'
      Size = 255
    end
    object CompanyInfoPOCity: TWideStringField
      FieldName = 'POCity'
      Origin = 'tblCompanyInformation.POCity'
      Size = 255
    end
    object CompanyInfoPOState: TWideStringField
      FieldName = 'POState'
      Origin = 'tblCompanyInformation.POState'
      Size = 255
    end
    object CompanyInfoPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Origin = 'tblCompanyInformation.POPostcode'
      Size = 255
    end
    object CompanyInfoPOCountry: TWideStringField
      FieldName = 'POCountry'
      Origin = 'tblCompanyInformation.POCountry'
      Size = 255
    end
    object CompanyInfoETPPayerType: TWideStringField
      FieldName = 'ETPPayerType'
      Origin = 'tblCompanyInformation.ETPPayerType'
      FixedChar = True
      Size = 1
    end
    object CompanyInfoFileReference: TWideStringField
      FieldName = 'FileReference'
      Origin = 'tblCompanyInformation.FileReference'
      Size = 16
    end
    object CompanyInfoTaxSignatory: TWideStringField
      FieldName = 'TaxSignatory'
      Origin = 'tblCompanyInformation.TaxSignatory'
      Size = 38
    end
    object CompanyInfoLeaveLoadingPercent: TFloatField
      FieldName = 'LeaveLoadingPercent'
      Origin = 'tblCompanyInformation.LeaveLoadingPercent'
    end
    object CompanyInfoCompulsorySuperPercent: TFloatField
      FieldName = 'CompulsorySuperPercent'
      Origin = 'tblCompanyInformation.CompulsorySuperPercent'
    end
    object CompanyInfoBSB: TWideStringField
      FieldName = 'BSB'
      Origin = 'tblCompanyInformation.BSB'
      Size = 10
    end
    object CompanyInfoAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Origin = 'tblCompanyInformation.AccountNo'
      Size = 50
    end
    object CompanyInfoFontCompanyName: TWideStringField
      FieldName = 'FontCompanyName'
      Origin = 'tblCompanyInformation.FontCompanyName'
      Size = 50
    end
    object CompanyInfoFontAddress: TWideStringField
      FieldName = 'FontAddress'
      Origin = 'tblCompanyInformation.FontAddress'
      Size = 50
    end
    object CompanyInfoFontSuburb: TWideStringField
      FieldName = 'FontSuburb'
      Origin = 'tblCompanyInformation.FontSuburb'
      Size = 50
    end
    object CompanyInfoFontPhone: TWideStringField
      FieldName = 'FontPhone'
      Origin = 'tblCompanyInformation.FontPhone'
      Size = 50
    end
    object CompanyInfoFontABN: TWideStringField
      FieldName = 'FontABN'
      Origin = 'tblCompanyInformation.FontABN'
      Size = 50
    end
    object CompanyInfoFontDefault: TWideStringField
      FieldName = 'FontDefault'
      Origin = 'tblCompanyInformation.FontDefault'
      Size = 50
    end
    object CompanyInfoSizeCompanyName: TIntegerField
      FieldName = 'SizeCompanyName'
      Origin = 'tblCompanyInformation.SizeCompanyName'
    end
    object CompanyInfoSizeAddress: TIntegerField
      FieldName = 'SizeAddress'
      Origin = 'tblCompanyInformation.SizeAddress'
    end
    object CompanyInfoSizeSuburb: TIntegerField
      FieldName = 'SizeSuburb'
      Origin = 'tblCompanyInformation.SizeSuburb'
    end
    object CompanyInfoSizePhone: TIntegerField
      FieldName = 'SizePhone'
      Origin = 'tblCompanyInformation.SizePhone'
    end
    object CompanyInfoSizeABN: TIntegerField
      FieldName = 'SizeABN'
      Origin = 'tblCompanyInformation.SizeABN'
    end
    object CompanyInfoSizeDefault: TIntegerField
      FieldName = 'SizeDefault'
      Origin = 'tblCompanyInformation.SizeDefault'
    end
    object CompanyInfoColorCompanyName: TWideStringField
      FieldName = 'ColorCompanyName'
      Origin = 'tblCompanyInformation.ColorCompanyName'
      Size = 50
    end
    object CompanyInfoColorAddress: TWideStringField
      FieldName = 'ColorAddress'
      Origin = 'tblCompanyInformation.ColorAddress'
      Size = 50
    end
    object CompanyInfoColorSuburb: TWideStringField
      FieldName = 'ColorSuburb'
      Origin = 'tblCompanyInformation.ColorSuburb'
      Size = 50
    end
    object CompanyInfoColorPhone: TWideStringField
      FieldName = 'ColorPhone'
      Origin = 'tblCompanyInformation.ColorPhone'
      Size = 50
    end
    object CompanyInfoColorABN: TWideStringField
      FieldName = 'ColorABN'
      Origin = 'tblCompanyInformation.ColorABN'
      Size = 50
    end
    object CompanyInfoColorDefault: TWideStringField
      FieldName = 'ColorDefault'
      Origin = 'tblCompanyInformation.ColorDefault'
      Size = 50
    end
    object CompanyInfoStyleCompanyName: TWideStringField
      FieldName = 'StyleCompanyName'
      Origin = 'tblCompanyInformation.StyleCompanyName'
      Size = 4
    end
    object CompanyInfoStyleAddress: TWideStringField
      FieldName = 'StyleAddress'
      Origin = 'tblCompanyInformation.StyleAddress'
      Size = 4
    end
    object CompanyInfoStyleSuburb: TWideStringField
      FieldName = 'StyleSuburb'
      Origin = 'tblCompanyInformation.StyleSuburb'
      Size = 4
    end
    object CompanyInfoStylePhone: TWideStringField
      FieldName = 'StylePhone'
      Origin = 'tblCompanyInformation.StylePhone'
      Size = 4
    end
    object CompanyInfoStyleABN: TWideStringField
      FieldName = 'StyleABN'
      Origin = 'tblCompanyInformation.StyleABN'
      Size = 4
    end
    object CompanyInfoStyleDefault: TWideStringField
      FieldName = 'StyleDefault'
      Origin = 'tblCompanyInformation.StyleDefault'
      Size = 4
    end
    object CompanyInfoBankCode: TIntegerField
      FieldName = 'BankCode'
      Origin = 'tblCompanyInformation.BankCode'
    end
    object CompanyInfoBankBranch: TWideStringField
      FieldName = 'BankBranch'
      Origin = 'tblCompanyInformation.BankBranch'
      Size = 150
    end
    object CompanyInfoAPCANo: TWideStringField
      FieldName = 'APCANo'
      Origin = 'tblCompanyInformation.APCANo'
      Size = 50
    end
    object CompanyInfoWorkersCompInsurer: TIntegerField
      FieldName = 'WorkersCompInsurer'
      Origin = 'tblCompanyInformation.WorkersCompInsurer'
    end
    object CompanyInfoEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblCompanyInformation.Email'
      Size = 255
    end
    object CompanyInfoGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblCompanyInformation.GlobalRef'
      Size = 255
    end
    object CompanyInfoAddress: TWideStringField
      FieldName = 'Address'
      Origin = 'tblCompanyInformation.Address'
      Size = 255
    end
    object CompanyInfoAddress2: TWideStringField
      FieldName = 'Address2'
      Origin = 'tblCompanyInformation.Address2'
      Size = 255
    end
    object CompanyInfoAddress3: TWideStringField
      FieldName = 'Address3'
      Size = 255
    end
    object CompanyInfoCity: TWideStringField
      FieldName = 'City'
      Origin = 'tblCompanyInformation.City'
      Size = 255
    end
    object CompanyInfoState: TWideStringField
      FieldName = 'State'
      Origin = 'tblCompanyInformation.State'
      Size = 255
    end
    object CompanyInfoPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblCompanyInformation.Postcode'
      Size = 255
    end
    object CompanyInfoCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblCompanyInformation.Country'
      Size = 255
    end
    object CompanyInfoURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblCompanyInformation.URL'
      Size = 255
    end
    object CompanyInfoContact: TWideStringField
      FieldName = 'Contact'
      Origin = 'tblCompanyInformation.Contact'
      Size = 255
    end
    object CompanyInfoMenuColor: TIntegerField
      FieldName = 'MenuColor'
      Origin = 'tblCompanyInformation.MenuColor'
    end
    object CompanyInfoSupplierId: TWideStringField
      FieldName = 'SupplierId'
      Origin = 'tblCompanyInformation.SupplierId'
      Size = 30
    end
    object CompanyInfoDVAABN: TWideStringField
      FieldName = 'DVAABN'
      Origin = 'tblCompanyInformation.DVAABN'
      Size = 100
    end
    object CompanyInfoRAPloginID: TWideStringField
      FieldName = 'RAPloginID'
      Origin = 'tblCompanyInformation.RAPloginID'
      Size = 100
    end
    object CompanyInfoRAPPassword: TWideStringField
      FieldName = 'RAPPassword'
      Origin = 'tblCompanyInformation.RAPPassword'
      Size = 100
    end
    object CompanyInfoRAPLoginPage: TWideStringField
      FieldName = 'RAPLoginPage'
      Origin = 'tblCompanyInformation.RAPLoginPage'
      Size = 255
    end
    object CompanyInfoRAPProgramName: TWideStringField
      FieldName = 'RAPProgramName'
      Origin = 'tblCompanyInformation.RAPProgramName'
      Size = 255
    end
    object CompanyInfoRAPInvoiceDescription: TWideStringField
      FieldName = 'RAPInvoiceDescription'
      Origin = 'tblCompanyInformation.RAPInvoiceDescription'
      Size = 255
    end
    object CompanyInfoRAPProductGroup: TWideStringField
      FieldName = 'RAPProductGroup'
      Origin = 'tblCompanyInformation.RAPProductGroup'
      Size = 255
    end
    object CompanyInfoRAPContractNumber: TWideStringField
      FieldName = 'RAPContractNumber'
      Origin = 'tblCompanyInformation.RAPContractNumber'
      Size = 100
    end
    object CompanyInfoCompanyNumber: TWideStringField
      FieldName = 'CompanyNumber'
      Size = 255
    end
    object CompanyInfoTrackEmails: TWideStringField
      FieldName = 'TrackEmails'
      FixedChar = True
      Size = 1
    end
  end
  object frmCompanyInformationSrc: TDataSource
    DataSet = CompanyInfo
    Left = 15
    Top = 187
  end
  object cboAccountQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountID, AccountName'
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'BANK'#39)
    Options.LongStrings = False
    Left = 242
    Top = 231
    object cboAccountQryAccountName: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountName'
      Origin = 'tblchartofaccounts.AccountName'
      Size = 50
    end
    object cboAccountQryAccountID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AccountID'
      Origin = 'tblchartofaccounts.AccountID'
      Visible = False
    end
  end
end
