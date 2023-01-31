inherited fmAdjustUOM: TfmAdjustUOM
  Left = 195
  Top = 189
  HelpContext = 699000
  Caption = 'Adjust UOM (Stock)'
  ClientHeight = 529
  ClientWidth = 988
  OldCreateOrder = True
  ExplicitLeft = 195
  ExplicitTop = 189
  ExplicitWidth = 1004
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 466
    Width = 988
    HelpContext = 699025
    ExplicitTop = 466
    ExplicitWidth = 988
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 196
    Width = 988
    Height = 270
    HelpContext = 699001
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      988
      270)
    object grdMain: TwwDBGrid
      Left = 7
      Top = 1
      Width = 972
      Height = 268
      HelpContext = 699002
      ControlType.Strings = (
        'SNtracking;CheckBox;T;F'
        'Transfer;CheckBox;T;F'
        'Transferred;CheckBox;T;F')
      Selected.Strings = (
        'ProductName'#9'16'#9'Product~Name'#9'F'
        'Classname'#9'1'#9'Department~Name'#9'F'
        'UOM'#9'5'#9'Name'#9'F'#9'UOM'
        'UOMMultiplier'#9'1'#9'Multiplier'#9'F'#9'UOM'
        'Batchnumber'#9'5'#9'No'#9'F'#9'Batch'
        'ExpiryDate'#9'8'#9'Expiry Date'#9'F'#9'Batch'
        'Binlocation'#9'1'#9'Location'#9'F'#9'Bin'
        'Binnumber'#9'1'#9'Number'#9'F'#9'Bin'
        'Serialnumber'#9'10'#9'Serial~number'#9'F'
        'UOMQty'#9'8'#9'Qty'#9'F'
        'Cost'#9'8'#9'Cost'#9'F'
        'Transfer'#9'1'#9'Transfer?'#9'F'
        'Transfered'#9'1'#9'Transferred'#9'F'
        'Reason'#9'15'#9'Reason For~Not Transferring'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      UseTFields = False
      OnCalcCellColors = grdMainCalcCellColors
      OnDblClick = grdMainDblClick
      FooterColor = clWhite
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 466
    Width = 988
    Height = 63
    HelpContext = 699004
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      988
      63)
    object btnOK: TDNMSpeedButton
      Left = 299
      Top = 18
      Width = 87
      Height = 27
      HelpContext = 699029
      Anchors = []
      Caption = 'Transfer'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 602
      Top = 18
      Width = 87
      Height = 27
      HelpContext = 699030
      Anchors = []
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnUOMlist: TDNMSpeedButton
      Left = 450
      Top = 18
      Width = 87
      Height = 27
      Anchors = []
      Caption = 'UOM List'
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
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      OnClick = btnUOMlistClick
      HelpContext = 699033
    end
  end
  object DNMPanel4: TDNMPanel [7]
    Left = 0
    Top = 70
    Width = 988
    Height = 126
    HelpContext = 699005
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Bevel6: TBevel
      Left = 536
      Top = 5
      Width = 438
      Height = 90
      HelpContext = 699006
    end
    object Bevel5: TBevel
      Left = 7
      Top = 5
      Width = 438
      Height = 90
      HelpContext = 699007
    end
    object Bevel2: TBevel
      Left = 546
      Top = 16
      Width = 208
      Height = 70
      HelpContext = 699008
    end
    object Bevel3: TBevel
      Left = 227
      Top = 16
      Width = 208
      Height = 70
      HelpContext = 699009
    end
    object Bevel1: TBevel
      Left = 17
      Top = 16
      Width = 208
      Height = 70
      HelpContext = 699010
    end
    object fromPartname: TDBText
      Left = 324
      Top = 61
      Width = 103
      Height = 17
      HelpContext = 699011
      DataField = 'PARTNAME'
      DataSource = dsUOMFrom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 238
      Top = 62
      Width = 81
      Height = 15
      HelpContext = 699012
      Caption = 'Product Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 267
      Top = 26
      Width = 52
      Height = 15
      HelpContext = 699013
      Alignment = taRightJustify
      Caption = 'Multiplier'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object fromMultiplier: TDBText
      Left = 324
      Top = 26
      Width = 53
      Height = 17
      HelpContext = 699014
      DataField = 'Multiplier'
      DataSource = dsUOMFrom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 36
      Top = 29
      Width = 173
      Height = 15
      HelpContext = 699015
      Caption = 'Move Available Quantity of Unit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel4: TBevel
      Left = 756
      Top = 16
      Width = 208
      Height = 70
      HelpContext = 699016
    end
    object toPartName: TDBText
      Left = 854
      Top = 54
      Width = 103
      Height = 17
      HelpContext = 699017
      DataField = 'PARTNAME'
      DataSource = dsUOMTo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 764
      Top = 55
      Width = 81
      Height = 15
      HelpContext = 699018
      Caption = 'Product Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 794
      Top = 29
      Width = 52
      Height = 15
      HelpContext = 699019
      Caption = 'Multiplier'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object toMultiplier: TDBText
      Left = 854
      Top = 28
      Width = 103
      Height = 17
      HelpContext = 699020
      DataField = 'Multiplier'
      DataSource = dsUOMTo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 626
      Top = 29
      Width = 49
      Height = 15
      HelpContext = 699021
      Caption = 'Into Unit '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblStatus: TLabel
      Left = 6
      Top = 106
      Width = 35
      Height = 16
      HelpContext = 699022
      Caption = 'Stock'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 261
      Top = 44
      Width = 58
      Height = 15
      HelpContext = 699031
      Alignment = taRightJustify
      Caption = 'Unit Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object unitName: TDBText
      Left = 324
      Top = 44
      Width = 103
      Height = 17
      HelpContext = 699032
      DataField = 'UnitName'
      DataSource = dsUOMFrom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object cboFrom: TwwDBLookupCombo
      Left = 62
      Top = 51
      Width = 121
      Height = 23
      HelpContext = 699023
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'Unit Name'#9'F'
        'PARTNAME'#9'20'#9'Product'#9'F'
        'Multiplier'#9'10'#9'Multiplier'#9'F')
      LookupTable = QryUOMFrom
      LookupField = 'UnitID'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboFromCloseUp
    end
    object cboTo: TwwDBLookupCombo
      Left = 592
      Top = 51
      Width = 121
      Height = 23
      HelpContext = 699024
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'Unit Name'#9'F'
        'Multiplier'#9'10'#9'Multiplier'#9'F'
        'PARTNAME'#9'20'#9'Product'#9'F')
      LookupTable = QryUOMTo
      LookupField = 'UnitID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboToCloseUp
    end
  end
  object DNMPanel2: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 988
    Height = 70
    HelpContext = 699003
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      988
      70)
    object pnlTitle: TDNMPanel
      Left = 282
      Top = 9
      Width = 425
      Height = 52
      HelpContext = 699026
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 421
        Height = 48
        HelpContext = 699027
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
        ExplicitWidth = 277
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 421
          Height = 48
          HelpContext = 699028
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Adjust UOM (Stock)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -33
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 2
        end
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 16
    Top = 5
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 261
    Top = 5
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 296
    Top = 5
  end
  inherited DataState: TDataState
    Left = 51
    Top = 5
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 699029
    Left = 331
    Top = 5
  end
  inherited imgsort: TImageList
    Left = 191
    Top = 5
    Bitmap = {
      494C010102001C00240010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object QryUOMFrom: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`U`.`UnitID`,'
      '`U`.`UnitName`,'
      '`U`.`Multiplier`,'
      '`U`.`UnitDescription`,'
      '`U`.`BaseUnitName`,'
      '`U`.`PartID`,'
      '`P`.`PARTNAME`, P.SNtracking '
      'FROM'
      '`tblunitsofmeasure` AS `U`'
      'Left Join `tblparts` AS `P` ON `U`.`PartID` = `P`.`PARTSID`'
      '#where ifnull(P.PartsID,0) = 0 or P.SNtracking ="F"'
      'ORDER BY'
      '`P`.`PartName` ASC')
    Left = 156
    Top = 5
    object QryUOMFromUnitName: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object QryUOMFromPARTNAME: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'PARTNAME'
      Size = 60
    end
    object QryUOMFromMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'Multiplier'
    end
    object QryUOMFromUnitID: TIntegerField
      FieldName = 'UnitID'
      Visible = False
    end
    object QryUOMFromUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Visible = False
      Size = 35
    end
    object QryUOMFromBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Visible = False
      Size = 15
    end
    object QryUOMFromPartID: TIntegerField
      FieldName = 'PartID'
      Visible = False
    end
    object QryUOMFromSNtracking: TWideStringField
      FieldName = 'SNtracking'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object QryUOMTo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`U`.`UnitID`,'
      '`U`.`UnitName`,'
      '`U`.`Multiplier`,'
      '`U`.`UnitDescription`,'
      '`U`.`BaseUnitName`,'
      '`U`.`PartID`,'
      '`P`.`PARTNAME`'
      'FROM'
      '`tblunitsofmeasure` AS `U`'
      'Left Join `tblparts` AS `P` ON `U`.`PartID` = `P`.`PARTSID`'
      '#where ifnull(P.PartsID,0) = 0 or P.SNtracking ="F"'
      'ORDER BY'
      '`U`.`UnitName` ASC')
    Left = 226
    Top = 5
    object QryUOMToUnitName: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object QryUOMToMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'Multiplier'
    end
    object QryUOMToPARTNAME: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'PARTNAME'
      Size = 60
    end
    object QryUOMToUnitID: TIntegerField
      FieldName = 'UnitID'
      Visible = False
    end
    object QryUOMToUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Visible = False
      Size = 35
    end
    object QryUOMToBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Visible = False
      Size = 15
    end
    object QryUOMToPartID: TIntegerField
      FieldName = 'PartID'
    end
  end
  object dsUOMTo: TDataSource
    DataSet = QryUOMTo
    Left = 121
    Top = 5
  end
  object dsUOMFrom: TDataSource
    DataSet = QryUOMFrom
    Left = 86
    Top = 5
  end
  object dsMain: TDataSource
    DataSet = Qrymain
    Left = 328
    Top = 408
  end
  object Qrymain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tmp_AdjustUOM')
    Left = 328
    Top = 376
    object QrymainProductName: TWideStringField
      DisplayLabel = 'Product~Name'
      DisplayWidth = 10
      FieldName = 'ProductName'
      Origin = 'tmp_AdjustUOM.ProductName'
      Size = 60
    end
    object QrymainClassname: TWideStringField
      DisplayLabel = 'Department~Name'
      DisplayWidth = 10
      FieldName = 'Classname'
      Origin = 'tmp_AdjustUOM.Classname'
      Size = 255
    end
    object QrymainUOM: TWideStringField
      DisplayWidth = 10
      FieldName = 'UOM'
      Origin = 'tmp_AdjustUOM.UOM'
      Size = 50
    end
    object QrymainUOMMultiplier: TFloatField
      DisplayLabel = 'Multiplier'
      DisplayWidth = 10
      FieldName = 'UOMMultiplier'
      Origin = 'tmp_AdjustUOM.UOMMultiplier'
    end
    object QrymainBatchnumber: TWideStringField
      DisplayLabel = 'Batch No'
      DisplayWidth = 10
      FieldName = 'Batchnumber'
      Origin = 'tmp_AdjustUOM.Batchnumber'
      Size = 100
    end
    object QrymainExpiryDate: TWideStringField
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 10
      FieldName = 'ExpiryDate'
      Origin = 'tmp_AdjustUOM.ExpiryDate'
      Size = 10
    end
    object QrymainBinlocation: TWideStringField
      DisplayLabel = 'Bin location'
      DisplayWidth = 10
      FieldName = 'Binlocation'
      Origin = 'tmp_AdjustUOM.Binlocation'
      Size = 30
    end
    object QrymainBinnumber: TWideStringField
      DisplayLabel = 'Bin number'
      DisplayWidth = 10
      FieldName = 'Binnumber'
      Origin = 'tmp_AdjustUOM.Binnumber'
      Size = 30
    end
    object QrymainSerialnumber: TWideStringField
      DisplayLabel = 'Serial number'
      DisplayWidth = 10
      FieldName = 'Serialnumber'
      Origin = 'tmp_AdjustUOM.Serialnumber'
      Size = 100
    end
    object QrymainUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tmp_AdjustUOM.UOMQty'
    end
    object QrymainCost: TFloatField
      DisplayWidth = 10
      FieldName = 'Cost'
      Origin = 'tmp_AdjustUOM.Cost'
      currency = True
    end
    object QrymainQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tmp_AdjustUOM.Qty'
      Visible = False
    end
    object QrymaingLevel: TLargeintField
      DisplayWidth = 15
      FieldName = 'gLevel'
      Origin = 'tmp_AdjustUOM.gLevel'
      Visible = False
    end
    object QrymainPartsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'tmp_AdjustUOM.PartsId'
      Visible = False
    end
    object QrymainDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'tmp_AdjustUOM.DepartmentID'
      Visible = False
    end
    object QrymainUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tmp_AdjustUOM.UOMID'
      Visible = False
    end
    object QrymainProductColumn1: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductColumn1'
      Origin = 'tmp_AdjustUOM.ProductColumn1'
      Visible = False
      Size = 255
    end
    object QrymainProductColumn2: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductColumn2'
      Origin = 'tmp_AdjustUOM.ProductColumn2'
      Visible = False
      Size = 255
    end
    object QrymainProductColumn3: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductColumn3'
      Origin = 'tmp_AdjustUOM.ProductColumn3'
      Visible = False
      Size = 255
    end
    object QrymainPartsDescription: TWideStringField
      DisplayWidth = 255
      FieldName = 'PartsDescription'
      Origin = 'tmp_AdjustUOM.PartsDescription'
      Visible = False
      Size = 255
    end
    object QrymainBatchExpiryDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'BatchExpiryDate'
      Origin = 'tmp_AdjustUOM.BatchExpiryDate'
      Visible = False
    end
    object QrymainInstockUOMQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockUOMQty'
      Origin = 'tmp_AdjustUOM.InstockUOMQty'
      Visible = False
    end
    object QrymainInstockQty: TFloatField
      DisplayWidth = 10
      FieldName = 'InstockQty'
      Origin = 'tmp_AdjustUOM.InstockQty'
      Visible = False
    end
    object QrymainValue: TFloatField
      DisplayWidth = 10
      FieldName = 'Value'
      Origin = 'tmp_AdjustUOM.Value'
      Visible = False
    end
    object QrymainSNtracking: TWideStringField
      FieldName = 'SNtracking'
      Origin = 'tmp_AdjustUOM.SNtracking'
      FixedChar = True
      Size = 1
    end
    object QrymainTransfer: TWideStringField
      FieldName = 'Transfer'
      Origin = 'tmp_AdjustUOM.Transfer'
      FixedChar = True
      Size = 1
    end
    object QrymainTransfered: TWideStringField
      FieldName = 'Transfered'
      FixedChar = True
      Size = 1
    end
    object QrymainReason: TWideStringField
      FieldName = 'Reason'
      Size = 100
    end
  end
  object QryAllUOM1111: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`U`.`UnitID`,'
      '`U`.`UnitName`,'
      '`U`.`Multiplier`,'
      '`U`.`UnitDescription`,'
      '`U`.`BaseUnitName`,'
      '`U`.`PartID`'
      'FROM'
      '`tblunitsofmeasure` AS `U`')
    Left = 367
    Top = 5
    object QryAllUOM1111UnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object QryAllUOM1111UnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object QryAllUOM1111Multiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object QryAllUOM1111UnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
    object QryAllUOM1111BaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Size = 15
    end
    object QryAllUOM1111PartID: TIntegerField
      FieldName = 'PartID'
    end
  end
end
