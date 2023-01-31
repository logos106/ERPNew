inherited POSProcessStepFrm: TPOSProcessStepFrm
  Left = 422
  Top = 212
  HelpContext = 430000
  Caption = 'Process Steps'
  ClientHeight = 372
  ClientWidth = 478
  OldCreateOrder = True
  ExplicitLeft = 422
  ExplicitTop = 212
  ExplicitWidth = 486
  ExplicitHeight = 399
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 430001
  end
  object grdSteps: TwwDBGrid [3]
    Left = 25
    Top = 57
    Width = 428
    Height = 259
    HelpContext = 430009
    ControlType.Strings = (
      'IsPurchasing;CheckBox;T;F'
      'Active;CheckBox;T;F')
    Selected.Strings = (
      'Description'#9'50'#9'Description'#9'F'#9
      'Active'#9'1'#9'Active'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWindow
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    Constraints.MinWidth = 320
    DataSource = dsProcessStep
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 453
    Top = 57
    Width = 25
    Height = 259
    HelpContext = 430010
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object pnlLeft: TDNMPanel [5]
    Left = 0
    Top = 57
    Width = 25
    Height = 259
    HelpContext = 430011
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 478
    Height = 57
    HelpContext = 430005
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      478
      57)
    object pnlTitle: TDNMPanel
      Left = 90
      Top = 6
      Width = 299
      Height = 45
      HelpContext = 430006
      Anchors = [akTop]
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
        Width = 295
        Height = 41
        HelpContext = 430007
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
          Width = 295
          Height = 41
          HelpContext = 430008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Process Steps'
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
  object pnlBottom: TDNMPanel [7]
    Left = 0
    Top = 316
    Width = 478
    Height = 56
    HelpContext = 430002
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      478
      56)
    object btnOK: TDNMSpeedButton
      Left = 140
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 430003
      Anchors = [akTop]
      Caption = 'O&K'
      Default = True
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
      Kind = bkOK
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 250
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 430004
      Anchors = [akTop]
      Cancel = True
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 256
    Top = 200
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 192
    Top = 200
  end
  inherited MyConnection: TERPConnection
    Left = 288
    Top = 199
  end
  object tblProcessStep: TMyTable
    TableName = 'tblprocessstep'
    Connection = MyConnection
    AfterInsert = tblProcessStepAfterInsert
    BeforePost = tblProcessStepBeforePost
    Left = 328
    Top = 200
    object tblProcessStepDescription: TWideStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Origin = 'tblprocessstep.Description'
      Size = 255
    end
    object tblProcessStepActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblprocessstep.Active'
      OnSetText = tblProcessStepActiveSetText
      FixedChar = True
      Size = 1
    end
    object tblProcessStepGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tblprocessstep.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblProcessStepID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblprocessstep.ID'
      Visible = False
    end
    object tblProcessStepProcessTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ProcessTime'
      Origin = 'tblprocessstep.ProcessTime'
      Visible = False
    end
    object tblProcessStepmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblprocessstep.msTimeStamp'
      Visible = False
    end
  end
  object dsProcessStep: TDataSource
    DataSet = tblProcessStep
    Left = 331
    Top = 232
  end
end
