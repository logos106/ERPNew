inherited frmImportExportSystem: TfrmImportExportSystem
  Left = 78
  Top = 160
  HelpContext = 293000
  Caption = 'Advanced Import / Export System'
  ClientHeight = 484
  ClientWidth = 972
  Menu = MainMenu1
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 293001
  end
  object DNMPanel3: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 972
    Height = 448
    HelpContext = 293002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      972
      448)
    object Label1: TLabel
      Left = 820
      Top = 163
      Width = 110
      Height = 19
      HelpContext = 293003
      Caption = 'Source Tables'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 50
      Top = 163
      Width = 131
      Height = 19
      HelpContext = 293004
      Caption = 'Platinum1 Tables'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 204
      Top = 163
      Width = 172
      Height = 19
      HelpContext = 293005
      Caption = 'Platinum1 Table Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 625
      Top = 163
      Width = 151
      Height = 19
      HelpContext = 293006
      Caption = 'Source Table Fields'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 430
      Top = 163
      Width = 111
      Height = 19
      HelpContext = 293007
      Caption = 'Mapped Fields'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 65
      Top = 50
      Width = 50
      Height = 15
      HelpContext = 293008
      Alignment = taRightJustify
      Caption = 'Options :'
      Transparent = True
    end
    object Label7: TLabel
      Left = 50
      Top = 104
      Width = 65
      Height = 15
      HelpContext = 293009
      Alignment = taRightJustify
      Caption = 'Import File :'
      Enabled = False
      Transparent = True
    end
    object Label14: TLabel
      Left = 60
      Top = 77
      Width = 55
      Height = 15
      HelpContext = 293010
      Alignment = taRightJustify
      Caption = 'File Type :'
      Enabled = False
      Transparent = True
    end
    object Label15: TLabel
      Left = 20
      Top = 131
      Width = 95
      Height = 15
      HelpContext = 293011
      Alignment = taRightJustify
      Caption = 'Template Name :'
      Enabled = False
      Transparent = True
    end
    object Label16: TLabel
      Left = 33
      Top = 24
      Width = 82
      Height = 15
      HelpContext = 293012
      Alignment = taRightJustify
      Caption = 'Configuration :'
      Transparent = True
    end
    object lsPlatinum1Tables: TListBox
      Left = 12
      Top = 184
      Width = 169
      Height = 258
      HelpContext = 293013
      Anchors = [akLeft, akTop, akBottom]
      ItemHeight = 15
      MultiSelect = True
      TabOrder = 7
      OnClick = lsPlatinum1TablesClick
    end
    object lbSourceTables: TListBox
      Left = 790
      Top = 184
      Width = 169
      Height = 258
      HelpContext = 293014
      Anchors = [akLeft, akTop, akBottom]
      Enabled = False
      ItemHeight = 15
      Sorted = True
      TabOrder = 8
    end
    object lsPlatinum1TableFields: TListBox
      Left = 182
      Top = 184
      Width = 177
      Height = 258
      HelpContext = 293015
      Anchors = [akLeft, akTop, akBottom]
      DragMode = dmAutomatic
      ItemHeight = 15
      Sorted = True
      TabOrder = 9
      OnDblClick = lbSourceTableFieldsDblClick
      OnDragOver = lsPlatinum1TableFieldsDragOver
    end
    object lbSourceTableFields: TListBox
      Left = 612
      Top = 184
      Width = 177
      Height = 258
      HelpContext = 293016
      Anchors = [akLeft, akTop, akBottom]
      DragMode = dmAutomatic
      Enabled = False
      ItemHeight = 15
      Sorted = True
      TabOrder = 10
      OnDblClick = lbSourceTableFieldsDblClick
      OnDragOver = lbSourceTableFieldsDragOver
      OnStartDrag = lbSourceTableFieldsStartDrag
    end
    object lbMappedFields: TListBox
      Left = 360
      Top = 184
      Width = 251
      Height = 258
      HelpContext = 293017
      Anchors = [akLeft, akTop, akBottom]
      DragMode = dmAutomatic
      Enabled = False
      ItemHeight = 15
      Sorted = True
      TabOrder = 11
      OnDragDrop = lbMappedFieldsDragDrop
      OnDragOver = lbMappedFieldsDragOver
      OnKeyUp = lbMappedFieldsKeyUp
    end
    object edtImportFile: TEdit
      Left = 120
      Top = 100
      Width = 241
      Height = 23
      HelpContext = 293018
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnSelectFile: TDNMSpeedButton
      Left = 363
      Top = 100
      Width = 22
      Height = 24
      HelpContext = 293019
      Caption = '...'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      OnClick = btnSelectFileClick
    end
    object cboOptions: TwwDBLookupCombo
      Left = 120
      Top = 46
      Width = 241
      Height = 23
      HelpContext = 293020
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupField = 'OptionType'
      Style = csDropDownList
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      ShowMatchText = True
      OnCloseUp = cboOptionsCloseUp
    end
    object cboFileType: TwwDBLookupCombo
      Left = 120
      Top = 73
      Width = 241
      Height = 23
      HelpContext = 293021
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupField = 'FileType'
      Style = csDropDownList
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      ShowMatchText = True
      OnCloseUp = cboFileTypeCloseUp
    end
    object cboTemplateType: TwwDBLookupCombo
      Left = 120
      Top = 127
      Width = 241
      Height = 23
      HelpContext = 293022
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupField = 'TemplateName'
      Style = csDropDownList
      DropDownWidth = 40
      Enabled = False
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      ShowMatchText = True
      OnCloseUp = cboTemplateTypeCloseUp
    end
    object btnTemplateEditor: TDNMSpeedButton
      Left = 363
      Top = 126
      Width = 22
      Height = 24
      HelpContext = 293023
      Caption = '...'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      OnClick = btnTemplateEditorClick
    end
    object cboConfiguration: TwwDBLookupCombo
      Left = 120
      Top = 20
      Width = 241
      Height = 23
      HelpContext = 293024
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupField = 'OptionType'
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      ShowMatchText = True
      OnCloseUp = cboConfigurationCloseUp
      OnKeyUp = cboConfigurationKeyUp
      OnNotInList = cboConfigurationNotInList
    end
  end
  object DNMPanel2: TDNMPanel [2]
    Left = 0
    Top = 448
    Width = 972
    Height = 36
    HelpContext = 293025
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      972
      36)
    object cmdClose: TDNMSpeedButton
      Left = 143
      Top = 4
      Width = 107
      Height = 28
      HelpContext = 293026
      Anchors = [akBottom]
      Caption = '&Close'
      Default = True
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
      OnClick = cmdCloseClick
    end
    object btnImport: TDNMSpeedButton
      Left = 281
      Top = 4
      Width = 107
      Height = 28
      HelpContext = 293027
      Anchors = [akBottom]
      Caption = '&Import Into Platinum1'
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnImportClick
    end
    object btnSaveConfig: TDNMSpeedButton
      Left = 420
      Top = 4
      Width = 107
      Height = 28
      HelpContext = 293028
      Anchors = [akBottom]
      Caption = '&Save Config'
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = btnSaveConfigClick
    end
    object btnExportXML: TDNMSpeedButton
      Left = 558
      Top = 4
      Width = 107
      Height = 28
      HelpContext = 293029
      Anchors = [akBottom]
      Caption = '&Export XML'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = oXML1Click
    end
    object btnExportCSV: TDNMSpeedButton
      Left = 696
      Top = 4
      Width = 107
      Height = 28
      HelpContext = 293030
      Anchors = [akBottom]
      Caption = '&Export CSV'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = oCSV1Click
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 544
    Top = 16
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 480
    Top = 16
  end
  inherited MyConnection: TERPConnection
    Left = 576
    Top = 15
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 124
    Top = 4
  end
  object MainMenu1: TMainMenu
    Left = 608
    Top = 16
    object General1: TMenuItem
      Caption = 'General'
      object emplate1: TMenuItem
        Caption = 'Template'
        object CreateNew1: TMenuItem
          Caption = 'Editor'
          ShortCut = 16453
          OnClick = CreateNew1Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Configurations1: TMenuItem
        Caption = 'Configurations'
        object Save1: TMenuItem
          Caption = 'Save'
          ShortCut = 16467
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Export1: TMenuItem
        Caption = 'Export'
        Enabled = False
        object oCSV1: TMenuItem
          Caption = 'To CSV'
          OnClick = oCSV1Click
        end
        object oXML1: TMenuItem
          Caption = 'To XML'
          OnClick = oXML1Click
        end
      end
      object Import1: TMenuItem
        Caption = 'Import into Platinum1'
        Enabled = False
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Caption = 'Close'
        OnClick = Close1Click
      end
    end
  end
  object MyXML: TXMLDocument
    Left = 640
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
end
