inherited fmbinLocations: TfmbinLocations
  Left = 525
  Top = 261
  HelpContext = 142000
  Caption = 'Bin Locations'
  ClientHeight = 319
  ClientWidth = 416
  Color = 15588572
  OldCreateOrder = True
  ExplicitLeft = 525
  ExplicitTop = 261
  ExplicitWidth = 432
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 267
    Width = 416
    HelpContext = 142043
    ExplicitTop = 267
    ExplicitWidth = 416
  end
  inherited imgGridWatermark: TImage
    HelpContext = 142001
  end
  object pnlGenerateBin: TDNMPanel [5]
    Left = 0
    Top = 103
    Width = 416
    Height = 164
    HelpContext = 142020
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Color = 15588572
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      412
      160)
    object Label6: TLabel
      Left = 165
      Top = 43
      Width = 29
      Height = 15
      HelpContext = 142022
      Alignment = taRightJustify
      Caption = 'From'
      Transparent = True
    end
    object Label1: TLabel
      Left = 36
      Top = 64
      Width = 70
      Height = 15
      HelpContext = 142023
      Alignment = taRightJustify
      Caption = 'Bin Location'
      Transparent = True
    end
    object Label7: TLabel
      Left = 321
      Top = 43
      Width = 13
      Height = 15
      HelpContext = 142024
      Alignment = taRightJustify
      Caption = 'To'
      Transparent = True
    end
    object Label5: TLabel
      Left = 40
      Top = 92
      Width = 66
      Height = 15
      HelpContext = 142025
      Alignment = taRightJustify
      Caption = 'Bin Number'
      Transparent = True
    end
    object Label8: TLabel
      Left = 20
      Top = 12
      Width = 86
      Height = 15
      HelpContext = 142026
      Alignment = taRightJustify
      Caption = 'Location Prefix'
      FocusControl = btnClose
      Transparent = True
      OnClick = FormActivate
    end
    object Label10: TLabel
      Left = 37
      Top = 139
      Width = 69
      Height = 15
      HelpContext = 142006
      Alignment = taRightJustify
      Caption = 'Max Volume'
      FocusControl = btnClose
      Transparent = True
      OnClick = FormActivate
    end
    object Bevel6: TBevel
      Left = 111
      Top = 43
      Width = 141
      Height = 80
      HelpContext = 142027
    end
    object Bevel1: TBevel
      Left = 252
      Top = 43
      Width = 150
      Height = 80
      HelpContext = 142044
    end
    object txtrowFrom: TEdit
      Left = 119
      Top = 60
      Width = 121
      Height = 23
      Hint = 'Location is defined as single character. ie. A to K'
      HelpContext = 142029
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object txtRowto: TEdit
      Left = 267
      Top = 60
      Width = 121
      Height = 23
      Hint = 'Location is defined as single character. ie. A to K'
      HelpContext = 142030
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object txtcolumnTo: TEdit
      Left = 267
      Top = 88
      Width = 121
      Height = 23
      Hint = 'The Bin Number is defined as a numeric value. ie. 1 to 10'
      HelpContext = 142031
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnKeyPress = txtcolumnFromKeyPress
    end
    object txtcolumnFrom: TEdit
      Left = 119
      Top = 88
      Width = 121
      Height = 23
      Hint = 'The Bin Number is defined as a numeric value. ie. 1 to 10'
      HelpContext = 142032
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyPress = txtcolumnFromKeyPress
    end
    object edtLocationPrefix: TEdit
      Left = 119
      Top = 8
      Width = 269
      Height = 23
      Hint = 'This will be the name prefixing the final Bin Name'
      HelpContext = 142033
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = FormActivate
    end
    object edtVolume: TEdit
      Left = 119
      Top = 135
      Width = 121
      Height = 23
      Hint = 'This is the Maximum volume of each bin generated'
      HelpContext = 142034
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = FormActivate
    end
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 267
    Width = 416
    Height = 52
    HelpContext = 142013
    Align = alBottom
    Anchors = [akLeft, akRight]
    BevelOuter = bvNone
    Color = 15588572
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      416
      52)
    object Label4: TLabel
      Left = 891
      Top = 19
      Width = 50
      Height = 16
      HelpContext = 142014
      Alignment = taCenter
      Anchors = [akLeft]
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object wwCheckBox1: TwwCheckBox
      Left = 943
      Top = 19
      Width = 15
      Height = 17
      HelpContext = 142015
      TabStop = False
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akLeft]
      Caption = 'chkActive'
      DataField = 'Active'
      TabOrder = 3
    end
    object btnCompleted: TDNMSpeedButton
      Left = 21
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 142016
      Anchors = []
      Caption = '&Save'
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
      TabOrder = 0
      OnClick = btnCompletedClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 121
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 142017
      Anchors = []
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = cmdNewClick
    end
    object btnClose: TDNMSpeedButton
      Left = 321
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 142019
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object btnImport: TDNMSpeedButton
      Left = 221
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 142045
      Anchors = []
      Caption = '&Import'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnImportClick
    end
  end
  object pnlHeader: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 416
    Height = 103
    HelpContext = 142035
    Align = alTop
    BevelOuter = bvNone
    Color = 15588572
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      416
      103)
    object lblClass: TLabel
      Left = 10
      Top = 74
      Width = 104
      Height = 18
      HelpContext = 142036
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object CboGroupclass: TwwDBLookupCombo
      Left = 119
      Top = 72
      Width = 175
      Height = 23
      HelpContext = 142039
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'60'#9'ClassName'#9'F')
      LookupTable = cboClassQry
      LookupField = 'ClassID'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object pnlTitle: TDNMPanel
      Left = 58
      Top = 6
      Width = 289
      Height = 45
      HelpContext = 142040
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 285
        Height = 41
        HelpContext = 142041
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
          Width = 285
          Height = 41
          HelpContext = 142042
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Bin Locations'
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
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 300
      Top = 70
      Width = 114
      Height = 27
      HelpContext = 142018
      Anchors = []
      Caption = 'Create Single Bin'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = DNMSpeedButton1Click
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 9
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 40
    Top = 49
  end
  inherited MyConnection: TERPConnection
    Left = 72
    Top = 48
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 104
    Top = 49
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003400380010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassID, ClassName '
      'FROM tblClass '
      'WHERE Active='#39'T'#39' AND ClassName Is Not Null'
      'ORDER BY ClassName;')
    Left = 162
    Top = 69
    object cboClassQryClassName: TWideStringField
      DisplayWidth = 60
      FieldName = 'ClassName'
      Size = 60
    end
    object cboClassQryClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
  end
  object qryBinLocations: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * '
      'from tblProductbin where Active = '#39'T'#39'  and binId = :KeyId'
      '')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterInsert = qryBinLocationsAfterInsert
    Left = 354
    Top = 33
    ParamData = <
      item
        DataType = ftString
        Name = 'KeyId'
        Value = ''
      end>
    object qryBinLocationsBinLocation: TWideStringField
      DisplayLabel = 'Bin Location'
      DisplayWidth = 40
      FieldName = 'BinLocation'
      Origin = 'tblProductbin.BinLocation'
      Size = 30
    end
    object qryBinLocationsBinNumber: TWideStringField
      DisplayLabel = 'Bin Number'
      DisplayWidth = 35
      FieldName = 'BinNumber'
      Origin = 'tblProductbin.BinNumber'
      Size = 30
    end
    object qryBinLocationsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblProductbin.Active'
      FixedChar = True
      Size = 1
    end
    object qryBinLocationsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryBinLocationsBinID: TIntegerField
      FieldName = 'BinID'
    end
    object qryBinLocationsClassId: TIntegerField
      FieldName = 'ClassId'
    end
    object qryBinLocationsvolume: TFloatField
      FieldName = 'volume'
    end
    object qryBinLocationsVolume_Used: TFloatField
      FieldName = 'Volume_Used'
    end
  end
  object dsBinLocations: TDataSource
    DataSet = qryBinLocations
    Left = 354
    Top = 5
  end
end
