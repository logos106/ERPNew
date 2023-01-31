inherited MainDashboardGUI: TMainDashboardGUI
  Left = 320
  Top = 242
  HelpContext = 999001
  Caption = 'Main Dashboard'
  ExplicitLeft = 320
  ExplicitTop = 242
  PixelsPerInch = 96
  TextHeight = 13
  object lblREfreshInfo: TLabel [2]
    Left = 0
    Top = 47
    Width = 952
    Height = 16
    HelpContext = 999002
    Align = alTop
    Alignment = taCenter
    Caption = 'Please Select Refresh Button to Apply the Selection Criteria'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Visible = False
    WordWrap = True
    ExplicitWidth = 379
  end
  inherited Horizontal1: TSplitter
    Top = 303
    ExplicitLeft = -16
    ExplicitTop = 304
  end
  inherited pnl3: TDNMPanel
    Top = 305
    Height = 184
    HelpContext = 999003
    ExplicitTop = 305
    ExplicitHeight = 187
    inherited report3n4: TSplitter
      Height = 182
      HelpContext = 999004
      ExplicitHeight = 201
    end
    inherited report4n5: TSplitter
      Height = 182
      HelpContext = 999005
      ExplicitHeight = 201
    end
    inherited Report4: TDNMPanel
      Height = 182
      HelpContext = 999006
      ExplicitHeight = 185
    end
    inherited Report5: TDNMPanel
      Height = 182
      HelpContext = 999007
      ExplicitHeight = 185
    end
    inherited report6: TDNMPanel
      Height = 182
      HelpContext = 999008
      ExplicitHeight = 185
    end
  end
  inherited DNMPanel1: TDNMPanel
    HelpContext = 999025
    inherited btnCancel: TDNMSpeedButton
      Left = 491
      ExplicitLeft = 491
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 211
      ExplicitLeft = 211
    end
    inherited btnImport: TDNMSpeedButton
      Left = 631
      ExplicitLeft = 631
    end
    object DNMSpeedButton1: TDNMSpeedButton [3]
      Left = 351
      Top = 6
      Width = 109
      Height = 27
      HelpContext = 999009
      Anchors = []
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
  end
  object HeaderPanel: TPanel [8]
    Left = 0
    Top = 0
    Width = 952
    Height = 47
    HelpContext = 999010
    Align = alTop
    BevelOuter = bvNone
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      952
      47)
    object lblFrom: TLabel
      Left = 708
      Top = 20
      Width = 29
      Height = 15
      HelpContext = 999011
      Anchors = [akTop, akRight]
      Caption = '&From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object lblTo: TLabel
      Left = 841
      Top = 20
      Width = 13
      Height = 15
      HelpContext = 999012
      Anchors = [akTop, akRight]
      Caption = '&To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object pnlHeader: TPanel
      Left = 371
      Top = 3
      Width = 210
      Height = 41
      HelpContext = 999013
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 208
        Height = 39
        HelpContext = 999014
        Align = alClient
        BevelOuter = bvNone
        Color = clInfoBk
        ParentBackground = False
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
          Width = 208
          Height = 39
          HelpContext = 999015
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Dashboard'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = 16
          ExplicitTop = -5
          ExplicitHeight = 33
        end
      end
    end
    object dtFrom: TwwDBDateTimePicker
      Left = 745
      Top = 16
      Width = 86
      Height = 22
      HelpContext = 999016
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 6
      CalendarAttributes.PopupYearOptions.StartYear = 1980
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
      OnChange = dtFromChange
    end
    object dtTo: TwwDBDateTimePicker
      Left = 860
      Top = 16
      Width = 86
      Height = 22
      HelpContext = 999017
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 6
      CalendarAttributes.PopupYearOptions.StartYear = 1980
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 2
      UnboundDataType = wwDTEdtDate
      OnChange = dtToChange
    end
    object chkIgnoreDates: TCheckBox
      Left = 600
      Top = 20
      Width = 96
      Height = 17
      HelpContext = 999018
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Ignore Dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      WordWrap = True
      OnClick = chkIgnoreDatesClick
    end
  end
  inherited pnl1: TDNMPanel
    Top = 63
    Height = 240
    HelpContext = 999019
    ExplicitTop = 63
    ExplicitHeight = 240
    inherited report2n3: TSplitter
      Height = 238
      HelpContext = 999020
      ExplicitTop = 17
      ExplicitHeight = 215
    end
    inherited report1n2: TSplitter
      Height = 238
      HelpContext = 999021
      ExplicitTop = 17
      ExplicitHeight = 215
    end
    inherited Report2: TDNMPanel
      Height = 238
      HelpContext = 999022
      ExplicitHeight = 238
    end
    inherited Report3: TDNMPanel
      Height = 238
      HelpContext = 999023
      ExplicitHeight = 238
    end
    inherited Report1: TDNMPanel
      Height = 238
      HelpContext = 999024
      ExplicitHeight = 238
    end
  end
  inherited dlgOpen: TOpenDialog
    Left = 543
    Top = 203
  end
end
