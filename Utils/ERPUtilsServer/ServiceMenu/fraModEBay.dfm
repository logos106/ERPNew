inherited frModEbay: TfrModEbay
  Height = 317
  OnResize = FrameResize
  ExplicitHeight = 317
  DesignSize = (
    675
    317)
  object Bevel1: TBevel
    Left = 3
    Top = 3
    Width = 669
    Height = 311
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
    ExplicitHeight = 285
  end
  object lblModuleName: TLabel
    Left = 14
    Top = 14
    Width = 91
    Height = 15
    HelpContext = 504027
    Caption = 'Ebay Integration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object pnlShowEbayonMainMenubyDefault: TDNMPanel
    Left = 292
    Top = 45
    Width = 238
    Height = 35
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 238
      Height = 35
      Align = alClient
      Brush.Style = bsClear
      Pen.Color = clMaroon
      ExplicitWidth = 230
      ExplicitHeight = 33
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 236
      Height = 33
      HelpContext = 504027
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      Alignment = taCenter
      Caption = 
        'Ebay on Main Menu will Only be Available if the Database is Sele' +
        'cted for Ebay in the List Below'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 229
      ExplicitHeight = 28
    end
  end
  object btnShowLog: TDNMSpeedButton
    Left = 614
    Top = 8
    Width = 49
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Log'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 0
    AutoDisableParentOnclick = True
    OnClick = btnShowLogClick
    ExplicitLeft = 476
  end
  object btnAddSite: TButton
    Left = 614
    Top = 87
    Width = 49
    Height = 25
    Anchors = [akRight]
    Caption = 'Add'
    TabOrder = 1
    OnClick = btnAddSiteClick
  end
  object btnEditSite: TButton
    Left = 614
    Top = 118
    Width = 49
    Height = 25
    Anchors = [akRight]
    Caption = 'Edit'
    TabOrder = 2
    OnClick = btnEditSiteClick
  end
  object btnDeleteSite: TButton
    Left = 614
    Top = 149
    Width = 49
    Height = 25
    Anchors = [akRight]
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btnDeleteSiteClick
  end
  object lvIntegrationConfig: TListView
    Left = 14
    Top = 86
    Width = 571
    Height = 216
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        Caption = 'State'
        Width = 60
      end
      item
        Caption = 'Database Name'
        Width = 150
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    GridLines = True
    RowSelect = True
    ParentFont = False
    TabOrder = 4
    ViewStyle = vsReport
  end
  object btnHelp: TDNMSpeedButton
    Left = 614
    Top = 275
    Width = 49
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Help'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = btnHelpClick
    ExplicitLeft = 476
  end
  object btnTestAccount: TDNMSpeedButton
    Left = 430
    Top = 8
    Width = 116
    Height = 27
    HelpContext = 1064075
    Anchors = [akTop, akRight]
    Caption = 'Load Test Settings'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Style = bsModern
    TabOrder = 6
    AutoDisableParentOnclick = True
    OnClick = btnTestAccountClick
    ExplicitLeft = 292
  end
  object chkShowEbayonMainMenubyDefault: TwwCheckBox
    Left = 14
    Top = 53
    Width = 277
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Show On Mainmenu By Default When Enabled'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = chkShowEbayonMainMenubyDefaultClick
  end
  object chkActive: TwwCheckBox
    Left = 14
    Top = 35
    Width = 97
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Active'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = chkActiveClick
  end
end
