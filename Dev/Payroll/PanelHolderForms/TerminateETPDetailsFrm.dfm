inherited frmTerminateETPDetails: TfrmTerminateETPDetails
  Left = 1282
  Top = 216
  HelpContext = 584000
  Caption = 'frmTerminateETPDetails'
  ClientHeight = 442
  ClientWidth = 886
  OldCreateOrder = True
  ExplicitWidth = 902
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 16
    Top = 40
    Width = 799
    Height = 283
    HelpContext = 584001
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
      HelpContext = 584002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label22: TLabel
      Left = 60
      Top = 18
      Width = 389
      Height = 19
      HelpContext = 584003
      AutoSize = False
      Caption = 'Please enter the details of the Eligible Termination Payment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label49: TLabel
      Left = 96
      Top = 44
      Width = 321
      Height = 29
      HelpContext = 584004
      AutoSize = False
      Caption = 
        'All values that are entered here should be whole dollars. Do not' +
        ' include Superannuation'
      Transparent = True
      WordWrap = True
    end
    object Label65: TLabel
      Left = 17
      Top = 90
      Width = 91
      Height = 15
      HelpContext = 584005
      Caption = 'Early retirement'
    end
    object Label57: TLabel
      Left = 16
      Top = 116
      Width = 70
      Height = 15
      HelpContext = 584006
      Caption = 'Redundancy'
    end
    object Label58: TLabel
      Left = 16
      Top = 146
      Width = 49
      Height = 15
      HelpContext = 584007
      Caption = 'Invalidity'
    end
    object Label61: TLabel
      Left = 16
      Top = 176
      Width = 81
      Height = 15
      HelpContext = 584008
      Caption = 'Unused RDO'#39's'
    end
    object Label59: TLabel
      Left = 16
      Top = 204
      Width = 33
      Height = 15
      HelpContext = 584009
      Caption = 'Death'
    end
    object Label66: TLabel
      Left = 32
      Top = 246
      Width = 37
      Height = 15
      HelpContext = 584010
      Caption = 'TOTAL'
    end
    object Label62: TLabel
      Left = 273
      Top = 86
      Width = 57
      Height = 15
      HelpContext = 584011
      Caption = 'Pay in lieu'
    end
    object Label63: TLabel
      Left = 273
      Top = 116
      Width = 106
      Height = 15
      HelpContext = 584012
      Caption = 'Golden Handshake'
    end
    object Label64: TLabel
      Left = 273
      Top = 147
      Width = 83
      Height = 15
      HelpContext = 584013
      Caption = 'Job loss comp'
    end
    object Label54: TLabel
      Left = 275
      Top = 174
      Width = 71
      Height = 15
      HelpContext = 584014
      Caption = 'Unused Sick'
    end
    object Label60: TLabel
      Left = 275
      Top = 204
      Width = 32
      Height = 15
      HelpContext = 584015
      Caption = 'Other'
    end
    object Label55: TLabel
      Left = 240
      Top = 246
      Width = 107
      Height = 15
      HelpContext = 584016
      Caption = 'Amount to roll over'
    end
    object Bevel2: TBevel
      Left = 521
      Top = 41
      Width = 262
      Height = 200
      HelpContext = 584017
      Shape = bsFrame
    end
    object Label23: TLabel
      Left = 558
      Top = 60
      Width = 94
      Height = 19
      HelpContext = 584018
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pre July 1983 :'
      Transparent = True
      WordWrap = True
    end
    object Label24: TLabel
      Left = 507
      Top = 92
      Width = 145
      Height = 19
      HelpContext = 584019
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Post June 1983 :'
      Transparent = True
      WordWrap = True
    end
    object Label25: TLabel
      Left = 507
      Top = 127
      Width = 145
      Height = 19
      HelpContext = 584020
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Post June 1994 :'
      Transparent = True
      WordWrap = True
    end
    object Label26: TLabel
      Left = 509
      Top = 175
      Width = 145
      Height = 19
      HelpContext = 584021
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Taxable ETP Amount :'
      Transparent = True
      WordWrap = True
    end
    object Label27: TLabel
      Left = 509
      Top = 207
      Width = 145
      Height = 19
      HelpContext = 584022
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Tax Free ETP Amount :'
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 576
      Top = 144
      Width = 57
      Height = 15
      HelpContext = 584023
      Caption = '(Invalidity)'
    end
    object edtEarlyRetire: TwwDBEdit
      Left = 120
      Top = 84
      Width = 113
      Height = 23
      HelpContext = 584024
      DataField = 'ETPEarlyRetirement'
      DataSource = DSEmpTerminate
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtOtherETP: TwwDBEdit
      Left = 384
      Top = 200
      Width = 113
      Height = 23
      HelpContext = 584025
      DataField = 'ETPOther'
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
    object edtRedundancy: TwwDBEdit
      Left = 120
      Top = 113
      Width = 113
      Height = 23
      HelpContext = 584026
      DataField = 'ETPRedundancy'
      DataSource = DSEmpTerminate
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtInvalidity: TwwDBEdit
      Left = 120
      Top = 142
      Width = 113
      Height = 23
      HelpContext = 584027
      DataField = 'ETPInvalidity'
      DataSource = DSEmpTerminate
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtSick: TwwDBEdit
      Left = 384
      Top = 171
      Width = 113
      Height = 23
      HelpContext = 584028
      DataField = 'ETPUnusedSick'
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
    object edtJobLoss: TwwDBEdit
      Left = 384
      Top = 142
      Width = 113
      Height = 23
      HelpContext = 584029
      DataField = 'ETPJobLossComp'
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
    object edtGoldenHandshake: TwwDBEdit
      Left = 384
      Top = 113
      Width = 113
      Height = 23
      HelpContext = 584030
      DataField = 'ETPGoldenHandshake'
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
    object edtPayInLieu: TwwDBEdit
      Left = 384
      Top = 84
      Width = 113
      Height = 23
      HelpContext = 584031
      DataField = 'ETPPayInLieu'
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
    object edtRDOs: TwwDBEdit
      Left = 120
      Top = 171
      Width = 113
      Height = 23
      HelpContext = 584032
      DataField = 'ETPUnusedRDOs'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtDeath: TwwDBEdit
      Left = 120
      Top = 200
      Width = 113
      Height = 23
      HelpContext = 584033
      DataField = 'ETPDeath'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtTotals: TwwDBEdit
      Left = 80
      Top = 240
      Width = 121
      Height = 23
      HelpContext = 584034
      DataField = 'ETPTotal'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtRollOver: TwwDBEdit
      Left = 368
      Top = 240
      Width = 113
      Height = 23
      HelpContext = 584035
      DataField = 'ETPRollover'
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
    object edtPreJuly1983: TwwDBEdit
      Left = 664
      Top = 56
      Width = 113
      Height = 23
      HelpContext = 584036
      DataField = 'ETPpre071983'
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
    object edPostJune1983: TwwDBEdit
      Left = 664
      Top = 89
      Width = 113
      Height = 23
      HelpContext = 584037
      DataField = 'ETPpost061983Untaxed'
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
    object wwDBEdit2: TwwDBEdit
      Left = 664
      Top = 123
      Width = 113
      Height = 23
      HelpContext = 584038
      DataField = 'ETPpost061994Component'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit3: TwwDBEdit
      Left = 662
      Top = 171
      Width = 113
      Height = 23
      HelpContext = 584039
      DataField = 'ETPpost061983Untaxed'
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
    object wwDBEdit4: TwwDBEdit
      Left = 662
      Top = 203
      Width = 113
      Height = 23
      HelpContext = 584040
      DataField = 'ETPtaxfree'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DSEmpTerminate: TDataSource
    Left = 512
  end
end
