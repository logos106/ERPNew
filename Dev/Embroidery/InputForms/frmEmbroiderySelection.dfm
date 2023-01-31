inherited EmbroiderySelectionGUI: TEmbroiderySelectionGUI
  Left = 290
  Top = 238
  Caption = 'Embroidery Selection'
  ClientHeight = 406
  ClientWidth = 418
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    Left = 40
    Top = 40
  end
  object grdMain: TwwDBGrid [1]
    Left = 16
    Top = 72
    Width = 388
    Height = 281
    Selected.Strings = (
      'ProductName'#9'39'#9'Product Name'#9'T'
      'Qty'#9'10'#9'Qty'#9'T')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWindow
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsMain
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    object grdMainIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 21
      Height = 22
      AllowAllUp = True
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
      NumGlyphs = 2
      Spacing = 1
      OnClick = grdMainIButtonClick
    end
  end
  object btnCancel: TDNMSpeedButton [2]
    Left = 257
    Top = 368
    Width = 87
    Height = 27
    Cancel = True
    Caption = 'Cancel'
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
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnSave: TDNMSpeedButton [3]
    Left = 77
    Top = 368
    Width = 87
    Height = 27
    Caption = 'Save'
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
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object pnlTitle: TDNMPanel [4]
    Left = 49
    Top = 6
    Width = 329
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 325
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
        Width = 325
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Embroidery Selection'
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
  inherited DataState: TDataState
    Top = 40
  end
  object qryMain: TMyQuery
    SQL.Strings = (
      
        'SELECT sl.ProductName AS ProductName, sl.ProductID AS ProductID,' +
        ' sl.UnitofMeasureQtySold AS Qty'
      'FROM tblsaleslines sl'
      'INNER JOIN tblparts p ON sl.ProductID = p.PartsID'
      
        'WHERE (sl.SaleID = :SaleID) AND (p.Embroidery = '#39'F'#39') AND (sl.Del' +
        'eted = '#39'F'#39')')
    Left = 104
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'SaleID'
        Size = -1
        Value = ''
      end>
    object qryMainProductName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 39
      FieldName = 'ProductName'
      Origin = 'tblsaleslines.ProductName'
      Size = 60
    end
    object qryMainQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblsaleslines.Qty'
    end
    object qryMainProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblsaleslines.ProductID'
      Visible = False
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 72
    Top = 40
  end
end
