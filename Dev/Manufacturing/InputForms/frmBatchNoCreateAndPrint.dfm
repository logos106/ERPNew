inherited fmBatchNoCreateAndPrint: TfmBatchNoCreateAndPrint
  Left = 695
  Top = 218
  HelpContext = 1269002
  Caption = 'Batch Number'
  ClientHeight = 465
  ClientWidth = 1006
  Position = poScreenCenter
  OnResize = FormResize
  ExplicitLeft = 695
  ExplicitTop = 218
  ExplicitWidth = 1022
  ExplicitHeight = 504
  DesignSize = (
    1006
    465)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 349
    Width = 1006
    HelpContext = 1269003
    ExplicitTop = 251
    ExplicitWidth = 505
  end
  inherited shapehint: TShape
    Left = 13
    ExplicitLeft = 13
  end
  inherited shapehintextra1: TShape
    Left = 55
    ExplicitLeft = 44
  end
  object lblBatchNo: TLabel [5]
    Left = 24
    Top = 119
    Width = 216
    Height = 37
    HelpContext = 1269004
    Alignment = taRightJustify
    Caption = 'Batch Number'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlbaseuom: TDNMPanel [6]
    Left = 8
    Top = 256
    Width = 545
    Height = 43
    HelpContext = 1269027
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object lblUnits: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 6
      Width = 135
      Height = 32
      HelpContext = 1269028
      Caption = 'Base UOM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtBOQty: TAdvEdit
      AlignWithMargins = True
      Left = 316
      Top = 1
      Width = 156
      Height = 40
      HelpContext = 1269016
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0.00'
      Visible = True
      OnChange = edtBOQtyChange
      Version = '2.8.6.9'
    end
    object edtQty: TAdvEdit
      AlignWithMargins = True
      Left = 146
      Top = 2
      Width = 156
      Height = 40
      HelpContext = 1269018
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0.00'
      Visible = True
      OnChange = edtQtyChange
      Version = '2.8.6.9'
    end
  end
  object DNMPanel5: TDNMPanel [7]
    Left = 6
    Top = 211
    Width = 992
    Height = 43
    HelpContext = 1269029
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      992
      43)
    object lblUOM: TLabel
      AlignWithMargins = True
      Left = 75
      Top = 3
      Width = 62
      Height = 32
      HelpContext = 1269030
      Alignment = taRightJustify
      Caption = 'UOM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object edtUOMQty: TAdvEdit
      AlignWithMargins = True
      Left = 146
      Top = 3
      Width = 156
      Height = 40
      HelpContext = 1269031
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0.00'
      Visible = True
      OnChange = edtUOMQtyChange
      Version = '2.8.6.9'
    end
    object edtUOMBOQty: TAdvEdit
      AlignWithMargins = True
      Left = 316
      Top = 3
      Width = 156
      Height = 40
      HelpContext = 1269032
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0.00'
      Visible = True
      OnChange = edtUOMBOQtyChange
      Version = '2.8.6.9'
    end
    object EdtPQACUSTFLD1: TAdvEdit
      AlignWithMargins = True
      Left = 486
      Top = 3
      Width = 156
      Height = 40
      HelpContext = 1269024
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0.00'
      Visible = True
      OnChange = EdtPQACUSTFLD1Change
      Version = '2.8.6.9'
    end
    object edtPQACUSTFLD4: TAdvEdit
      AlignWithMargins = True
      Left = 656
      Top = 3
      Width = 156
      Height = 40
      HelpContext = 1269042
      EditType = etNumeric
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '0'
      Visible = True
      OnChange = edtPQACUSTFLD4Change
      Version = '2.8.6.9'
    end
    object edtExpiryDate: TwwDBDateTimePicker
      Left = 826
      Top = 3
      Width = 156
      Height = 23
      HelpContext = 1269017
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      Date = 42685.000000000000000000
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
      OnChange = edtExpiryDateChange
    end
  end
  object DNMPanel4: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 1006
    Height = 73
    HelpContext = 1269033
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object pnlTitle: TDNMPanel
      AlignWithMargins = True
      Left = 342
      Top = 12
      Width = 321
      Height = 49
      HelpContext = 1269020
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 11
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 2
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 319
        Height = 47
        HelpContext = 1269021
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
          Width = 319
          Height = 47
          HelpContext = 1269022
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
          ExplicitTop = 1
        end
      end
    end
    object pnlSeqno: TDNMPanel
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 135
      Height = 49
      HelpContext = 1269034
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 11
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object edtSeqno: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 127
        Height = 41
        HelpContext = 1269035
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsNone
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
    object DNMPanel1: TDNMPanel
      AlignWithMargins = True
      Left = 859
      Top = 12
      Width = 135
      Height = 49
      HelpContext = 1269036
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 11
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
        Left = 1
        Top = 4
        Width = 51
        Height = 37
        HelpContext = 1269037
        Margins.Left = 0
        Align = alLeft
        Caption = ' No #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 24
      end
      object edtBatchSeqno: TEdit
        AlignWithMargins = True
        Left = 58
        Top = 4
        Width = 69
        Height = 37
        HelpContext = 1269038
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsNone
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
  object edtBatchNo: TEdit [9]
    Left = 257
    Top = 112
    Width = 741
    Height = 44
    HelpContext = 1269015
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'abcdefghijklmnopqrstuvwxyz'
    OnChange = edtBatchNoChange
  end
  object DNMPanel6: TDNMPanel [10]
    Left = 0
    Top = 349
    Width = 1006
    Height = 116
    HelpContext = 1269039
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      1006
      116)
    object cmdClose: TDNMSpeedButton
      Left = 156
      Top = 11
      Width = 165
      Height = 50
      HelpContext = 1269019
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
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
      TabOrder = 0
      OnClick = cmdCloseClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 420
      Top = 6
      Width = 165
      Height = 50
      Hint = '"Print The List"'
      HelpContext = 1269014
      Anchors = [akBottom]
      Caption = 'Prin&t'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
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
      OnClick = cmdPrintClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 685
      Top = 11
      Width = 165
      Height = 50
      HelpContext = 1269008
      Anchors = [akBottom]
      Cancel = True
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
      TabOrder = 2
      OnClick = cmdCancelClick
    end
    object pnlAdvPrinting: TDNMPanel
      Left = 245
      Top = 77
      Width = 516
      Height = 29
      HelpContext = 1269009
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 3
      Transparent = False
      object ChkChooseRpt: TCheckBox
        Left = 130
        Top = 1
        Width = 129
        Height = 27
        HelpContext = 1269012
        Align = alLeft
        Caption = 'Choose &Template'
        TabOrder = 1
      end
      object chkPreview: TCheckBox
        Left = 1
        Top = 1
        Width = 129
        Height = 27
        HelpContext = 1269013
        Align = alLeft
        Caption = 'Show Previe&w'
        TabOrder = 0
      end
      object chkShowBOQuantity: TCheckBox
        Left = 259
        Top = 1
        Width = 129
        Height = 27
        HelpContext = 1269043
        Align = alLeft
        Caption = 'Show BO Quantity'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = chkShowBOQuantityClick
      end
      object chkShowExpiry: TCheckBox
        Left = 388
        Top = 1
        Width = 129
        Height = 27
        HelpContext = 1269044
        Align = alLeft
        Caption = 'Show Expiry Date'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = chkShowExpiryClick
      end
    end
  end
  object pnlUOMDetails: TDNMPanel [11]
    Left = 5
    Top = 302
    Width = 545
    Height = 40
    HelpContext = 1269040
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object lblUOMDetails: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 539
      Height = 34
      HelpContext = 1269041
      Align = alClient
      Alignment = taCenter
      Caption = '1 UOM = X Base UOM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 278
      ExplicitHeight = 32
    end
  end
  object DNMPanel2: TDNMPanel [12]
    Left = 6
    Top = 173
    Width = 982
    Height = 38
    HelpContext = 1269025
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object lblExpiryDate: TLabel
      AlignWithMargins = True
      Left = 826
      Top = 3
      Width = 160
      Height = 32
      HelpContext = 1269005
      AutoSize = False
      Caption = 'Expiry Date'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object lblPQADEtailsCUSTFLD1: TLabel
      AlignWithMargins = True
      Left = 486
      Top = 3
      Width = 160
      Height = 32
      HelpContext = 1269023
      AutoSize = False
      Caption = 'CustFld1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 316
      Top = 3
      Width = 160
      Height = 32
      HelpContext = 1269007
      AutoSize = False
      Caption = 'BO Quantity'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 146
      Top = 3
      Width = 160
      Height = 32
      HelpContext = 1269006
      AutoSize = False
      Caption = 'Quantity'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object lblPQADEtailsCUSTFLD4: TLabel
      Left = 656
      Top = 6
      Width = 103
      Height = 29
      HelpContext = 1269045
      Caption = 'CustFld4'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 432
    Top = 8
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102001001400110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qrySales: TERPQuery
    SQL.Strings = (
      
        'select tblsaleslines.SaleLineID, tblsales.SaleID, tblsales.Custo' +
        'merName, tblsales.SaleDate, '
      
        'if(tblsales.IsInvoice = "T","Invoice", if(tblsales.IsSalesOrder=' +
        ' "T","Sales Order","Other")) as SaleType,'
      
        'tblsaleslines.ProductName, tblsaleslines.UnitofMeasureQtySold, t' +
        'blsaleslines.UnitofMeasureShipped, '
      
        'sum(IfNull(tblpqadetails.UOMQty,0)) as BatchQty, sum(IfNull(tblp' +
        'qadetails.BOUOMQty,0)) as BOBatchQty,'
      'tblsaleslines.BatchAllocated as Allocated'
      'from tblsales '
      
        'inner join tblsaleslines on tblsales.SaleID = tblsaleslines.Sale' +
        'ID'
      
        'inner join tblparts on tblparts.PARTSID = tblsaleslines.ProductI' +
        'D and tblparts.batch = "T" '
      
        'inner join tblpqa on tblsaleslines.SaleLineID = tblpqa.TransLine' +
        'ID and tblpqa.TransType in ("TSalesOrderLine","TInvoice")'
      
        'inner join tblproctree on tblproctree.SaleLineID = tblsaleslines' +
        '.SaleLineID'
      
        'left join tblpqadetails on tblpqadetails.PQAID = tblpqa.PQAID an' +
        'd tblpqadetails.PQAType = "Batch"'
      '/* where tblsaleslines.BatchAllocated = "F" */'
      'group by tblsaleslines.SaleLineID '
      'order by tblsales.CustomerName, tblsales.SaleID')
    Left = 368
    Top = 80
  end
end
