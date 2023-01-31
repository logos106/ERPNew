inherited fmLogmeInDetails: TfmLogmeInDetails
  Left = 513
  Top = 243
  HelpContext = 645000
  Caption = 'LogMeIn Details'
  ClientHeight = 347
  ClientWidth = 442
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 8
    Top = 64
    Width = 426
    Height = 41
    HelpContext = 645001
  end
  object Box72: TBevel [1]
    Left = 7
    Top = 112
    Width = 426
    Height = 73
    HelpContext = 645002
  end
  object Bevel1: TBevel [2]
    Left = 7
    Top = 192
    Width = 426
    Height = 109
    HelpContext = 645003
  end
  object Label2: TLabel [4]
    Left = 12
    Top = 76
    Width = 86
    Height = 18
    HelpContext = 645004
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'IP Address'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label1: TLabel [5]
    Left = 16
    Top = 122
    Width = 82
    Height = 15
    HelpContext = 645005
    Caption = 'Email Address'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [6]
    Left = 40
    Top = 156
    Width = 58
    Height = 15
    HelpContext = 645006
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label4: TLabel [7]
    Left = 161
    Top = 210
    Width = 48
    Height = 15
    HelpContext = 645007
    Caption = 'Log Me In'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label5: TLabel [8]
    Left = 308
    Top = 210
    Width = 23
    Height = 15
    HelpContext = 645008
    Caption = 'ERP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label6: TLabel [9]
    Left = 35
    Top = 233
    Width = 63
    Height = 15
    HelpContext = 645009
    Caption = 'User Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label7: TLabel [10]
    Left = 40
    Top = 265
    Width = 58
    Height = 15
    HelpContext = 645010
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label8: TLabel [11]
    Left = 228
    Top = 76
    Width = 72
    Height = 18
    HelpContext = 645011
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object pnlTitle: TDNMPanel [12]
    Left = 8
    Top = 9
    Width = 426
    Height = 45
    HelpContext = 645012
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
      Width = 422
      Height = 41
      HelpContext = 645013
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
        Width = 422
        Height = 41
        HelpContext = 645014
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'LogMeIn Details'
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
  object txtCompany: TDBEdit [13]
    Left = 112
    Top = 73
    Width = 113
    Height = 23
    HelpContext = 645015
    AutoSelect = False
    AutoSize = False
    DataField = 'LogMeInComputerIPAddress'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object DBEdit1: TDBEdit [14]
    Left = 112
    Top = 118
    Width = 295
    Height = 23
    HelpContext = 645016
    AutoSelect = False
    AutoSize = False
    DataField = 'ContactEmail'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object DBEdit2: TDBEdit [15]
    Left = 111
    Top = 153
    Width = 169
    Height = 23
    HelpContext = 645017
    AutoSelect = False
    AutoSize = False
    DataField = 'LogMeInEmailPassword'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object DBEdit3: TDBEdit [16]
    Left = 131
    Top = 229
    Width = 118
    Height = 23
    HelpContext = 645018
    AutoSelect = False
    AutoSize = False
    DataField = 'LogMeInUserName'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object DBEdit4: TDBEdit [17]
    Left = 131
    Top = 261
    Width = 118
    Height = 23
    HelpContext = 645019
    AutoSelect = False
    AutoSize = False
    DataField = 'LogMeInPassword'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object DBEdit5: TDBEdit [18]
    Left = 263
    Top = 229
    Width = 118
    Height = 23
    HelpContext = 645020
    AutoSelect = False
    AutoSize = False
    DataField = 'LogMeInERPUserName'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object DBEdit6: TDBEdit [19]
    Left = 263
    Top = 261
    Width = 118
    Height = 23
    HelpContext = 645021
    AutoSelect = False
    AutoSize = False
    DataField = 'LogMeInERPPassword'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object btnOk: TDNMSpeedButton [20]
    Left = 125
    Top = 309
    Width = 87
    Height = 27
    HelpContext = 645022
    Caption = '&Save'
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
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 8
    OnClick = btnOkClick
  end
  object cmdClose: TDNMSpeedButton [21]
    Left = 227
    Top = 309
    Width = 87
    Height = 27
    HelpContext = 645023
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
    TabOrder = 9
    OnClick = cmdCloseClick
  end
  object DBEdit7: TDBEdit [22]
    Left = 311
    Top = 73
    Width = 113
    Height = 23
    HelpContext = 645024
    AutoSelect = False
    AutoSize = False
    DataField = 'LogMeIncomputerPassword'
    DataSource = frmContactSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 24
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 24
    Top = 56
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ContactID=:KeyID;')
    Left = 277
    Top = 5
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblContacts.GlobalRef'
      Size = 255
    end
    object qryContactsContactID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ContactID'
      Origin = 'tblContacts.ContactID'
      ReadOnly = True
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblContacts.Company'
      Size = 50
    end
    object qryContactsLogMeInComputerIPAddress: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
      Origin = 'tblContacts.LogMeInComputerIPAddress'
    end
    object qryContactsLogMeInContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Origin = 'tblContacts.LogMeInContactEmail'
      Size = 255
    end
    object qryContactsLogMeInEmailPassword: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Origin = 'tblContacts.LogMeInEmailPassword'
      Size = 100
    end
    object qryContactsLogMeInUserName: TWideStringField
      FieldName = 'LogMeInUserName'
      Origin = 'tblContacts.LogMeInUserName'
      Size = 100
    end
    object qryContactsLogMeInPassword: TWideStringField
      FieldName = 'LogMeInPassword'
      Origin = 'tblContacts.LogMeInPassword'
      Size = 100
    end
    object qryContactsLogMeInERPUserName: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Origin = 'tblContacts.LogMeInERPUserName'
      Size = 100
    end
    object qryContactsLogMeInERPPassword: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Origin = 'tblContacts.LogMeInERPPassword'
      Size = 100
    end
    object qryContactsLogMeIncomputerPassword: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
  end
  object frmContactSrc: TDataSource
    DataSet = qryContacts
    Left = 310
    Top = 6
  end
end
