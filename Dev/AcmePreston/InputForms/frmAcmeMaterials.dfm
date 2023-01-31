inherited AcmeInputGUI: TAcmeInputGUI
  Left = 101
  Top = 188
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Custom Printing'
  ClientHeight = 524
  ClientWidth = 968
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Label12: TLabel [0]
    Left = -712
    Top = 288
    Width = 27
    Height = 15
    Caption = 'Item:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label92: TLabel [1]
    Left = 317
    Top = 84
    Width = 80
    Height = 15
    Alignment = taRightJustify
    Caption = 'Mach. Cost/Hr:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label93: TLabel [2]
    Left = 465
    Top = 84
    Width = 80
    Height = 15
    Alignment = taRightJustify
    Caption = 'Mach. Cost/Hr:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object pnlHeader: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 968
    Height = 837
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      968
      837)
    object btnCompleted: TDNMSpeedButton
      Left = 1597
      Top = 38
      Width = 87
      Height = 27
      Anchors = [akTop, akRight]
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      TabOrder = 1
      TabStop = False
    end
    object btnClose: TDNMSpeedButton
      Left = 1597
      Top = 71
      Width = 87
      Height = 27
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      TabOrder = 0
      TabStop = False
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 56
      Width = 872
      Height = 465
      ActivePage = tabMaterial
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabIndex = 0
      TabOrder = 2
      TabWidth = 434
      object tabMaterial: TTabSheet
        Caption = '&Material Calculation'
        ImageIndex = 1
        object DNMPanel1: TDNMPanel
          Left = 0
          Top = 0
          Width = 865
          Height = 435
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            865
            435)
          object Label1: TLabel
            Left = 4
            Top = 20
            Width = 28
            Height = 15
            Caption = 'Item:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 168
            Top = 20
            Width = 32
            Height = 15
            Caption = 'Units:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label3: TLabel
            Left = 390
            Top = 20
            Width = 22
            Height = 15
            Caption = 'Qty:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label4: TLabel
            Left = 550
            Top = 20
            Width = 37
            Height = 15
            Caption = 'Overs:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label5: TLabel
            Left = 4
            Top = 80
            Width = 45
            Height = 15
            Alignment = taRightJustify
            Caption = 'Fin W-L:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label6: TLabel
            Left = 0
            Top = 104
            Width = 49
            Height = 15
            Alignment = taRightJustify
            Caption = 'Grip/Lay:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 2
            Top = 128
            Width = 47
            Height = 15
            Alignment = taRightJustify
            Caption = 'Sht W/L:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label8: TLabel
            Left = 15
            Top = 152
            Width = 34
            Height = 15
            Alignment = taRightJustify
            Caption = 'Mat 2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label9: TLabel
            Left = 15
            Top = 176
            Width = 34
            Height = 15
            Alignment = taRightJustify
            Caption = 'Mat 3:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label10: TLabel
            Left = 2
            Top = 200
            Width = 47
            Height = 15
            Alignment = taRightJustify
            Caption = 'Board 4:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label11: TLabel
            Left = 39
            Top = 224
            Width = 10
            Height = 15
            Alignment = taRightJustify
            Caption = '5:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label16: TLabel
            Left = 39
            Top = 248
            Width = 10
            Height = 15
            Alignment = taRightJustify
            Caption = '6:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label19: TLabel
            Left = 56
            Top = 60
            Width = 33
            Height = 15
            Alignment = taCenter
            Caption = 'Width'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label20: TLabel
            Left = 112
            Top = 60
            Width = 39
            Height = 15
            Alignment = taCenter
            Caption = 'Length'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label18: TLabel
            Left = 55
            Top = 272
            Width = 30
            Height = 15
            Alignment = taRightJustify
            Caption = 'Area:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label17: TLabel
            Left = 56
            Top = 328
            Width = 109
            Height = 22
            Caption = 'PRE PRESS'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label13: TLabel
            Left = 20
            Top = 364
            Width = 55
            Height = 15
            Alignment = taRightJustify
            Caption = 'Film Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label14: TLabel
            Left = 2
            Top = 388
            Width = 73
            Height = 15
            Alignment = taRightJustify
            Caption = 'Tooling Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label15: TLabel
            Left = 24
            Top = 412
            Width = 49
            Height = 15
            Alignment = taRightJustify
            Caption = 'Art Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label31: TLabel
            Left = 154
            Top = 364
            Width = 71
            Height = 15
            Alignment = taRightJustify
            Caption = 'Unit Cost Ex:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label32: TLabel
            Left = 151
            Top = 388
            Width = 74
            Height = 15
            Alignment = taRightJustify
            Caption = 'Unit Cost Inc:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label34: TLabel
            Left = 306
            Top = 364
            Width = 23
            Height = 15
            Alignment = taRightJustify
            Caption = 'SAY'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label33: TLabel
            Left = 306
            Top = 388
            Width = 23
            Height = 15
            Alignment = taRightJustify
            Caption = 'SAY'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label49: TLabel
            Left = 305
            Top = 320
            Width = 94
            Height = 15
            Alignment = taCenter
            Caption = 'Total Work Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label45: TLabel
            Left = 330
            Top = 296
            Width = 69
            Height = 15
            Alignment = taCenter
            Caption = 'Other Metal:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label43: TLabel
            Left = 355
            Top = 276
            Width = 44
            Height = 15
            Alignment = taCenter
            Caption = 'Metal 2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label42: TLabel
            Left = 365
            Top = 248
            Width = 34
            Height = 15
            Alignment = taCenter
            Caption = 'Metal:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label41: TLabel
            Left = 345
            Top = 224
            Width = 52
            Height = 15
            Alignment = taCenter
            Caption = 'Ink Code:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label40: TLabel
            Left = 387
            Top = 200
            Width = 10
            Height = 15
            Alignment = taCenter
            Caption = '6:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label39: TLabel
            Left = 387
            Top = 176
            Width = 10
            Height = 15
            Alignment = taCenter
            Caption = '5:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label38: TLabel
            Left = 351
            Top = 152
            Width = 47
            Height = 15
            Alignment = taCenter
            Caption = 'Board 4:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label37: TLabel
            Left = 341
            Top = 128
            Width = 59
            Height = 15
            Alignment = taCenter
            Caption = 'Material 3:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label36: TLabel
            Left = 341
            Top = 104
            Width = 59
            Height = 15
            Alignment = taCenter
            Caption = 'Material 2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label35: TLabel
            Left = 404
            Top = 60
            Width = 46
            Height = 15
            Alignment = taCenter
            Caption = 'Material'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object NumUpWxl: TLabel
            Left = 323
            Top = 80
            Width = 3
            Height = 15
            Alignment = taCenter
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label29: TLabel
            Left = 316
            Top = 80
            Width = 9
            Height = 19
            Alignment = taCenter
            Caption = '='
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label28: TLabel
            Left = 208
            Top = 60
            Width = 72
            Height = 15
            Alignment = taCenter
            Caption = 'Num up WxL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label21: TLabel
            Left = 228
            Top = 104
            Width = 25
            Height = 15
            Caption = 'Gap:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label27: TLabel
            Left = 210
            Top = 128
            Width = 45
            Height = 15
            Caption = 'Items 1:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label26: TLabel
            Left = 210
            Top = 152
            Width = 45
            Height = 15
            Caption = 'Items 2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label25: TLabel
            Left = 210
            Top = 176
            Width = 45
            Height = 15
            Caption = 'Items 3:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label24: TLabel
            Left = 210
            Top = 200
            Width = 45
            Height = 15
            Caption = 'Items 4:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label23: TLabel
            Left = 210
            Top = 224
            Width = 45
            Height = 15
            Caption = 'Items 5:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label22: TLabel
            Left = 210
            Top = 248
            Width = 45
            Height = 15
            Caption = 'Items 6:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label99: TLabel
            Left = 208
            Top = 276
            Width = 46
            Height = 15
            Caption = 'Inked %:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label53: TLabel
            Left = 575
            Top = 392
            Width = 174
            Height = 15
            Alignment = taCenter
            Caption = 'TOTAL incl. PrePress and GST:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label52: TLabel
            Left = 587
            Top = 368
            Width = 162
            Height = 15
            Alignment = taCenter
            Caption = 'GST on TOTAL + PRE PRESS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label51: TLabel
            Left = 543
            Top = 344
            Width = 140
            Height = 15
            Alignment = taCenter
            Caption = 'Total exTax exPrePress:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label50: TLabel
            Left = 545
            Top = 320
            Width = 139
            Height = 15
            Alignment = taCenter
            Caption = 'Total Materials incl. 10%:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label54: TLabel
            Left = 769
            Top = 320
            Width = 60
            Height = 15
            Alignment = taCenter
            Caption = 'SAY PRICE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label48: TLabel
            Left = 693
            Top = 60
            Width = 57
            Height = 15
            Alignment = taCenter
            Caption = 'Total Cost'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label47: TLabel
            Left = 631
            Top = 44
            Width = 60
            Height = 30
            Alignment = taCenter
            Caption = 'Num Rolls or Sheets'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label46: TLabel
            Left = 581
            Top = 44
            Width = 44
            Height = 30
            Alignment = taCenter
            Caption = 'Qty/ Roll-Sht'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label44: TLabel
            Left = 506
            Top = 60
            Width = 30
            Height = 15
            Alignment = taCenter
            Caption = 'Price'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label55: TLabel
            Left = 773
            Top = 264
            Width = 36
            Height = 15
            Alignment = taCenter
            Caption = 'Tax %:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label56: TLabel
            Left = 772
            Top = 220
            Width = 58
            Height = 15
            Alignment = taCenter
            Caption = 'Markup %:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label57: TLabel
            Left = 772
            Top = 157
            Width = 49
            Height = 45
            Alignment = taCenter
            Caption = 'Material Markup %:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object LblNum_UPT: TLabel
            Left = 332
            Top = 80
            Width = 45
            Height = 19
            Alignment = taCenter
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Key: TEdit
            Left = 36
            Top = 16
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0'
            OnChange = IsDirty
          end
          object Qty: TEdit
            Left = 212
            Top = 16
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = EnableDisableCalcBtns
          end
          object Qty_Qt: TEdit
            Left = 420
            Top = 16
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = IsDirty
          end
          object Overs: TEdit
            Left = 588
            Top = 16
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = IsDirty
          end
          object Brd_Size_W3: TEdit
            Left = 52
            Top = 244
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 31
            OnChange = IsDirty
          end
          object Brd_Size_W2: TEdit
            Left = 52
            Top = 220
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 27
            OnChange = IsDirty
          end
          object Brd_Size_W1: TEdit
            Left = 52
            Top = 196
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 23
            OnChange = IsDirty
          end
          object Size3_WC: TEdit
            Left = 52
            Top = 172
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 19
            OnChange = IsDirty
          end
          object Size2_WC: TEdit
            Left = 52
            Top = 148
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
            OnChange = IsDirty
          end
          object Size1_WC: TEdit
            Left = 52
            Top = 124
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            OnChange = IsDirty
            OnEnter = Size_WC_Enter
          end
          object Grip: TEdit
            Left = 52
            Top = 100
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnChange = IsDirty
          end
          object Size1_WF: TEdit
            Left = 52
            Top = 76
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = IsDirty
          end
          object Size1_LF: TEdit
            Left = 112
            Top = 76
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = IsDirty
          end
          object Lay: TEdit
            Left = 112
            Top = 100
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            OnChange = IsDirty
          end
          object Size1_LC: TEdit
            Left = 112
            Top = 124
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            OnChange = IsDirty
            OnEnter = Size_LC_Enter
          end
          object Size2_LC: TEdit
            Left = 112
            Top = 148
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
            OnChange = IsDirty
          end
          object Size3_LC: TEdit
            Left = 112
            Top = 172
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 20
            OnChange = IsDirty
          end
          object Brd_Size_L1: TEdit
            Left = 112
            Top = 196
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 24
            OnChange = IsDirty
          end
          object Brd_Size_L2: TEdit
            Left = 112
            Top = 220
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 28
            OnChange = IsDirty
          end
          object Brd_Size_L3: TEdit
            Left = 112
            Top = 244
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 32
            OnChange = IsDirty
          end
          object Area: TEdit
            Left = 88
            Top = 268
            Width = 65
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 35
            OnChange = IsDirty
          end
          object Cost_Art: TEdit
            Left = 76
            Top = 408
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 46
            OnChange = IsDirty
          end
          object Cost_Tooling: TEdit
            Left = 76
            Top = 384
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 45
            OnChange = IsDirty
          end
          object Cost_Film: TEdit
            Left = 76
            Top = 360
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 44
            OnChange = IsDirty
          end
          object Unit_Cost_Inc: TEdit
            Left = 228
            Top = 384
            Width = 70
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 49
            OnChange = IsDirty
          end
          object Unit_Cost_Ex: TEdit
            Left = 228
            Top = 360
            Width = 70
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 47
            OnChange = IsDirty
          end
          object Unit_Cost_Ex_S: TEdit
            Left = 332
            Top = 360
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 48
            OnChange = IsDirty
            OnExit = Unit_Cost_Ex_S_OnExit
          end
          object Unit_Cost_Inc_S: TEdit
            Left = 332
            Top = 384
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 50
            OnChange = IsDirty
          end
          object Other_Material: TEdit
            Left = 400
            Top = 292
            Width = 289
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 40
            OnChange = IsDirty
          end
          object Work_Tot_Cost: TEdit
            Left = 400
            Top = 316
            Width = 97
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 82
            OnChange = IsDirty
          end
          object NUM_UPL: TEdit
            Left = 256
            Top = 76
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnChange = UpdateLabel
          end
          object NUM_UPW: TEdit
            Left = 196
            Top = 76
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = UpdateLabel
          end
          object Gap: TEdit
            Left = 256
            Top = 100
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            OnChange = IsDirty
          end
          object Qty1: TEdit
            Left = 256
            Top = 124
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            OnChange = IsDirty
          end
          object Qty2: TEdit
            Left = 256
            Top = 148
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
            OnChange = IsDirty
          end
          object Qty3: TEdit
            Left = 256
            Top = 172
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 21
            OnChange = IsDirty
          end
          object Brd_Qty1: TEdit
            Left = 256
            Top = 196
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 25
            OnChange = IsDirty
          end
          object Brd_Qty2: TEdit
            Left = 256
            Top = 220
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 29
            OnChange = IsDirty
          end
          object Brd_Qty3: TEdit
            Left = 256
            Top = 244
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 33
            OnChange = IsDirty
          end
          object Inked_PC: TEdit
            Left = 256
            Top = 268
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 36
            OnChange = IsDirty
          end
          object Total_ExTax: TEdit
            Left = 692
            Top = 340
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 84
          end
          object Mat_Tot_Cost: TEdit
            Left = 692
            Top = 316
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 83
          end
          object Total_ExTax_S: TEdit
            Left = 764
            Top = 340
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 85
          end
          object Tax_Amount_S: TEdit
            Left = 764
            Top = 364
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 86
          end
          object Total_Inc_S: TEdit
            Left = 764
            Top = 388
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 87
          end
          object Other_Mat_Cost: TEdit
            Left = 692
            Top = 292
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 81
          end
          object MetalTotalCost2: TEdit
            Left = 692
            Top = 268
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 80
          end
          object MetalTotalCost1: TEdit
            Left = 692
            Top = 244
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 78
          end
          object Ink_Tot_Cost: TEdit
            Left = 692
            Top = 220
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 76
          end
          object Brd_Tot_Cost3: TEdit
            Left = 692
            Top = 196
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 74
          end
          object Brd_Tot_Cost2: TEdit
            Left = 692
            Top = 172
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 70
          end
          object Brd_Tot_Cost1: TEdit
            Left = 692
            Top = 148
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 66
          end
          object Tot_Cost3: TEdit
            Left = 692
            Top = 124
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 62
          end
          object Tot_Cost2: TEdit
            Left = 692
            Top = 100
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 58
          end
          object Tot_Cost1: TEdit
            Left = 692
            Top = 76
            Width = 70
            Height = 23
            TabStop = False
            Color = clScrollBar
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 54
          end
          object Price1: TEdit
            Left = 504
            Top = 76
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 51
          end
          object Price2: TEdit
            Left = 504
            Top = 100
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 55
          end
          object Price3: TEdit
            Left = 504
            Top = 124
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 59
          end
          object Brd_Price1: TEdit
            Left = 504
            Top = 148
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 63
          end
          object Brd_Price2: TEdit
            Left = 504
            Top = 172
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 67
          end
          object Brd_Price3: TEdit
            Left = 504
            Top = 196
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 71
          end
          object Ink_Price: TEdit
            Left = 504
            Top = 220
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 75
          end
          object Metal_Price1: TEdit
            Left = 504
            Top = 244
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 77
          end
          object Metal_Price2: TEdit
            Left = 504
            Top = 268
            Width = 65
            Height = 23
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 79
          end
          object Brd_Unit3: TEdit
            Left = 572
            Top = 196
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 72
            OnChange = IsDirty
          end
          object Brd_Unit2: TEdit
            Left = 572
            Top = 172
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 68
            OnChange = IsDirty
          end
          object Brd_Unit1: TEdit
            Left = 572
            Top = 148
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 64
            OnChange = IsDirty
          end
          object Qty_Unit3: TEdit
            Left = 572
            Top = 124
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 60
            OnChange = IsDirty
          end
          object Qty_Unit2: TEdit
            Left = 572
            Top = 100
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 56
            OnChange = IsDirty
          end
          object Qty_Unit1: TEdit
            Left = 572
            Top = 76
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 52
            OnChange = IsDirty
          end
          object Stk_Qty1: TEdit
            Left = 632
            Top = 76
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 53
            OnChange = IsDirty
          end
          object Stk_Qty2: TEdit
            Left = 632
            Top = 100
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 57
            OnChange = IsDirty
          end
          object Stk_Qty3: TEdit
            Left = 632
            Top = 124
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 61
            OnChange = IsDirty
          end
          object Brd_Stk1: TEdit
            Left = 632
            Top = 148
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 65
            OnChange = IsDirty
          end
          object Brd_Stk2: TEdit
            Left = 632
            Top = 172
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 69
            OnChange = IsDirty
          end
          object Brd_Stk3: TEdit
            Left = 632
            Top = 196
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 73
            OnChange = IsDirty
          end
          object Markup_Tax: TEdit
            Left = 772
            Top = 280
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 43
            OnChange = IsDirty
          end
          object Markup_PC: TEdit
            Left = 772
            Top = 236
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 42
            OnChange = IsDirty
          end
          object Mat_Markup_PC: TEdit
            Left = 772
            Top = 188
            Width = 57
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 41
            OnChange = IsDirty
          end
          object BitBtn3: TDNMSpeedButton
            Left = 775
            Top = 59
            Width = 87
            Height = 27
            Anchors = [akTop, akRight]
            Cancel = True
            Caption = '&Total Calc'
            DisableTransparent = False
            Enabled = False
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
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 90
            TabStop = False
            OnClick = BitBtn3Click
          end
          object BitBtn2: TDNMSpeedButton
            Left = 775
            Top = 31
            Width = 87
            Height = 27
            Anchors = [akTop, akRight]
            Cancel = True
            Caption = 'M&aterial Calc'
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
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 89
            TabStop = False
            OnClick = BitBtn2Click
          end
          object BitBtn1: TDNMSpeedButton
            Left = 775
            Top = 3
            Width = 87
            Height = 27
            Anchors = [akTop, akRight]
            Cancel = True
            Caption = 'Price &Update'
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
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 88
            TabStop = False
            OnClick = BitBtn1Click
          end
          object Metal_Code1: TwwDBComboBox
            Left = 401
            Top = 244
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 38
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = Metal_Code1_OnExit
          end
          object Metal_Code2: TwwDBComboBox
            Left = 401
            Top = 268
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 39
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = Metal_Code2_OnExit
          end
          object Ink_Code: TwwDBComboBox
            Left = 401
            Top = 220
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 37
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = Ink_Code_OnExit
          end
          object Brd_Code3: TwwDBComboBox
            Left = 401
            Top = 196
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 34
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = Brd_Code3_OnExit
          end
          object Brd_Code2: TwwDBComboBox
            Left = 401
            Top = 172
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 30
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = Brd_Code2_OnExit
          end
          object Brd_Code1: TwwDBComboBox
            Left = 401
            Top = 148
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 26
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = Brd_Code1_OnExit
          end
          object MT_Key3: TwwDBComboBox
            Left = 401
            Top = 124
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 22
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = MT_Key3_OnExit
          end
          object MT_Key2: TwwDBComboBox
            Left = 401
            Top = 100
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 18
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = MT_Key2_OnExit
          end
          object MT_Key1: TwwDBComboBox
            Left = 401
            Top = 76
            Width = 100
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DropDownCount = 8
            DropDownWidth = 350
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = False
            TabOrder = 14
            UnboundDataType = wwDefault
            OnChange = IsDirty
            OnExit = MT_Key1_OnExit
          end
        end
      end
      object tabProduction: TTabSheet
        Caption = '&Production'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ImageIndex = 1
        ParentFont = False
        OnEnter = tabProductionEnter
        object DNMPanel2: TDNMPanel
          Left = 0
          Top = 0
          Width = 861
          Height = 435
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = IsDirty
          DesignSize = (
            861
            435)
          object Label90: TLabel
            Left = 43
            Top = 16
            Width = 50
            Height = 15
            Alignment = taRightJustify
            Caption = 'Quantity:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label96: TLabel
            Left = 15
            Top = 44
            Width = 34
            Height = 15
            Alignment = taRightJustify
            Caption = 'Overs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label97: TLabel
            Left = 130
            Top = 44
            Width = 47
            Height = 15
            Alignment = taRightJustify
            Caption = 'Num. Up'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label91: TLabel
            Left = 175
            Top = 16
            Width = 74
            Height = 15
            Alignment = taRightJustify
            Caption = 'Item per unit:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label94: TLabel
            Left = 327
            Top = 16
            Width = 74
            Height = 15
            Alignment = taRightJustify
            Caption = 'Lay of Board:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label95: TLabel
            Left = 529
            Top = 16
            Width = 60
            Height = 15
            Alignment = taRightJustify
            Caption = 'Qty Rivets:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label82: TLabel
            Left = 435
            Top = 156
            Width = 94
            Height = 15
            Alignment = taRightJustify
            Caption = 'Total Work Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label89: TLabel
            Left = 425
            Top = 216
            Width = 36
            Height = 15
            Alignment = taRightJustify
            Caption = 'Notes:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label76: TLabel
            Left = 344
            Top = 384
            Width = 77
            Height = 15
            Alignment = taRightJustify
            Caption = 'Sub Contract:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label75: TLabel
            Left = 344
            Top = 360
            Width = 77
            Height = 15
            Alignment = taRightJustify
            Caption = 'Delivery Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label74: TLabel
            Left = 358
            Top = 336
            Width = 63
            Height = 15
            Alignment = taRightJustify
            Caption = 'Packaging:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label83: TLabel
            Left = 265
            Top = 304
            Width = 60
            Height = 15
            Alignment = taRightJustify
            Caption = 'Rivet Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label84: TLabel
            Left = 233
            Top = 280
            Width = 92
            Height = 15
            Alignment = taRightJustify
            Caption = 'Total Weld Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label85: TLabel
            Left = 235
            Top = 256
            Width = 90
            Height = 15
            Alignment = taRightJustify
            Caption = 'Post Weld Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label86: TLabel
            Left = 240
            Top = 232
            Width = 85
            Height = 15
            Alignment = taRightJustify
            Caption = 'Welding Costs:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label87: TLabel
            Left = 221
            Top = 208
            Width = 104
            Height = 15
            Alignment = taRightJustify
            Caption = 'Machine Cost/Day:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label88: TLabel
            Left = 232
            Top = 184
            Width = 93
            Height = 15
            Alignment = taRightJustify
            Caption = 'Main Welds/Day:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label81: TLabel
            Left = 259
            Top = 160
            Width = 66
            Height = 15
            Alignment = taRightJustify
            Caption = 'Number Up:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label80: TLabel
            Left = 241
            Top = 136
            Width = 84
            Height = 15
            Alignment = taRightJustify
            Caption = 'Pre Weld Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label79: TLabel
            Left = 245
            Top = 112
            Width = 80
            Height = 15
            Alignment = taRightJustify
            Caption = 'Board Cutting:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label78: TLabel
            Left = 255
            Top = 88
            Width = 70
            Height = 15
            Alignment = taRightJustify
            Caption = 'PVC Cutting:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label77: TLabel
            Left = 260
            Top = 64
            Width = 65
            Height = 15
            Alignment = taRightJustify
            Caption = 'Setup Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label71: TLabel
            Left = 200
            Top = 336
            Width = 53
            Height = 15
            Alignment = taRightJustify
            Caption = 'Back Slit:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label72: TLabel
            Left = 187
            Top = 360
            Width = 66
            Height = 15
            Alignment = taRightJustify
            Caption = 'Hand Work:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label73: TLabel
            Left = 198
            Top = 384
            Width = 55
            Height = 15
            Alignment = taRightJustify
            Caption = 'Guillotine:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label70: TLabel
            Left = 31
            Top = 384
            Width = 74
            Height = 15
            Alignment = taRightJustify
            Caption = 'Total Die Cut:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label69: TLabel
            Left = 58
            Top = 360
            Width = 47
            Height = 15
            Alignment = taRightJustify
            Caption = 'Imps/Hr:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label68: TLabel
            Left = 46
            Top = 336
            Width = 59
            Height = 15
            Alignment = taRightJustify
            Caption = 'Cost/Hour:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label67: TLabel
            Left = 39
            Top = 312
            Width = 66
            Height = 15
            Alignment = taRightJustify
            Caption = 'Number Up:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label66: TLabel
            Left = 0
            Top = 288
            Width = 108
            Height = 15
            Alignment = taRightJustify
            Caption = 'Die Cut Setup Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label65: TLabel
            Left = 10
            Top = 264
            Width = 97
            Height = 15
            Alignment = taRightJustify
            Caption = 'Total Print Costs:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label64: TLabel
            Left = 33
            Top = 240
            Width = 72
            Height = 15
            Alignment = taRightJustify
            Caption = 'Setup Costs:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label63: TLabel
            Left = 32
            Top = 216
            Width = 73
            Height = 15
            Alignment = taRightJustify
            Caption = 'Screen Cost:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label62: TLabel
            Left = 45
            Top = 192
            Width = 60
            Height = 15
            Alignment = taRightJustify
            Caption = 'Cols/Pass:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label61: TLabel
            Left = 50
            Top = 168
            Width = 55
            Height = 15
            Alignment = taRightJustify
            Caption = 'Col/Label:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label60: TLabel
            Left = 32
            Top = 144
            Width = 73
            Height = 15
            Alignment = taRightJustify
            Caption = 'Numbers Up:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label59: TLabel
            Left = 52
            Top = 120
            Width = 53
            Height = 15
            Alignment = taRightJustify
            Caption = 'Prints/Hr:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label58: TLabel
            Left = 23
            Top = 96
            Width = 82
            Height = 15
            Alignment = taRightJustify
            Caption = 'Mach. Cost/Hr:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Prod_Overs: TEdit
            Left = 52
            Top = 40
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = IsDirty
          end
          object Prod_Qty: TEdit
            Left = 96
            Top = 12
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = IsDirty
          end
          object Num_UPT: TEdit
            Left = 180
            Top = 40
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = EnableDisableCalcBtns
            OnClick = IsDirty
          end
          object Prod_Qty_Qt: TEdit
            Left = 252
            Top = 12
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = IsDirty
          end
          object Lays_Brd: TEdit
            Left = 404
            Top = 12
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = IsDirty
          end
          object Slit_YN: TCheckBox
            Left = 480
            Top = 16
            Width = 45
            Height = 17
            BiDiMode = bdRightToLeft
            Caption = 'Slit'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 3
            OnClick = IsDirty
          end
          object Rivets: TEdit
            Left = 592
            Top = 12
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = IsDirty
          end
          object WorkTot_Cost: TEdit
            Left = 532
            Top = 152
            Width = 85
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 25
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Notes: TMemo
            Left = 424
            Top = 236
            Width = 193
            Height = 89
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Lines.Strings = (
              'Notes')
            ParentFont = False
            TabOrder = 38
            OnClick = IsDirty
          end
          object Pack_Cost: TEdit
            Left = 424
            Top = 332
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 35
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Del_Cost: TEdit
            Left = 424
            Top = 356
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 36
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object SubCon_Cost: TEdit
            Left = 424
            Top = 380
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 37
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Rivet_Cost: TEdit
            Left = 328
            Top = 300
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 31
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object E_Setup_Cost: TEdit
            Left = 328
            Top = 60
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 20
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object CutPVC_Cost: TEdit
            Left = 328
            Top = 84
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 21
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object CutBrd_Cost: TEdit
            Left = 328
            Top = 108
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 22
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object PreWeld_Cost: TEdit
            Left = 328
            Top = 132
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 23
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Main_Weld_Up: TEdit
            Left = 328
            Top = 156
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 24
            OnClick = IsDirty
          end
          object Main_Welds_Day: TEdit
            Left = 328
            Top = 180
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 26
            OnClick = IsDirty
          end
          object Mach_Cost_Day: TEdit
            Left = 328
            Top = 204
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 27
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Weld_Cost: TEdit
            Left = 328
            Top = 228
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 28
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Post_Weld_Cost: TEdit
            Left = 328
            Top = 252
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 29
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Tot_Weld_Cost: TEdit
            Left = 328
            Top = 276
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 30
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object BackSlit_Cost: TEdit
            Left = 256
            Top = 332
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 32
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object HandWork_Cost: TEdit
            Left = 256
            Top = 356
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 33
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Guillotine_Cost: TEdit
            Left = 256
            Top = 380
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 34
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Tot_Die_Cost: TEdit
            Left = 108
            Top = 380
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 19
            OnClick = IsDirty
          end
          object Imps_Hr: TEdit
            Left = 108
            Top = 356
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 18
            OnClick = IsDirty
          end
          object Cost_Hr: TEdit
            Left = 108
            Top = 332
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object D_Num_Up: TEdit
            Left = 108
            Top = 308
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
            OnClick = IsDirty
          end
          object D_Setup_Cost: TEdit
            Left = 108
            Top = 284
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Tot_Prn_Cost: TEdit
            Left = 108
            Top = 260
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Setup_Cost: TEdit
            Left = 108
            Top = 236
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Screen_Cost: TEdit
            Left = 108
            Top = 212
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object Colours_pass: TEdit
            Left = 108
            Top = 188
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            OnClick = IsDirty
          end
          object Colour_lbl: TEdit
            Left = 108
            Top = 164
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            OnClick = IsDirty
          end
          object Num_Up: TEdit
            Left = 108
            Top = 140
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            OnChange = EnableDisableCalcBtns
            OnClick = IsDirty
            OnEnter = Num_Up_Enter
          end
          object Prints_Hr: TEdit
            Left = 108
            Top = 116
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnClick = IsDirty
          end
          object Mach_Cost_Hr: TEdit
            Left = 108
            Top = 92
            Width = 70
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnChange = EnableDisableCalcBtns
            OnClick = IsDirty
            OnExit = CurrencyExit
          end
          object BitBtn4: TDNMSpeedButton
            Left = 773
            Top = 3
            Width = 87
            Height = 27
            Anchors = [akTop, akRight]
            Cancel = True
            Caption = '&Calculate'
            DisableTransparent = False
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 39
            TabStop = False
            OnClick = BitBtn4Click
          end
        end
      end
    end
    object cmdSave: TDNMSpeedButton
      Left = 877
      Top = 59
      Width = 88
      Height = 27
      Anchors = [akRight, akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = cmdSaveClick
    end
    object CmdCancel: TDNMSpeedButton
      Left = 877
      Top = 91
      Width = 88
      Height = 27
      Anchors = [akTop, akRight, akBottom]
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = CmdCancelClick
    end
    object pnlTitle: TDNMPanel
      Left = 311
      Top = 6
      Width = 249
      Height = 45
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 245
        Height = 41
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.2.1.1'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 245
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Custom Printing'
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
    Left = 64888
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 64824
  end
  inherited MyConnection: TMyConnection
    Left = 64920
  end
  inherited DataState: TDataState
    Left = 64824
  end
end
