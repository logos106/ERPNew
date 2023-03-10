inherited DashBoardPnLGUI: TDashBoardPnLGUI
  Left = 1301
  Top = 324
  HelpContext = 671000
  Caption = 'DashBoardPnLGUI'
  ClientHeight = 238
  ClientWidth = 472
  ExplicitLeft = 1301
  ExplicitTop = 324
  ExplicitWidth = 488
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 238
    Width = 472
    ExplicitTop = 238
    ExplicitWidth = 472
    HelpContext = 671053
  end
  inherited pnlmain: TDNMPanel
    Width = 472
    Height = 238
    HelpContext = 671001
    OnResize = pnlmainResize
    ExplicitWidth = 472
    ExplicitHeight = 238
    inherited pnlHeader: TDNMPanel
      Width = 470
      HelpContext = 671002
      Caption = 'Income and Expenditure Summary'
      ExplicitWidth = 470
    end
    inherited pnlDetails: TDNMPanel
      Width = 470
      Height = 213
      HelpContext = 671003
      ExplicitWidth = 470
      ExplicitHeight = 213
      DesignSize = (
        470
        213)
      object IncnCogs: TBevel
        Left = 6
        Top = 21
        Width = 457
        Height = 186
        HelpContext = 671004
        Anchors = [akLeft, akTop, akRight, akBottom]
        Style = bsRaised
      end
      object Bevel3: TBevel
        Left = 6
        Top = 20
        Width = 456
        Height = 185
        HelpContext = 671005
        Anchors = [akLeft, akTop, akRight, akBottom]
      end
      object c1: TLabel
        Left = 16
        Top = 27
        Width = 41
        Height = 15
        HelpContext = 671006
        Anchors = []
        Caption = 'Income'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object c2: TLabel
        Left = 16
        Top = 53
        Width = 35
        Height = 15
        HelpContext = 671007
        Anchors = []
        Caption = 'COGS'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object c3: TLabel
        Left = 16
        Top = 80
        Width = 34
        Height = 15
        HelpContext = 671008
        Anchors = []
        Caption = 'Gross'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object c4: TLabel
        Left = 16
        Top = 106
        Width = 48
        Height = 15
        HelpContext = 671009
        Anchors = []
        Caption = 'Expense'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object c5: TLabel
        Left = 16
        Top = 133
        Width = 36
        Height = 15
        HelpContext = 671010
        Anchors = []
        Caption = 'NetInc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object c6: TLabel
        Left = 16
        Top = 159
        Width = 62
        Height = 15
        HelpContext = 671011
        Anchors = []
        Caption = 'income Tax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object c7: TLabel
        Left = 16
        Top = 186
        Width = 33
        Height = 15
        HelpContext = 671012
        Anchors = []
        Caption = 'NetEx'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object t7: TLabel
        Left = 172
        Top = 186
        Width = 33
        Height = 15
        HelpContext = 671013
        Alignment = taRightJustify
        Anchors = []
        Caption = 'NetEx'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object t6: TLabel
        Left = 146
        Top = 159
        Width = 59
        Height = 15
        HelpContext = 671014
        Alignment = taRightJustify
        Anchors = []
        Caption = 'IncomeTax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object t5: TLabel
        Left = 169
        Top = 133
        Width = 36
        Height = 15
        HelpContext = 671015
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Netinc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object t4: TLabel
        Left = 157
        Top = 106
        Width = 48
        Height = 15
        HelpContext = 671016
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Expense'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object t3: TLabel
        Left = 171
        Top = 80
        Width = 34
        Height = 15
        HelpContext = 671017
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Gross'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object t2: TLabel
        Left = 179
        Top = 53
        Width = 27
        Height = 15
        HelpContext = 671018
        Alignment = taRightJustify
        Anchors = []
        Caption = 'cogs'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object t1: TLabel
        Left = 164
        Top = 27
        Width = 41
        Height = 15
        HelpContext = 671019
        Alignment = taRightJustify
        Anchors = []
        Caption = 'income'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object b1: TLabel
        Left = 264
        Top = 27
        Width = 41
        Height = 15
        HelpContext = 671020
        Alignment = taRightJustify
        Anchors = []
        Caption = 'income'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object b2: TLabel
        Left = 278
        Top = 53
        Width = 27
        Height = 15
        HelpContext = 671021
        Alignment = taRightJustify
        Anchors = []
        Caption = 'cogs'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object b3: TLabel
        Left = 271
        Top = 80
        Width = 34
        Height = 15
        HelpContext = 671022
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Gross'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object b4: TLabel
        Left = 257
        Top = 106
        Width = 48
        Height = 15
        HelpContext = 671023
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Expense'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object b5: TLabel
        Left = 269
        Top = 133
        Width = 36
        Height = 15
        HelpContext = 671024
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Netinc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object b6: TLabel
        Left = 246
        Top = 159
        Width = 59
        Height = 15
        HelpContext = 671025
        Alignment = taRightJustify
        Anchors = []
        Caption = 'IncomeTax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object b7: TLabel
        Left = 272
        Top = 186
        Width = 33
        Height = 15
        HelpContext = 671026
        Alignment = taRightJustify
        Anchors = []
        Caption = 'NetEx'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblTotal: TLabel
        Left = 179
        Top = 3
        Width = 27
        Height = 15
        HelpContext = 671027
        Alignment = taRightJustify
        Anchors = [akTop]
        Caption = 'Total'
        Transparent = True
      end
      object lblBudget: TLabel
        Left = 265
        Top = 3
        Width = 40
        Height = 15
        HelpContext = 671028
        Alignment = taRightJustify
        Anchors = [akTop]
        Caption = 'Budget'
        Transparent = True
      end
      object lblVariance: TLabel
        Left = 376
        Top = 3
        Width = 50
        Height = 15
        HelpContext = 671029
        Alignment = taRightJustify
        Anchors = [akTop]
        Caption = 'Variance'
        Transparent = True
      end
      object v1: TLabel
        Left = 364
        Top = 27
        Width = 41
        Height = 15
        HelpContext = 671030
        Alignment = taRightJustify
        Anchors = []
        Caption = 'income'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object v2: TLabel
        Left = 378
        Top = 53
        Width = 27
        Height = 15
        HelpContext = 671031
        Alignment = taRightJustify
        Anchors = []
        Caption = 'cogs'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object v3: TLabel
        Left = 371
        Top = 80
        Width = 34
        Height = 15
        HelpContext = 671032
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Gross'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object v4: TLabel
        Left = 357
        Top = 106
        Width = 48
        Height = 15
        HelpContext = 671033
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Expense'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object v5: TLabel
        Left = 369
        Top = 133
        Width = 36
        Height = 15
        HelpContext = 671034
        Alignment = taRightJustify
        Anchors = []
        Caption = 'Netinc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object v6: TLabel
        Left = 346
        Top = 159
        Width = 59
        Height = 15
        HelpContext = 671035
        Alignment = taRightJustify
        Anchors = []
        Caption = 'IncomeTax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object v7: TLabel
        Left = 372
        Top = 186
        Width = 33
        Height = 15
        HelpContext = 671036
        Alignment = taRightJustify
        Anchors = []
        Caption = 'NetEx'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Bevel1: TBevel
        Left = 9
        Top = 101
        Width = 453
        Height = 5
        HelpContext = 671037
        Anchors = [akLeft, akRight]
        Shape = bsTopLine
      end
      object Bevel2: TBevel
        Left = 9
        Top = 154
        Width = 453
        Height = 5
        HelpContext = 671038
        Anchors = [akLeft, akRight]
        Shape = bsTopLine
      end
      object a1: TLabel
        Left = 429
        Top = 34
        Width = 30
        Height = 7
        HelpContext = 671039
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object a2: TLabel
        Left = 429
        Top = 60
        Width = 30
        Height = 7
        HelpContext = 671040
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object a3: TLabel
        Left = 429
        Top = 87
        Width = 30
        Height = 7
        HelpContext = 671041
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object a4: TLabel
        Left = 429
        Top = 113
        Width = 30
        Height = 7
        HelpContext = 671042
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object a5: TLabel
        Left = 429
        Top = 140
        Width = 30
        Height = 7
        HelpContext = 671043
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object a6: TLabel
        Left = 429
        Top = 166
        Width = 30
        Height = 7
        HelpContext = 671044
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object a7: TLabel
        Left = 429
        Top = 193
        Width = 30
        Height = 7
        HelpContext = 671045
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bu2: TLabel
        Left = 429
        Top = 54
        Width = 30
        Height = 7
        HelpContext = 671046
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bu3: TLabel
        Left = 429
        Top = 81
        Width = 30
        Height = 7
        HelpContext = 671047
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bu4: TLabel
        Left = 429
        Top = 107
        Width = 30
        Height = 7
        HelpContext = 671048
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bu5: TLabel
        Left = 429
        Top = 134
        Width = 30
        Height = 7
        HelpContext = 671049
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bu6: TLabel
        Left = 429
        Top = 160
        Width = 30
        Height = 7
        HelpContext = 671050
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bu7: TLabel
        Left = 429
        Top = 187
        Width = 30
        Height = 7
        HelpContext = 671051
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object bu1: TLabel
        Left = 429
        Top = 28
        Width = 30
        Height = 7
        HelpContext = 671052
        Anchors = []
        AutoSize = False
        Caption = 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
    end
  end
end
