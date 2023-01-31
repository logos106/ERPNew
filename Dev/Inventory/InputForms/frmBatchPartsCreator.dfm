inherited frmBatchParts: TfrmBatchParts
  Left = 233
  Top = 146
  HelpContext = 235000
  Caption = 'Batch Part Creator'
  ClientWidth = 792
  OldCreateOrder = True
  ExplicitLeft = 233
  ExplicitTop = 146
  ExplicitWidth = 808
  DesignSize = (
    792
    532)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Width = 792
    ExplicitWidth = 792
    HelpContext = 235043
  end
  inherited imgGridWatermark: TImage
    HelpContext = 235001
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 141
    Width = 792
    Height = 330
    HelpContext = 235011
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object DNMPanel5: TDNMPanel
      Left = 632
      Top = 1
      Width = 159
      Height = 327
      HelpContext = 235012
      UseDockManager = False
      DragMode = dmAutomatic
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      TabStop = True
      OnDragDrop = DNMPanel5DragDrop
      OnDragOver = DNMPanel5DragOver
      OnStartDrag = DNMPanel5StartDrag
      DesignSize = (
        159
        327)
      object lblCatagory5: TLabel
        Left = 4
        Top = 8
        Width = 149
        Height = 15
        HelpContext = 235013
        Alignment = taCenter
        AutoSize = False
        Caption = 'Catagory #5'
        DragMode = dmAutomatic
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnDragDrop = DNMPanel5DragDrop
        OnDragOver = DNMPanel5DragOver
        OnStartDrag = DNMPanel5StartDrag
      end
      object wwDBGrid5: TwwDBGrid
        Left = 4
        Top = 30
        Width = 151
        Height = 267
        HelpContext = 235014
        Selected.Strings = (
          'DescriptionAttribValue'#9'14'#9'Attribute')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = []
        DataSource = dsCatagory5
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTabExitsOnLastCol]
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
      object btnSelectAll5: TDNMSpeedButton
        Left = 40
        Top = 300
        Width = 75
        Height = 24
        HelpContext = 235015
        Caption = 'Select All'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        OnClick = btnSelectAll5Click
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 473
      Top = 1
      Width = 159
      Height = 327
      HelpContext = 235016
      UseDockManager = False
      DragMode = dmAutomatic
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TabStop = True
      OnDragDrop = DNMPanel6DragDrop
      OnDragOver = DNMPanel6DragOver
      OnStartDrag = DNMPanel6StartDrag
      DesignSize = (
        159
        327)
      object lblCatagory4: TLabel
        Left = 8
        Top = 8
        Width = 145
        Height = 15
        HelpContext = 235017
        Alignment = taCenter
        AutoSize = False
        Caption = 'Catagory #4'
        DragMode = dmAutomatic
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnDragDrop = DNMPanel6DragDrop
        OnDragOver = DNMPanel6DragOver
        OnStartDrag = DNMPanel6StartDrag
      end
      object wwDBGrid2: TwwDBGrid
        Left = 4
        Top = 30
        Width = 151
        Height = 267
        HelpContext = 235018
        Selected.Strings = (
          'DescriptionAttribValue'#9'14'#9'Attribute')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = []
        DataSource = dsCatagory4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTabExitsOnLastCol]
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
      object btnSelectAll4: TDNMSpeedButton
        Left = 40
        Top = 300
        Width = 75
        Height = 24
        HelpContext = 235019
        Caption = 'Select All'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        OnClick = btnSelectAll4Click
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 314
      Top = 1
      Width = 159
      Height = 327
      HelpContext = 235020
      UseDockManager = False
      DragMode = dmAutomatic
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      TabStop = True
      OnDragDrop = DNMPanel7DragDrop
      OnDragOver = DNMPanel7DragOver
      OnStartDrag = DNMPanel7StartDrag
      DesignSize = (
        159
        327)
      object lblCatagory3: TLabel
        Left = 4
        Top = 8
        Width = 149
        Height = 15
        HelpContext = 235021
        Alignment = taCenter
        AutoSize = False
        Caption = 'Catagory #3'
        DragMode = dmAutomatic
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnDragDrop = DNMPanel7DragDrop
        OnDragOver = DNMPanel7DragOver
        OnStartDrag = DNMPanel7StartDrag
      end
      object wwDBGrid3: TwwDBGrid
        Left = 4
        Top = 30
        Width = 151
        Height = 267
        HelpContext = 235022
        Selected.Strings = (
          'DescriptionAttribValue'#9'14'#9'Attribute')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = []
        DataSource = dsCatagory3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTabExitsOnLastCol]
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
      object btnSelectAll3: TDNMSpeedButton
        Left = 40
        Top = 300
        Width = 75
        Height = 24
        HelpContext = 235023
        Caption = 'Select All'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        OnClick = btnSelectAll3Click
      end
    end
    object DNMPanel8: TDNMPanel
      Left = 155
      Top = 1
      Width = 159
      Height = 327
      HelpContext = 235024
      UseDockManager = False
      DragMode = dmAutomatic
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      TabStop = True
      OnDragDrop = DNMPanel8DragDrop
      OnDragOver = DNMPanel8DragOver
      OnStartDrag = DNMPanel8StartDrag
      DesignSize = (
        159
        327)
      object lblCatagory2: TLabel
        Left = 4
        Top = 8
        Width = 149
        Height = 15
        HelpContext = 235025
        Alignment = taCenter
        AutoSize = False
        Caption = 'Catagory #2'
        DragMode = dmAutomatic
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnDragDrop = DNMPanel8DragDrop
        OnDragOver = DNMPanel8DragOver
        OnStartDrag = DNMPanel8StartDrag
      end
      object wwDBGrid4: TwwDBGrid
        Left = 4
        Top = 30
        Width = 151
        Height = 267
        HelpContext = 235026
        Selected.Strings = (
          'DescriptionAttribValue'#9'14'#9'Attribute')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = []
        DataSource = dsCatagory2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTabExitsOnLastCol]
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
      object btnSelectAll2: TDNMSpeedButton
        Left = 40
        Top = 300
        Width = 75
        Height = 24
        HelpContext = 235027
        Caption = 'Select All'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        OnClick = btnSelectAll2Click
      end
    end
    object DNMPanel9: TDNMPanel
      Left = -4
      Top = 1
      Width = 159
      Height = 327
      HelpContext = 235028
      Alignment = taLeftJustify
      UseDockManager = False
      DragMode = dmAutomatic
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnDragDrop = DNMPanel9DragDrop
      OnDragOver = DNMPanel9DragOver
      OnStartDrag = DNMPanel9StartDrag
      DesignSize = (
        159
        327)
      object lblCatagory1: TLabel
        Left = 4
        Top = 8
        Width = 149
        Height = 15
        HelpContext = 235029
        Alignment = taCenter
        AutoSize = False
        Caption = 'Catagory #1'
        DragMode = dmAutomatic
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        OnDragDrop = DNMPanel9DragDrop
        OnDragOver = DNMPanel9DragOver
        OnStartDrag = DNMPanel9StartDrag
      end
      object wwDBGrid1: TwwDBGrid
        Left = 4
        Top = 30
        Width = 151
        Height = 267
        HelpContext = 235030
        Selected.Strings = (
          'DescriptionAttribValue'#9'14'#9'Attribute'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = []
        DataSource = dsCatagory1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgTabExitsOnLastCol]
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
      object btnSelectAll1: TDNMSpeedButton
        Left = 40
        Top = 300
        Width = 75
        Height = 24
        HelpContext = 235031
        Caption = 'Select All'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        OnClick = btnSelectAll1Click
      end
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 49
    Width = 792
    Height = 92
    HelpContext = 235002
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 75
      Top = 11
      Width = 104
      Height = 15
      HelpContext = 235003
      Alignment = taRightJustify
      Caption = 'Selected Product :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblPartAbbrev: TLabel
      Left = 488
      Top = 10
      Width = 104
      Height = 15
      HelpContext = 235004
      Caption = 'Part Abbreviation :'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblProductDescription: TLabel
      Left = 84
      Top = 36
      Width = 95
      Height = 15
      HelpContext = 235005
      Alignment = taRightJustify
      Caption = 'Known Batches :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 120
      Top = 59
      Width = 553
      Height = 29
      HelpContext = 235006
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'You can swap the order of the columns by selecting the panel wit' +
        'h the left mouse button down and then drag to where you would li' +
        'ke the panel to show.'
      Transparent = True
      WordWrap = True
    end
    object edtPartAbbrev: TEdit
      Left = 600
      Top = 6
      Width = 185
      Height = 23
      HelpContext = 235007
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 25
      ParentFont = False
      TabOrder = 1
    end
    object cboKnownBatchs: TComboBox
      Left = 185
      Top = 33
      Width = 288
      Height = 23
      HelpContext = 235008
      AutoComplete = False
      AutoDropDown = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnCloseUp = cboKnownBatchsCloseUp
      OnSelect = cboKnownBatchsCloseUp
    end
    object edtSearchFilter: TEdit
      Left = 624
      Top = 63
      Width = 161
      Height = 23
      HelpContext = 235009
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnExit = edtSearchFilterExit
    end
    object cboPartName: TwwDBLookupCombo
      Left = 185
      Top = 8
      Width = 288
      Height = 23
      HelpContext = 235010
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryParts
      LookupField = 'PartName'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboPartNameCloseUp
      OnNotInList = cboPartNameNotInList
    end
  end
  object DNMPanel3: TDNMPanel [7]
    Left = 0
    Top = 471
    Width = 792
    Height = 61
    HelpContext = 235032
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label3: TLabel
      Left = 197
      Top = 5
      Width = 361
      Height = 15
      HelpContext = 235033
      Caption = 'To multiply select items you will need to hold down the CTRL key'
      Transparent = True
    end
    object btnCompleted: TDNMSpeedButton
      Left = 129
      Top = 26
      Width = 113
      Height = 26
      HelpContext = 235034
      Caption = '&Create'
      DisableTransparent = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 537
      Top = 26
      Width = 113
      Height = 26
      HelpContext = 235035
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object btnDelete: TDNMSpeedButton
      Left = -24
      Top = 2
      Width = 113
      Height = 26
      HelpContext = 235036
      Caption = '&Delete'
      DisableTransparent = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = btnCompletedClick
    end
    object btnAbbreviator: TDNMSpeedButton
      Left = 265
      Top = 26
      Width = 113
      Height = 26
      HelpContext = 235037
      Caption = '&Abbreviator'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
        333333333373F3333333333330F033333333333337373F33333333330FFF0333
        33333333733F73F333333330F80FF033333333373373373F3333330F80F7FF03
        33333373373F3F73F33330F70F0F0FF03333373F737373F73F33330F77F7F0FF
        03333373F33F373F73F33330F70F0F0FF03333373F737373373F33330F77F7F7
        FF03333373F33F3F3F73333330F70F0F07F03333373F737373373333330F77FF
        7F0333333373F33F337333333330F707F033333333373F733733333333330F7F
        03333333333373F373F33333333330F0303333F3F3F3F73737F3303030303303
        3033373737373F7FF73303030303000003337373737377777333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnAbbreviatorClick
    end
    object btnSave: TDNMSpeedButton
      Left = 401
      Top = 26
      Width = 113
      Height = 26
      HelpContext = 235038
      Caption = 'Save Batch'
      DisableTransparent = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = btnSaveClick
    end
  end
  object DNMPanel4: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 792
    Height = 49
    HelpContext = 235039
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      792
      49)
    object pnlTitle: TDNMPanel
      Left = 219
      Top = 5
      Width = 352
      Height = 39
      HelpContext = 235040
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 348
        Height = 35
        HelpContext = 235041
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
          Width = 348
          Height = 35
          HelpContext = 235042
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Batch Product Creator'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 15
    Top = 53
  end
  inherited MyConnection: TERPConnection
    Left = 47
    Top = 52
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004801140210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsParts: TDataSource
    Left = 79
    Top = 53
  end
  object dsCatID: TDataSource
    DataSet = qrySetupID
    Left = 143
    Top = 53
  end
  object qrySetupID: TERPQuery
    SQL.Strings = (
      
        'SELECT DescriptionAttribID, CatagoryName, Active, EditedFlag ,Gl' +
        'obalRef '
      'FROM tblproductcodeabbrevsetup'
      'ORDER BY DescriptionAttribID')
    Left = 111
    Top = 53
  end
  object dsCatagory2: TDataSource
    DataSet = qryCatagory2
    Left = 565
    Top = 57
  end
  object dsCatagory1: TDataSource
    DataSet = qryCatagory1
    Left = 501
    Top = 57
  end
  object dsCatagory3: TDataSource
    DataSet = qryCatagory3
    Left = 629
    Top = 57
  end
  object dsCatagory4: TDataSource
    DataSet = qryCatagory4
    Left = 693
    Top = 57
  end
  object dsCatagory5: TDataSource
    DataSet = qryCatagory5
    Left = 757
    Top = 57
  end
  object tmrControlMonitor: TTimer
    Interval = 200
    OnTimer = tmrControlMonitorTimer
    Left = 175
    Top = 53
  end
  object dsBatchSaves: TDataSource
    DataSet = qryBatchSaves
    Left = 24
    Top = 200
  end
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblparts '
      
        'WHERE (PartType = '#39'OTHER'#39' OR PartType='#39'INV'#39' OR PartType='#39'NONINV'#39 +
        ') '
      'ORDER BY PartName;')
    Options.LongStrings = False
    Left = 24
    Top = 232
  end
  object qryPartQtyLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblproductClasses;')
    Options.LongStrings = False
    Left = 24
    Top = 296
  end
  object qryPartChecker: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblparts ORDER BY Partname;')
    Options.LongStrings = False
    Left = 24
    Top = 264
  end
  object qryNewPart: TERPQuery
    Connection = MyConnection
    Options.LongStrings = False
    Left = 24
    Top = 328
  end
  object qryNewPartLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblproductClasses;')
    Options.LongStrings = False
    Left = 24
    Top = 360
  end
  object qryBatchSaves: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblbatchsaves ORDER BY BatchName;')
    Options.LongStrings = False
    Left = 56
    Top = 200
  end
  object qryBatchInsert: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblbatchsaves ORDER BY BatchName;')
    Options.LongStrings = False
    Left = 56
    Top = 232
  end
  object qryBatchChecker: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT BatchName FROM tblbatchsaves ORDER BY BatchName;')
    Options.LongStrings = False
    Left = 88
    Top = 200
  end
  object qryCatagory1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribValue, DescriptionAttribAbbrev '
      'FROM tblproductcodeabbrevlines '
      'WHERE (DescriptionAttribID = 1) '
      'ORDER BY DescriptionAttribValue;')
    Options.LongStrings = False
    Left = 469
    Top = 57
    object qryCatagory1DescriptionAttribValue: TWideStringField
      DisplayLabel = 'Attribute'
      DisplayWidth = 14
      FieldName = 'DescriptionAttribValue'
      Size = 255
    end
    object qryCatagory1DescriptionAttribAbbrev: TWideStringField
      DisplayWidth = 3
      FieldName = 'DescriptionAttribAbbrev'
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
  object qryCatagory2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribValue, DescriptionAttribAbbrev '
      'FROM tblproductcodeabbrevlines '
      'WHERE (DescriptionAttribID = 2) '
      'ORDER BY DescriptionAttribValue;')
    Options.LongStrings = False
    Left = 534
    Top = 57
    object StringField1: TWideStringField
      DisplayLabel = 'Attribute'
      DisplayWidth = 14
      FieldName = 'DescriptionAttribValue'
      Size = 255
    end
    object StringField2: TWideStringField
      DisplayWidth = 3
      FieldName = 'DescriptionAttribAbbrev'
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
  object qryCatagory3: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribValue, DescriptionAttribAbbrev '
      'FROM tblproductcodeabbrevlines '
      'WHERE (DescriptionAttribID = 3) '
      'ORDER BY DescriptionAttribValue;')
    Options.LongStrings = False
    Left = 597
    Top = 57
    object StringField3: TWideStringField
      DisplayLabel = 'Attribute'
      DisplayWidth = 14
      FieldName = 'DescriptionAttribValue'
      Size = 255
    end
    object StringField4: TWideStringField
      DisplayWidth = 3
      FieldName = 'DescriptionAttribAbbrev'
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
  object qryCatagory4: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribValue, DescriptionAttribAbbrev '
      'FROM tblproductcodeabbrevlines '
      'WHERE (DescriptionAttribID = 4) '
      'ORDER BY DescriptionAttribValue;')
    Options.LongStrings = False
    Left = 661
    Top = 57
    object StringField5: TWideStringField
      DisplayLabel = 'Attribute'
      DisplayWidth = 14
      FieldName = 'DescriptionAttribValue'
      Size = 255
    end
    object StringField6: TWideStringField
      DisplayWidth = 3
      FieldName = 'DescriptionAttribAbbrev'
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
  object qryCatagory5: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DescriptionAttribValue, DescriptionAttribAbbrev '
      'FROM tblproductcodeabbrevlines '
      'WHERE (DescriptionAttribID = 5) '
      'ORDER BY DescriptionAttribValue;')
    Options.LongStrings = False
    Left = 725
    Top = 57
    object StringField7: TWideStringField
      DisplayLabel = 'Attribute'
      DisplayWidth = 14
      FieldName = 'DescriptionAttribValue'
      Size = 255
    end
    object StringField8: TWideStringField
      DisplayWidth = 3
      FieldName = 'DescriptionAttribAbbrev'
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
end
