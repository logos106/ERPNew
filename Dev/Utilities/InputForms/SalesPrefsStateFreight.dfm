object SalesPrefsStateFreightGUI: TSalesPrefsStateFreightGUI
  Left = 0
  Top = 0
  HelpContext = 1553002
  Caption = 'SalesPrefsStateFreightGUI'
  ClientHeight = 222
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlStateFreight: TDNMPanel
    Left = 16
    Top = 12
    Width = 545
    Height = 149
    HelpContext = 1553003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      545
      149)
    object Bevel8: TBevel
      Left = 7
      Top = 7
      Width = 532
      Height = 136
      HelpContext = 1553004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitHeight = 128
    end
    object Label7: TLabel
      Left = 14
      Top = 14
      Width = 72
      Height = 15
      HelpContext = 1553005
      Caption = 'State Freight'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 21
      Top = 87
      Width = 131
      Height = 15
      HelpContext = 1553007
      Caption = 'Freight Charge Product'
      Transparent = True
    end
    object Label1: TLabel
      Left = 168
      Top = 113
      Width = 183
      Height = 15
      HelpContext = 1553008
      Caption = '( Must be "Other" Product Type )'
      Transparent = True
    end
    object chkStateFreightEnabled: TwwCheckBox
      Left = 19
      Top = 47
      Width = 238
      Height = 17
      HelpContext = 1553009
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Enabled State Freight Charges'
      TabOrder = 0
    end
    object cboFreightProduct: TwwDBLookupCombo
      Left = 168
      Top = 84
      Width = 329
      Height = 23
      HelpContext = 1553010
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PartName'#9'25'#9'Name'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F')
      LookupTable = qryProductLookup
      LookupField = 'PartName'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object btnShowStateFreightList: TDNMSpeedButton
      Left = 360
      Top = 40
      Width = 137
      Height = 27
      HelpContext = 1553011
      Caption = 'State Freight List'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Tahoma'
      HotTrackFont.Style = []
      TabOrder = 2
      OnClick = btnShowStateFreightListClick
    end
  end
  object qryProductLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select PartName, PartsDescription  from tblparts where PartType ' +
        '= "OTHER" order by PartName')
    FetchAll = False
    Left = 400
    Top = 112
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 190
    Top = 1
  end
end
