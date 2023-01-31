inherited fmDefaults: TfmDefaults
  Left = 354
  Top = 108
  HelpContext = 305000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = []
  Caption = 'Company Defaults'
  ClientHeight = 227
  ClientWidth = 425
  DefaultMonitor = dmDesktop
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 431
  ExplicitHeight = 256
  DesignSize = (
    425
    227)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 227
    Width = 425
    HelpContext = 305001
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 49
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 113
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel4: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 425
    Height = 227
    HelpContext = 305002
    Align = alClient
    BevelInner = bvRaised
    BevelKind = bkFlat
    BorderWidth = 1
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    object DNMPanel2: TDNMPanel
      Left = 3
      Top = 3
      Width = 411
      Height = 59
      HelpContext = 305003
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        411
        59)
      object pnlTitle: TDNMPanel
        Left = 33
        Top = 9
        Width = 344
        Height = 39
        HelpContext = 305004
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
          Width = 342
          Height = 37
          HelpContext = 305005
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
            Width = 342
            Height = 37
            HelpContext = 305006
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Company Defaults'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitLeft = -1
            ExplicitTop = 6
          end
        end
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 3
      Top = 62
      Width = 411
      Height = 104
      HelpContext = 305007
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object lbldefaultUOM: TLabel
        Left = 32
        Top = 17
        Width = 92
        Height = 15
        HelpContext = 305008
        Alignment = taRightJustify
        Caption = 'Unit of Measure '
      end
      object lbldefaultclass: TLabel
        Left = 57
        Top = 60
        Width = 67
        Height = 15
        HelpContext = 305009
        Alignment = taRightJustify
        Caption = 'Department'
      end
      object Label1: TLabel
        Left = 280
        Top = 35
        Width = 53
        Height = 15
        HelpContext = 305010
        Alignment = taRightJustify
        Caption = 'Site code'
      end
      object lblmsg: TLabel
        Left = 1
        Top = 88
        Width = 409
        Height = 15
        HelpContext = 305011
        Align = alBottom
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
        ExplicitWidth = 3
      end
      object edtSitecode: TwwDBEdit
        Left = 280
        Top = 56
        Width = 121
        Height = 23
        HelpContext = 305012
        DataField = 'SiteCode'
        DataSource = DSBranchCode
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
        OnEnter = edtSitecodeEnter
        OnExit = edtSitecodeExit
      end
      object cboUOM: TwwDBLookupCombo
        Left = 130
        Top = 14
        Width = 144
        Height = 23
        HelpContext = 305013
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'unitname'#9'15'#9'unitname'#9'F')
        DataField = 'DefaultUOM'
        DataSource = dscolumnheadings
        LookupTable = qryuom
        LookupField = 'unitname'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cboUOMEnter
        OnExit = cboUOMExit
        OnNotInList = cboUOMNotInList
      end
      object cbodept: TwwDBLookupCombo
        Left = 130
        Top = 56
        Width = 144
        Height = 23
        HelpContext = 305014
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'classname'#9'20'#9'classname'#9'F'
          'sitecode'#9'3'#9'sitecode'#9'F')
        DataField = 'DefaultClass'
        DataSource = dscolumnheadings
        LookupTable = qryclass
        LookupField = 'classname'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cbodeptCloseUp
        OnEnter = cbodeptEnter
        OnExit = cbodeptExit
        OnNotInList = cbodeptNotInList
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 3
      Top = 166
      Width = 411
      Height = 50
      HelpContext = 305015
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        411
        50)
      object cmdClose: TDNMSpeedButton
        Left = 93
        Top = 11
        Width = 93
        Height = 29
        HelpContext = 305016
        Anchors = [akBottom]
        Caption = '&Save'
        Default = True
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = cmdCloseClick
      end
      object cmdCancel: TDNMSpeedButton
        Left = 243
        Top = 11
        Width = 93
        Height = 29
        HelpContext = 305017
        Anchors = [akBottom]
        Cancel = True
        Caption = '&Cancel'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ModalResult = 2
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = cmdCancelClick
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 135
    Top = 77
  end
  inherited tmrdelay: TTimer
    Left = 300
    Top = 77
  end
  inherited popSpelling: TPopupMenu
    Left = 102
    Top = 77
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 168
    Top = 77
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 333
    Top = 77
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 8
    Top = 79
  end
  inherited DataState: TDataState
    Left = 234
    Top = 77
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 366
    Top = 77
  end
  inherited imgsort: TImageList
    Left = 267
    Top = 77
    Bitmap = {
      494C01010200C400EC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 69
    Top = 77
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 399
    Top = 77
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 201
    Top = 77
  end
  inherited qryMemTrans: TERPQuery
    Left = 36
    Top = 77
  end
  object Qrycolumnheadings: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblcolumnheadings')
    AfterOpen = QrycolumnheadingsAfterOpen
    Left = 20
    Top = 117
    object QrycolumnheadingsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcolumnheadings.GlobalRef'
      Size = 255
    end
    object QrycolumnheadingsColumnheadingsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ColumnheadingsID'
      Origin = 'tblcolumnheadings.ColumnheadingsID'
    end
    object QrycolumnheadingsFirstColumn: TWideStringField
      FieldName = 'FirstColumn'
      Origin = 'tblcolumnheadings.FirstColumn'
      Size = 50
    end
    object QrycolumnheadingsSecondColumnName: TWideStringField
      FieldName = 'SecondColumnName'
      Origin = 'tblcolumnheadings.SecondColumnName'
      Size = 50
    end
    object QrycolumnheadingsThirdColumnName: TWideStringField
      FieldName = 'ThirdColumnName'
      Origin = 'tblcolumnheadings.ThirdColumnName'
      Size = 50
    end
    object QrycolumnheadingsPartColumnName: TWideStringField
      FieldName = 'PartColumnName'
      Origin = 'tblcolumnheadings.PartColumnName'
      Size = 50
    end
    object QrycolumnheadingsCustomerColumnName: TWideStringField
      FieldName = 'CustomerColumnName'
      Origin = 'tblcolumnheadings.CustomerColumnName'
      Size = 50
    end
    object QrycolumnheadingsSupplierColumnName: TWideStringField
      FieldName = 'SupplierColumnName'
      Origin = 'tblcolumnheadings.SupplierColumnName'
      Size = 50
    end
    object QrycolumnheadingsProspectColumnName: TWideStringField
      FieldName = 'ProspectColumnName'
      Origin = 'tblcolumnheadings.ProspectColumnName'
      Size = 50
    end
    object QrycolumnheadingsDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Origin = 'tblcolumnheadings.DefaultClass'
      Size = 30
    end
    object QrycolumnheadingsDefaultUOM: TWideStringField
      FieldName = 'DefaultUOM'
      Origin = 'tblcolumnheadings.DefaultUOM'
      Size = 100
    end
    object QrycolumnheadingsClassHeading: TWideStringField
      FieldName = 'ClassHeading'
      Origin = 'tblcolumnheadings.ClassHeading'
      Size = 50
    end
    object QrycolumnheadingsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblcolumnheadings.msTimeStamp'
    end
    object QrycolumnheadingsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblcolumnheadings.msUpdateSiteCode'
      Size = 3
    end
  end
  object qryuom: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select unitname from tblunitsofmeasure where active ="T" and mul' +
        'tiplier = 1 and partid = 0'
      'union '
      'Select  '#39'Units'#39' as unitname '
      'union '
      'Select  '#39'Each'#39' as unitname '
      'union '
      'Select  '#39'Item'#39' as unitname '
      'order by unitname')
    AfterOpen = QrycolumnheadingsAfterOpen
    Left = 58
    Top = 117
  end
  object qryclass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select classid, classname, sitecode from tblclass where active =' +
        '"T" order by classname')
    AfterOpen = QrycolumnheadingsAfterOpen
    Left = 97
    Top = 117
    object qryclassclassname: TWideStringField
      FieldName = 'classname'
      Origin = 'tblclass.ClassName'
      Size = 60
    end
    object qryclasssitecode: TWideStringField
      FieldName = 'sitecode'
      Origin = 'tblclass.SiteCode'
      FixedChar = True
      Size = 3
    end
    object qryclassclassid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'classid'
      Origin = 'tblclass.ClassID'
    end
  end
  object dscolumnheadings: TDataSource
    DataSet = Qrycolumnheadings
    Left = 20
    Top = 147
  end
  object qryBranchCode: TERPQuery
    Connection = MyConnection
    ParamCheck = False
    SQL.Strings = (
      
        'SELECT BackEndID, SiteCode ,SiteDesc ,BEDefault,EmailAddressData' +
        ', EmailUsername, EmailPassword, ConflictTodoUserId  FROM tblmsba' +
        'ckendid')
    AfterOpen = QrycolumnheadingsAfterOpen
    Left = 136
    Top = 117
    object qryBranchCodeBEDefault: TWideStringField
      DisplayLabel = 'Def'
      DisplayWidth = 3
      FieldName = 'BEDefault'
      Origin = 'tblmsbackendid.BEDefault'
      FixedChar = True
      Size = 1
    end
    object qryBranchCodeSiteCode: TWideStringField
      DisplayLabel = 'Site Code'
      DisplayWidth = 7
      FieldName = 'SiteCode'
      Origin = 'tblmsbackendid.SiteCode'
      FixedChar = True
      Size = 3
    end
    object qryBranchCodeSiteDesc: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 15
      FieldName = 'SiteDesc'
      Origin = 'tblmsbackendid.SiteDesc'
      Size = 255
    end
    object qryBranchCodeEmailAddressData: TWideStringField
      DisplayLabel = 'Email'
      DisplayWidth = 23
      FieldName = 'EmailAddressData'
      Origin = 'tblmsbackendid.EmailAddressData'
      Size = 255
    end
    object qryBranchCodeEmailUsername: TWideStringField
      DisplayLabel = 'Username'
      DisplayWidth = 12
      FieldName = 'EmailUsername'
      Origin = 'tblmsbackendid.EmailUsername'
      Size = 255
    end
    object qryBranchCodeEmailPassword: TWideStringField
      DisplayLabel = 'Password'
      DisplayWidth = 12
      FieldName = 'EmailPassword'
      Origin = 'tblmsbackendid.EmailPassword'
      Size = 255
    end
    object qryBranchCodeConflictTodoUserId: TIntegerField
      DisplayLabel = 'Conflict Resolver'
      DisplayWidth = 10
      FieldName = 'ConflictTodoUserId'
      Origin = 'tblmsbackendid.ConflictTodoUserId'
      Visible = False
    end
    object qryBranchCodeBackEndID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'BackEndID'
      Origin = 'tblmsbackendid.BackEndID'
      Visible = False
    end
  end
  object DSBranchCode: TDataSource
    DataSet = qryBranchCode
    Left = 136
    Top = 147
  end
end
