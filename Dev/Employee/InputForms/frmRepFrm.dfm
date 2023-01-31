inherited frmRep: TfrmRep
  Left = 708
  Top = 173
  HelpContext = 343000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Rep'
  ClientHeight = 402
  ClientWidth = 747
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 753
  ExplicitHeight = 431
  PixelsPerInch = 96
  TextHeight = 15
  object Label36: TLabel [0]
    Left = 646
    Top = 265
    Width = 59
    Height = 31
    HelpContext = 343002
    Alignment = taCenter
    AutoSize = False
    Caption = 'Rep is Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label133: TLabel [1]
    Left = 457
    Top = 59
    Width = 182
    Height = 16
    HelpContext = 343003
    AutoSize = False
    Caption = '"Edit Rep from the Employee Screen"'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 402
    Width = 747
    ExplicitTop = 402
    ExplicitWidth = 747
    HelpContext = 343076
  end
  inherited imgGridWatermark: TImage
    HelpContext = 343001
  end
  object cmdNotes: TDNMSpeedButton [7]
    Left = 650
    Top = 229
    Width = 87
    Height = 27
    Hint = '"Go To The Notes Field"'
    HelpContext = 343067
    Caption = 'N&otes'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = cmdNotesClick
  end
  object txtTrainerID: TDBEdit [8]
    Left = 583
    Top = 7
    Width = 25
    Height = 22
    HelpContext = 343068
    TabStop = False
    DataField = 'EmployeeID'
    DataSource = cboRepNameSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object txtTrainercode: TDBEdit [9]
    Left = 618
    Top = 7
    Width = 25
    Height = 22
    HelpContext = 343069
    TabStop = False
    DataField = 'RepCode'
    DataSource = cboRepNameSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Visible = False
  end
  object EmpID: TDBEdit [10]
    Left = 650
    Top = 7
    Width = 25
    Height = 22
    HelpContext = 343070
    TabStop = False
    DataField = 'EmployeeID'
    DataSource = cboRepNameSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Visible = False
  end
  object cboRepName: TwwDBLookupCombo [11]
    Left = 194
    Top = 48
    Width = 261
    Height = 27
    HelpContext = 343071
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    DropDownAlignment = taLeftJustify
    LookupTable = qryRep
    LookupField = 'EmployeeName'
    ParentFont = False
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboRepNameCloseUp
    OnNotInList = cboRepNameNotInList
  end
  object cmdCancel: TDNMSpeedButton [12]
    Left = 650
    Top = 147
    Width = 87
    Height = 27
    HelpContext = 343072
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
    OnClick = cmdCancelClick
  end
  object pnlTitle: TDNMPanel [13]
    Left = 205
    Top = 3
    Width = 238
    Height = 42
    HelpContext = 343073
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
      Width = 234
      Height = 38
      HelpContext = 343074
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
        Height = 38
        HelpContext = 343075
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Representative'
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
  object TabCtl20: TPageControl [14]
    Left = 7
    Top = 78
    Width = 633
    Height = 317
    HelpContext = 343005
    ActivePage = Rate_Info
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    RaggedRight = True
    TabHeight = 25
    TabOrder = 1
    TabWidth = 157
    OnChange = TabCtl20Change
    object Rep_Info: TTabSheet
      HelpContext = 343006
      Caption = '&Rep Info'
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 625
        Height = 282
        HelpContext = 343007
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Box72: TBevel
          Left = 63
          Top = 137
          Width = 518
          Height = 140
          HelpContext = 343008
        end
        object Box70: TBevel
          Left = 332
          Top = 12
          Width = 247
          Height = 109
          HelpContext = 343009
        end
        object Box69: TBevel
          Left = 63
          Top = 12
          Width = 251
          Height = 109
          HelpContext = 343010
        end
        object Label25: TLabel
          Left = 73
          Top = 22
          Width = 83
          Height = 16
          HelpContext = 343011
          AutoSize = False
          Caption = 'Company:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
          WordWrap = True
        end
        object Label27: TLabel
          Left = 73
          Top = 24
          Width = 83
          Height = 16
          HelpContext = 343012
          AutoSize = False
          Caption = 'Mr./Mrs/...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label28: TLabel
          Left = 73
          Top = 57
          Width = 83
          Height = 16
          HelpContext = 343013
          AutoSize = False
          Caption = 'First Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label29: TLabel
          Left = 73
          Top = 93
          Width = 83
          Height = 16
          HelpContext = 343014
          AutoSize = False
          Caption = 'Last Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label31: TLabel
          Left = 343
          Top = 23
          Width = 94
          Height = 16
          HelpContext = 343015
          AutoSize = False
          Caption = 'Phone Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label33: TLabel
          Left = 344
          Top = 48
          Width = 94
          Height = 16
          HelpContext = 343016
          AutoSize = False
          Caption = 'Fax Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label34: TLabel
          Left = 343
          Top = 73
          Width = 94
          Height = 16
          HelpContext = 343017
          AutoSize = False
          Caption = 'Mobile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label35: TLabel
          Left = 343
          Top = 98
          Width = 94
          Height = 16
          HelpContext = 343018
          AutoSize = False
          Caption = 'Alt Contact:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label59: TLabel
          Left = 89
          Top = 149
          Width = 36
          Height = 16
          HelpContext = 343019
          AutoSize = False
          Caption = 'Notes:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object edtNotes: TDBMemo
          Left = 137
          Top = 149
          Width = 431
          Height = 92
          HelpContext = 343020
          DataField = 'Notes'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object DBEdit1: TDBEdit
          Left = 160
          Top = 19
          Width = 145
          Height = 23
          HelpContext = 343021
          TabStop = False
          DataField = 'Company'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Visible = False
        end
        object DBEdit2: TDBEdit
          Left = 160
          Top = 19
          Width = 49
          Height = 23
          HelpContext = 343022
          TabStop = False
          DataField = 'Title'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit3: TDBEdit
          Left = 160
          Top = 54
          Width = 145
          Height = 23
          HelpContext = 343023
          TabStop = False
          DataField = 'FirstName'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object DBEdit4: TDBEdit
          Left = 160
          Top = 89
          Width = 145
          Height = 23
          HelpContext = 343024
          TabStop = False
          DataField = 'LastName'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object DBEdit5: TDBEdit
          Left = 432
          Top = 19
          Width = 137
          Height = 23
          HelpContext = 343025
          TabStop = False
          DataField = 'Phone'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit6: TDBEdit
          Left = 432
          Top = 45
          Width = 137
          Height = 23
          HelpContext = 343026
          TabStop = False
          DataField = 'FaxNumber'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit7: TDBEdit
          Left = 432
          Top = 70
          Width = 137
          Height = 23
          HelpContext = 343027
          TabStop = False
          DataField = 'Mobile'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit8: TDBEdit
          Left = 432
          Top = 95
          Width = 137
          Height = 23
          HelpContext = 343028
          TabStop = False
          DataField = 'AltContact'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object btnAddDateTime: TDNMSpeedButton
          Left = 301
          Top = 245
          Width = 105
          Height = 27
          HelpContext = 343029
          Caption = 'Add Date && Time'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = btnAddDateTimeClick
        end
      end
    end
    object Address_Info: TTabSheet
      HelpContext = 343030
      Caption = '&Address Info'
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 625
        Height = 282
        HelpContext = 343031
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel1: TBevel
          Left = 351
          Top = 120
          Width = 250
          Height = 67
          HelpContext = 343032
        end
        object Box76: TBevel
          Left = 351
          Top = 12
          Width = 250
          Height = 85
          HelpContext = 343033
        end
        object Box71: TBevel
          Left = 32
          Top = 12
          Width = 293
          Height = 227
          HelpContext = 343034
        end
        object Label65: TLabel
          Left = 357
          Top = 33
          Width = 32
          Height = 18
          HelpContext = 343035
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ABN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label77: TLabel
          Left = 356
          Top = 64
          Width = 44
          Height = 18
          HelpContext = 343036
          AutoSize = False
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label78: TLabel
          Left = 56
          Top = 24
          Width = 56
          Height = 18
          HelpContext = 343037
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label79: TLabel
          Left = 83
          Top = 102
          Width = 29
          Height = 18
          HelpContext = 343038
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'City:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label80: TLabel
          Left = 50
          Top = 128
          Width = 62
          Height = 18
          HelpContext = 343039
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Postcode'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label81: TLabel
          Left = 74
          Top = 154
          Width = 38
          Height = 18
          HelpContext = 343040
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'State:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label135: TLabel
          Left = 46
          Top = 50
          Width = 66
          Height = 18
          HelpContext = 343041
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label1: TLabel
          Left = 356
          Top = 130
          Width = 155
          Height = 15
          HelpContext = 343042
          Caption = 'Area Range: (eg 1, 10-15, 7)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblAddress3: TLabel
          Left = 46
          Top = 76
          Width = 66
          Height = 18
          HelpContext = 343044
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Address 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblCountry: TLabel
          Left = 46
          Top = 180
          Width = 66
          Height = 18
          HelpContext = 343045
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object DBEdit9: TDBEdit
          Left = 120
          Top = 22
          Width = 193
          Height = 23
          HelpContext = 343046
          DataField = 'Street'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object DBEdit10: TDBEdit
          Left = 120
          Top = 48
          Width = 193
          Height = 23
          HelpContext = 343047
          DataField = 'Street2'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit11: TDBEdit
          Left = 120
          Top = 126
          Width = 89
          Height = 23
          HelpContext = 343048
          DataField = 'Postcode'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit12: TDBEdit
          Left = 120
          Top = 152
          Width = 89
          Height = 23
          HelpContext = 343049
          DataField = 'State'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit13: TDBEdit
          Left = 400
          Top = 30
          Width = 193
          Height = 23
          HelpContext = 343050
          DataField = 'ABN'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit14: TDBEdit
          Left = 400
          Top = 60
          Width = 193
          Height = 23
          HelpContext = 343051
          DataField = 'Email'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object DBEdit17: TDBEdit
          Left = 120
          Top = 100
          Width = 193
          Height = 23
          HelpContext = 343052
          DataField = 'Suburb'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object edtAreas: TwwDBEdit
          Left = 400
          Top = 150
          Width = 189
          Height = 23
          HelpContext = 343053
          DataField = 'AreaRange'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtAddress3: TDBEdit
          Left = 120
          Top = 74
          Width = 193
          Height = 23
          HelpContext = 343055
          DataField = 'Street3'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object txtCountry: TDBEdit
          Left = 120
          Top = 178
          Width = 193
          Height = 23
          HelpContext = 343056
          DataField = 'Country'
          DataSource = EmployeeSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
      end
    end
    object Rate_Info: TTabSheet
      HelpContext = 343057
      Caption = 'Ra&te Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 625
        Height = 282
        HelpContext = 343058
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Trainerratessubform_Label: TLabel
          Left = 10
          Top = 20
          Width = 98
          Height = 16
          HelpContext = 343059
          AutoSize = False
          Caption = 'Rep Rates:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object DNMPanel5: TDNMPanel
          Left = 7
          Top = 39
          Width = 607
          Height = 194
          HelpContext = 343060
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object grdRateInfo: TwwDBGrid
            Left = 2
            Top = 2
            Width = 603
            Height = 190
            HelpContext = 343061
            ControlType.Strings = (
              'ServiceID;CustomEdit;dboService;F'
              'AbilityID;CustomEdit;cboAbility;F'
              'ServiceName;CustomEdit;cboService;F'
              'AbilityDesc;CustomEdit;cboAbility;F'
              'ChargeToLookup;CustomEdit;cboCompany;F')
            Selected.Strings = (
              'ServiceName'#9'20'#9'Service Type'#9'F'
              'AbilityDesc'#9'10'#9'Ability'#9'F'
              'Rate'#9'10'#9'Charge Rate (Inc)'#9'F'
              'PayRate'#9'10'#9'Pay Rate'#9'F'
              'ChargeToLookup'#9'22'#9'Charge To'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = srcTrainerRates
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            UseTFields = False
            OnExit = grdRateInfoExit
            PaintOptions.BackgroundOptions = [coBlendFixedRow]
            object btnDetailDelete: TwwIButton
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
              OnClick = btnDetailDeleteClick
              HelpContext = 343077
            end
          end
          object cboService: TwwDBLookupCombo
            Left = 24
            Top = 32
            Width = 97
            Height = 23
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'ServiceDesc'#9'50'#9'ServiceDesc'#9#9)
            DataField = 'ServiceID'
            DataSource = srcTrainerRates
            LookupTable = qrycboServices
            LookupField = 'ServiceID'
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnNotInList = cboServiceNotInList
            HelpContext = 343078
          end
          object cboCompany: TwwDBLookupCombo
            Left = 336
            Top = 40
            Width = 121
            Height = 23
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Company'#9'80'#9'Company'#9#9)
            DataField = 'ClientID'
            DataSource = srcTrainerRates
            LookupTable = qryClients
            LookupField = 'Company'
            TabOrder = 2
            AutoDropDown = False
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            HelpContext = 343079
          end
          object cboAbility: TwwDBLookupCombo
            Left = 136
            Top = 48
            Width = 121
            Height = 23
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AbilityDesc'#9'20'#9'AbilityDesc'#9'F')
            DataField = 'AbilityID'
            DataSource = srcTrainerRates
            LookupTable = qrycboAbility
            LookupField = 'AbilityID'
            TabOrder = 3
            AutoDropDown = False
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            HelpContext = 343080
          end
        end
      end
    end
    object History: TTabSheet
      HelpContext = 343062
      Caption = '&History'
      object pnlHistory: TDNMPanel
        Left = 0
        Top = 0
        Width = 625
        Height = 282
        HelpContext = 343063
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grpHistory: TRadioGroup
          Left = 0
          Top = 0
          Width = 625
          Height = 33
          HelpContext = 343064
          Align = alTop
          ItemIndex = 0
          Items.Strings = (
            'Appointments')
          TabOrder = 0
        end
      end
    end
  end
  object cmdOk: TDNMSpeedButton [15]
    Left = 650
    Top = 107
    Width = 87
    Height = 27
    HelpContext = 343004
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = cmdOkClick
  end
  object chkActive: TDBCheckBox [16]
    Left = 726
    Top = 273
    Width = 13
    Height = 15
    HelpContext = 343065
    Color = 13168109
    DataField = 'Rep'
    DataSource = EmployeeSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 6
    ValueChecked = 'True;T'
    ValueUnchecked = 'False;F'
  end
  object cmdNew: TDNMSpeedButton [17]
    Left = 650
    Top = 188
    Width = 87
    Height = 27
    Hint = '"Save This Rep And Open A New Rep"'
    HelpContext = 343066
    Caption = '&New'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = cmdNewClick
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020058005C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object cboRepNameSrc: TDataSource
    AutoEdit = False
    DataSet = qryRep
    Left = 8
    Top = 96
  end
  object srcTrainerRates: TDataSource
    DataSet = qryTrainerRates
    Left = 8
    Top = 128
  end
  object subfrmTrainerHistorySrc: TDataSource
    DataSet = qryTrainerHistory
    Left = 8
    Top = 160
  end
  object EmployeeSrc: TDataSource
    DataSet = qryEmployee
    Left = 8
    Top = 192
  end
  object qryTrainerRates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblTrainerRates.TrainRateID, tblTrainerRates.Rate, '
      'tblTrainerRates.PayRate, tblTrainerRates.EmployeeID, '
      
        'tblTrainerRates.ServiceID, tblTrainerRates.AbilityID, tblTrainer' +
        'Rates.ClientID,'
      'tblTrainerRates.EditedFlag'
      'FROM tblTrainerRates AS tblTrainerRates'
      
        'Left join tblServices on (tblTrainerRates.ServiceID = tblService' +
        's.ServiceID)'
      
        'left join tblAbility on (tblTrainerRates.AbilityID = tblAbility.' +
        'AbilityID)'
      'WHERE   tblTrainerRates.EmployeeID = :RepID ;')
    AfterOpen = qryTrainerRatesAfterOpen
    Left = 208
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepID'
      end>
    object qryTrainerRatesTrainRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'TrainRateID'
      ReadOnly = True
    end
    object qryTrainerRatesRate: TFloatField
      DisplayWidth = 16
      FieldName = 'Rate'
      currency = True
    end
    object qryTrainerRatesPayRate: TFloatField
      DisplayWidth = 16
      FieldName = 'PayRate'
      currency = True
    end
    object qryTrainerRatesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
    end
    object qryTrainerRatesServiceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ServiceID'
      OnChange = qryTrainerRatesServiceIDChange
    end
    object qryTrainerRatesAbilityID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AbilityID'
    end
    object qryTrainerRatesServiceName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ServiceName'
      LookupDataSet = qrycboServices
      LookupKeyFields = 'ServiceID'
      LookupResultField = 'ServiceDesc'
      KeyFields = 'ServiceID'
      Lookup = True
    end
    object qryTrainerRatesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryTrainerRatesClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryTrainerRatesChargeToLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ChargeToLookup'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Size = 80
      Lookup = True
    end
    object qryTrainerRatesAbilityDesc: TWideStringField
      FieldKind = fkLookup
      FieldName = 'AbilityDesc'
      LookupDataSet = qrycboAbility
      LookupKeyFields = 'AbilityID'
      LookupResultField = 'AbilityDesc'
      KeyFields = 'AbilityID'
      Size = 255
      Lookup = True
    end
  end
  object qryTrainerHistory: TERPQuery
    SQL.Strings = (
      
        'SELECT tblAppointments.CusID, tblAppointments.AppDate, tblClient' +
        's.Company, tblAppointments.FeedbackNotes, tblAppointments.Traine' +
        'rID, tblAppointments.Cancellation, tblAppointments.AppointID'
      
        'FROM tblAppointments INNER JOIN tblClients ON tblAppointments.Cu' +
        'sID=tblClients.ClientID'
      'WHERE (((tblAppointments.TrainerID)=:RepID));')
    Left = 176
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepID'
      end>
  end
  object qryEmployee: TERPQuery
    SQL.Strings = (
      'SELECT Company, EmployeeID, Title, FirstName, LastName, Phone, '
      'FaxNumber, Mobile, AltContact, Notes, Street, Street2, Street3,'
      'Suburb, Postcode, State, Country, ABN, Email,'
      'Concat_WS(" ", FirstName, LastName) as EmployeeName, Rep,'
      'EditedFlag,  AreaRange, EmployeeTypeID'
      'FROM tblEmployees'
      'WHERE EmployeeID = :EmpID;')
    AfterOpen = qryEmployeeAfterOpen
    Left = 144
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmpID'
      end>
    object qryEmployeeCompany: TWideStringField
      FieldName = 'Company'
      Size = 35
    end
    object qryEmployeeEmployeeID: TAutoIncField
      FieldName = 'EmployeeID'
      ReadOnly = True
    end
    object qryEmployeeTitle: TWideStringField
      FieldName = 'Title'
      Size = 5
    end
    object qryEmployeeFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 15
    end
    object qryEmployeeLastName: TWideStringField
      FieldName = 'LastName'
      Size = 30
    end
    object qryEmployeePhone: TWideStringField
      FieldName = 'Phone'
    end
    object qryEmployeeFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
    end
    object qryEmployeeMobile: TWideStringField
      FieldName = 'Mobile'
    end
    object qryEmployeeAltContact: TWideStringField
      FieldName = 'AltContact'
      Size = 50
    end
    object qryEmployeeNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryEmployeeStreet: TWideStringField
      FieldName = 'Street'
      Size = 38
    end
    object qryEmployeeStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 38
    end
    object qryEmployeeStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryEmployeeSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 27
    end
    object qryEmployeePostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object qryEmployeeState: TWideStringField
      DisplayWidth = 40
      FieldName = 'State'
      FixedChar = True
      Size = 255
    end
    object qryEmployeeCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryEmployeeABN: TWideStringField
      FieldName = 'ABN'
      Size = 15
    end
    object qryEmployeeEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
    object qryEmployeeEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      ReadOnly = True
      Size = 46
    end
    object qryEmployeeRep: TWideStringField
      FieldName = 'Rep'
      FixedChar = True
      Size = 1
    end
    object qryEmployeeEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryEmployeeAreaRange: TWideStringField
      FieldName = 'AreaRange'
      Size = 255
    end
    object qryEmployeeEmployeeTypeID: TIntegerField
      FieldName = 'EmployeeTypeID'
      Visible = False
    end
  end
  object qryRep: TERPQuery
    SQL.Strings = (
      
        'SELECT EmployeeID, Rep, RepCode, Concat(FirstName, " ", LastName' +
        ') as EmployeeName  FROM tblEmployees'
      'WHERE Active = '#39'T'#39
      'ORDER BY EmployeeName'
      '')
    Left = 272
    Top = 336
  end
  object dsqrycboServices: TDataSource
    AutoEdit = False
    Left = 8
    Top = 224
  end
  object qrycboServices: TERPQuery
    SQL.Strings = (
      
        'Select ServiceID, ServiceDesc, StandardRate from tblServices ORD' +
        'ER BY ServiceDesc')
    Left = 80
    Top = 336
  end
  object dsqrycboAbility: TDataSource
    AutoEdit = False
    DataSet = qrycboAbility
    Left = 8
    Top = 256
  end
  object qrycboAbility: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AbilityID, AbilityDesc FROM tblAbility')
    Left = 48
    Top = 336
  end
  object memqryTrainerRates: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'TrainRateID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'Rate'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'PayRate'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'EmployeeID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'ServiceID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'AbilityID'
        Attributes = [faFixed]
        DataType = ftInteger
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
    Left = 240
    Top = 336
  end
  object memqryEmployee: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 112
    Top = 336
  end
  object qryClients: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company FROM tblClients'
      'WHERE Customer = '#39'T'#39' AND Active = '#39'T'#39
      'ORDER BY Company ')
    Left = 304
    Top = 336
  end
end
