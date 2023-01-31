object fmEDIMapEdit: TfmEDIMapEdit
  Left = 0
  Top = 0
  Caption = 'Map Edit'
  ClientHeight = 320
  ClientWidth = 705
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    705
    320)
  PixelsPerInch = 96
  TextHeight = 15
  object btnSave: TDNMSpeedButton
    Left = 250
    Top = 285
    Width = 87
    Height = 27
    HelpContext = 1063005
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
    Left = 368
    Top = 285
    Width = 87
    Height = 27
    HelpContext = 1063006
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
  object grpSource: TGroupBox
    Left = 8
    Top = 16
    Width = 337
    Height = 249
    Caption = 'Source'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object lblSourceDataType: TLabel
      Left = 226
      Top = 15
      Width = 99
      Height = 15
      Alignment = taRightJustify
      Caption = 'Source Data Type'
    end
    object chkSourceInputFile: TCheckBox
      Left = 16
      Top = 39
      Width = 89
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Input Field'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = chkSourceInputFileClick
    end
    object chkSourceValue: TCheckBox
      Left = 16
      Top = 72
      Width = 89
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Fixed Value'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = chkSourceValueClick
    end
    object edtSourceValue: TEdit
      Left = 120
      Top = 69
      Width = 209
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'edtSourceValue'
      OnChange = edtSourceValueChange
    end
    object cboSourceCol: TwwDBComboBox
      Left = 120
      Top = 36
      Width = 205
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      DropDownCount = 8
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'disp 1'#9'1'
        'disp 2'#9'2')
      ParentFont = False
      Sorted = False
      TabOrder = 3
      UnboundDataType = wwDefault
      OnChange = cboSourceColChange
    end
    object pagesSourceFormula: TPageControl
      Left = 16
      Top = 98
      Width = 313
      Height = 143
      ActivePage = pgReplaceString
      TabOrder = 4
      object pgReplaceString: TTabSheet
        Caption = 'Replace String'
        object pnlStringReplace: TDNMPanel
          Left = 0
          Top = 0
          Width = 305
          Height = 113
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object lblSearchFor: TLabel
            Left = 16
            Top = 46
            Width = 62
            Height = 15
            Caption = 'Search For'
          end
          object lblReplaceWith: TLabel
            Left = 16
            Top = 79
            Width = 75
            Height = 15
            Caption = 'Replace With'
          end
          object chkStringReplace: TCheckBox
            Left = 16
            Top = 12
            Width = 161
            Height = 17
            Caption = 'Use String Replace'
            TabOrder = 0
            OnClick = chkStringReplaceClick
          end
          object edtSearchString: TEdit
            Left = 100
            Top = 43
            Width = 77
            Height = 23
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'edtSearchString'
            OnChange = edtSearchStringChange
          end
          object edtReplaceString: TEdit
            Left = 100
            Top = 76
            Width = 77
            Height = 23
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = 'edtReplaceString'
            OnChange = edtReplaceStringChange
          end
          object chkReplaceAll: TCheckBox
            Left = 200
            Top = 44
            Width = 89
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Replace All'
            TabOrder = 3
            OnClick = chkReplaceAllClick
          end
          object chkIgnoreCase: TCheckBox
            Left = 200
            Top = 79
            Width = 89
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Ignore Case'
            TabOrder = 4
            OnClick = chkIgnoreCaseClick
          end
        end
      end
      object pgFilter: TTabSheet
        Caption = 'Filter'
        ImageIndex = 1
        object pnlFilter: TDNMPanel
          Left = 0
          Top = 0
          Width = 305
          Height = 113
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object chkMapWhenNotBlank: TCheckBox
            Left = 16
            Top = 20
            Width = 185
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Only Map if Not Blank or Zero'
            TabOrder = 0
            OnClick = chkMapWhenNotBlankClick
          end
        end
      end
      object tsDefaultValue: TTabSheet
        Caption = 'Default Value'
        ImageIndex = 2
        object pnlDefaultValue: TDNMPanel
          Left = 0
          Top = 0
          Width = 305
          Height = 113
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object Label1: TLabel
            Left = 16
            Top = 46
            Width = 74
            Height = 15
            Caption = 'Default Value'
          end
          object chkUseDefaultWhenBlank: TCheckBox
            Left = 16
            Top = 12
            Width = 161
            Height = 17
            Caption = 'Use Default When Blank'
            TabOrder = 0
            OnClick = chkUseDefaultWhenBlankClick
          end
          object edtDefaultValue: TEdit
            Left = 100
            Top = 43
            Width = 125
            Height = 23
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'edtDefaultValue'
            OnChange = edtDefaultValueChange
          end
        end
      end
    end
  end
  object grpTarget: TGroupBox
    Left = 359
    Top = 16
    Width = 337
    Height = 249
    Caption = 'Target'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object lblTargetType: TLabel
      Left = 233
      Top = 15
      Width = 94
      Height = 15
      Alignment = taRightJustify
      Caption = 'Target Data Type'
    end
    object cboTarget: TwwDBLookupCombo
      Left = 16
      Top = 36
      Width = 311
      Height = 23
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = tblTarget
      LookupField = 'Name'
      Options = [loTitles]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboTargetChange
    end
    object pagesTargetFormula: TPageControl
      Left = 16
      Top = 98
      Width = 313
      Height = 143
      ActivePage = pgSeparator
      TabOrder = 1
      object pgSeparator: TTabSheet
        Caption = 'Separator'
        object pnlSeparator: TDNMPanel
          Left = 0
          Top = 0
          Width = 305
          Height = 113
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object lblSeparateWith: TLabel
            Left = 16
            Top = 46
            Width = 79
            Height = 15
            Caption = 'Separate with'
          end
          object chkSeparator: TCheckBox
            Left = 16
            Top = 12
            Width = 161
            Height = 17
            Caption = 'Separate New Data'
            TabOrder = 0
            OnClick = chkSeparatorClick
          end
          object cboSeparator: TComboBox
            Left = 112
            Top = 43
            Width = 145
            Height = 23
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = cboSeparatorChange
            Items.Strings = (
              'New Line'
              'Space')
          end
        end
      end
    end
  end
  object tblTarget: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 496
    Top = 280
  end
end
