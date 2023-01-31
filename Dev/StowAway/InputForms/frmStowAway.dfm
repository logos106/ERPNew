inherited fmStowAway: TfmStowAway
  Left = 332
  Top = 131
  HelpContext = 500000
  Caption = 'Stow Away'
  ClientHeight = 540
  ClientWidth = 703
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 332
  ExplicitTop = 131
  ExplicitWidth = 719
  ExplicitHeight = 579
  DesignSize = (
    703
    540)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 347
    Width = 703
    HelpContext = 500004
    ExplicitTop = 407
    ExplicitWidth = 914
  end
  inherited shapehint: TShape
    Left = 3
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 31
    ExplicitLeft = 47
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 475
    Width = 703
    Height = 65
    HelpContext = 500009
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      703
      65)
    object btnCompleted: TDNMSpeedButton
      Left = 120
      Top = 22
      Width = 87
      Height = 27
      HelpContext = 500010
      Anchors = []
      Caption = '&Save'
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 478
      Top = 22
      Width = 87
      Height = 27
      HelpContext = 500011
      Anchors = []
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btnCloseClick
    end
    object btnNew: TDNMSpeedButton
      Left = 239
      Top = 22
      Width = 87
      Height = 27
      Hint = 'Select this to create a new Stow Away reord'
      HelpContext = 500012
      Anchors = []
      Caption = '&New'
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
      TabOrder = 1
      TabStop = False
      OnClick = btnNewClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 358
      Top = 22
      Width = 87
      Height = 27
      HelpContext = 500013
      Anchors = [akTop, akRight]
      Caption = 'Print'
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
      TabOrder = 3
      TabStop = False
      OnClick = btnPrintClick
    end
  end
  object DNMPanel4: TDNMPanel [6]
    Left = 0
    Top = 347
    Width = 703
    Height = 128
    HelpContext = 500014
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Bevel2: TBevel
      Left = 181
      Top = 73
      Width = 514
      Height = 47
      HelpContext = 500015
    end
    object Bevel1: TBevel
      Left = 181
      Top = 11
      Width = 514
      Height = 51
      HelpContext = 500016
    end
    object Label1: TLabel
      Left = 196
      Top = 29
      Width = 69
      Height = 15
      HelpContext = 500017
      Caption = 'Ordered Qty'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 402
      Top = 29
      Width = 27
      Height = 15
      HelpContext = 500018
      Caption = 'UOM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 106
      Top = 29
      Width = 69
      Height = 15
      HelpContext = 500019
      Caption = 'BOM Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 13
      Top = 89
      Width = 162
      Height = 15
      HelpContext = 500020
      Caption = 'Ordered Quantity Difference '
    end
    object lblExtraforcustomer: TLabel
      Left = 188
      Top = 89
      Width = 77
      Height = 15
      HelpContext = 500021
      Caption = 'For Customer'
    end
    object Label6: TLabel
      Left = 382
      Top = 89
      Width = 47
      Height = 15
      HelpContext = 500022
      Caption = 'To Store'
    end
    object lblDefaultUOM: TLabel
      Left = 578
      Top = 89
      Width = 27
      Height = 15
      HelpContext = 500023
      Caption = 'UOM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtUOMQty: TwwDBEdit
      Left = 272
      Top = 25
      Width = 103
      Height = 23
      HelpContext = 500024
      DataField = 'ManufactureUOMQty'
      DataSource = dsproctree
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit2: TwwDBEdit
      Left = 435
      Top = 25
      Width = 130
      Height = 23
      HelpContext = 500025
      DataField = 'UOM'
      DataSource = dsproctree
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwCheckBox1: TwwCheckBox
      Left = 578
      Top = 28
      Width = 97
      Height = 17
      HelpContext = 500026
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Internal Order ?'
      DataField = 'isinternalorder'
      DataSource = dsproctree
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ReadOnly = True
    end
    object edtExtraforcustomer: TwwDBEdit
      Left = 272
      Top = 85
      Width = 103
      Height = 23
      HelpContext = 500027
      DataField = 'ExtraQtyToCustomer'
      DataSource = dsProcTreeStow
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit4: TwwDBEdit
      Left = 435
      Top = 85
      Width = 130
      Height = 23
      HelpContext = 500028
      DataField = 'ExtraQtytoStore'
      DataSource = dsProcTreeStow
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel3: TDNMPanel [7]
    Left = 0
    Top = 65
    Width = 703
    Height = 282
    HelpContext = 500029
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 4
      Width = 108
      Height = 15
      HelpContext = 500030
      Caption = 'Finished Quantities'
    end
    object pnlDetails: TDNMPanel
      Left = 451
      Top = 1
      Width = 251
      Height = 280
      HelpContext = 500031
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object lblLinesMsg: TLabel
        Left = 1
        Top = 1
        Width = 249
        Height = 278
        HelpContext = 500032
        Align = alClient
        Alignment = taCenter
        Caption = 
          'Please   Select   a   Record   in   '#39'Finished Quantities'#39'     to' +
          '   see    the   '#39'Stow Away'#39' details '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 243
        ExplicitHeight = 145
      end
      object cboUnitOfMeasure: TwwDBLookupCombo
        Left = 41
        Top = 24
        Width = 85
        Height = 26
        HelpContext = 500033
        AutoSize = False
        DropDownAlignment = taLeftJustify
        DataField = 'UOM'
        DataSource = dsprocStowawayLines
        LookupTable = qryUnitOfMeasure
        LookupField = 'UnitName'
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object grdLines: TwwDBGrid
        AlignWithMargins = True
        Left = 12
        Top = 23
        Width = 227
        Height = 245
        HelpContext = 500003
        Margins.Left = 11
        Margins.Top = 22
        Margins.Right = 11
        Margins.Bottom = 11
        ControlType.Strings = (
          'UOM;CustomEdit;cboUnitOfMeasure;F')
        Selected.Strings = (
          'UOM'#9'15'#9'UOM'#9#9'Stow Away As'
          'UOMQty'#9'10'#9'Qty'#9#9'Stow Away As')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnHighlight
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsprocStowawayLines
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgAllowInsert]
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = True
        Visible = False
        PaintOptions.AlternatingRowRegions = [arrFixedColumns]
        PaintOptions.BackgroundOptions = [coBlendFixedRow]
        object btnDeleteGridLine: TwwIButton
          Left = 0
          Top = 0
          Width = 20
          Height = 33
          Hint = 'Click to Delete Record'
          HelpContext = 500034
          AllowAllUp = True
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
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDeleteGridLineClick
        end
      end
    end
    object grdmain: TwwDBGrid
      AlignWithMargins = True
      Left = 8
      Top = 23
      Width = 438
      Height = 255
      Hint = 
        'Select a Record here to see the Unit Of Measure Details that its' +
        ' stow awayed as '
      HelpContext = 500037
      Margins.Left = 7
      Margins.Top = 22
      ControlType.Strings = (
        'EmployeeName;CustomEdit;cboEmployee;F')
      Selected.Strings = (
        'EmployeeName'#9'15'#9'Employee '
        'StowAwayDate'#9'15'#9'Date'
        'CUOM'#9'14'#9'UOM'
        'UOMQty'#9'10'#9'Qty')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnHighlight
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alLeft
      DataSource = dsprocStowAway
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgShowFooter, dgRowResize]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnCalcCellColors = grdmainCalcCellColors
      OnEnter = grdmainEnter
      OnMouseDown = grdmainMouseDown
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.AlternatingRowRegions = [arrFixedColumns]
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object wwIButton1: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 19
        Hint = 'Click to Delete Record'
        HelpContext = 500035
        AllowAllUp = True
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
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = wwIButton1Click
      end
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 26
      Top = 53
      Width = 119
      Height = 23
      HelpContext = 500036
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'25'#9'EmployeeName'#9'F')
      DataField = 'EmployeeName'
      DataSource = dsprocStowAway
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeName'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 703
    Height = 65
    HelpContext = 500005
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      703
      65)
    object pnlTitle: TDNMPanel
      Left = 190
      Top = 9
      Width = 325
      Height = 45
      HelpContext = 500006
      Anchors = []
      Caption = 'Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 323
        Height = 43
        HelpContext = 500007
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
          Width = 323
          Height = 43
          HelpContext = 500008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Stow Away'
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
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200C800D80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object QryprocStowAway: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblprocStowAway'
      'where ProctreeStowId = :ProctreeStowId')
    Filtered = True
    Filter = 'Deleted = '#39'F'#39
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    OnCalcFields = QryprocStowAwayCalcFields
    Left = 75
    Top = 199
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProctreeStowId'
      end>
    object QryprocStowAwayEmployeeName: TWideStringField
      DisplayLabel = 'Employee '
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblprocstowaway.EmployeeName'
      Size = 100
    end
    object QryprocStowAwayStowAwayDate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 15
      FieldName = 'StowAwayDate'
      Origin = 'tblprocstowaway.StowAwayDate'
    end
    object QryprocStowAwayCUOM: TStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 14
      FieldKind = fkCalculated
      FieldName = 'CUOM'
      Size = 100
      Calculated = True
    end
    object QryprocStowAwayUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblprocstowaway.UOMQty'
    end
    object QryprocStowAwayUOM: TWideStringField
      DisplayWidth = 14
      FieldName = 'UOM'
      Origin = 'tblprocstowaway.UOM'
      Visible = False
      Size = 50
    end
    object QryprocStowAwayID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblprocstowaway.ID'
      Visible = False
    end
    object QryprocStowAwayGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblprocstowaway.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryprocStowAwayProctreeStowId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProctreeStowId'
      Origin = 'tblprocstowaway.ProctreeStowId'
      Visible = False
    end
    object QryprocStowAwayEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblprocstowaway.EmployeeID'
      Visible = False
    end
    object QryprocStowAwayQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblprocstowaway.Qty'
      Visible = False
    end
    object QryprocStowAwayUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblprocstowaway.UOMID'
      Visible = False
    end
    object QryprocStowAwayUOMMult: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMMult'
      Origin = 'tblprocstowaway.UOMMult'
      Visible = False
    end
    object QryprocStowAwaymsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblprocstowaway.msTimeStamp'
      Visible = False
    end
    object QryprocStowAwaymsUpdateSitecode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSitecode'
      Origin = 'tblprocstowaway.msUpdateSitecode'
      Visible = False
      Size = 3
    end
    object QryprocStowAwayDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblprocstowaway.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsprocStowAway: TDataSource
    DataSet = QryprocStowAway
    Left = 72
    Top = 231
  end
  object qryUnitOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )'
      'Order By UnitID desc ,UnitName;')
    Left = 207
    Top = 205
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end>
    object qryUnitOfMeasureUnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object qryUnitOfMeasureUnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
    object qryUnitOfMeasureMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object qryUnitOfMeasureBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Size = 15
    end
  end
  object QryprocStowawayLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblprocStowawayLines'
      'Where StowAwayID = :StowAwayID')
    Filtered = True
    Filter = 'Deleted = '#39'F'#39
    Left = 115
    Top = 205
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'StowAwayID'
      end>
    object QryprocStowawayLinesUOM: TWideStringField
      DisplayWidth = 15
      FieldName = 'UOM'
      Origin = 'tblprocstowawaylines.UOM'
      Size = 50
    end
    object QryprocStowawayLinesUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblprocstowawaylines.UOMQty'
    end
    object QryprocStowawayLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblprocstowawaylines.ID'
      Visible = False
    end
    object QryprocStowawayLinesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblprocstowawaylines.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryprocStowawayLinesStowAwayID: TIntegerField
      FieldName = 'StowAwayID'
      Origin = 'tblprocstowawaylines.StowAwayID'
      Visible = False
    end
    object QryprocStowawayLinesQty: TFloatField
      FieldName = 'Qty'
      Origin = 'tblprocstowawaylines.Qty'
      Visible = False
    end
    object QryprocStowawayLinesUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblprocstowawaylines.UOMID'
      Visible = False
    end
    object QryprocStowawayLinesUOMMult: TFloatField
      FieldName = 'UOMMult'
      Origin = 'tblprocstowawaylines.UOMMult'
      Visible = False
    end
    object QryprocStowawayLinesmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
      Origin = 'tblprocstowawaylines.mstimeStamp'
      Visible = False
    end
    object QryprocStowawayLinesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblprocstowawaylines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object QryprocStowawayLinesDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblprocstowawaylines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryprocStowawayLinesProctreeStowId: TIntegerField
      FieldName = 'ProctreeStowId'
      Origin = 'tblprocstowawaylines.ProctreeStowId'
      Visible = False
    end
  end
  object dsprocStowawayLines: TDataSource
    DataSet = QryprocStowawayLines
    Left = 115
    Top = 241
  end
  object QryProcTreeStow: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblProcTreeStow'
      'WHERE ProcTreeId= :ID')
    Left = 36
    Top = 197
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QryProcTreeStowID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblproctreestow.ID'
    end
    object QryProcTreeStowGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblproctreestow.GlobalRef'
      Size = 255
    end
    object QryProcTreeStowProcTreeId: TIntegerField
      FieldName = 'ProcTreeId'
      Origin = 'tblproctreestow.ProcTreeId'
    end
    object QryProcTreeStowDateCreated: TDateTimeField
      FieldName = 'DateCreated'
      Origin = 'tblproctreestow.DateCreated'
    end
    object QryProcTreeStowTotalStowedQty: TFloatField
      FieldName = 'TotalStowedQty'
      Origin = 'tblproctreestow.TotalStowedQty'
    end
    object QryProcTreeStowExtraQtyToCustomer: TFloatField
      FieldName = 'ExtraQtyToCustomer'
      Origin = 'tblproctreestow.ExtraQtyToCustomer'
    end
    object QryProcTreeStowExtraQtytoStore: TFloatField
      FieldName = 'ExtraQtytoStore'
      Origin = 'tblproctreestow.ExtraQtytoStore'
    end
    object QryProcTreeStowmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblproctreestow.msTimeStamp'
    end
    object QryProcTreeStowmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblproctreestow.msUpdateSiteCode'
      Size = 3
    end
  end
  object dsProcTreeStow: TDataSource
    DataSet = QryProcTreeStow
    Left = 36
    Top = 233
  end
  object Qryproctree: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PT.proctreeId  , PT.ManufactureQty , PT.ManufactureUOMQty' +
        ', PT.TreePartUOM, PT.TreePartUOMID, PT.TreePartUOMMultiplier, S.' +
        'isinternalorder,'
      
        'concat(PT.TreePartUOM, '#39'('#39' , PT.TreePartUOMMultiplier,'#39')'#39') as UO' +
        'M'
      'FROM tblproctree PT '
      'inner join tblSaleslines SL on PT.MasterId = SL.SaleLineId'
      'inner join tblSales S on S.SaleId = SL.SaLeId'
      'where PT.ProctreeId = :ProctreeId')
    AfterOpen = QryproctreeAfterOpen
    Left = 147
    Top = 205
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProctreeId'
      end>
    object QryproctreeproctreeId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'proctreeId'
      Origin = 'PT.proctreeId'
    end
    object QryproctreeManufactureQty: TFloatField
      FieldName = 'ManufactureQty'
      Origin = 'PT.ManufactureQty'
    end
    object QryproctreeManufactureUOMQty: TFloatField
      FieldName = 'ManufactureUOMQty'
      Origin = 'PT.ManufactureUOMQty'
    end
    object QryproctreeTreePartUOM: TWideStringField
      FieldName = 'TreePartUOM'
      Origin = 'PT.TreePartUOM'
      Size = 100
    end
    object QryproctreeTreePartUOMID: TLargeintField
      FieldName = 'TreePartUOMID'
      Origin = 'PT.TreePartUOMID'
    end
    object QryproctreeTreePartUOMMultiplier: TFloatField
      FieldName = 'TreePartUOMMultiplier'
      Origin = 'PT.TreePartUOMMultiplier'
    end
    object Qryproctreeisinternalorder: TWideStringField
      FieldName = 'isinternalorder'
      Origin = 'S.isinternalorder'
      FixedChar = True
      Size = 1
    end
    object QryproctreeUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 124
    end
  end
  object dsproctree: TDataSource
    DataSet = Qryproctree
    Left = 147
    Top = 241
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 275
    Top = 181
  end
end
