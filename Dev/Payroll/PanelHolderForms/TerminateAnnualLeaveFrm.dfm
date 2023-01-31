inherited frmTerminateAnnualLeave: TfrmTerminateAnnualLeave
  Left = 1227
  Top = 126
  Width = 811
  Height = 480
  HelpContext = 581000
  Caption = 'frmTerminateAnnualLeave'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 0
    Top = 40
    Width = 799
    Height = 283
    HelpContext = 581001
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
      HelpContext = 581002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label16: TLabel
      Left = 307
      Top = 21
      Width = 209
      Height = 19
      HelpContext = 581003
      AutoSize = False
      Caption = 'Outstanding Annual Leave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel5: TBevel
      Left = 75
      Top = 64
      Width = 657
      Height = 171
      HelpContext = 581004
      Shape = bsFrame
    end
    object Label19: TLabel
      Left = 107
      Top = 82
      Width = 593
      Height = 17
      HelpContext = 581005
      AutoSize = False
      Caption = 
        'If this employee is NOT entitled to Leave Loading you may need t' +
        'o  check Manual entry and set fields to 0'
      Transparent = True
      WordWrap = True
    end
    object Label18: TLabel
      Left = 96
      Top = 128
      Width = 158
      Height = 19
      HelpContext = 581006
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Accrued Before 18 / 8 / 93 :'
      Transparent = True
      WordWrap = True
    end
    object Label21: TLabel
      Left = 430
      Top = 125
      Width = 110
      Height = 19
      HelpContext = 581007
      Alignment = taRightJustify
      AutoSize = False
      Caption = ' Leave Loading :'
      Transparent = True
      WordWrap = True
    end
    object Label41: TLabel
      Left = 427
      Top = 176
      Width = 113
      Height = 19
      HelpContext = 581008
      Alignment = taRightJustify
      AutoSize = False
      Caption = ' Leave Loading :'
      Transparent = True
      WordWrap = True
    end
    object Label20: TLabel
      Left = 97
      Top = 176
      Width = 158
      Height = 19
      HelpContext = 581009
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Accrued After 17 / 8 / 93 :'
      Transparent = True
      WordWrap = True
    end
    object wwDBEdit1: TwwDBEdit
      Left = 272
      Top = 120
      Width = 137
      Height = 23
      HelpContext = 581010
      DataField = 'AnnualLeavePre18081993'
      DataSource = DSEmpTerminate
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
    object wwDBEdit2: TwwDBEdit
      Left = 272
      Top = 168
      Width = 137
      Height = 23
      HelpContext = 581011
      DataField = 'AnnualLeavePost17081993'
      DataSource = DSEmpTerminate
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
    object wwDBEdit3: TwwDBEdit
      Left = 544
      Top = 120
      Width = 137
      Height = 23
      HelpContext = 581012
      DataField = 'AnnLeaveLoadingPre18081993'
      DataSource = DSEmpTerminate
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
    object wwDBEdit4: TwwDBEdit
      Left = 544
      Top = 168
      Width = 137
      Height = 23
      HelpContext = 581013
      DataField = 'AnnLeaveLoadingPost17081993'
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
    object chkOverrideAnnualLeave: TwwCheckBox
      Left = 32
      Top = 248
      Width = 97
      Height = 17
      HelpContext = 581014
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Manual entry'
      DataField = 'IsManualAnnualLeave'
      DataSource = DSEmpTerminate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
  end
  object DSEmpTerminate: TDataSource
    Left = 512
  end
end
