inherited fmStockStatus: TfmStockStatus
  Left = 297
  Top = 212
  HelpContext = 650000
  BorderStyle = bsSingle
  Caption = 'Available Stock Status for the Back Ordered Products '
  ClientHeight = 565
  ClientWidth = 1184
  Position = poScreenCenter
  ExplicitLeft = 297
  ExplicitTop = 212
  ExplicitWidth = 1200
  ExplicitHeight = 604
  DesignSize = (
    1184
    565)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 50
    Width = 1184
    HelpContext = 650011
    ExplicitTop = 59
    ExplicitWidth = 952
  end
  object lblDate: TLabel [4]
    AlignWithMargins = True
    Left = 1010
    Top = 6
    Width = 132
    Height = 15
    HelpContext = 650023
    Anchors = [akTop, akRight]
    Caption = 'Stock As on Sales Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    ExplicitLeft = 940
  end
  object edtdate: TEdit [5]
    Left = 1009
    Top = 23
    Width = 137
    Height = 21
    HelpContext = 650024
    Anchors = [akTop, akRight]
    ReadOnly = True
    TabOrder = 3
    Text = '01/01/1990 10:10:00 AM'
  end
  object DNMPanel2: TDNMPanel [6]
    Left = 0
    Top = 50
    Width = 1184
    Height = 27
    HelpContext = 650025
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object chkShowDetails: TCheckBox
      AlignWithMargins = True
      Left = 10
      Top = 0
      Width = 152
      Height = 27
      HelpContext = 650026
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Show Details'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = chkShowDetailsClick
    end
    object chkShowcompanyStock: TCheckBox
      AlignWithMargins = True
      Left = 1010
      Top = 0
      Width = 164
      Height = 27
      HelpContext = 650027
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Show Companies Stock'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = chkShowcompanyStockClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 77
    Width = 1184
    Height = 488
    HelpContext = 650002
    Align = alBottom
    BevelInner = bvRaised
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlPanles: TDNMPanel
      Left = 2
      Top = 2
      Width = 1176
      Height = 90
      HelpContext = 650012
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label4: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 74
        Height = 82
        HelpContext = 650003
        Align = alLeft
        Caption = 'Multi select : '
        Transparent = True
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object pnl3: TDNMPanel
        AlignWithMargins = True
        Left = 817
        Top = 2
        Width = 225
        Height = 86
        HelpContext = 650013
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alLeft
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          225
          86)
        object lbl3: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 2
          Width = 218
          Height = 15
          HelpContext = 650028
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = '3: Use Stock From Other Companies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 205
        end
        object DNMSpeedButton1: TDNMSpeedButton
          AlignWithMargins = True
          Left = 49
          Top = 53
          Width = 125
          Height = 29
          HelpContext = 650029
          Anchors = [akBottom]
          Caption = 'Choose Companies'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
        object chkDoCrosscheckCompanies: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 21
          Width = 217
          Height = 17
          HelpContext = 650030
          Align = alTop
          Caption = '  Check In Other Companies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = ReceiveOption1Click
        end
      end
      object pnlDepts: TDNMPanel
        AlignWithMargins = True
        Left = 313
        Top = 2
        Width = 500
        Height = 86
        HelpContext = 650031
        Margins.Left = 1
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alLeft
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lbl2: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 2
          Width = 493
          Height = 15
          HelpContext = 650032
          Margins.Left = 4
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = '2: Use Stock From Other Departments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 215
        end
        object chkDocheckDepartments: TCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 19
          Width = 496
          Height = 17
          HelpContext = 650034
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 'Check In Other Departments '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = ReceiveOption1Click
        end
        object chkuseDefaultStockClassID: TCheckBox
          AlignWithMargins = True
          Left = 19
          Top = 38
          Width = 305
          Height = 17
          HelpContext = 650043
          Margins.Left = 18
          Margins.Top = 1
          Margins.Right = 175
          Margins.Bottom = 1
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Check for Stock in Product'#39's Default Deaprtment First'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = chkuseDefaultStockClassIDClick
        end
      end
      object pnl1: TDNMPanel
        AlignWithMargins = True
        Left = 84
        Top = 2
        Width = 225
        Height = 86
        HelpContext = 650035
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alLeft
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object pnlQtyoptions: TDNMPanel
          Left = 1
          Top = 1
          Width = 223
          Height = 84
          HelpContext = 650036
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lbl1: TLabel
            AlignWithMargins = True
            Left = 1
            Top = 1
            Width = 221
            Height = 15
            HelpContext = 650037
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alTop
            Caption = '1: Use Stock From Current Department'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            WordWrap = True
            ExplicitWidth = 219
          end
          object DNMPanel7: TDNMPanel
            AlignWithMargins = True
            Left = 92
            Top = 17
            Width = 131
            Height = 67
            HelpContext = 650038
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object ReceiveOption4: TRadioButton
              AlignWithMargins = True
              Left = 0
              Top = 6
              Width = 131
              Height = 20
              HelpContext = 650022
              Margins.Left = 0
              Margins.Top = 6
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alTop
              Caption = 'None'
              TabOrder = 0
              OnClick = ReceiveOption1Click
            end
            object ReceiveOption2: TRadioButton
              AlignWithMargins = True
              Left = 0
              Top = 32
              Width = 131
              Height = 20
              HelpContext = 650009
              Margins.Left = 0
              Margins.Top = 6
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alTop
              Caption = 'Available'
              TabOrder = 1
              OnClick = ReceiveOption1Click
            end
          end
          object DNMPanel8: TDNMPanel
            AlignWithMargins = True
            Left = 3
            Top = 17
            Width = 89
            Height = 67
            HelpContext = 650039
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alLeft
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object ReceiveOption3: TRadioButton
              AlignWithMargins = True
              Left = 0
              Top = 32
              Width = 89
              Height = 20
              HelpContext = 650010
              Margins.Left = 0
              Margins.Top = 6
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alTop
              Caption = 'Received'
              TabOrder = 0
              OnClick = ReceiveOption1Click
            end
            object ReceiveOption1: TRadioButton
              AlignWithMargins = True
              Left = 0
              Top = 6
              Width = 89
              Height = 20
              HelpContext = 650008
              Margins.Left = 0
              Margins.Top = 6
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alTop
              Caption = 'All'
              TabOrder = 1
              OnClick = ReceiveOption1Click
            end
          end
        end
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 2
      Top = 92
      Width = 1176
      Height = 354
      HelpContext = 650014
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object splBottom1: TSplitter
        Left = 1
        Top = 185
        Width = 1174
        Height = 2
        Cursor = crVSplit
        HelpContext = 650040
        Align = alBottom
        ExplicitTop = 152
        ExplicitWidth = 1180
      end
      object grdMain: TwwDBGrid
        Left = 1
        Top = 1
        Width = 1174
        Height = 184
        HelpContext = 650004
        ControlType.Strings = (
          'ShipmentOption;CustomEdit;OptReceive;F'
          'DocheckDepartments;CheckBox;T;F'
          'DoCrosscheckCompanies;CheckBox;T;F')
        Selected.Strings = (
          'Productname'#9'10'#9'Product'#9'T'
          'UOMsold'#9'7'#9'Sold'#9'T'#9'Quantity'
          'UOMShipped'#9'7'#9'Shipped'#9'T'#9'Quantity'
          'UOMBackOrder'#9'7'#9'BO'#9'T'#9'Quantity'
          'sUOM'#9'7'#9'UOM'#9'T'
          'calcAssociatedPOsReceived'#9'3'#9'Associated~POs Received?'#9'T'
          'Received'#9'7'#9'Received~Quantity'#9'T'
          'ETA'#9'10'#9'ETA'#9'T'
          'UOMAvailableStock'#9'8'#9'Available~Stock'#9'T'#9'Available'
          'oUOMAvailableStock'#9'8'#9'Available~Stock'#9'T'#9'Available'
          'calcEnoughStock'#9'3'#9'Enough~Stock?'#9'T'
          'ShipmentOption'#9'35'#9'What you wish to~Receive?'#9'F'
          'DocheckDepartments'#9'1'#9'Check Other~Departments'#9'F'
          'DoCrosscheckCompanies'#9'1'#9'Check Other~Companies'#9'F')
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = False
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = dsmain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = grdMainCalcCellColors
        OnDblClick = grdMainDblClick
      end
      object pnlCrossStock: TDNMPanel
        Left = 1
        Top = 187
        Width = 1174
        Height = 166
        HelpContext = 650041
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblOthercompanies: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 1166
          Height = 23
          HelpContext = 650042
          Align = alTop
          AutoSize = False
          Caption = 'Available Stock in Other companies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 754
        end
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 2
      Top = 446
      Width = 1176
      Height = 36
      HelpContext = 650015
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        1176
        36)
      object btnCompleted: TDNMSpeedButton
        Left = 346
        Top = 5
        Width = 87
        Height = 27
        HelpContext = 650016
        Anchors = []
        Caption = '&OK'
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ModalResult = 1
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        TabStop = False
        AutoDisableParentOnclick = True
      end
      object btnClose: TDNMSpeedButton
        Left = 744
        Top = 5
        Width = 87
        Height = 27
        HelpContext = 650017
        Anchors = []
        Cancel = True
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ModalResult = 2
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        TabStop = False
        AutoDisableParentOnclick = True
      end
      object btnHowTo: TDNMSpeedButton
        Left = 545
        Top = 5
        Width = 87
        Height = 27
        Anchors = [akBottom]
        Caption = 'How To'
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
        AutoDisableParentOnclick = True
        OnClick = btnHowToClick
        HelpContext = 650044
      end
    end
  end
  object pnlTitle: TDNMPanel [8]
    Left = 383
    Top = 8
    Width = 417
    Height = 39
    HelpContext = 650018
    Anchors = []
    Caption = 'Invoice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 1
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 415
      Height = 37
      HelpContext = 650019
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
        Width = 415
        Height = 37
        HelpContext = 650020
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Transactional Stock Status'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitTop = 1
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 459
    Top = 232
  end
  inherited tmrdelay: TTimer
    Left = 536
    Top = 232
  end
  inherited popSpelling: TPopupMenu
    Left = 420
    Top = 232
  end
  inherited tmrdelayMsg: TTimer
    Left = 497
    Top = 232
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 305
    Top = 232
  end
  object qrymain: TERPQuery
    SQL.Strings = (
      'select * from tmp_StockStatus')
    BeforeOpen = qrymainBeforeOpen
    AfterOpen = qrymainAfterOpen
    AfterScroll = ocateproduct
    OnCalcFields = qrymainCalcFields
    Left = 343
    Top = 232
    object qrymainProductname: TWideStringField
      DisplayWidth = 255
      FieldName = 'Productname'
      Origin = 'tmp_StockStatus.Productname'
      Size = 255
    end
    object qrymainOtherClassname: TWideStringField
      DisplayWidth = 255
      FieldName = 'OtherClassname'
      Origin = 'tmp_StockStatus.OtherClassname'
      Size = 255
    end
    object qrymainUOMsold: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMsold'
      Origin = 'tmp_StockStatus.UOMsold'
    end
    object qrymainUOMShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMShipped'
      Origin = 'tmp_StockStatus.UOMShipped'
    end
    object qrymainUOMBackOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMBackOrder'
      Origin = 'tmp_StockStatus.UOMBackOrder'
    end
    object qrymainUOM: TWideStringField
      DisplayWidth = 100
      FieldName = 'UOM'
      Origin = 'tmp_StockStatus.UOM'
      Size = 100
    end
    object qrymainsUOM: TWideStringField
      DisplayWidth = 100
      FieldName = 'sUOM'
      Origin = 'tmp_StockStatus.sUOM'
      Size = 100
    end
    object qrymainUOMAvailableStock: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMAvailableStock'
      Origin = 'tmp_StockStatus.UOMAvailableStock'
    end
    object qrymainoUOMAvailableStock: TFloatField
      DisplayWidth = 10
      FieldName = 'oUOMAvailableStock'
      Origin = 'tmp_StockStatus.oUOMAvailableStock'
    end
    object qrymainEnoughStock: TWideStringField
      DisplayWidth = 1
      FieldName = 'EnoughStock'
      Origin = 'tmp_StockStatus.EnoughStock'
      FixedChar = True
      Size = 1
    end
    object qrymainDoCrosscheckCompanies: TWideStringField
      DisplayWidth = 1
      FieldName = 'DoCrosscheckCompanies'
      Origin = 'tmp_StockStatus.DoCrosscheckCompanies'
      FixedChar = True
      Size = 1
    end
    object qrymainDocheckDepartments: TWideStringField
      DisplayWidth = 1
      FieldName = 'DocheckDepartments'
      Origin = 'tmp_StockStatus.DocheckDepartments'
      FixedChar = True
      Size = 1
    end
    object qrymainAssociatedPOsReceived: TWideStringField
      DisplayWidth = 1
      FieldName = 'AssociatedPOsReceived'
      Origin = 'tmp_StockStatus.AssociatedPOsReceived'
      FixedChar = True
      Size = 1
    end
    object qrymainShipmentOption: TWideStringField
      DisplayWidth = 1
      FieldName = 'ShipmentOption'
      Origin = 'tmp_StockStatus.ShipmentOption'
      FixedChar = True
      Size = 1
    end
    object qrymainID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_StockStatus.ID'
      Visible = False
    end
    object qrymainclassId: TIntegerField
      FieldName = 'classId'
      Origin = 'tmp_StockStatus.classId'
      Visible = False
    end
    object qrymainDefaultStockClassID: TIntegerField
      FieldName = 'DefaultStockClassID'
      Origin = 'tmp_StockStatus.DefaultStockClassID'
      Visible = False
    end
    object qrymainOtherClassId: TIntegerField
      FieldName = 'OtherClassId'
      Origin = 'tmp_StockStatus.OtherClassId'
      Visible = False
    end
    object qrymainSaleID: TIntegerField
      FieldName = 'SaleID'
      Origin = 'tmp_StockStatus.SaleID'
      Visible = False
    end
    object qrymainsaleLineId: TIntegerField
      FieldName = 'saleLineId'
      Origin = 'tmp_StockStatus.saleLineId'
      Visible = False
    end
    object qrymainProductId: TIntegerField
      FieldName = 'ProductId'
      Origin = 'tmp_StockStatus.ProductId'
      Visible = False
    end
    object qrymainSold: TFloatField
      FieldName = 'Sold'
      Origin = 'tmp_StockStatus.Sold'
      Visible = False
    end
    object qrymainShipped: TFloatField
      FieldName = 'Shipped'
      Origin = 'tmp_StockStatus.Shipped'
      Visible = False
    end
    object qrymainBackOrder: TFloatField
      FieldName = 'BackOrder'
      Origin = 'tmp_StockStatus.BackOrder'
      Visible = False
    end
    object qrymainUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tmp_StockStatus.UOMID'
      Visible = False
    end
    object qrymainUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tmp_StockStatus.UOMMultiplier'
      Visible = False
    end
    object qrymainAvailableStock: TFloatField
      FieldName = 'AvailableStock'
      Origin = 'tmp_StockStatus.AvailableStock'
      Visible = False
    end
    object qrymainoavailableStock: TFloatField
      FieldName = 'oavailableStock'
      Origin = 'tmp_StockStatus.oavailableStock'
      Visible = False
    end
    object qrymaincalcAssociatedPOsReceived: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'calcAssociatedPOsReceived'
      Size = 3
      Calculated = True
    end
    object qrymaincalcEnoughStock: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'calcEnoughStock'
      Size = 3
      Calculated = True
    end
    object qrymainReceived: TFloatField
      FieldName = 'Received'
    end
    object qrymainETA: TDateTimeField
      FieldName = 'ETA'
    end
    object qrymainPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object qrymainBaseLineno: TIntegerField
      FieldName = 'BaseLineno'
    end
    object qrymainOriginalQty: TFloatField
      FieldName = 'OriginalQty'
    end
    object qrymainQtyRequired: TFloatField
      FieldName = 'QtyRequired'
    end
    object qrymainReceivedtoUse: TFloatField
      FieldName = 'ReceivedtoUse'
    end
    object qrymainoUOMAvailableStocktoUse: TFloatField
      FieldName = 'oUOMAvailableStocktoUse'
    end
    object qrymainUOMAvailableStocktoUse: TFloatField
      FieldName = 'UOMAvailableStocktoUse'
    end
  end
  object dsmain: TDataSource
    DataSet = qrymain
    Left = 382
    Top = 232
  end
  object MyScript1: TERPScript
    OnError = MyScript1Error
    Connection = BaseInputGUI.MyConnection
    IgnorenContinueOnError = False
    Left = 576
    Top = 232
  end
end
