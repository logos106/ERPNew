inherited fmTerms: TfmTerms
  Left = 510
  Top = 237
  HelpContext = 1344002
  Caption = 'Term'
  ClientHeight = 521
  ClientWidth = 454
  ExplicitLeft = 510
  ExplicitTop = 237
  ExplicitWidth = 470
  ExplicitHeight = 560
  DesignSize = (
    454
    521)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 471
    Width = 454
    HelpContext = 1344003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 50
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
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 454
    Height = 59
    HelpContext = 1344051
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      454
      59)
    object pnlTitle: TDNMPanel
      Left = 113
      Top = 10
      Width = 228
      Height = 39
      HelpContext = 1344052
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 226
        Height = 37
        HelpContext = 1344053
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
          Width = 226
          Height = 37
          HelpContext = 1344054
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Term'
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
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 471
    Width = 454
    Height = 50
    HelpContext = 1344055
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitTop = 513
    DesignSize = (
      454
      50)
    object cmdClose: TDNMSpeedButton
      Left = 84
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1344056
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
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 276
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1344057
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 183
      Top = 11
      Width = 87
      Height = 27
      Hint = '"Add A Class"'
      HelpContext = 1344058
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
    object chkActive: TwwCheckBox
      Left = 389
      Top = 13
      Width = 59
      Height = 23
      HelpContext = 1344050
      DisableThemes = False
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbChecked
      Anchors = [akRight, akBottom]
      Caption = 'Active '
      Checked = True
      DataField = 'Active'
      DataSource = frmTermsSrc
      State = cbChecked
      TabOrder = 3
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 59
    Width = 454
    Height = 412
    HelpContext = 1344004
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 454
    object Label11: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 342
      Width = 446
      Height = 18
      HelpContext = 1344005
      Margins.Top = 11
      Align = alTop
      AutoSize = False
      Caption = 'Early Payment Discount (%)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitTop = 335
    end
    object Label14: TLabel
      Left = 297
      Top = 344
      Width = 48
      Height = 15
      HelpContext = 1344059
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Days'
    end
    object DNMPanel4: TDNMPanel
      Left = 1
      Top = 126
      Width = 452
      Height = 205
      HelpContext = 1344006
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label10: TLabel
        Left = 81
        Top = 57
        Width = 67
        Height = 15
        HelpContext = 1344007
        Alignment = taRightJustify
        Caption = 'Instalments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblPPHint: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 173
        Width = 444
        Height = 28
        HelpContext = 1344008
        Margins.Top = 1
        Align = alBottom
        Caption = 
          'Progress Payment is only applicable for INVOICE.                ' +
          '                                                 The First Date,' +
          ' Based on the Selections, is the Due Date for All Other Type of ' +
          'Transactions.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitWidth = 438
      end
      object Label3: TLabel
        Left = 38
        Top = 127
        Width = 110
        Height = 30
        HelpContext = 1344009
        Alignment = taRightJustify
        Caption = 'Days after the First Instalment Due'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        AlignWithMargins = True
        Left = 151
        Top = 2
        Width = 297
        Height = 30
        HelpContext = 1344010
        Margins.Left = 150
        Margins.Top = 1
        Align = alTop
        Alignment = taCenter
        Caption = 
          'Recommend You to Create an Additional Set of Terms If You Wish T' +
          'o Use Progress Payments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitWidth = 265
      end
      object Label13: TLabel
        Left = 29
        Top = 85
        Width = 119
        Height = 30
        HelpContext = 1344011
        Alignment = taRightJustify
        Caption = 'First Installment Due on Sale Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Panel1: TDNMPanel
        AlignWithMargins = True
        Left = 210
        Top = 38
        Width = 238
        Height = 133
        HelpContext = 1344012
        Margins.Bottom = 1
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          238
          133)
        object rgFrequency: TDBRadioGroup
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 232
          Height = 126
          HelpContext = 1344013
          Margins.Top = 0
          Margins.Bottom = 7
          Align = alClient
          DataField = 'ProgressPaymenttype'
          DataSource = frmTermsSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Day'
            'Weekly'
            'Monthly')
          ParentBackground = True
          ParentFont = False
          TabOrder = 0
          TabStop = True
          Values.Strings = (
            'D'
            'W'
            'M')
          OnClick = rgFrequencyClick
        end
        object pnlDay: TDNMPanel
          Left = 81
          Top = 11
          Width = 146
          Height = 33
          HelpContext = 1344014
          Anchors = [akLeft, akTop, akRight]
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          TabStop = True
          object Label4: TLabel
            Left = 7
            Top = 8
            Width = 31
            Height = 15
            HelpContext = 1344015
            Caption = 'Every'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label5: TLabel
            Left = 95
            Top = 8
            Width = 36
            Height = 15
            HelpContext = 1344016
            Caption = 'Day(s)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object seDayDays: TwwDBSpinEdit
            Left = 48
            Top = 6
            Width = 41
            Height = 23
            HelpContext = 1344017
            Increment = 1.000000000000000000
            DataField = 'ProgressPaymentDuration'
            DataSource = frmTermsSrc
            TabOrder = 0
            UnboundDataType = wwDefault
          end
        end
        object pnlWeekDay: TDNMPanel
          Left = 81
          Top = 51
          Width = 146
          Height = 33
          HelpContext = 1344018
          Anchors = [akLeft, akTop, akRight]
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          TabStop = True
          object Label6: TLabel
            Left = 7
            Top = 8
            Width = 31
            Height = 15
            HelpContext = 1344019
            Caption = 'Every'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 95
            Top = 8
            Width = 48
            Height = 15
            HelpContext = 1344020
            Caption = 'Week(s)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object seWeekDays: TwwDBSpinEdit
            Left = 48
            Top = 6
            Width = 41
            Height = 23
            HelpContext = 1344021
            Increment = 1.000000000000000000
            DataField = 'ProgressPaymentDuration'
            DataSource = frmTermsSrc
            TabOrder = 0
            UnboundDataType = wwDefault
          end
        end
        object pnlMonth: TDNMPanel
          Left = 81
          Top = 91
          Width = 146
          Height = 33
          HelpContext = 1344022
          Anchors = [akLeft, akTop, akRight]
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          TabStop = True
          object Label8: TLabel
            Left = 7
            Top = 7
            Width = 31
            Height = 15
            HelpContext = 1344023
            Caption = 'Every'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label9: TLabel
            Left = 95
            Top = 7
            Width = 50
            Height = 15
            HelpContext = 1344024
            Caption = 'Month(s)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object seMonthMonths: TwwDBSpinEdit
            Left = 48
            Top = 5
            Width = 41
            Height = 23
            HelpContext = 1344025
            Increment = 1.000000000000000000
            DataField = 'ProgressPaymentDuration'
            DataSource = frmTermsSrc
            TabOrder = 0
            UnboundDataType = wwDefault
          end
        end
      end
      object edtInstallments: TwwDBSpinEdit
        Left = 159
        Top = 53
        Width = 48
        Height = 23
        HelpContext = 1344026
        Increment = 1.000000000000000000
        DataField = 'ProgressPaymentInstallments'
        DataSource = frmTermsSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
      end
      object chkP: TwwCheckBox
        Left = 8
        Top = 13
        Width = 137
        Height = 17
        HelpContext = 1344027
        DisableThemes = False
        AlwaysTransparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = '  Progress Payment'
        DataField = 'PP'
        DataSource = frmTermsSrc
        TabOrder = 2
        OnClick = chooseType
      end
      object edtPPDays: TwwDBSpinEdit
        Left = 159
        Top = 131
        Width = 48
        Height = 23
        HelpContext = 1344028
        Increment = 1.000000000000000000
        DataField = 'TermsAmount'
        DataSource = frmTermsSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
      end
      object chkProgressPaymentfirstPayonSaleDate: TDBCheckBox
        Left = 159
        Top = 89
        Width = 23
        Height = 23
        HelpContext = 1344029
        DataField = 'ProgressPaymentfirstPayonSaleDate'
        DataSource = frmTermsSrc
        TabOrder = 4
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
        OnClick = chkProgressPaymentfirstPayonSaleDateClick
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 1
      Top = 1
      Width = 452
      Height = 55
      HelpContext = 1344030
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 3
        Width = 38
        Height = 18
        HelpContext = 1344031
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label2: TLabel
        Left = 147
        Top = 3
        Width = 70
        Height = 18
        HelpContext = 1344032
        Alignment = taRightJustify
        AutoSize = False
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
      object edtName: TDBEdit
        Left = 8
        Top = 23
        Width = 128
        Height = 23
        HelpContext = 1344033
        DataField = 'Terms'
        DataSource = frmTermsSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 147
        Top = 23
        Width = 286
        Height = 23
        HelpContext = 1344034
        DataField = 'Description'
        DataSource = frmTermsSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object edtEarlyPaymentDiscount: TDBEdit
      Left = 178
      Top = 340
      Width = 68
      Height = 23
      HelpContext = 1344049
      DataField = 'EarlyPaymentDiscount'
      DataSource = frmTermsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtEarlyPaymentDiscountDays: TDBEdit
      Left = 348
      Top = 340
      Width = 50
      Height = 23
      HelpContext = 1344060
      DataField = 'EarlyPaymentDays'
      DataSource = frmTermsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object DNMPanel9: TDNMPanel
      Left = 1
      Top = 56
      Width = 452
      Height = 70
      HelpContext = 1344061
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object DNMPanel7: TDNMPanel
        Left = 300
        Top = 0
        Width = 152
        Height = 70
        HelpContext = 1344039
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblNDays2: TLabel
          AlignWithMargins = True
          Left = 23
          Top = 4
          Width = -172
          Height = 28
          HelpContext = 1344040
          Margins.Left = 22
          Margins.Right = 300
          Align = alBottom
          Caption = '"Due at the End Of the  Following Month"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitTop = 22
          ExplicitWidth = 113
        end
        object lblNDays1: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 38
          Width = 144
          Height = 28
          HelpContext = 1344041
          Align = alBottom
          Alignment = taRightJustify
          AutoSize = False
          Caption = '"Number of Days After the End of the Following Month"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitLeft = 6
          ExplicitTop = 118
        end
        object chkN: TwwCheckBox
          Left = 5
          Top = 8
          Width = 94
          Height = 17
          HelpContext = 1344042
          DisableThemes = False
          AlwaysTransparent = True
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Caption = '  EOM Plus'
          DataField = 'EOMPlus'
          DataSource = frmTermsSrc
          TabOrder = 0
          OnClick = chooseType
        end
        object edtNDays: TwwDBSpinEdit
          Left = 86
          Top = 5
          Width = 54
          Height = 23
          HelpContext = 1344043
          Increment = 1.000000000000000000
          DataField = 'TermsAmount'
          DataSource = frmTermsSrc
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          UnboundDataType = wwDefault
        end
      end
      object DNMPanel8: TDNMPanel
        Left = 150
        Top = 0
        Width = 150
        Height = 70
        HelpContext = 1344044
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label23: TLabel
          AlignWithMargins = True
          Left = 23
          Top = 6
          Width = -174
          Height = 26
          HelpContext = 1344045
          Margins.Left = 22
          Margins.Right = 300
          Align = alBottom
          AutoSize = False
          Caption = '"Due at the End Of the Current Month"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitTop = 23
          ExplicitWidth = 118
        end
        object lblEDays: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 38
          Width = 142
          Height = 28
          HelpContext = 1344046
          Align = alBottom
          Alignment = taRightJustify
          AutoSize = False
          Caption = '"Number of Days After the End of the Current Month"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 119
        end
        object chkE: TwwCheckBox
          Left = 5
          Top = 8
          Width = 71
          Height = 17
          HelpContext = 1344047
          DisableThemes = False
          AlwaysTransparent = True
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Caption = '  EOM'
          DataField = 'EOM'
          DataSource = frmTermsSrc
          TabOrder = 0
          OnClick = chooseType
        end
        object edtEDays: TwwDBSpinEdit
          Left = 86
          Top = 5
          Width = 54
          Height = 23
          HelpContext = 1344048
          Increment = 1.000000000000000000
          DataField = 'TermsAmount'
          DataSource = frmTermsSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          UnboundDataType = wwDefault
        end
      end
      object DNMPanel6: TDNMPanel
        Left = 0
        Top = 0
        Width = 150
        Height = 70
        HelpContext = 1344035
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lblDDays: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 38
          Width = 142
          Height = 28
          HelpContext = 1344036
          Align = alBottom
          Alignment = taRightJustify
          AutoSize = False
          Caption = '"Number of Days After invoice Date"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitLeft = 1
          ExplicitTop = 37
          ExplicitWidth = 146
        end
        object edtDDays: TwwDBSpinEdit
          Left = 86
          Top = 5
          Width = 54
          Height = 23
          HelpContext = 1344037
          Increment = 1.000000000000000000
          DataField = 'TermsAmount'
          DataSource = frmTermsSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          UnboundDataType = wwDefault
        end
        object chkD: TwwCheckBox
          Left = 5
          Top = 8
          Width = 71
          Height = 17
          HelpContext = 1344038
          DisableThemes = False
          AlwaysTransparent = True
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Caption = '  Day(s)'
          DataField = 'Days'
          DataSource = frmTermsSrc
          TabOrder = 1
          OnClick = chooseType
        end
      end
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 403
      Top = 342
      Width = 21
      Height = 18
      Hint = '"Add A Class"'
      HelpContext = 1344062
      Caption = '?'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
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
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
    object DNMPanel10: TDNMPanel
      Left = 1
      Top = 366
      Width = 452
      Height = 45
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      ExplicitTop = 408
      object wwCheckBox1: TwwCheckBox
        Left = 70
        Top = 14
        Width = 122
        Height = 17
        HelpContext = 1344027
        DisableThemes = False
        AlwaysTransparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Publish on VS1 ?'
        DataField = 'PublishOnVS1'
        DataSource = frmTermsSrc
        TabOrder = 0
        OnClick = chooseType
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 151
    Top = 13
  end
  inherited tmrdelay: TTimer
    Left = 316
    Top = 13
  end
  inherited popSpelling: TPopupMenu
    Left = 118
    Top = 13
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 184
    Top = 13
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 349
    Top = 13
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Server = 'localhost'
    Connected = True
    Left = 24
    Top = 79
  end
  inherited DataState: TDataState
    Left = 250
    Top = 13
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 382
    Top = 13
  end
  inherited imgsort: TImageList
    Left = 283
    Top = 13
    Bitmap = {
      494C01010200E400140110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 85
    Top = 13
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 415
    Top = 13
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 217
    Top = 13
  end
  inherited qryMemTrans: TERPQuery
    Left = 52
    Top = 13
  end
  object qryTerms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblTerms'
      'WHERE TermsID=:TID;')
    AfterOpen = qryTermsAfterOpen
    Left = 134
    Top = 59
    ParamData = <
      item
        DataType = ftString
        Name = 'TID'
        Size = 255
      end>
    object qryTermsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblterms.GlobalRef'
      Size = 255
    end
    object qryTermsTermsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TermsID'
      Origin = 'tblterms.TermsID'
    end
    object qryTermsTerms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblterms.Terms'
      Size = 50
    end
    object qryTermsTermsAmount: TIntegerField
      FieldName = 'TermsAmount'
      Origin = 'tblterms.TermsAmount'
    end
    object qryTermsEOM: TWideStringField
      FieldName = 'EOM'
      Origin = 'tblterms.EOM'
      FixedChar = True
      Size = 1
    end
    object qryTermsEOMPlus: TWideStringField
      FieldName = 'EOMPlus'
      Origin = 'tblterms.EOMPlus'
      FixedChar = True
      Size = 1
    end
    object qryTermsDays: TWideStringField
      FieldName = 'Days'
      Origin = 'tblterms.Days'
      FixedChar = True
      Size = 1
    end
    object qryTermsPP: TWideStringField
      FieldName = 'PP'
      Origin = 'tblterms.PP'
      FixedChar = True
      Size = 1
    end
    object qryTermsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblterms.Active'
      FixedChar = True
      Size = 1
    end
    object qryTermsDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblterms.Description'
      Size = 255
    end
    object qryTermsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblterms.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryTermsRequired: TWideStringField
      FieldName = 'Required'
      Origin = 'tblterms.Required'
      FixedChar = True
      Size = 1
    end
    object qryTermsEarlyPaymentDiscount: TFloatField
      FieldName = 'EarlyPaymentDiscount'
      Origin = 'tblterms.EarlyPaymentDiscount'
    end
    object qryTermsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblterms.msTimeStamp'
    end
    object qryTermsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblterms.msUpdateSiteCode'
      Size = 3
    end
    object qryTermsProgressPaymenttype: TWideStringField
      FieldName = 'ProgressPaymenttype'
      Origin = 'tblterms.ProgressPaymenttype'
      FixedChar = True
      Size = 1
    end
    object qryTermsProgressPaymentDuration: TIntegerField
      FieldName = 'ProgressPaymentDuration'
      Origin = 'tblterms.ProgressPaymentDuration'
    end
    object qryTermsProgressPaymentInstallments: TIntegerField
      FieldName = 'ProgressPaymentInstallments'
    end
    object qryTermsProgressPaymentfirstPayonSaleDate: TWideStringField
      FieldName = 'ProgressPaymentfirstPayonSaleDate'
      FixedChar = True
      Size = 1
    end
    object qryTermsEarlyPaymentDays: TIntegerField
      FieldName = 'EarlyPaymentDays'
    end
    object qryTermsPublishOnVS1: TWideStringField
      FieldName = 'PublishOnVS1'
      FixedChar = True
      Size = 1
    end
  end
  object frmTermsSrc: TDataSource
    DataSet = qryTerms
    Left = 163
    Top = 62
  end
end
