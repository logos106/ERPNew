inherited fmSiteIntergrationTestSteps: TfmSiteIntergrationTestSteps
  Left = 221
  Top = 302
  Caption = 'Site Intergration Test'
  Scaled = False
  OnDestroy = FormDestroy
  ExplicitLeft = 221
  ExplicitTop = 302
  ExplicitWidth = 936
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 935001
  inherited pnlMain: TDNMPanel
    HelpContext = 935006
    object Label1: TLabel [0]
      Left = 12
      Top = 65
      Width = 94
      Height = 15
      Caption = 'Configured Sites'
      HelpContext = 935002
    end
    inherited ScrollBox: TScrollBox
      Left = 9
      Top = 95
      Height = 394
      ExplicitLeft = 9
      ExplicitTop = 95
      ExplicitHeight = 394
      HelpContext = 935003
    end
    inherited btnTest: TDNMSpeedButton
      OnClick = btnTestClick
    end
    object cboSites: TwwDBComboBox
      Left = 116
      Top = 62
      Width = 293
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = False
      TabOrder = 4
      UnboundDataType = wwDefault
      OnCloseUp = cboSitesCloseUp
      HelpContext = 935004
    end
    object chkRemoteTested: TwwCheckBox
      Left = 435
      Top = 65
      Width = 318
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'WebAPI tests have been run on remote ERP Server. '
      TabOrder = 5
      HelpContext = 935005
    end
  end
end
