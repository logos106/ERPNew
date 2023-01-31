inherited VATSelectionGUI: TVATSelectionGUI
  Left = 345
  Top = 173
  HelpContext = 549000
  BorderStyle = bsSingle
  Caption = 'Select'
  ClientHeight = 397
  ClientWidth = 580
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  OldCreateOrder = True
  Position = poDefault
  OnPaint = FormPaint
  ExplicitLeft = 345
  ExplicitTop = 173
  ExplicitWidth = 596
  ExplicitHeight = 435
  DesignSize = (
    580
    397)
  PixelsPerInch = 96
  TextHeight = 15
  object ActionLbl: TLabel
    Left = 20
    Top = 18
    Width = 36
    Height = 15
    HelpContext = 549001
    Caption = 'Select'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel
    Left = 338
    Top = 6
    Width = 43
    Height = 15
    HelpContext = 549002
    AutoSize = False
    Caption = 'Search '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object btnCompleted: TDNMSpeedButton
    Left = 108
    Top = 366
    Width = 87
    Height = 27
    HelpContext = 549003
    Anchors = [akBottom]
    Caption = 'O&K'
    Color = clWhite
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
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 0
    OnClick = btnCompletedClick
  end
  object btnClose: TDNMSpeedButton
    Left = 397
    Top = 366
    Width = 87
    Height = 27
    HelpContext = 549004
    Anchors = [akBottom]
    Caption = '&Cancel'
    Color = clWhite
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
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object List: TwwDBGrid
    Left = 19
    Top = 33
    Width = 540
    Height = 328
    HelpContext = 549005
    IniAttributes.Enabled = True
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    OnMultiSelectRecord = ListMultiSelectRecord
    FixedCols = 0
    ShowHorzScrollBar = True
    Color = clWhite
    DataSource = DSMain
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    FooterColor = clWhite
    FooterCellColor = clWhite
  end
  object edtSearch: TEdit
    Left = 380
    Top = 2
    Width = 177
    Height = 23
    HelpContext = 549006
    TabOrder = 3
    OnChange = edtSearchChange
  end
  object DSMain: TDataSource
    DataSet = qryMain
    Left = 218
    Top = 364
  end
  object qryMain: TERPQuery
    SQL.Strings = (
      'SELECT TaxCodeID,Name, Description, Rate, Active, EditedFlag  '
      'FROM tbltaxcodes'
      'Where RegionID= :xRegionID'
      '')
    Left = 253
    Top = 365
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
end
