inherited fmBatchNoCreate: TfmBatchNoCreate
  Left = 368
  Top = 189
  Caption = 'Batch Number'
  ClientHeight = 601
  ClientWidth = 994
  Font.Height = -32
  ExplicitLeft = 368
  ExplicitTop = 189
  ExplicitWidth = 1010
  ExplicitHeight = 640
  DesignSize = (
    994
    601)
  PixelsPerInch = 96
  TextHeight = 37
  HelpContext = 1629002
  inherited lblSkingroupMsg: TLabel
    Top = 470
    Width = 994
    ExplicitTop = 223
    ExplicitWidth = 455
    HelpContext = 1629003
  end
  inherited shapehint: TShape
    Left = 126
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
    Left = 266
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object pnltop: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 994
    Height = 71
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      994
      71)
    HelpContext = 1629004
    object pnlTitle: TDNMPanel
      Left = 336
      Top = 7
      Width = 289
      Height = 57
      HelpContext = 1629005
      Anchors = []
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
        Width = 287
        Height = 55
        HelpContext = 1629006
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
          Width = 287
          Height = 55
          HelpContext = 1629007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Batch Number'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -37
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -2
          ExplicitTop = -5
          ExplicitWidth = 386
          ExplicitHeight = 47
        end
      end
    end
    object DNMPanel4: TDNMPanel
      AlignWithMargins = True
      Left = 831
      Top = 3
      Width = 135
      Height = 65
      HelpContext = 1629008
      Margins.Top = 2
      Margins.Right = 27
      Margins.Bottom = 2
      Align = alRight
      BevelEdges = []
      BevelOuter = bvNone
      BorderWidth = 1
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 123
        Height = 24
        HelpContext = 1629009
        Align = alTop
        Alignment = taRightJustify
        Caption = ' No #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 76
        ExplicitWidth = 51
      end
      object edtBatchSeqno: TDBEdit
        Left = 1
        Top = 31
        Width = 129
        Height = 29
        HelpContext = 1629010
        Margins.Top = 8
        Margins.Bottom = 9
        TabStop = False
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsNone
        DataField = 'CUSTFLD3'
        DataSource = dssaleaBatch
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object pnlSeqno: TDNMPanel
      AlignWithMargins = True
      Left = 27
      Top = 12
      Width = 135
      Height = 47
      HelpContext = 1629011
      Margins.Left = 26
      Margins.Top = 11
      Margins.Bottom = 11
      Align = alLeft
      BevelOuter = bvNone
      BorderWidth = 1
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object edtSeqno: TDBEdit
        Left = 1
        Top = 1
        Width = 129
        Height = 41
        HelpContext = 1629012
        Margins.Top = 8
        Margins.Bottom = 13
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsNone
        DataField = 'CUSTFLD2'
        DataSource = dssaleaBatch
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
      end
    end
    object DNMPanel9: TDNMPanel
      AlignWithMargins = True
      Left = 651
      Top = 3
      Width = 175
      Height = 65
      HelpContext = 1629013
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      BevelEdges = []
      BevelOuter = bvNone
      BorderWidth = 1
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label7: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 163
        Height = 24
        HelpContext = 1629014
        Align = alTop
        Alignment = taRightJustify
        Caption = 'Customer PO #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 14
        ExplicitWidth = 153
      end
      object DBEdit1: TDBEdit
        Left = 1
        Top = 31
        Width = 169
        Height = 29
        HelpContext = 1629015
        Margins.Top = 8
        Margins.Bottom = 9
        TabStop = False
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsNone
        DataField = 'PONumber'
        DataSource = dsSales
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object pnlSalesBatchRelated: TDNMPanel [6]
    Left = 0
    Top = 209
    Width = 994
    Height = 261
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitTop = 163
    ExplicitHeight = 307
    HelpContext = 1629016
    object grdSalesBatchRelated: TwwDBGrid
      AlignWithMargins = True
      Left = 26
      Top = 4
      Width = 157
      Height = 253
      Margins.Left = 25
      Margins.Right = 25
      TabStop = False
      Selected.Strings = (
        'ProductName'#9'14'#9'Item'#9'T'#9
        'ProductDescription'#9'19'#9'Description'#9'T'#9
        'Uom'#9'9'#9'UOM'#9'T'#9
        'RelatedProductQty'#9'7'#9'Qty'#9#9
        'TotalWeight'#9'10'#9'Tare Weight'#9'T'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsSalesBatchRelated
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -24
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdSalesBatchRelatedCalcCellColors
      OnCalcTitleAttributes = grdSalesBatchRelatedCalcTitleAttributes
      FooterColor = clWhite
      ExplicitHeight = 299
      HelpContext = 1629017
    end
    object DNMPanel1: TDNMPanel
      Left = 208
      Top = 1
      Width = 785
      Height = 259
      Align = alRight
      BorderWidth = 3
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
      ExplicitHeight = 305
      HelpContext = 1629018
      object Label9: TLabel
        Left = 4
        Top = 188
        Width = 272
        Height = 63
        HelpContext = 1629019
        Align = alLeft
        Alignment = taCenter
        Caption = 'Invisible Panel, not Implemented'
        Color = clGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
        ExplicitHeight = 68
      end
      object pnlUOMDetails: TDNMPanel
        Left = 4
        Top = 148
        Width = 773
        Height = 40
        HelpContext = 1629020
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblUOMDetails: TLabel
          AlignWithMargins = True
          Left = 0
          Top = 3
          Width = 251
          Height = 34
          HelpContext = 1629021
          Margins.Left = 0
          Margins.Right = 522
          Align = alClient
          Alignment = taCenter
          Caption = '1 UOM = X Base UOM'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 213
          ExplicitHeight = 24
        end
      end
      object DNMPanel5: TDNMPanel
        Left = 4
        Top = 4
        Width = 773
        Height = 144
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Visible = False
        HelpContext = 1629022
        object pnlLabels: TDNMPanel
          Left = 201
          Top = 0
          Width = 150
          Height = 144
          Align = alLeft
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          HelpContext = 1629023
          object DNMPanel12: TDNMPanel
            Left = 0
            Top = 94
            Width = 150
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            HelpContext = 1629024
            object lblUnits: TLabel
              Left = 46
              Top = 0
              Width = 104
              Height = 47
              HelpContext = 1629025
              Align = alRight
              Caption = 'Base UOM'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
              ExplicitHeight = 24
            end
          end
          object DNMPanel13: TDNMPanel
            Left = 0
            Top = 47
            Width = 150
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            HelpContext = 1629026
            object lblUOM: TLabel
              Left = 103
              Top = 0
              Width = 47
              Height = 47
              HelpContext = 1629027
              Align = alRight
              Alignment = taRightJustify
              Caption = 'UOM'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
              ExplicitHeight = 24
            end
          end
          object DNMPanel14: TDNMPanel
            Left = 0
            Top = 0
            Width = 150
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            HelpContext = 1629028
          end
        end
        object pnlExpiryDate: TDNMPanel
          Left = 0
          Top = 0
          Width = 201
          Height = 144
          Align = alLeft
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          HelpContext = 1629029
          object DNMPanel16: TDNMPanel
            Left = 1
            Top = 48
            Width = 199
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            HelpContext = 1629030
            object wwDBDateTimePicker1: TwwDBDateTimePicker
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 187
              Height = 40
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'Tahoma'
              CalendarAttributes.Font.Style = []
              DataField = 'ExpiryDate'
              DataSource = dssaleaBatch
              Epoch = 1950
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -27
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ShowButton = True
              TabOrder = 0
              HelpContext = 1629031
            end
          end
          object DNMPanel17: TDNMPanel
            Left = 1
            Top = 1
            Width = 199
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            HelpContext = 1629032
            object lblExpiryDate: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 0
              Width = 196
              Height = 47
              HelpContext = 1629033
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alClient
              Caption = 'Expiry Date'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlBottom
              ExplicitWidth = 115
              ExplicitHeight = 24
            end
          end
        end
        object pnlBOQty: TDNMPanel
          Left = 453
          Top = 0
          Width = 160
          Height = 144
          Align = alRight
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          ExplicitLeft = 133
          HelpContext = 1629034
          object DNMPanel22: TDNMPanel
            Left = 0
            Top = 94
            Width = 160
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            HelpContext = 1629035
            object edtBOQty: TDBEdit
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 156
              Height = 41
              HelpContext = 1629036
              Align = alLeft
              DataField = 'BOQty'
              DataSource = dssaleaBatch
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -27
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitHeight = 40
            end
          end
          object DNMPanel23: TDNMPanel
            Left = 0
            Top = 47
            Width = 160
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            HelpContext = 1629037
            object edtUOMBOQty: TDBEdit
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 156
              Height = 41
              HelpContext = 1629038
              Align = alLeft
              DataField = 'BOUOMQty'
              DataSource = dssaleaBatch
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -27
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitHeight = 40
            end
          end
          object DNMPanel24: TDNMPanel
            Left = 0
            Top = 0
            Width = 160
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            HelpContext = 1629039
            object Label5: TLabel
              Left = 0
              Top = 0
              Width = 160
              Height = 47
              HelpContext = 1629040
              Align = alClient
              Caption = 'BO Quantity'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlBottom
              WordWrap = True
              ExplicitWidth = 121
              ExplicitHeight = 24
            end
          end
        end
        object pnlQty: TDNMPanel
          Left = 613
          Top = 0
          Width = 160
          Height = 144
          Align = alRight
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitLeft = 293
          HelpContext = 1629041
          object DNMPanel25: TDNMPanel
            Left = 0
            Top = 47
            Width = 160
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            HelpContext = 1629042
            object edtUOMQty: TDBEdit
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 156
              Height = 41
              HelpContext = 1629043
              Align = alLeft
              DataField = 'UOMQty'
              DataSource = dssaleaBatch
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -27
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitHeight = 40
            end
          end
          object DNMPanel26: TDNMPanel
            Left = 0
            Top = 0
            Width = 160
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            HelpContext = 1629044
            object lblQty: TLabel
              Left = 0
              Top = 0
              Width = 160
              Height = 47
              HelpContext = 1629045
              Align = alClient
              Caption = 'Quantity'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlBottom
              WordWrap = True
              ExplicitWidth = 84
              ExplicitHeight = 24
            end
          end
          object DNMPanel27: TDNMPanel
            Left = 0
            Top = 94
            Width = 160
            Height = 47
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            HelpContext = 1629046
            object edtQty: TDBEdit
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 156
              Height = 41
              HelpContext = 1629047
              Align = alLeft
              DataField = 'Qty'
              DataSource = dssaleaBatch
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -27
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              ExplicitHeight = 40
            end
          end
        end
      end
      object DNMPanel6: TDNMPanel
        Left = 475
        Top = 177
        Width = 505
        Height = 80
        BevelOuter = bvLowered
        BorderWidth = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        Visible = False
        HelpContext = 1629048
        object lblRelatedQtybasedon: TLabel
          Left = 2
          Top = 2
          Width = 501
          Height = 22
          HelpContext = 1629049
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Related Product Qty Based on'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 278
        end
        object grpFilters: TwwRadioGroup
          AlignWithMargins = True
          Left = 35
          Top = 24
          Width = 468
          Height = 54
          Margins.Left = 33
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          DisableThemes = False
          ItemIndex = 0
          ShowGroupCaption = False
          Align = alClient
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Qty'
            'Custom field1')
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = grpFiltersClick
          HelpContext = 1629050
        end
      end
    end
  end
  object pnlFooter: TDNMPanel [7]
    Left = 0
    Top = 536
    Width = 994
    Height = 65
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    HelpContext = 1629051
    object cmdCancel: TDNMSpeedButton
      AlignWithMargins = True
      Left = 811
      Top = 7
      Width = 151
      Height = 51
      HelpContext = 1629052
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
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
      OnClick = cmdCancelClick
    end
    object btnfinalise: TDNMSpeedButton
      AlignWithMargins = True
      Left = 654
      Top = 7
      Width = 151
      Height = 51
      HelpContext = 1629053
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = '&Finalise'
      DisableTransparent = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
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
      OnClick = btnfinaliseClick
    end
    object btnPrintunallocated: TDNMSpeedButton
      AlignWithMargins = True
      Left = 497
      Top = 7
      Width = 151
      Height = 51
      HelpContext = 1629054
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = 'Print Un-Allocated'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
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
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnPrintunallocatedClick
    end
    object cmdNew: TDNMSpeedButton
      AlignWithMargins = True
      Left = 340
      Top = 7
      Width = 151
      Height = 51
      HelpContext = 1629055
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = '&Print'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
    object btnNew: TDNMSpeedButton
      AlignWithMargins = True
      Left = 183
      Top = 7
      Width = 151
      Height = 51
      HelpContext = 1629056
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnNewClick
    end
    object cmdClose: TDNMSpeedButton
      AlignWithMargins = True
      Left = 26
      Top = 7
      Width = 151
      Height = 51
      HelpContext = 1629057
      Margins.Left = 25
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
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
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
  end
  object pnlWeight: TDNMPanel [8]
    Left = 0
    Top = 470
    Width = 994
    Height = 66
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'sadsadsadasd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    HelpContext = 1629058
    object Shape1: TShape
      Left = 164
      Top = 0
      Width = 1
      Height = 66
      Align = alLeft
      HelpContext = 1629059
    end
    object Shape2: TShape
      Left = 786
      Top = 0
      Width = 1
      Height = 66
      Align = alLeft
      HelpContext = 1629060
    end
    object Shape3: TShape
      Left = 582
      Top = 0
      Width = 1
      Height = 66
      Align = alLeft
      HelpContext = 1629061
    end
    object Shape4: TShape
      Left = 0
      Top = 0
      Width = 993
      Height = 66
      Brush.Style = bsClear
      HelpContext = 1629062
    end
    object pnlAdvPrinting: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 1
      Width = 158
      Height = 64
      HelpContext = 1629063
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alLeft
      BevelOuter = bvNone
      BorderWidth = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      Transparent = False
      object ChkChooseRpt: TCheckBox
        AlignWithMargins = True
        Left = 82
        Top = 4
        Width = 88
        Height = 56
        HelpContext = 1629064
        Align = alLeft
        Caption = 'Choose &Template'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        WordWrap = True
      end
      object chkPreview: TCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 72
        Height = 56
        HelpContext = 1629065
        Align = alLeft
        Caption = 'Show Previe&w'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        WordWrap = True
      end
      object chkShowBOQuantity: TCheckBox
        Left = 173
        Top = 1
        Width = 129
        Height = 62
        HelpContext = 1629066
        Align = alLeft
        Caption = 'Show BO Quantity'
        Checked = True
        State = cbChecked
        TabOrder = 2
        Visible = False
        OnClick = chkShowBOQuantityClick
      end
      object chkShowExpiry: TCheckBox
        Left = 302
        Top = 1
        Width = 129
        Height = 62
        HelpContext = 1629067
        Align = alLeft
        Caption = 'Show Expiry Date'
        Checked = True
        State = cbChecked
        TabOrder = 3
        Visible = False
        OnClick = chkShowExpiryClick
      end
    end
    object DNMPanel3: TDNMPanel
      AlignWithMargins = True
      Left = 165
      Top = 1
      Width = 417
      Height = 64
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alLeft
      BevelOuter = bvNone
      BorderWidth = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      HelpContext = 1629068
      object Label4: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 86
        Height = 56
        HelpContext = 1629069
        Align = alLeft
        Alignment = taRightJustify
        Caption = 'Pallets : '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 24
      end
      object edtCUSTFLD5: TDBEdit
        AlignWithMargins = True
        Left = 96
        Top = 12
        Width = 123
        Height = 40
        HelpContext = 1629070
        Margins.Top = 11
        Margins.Bottom = 11
        Align = alClient
        DataField = 'CUSTFLD5'
        DataSource = dssaleaBatch
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = edtCUSTFLD5Exit
      end
      object btnContacts: TDNMSpeedButton
        AlignWithMargins = True
        Left = 320
        Top = 12
        Width = 95
        Height = 40
        Hint = 'Choose from List'
        HelpContext = 1629071
        Margins.Left = 1
        Margins.Top = 11
        Margins.Right = 1
        Margins.Bottom = 11
        Align = alRight
        Caption = 'Pallet List'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = blGlyphTop
        ParentFont = False
        TabOrder = 2
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnContactsClick
      end
      object btnNextPallet: TDNMSpeedButton
        AlignWithMargins = True
        Left = 223
        Top = 12
        Width = 95
        Height = 40
        HelpContext = 1629072
        Margins.Left = 1
        Margins.Top = 11
        Margins.Right = 1
        Margins.Bottom = 11
        Align = alRight
        Caption = 'Next P&allet'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnNextPalletClick
      end
    end
    object DNMPanel8: TDNMPanel
      AlignWithMargins = True
      Left = 790
      Top = 1
      Width = 201
      Height = 64
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        201
        64)
      HelpContext = 1629073
      object Label6: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 45
        Height = 56
        HelpContext = 1629074
        Align = alLeft
        Alignment = taRightJustify
        Caption = 'Net Weight'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitHeight = 32
      end
      object edtNetWeight: TwwDBEdit
        AlignWithMargins = True
        Left = 79
        Top = 12
        Width = 120
        Height = 40
        TabStop = False
        Anchors = [akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 16
        ParentFont = False
        Picture.PictureMask = '[#][#][#][#][#][#][#][#][#][#][#][.][#][#][#][#][#][#][#]'
        Picture.AllowInvalidExit = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtNetWeightChange
        OnEnter = edtNetWeightEnter
        OnExit = edtNetWeightExit
        HelpContext = 1629075
      end
    end
    object DNMPanel11: TDNMPanel
      AlignWithMargins = True
      Left = 586
      Top = 1
      Width = 197
      Height = 64
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alLeft
      BevelOuter = bvNone
      BorderWidth = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        197
        64)
      HelpContext = 1629076
      object Label8: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 45
        Height = 56
        HelpContext = 1629077
        Align = alLeft
        Alignment = taRightJustify
        Caption = 'Gross Weight'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitHeight = 32
      end
      object edtTotalWeight: TwwDBEdit
        AlignWithMargins = True
        Left = 75
        Top = 12
        Width = 120
        Height = 40
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Anchors = [akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 16
        ParentFont = False
        Picture.PictureMask = '[#][#][#][#][#][#][#][#][#][#][#][.][#][#][#][#][#][#][#]'
        Picture.AllowInvalidExit = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtTotalWeightChange
        OnEnter = edtTotalWeightEnter
        OnExit = edtTotalWeightExit
        HelpContext = 1629078
      end
    end
  end
  object pnlBatch: TDNMPanel [9]
    Left = 0
    Top = 71
    Width = 994
    Height = 92
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      994
      92)
    HelpContext = 1629079
    object lblBatchNo: TLabel
      Left = 24
      Top = 39
      Width = 216
      Height = 37
      HelpContext = 1629080
      Alignment = taRightJustify
      Caption = 'Batch Number'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 849
      Top = 7
      Width = 117
      Height = 24
      HelpContext = 1629081
      Alignment = taRightJustify
      Caption = 'Nett Weight'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 707
      Top = 5
      Width = 84
      Height = 24
      HelpContext = 1629082
      Alignment = taRightJustify
      Caption = 'Quantity'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object edtBatchNo: TDBEdit
      Left = 249
      Top = 35
      Width = 420
      Height = 44
      HelpContext = 1629083
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Value'
      DataSource = dssaleaBatch
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtWeight: TDBEdit
      AlignWithMargins = True
      Left = 815
      Top = 37
      Width = 151
      Height = 40
      HelpContext = 1629084
      TabStop = False
      Color = 13224393
      DataField = 'totalWeight'
      DataSource = dsUOM
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtBatchQty: TDBEdit
      AlignWithMargins = True
      Left = 676
      Top = 37
      Width = 112
      Height = 40
      HelpContext = 1629085
      DataField = 'UOMQty'
      DataSource = dssaleaBatch
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edtBatchQtyChange
      OnEnter = edtBatchQtyEnter
      OnExit = edtBatchQtyExit
    end
  end
  object DNMPanel2: TDNMPanel [10]
    Left = 0
    Top = 163
    Width = 994
    Height = 46
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    HelpContext = 1629086
    object pnlcustFld1: TDNMPanel
      Left = 670
      Top = 1
      Width = 323
      Height = 44
      Align = alRight
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      HelpContext = 1629087
      object lblPQADEtailsCUSTFLD1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 155
        Height = 38
        HelpContext = 1629088
        Align = alClient
        Alignment = taRightJustify
        Caption = 'CustFld1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 90
        ExplicitHeight = 24
      end
      object EdtPQACUSTFLD1: TDBEdit
        AlignWithMargins = True
        Left = 164
        Top = 3
        Width = 156
        Height = 38
        HelpContext = 1629089
        Align = alRight
        DataField = 'CUSTFLD1'
        DataSource = dssaleaBatch
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 93
      end
    end
    object pnlcustfld4: TDNMPanel
      Left = 1
      Top = 1
      Width = 669
      Height = 44
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 65
      ExplicitWidth = 464
      HelpContext = 1629090
      object lblPQADEtailsCUSTFLD4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 501
        Height = 38
        HelpContext = 1629091
        Align = alClient
        Alignment = taRightJustify
        Caption = 'CustFld4'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = -3
        ExplicitTop = 2
        ExplicitWidth = 269
        ExplicitHeight = 44
      end
      object edtPQACUSTFLD4: TDBEdit
        AlignWithMargins = True
        Left = 510
        Top = 3
        Width = 156
        Height = 38
        HelpContext = 1629092
        Align = alRight
        DataField = 'CUSTFLD4'
        DataSource = dssaleaBatch
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 153
        ExplicitTop = 2
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 499
    Top = 244
  end
  inherited tmrdelay: TTimer
    Left = 646
    Top = 244
  end
  inherited popSpelling: TPopupMenu
    Left = 469
    Top = 244
  end
  inherited tmrdelayMsg: TTimer
    Left = 410
    Top = 244
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 528
    Top = 244
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 676
    Top = 244
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 352
    Top = 244
  end
  inherited DataState: TDataState
    Left = 587
    Top = 244
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 705
    Top = 244
  end
  inherited imgsort: TImageList
    Left = 617
    Top = 244
    Bitmap = {
      494C0101020094008C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 440
    Top = 244
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 735
    Top = 244
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 558
    Top = 244
  end
  inherited qryMemTrans: TERPQuery
    Left = 381
    Top = 244
  end
  object dssaleaBatch: TDataSource
    Left = 315
    Top = 273
  end
  object dsSalesBatchRelated: TDataSource
    DataSet = QrySalesBatchRelated
    Left = 283
    Top = 273
  end
  object QrySalesBatchRelated: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSalesBatches')
    BeforeOpen = QrySalesBatchRelatedBeforeOpen
    OnCalcFields = QrySalesBatchRelatedCalcFields
    Left = 284
    Top = 244
    object QrySalesBatchRelatedProductName: TWideStringField
      DisplayLabel = 'Item'
      DisplayWidth = 14
      FieldName = 'ProductName'
      Origin = 'tblsalesbatches.ProductName'
      Size = 255
    end
    object QrySalesBatchRelatedProductDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 19
      FieldName = 'ProductDescription'
      Origin = 'tblsalesbatches.ProductDescription'
      Size = 255
    end
    object QrySalesBatchRelatedUom: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 9
      FieldName = 'Uom'
      Origin = 'tblsalesbatches.Uom'
      Size = 255
    end
    object QrySalesBatchRelatedRelatedProductQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 7
      FieldName = 'RelatedProductQty'
      Origin = 'tblsalesbatches.RelatedProductQty'
    end
    object QrySalesBatchRelatedTotalWeight: TFloatField
      DisplayLabel = 'Tare Weight'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalWeight'
      Calculated = True
    end
    object QrySalesBatchRelatedID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblsalesbatches.ID'
      Visible = False
    end
    object QrySalesBatchRelatedSaleLineId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineId'
      Origin = 'tblsalesbatches.SaleLineId'
      Visible = False
    end
    object QrySalesBatchRelatedRelatedParentLineRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'RelatedParentLineRef'
      Origin = 'tblsalesbatches.RelatedParentLineRef'
      Visible = False
      Size = 255
    end
    object QrySalesBatchRelatedManPQADetailsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ManPQADetailsId'
      Origin = 'tblsalesbatches.ManPQADetailsId'
      Visible = False
    end
    object QrySalesBatchRelatedProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductId'
      Origin = 'tblsalesbatches.ProductId'
      Visible = False
    end
    object QrySalesBatchRelatedSalesRelatedProductQty: TFloatField
      DisplayWidth = 10
      FieldName = 'SalesRelatedProductQty'
      Origin = 'tblsalesbatches.SalesRelatedProductQty'
      Visible = False
    end
    object QrySalesBatchRelatedmstimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimestamp'
      Origin = 'tblsalesbatches.mstimestamp'
      Visible = False
    end
    object QrySalesBatchRelatedmsupdatesitecode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msupdatesitecode'
      Origin = 'tblsalesbatches.msupdatesitecode'
      Visible = False
      Size = 3
    end
    object QrySalesBatchRelateddateCreated: TDateTimeField
      DisplayWidth = 18
      FieldName = 'dateCreated'
      Origin = 'tblsalesbatches.dateCreated'
      Visible = False
    end
    object QrySalesBatchRelatedUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblsalesbatches.UOMID'
      Visible = False
    end
    object QrySalesBatchRelatedUOMMult: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMMult'
      Origin = 'tblsalesbatches.UOMMult'
      Visible = False
    end
    object QrySalesBatchRelatedUOMWeight: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMWeight'
      LookupKeyFields = 'unitId'
      LookupResultField = 'weight'
      KeyFields = 'UOMID'
      Origin = 'tblsalesbatches.UOMWeight'
      Visible = False
    end
  end
  object QryUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select unitId , weight from tblunitsofmeasure U where U.UnitID =' +
        ' 1')
    BeforeOpen = QrySalesBatchRelatedBeforeOpen
    OnCalcFields = QrySalesBatchRelatedCalcFields
    Left = 244
    Top = 244
    object QryUOMunitId: TIntegerField
      FieldName = 'unitId'
    end
    object QryUOMweight: TFloatField
      FieldName = 'weight'
    end
    object QryUOMtotalWeight: TFloatField
      FieldKind = fkCalculated
      FieldName = 'totalWeight'
      Calculated = True
    end
  end
  object dsUOM: TDataSource
    DataSet = QryUOM
    Left = 243
    Top = 273
  end
  object dsPQA: TDataSource
    Left = 347
    Top = 273
  end
  object qrySales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select saleId, PONumber from tblsales where saleId= :SaleId')
    BeforeOpen = QrySalesBatchRelatedBeforeOpen
    OnCalcFields = QrySalesBatchRelatedCalcFields
    Left = 212
    Top = 244
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleId'
      end>
    object qrySalesPONumber: TWideStringField
      Alignment = taRightJustify
      FieldName = 'PONumber'
      Size = 30
    end
    object qrySalessaleId: TIntegerField
      FieldName = 'saleId'
    end
  end
  object dsSales: TDataSource
    DataSet = qrySales
    Left = 211
    Top = 273
  end
end
