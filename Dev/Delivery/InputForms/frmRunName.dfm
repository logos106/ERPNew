inherited frmRunCreator: TfrmRunCreator
  Left = 285
  Top = 161
  Caption = 'Run Name'
  ClientHeight = 436
  ClientWidth = 669
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 669
    Height = 436
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
      669
      436)
    object btnClose: TDNMSpeedButton
      Left = 395
      Top = 400
      Width = 87
      Height = 28
      Anchors = [akLeft, akBottom]
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
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnSave: TDNMSpeedButton
      Left = 184
      Top = 400
      Width = 87
      Height = 27
      Anchors = [akLeft, akBottom]
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
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object grdRuns: TwwDBGrid
      Left = 7
      Top = 47
      Width = 654
      Height = 345
      ControlType.Strings = (
        'Active;CheckBox;T;F'
        'Operator;CustomEdit;cboOperator;F')
      Selected.Strings = (
        'RunName'#9'40'#9'Run Name'#9#9
        'Operator'#9'26'#9'Operator'#9'F'#9
        'Active'#9'1'#9'Active'#9#9)
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
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
    end
    object cboOperator: TwwDBLookupCombo
      Left = 400
      Top = 56
      Width = 233
      Height = 23
      DropDownAlignment = taLeftJustify
      DataField = 'Operator'
      DataSource = dsRuns
      LookupTable = qryOperator
      LookupField = 'EmployeeName'
      Style = csDropDownList
      DropDownWidth = 40
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboOperatorCloseUp
      OnNotInList = cboOperatorNotInList
    end
    object pnlTitle: TDNMPanel
      Left = 213
      Top = 6
      Width = 238
      Height = 36
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
        Height = 32
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
          Height = 32
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Run Name'
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
  object qryRuns: TMyQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblruns')
    BeforePost = qryRunsBeforePost
    AfterPost = qryRunsAfterPost
    Left = 104
    Top = 8
    object qryRunsRunName: TStringField
      DisplayLabel = 'Run Name'
      DisplayWidth = 40
      FieldName = 'RunName'
      Size = 255
    end
    object qryRunsOperator: TStringField
      DisplayWidth = 26
      FieldName = 'Operator'
      Size = 255
    end
    object qryRunsActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryRunsRunID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'RunID'
      ReadOnly = True
      Visible = False
    end
    object qryRunsOperatorID: TIntegerField
      DisplayWidth = 10
      FieldName = 'OperatorID'
      Visible = False
    end
    object qryRunsGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object dsRuns: TDataSource
    DataSet = qryRuns
    Left = 104
    Top = 40
  end
  object qryOperator: TMyQuery
    SQL.Strings = (
      'SELECT'
      'EmployeeID, EmployeeName'
      'FROM tblemployees'
      'WHERE Active = '#39'T'#39' AND Rep = '#39'F'#39
      'ORDER BY EmployeeName')
    Options.LongStrings = False
    Left = 632
    Top = 8
    object qryOperatorEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryOperatorEmployeeName: TStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
  end
end
