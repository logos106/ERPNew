inherited frmShipContainer: TfrmShipContainer
  Left = 647
  Top = 182
  HelpContext = 632000
  Caption = 'Shipping Container'
  ClientHeight = 564
  ClientWidth = 927
  OldCreateOrder = True
  ExplicitLeft = 647
  ExplicitTop = 182
  ExplicitWidth = 943
  ExplicitHeight = 603
  DesignSize = (
    927
    564)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 475
    Width = 927
    HelpContext = 632040
    ExplicitTop = 499
    ExplicitWidth = 927
  end
  inherited imgGridWatermark: TImage
    Left = 3
    Top = 43
    ExplicitLeft = 3
    ExplicitTop = 43
  end
  object pnlgrid: TDNMPanel [5]
    Left = 0
    Top = 171
    Width = 927
    Height = 304
    HelpContext = 632044
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object lblMsg: TLabel
      Left = 1
      Top = 272
      Width = 925
      Height = 15
      HelpContext = 632045
      Align = alBottom
      Alignment = taCenter
      Caption = 'lblMsg'
      Visible = False
      ExplicitWidth = 37
    end
    object grdDetails: TwwDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 734
      Height = 265
      HelpContext = 632020
      Selected.Strings = (
        'orderdate'#9'18'#9'Order Date'#9'F'
        'InvoiceNumber'#9'1'#9'Invoice Number'#9'T'
        'Suppliername'#9'15'#9'Supplier'#9'F'
        'CustomerJob'#9'13'#9'Customer Job'#9'F'
        'CommercialInvNo'#9'13'#9'Com Inv No'#9'F'
        'SupplierWorkOrderNo'#9'13'#9'Sup Work Order No'#9'F'
        'ForeignCurrencyLineCost'#9'13'#9'Total Foreign'#9'F'
        'ProductName'#9'13'#9'Product Name'#9'F'
        'Product_Description'#9'15'#9'Product Description'#9'F'
        'UnitOfMeasureQtySold'#9'12'#9'Ordered'#9'F'
        'ReceivedQty'#9'10'#9'Received'#9'F'
        'UnitOfMeasurePOLines'#9'10'#9'Units'#9'F'
        'TotalAmountInc'#9'10'#9'Total Amount'#9'F'
        'Class'#9'15'#9'Department'#9'F'
        'PurchaseOrderID'#9'9'#9'From PO #'#9'T'
        'LandedCostsPercentage'#9'15'#9'L/C %'#9'F'
        'LandedCostsPerItem'#9'15'#9'L/C Prod'#9'F'
        'TotalLineLandedCosts'#9'10'#9'Tot L/C'#9'F'
        'InvoiceDate'#9'10'#9'Invoice Date'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = dsShipContainerDetailsforGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowDelete]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      OnTitleButtonClick = grdDetailsTitleButtonClick
      OnDblClick = grdDetailsDblClick
      OnCalcTitleImage = grdDetailsCalcTitleImage
      TitleImageList = imgPopup
      object grdDetailsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 22
        HelpContext = 632021
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = grdDetailsIButtonClick
      end
    end
    object ProgressBar: TProgressBar
      Left = 1
      Top = 287
      Width = 925
      Height = 16
      HelpContext = 632046
      Align = alBottom
      TabOrder = 1
      Visible = False
    end
    object grdbusobj: TwwDBGrid
      AlignWithMargins = True
      Left = 744
      Top = 4
      Width = 179
      Height = 265
      HelpContext = 632068
      Selected.Strings = (
        'PurchaseLineID'#9'10'#9'PurchaseLineID'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alRight
      DataSource = DSShipContainerDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowDelete]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      OnDblClick = grdDetailsDblClick
      object wwIButton1: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 22
        HelpContext = 632069
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = grdDetailsIButtonClick
      end
    end
  end
  object pnlBottom: TDNMPanel [6]
    Left = 0
    Top = 475
    Width = 927
    Height = 89
    HelpContext = 632047
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      927
      89)
    object Label8: TLabel
      Left = 8
      Top = 8
      Width = 36
      Height = 15
      HelpContext = 632048
      Caption = 'Notes:'
      Transparent = True
    end
    object btnSave: TDNMSpeedButton
      Left = 268
      Top = 54
      Width = 87
      Height = 27
      HelpContext = 632016
      Action = actSave
      Anchors = [akBottom]
      Caption = '&Save'
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
      AutoDisableParentOnclick = True
    end
    object btnNew: TDNMSpeedButton
      Left = 568
      Top = 54
      Width = 87
      Height = 27
      HelpContext = 632017
      Action = actNew
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
      TabOrder = 1
      AutoDisableParentOnclick = True
    end
    object btnCancel: TDNMSpeedButton
      Left = 718
      Top = 54
      Width = 87
      Height = 27
      HelpContext = 632018
      Action = actCancel
      Anchors = [akBottom]
      Caption = '&Close'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
    end
    object chkActive: TwwCheckBox
      Left = 853
      Top = 60
      Width = 65
      Height = 17
      HelpContext = 632049
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
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      DataField = 'Active'
      DataSource = DSShippingContainer
      TabOrder = 3
    end
    object ContainerNotes: TDBMemo
      Left = 53
      Top = 4
      Width = 328
      Height = 42
      Hint = '"Type In A Comment For The Warehouse"'
      HelpContext = 632050
      DataField = 'ContainerNotes'
      DataSource = DSShippingContainer
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object DNMPanel2: TDNMPanel
      Left = 386
      Top = 5
      Width = 515
      Height = 43
      HelpContext = 632051
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      DesignSize = (
        515
        43)
      object Bevel1: TBevel
        Left = 273
        Top = 4
        Width = 235
        Height = 36
        HelpContext = 632052
        Anchors = [akTop]
        Shape = bsFrame
      end
      object cmdIncudeLandeCost: TDNMSpeedButton
        Left = 281
        Top = 8
        Width = 106
        Height = 27
        HelpContext = 632053
        Anchors = [akTop]
        Caption = 'Import Costs'
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
        TabOrder = 0
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = cmdIncudeLandeCostClick
      end
      object btnAdd: TDNMSpeedButton
        Left = 6
        Top = 9
        Width = 106
        Height = 27
        HelpContext = 632019
        Anchors = [akBottom]
        Caption = '&Add to Container'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnAddClick
      end
      object edTotalImportCosts: TwwDBEdit
        Left = 393
        Top = 10
        Width = 108
        Height = 23
        HelpContext = 632054
        Anchors = [akTop]
        DataField = 'TotalAuxilaryCosts'
        DataSource = DSShipContainerDetails
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
      end
      object btnRecieve: TDNMSpeedButton
        Left = 143
        Top = 9
        Width = 100
        Height = 27
        HelpContext = 632055
        Caption = '&Receive All'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnRecieveClick
      end
    end
    object btnPrint: TDNMSpeedButton
      Left = 418
      Top = 54
      Width = 87
      Height = 27
      HelpContext = 632056
      Anchors = [akBottom]
      Caption = '&Print'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btnApply: TDNMSpeedButton
      Left = 328
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 632057
      Action = actApply
      Anchors = [akBottom]
      Caption = 'Apply'
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
      TabOrder = 7
      Visible = False
      AutoDisableParentOnclick = True
    end
    object cmdEmail: TDNMSpeedButton
      Left = 119
      Top = 54
      Width = 87
      Height = 27
      HelpContext = 632058
      Caption = '&Email / SMS'
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
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = cmdEmailClick
    end
  end
  object DNMPanel3: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 927
    Height = 58
    HelpContext = 632059
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      927
      58)
    object pnlTitle: TDNMPanel
      Left = 226
      Top = 8
      Width = 475
      Height = 41
      HelpContext = 632060
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
        Width = 471
        Height = 37
        HelpContext = 632061
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
          Width = 471
          Height = 37
          HelpContext = 632062
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Shipping Container'
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
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 58
    Width = 927
    Height = 113
    HelpContext = 632001
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 13
      Top = 8
      Width = 91
      Height = 15
      HelpContext = 632002
      Caption = 'Container Name'
      Transparent = True
    end
    object Label7: TLabel
      Left = 13
      Top = 57
      Width = 148
      Height = 15
      HelpContext = 632003
      Caption = 'Estimated Time Departure'
      Transparent = True
    end
    object Label2: TLabel
      Left = 213
      Top = 57
      Width = 128
      Height = 15
      HelpContext = 632004
      Caption = 'Estimated Time Arrival'
      Transparent = True
    end
    object Label5: TLabel
      Left = 577
      Top = 8
      Width = 74
      Height = 15
      HelpContext = 632005
      Caption = 'Vessel Name'
      Transparent = True
    end
    object Label3: TLabel
      Left = 765
      Top = 8
      Width = 37
      Height = 15
      HelpContext = 632006
      Caption = 'Status'
      Transparent = True
    end
    object Label4: TLabel
      Left = 386
      Top = 57
      Width = 89
      Height = 15
      HelpContext = 632007
      Caption = 'Departure Point'
      Transparent = True
    end
    object Label6: TLabel
      Left = 577
      Top = 57
      Width = 69
      Height = 15
      HelpContext = 632008
      Caption = 'Arrival Point'
      Transparent = True
    end
    object Label9: TLabel
      Left = 213
      Top = 8
      Width = 103
      Height = 15
      HelpContext = 632064
      Caption = 'Container Number'
      Transparent = True
    end
    object Label10: TLabel
      Left = 386
      Top = 8
      Width = 82
      Height = 15
      HelpContext = 632065
      Caption = 'Container Size'
      Transparent = True
    end
    object edName: TwwDBEdit
      Left = 13
      Top = 24
      Width = 174
      Height = 23
      HelpContext = 632009
      DataField = 'ContainerName'
      DataSource = DSShippingContainer
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object dtETD: TwwDBDateTimePicker
      Left = 13
      Top = 73
      Width = 147
      Height = 23
      HelpContext = 632010
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ETDeparture'
      DataSource = DSShippingContainer
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 5
    end
    object dtETA: TwwDBDateTimePicker
      Left = 213
      Top = 73
      Width = 147
      Height = 23
      HelpContext = 632011
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ETA'
      DataSource = DSShippingContainer
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 6
    end
    object edVessel: TwwDBEdit
      Left = 577
      Top = 24
      Width = 173
      Height = 23
      HelpContext = 632012
      DataField = 'VesselName'
      DataSource = DSShippingContainer
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboStatus: TwwDBLookupCombo
      Left = 765
      Top = 24
      Width = 149
      Height = 23
      HelpContext = 632013
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'name'#9'25'#9'name'#9'F')
      DataField = 'ShippingContainerStatus'
      DataSource = DSShippingContainer
      LookupTable = qrySimpleTypes
      LookupField = 'Name'
      ParentFont = False
      TabOrder = 4
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      ShowMatchText = True
      OnNotInList = cboStatusNotInList
    end
    object edDeparture: TwwDBEdit
      Left = 386
      Top = 73
      Width = 181
      Height = 23
      HelpContext = 632014
      DataField = 'DeparturePoint'
      DataSource = DSShippingContainer
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edArrival: TwwDBEdit
      Left = 577
      Top = 73
      Width = 181
      Height = 23
      HelpContext = 632015
      DataField = 'ArrivalPoint'
      DataSource = DSShippingContainer
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtContainerNumber: TwwDBEdit
      Left = 213
      Top = 24
      Width = 134
      Height = 23
      HelpContext = 632066
      DataField = 'ContainerNumber'
      DataSource = DSShippingContainer
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtContainerSize: TwwDBEdit
      Left = 386
      Top = 24
      Width = 134
      Height = 23
      HelpContext = 632067
      DataField = 'ContainerSize'
      DataSource = DSShippingContainer
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object pnlChooseRpt: TDNMPanel
      Left = 765
      Top = 73
      Width = 128
      Height = 23
      HelpContext = 632041
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object lblChooseRpt: TLabel
        Left = 25
        Top = 4
        Width = 98
        Height = 15
        HelpContext = 632042
        Caption = 'Choose Template'
        ParentShowHint = False
        ShowHint = True
        Transparent = True
      end
      object chkChooseRpt: TCheckBox
        Left = 5
        Top = 3
        Width = 14
        Height = 17
        HelpContext = 632043
        TabStop = False
        TabOrder = 0
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 886
    Top = 300
  end
  inherited tmrdelay: TTimer
    Left = 886
    Top = 266
  end
  inherited popSpelling: TPopupMenu
    Left = 849
    Top = 333
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 849
    Top = 400
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 849
    Top = 200
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 813
    Top = 400
  end
  inherited DataState: TDataState
    Left = 886
    Top = 233
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 849
    Top = 233
  end
  inherited imgsort: TImageList
    Left = 886
    Top = 200
    Bitmap = {
      494C01010200C800E00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 813
    Top = 300
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 849
    Top = 266
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 849
    Top = 300
  end
  inherited qryMemTrans: TERPQuery
    Left = 813
    Top = 200
  end
  object DSShippingContainer: TDataSource
    DataSet = qryShippingContainer
    Left = 782
    Top = 366
  end
  object qryShippingContainer: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblshippingcontainer')
    Left = 813
    Top = 366
    object qryShippingContainerShippingContainerID: TIntegerField
      FieldName = 'ShippingContainerID'
    end
    object qryShippingContainerContainerName: TWideStringField
      FieldName = 'ContainerName'
      Size = 255
    end
    object qryShippingContainerETDeparture: TDateField
      FieldName = 'ETDeparture'
    end
    object qryShippingContainerShippingContainerStatus: TWideStringField
      FieldName = 'ShippingContainerStatus'
      Size = 255
    end
    object qryShippingContainerDeparturePoint: TWideStringField
      FieldName = 'DeparturePoint'
      Size = 255
    end
    object qryShippingContainerVesselName: TWideStringField
      FieldName = 'VesselName'
      Size = 255
    end
    object qryShippingContainerETA: TDateField
      FieldName = 'ETA'
    end
    object qryShippingContainerArrivalPoint: TWideStringField
      FieldName = 'ArrivalPoint'
      Size = 255
    end
    object qryShippingContainerActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryShippingContainerContainerNotes: TWideMemoField
      FieldName = 'ContainerNotes'
      BlobType = ftWideMemo
    end
    object qryShippingContainerGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryShippingContainerContainerNumber: TWideStringField
      FieldName = 'ContainerNumber'
      Size = 255
    end
    object qryShippingContainerContainerSize: TWideStringField
      FieldName = 'ContainerSize'
      Size = 255
    end
    object qryShippingContainermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object qrySimpleTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'ShippingContainerStatusType'#39
      'AND Active = '#39'T'#39
      'ORDER BY Name')
    Left = 813
    Top = 233
    object qrySimpleTypesname: TWideStringField
      DisplayWidth = 25
      FieldName = 'name'
      Size = 255
    end
  end
  object ActionList: TActionList
    Left = 849
    Top = 366
    object actSave: TAction
      Caption = 'Save'
      HelpContext = 632037
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
    object actCancel: TAction
      Caption = '&Close'
      HelpContext = 632038
      OnExecute = actCancelExecute
    end
    object actNew: TAction
      Caption = 'New'
      HelpContext = 632039
      OnExecute = actNewExecute
    end
    object actApply: TAction
      Caption = 'Apply'
      HelpContext = 632063
      OnExecute = actApplyExecute
      OnUpdate = actApplyUpdate
    end
  end
  object qryShipContainerDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT SD.*'
      'FROM tblshipcontainerdetails SD')
    Left = 813
    Top = 333
    object qryShipContainerDetailsShipContainerDetailID: TIntegerField
      FieldName = 'ShipContainerDetailID'
    end
    object qryShipContainerDetailsShippingContainerID: TIntegerField
      FieldName = 'ShippingContainerID'
    end
    object qryShipContainerDetailsGLOBALREF: TWideStringField
      FieldName = 'GLOBALREF'
      Size = 255
    end
    object qryShipContainerDetailsCommercialInvNo: TWideStringField
      FieldName = 'CommercialInvNo'
      Size = 255
    end
    object qryShipContainerDetailsSupplierWorkOrderNo: TWideStringField
      FieldName = 'SupplierWorkOrderNo'
      Size = 255
    end
    object qryShipContainerDetailsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryShipContainerDetailsPurchaseLineID: TIntegerField
      FieldName = 'PurchaseLineID'
    end
    object qryShipContainerDetailsTotalAuxilaryCosts: TFloatField
      FieldName = 'TotalAuxilaryCosts'
      currency = True
    end
    object qryShipContainerDetailsAuxilaryCostsPercentage: TFloatField
      FieldName = 'AuxilaryCostsPercentage'
    end
    object qryShipContainerDetailsAuxilaryCostsPerItem: TFloatField
      FieldName = 'AuxilaryCostsPerItem'
    end
    object qryShipContainerDetailsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryShipContainerDetailsPurchaseOrderID: TIntegerField
      FieldKind = fkLookup
      FieldName = 'PurchaseOrderID'
      LookupDataSet = qryShipContainerDetailsforGrid
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'PurchaseOrderID'
      KeyFields = 'PurchaseLineID'
      Lookup = True
    end
  end
  object DSShipContainerDetails: TDataSource
    DataSet = qryShipContainerDetails
    Left = 781
    Top = 333
  end
  object qryShipContainerDetailsforGrid: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'SD.*,'
      'POL.SaleLineID,'
      'SL.SaleID,'
      
        'POL.ForeignCurrencyLineCost * POL.qtySold as ForeignCurrencyLine' +
        'Cost,'
      'POL.BaseLineNo,'
      'SDPOL.ProductName,'
      'SDPOL.PurchaseLineID,'
      'SDPO.orderdate,'
      'SDPOL.LandedCostsPercentage,'
      'SDPOL.LandedCostsTotal,'
      'SDPOL.LandedCostsPerItem,'
      'SDPOL.UnitOfMeasureShipped as ReceivedQty,'
      'SDPOL.LineCostInc *SDPOL.qtysold as TotalAmountInc,'
      'SDPOL.BaseLineNo, '
      'SDPOL.class,'
      'SDPOL.UnitOfMeasureQtySold,'
      'SDPOL.Product_Description,'
      'SDPO.SupplierName,'
      'SDPOL.CustomerJob,'
      'SDPO.PurchaseOrderID,'
      'SDPOL.UnitOfMeasurePOLines,'
      
        'SDPOL.ForeignCurrencyLineCost * SDPOL.qtysold as ForeignCurrency' +
        'LIneCost,'
      'SDPO.ForeignExchangeCode as FXCode,'
      'SDPOL.QtySold,'
      'SDPO.InvoiceNumber , '
      'SDPO.InvoiceDate,'
      'SDPOL.QtySold*SDPOL.LandedCostsPerItem as TotalLineLandedCosts'
      'FROM tblshipcontainerdetails SD'
      
        'INNER JOIN tblshippingcontainer SC ON SC.ShippingContainerID = S' +
        'D.ShippingContainerID'
      
        'INNER JOIN tblpurchaselines POL ON (SD.PurchaseLineID = POL.Purc' +
        'haseLineID OR SD.PurchaseLineID=POL.BaseLineNo)'
      'LEFT JOIN tblsalesLines SL ON POL.SaleLineID= SL.SaleLineID '
      
        'Left join (tblpurchaselines SDPOL INNER JOIN tblpurchaseorders S' +
        'DPO ON SDPOL.purchaseorderID = SDPO.purchaseOrderID) on SD.Purch' +
        'aseLineID = SDPOL.PurchaseLineID '
      'WHERE SC.Active = "T"'
      'AND SC.ShippingContainerID = :xShippingContainerID'
      '/* ORDER BY CustomerJob */')
    AfterScroll = qryShipContainerDetailsForGridAfterScroll
    FetchAll = False
    Left = 813
    Top = 266
    ParamData = <
      item
        DataType = ftInteger
        Name = 'xShippingContainerID'
        Value = 7
      end>
    object qryShipContainerDetailsforGridPurchaseLineID: TIntegerField
      DisplayLabel = 'Purchase LineID'
      DisplayWidth = 15
      FieldName = 'PurchaseLineID'
      Origin = 'SD.PurchaseLineID'
    end
    object qryShipContainerDetailsforGridCommercialInvNo: TWideStringField
      DisplayLabel = 'Commercial Inv No'
      DisplayWidth = 20
      FieldName = 'CommercialInvNo'
      Origin = 'SD.CommercialInvNo'
      Size = 255
    end
    object qryShipContainerDetailsforGridSupplierWorkOrderNo: TWideStringField
      DisplayLabel = 'Supplier Work Order No'
      DisplayWidth = 20
      FieldName = 'SupplierWorkOrderNo'
      Origin = 'SD.SupplierWorkOrderNo'
      Size = 255
    end
    object qryShipContainerDetailsforGridProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'SDPOL.ProductName'
      Size = 60
    end
    object qryShipContainerDetailsforGridTotalAmountInc: TFloatField
      DisplayLabel = 'Total Amount Inc'
      DisplayWidth = 10
      FieldName = 'TotalAmountInc'
      Origin = 'TotalAmountInc'
      currency = True
    end
    object qryShipContainerDetailsforGridUnitOfMeasureQtySold: TFloatField
      DisplayLabel = 'Qty Sold'
      DisplayWidth = 12
      FieldName = 'UnitOfMeasureQtySold'
      Origin = 'SDPOL.UnitOfMeasureQtySold'
    end
    object qryShipContainerDetailsforGridDepartment: TWideStringField
      DisplayWidth = 20
      FieldName = 'Class'
      Origin = 'SDPOL.class'
      Size = 255
    end
    object qryShipContainerDetailsforGridProductDescription: TWideStringField
      DisplayLabel = 'Product Description'
      DisplayWidth = 30
      FieldName = 'Product_Description'
      Origin = 'SDPOL.Product_Description'
      Size = 255
    end
    object qryShipContainerDetailsforGridShipContainerDetailID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ShipContainerDetailID'
      Origin = 'SD.ShipContainerDetailID'
      Visible = False
    end
    object qryShipContainerDetailsforGridShippingContainerID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShippingContainerID'
      Origin = 'SD.ShippingContainerID'
      Visible = False
    end
    object qryShipContainerDetailsforGridGLOBALREF: TWideStringField
      DisplayWidth = 20
      FieldName = 'GLOBALREF'
      Origin = 'SD.GLOBALREF'
      Visible = False
      Size = 255
    end
    object qryShipContainerDetailsforGridSupplier: TWideStringField
      FieldName = 'Suppliername'
      Origin = 'SDPO.SupplierName'
      Size = 255
    end
    object qryShipContainerDetailsforGridCustomerJob: TWideStringField
      FieldName = 'CustomerJob'
      Origin = 'SDPOL.CustomerJob'
      Size = 255
    end
    object qryShipContainerDetailsforGridPurchaseOrderID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PurchaseOrderID'
      Origin = 'SDPO.PurchaseOrderID'
    end
    object qryShipContainerDetailsforGridUnits: TWideStringField
      FieldName = 'UnitOfMeasurePOLines'
      Origin = 'SDPOL.UnitOfMeasurePOLines'
      Size = 255
    end
    object qryShipContainerDetailsforGridforeignAmountInc: TFloatField
      FieldName = 'ForeignCurrencyLineCost'
      Origin = 'ForeignCurrencyLineCost'
      DisplayFormat = '#,##0.00#'
      currency = True
    end
    object qryShipContainerDetailsforGridForeignExchangeCode: TWideStringField
      FieldName = 'FXCode'
      Origin = 'SDPO.FXCode'
      Size = 3
    end
    object qryShipContainerDetailsforGridforeignAmountStr: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'foreignAmountStr'
      Size = 255
      Calculated = True
    end
    object qryShipContainerDetailsforGridLandedCostsTotal: TFloatField
      FieldName = 'LandedCostsTotal'
      Origin = 'SDPOL.LandedCostsTotal'
      currency = True
    end
    object qryShipContainerDetailsforGridLandedCostsPercentage: TFloatField
      FieldName = 'LandedCostsPercentage'
      Origin = 'SDPOL.LandedCostsPercentage'
    end
    object qryShipContainerDetailsforGridLandedCostsPerItem: TFloatField
      FieldName = 'LandedCostsPerItem'
      Origin = 'SDPOL.LandedCostsPerItem'
      currency = True
    end
    object qryShipContainerDetailsforGridTotalAuxilaryCosts: TFloatField
      FieldName = 'TotalAuxilaryCosts'
      Origin = 'SD.TotalAuxilaryCosts'
      currency = True
    end
    object qryShipContainerDetailsforGridAuxilaryCostsPercentage: TFloatField
      FieldName = 'AuxilaryCostsPercentage'
      Origin = 'SD.AuxilaryCostsPercentage'
    end
    object qryShipContainerDetailsforGridAuxilaryCostsPerItem: TFloatField
      FieldName = 'AuxilaryCostsPerItem'
      Origin = 'SD.AuxilaryCostsPerItem'
      currency = True
    end
    object qryShipContainerDetailsforGridQtySold: TFloatField
      FieldName = 'QtySold'
      Origin = 'SDPOL.QtySold'
    end
    object qryShipContainerDetailsforGridTotalLineLandedCosts: TFloatField
      FieldName = 'TotalLineLandedCosts'
      Origin = 'TotalLineLandedCosts'
      currency = True
    end
    object qryShipContainerDetailsforGridBaseLineNo: TIntegerField
      FieldName = 'BaseLineNo'
      Origin = 'POL.BaseLineNo'
    end
    object qryShipContainerDetailsforGridReceivedQty: TFloatField
      DisplayLabel = 'Received Qty'
      FieldName = 'ReceivedQty'
      Origin = 'SDPOL.ReceivedQty'
    end
    object qryShipContainerDetailsforGridInvoiceNumber: TWideStringField
      DisplayLabel = 'Invoice Number'
      DisplayWidth = 10
      FieldName = 'InvoiceNumber'
      Origin = 'SDPO.InvoiceNumber'
    end
    object qryShipContainerDetailsforGridorderdate: TDateTimeField
      FieldName = 'orderdate'
      Origin = 'SDPO.orderdate'
    end
    object qryShipContainerDetailsforGridInvoiceDate: TDateField
      FieldName = 'InvoiceDate'
      Origin = 'SDPO.InvoiceDate'
    end
  end
  object dsShipContainerDetailsforGrid: TDataSource
    DataSet = qryShipContainerDetailsforGrid
    Left = 781
    Top = 266
  end
  object imgPopup: TImageList
    Left = 745
    Top = 328
    Bitmap = {
      494C010108002C03440310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000BFBFBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000FFFFFF000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF007F7F7F0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF007F7F7F00FFFFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF007F7F7F0000FFFF00FFFFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000FFFF00FFFFFF007F7F7F00FFFFFF0000FFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000000000FF000000
      FF000000FF000000FF000000000000FF000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000FF
      FF0000FFFF00000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000000000FF000000FF000000FF000000000000FF000000FF00
      0000FF0000007F7F7F0000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF0000FFFF00FFFFFF000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      FF000000000000FF000000FF000000FF000000FF000000FF000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008080000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF0000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000080800000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000808000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000808000008080000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FDFF8000FEFFFFFFF8FF8000FC7FF83F
      F8FFC000FC7F1010F87FE000D837E00FF81FF000E00FC007F80FF800E00F8003
      F00FFC00C0078003E00F0600C0078003E00F070000018003E00F0180C0078003
      F01F0180C007C007F00F0060E00FE00FF00FC060E00F3018F007C060D837F83F
      F007F044FEFFFFFFF007F07EFEFFFFFFFFFDFFFF847FE00FFFF8FFFF00EFE00F
      FFF1F9FF31BFE00FFFE3F0FF39FFF00FFFC7F0FF993FF00FE08FE07FCA1FF80F
      C01FC07FF40FF007803F843F9C07F007001F1E3F9603F007001FFE1FCB01F00F
      001FFF1FFF80F01F001FFF8FF7C0F81F001FFFC7FFE0FE1F803FFFE3EFF0FF1F
      C07FFFF8FFF8FF1FE0FFFFFFFFFCFFBF00000000000000000000000000000000
      000000000000}
  end
end
