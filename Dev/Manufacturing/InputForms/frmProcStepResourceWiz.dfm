inherited fmProcStepResourceWiz: TfmProcStepResourceWiz
  Left = 2163
  Top = 96
  HelpContext = 609000
  BorderStyle = bsDialog
  Caption = 'Process Step and Resource Wizard'
  ClientHeight = 325
  ClientWidth = 447
  OldCreateOrder = True
  ExplicitLeft = 2163
  ExplicitTop = 96
  ExplicitWidth = 463
  ExplicitHeight = 363
  PixelsPerInch = 96
  TextHeight = 15
  object pnlStep: TDNMPanel [3]
    Left = 0
    Top = 65
    Width = 447
    Height = 120
    HelpContext = 609008
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label2: TLabel
      Left = 99
      Top = 21
      Width = 145
      Height = 15
      HelpContext = 609009
      Caption = 'Process Step Description'
      Transparent = True
    end
    object Label1: TLabel
      Left = 99
      Top = 69
      Width = 91
      Height = 15
      HelpContext = 609010
      Caption = 'Resource Name'
      Transparent = True
    end
    object edtStepDesc: TEdit
      Left = 99
      Top = 37
      Width = 249
      Height = 23
      HelpContext = 609011
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object cboResource: TComboBox
      Left = 99
      Top = 85
      Width = 249
      Height = 23
      HelpContext = 609012
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnCloseUp = cboResourceCloseUp
      OnExit = cboResourceExit
    end
  end
  object pnlResourceDetail: TDNMPanel [4]
    Left = 0
    Top = 185
    Width = 447
    Height = 96
    HelpContext = 609013
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label3: TLabel
      Left = 72
      Top = 18
      Width = 86
      Height = 15
      HelpContext = 609014
      Caption = 'Capacity Hours'
      Transparent = True
    end
    object Label4: TLabel
      Left = 176
      Top = 18
      Width = 70
      Height = 15
      HelpContext = 609015
      Caption = 'Setup Hours'
      Transparent = True
    end
    object Label5: TLabel
      Left = 272
      Top = 18
      Width = 102
      Height = 15
      HelpContext = 609016
      Caption = 'Breakdown Hours'
      Transparent = True
    end
    object edtCapacityHours: TAdvEdit
      Left = 70
      Top = 33
      Width = 75
      Height = 23
      HelpContext = 609017
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0.00'
      Visible = True
      Version = '2.8.6.9'
    end
    object edtSetupHours: TAdvEdit
      Left = 174
      Top = 33
      Width = 75
      Height = 23
      HelpContext = 609018
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0.00'
      Visible = True
      Version = '2.8.6.9'
    end
    object edtBreakDownHours: TAdvEdit
      Left = 270
      Top = 33
      Width = 75
      Height = 23
      HelpContext = 609019
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0.00'
      Visible = True
      Version = '2.8.6.9'
    end
  end
  object pnlTop: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 447
    Height = 65
    HelpContext = 609004
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
      447
      65)
    object pnlTitle: TDNMPanel
      Left = 39
      Top = 14
      Width = 369
      Height = 41
      HelpContext = 609005
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
        Width = 365
        Height = 37
        HelpContext = 609006
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
          Width = 365
          Height = 37
          HelpContext = 609007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Step / Resource Wizard'
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
  object pnlBottom: TDNMPanel [6]
    Left = 0
    Top = 281
    Width = 447
    Height = 44
    HelpContext = 609001
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      447
      44)
    object btnSave: TDNMSpeedButton
      Left = 121
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 609002
      Anchors = [akBottom]
      Caption = 'Save'
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
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 238
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 609003
      Anchors = [akBottom]
      Caption = 'Cancel'
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
      TabOrder = 1
    end
  end
end
