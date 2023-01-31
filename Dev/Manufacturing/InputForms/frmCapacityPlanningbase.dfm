inherited fmCapacityPlanningbase: TfmCapacityPlanningbase
  Left = 415
  Top = 339
  Caption = 'fmCapacityPlanningbase'
  ClientHeight = 618
  ClientWidth = 1016
  Constraints.MinHeight = 645
  Constraints.MinWidth = 1004
  Position = poMainFormCenter
  ExplicitLeft = 415
  ExplicitTop = 339
  ExplicitWidth = 1032
  ExplicitHeight = 657
  DesignSize = (
    1016
    618)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 602
    Width = 1016
    ExplicitTop = 597
    ExplicitWidth = 1163
  end
  inherited shapehint: TShape
    Left = 11
    ExplicitLeft = 14
  end
  inherited shapehintextra1: TShape
    Left = 52
    ExplicitLeft = 62
  end
  object lblMsg: TLabel [4]
    Left = 0
    Top = 602
    Width = 1016
    Height = 16
    Align = alBottom
    Alignment = taCenter
    Caption = 'As per the Preferences, Capacity planner displays  7 Weeks. '
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 358
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 1016
    Height = 136
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      1016
      136)
    object Label1: TLabel
      Left = 830
      Top = 7
      Width = 33
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'From'
      Transparent = True
    end
    object Label5: TLabel
      Left = 46
      Top = 42
      Width = 98
      Height = 16
      Caption = 'Show Finalised'
      Transparent = True
    end
    object pnlOptions: TDNMPanel
      Left = 1
      Top = 63
      Width = 717
      Height = 60
      Anchors = [akLeft, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      DesignSize = (
        717
        60)
      object Label4: TLabel
        Left = 7
        Top = 3
        Width = 27
        Height = 16
        Caption = 'Cust'
        Transparent = True
      end
      object lblResource: TLabel
        Left = 150
        Top = 3
        Width = 59
        Height = 16
        Caption = 'Resource'
        Transparent = True
      end
      object Label3: TLabel
        Left = 292
        Top = 3
        Width = 49
        Height = 16
        Caption = 'Process'
        Transparent = True
      end
      object Label7: TLabel
        Left = 419
        Top = 3
        Width = 80
        Height = 16
        Caption = 'Sale Order #'
        Transparent = True
      end
      object lblSelectionoption: TLabel
        Left = 528
        Top = 13
        Width = 155
        Height = 36
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        Caption = 'Show Selection Options before load'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 135
      end
      object cboCustomers: TComboBox
        Left = 7
        Top = 24
        Width = 139
        Height = 24
        AutoDropDown = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnCloseUp = cboCustomersCloseUp
      end
      object cboResource: TComboBox
        Left = 152
        Top = 25
        Width = 139
        Height = 24
        AutoDropDown = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnCloseUp = cboResourceCloseUp
      end
      object cboResourceProcess: TComboBox
        Left = 292
        Top = 24
        Width = 123
        Height = 24
        AutoDropDown = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnCloseUp = cboResourceProcessCloseUp
      end
      object cboSOIds: TComboBox
        Left = 419
        Top = 24
        Width = 110
        Height = 24
        AutoDropDown = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnCloseUp = cboSOIdsCloseUp
      end
      object chkSelectionoption: TwwCheckBox
        Left = 687
        Top = 21
        Width = 18
        Height = 19
        TabStop = False
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
        Anchors = [akRight]
        Caption = 'chkSelectionoption'
        TabOrder = 4
        OnClick = chkSelectionoptionClick
      end
    end
    object edtDateFrom: TwwDBDateTimePicker
      Left = 830
      Top = 28
      Width = 87
      Height = 24
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 0
      OnChange = edtDateFromChange
    end
    object pnlTitle: TDNMPanel
      Left = 288
      Top = 7
      Width = 345
      Height = 45
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 1
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 343
        Height = 43
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 343
          Height = 43
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Capacity Planning'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -33
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 322
        end
      end
    end
    object btnRequery: TDNMSpeedButton
      Left = 20
      Top = 5
      Width = 123
      Height = 29
      Action = actRefresh
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
    end
    object chkShowFinalised: TwwCheckBox
      Left = 20
      Top = 41
      Width = 19
      Height = 19
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Show Finalised'
      TabOrder = 3
      OnClick = chkShowFinalisedClick
    end
    object btnPrevPage: TDNMSpeedButton
      Left = 735
      Top = 7
      Width = 86
      Height = 45
      Hint = 
        'Select this to refresh the list to display the first '#39'scheduled'#39 +
        ' or '#39'Started'#39' in the database'
      Anchors = [akTop, akRight]
      Caption = 'Previous Page'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF3333333333333744333333333333F773333333333337
        44473333333333F777F3333333333744444333333333F7733733333333374444
        4433333333F77333733333333744444447333333F7733337F333333744444444
        433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
        9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
        C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
        CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
        CCC333333333333777FF33333333333333CC3333333333333773}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnPrevPageClick
    end
    object btnNext: TDNMSpeedButton
      Left = 926
      Top = 7
      Width = 87
      Height = 45
      Hint = 
        'Select this to refresh the list to display the first '#39'scheduled'#39 +
        ' or '#39'Started'#39' in the database'
      Anchors = [akTop, akRight]
      Caption = '   Next          Page      '
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333447333333333333374447333333333333444447333333333334444447333
        3333337444444473333333344444444473333333444444444473999999999999
        99993333CCCCCCCCCC33333CCCCCCCCC3333333CCCCCCC33333333CCCCCC3333
        33333CCCCC33333333333CCC333333333333CC33333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Layout = blGlyphRight
      NumGlyphs = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNextClick
    end
    object btnfirstpage: TDNMSpeedButton
      Left = 640
      Top = 7
      Width = 87
      Height = 45
      Hint = 
        'Select this to refresh the list to display the first '#39'scheduled'#39 +
        ' or '#39'Started'#39' in the database'
      Anchors = [akTop, akRight]
      Caption = 'First Page'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnfirstpageClick
    end
    object DNMPanel1: TDNMPanel
      Left = 724
      Top = 63
      Width = 289
      Height = 60
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object grpGridDetail: TwwRadioGroup
        Left = 0
        Top = 0
        Width = 289
        Height = 60
        DisableThemes = False
        ItemIndex = 0
        TransparentActiveItem = True
        ShowGroupCaption = False
        Transparent = True
        Align = alClient
        Caption = 'Caption'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'Summary'
          'Detail'
          'Extra Detail')
        ParentFont = False
        TabOrder = 0
        OnChange = grpGridDetailChange
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 256
    Top = 179
  end
  inherited tmrdelay: TTimer
    Left = 325
    Top = 179
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 152
    Top = 179
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 186
    Top = 179
  end
  inherited MyConnection: TERPConnection
    Left = 48
    Top = 179
  end
  inherited DataState: TDataState
    Left = 221
    Top = 179
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 290
    Top = 179
  end
  inherited imgsort: TImageList
    Left = 117
    Top = 179
    Bitmap = {
      494C01010200DC00080110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 82
    Top = 179
  end
  object ActionList: TActionList
    Left = 360
    Top = 179
    object actCancel: TAction
      Caption = 'Close'
      OnExecute = actCancelExecute
    end
    object actSave: TAction
      Caption = 'Save'
      OnExecute = actSaveExecute
    end
    object actStart: TAction
      Caption = 'Flag as Started'
    end
    object actComplete: TAction
      Caption = 'Flag as Complete'
    end
    object actScheduled: TAction
      Caption = 'Flag as Scheduled'
    end
    object actNotScheduled: TAction
      Caption = 'Flag as Not Scheduled'
    end
    object actOpenSale: TAction
      Caption = 'Open Sale'
    end
    object actProductTree: TAction
      Caption = 'Product Tree'
    end
    object actAutoSchedule: TAction
      Caption = 'Auto Schedule'
    end
    object actApply: TAction
      Caption = 'Apply'
    end
    object actCreatePickingSlip: TAction
      Caption = 'Print Picking Slip'
    end
    object actPrintWorkSheets: TAction
      Caption = 'Production Work Sheets'
    end
    object actRefresh: TAction
      Caption = 'Refresh'
      OnExecute = actRefreshExecute
    end
    object actInvoice: TAction
      Caption = 'Complete and Invoice'
    end
    object actQualityAssurance: TAction
      Caption = 'Flag as Quality Assurance'
    end
  end
end
