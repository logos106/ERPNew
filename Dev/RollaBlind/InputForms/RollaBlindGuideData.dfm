inherited RollaBlindGuideDataGUI: TRollaBlindGuideDataGUI
  Left = 373
  Top = 311
  Caption = 'Guide Data'
  ClientHeight = 329
  ClientWidth = 364
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel [1]
    Left = 40
    Top = 88
    Width = 67
    Height = 15
    Caption = 'Profile Type'
  end
  object DNMPanel1: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 364
    Height = 329
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      364
      329)
    object Bevel1: TBevel
      Left = 16
      Top = 72
      Width = 332
      Height = 201
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 40
      Top = 88
      Width = 67
      Height = 15
      Caption = 'Profile Type'
      Transparent = True
    end
    object Label3: TLabel
      Left = 192
      Top = 88
      Width = 62
      Height = 15
      Caption = 'Guide Type'
      Transparent = True
    end
    object Label4: TLabel
      Left = 40
      Top = 208
      Width = 39
      Height = 15
      Caption = 'Length'
      Transparent = True
    end
    object Label5: TLabel
      Left = 192
      Top = 208
      Width = 73
      Height = 15
      Caption = 'Item Number'
      Transparent = True
    end
    object Label6: TLabel
      Left = 64
      Top = 144
      Width = 61
      Height = 15
      Caption = 'Perforated'
      Transparent = True
    end
    object Label7: TLabel
      Left = 64
      Top = 176
      Width = 42
      Height = 15
      Caption = 'Clipped'
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 96
      Top = 16
      Width = 169
      Height = 41
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object btnSave: TDNMSpeedButton
      Left = 36
      Top = 288
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
      DisableTransparent = False
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
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 7
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 241
      Top = 288
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
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
      TabOrder = 9
      OnClick = btnCancelClick
    end
    object cboGuideType: TwwDBComboBox
      Left = 192
      Top = 104
      Width = 129
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'GuideType'
      DataSource = dsMain
      DropDownCount = 8
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Commercial'
        'Heavy Duty'
        'Reveal'
        'Surface')
      ItemIndex = 2
      ParentFont = False
      Sorted = False
      TabOrder = 4
      UnboundDataType = wwDefault
    end
    object edtLength: TwwDBEdit
      Left = 40
      Top = 224
      Width = 129
      Height = 23
      DataField = 'Length'
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtItemNumber: TwwDBEdit
      Left = 192
      Top = 224
      Width = 129
      Height = 23
      DataField = 'ItemNumber'
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object grpStandard: TwwRadioGroup
      Left = 192
      Top = 136
      Width = 129
      Height = 65
      TransparentActiveItem = True
      ShowGroupCaption = False
      Transparent = True
      Caption = 'Standard'
      DataField = 'Standard'
      DataSource = dsMain
      Items.Strings = (
        ' Standard'
        ' Reverse')
      TabOrder = 5
      Values.Strings = (
        'T'
        'F')
    end
    object btnNew: TDNMSpeedButton
      Left = 139
      Top = 288
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 8
      OnClick = btnNewClick
    end
    object chkPerforated: TwwCheckBox
      Left = 40
      Top = 144
      Width = 17
      Height = 17
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
      Caption = 'Perforated'
      DataField = 'Perforated'
      DataSource = dsMain
      TabOrder = 1
    end
    object chkClipped: TwwCheckBox
      Left = 40
      Top = 176
      Width = 17
      Height = 17
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
      Caption = 'Clipped'
      DataField = 'ShutterClipped'
      DataSource = dsMain
      TabOrder = 2
    end
  end
  object cboProfileType: TwwDBLookupCombo [3]
    Left = 40
    Top = 104
    Width = 129
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    DataField = 'ProfileType'
    DataSource = dsMain
    LookupTable = qryProfileType
    LookupField = 'ProfileType'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object qryMain: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrollaguidedata')
    Left = 40
    Top = 40
  end
  object qryProfileType: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrollaprofiletypes')
    Left = 72
    Top = 40
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 136
    Top = 40
  end
end
