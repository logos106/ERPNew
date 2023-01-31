inherited frmRunSelectorGUI: TfrmRunSelectorGUI
  Left = 413
  Top = 202
  Caption = 'Run Selector'
  ClientHeight = 459
  ClientWidth = 450
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 450
    Height = 459
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      450
      459)
    object cmdOK: TDNMSpeedButton
      Left = 48
      Top = 423
      Width = 87
      Height = 28
      Anchors = [akBottom]
      Caption = '&Ok'
      Default = True
      DisableTransparent = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 1
      OnClick = cmdOKClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 315
      Top = 423
      Width = 87
      Height = 29
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 3
      OnClick = cmdCancelClick
    end
    object grdRuns: TwwDBGrid
      Left = 8
      Top = 56
      Width = 433
      Height = 355
      Selected.Strings = (
        'RunName'#9'30'#9'RunName'#9#9
        'Operator'#9'25'#9'Operator'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsRuns
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = grdRunsDblClick
      OnEnter = grdRunsEnter
    end
    object btnNew: TDNMSpeedButton
      Left = 181
      Top = 424
      Width = 87
      Height = 27
      Hint = '"Press to create new run names."'
      Anchors = [akBottom]
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnNewClick
    end
    object pnlTitle: TDNMPanel
      Left = 106
      Top = 5
      Width = 238
      Height = 45
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
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
          Width = 234
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Run Selector'
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
    Top = 93
  end
  inherited MyConnection: TMyConnection
    Top = 92
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 174
    Top = 98
  end
  object qryRun: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblruns '
      'WHERE Active = "T"'
      'ORDER BY RunName;')
    Options.LongStrings = False
    Left = 136
    Top = 93
    object qryRunRunName: TStringField
      DisplayWidth = 30
      FieldName = 'RunName'
      Origin = 'tblruns.RunName'
      Size = 255
    end
    object qryRunOperator: TStringField
      DisplayWidth = 25
      FieldName = 'Operator'
      Origin = 'tblruns.Operator'
      Size = 255
    end
    object qryRunRunID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RunID'
      Origin = 'tblruns.RunID'
      Visible = False
    end
    object qryRunActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblruns.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryRunOperatorID: TIntegerField
      DisplayWidth = 15
      FieldName = 'OperatorID'
      Origin = 'tblruns.OperatorID'
      Visible = False
    end
    object qryRunRunDate: TDateField
      DisplayWidth = 10
      FieldName = 'RunDate'
      Origin = 'tblruns.RunDate'
      Visible = False
    end
    object qryRunGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblruns.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryRunClassName: TStringField
      DisplayWidth = 255
      FieldName = 'ClassName'
      Origin = 'tblruns.ClassName'
      Visible = False
      Size = 255
    end
    object qryRunClassID: TIntegerField
      DisplayWidth = 15
      FieldName = 'ClassID'
      Origin = 'tblruns.ClassID'
      Visible = False
    end
    object qryRunIsPublicHoliday: TStringField
      DisplayWidth = 1
      FieldName = 'IsPublicHoliday'
      Origin = 'tblruns.IsPublicHoliday'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsRuns: TDataSource
    DataSet = qryRun
    Left = 136
    Top = 125
  end
  object tmrCheck: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrCheckTimer
    Left = 408
    Top = 8
  end
end
