inherited BasSelectionGUI: TBasSelectionGUI
  Left = 314
  Top = 152
  HelpContext = 42000
  BorderStyle = bsSingle
  Caption = 'Select'
  ClientHeight = 472
  ClientWidth = 580
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  OldCreateOrder = True
  Position = poDefault
  OnPaint = FormPaint
  ExplicitLeft = 314
  ExplicitTop = 152
  ExplicitWidth = 596
  ExplicitHeight = 511
  DesignSize = (
    580
    472)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 472
    Width = 580
    HelpContext = 42007
    ExplicitTop = 472
    ExplicitWidth = 580
  end
  object ActionLbl: TLabel [1]
    Left = 20
    Top = 18
    Width = 36
    Height = 15
    HelpContext = 42001
    Caption = 'Select'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel [2]
    Left = 338
    Top = 6
    Width = 43
    Height = 15
    HelpContext = 42002
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
  object lblSelected: TLabel [3]
    Left = 21
    Top = 271
    Width = 53
    Height = 15
    HelpContext = 42008
    Caption = 'Selected '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object edtSearch: TEdit [7]
    Left = 380
    Top = 2
    Width = 177
    Height = 23
    HelpContext = 42006
    TabOrder = 3
    OnChange = edtSearchChange
  end
  object grdSelected: TwwDBGrid [8]
    Left = 19
    Top = 285
    Width = 540
    Height = 147
    HelpContext = 42009
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    OnRowChanged = grdSelectedRowChanged
    FixedCols = 0
    ShowHorzScrollBar = True
    Color = clWhite
    DataSource = dsSelected
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clNavy
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    IndicatorIconColor = clYellow
    FooterColor = clWhite
    FooterCellColor = clWhite
    object grdSelectedIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 16
      Height = 22
      HelpContext = 42010
      AllowAllUp = True
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
        636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
        7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
        00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
        FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
        000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
        D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
        0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
        FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
        D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
        00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
        00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
        0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
        E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
        AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
        07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
        0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
        00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
        FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
        FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
        007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
        CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
        0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
        FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
        1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
        C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
        D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
        E0E3FFFFFFFFFFFF0000}
      OnClick = grdSelectedIButtonClick
    end
  end
  object List: TwwDBGrid [9]
    Left = 19
    Top = 33
    Width = 540
    Height = 232
    HelpContext = 42005
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
    OnMouseUp = ListMouseUp
    FooterColor = clWhite
    FooterCellColor = clWhite
  end
  object btnClose: TDNMSpeedButton [10]
    Left = 397
    Top = 441
    Width = 87
    Height = 27
    HelpContext = 42004
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
    AutoDisableParentOnclick = True
    OnClick = btnCloseClick
  end
  object btnCompleted: TDNMSpeedButton [11]
    Left = 108
    Top = 441
    Width = 87
    Height = 27
    HelpContext = 42003
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
    AutoDisableParentOnclick = True
    OnClick = btnCompletedClick
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
      'order by TaxCodeID')
    Left = 253
    Top = 365
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object dsSelected: TDataSource
    DataSet = QrySelected
    Left = 298
    Top = 364
  end
  object QrySelected: TERPQuery
    SQL.Strings = (
      'SELECT TaxCodeID,Name, Description, Rate, Active, EditedFlag  '
      'FROM tbltaxcodes')
    AfterScroll = QrySelectedAfterScroll
    Left = 333
    Top = 365
  end
end
