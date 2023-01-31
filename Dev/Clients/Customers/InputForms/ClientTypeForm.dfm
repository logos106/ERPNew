inherited ClientTypeGUI: TClientTypeGUI
  Left = 470
  Top = 110
  HelpContext = 68000
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Customer Type'
  ClientHeight = 404
  ClientWidth = 422
  OldCreateOrder = True
  ExplicitLeft = 470
  ExplicitTop = 110
  ExplicitWidth = 438
  ExplicitHeight = 443
  DesignSize = (
    422
    404)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 6
    Top = 183
    Width = 408
    Height = 122
    HelpContext = 68002
    Shape = bsFrame
  end
  object Bevel2: TBevel [1]
    Left = 272
    Top = 198
    Width = 138
    Height = 66
    HelpContext = 68035
    Shape = bsFrame
  end
  object Name_Label: TLabel [2]
    Left = 70
    Top = 80
    Width = 68
    Height = 15
    HelpContext = 68003
    Alignment = taRightJustify
    Caption = 'Type Name :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Description_Label: TLabel [3]
    Left = 73
    Top = 117
    Width = 65
    Height = 15
    HelpContext = 68004
    Alignment = taRightJustify
    Caption = 'Description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label1: TLabel [4]
    Left = 24
    Top = 203
    Width = 36
    Height = 15
    HelpContext = 68005
    Alignment = taRightJustify
    Caption = 'Terms'
    Transparent = True
  end
  object Label2: TLabel [5]
    Left = 23
    Top = 237
    Width = 93
    Height = 15
    HelpContext = 68006
    Alignment = taRightJustify
    Caption = 'Credit Limit ($'#39's)'
    Transparent = True
  end
  object Label3: TLabel [6]
    Left = 27
    Top = 272
    Width = 113
    Height = 15
    HelpContext = 68007
    Alignment = taRightJustify
    Caption = 'Grace Period (Days)'
    Transparent = True
  end
  object Label4: TLabel [7]
    Left = 276
    Top = 201
    Width = 131
    Height = 60
    HelpContext = 68008
    Alignment = taCenter
    Caption = 
      'Select this Check Box to Apply these Credit Terms to all existin' +
      'g Customers of this Type.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label5: TLabel [8]
    Left = 292
    Top = 272
    Width = 78
    Height = 15
    HelpContext = 68009
    Caption = 'Apply Globally'
    Transparent = True
  end
  object Label6: TLabel [9]
    Left = 377
    Top = 321
    Width = 35
    Height = 15
    HelpContext = 68010
    Caption = 'Active'
    Transparent = True
  end
  object Label113: TLabel [10]
    Left = 15
    Top = 147
    Width = 119
    Height = 30
    HelpContext = 68011
    Alignment = taRightJustify
    Caption = 'Default Accounts Receivables Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 404
    Width = 422
    HelpContext = 68027
    ExplicitTop = 387
    ExplicitWidth = 422
  end
  inherited imgGridWatermark: TImage
    HelpContext = 68001
  end
  object Label7: TLabel [14]
    Left = 41
    Top = 320
    Width = 99
    Height = 18
    HelpContext = 68026
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Call Priority'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object cboTerms: TwwDBLookupCombo [17]
    Left = 80
    Top = 200
    Width = 181
    Height = 23
    HelpContext = 68016
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Terms'#9'50'#9'Terms'#9#9)
    DataField = 'TermsId'
    DataSource = dsClientType
    LookupTable = qryTerms
    LookupField = 'TermsID'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object edtCredit: TDBEdit [18]
    Left = 164
    Top = 234
    Width = 95
    Height = 23
    HelpContext = 68017
    DataField = 'CreditLimit'
    DataSource = dsClientType
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtGrace: TDBEdit [19]
    Left = 164
    Top = 268
    Width = 95
    Height = 23
    HelpContext = 68018
    DataField = 'GracePeriod'
    DataSource = dsClientType
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object chkGlobal: TCheckBox [20]
    Left = 273
    Top = 271
    Width = 15
    Height = 17
    HelpContext = 68019
    Caption = 'chkGlobal'
    TabOrder = 6
  end
  object chkActive: TwwCheckBox [21]
    Left = 356
    Top = 321
    Width = 15
    Height = 17
    HelpContext = 68020
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
    Caption = 'chkActive'
    DataField = 'Active'
    DataSource = dsClientType
    TabOrder = 11
  end
  object cboDefaultPostAccount: TwwDBLookupCombo [22]
    Left = 144
    Top = 151
    Width = 182
    Height = 23
    HelpContext = 68021
    DropDownAlignment = taLeftJustify
    DataField = 'DefaultPostAccount'
    DataSource = dsClientType
    LookupTable = cboAccountQry
    LookupField = 'AccountName'
    Options = [loColLines]
    ImeName = 'cboDefaultPostAccount'
    TabOrder = 2
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboDefaultPostAccountCloseUp
  end
  object btnSave: TDNMSpeedButton [23]
    Left = 46
    Top = 372
    Width = 98
    Height = 27
    HelpContext = 68029
    Action = actSave
    Anchors = [akBottom]
    Caption = '&Save'
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
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 8
    TabStop = False
  end
  object pnlTitle: TDNMPanel [24]
    Left = 98
    Top = 6
    Width = 238
    Height = 45
    HelpContext = 68023
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      HelpContext = 68024
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
        Width = 234
        Height = 41
        HelpContext = 68025
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customer Type'
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
  object TypeName: TDBEdit [25]
    Left = 144
    Top = 76
    Width = 181
    Height = 23
    HelpContext = 68013
    DataField = 'TypeName'
    DataSource = dsClientType
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnCancel: TDNMSpeedButton [26]
    Left = 276
    Top = 372
    Width = 98
    Height = 27
    HelpContext = 68030
    Action = actCancel
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
    TabOrder = 10
    TabStop = False
  end
  object wwDBComboBox1: TwwDBComboBox [27]
    Left = 151
    Top = 318
    Width = 135
    Height = 23
    HelpContext = 68031
    ShowButton = True
    Style = csDropDownList
    MapList = True
    AllowClearKey = False
    AutoDropDown = True
    AutoFillDate = False
    DataField = 'CallPriority'
    DataSource = dsClientType
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '10 - High'#9'10'
      '9'#9'9'
      '8'#9'8'
      '7'#9'7'
      '6'#9'6'
      '5  - Standard'#9'5'
      '4'#9'4'
      '3'#9'3'
      '2'#9'2'
      '1'#9'1'
      '0  - Low'#9'0')
    ParentFont = False
    Sorted = False
    TabOrder = 7
    UnboundDataType = wwDefault
    UnboundAlignment = taCenter
  end
  object edtDescription: TDBEdit [28]
    Left = 144
    Top = 113
    Width = 181
    Height = 23
    HelpContext = 68014
    DataField = 'TypeDescription'
    DataSource = dsClientType
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btnNew: TDNMSpeedButton [29]
    Left = 161
    Top = 372
    Width = 98
    Height = 27
    HelpContext = 68028
    Action = actNew
    Anchors = [akBottom]
    Caption = '&New'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
      0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
      00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
      00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
      F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
      F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
      FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
      0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
      00337777FFFF77FF7733EEEE0000000003337777777777777333}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 9
    TabStop = False
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003800400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsClientType: TDataSource
    DataSet = qryClientType
    Left = 344
    Top = 8
  end
  object qryClientType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'ClientTypeID, TypeName, TypeDescription, TermsID, '
      'DefaultPostAccount, DefaultPostAccountID,'
      
        'CreditLimit, GracePeriod, Active, EditedFlag, GlobalRef, callpri' +
        'ority'
      'FROM tblClientType '
      'WHERE ClientTypeID = :xClientTypeID;')
    Left = 344
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientTypeID'
      end>
    object qryClientTypeClientTypeID: TAutoIncField
      FieldName = 'ClientTypeID'
      ReadOnly = True
    end
    object qryClientTypeTypeName: TWideStringField
      FieldName = 'TypeName'
      OnChange = qryClientTypeTypeNameChange
      Size = 50
    end
    object qryClientTypeTypeDescription: TWideStringField
      FieldName = 'TypeDescription'
      Size = 255
    end
    object qryClientTypeTermsID: TIntegerField
      FieldName = 'TermsID'
    end
    object qryClientTypeDefaultPostAccount: TWideStringField
      FieldName = 'DefaultPostAccount'
      Size = 255
    end
    object qryClientTypeDefaultPostAccountID: TIntegerField
      FieldName = 'DefaultPostAccountID'
    end
    object qryClientTypeCreditLimit: TFloatField
      FieldName = 'CreditLimit'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryClientTypeGracePeriod: TWordField
      FieldName = 'GracePeriod'
    end
    object qryClientTypeActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryClientTypeEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryClientTypeGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryClientTypecallpriority: TIntegerField
      FieldName = 'callpriority'
    end
  end
  object qryTerms: TERPQuery
    SQL.Strings = (
      'SELECT TermsID, Terms FROM tblTerms WHERE Active = '#39'T'#39)
    Left = 376
    Top = 8
  end
  object memQryClientType: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ClientTypeID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'TypeName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TypeDescription'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'TermsID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'CreditLimit'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'GracePeriod'
        Attributes = [faFixed]
        DataType = ftWord
      end
      item
        Name = 'Active'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 200
    Top = 8
  end
  object cboAccountQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'AccountID, AccountName, AccountType, Description, '
      'AccountNumber, Taxcode, BankNumber, Extra, Active, '
      'EditedFlag, Class, AllClasses, OpeningBalance, Debits, '
      'Credits, ClosingBalance, AccountGroup  '
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'AR'#39' and Active='#39'T'#39' and IsHeader = '#39'F'#39';')
    Options.LongStrings = False
    Left = 231
    Top = 11
  end
  object ActionList: TActionList
    Left = 40
    Top = 40
    object actSave: TAction
      Caption = '&Save'
      HelpContext = 68032
      OnExecute = actSaveExecute
    end
    object actNew: TAction
      Caption = '&New'
      HelpContext = 68033
      OnExecute = actNewExecute
    end
    object actCancel: TAction
      Caption = '&Cancel'
      HelpContext = 68034
      OnExecute = actCancelExecute
    end
  end
end
