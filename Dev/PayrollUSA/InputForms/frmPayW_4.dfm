inherited fmPayW_4: TfmPayW_4
  Left = 358
  Top = 133
  Caption = 'W-4'
  ClientHeight = 571
  ClientWidth = 1054
  ExplicitTop = -106
  ExplicitWidth = 1060
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 515
    Width = 1054
    ExplicitTop = 980
    ExplicitWidth = 984
  end
  inherited shapehint: TShape
    Left = 11
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 61
    ExplicitLeft = 56
  end
  object pnlHeader: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1054
    Height = 70
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 331
      Top = 12
      Width = 392
      Height = 45
      HelpContext = 272017
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
        Width = 388
        Height = 41
        HelpContext = 272018
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
          HelpContext = 272019
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'W-4'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 4
        end
      end
    end
    object chkUseW4: TwwCheckBox
      Left = 760
      Top = 27
      Width = 129
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Has W-4 for 2021 ?'
      DataField = 'UseW4'
      DataSource = dspaysw_4
      TabOrder = 1
      Visible = False
    end
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 515
    Width = 1054
    Height = 56
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      1054
      56)
    object btnSave: TDNMSpeedButton
      Left = 324
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 272011
      Anchors = [akBottom]
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
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 643
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 272012
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 485
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 272011
      Anchors = [akBottom]
      Caption = 'Print'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
  end
  object sbPanels: TScrollBox [7]
    AlignWithMargins = True
    Left = 3
    Top = 73
    Width = 1048
    Height = 439
    HelpContext = 272008
    HorzScrollBar.Visible = False
    VertScrollBar.Position = 439
    VertScrollBar.Range = 1000
    Align = alClient
    AutoScroll = False
    BorderStyle = bsNone
    TabOrder = 2
    object pnlMain: TDNMPanel
      Left = 5
      Top = -434
      Width = 1020
      Height = 1030
      HelpContext = 272009
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      BevelOuter = bvNone
      BorderWidth = 3
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      Category = 'USAPayroll-Top'
      Transparent = False
      object pnl01: TDNMPanel
        Left = 3
        Top = 3
        Width = 1010
        Height = 80
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object DNMPanel3: TDNMPanel
          Left = 1
          Top = 1
          Width = 176
          Height = 78
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lbl1: TLabel
            Left = 5
            Top = 32
            Width = 152
            Height = 45
            HelpContext = 272059
            Caption = 
              '(Rev. December 2020) Department of the Treasury Internal Revenue' +
              ' Service'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lbl2: TLabel
            Left = 63
            Top = 1
            Width = 52
            Height = 34
            HelpContext = 272059
            Caption = 'W-4'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblA1: TLabel
            Left = 27
            Top = 15
            Width = 29
            Height = 15
            Caption = 'Form'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
        end
        object DNMPanel4: TDNMPanel
          Left = 839
          Top = 1
          Width = 170
          Height = 78
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lbl7: TLabel
            Left = 1
            Top = 1
            Width = 168
            Height = 19
            HelpContext = 272059
            Align = alTop
            Alignment = taCenter
            Caption = 'OMB No. 1545-0074'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Transparent = True
            ExplicitWidth = 148
          end
          object lbl8: TLabel
            Left = 1
            Top = 20
            Width = 168
            Height = 57
            HelpContext = 272059
            Align = alClient
            Alignment = taCenter
            Caption = '2021'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -37
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitWidth = 84
            ExplicitHeight = 44
          end
        end
        object DNMPanel5: TDNMPanel
          Left = 177
          Top = 1
          Width = 660
          Height = 78
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object lbl3: TLabel
            Left = 1
            Top = 1
            Width = 658
            Height = 24
            HelpContext = 272059
            Align = alTop
            Alignment = taCenter
            Caption = 'Employee'#8217's Withholding Certificate'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitWidth = 352
          end
          object lbl4: TLabel
            Left = 1
            Top = 25
            Width = 658
            Height = 15
            HelpContext = 272059
            Align = alTop
            Alignment = taCenter
            Caption = 
              #9654' Complete Form W-4 so that your employer can withhold the corre' +
              'ct federal income tax from your pay'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitWidth = 583
          end
          object lbl5: TLabel
            Left = 1
            Top = 40
            Width = 658
            Height = 15
            HelpContext = 272059
            Align = alTop
            Alignment = taCenter
            Caption = #9654' Give Form W-4 to your employer.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitWidth = 196
          end
          object lbl6: TLabel
            Left = 1
            Top = 55
            Width = 658
            Height = 15
            HelpContext = 272059
            Align = alTop
            Alignment = taCenter
            Caption = #9654' Your withholding is subject to review by the IRS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitWidth = 279
          end
        end
      end
      object pnlStep1: TDNMPanel
        Left = 3
        Top = 83
        Width = 1010
        Height = 300
        Margins.Left = 5
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object pnlMainLabel: TDNMPanel
          Left = 1
          Top = 1
          Width = 136
          Height = 298
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lbl9: TLabel
            Left = 1
            Top = 1
            Width = 134
            Height = 296
            HelpContext = 272059
            Align = alClient
            Caption = 'Step 1: Enter Personal Information'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitWidth = 103
            ExplicitHeight = 57
          end
        end
        object pnlContent: TDNMPanel
          Left = 139
          Top = 1
          Width = 870
          Height = 298
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object pnlUpper: TDNMPanel
            Left = 1
            Top = 1
            Width = 868
            Height = 192
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object pnlEmployee: TDNMPanel
              Left = 1
              Top = 1
              Width = 647
              Height = 190
              Align = alLeft
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object pnlAddress: TDNMPanel
                Left = 1
                Top = 46
                Width = 645
                Height = 45
                Align = alTop
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                DesignSize = (
                  645
                  45)
                object Label3: TLabel
                  AlignWithMargins = True
                  Left = 2
                  Top = 2
                  Width = 641
                  Height = 15
                  HelpContext = 272059
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Align = alTop
                  Caption = 'Address'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                  ExplicitWidth = 48
                end
                object edtAddress: TwwDBEdit
                  AlignWithMargins = True
                  Left = 2
                  Top = 19
                  Width = 641
                  Height = 23
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  DataField = 'Street1'
                  DataSource = dspaysw_4
                  TabOrder = 0
                  UnboundDataType = wwDefault
                  WantReturns = False
                  WordWrap = False
                end
              end
              object pnlCity1: TDNMPanel
                Left = 1
                Top = 91
                Width = 645
                Height = 44
                Align = alTop
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                DesignSize = (
                  645
                  44)
                object Label4: TLabel
                  Left = 1
                  Top = 1
                  Width = 643
                  Height = 15
                  HelpContext = 272059
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Align = alTop
                  Caption = 
                    'City                                           Town             ' +
                    '                                State                         ZI' +
                    'P code'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                  ExplicitWidth = 469
                end
                object edtCity: TwwDBEdit
                  AlignWithMargins = True
                  Left = 1
                  Top = 18
                  Width = 141
                  Height = 23
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Anchors = [akLeft, akTop, akBottom]
                  DataField = 'Street2'
                  DataSource = dspaysw_4
                  TabOrder = 0
                  UnboundDataType = wwDefault
                  WantReturns = False
                  WordWrap = False
                end
                object edtTown: TwwDBEdit
                  AlignWithMargins = True
                  Left = 150
                  Top = 18
                  Width = 141
                  Height = 23
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Anchors = [akLeft, akTop, akBottom]
                  DataField = 'Suburb'
                  DataSource = dspaysw_4
                  TabOrder = 1
                  UnboundDataType = wwDefault
                  WantReturns = False
                  WordWrap = False
                end
                object edtState: TwwDBEdit
                  AlignWithMargins = True
                  Left = 318
                  Top = 18
                  Width = 82
                  Height = 23
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Anchors = [akLeft, akTop, akBottom]
                  DataField = 'State'
                  DataSource = dspaysw_4
                  TabOrder = 2
                  UnboundDataType = wwDefault
                  WantReturns = False
                  WordWrap = False
                end
                object edtZIP: TwwDBEdit
                  AlignWithMargins = True
                  Left = 422
                  Top = 18
                  Width = 74
                  Height = 23
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Anchors = [akLeft, akTop, akBottom]
                  DataField = 'Postcode'
                  DataSource = dspaysw_4
                  TabOrder = 3
                  UnboundDataType = wwDefault
                  WantReturns = False
                  WordWrap = False
                end
              end
              object pnlName: TDNMPanel
                Left = 1
                Top = 1
                Width = 645
                Height = 45
                Align = alTop
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                object pnlfirstname: TDNMPanel
                  AlignWithMargins = True
                  Left = 1
                  Top = 1
                  Width = 320
                  Height = 44
                  Margins.Left = 0
                  Margins.Top = 0
                  Margins.Right = 315
                  Margins.Bottom = 0
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  DesignSize = (
                    320
                    44)
                  object Label1: TLabel
                    AlignWithMargins = True
                    Left = 2
                    Top = 2
                    Width = 316
                    Height = 15
                    HelpContext = 272059
                    Margins.Left = 1
                    Margins.Top = 1
                    Margins.Right = 1
                    Margins.Bottom = 1
                    Align = alTop
                    Caption = '(a) First name and middle initial'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                    ExplicitWidth = 176
                  end
                  object edtFirstname: TwwDBEdit
                    AlignWithMargins = True
                    Left = 2
                    Top = 19
                    Width = 316
                    Height = 23
                    Margins.Left = 1
                    Margins.Top = 1
                    Margins.Right = 1
                    Margins.Bottom = 1
                    Anchors = [akLeft, akTop, akRight, akBottom]
                    DataField = 'FirstName'
                    DataSource = dspaysw_4
                    TabOrder = 0
                    UnboundDataType = wwDefault
                    WantReturns = False
                    WordWrap = False
                  end
                end
                object pnlLastname: TDNMPanel
                  Left = 324
                  Top = 0
                  Width = 320
                  Height = 44
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                  Transparent = False
                  DesignSize = (
                    320
                    44)
                  object Label2: TLabel
                    AlignWithMargins = True
                    Left = 2
                    Top = 2
                    Width = 316
                    Height = 15
                    HelpContext = 272059
                    Margins.Left = 1
                    Margins.Top = 1
                    Margins.Right = 1
                    Margins.Bottom = 1
                    Align = alTop
                    Caption = 'Last name'
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clBlack
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                    ExplicitWidth = 60
                  end
                  object edtLastName: TwwDBEdit
                    AlignWithMargins = True
                    Left = 2
                    Top = 20
                    Width = 316
                    Height = 23
                    Margins.Left = 1
                    Margins.Top = 1
                    Margins.Right = 1
                    Margins.Bottom = 1
                    Anchors = [akLeft, akTop, akRight, akBottom]
                    DataField = 'LastName'
                    DataSource = dspaysw_4
                    TabOrder = 0
                    UnboundDataType = wwDefault
                    WantReturns = False
                    WordWrap = False
                  end
                end
              end
            end
            object pnlSocial: TDNMPanel
              Left = 652
              Top = 1
              Width = 215
              Height = 190
              Align = alRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object Label7: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 46
                Width = 209
                Height = 142
                HelpContext = 272059
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                Align = alClient
                Caption = 
                  #9654' Does your name match the name on your social security card? If' +
                  ' not, to ensure you get credit for your earnings, contact SSA at' +
                  ' 800-772-1213 or go to www.ssa.gov.'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                WordWrap = True
                ExplicitWidth = 205
                ExplicitHeight = 108
              end
              object DNMPanel6: TDNMPanel
                Left = 1
                Top = 1
                Width = 213
                Height = 44
                Align = alTop
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                DesignSize = (
                  213
                  44)
                object Label6: TLabel
                  AlignWithMargins = True
                  Left = 2
                  Top = 2
                  Width = 209
                  Height = 15
                  HelpContext = 272059
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Align = alTop
                  Caption = '(b) Social security number'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                  ExplicitWidth = 149
                end
                object Edit5: TwwDBEdit
                  AlignWithMargins = True
                  Left = 2
                  Top = 20
                  Width = 207
                  Height = 23
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  DataField = 'SocialSecurityNumber'
                  DataSource = dspaysw_4
                  TabOrder = 0
                  UnboundDataType = wwDefault
                  WantReturns = False
                  WordWrap = False
                end
              end
            end
          end
          object pnlBelow: TDNMPanel
            Left = 1
            Top = 193
            Width = 868
            Height = 105
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Label5: TLabel
              Left = 1
              Top = 1
              Width = 15
              Height = 103
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alLeft
              Caption = '(c)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              ExplicitHeight = 15
            end
            object opt1: TwwRadioGroup
              Left = 16
              Top = 1
              Width = 873
              Height = 103
              DisableThemes = False
              Align = alLeft
              DataField = 'TaxReportingtype'
              DataSource = dspaysw_4
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Items.Strings = (
                '    Single or Married filing separately'
                '    Married filing jointly or Qualifying widow(er)'
                
                  '    Head of household (Check only if you'#8217're unmarried and pay mo' +
                  're than half the costs of keeping up a home for yourself and a q' +
                  'ualifying individual.)'
                '    unknown')
              ParentFont = False
              TabOrder = 0
              WordWrap = True
              Values.Strings = (
                'A'
                'B'
                'C'
                'U')
            end
          end
        end
      end
      object pnl02: TDNMPanel
        Left = 3
        Top = 383
        Width = 1010
        Height = 44
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object pnlContainer: TDNMPanel
          Left = 1
          Top = 1
          Width = 1027
          Height = 42
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label9: TLabel
            AlignWithMargins = True
            Left = 2
            Top = 2
            Width = 1023
            Height = 18
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = 
              'Complete Steps 2'#8211'4 ONLY if they apply to you; otherwise, skip to' +
              ' Step 5.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitWidth = 507
          end
          object Label8: TLabel
            AlignWithMargins = True
            Left = 2
            Top = 22
            Width = 1023
            Height = 18
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alClient
            Caption = 
              'See page 2 for more information on each step, who can claim exem' +
              'ption from withholding, when to use the estimator at www.irs.gov' +
              '/W4App, and privacy.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitWidth = 867
            ExplicitHeight = 15
          end
        end
      end
      object pnlStep2: TDNMPanel
        Left = 3
        Top = 427
        Width = 1010
        Height = 220
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object lbl12: TLabel
          AlignWithMargins = True
          Left = 161
          Top = 147
          Width = 847
          Height = 30
          HelpContext = 272059
          Margins.Left = 160
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 10
          Align = alBottom
          Caption = 
            'TIP: To be accurate, submit a 2021 Form W-4 for all other jobs. ' +
            'If you (or your spouse) have self-employment income, including a' +
            's an independent contractor, use the estimator.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitWidth = 819
        end
        object Label10: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 188
          Width = 1006
          Height = 30
          HelpContext = 272059
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alBottom
          Caption = 
            'Complete Steps 3'#8211'4(b) on Form W-4 for only ONE of these jobs. Le' +
            'ave those steps blank for the other jobs. (Your withholding will' +
            ' be most accurate if you complete Steps 3'#8211'4(b) on the Form W-4 f' +
            'or the highest paying job.)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitWidth = 1005
        end
        object RichEdit1: TRichEdit
          AlignWithMargins = True
          Left = 154
          Top = 4
          Width = 733
          Height = 139
          Margins.Right = 122
          TabStop = False
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            
              'Complete this step if you (1) hold more than one job at a time, ' +
              'or (2) are married filing jointly and your spouse'
            
              'also works. The correct amount of withholding depends on income ' +
              'earned from all of these jobs.'
            ''
            'Do only one of the following.'
            ''
            
              '(a) Use the estimator at www.irs.gov/W4App for most accurate wit' +
              'hholding for this step (and Steps 3'#8211'4); or'
            
              '(b) Use the Multiple Jobs Worksheet on page 3 and enter the resu' +
              'lt in Step 4(c) below for roughly accurate withholding; or'
            
              '(c) If there are only two jobs total, you may check this box. Do' +
              ' the same on Form W-4 for the other job. This option'
            
              '      is accurate for jobs with similar pay; otherwise, more tax' +
              ' than necessary may be withheld . . . . . '#9654)
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object chk1: TwwCheckBox
          Left = 832
          Top = 126
          Width = 17
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          DataField = 'HaveMultipleJobs'
          DataSource = dspaysw_4
          TabOrder = 0
        end
        object DNMPanel20: TDNMPanel
          Left = 1
          Top = 1
          Width = 150
          Height = 145
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lbl10: TLabel
            AlignWithMargins = True
            Left = 2
            Top = 2
            Width = 146
            Height = 141
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alClient
            AutoSize = False
            Caption = 'Step 2: '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitHeight = 150
          end
        end
      end
      object pnlStep3: TDNMPanel
        Left = 3
        Top = 647
        Width = 1010
        Height = 126
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object DNMPanel12: TDNMPanel
          Left = 1
          Top = 1
          Width = 150
          Height = 124
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lbl13: TLabel
            AlignWithMargins = True
            Left = 2
            Top = 2
            Width = 174
            Height = 120
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            AutoSize = False
            Caption = 'Step 3: '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitLeft = 0
            ExplicitTop = 3
          end
        end
        object DNMPanel13: TDNMPanel
          Left = 856
          Top = 1
          Width = 153
          Height = 124
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          DesignSize = (
            153
            124)
          object Edit6: TwwDBEdit
            AlignWithMargins = True
            Left = 2
            Top = 99
            Width = 147
            Height = 23
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Anchors = [akLeft, akRight, akBottom]
            DataField = 'Dependent'
            DataSource = dspaysw_4
            TabOrder = 0
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
        end
        object DNMPanel14: TDNMPanel
          Left = 806
          Top = 1
          Width = 50
          Height = 124
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label11: TLabel
            AlignWithMargins = True
            Left = 2
            Top = 103
            Width = 46
            Height = 15
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 5
            Align = alBottom
            Alignment = taRightJustify
            Caption = '3    $ '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitLeft = 19
            ExplicitWidth = 29
          end
        end
        object DNMPanel15: TDNMPanel
          Left = 151
          Top = 1
          Width = 655
          Height = 124
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object DNMPanel16: TDNMPanel
            AlignWithMargins = True
            Left = 4
            Top = 96
            Width = 647
            Height = 27
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label14: TLabel
              AlignWithMargins = True
              Left = 12
              Top = 5
              Width = 664
              Height = 15
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Caption = 
                'Add the amounts above and enter the total here . . . . . . . . .' +
                ' . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .' +
                ' . . . . . . . . . . . . . . . . . . . . . . . . .'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
          end
          object DNMPanel17: TDNMPanel
            AlignWithMargins = True
            Left = 4
            Top = 65
            Width = 647
            Height = 27
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            DesignSize = (
              647
              27)
            object Label15: TLabel
              AlignWithMargins = True
              Left = 12
              Top = 6
              Width = 560
              Height = 15
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Caption = 
                'Number of other dependents by $500 . . . . . . . . . . . . . . .' +
                ' . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .' +
                ' . . . . . . . '#9654'  $'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Edit8: TwwDBEdit
              AlignWithMargins = True
              Left = 560
              Top = 1
              Width = 86
              Height = 23
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Anchors = [akTop, akRight, akBottom]
              DataField = 'OtherDependent'
              DataSource = dspaysw_4
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
          end
          object DNMPanel18: TDNMPanel
            AlignWithMargins = True
            Left = 4
            Top = 34
            Width = 647
            Height = 27
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            DesignSize = (
              647
              27)
            object Label16: TLabel
              AlignWithMargins = True
              Left = 12
              Top = 5
              Width = 560
              Height = 15
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Caption = 
                'Number of qualifying children under age 17 by $2,000  . . . . . ' +
                '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ' +
                '. .'#9654'  $'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Edit7: TwwDBEdit
              AlignWithMargins = True
              Left = 559
              Top = 2
              Width = 86
              Height = 23
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Anchors = [akTop, akRight, akBottom]
              DataField = 'ChildrenUnder17'
              DataSource = dspaysw_4
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
          end
          object DNMPanel19: TDNMPanel
            AlignWithMargins = True
            Left = 4
            Top = 3
            Width = 647
            Height = 27
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            object Label17: TLabel
              AlignWithMargins = True
              Left = 12
              Top = 4
              Width = 476
              Height = 15
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Caption = 
                'If your total income will be $200,000 or less ($400,000 or less ' +
                'if married filing jointly):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
          end
        end
      end
      object pnlStep4: TDNMPanel
        Left = 3
        Top = 773
        Width = 1010
        Height = 152
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        object DNMPanel22: TDNMPanel
          Left = 1
          Top = 1
          Width = 150
          Height = 150
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lbl14: TLabel
            AlignWithMargins = True
            Left = 2
            Top = 2
            Width = 174
            Height = 146
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            AutoSize = False
            Caption = 'Step 4: '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitLeft = 0
            ExplicitTop = 3
            ExplicitHeight = 120
          end
        end
        object DNMPanel25: TDNMPanel
          Left = 151
          Top = 1
          Width = 858
          Height = 150
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object pnl4C: TDNMPanel
            Left = 1
            Top = 107
            Width = 856
            Height = 32
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label18: TLabel
              AlignWithMargins = True
              Left = 19
              Top = 2
              Width = 635
              Height = 28
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alClient
              Caption = 
                ' Extra withholding. Enter any additional tax you want withheld e' +
                'ach pay period'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              WordWrap = True
              ExplicitWidth = 437
              ExplicitHeight = 15
            end
            object Label20: TLabel
              AlignWithMargins = True
              Left = 2
              Top = 2
              Width = 15
              Height = 28
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alLeft
              AutoSize = False
              Caption = '(c)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              ExplicitTop = 4
              ExplicitHeight = 15
            end
            object DNMPanel32: TDNMPanel
              Left = 705
              Top = 1
              Width = 150
              Height = 30
              Align = alRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              DesignSize = (
                150
                30)
              object Label23: TLabel
                AlignWithMargins = True
                Left = 5
                Top = 110
                Width = 7
                Height = 15
                HelpContext = 272059
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                Caption = '$'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Edit10: TwwDBEdit
                AlignWithMargins = True
                Left = 2
                Top = 5
                Width = 144
                Height = 23
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                Anchors = [akLeft, akRight, akBottom]
                DataField = 'ExtraWithholding'
                DataSource = dspaysw_4
                TabOrder = 0
                UnboundDataType = wwDefault
                WantReturns = False
                WordWrap = False
              end
            end
            object DNMPanel33: TDNMPanel
              Left = 655
              Top = 1
              Width = 50
              Height = 30
              Align = alRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object Label27: TLabel
                AlignWithMargins = True
                Left = 2
                Top = 9
                Width = 46
                Height = 15
                HelpContext = 272059
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 5
                Align = alBottom
                Alignment = taCenter
                Caption = '4(c)    $ '
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                ExplicitWidth = 44
              end
            end
          end
          object pnl4B: TDNMPanel
            Left = 1
            Top = 54
            Width = 856
            Height = 53
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Label24: TLabel
              AlignWithMargins = True
              Left = 19
              Top = 2
              Width = 635
              Height = 49
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alClient
              Caption = 
                'Deductions. If you expect to claim deductions other than the sta' +
                'ndard deduction and want to reduce your withholding, use the Ded' +
                'uctions Worksheet on page 3 and enter the result here . . . . . ' +
                '. . . . . . . . . . . . . . . .'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              WordWrap = True
              ExplicitWidth = 594
              ExplicitHeight = 30
            end
            object Label22: TLabel
              AlignWithMargins = True
              Left = 2
              Top = 4
              Width = 15
              Height = 47
              HelpContext = 272059
              Margins.Left = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alLeft
              AutoSize = False
              Caption = '(b)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              ExplicitHeight = 15
            end
            object DNMPanel30: TDNMPanel
              Left = 705
              Top = 1
              Width = 150
              Height = 51
              Align = alRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              DesignSize = (
                150
                51)
              object Label12: TLabel
                AlignWithMargins = True
                Left = 5
                Top = 110
                Width = 7
                Height = 15
                HelpContext = 272059
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                Caption = '$'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Edit11: TwwDBEdit
                AlignWithMargins = True
                Left = 2
                Top = 26
                Width = 144
                Height = 23
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                Anchors = [akLeft, akRight, akBottom]
                DataField = 'Deductions'
                DataSource = dspaysw_4
                TabOrder = 0
                UnboundDataType = wwDefault
                WantReturns = False
                WordWrap = False
              end
            end
            object DNMPanel31: TDNMPanel
              Left = 655
              Top = 1
              Width = 50
              Height = 51
              Align = alRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object Label26: TLabel
                AlignWithMargins = True
                Left = 2
                Top = 30
                Width = 46
                Height = 15
                HelpContext = 272059
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 5
                Align = alBottom
                Alignment = taCenter
                Caption = '4(b)    $ '
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                ExplicitWidth = 44
              end
            end
          end
          object pnl4A: TDNMPanel
            Left = 1
            Top = 1
            Width = 856
            Height = 53
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object Label25: TLabel
              AlignWithMargins = True
              Left = 24
              Top = 2
              Width = 630
              Height = 49
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alClient
              Caption = 
                'Other income (not from jobs). If you want tax withheld for other' +
                ' income you expect this year that won'#8217't have withholding, enter ' +
                'the amount of other income here. This may include interest, divi' +
                'dends, and retirement income . . . . . . . . . . . .'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              WordWrap = True
              ExplicitWidth = 608
              ExplicitHeight = 45
            end
            object Label13: TLabel
              AlignWithMargins = True
              Left = 2
              Top = 4
              Width = 20
              Height = 47
              HelpContext = 272059
              Margins.Left = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alLeft
              AutoSize = False
              Caption = '(a)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object DNMPanel23: TDNMPanel
              Left = 705
              Top = 1
              Width = 150
              Height = 51
              Align = alRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              DesignSize = (
                150
                51)
              object Label19: TLabel
                AlignWithMargins = True
                Left = 5
                Top = 110
                Width = 7
                Height = 15
                HelpContext = 272059
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                Caption = '$'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Edit9: TwwDBEdit
                AlignWithMargins = True
                Left = 2
                Top = 26
                Width = 144
                Height = 23
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 1
                Anchors = [akLeft, akRight, akBottom]
                DataField = 'OtherIncome'
                DataSource = dspaysw_4
                TabOrder = 0
                UnboundDataType = wwDefault
                WantReturns = False
                WordWrap = False
              end
            end
            object DNMPanel24: TDNMPanel
              Left = 655
              Top = 1
              Width = 50
              Height = 51
              Align = alRight
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object Label21: TLabel
                AlignWithMargins = True
                Left = 2
                Top = 30
                Width = 46
                Height = 15
                HelpContext = 272059
                Margins.Left = 1
                Margins.Top = 1
                Margins.Right = 1
                Margins.Bottom = 5
                Align = alBottom
                Alignment = taCenter
                Caption = '4(a)    $ '
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                ExplicitWidth = 44
              end
            end
          end
        end
      end
      object pnlStep5: TDNMPanel
        Left = 3
        Top = 925
        Width = 1010
        Height = 100
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        object DNMPanel9: TDNMPanel
          Left = 1
          Top = 1
          Width = 150
          Height = 98
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label28: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 100
            Height = 29
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            AutoSize = False
            Caption = 'Step 5: '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label29: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 35
            Width = 100
            Height = 30
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            AutoSize = False
            Caption = 'Sign'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label30: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 58
            Width = 100
            Height = 29
            HelpContext = 272059
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            AutoSize = False
            Caption = 'Here'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
        end
        object DNMPanel21: TDNMPanel
          Left = 151
          Top = 1
          Width = 858
          Height = 98
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object DNMPanel39: TDNMPanel
            Left = 1
            Top = 1
            Width = 856
            Height = 29
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label37: TLabel
              AlignWithMargins = True
              Left = 2
              Top = 2
              Width = 852
              Height = 25
              HelpContext = 272059
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alClient
              Caption = 
                'Under penalties of perjury, I declare that this certificate, to ' +
                'the best of my knowledge and belief, is true, correct, and compl' +
                'ete'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              WordWrap = True
              ExplicitWidth = 706
              ExplicitHeight = 15
            end
          end
        end
      end
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 112
    Top = 8
  end
  inherited tmrdelayMsg: TTimer
    Left = 512
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 241
    Top = 8
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 237
  end
  inherited MyConnection: TERPConnection
    Database = 'wang_developer'
    Server = 'localhost'
    Connected = True
    Left = 2
    Top = 7
  end
  inherited DataState: TDataState
    Left = 272
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 139
    Top = 8
  end
  inherited imgsort: TImageList
    Left = 307
    Bitmap = {
      494C010102004801EC0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 50
    Top = 16
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 342
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 182
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Left = 77
    Top = 8
  end
  object dspaysw_4: TDataSource
    DataSet = qrypaysw_4
    Left = 904
    Top = 8
  end
  object qrypaysw_4: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblPaysW_4')
    Left = 984
    Top = 16
    object qrypaysw_4EmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblpaysw_4.EmployeeID'
    end
    object qrypaysw_4PayYear: TIntegerField
      FieldName = 'PayYear'
      Origin = 'tblpaysw_4.PayYear'
    end
    object qrypaysw_4PayYearStart: TDateField
      FieldName = 'PayYearStart'
      Origin = 'tblpaysw_4.PayYearStart'
    end
    object qrypaysw_4FirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblpaysw_4.FirstName'
      Size = 255
    end
    object qrypaysw_4LastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblpaysw_4.LastName'
      Size = 255
    end
    object qrypaysw_4SocialSecurityNumber: TWideStringField
      FieldName = 'SocialSecurityNumber'
      Origin = 'tblpaysw_4.SocialSecurityNumber'
      Size = 255
    end
    object qrypaysw_4Street1: TWideStringField
      FieldName = 'Street1'
      Origin = 'tblpaysw_4.Street1'
      Size = 255
    end
    object qrypaysw_4Street2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblpaysw_4.Street2'
      Size = 255
    end
    object qrypaysw_4Suburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblpaysw_4.Suburb'
      Size = 255
    end
    object qrypaysw_4Postcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblpaysw_4.Postcode'
      Size = 255
    end
    object qrypaysw_4State: TWideStringField
      FieldName = 'State'
      Origin = 'tblpaysw_4.State'
      Size = 255
    end
    object qrypaysw_4Country: TWideStringField
      FieldName = 'Country'
      Origin = 'tblpaysw_4.Country'
      Size = 255
    end
    object qrypaysw_4TaxReportingtype: TWideStringField
      FieldName = 'TaxReportingtype'
      Origin = 'tblpaysw_4.TaxReportingtype'
      FixedChar = True
      Size = 1
    end
    object qrypaysw_4UseW4: TWideStringField
      FieldName = 'UseW4'
      Origin = 'tblpaysw_4.UseW4'
      FixedChar = True
      Size = 1
    end
    object qrypaysw_4HaveMultipleJobs: TWideStringField
      FieldName = 'HaveMultipleJobs'
      Origin = 'tblpaysw_4.HaveMultipleJobs'
      FixedChar = True
      Size = 1
    end
    object qrypaysw_4ChildrenUnder17: TIntegerField
      FieldName = 'ChildrenUnder17'
      Origin = 'tblpaysw_4.ChildrenUnder17'
    end
    object qrypaysw_4OtherDependent: TIntegerField
      FieldName = 'OtherDependent'
      Origin = 'tblpaysw_4.OtherDependent'
    end
    object qrypaysw_4Dependent: TIntegerField
      FieldName = 'Dependent'
      Origin = 'tblpaysw_4.Dependent'
    end
    object qrypaysw_4OtherIncome: TFloatField
      FieldName = 'OtherIncome'
      Origin = 'tblpaysw_4.OtherIncome'
    end
    object qrypaysw_4Deductions: TFloatField
      FieldName = 'Deductions'
      Origin = 'tblpaysw_4.Deductions'
    end
    object qrypaysw_4ExtraWithholding: TFloatField
      FieldName = 'ExtraWithholding'
      Origin = 'tblpaysw_4.ExtraWithholding'
    end
  end
end
