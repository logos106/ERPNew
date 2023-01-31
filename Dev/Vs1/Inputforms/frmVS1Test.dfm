inherited fmVS1Test: TfmVS1Test
  Caption = 'VS1 Test'
  ClientWidth = 996
  ExplicitWidth = 1012
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 483
    Width = 996
    ExplicitTop = 483
    ExplicitWidth = 996
  end
  inherited shapehint: TShape
    Left = 9
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 996
    Height = 49
    HelpContext = 1647005
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      49)
    object pnlTitle: TDNMPanel
      Left = 222
      Top = 9
      Width = 553
      Height = 31
      HelpContext = 1647007
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 551
        Height = 29
        HelpContext = 1647008
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
          Width = 551
          Height = 29
          HelpContext = 1647009
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'VS1 Test'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 7
          ExplicitWidth = 513
          ExplicitHeight = 50
        end
      end
    end
  end
  object pnlButtons: TDNMPanel [6]
    Left = 0
    Top = 483
    Width = 996
    Height = 49
    HelpContext = 1647024
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      996
      49)
    object lblMsg: TLabel
      Left = 1
      Top = 1
      Width = 994
      Height = 15
      Margins.Top = 11
      Margins.Bottom = 11
      Align = alTop
      Alignment = taCenter
      Caption = 'Server'
      Visible = False
      ExplicitWidth = 38
    end
    object cmdClose: TDNMSpeedButton
      Left = 455
      Top = 17
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 49
    Width = 996
    Height = 49
    HelpContext = 1647024
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object DNMPanel3: TDNMPanel
      Left = 1
      Top = 1
      Width = 202
      Height = 47
      HelpContext = 1647024
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        202
        47)
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 200
        Height = 15
        Align = alTop
        Alignment = taCenter
        Caption = 'VS1 cloud Server IP Address'
        ExplicitWidth = 163
      end
      object edtIP: TEdit
        Left = 7
        Top = 19
        Width = 190
        Height = 23
        Anchors = [akTop]
        TabOrder = 0
        Text = '192.168.1.100'
        OnExit = edtIPExit
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 203
      Top = 1
      Width = 202
      Height = 47
      HelpContext = 1647024
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        202
        47)
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 200
        Height = 15
        Align = alTop
        Alignment = taCenter
        Caption = 'Email ID'
        ExplicitWidth = 45
      end
      object edtUserNameToSearch: TEdit
        Left = 6
        Top = 18
        Width = 190
        Height = 23
        Anchors = [akTop]
        TabOrder = 0
        OnExit = edtUserNameToSearchExit
      end
    end
    object btnRequery: TDNMSpeedButton
      AlignWithMargins = True
      Left = 610
      Top = 8
      Width = 85
      Height = 33
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alLeft
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      OnClick = btnRequeryClick
    end
    object DNMPanel5: TDNMPanel
      Left = 405
      Top = 1
      Width = 202
      Height = 47
      HelpContext = 1647024
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        202
        47)
      object Label3: TLabel
        Left = 1
        Top = 1
        Width = 200
        Height = 15
        Align = alTop
        Alignment = taCenter
        Caption = 'VS1 Admin DB'
        ExplicitWidth = 81
      end
      object cboVs1CloudServerDB: TwwDBComboBox
        Left = 6
        Top = 18
        Width = 190
        Height = 23
        HelpContext = 305015
        Anchors = [akLeft, akRight, akBottom]
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        AutoDropDown = True
        AutoFillDate = False
        AutoSize = False
        Column1Width = 215
        DropDownCount = 8
        DropDownWidth = 350
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
        TwoColumnDisplay = True
      end
    end
  end
  object DNMPanel8: TDNMPanel [8]
    Left = 0
    Top = 98
    Width = 350
    Height = 385
    HelpContext = 1647024
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label4: TLabel
      AlignWithMargins = True
      Left = 48
      Top = 8
      Width = 54
      Height = 15
      Margins.Top = 11
      Margins.Bottom = 11
      Caption = 'Database'
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 203
      Top = 8
      Width = 38
      Height = 15
      Margins.Top = 11
      Margins.Bottom = 11
      Caption = 'Server'
    end
    object edtVS1Database: TwwDBEdit
      Left = 9
      Top = 32
      Width = 147
      Height = 23
      DataField = 'DatabaseName'
      DataSource = dsVS1Users
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtVS1DBServer: TwwDBEdit
      Left = 185
      Top = 32
      Width = 147
      Height = 23
      DataField = 'ServerName'
      DataSource = dsVS1Users
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit10: TwwDBEdit
      Left = 9
      Top = 61
      Width = 147
      Height = 23
      DataField = 'CUDataabse'
      DataSource = dsVS1Users
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit11: TwwDBEdit
      Left = 185
      Top = 61
      Width = 147
      Height = 23
      DataField = 'CServer'
      DataSource = dsVS1Users
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object DNMPanel6: TDNMPanel
      Left = 1
      Top = 90
      Width = 348
      Height = 294
      HelpContext = 1647024
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label6: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 6
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Region'
        ExplicitWidth = 39
      end
      object Label7: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 31
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Status'
        ExplicitWidth = 37
      end
      object Label8: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 56
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Created On'
        ExplicitWidth = 64
      end
      object Label9: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 81
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Discontinued On'
        ExplicitWidth = 93
      end
      object Label10: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 181
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'ClientName'
        ExplicitWidth = 65
      end
      object Label11: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 156
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'APIPort'
        ExplicitWidth = 43
      end
      object Label12: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 131
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'AdminPass'
        ExplicitWidth = 65
      end
      object Label13: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 206
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'AdminUser'
        ExplicitWidth = 63
      end
      object Label14: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 106
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'AdminDB'
        ExplicitWidth = 52
      end
      object Label16: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 231
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Password'
        ExplicitWidth = 58
      end
      object Label15: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 256
        Width = 340
        Height = 15
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Email ID'
        ExplicitWidth = 45
      end
      object wwDBEdit1: TwwDBEdit
        Left = 123
        Top = 2
        Width = 147
        Height = 23
        DataField = 'Regionname'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit2: TwwDBEdit
        Left = 123
        Top = 27
        Width = 147
        Height = 23
        DataField = 'Status'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit3: TwwDBEdit
        Left = 123
        Top = 52
        Width = 147
        Height = 23
        DataField = 'CreatedOn'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit4: TwwDBEdit
        Left = 123
        Top = 77
        Width = 147
        Height = 23
        DataField = 'DiscontinuedOn'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit5: TwwDBEdit
        Left = 123
        Top = 102
        Width = 147
        Height = 23
        DataField = 'AdminDB'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit6: TwwDBEdit
        Left = 123
        Top = 202
        Width = 147
        Height = 23
        DataField = 'AdminUser'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit7: TwwDBEdit
        Left = 123
        Top = 127
        Width = 147
        Height = 23
        DataField = 'AdminPass'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit8: TwwDBEdit
        Left = 123
        Top = 152
        Width = 147
        Height = 23
        DataField = 'APIPort'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit9: TwwDBEdit
        Left = 123
        Top = 177
        Width = 147
        Height = 23
        DataField = 'ClientName'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit12: TwwDBEdit
        Left = 123
        Top = 252
        Width = 147
        Height = 23
        DataField = 'EmailId'
        DataSource = dsVS1Users
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit13: TwwDBEdit
        Left = 123
        Top = 227
        Width = 147
        Height = 23
        DataField = 'Password'
        DataSource = dsVS1Users
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
    end
  end
  object DNMPanel7: TDNMPanel [9]
    Left = 350
    Top = 98
    Width = 646
    Height = 385
    HelpContext = 1647024
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    ExplicitLeft = 351
    ExplicitTop = 100
    ExplicitWidth = 350
    object lblrecno: TLabel
      Left = 1
      Top = 369
      Width = 644
      Height = 15
      Margins.Top = 11
      Margins.Bottom = 11
      Align = alBottom
      Alignment = taCenter
      ExplicitWidth = 3
    end
    object wwDBGrid1: TwwDBGrid
      Left = 1
      Top = 41
      Width = 644
      Height = 328
      ControlType.Strings = (
        'active;CheckBox;T;F')
      Selected.Strings = (
        'Logon_Name'#9'25'#9'Logon Name'#9'F'#9
        'EmployeeName'#9'20'#9'Employee Name'#9'F'#9
        'active'#9'1'#9'Active'#9'F'#9
        'FormName'#9'20'#9'Form'#9'F'#9
        'Description'#9'20'#9'Description'#9#9
        'AccessDesc'#9'25'#9'Access'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsClientDBEmployeenAccess
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
    end
    object DNMPanel9: TDNMPanel
      Left = 1
      Top = 1
      Width = 644
      Height = 40
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object grpFilters: TwwRadioGroup
        Left = 1
        Top = 1
        Width = 642
        Height = 38
        DisableThemes = False
        Align = alClient
        Columns = 4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'With Write Access'
          'Read-Only Access'
          'No Access Defined'
          'All')
        ParentFont = False
        TabOrder = 0
        OnClick = grpFiltersClick
        ExplicitLeft = 5
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 568
    Top = 264
  end
  inherited tmrdelay: TTimer
    Left = 604
    Top = 264
  end
  inherited popSpelling: TPopupMenu
    Left = 249
    Top = 264
  end
  inherited tmrdelayMsg: TTimer
    Left = 533
    Top = 264
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 355
    Top = 264
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 391
    Top = 264
  end
  inherited MyConnection: TERPConnection
    Database = 'vs1_cloud'
    Server = 'localhost'
    Connected = True
    AfterConnect = MyConnectionAfterConnect
    Left = 178
    Top = 231
  end
  inherited DataState: TDataState
    Left = 426
    Top = 264
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 284
    Top = 264
  end
  inherited imgsort: TImageList
    Left = 462
    Top = 264
    Bitmap = {
      494C0101020048019C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 178
    Top = 264
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 497
    Top = 264
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 320
    Top = 264
  end
  inherited qryMemTrans: TERPQuery
    Left = 213
    Top = 264
  end
  inherited tmrOnshow: TTimer
    Left = 640
    Top = 264
  end
  object QryVS1Users: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT CU.ClientID, CU.DatabaseName,CU.EmailId, CU.Password,  DB' +
        '.ServerName, DB.Regionname, DB.`Status`, DB.CreatedOn, DB.UsedOn' +
        ', DB.DiscontinuedOn,'
      'CU.DatabaseName CUDataabse, C.ServerName CServer, '
      'CDB.AdminDB, CDB.AdminUser, CDB.AdminPass, CDB.APIPort,'
      
        '(SELECT company FROM tblclients WHERE clientId = DB.Vs1_ClientID' +
        ') AS ClientName'
      'FROM '
      'tblVS1_databases DB '
      'Left JOIN  tblVS1_clients C  ON DB.ID = C.DatabaseID'
      'Left JOIN  tblVS1_clientusers CU ON CU.ClientID = C.id'
      
        'left JOIN tblVS1_clientdbservers CDB ON CDB.ServerName = C.Serve' +
        'rName'
      'WHERE EmailId =:UserNameToSearch')
    BeforeOpen = QryVS1UsersBeforeOpen
    AfterOpen = QryVS1UsersAfterOpen
    Left = 176
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UserNameToSearch'
      end>
    object QryVS1UsersClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object QryVS1UsersDatabaseName: TWideStringField
      FieldName = 'DatabaseName'
      Size = 255
    end
    object QryVS1UsersServerName: TWideStringField
      FieldName = 'ServerName'
      Size = 255
    end
    object QryVS1UsersRegionname: TWideStringField
      FieldName = 'Regionname'
      Size = 255
    end
    object QryVS1UsersStatus: TWideStringField
      FieldName = 'Status'
      FixedChar = True
      Size = 12
    end
    object QryVS1UsersCreatedOn: TDateField
      FieldName = 'CreatedOn'
    end
    object QryVS1UsersUsedOn: TDateField
      FieldName = 'UsedOn'
    end
    object QryVS1UsersDiscontinuedOn: TDateField
      FieldName = 'DiscontinuedOn'
    end
    object QryVS1UsersAdminDB: TWideStringField
      FieldName = 'AdminDB'
      Size = 255
    end
    object QryVS1UsersAdminUser: TWideStringField
      FieldName = 'AdminUser'
      Size = 255
    end
    object QryVS1UsersAdminPass: TWideStringField
      FieldName = 'AdminPass'
      Size = 255
    end
    object QryVS1UsersAPIPort: TIntegerField
      FieldName = 'APIPort'
    end
    object QryVS1UsersClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 160
    end
    object QryVS1UsersCUDataabse: TWideStringField
      FieldName = 'CUDataabse'
      Size = 255
    end
    object QryVS1UsersCServer: TWideStringField
      FieldName = 'CServer'
      Size = 255
    end
    object QryVS1UsersEmailId: TWideStringField
      FieldName = 'EmailId'
      Size = 255
    end
    object QryVS1UsersPassword: TWideStringField
      FieldName = 'Password'
      Size = 255
    end
  end
  object dsVS1Users: TDataSource
    DataSet = QryVS1Users
    Left = 176
    Top = 328
  end
  object dsClientDBEmployeenAccess: TDataSource
    DataSet = qryClientDBEmployeenAccess
    Left = 208
    Top = 328
  end
  object qryClientDBEmployeenAccess: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT P.Logon_Name, E.FirstName, E.LastName, E.EmployeeName, E.' +
        'active, F.FormName, F.Description, ifnull(EFA.Access,0) as Acces' +
        's, AccLevelNoToDescription(EFA.Access) AccessDesc'
      'FROM tblpassword P'
      'LEft JOIN tblemployees E ON P.EmployeeId = e.employeeId'
      
        'LEft JOIN tblemployeeformsaccess  EFA ON EFA.EmployeeID = E.empl' +
        'oyeeID'
      'LEft  JOIN tblforms F ON EFA.FormID = F.FormID'
      ' WHERE logon_name =:UserNameToSearch')
    BeforeOpen = qryClientDBEmployeenAccessBeforeOpen
    AfterOpen = qryClientDBEmployeenAccessAfterOpen
    Active = True
    Left = 208
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UserNameToSearch'
      end>
    object qryClientDBEmployeenAccessLogon_Name: TWideStringField
      DisplayLabel = 'Logon Name'
      DisplayWidth = 25
      FieldName = 'Logon_Name'
      Origin = 'P.Logon_Name'
      Size = 25
    end
    object qryClientDBEmployeenAccessEmployeeName: TWideStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 20
      FieldName = 'EmployeeName'
      Origin = 'E.EmployeeName'
      Size = 255
    end
    object qryClientDBEmployeenAccessactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 1
      FieldName = 'active'
      Origin = 'E.Active'
      FixedChar = True
      Size = 1
    end
    object qryClientDBEmployeenAccessFormName: TWideStringField
      DisplayLabel = 'Form'
      DisplayWidth = 20
      FieldName = 'FormName'
      Origin = 'F.FormName'
      Size = 50
    end
    object qryClientDBEmployeenAccessDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'F.Description'
      Size = 100
    end
    object qryClientDBEmployeenAccessAccessDesc: TWideStringField
      DisplayLabel = 'Access'
      DisplayWidth = 25
      FieldName = 'AccessDesc'
      Origin = 'AccessDesc'
      Size = 50
    end
    object qryClientDBEmployeenAccessFirstName: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 20
      FieldName = 'FirstName'
      Origin = 'E.FirstName'
      Visible = False
      Size = 40
    end
    object qryClientDBEmployeenAccessLastName: TWideStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 20
      FieldName = 'LastName'
      Origin = 'E.LastName'
      Visible = False
      Size = 40
    end
    object qryClientDBEmployeenAccessAccess: TLargeintField
      FieldName = 'Access'
      Origin = 'Access'
      Visible = False
    end
  end
  object ConnclientDB: TERPConnection
    Database = 'aus_sample_company'
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    AfterConnect = ConnclientDBAfterConnect
    LoginPrompt = False
    Left = 210
    Top = 367
  end
end
