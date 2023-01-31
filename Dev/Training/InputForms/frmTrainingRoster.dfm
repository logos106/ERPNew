inherited fmTrainingRoster: TfmTrainingRoster
  Left = 255
  Top = 261
  HelpContext = 776001
  Caption = 'Training Roster'
  ClientWidth = 989
  ExplicitLeft = 255
  ExplicitTop = 261
  ExplicitWidth = 1005
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Width = 989
    HelpContext = 776002
    ExplicitTop = 532
    ExplicitWidth = 989
  end
  inherited pnlForm: TDNMPanel
    Left = 157
    Width = 832
    HelpContext = 776006
    ExplicitLeft = 157
    ExplicitWidth = 832
    inherited pnlTop: TDNMPanel
      Width = 830
      HelpContext = 776007
      ExplicitWidth = 830
      DesignSize = (
        830
        63)
      object Label11: TLabel
        Left = 5
        Top = 10
        Width = 82
        Height = 15
        HelpContext = 776008
        Caption = 'Training Group'
      end
      object pnlTitle: TDNMPanel
        Left = 284
        Top = 5
        Width = 262
        Height = 39
        HelpContext = 776009
        Anchors = [akTop]
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
          Width = 258
          Height = 35
          HelpContext = 776010
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
            Width = 258
            Height = 35
            HelpContext = 776011
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Training Roster'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitWidth = 234
          end
        end
      end
      object dtpMonth: TwwDBDateTimePicker
        Left = 671
        Top = 38
        Width = 130
        Height = 23
        HelpContext = 776012
        Anchors = [akTop, akRight]
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        Date = 40430.000000000000000000
        Epoch = 1950
        ShowButton = True
        TabOrder = 1
        DisplayFormat = 'dd mmmm yyyy'
        OnChange = dtpMonthChange
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 2
        Top = 38
        Width = 23
        Height = 22
        HelpContext = 776013
        Anchors = [akLeft, akTop, akBottom]
        DisableTransparent = False
        Glyph.Data = {
          66070000424D660700000000000036000000280000001A000000170000000100
          1800000000003007000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0C79B8B9C471FB8633CFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0C79B8B9C471F
          933709933709933709FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF8F6F0C79B8B9C471F933709933709933709933709933709FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF8F6F0C79B8B9C471F933709933709933709933709
          9337099E3D179E3D17FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0C79B8B9C471F9337
          09933709933709933709933709AA4217AA4217B94E21AA4217FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
          F6F0C79B8B9C471F9337099337099337099337099337099E3D17AA4217B94E21
          B94E21C6541BAA4217FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF8F6F0C79B8B9C471F9337099337099337099337099337
          099337099E3D17AA4217B94E21BA4B0FC6541BD15F34B94E21FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D503293370993
          37099337099337099337099337099337099E3D17AA4217B94E21C6541BC6541B
          DB5A22E8733BB94E21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF8D50329337099337099337099337099337099337099337
          09AA4217B94E21C6541BC6541BDB5A22D15F34E8733BB94E21FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0C79B8B9C
          471F933709933709933709933709AA4217B94E21BA4B0FC6541BDB5A22DB5A22
          E8733BE17841C25A2DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0C79B8B9C471F933709933709AA42
          17B94E21C6541BDB5A22DB5A22E8733BE17841EF8750C25A2DFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFF8F6F0C79B8B9C471FB94E21BA4B0FC6541BDB5A22E8733BEF8750
          EF8750F3986AB8633CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0C79B
          8BB94E21D15F34E8733BE17841EF8750F3986AF7A672B8633CFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0D7A28CCB693CEF8750F3986A
          F7A672E5B297B8633CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFF8F6F0D7A28CD27949F7A672F7BFA0B8633CFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F0
          D7A28CCA7B56AE6854FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000}
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ModalResult = 1
        NumGlyphs = 1
        TabOrder = 2
        OnClick = DNMSpeedButton1Click
      end
      object DNMSpeedButton2: TDNMSpeedButton
        Left = 803
        Top = 38
        Width = 23
        Height = 22
        HelpContext = 776014
        Anchors = [akTop, akRight]
        DisableTransparent = False
        Glyph.Data = {
          66070000424D660700000000000036000000280000001A000000170000000100
          1800000000003007000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFB8633C9C471FC79B8BF8F6F0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF93370993370993
          37099C471FC79B8BF8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF9337099337099337099337099337099C471FC79B8BF8F6
          F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9E3D179E3D1793
          37099337099337099337099337099C471FC79B8BF8F6F0FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFAA4217B94E21AA4217AA42179337099337099337099337
          099337099C471FC79B8BF8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAA4217C6541BB9
          4E21B94E21AA42179E3D179337099337099337099337099337099C471FC79B8B
          F8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFB94E21D15F34C6541BBA4B0FB94E21AA42179E3D179337
          099337099337099337099337099337099C471FC79B8BF8F6F0FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB94E21E8733BDB
          5A22C6541BC6541BB94E21AA42179E3D17933709933709933709933709933709
          9337099337098D5032FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFB94E21E8733BD15F34DB5A22C6541BC6541BB94E21AA42
          179337099337099337099337099337099337099337098D5032FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC25A2DE17841E8
          733BDB5A22DB5A22C6541BBA4B0FB94E21AA4217933709933709933709933709
          9C471FC79B8BF8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFC25A2DEF8750E17841E8733BDB5A22DB5A22C6541BB94E
          21AA42179337099337099C471FC79B8BF8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8633CF3986AEF
          8750EF8750E8733BDB5A22C6541BBA4B0FB94E219C471FC79B8BF8F6F0FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFB8633CF7A672F3986AEF8750E17841E8733BD15F34B94E
          21C79B8BF8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8633CE5B297F7
          A672F3986AEF8750CB693CD7A28CF8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFB8633CF7BFA0F7A672D27949D7A28CF8F6F0FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAE6854CA7B56D7
          A28CF8F6F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000}
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ModalResult = 1
        NumGlyphs = 1
        TabOrder = 3
        OnClick = DNMSpeedButton2Click
      end
      object cboTraining: TwwDBLookupCombo
        Left = 95
        Top = 7
        Width = 175
        Height = 23
        HelpContext = 776015
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'40'#9'Description'#9'F')
        LookupTable = qryTrainingLookup
        LookupField = 'Description'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboTrainingCloseUp
      end
    end
    inherited pnlbottom: TDNMPanel
      Top = 483
      Width = 830
      Height = 48
      HelpContext = 776016
      ExplicitTop = 483
      ExplicitWidth = 830
      ExplicitHeight = 48
      DesignSize = (
        830
        48)
      object btnSave: TDNMSpeedButton
        Left = 216
        Top = 13
        Width = 87
        Height = 27
        HelpContext = 776017
        Anchors = [akBottom]
        Caption = 'Save'
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
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object btnCancel: TDNMSpeedButton
        Left = 526
        Top = 13
        Width = 87
        Height = 27
        HelpContext = 776018
        Anchors = [akBottom]
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
        ModalResult = 2
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnCancelClick
      end
      object btnPrint: TDNMSpeedButton
        Left = 371
        Top = 13
        Width = 87
        Height = 27
        HelpContext = 776019
        Anchors = [akBottom]
        Caption = '&Print'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnPrintClick
      end
    end
    inherited pnlmain: TDNMPanel
      Width = 830
      Height = 419
      HelpContext = 776020
      ExplicitWidth = 830
      ExplicitHeight = 419
      object lblItemDetails: TLabel
        Left = 1
        Top = 399
        Width = 828
        Height = 19
        HelpContext = 776021
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 'Select An Item'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        WordWrap = True
        ExplicitTop = 401
        ExplicitWidth = 827
      end
      object PageControl1: TPageControl
        Left = 1
        Top = 1
        Width = 828
        Height = 398
        HelpContext = 776022
        ActivePage = tabDaily
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabHeight = 30
        TabOrder = 0
        TabWidth = 412
        OnChange = PageControl1Change
        OnResize = PageControl1Resize
        object tabWeekly: TTabSheet
          HelpContext = 776023
          Caption = '&Weekly'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object plannerWeek: TDBPlanner
            Left = 0
            Top = 0
            Width = 820
            Height = 358
            HelpContext = 776024
            Align = alClient
            AttachementGlyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              8888888888700078888888888708880788888888808808808888888880808080
              8888888880808080888888888080808088888888808080808888888880808080
              8888888880808080888888888080808088888888808080808888888888808080
              8888888888808880888888888888000888888888888888888888}
            AutoThemeAdapt = True
            Caption.Title = 'TDBPlanner'
            Caption.Font.Charset = DEFAULT_CHARSET
            Caption.Font.Color = clWhite
            Caption.Font.Height = -13
            Caption.Font.Name = 'MS Sans Serif'
            Caption.Font.Style = [fsBold]
            Caption.BackgroundSteps = 32
            Caption.Height = 0
            DayNames.Strings = (
              'Sun'
              'Mon'
              'Tue'
              'Wed'
              'Thu'
              'Fri'
              'Sat')
            DefaultItem.CaptionBkgTo = clSilver
            DefaultItem.CaptionFont.Charset = ANSI_CHARSET
            DefaultItem.CaptionFont.Color = clWindowText
            DefaultItem.CaptionFont.Height = -7
            DefaultItem.CaptionFont.Name = 'Small Fonts'
            DefaultItem.CaptionFont.Style = []
            DefaultItem.ColorTo = 16250871
            DefaultItem.Cursor = -1
            DefaultItem.Font.Charset = ANSI_CHARSET
            DefaultItem.Font.Color = clWindowText
            DefaultItem.Font.Height = -7
            DefaultItem.Font.Name = 'Small Fonts'
            DefaultItem.Font.Style = []
            DefaultItem.ItemBegin = 16
            DefaultItem.ItemEnd = 17
            DefaultItem.ItemPos = 0
            DefaultItem.Name = 'PlannerItem0'
            DefaultItem.ReadOnly = True
            DefaultItem.Shape = psRounded
            DefaultItem.SelectColor = clWhite
            DefaultItem.SelectColorTo = clInfoBk
            DefaultItem.SelectFontColor = clBlack
            DefaultItem.Shadow = False
            DeleteGlyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707
              0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616
              161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E
              56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6
              075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E
              EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6
              EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F
              5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D
              0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}
            Display.ActiveStart = 1
            Display.ActiveEnd = 31
            Display.DisplayEnd = 35
            Display.DisplayScale = 50
            Display.DisplayUnit = 10
            Display.ColorNonActive = clSilver
            Display.ColorCurrent = 14145535
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Footer.Captions.Strings = (
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              '')
            Footer.CompletionFormat = '%d%%'
            Footer.Completion.Font.Charset = DEFAULT_CHARSET
            Footer.Completion.Font.Color = clWindowText
            Footer.Completion.Font.Height = -11
            Footer.Completion.Font.Name = 'Arial'
            Footer.Completion.Font.Style = []
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'MS Sans Serif'
            Footer.Font.Style = []
            GridPopup = PopupMenu
            GridLeftCol = 0
            GridTopRow = 1
            Header.Captions.Strings = (
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              '')
            Header.CustomGroups = <>
            Header.Height = 100
            Header.Font.Charset = ANSI_CHARSET
            Header.Font.Color = clBlack
            Header.Font.Height = -11
            Header.Font.Name = 'Arial'
            Header.Font.Style = []
            Header.GroupFont.Charset = DEFAULT_CHARSET
            Header.GroupFont.Color = clWindowText
            Header.GroupFont.Height = -11
            Header.GroupFont.Name = 'MS Sans Serif'
            Header.GroupFont.Style = []
            Header.ItemHeight = 16
            Header.TextHeight = 100
            HTMLOptions.CellFontStyle = []
            HTMLOptions.HeaderFontStyle = []
            HTMLOptions.SidebarFontStyle = []
            ItemPopup = PopupMenuPlannerItem
            Items = <>
            Mode.Month = 8
            Mode.PeriodStartDay = 1
            Mode.PeriodStartMonth = 7
            Mode.PeriodStartYear = 2003
            Mode.PeriodEndDay = 31
            Mode.PeriodEndMonth = 7
            Mode.PeriodEndYear = 2003
            Mode.PlannerType = plWeek
            Mode.TimeLineStart = 38009.000000000000000000
            Mode.TimeLineNVUBegin = 0
            Mode.TimeLineNVUEnd = 0
            Mode.Year = 2003
            NavigatorButtons.PrevHint = 'Previous'
            NavigatorButtons.NextHint = 'Next'
            NavigatorButtons.ShowHint = True
            ShadowColor = clSilver
            Sidebar.DateTimeFormat = 'mmm dd'
            Sidebar.Font.Charset = DEFAULT_CHARSET
            Sidebar.Font.Color = clBlack
            Sidebar.Font.Height = -11
            Sidebar.Font.Name = 'Arial'
            Sidebar.Font.Style = []
            Sidebar.HourFontRatio = 1.800000000000000000
            Sidebar.OccupiedTo = clWhite
            Sidebar.Position = spTop
            Sidebar.ShowDayName = False
            Sidebar.Width = 20
            Positions = 31
            PositionProps = <>
            PositionWidth = 31
            PrintOptions.LineWidth = 0
            PrintOptions.FooterFont.Charset = DEFAULT_CHARSET
            PrintOptions.FooterFont.Color = clWindowText
            PrintOptions.FooterFont.Height = -11
            PrintOptions.FooterFont.Name = 'MS Sans Serif'
            PrintOptions.FooterFont.Style = []
            PrintOptions.HeaderAlignment = taCenter
            PrintOptions.HeaderFont.Charset = ANSI_CHARSET
            PrintOptions.HeaderFont.Color = clWindowText
            PrintOptions.HeaderFont.Height = -21
            PrintOptions.HeaderFont.Name = 'Arial'
            PrintOptions.HeaderFont.Style = [fsBold]
            PrintOptions.HeaderSize = 500
            PrintOptions.JobName = 'Roster'
            ScrollSmooth = True
            ScrollSynch = True
            URLGlyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
              0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
              0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
              88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
              888887F8F8222208888888776888208888888887777778888888}
            Version = '2.5.8.4'
            OnItemDblClick = plannerWeekItemDblClick
            OnItemSelect = plannerWeekItemSelect
            OnItemExit = plannerWeekItemExit
            OnPlannerKeyDown = plannerWeekPlannerKeyDown
            ItemSource = WeekSource
          end
        end
        object tabDaily: TTabSheet
          HelpContext = 776025
          Caption = '&Daily'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object plannerDay: TDBPlanner
            Left = 0
            Top = 0
            Width = 820
            Height = 358
            HelpContext = 776026
            Align = alClient
            AttachementGlyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              8888888888700078888888888708880788888888808808808888888880808080
              8888888880808080888888888080808088888888808080808888888880808080
              8888888880808080888888888080808088888888808080808888888888808080
              8888888888808880888888888888000888888888888888888888}
            AutoThemeAdapt = True
            Caption.Title = 'TDBPlanner'
            Caption.Font.Charset = DEFAULT_CHARSET
            Caption.Font.Color = clWhite
            Caption.Font.Height = -13
            Caption.Font.Name = 'MS Sans Serif'
            Caption.Font.Style = [fsBold]
            Caption.BackgroundSteps = 32
            Caption.Visible = False
            DayNames.Strings = (
              'Sun'
              'Mon'
              'Tue'
              'Wed'
              'Thu'
              'Fri'
              'Sat')
            DefaultItem.CaptionBkgTo = clSilver
            DefaultItem.CaptionFont.Charset = DEFAULT_CHARSET
            DefaultItem.CaptionFont.Color = clWindowText
            DefaultItem.CaptionFont.Height = -11
            DefaultItem.CaptionFont.Name = 'MS Sans Serif'
            DefaultItem.CaptionFont.Style = []
            DefaultItem.ColorTo = 16250871
            DefaultItem.Cursor = -1
            DefaultItem.Font.Charset = DEFAULT_CHARSET
            DefaultItem.Font.Color = clWindowText
            DefaultItem.Font.Height = -11
            DefaultItem.Font.Name = 'MS Sans Serif'
            DefaultItem.Font.Style = []
            DefaultItem.ItemBegin = 16
            DefaultItem.ItemEnd = 17
            DefaultItem.ItemPos = 0
            DefaultItem.Name = 'PlannerItem0'
            DefaultItem.ReadOnly = True
            DefaultItem.Shape = psRounded
            DefaultItem.SelectColor = clWhite
            DefaultItem.SelectColorTo = clInfoBk
            DefaultItem.Shadow = False
            DeleteGlyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              0800000000000001000000000000000000000001000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00D9ED07070707
              0707070707070707ECD9EC5E5E5E5E5E5E5E5E5E5E5E5E5E5DED070D0E161616
              161616160E0E0E0E5E07070D161656561616161616160E0E5E07070D16AF075E
              56561657B7EF0E0E5E07070D56AFF6075F565FAFF6AF160E5E07070D565EAFF6
              075FEFF6AF17160E5E07070D5E5E5EAFF607F6AF161616165E07070D5E5E5E5E
              EFF60756161616165E07070D5E5E5FEFF6EFF6075E1616165E07070D5F5F07F6
              EF5EAFF6075616165E07070D6707F6075E5656AFF60716165E07070DA7AF075F
              5E5E5E5EAFAF56165E07070DA7A7675F5F5E5E5E5E5E56165E07EDAF0D0D0D0D
              0D0D0D0D0D0D0D0D5EECD9ED070707070707070707070707EDD1}
            Display.ActiveStart = 0
            Display.ActiveEnd = 400
            Display.DisplayScale = 29
            Display.ColorNonActive = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Footer.Captions.Strings = (
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              '')
            Footer.CompletionFormat = '%d%%'
            Footer.Completion.Font.Charset = DEFAULT_CHARSET
            Footer.Completion.Font.Color = clWindowText
            Footer.Completion.Font.Height = -11
            Footer.Completion.Font.Name = 'Arial'
            Footer.Completion.Font.Style = []
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'MS Sans Serif'
            Footer.Font.Style = []
            GridPopup = PopupMenu
            GridLeftCol = 21
            GridTopRow = 1
            Header.Captions.Strings = (
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              ''
              '')
            Header.CustomGroups = <>
            Header.Height = 100
            Header.Font.Charset = ANSI_CHARSET
            Header.Font.Color = clBlack
            Header.Font.Height = -11
            Header.Font.Name = 'Arial'
            Header.Font.Style = []
            Header.GroupFont.Charset = DEFAULT_CHARSET
            Header.GroupFont.Color = clWindowText
            Header.GroupFont.Height = -11
            Header.GroupFont.Name = 'MS Sans Serif'
            Header.GroupFont.Style = []
            Header.ItemHeight = 16
            Header.TextHeight = 100
            HourType = ht12hrs
            HTMLOptions.CellFontStyle = []
            HTMLOptions.HeaderFontStyle = []
            HTMLOptions.SidebarFontStyle = []
            InActiveDays.Sat = False
            InActiveDays.Sun = False
            ItemPopup = PopupMenuPlannerItem
            Items = <>
            Mode.Month = 8
            Mode.PeriodStartDay = 28
            Mode.PeriodStartMonth = 7
            Mode.PeriodStartYear = 2003
            Mode.PeriodEndDay = 14
            Mode.PeriodEndMonth = 9
            Mode.PeriodEndYear = 2003
            Mode.TimeLineStart = 38009.000000000000000000
            Mode.TimeLineNVUBegin = 0
            Mode.TimeLineNVUEnd = 0
            Mode.Year = 2003
            MultiSelect = True
            ShadowColor = clSilver
            Sidebar.AMPMPos = apNone
            Sidebar.DateTimeFormat = 'am/pm'
            Sidebar.Font.Charset = DEFAULT_CHARSET
            Sidebar.Font.Color = clBlack
            Sidebar.Font.Height = -11
            Sidebar.Font.Name = 'Arial'
            Sidebar.Font.Style = []
            Sidebar.HourFontRatio = 1.700000000000000000
            Sidebar.OccupiedTo = clWhite
            Sidebar.Position = spTop
            Positions = 20
            PositionProps = <>
            PositionWidth = 26
            PrintOptions.LineWidth = 0
            PrintOptions.FooterFont.Charset = DEFAULT_CHARSET
            PrintOptions.FooterFont.Color = clWindowText
            PrintOptions.FooterFont.Height = -11
            PrintOptions.FooterFont.Name = 'MS Sans Serif'
            PrintOptions.FooterFont.Style = []
            PrintOptions.HeaderFont.Charset = DEFAULT_CHARSET
            PrintOptions.HeaderFont.Color = clWindowText
            PrintOptions.HeaderFont.Height = -11
            PrintOptions.HeaderFont.Name = 'MS Sans Serif'
            PrintOptions.HeaderFont.Style = []
            ShowDesignHelper = False
            URLGlyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888880000800
              0088888808F8F0F8F80888808000000000808880F070888070F0888080000000
              0080880408F8F0F8F80880CCC0000400008874CCC2222C4788887CCCC22226C0
              88887CC822222CC088887C822224642088887C888422C220888877CF8CCCC227
              888887F8F8222208888888776888208888888887777778888888}
            Version = '2.5.8.4'
            OnItemSelect = plannerWeekItemSelect
            OnPlannerKeyDown = plannerWeekPlannerKeyDown
            ItemSource = DaySource
          end
        end
      end
    end
  end
  object lstColorBox: TListBox [6]
    Left = 641
    Top = 226
    Width = 88
    Height = 56
    HelpContext = 776003
    Color = clWhite
    Columns = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12845252
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    Items.Strings = (
      'clRed'
      'clBlue'
      'clBlack'
      '$0000C6FF'
      '$0044C100'
      '$00C400C4'
      'clMaroon'
      'clMoneyGreen'
      '$007D7DFF'
      '$00FFA4A4'
      '$00AAECFF'
      '$00A4A444'
      'clOlive'
      'clNavy'
      'clPurple'
      'clSilver'
      '$00D28B6C'
      '$00DDDDAC'
      'clTeal'
      'clGreen'
      'clGray'
      'clAqua'
      'clLime'
      'clYellow')
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object grdmodules: TwwDBGrid [7]
    Left = 0
    Top = 0
    Width = 157
    Height = 532
    HelpContext = 776004
    Selected.Strings = (
      'TrainingModuleName'#9'21'#9'Modules')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = False
    Align = alLeft
    DataSource = dsmodules
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = grdmodulesCalcCellColors
    OnDblClick = grdmodulesDblClick
    FooterColor = clWhite
    object grdmodulesIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 1
      Height = 22
      HelpContext = 776005
      AllowAllUp = True
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003000400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 56
  end
  object Qrymodules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tbltrainingmodules'
      'order by Seqno')
    Left = 70
    Top = 173
    object QrymodulesTrainingModuleName: TWideStringField
      DisplayLabel = 'Modules'
      DisplayWidth = 21
      FieldName = 'TrainingModuleName'
      Origin = 'tbltrainingmodules.TrainingModuleName'
      Size = 100
    end
    object QrymodulesTrainingModuleID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'ID'
      DisplayWidth = 1
      FieldName = 'TrainingModuleID'
      Origin = 'tbltrainingmodules.TrainingModuleID'
      Visible = False
    end
    object QrymodulesTrainingHrs: TFloatField
      DisplayWidth = 10
      FieldName = 'TrainingHrs'
      Origin = 'tbltrainingmodules.TrainingHrs'
      Visible = False
    end
  end
  object dsmodules: TDataSource
    DataSet = Qrymodules
    Left = 72
    Top = 208
  end
  object QryRoster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select RosterID, tblroster.GlobalRef, PlannerID, tblroster.Type,' +
        ' tblroster.EmployeeID,tblroster.Date,'
      'tblroster.ClassID, tblroster.Notes,tblroster.Hours,'
      
        'StartTime, EndTime, tblroster.EditedFlag, ClockedOff,TypeCatagor' +
        'y,IsClocked,TRainingModuleId '
      'FROM tblroster'
      '#INNER JOIN tbltrainingemployeemodules using (EmployeeID)'
      'WHERE  (Type = '#39'Training'#39')')
    AfterInsert = QryRosterAfterInsert
    AfterPost = QryRosterAfterPost
    Left = 202
    Top = 333
    object QryRosterRosterID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RosterID'
      Origin = 'tblroster.RosterID'
    end
    object QryRosterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblroster.GlobalRef'
      Size = 255
    end
    object QryRosterPlannerID: TWideStringField
      FieldName = 'PlannerID'
      Origin = 'tblroster.PlannerID'
      Size = 255
    end
    object QryRosterType: TWideStringField
      FieldName = 'Type'
      Origin = 'tblroster.Type'
      Size = 255
    end
    object QryRosterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblroster.EmployeeID'
    end
    object QryRosterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblroster.ClassID'
    end
    object QryRosterNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblroster.Notes'
      Size = 255
    end
    object QryRosterStartTime: TDateTimeField
      FieldName = 'StartTime'
      Origin = 'tblroster.StartTime'
    end
    object QryRosterEndTime: TDateTimeField
      FieldName = 'EndTime'
      Origin = 'tblroster.EndTime'
    end
    object QryRosterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblroster.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QryRosterClockedOff: TWideStringField
      FieldName = 'ClockedOff'
      Origin = 'tblroster.ClockedOff'
      FixedChar = True
      Size = 1
    end
    object QryRosterTypeCatagory: TWideStringField
      FieldName = 'TypeCatagory'
      Origin = 'tblroster.TypeCatagory'
      FixedChar = True
      Size = 10
    end
    object QryRosterHours: TFloatField
      FieldName = 'Hours'
      Origin = 'tblroster.Hours'
    end
    object QryRosterDate: TDateField
      FieldName = 'Date'
      Origin = 'tblroster.Date'
    end
    object QryRosterIsClocked: TWideStringField
      FieldName = 'IsClocked'
      Origin = 'tblroster.IsClocked'
      FixedChar = True
      Size = 1
    end
    object QryRosterTRainingModuleId: TLargeintField
      FieldName = 'TRainingModuleId'
      Origin = 'tblroster.TrainingModuleId'
    end
  end
  object dsDayRoster: TDataSource
    DataSet = QryRoster
    Left = 168
    Top = 376
  end
  object dsWeekRoster: TDataSource
    DataSet = QryRoster
    Left = 232
    Top = 376
  end
  object DaySource: TDBDaySource
    Active = False
    AutoIncKey = False
    DataSource = dsDayRoster
    ResourceMap = <>
    StartTimeField = 'StartTime'
    EndTimeField = 'EndTime'
    KeyField = 'PlannerID'
    ReadOnly = False
    ResourceField = 'EmployeeID'
    NotesField = 'Notes'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToItem
    OnItemToFields = SourceItemToFields
    OnResourceToPosition = SourceResourceToPosition
    OnPositionToResource = PositionToResource
    DateFormat = 'dd mmm yyyy'
    Day = 37846.000000000000000000
    Mode = dmMultiResource
    NumberOfResources = 20
    Left = 168
    Top = 344
  end
  object WeekSource: TDBWeekSource
    Active = False
    AutoIncKey = False
    DataSource = dsWeekRoster
    ResourceMap = <>
    StartTimeField = 'StartTime'
    EndTimeField = 'EndTime'
    KeyField = 'PlannerID'
    ReadOnly = False
    ResourceField = 'EmployeeID'
    NotesField = 'Notes'
    UpdateByQuery = False
    OnFieldsToItem = SourceFieldsToItem
    OnItemToFields = SourceItemToFields
    OnResourceToPosition = SourceResourceToPosition
    NumberOfResources = 20
    Month = 8
    Year = 2003
    WeekStart = 0
    Weeks = 5
    Left = 232
    Top = 344
  end
  object PopupMenuPlannerItem: TAdvPopupMenu
    OnPopup = PopupMenuPlannerItemPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 432
    Top = 168
  end
  object PopupMenu: TAdvPopupMenu
    OnPopup = PopupMenuPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 530
    Top = 171
  end
  object QryTrainingEmployeeModules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblTrainingEmployeeModules')
    Left = 32
    Top = 208
    object QryTrainingEmployeeModulesEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblTrainingEmployeeModules.EmployeeName'
      Size = 100
    end
    object QryTrainingEmployeeModulesBasicFeatures: TWideStringField
      DisplayLabel = 'Basic~Features'
      DisplayWidth = 1
      FieldName = 'BasicFeatures'
      Origin = 'tblTrainingEmployeeModules.BasicFeatures'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesEmployee: TWideStringField
      DisplayWidth = 10
      FieldName = 'Employee'
      Origin = 'tblTrainingEmployeeModules.Employee'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesAccounts: TWideStringField
      DisplayWidth = 10
      FieldName = 'Accounts'
      Origin = 'tblTrainingEmployeeModules.Accounts'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesInventory_Basics: TWideStringField
      DisplayLabel = 'Inventory~Basics'
      DisplayWidth = 1
      FieldName = 'Inventory_Basics'
      Origin = 'tblTrainingEmployeeModules.Inventory_Basics'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesFileMaintenance: TWideStringField
      DisplayLabel = 'File~Maintenance'
      DisplayWidth = 1
      FieldName = 'FileMaintenance'
      Origin = 'tblTrainingEmployeeModules.FileMaintenance'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesPurchase: TWideStringField
      DisplayWidth = 10
      FieldName = 'Purchase'
      Origin = 'tblTrainingEmployeeModules.Purchase'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesCRM: TWideStringField
      DisplayWidth = 10
      FieldName = 'CRM'
      Origin = 'tblTrainingEmployeeModules.CRM'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMarketing: TWideStringField
      DisplayWidth = 10
      FieldName = 'Marketing'
      Origin = 'tblTrainingEmployeeModules.Marketing'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesSales: TWideStringField
      DisplayWidth = 10
      FieldName = 'Sales'
      Origin = 'tblTrainingEmployeeModules.Sales'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesPos: TWideStringField
      DisplayWidth = 10
      FieldName = 'Pos'
      Origin = 'tblTrainingEmployeeModules.Pos'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesBanking: TWideStringField
      DisplayWidth = 10
      FieldName = 'Banking'
      Origin = 'tblTrainingEmployeeModules.Banking'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesReports: TWideStringField
      DisplayWidth = 10
      FieldName = 'Reports'
      Origin = 'tblTrainingEmployeeModules.Reports'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesGeneral_Templates: TWideStringField
      DisplayWidth = 10
      FieldName = 'General_Templates'
      Origin = 'tblTrainingEmployeeModules.General_Templates'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesUtilities: TWideStringField
      DisplayWidth = 10
      FieldName = 'Utilities'
      Origin = 'tblTrainingEmployeeModules.Utilities'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesInventory_Advanced: TWideStringField
      DisplayLabel = 'Inventory~Advanced'
      DisplayWidth = 1
      FieldName = 'Inventory_Advanced'
      Origin = 'tblTrainingEmployeeModules.Inventory_Advanced'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesCustomerPayments: TWideStringField
      DisplayLabel = 'Customer~Payments'
      DisplayWidth = 1
      FieldName = 'CustomerPayments'
      Origin = 'tblTrainingEmployeeModules.CustomerPayments'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesSupplierPayments: TWideStringField
      DisplayLabel = 'Supplier~Payments'
      DisplayWidth = 1
      FieldName = 'SupplierPayments'
      Origin = 'tblTrainingEmployeeModules.SupplierPayments'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesManufacturing: TWideStringField
      DisplayWidth = 10
      FieldName = 'Manufacturing'
      Origin = 'tblTrainingEmployeeModules.Manufacturing'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesAppointments: TWideStringField
      DisplayWidth = 10
      FieldName = 'Appointments'
      Origin = 'tblTrainingEmployeeModules.Appointments'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesPayroll: TWideStringField
      DisplayWidth = 10
      FieldName = 'Payroll'
      Origin = 'tblTrainingEmployeeModules.Payroll'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesFixedAssets: TWideStringField
      DisplayLabel = 'Fixed~Assets'
      DisplayWidth = 1
      FieldName = 'FixedAssets'
      Origin = 'tblTrainingEmployeeModules.FixedAssets'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesWorkshop: TWideStringField
      DisplayWidth = 10
      FieldName = 'Workshop'
      Origin = 'tblTrainingEmployeeModules.Workshop'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesbudgets: TWideStringField
      DisplayLabel = 'Budgets'
      DisplayWidth = 10
      FieldName = 'budgets'
      Origin = 'tblTrainingEmployeeModules.budgets'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesDelivery: TWideStringField
      DisplayWidth = 10
      FieldName = 'Delivery'
      Origin = 'tblTrainingEmployeeModules.Delivery'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMatrix: TWideStringField
      DisplayWidth = 10
      FieldName = 'Matrix'
      Origin = 'tblTrainingEmployeeModules.Matrix'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMoreTraining: TWideStringField
      DisplayLabel = 'More~Training'
      DisplayWidth = 1
      FieldName = 'MoreTraining'
      Origin = 'tblTrainingEmployeeModules.MoreTraining'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesMoreTrainingDetails: TWideStringField
      DisplayLabel = 'More Training~Details'
      DisplayWidth = 20
      FieldName = 'MoreTrainingDetails'
      Origin = 'tblTrainingEmployeeModules.MoreTrainingDetails'
      Size = 255
    end
    object QryTrainingEmployeeModulesTrainingID: TLargeintField
      DisplayWidth = 15
      FieldName = 'TrainingID'
      Origin = 'tblTrainingEmployeeModules.TrainingID'
    end
    object QryTrainingEmployeeModulesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblTrainingEmployeeModules.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryTrainingEmployeeModulesTrainingEmployeeModuleID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TrainingEmployeeModuleID'
      Origin = 'tblTrainingEmployeeModules.TrainingEmployeeModuleID'
      Visible = False
    end
    object QryTrainingEmployeeModulesEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
      Origin = 'tblTrainingEmployeeModules.EmployeeId'
      Visible = False
    end
    object QryTrainingEmployeeModulesDateCreated: TDateTimeField
      FieldName = 'DateCreated'
      Origin = 'tblTrainingEmployeeModules.DateCreated'
      Visible = False
    end
    object QryTrainingEmployeeModulesEnteredby: TIntegerField
      FieldName = 'Enteredby'
      Origin = 'tblTrainingEmployeeModules.Enteredby'
      Visible = False
    end
    object QryTrainingEmployeeModulesmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblTrainingEmployeeModules.mstimestamp'
      Visible = False
    end
    object QryTrainingEmployeeModulesFieldName: TWordField
      FieldName = 'FieldName'
    end
    object QryTrainingEmployeeModulesDataImport: TWideStringField
      FieldName = 'DataImport'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesERPSetup: TWideStringField
      FieldName = 'ERPSetup'
      FixedChar = True
      Size = 1
    end
    object QryTrainingEmployeeModulesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object QryTrainingEmployeeModulesPurchase_FX: TWideStringField
      FieldName = 'Purchase_FX'
      FixedChar = True
      Size = 1
    end
  end
  object dsTrainingEmployeeModules: TDataSource
    DataSet = QryTrainingEmployeeModules
    Left = 32
    Top = 176
  end
  object qryTrainingLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblTraining')
    Left = 390
    Top = 16
    object WideStringField2: TWideStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblTraining.Description'
      Size = 100
    end
    object WideStringField1: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblTraining.GlobalRef'
      Visible = False
      Size = 255
    end
    object LargeintField1: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'TrainingID'
      Origin = 'tblTraining.TrainingID'
      Visible = False
    end
    object DateField1: TDateField
      FieldName = 'TrainingDate'
      Origin = 'tblTraining.TrainingDate'
      Visible = False
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblTraining.msTimeStamp'
      Visible = False
    end
    object IntegerField1: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'MinutesInADay'
      Visible = False
      Calculated = True
    end
    object WideStringField3: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'HoursInADay'
      Visible = False
      Calculated = True
    end
    object TimeField1: TTimeField
      FieldName = 'StartOfTheDay'
      Origin = 'tblTraining.StartOfTheDay'
      Visible = False
      DisplayFormat = 'HH:NN:SS AM/PM'
    end
    object TimeField2: TTimeField
      FieldName = 'EndOftheDay'
      Origin = 'tblTraining.EndOftheDay'
      Visible = False
      DisplayFormat = 'HH:NN:SS AM/PM'
    end
    object FloatField1: TFloatField
      FieldName = 'TotalHours'
      Origin = 'tblTraining.TotalHours'
      Visible = False
    end
  end
end
