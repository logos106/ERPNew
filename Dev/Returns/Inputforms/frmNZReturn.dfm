inherited fmNZReturn: TfmNZReturn
  Left = 410
  Top = 44
  HelpContext = 894001
  Caption = 'fmNZReturn'
  ExplicitLeft = 410
  ExplicitTop = 44
  ExplicitWidth = 320
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnltop: TDNMPanel
    HelpContext = 894124
    inherited edtDescription: TwwDBEdit
      DataField = 'BasSheetDesc'
    end
  end
  inherited Panel1: TDNMPanel
    HelpContext = 894125
    inherited BtnRefresh: TDNMSpeedButton
      Top = 2
      ExplicitTop = 2
    end
  end
  inherited Tabmain: TPageControl
    ActivePage = tabNZReturnStatement
    TabWidth = 439
    object tabNZReturnStatement: TTabSheet
      HelpContext = 894002
      Caption = '         &N.Z. Tax Return Statement           '
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Bevel1: TBevel
        Left = 8
        Top = 31
        Width = 861
        Height = 39
        HelpContext = 894003
      end
      object Label179: TLabel
        Left = 242
        Top = 0
        Width = 294
        Height = 22
        HelpContext = 894004
        Caption = 'Goods and Services Tax Return'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label180: TLabel
        Left = 241
        Top = 95
        Width = 295
        Height = 28
        HelpContext = 894005
        Alignment = taRightJustify
        Caption = 
          'Total sales and income for the period (including GST and any zer' +
          'o-rated supplies)'
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
      object Label181: TLabel
        Tag = 90
        Left = 651
        Top = 100
        Width = 9
        Height = 19
        HelpContext = 894006
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
      object Label182: TLabel
        Left = 199
        Top = 119
        Width = 337
        Height = 28
        HelpContext = 894007
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Zero-rated supplies included in Box 5'
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
      object Label183: TLabel
        Tag = 90
        Left = 651
        Top = 124
        Width = 9
        Height = 19
        HelpContext = 894008
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
      object Label184: TLabel
        Left = 335
        Top = 149
        Width = 201
        Height = 14
        HelpContext = 894009
        Alignment = taRightJustify
        Caption = 'Subtract Box 6 from Box 5 and enter the  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object Label185: TLabel
        Tag = 90
        Left = 651
        Top = 147
        Width = 9
        Height = 19
        HelpContext = 894010
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
      object Label186: TLabel
        Left = 201
        Top = 167
        Width = 335
        Height = 30
        HelpContext = 894011
        Alignment = taRightJustify
        Caption = 
          'Multiply the amount in Box 7 by three (3) and  then divide by tw' +
          'enty-three (23)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label187: TLabel
        Tag = 90
        Left = 651
        Top = 171
        Width = 9
        Height = 19
        HelpContext = 894012
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
      object Label190: TLabel
        Left = 576
        Top = 146
        Width = 17
        Height = 21
        HelpContext = 894013
        Alignment = taRightJustify
        AutoSize = False
        Caption = '7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label191: TLabel
        Left = 576
        Top = 170
        Width = 17
        Height = 21
        HelpContext = 894014
        Alignment = taRightJustify
        AutoSize = False
        Caption = '8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label192: TLabel
        Left = 199
        Top = 191
        Width = 337
        Height = 28
        HelpContext = 894015
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Adjustments from your calculation sheet'
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
      object Label194: TLabel
        Tag = 90
        Left = 651
        Top = 196
        Width = 9
        Height = 19
        HelpContext = 894016
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
      object Label195: TLabel
        Left = 207
        Top = 216
        Width = 329
        Height = 28
        HelpContext = 894017
        Alignment = taRightJustify
        Caption = 
          'Add Box 8 and Box 9.  This is your total GST collected on sales ' +
          'and income'
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
      object Label196: TLabel
        Left = 576
        Top = 218
        Width = 17
        Height = 21
        HelpContext = 894018
        Alignment = taRightJustify
        AutoSize = False
        Caption = '10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label197: TLabel
        Tag = 90
        Left = 651
        Top = 219
        Width = 9
        Height = 19
        HelpContext = 894019
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
      object Label198: TLabel
        Left = 201
        Top = 289
        Width = 335
        Height = 30
        HelpContext = 894020
        Alignment = taRightJustify
        Caption = 
          'Multiply the amount in Box 11 by three (3) and then divide by tw' +
          'enty-three (23)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label199: TLabel
        Left = 576
        Top = 290
        Width = 17
        Height = 24
        HelpContext = 894021
        Alignment = taRightJustify
        AutoSize = False
        Caption = '12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label200: TLabel
        Tag = 90
        Left = 651
        Top = 293
        Width = 9
        Height = 19
        HelpContext = 894022
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
      object Label201: TLabel
        Left = 197
        Top = 255
        Width = 339
        Height = 31
        HelpContext = 894023
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'Total purchases and expenses (including GST) for which tax invoi' +
          'cing requirements have been  met'#8212'excluding any imported goods'
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
      object Label203: TLabel
        Tag = 90
        Left = 651
        Top = 268
        Width = 9
        Height = 19
        HelpContext = 894024
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
      object Label204: TLabel
        Left = 199
        Top = 310
        Width = 337
        Height = 31
        HelpContext = 894025
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Credit adjustments from your calculation sheet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object Label206: TLabel
        Tag = 90
        Left = 651
        Top = 316
        Width = 9
        Height = 19
        HelpContext = 894026
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
      object Label207: TLabel
        Left = 204
        Top = 341
        Width = 332
        Height = 28
        HelpContext = 894027
        Alignment = taRightJustify
        Caption = 
          'Add Box 12 and Box 13.  This is your total GST credit for purcha' +
          'ses and expenses'
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
      object Label208: TLabel
        Left = 576
        Top = 338
        Width = 17
        Height = 24
        HelpContext = 894028
        Alignment = taRightJustify
        AutoSize = False
        Caption = '14'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label209: TLabel
        Tag = 90
        Left = 651
        Top = 341
        Width = 9
        Height = 19
        HelpContext = 894029
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
        Left = 199
        Top = 394
        Width = 337
        Height = 21
        HelpContext = 894030
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'If Box 14 is larger than Box 10 the difference is your GST refun' +
          'd'
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
        Left = 199
        Top = 413
        Width = 337
        Height = 21
        HelpContext = 894031
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'If Box 10 is larger than Box 14 the difference is GST to pay'
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
      object Label193: TLabel
        Left = 238
        Top = 367
        Width = 298
        Height = 15
        HelpContext = 894032
        Alignment = taRightJustify
        Caption = 'Print the difference between Box 10 and Box 14 here'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object Label212: TLabel
        Left = 576
        Top = 362
        Width = 17
        Height = 24
        HelpContext = 894033
        Alignment = taRightJustify
        AutoSize = False
        Caption = '15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label213: TLabel
        Tag = 90
        Left = 651
        Top = 365
        Width = 9
        Height = 19
        HelpContext = 894034
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
      object Label214: TLabel
        Left = 408
        Top = 438
        Width = 129
        Height = 28
        HelpContext = 894035
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Amount of payment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label215: TLabel
        Left = 576
        Top = 442
        Width = 17
        Height = 21
        HelpContext = 894036
        Alignment = taRightJustify
        AutoSize = False
        Caption = '16'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label216: TLabel
        Tag = 90
        Left = 651
        Top = 443
        Width = 9
        Height = 19
        HelpContext = 894037
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
      object MonthLabel: TLabel
        Left = 301
        Top = 42
        Width = 93
        Height = 15
        HelpContext = 894038
        Alignment = taRightJustify
        Caption = 'Month beginning'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label219: TLabel
        Left = 531
        Top = 42
        Width = 38
        Height = 15
        HelpContext = 894039
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Year'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label220: TLabel
        Left = 586
        Top = 76
        Width = 197
        Height = 15
        HelpContext = 894040
        Caption = '           Total Sales and Income           '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label221: TLabel
        Left = 582
        Top = 245
        Width = 202
        Height = 15
        HelpContext = 894041
        Caption = '     Total Purchases and Expenses    '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label217: TLabel
        Left = 11
        Top = 14
        Width = 213
        Height = 15
        HelpContext = 894042
        Alignment = taRightJustify
        Caption = 'Goods and Services tax for the period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label188: TLabel
        Left = 11
        Top = 76
        Width = 180
        Height = 15
        HelpContext = 894043
        Caption = 'Accounting Basis: Invoice Basis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 662
        Top = 42
        Width = 78
        Height = 15
        HelpContext = 894044
        Alignment = taRightJustify
        Caption = 'Period Ending'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 191
        Top = 144
        Width = 351
        Height = 2
        HelpContext = 894045
      end
      object Bevel3: TBevel
        Left = 191
        Top = 166
        Width = 351
        Height = 2
        HelpContext = 894046
      end
      object Bevel4: TBevel
        Left = 191
        Top = 214
        Width = 351
        Height = 2
        HelpContext = 894047
      end
      object Bevel5: TBevel
        Left = 0
        Top = 242
        Width = 874
        Height = 2
        HelpContext = 894048
      end
      object Bevel6: TBevel
        Left = 191
        Top = 286
        Width = 351
        Height = 2
        HelpContext = 894049
      end
      object Bevel7: TBevel
        Left = 191
        Top = 339
        Width = 351
        Height = 2
        HelpContext = 894050
      end
      object Bevel8: TBevel
        Left = 191
        Top = 385
        Width = 351
        Height = 2
        HelpContext = 894051
      end
      object Label4: TLabel
        Left = 8
        Top = 97
        Width = 177
        Height = 139
        HelpContext = 894052
        AutoSize = False
        Caption = 'Goods and services tax on your sales  and income'
        Font.Charset = ANSI_CHARSET
        Font.Color = 8391127
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object Label5: TLabel
        Left = 7
        Top = 252
        Width = 177
        Height = 198
        HelpContext = 894053
        AutoSize = False
        Caption = 'Goods and services tax on your purchases and expenses'
        Font.Charset = ANSI_CHARSET
        Font.Color = 8391127
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object btnGoCalculationSheet: TDNMSpeedButton
        Left = 576
        Top = 194
        Width = 25
        Height = 23
        HelpContext = 894054
        Caption = '&9'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
        TabOrder = 10
        OnClick = btnGoCalculationSheetClick
      end
      object btnGoCalculationSheet2: TDNMSpeedButton
        Left = 576
        Top = 314
        Width = 25
        Height = 23
        HelpContext = 894055
        Caption = '&13'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
      end
      object rgGSTPaymentStatus: TRadioGroup
        Left = 576
        Top = 392
        Width = 209
        Height = 41
        HelpContext = 894056
        Columns = 2
        Enabled = False
        Items.Strings = (
          'Refund'
          'GST to pay')
        TabOrder = 12
      end
      object Period4: TwwRadioGroup
        Left = 9
        Top = 38
        Width = 288
        Height = 29
        HelpContext = 894057
        DisableThemes = False
        Frame.Transparent = True
        ButtonFrame.Transparent = True
        ShowGroupCaption = False
        ShowFocusRect = False
        Columns = 3
        DataField = 'Tab4_Type'
        DataSource = dsReturns
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        Items.Strings = (
          'Monthly'
          'Two Monthly'
          'Six Monthly')
        ParentFont = False
        TabOrder = 15
        OnChange = PeriodChange
      end
      object btn5: TDNMSpeedButton
        Left = 576
        Top = 98
        Width = 25
        Height = 23
        HelpContext = 894058
        Caption = '&5'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
        OnClick = btn5Click
      end
      object btn6: TDNMSpeedButton
        Left = 576
        Top = 122
        Width = 25
        Height = 23
        HelpContext = 894059
        Caption = '&6'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
        OnClick = btn6Click
      end
      object Button22: TDNMSpeedButton
        Left = 576
        Top = 266
        Width = 25
        Height = 23
        HelpContext = 894060
        Caption = '&11'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
        OnClick = Button22Click
      end
      object NZG5: TDBEdit
        Tag = 91
        Left = 666
        Top = 98
        Width = 121
        Height = 23
        HelpContext = 894061
        DataField = 'NZG5'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnDblClick = TaxDblClick
      end
      object NZG6: TDBEdit
        Tag = 91
        Left = 666
        Top = 122
        Width = 121
        Height = 23
        HelpContext = 894062
        DataField = 'NZG6'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnDblClick = TaxDblClick
      end
      object NZG7: TDBEdit
        Tag = 91
        Left = 666
        Top = 145
        Width = 121
        Height = 23
        HelpContext = 894063
        Color = 13494001
        DataField = 'NZG7'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object NZG8: TDBEdit
        Tag = 91
        Left = 666
        Top = 169
        Width = 121
        Height = 23
        HelpContext = 894064
        Color = 13494001
        DataField = 'NZG8'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object NZG9: TDBEdit
        Tag = 91
        Left = 666
        Top = 194
        Width = 121
        Height = 23
        HelpContext = 894065
        Color = clWhite
        DataField = 'NZG9'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object NZG10: TDBEdit
        Tag = 91
        Left = 666
        Top = 217
        Width = 121
        Height = 23
        HelpContext = 894066
        Color = 13494001
        DataField = 'NZG10'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
      object NZG12: TDBEdit
        Tag = 91
        Left = 666
        Top = 291
        Width = 121
        Height = 23
        HelpContext = 894067
        Color = 13494001
        DataField = 'NZG12'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object NZG11: TDBEdit
        Tag = 91
        Left = 666
        Top = 266
        Width = 121
        Height = 23
        HelpContext = 894068
        DataField = 'NZG11'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnDblClick = TaxDblClick
      end
      object NZG13: TDBEdit
        Tag = 91
        Left = 666
        Top = 314
        Width = 121
        Height = 23
        HelpContext = 894069
        Color = clWhite
        DataField = 'NZG13'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object NZG14: TDBEdit
        Tag = 91
        Left = 666
        Top = 339
        Width = 121
        Height = 23
        HelpContext = 894070
        Color = 13494001
        DataField = 'NZG14'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
      object NZG15: TDBEdit
        Tag = 91
        Left = 666
        Top = 363
        Width = 121
        Height = 23
        HelpContext = 894071
        Color = 13494001
        DataField = 'NZG15'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 13
      end
      object NZG16: TDBEdit
        Tag = 91
        Left = 665
        Top = 441
        Width = 121
        Height = 23
        HelpContext = 894072
        Color = 13494001
        DataField = 'NZG16'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 14
      end
      object Tab4_Month: TwwDBComboBox
        Left = 396
        Top = 37
        Width = 120
        Height = 24
        HelpContext = 894073
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DataField = 'Tab4_Month'
        DataSource = dsReturns
        DropDownCount = 8
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = False
        TabOrder = 19
        UnboundDataType = wwDefault
      end
      object Tab4_Year: TwwDBComboBox
        Left = 576
        Top = 37
        Width = 80
        Height = 24
        HelpContext = 894074
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DataField = 'Tab4_Year'
        DataSource = dsReturns
        DropDownCount = 8
        Font.Charset = ANSI_CHARSET
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
        TabOrder = 20
        UnboundDataType = wwDefault
      end
      object dtTab_4PeriodEnding: TwwDBDateTimePicker
        Left = 745
        Top = 38
        Width = 121
        Height = 23
        HelpContext = 894075
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        Epoch = 1950
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowButton = True
        TabOrder = 21
      end
      object pnlTab4_LastPeriod: TDNMPanel
        Left = 560
        Top = 1
        Width = 309
        Height = 31
        HelpContext = 894076
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 22
        DesignSize = (
          309
          31)
        object Label2: TLabel
          Left = 11
          Top = 9
          Width = 94
          Height = 15
          HelpContext = 894077
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
        object Label3: TLabel
          Left = 198
          Top = 9
          Width = 16
          Height = 15
          HelpContext = 894078
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
          Left = 111
          Top = 5
          Width = 83
          Height = 23
          HelpContext = 894079
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
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowButton = True
          TabOrder = 0
          ExplicitLeft = 84
        end
        object dtTab4_To: TwwDBDateTimePicker
          Left = 218
          Top = 5
          Width = 83
          Height = 23
          HelpContext = 894080
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
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowButton = True
          TabOrder = 1
          ExplicitLeft = 191
        end
      end
    end
    object tabNZReturnCalcSheet: TTabSheet
      HelpContext = 894081
      Caption = '         N.&Z. Calculation Sheet             '
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblGSTAdjustmentTitle: TLabel
        Left = 291
        Top = 0
        Width = 322
        Height = 22
        HelpContext = 894082
        Caption = 'GST adjustments calculation sheet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label120: TLabel
        Left = 168
        Top = 40
        Width = 433
        Height = 28
        HelpContext = 894083
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'Private use of business goods and services for annual or period-' +
          'by-period adjustments'
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
      object Label74: TLabel
        Left = 328
        Top = 74
        Width = 273
        Height = 28
        HelpContext = 894084
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Business assets used privately (a one-off adjustments)'
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
      object Label121: TLabel
        Left = 392
        Top = 106
        Width = 209
        Height = 28
        HelpContext = 894085
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Assets kept after ceasing to be registered'
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
      object Label122: TLabel
        Left = 384
        Top = 138
        Width = 217
        Height = 28
        HelpContext = 894086
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Entertainment expenses (once a year only)'
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
      object Label155: TLabel
        Left = 456
        Top = 170
        Width = 145
        Height = 28
        HelpContext = 894087
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Change of accounting basis'
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
      object Label156: TLabel
        Left = 128
        Top = 202
        Width = 473
        Height = 28
        HelpContext = 894088
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'Goods and services used in making exempt supplies for annual or ' +
          'period-by-period adjustments'
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
      object Label157: TLabel
        Left = 72
        Top = 234
        Width = 529
        Height = 28
        HelpContext = 894089
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'Other (such as: barter, bad debts recovered, exported secondhand' +
          ' goods, insurance payments received)'
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
      object Label158: TLabel
        Left = 472
        Top = 268
        Width = 129
        Height = 28
        HelpContext = 894090
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total adjustments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label159: TLabel
        Left = 624
        Top = 268
        Width = 9
        Height = 28
        HelpContext = 894091
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label160: TLabel
        Left = 72
        Top = 298
        Width = 529
        Height = 28
        HelpContext = 894092
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'Business use of private/exempt goods and services for annual or ' +
          'period-by-period adjustments'
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
      object Label161: TLabel
        Left = 72
        Top = 330
        Width = 529
        Height = 28
        HelpContext = 894093
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'Private assets used for business costing less than $18,000 (a on' +
          'e-off adjustment)'
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
        Left = 72
        Top = 362
        Width = 529
        Height = 28
        HelpContext = 894094
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Change of accounting basis'
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
      object Label163: TLabel
        Left = 72
        Top = 394
        Width = 529
        Height = 28
        HelpContext = 894095
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          'Other (such as: barter, bad debts recovered, exported secondhand' +
          ' goods, insurance payments received)'
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
      object Label164: TLabel
        Left = 432
        Top = 427
        Width = 169
        Height = 28
        HelpContext = 894096
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total Credit adjustments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label165: TLabel
        Left = 616
        Top = 427
        Width = 17
        Height = 28
        HelpContext = 894097
        Alignment = taRightJustify
        AutoSize = False
        Caption = '13'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8391127
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label166: TLabel
        Tag = 90
        Left = 650
        Top = 45
        Width = 9
        Height = 19
        HelpContext = 894098
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
      object Label167: TLabel
        Tag = 90
        Left = 650
        Top = 79
        Width = 9
        Height = 19
        HelpContext = 894099
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
      object Label168: TLabel
        Tag = 90
        Left = 650
        Top = 111
        Width = 9
        Height = 19
        HelpContext = 894100
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
        Tag = 90
        Left = 650
        Top = 143
        Width = 9
        Height = 19
        HelpContext = 894101
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
      object Label170: TLabel
        Tag = 90
        Left = 650
        Top = 175
        Width = 9
        Height = 19
        HelpContext = 894102
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
      object Label171: TLabel
        Tag = 90
        Left = 650
        Top = 207
        Width = 9
        Height = 19
        HelpContext = 894103
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
      object Label172: TLabel
        Tag = 90
        Left = 650
        Top = 239
        Width = 9
        Height = 19
        HelpContext = 894104
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
      object Label173: TLabel
        Tag = 90
        Left = 650
        Top = 273
        Width = 9
        Height = 19
        HelpContext = 894105
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
      object Label174: TLabel
        Tag = 90
        Left = 650
        Top = 303
        Width = 9
        Height = 19
        HelpContext = 894106
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
      object Label175: TLabel
        Tag = 90
        Left = 650
        Top = 335
        Width = 9
        Height = 19
        HelpContext = 894107
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
      object Label176: TLabel
        Tag = 90
        Left = 650
        Top = 367
        Width = 9
        Height = 19
        HelpContext = 894108
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
      object Label177: TLabel
        Tag = 90
        Left = 650
        Top = 399
        Width = 9
        Height = 19
        HelpContext = 894109
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
      object Label178: TLabel
        Tag = 90
        Left = 650
        Top = 432
        Width = 9
        Height = 19
        HelpContext = 894110
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
      object C1: TDBEdit
        Tag = 91
        Left = 666
        Top = 43
        Width = 121
        Height = 23
        HelpContext = 894111
        DataField = 'C1'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object C2: TDBEdit
        Tag = 91
        Left = 666
        Top = 77
        Width = 121
        Height = 23
        HelpContext = 894112
        DataField = 'C2'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object C3: TDBEdit
        Tag = 91
        Left = 666
        Top = 109
        Width = 121
        Height = 23
        HelpContext = 894113
        DataField = 'C3'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object C4: TDBEdit
        Tag = 91
        Left = 666
        Top = 141
        Width = 121
        Height = 23
        HelpContext = 894114
        DataField = 'C4'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object C5: TDBEdit
        Tag = 91
        Left = 666
        Top = 173
        Width = 121
        Height = 23
        HelpContext = 894115
        DataField = 'C5'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object C6: TDBEdit
        Tag = 91
        Left = 666
        Top = 205
        Width = 121
        Height = 23
        HelpContext = 894116
        DataField = 'C6'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object C7: TDBEdit
        Tag = 91
        Left = 666
        Top = 237
        Width = 121
        Height = 23
        HelpContext = 894117
        DataField = 'C7'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object C8: TDBEdit
        Tag = 91
        Left = 666
        Top = 271
        Width = 121
        Height = 23
        HelpContext = 894118
        Color = 13494001
        DataField = 'C8'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object C13: TDBEdit
        Tag = 91
        Left = 666
        Top = 430
        Width = 121
        Height = 23
        HelpContext = 894119
        Color = 13494001
        DataField = 'C13'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
      end
      object C9: TDBEdit
        Tag = 91
        Left = 666
        Top = 301
        Width = 121
        Height = 23
        HelpContext = 894120
        DataField = 'C9'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object C10: TDBEdit
        Tag = 91
        Left = 666
        Top = 333
        Width = 121
        Height = 23
        HelpContext = 894121
        DataField = 'C10'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object C11: TDBEdit
        Tag = 91
        Left = 666
        Top = 365
        Width = 121
        Height = 23
        HelpContext = 894122
        DataField = 'C11'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object C12: TDBEdit
        Tag = 91
        Left = 666
        Top = 397
        Width = 121
        Height = 23
        HelpContext = 894123
        DataField = 'C12'
        DataSource = dsReturns
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102005400580010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryReturns: TERPQuery
    SQL.Strings = (
      'Select * from tblnzreturns')
    Left = 392
    object QryReturnsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryReturnsID: TIntegerField
      FieldName = 'ID'
    end
    object QryReturnsTab4_Type: TWideStringField
      FieldName = 'Tab4_Type'
      Size = 50
    end
    object QryReturnsTab4_Month: TWideStringField
      FieldName = 'Tab4_Month'
      Size = 50
    end
    object QryReturnsTab4_Year: TIntegerField
      FieldName = 'Tab4_Year'
    end
    object QryReturnsBasSheetDesc: TWideStringField
      FieldName = 'BasSheetDesc'
      Size = 50
    end
    object QryReturnsNZG5: TFloatField
      FieldName = 'NZG5'
    end
    object QryReturnsNZG5Selected: TWideStringField
      FieldName = 'NZG5Selected'
      Size = 255
    end
    object QryReturnsNZG6: TFloatField
      FieldName = 'NZG6'
    end
    object QryReturnsNZG6Selected: TWideStringField
      FieldName = 'NZG6Selected'
      Size = 255
    end
    object QryReturnsNZG7: TFloatField
      FieldName = 'NZG7'
    end
    object QryReturnsNZG8: TFloatField
      FieldName = 'NZG8'
    end
    object QryReturnsNZG9: TFloatField
      FieldName = 'NZG9'
    end
    object QryReturnsNZG10: TFloatField
      FieldName = 'NZG10'
    end
    object QryReturnsNZG11: TFloatField
      FieldName = 'NZG11'
    end
    object QryReturnsNZG11Selected: TWideStringField
      FieldName = 'NZG11Selected'
      Size = 255
    end
    object QryReturnsNZG12: TFloatField
      FieldName = 'NZG12'
    end
    object QryReturnsNZG13: TFloatField
      FieldName = 'NZG13'
    end
    object QryReturnsNZG14: TFloatField
      FieldName = 'NZG14'
    end
    object QryReturnsNZG15: TFloatField
      FieldName = 'NZG15'
    end
    object QryReturnsNZG16: TFloatField
      FieldName = 'NZG16'
    end
    object QryReturnsC1: TFloatField
      FieldName = 'C1'
    end
    object QryReturnsC2: TFloatField
      FieldName = 'C2'
    end
    object QryReturnsC3: TFloatField
      FieldName = 'C3'
    end
    object QryReturnsC4: TFloatField
      FieldName = 'C4'
    end
    object QryReturnsC5: TFloatField
      FieldName = 'C5'
    end
    object QryReturnsC6: TFloatField
      FieldName = 'C6'
    end
    object QryReturnsC7: TFloatField
      FieldName = 'C7'
    end
    object QryReturnsC8: TFloatField
      FieldName = 'C8'
    end
    object QryReturnsC9: TFloatField
      FieldName = 'C9'
    end
    object QryReturnsC10: TFloatField
      FieldName = 'C10'
    end
    object QryReturnsC11: TFloatField
      FieldName = 'C11'
    end
    object QryReturnsC12: TFloatField
      FieldName = 'C12'
    end
    object QryReturnsC13: TFloatField
      FieldName = 'C13'
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
    object QryReturnsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryReturnsDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object QryReturnsSummarisedTransDate: TDateField
      FieldName = 'SummarisedTransDate'
    end
  end
  inherited QryReturnLines: TERPQuery
    SQL.Strings = (
      'Select * from tblNZReportLines')
    Left = 427
    object QryReturnLinesID: TIntegerField
      FieldName = 'ID'
    end
    object QryReturnLinesGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object QryReturnLinesNZID: TIntegerField
      FieldName = 'NZID'
    end
    object QryReturnLinesTransGlobalref: TWideStringField
      FieldName = 'TransGlobalref'
      Size = 255
    end
    object QryReturnLinesTranstype: TWideStringField
      FieldName = 'Transtype'
      Size = 100
    end
    object QryReturnLinesTransSeqno: TIntegerField
      FieldName = 'TransSeqno'
    end
    object QryReturnLinesNZCode: TWideStringField
      FieldName = 'NZCode'
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
  inherited dsReturns: TDataSource
    Left = 392
  end
  inherited dsReturnLines: TDataSource
    Left = 427
  end
  object tmrNZBasMonitor: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrNZBasMonitorTimer
    Left = 75
    Top = 120
  end
end
