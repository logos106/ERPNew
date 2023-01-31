inherited frmTerminateLongService: TfrmTerminateLongService
  Left = 230
  Top = 209
  Width = 856
  Height = 480
  Caption = 'frmTerminateLongService'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 585000
  object DNMPanel1: TDNMPanel
    Left = 0
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
    HelpContext = 585001
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 268
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      HelpContext = 585002
    end
    object Label12: TLabel
      Left = 304
      Top = 16
      Width = 249
      Height = 19
      AutoSize = False
      Caption = 'Outstanding Long Service Leave'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      HelpContext = 585003
    end
    object Bevel8: TBevel
      Left = 216
      Top = 72
      Width = 409
      Height = 161
      Shape = bsFrame
      HelpContext = 585004
    end
    object Label13: TLabel
      Left = 240
      Top = 102
      Width = 158
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Accrued Before 16 / 8 / 78 :'
      Transparent = True
      WordWrap = True
      HelpContext = 585005
    end
    object Label14: TLabel
      Left = 253
      Top = 142
      Width = 145
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Accrued After 16 / 8 / 78 :'
      Transparent = True
      WordWrap = True
      HelpContext = 585006
    end
    object Label15: TLabel
      Left = 253
      Top = 182
      Width = 145
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Accrued After 17 / 8 / 93 :'
      Transparent = True
      WordWrap = True
      HelpContext = 585007
    end
    object chkOverrideLongService: TwwCheckBox
      Left = 24
      Top = 248
      Width = 97
      Height = 17
      AlwaysTransparent = False
      Frame.Enabled = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Manual Entry'
      DataField = 'IsManualLongService'
      DataSource = DSEmpTerminate
      TabOrder = 0
      HelpContext = 585008
    end
    object wwDBEdit1: TwwDBEdit
      Left = 416
      Top = 98
      Width = 113
      Height = 23
      DataField = 'LongServicePre16081978'
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
      HelpContext = 585009
    end
    object wwDBEdit2: TwwDBEdit
      Left = 416
      Top = 136
      Width = 113
      Height = 23
      DataField = 'LongServicePost16081978'
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
      HelpContext = 585010
    end
    object wwDBEdit3: TwwDBEdit
      Left = 416
      Top = 176
      Width = 113
      Height = 23
      DataField = 'LongServicePost17081993'
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
      HelpContext = 585011
    end
  end
  object DSEmpTerminate: TDataSource
    Left = 512
  end
end
