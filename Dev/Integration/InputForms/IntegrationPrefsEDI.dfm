object ItegrationPrefsEDIGUI: TItegrationPrefsEDIGUI
  Left = 196
  Top = 119
  Caption = 'ItegrationPrefsEDIGUI'
  ClientHeight = 509
  ClientWidth = 577
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlEDIConfig: TDNMPanel
    Left = -2
    Top = 0
    Width = 548
    Height = 446
    HelpContext = 1686003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      548
      446)
    object Bevel8: TBevel
      Left = 6
      Top = 7
      Width = 536
      Height = 433
      HelpContext = 1686004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitWidth = 606
      ExplicitHeight = 460
    end
    object Label4: TLabel
      Left = 14
      Top = 11
      Width = 18
      Height = 15
      HelpContext = 1686005
      Caption = 'EDI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 28
      Top = 56
      Width = 22
      Height = 15
      HelpContext = 1686005
      Caption = 'X12'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object chkShowEDIOnMainMenuByDefault: TwwCheckBox
      Left = 74
      Top = 86
      Width = 235
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Show EDI on Main Menu by Default'
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object btnHelp: TDNMSpeedButton
      Left = 446
      Top = 76
      Width = 49
      Height = 27
      Caption = 'Help'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnHelpClick
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 9
      Top = 103
      Width = 530
      Height = 334
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      ExplicitTop = 0
      ExplicitWidth = 600
      DesignSize = (
        530
        334)
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 35
        Width = 524
        Height = 296
        HelpContext = 1686004
        Align = alBottom
        Shape = bsFrame
        ExplicitLeft = 5
        ExplicitTop = 39
        ExplicitWidth = 594
      end
      object Bevel1: TBevel
        Left = 143
        Top = 35
        Width = 190
        Height = 296
        HelpContext = 1686004
        Anchors = [akLeft, akTop, akBottom]
        Shape = bsFrame
      end
      object lblTitle: TLabel
        Left = 172
        Top = 18
        Width = 17
        Height = 15
        HelpContext = 1686005
        Caption = 'PO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 371
        Top = 18
        Width = 40
        Height = 15
        HelpContext = 1686005
        Caption = 'Invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 78
        Top = 48
        Width = 59
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Enable EDI'
        Transparent = True
      end
      object Label2: TLabel
        Left = 60
        Top = 89
        Width = 77
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Sender Name'
        Transparent = True
      end
      object Label9: TLabel
        Left = 62
        Top = 131
        Width = 75
        Height = 15
        HelpContext = 1686007
        Alignment = taRightJustify
        Caption = 'Ready Status'
        Transparent = True
      end
      object Label10: TLabel
        Left = 71
        Top = 172
        Width = 66
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Sent Status'
        Transparent = True
      end
      object Label1: TLabel
        Left = 20
        Top = 214
        Width = 117
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Acknowledge Status'
        Transparent = True
      end
      object Label3: TLabel
        Left = 51
        Top = 255
        Width = 86
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Shipped Status'
        Transparent = True
      end
      object Label6: TLabel
        Left = 17
        Top = 297
        Width = 120
        Height = 15
        HelpContext = 1686006
        Alignment = taRightJustify
        Caption = 'Auto Synch From List'
        Transparent = True
      end
      object chkAutoSynchFromList: TwwCheckBox
        Left = 149
        Top = 296
        Width = 17
        Height = 17
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object chkAutoSynchFromSalesList: TwwCheckBox
        Left = 336
        Top = 296
        Width = 17
        Height = 17
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        TabOrder = 1
        OnClick = CheckBoxClick
      end
      object edtSaleshippedStatus: TEdit
        Left = 336
        Top = 251
        Width = 180
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = edtChange
      end
      object edtPOShippedStatus: TEdit
        Left = 149
        Top = 251
        Width = 180
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edtChange
      end
      object edtPOAcknowledgementStatus: TEdit
        Left = 149
        Top = 209
        Width = 180
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = edtChange
      end
      object edtPOSentStatus: TEdit
        Left = 149
        Top = 168
        Width = 180
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnChange = edtChange
      end
      object edtPOReadyStatus: TEdit
        Left = 149
        Top = 126
        Width = 180
        Height = 23
        HelpContext = 1686012
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnChange = edtChange
      end
      object edtDocSenderCode: TEdit
        Left = 149
        Top = 85
        Width = 180
        Height = 23
        Hint = 'Contact ERP Support to obtain a Document Sender Code'
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnChange = edtChange
      end
      object chkEnableEDI: TwwCheckBox
        Left = 149
        Top = 48
        Width = 17
        Height = 17
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        TabOrder = 8
        OnClick = CheckBoxClick
      end
      object chkEnableSalesEDI: TwwCheckBox
        Left = 336
        Top = 48
        Width = 17
        Height = 17
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        TabOrder = 9
        OnClick = CheckBoxClick
      end
      object edtSalesDocSenderCode: TEdit
        Left = 336
        Top = 85
        Width = 180
        Height = 23
        Hint = 'Contact ERP Support to obtain a Document Sender Code'
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnChange = edtChange
      end
      object edtSalesReadyStatus: TEdit
        Left = 336
        Top = 126
        Width = 180
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnChange = edtChange
      end
      object edtSalesSentStatus: TEdit
        Left = 336
        Top = 168
        Width = 180
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        OnChange = edtChange
      end
      object edtSalesAcknowledgementStatus: TEdit
        Left = 336
        Top = 209
        Width = 180
        Height = 23
        HelpContext = 1686011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnChange = edtChange
      end
    end
  end
end
