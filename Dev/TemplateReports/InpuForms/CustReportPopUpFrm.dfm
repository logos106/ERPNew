inherited CustReportPopUpGUI: TCustReportPopUpGUI
  Left = 434
  Top = 264
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 337
  ClientWidth = 327
  Color = 14609623
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 601000
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 313
    Height = 265
    Shape = bsFrame
    HelpContext = 601001
  end
  object ReportGUI: TLabel
    Left = 48
    Top = 80
    Width = 74
    Height = 15
    Caption = 'Report Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 601002
  end
  object Label1: TLabel
    Left = 48
    Top = 144
    Width = 171
    Height = 15
    Caption = 'Report Selector Tab (Optional)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 601003
  end
  object Label2: TLabel
    Left = 48
    Top = 200
    Width = 233
    Height = 57
    AutoSize = False
    Caption = 
      'Note that the report will show in the "My Reports" tab of the Re' +
      'port Selector in addition to the Tab chosen from the above Combo' +
      ' Box.'
    Transparent = True
    WordWrap = True
    HelpContext = 601004
  end
  object edtReport: TEdit
    Left = 48
    Top = 96
    Width = 233
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    TabOrder = 2
    Text = 'edtReport'
    HelpContext = 601005
  end
  object OKBtn: TDNMSpeedButton
    Left = 38
    Top = 292
    Width = 87
    Height = 27
    Caption = 'O&K'
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = OKBtnClick
    HelpContext = 601006
  end
  object CancelBtn: TDNMSpeedButton
    Left = 202
    Top = 292
    Width = 87
    Height = 27
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    HelpContext = 601007
  end
  object cboTabs: TwwDBComboBox
    Left = 48
    Top = 161
    Width = 248
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = True
    AutoDropDown = True
    AutoFillDate = False
    AutoSize = False
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Accounts'
      'Appointments'
      'Banking'
      'CRM'
      'Employee'
      'Fixed Assets'
      'Hire/Projects'
      'Hospitality'
      'Inventory'
      'Jobs'
      'Payments'
      'Payroll'
      'Purchases'
      'Sales')
    ParentFont = False
    Sorted = False
    TabOrder = 3
    UnboundDataType = wwDefault
    HelpContext = 601008
  end
  object pnlTitle: TDNMPanel
    Left = 33
    Top = 20
    Width = 263
    Height = 40
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    HelpContext = 601009
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 259
      Height = 36
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
      HelpContext = 601010
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 259
        Height = 36
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customised Reports'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        HelpContext = 601011
      end
    end
  end
end
