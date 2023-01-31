inherited fmProdAttribCreateProducts: TfmProdAttribCreateProducts
  Left = 1002
  Top = 166
  HelpContext = 62000
  Caption = 'Product Attribute Create'
  ClientHeight = 403
  ClientWidth = 830
  Color = 16769217
  ExplicitLeft = 1002
  ExplicitTop = 166
  ExplicitWidth = 846
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 403
    Width = 830
    HelpContext = 62002
    ExplicitTop = 403
    ExplicitWidth = 830
  end
  object SubForm: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 830
    Height = 403
    HelpContext = 62001
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      826
      399)
    object Label46: TLabel
      Left = 39
      Top = 364
      Width = 53
      Height = 15
      HelpContext = 62003
      Caption = 'Select All'
      Transparent = True
      OnClick = chkSelectAllClick
    end
    object dbgAttribNewProducts: TwwDBGrid
      Left = 22
      Top = 18
      Width = 785
      Height = 336
      HelpContext = 62004
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnMultiSelectRecord = dbgAttribNewProductsMultiSelectRecord
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DSGrid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
      ParentFont = False
      ParentShowHint = False
      PopupMenu = mnuOptions
      ShowHint = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnKeyUp = dbgAttribNewProductsKeyUp
      OnMouseUp = dbgAttribNewProductsMouseUp
      FooterColor = clWhite
      FooterCellColor = clWhite
    end
    object btnCreate: TDNMSpeedButton
      Left = 311
      Top = 360
      Width = 199
      Height = 27
      HelpContext = 62005
      Anchors = [akBottom]
      Caption = 'Create Selected Products'
      Color = clWhite
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      Style = bsModern
      TabOrder = 1
      OnClick = btnCreateClick
    end
    object chkSelectAll: TCheckBox
      Left = 22
      Top = 364
      Width = 13
      Height = 17
      HelpContext = 62006
      TabOrder = 2
      OnClick = chkSelectAllClick
    end
  end
  object grdMemTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'AutoID'
        DataType = ftAutoInc
      end>
    IndexDefs = <>
    SortOptions = []
    Standalone = True
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = [foCaseInsensitive]
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 18
    Top = 5
  end
  object DSGrid: TDataSource
    DataSet = grdMemTable
    Left = 19
    Top = 35
  end
  object mnuOptions: TAdvPopupMenu
    Version = '2.5.3.4'
    Left = 198
    Top = 163
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      HelpContext = 62007
      OnClick = SelectAll1Click
    end
    object DeselectAll1: TMenuItem
      Caption = 'Deselect All'
      HelpContext = 62008
      OnClick = DeselectAll1Click
    end
  end
end
