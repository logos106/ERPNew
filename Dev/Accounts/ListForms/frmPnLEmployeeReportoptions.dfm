inherited fmPnLEmployeeReportoptions: TfmPnLEmployeeReportoptions
  Caption = 'Profit and Loss (Area/Employee) Options'
  ClientHeight = 431
  ClientWidth = 470
  Position = poMainFormCenter
  ExplicitWidth = 478
  ExplicitHeight = 458
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1072002
  inherited lblSkingroupMsg: TLabel
    Top = 381
    Width = 470
    ExplicitTop = 381
    ExplicitWidth = 470
    HelpContext = 1072003
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 73
    Width = 470
    Height = 308
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      470
      308)
    HelpContext = 1072004
    object label1: TLabel
      Left = 254
      Top = 10
      Width = 56
      Height = 15
      Anchors = [akTop]
      Caption = 'Expenses'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      WordWrap = True
      HelpContext = 1072005
    end
    object Label2: TLabel
      Left = 15
      Top = 10
      Width = 42
      Height = 15
      Anchors = [akTop]
      Caption = 'Income'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      WordWrap = True
      HelpContext = 1072006
    end
    object Label4: TLabel
      Left = 254
      Top = 159
      Width = 75
      Height = 15
      Anchors = [akTop]
      Caption = 'Journal Entry'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      HelpContext = 1072007
    end
    object Shape1: TShape
      Left = 251
      Top = 184
      Width = 213
      Height = 38
      Brush.Style = bsClear
      Pen.Color = clGray
      HelpContext = 1072008
    end
    object lblCategory: TLabel
      Left = 251
      Top = 231
      Width = 106
      Height = 15
      Anchors = [akTop]
      Caption = 'Report Grouped By'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      HelpContext = 1072009
    end
    object Shape2: TShape
      Left = 251
      Top = 34
      Width = 213
      Height = 120
      Brush.Style = bsClear
      Pen.Color = clGray
      HelpContext = 1072010
    end
    object Shape3: TShape
      Left = 15
      Top = 31
      Width = 213
      Height = 267
      Brush.Style = bsClear
      Pen.Color = clGray
      HelpContext = 1072011
    end
    object chkPO: TCheckBox
      Left = 262
      Top = 41
      Width = 176
      Height = 17
      Caption = 'Include Purchase Orders'
      TabOrder = 0
      HelpContext = 1072012
    end
    object chkLayby: TCheckBox
      Left = 22
      Top = 156
      Width = 176
      Height = 17
      Caption = 'Include Laybys'
      TabOrder = 1
      HelpContext = 1072013
    end
    object chkcheque: TCheckBox
      Left = 262
      Top = 72
      Width = 176
      Height = 17
      Caption = 'Include Cheques'
      TabOrder = 2
      HelpContext = 1072014
    end
    object chkBills: TCheckBox
      Left = 262
      Top = 103
      Width = 176
      Height = 17
      Caption = 'Include Bills'
      TabOrder = 3
      HelpContext = 1072015
    end
    object chkCredits: TCheckBox
      Left = 262
      Top = 134
      Width = 176
      Height = 17
      Caption = 'Include Credits'
      TabOrder = 4
      HelpContext = 1072016
    end
    object chkInvoice: TCheckBox
      Left = 22
      Top = 44
      Width = 176
      Height = 17
      Caption = 'Include Invoice'
      TabOrder = 5
      HelpContext = 1072017
    end
    object chkPOS: TCheckBox
      Left = 22
      Top = 81
      Width = 176
      Height = 17
      Caption = 'Include POS'
      TabOrder = 6
      HelpContext = 1072018
    end
    object chkSO: TCheckBox
      Left = 22
      Top = 118
      Width = 176
      Height = 17
      Caption = 'Include Sales Orders'
      TabOrder = 7
      HelpContext = 1072019
    end
    object chkCashSale: TCheckBox
      Left = 22
      Top = 193
      Width = 176
      Height = 17
      Caption = 'Include Cash Sales'
      TabOrder = 8
      HelpContext = 1072020
    end
    object chkRefunds: TCheckBox
      Left = 22
      Top = 230
      Width = 176
      Height = 17
      Caption = 'Include Refunds'
      TabOrder = 9
      HelpContext = 1072021
    end
    object optCategory: TRadioGroup
      AlignWithMargins = True
      Left = 251
      Top = 248
      Width = 213
      Height = 50
      Margins.Left = 32
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 1
      Items.Strings = (
        'By employee'
        'By Area')
      ParentFont = False
      TabOrder = 10
      HelpContext = 1072022
    end
    object chkJE: TCheckBox
      Left = 262
      Top = 195
      Width = 176
      Height = 17
      Caption = 'Include Journal entry'
      TabOrder = 11
      HelpContext = 1072023
    end
    object chkVoucher: TCheckBox
      Left = 22
      Top = 268
      Width = 176
      Height = 17
      Caption = 'Include Vouchers'
      TabOrder = 12
      HelpContext = 1072024
    end
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 0
    Top = 381
    Width = 470
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      470
      50)
    HelpContext = 1072025
    object cmdClose: TDNMSpeedButton
      Left = 254
      Top = 15
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Cancel'
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
      OnClick = cmdCloseClick
      HelpContext = 1072026
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 126
      Top = 15
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = '&Ok'
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
      OnClick = DNMSpeedButton1Click
      HelpContext = 1072027
    end
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 470
    Height = 73
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      470
      73)
    HelpContext = 1072028
    object pnlHeader: TPanel
      Left = 107
      Top = 10
      Width = 257
      Height = 45
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      HelpContext = 1072029
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 255
        Height = 43
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
        HelpContext = 1072030
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 255
          Height = 43
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Options'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -3
          ExplicitTop = 1
          ExplicitWidth = 546
          ExplicitHeight = 56
          HelpContext = 1072031
        end
      end
    end
  end
end
