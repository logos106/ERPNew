inherited fmVATReturn: TfmVATReturn
  Left = -15
  Top = 248
  HelpContext = 898001
  Caption = 'fmVATReturn'
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 522
    ExplicitTop = 522
  end
  object Bevel2: TBevel [3]
    Left = 88
    Top = 145
    Width = 545
    Height = 46
    HelpContext = 898002
  end
  inherited pnltop: TDNMPanel
    HelpContext = 898066
    inherited edtDescription: TwwDBEdit
      DataField = 'VATDesc'
    end
  end
  inherited memsummaryreturn: TMemo
    Left = 141
    Top = 216
    ExplicitLeft = 141
    ExplicitTop = 216
  end
  inherited Panel1: TDNMPanel
    Top = 522
    Height = 43
    HelpContext = 898067
    ExplicitTop = 522
    ExplicitHeight = 43
    inherited Label189: TLabel
      Left = 22
      Top = 20
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 22
      ExplicitTop = 20
    end
    inherited BtnRefresh: TDNMSpeedButton
      Left = 423
      Top = 9
      Width = 93
      HelpContext = 898068
      ExplicitLeft = 423
      ExplicitTop = 9
      ExplicitWidth = 93
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 132
      Top = 9
      Width = 93
      HelpContext = 898069
      ExplicitLeft = 132
      ExplicitTop = 9
      ExplicitWidth = 93
    end
    inherited btnClose: TDNMSpeedButton
      Left = 714
      Top = 9
      Width = 93
      HelpContext = 898070
      ExplicitLeft = 714
      ExplicitTop = 9
      ExplicitWidth = 93
    end
    inherited btnOptions: TDNMSpeedButton
      Left = 229
      Top = 9
      Width = 93
      HelpContext = 898071
      ExplicitLeft = 229
      ExplicitTop = 9
      ExplicitWidth = 93
    end
    inherited chkActive: TwwCheckBox
      Left = 816
      Top = 2
      Anchors = [akRight, akBottom]
      ExplicitLeft = 816
      ExplicitTop = 2
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 520
      Top = 9
      Width = 93
      HelpContext = 898072
      ExplicitLeft = 520
      ExplicitTop = 9
      ExplicitWidth = 93
    end
    inherited chkChooseRpt: TCheckBox
      Left = 4
      Top = 19
      Anchors = [akLeft, akBottom]
      ExplicitLeft = 4
      ExplicitTop = 19
    end
    object btnElectronic: TDNMSpeedButton [8]
      Left = 326
      Top = 9
      Width = 93
      Height = 27
      HelpContext = 898065
      Anchors = [akRight, akBottom]
      Caption = 'Submit'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnElectronicClick
    end
    inherited wwCheckBox2: TwwCheckBox
      Left = 816
      Top = 20
      Anchors = [akRight, akBottom]
      TabOrder = 8
      OnClick = wwCheckBox2Click
      ExplicitLeft = 816
      ExplicitTop = 20
    end
    object btnGetObligations: TDNMSpeedButton
      Left = 617
      Top = 9
      Width = 93
      Height = 27
      HelpContext = 898073
      Anchors = [akBottom]
      Caption = 'Get Obligations'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      AutoDisableParentOnclick = True
      OnClick = btnGetObligationsClick
    end
  end
  inherited Tabmain: TPageControl
    Height = 487
    HelpContext = 898074
    ActivePage = tabVat
    TabWidth = 878
    ExplicitHeight = 487
    object tabVat: TTabSheet
      HelpContext = 898003
      Caption = 'VAT Return'
      Font.Charset = ANSI_CHARSET
      Font.Color = 8391127
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 874
        Height = 452
        HelpContext = 898004
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          874
          452)
        object Bevel9: TBevel
          Left = 14
          Top = 410
          Width = 849
          Height = 32
          HelpContext = 898005
        end
        object Bevel4: TBevel
          Left = 14
          Top = 373
          Width = 849
          Height = 32
          HelpContext = 898006
        end
        object Bevel8: TBevel
          Left = 14
          Top = 334
          Width = 849
          Height = 32
          HelpContext = 898007
        end
        object Bevel7: TBevel
          Left = 14
          Top = 294
          Width = 849
          Height = 32
          HelpContext = 898008
        end
        object Bevel6: TBevel
          Left = 14
          Top = 255
          Width = 849
          Height = 32
          HelpContext = 898009
        end
        object Bevel5: TBevel
          Left = 14
          Top = 216
          Width = 849
          Height = 32
          HelpContext = 898010
        end
        object Bevel10: TBevel
          Left = 14
          Top = 177
          Width = 849
          Height = 32
          HelpContext = 898011
        end
        object Bevel3: TBevel
          Left = 14
          Top = 138
          Width = 849
          Height = 32
          HelpContext = 898012
        end
        object Bevel1: TBevel
          Left = 14
          Top = 99
          Width = 849
          Height = 32
          HelpContext = 898013
        end
        object Label1: TLabel
          Left = 352
          Top = 109
          Width = 275
          Height = 15
          HelpContext = 898014
          Alignment = taRightJustify
          Caption = 'VAT due in this period on sales and other outputs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label2: TLabel
          Left = 246
          Top = 148
          Width = 381
          Height = 15
          HelpContext = 898015
          Alignment = taRightJustify
          Caption = 
            'VAT due in this period on acquisitions from other EC Member Stat' +
            'es'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label4: TLabel
          Left = 399
          Top = 187
          Width = 228
          Height = 15
          HelpContext = 898016
          Alignment = taRightJustify
          Caption = 'Total VAT due (the sum of boxes 1 and 2)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label5: TLabel
          Left = 664
          Top = 181
          Width = 32
          Height = 26
          HelpContext = 898017
          Alignment = taCenter
          Anchors = [akTop]
          AutoSize = False
          Caption = '3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
          Layout = tlCenter
        end
        object Label6: TLabel
          Left = 91
          Top = 226
          Width = 536
          Height = 15
          HelpContext = 898018
          Alignment = taRightJustify
          Caption = 
            'VAT reclaimed in this period on purchases and other inputs (incl' +
            'uding acquisitions from the EC)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label7: TLabel
          Left = 140
          Top = 265
          Width = 487
          Height = 15
          HelpContext = 898019
          Alignment = taRightJustify
          Caption = 
            'Net VAT to be paid to Customs or reclaimed by you (Difference be' +
            'tween boxes 3 and 4)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label3: TLabel
          Left = 663
          Top = 259
          Width = 32
          Height = 26
          HelpContext = 898020
          Alignment = taCenter
          Anchors = [akTop]
          AutoSize = False
          Caption = '5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
          Layout = tlCenter
        end
        object Label8: TLabel
          Left = 148
          Top = 304
          Width = 479
          Height = 15
          HelpContext = 898021
          Alignment = taRightJustify
          Caption = 
            'Total value of sales and all other outputs excluding any VAT.  I' +
            'nclude your box 8 figure'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label9: TLabel
          Left = 119
          Top = 344
          Width = 508
          Height = 15
          HelpContext = 898022
          Alignment = taRightJustify
          Caption = 
            'Total value of purchases and all other inputs excluding any VAT.' +
            ' Including your box 9 figure'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label10: TLabel
          Left = 62
          Top = 383
          Width = 565
          Height = 15
          HelpContext = 898023
          Alignment = taRightJustify
          Caption = 
            'Total value of all supplies of goods and related costs.  Excludi' +
            'ng any VAT. To other EC Member States'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label11: TLabel
          Left = 25
          Top = 420
          Width = 602
          Height = 15
          HelpContext = 898024
          Alignment = taRightJustify
          Caption = 
            'Total value of all acquisitions of goods and related costs.  Exc' +
            'luding any VAT. From other EC Member States'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lblMethod: TLabel
          Left = 15
          Top = 74
          Width = 235
          Height = 15
          HelpContext = 898025
          Caption = 'Accounting Method : Non-Cash (Accruals)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label12: TLabel
          Tag = 90
          Left = 726
          Top = 107
          Width = 9
          Height = 19
          HelpContext = 898026
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label13: TLabel
          Tag = 90
          Left = 726
          Top = 146
          Width = 9
          Height = 19
          HelpContext = 898027
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label14: TLabel
          Tag = 90
          Left = 726
          Top = 185
          Width = 9
          Height = 19
          HelpContext = 898028
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label15: TLabel
          Tag = 90
          Left = 726
          Top = 224
          Width = 9
          Height = 19
          HelpContext = 898029
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label16: TLabel
          Tag = 90
          Left = 726
          Top = 263
          Width = 9
          Height = 19
          HelpContext = 898030
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label17: TLabel
          Tag = 90
          Left = 726
          Top = 302
          Width = 9
          Height = 19
          HelpContext = 898031
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label18: TLabel
          Tag = 90
          Left = 726
          Top = 342
          Width = 9
          Height = 19
          HelpContext = 898032
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label19: TLabel
          Tag = 90
          Left = 726
          Top = 381
          Width = 9
          Height = 19
          HelpContext = 898033
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label20: TLabel
          Tag = 90
          Left = 726
          Top = 418
          Width = 9
          Height = 19
          HelpContext = 898034
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label22: TLabel
          Left = 1
          Top = 1
          Width = 872
          Height = 26
          HelpContext = 898035
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'VAT Return'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label25: TLabel
          Left = 268
          Top = 75
          Width = 97
          Height = 15
          HelpContext = 898075
          Caption = 'Obligation Period'
        end
        object Panel2: TPanel
          Left = 1
          Top = 27
          Width = 872
          Height = 43
          HelpContext = 898036
          Align = alTop
          BevelOuter = bvLowered
          Color = clWhite
          TabOrder = 0
          DesignSize = (
            872
            43)
          object YearLabel: TLabel
            Left = 593
            Top = 1
            Width = 78
            Height = 15
            HelpContext = 898037
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Current Year'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object MonthLabel: TLabel
            Left = 427
            Top = 1
            Width = 102
            Height = 15
            HelpContext = 898038
            Anchors = [akTop]
            Caption = 'Quarter beginning'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label21: TLabel
            Left = 748
            Top = 2
            Width = 78
            Height = 15
            HelpContext = 898039
            Caption = 'Period Ending'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Period: TwwRadioGroup
            Left = 1
            Top = 1
            Width = 328
            Height = 41
            HelpContext = 898040
            DisableThemes = False
            TransparentActiveItem = True
            Frame.Transparent = True
            ButtonFrame.Transparent = True
            ShowGroupCaption = False
            ShowFocusRect = False
            Transparent = True
            Align = alLeft
            Columns = 3
            DataField = 'Type'
            DataSource = dsReturns
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            Items.Strings = (
              'Quarterly'
              'Two Monthly'
              'Monthly')
            ParentFont = False
            TabOrder = 0
            OnChange = PeriodChange
          end
          object Month: TwwDBComboBox
            Left = 427
            Top = 17
            Width = 120
            Height = 24
            HelpContext = 898041
            Anchors = [akTop]
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'Month'
            DataSource = dsReturns
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 1
            UnboundDataType = wwDefault
          end
          object Year: TwwDBComboBox
            Left = 593
            Top = 17
            Width = 120
            Height = 24
            HelpContext = 898042
            Anchors = [akTop, akRight]
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'Year'
            DataSource = dsReturns
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              '2000'
              '2001'
              '2002'
              '2003'
              '2004'
              '2005'
              '2006'
              '2007'
              '2008'
              '2009'
              '2010'
              '2011'
              '2012'
              '2013'
              '2014'
              '2015'
              '2016'
              '2017'
              '2018'
              '2019'
              '2020')
            ParentFont = False
            Sorted = False
            TabOrder = 2
            UnboundDataType = wwDefault
          end
          object dtPeriodEnding: TwwDBDateTimePicker
            Left = 748
            Top = 18
            Width = 121
            Height = 23
            HelpContext = 898043
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'Tahoma'
            CalendarAttributes.Font.Style = []
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ShowButton = True
            TabOrder = 3
          end
          object chkSubmitted: TwwCheckBox
            Left = 335
            Top = 16
            Width = 86
            Height = 17
            HelpContext = 898076
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'T'
            DisplayValueUnchecked = 'F'
            NullAndBlankState = cbUnchecked
            Caption = 'Submitted'
            DataField = 'Submitted'
            DataSource = dsReturns
            TabOrder = 4
            ReadOnly = True
          end
        end
        object Button2: TDNMSpeedButton
          Left = 663
          Top = 103
          Width = 32
          Height = 26
          HelpContext = 898044
          Anchors = [akTop]
          Caption = '1'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ShadowColor = clBtnShadow
          SlowDecease = True
          TabOrder = 1
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = Button2Click
        end
        object VAT1: TDBEdit
          Tag = 91
          Left = 740
          Top = 105
          Width = 117
          Height = 23
          HelpContext = 898045
          Anchors = [akTop, akRight]
          DataField = 'VAT1'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = VAT1Change
          OnDblClick = TaxDblClick
        end
        object DNMSpeedButton1: TDNMSpeedButton
          Left = 664
          Top = 142
          Width = 32
          Height = 26
          HelpContext = 898046
          Anchors = [akTop]
          Caption = '2'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ShadowColor = clBtnShadow
          SlowDecease = True
          TabOrder = 3
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
        object VAT2: TDBEdit
          Tag = 91
          Left = 740
          Top = 144
          Width = 117
          Height = 23
          HelpContext = 898047
          Anchors = [akTop, akRight]
          DataField = 'VAT2'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = VAT1Change
          OnDblClick = TaxDblClick
        end
        object VAT3: TDBEdit
          Tag = 91
          Left = 740
          Top = 183
          Width = 117
          Height = 23
          HelpContext = 898048
          Anchors = [akTop, akRight]
          DataField = 'VAT3'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DNMSpeedButton2: TDNMSpeedButton
          Left = 664
          Top = 220
          Width = 32
          Height = 26
          HelpContext = 898049
          Anchors = [akTop]
          Caption = '4'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ShadowColor = clBtnShadow
          SlowDecease = True
          TabOrder = 6
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton2Click
        end
        object VAT4: TDBEdit
          Tag = 91
          Left = 740
          Top = 222
          Width = 117
          Height = 23
          HelpContext = 898050
          Anchors = [akTop, akRight]
          DataField = 'VAT4'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnChange = VAT1Change
          OnDblClick = TaxDblClick
        end
        object VAT5: TDBEdit
          Tag = 91
          Left = 740
          Top = 261
          Width = 117
          Height = 23
          HelpContext = 898051
          Anchors = [akTop, akRight]
          DataField = 'VAT5'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object DNMSpeedButton3: TDNMSpeedButton
          Left = 664
          Top = 298
          Width = 32
          Height = 26
          HelpContext = 898052
          Anchors = [akTop]
          Caption = '6'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ShadowColor = clBtnShadow
          SlowDecease = True
          TabOrder = 9
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton3Click
        end
        object VAT6: TDBEdit
          Tag = 91
          Left = 740
          Top = 300
          Width = 117
          Height = 23
          HelpContext = 898053
          Anchors = [akTop, akRight]
          DataField = 'VAT6'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnChange = VAT1Change
          OnDblClick = TaxDblClick
        end
        object DNMSpeedButton4: TDNMSpeedButton
          Left = 663
          Top = 338
          Width = 32
          Height = 26
          HelpContext = 898054
          Anchors = [akTop]
          Caption = '7'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ShadowColor = clBtnShadow
          SlowDecease = True
          TabOrder = 11
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton4Click
        end
        object VAT7: TDBEdit
          Tag = 91
          Left = 740
          Top = 340
          Width = 117
          Height = 23
          HelpContext = 898055
          Anchors = [akTop, akRight]
          DataField = 'VAT7'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          OnChange = VAT1Change
          OnDblClick = TaxDblClick
        end
        object DNMSpeedButton5: TDNMSpeedButton
          Left = 663
          Top = 377
          Width = 32
          Height = 26
          HelpContext = 898056
          Anchors = [akTop]
          Caption = '8'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ShadowColor = clBtnShadow
          SlowDecease = True
          TabOrder = 13
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton5Click
        end
        object VAT8: TDBEdit
          Tag = 91
          Left = 741
          Top = 379
          Width = 117
          Height = 23
          HelpContext = 898057
          Anchors = [akTop, akRight]
          DataField = 'VAT8'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          OnChange = VAT1Change
          OnDblClick = TaxDblClick
        end
        object DNMSpeedButton6: TDNMSpeedButton
          Left = 664
          Top = 414
          Width = 32
          Height = 26
          HelpContext = 898058
          Anchors = [akTop]
          Caption = '9'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ShadowColor = clBtnShadow
          SlowDecease = True
          TabOrder = 15
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton6Click
        end
        object VAT9: TDBEdit
          Tag = 91
          Left = 740
          Top = 416
          Width = 117
          Height = 23
          HelpContext = 898059
          Anchors = [akTop, akRight]
          DataField = 'VAT9'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          OnChange = VAT1Change
          OnDblClick = TaxDblClick
        end
        object pnlVAT_LastPeriod: TDNMPanel
          Left = 560
          Top = 69
          Width = 310
          Height = 31
          HelpContext = 898060
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 17
          DesignSize = (
            310
            31)
          object Label23: TLabel
            Left = 12
            Top = 7
            Width = 94
            Height = 15
            HelpContext = 898061
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Previous Return:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label24: TLabel
            Left = 199
            Top = 7
            Width = 16
            Height = 15
            HelpContext = 898062
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'To '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dtVAT_from: TwwDBDateTimePicker
            Left = 112
            Top = 3
            Width = 83
            Height = 23
            HelpContext = 898063
            Anchors = [akTop, akRight]
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'Tahoma'
            CalendarAttributes.Font.Style = []
            Date = 40858.000000000000000000
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            ShowButton = True
            TabOrder = 0
          end
          object dtVAT_To: TwwDBDateTimePicker
            Left = 219
            Top = 3
            Width = 83
            Height = 23
            HelpContext = 898064
            Anchors = [akTop, akRight]
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'Tahoma'
            CalendarAttributes.Font.Style = []
            Date = 40858.000000000000000000
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            ShowButton = True
            TabOrder = 1
          end
        end
        object cboPeriodKey: TwwDBLookupCombo
          Left = 371
          Top = 72
          Width = 177
          Height = 23
          HelpContext = 898077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Period'#9'21'#9'Period'#9'F'
            'Due'#9'10'#9'Due'#9#9)
          DataField = 'ObligationID'
          DataSource = dsReturns
          LookupTable = qryPeriodKeyLookup
          LookupField = 'ID'
          Options = [loTitles]
          ParentFont = False
          TabOrder = 18
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 292
    Top = 40
  end
  inherited tmrdelay: TTimer
    Left = 376
    Top = 24
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 232
    Top = 232
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 61
    Top = 24
  end
  inherited DataState: TDataState
    Left = 196
    Top = 232
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 176
  end
  inherited imgsort: TImageList
    Left = 96
    Top = 24
    Bitmap = {
      494C010102004C00840010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 254
    Top = 32
  end
  inherited tmrOnshow: TTimer
    Left = 504
    Top = 40
  end
  inherited QryReturns: TERPQuery
    SQL.Strings = (
      'select * from tblvatReturns')
    object QryReturnsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryReturnsID: TIntegerField
      FieldName = 'ID'
    end
    object QryReturnsVATDesc: TWideStringField
      FieldName = 'VATDesc'
      Size = 255
    end
    object QryReturnsType: TWideStringField
      FieldName = 'Type'
      Size = 50
    end
    object QryReturnsMonth: TWideStringField
      FieldName = 'Month'
      Size = 50
    end
    object QryReturnsYear: TIntegerField
      FieldName = 'Year'
    end
    object QryReturnsAccMethod: TWideStringField
      FieldName = 'AccMethod'
      FixedChar = True
      Size = 7
    end
    object QryReturnsAllClass: TWideStringField
      FieldName = 'AllClass'
      FixedChar = True
      Size = 1
    end
    object QryReturnsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object QryReturnsVAT1: TFloatField
      FieldName = 'VAT1'
    end
    object QryReturnsVAT1Selected: TWideStringField
      FieldName = 'VAT1Selected'
      Size = 50
    end
    object QryReturnsVAT2: TFloatField
      FieldName = 'VAT2'
    end
    object QryReturnsVAT2Selected: TWideStringField
      FieldName = 'VAT2Selected'
      Size = 50
    end
    object QryReturnsVAT3: TFloatField
      FieldName = 'VAT3'
    end
    object QryReturnsVAT3Selected: TWideStringField
      FieldName = 'VAT3Selected'
      Size = 50
    end
    object QryReturnsVAT4: TFloatField
      FieldName = 'VAT4'
    end
    object QryReturnsVAT4Selected: TWideStringField
      FieldName = 'VAT4Selected'
      Size = 50
    end
    object QryReturnsVAT5: TFloatField
      FieldName = 'VAT5'
    end
    object QryReturnsVAT5Selected: TWideStringField
      FieldName = 'VAT5Selected'
      Size = 50
    end
    object QryReturnsVAT6: TFloatField
      FieldName = 'VAT6'
    end
    object QryReturnsVAT6Selected: TWideStringField
      FieldName = 'VAT6Selected'
      Size = 50
    end
    object QryReturnsVAT7: TFloatField
      FieldName = 'VAT7'
    end
    object QryReturnsVAT7Selected: TWideStringField
      FieldName = 'VAT7Selected'
      Size = 50
    end
    object QryReturnsVAT8: TFloatField
      FieldName = 'VAT8'
    end
    object QryReturnsVAT8Selected: TWideStringField
      FieldName = 'VAT8Selected'
      Size = 50
    end
    object QryReturnsVAT9: TFloatField
      FieldName = 'VAT9'
    end
    object QryReturnsVAT9Selected: TWideStringField
      FieldName = 'VAT9Selected'
      Size = 255
    end
    object QryReturnsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QryReturnsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryReturnsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object QryReturnsDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object QryReturnsSummarisedTransDate: TDateField
      FieldName = 'SummarisedTransDate'
    end
    object QryReturnsSubmitted: TWideStringField
      FieldName = 'Submitted'
      FixedChar = True
      Size = 1
    end
    object QryReturnsObligationID: TIntegerField
      FieldName = 'ObligationID'
    end
  end
  inherited QryReturnLines: TERPQuery
    SQL.Strings = (
      'Select * from tblVatReportLines')
    Left = 83
    Top = 240
    object QryReturnLinesID: TIntegerField
      FieldName = 'ID'
    end
    object QryReturnLinesGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object QryReturnLinesVATID: TIntegerField
      FieldName = 'VATID'
    end
    object QryReturnLinesTransGlobalref: TWideStringField
      FieldName = 'TransGlobalref'
      Size = 255
    end
    object QryReturnLinesTranstype: TWideStringField
      FieldName = 'Transtype'
      Size = 100
    end
    object QryReturnLinesTransSeqno: TFloatField
      FieldName = 'TransSeqno'
    end
    object QryReturnLinesVATCode: TWideStringField
      FieldName = 'VATCode'
      Size = 10
    end
    object QryReturnLinesAmount: TFloatField
      FieldName = 'Amount'
    end
    object QryReturnLinesmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
    end
    object QryReturnLinesTransDate: TDateField
      FieldName = 'TransDate'
    end
  end
  object qryPeriodKeyLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'tblVATObligations.*,'
      'Concat(Start, " to ",End) as Period'
      'FROM tblVATObligations'
      
        'LEFT JOIN tblVATReturns ON tblVATReturns.ObligationID = tblVATOb' +
        'ligations.ID AND tblVATReturns.Active = "T"'
      
        'WHERE (ISNULL(tblVATReturns.ID) and tblVATObligations.Status = "' +
        'O")'
      'or tblVATReturns.ID = :VatReturnID')
    Left = 760
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'VatReturnID'
      end>
    object qryPeriodKeyLookupPeriod: TWideStringField
      DisplayWidth = 21
      FieldName = 'Period'
      Size = 21
    end
    object qryPeriodKeyLookupDue: TDateField
      DisplayWidth = 10
      FieldName = 'Due'
    end
    object qryPeriodKeyLookupGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPeriodKeyLookupID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object qryPeriodKeyLookupPeriodKey: TWideStringField
      FieldName = 'PeriodKey'
      Visible = False
      Size = 255
    end
    object qryPeriodKeyLookupStart: TDateField
      DisplayWidth = 10
      FieldName = 'Start'
      Visible = False
    end
    object qryPeriodKeyLookupEnd: TDateField
      DisplayWidth = 10
      FieldName = 'End'
      Visible = False
    end
    object qryPeriodKeyLookupReceived: TDateField
      FieldName = 'Received'
      Visible = False
    end
    object qryPeriodKeyLookupStatus: TWideStringField
      FieldName = 'Status'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPeriodKeyLookupActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPeriodKeyLookupmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object qryPeriodKeyLookupmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
end
