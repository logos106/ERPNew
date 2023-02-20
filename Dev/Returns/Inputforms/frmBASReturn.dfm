inherited fmBASReturn: TfmBASReturn
  Left = 453
  Top = 169
  HelpContext = 895001
  Caption = 'BAS Return'
  ClientHeight = 563
  ExplicitHeight = 592
  DesignSize = (
    882
    563)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 532
    ExplicitTop = 532
  end
  inherited pnltop: TDNMPanel
    Height = 34
    HelpContext = 895279
    ExplicitHeight = 34
    inherited Label202: TLabel
      Top = 9
      ExplicitTop = 9
    end
    inherited lblreturnno: TLabel
      Top = 9
      ExplicitTop = 9
    end
    object Bevel1: TBevel [2]
      Left = 325
      Top = 4
      Width = 407
      Height = 24
      HelpContext = 895280
    end
    object Label164: TLabel [3]
      Left = 281
      Top = 9
      Width = 41
      Height = 15
      HelpContext = 895340
      Caption = 'Enable '
    end
    inherited edtDescription: TwwDBEdit
      Left = 87
      Top = 5
      Width = 171
      HelpContext = 895281
      DataField = 'BasSheetDesc'
      ExplicitLeft = 87
      ExplicitTop = 5
      ExplicitWidth = 171
    end
    inherited wwDBEdit1: TwwDBEdit
      Top = 5
      ExplicitTop = 5
    end
    object chkHasTab1: TwwCheckBox
      Left = 327
      Top = 8
      Width = 50
      Height = 17
      HelpContext = 895282
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'GST'
      Color = clBtnFace
      DataField = 'HasTab1'
      DataSource = dsReturns
      ParentColor = False
      TabOrder = 2
      OnClick = chkHasTab1Click
    end
    object chkHasTab2: TwwCheckBox
      Left = 383
      Top = 8
      Width = 106
      Height = 17
      HelpContext = 895283
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'PAYG Withheld'
      DataField = 'HasTab2'
      DataSource = dsReturns
      TabOrder = 3
      OnClick = chkHasTab2Click
    end
    object chkHasTab3: TwwCheckBox
      Left = 495
      Top = 8
      Width = 116
      Height = 17
      HelpContext = 895284
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'PAYG Instalment'
      DataField = 'HasTab3'
      DataSource = dsReturns
      TabOrder = 4
      OnClick = chkHasTab3Click
    end
    object chkHAsTab4: TwwCheckBox
      Left = 610
      Top = 8
      Width = 118
      Height = 17
      HelpContext = 895341
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Wine And Luxury'
      DataField = 'HasTab4'
      DataSource = dsReturns
      TabOrder = 5
      OnClick = chkHAsTab4Click
    end
  end
  inherited memsummaryreturn: TMemo
    Left = 227
    Top = 512
    ExplicitLeft = 227
    ExplicitTop = 512
  end
  inherited Panel1: TDNMPanel
    Top = 532
    HelpContext = 895342
    TabOrder = 1
    ExplicitTop = 532
    inherited BtnRefresh: TDNMSpeedButton
      Top = 3
      ExplicitTop = 3
    end
  end
  inherited Tabmain: TPageControl
    Top = 34
    Height = 498
    HelpContext = 895002
    ActivePage = tabSuppAndAcq
    TabOrder = 0
    TabWidth = 219
    ExplicitTop = 34
    ExplicitHeight = 498
    object tabSuppAndAcq: TTabSheet
      HelpContext = 895003
      Caption = 'Supplies and &Acquisitions'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8391127
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object Label72: TLabel
        Left = 0
        Top = 0
        Width = 874
        Height = 19
        HelpContext = 895004
        Align = alTop
        Alignment = taCenter
        Caption = 'Calculation Sheet - Supplies && Acquisitions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitWidth = 328
      end
      object pnlGST: TDNMPanel
        Left = 0
        Top = 19
        Width = 874
        Height = 444
        HelpContext = 895005
        Align = alClient
        Color = 13487565
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object Bevel9: TBevel
          Left = 10
          Top = 100
          Width = 345
          Height = 331
          HelpContext = 895006
        end
        object Bevel18: TBevel
          Left = 357
          Top = 100
          Width = 512
          Height = 331
          HelpContext = 895007
          Touch.ParentTabletOptions = False
          Touch.TabletOptions = [toPressAndHold]
        end
        object Label98: TLabel
          Left = 486
          Top = 430
          Width = 346
          Height = 16
          HelpContext = 895008
          AutoSize = False
          Caption = 
            'The amount at G20 is your GST credit. This amount is transferred' +
            ' to 1B'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label97: TLabel
          Left = 10
          Top = 430
          Width = 348
          Height = 16
          HelpContext = 895009
          AutoSize = False
          Caption = 
            'The amount at G9 is your GST payable. This amount is transferred' +
            ' to 1A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label96: TLabel
          Left = 579
          Top = 410
          Width = 102
          Height = 14
          HelpContext = 895010
          Alignment = taRightJustify
          Caption = 'Divide G19 by Eleven'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label25: TLabel
          Left = 691
          Top = 404
          Width = 32
          Height = 26
          HelpContext = 895011
          Alignment = taCenter
          AutoSize = False
          Caption = 'G20'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label20: TLabel
          Tag = 90
          Left = 748
          Top = 408
          Width = 9
          Height = 19
          HelpContext = 895012
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label18: TLabel
          Tag = 90
          Left = 748
          Top = 378
          Width = 9
          Height = 19
          HelpContext = 895013
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label26: TLabel
          Left = 691
          Top = 374
          Width = 32
          Height = 26
          HelpContext = 895014
          Alignment = taCenter
          AutoSize = False
          Caption = 'G19'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label95: TLabel
          Left = 424
          Top = 380
          Width = 257
          Height = 14
          HelpContext = 895015
          Alignment = taRightJustify
          Caption = 'Total of your creditable acquisitions after adjustments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label94: TLabel
          Left = 621
          Top = 350
          Width = 60
          Height = 14
          HelpContext = 895016
          Alignment = taRightJustify
          Caption = 'Adjustments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label17: TLabel
          Tag = 90
          Left = 748
          Top = 348
          Width = 9
          Height = 19
          HelpContext = 895017
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label16: TLabel
          Tag = 90
          Left = 748
          Top = 318
          Width = 9
          Height = 19
          HelpContext = 895018
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label27: TLabel
          Left = 691
          Top = 314
          Width = 32
          Height = 26
          HelpContext = 895019
          Alignment = taCenter
          AutoSize = False
          Caption = 'G17'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label93: TLabel
          Left = 536
          Top = 320
          Width = 145
          Height = 14
          HelpContext = 895020
          Alignment = taRightJustify
          Caption = 'Total of creditable acquisitions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label92: TLabel
          Left = 493
          Top = 290
          Width = 192
          Height = 14
          HelpContext = 895021
          Alignment = taRightJustify
          Caption = 'Total of your non-creditable acquisitions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label28: TLabel
          Left = 691
          Top = 284
          Width = 32
          Height = 26
          HelpContext = 895022
          Alignment = taCenter
          AutoSize = False
          Caption = 'G16'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label15: TLabel
          Tag = 90
          Left = 748
          Top = 288
          Width = 9
          Height = 19
          HelpContext = 895023
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label14: TLabel
          Tag = 90
          Left = 748
          Top = 258
          Width = 9
          Height = 19
          HelpContext = 895024
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label91: TLabel
          Left = 384
          Top = 260
          Width = 297
          Height = 14
          HelpContext = 895025
          Alignment = taRightJustify
          Caption = 'Total of estimated private use of acquisitions + non-deductible'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label90: TLabel
          Left = 503
          Top = 230
          Width = 178
          Height = 14
          HelpContext = 895026
          Alignment = taRightJustify
          Caption = 'Acquisitions with no GST in the price'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label13: TLabel
          Tag = 90
          Left = 748
          Top = 228
          Width = 9
          Height = 19
          HelpContext = 895027
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label12: TLabel
          Tag = 90
          Left = 748
          Top = 198
          Width = 9
          Height = 19
          HelpContext = 895028
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label89: TLabel
          Left = 362
          Top = 200
          Width = 325
          Height = 14
          HelpContext = 895029
          Alignment = taRightJustify
          Caption = 
            'Acquisitions for making input taxed sales && income && other sup' +
            'plies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label88: TLabel
          Left = 566
          Top = 170
          Width = 120
          Height = 14
          HelpContext = 895030
          Alignment = taRightJustify
          Caption = 'Total of your acquisitions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label29: TLabel
          Left = 692
          Top = 164
          Width = 32
          Height = 26
          HelpContext = 895031
          Alignment = taCenter
          AutoSize = False
          Caption = 'G12'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label11: TLabel
          Tag = 90
          Left = 748
          Top = 168
          Width = 9
          Height = 19
          HelpContext = 895032
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label10: TLabel
          Tag = 90
          Left = 748
          Top = 138
          Width = 9
          Height = 19
          HelpContext = 895033
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label87: TLabel
          Left = 594
          Top = 140
          Width = 87
          Height = 14
          HelpContext = 895034
          Alignment = taRightJustify
          Caption = 'Other acquisitions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label86: TLabel
          Left = 589
          Top = 110
          Width = 92
          Height = 14
          HelpContext = 895035
          Alignment = taRightJustify
          Caption = 'Capital acquisitions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label19: TLabel
          Tag = 90
          Left = 748
          Top = 108
          Width = 9
          Height = 19
          HelpContext = 895036
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label99: TLabel
          Left = 463
          Top = 85
          Width = 318
          Height = 15
          HelpContext = 895037
          Caption = 'Amounts G1,G7,G10,G11,G13,G15 & G18 are GST inclusive'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label100: TLabel
          Left = 452
          Top = 66
          Width = 338
          Height = 15
          HelpContext = 895038
          Caption = 
            '                              Acquisitions you have made        ' +
            '                      '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Label9: TLabel
          Tag = 90
          Left = 234
          Top = 402
          Width = 9
          Height = 19
          HelpContext = 895039
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label23: TLabel
          Left = 177
          Top = 398
          Width = 32
          Height = 26
          HelpContext = 895040
          Alignment = taCenter
          AutoSize = False
          Caption = 'G9'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label85: TLabel
          Left = 57
          Top = 397
          Width = 112
          Height = 28
          HelpContext = 895041
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Divide G8 by Eleven'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label84: TLabel
          Left = 29
          Top = 360
          Width = 140
          Height = 28
          HelpContext = 895042
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total of your taxable supplies after adjustments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label24: TLabel
          Left = 177
          Top = 361
          Width = 32
          Height = 26
          HelpContext = 895043
          Alignment = taCenter
          AutoSize = False
          Caption = 'G8'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label8: TLabel
          Tag = 90
          Left = 234
          Top = 365
          Width = 9
          Height = 19
          HelpContext = 895044
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label7: TLabel
          Tag = 90
          Left = 234
          Top = 329
          Width = 9
          Height = 19
          HelpContext = 895045
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label83: TLabel
          Left = 57
          Top = 324
          Width = 112
          Height = 28
          HelpContext = 895046
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Adjustments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label82: TLabel
          Left = 57
          Top = 287
          Width = 112
          Height = 28
          HelpContext = 895047
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total of your taxable supplies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label22: TLabel
          Left = 177
          Top = 288
          Width = 32
          Height = 26
          HelpContext = 895048
          Alignment = taCenter
          AutoSize = False
          Caption = 'G6'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label6: TLabel
          Tag = 90
          Left = 234
          Top = 292
          Width = 9
          Height = 19
          HelpContext = 895049
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label5: TLabel
          Tag = 90
          Left = 234
          Top = 256
          Width = 9
          Height = 19
          HelpContext = 895050
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label21: TLabel
          Left = 177
          Top = 252
          Width = 32
          Height = 26
          HelpContext = 895051
          Alignment = taCenter
          AutoSize = False
          Caption = 'G5'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label81: TLabel
          Left = 23
          Top = 251
          Width = 146
          Height = 28
          HelpContext = 895052
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total of your GST-free and input taxed supplies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label80: TLabel
          Left = 39
          Top = 214
          Width = 130
          Height = 28
          HelpContext = 895053
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Input Taxed Sales && income && other suppliers'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label4: TLabel
          Tag = 90
          Left = 234
          Top = 219
          Width = 9
          Height = 19
          HelpContext = 895054
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label3: TLabel
          Tag = 90
          Left = 234
          Top = 183
          Width = 9
          Height = 19
          HelpContext = 895055
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label79: TLabel
          Left = 57
          Top = 178
          Width = 112
          Height = 28
          HelpContext = 895056
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Other GST-Free supplies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label78: TLabel
          Left = 57
          Top = 141
          Width = 112
          Height = 28
          HelpContext = 895057
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Exports'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label2: TLabel
          Tag = 90
          Left = 234
          Top = 146
          Width = 9
          Height = 19
          HelpContext = 895058
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label77: TLabel
          Left = 57
          Top = 105
          Width = 112
          Height = 28
          HelpContext = 895059
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total sales && income && other supplies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label1: TLabel
          Tag = 90
          Left = 234
          Top = 110
          Width = 9
          Height = 19
          HelpContext = 895060
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label76: TLabel
          Left = 81
          Top = 85
          Width = 251
          Height = 15
          HelpContext = 895061
          AutoSize = False
          Caption = 'GST Accounting Method Non-Cash (Accruals)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label75: TLabel
          Left = 81
          Top = 65
          Width = 251
          Height = 15
          HelpContext = 895062
          AutoSize = False
          Caption = '                   Supplies you have made                   '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object Bevel6: TBevel
          Left = 9
          Top = 30
          Width = 862
          Height = 33
          HelpContext = 895063
        end
        object MonthLabel: TLabel
          Left = 202
          Top = 40
          Width = 102
          Height = 15
          HelpContext = 895064
          Alignment = taRightJustify
          Caption = 'Quarter beginning'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object YearLabel: TLabel
          Left = 430
          Top = 40
          Width = 78
          Height = 15
          HelpContext = 895065
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Current Year'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label74: TLabel
          Left = 662
          Top = 40
          Width = 78
          Height = 15
          HelpContext = 895066
          Alignment = taRightJustify
          Caption = 'Period Ending'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label73: TLabel
          Left = 10
          Top = 14
          Width = 213
          Height = 15
          HelpContext = 895067
          Caption = 'Goods and Services tax for the period'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object G20: TDBEdit
          Tag = 91
          Left = 761
          Top = 405
          Width = 102
          Height = 24
          HelpContext = 895068
          TabStop = False
          Color = 13494001
          DataField = 'G20'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object G19: TDBEdit
          Tag = 91
          Left = 761
          Top = 375
          Width = 102
          Height = 24
          HelpContext = 895069
          TabStop = False
          Color = 13494001
          DataField = 'G19'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object btn18: TDNMSpeedButton
          Left = 691
          Top = 344
          Width = 32
          Height = 26
          HelpContext = 895070
          Caption = 'G18'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 2
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn18Click
        end
        object G18: TDBEdit
          Tag = 91
          Left = 761
          Top = 345
          Width = 102
          Height = 24
          HelpContext = 895071
          DataField = 'G18'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnDblClick = TaxDblClick
        end
        object G17: TDBEdit
          Tag = 91
          Left = 761
          Top = 315
          Width = 102
          Height = 24
          HelpContext = 895072
          TabStop = False
          Color = 13494001
          DataField = 'G17'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object G16: TDBEdit
          Tag = 91
          Left = 761
          Top = 285
          Width = 102
          Height = 24
          HelpContext = 895073
          TabStop = False
          Color = 13494001
          DataField = 'G16'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object G15: TDBEdit
          Tag = 91
          Left = 763
          Top = 255
          Width = 102
          Height = 24
          HelpContext = 895074
          DataField = 'G15'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnDblClick = TaxDblClick
        end
        object btn15: TDNMSpeedButton
          Left = 691
          Top = 254
          Width = 32
          Height = 26
          HelpContext = 895075
          Caption = 'G15'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 7
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn15Click
        end
        object btn14: TDNMSpeedButton
          Left = 691
          Top = 224
          Width = 32
          Height = 26
          HelpContext = 895076
          Caption = 'G14'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 8
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn14Click
        end
        object G14: TDBEdit
          Tag = 91
          Left = 761
          Top = 225
          Width = 102
          Height = 24
          HelpContext = 895077
          DataField = 'G14'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnDblClick = TaxDblClick
        end
        object G13: TDBEdit
          Tag = 91
          Left = 761
          Top = 195
          Width = 102
          Height = 24
          HelpContext = 895078
          DataField = 'G13'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnDblClick = TaxDblClick
        end
        object btn13: TDNMSpeedButton
          Left = 691
          Top = 194
          Width = 32
          Height = 26
          HelpContext = 895079
          Caption = 'G13'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 11
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn13Click
        end
        object G12: TDBEdit
          Tag = 91
          Left = 761
          Top = 165
          Width = 102
          Height = 24
          HelpContext = 895080
          TabStop = False
          Color = 13494001
          DataField = 'G12'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
        end
        object G11: TDBEdit
          Tag = 91
          Left = 761
          Top = 135
          Width = 102
          Height = 24
          HelpContext = 895081
          DataField = 'G11'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          OnDblClick = TaxDblClick
        end
        object btn11: TDNMSpeedButton
          Left = 691
          Top = 134
          Width = 32
          Height = 26
          HelpContext = 895082
          Caption = 'G11'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 14
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn11Click
        end
        object btn20: TDNMSpeedButton
          Left = 691
          Top = 104
          Width = 32
          Height = 26
          HelpContext = 895083
          Caption = 'G10'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 15
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn20Click
        end
        object G10: TDBEdit
          Tag = 91
          Left = 761
          Top = 105
          Width = 102
          Height = 24
          HelpContext = 895084
          DataField = 'G10'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          OnDblClick = TaxDblClick
        end
        object G9: TDBEdit
          Tag = 91
          Left = 247
          Top = 399
          Width = 102
          Height = 24
          HelpContext = 895085
          TabStop = False
          Color = 13494001
          DataField = 'G9'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 17
        end
        object G8: TDBEdit
          Tag = 91
          Left = 247
          Top = 362
          Width = 102
          Height = 24
          HelpContext = 895086
          TabStop = False
          Color = 13494001
          DataField = 'G8'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
        end
        object G7: TDBEdit
          Tag = 91
          Left = 247
          Top = 326
          Width = 102
          Height = 24
          HelpContext = 895087
          DataField = 'G7'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
          OnDblClick = TaxDblClick
        end
        object btn8: TDNMSpeedButton
          Left = 177
          Top = 325
          Width = 32
          Height = 26
          HelpContext = 895088
          Caption = 'G7'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 20
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn8Click
        end
        object G6: TDBEdit
          Tag = 91
          Left = 247
          Top = 289
          Width = 102
          Height = 24
          HelpContext = 895089
          TabStop = False
          Color = 13494001
          DataField = 'G6'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
        end
        object G5: TDBEdit
          Tag = 91
          Left = 247
          Top = 253
          Width = 102
          Height = 24
          HelpContext = 895090
          TabStop = False
          Color = 13494001
          DataField = 'G5'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 22
        end
        object btn5: TDNMSpeedButton
          Left = 177
          Top = 215
          Width = 32
          Height = 26
          HelpContext = 895091
          Caption = 'G4'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 23
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn5Click
        end
        object G4: TDBEdit
          Tag = 91
          Left = 247
          Top = 216
          Width = 102
          Height = 24
          HelpContext = 895092
          DataField = 'G4'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 24
          OnDblClick = TaxDblClick
        end
        object G3: TDBEdit
          Tag = 91
          Left = 247
          Top = 180
          Width = 102
          Height = 24
          HelpContext = 895093
          DataField = 'G3'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 25
          OnDblClick = TaxDblClick
        end
        object btn4: TDNMSpeedButton
          Left = 177
          Top = 179
          Width = 32
          Height = 26
          HelpContext = 895094
          Caption = 'G3'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 26
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn4Click
        end
        object btn3: TDNMSpeedButton
          Left = 177
          Top = 142
          Width = 32
          Height = 26
          HelpContext = 895095
          Caption = 'G2'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 27
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn3Click
        end
        object G2: TDBEdit
          Tag = 91
          Left = 247
          Top = 143
          Width = 102
          Height = 24
          HelpContext = 895096
          DataField = 'G2'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 28
          OnDblClick = TaxDblClick
        end
        object btn2: TDNMSpeedButton
          Left = 177
          Top = 106
          Width = 32
          Height = 26
          HelpContext = 895097
          Caption = 'G1'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 29
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn2Click
        end
        object G1: TDBEdit
          Tag = 91
          Left = 247
          Top = 107
          Width = 102
          Height = 24
          HelpContext = 895098
          DataField = 'G1'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 30
          OnDblClick = TaxDblClick
        end
        object Period: TwwRadioGroup
          Left = 11
          Top = 37
          Width = 176
          Height = 20
          HelpContext = 895099
          DisableThemes = False
          Frame.Transparent = True
          ButtonFrame.Transparent = True
          ShowGroupCaption = False
          ShowFocusRect = False
          Columns = 2
          DataField = 'Tab1_Type'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Items.Strings = (
            'Quarterly'
            'Monthly')
          ParentFont = False
          TabOrder = 31
          OnChange = PeriodChange
        end
        object Tab1_Month: TwwDBComboBox
          Left = 310
          Top = 35
          Width = 120
          Height = 24
          HelpContext = 895100
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab1_Month'
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
          TabOrder = 32
          UnboundDataType = wwDefault
          OnCloseUp = Tab1_MonthCloseUp
        end
        object Tab1_Year: TwwDBComboBox
          Left = 510
          Top = 35
          Width = 120
          Height = 24
          HelpContext = 895101
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab1_Year'
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
          TabOrder = 33
          UnboundDataType = wwDefault
        end
        object dtTab_1PeriodEnding: TwwDBDateTimePicker
          Left = 746
          Top = 36
          Width = 121
          Height = 23
          HelpContext = 895102
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
          TabOrder = 34
        end
        object pnlTab1_LastPeriod: TDNMPanel
          Left = 566
          Top = 0
          Width = 306
          Height = 31
          HelpContext = 895103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 35
          DesignSize = (
            306
            31)
          object Label121: TLabel
            Left = 6
            Top = 8
            Width = 94
            Height = 15
            HelpContext = 895104
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Previous Return:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 20
          end
          object Label122: TLabel
            Left = 193
            Top = 8
            Width = 16
            Height = 15
            HelpContext = 895105
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'To '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 207
          end
          object dtTab1_from: TwwDBDateTimePicker
            Left = 106
            Top = 4
            Width = 83
            Height = 23
            HelpContext = 895106
            Anchors = [akTop, akRight]
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
            TabOrder = 0
          end
          object dtTab1_To: TwwDBDateTimePicker
            Left = 213
            Top = 4
            Width = 83
            Height = 23
            HelpContext = 895107
            Anchors = [akTop, akRight]
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
            TabOrder = 1
          end
        end
      end
    end
    object tabTaxandWithheld: TTabSheet
      HelpContext = 895108
      Caption = 'Ta&xes and Amounts Withheld'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object Label31: TLabel
        Tag = 90
        Left = 262
        Top = 134
        Width = 9
        Height = 19
        HelpContext = 895109
        Alignment = taRightJustify
        Caption = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label101: TLabel
        Left = 0
        Top = 0
        Width = 874
        Height = 19
        HelpContext = 895110
        Align = alTop
        Alignment = taCenter
        Caption = 'Calculation Sheet - Taxes && Amounts Withheld'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitWidth = 351
      end
      object pnlTaxandWithheld: TDNMPanel
        Left = 0
        Top = 19
        Width = 874
        Height = 171
        HelpContext = 895111
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel2: TBevel
          Left = 35
          Top = 70
          Width = 369
          Height = 39
          HelpContext = 895112
          Shape = bsFrame
        end
        object Label117: TLabel
          Left = 271
          Top = 151
          Width = 323
          Height = 15
          HelpContext = 895113
          Alignment = taCenter
          Caption = 'The total of W2+W3+W4 is automatically entered into field 4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label32: TLabel
          Tag = 90
          Left = 702
          Top = 119
          Width = 9
          Height = 19
          HelpContext = 895114
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label110: TLabel
          Left = 432
          Top = 114
          Width = 187
          Height = 29
          HelpContext = 895115
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Amounts withheld from payment of invoices where no ABN is quoted'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label109: TLabel
          Left = 424
          Top = 73
          Width = 199
          Height = 29
          HelpContext = 895116
          Alignment = taRightJustify
          AutoSize = False
          Caption = 
            'Amounts withheld from investment distributions where no TFN is q' +
            'uoted'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label33: TLabel
          Tag = 90
          Left = 702
          Top = 80
          Width = 9
          Height = 19
          HelpContext = 895117
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label104: TLabel
          Left = 23
          Top = 114
          Width = 172
          Height = 29
          HelpContext = 895118
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Amounts withheld from salary, wages, and other payments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label103: TLabel
          Left = 71
          Top = 75
          Width = 124
          Height = 29
          HelpContext = 895119
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total of salary, wages, and other payments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label30: TLabel
          Tag = 90
          Left = 262
          Top = 80
          Width = 9
          Height = 19
          HelpContext = 895120
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Bevel7: TBevel
          Left = 5
          Top = 30
          Width = 867
          Height = 33
          HelpContext = 895121
        end
        object MonthLabel2: TLabel
          Left = 206
          Top = 39
          Width = 102
          Height = 15
          HelpContext = 895122
          Alignment = taRightJustify
          Caption = 'Quarter beginning'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object YearLabel2: TLabel
          Left = 432
          Top = 40
          Width = 78
          Height = 15
          HelpContext = 895123
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Current Year'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label120: TLabel
          Left = 662
          Top = 39
          Width = 78
          Height = 15
          HelpContext = 895124
          Alignment = taRightJustify
          Caption = 'Period Ending'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label102: TLabel
          Left = 5
          Top = 15
          Width = 228
          Height = 15
          HelpContext = 895125
          Alignment = taCenter
          AutoSize = False
          Caption = 'Pay As You Go withholding for the period'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label160: TLabel
          Tag = 90
          Left = 262
          Top = 119
          Width = 9
          Height = 19
          HelpContext = 895126
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object W4: TDBEdit
          Tag = 91
          Left = 715
          Top = 116
          Width = 102
          Height = 24
          HelpContext = 895127
          DataField = 'W4'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnDblClick = AccDblClick
        end
        object btn9: TDNMSpeedButton
          Left = 645
          Top = 115
          Width = 32
          Height = 27
          HelpContext = 895128
          Caption = 'W4'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn9Click
        end
        object btn10: TDNMSpeedButton
          Left = 645
          Top = 76
          Width = 32
          Height = 27
          HelpContext = 895129
          Caption = 'W3'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 2
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn10Click
        end
        object W3: TDBEdit
          Tag = 91
          Left = 715
          Top = 77
          Width = 102
          Height = 24
          HelpContext = 895130
          DataField = 'W3'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnDblClick = AccDblClick
        end
        object W2: TDBEdit
          Tag = 91
          Left = 278
          Top = 116
          Width = 102
          Height = 24
          HelpContext = 895131
          DataField = 'W2'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnDblClick = AccDblClick
        end
        object btn7: TDNMSpeedButton
          Left = 205
          Top = 115
          Width = 32
          Height = 27
          HelpContext = 895132
          Caption = 'W2'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 5
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn7Click
        end
        object btn6: TDNMSpeedButton
          Left = 205
          Top = 76
          Width = 32
          Height = 27
          HelpContext = 895133
          Caption = 'W1'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 6
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn6Click
        end
        object W1: TDBEdit
          Tag = 91
          Left = 277
          Top = 77
          Width = 102
          Height = 24
          HelpContext = 895134
          DataField = 'W1'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnDblClick = AccDblClick
        end
        object Period2: TwwRadioGroup
          Left = 16
          Top = 36
          Width = 176
          Height = 22
          HelpContext = 895135
          DisableThemes = False
          TransparentActiveItem = True
          Frame.Transparent = True
          ButtonFrame.Transparent = True
          ShowGroupCaption = False
          ShowFocusRect = False
          Columns = 2
          DataField = 'Tab2_Type'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Items.Strings = (
            'Quarterly'
            'Monthly')
          ParentFont = False
          TabOrder = 8
          OnChange = Period2Change
        end
        object Tab2_Month: TwwDBComboBox
          Left = 314
          Top = 34
          Width = 120
          Height = 23
          HelpContext = 895136
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab2_Month'
          DataSource = dsReturns
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 9
          UnboundDataType = wwDefault
          OnCloseUp = Tab2_MonthCloseUp
        end
        object Tab2_Year: TwwDBComboBox
          Left = 514
          Top = 34
          Width = 89
          Height = 23
          HelpContext = 895137
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab2_Year'
          DataSource = dsReturns
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
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
          TabOrder = 10
          UnboundDataType = wwDefault
        end
        object dtTab_2PeriodEnding: TwwDBDateTimePicker
          Left = 746
          Top = 34
          Width = 121
          Height = 23
          HelpContext = 895138
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
          TabOrder = 11
        end
        object pnlTab2_LastPeriod: TDNMPanel
          Left = 565
          Top = 0
          Width = 307
          Height = 31
          HelpContext = 895139
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          DesignSize = (
            307
            31)
          object Label155: TLabel
            Left = 9
            Top = 10
            Width = 94
            Height = 15
            HelpContext = 895140
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Previous Return:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = -16
          end
          object Label156: TLabel
            Left = 196
            Top = 10
            Width = 16
            Height = 15
            HelpContext = 895141
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'To '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 171
          end
          object dtTab2_from: TwwDBDateTimePicker
            Left = 109
            Top = 6
            Width = 83
            Height = 23
            HelpContext = 895142
            Anchors = [akTop, akRight]
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
            TabOrder = 0
          end
          object dtTab2_To: TwwDBDateTimePicker
            Left = 216
            Top = 6
            Width = 83
            Height = 23
            HelpContext = 895143
            Anchors = [akTop, akRight]
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
            TabOrder = 1
          end
        end
      end
      object pnlInstallment: TDNMPanel
        Left = 0
        Top = 190
        Width = 874
        Height = 273
        HelpContext = 895144
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label115: TLabel
          Left = 13
          Top = 15
          Width = 223
          Height = 16
          HelpContext = 895145
          Alignment = taCenter
          AutoSize = False
          Caption = 'Pay As You Go instalment for the period'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Bevel8: TBevel
          Left = 14
          Top = 31
          Width = 850
          Height = 33
          HelpContext = 895146
        end
        object MonthLabel3: TLabel
          Left = 206
          Top = 41
          Width = 102
          Height = 15
          HelpContext = 895147
          Alignment = taRightJustify
          Caption = 'Quarter beginning'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object YearLabel3: TLabel
          Left = 440
          Top = 39
          Width = 78
          Height = 15
          HelpContext = 895148
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Current Year'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label157: TLabel
          Left = 656
          Top = 41
          Width = 78
          Height = 15
          HelpContext = 895149
          Alignment = taRightJustify
          Caption = 'Period Ending'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label105: TLabel
          Left = 92
          Top = 70
          Width = 112
          Height = 29
          HelpContext = 895150
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Instalment income'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label106: TLabel
          Left = 92
          Top = 101
          Width = 112
          Height = 29
          HelpContext = 895151
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Commissioner'#39's / varied instalment rate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label38: TLabel
          Left = 214
          Top = 102
          Width = 32
          Height = 27
          HelpContext = 895152
          Alignment = taCenter
          AutoSize = False
          Caption = 'T2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label34: TLabel
          Tag = 90
          Left = 271
          Top = 73
          Width = 9
          Height = 19
          HelpContext = 895153
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label35: TLabel
          Left = 390
          Top = 105
          Width = 32
          Height = 27
          HelpContext = 895154
          Alignment = taCenter
          AutoSize = False
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label118: TLabel
          Left = 258
          Top = 134
          Width = 380
          Height = 15
          HelpContext = 895155
          Alignment = taCenter
          Caption = 
            'The Pay As You Go instalment is automatically transferred into f' +
            'ield 5A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label112: TLabel
          Left = 490
          Top = 100
          Width = 112
          Height = 29
          HelpContext = 895156
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Reason for variation'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label111: TLabel
          Left = 461
          Top = 67
          Width = 141
          Height = 29
          HelpContext = 895157
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'New varied instalment rate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label39: TLabel
          Left = 625
          Top = 67
          Width = 32
          Height = 27
          HelpContext = 895158
          Alignment = taCenter
          AutoSize = False
          Caption = 'T3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label40: TLabel
          Left = 626
          Top = 101
          Width = 32
          Height = 27
          HelpContext = 895159
          Alignment = taCenter
          AutoSize = False
          Caption = 'T4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label37: TLabel
          Left = 774
          Top = 67
          Width = 32
          Height = 27
          HelpContext = 895160
          Alignment = taCenter
          AutoSize = False
          Caption = '%'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Bevel3: TBevel
          Left = 22
          Top = 151
          Width = 841
          Height = 7
          HelpContext = 895161
          Shape = bsFrame
        end
        object Label116: TLabel
          Left = 329
          Top = 161
          Width = 247
          Height = 16
          HelpContext = 895162
          Alignment = taCenter
          AutoSize = False
          Caption = 'Fringe benefits tax instalment for the period'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object DateLabel2: TLabel
          Left = 639
          Top = 165
          Width = 143
          Height = 15
          HelpContext = 895163
          Caption = '01/07/2001 to 1/07/2002   '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label107: TLabel
          Left = 64
          Top = 184
          Width = 140
          Height = 29
          HelpContext = 895164
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ATO-calculated fringe benefits tax instalment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label46: TLabel
          Left = 214
          Top = 185
          Width = 32
          Height = 27
          HelpContext = 895165
          Alignment = taCenter
          AutoSize = False
          Caption = 'F1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label36: TLabel
          Tag = 90
          Left = 271
          Top = 189
          Width = 9
          Height = 19
          HelpContext = 895166
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label113: TLabel
          Left = 442
          Top = 184
          Width = 123
          Height = 29
          HelpContext = 895167
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Varied fringe benefits tax instalment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label44: TLabel
          Left = 571
          Top = 181
          Width = 32
          Height = 27
          HelpContext = 895168
          Alignment = taCenter
          AutoSize = False
          Caption = 'F3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label42: TLabel
          Tag = 90
          Left = 626
          Top = 183
          Width = 9
          Height = 19
          HelpContext = 895169
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label108: TLabel
          Left = 71
          Top = 224
          Width = 133
          Height = 29
          HelpContext = 895170
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Estimated total fringe benefits tax payable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label43: TLabel
          Left = 214
          Top = 224
          Width = 32
          Height = 27
          HelpContext = 895171
          Alignment = taCenter
          AutoSize = False
          Caption = 'F2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label41: TLabel
          Tag = 90
          Left = 271
          Top = 228
          Width = 9
          Height = 19
          HelpContext = 895172
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label119: TLabel
          Left = 251
          Top = 257
          Width = 398
          Height = 15
          HelpContext = 895173
          Alignment = taCenter
          Caption = 
            'The fringe benefits tax instalment is automatically transferred ' +
            'into field 6A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label114: TLabel
          Left = 415
          Top = 225
          Width = 112
          Height = 29
          HelpContext = 895174
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Reason for fringe benefits tax variation'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label45: TLabel
          Left = 528
          Top = 224
          Width = 32
          Height = 27
          HelpContext = 895175
          Alignment = taCenter
          AutoSize = False
          Caption = 'F4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object pnlTab3_LastPeriod: TDNMPanel
          Left = 565
          Top = 1
          Width = 307
          Height = 31
          HelpContext = 895176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            307
            31)
          object Label158: TLabel
            Left = 9
            Top = 10
            Width = 94
            Height = 15
            HelpContext = 895177
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Previous Return:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = -16
          end
          object Label159: TLabel
            Left = 196
            Top = 10
            Width = 16
            Height = 15
            HelpContext = 895178
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'To '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 171
          end
          object dtTab3_from: TwwDBDateTimePicker
            Left = 109
            Top = 6
            Width = 83
            Height = 23
            HelpContext = 895179
            Anchors = [akTop, akRight]
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
            TabOrder = 0
          end
          object dtTab3_To: TwwDBDateTimePicker
            Left = 216
            Top = 6
            Width = 83
            Height = 23
            HelpContext = 895180
            Anchors = [akTop, akRight]
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
            TabOrder = 1
          end
        end
        object Period3: TwwRadioGroup
          Left = 25
          Top = 37
          Width = 176
          Height = 22
          HelpContext = 895181
          DisableThemes = False
          TransparentActiveItem = True
          Frame.Transparent = True
          ButtonFrame.Transparent = True
          ShowGroupCaption = False
          ShowFocusRect = False
          Columns = 2
          DataField = 'Tab3_Type'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Items.Strings = (
            'Quarterly'
            'Monthly')
          ParentFont = False
          TabOrder = 1
          OnChange = Period3Change
        end
        object Tab3_Month: TwwDBComboBox
          Left = 321
          Top = 34
          Width = 120
          Height = 23
          HelpContext = 895182
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab3_Month'
          DataSource = dsReturns
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
          OnCloseUp = Tab3_MonthCloseUp
        end
        object Tab3_Year: TwwDBComboBox
          Left = 521
          Top = 34
          Width = 89
          Height = 23
          HelpContext = 895183
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab3_Year'
          DataSource = dsReturns
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
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
          TabOrder = 3
          UnboundDataType = wwDefault
        end
        object dtTab_3PeriodEnding: TwwDBDateTimePicker
          Left = 739
          Top = 36
          Width = 121
          Height = 23
          HelpContext = 895184
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
          TabOrder = 4
        end
        object btn12: TDNMSpeedButton
          Left = 214
          Top = 69
          Width = 32
          Height = 27
          HelpContext = 895185
          Caption = 'T1'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 5
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn12Click
        end
        object T1: TDBEdit
          Tag = 91
          Left = 287
          Top = 70
          Width = 102
          Height = 24
          HelpContext = 895186
          DataField = 'T1'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnDblClick = AccDblClick
        end
        object T2: TDBEdit
          Tag = 91
          Left = 287
          Top = 103
          Width = 102
          Height = 24
          HelpContext = 895187
          DataField = 'T2'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object T3: TDBEdit
          Tag = 91
          Left = 670
          Top = 69
          Width = 102
          Height = 24
          HelpContext = 895188
          DataField = 'T3'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object T4: TwwDBComboBox
          Left = 671
          Top = 102
          Width = 173
          Height = 23
          HelpContext = 895189
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          Column1Width = 300
          DataField = 'T4'
          DataSource = dsReturns
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            '01 Mergers, acquisitions and takeovers'
            '02 Cessation of business activity'
            '03 Expected utilisation of losses of a revenue or capital '
            'nature'
            '04 Significant (abnormal) transactions affecting income or '
            'expenses'
            '05 Change in trading conditions affecting income or '
            'expenses'
            '06 Domestic or foreign financial market changes'
            '07 Change in investment strategies or policies'
            '08 Change in product mix'
            '09 Business expansion or contraction'
            '10 Change in entity structure'
            '11 Internal or external restructuring of business activity'
            '12 Change in any legislation'
            '13 Change in profit margin')
          Sorted = False
          TabOrder = 9
          UnboundDataType = wwDefault
        end
        object F1: TDBEdit
          Tag = 91
          Left = 287
          Top = 186
          Width = 102
          Height = 24
          HelpContext = 895190
          DataField = 'F1'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object F3: TDBEdit
          Tag = 91
          Left = 641
          Top = 182
          Width = 102
          Height = 24
          HelpContext = 895191
          DataField = 'F3'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object F2: TDBEdit
          Tag = 91
          Left = 287
          Top = 225
          Width = 102
          Height = 24
          HelpContext = 895192
          DataField = 'F2'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object F4: TwwDBComboBox
          Left = 560
          Top = 225
          Width = 280
          Height = 23
          HelpContext = 895193
          ShowButton = True
          Style = csDropDown
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          Column1Width = 290
          DataField = 'F4'
          DataSource = dsReturns
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            
              '01 Benefits ceased/reduced and salary increased'#9'01 Benefits ceas' +
              'ed/reduced and salary increased'
            
              '02 Benefits ceased/reduced and no compensation to employees'#9'02 B' +
              'enefits ceased/reduced and no compensation to employees'
            '03 Fewer employees'#9'03 Fewer employees'
            
              '04 Increase in employee contribution'#9'04 Increase in employee con' +
              'tribution'
            
              '05 Section 65J rebate now claimed'#9'05 Section 65J rebate now clai' +
              'med'
            
              '06 Liquidation, receiver/manager appointed'#9'06 Liquidation, recei' +
              'ver/manager appointed'
            '07 None of the above'#9'07 None of the above')
          Sorted = False
          TabOrder = 13
          UnboundDataType = wwDefault
        end
      end
    end
    object TabSheet1: TTabSheet
      HelpContext = 895285
      Caption = 'Wine And Luxury'
      ImageIndex = 3
      object Label163: TLabel
        Left = 0
        Top = 0
        Width = 874
        Height = 25
        HelpContext = 895195
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Wine And Luxury '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object pnlWnL: TDNMPanel
        Left = 0
        Top = 25
        Width = 874
        Height = 438
        HelpContext = 895196
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel10: TBevel
          Left = 5
          Top = 30
          Width = 867
          Height = 33
          HelpContext = 895286
        end
        object Label167: TLabel
          Left = 88
          Top = 82
          Width = 176
          Height = 28
          HelpContext = 895202
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Wine equalisation tax payable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label168: TLabel
          Tag = 90
          Left = 326
          Top = 87
          Width = 9
          Height = 19
          HelpContext = 895203
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label169: TLabel
          Left = 88
          Top = 128
          Width = 176
          Height = 28
          HelpContext = 895204
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Luxury car tax payable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label170: TLabel
          Tag = 90
          Left = 326
          Top = 133
          Width = 9
          Height = 19
          HelpContext = 895205
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label210: TLabel
          Left = 61
          Top = 266
          Width = 198
          Height = 28
          HelpContext = 895243
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Special credit for wholesale sales tax'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label211: TLabel
          Left = 83
          Top = 220
          Width = 176
          Height = 28
          HelpContext = 895244
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Luxury car tax refundable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label212: TLabel
          Left = 83
          Top = 174
          Width = 176
          Height = 28
          HelpContext = 895245
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Wine equalisation tax refundable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label217: TLabel
          Tag = 90
          Left = 324
          Top = 179
          Width = 9
          Height = 19
          HelpContext = 895250
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label218: TLabel
          Tag = 90
          Left = 324
          Top = 225
          Width = 9
          Height = 19
          HelpContext = 895251
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label219: TLabel
          Tag = 90
          Left = 324
          Top = 271
          Width = 9
          Height = 19
          HelpContext = 895252
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label222: TLabel
          Left = 141
          Top = 312
          Width = 119
          Height = 28
          HelpContext = 895287
          Alignment = taRightJustify
          AutoSize = False
          Caption = '              Fuel Tax Credit (Do not claim in Litres)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label223: TLabel
          Tag = 90
          Left = 325
          Top = 317
          Width = 9
          Height = 19
          HelpContext = 895288
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object MonthLabel4: TLabel
          Left = 206
          Top = 39
          Width = 102
          Height = 15
          HelpContext = 895289
          Alignment = taRightJustify
          Caption = 'Quarter beginning'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object YearLabel4: TLabel
          Left = 432
          Top = 40
          Width = 78
          Height = 15
          HelpContext = 895290
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Current Year'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label171: TLabel
          Left = 662
          Top = 39
          Width = 78
          Height = 15
          HelpContext = 895291
          Alignment = taRightJustify
          Caption = 'Period Ending'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btn17: TDNMSpeedButton
          Left = 272
          Top = 83
          Width = 32
          Height = 26
          HelpContext = 895256
          Caption = '1C'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn17Click
        end
        object btn19: TDNMSpeedButton
          Left = 272
          Top = 129
          Width = 32
          Height = 26
          HelpContext = 895258
          Caption = '1E'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn19Click
        end
        object _1E: TDBEdit
          Tag = 91
          Left = 342
          Top = 130
          Width = 102
          Height = 24
          HelpContext = 895259
          DataField = '_1E'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnDblClick = TaxDblClick
        end
        object btn25: TDNMSpeedButton
          Left = 272
          Top = 267
          Width = 32
          Height = 26
          HelpContext = 895271
          Caption = '1G'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 3
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn25Click
        end
        object btn24: TDNMSpeedButton
          Left = 272
          Top = 221
          Width = 32
          Height = 26
          HelpContext = 895272
          Caption = '1F'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 4
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn24Click
        end
        object btn23: TDNMSpeedButton
          Left = 272
          Top = 175
          Width = 32
          Height = 26
          HelpContext = 895273
          Caption = '1D'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 5
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn23Click
        end
        object _1d: TDBEdit
          Tag = 91
          Left = 342
          Top = 176
          Width = 102
          Height = 24
          HelpContext = 895275
          DataField = '_1D'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnDblClick = TaxDblClick
        end
        object _1F: TDBEdit
          Tag = 91
          Left = 342
          Top = 222
          Width = 102
          Height = 24
          HelpContext = 895276
          DataField = '_1F'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnDblClick = TaxDblClick
        end
        object _1G: TDBEdit
          Tag = 91
          Left = 342
          Top = 268
          Width = 102
          Height = 24
          HelpContext = 895277
          DataField = '_1G'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnDblClick = TaxDblClick
        end
        object btn26: TDNMSpeedButton
          Left = 273
          Top = 313
          Width = 32
          Height = 26
          HelpContext = 895292
          Caption = '7D'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 9
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btn26Click
        end
        object _7d: TDBEdit
          Tag = 91
          Left = 340
          Top = 314
          Width = 102
          Height = 24
          HelpContext = 895293
          DataField = '_7D'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnDblClick = AccDblClick
        end
        object Period4: TwwRadioGroup
          Left = 16
          Top = 36
          Width = 176
          Height = 22
          HelpContext = 895294
          DisableThemes = False
          TransparentActiveItem = True
          Frame.Transparent = True
          ButtonFrame.Transparent = True
          ShowGroupCaption = False
          ShowFocusRect = False
          Columns = 2
          DataField = 'Tab4_type'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Items.Strings = (
            'Quarterly'
            'Monthly')
          ParentFont = False
          TabOrder = 11
          OnChange = Period4Change
        end
        object Tab4_Month: TwwDBComboBox
          Left = 314
          Top = 34
          Width = 120
          Height = 23
          HelpContext = 895295
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab4_Month'
          DataSource = dsReturns
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 12
          UnboundDataType = wwDefault
          OnCloseUp = Tab4_MonthCloseUp
        end
        object Tab4_Year: TwwDBComboBox
          Left = 514
          Top = 34
          Width = 89
          Height = 23
          HelpContext = 895296
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'Tab4_year'
          DataSource = dsReturns
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
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
          TabOrder = 13
          UnboundDataType = wwDefault
        end
        object dtTab_4PeriodEnding: TwwDBDateTimePicker
          Left = 746
          Top = 34
          Width = 121
          Height = 23
          HelpContext = 895297
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
          TabOrder = 14
        end
        object DNMPanel1: TDNMPanel
          Left = 565
          Top = 0
          Width = 307
          Height = 31
          HelpContext = 895298
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 15
          DesignSize = (
            307
            31)
          object pnlTab4_LastPeriod: TLabel
            Left = 9
            Top = 10
            Width = 94
            Height = 15
            HelpContext = 895299
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Previous Return:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = -16
          end
          object Label173: TLabel
            Left = 196
            Top = 10
            Width = 16
            Height = 15
            HelpContext = 895300
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'To '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8391127
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 171
          end
          object dtTab4_from: TwwDBDateTimePicker
            Left = 109
            Top = 6
            Width = 83
            Height = 23
            HelpContext = 895301
            Anchors = [akTop, akRight]
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
            TabOrder = 0
          end
          object dtTab4_To: TwwDBDateTimePicker
            Left = 216
            Top = 6
            Width = 83
            Height = 23
            HelpContext = 895302
            Anchors = [akTop, akRight]
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
            TabOrder = 1
          end
        end
        object _1C: TDBEdit
          Tag = 91
          Left = 342
          Top = 84
          Width = 102
          Height = 24
          HelpContext = 895257
          DataField = '_1C'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          OnDblClick = TaxDblClick
        end
      end
    end
    object Page327: TTabSheet
      HelpContext = 895194
      Caption = '&BAS Debits and Credits'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object Label123: TLabel
        Left = 0
        Top = 0
        Width = 874
        Height = 19
        HelpContext = 895303
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'BAS Sheet - Debits && Credits'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitLeft = 272
        ExplicitTop = 1
        ExplicitWidth = 336
      end
      object DNMPanel4: TDNMPanel
        Left = 0
        Top = 19
        Width = 874
        Height = 444
        HelpContext = 895304
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel4: TBevel
          Left = 36
          Top = 192
          Width = 808
          Height = 40
          HelpContext = 895197
          Shape = bsFrame
        end
        object Bevel5: TBevel
          Left = 31
          Top = 399
          Width = 808
          Height = 41
          HelpContext = 895198
          Shape = bsFrame
        end
        object Label134: TLabel
          Left = 18
          Top = 21
          Width = 176
          Height = 28
          HelpContext = 895199
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Goods and services tax payable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label127: TLabel
          Left = 202
          Top = 22
          Width = 32
          Height = 26
          HelpContext = 895200
          Alignment = taCenter
          AutoSize = False
          Caption = '1A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label47: TLabel
          Tag = 90
          Left = 256
          Top = 26
          Width = 9
          Height = 19
          HelpContext = 895201
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label135: TLabel
          Left = 18
          Top = 56
          Width = 176
          Height = 28
          HelpContext = 895305
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Wine equalisation tax payable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label48: TLabel
          Tag = 90
          Left = 256
          Top = 61
          Width = 9
          Height = 19
          HelpContext = 895306
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label136: TLabel
          Left = 18
          Top = 91
          Width = 176
          Height = 28
          HelpContext = 895307
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Luxury car tax payable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label49: TLabel
          Tag = 90
          Left = 256
          Top = 96
          Width = 9
          Height = 19
          HelpContext = 895308
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label137: TLabel
          Left = 18
          Top = 156
          Width = 176
          Height = 28
          HelpContext = 895206
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Add 1A + 1C + 1E'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label128: TLabel
          Left = 202
          Top = 157
          Width = 32
          Height = 26
          HelpContext = 895207
          Alignment = taCenter
          AutoSize = False
          Caption = '2A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label129: TLabel
          Tag = 90
          Left = 256
          Top = 161
          Width = 9
          Height = 19
          HelpContext = 895208
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label138: TLabel
          Left = 31
          Top = 198
          Width = 163
          Height = 28
          HelpContext = 895209
          Alignment = taRightJustify
          AutoSize = False
          Caption = '2A minus 2B GST net amount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label51: TLabel
          Tag = 90
          Left = 256
          Top = 203
          Width = 9
          Height = 19
          HelpContext = 895210
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label65: TLabel
          Left = 202
          Top = 199
          Width = 32
          Height = 26
          HelpContext = 895211
          Alignment = taCenter
          AutoSize = False
          Caption = '3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label150: TLabel
          Left = 457
          Top = 198
          Width = 325
          Height = 28
          HelpContext = 895212
          AutoSize = False
          Caption = 
            'If the result is positive, this is your net amount of GST.  If t' +
            'he result is negative, this is your net amount of GST credit.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label139: TLabel
          Left = 18
          Top = 233
          Width = 176
          Height = 28
          HelpContext = 895213
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pay As You Go withholding'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label140: TLabel
          Left = 18
          Top = 267
          Width = 176
          Height = 28
          HelpContext = 895214
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pay As You Go instalment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label141: TLabel
          Left = 18
          Top = 301
          Width = 176
          Height = 28
          HelpContext = 895215
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Fringe benefits tax instalment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label142: TLabel
          Left = 18
          Top = 336
          Width = 176
          Height = 28
          HelpContext = 895216
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Deferred company / fund instalment'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label143: TLabel
          Left = 18
          Top = 370
          Width = 176
          Height = 28
          HelpContext = 895217
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Add 1A + 4 + 5A + 7'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label67: TLabel
          Left = 202
          Top = 371
          Width = 32
          Height = 26
          HelpContext = 895218
          Alignment = taCenter
          AutoSize = False
          Caption = '8A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label68: TLabel
          Left = 202
          Top = 337
          Width = 32
          Height = 26
          HelpContext = 895219
          Alignment = taCenter
          AutoSize = False
          Caption = '7'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label133: TLabel
          Left = 202
          Top = 302
          Width = 32
          Height = 26
          HelpContext = 895220
          Alignment = taCenter
          AutoSize = False
          Caption = '6A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label66: TLabel
          Left = 202
          Top = 268
          Width = 32
          Height = 26
          HelpContext = 895221
          Alignment = taCenter
          AutoSize = False
          Caption = '5A'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label132: TLabel
          Left = 202
          Top = 234
          Width = 32
          Height = 26
          HelpContext = 895222
          Alignment = taCenter
          AutoSize = False
          Caption = '4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label50: TLabel
          Tag = 90
          Left = 256
          Top = 238
          Width = 9
          Height = 19
          HelpContext = 895223
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label52: TLabel
          Tag = 90
          Left = 256
          Top = 272
          Width = 9
          Height = 19
          HelpContext = 895224
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label53: TLabel
          Tag = 90
          Left = 256
          Top = 306
          Width = 9
          Height = 19
          HelpContext = 895225
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label54: TLabel
          Tag = 90
          Left = 256
          Top = 341
          Width = 9
          Height = 19
          HelpContext = 895226
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label55: TLabel
          Tag = 90
          Left = 256
          Top = 375
          Width = 9
          Height = 19
          HelpContext = 895227
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label144: TLabel
          Left = 40
          Top = 405
          Width = 154
          Height = 28
          HelpContext = 895228
          Alignment = taRightJustify
          AutoSize = False
          Caption = '8A minus 8B Net amount for this statement'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label69: TLabel
          Left = 202
          Top = 406
          Width = 32
          Height = 26
          HelpContext = 895229
          Alignment = taCenter
          AutoSize = False
          Caption = '9'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label62: TLabel
          Tag = 90
          Left = 254
          Top = 410
          Width = 9
          Height = 19
          HelpContext = 895230
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label154: TLabel
          Left = 389
          Top = 399
          Width = 409
          Height = 41
          HelpContext = 895231
          AutoSize = False
          Caption = 
            'If the result is positive,  the amount is payable to the ATO.  I' +
            'f the result is negative, the amount will be refunded to you or ' +
            'offset against any other obligation you have.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label153: TLabel
          Left = 474
          Top = 370
          Width = 176
          Height = 28
          HelpContext = 895232
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Add 2B + 5B + 6B + 7D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label152: TLabel
          Left = 478
          Top = 267
          Width = 172
          Height = 28
          HelpContext = 895233
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Credit arising from reduced fringe benefits tax instalments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label151: TLabel
          Left = 489
          Top = 233
          Width = 161
          Height = 28
          HelpContext = 895234
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Credit arising from reduced Pay As You Go instalments '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label130: TLabel
          Left = 663
          Top = 234
          Width = 32
          Height = 26
          HelpContext = 895235
          Alignment = taCenter
          AutoSize = False
          Caption = '5B'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label70: TLabel
          Left = 663
          Top = 268
          Width = 32
          Height = 26
          HelpContext = 895236
          Alignment = taCenter
          AutoSize = False
          Caption = '6B'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label131: TLabel
          Left = 663
          Top = 371
          Width = 32
          Height = 26
          HelpContext = 895237
          Alignment = taCenter
          AutoSize = False
          Caption = '8B'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label63: TLabel
          Tag = 90
          Left = 715
          Top = 375
          Width = 9
          Height = 19
          HelpContext = 895238
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label61: TLabel
          Tag = 90
          Left = 715
          Top = 272
          Width = 9
          Height = 19
          HelpContext = 895239
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label60: TLabel
          Tag = 90
          Left = 715
          Top = 238
          Width = 9
          Height = 19
          HelpContext = 895240
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label149: TLabel
          Left = 474
          Top = 156
          Width = 176
          Height = 28
          HelpContext = 895241
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Add 1B + 1D + 1F + 1G'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label71: TLabel
          Left = 663
          Top = 157
          Width = 32
          Height = 26
          HelpContext = 895242
          Alignment = taCenter
          AutoSize = False
          Caption = '2B'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label148: TLabel
          Left = 452
          Top = 123
          Width = 198
          Height = 28
          HelpContext = 895309
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Special credit for wholesale sales tax'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label147: TLabel
          Left = 474
          Top = 91
          Width = 176
          Height = 28
          HelpContext = 895310
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Luxury car tax refundable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label146: TLabel
          Left = 474
          Top = 56
          Width = 176
          Height = 28
          HelpContext = 895311
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Wine equalisation tax refundable'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label145: TLabel
          Left = 452
          Top = 21
          Width = 198
          Height = 28
          HelpContext = 895246
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Credit for goods and services tax paid'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label126: TLabel
          Left = 663
          Top = 22
          Width = 32
          Height = 26
          HelpContext = 895247
          Alignment = taCenter
          AutoSize = False
          Caption = '1B'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label125: TLabel
          Left = 559
          Top = 4
          Width = 228
          Height = 15
          HelpContext = 895248
          Alignment = taCenter
          AutoSize = False
          Caption = 'CREDITS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label64: TLabel
          Tag = 90
          Left = 715
          Top = 26
          Width = 9
          Height = 19
          HelpContext = 895249
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label56: TLabel
          Tag = 90
          Left = 715
          Top = 61
          Width = 9
          Height = 19
          HelpContext = 895312
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label57: TLabel
          Tag = 90
          Left = 715
          Top = 96
          Width = 9
          Height = 19
          HelpContext = 895313
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label58: TLabel
          Tag = 90
          Left = 715
          Top = 128
          Width = 9
          Height = 19
          HelpContext = 895314
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label59: TLabel
          Tag = 90
          Left = 715
          Top = 161
          Width = 9
          Height = 19
          HelpContext = 895253
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object Label124: TLabel
          Left = 87
          Top = 2
          Width = 228
          Height = 15
          HelpContext = 895254
          Alignment = taCenter
          AutoSize = False
          Caption = 'DEBITS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label161: TLabel
          Left = 531
          Top = 336
          Width = 119
          Height = 28
          HelpContext = 895315
          Alignment = taRightJustify
          AutoSize = False
          Caption = '              Fuel Tax Credit (Do not claim in Litres)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Label162: TLabel
          Tag = 90
          Left = 715
          Top = 341
          Width = 9
          Height = 19
          HelpContext = 895316
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lbl_comment_1: TLabel
          Left = 380
          Top = 28
          Width = 14
          Height = 14
          HelpContext = 895317
          Caption = 'G9'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object lbl_comment_5: TLabel
          Left = 841
          Top = 28
          Width = 20
          Height = 14
          HelpContext = 895318
          Caption = 'G20'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object lbl_comment_3: TLabel
          Left = 380
          Top = 274
          Width = 140
          Height = 14
          HelpContext = 895319
          Caption = 'T1 * T3 / 100 OR T1 * T2 /100'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lbl_comment_2: TLabel
          Left = 380
          Top = 239
          Width = 72
          Height = 14
          HelpContext = 895320
          Caption = 'W2 + W3 + W4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lbl_comment_4: TLabel
          Left = 380
          Top = 308
          Width = 48
          Height = 14
          HelpContext = 895321
          Caption = 'F1  Or  F3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lbl01: TLabel
          Left = 202
          Top = 63
          Width = 32
          Height = 15
          HelpContext = 895322
          Alignment = taCenter
          AutoSize = False
          Caption = '1C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lbl02: TLabel
          Left = 202
          Top = 98
          Width = 32
          Height = 15
          HelpContext = 895323
          Alignment = taCenter
          AutoSize = False
          Caption = '1E'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lbl05: TLabel
          Left = 663
          Top = 130
          Width = 32
          Height = 15
          HelpContext = 895324
          Alignment = taCenter
          AutoSize = False
          Caption = '1G'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lbl04: TLabel
          Left = 663
          Top = 98
          Width = 32
          Height = 15
          HelpContext = 895325
          Alignment = taCenter
          AutoSize = False
          Caption = '1F'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lbl03: TLabel
          Left = 663
          Top = 63
          Width = 32
          Height = 15
          HelpContext = 895326
          Alignment = taCenter
          AutoSize = False
          Caption = '1D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object lbl06: TLabel
          Left = 663
          Top = 343
          Width = 32
          Height = 15
          HelpContext = 895327
          Alignment = taCenter
          AutoSize = False
          Caption = '7D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
        object _1A: TDBEdit
          Tag = 91
          Left = 272
          Top = 23
          Width = 102
          Height = 24
          HelpContext = 895255
          TabStop = False
          Color = 13494001
          DataField = '_1A'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object btn17_old: TDNMSpeedButton
          Left = 381
          Top = 57
          Width = 32
          Height = 26
          HelpContext = 895328
          Caption = '1C'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btn17Click
        end
        object _1C_: TDBEdit
          Tag = 91
          Left = 272
          Top = 58
          Width = 102
          Height = 24
          HelpContext = 895329
          TabStop = False
          Color = 13494001
          DataField = '_1C'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object btn19_old: TDNMSpeedButton
          Left = 381
          Top = 92
          Width = 32
          Height = 26
          HelpContext = 895330
          Caption = '1E'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 3
          TabStop = False
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btn19Click
        end
        object _1E_: TDBEdit
          Tag = 91
          Left = 272
          Top = 93
          Width = 102
          Height = 24
          HelpContext = 895331
          TabStop = False
          Color = 13494001
          DataField = '_1E'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          OnDblClick = AccDblClick
        end
        object _2A: TDBEdit
          Tag = 91
          Left = 272
          Top = 158
          Width = 102
          Height = 24
          HelpContext = 895260
          TabStop = False
          Color = 13494001
          DataField = '_2A'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object _3: TDBEdit
          Tag = 91
          Left = 273
          Top = 200
          Width = 102
          Height = 24
          HelpContext = 895261
          TabStop = False
          Color = 13494001
          DataField = '_3'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object _8A: TDBEdit
          Tag = 91
          Left = 272
          Top = 372
          Width = 102
          Height = 24
          HelpContext = 895262
          TabStop = False
          Color = 13494001
          DataField = '_8A'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object _7: TDBEdit
          Tag = 91
          Left = 272
          Top = 338
          Width = 102
          Height = 24
          HelpContext = 895263
          DataField = '_7'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object _6A: TDBEdit
          Tag = 91
          Left = 272
          Top = 303
          Width = 102
          Height = 24
          HelpContext = 895264
          TabStop = False
          Color = 13494001
          DataField = '_6A'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object _5A: TDBEdit
          Tag = 91
          Left = 272
          Top = 269
          Width = 102
          Height = 24
          HelpContext = 895265
          TabStop = False
          Color = 13494001
          DataField = '_5A'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
        end
        object _4: TDBEdit
          Tag = 91
          Left = 272
          Top = 235
          Width = 102
          Height = 24
          HelpContext = 895266
          TabStop = False
          Color = 13494001
          DataField = '_4'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
        end
        object _9: TDBEdit
          Tag = 91
          Left = 272
          Top = 407
          Width = 102
          Height = 24
          HelpContext = 895267
          TabStop = False
          Color = 13494001
          DataField = '_9'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
        end
        object _5B: TDBEdit
          Tag = 91
          Left = 733
          Top = 235
          Width = 102
          Height = 24
          HelpContext = 895268
          DataField = '_5B'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object _6B: TDBEdit
          Tag = 91
          Left = 733
          Top = 269
          Width = 102
          Height = 24
          HelpContext = 895269
          DataField = '_6B'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object _8B: TDBEdit
          Tag = 91
          Left = 733
          Top = 372
          Width = 102
          Height = 24
          HelpContext = 895270
          TabStop = False
          Color = 13494001
          DataField = '_8B'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 15
        end
        object btn25_old: TDNMSpeedButton
          Left = 842
          Top = 124
          Width = 32
          Height = 26
          HelpContext = 895332
          Caption = '1G'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 16
          TabStop = False
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btn25Click
        end
        object btn24_old: TDNMSpeedButton
          Left = 842
          Top = 92
          Width = 32
          Height = 26
          HelpContext = 895333
          Caption = '1F'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 17
          TabStop = False
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btn24Click
        end
        object btn23_old: TDNMSpeedButton
          Left = 842
          Top = 57
          Width = 32
          Height = 26
          HelpContext = 895334
          Caption = '1D'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 18
          TabStop = False
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btn23Click
        end
        object _1B: TDBEdit
          Tag = 91
          Left = 733
          Top = 23
          Width = 102
          Height = 24
          HelpContext = 895274
          TabStop = False
          Color = 13494001
          DataField = '_1B'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
        end
        object _1D_: TDBEdit
          Tag = 91
          Left = 733
          Top = 58
          Width = 102
          Height = 24
          HelpContext = 895335
          TabStop = False
          Color = 13494001
          DataField = '_1D'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 20
          OnDblClick = AccDblClick
        end
        object _1F_: TDBEdit
          Tag = 91
          Left = 733
          Top = 93
          Width = 102
          Height = 24
          HelpContext = 895336
          TabStop = False
          Color = 13494001
          DataField = '_1F'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
          OnDblClick = AccDblClick
        end
        object _1G_: TDBEdit
          Tag = 91
          Left = 733
          Top = 125
          Width = 102
          Height = 24
          HelpContext = 895337
          TabStop = False
          Color = 13494001
          DataField = '_1G'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 22
          OnDblClick = AccDblClick
        end
        object _2B: TDBEdit
          Tag = 91
          Left = 733
          Top = 158
          Width = 102
          Height = 24
          HelpContext = 895278
          TabStop = False
          Color = 13494001
          DataField = '_2B'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 23
        end
        object btn26_old: TDNMSpeedButton
          Left = 842
          Top = 337
          Width = 32
          Height = 26
          HelpContext = 895338
          Caption = '7D'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8391127
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 24
          TabStop = False
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btn26Click
        end
        object _7D_: TDBEdit
          Tag = 91
          Left = 733
          Top = 338
          Width = 102
          Height = 24
          HelpContext = 895339
          TabStop = False
          Color = 13494001
          DataField = '_7D'
          DataSource = dsReturns
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 25
          OnDblClick = AccDblClick
        end
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 424
    Top = 352
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 424
    Top = 320
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Server = 'Localhost'
    Connected = True
    Left = 209
    Top = 56
  end
  inherited DataState: TDataState
    Left = 384
    Top = 352
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 344
    Top = 320
  end
  inherited imgsort: TImageList
    Left = 352
    Top = 352
    Bitmap = {
      494C01010200C000EC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 384
  end
  inherited QryReturns: TERPQuery
    SQL.Strings = (
      'Select * from tblbasreports')
    Left = 352
    Top = 384
    object QryReturnsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryReturnsID: TIntegerField
      FieldName = 'ID'
    end
    object QryReturnsTab1_Type: TWideStringField
      FieldName = 'Tab1_Type'
      OnChange = Tab1Change
      Size = 50
    end
    object QryReturnsTab1_Month: TWideStringField
      FieldName = 'Tab1_Month'
      OnChange = Tab1Change
      Size = 50
    end
    object QryReturnsTab1_Year: TIntegerField
      FieldName = 'Tab1_Year'
      OnChange = Tab1Change
    end
    object QryReturnsBasSheetDesc: TWideStringField
      FieldName = 'BasSheetDesc'
      Size = 50
    end
    object QryReturnsG1: TFloatField
      FieldName = 'G1'
      OnChange = QryReturnsG1Change
      DisplayFormat = '############0'
    end
    object QryReturnsG1Selected: TWideStringField
      FieldName = 'G1Selected'
      Size = 255
    end
    object QryReturnsG2: TFloatField
      FieldName = 'G2'
      DisplayFormat = '############0'
    end
    object QryReturnsG2Selected: TWideStringField
      FieldName = 'G2Selected'
      Size = 255
    end
    object QryReturnsG3: TFloatField
      FieldName = 'G3'
      DisplayFormat = '############0'
    end
    object QryReturnsG3Selected: TWideStringField
      FieldName = 'G3Selected'
      Size = 255
    end
    object QryReturnsG4: TFloatField
      FieldName = 'G4'
      DisplayFormat = '############0'
    end
    object QryReturnsG4Selected: TWideStringField
      FieldName = 'G4Selected'
      Size = 255
    end
    object QryReturnsG5: TFloatField
      FieldName = 'G5'
      DisplayFormat = '############0'
    end
    object QryReturnsG6: TFloatField
      FieldName = 'G6'
      DisplayFormat = '############0'
    end
    object QryReturnsG7: TFloatField
      FieldName = 'G7'
      DisplayFormat = '############0'
    end
    object QryReturnsG7Selected: TWideStringField
      FieldName = 'G7Selected'
      Size = 255
    end
    object QryReturnsG8: TFloatField
      FieldName = 'G8'
      DisplayFormat = '############0'
    end
    object QryReturnsG9: TFloatField
      FieldName = 'G9'
      DisplayFormat = '############0'
    end
    object QryReturnsG10: TFloatField
      FieldName = 'G10'
      DisplayFormat = '############0'
    end
    object QryReturnsG10Selected: TWideStringField
      FieldName = 'G10Selected'
      Size = 255
    end
    object QryReturnsG11: TFloatField
      FieldName = 'G11'
      DisplayFormat = '############0'
    end
    object QryReturnsG11Selected: TWideStringField
      FieldName = 'G11Selected'
      Size = 255
    end
    object QryReturnsG12: TFloatField
      FieldName = 'G12'
      DisplayFormat = '############0'
    end
    object QryReturnsG13: TFloatField
      FieldName = 'G13'
      DisplayFormat = '############0'
    end
    object QryReturnsG13Selected: TWideStringField
      FieldName = 'G13Selected'
      Size = 255
    end
    object QryReturnsG14: TFloatField
      FieldName = 'G14'
      DisplayFormat = '############0'
    end
    object QryReturnsG14Selected: TWideStringField
      FieldName = 'G14Selected'
      Size = 255
    end
    object QryReturnsG15: TFloatField
      FieldName = 'G15'
      DisplayFormat = '############0'
    end
    object QryReturnsG15Selected: TWideStringField
      FieldName = 'G15Selected'
      Size = 255
    end
    object QryReturnsG16: TFloatField
      FieldName = 'G16'
      DisplayFormat = '############0'
    end
    object QryReturnsG17: TFloatField
      FieldName = 'G17'
      DisplayFormat = '############0'
    end
    object QryReturnsG18: TFloatField
      FieldName = 'G18'
      DisplayFormat = '############0'
    end
    object QryReturnsG18Selected: TWideStringField
      FieldName = 'G18Selected'
      Size = 255
    end
    object QryReturnsG19: TFloatField
      FieldName = 'G19'
      DisplayFormat = '############0'
    end
    object QryReturnsG20: TFloatField
      FieldName = 'G20'
      DisplayFormat = '############0'
    end
    object QryReturnsTab2_Type: TWideStringField
      FieldName = 'Tab2_Type'
      Size = 50
    end
    object QryReturnsTab2_Month: TWideStringField
      FieldName = 'Tab2_Month'
      Size = 50
    end
    object QryReturnsTab2_Year: TIntegerField
      FieldName = 'Tab2_Year'
    end
    object QryReturnsW1: TFloatField
      FieldName = 'W1'
      OnChange = QryReturnsW1Change
      DisplayFormat = '############0'
    end
    object QryReturnsW1Selected: TWideStringField
      FieldName = 'W1Selected'
      Size = 255
    end
    object QryReturnsW2: TFloatField
      FieldName = 'W2'
      DisplayFormat = '############0'
    end
    object QryReturnsW2Selected: TWideStringField
      FieldName = 'W2Selected'
      Size = 255
    end
    object QryReturnsW3: TFloatField
      FieldName = 'W3'
      DisplayFormat = '############0'
    end
    object QryReturnsW3Selected: TWideStringField
      FieldName = 'W3Selected'
      Size = 255
    end
    object QryReturnsW4: TFloatField
      FieldName = 'W4'
      DisplayFormat = '############0'
    end
    object QryReturnsW4Selected: TWideStringField
      FieldName = 'W4Selected'
      Size = 255
    end
    object QryReturnsT1: TFloatField
      FieldName = 'T1'
      DisplayFormat = '############0'
    end
    object QryReturnsT1Selected: TWideStringField
      FieldName = 'T1Selected'
      Size = 255
    end
    object QryReturnsT2: TFloatField
      FieldName = 'T2'
      DisplayFormat = '############0.##'
    end
    object QryReturnsT3: TFloatField
      FieldName = 'T3'
      DisplayFormat = '############0'
    end
    object QryReturnsT4: TWideStringField
      FieldName = 'T4'
      Size = 255
    end
    object QryReturnsF1: TFloatField
      FieldName = 'F1'
      DisplayFormat = '############0'
    end
    object QryReturnsF2: TFloatField
      FieldName = 'F2'
      DisplayFormat = '############0'
    end
    object QryReturnsF3: TFloatField
      FieldName = 'F3'
      DisplayFormat = '############0'
    end
    object QryReturnsF4: TWideStringField
      FieldName = 'F4'
      Size = 50
    end
    object QryReturns_1A: TFloatField
      FieldName = '_1A'
      DisplayFormat = '############0'
    end
    object QryReturns_1B: TFloatField
      FieldName = '_1B'
      DisplayFormat = '############0'
    end
    object QryReturns_1C: TFloatField
      FieldName = '_1C'
      OnChange = QryReturns_1CChange
      DisplayFormat = '############0'
    end
    object QryReturns_1CSelected: TWideStringField
      FieldName = '_1CSelected'
      Size = 255
    end
    object QryReturns_1D: TFloatField
      FieldName = '_1D'
      DisplayFormat = '############0'
    end
    object QryReturns_1DSelected: TWideStringField
      FieldName = '_1DSelected'
      Size = 255
    end
    object QryReturns_1E: TFloatField
      FieldName = '_1E'
      DisplayFormat = '############0'
    end
    object QryReturns_1ESelected: TWideStringField
      FieldName = '_1ESelected'
      Size = 255
    end
    object QryReturns_1F: TFloatField
      FieldName = '_1F'
      DisplayFormat = '############0'
    end
    object QryReturns_1FSelected: TWideStringField
      FieldName = '_1FSelected'
      Size = 255
    end
    object QryReturns_1G: TFloatField
      FieldName = '_1G'
      DisplayFormat = '############0'
    end
    object QryReturns_1GSelected: TWideStringField
      FieldName = '_1GSelected'
      Size = 255
    end
    object QryReturns_2A: TFloatField
      FieldName = '_2A'
      DisplayFormat = '############0'
    end
    object QryReturns_2B: TFloatField
      FieldName = '_2B'
      DisplayFormat = '############0'
    end
    object QryReturns_3: TFloatField
      FieldName = '_3'
      DisplayFormat = '############0'
    end
    object QryReturns_4: TFloatField
      FieldName = '_4'
      DisplayFormat = '############0'
    end
    object QryReturns_5A: TFloatField
      FieldName = '_5A'
      DisplayFormat = '############0'
    end
    object QryReturns_5B: TFloatField
      FieldName = '_5B'
      DisplayFormat = '############0'
    end
    object QryReturns_6A: TFloatField
      FieldName = '_6A'
      DisplayFormat = '############0'
    end
    object QryReturns_6B: TFloatField
      FieldName = '_6B'
      DisplayFormat = '############0'
    end
    object QryReturns_7: TFloatField
      FieldName = '_7'
      DisplayFormat = '############0'
    end
    object QryReturns_8A: TFloatField
      FieldName = '_8A'
      DisplayFormat = '############0'
    end
    object QryReturns_8B: TFloatField
      FieldName = '_8B'
      DisplayFormat = '############0'
    end
    object QryReturns_9: TFloatField
      FieldName = '_9'
      DisplayFormat = '############0'
    end
    object QryReturnsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QryReturnsAccMethod: TWideStringField
      FieldName = 'AccMethod'
      OnChange = QryReturnsAccMethodChange
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
    object QryReturnsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QryReturnsTab3_Type: TWideStringField
      FieldName = 'Tab3_Type'
      Size = 50
    end
    object QryReturnsTab3_Month: TWideStringField
      FieldName = 'Tab3_Month'
      Size = 50
    end
    object QryReturnsTab3_Year: TIntegerField
      FieldName = 'Tab3_Year'
    end
    object QryReturnsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryReturnsDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object QryReturnsHasTab1: TWideStringField
      FieldName = 'HasTab1'
      FixedChar = True
      Size = 1
    end
    object QryReturnsHasTab2: TWideStringField
      FieldName = 'HasTab2'
      FixedChar = True
      Size = 1
    end
    object QryReturnsHasTab3: TWideStringField
      FieldName = 'HasTab3'
      FixedChar = True
      Size = 1
    end
    object QryReturnsSummarisedTransDate: TDateField
      FieldName = 'SummarisedTransDate'
    end
    object QryReturns_7D: TFloatField
      FieldName = '_7D'
    end
    object QryReturns_7DSelected: TWideStringField
      FieldName = '_7DSelected'
      Size = 255
    end
    object QryReturnsTab4_type: TWideStringField
      FieldName = 'Tab4_type'
      Size = 50
    end
    object QryReturnsTab4_Month: TWideStringField
      FieldName = 'Tab4_Month'
      Size = 50
    end
    object QryReturnsTab4_year: TIntegerField
      FieldName = 'Tab4_year'
    end
    object QryReturnsHasTab4: TWideStringField
      FieldName = 'HasTab4'
      FixedChar = True
      Size = 1
    end
  end
  inherited QryReturnLines: TERPQuery
    SQL.Strings = (
      'select * from `tblBasReportLines`')
    Left = 67
    Top = 344
    object QryReturnLinesID: TIntegerField
      FieldName = 'ID'
    end
    object QryReturnLinesGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object QryReturnLinesBasID: TIntegerField
      FieldName = 'BasID'
    end
    object QryReturnLinesTransGlobalref: TWideStringField
      FieldName = 'TransGlobalref'
      Size = 255
    end
    object QryReturnLinesTranstype: TWideStringField
      FieldName = 'Transtype'
      Size = 100
    end
    object QryReturnLinesBasCode: TWideStringField
      FieldName = 'BasCode'
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
    object QryReturnLinesTransSeqno: TFloatField
      FieldName = 'TransSeqno'
    end
  end
  inherited dsReturns: TDataSource
    Left = 344
    Top = 280
  end
  inherited dsReturnLines: TDataSource
    Left = 424
    Top = 168
  end
end
