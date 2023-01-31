inherited MultisiteWizardGUI: TMultisiteWizardGUI
  Left = 290
  Top = 193
  ActiveControl = btnDoIt
  Caption = 'Multisite Wizard'
  ClientHeight = 545
  ClientWidth = 706
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Label5: TLabel [0]
    Left = 234
    Top = 24
    Width = 90
    Height = 15
    Caption = 'Site Description'
  end
  object DNMPanel1: TDNMPanel [2]
    Left = 0
    Top = 504
    Width = 706
    Height = 41
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      706
      41)
    object cmdOK: TDNMSpeedButton
      Left = 216
      Top = 7
      Width = 87
      Height = 27
      Anchors = [akTop, akRight]
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
      TabOrder = 0
      OnClick = cmdOKClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 403
      Top = 7
      Width = 87
      Height = 27
      Anchors = [akTop, akRight]
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cmdCancelClick
    end
  end
  object DNMPanel2: TDNMPanel [3]
    Left = 0
    Top = 50
    Width = 706
    Height = 454
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      706
      454)
    object PageControl1: TPageControl
      Left = 8
      Top = 7
      Width = 690
      Height = 438
      ActivePage = TabSheet2
      Anchors = [akLeft, akTop, akRight, akBottom]
      Images = ImageList1
      TabHeight = 25
      TabIndex = 2
      TabOrder = 0
      TabWidth = 229
      OnChanging = PageControl1Changing
      object TabSheet1: TTabSheet
        Caption = '1. Site Details'
        object DNMPanel3: TDNMPanel
          Left = 0
          Top = 0
          Width = 682
          Height = 403
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
            Left = 94
            Top = 82
            Width = 496
            Height = 148
            Shape = bsFrame
            Style = bsRaised
          end
          object Bevel3: TBevel
            Left = 224
            Top = 274
            Width = 234
            Height = 66
            Shape = bsFrame
            Style = bsRaised
          end
          object Label1: TLabel
            Left = 8
            Top = 8
            Width = 142
            Height = 33
            Caption = 'STEP ONE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -28
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label4: TLabel
            Left = 127
            Top = 101
            Width = 139
            Height = 15
            Caption = 'Site Code (3 Characters)'
            FocusControl = edSiteCode
            Transparent = True
          end
          object Label8: TLabel
            Left = 271
            Top = 286
            Width = 96
            Height = 15
            Caption = 'Conflict Resolver'
            Transparent = True
          end
          object Label2: TLabel
            Left = 384
            Top = 97
            Width = 90
            Height = 15
            Caption = 'Site Description'
            FocusControl = edSiteDesc
            Transparent = True
          end
          object Label10: TLabel
            Left = 127
            Top = 164
            Width = 89
            Height = 15
            Caption = 'Company Name'
            FocusControl = edSiteDesc
            Transparent = True
          end
          object lbClass: TLabel
            Left = 384
            Top = 164
            Width = 32
            Height = 15
            Caption = 'Class'
            FocusControl = edSiteDesc
            Transparent = True
          end
          object btnNext: TDNMSpeedButton
            Left = 576
            Top = 373
            Width = 87
            Height = 27
            Caption = '&Next'
            DisableTransparent = False
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333333333333333333333333333333FFF333333333333000333333333
              3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
              3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
              0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
              BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
              33337777773FF733333333333300033333333333337773333333333333333333
              3333333333333333333333333333333333333333333333333333333333333333
              3333333333333333333333333333333333333333333333333333}
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            TabOrder = 5
            OnClick = btnNextClick
          end
          object edSiteCode: TDBEdit
            Left = 127
            Top = 117
            Width = 57
            Height = 23
            CharCase = ecUpperCase
            DataField = 'SiteCode'
            DataSource = dstblmsbackendid
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnExit = edSiteCodeExit
          end
          object edSiteDesc: TDBEdit
            Left = 384
            Top = 113
            Width = 175
            Height = 23
            DataField = 'SiteDesc'
            DataSource = dstblmsbackendid
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnExit = RefreshStatus
          end
          object edCompanyName: TEdit
            Left = 126
            Top = 181
            Width = 175
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = RefreshStatus
            OnExit = RefreshStatus
          end
          object cbConflictTodoUserID: TwwDBLookupCombo
            Left = 271
            Top = 302
            Width = 145
            Height = 23
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'35'#9'EmployeeName'#9'F')
            DataField = 'ConflictTodoUserId'
            DataSource = dstblmsbackendid
            LookupTable = qrytblEmployees
            LookupField = 'EmployeeID'
            Style = csDropDownList
            DropDownWidth = 160
            ParentFont = False
            TabOrder = 4
            AutoDropDown = True
            ShowButton = True
            AllowClearKey = False
            OnCloseUp = cbConflictTodoUserIDCloseUp
            OnExit = RefreshStatus
          end
          object cboClass: TwwDBLookupCombo
            Left = 384
            Top = 181
            Width = 175
            Height = 23
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'ClassName'#9'30'#9'Class'#9'F')
            LookupTable = cboClassQry
            LookupField = 'ClassName'
            ParentFont = False
            TabOrder = 3
            AutoDropDown = True
            ShowButton = True
            UseTFields = False
            AllowClearKey = False
            OnChange = RefreshStatus
            OnExit = RefreshStatus
            OnNotInList = cboClassNotInList
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = '2. Site Email'
        object DNMPanel5: TDNMPanel
          Left = 0
          Top = 0
          Width = 682
          Height = 403
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Bevel2: TBevel
            Left = 226
            Top = 83
            Width = 234
            Height = 223
            Shape = bsFrame
            Style = bsRaised
          end
          object Label11: TLabel
            Left = 8
            Top = 8
            Width = 148
            Height = 33
            Caption = 'STEP TWO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -28
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label6: TLabel
            Left = 260
            Top = 101
            Width = 82
            Height = 15
            Caption = 'Email Address'
            FocusControl = edEmailAddressData
            Transparent = True
          end
          object Label9: TLabel
            Left = 260
            Top = 171
            Width = 93
            Height = 15
            Caption = 'Email Username'
            FocusControl = edSiteDesc
            Transparent = True
          end
          object Label7: TLabel
            Left = 260
            Top = 244
            Width = 92
            Height = 15
            Caption = 'Email Password'
            FocusControl = edEmailPassword
            Transparent = True
          end
          object btnNext2: TDNMSpeedButton
            Left = 576
            Top = 373
            Width = 87
            Height = 27
            Caption = '&Next'
            DisableTransparent = False
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333333333333333333333333333333FFF333333333333000333333333
              3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
              3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
              0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
              BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
              33337777773FF733333333333300033333333333337773333333333333333333
              3333333333333333333333333333333333333333333333333333333333333333
              3333333333333333333333333333333333333333333333333333}
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            TabOrder = 0
            OnClick = btnNextClick
          end
          object edEmailAddressData: TDBEdit
            Left = 260
            Top = 114
            Width = 175
            Height = 23
            DataField = 'EmailAddressData'
            DataSource = dstblmsbackendid
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnExit = edEmailAddressDataExit
          end
          object edEmailUsername: TDBEdit
            Left = 260
            Top = 186
            Width = 175
            Height = 23
            DataField = 'EmailUsername'
            DataSource = dstblmsbackendid
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnExit = RefreshStatus
          end
          object edEmailPassword: TDBEdit
            Left = 260
            Top = 259
            Width = 175
            Height = 23
            DataField = 'EmailPassword'
            DataSource = dstblmsbackendid
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 3
            OnChange = edEmailPasswordChange
            OnExit = RefreshStatus
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = '3. Execute'
        object DNMPanel4: TDNMPanel
          Left = 0
          Top = 0
          Width = 682
          Height = 403
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label3: TLabel
            Left = 8
            Top = 8
            Width = 178
            Height = 33
            Caption = 'STEP THREE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -28
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lbC: TLabel
            Left = 208
            Top = 137
            Width = 146
            Height = 19
            Caption = 'C)  Clone Database'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lbB: TLabel
            Left = 208
            Top = 105
            Width = 178
            Height = 19
            Caption = 'B)  Validate Global Refs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lbD: TLabel
            Left = 208
            Top = 169
            Width = 210
            Height = 19
            Caption = 'D)  Apply Changes to Clone'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lbF: TLabel
            Left = 208
            Top = 233
            Width = 330
            Height = 19
            Caption = 'F)  Inform All Alternate Sites About New Site'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lbE: TLabel
            Left = 208
            Top = 201
            Width = 197
            Height = 19
            Caption = 'E)  Pack Clone to Backup '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lbG: TLabel
            Left = 208
            Top = 265
            Width = 239
            Height = 19
            Caption = 'G)  Remove Clone From Server '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lbA: TLabel
            Left = 208
            Top = 73
            Width = 287
            Height = 19
            Caption = 'A)  Apply Changes to Active Database'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object ProgressTime1: TProgressTime
            Left = 104
            Top = 354
            Width = 481
            Height = 33
            Caption = '0:00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Active = False
            BarWidth = 4
            BarColor = clBtnShadow
            MilliSec = False
          end
          object btnDoIt: TDNMSpeedButton
            Left = 296
            Top = 310
            Width = 87
            Height = 27
            Caption = 'Create'
            DisableTransparent = False
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
              7700333333337777777733333333008088003333333377F73377333333330088
              88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
              000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
              FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
              99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
              99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
              99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
              93337FFFF7737777733300000033333333337777773333333333}
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnDoItclick
          end
        end
      end
    end
  end
  object pnlTitle: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 706
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object DNMPanel6: TDNMPanel
      Left = 173
      Top = 5
      Width = 357
      Height = 42
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 353
        Height = 38
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
          Width = 353
          Height = 38
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'New Multisite Wizard'
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
  end
  object ImageList1: TImageList
    Left = 512
    Top = 8
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F0000000000000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF00000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF00000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007F7F7F000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF007F7F7F00FFFF
      FF0000000000000000000000FF0000008000000080000000000000000000FFFF
      FF007F7F7F007F7F7F00000000000000000000000000BFBFBF007F7F7F00FFFF
      FF00000000000000000000FF000000800000008000000000000000000000FFFF
      FF007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF00000000000000
      FF00000000000000FF00000080000000FF000000800000008000000000000000
      FF00000000007F7F7F00000000000000000000000000BFBFBF000000000000FF
      00000000000000FF00000080000000FF000000800000008000000000000000FF
      0000000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000FF000000FF000000FF000000FF000000800000000000FFFF
      FF00000000007F7F7F00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FF000000FF000000FF000000FF00000080000000000000FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      FF0000000000FFFFFF000000FF000000FF00000080000000FF00000000000000
      FF0000000000BFBFBF00000000000000000000000000FFFFFF000000000000FF
      000000000000FFFFFF0000FF000000FF00000080000000FF00000000000000FF
      000000000000BFBFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF007F7F7F00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000FF000000000000000000FFFF
      FF007F7F7F00BFBFBF00000000000000000000000000FFFFFF007F7F7F00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FF00000000000000000000FFFF
      FF007F7F7F00BFBFBF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BFBFBF000000000000000000000000000000000000000000BFBFBF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BFBFBF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00BFBF
      BF0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF0000000000BFBF
      BF00BFBFBF000000000000000000000000000000000000000000FFFFFF00BFBF
      BF0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF0000000000BFBF
      BF00BFBFBF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F83FF83F00000000
      E00FE00F00000000C007C0070000000080038003000000008003800300000000
      0001000100000000000100010000000000010001000000000001000100000000
      000100010000000080038003000000008003800300000000C007C00700000000
      E00FE00F00000000F83FF83F0000000000000000000000000000000000000000
      000000000000}
  end
  object MTClient: TMTClient
    DBPort = 0
    Host = '127.0.0.1'
    Port = 3307
    Left = 568
    Top = 8
  end
  object dstblmsbackendid: TDataSource
    DataSet = tblmsbackendid
    Left = 21
    Top = 492
  end
  object tblcolumnheadings: TMyTable
    TableName = 'tblcolumnheadings'
    Options.LongStrings = False
    FetchAll = True
    Left = 21
    Top = 459
    object tblcolumnheadingsClassHeading: TStringField
      FieldName = 'ClassHeading'
      Size = 50
    end
  end
  object qrytblEmployees: TMyQuery
    SQL.Strings = (
      'SELECT'
      'tblemployees.EmployeeID,'
      'tblemployees.EmployeeName'
      'FROM tblemployees'
      'WHERE tblemployees.Active = '#39'T'#39
      'ORDER BY tblemployees.EmployeeName'
      '')
    FetchRows = 1
    Options.LongStrings = False
    Left = 195
    Top = 9
    object qrytblEmployeesEmployeeName: TStringField
      DisplayWidth = 35
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qrytblEmployeesEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
      Visible = False
    end
  end
  object dstblEmployees: TDataSource
    AutoEdit = False
    DataSet = qrytblEmployees
    Left = 54
    Top = 489
  end
  object tblmsbackendid: TMyTable
    TableName = 'tblmsbackendid'
    Options.LongStrings = False
    FetchAll = True
    Left = 57
    Top = 457
    object tblmsbackendidSiteCode: TStringField
      FieldName = 'SiteCode'
      Origin = 'tblmsbackendid.SiteCode'
      FixedChar = True
      Size = 3
    end
    object tblmsbackendidSiteDesc: TStringField
      FieldName = 'SiteDesc'
      Origin = 'tblmsbackendid.SiteDesc'
      Size = 255
    end
    object tblmsbackendidEmailAddressData: TStringField
      FieldName = 'EmailAddressData'
      Origin = 'tblmsbackendid.EmailAddressData'
      Size = 255
    end
    object tblmsbackendidEmailPassword: TStringField
      FieldName = 'EmailPassword'
      Origin = 'tblmsbackendid.EmailPassword'
      Size = 255
    end
    object tblmsbackendidConflictTodoUserId: TIntegerField
      FieldName = 'ConflictTodoUserId'
      Origin = 'tblmsbackendid.ConflictTodoUserId'
    end
    object tblmsbackendidBEDefault: TStringField
      FieldName = 'BEDefault'
      Origin = 'tblmsbackendid.BEDefault'
      Size = 1
    end
    object tblmsbackendidEmailUsername: TStringField
      FieldName = 'EmailUsername'
      Origin = 'tblmsbackendid.EmailUsername'
      Size = 255
    end
    object tblmsbackendidBackEndID: TIntegerField
      FieldName = 'BackEndID'
    end
  end
  object CloneConnection: TMyConnection
    LoginPrompt = False
    Left = 137
    Top = 8
  end
  object CloneCommand: TMyCommand
    Connection = CloneConnection
    Left = 168
    Top = 8
  end
  object cboClassQry: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName,ClassPercent'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Options.LongStrings = False
    Left = 229
    Top = 10
  end
end
