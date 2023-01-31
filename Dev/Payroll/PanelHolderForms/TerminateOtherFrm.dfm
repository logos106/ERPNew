inherited frmTerminateOther: TfrmTerminateOther
  Left = 201
  Top = 172
  Width = 829
  Height = 480
  Caption = 'frmTerminateOther'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 586000
  object DNMPanel1: TDNMPanel
    Left = 6
    Top = 40
    Width = 799
    Height = 283
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
    HelpContext = 586001
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 268
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      HelpContext = 586002
    end
    object Label53: TLabel
      Left = 329
      Top = 32
      Width = 129
      Height = 17
      AutoSize = False
      Caption = 'Other Payments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      HelpContext = 586003
    end
    object Bevel6: TBevel
      Left = 170
      Top = 77
      Width = 481
      Height = 153
      Shape = bsFrame
      HelpContext = 586004
    end
    object Label45: TLabel
      Left = 215
      Top = 116
      Width = 86
      Height = 15
      Alignment = taRightJustify
      Caption = 'Payment Type :'
      Transparent = True
      HelpContext = 586005
    end
    object lblAmount: TLabel
      Left = 172
      Top = 172
      Width = 145
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Payment Amount'
      Enabled = False
      Transparent = True
      WordWrap = True
      HelpContext = 586006
    end
    object cboOtherPayments: TwwDBComboBox
      Left = 326
      Top = 114
      Width = 243
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'OtherPaymentType'
      DataSource = DSEmpTerminate
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'None'
        'Back Payment of Salary or Wages'
        'Return to Work Payment'
        '')
      ParentFont = False
      Sorted = False
      TabOrder = 0
      UnboundDataType = wwDefault
      OnCloseUp = cboOtherPaymentsCloseUp
      HelpContext = 586007
    end
    object edAmount: TwwDBEdit
      Left = 408
      Top = 168
      Width = 161
      Height = 23
      DataField = 'OtherPaymentAmount'
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
      HelpContext = 586008
    end
  end
  object DSEmpTerminate: TDataSource
    Left = 512
  end
end
