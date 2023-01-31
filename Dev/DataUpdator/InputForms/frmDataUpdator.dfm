inherited fmDataUpdator: TfmDataUpdator
  Left = 407
  Top = 209
  HelpContext = 985001
  Caption = 'fmDataUpdator'
  ClientHeight = 581
  Constraints.MinHeight = 559
  Constraints.MinWidth = 955
  OnResize = FormResize
  ExplicitLeft = 407
  ExplicitTop = 209
  ExplicitWidth = 320
  ExplicitHeight = 620
  DesignSize = (
    949
    581)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 581
    ExplicitTop = 858
  end
  object PnlDataUpdator: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 949
    Height = 581
    HelpContext = 985016
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTop: TDNMPanel
      Left = 1
      Top = 1
      Width = 947
      Height = 50
      HelpContext = 985003
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        947
        50)
      object pnlTitle: TDNMPanel
        Left = 356
        Top = 4
        Width = 238
        Height = 40
        HelpContext = 985004
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
          Width = 234
          Height = 36
          HelpContext = 985005
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
            Width = 234
            Height = 36
            HelpContext = 985006
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = ' Data Update'
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
    object pnlbottom: TDNMPanel
      Left = 1
      Top = 528
      Width = 947
      Height = 52
      HelpContext = 985010
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        947
        52)
      object lblViewUpdateLog: TLabel
        Left = 846
        Top = 17
        Width = 95
        Height = 15
        Cursor = crHandPoint
        HelpContext = 985011
        Anchors = [akTop, akRight]
        Caption = 'View Update Log'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Visible = False
        OnClick = lblViewUpdateLogClick
      end
      object btnClose: TDNMSpeedButton
        Left = 521
        Top = 12
        Width = 108
        Height = 27
        HelpContext = 985012
        Anchors = []
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
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ModalResult = 2
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnCloseClick
      end
      object btnCompleted: TDNMSpeedButton
        Left = 318
        Top = 12
        Width = 108
        Height = 27
        HelpContext = 985013
        Anchors = []
        Caption = '&Update'
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
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnCompletedClick
      end
    end
    object PageMain: TPageControl
      Left = 1
      Top = 51
      Width = 947
      Height = 477
      HelpContext = 985017
      ActivePage = TabSheet1
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MultiLine = True
      ParentFont = False
      RaggedRight = True
      TabHeight = 23
      TabOrder = 2
      TabWidth = 143
      OnChange = PageMainChange
      OnResize = PageMainResize
      object TabSheet1: TTabSheet
        HelpContext = 985018
        Caption = 'Products'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object ProductSpliter: TSplitter
          Left = 0
          Top = 79
          Width = 939
          Height = 2
          Cursor = crVSplit
          HelpContext = 985002
          Align = alTop
          OnMoved = ProductSpliterMoved
          ExplicitWidth = 941
        end
        object pnlProduct: TDNMPanel
          Left = 0
          Top = 0
          Width = 939
          Height = 79
          HelpContext = 985007
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object pnldetails: TDNMPanel
          Left = 0
          Top = 81
          Width = 939
          Height = 363
          HelpContext = 985008
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object pnlProductMain: TDNMPanel
            Left = 178
            Top = 1
            Width = 760
            Height = 361
            HelpContext = 985009
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvLowered
            BorderWidth = 1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object sbButtons: TScrollBox
            Left = 1
            Top = 1
            Width = 177
            Height = 361
            HelpContext = 985014
            HorzScrollBar.Visible = False
            Align = alLeft
            BorderStyle = bsNone
            TabOrder = 1
            object pnlProductButtons: TDNMPanel
              Left = 0
              Top = 0
              Width = 177
              Height = 361
              HelpContext = 985015
              Align = alClient
              BevelInner = bvLowered
              BevelOuter = bvLowered
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Transparent = False
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        HelpContext = 985019
        Caption = 'Clients'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object ClientFilter: TSplitter
          Left = 0
          Top = 79
          Width = 939
          Height = 2
          Cursor = crVSplit
          HelpContext = 985020
          Align = alTop
          OnMoved = ProductSpliterMoved
        end
        object pnlclient: TDNMPanel
          Left = 0
          Top = 0
          Width = 939
          Height = 79
          HelpContext = 985021
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object DNMPanel1: TDNMPanel
          Left = 0
          Top = 81
          Width = 939
          Height = 363
          HelpContext = 985022
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object pnlClientMain: TDNMPanel
            Left = 178
            Top = 1
            Width = 760
            Height = 361
            HelpContext = 985023
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvLowered
            BorderWidth = 1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object scrClientButtons: TScrollBox
            Left = 1
            Top = 1
            Width = 177
            Height = 361
            HelpContext = 985024
            HorzScrollBar.Visible = False
            Align = alLeft
            BorderStyle = bsNone
            TabOrder = 1
            object pnlClientButtons: TDNMPanel
              Left = 0
              Top = 0
              Width = 177
              Height = 361
              HelpContext = 985025
              Align = alClient
              BevelInner = bvLowered
              BevelOuter = bvLowered
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Transparent = False
            end
          end
        end
      end
      object tabMiscDataUpdates: TTabSheet
        HelpContext = 985026
        Caption = 'Data Updates'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object splMiscDataupdate: TSplitter
          Left = 0
          Top = 97
          Width = 939
          Height = 2
          Cursor = crVSplit
          HelpContext = 985027
          Align = alTop
          OnMoved = ProductSpliterMoved
        end
        object pnlMiscDataupdate: TDNMPanel
          Left = 0
          Top = 0
          Width = 939
          Height = 97
          HelpContext = 985028
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object pnlMiscDataupdateMain: TDNMPanel
          Left = 177
          Top = 99
          Width = 762
          Height = 345
          HelpContext = 985029
          Align = alClient
          BevelInner = bvLowered
          BevelOuter = bvLowered
          BorderWidth = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object scrMiscDataupdateButtons: TScrollBox
          Left = 0
          Top = 99
          Width = 177
          Height = 345
          HelpContext = 985030
          HorzScrollBar.Visible = False
          Align = alLeft
          BorderStyle = bsNone
          TabOrder = 2
          object pnlMiscDataupdateButtons: TDNMPanel
            Left = 0
            Top = 0
            Width = 177
            Height = 345
            HelpContext = 985031
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
        end
      end
      object TabSheet3: TTabSheet
        HelpContext = 985032
        Caption = 'Resources'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object splProcResButtons: TSplitter
          Left = 0
          Top = 79
          Width = 939
          Height = 2
          Cursor = crVSplit
          HelpContext = 985033
          Align = alTop
          OnMoved = ProductSpliterMoved
        end
        object DNMPanel2: TDNMPanel
          Left = 0
          Top = 81
          Width = 939
          Height = 363
          HelpContext = 985034
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object pnlProcResMain: TDNMPanel
            Left = 178
            Top = 1
            Width = 760
            Height = 361
            HelpContext = 985035
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvLowered
            BorderWidth = 1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object scrProcResButtons: TScrollBox
            Left = 1
            Top = 1
            Width = 177
            Height = 361
            HelpContext = 985036
            HorzScrollBar.Visible = False
            Align = alLeft
            BorderStyle = bsNone
            TabOrder = 1
            object pnlProcResButtons: TDNMPanel
              Left = 0
              Top = 0
              Width = 177
              Height = 361
              HelpContext = 985037
              Align = alClient
              BevelInner = bvLowered
              BevelOuter = bvLowered
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Transparent = False
            end
          end
        end
        object pnlProcRes: TDNMPanel
          Left = 0
          Top = 0
          Width = 939
          Height = 79
          HelpContext = 985038
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 405
    Top = 224
  end
  inherited tmrdelay: TTimer
    Left = 372
    Top = 224
  end
  inherited popSpelling: TPopupMenu
    Left = 144
    Top = 56
  end
  inherited tmrdelayMsg: TTimer
    Left = 80
    Top = 16
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 208
    Top = 224
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 306
    Top = 224
  end
  inherited MyConnection: TERPConnection
    Left = 339
    Top = 224
  end
  inherited DataState: TDataState
    Left = 240
    Top = 224
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 470
    Top = 224
  end
  inherited imgsort: TImageList
    Left = 273
    Top = 224
    Bitmap = {
      494C010102005C010C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 898
    Top = 224
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 503
    Top = 224
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 438
    Top = 224
  end
  inherited qryMemTrans: TERPQuery
    Left = 13
    Top = 8
  end
  object qryExtraBuyPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ExtraPartPriceID, PartsID, SupplierID, Price, PartName, '
      'Buy1, PrintedValue1, '
      
        'SupplierProductCode, SupplierProductName, UsePrice, UOM, UOMID, ' +
        'UOMMultiplier, MinimumOrderQty,'
      'VariationOption , Variationtype, VariationAmt'
      'FROM tmp_1')
    Filtered = True
    Filter = 'Deleted ="F"'
    Left = 766
    Top = 224
    object qryExtraBuyPriceExtraPartPriceID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ExtraPartPriceID'
      Origin = 'tblextraprice.ExtraPartPriceID'
      ReadOnly = True
    end
    object qryExtraBuyPricePartsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsID'
      Origin = 'tblextraprice.PartsID'
    end
    object qryExtraBuyPriceSupplierID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SupplierID'
      Origin = 'tblextraprice.SupplierID'
    end
    object qryExtraBuyPricePrice: TFloatField
      DisplayWidth = 21
      FieldName = 'Price'
      Origin = 'tblextraprice.Price'
      currency = True
    end
    object qryExtraBuyPricePartName: TWideStringField
      DisplayWidth = 50
      FieldName = 'PartName'
      Origin = 'tblextraprice.PartName'
      FixedChar = True
      Size = 60
    end
    object qryExtraBuyPriceBuy1: TIntegerField
      DisplayWidth = 10
      FieldName = 'Buy1'
      Origin = 'tblextraprice.Buy1'
    end
    object qryExtraBuyPriceSupplierProductCode: TWideStringField
      DisplayWidth = 50
      FieldName = 'SupplierProductCode'
      Origin = 'tblextraprice.SupplierProductCode'
      FixedChar = True
      Size = 50
    end
    object qryExtraBuyPriceSupplierProductName: TWideStringField
      DisplayWidth = 60
      FieldName = 'SupplierProductName'
      Origin = 'tblextraprice.SupplierProductName'
      FixedChar = True
      Size = 50
    end
    object qryExtraBuyPriceUsePrice: TWideStringField
      DisplayWidth = 1
      FieldName = 'UsePrice'
      Origin = 'tblextraprice.UsePrice'
      FixedChar = True
      Size = 1
    end
    object qryExtraBuyPriceSupplierName: TWideStringField
      DisplayWidth = 80
      FieldKind = fkLookup
      FieldName = 'SupplierName'
      LookupDataSet = cboClientLookup
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'SupplierID'
      Size = 80
      Lookup = True
    end
    object qryExtraBuyPricePrintedValue: TFloatField
      FieldName = 'PrintedValue1'
      Origin = 'tblextraprice.PrintedValue1'
      currency = True
    end
    object qryExtraBuyPriceUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tblextraprice.UOM'
      Size = 100
    end
    object qryExtraBuyPriceUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblextraprice.UOMID'
    end
    object qryExtraBuyPriceUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblextraprice.UOMMultiplier'
    end
    object qryExtraBuyPriceMinimumOrderQty: TFloatField
      FieldName = 'MinimumOrderQty'
      Origin = 'tblextraprice.MinimumOrderQty'
    end
    object qryExtraBuyPriceVariationOption: TWideStringField
      FieldName = 'VariationOption'
      FixedChar = True
      Size = 1
    end
    object qryExtraBuyPriceVariationtype: TWideStringField
      FieldName = 'Variationtype'
      FixedChar = True
      Size = 1
    end
    object qryExtraBuyPriceVariationAmt: TFloatField
      FieldName = 'VariationAmt'
    end
    object qryExtraBuyPriceDeleted: TWideStringField
      FieldName = 'Deleted'
      Size = 0
    end
  end
  object QryExtraFxBuyPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ForeignPriceID, PartsID, ClientID, PartName, '
      'Buy1, Price1, SupplierProductCode, '
      
        'SupplierProductName, IsSellPrice , CurrencyId, UOM, UOMID , UOMM' +
        'ultiplier,'
      'VariationOption , Variationtype, VariationAmt'
      'FROM tmp_1')
    Filtered = True
    Filter = 'Deleted ="F"'
    Left = 799
    Top = 224
    object QryExtraFxBuyPriceForeignPriceID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ForeignPriceID'
      Origin = 'tmp_1.ForeignPriceID'
      ReadOnly = True
    end
    object QryExtraFxBuyPricePartsID: TIntegerField
      FieldName = 'PartsID'
      Origin = 'tmp_1.PartsID'
    end
    object QryExtraFxBuyPricePartName: TWideStringField
      FieldName = 'PartName'
      Origin = 'tmp_1.PartName'
      Size = 60
    end
    object QryExtraFxBuyPriceBuy1: TIntegerField
      FieldName = 'Buy1'
      Origin = 'tmp_1.Buy1'
    end
    object QryExtraFxBuyPricePrice1: TFloatField
      FieldName = 'Price1'
      Origin = 'tmp_1.Price1'
      DisplayFormat = '#,##0.00000;(#,##0.00000)'
    end
    object QryExtraFxBuyPriceSupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Origin = 'tmp_1.SupplierProductCode'
      Size = 50
    end
    object QryExtraFxBuyPriceSupplierProductName: TWideStringField
      FieldName = 'SupplierProductName'
      Origin = 'tmp_1.SupplierProductName'
      Size = 50
    end
    object QryExtraFxBuyPriceSupplierName: TWideStringField
      DisplayWidth = 80
      FieldKind = fkLookup
      FieldName = 'SupplierName'
      LookupDataSet = cboClientLookup
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Size = 255
      Lookup = True
    end
    object QryExtraFxBuyPriceIsSellPrice: TWideStringField
      FieldName = 'IsSellPrice'
      Origin = 'tmp_1.IsSellPrice'
      FixedChar = True
      Size = 1
    end
    object QryExtraFxBuyPriceClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tmp_1.ClientID'
    end
    object QryExtraFxBuyPriceCurrencyId: TIntegerField
      FieldName = 'CurrencyId'
      Origin = 'tmp_1.CurrencyId'
    end
    object QryExtraFxBuyPriceCurrencyCode: TWideStringField
      FieldKind = fkLookup
      FieldName = 'CurrencyCode'
      LookupDataSet = qryBuyCurrencyLookup
      LookupKeyFields = 'CurrencyId'
      LookupResultField = 'Code'
      KeyFields = 'CurrencyId'
      Size = 3
      Lookup = True
    end
    object QryExtraFxBuyPriceUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tmp_1.UOM'
      Size = 100
    end
    object QryExtraFxBuyPriceUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tmp_1.UOMID'
    end
    object QryExtraFxBuyPriceUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tmp_1.UOMMultiplier'
    end
    object QryExtraFxBuyPriceVariationOption: TWideStringField
      FieldName = 'VariationOption'
      Origin = 'tmp_1.VariationOption'
      FixedChar = True
      Size = 1
    end
    object QryExtraFxBuyPriceVariationtype: TWideStringField
      FieldName = 'Variationtype'
      Origin = 'tmp_1.Variationtype'
      FixedChar = True
      Size = 1
    end
    object QryExtraFxBuyPriceVariationAmt: TFloatField
      FieldName = 'VariationAmt'
      Origin = 'tmp_1.VariationAmt'
    end
    object QryExtraFxBuyPriceDeleted: TWideStringField
      FieldName = 'Deleted'
      Size = 0
    end
  end
  object qryExtraSellPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PriceID, ClientTypeID, Terms, PartsID, QtyPercent1,Price1' +
        ','
      
        'AllClients,DateTo,DateFrom,ExtraSellDesc, UOM, UOMID, UOMMultipl' +
        'ier ,'
      'VariationOption , Variationtype, VariationAmt'
      'FROM tmp_1')
    Filtered = True
    Filter = 'Deleted ="F"'
    Left = 700
    Top = 224
    object qryExtraSellPricePriceID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'PriceID'
      Origin = 'tblextrapricesell.PriceID'
      ReadOnly = True
    end
    object qryExtraSellPriceClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
      Origin = 'tblextrapricesell.ClientTypeID'
    end
    object qryExtraSellPricePartsID: TIntegerField
      FieldName = 'PartsID'
      Origin = 'tblextrapricesell.PartsID'
    end
    object qryExtraSellPriceQtyPercent1: TFloatField
      FieldName = 'QtyPercent1'
      Origin = 'tblextrapricesell.QtyPercent1'
      DisplayFormat = '#0.0'#39'%'#39
    end
    object qryExtraSellPriceClientTypeName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ClientTypeName'
      LookupDataSet = qryClientTypes
      LookupKeyFields = 'ClientTypeID'
      LookupResultField = 'TypeName'
      KeyFields = 'ClientTypeID'
      Size = 30
      Lookup = True
    end
    object qryExtraSellPriceAllClients: TWideStringField
      FieldName = 'AllClients'
      Origin = 'tblextrapricesell.AllClients'
      FixedChar = True
      Size = 1
    end
    object qryExtraSellPriceDateTo: TDateField
      FieldName = 'DateTo'
      Origin = 'tblextrapricesell.DateTo'
    end
    object qryExtraSellPriceDateFrom: TDateField
      FieldName = 'DateFrom'
      Origin = 'tblextrapricesell.DateFrom'
    end
    object qryExtraSellPriceExtraSellDesc: TWideStringField
      FieldName = 'ExtraSellDesc'
      Origin = 'tblextrapricesell.ExtraSellDesc'
      Size = 255
    end
    object qryExtraSellPriceTerms: TWideStringField
      DisplayWidth = 100
      FieldName = 'Terms'
      Origin = 'tblextrapricesell.ExtraSellDesc'
      Size = 100
    end
    object qryExtraSellPricePrice1: TFloatField
      FieldName = 'Price1'
      Origin = 'tblextrapricesell.Price1'
      DisplayFormat = '$,0.00###'
      EditFormat = '0.00###'
      currency = True
    end
    object qryExtraSellPriceUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tblextrapricesell.UOM'
      Size = 100
    end
    object qryExtraSellPriceUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblextrapricesell.UOMID'
    end
    object qryExtraSellPriceUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblextrapricesell.UOMMultiplier'
    end
    object qryExtraSellPriceVariationOption: TWideStringField
      FieldName = 'VariationOption'
      FixedChar = True
      Size = 1
    end
    object qryExtraSellPriceVariationtype: TWideStringField
      FieldName = 'Variationtype'
      FixedChar = True
      Size = 1
    end
    object qryExtraSellPriceVariationAmt: TFloatField
      FieldName = 'VariationAmt'
    end
    object qryExtraSellPriceDeleted: TWideStringField
      FieldName = 'Deleted'
      Size = 0
    end
  end
  object qryExtraFxSellPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ForeignPriceID, PartsID, ClientID, PartName, '
      'Buy1, Price1, SupplierProductCode, '
      
        'SupplierProductName, IsSellPrice, CurrencyId, UOMID, UOM, UOMMul' +
        'tiplier,'
      'VariationOption , Variationtype, VariationAmt'
      'FROM tmp_1')
    Filtered = True
    Filter = 'Deleted ="F"'
    Left = 733
    Top = 224
    object qryExtraFxSellPriceCode: TWideStringField
      DisplayWidth = 3
      FieldKind = fkLookup
      FieldName = 'Code'
      LookupDataSet = qrySellCurrencyLookup
      LookupKeyFields = 'CurrencyId'
      LookupResultField = 'Code'
      KeyFields = 'CurrencyId'
      Size = 3
      Lookup = True
    end
    object qryExtraFxSellPriceUOM: TWideStringField
      DisplayWidth = 100
      FieldName = 'UOM'
      Origin = 'tblforeignprice.UOM'
      Size = 100
    end
    object qryExtraFxSellPricePrice1: TFloatField
      DisplayWidth = 10
      FieldName = 'Price1'
      Origin = 'tblforeignprice.Price1'
      DisplayFormat = '#,##0.00###;(#,##0.00###)'
    end
    object qryExtraFxSellPriceForeignPriceId: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ForeignPriceID'
      Origin = 'tblforeignprice.ForeignPriceID'
      ReadOnly = True
      Visible = False
    end
    object qryExtraFxSellPricePartsId: TIntegerField
      FieldName = 'PartsID'
      Origin = 'tblforeignprice.PartsID'
      Visible = False
    end
    object qryExtraFxSellPriceClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblforeignprice.ClientID'
      Visible = False
    end
    object qryExtraFxSellPricePartName: TWideStringField
      FieldName = 'PartName'
      Origin = 'tblforeignprice.PartName'
      Visible = False
      Size = 60
    end
    object qryExtraFxSellPriceBuy1: TIntegerField
      FieldName = 'Buy1'
      Origin = 'tblforeignprice.Buy1'
      Visible = False
    end
    object qryExtraFxSellPriceSupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Origin = 'tblforeignprice.SupplierProductCode'
      Visible = False
      Size = 50
    end
    object qryExtraFxSellPriceSupplierProductName: TWideStringField
      FieldName = 'SupplierProductName'
      Origin = 'tblforeignprice.SupplierProductName'
      Visible = False
      Size = 50
    end
    object qryExtraFxSellPriceSupplierName: TWideStringField
      DisplayWidth = 80
      FieldKind = fkLookup
      FieldName = 'SupplierName'
      LookupDataSet = cboClientLookup
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryExtraFxSellPriceIsSellPrice: TWideStringField
      FieldName = 'IsSellPrice'
      Origin = 'tblforeignprice.IsSellPrice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryExtraFxSellPriceCurrencyId: TIntegerField
      FieldName = 'CurrencyId'
      Origin = 'tblforeignprice.CurrencyId'
      Visible = False
    end
    object qryExtraFxSellPriceUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblforeignprice.UOMID'
      Visible = False
    end
    object qryExtraFxSellPriceUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblforeignprice.UOMMultiplier'
      Visible = False
    end
    object qryExtraFxSellPriceVariationOption: TWideStringField
      FieldName = 'VariationOption'
      FixedChar = True
      Size = 1
    end
    object qryExtraFxSellPriceVariationtype: TWideStringField
      FieldName = 'Variationtype'
      FixedChar = True
      Size = 1
    end
    object qryExtraFxSellPriceVariationAmt: TFloatField
      FieldName = 'VariationAmt'
    end
    object qryExtraFxSellPriceDeleted: TWideStringField
      FieldName = 'Deleted'
      Size = 0
    end
  end
  object cboClientLookup: TERPQuery
    SQLDelete.Strings = (
      'DELETE FROM tblclients'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLUpdate.Strings = (
      'UPDATE tblclients'
      'SET'
      
        '  ClientID = :ClientID, Company = :Company, ForeignExchangeSellC' +
        'ode = :ForeignExchangeSellCode'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLRefresh.Strings = (
      
        'SELECT tblclients.ClientID, tblclients.Company, tblclients.Forei' +
        'gnExchangeSellCode FROM tblclients'
      'WHERE'
      '  tblclients.ClientID = :Old_ClientID')
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company, ForeignExchangeSellCode'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active <>'#39'F'#39 +
        ' And tblclients.Supplier = '#39'T'#39
      ''
      '')
    FetchRows = 1
    Left = 536
    Top = 224
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object cboClientLookupClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
    end
    object cboClientLookupForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
  end
  object QryUOM: TERPQuery
    SQL.Strings = (
      'SELECT  '
      'distinct U.UnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  '
      'Order By UnitName;')
    Options.LongStrings = False
    Left = 569
    Top = 224
    object QryUOMUnitname: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'Unitname'
      Origin = '.UnitName'
      Size = 15
    end
  end
  object qryClientTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'ClientTypeID, TypeName, TypeDescription '
      'FROM tblClientType'
      'WHERE Active = '#39'T'#39)
    Left = 635
    Top = 224
  end
  object qrySellCurrencyLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT CurrencyId, Code FROM tblCurrencyConversion WHERE SellRat' +
        'e > 0')
    Left = 602
    Top = 224
  end
  object qryBuyCurrencyLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT CurrencyId, Code FROM tblCurrencyConversion WHERE BuyRate' +
        ' > 0')
    Left = 668
    Top = 224
  end
  object QryUpdateErrLog: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tmp_1')
    Left = 832
    Top = 224
    object QryUpdateErrLogID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object QryUpdateErrLogErrObjType: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 30
      FieldName = 'ErrObjType'
      Size = 100
    end
    object QryUpdateErrLogErrObjname: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 30
      FieldName = 'ErrObjname'
      Size = 255
    end
    object QryUpdateErrLogErrDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 100
      FieldName = 'ErrDescription'
      Size = 255
    end
  end
  object qryExtraSellPriceToDelete: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select ESP.PriceID, P.partsID, P.PARTNAME , CT.TypeName , ESP.Al' +
        'lClients , ESP.DateFrom , ESP.DateTo , '
      
        'if(ifnull(ESP.UOMID,0)=0 ,'#39#39' ,   concat(ESP.UOM , '#39'('#39' , ESP.UOMM' +
        'ultiplier , '#39')'#39' )) as UOM , '
      'ESP.QtyPercent1'
      
        ' from tblextrapricesell ESP inner join tblparts  P on ESP.PartsI' +
        'D = P.PARTSID left join tblclienttype CT on ESP.ClientTypeID = C' +
        'T.ClientTypeID '
      ' where ESP.active ="T"'
      'order by partname')
    Filtered = True
    Left = 865
    Top = 224
    object qryExtraSellPriceToDeletePARTNAME: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'PARTNAME'
      Origin = 'P.PARTNAME'
      Size = 60
    end
    object qryExtraSellPriceToDeleteTypeName: TWideStringField
      DisplayLabel = 'Client Type'
      DisplayWidth = 10
      FieldName = 'TypeName'
      Origin = 'CT.TypeName'
      Size = 50
    end
    object qryExtraSellPriceToDeleteAllClients: TWideStringField
      DisplayLabel = 'All Clients?'
      FieldName = 'AllClients'
      Origin = 'ESP.AllClients'
      FixedChar = True
      Size = 1
    end
    object qryExtraSellPriceToDeleteDateFrom: TDateField
      DisplayLabel = 'Date From'
      DisplayWidth = 12
      FieldName = 'DateFrom'
      Origin = 'ESP.DateFrom'
    end
    object qryExtraSellPriceToDeleteDateTo: TDateField
      DisplayLabel = 'Date To'
      DisplayWidth = 12
      FieldName = 'DateTo'
      Origin = 'ESP.DateTo'
    end
    object qryExtraSellPriceToDeleteUOM: TWideStringField
      DisplayWidth = 12
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 124
    end
    object qryExtraSellPriceToDeleteQtyPercent1: TFloatField
      DisplayLabel = 'Discount %'
      DisplayWidth = 1
      FieldName = 'QtyPercent1'
      Origin = 'ESP.QtyPercent1'
    end
    object qryExtraSellPriceToDeletepartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'partsID'
      Origin = 'P.partsID'
    end
    object qryExtraSellPriceToDeletePriceID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PriceID'
      Origin = 'ESP.PriceID'
    end
  end
  object QryProduct: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblparts where PartsId = 0')
    Left = 215
    Top = 314
  end
  object qrypartbarcodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblpartbarcodes WHERE PartsId = 0')
    Left = 247
    Top = 314
  end
  object qryProductBarcodeList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblpartbarcodes WHERE PartsId = 0')
    Left = 279
    Top = 314
  end
  object qryReorder: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT * FROM tblReorderPoints where ProductId=698 and ClassId =' +
        ' 1')
    Left = 327
    Top = 314
  end
  object QrySpecialProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tmp_1')
    Filtered = True
    Filter = 'Deleted ="F"'
    Left = 717
    Top = 344
    object QrySpecialProductsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tmp_1.GlobalRef'
      Size = 255
    end
    object QrySpecialProductsCustomerLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CustomerLinesID'
      Origin = 'tmp_1.CustomerLinesID'
    end
    object QrySpecialProductsCustomerId: TIntegerField
      FieldName = 'CustomerId'
      Origin = 'tmp_1.CustomerId'
    end
    object QrySpecialProductsProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tmp_1.ProductID'
    end
    object QrySpecialProductsName: TWideStringField
      FieldName = 'Name'
      Origin = 'tmp_1.Name'
      Size = 40
    end
    object QrySpecialProductsDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tmp_1.Description'
      Size = 255
    end
    object QrySpecialProductsOrigPrice: TFloatField
      FieldName = 'OrigPrice'
      Origin = 'tmp_1.OrigPrice'
      currency = True
    end
    object QrySpecialProductsLinePrice: TFloatField
      FieldName = 'LinePrice'
      Origin = 'tmp_1.LinePrice'
      currency = True
    end
    object QrySpecialProductsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tmp_1.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QrySpecialProductsIncludeInRun: TWideStringField
      FieldName = 'IncludeInRun'
      Origin = 'tmp_1.IncludeInRun'
      FixedChar = True
      Size = 1
    end
    object QrySpecialProductsDateFrom: TDateField
      FieldName = 'DateFrom'
      Origin = 'tmp_1.DateFrom'
    end
    object QrySpecialProductsDateTo: TDateField
      FieldName = 'DateTo'
      Origin = 'tmp_1.DateTo'
    end
    object QrySpecialProductsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tmp_1.msTimeStamp'
    end
    object QrySpecialProductsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tmp_1.msUpdateSiteCode'
      Size = 3
    end
    object QrySpecialProductsUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tmp_1.UOM'
      Size = 100
    end
    object QrySpecialProductsUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tmp_1.UOMID'
    end
    object QrySpecialProductsUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tmp_1.UOMMultiplier'
    end
    object QrySpecialProductsdeleted: TWideStringField
      FieldName = 'deleted'
      Origin = 'tmp_1.deleted'
      FixedChar = True
      Size = 1
    end
    object QrySpecialProductsVariationOption: TWideStringField
      FieldName = 'VariationOption'
      Origin = 'tmp_1.VariationOption'
      FixedChar = True
      Size = 1
    end
    object QrySpecialProductsVariationtype: TWideStringField
      FieldName = 'Variationtype'
      Origin = 'tmp_1.Variationtype'
      FixedChar = True
      Size = 1
    end
    object QrySpecialProductsVariationAmt: TFloatField
      DisplayLabel = 'Variation Amount'
      FieldName = 'VariationAmt'
      Origin = 'tmp_1.VariationAmt'
    end
  end
end
