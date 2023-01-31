inherited fmProcProgress: TfmProcProgress
  Left = 562
  Top = 181
  HelpContext = 1455002
  Caption = 'Progress Build'
  ClientHeight = 672
  ClientWidth = 907
  ExplicitLeft = 562
  ExplicitTop = 181
  ExplicitWidth = 923
  ExplicitHeight = 711
  DesignSize = (
    907
    672)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 672
    Width = 907
    HelpContext = 1455003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 114
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
    Left = 243
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object pnlDetails: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 757
    Height = 672
    HelpContext = 1455004
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlSO: TDNMPanel
      Left = 0
      Top = 257
      Width = 757
      Height = 147
      HelpContext = 1455006
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
      object Label2: TLabel
        AlignWithMargins = True
        Left = 31
        Top = 11
        Width = 117
        Height = 29
        HelpContext = 1455007
        Margins.Left = 22
        Margins.Top = 11
        Margins.Bottom = 11
        Alignment = taRightJustify
        Caption = 'Order No :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label5: TLabel
        AlignWithMargins = True
        Left = 486
        Top = 95
        Width = 137
        Height = 29
        HelpContext = 1455008
        Margins.Left = 22
        Margins.Top = 11
        Margins.Bottom = 11
        Alignment = taRightJustify
        Caption = 'Remaining :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label4: TLabel
        AlignWithMargins = True
        Left = 32
        Top = 95
        Width = 116
        Height = 29
        HelpContext = 1455009
        Margins.Left = 22
        Margins.Top = 11
        Margins.Bottom = 11
        Alignment = taRightJustify
        Caption = 'Total Qty :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label8: TLabel
        AlignWithMargins = True
        Left = 320
        Top = 95
        Width = 75
        Height = 29
        HelpContext = 1455010
        Margins.Left = 22
        Margins.Top = 11
        Margins.Bottom = 11
        Alignment = taRightJustify
        Caption = 'Built : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 757
        Height = 1
        HelpContext = 1455011
        Align = alTop
        Pen.Color = clGray
        ExplicitLeft = 296
        ExplicitTop = -8
        ExplicitWidth = 65
      end
      object Label7: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 132
        Width = 721
        Height = 14
        HelpContext = 1455056
        Margins.Right = 33
        Margins.Bottom = 1
        Align = alBottom
        Alignment = taRightJustify
        Caption = 'Double Click for Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = edtQtyRemainingDblClick
        ExplicitLeft = 597
        ExplicitWidth = 127
      end
      object Label10: TLabel
        AlignWithMargins = True
        Left = 35
        Top = 53
        Width = 112
        Height = 29
        HelpContext = 1455058
        Margins.Left = 22
        Margins.Top = 11
        Margins.Bottom = 11
        Alignment = taRightJustify
        Caption = 'Product : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label11: TLabel
        AlignWithMargins = True
        Left = 408
        Top = 11
        Width = 128
        Height = 29
        HelpContext = 1455059
        Margins.Left = 22
        Margins.Top = 11
        Margins.Bottom = 11
        Alignment = taRightJustify
        Caption = 'Sale Date : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object DBText1: TDBEdit
        AlignWithMargins = True
        Left = 158
        Top = 7
        Width = 185
        Height = 37
        HelpContext = 1455012
        Margins.Top = 11
        Margins.Bottom = 11
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'SaleID'
        DataSource = dsSO
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtQtyRemaining: TEdit
        AlignWithMargins = True
        Left = 623
        Top = 91
        Width = 84
        Height = 37
        Hint = 'Double Click for the Details'
        HelpContext = 1455013
        Margins.Top = 11
        Margins.Bottom = 11
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        OnDblClick = edtQtyRemainingDblClick
      end
      object edtUnitofMeasureShipped: TDBEdit
        AlignWithMargins = True
        Left = 158
        Top = 91
        Width = 134
        Height = 37
        Hint = 'Double Click for the Details'
        HelpContext = 1455014
        Margins.Top = 11
        Margins.Bottom = 11
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'UnitofMeasureShipped'
        DataSource = dssaleslines
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        OnDblClick = edtUnitofMeasureShippedDblClick
      end
      object DBText7: TDBEdit
        AlignWithMargins = True
        Left = 158
        Top = 48
        Width = 549
        Height = 37
        HelpContext = 1455015
        Margins.Top = 11
        Margins.Bottom = 11
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'ProductName'
        DataSource = dssaleslines
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object DBText8: TDBEdit
        AlignWithMargins = True
        Left = 390
        Top = 91
        Width = 84
        Height = 37
        HelpContext = 1455016
        Margins.Top = 11
        Margins.Bottom = 11
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'ManufacturedUOMQty'
        DataSource = dsManQty
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object edtsaledatetime: TDBEdit
        AlignWithMargins = True
        Left = 544
        Top = 7
        Width = 163
        Height = 37
        HelpContext = 1455060
        Margins.Top = 11
        Margins.Bottom = 11
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'saledatetime'
        DataSource = dsSO
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
    end
    object pnlEmp: TDNMPanel
      Left = 0
      Top = 211
      Width = 757
      Height = 46
      HelpContext = 1455017
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
      object Label3: TLabel
        AlignWithMargins = True
        Left = 22
        Top = 11
        Width = 134
        Height = 29
        HelpContext = 1455018
        Margins.Left = 22
        Margins.Top = 11
        Margins.Bottom = 11
        Alignment = taRightJustify
        Caption = 'Employee : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 757
        Height = 1
        HelpContext = 1455019
        Align = alTop
        Pen.Color = clGray
        ExplicitLeft = 296
        ExplicitTop = -8
        ExplicitWidth = 65
      end
      object DBText2: TDBEdit
        AlignWithMargins = True
        Left = 158
        Top = 5
        Width = 549
        Height = 37
        HelpContext = 1455020
        Margins.Top = 9
        Margins.Right = 12
        Margins.Bottom = 9
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'EmployeeName'
        DataSource = dsemp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object pnlBatch: TDNMPanel
      Left = 0
      Top = 404
      Width = 757
      Height = 101
      HelpContext = 1455021
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
      object Shape3: TShape
        Left = 0
        Top = 0
        Width = 757
        Height = 1
        HelpContext = 1455022
        Align = alTop
        Pen.Color = clGray
        ExplicitTop = -3
        ExplicitWidth = 722
      end
      object Label6: TLabel
        AlignWithMargins = True
        Left = 67
        Top = 10
        Width = 80
        Height = 29
        HelpContext = 1455023
        Margins.Left = 22
        Alignment = taRightJustify
        Caption = 'Batch :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label9: TLabel
        AlignWithMargins = True
        Left = 25
        Top = 57
        Width = 122
        Height = 29
        HelpContext = 1455024
        Alignment = taRightJustify
        Caption = 'Allocated :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object DBText5: TDBEdit
        AlignWithMargins = True
        Left = 158
        Top = 6
        Width = 358
        Height = 37
        HelpContext = 1455025
        Margins.Left = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'Batchno'
        DataSource = dsBatchQty
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtAvailable: TDBEdit
        AlignWithMargins = True
        Left = 520
        Top = 53
        Width = 126
        Height = 37
        HelpContext = 1455026
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'totUOMQty'
        DataSource = dsBatchQty
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object edtAllocated: TDBEdit
        AlignWithMargins = True
        Left = 158
        Top = 53
        Width = 126
        Height = 37
        HelpContext = 1455027
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'AllocateduomQty'
        DataSource = dsBatchQty
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit3: TDBEdit
        AlignWithMargins = True
        Left = 290
        Top = 53
        Width = 225
        Height = 37
        HelpContext = 1455028
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = 14607076
        DataField = 'uom'
        DataSource = dsBatchQty
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object pnlBarcode: TDNMPanel
      Left = 0
      Top = 71
      Width = 757
      Height = 140
      HelpContext = 1455029
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 623
        Height = 140
        HelpContext = 1455030
        Align = alClient
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
          Left = 22
          Top = 3
          Width = 579
          Height = 29
          HelpContext = 1455031
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Caption = 'Scan Barcode'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 159
        end
        object lblOptions: TLabel
          Left = 0
          Top = 80
          Width = 623
          Height = 60
          HelpContext = 1455032
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = '(F9 for Options )'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitTop = 111
          ExplicitWidth = 596
        end
        object edtBarcode: TEdit
          AlignWithMargins = True
          Left = 22
          Top = 38
          Width = 589
          Height = 37
          HelpContext = 1455033
          Margins.Left = 22
          Margins.Right = 12
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnKeyDown = edtBarcodeKeyDown
          OnKeyPress = edtBarcodeKeyPress
        end
        object AdvGlowButton1: TAdvGlowButton
          AlignWithMargins = True
          Left = 3
          Top = 93
          Width = 617
          Height = 0
          HelpContext = 1455034
          Margins.Top = 15
          Margins.Bottom = 15
          Align = alClient
          Caption = 'Right'
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          TabOrder = 1
          Visible = False
          Appearance.Color = clGreen
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = clWhite
          Appearance.ColorDisabled = 15066597
          Appearance.ColorDisabledTo = 11599792
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirror = clGreen
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = clWhite
          Appearance.ColorMirrorDisabled = 15066597
          Appearance.ColorMirrorDisabledTo = 11599792
        end
      end
      object btnGreen: TAdvGlowButton
        AlignWithMargins = True
        Left = 693
        Top = 15
        Width = 61
        Height = 110
        HelpContext = 1455035
        Margins.Top = 15
        Margins.Bottom = 15
        Align = alRight
        Caption = 'Right'
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 1
        Visible = False
        Appearance.Color = clGreen
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = clWhite
        Appearance.ColorDisabled = 15066597
        Appearance.ColorDisabledTo = 11599792
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirror = clGreen
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = clWhite
        Appearance.ColorMirrorDisabled = 15066597
        Appearance.ColorMirrorDisabledTo = 11599792
      end
      object btnRed: TAdvGlowButton
        AlignWithMargins = True
        Left = 626
        Top = 15
        Width = 61
        Height = 110
        HelpContext = 1455036
        Margins.Top = 15
        Margins.Bottom = 15
        Align = alRight
        Caption = 'Wrong'
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 2
        Visible = False
        Appearance.Color = clRed
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = clWhite
        Appearance.ColorDisabled = 15066597
        Appearance.ColorDisabledTo = 11599792
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirror = clRed
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = clWhite
        Appearance.ColorMirrorDisabled = 15066597
        Appearance.ColorMirrorDisabledTo = 11599792
      end
    end
    object pnltop: TDNMPanel
      Left = 0
      Top = 0
      Width = 757
      Height = 71
      HelpContext = 1455038
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        757
        71)
      object pnlTitle: TDNMPanel
        Left = 202
        Top = 9
        Width = 354
        Height = 53
        HelpContext = 1455039
        Anchors = []
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
          Width = 350
          Height = 49
          HelpContext = 1455040
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
            Width = 350
            Height = 49
            HelpContext = 1455041
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Progress Build'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -37
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitTop = -1
            ExplicitWidth = 367
          end
        end
      end
    end
    object pnlFooter: TDNMPanel
      Left = 0
      Top = 556
      Width = 757
      Height = 116
      HelpContext = 1455037
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
  end
  object pnlButtons: TDNMPanel [6]
    Left = 757
    Top = 0
    Width = 150
    Height = 672
    HelpContext = 1455042
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 2
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  inherited tmrProcessMessage: TTimer
    Left = 100
    Top = 576
  end
  inherited tmrdelay: TTimer
    Left = 133
    Top = 576
  end
  inherited popSpelling: TPopupMenu
    Left = 265
    Top = 576
  end
  inherited tmrdelayMsg: TTimer
    Left = 166
    Top = 576
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 232
    Top = 576
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 397
    Top = 576
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 162
    Top = 511
  end
  inherited DataState: TDataState
    Left = 331
    Top = 576
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 430
    Top = 576
  end
  inherited imgsort: TImageList
    Left = 364
    Top = 576
    Bitmap = {
      494C010102009400E80210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 228
    Top = 512
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 463
    Top = 576
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 298
    Top = 576
  end
  inherited qryMemTrans: TERPQuery
    Left = 196
    Top = 512
  end
  object QrySO: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblsales')
    AfterOpen = QrySOAfterOpen
    Left = 289
    Top = 512
  end
  object dsSO: TDataSource
    DataSet = QrySO
    Left = 289
    Top = 544
  end
  object qrysaleslines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblsaleslines')
    AfterOpen = qrysaleslinesAfterOpen
    Left = 321
    Top = 512
  end
  object dssaleslines: TDataSource
    DataSet = qrysaleslines
    Left = 321
    Top = 544
  end
  object qryemp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblemployees')
    Left = 257
    Top = 512
  end
  object dsemp: TDataSource
    DataSet = qryemp
    Left = 257
    Top = 544
  end
  object TmrIndicator: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TmrIndicatorTimer
    Left = 199
    Top = 576
  end
  object dsManQty: TDataSource
    Left = 353
    Top = 544
  end
  object QryBatchQty: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select 1 as Seqno  ,PartsID , UOM,  Batchno ,  '
      
        'sum(if(Seqno=1, qty,0)) as qty , sum(if(Seqno=2, qty,0)) as Allo' +
        'catedqty ,   '
      
        'sum(if(Seqno=1, uomQty,0)) as uomQty , sum(if(Seqno=2, uomQty,0)' +
        ') as AllocateduomQty   from (SELECT 1 as Seqno ,P.PartsID,P.PART' +
        'NAME , PC.PreferredLevel,'
      'PQA.UOM,'
      'PQA.DepartmentID,PC.ClassName,'
      'PQABatch.Value as Batchno,'
      'PQABatch.ExpiryDate , '
      'PQABatch.TruckLoadNo , '
      
        'Round(Sum( if(PQA.TransType ="TSalesOrderInvoiceLines"  and PQA.' +
        'Active ="F" , 0, if(PQA.TransType ="TSalesOrderInvoiceLines"  an' +
        'd PQA.Active ="T" , ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> 0' +
        ' , PQABatch.Qty,PQA.Qty ),0),  if(PQA.Active ="F" and  PQA.alloc' +
        'type  ="IN" and PQA.TransType in ('#39'TProcTreePart'#39','#39'TProcTreePart' +
        'IN'#39'), ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> 0 , PQABatch.Qt' +
        'y,PQA.Qty ),0),  if((PQA.Active ="F") and  (not(PQA.TransType in' +
        ' ('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.TransType='#39'TProcT' +
        'reePart'#39') and (PQA.alloctype  ="IN")) ), 0,  if(PQA.TransType  i' +
        'n ('#39'TStockMovementLines'#39')  and PQA.Active ="T"  and PQA.alloctyp' +
        'e ="IN" , ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> 0 , PQABatc' +
        'h.Qty,PQA.Qty ),0) , if(PQA.TransType  in ('#39'TStockMovementLines'#39 +
        ')  and PQA.Active ="T"  and PQA.alloctype ="OUT" , 0-ifnull(if(i' +
        'fnull(PQABatch.PQAdetailID,0)<> 0 , PQABatch.Qty,PQA.Qty ),0) , ' +
        'if(PQA.TransType  in ("THireLines")    and PQA.alloctype  ="OUT"' +
        ' and PQA.Active ="T" , 0-ifnull(if(ifnull(PQABatch.PQAdetailID,0' +
        ')<> 0 , PQABatch.Qty,PQA.Qty ),0) , if(PQA.TransType  in ("THire' +
        'LinesIN")    and PQA.alloctype  ="IN" and PQA.Active ="T" , ifnu' +
        'll(if(ifnull(PQABatch.PQAdetailID,0)<> 0 , PQABatch.Qty,PQA.Qty ' +
        '),0) , if( PQA.alloctype ="IN" and  ifnull(PQA.IsBO , "F")="F", ' +
        'ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> 0 , PQABatch.Qty,PQA.' +
        'Qty ),0),  if(PQA.alloctype ="OUT" and (PQA.TransType<>'#39'TSalesOr' +
        'derLine'#39' or ifnull(PQA.IsBO , "F")="F") ,0-ifnull(if(ifnull(PQAB' +
        'atch.PQAdetailID,0)<> 0 , PQABatch.Qty,PQA.Qty ),0),0)))))))))))' +
        ',5) as Qty,'
      
        'Round(Sum( if(PQA.TransType ="TSalesOrderInvoiceLines"  and PQA.' +
        'Active ="F" , 0, if(PQA.TransType ="TSalesOrderInvoiceLines"  an' +
        'd PQA.Active ="T" , ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> 0' +
        ' , PQABatch.UOMQty,PQA.UOMQty ),0),  if(PQA.Active ="F" and  PQA' +
        '.alloctype  ="IN" and PQA.TransType in ('#39'TProcTreePart'#39','#39'TProcTr' +
        'eePartIN'#39'), ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> 0 , PQABa' +
        'tch.UOMQty,PQA.UOMQty ),0),  if((PQA.Active ="F") and  (not(PQA.' +
        'TransType in ('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.Trans' +
        'Type='#39'TProcTreePart'#39') and (PQA.alloctype  ="IN")) ), 0,  if(PQA.' +
        'TransType  in ('#39'TStockMovementLines'#39')  and PQA.Active ="T"  and ' +
        'PQA.alloctype ="IN" , ifnull(if(ifnull(PQABatch.PQAdetailID,0)<>' +
        ' 0 , PQABatch.UOMQty,PQA.UOMQty ),0) , if(PQA.TransType  in ('#39'TS' +
        'tockMovementLines'#39')  and PQA.Active ="T"  and PQA.alloctype ="OU' +
        'T" , 0-ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> 0 , PQABatch.U' +
        'OMQty,PQA.UOMQty ),0) , if(PQA.TransType  in ("THireLines")    a' +
        'nd PQA.alloctype  ="OUT" and PQA.Active ="T" , 0-ifnull(if(ifnul' +
        'l(PQABatch.PQAdetailID,0)<> 0 , PQABatch.UOMQty,PQA.UOMQty ),0) ' +
        ', if(PQA.TransType  in ("THireLinesIN")    and PQA.alloctype  ="' +
        'IN" and PQA.Active ="T" , ifnull(if(ifnull(PQABatch.PQAdetailID,' +
        '0)<> 0 , PQABatch.UOMQty,PQA.UOMQty ),0) , if( PQA.alloctype ="I' +
        'N" and  ifnull(PQA.IsBO , "F")="F", ifnull(if(ifnull(PQABatch.PQ' +
        'AdetailID,0)<> 0 , PQABatch.UOMQty,PQA.UOMQty ),0),  if(PQA.allo' +
        'ctype ="OUT" and (PQA.TransType<>'#39'TSalesOrderLine'#39' or ifnull(PQA' +
        '.IsBO , "F")="F") ,0-ifnull(if(ifnull(PQABatch.PQAdetailID,0)<> ' +
        '0 , PQABatch.UOMQty,PQA.UOMQty ),0),0))))))))))),5) as UOMQty'
      ' FROM `tblParts` as P'
      'inner join `tblPQA` as PQA on PQA.ProductId = P.PartsID '
      
        'and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F' +
        '") OR (PQA.PQAID in (Select PQAID from `tblPQADetails`)))'
      'inner join `tblclass` as C on PQA.departmentID = C.ClassID '
      
        'Inner join `tblProductClasses` as PC on PC.ProductID = PQA.Produ' +
        'ctID and PC.ClassID = PQA.departmentID'
      
        'left join `tblPqaDetails` PQABatch  on PQABatch.PQAId '#9'= PQA.PQA' +
        'ID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T"'
      ''
      
        ' Where P.active <>"F" and PC.ACtive <> "F" /*and PQA.active <> "' +
        'F"*/'
      'and PQA.DepartmentID = 1'
      'and PQA.ProductID =44'
      'and PQA.UOM = '#39'Units'#39
      
        '  and ((ifnull(P.Batch,"F") ="F") or (( PQABatch.value = '#39'PO-3-3' +
        '-1'#39')))'
      'group by P.PartsID, P.PARTNAME '
      ',UOM'
      ',DepartmentID'
      ',IFNULL( PQABatch.Value,"")'
      ',IFNULL( PQABatch.TruckLoadNo,"")'
      ',IFNULL( PQABatch.ExpiryDate,0)  '
      
        'union all   SELECT 2 as Seqno,  P.PartsID,  P.PARTNAME , null as' +
        ' PreferredLevel,  PQA.UOM,  PQA.DepartmentID,null as ClassName, ' +
        ' PQABatch.Value as Batchno,  PQABatch.ExpiryDate ,  PQABatch.Tru' +
        'ckLoadNo ,  Sum(PQABatch.qty) as Qty,  Sum(PQABatch.uomqty) as U' +
        'OMQty   FROM `tblParts` as P  inner join `tblPQA` as PQA on PQA.' +
        'ProductId = P.PartsID and PQA.transId = 1 and PQA.transLineId = ' +
        '258 and PQA.transtype = "TProcTreePart"   and PQA.alloctype ="OU' +
        'T"  inner join `tblPqaDetails` PQABatch  on PQABatch.PQAId '#9'= PQ' +
        'A.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Value ='#39'PO-' +
        '3-3-1'#39
      ') details'
      
        'union all   SELECT 2  as seqno , 0 as PartsID ,"" as UOM, '#39'PO-3-' +
        '3-1'#39' as Batchno, 0 as Qty, 0 as  Allocateqty , 0 as UOMQty , 0 a' +
        's AllocateuomQty order by seqno limit 1')
    OnCalcFields = QryBatchQtyCalcFields
    Left = 384
    Top = 514
    object QryBatchQtyBatchno: TWideStringField
      FieldName = 'Batchno'
      Origin = 'Batchno'
      Size = 100
    end
    object QryBatchQtyAllocatedqty: TFloatField
      FieldName = 'Allocatedqty'
      Origin = 'Allocatedqty'
    end
    object QryBatchQtyallocateduomQty: TFloatField
      FieldName = 'AllocateduomQty'
      Origin = 'AllocateduomQty'
    end
    object QryBatchQtySeqno: TLargeintField
      FieldName = 'Seqno'
      Origin = 'Seqno'
    end
    object QryBatchQtyPartsID: TLargeintField
      FieldName = 'PartsID'
      Origin = 'PartsID'
    end
    object QryBatchQtyqty: TFloatField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object QryBatchQtyuomQty: TFloatField
      FieldName = 'uomQty'
      Origin = 'uomQty'
    end
    object QryBatchQtyUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 50
    end
    object QryBatchQtytotUOMQty: TFloatField
      FieldKind = fkCalculated
      FieldName = 'totUOMQty'
      Calculated = True
    end
  end
  object dsBatchQty: TDataSource
    DataSet = QryBatchQty
    Left = 385
    Top = 544
  end
  object Actions: TActionList
    Left = 496
    Top = 576
    object actPrint: TDNMAction
      Caption = 'Print'
      HelpContext = 1455043
      Hint = 'This will Flag 1 Qty as Finished and will be available in Stock'
      ImageIndex = 744
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actHold: TDNMAction
      Caption = 'Hold'
      HelpContext = 1455044
      Hint = 'On Hold '
      ImageIndex = 241
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actWaste: TDNMAction
      Caption = 'Waste'
      HelpContext = 1455045
      Hint = 'Build 1 stock and Flag as Wasted'
      ImageIndex = 208
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actSave: TDNMAction
      Caption = 'Save'
      HelpContext = 1455046
      Hint = 'Save'
      ImageIndex = 394
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actclose: TDNMAction
      Caption = 'Close'
      HelpContext = 1455047
      Hint = 'close'
      ImageIndex = 238
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actFinalise: TDNMAction
      Caption = 'Finalise'
      HelpContext = 1455061
      Hint = 'Finalise and Convert The Order'
      ImageIndex = 240
      OnExecute = DoSomething
      buttoncolor = clWhite
    end
    object actRePrint: TDNMAction
      Caption = 'Reprint'
      ImageIndex = 242
      OnExecute = DoSomething
      buttoncolor = clWhite
      HelpContext = 1455062
    end
    object actHelp: TDNMAction
      Caption = 'How To'
      HelpContext = 1455048
      ImageIndex = 501
      OnExecute = actHelpExecute
      buttoncolor = clWhite
    end
    object actsales: TDNMAction
      Caption = 'Jobs'
      HelpContext = 1455057
      Hint = 'Jobs'
      ImageIndex = 225
      OnExecute = actsalesExecute
      buttoncolor = clWhite
    end
    object actBatches: TDNMAction
      Caption = 'Batches'
      HelpContext = 1455049
      Hint = 'Batches'
      ImageIndex = 37
      OnExecute = actBatchesExecute
      buttoncolor = clWhite
    end
    object actReport: TDNMAction
      Caption = 'Report'
      HelpContext = 1455050
      Hint = 'Report'
      ImageIndex = 141
      OnExecute = actReportExecute
      buttoncolor = clWhite
    end
    object actOnHold: TDNMAction
      Caption = 'On Hold Product(s)'
      HelpContext = 1455051
      Hint = 'On Hold Product(s)'
      ImageIndex = 47
      OnExecute = actOnHoldExecute
      buttoncolor = clWhite
    end
    object actPQAList: TDNMAction
      Caption = 'PQA List'
      HelpContext = 1455052
      Hint = 'PQA List by Category'
      ImageIndex = 215
      OnExecute = actPQAListExecute
      buttoncolor = clWhite
    end
    object actOpenSO: TDNMAction
      Caption = 'Open Sale'
      HelpContext = 1455053
      Hint = 'Open the Sales Order'
      ImageIndex = 226
      OnExecute = actOpenSOExecute
      buttoncolor = clWhite
    end
    object actAllocation: TDNMAction
      Caption = 'Allocation'
      HelpContext = 1455054
      ImageIndex = 377
      OnExecute = actAllocationExecute
      buttoncolor = clWhite
    end
    object actRemBatch: TDNMAction
      Caption = 'Remove Batches'
      HelpContext = 1455055
      Hint = 'Un Assign Batches'
      ImageIndex = 658
      OnExecute = actRemBatchExecute
      buttoncolor = clWhite
    end
  end
  object QrySerialNumber: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select'
      'PPT.ProcTreeID, PT.proctreeId, PTP.ProctreePartID'
      'from tblsales S'
      'inner join tblsaleslines SL on S.saleId = SL.saleId '
      
        'inner join tblproctree PT on PT.masterId = SL.saleLineId and PT.' +
        'mastertype <> "mtProduct"'
      'inner join tblProcTree PPT on PT.parentID = PPT.proctreeId'
      
        'inner join tblProcTreePart PTP on PT.procTreEId = PTP.proctreeId' +
        ' '
      
        'inner join tblpqa pqa on pqa.TransLineID = PTP.ProctreePartId an' +
        'd PQA.transtype = "TProcTreePart"'
      
        'inner join tblpqadetails pqasn on pqa.pqaid = pqasn.pqaid and pq' +
        'asn.PQAType ="SN"'
      'Where pqasn.value ="5-0002"')
    OnCalcFields = QryBatchQtyCalcFields
    Left = 416
    Top = 514
    object WideStringField1: TWideStringField
      FieldName = 'Batchno'
      Origin = 'Batchno'
      Size = 100
    end
    object FloatField1: TFloatField
      FieldName = 'Allocatedqty'
      Origin = 'Allocatedqty'
    end
    object FloatField2: TFloatField
      FieldName = 'AllocateduomQty'
      Origin = 'AllocateduomQty'
    end
    object LargeintField1: TLargeintField
      FieldName = 'Seqno'
      Origin = 'Seqno'
    end
    object LargeintField2: TLargeintField
      FieldName = 'PartsID'
      Origin = 'PartsID'
    end
    object FloatField3: TFloatField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FloatField4: TFloatField
      FieldName = 'uomQty'
      Origin = 'uomQty'
    end
    object WideStringField2: TWideStringField
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 50
    end
    object FloatField5: TFloatField
      FieldKind = fkCalculated
      FieldName = 'totUOMQty'
      Calculated = True
    end
  end
  object dsSerialNumber: TDataSource
    DataSet = QrySerialNumber
    Left = 417
    Top = 544
  end
  object dsPPG_SN_forBuildStatus: TDataSource
    DataSet = qryPPG_SN_forBuildStatus
    Left = 449
    Top = 544
  end
  object qryPPG_SN_forBuildStatus: TERPQuery
    Connection = MyConnection
    Left = 448
    Top = 517
  end
end
