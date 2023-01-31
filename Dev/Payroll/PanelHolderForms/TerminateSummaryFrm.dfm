inherited frmTerminateSummary: TfrmTerminateSummary
  Left = 1287
  Top = 240
  HelpContext = 606000
  Caption = 'frmTerminateSummary'
  ClientHeight = 441
  ClientWidth = 810
  OldCreateOrder = True
  ExplicitWidth = 826
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 441
    Width = 810
    HelpContext = 606034
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 10
    Top = 40
    Width = 799
    Height = 283
    HelpContext = 606001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      799
      283)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 268
      HelpContext = 606002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Bevel3: TBevel
      Left = 160
      Top = 226
      Width = 151
      Height = 32
      HelpContext = 606003
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label29: TLabel
      Left = 55
      Top = 32
      Width = 94
      Height = 19
      HelpContext = 606004
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Lump Sum A :'
      Transparent = True
      WordWrap = True
    end
    object Label30: TLabel
      Left = 63
      Top = 64
      Width = 86
      Height = 19
      HelpContext = 606005
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Lump Sum B :'
      Transparent = True
      WordWrap = True
    end
    object Label42: TLabel
      Left = 31
      Top = 96
      Width = 118
      Height = 19
      HelpContext = 606006
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Lump Sum C (ETP) :'
      Transparent = True
      WordWrap = True
    end
    object Label31: TLabel
      Left = 63
      Top = 128
      Width = 86
      Height = 19
      HelpContext = 606007
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Lump Sum D :'
      Transparent = True
      WordWrap = True
    end
    object Label32: TLabel
      Left = 63
      Top = 160
      Width = 86
      Height = 19
      HelpContext = 606008
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Lump Sum E :'
      Transparent = True
      WordWrap = True
    end
    object lblEFT: TLabel
      Left = 189
      Top = 233
      Width = 108
      Height = 15
      HelpContext = 606009
      Caption = 'Add Payout to E.F.T.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label36: TLabel
      Left = 367
      Top = 188
      Width = 30
      Height = 19
      HelpContext = 606010
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Net'
      Transparent = True
      WordWrap = True
    end
    object Label35: TLabel
      Left = 367
      Top = 156
      Width = 30
      Height = 19
      HelpContext = 606011
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Tax :'
      Transparent = True
      WordWrap = True
    end
    object Label34: TLabel
      Left = 319
      Top = 124
      Width = 78
      Height = 19
      HelpContext = 606012
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Lump Sums :'
      Transparent = True
      WordWrap = True
    end
    object Label33: TLabel
      Left = 320
      Top = 58
      Width = 77
      Height = 33
      HelpContext = 606013
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Gross   (Steps 1 - 6) :'
      Transparent = True
      WordWrap = True
    end
    object Label47: TLabel
      Left = 335
      Top = 32
      Width = 62
      Height = 19
      HelpContext = 606014
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Date Paid'
      Transparent = True
    end
    object Bevel2: TBevel
      Left = 576
      Top = 17
      Width = 206
      Height = 195
      HelpContext = 606015
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label38: TLabel
      Left = 341
      Top = 227
      Width = 428
      Height = 38
      HelpContext = 606016
      AutoSize = False
      Caption = 
        'Click the "Save button" to now Automate the Termination of this ' +
        'Employee or Cancel to Abort the Operation.'
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 322
      Top = 96
      Width = 74
      Height = 19
      HelpContext = 606017
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pay Gross :'
      Transparent = True
      WordWrap = True
    end
    object chkAddToEft: TCheckBox
      Left = 171
      Top = 233
      Width = 14
      Height = 16
      HelpContext = 606018
      TabOrder = 0
      OnClick = chkAddToEftClick
    end
    object dtpDate: TwwDBDateTimePicker
      Left = 407
      Top = 30
      Width = 137
      Height = 23
      HelpContext = 606019
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'EndDate'
      DataSource = DSEmpTerminate
      Date = 38105.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
    end
    object btnPreviewPreETPStatement: TDNMSpeedButton
      Left = 592
      Top = 77
      Width = 177
      Height = 27
      HelpContext = 606020
      Caption = 'Preview &Pre-ETP Statement'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      OnClick = btnPreviewPreETPStatementClick
    end
    object btnPreviewETPStatement: TDNMSpeedButton
      Left = 592
      Top = 30
      Width = 177
      Height = 27
      HelpContext = 606021
      Caption = 'Preview &ETP Statement'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      OnClick = btnPreviewETPStatementClick
    end
    object btnPreviewRollover: TDNMSpeedButton
      Left = 592
      Top = 124
      Width = 177
      Height = 27
      HelpContext = 606022
      Caption = 'Preview Rollover Statement'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      OnClick = btnPreviewRolloverClick
    end
    object edLumpA: TwwDBEdit
      Left = 160
      Top = 30
      Width = 113
      Height = 23
      HelpContext = 606023
      DataField = 'LumpSumA'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edLumpB: TwwDBEdit
      Left = 160
      Top = 62
      Width = 113
      Height = 23
      HelpContext = 606024
      DataField = 'LumpSumB'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edLumpC: TwwDBEdit
      Left = 160
      Top = 94
      Width = 113
      Height = 23
      HelpContext = 606025
      DataField = 'LumpSumC'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edLumpD: TwwDBEdit
      Left = 160
      Top = 126
      Width = 113
      Height = 23
      HelpContext = 606026
      DataField = 'LumpSumD'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edLumpE: TwwDBEdit
      Left = 160
      Top = 158
      Width = 113
      Height = 23
      HelpContext = 606027
      DataField = 'LumpSumE'
      DataSource = DSEmpTerminate
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
    object edGross: TwwDBEdit
      Left = 408
      Top = 62
      Width = 113
      Height = 23
      HelpContext = 606028
      DataField = 'Gross'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edTotalLumps: TwwDBEdit
      Left = 408
      Top = 122
      Width = 113
      Height = 23
      HelpContext = 606029
      DataField = 'TotalLumpSums'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edTax: TwwDBEdit
      Left = 408
      Top = 154
      Width = 113
      Height = 23
      HelpContext = 606030
      DataField = 'Tax'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edNet: TwwDBEdit
      Left = 408
      Top = 186
      Width = 113
      Height = 23
      HelpContext = 606031
      DataField = 'Net'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object btnPreviewPaySlip: TDNMSpeedButton
      Left = 592
      Top = 172
      Width = 177
      Height = 25
      HelpContext = 606032
      Caption = 'Preview Payslip'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 14
      OnClick = btnPreviewPaySlipClick
    end
    object wwDBEdit1: TwwDBEdit
      Left = 408
      Top = 94
      Width = 113
      Height = 23
      HelpContext = 606033
      DataField = 'PayGross'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DSEmpTerminate: TDataSource
    Left = 512
  end
end
