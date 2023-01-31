inherited fmBarCodeManufacturing: TfmBarCodeManufacturing
  Left = 190
  Top = 122
  HelpContext = 753000
  Caption = 'Barcode Manufacturing'
  ClientHeight = 565
  ClientWidth = 1234
  OldCreateOrder = True
  ExplicitLeft = 190
  ExplicitTop = 122
  ExplicitWidth = 1250
  ExplicitHeight = 604
  DesignSize = (
    1234
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 435
    Width = 1234
    HelpContext = 753109
    ExplicitTop = 411
    ExplicitWidth = 998
  end
  inherited shapehint: TShape
    Left = 17
    ExplicitLeft = 13
  end
  inherited shapehintextra1: TShape
    Left = 70
    ExplicitLeft = 54
  end
  object pnlJobs: TDNMPanel [5]
    Left = 0
    Top = 131
    Width = 1234
    Height = 304
    HelpContext = 753001
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object lbltimesheethint: TLabel
      Left = 1
      Top = 288
      Width = 1232
      Height = 15
      HelpContext = 753002
      Align = alBottom
      Alignment = taCenter
      Caption = 'Lines in Red Colour are Started by :Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 249
    end
    object splComments: TAdvSplitter
      AlignWithMargins = True
      Left = 1080
      Top = 45
      Height = 243
      HelpContext = 753135
      Margins.Left = 0
      Margins.Top = 44
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitLeft = 1022
      ExplicitTop = -1
      ExplicitHeight = 287
    end
    object grdJobs: TwwDBGrid
      Left = 1
      Top = 1
      Width = 1079
      Height = 287
      HelpContext = 753003
      ControlType.Strings = (
        'Complete;CheckBox;T;F')
      Selected.Strings = (
        'InvoiceDocNumber'#9'1'#9'Number'#9'F'
        'customername'#9'15'#9'Customer Name'#9'F'
        'LineProductName'#9'15'#9'Product Name'#9'F'
        'Caption'#9'10'#9'Sub'#9'F'
        'Process'#9'12'#9'Process'#9'F'
        'cStatus'#9'12'#9'Status'#9'F'
        'TimeStart'#9'20'#9'Started At'#9'F'
        'TimeEnd'#9'20'#9'Completed At'#9'F'
        'SetupDuration'#9'7'#9'Setup'#9'F'#9'Duration'
        'Duration'#9'7'#9'Process'#9'F'#9'Duration'
        'BreakdownDuration'#9'7'#9'Down'#9'F'#9'Duration'
        'LineQty'#9'10'#9'Sold'#9'F'#9'Product Quantity'
        'Partiallyinvoiced'#9'10'#9'Invoiced'#9'F'#9'Product Quantity'
        'QtyToBeinvoiced'#9'10'#9'To Be Invoiced'#9'F'#9'Product Quantity'
        'manufactureduomqty'#9'10'#9'Built into Stock'#9'F'#9'Product Quantity'
        'QtyToBeBuilt'#9'10'#9'To Be Built'#9'F'#9'Product Quantity'
        'ManufacturingUOMQty'#9'10'#9'Used to Build'#9'F'#9'Product Quantity'
        'ToBeused'#9'10'#9'To Be Used'#9'F'#9'Product Quantity'
        'LineShipDate'#9'10'#9'Ship Date'#9'F'#9
        'class'#9'10'#9'Department'#9'F'
        'SaleDate'#9'10'#9'Sale Date'#9'F'
        'Comment'#9'40'#9'Comment'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsjobs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
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
      OnCalcCellColors = grdJobsCalcCellColors
      OnColEnter = grdJobsColEnter
      OnColExit = grdJobsColExit
      OnDblClick = grdJobsDblClick
      OnKeyPress = grdJobsKeyPress
      FooterColor = clWhite
    end
    object pnlComments: TDNMPanel
      AlignWithMargins = True
      Left = 1083
      Top = 1
      Width = 150
      Height = 284
      HelpContext = 753136
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alRight
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object grdMain: TwwDBGrid
        Left = 0
        Top = 0
        Width = 150
        Height = 284
        Hint = 'Double Click for the list of Comments'
        HelpContext = 753137
        Selected.Strings = (
          'timestart'#9'10'#9'Date'#9'F'
          'comment'#9'20'#9'Comments'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = False
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
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
        TitleButtons = False
        UseTFields = False
        OnDblClick = grdMainDblClick
        FooterColor = clWhite
        object btnGrid: TwwIButton
          Left = 0
          Top = 0
          Width = 2
          Height = 22
          HelpContext = 753138
          AllowAllUp = True
        end
      end
    end
  end
  object pnlButtons: TDNMPanel [6]
    Left = 0
    Top = 527
    Width = 1234
    Height = 38
    HelpContext = 753104
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    DesignSize = (
      1234
      38)
    object btnClose: TDNMSpeedButton
      AlignWithMargins = True
      Left = 900
      Top = 4
      Width = 100
      Height = 30
      HelpContext = 753105
      Margins.Top = 4
      Margins.Right = 0
      Margins.Bottom = 4
      Align = alLeft
      Anchors = []
      Cancel = True
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object pnlextrabuttons: TDNMPanel
      Left = 0
      Top = 0
      Width = 897
      Height = 38
      HelpContext = 753130
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Transparent = False
      object lblMsg: TLabel
        Left = 0
        Top = 21
        Width = 897
        Height = 17
        HelpContext = 753117
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblMsg'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
        OnClick = lblMsgClick
        OnDblClick = lblMsgDblClick
        ExplicitLeft = -3
        ExplicitTop = 24
        ExplicitWidth = 821
      end
      object btnControlBarCodes: TDNMSpeedButton
        AlignWithMargins = True
        Left = 399
        Top = 4
        Width = 161
        Height = 13
        HelpContext = 753090
        Margins.Top = 4
        Margins.Bottom = 4
        Action = actPrintcontrolcodes
        Align = alRight
        Anchors = []
        Caption = 'Print Control Codes'
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
        TabOrder = 0
        TabStop = False
        AutoDisableParentOnclick = True
      end
      object btnSelectall: TDNMSpeedButton
        AlignWithMargins = True
        Left = 733
        Top = 4
        Width = 161
        Height = 13
        HelpContext = 753005
        Margins.Top = 4
        Margins.Bottom = 4
        Align = alRight
        Anchors = []
        Caption = 'Clocked On Employee List'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnSelectallClick
      end
      object DNMSpeedButton8: TDNMSpeedButton
        AlignWithMargins = True
        Left = 566
        Top = 4
        Width = 161
        Height = 13
        HelpContext = 753123
        Margins.Top = 4
        Margins.Bottom = 4
        Action = actSelectall
        Align = alRight
        Anchors = []
        Caption = 'Select &All Processes'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 2
        AutoDisableParentOnclick = True
      end
      object btnCustomise: TDNMSpeedButton
        AlignWithMargins = True
        Left = 232
        Top = 4
        Width = 161
        Height = 13
        HelpContext = 753131
        Margins.Left = 0
        Margins.Top = 4
        Margins.Bottom = 4
        Align = alRight
        Anchors = []
        Caption = 'Customise'
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
        TabOrder = 3
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnCustomiseClick
      end
    end
    object chkHidecomments: TwwCheckBox
      Left = 1096
      Top = 10
      Width = 131
      Height = 17
      HelpContext = 753139
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akRight]
      Caption = 'Hide Comments'
      TabOrder = 2
      OnClick = chkHidecommentsClick
    end
  end
  object pnlOptions: TDNMPanel [7]
    Left = 0
    Top = 435
    Width = 1234
    Height = 92
    HelpContext = 753006
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 1234
    Height = 131
    HelpContext = 753100
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 0
      Width = 352
      Height = 131
      HelpContext = 753110
      Align = alLeft
      BevelInner = bvLowered
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object grdEmployees: TwwDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 80
        Width = 338
        Height = 44
        HelpContext = 753019
        Margins.Top = 1
        Margins.Bottom = 1
        ControlType.Strings = (
          'Complete;CheckBox;T;F')
        Selected.Strings = (
          'EmployeeNo'#9'1'#9'Employee No'#9'F'
          'EmployeeName'#9'35'#9'Employee Name'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = False
        ShowVertScrollBar = False
        Align = alBottom
        DataSource = dsEmployee
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnEnter = ExitSalesGridOnEnter
        FooterColor = clWhite
        object wwIButton1: TwwIButton
          Left = 0
          Top = 0
          Width = 0
          Height = 22
          HelpContext = 753020
          AllowAllUp = True
        end
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 991
      Top = 0
      Width = 243
      Height = 131
      HelpContext = 753114
      Align = alRight
      BevelInner = bvLowered
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object grdSales: TwwDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 80
        Width = 229
        Height = 44
        HelpContext = 753021
        Margins.Bottom = 1
        ControlType.Strings = (
          'Complete;CheckBox;T;F')
        Selected.Strings = (
          'InvoiceDocNumber'#9'1'#9'Doc Number'#9'F'
          'CustomerName'#9'20'#9'Customer Name'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = False
        ShowVertScrollBar = False
        Align = alBottom
        DataSource = dsSales
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        UseTFields = False
        OnEnter = ExitSalesGridOnEnter
        FooterColor = clWhite
        object wwDBGrid1IButton: TwwIButton
          Left = 0
          Top = 0
          Width = 0
          Height = 22
          HelpContext = 753022
          AllowAllUp = True
        end
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 352
      Top = 0
      Width = 639
      Height = 131
      HelpContext = 753116
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label4: TLabel
        Left = 1
        Top = 54
        Width = 637
        Height = 26
        HelpContext = 753107
        Align = alClient
        Alignment = taCenter
        Caption = 'To select existing  Job enter "S-<order number>"  (eg S-123)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 328
        ExplicitHeight = 15
      end
      object DNMPanel2: TDNMPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 631
        Height = 47
        HelpContext = 753101
        Align = alTop
        BevelInner = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Shader1: TShader
          Left = 2
          Top = 2
          Width = 627
          Height = 43
          HelpContext = 753102
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
          object titleLabel: TLabel
            Left = 0
            Top = 0
            Width = 627
            Height = 43
            HelpContext = 753103
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Barcode Manufacturing'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitLeft = -1
            ExplicitWidth = 351
            ExplicitHeight = 41
          end
        end
      end
      object edtBarcodeInput: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 83
        Width = 631
        Height = 44
        HelpContext = 753108
        Align = alBottom
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnExit = edtBarcodeInputExit
        OnKeyDown = edtBarcodeInputKeyDown
        OnKeyPress = edtBarcodeInputKeyPress
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 216
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102001801E40110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 138
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Left = 53
    Top = 16
  end
  object QryJobs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SQL changed dynamically in Procedure LoadJobs  */'
      ' Select  '
      
        'CONVERT( @rownum:=if(@SaleLineId <> details.SaleLineId,  @rownum' +
        ':= 1 ,  @rownum+1), unsigned) rownum ,'
      ' @SaleLineId := details.SaleLineId,'
      ' details.*'
      ' from '
      ' (SELECT @rownum:=0) r ,'
      ' (SELECT @SaleId:=0) s,'
      ' (SELECT  distinct '
      ' S.isinternalorder, '
      ' S.SaleID, '
      ' S.InvoiceDocNumber, '
      ' S.customername, '
      ' S.SaleDate, '
      ' S.class, '
      ' pp.ID, '
      ' SL.ProductId, '
      ' TreeNodeCaption(pt.Level, pt.Caption) AS caption, '
      ' pt.caption Name, '
      ' PT.info , '
      ' sl.SaleLineId, '
      ' sl.ProductName as LineProductName, '
      ' sl.Product_Description as LineProductDescription, '
      ' sl.UnitOfMeasureShipped as LineQty, '
      
        ' IFNULL((Select SUM(ifnull(SOIL.uomQty,0))   FROM tblsalesOrderI' +
        'nvoices SOI  INNER JOIN  tblsalesOrderInvoiceLines SOIL on SOIL.' +
        'SOInvoiceID = SOI.SOINvoiceID  WHERE S.saleId = SOI.salesorderID' +
        '  and SOIL.SalesorderLineID = SL.SaleLineID) ,0) +   '
      
        ' IFNULL((SELECT SUM(invl.UnitOfMeasureShipped)  FROM tblsales in' +
        'v  INNER JOIN tblsaleslines invl ON inv.saleId = invl.saleId  WH' +
        'ERE trim(ifnull(inv.salesorderglobalref,"")) = trim(S.globalref)' +
        '),0) as Partiallyinvoiced, '
      ' pt.ManufacturingUOMQty, '
      ' pt.ManufactureUOMQty, '
      ' pt.manufactureduomqty, '
      ' pt.totalqty, '
      ' sl.ShipDate as LineShipDate, '
      ' pt.ProcTreeId ,'
      ' PT.Complete , '
      ' Ps.Description as Process, '
      
        ' if(ifnull(pp.Status,"") = "" , "From Stock" , pp.status) as Sta' +
        'tus, '
      ' pp.Duration , '
      ' pp.SetupDuration , '
      ' pp.BreakdownDuration, '
      
        ' convert(if(ifnull(ppt.ID,0) = 0 , pp.TimeStart, ppt.timestart),' +
        'DateTime) as Timestart, '
      
        ' convert(if(if(ifnull(pp.Status,"") = "" , "From Stock" , pp.sta' +
        'tus)="psComplete" ,  (Select Max(TimeEnd)  from tblProcessPartti' +
        'mesheet xppt  where xppt.ProcessPartID = pp.Id and xppt.Active =' +
        ' "T"),0),DateTime)  as TimeEnd, '
      ' pp.ProcessStepSeq, '
      ' ppt.ID as PPTID, '
      ' pt.TreeRootId ,  '
      ' PP.ProcessStepId, '
      ' if (pt.TreeRootId =pt.proctreeID, "T" , "F") AS isroot, '
      
        ' (Select min(Timestart)   from tblProcesstime PPt   where PPt.Pr' +
        'ocessPartId = pp.ID) as ProcesstimeStart, '
      ' ppt1.Comment, '
      ' ppt1.id as pptid1, '
      ' if(ifnull(cpt.proctreeid,0)<> 0 , "T", "F") IsSubBOM, '
      ' if(S.saleID = 18, "T", "F") as IsJoboftheCurrentsale '
      ' FROM  tblSales s '
      
        ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId and (SL.BO' +
        'MGroupedLine ="F" or SL.BOMProductionLine ="T" ) '
      ' inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId '
      ' LEFT JOIN tblProcTree cpt ON pt.proctreeid = cpt.parentId '
      ' and pt.MasterType = "mtSalesOrder" '
      ' Inner join tblProcessPart pp on pp.ProcTreeId = Pt.ProcTreeId '
      ' Inner join tblProcessStep Ps on Ps.Id = PP.ProcessStepId '
      
        ' LEFT join tblProcessParttimesheet ppt  on ppt.ProcessPartID  = ' +
        'pp.Id and ppt.employeeId  = 1 and ifnull(PPT.TimeEnd,0) = 0 and ' +
        'ppt.Active = "T" '
      
        ' LEFT JOIN tblProcessParttimesheet ppt1 on ppt1.ProcessPartID = ' +
        'pp.Id and ppt1.employeeId = 1 and ppt1.Active = "T" '
      
        ' where S.converted = "F" and (s.saleid = 18 or ppt.employeeId = ' +
        '1) and pt.totalQty<>0 '
      
        ' order by sl.SaleLineId, pt.ProcTreeId , pp.ProcessStepSeq) as d' +
        'etails')
    BeforeOpen = ClearSelectedJobs
    AfterOpen = SelectFirstJob
    AfterPost = QryJobsAfterPost
    AfterScroll = QryJobsAfterScroll
    OnCalcFields = QryJobsCalcFields
    Left = 344
    Top = 314
    object QryJobsLineShipDate: TDateTimeField
      DisplayLabel = 'Ship Date'
      DisplayWidth = 10
      FieldName = 'LineShipDate'
      Origin = 'sl.LineShipDate'
    end
    object QryJobsLineProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 20
      FieldName = 'LineProductName'
      Origin = 'sl.LineProductName'
      Size = 60
    end
    object QryJobsLineProductDescription: TWideStringField
      DisplayLabel = 'Product Description'
      DisplayWidth = 20
      FieldName = 'LineProductDescription'
      Origin = 'sl.LineProductDescription'
      Size = 255
    end
    object QryJobsLineQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 10
      FieldName = 'LineQty'
      Origin = 'sl.LineQty'
    end
    object QryJobsComplete: TWideStringField
      DisplayWidth = 1
      FieldName = 'Complete'
      Origin = 'pt.Complete'
      FixedChar = True
      Size = 1
    end
    object QryJobsStatus: TWideStringField
      DisplayWidth = 20
      FieldName = 'Status'
      Origin = '.Status'
      Size = 255
    end
    object QryJobsProductId: TIntegerField
      FieldName = 'ProductId'
      Origin = 'sl.ProductId'
      Visible = False
    end
    object QryJobsSaleLineId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleLineId'
      Origin = 'sl.SaleLineId'
      Visible = False
    end
    object QryJobsProcTreeId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ProcTreeId'
      Origin = 'pt.ProcTreeId'
      Visible = False
    end
    object QryJobsProcess: TWideStringField
      FieldName = 'Process'
      Origin = 'Ps.Process'
      Visible = False
      Size = 255
    end
    object QryJobsDuration: TFloatField
      FieldName = 'Duration'
      Origin = 'pp.Duration'
      Visible = False
      DisplayFormat = '###,###,##0.00'
    end
    object QryJobsSetupDuration: TFloatField
      FieldName = 'SetupDuration'
      Origin = 'pp.SetupDuration'
      Visible = False
      DisplayFormat = '###,###,##0.00'
    end
    object QryJobsBreakdownDuration: TFloatField
      FieldName = 'BreakdownDuration'
      Origin = 'pp.BreakdownDuration'
      Visible = False
      DisplayFormat = '###,###,##0.00'
    end
    object QryJobsProcessStepSeq: TIntegerField
      FieldName = 'ProcessStepSeq'
      Origin = 'pp.ProcessStepSeq'
      Visible = False
    end
    object QryJobscStatus: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cStatus'
      Size = 100
      Calculated = True
    end
    object QryJobsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'pp.ID'
      Visible = False
    end
    object QryJobsInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Size = 30
    end
    object QryJobscustomername: TWideStringField
      FieldName = 'customername'
      Size = 255
    end
    object QryJobsSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object QryJobsclass: TWideStringField
      FieldName = 'class'
      Size = 255
    end
    object QryJobsTimestart: TDateTimeField
      FieldName = 'Timestart'
    end
    object QryJobsTimeEnd: TDateTimeField
      FieldName = 'TimeEnd'
    end
    object QryJobsName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object QryJobsSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object QryJobsTreeRootId: TIntegerField
      FieldName = 'TreeRootId'
      Visible = False
    end
    object QryJobsProcessStepId: TIntegerField
      FieldName = 'ProcessStepId'
    end
    object QryJobsProcesstimeStart: TDateTimeField
      FieldName = 'ProcesstimeStart'
    end
    object QryJobsPartiallyinvoiced: TFloatField
      FieldName = 'Partiallyinvoiced'
    end
    object QryJobsQtyToBeinvoiced: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QtyToBeinvoiced'
      Calculated = True
    end
    object QryJobsinfo: TWideMemoField
      FieldName = 'info'
      BlobType = ftWideMemo
    end
    object QryJobsComment: TWideStringField
      FieldName = 'Comment'
      Size = 255
    end
    object QryJobsPPTID: TLargeintField
      FieldName = 'PPTID'
      Visible = False
    end
    object QryJobspptid1: TLargeintField
      FieldName = 'pptid1'
      Visible = False
    end
    object QryJobsmanufactureduomqty: TFloatField
      FieldName = 'manufactureduomqty'
    end
    object QryJobstotalqty: TFloatField
      FieldName = 'totalqty'
    end
    object QryJobsisroot: TWideStringField
      FieldName = 'isroot'
      Size = 1
    end
    object QryJobsisinternalorder: TWideStringField
      FieldName = 'isinternalorder'
      FixedChar = True
      Size = 1
    end
    object QryJobsQtyToBeBuilt: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QtyToBeBuilt'
      Calculated = True
    end
    object QryJobsManufacturingUOMQty: TFloatField
      FieldName = 'ManufacturingUOMQty'
    end
    object QryJobsManufactureUOMQty: TFloatField
      FieldName = 'ManufactureUOMQty'
    end
    object QryJobsIsSubBOM: TWideStringField
      FieldName = 'IsSubBOM'
      Size = 1
    end
    object QryJobstobeused: TFloatField
      FieldKind = fkCalculated
      FieldName = 'tobeused'
      Calculated = True
    end
    object QryJobscaption: TWideStringField
      FieldName = 'caption'
      Size = 255
    end
    object QryJobsIsJoboftheCurrentsale: TWideStringField
      FieldName = 'IsJoboftheCurrentsale'
      Size = 1
    end
    object QryJobsrownum: TLargeintField
      FieldName = 'rownum'
    end
  end
  object dsjobs: TDataSource
    DataSet = QryJobs
    Left = 384
    Top = 314
  end
  object QrySales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSales')
    Left = 840
    Top = 19
    object QrySalesSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleID'
      Origin = 'tblSales.SaleID'
    end
    object QrySalesInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Origin = 'tblSales.InvoiceDocNumber'
      Size = 30
    end
    object QrySalesCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tblSales.CustomerName'
      Size = 255
    end
    object QrySalesSaleDate: TDateField
      FieldName = 'SaleDate'
      Origin = 'tblSales.SaleDate'
    end
    object QrySalesClass: TWideStringField
      FieldName = 'Class'
      Origin = 'tblSales.Class'
      Size = 255
    end
    object QrySalesShipDate: TDateField
      FieldName = 'ShipDate'
      Origin = 'tblSales.ShipDate'
    end
  end
  object dsSales: TDataSource
    DataSet = QrySales
    Left = 880
    Top = 19
  end
  object QryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblemployees')
    OnCalcFields = QryEmployeeCalcFields
    Left = 56
    Top = 208
    object QryEmployeeTitle: TWideStringField
      FieldName = 'Title'
      Size = 5
    end
    object QryEmployeeFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 40
    end
    object QryEmployeeMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Size = 40
    end
    object QryEmployeeLastName: TWideStringField
      FieldName = 'LastName'
      Size = 40
    end
    object QryEmployeePhone: TWideStringField
      FieldName = 'Phone'
      Size = 255
    end
    object QryEmployeeMobile: TWideStringField
      FieldName = 'Mobile'
      Size = 255
    end
    object QryEmployeePosition: TWideStringField
      FieldName = 'Position'
      Size = 30
    end
    object QryEmployeeEmployeeNo: TIntegerField
      FieldName = 'EmployeeNo'
    end
    object QryEmployeeEmployeeName: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'EmployeeName'
      Size = 100
      Calculated = True
    end
    object QryEmployeeEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
  end
  object dsEmployee: TDataSource
    DataSet = QryEmployee
    Left = 108
    Top = 208
  end
  object c: TActionList
    Left = 200
    Top = 40
    object actEmployees: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'EMPLOYEE'
      HelpContext = 753120
      ImageIndex = 39
      OnExecute = actEmployeesExecute
      buttoncolor = clWhite
    end
    object actJobs: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'JOBS'
      HelpContext = 753121
      ImageIndex = 19
      OnExecute = actJobsExecute
      buttoncolor = clWhite
    end
    object actStart: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'START'
      HelpContext = 753079
      ImageIndex = 394
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actSchedule: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'SCHEDULE'
      HelpContext = 753080
      ImageIndex = 170
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actStop: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'STOP'
      HelpContext = 753122
      ImageIndex = 107
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actStopAll: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'STOP ALL'
      HelpContext = 753082
      ImageIndex = 257
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actComplete: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'COMPLETE'
      HelpContext = 753083
      ImageIndex = 335
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actUnschedule: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'UNSCHEDULE'
      HelpContext = 753084
      ImageIndex = 169
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actOpenSale: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'OPEN SALE'
      HelpContext = 753085
      ImageIndex = 292
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actTree: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'OPEN TREE'
      HelpContext = 753086
      ImageIndex = 208
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actPicking: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'PICKING'
      HelpContext = 753087
      ImageIndex = 241
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actWorksheet: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'WORKSHEET'
      HelpContext = 753088
      ImageIndex = 200
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actInvoice: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'FINALIZE'
      HelpContext = 753089
      ImageIndex = 660
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actPrintcontrolcodes: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'Print Control Codes'
      HelpContext = 753133
      ImageIndex = 205
      OnExecute = actPrintcontrolcodesExecute
      buttoncolor = clWhite
    end
    object actSelectall: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'Select &All Processes'
      HelpContext = 753132
      OnExecute = actSelectallExecute
      buttoncolor = clWhite
    end
    object actQA: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'Q && A'
      HelpContext = 753124
      ImageIndex = 261
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actAllocation: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'ALLOCATION'
      HelpContext = 753125
      ImageIndex = 37
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actLogOff: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'LOG OFF'
      HelpContext = 753126
      ImageIndex = 238
      OnExecute = DoSomething
      OnUpdate = actLogOffUpdate
      buttoncolor = clWhite
    end
    object actBreak: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'BREAK'
      HelpContext = 753127
      ImageIndex = 448
      OnExecute = DoSomething
      OnUpdate = actBreakUpdate
      buttoncolor = clWhite
    end
    object actHistory: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'HISTORY'
      HelpContext = 753128
      ImageIndex = 27
      OnExecute = DoSomething
      OnUpdate = actHistoryUpdate
      buttoncolor = clWhite
    end
    object actComments: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'COMMENTS'
      HelpContext = 753129
      ImageIndex = 380
      OnExecute = DoSomething
      OnUpdate = actCommentsUpdate
      buttoncolor = clWhite
    end
    object actPInvoice: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'Partial Invoice'
      HelpContext = 753134
      ImageIndex = 15
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actPInvoiceold: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'Partial Invoice Old'
      HelpContext = 753140
      ImageIndex = 15
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actopenDocPath: TDNMAction
      Category = 'BarCodeManufacturing'
      Caption = 'Open Doc Path'
      HelpContext = 753141
      ImageIndex = 16
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'ppt.timestart, '
      'ppt.comment as comment '
      'from tblProcessPart pp '
      
        'inner join tblProcessParttimesheet ppt on ppt.ProcessPartID = pp' +
        '.Id '
      'where PP.id = :ppid and ifnull(ppt.comment,'#39#39')<> '#39#39
      'order by timestart')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = qryMainAfterOpen
    Left = 1115
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ppid'
      end>
    object qryMaintimestart: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'timestart'
    end
    object qryMaincomment: TWideStringField
      DisplayLabel = 'Comments'
      DisplayWidth = 20
      FieldName = 'comment'
      Size = 255
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 1118
    Top = 183
  end
end
