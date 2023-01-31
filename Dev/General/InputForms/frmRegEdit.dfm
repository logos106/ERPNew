inherited fmRegEdit: TfmRegEdit
  Caption = 'Edit Registry'
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 793001
  object Label1: TLabel [3]
    Left = 32
    Top = 88
    Width = 3
    Height = 15
    HelpContext = 793002
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 952
    Height = 73
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 793003
    object pnlTitle: TDNMPanel
      Left = 343
      Top = 11
      Width = 266
      Height = 45
      HelpContext = 793004
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
        Width = 262
        Height = 41
        HelpContext = 793005
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
          Width = 262
          Height = 41
          HelpContext = 793006
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Edit Registry'
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
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 73
    Width = 952
    Height = 386
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    HelpContext = 793007
    object RegTreeView: TTreeView
      Left = 1
      Top = 1
      Width = 272
      Height = 384
      HelpContext = 793008
      Align = alLeft
      AutoExpand = True
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Indent = 19
      ParentFont = False
      ReadOnly = True
      ShowButtons = False
      TabOrder = 0
    end
    object CboRegEdit: TwwDBComboBox
      Left = 468
      Top = 331
      Width = 121
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'RegValue'
      DataSource = dsRegEdit
      DropDownCount = 8
      ItemHeight = 0
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
      Visible = False
      HelpContext = 793009
    end
    object grdRegEdit: TwwDBGrid
      Left = 273
      Top = 1
      Width = 678
      Height = 384
      HelpContext = 793010
      Selected.Strings = (
        'RegName'#9'20'#9'Name'#9'T'
        'RegValue'#9'69'#9'Value'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdRegEditRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsRegEdit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab, dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnEnter = grdRegEditEnter
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 459
    Width = 952
    Height = 73
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    HelpContext = 793011
    object btnSave: TDNMSpeedButton
      Left = 362
      Top = 30
      Width = 87
      Height = 27
      HelpContext = 793012
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 497
      Top = 30
      Width = 87
      Height = 27
      HelpContext = 793013
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  object QryRegEdit: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tmp_regEdit')
    Left = 464
    Top = 224
    object QryRegEditRegName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'RegName'
      Origin = 'tmp_regedit.RegName'
      Size = 255
    end
    object QryRegEditRegValue: TWideStringField
      DisplayLabel = 'Value'
      DisplayWidth = 69
      FieldName = 'RegValue'
      Origin = 'tmp_regedit.RegValue'
      Size = 255
    end
    object QryRegEditID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tmp_regedit.ID'
      Visible = False
    end
    object QryRegEditKeyName: TWideMemoField
      DisplayWidth = 10
      FieldName = 'KeyName'
      Origin = 'tmp_regedit.KeyName'
      Visible = False
      BlobType = ftWideMemo
    end
  end
  object dsRegEdit: TDataSource
    DataSet = QryRegEdit
    Left = 464
    Top = 264
  end
end
