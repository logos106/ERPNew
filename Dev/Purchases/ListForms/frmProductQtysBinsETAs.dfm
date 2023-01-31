inherited frmProductQtyBinETA: TfrmProductQtyBinETA
  Left = 690
  Top = 128
  HelpContext = 634000
  Caption = 'Product Status'
  ClientHeight = 565
  ClientWidth = 766
  OldCreateOrder = True
  PopupMenu = Mnumain
  OnResize = FormResize
  ExplicitLeft = 690
  ExplicitTop = 128
  ExplicitWidth = 782
  ExplicitHeight = 604
  DesignSize = (
    766
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 530
    Width = 766
    HelpContext = 634005
    ExplicitTop = 522
    ExplicitWidth = 766
  end
  object pnlFooter: TDNMPanel [5]
    Left = 0
    Top = 530
    Width = 766
    Height = 35
    HelpContext = 634003
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      766
      35)
    object BitBtn2: TDNMSpeedButton
      Left = 465
      Top = 4
      Width = 102
      Height = 27
      HelpContext = 634011
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Close'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = BitBtn2Click
    end
    object btnHowTo: TDNMSpeedButton
      Left = 199
      Top = 4
      Width = 102
      Height = 27
      HelpContext = 634025
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
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnHowToClick
    end
    object btnAltProducts: TDNMSpeedButton
      Left = 322
      Top = 4
      Width = 122
      Height = 27
      HelpContext = 634026
      Anchors = [akBottom]
      Caption = 'Alternate Products'
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
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnAltProductsClick
    end
  end
  object PgMain: TPageControl [6]
    Left = 0
    Top = 50
    Width = 766
    Height = 480
    HelpContext = 634013
    ActivePage = TabStock
    Align = alClient
    TabOrder = 2
    OnResize = PgMainResize
    object TabStock: TTabSheet
      HelpContext = 634014
      Caption = 'Stock '
      ImageIndex = 1
      object splBottom1: TSplitter
        Left = 0
        Top = 323
        Width = 758
        Height = 2
        Cursor = crVSplit
        HelpContext = 634015
        Align = alBottom
        ExplicitTop = 350
      end
      object pnlBins: TDNMPanel
        Left = 0
        Top = 0
        Width = 758
        Height = 323
        HelpContext = 634006
        Align = alClient
        BevelKind = bkSoft
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label2: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 746
          Height = 44
          HelpContext = 634016
          Align = alTop
          Alignment = taCenter
          Caption = 'Bin Quantities : EmbedBins'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -37
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
          ExplicitWidth = 491
        end
      end
      object pnlCCS: TDNMPanel
        Left = 0
        Top = 325
        Width = 758
        Height = 125
        HelpContext = 634017
        Align = alBottom
        BevelKind = bkSoft
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label4: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 33
          Width = 746
          Height = 44
          HelpContext = 634018
          Align = alTop
          Alignment = taCenter
          Caption = 'Cross Companies Stock : EmbedCCS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -37
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
          ExplicitWidth = 667
        end
        object Label5: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 746
          Height = 23
          HelpContext = 634001
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
        object Label6: TLabel
          Left = 1
          Top = 97
          Width = 752
          Height = 23
          HelpContext = 634027
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 'Double Click on the Company'#39's Qty to Make Invoice For'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = 4
          ExplicitTop = 4
          ExplicitWidth = 754
        end
        object DNMSpeedButton1: TDNMSpeedButton
          AlignWithMargins = True
          Left = 217
          Top = 2
          Width = 93
          Height = 23
          HelpContext = 634019
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Caption = 'Companies'
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
      end
    end
    object TabPO: TTabSheet
      HelpContext = 634020
      Caption = 'Expected Stock'
      object spltop2: TSplitter
        Left = 0
        Top = 323
        Width = 758
        Height = 2
        Cursor = crVSplit
        HelpContext = 634021
        Align = alBottom
        ExplicitTop = 125
      end
      object pnlshipcontainers: TDNMPanel
        Left = 0
        Top = 325
        Width = 758
        Height = 125
        HelpContext = 634012
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 752
          Height = 15
          HelpContext = 634022
          Align = alTop
          Caption = 'Shipping Container'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          ExplicitWidth = 107
        end
        object grdShipping: TwwDBGrid
          Left = 0
          Top = 21
          Width = 758
          Height = 104
          HelpContext = 634002
          Selected.Strings = (
            'ContainerName'#9'13'#9'ContainerName'#9'F'
            'ETDeparture'#9'10'#9'ETD Date'#9'F'
            'ShippingContainerStatus'#9'7'#9'Status'#9'F'
            'DeparturePoint'#9'13'#9'Port of Departure'#9'F'
            'VesselName'#9'22'#9'Vessel Name'#9'F'
            'ETA'#9'13'#9'ETA Date'#9'F'
            'ArrivalPoint'#9'20'#9'Port of Arrival'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alClient
          DataSource = DSShipContainer
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize, dgFixedProportionalResize]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = grdShippingDblClick
        end
      end
      object PnlETA: TDNMPanel
        Left = 0
        Top = 0
        Width = 758
        Height = 323
        HelpContext = 634007
        Align = alClient
        BevelKind = bkSoft
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label3: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 746
          Height = 44
          HelpContext = 634023
          Align = alTop
          Alignment = taCenter
          Caption = 'ETA : EmbedETA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -37
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
          ExplicitWidth = 301
        end
      end
    end
  end
  object pnlTop: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 766
    Height = 50
    HelpContext = 634004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      766
      50)
    object pnlTitle: TDNMPanel
      Left = 202
      Top = 6
      Width = 346
      Height = 38
      HelpContext = 634008
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
        Width = 342
        Height = 34
        HelpContext = 634009
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
          Height = 34
          HelpContext = 634010
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Product Status'
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
  inherited tmrProcessMessage: TTimer
    Left = 307
    Top = 248
  end
  inherited tmrdelay: TTimer
    Left = 344
    Top = 248
  end
  inherited popSpelling: TPopupMenu
    Left = 381
    Top = 248
  end
  inherited tmrdelayMsg: TTimer
    Left = 270
    Top = 248
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 492
    Top = 248
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 640
    Top = 248
  end
  inherited MyConnection: TERPConnection
    Left = 48
    Top = 215
  end
  inherited DataState: TDataState
    Left = 529
    Top = 248
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 634007
    Left = 418
    Top = 248
  end
  inherited imgsort: TImageList
    Left = 566
    Top = 248
    Bitmap = {
      494C010102003C00A00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 85
    Top = 248
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 603
    Top = 248
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 455
    Top = 248
  end
  inherited qryMemTrans: TERPQuery
    Left = 159
    Top = 248
  end
  object qryShippingContainer: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblshippingcontainer')
    Left = 48
    Top = 248
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
  end
  object qryShipContainerDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblshipcontainerdetails '
      'WHERE ShippingContainerID = :xShippingContainerID')
    Left = 122
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xShippingContainerID'
      end>
    object qryShipContainerDetailsPurchaseLineID: TIntegerField
      DisplayLabel = 'Purchase LineID'
      DisplayWidth = 15
      FieldName = 'PurchaseLineID'
      Origin = 'tblshipcontainerdetails.PurchaseLineID'
      Visible = False
    end
    object qryShipContainerDetailsOrderDate: TDateField
      DisplayLabel = 'Order Date'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'OrderDate'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'orderdate'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Lookup = True
    end
    object qryShipContainerDetailsCommercialInvNo: TWideStringField
      DisplayLabel = 'Commercial Inv No'
      DisplayWidth = 20
      FieldName = 'CommercialInvNo'
      Origin = 'tblshipcontainerdetails.CommercialInvNo'
      Visible = False
      Size = 255
    end
    object qryShipContainerDetailsSupplierWorkOrderNo: TWideStringField
      DisplayLabel = 'Supplier Work Order No'
      DisplayWidth = 20
      FieldName = 'SupplierWorkOrderNo'
      Origin = 'tblshipcontainerdetails.SupplierWorkOrderNo'
      Visible = False
      Size = 255
    end
    object qryShipContainerDetailsProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ProductName'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'ProductName'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryShipContainerDetailsTotalAmountInc: TFloatField
      DisplayLabel = 'Total Amount Inc'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'TotalAmountInc'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'TotalAmountInc'
      KeyFields = 'PurchaseLineID'
      Visible = False
      currency = True
      Lookup = True
    end
    object qryShipContainerDetailsUnitOfMeasureQtySold: TWideStringField
      DisplayLabel = 'Qty Sold'
      DisplayWidth = 12
      FieldKind = fkLookup
      FieldName = 'UnitOfMeasureQtySold'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'UnitOfMeasureQtySold'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryShipContainerDetailsDepartment: TWideStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Department'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'class'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryShipContainerDetailsProductDescription: TWideStringField
      DisplayLabel = 'Product Description'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'ProductDescription'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'Product_Description'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryShipContainerDetailsShipContainerDetailID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ShipContainerDetailID'
      Origin = 'tblshipcontainerdetails.ShipContainerDetailID'
      Visible = False
    end
    object qryShipContainerDetailsShippingContainerID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShippingContainerID'
      Origin = 'tblshipcontainerdetails.ShippingContainerID'
      Visible = False
    end
    object qryShipContainerDetailsGLOBALREF: TWideStringField
      DisplayWidth = 20
      FieldName = 'GLOBALREF'
      Origin = 'tblshipcontainerdetails.GLOBALREF'
      Visible = False
      Size = 255
    end
    object qryShipContainerDetailsSupplier: TWideStringField
      DisplayWidth = 255
      FieldKind = fkLookup
      FieldName = 'Supplier'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'SupplierName'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryShipContainerDetailsCustomerJob: TWideStringField
      DisplayWidth = 255
      FieldKind = fkLookup
      FieldName = 'CustomerJob'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'CustomerJob'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryShipContainerDetailsPurchaseOrderID: TIntegerField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PurchaseOrderID'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'PurchaseOrderID'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Lookup = True
    end
    object qryShipContainerDetailsUnits: TWideStringField
      DisplayWidth = 255
      FieldKind = fkLookup
      FieldName = 'Units'
      LookupKeyFields = 'PurchaseLineID'
      LookupResultField = 'UnitOfMeasurePOLines'
      KeyFields = 'PurchaseLineID'
      Visible = False
      Size = 255
      Lookup = True
    end
  end
  object DSShipContainer: TDataSource
    DataSet = qryShipContainers
    Left = 233
    Top = 216
  end
  object qryShipContainers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT SC.ContainerName,SC.ETDeparture,SC.ShippingContainerStatu' +
        's,DeparturePoint,VesselName,'
      
        'SC.ETA,SC.ArrivalPoint,SD.PurchaseLineID,tblparts.partname,SC.Sh' +
        'ippingContainerID '
      'FROM tblshippingcontainer SC'
      
        'INNER JOIN tblshipcontainerdetails SD ON SC.ShippingContainerID ' +
        '= SD.ShippingContainerID'
      
        'INNER JOIN tblpurchaseLines PL ON SD.PurchaseLineId = PL.Purchas' +
        'eLineID'
      'INNER JOIN tblparts ON PL.ProductID=tblparts.PartsID')
    Left = 233
    Top = 248
    object qryShipContainersContainerName: TWideStringField
      DisplayWidth = 15
      FieldName = 'ContainerName'
      Size = 255
    end
    object qryShipContainersETDeparture: TDateField
      DisplayLabel = 'ETD Date'
      DisplayWidth = 10
      FieldName = 'ETDeparture'
    end
    object qryShipContainersShippingContainerStatus: TWideStringField
      DisplayLabel = 'Status'
      DisplayWidth = 15
      FieldName = 'ShippingContainerStatus'
      Size = 255
    end
    object qryShipContainersDeparturePoint: TWideStringField
      DisplayLabel = 'Port of Departure'
      DisplayWidth = 15
      FieldName = 'DeparturePoint'
      Size = 255
    end
    object qryShipContainersVesselName: TWideStringField
      DisplayLabel = 'Vessel Name'
      DisplayWidth = 20
      FieldName = 'VesselName'
      Size = 255
    end
    object qryShipContainersETA: TDateField
      DisplayLabel = 'ETA Date'
      DisplayWidth = 10
      FieldName = 'ETA'
    end
    object qryShipContainersArrivalPoint: TWideStringField
      DisplayLabel = 'Port of Arrival'
      DisplayWidth = 20
      FieldName = 'ArrivalPoint'
      Size = 255
    end
    object qryShipContainersPurchaseLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseLineID'
      Visible = False
    end
    object qryShipContainerspartname: TWideStringField
      DisplayLabel = 'Part Name'
      DisplayWidth = 20
      FieldName = 'partname'
      Visible = False
      Size = 60
    end
    object qryShipContainersShippingContainerID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShippingContainerID'
    end
  end
  object qryShipContainerLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ContainerName,SD.PurchaseLineID,tblpurchaselines.SaleLine' +
        'ID,SC.ETA,SC.Active'
      'FROM tblshippingcontainer SC'
      
        'INNER JOIN tblshipcontainerdetails SD ON SC.ShippingContainerID ' +
        '= SD.ShippingContainerID'
      
        'INNER JOIN tblpurchaselines ON SD.PurchaseLineID = tblpurchaseli' +
        'nes.PurchaseLineID'
      'WHERE SC.Active = "T"'
      '#GROUP BY ContainerName')
    Left = 196
    Top = 248
  end
  object Mnumain: TAdvPopupMenu
    Version = '2.5.3.4'
    Left = 680
    Top = 248
    object DefaultHeight1: TMenuItem
      Caption = 'Default Height'
      HelpContext = 634024
      OnClick = DefaultHeight1Click
    end
  end
end
