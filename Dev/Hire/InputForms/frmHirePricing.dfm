inherited fmHirePricing: TfmHirePricing
  Left = 400
  Top = 202
  HelpContext = 1333002
  ClientHeight = 354
  ClientWidth = 975
  ExplicitLeft = 400
  ExplicitTop = 202
  ExplicitWidth = 991
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 354
    Width = 975
    HelpContext = 1333003
    ExplicitTop = 160
    ExplicitWidth = 665
  end
  object pnlHirePricing: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 975
    Height = 354
    HelpContext = 1333004
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlPricing: TDNMPanel
      Left = 1
      Top = 1
      Width = 282
      Height = 352
      HelpContext = 1333005
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 16
        Width = 274
        Height = 15
        HelpContext = 1333006
        Margins.Top = 15
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Minimum Hire Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 118
      end
      object edtMinHirePeriod: TwwDBEdit
        Left = 128
        Top = 12
        Width = 53
        Height = 23
        HelpContext = 1333007
        DataField = 'MinHirePeriod'
        DataSource = dsPartHirePricing
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cboMinHirePeriodType: TwwDBComboBox
        Left = 187
        Top = 12
        Width = 93
        Height = 23
        HelpContext = 1333008
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DataField = 'MinHirePeriodType'
        DataSource = dsPartHirePricing
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Hours'#9'H'
          'Days'#9'D'
          'Weeks'#9'W'
          'Months'#9'M'
          'Years'#9'Y')
        ParentFont = False
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
      end
      object grdRates: TwwDBGrid
        AlignWithMargins = True
        Left = 4
        Top = 68
        Width = 274
        Height = 280
        HelpContext = 1333009
        ControlType.Strings = (
          'Active;CheckBox;T;F'
          'DurationName;CustomEdit;cboDuration;F')
        Selected.Strings = (
          'DurationName'#9'15'#9'Duration'#9'F'#9
          'Rate'#9'10'#9'Rate'#9'F'#9
          'Active'#9'1'#9'Active'#9#9)
        MemoAttributes = [mSizeable, mWordWrap, mGridShow]
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = dsPartHirePricingLines
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgAllowInsert]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
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
        FooterColor = clWhite
        FooterCellColor = clWhite
        PaintOptions.BackgroundOptions = [coBlendFixedRow]
        object btnDelete: TwwIButton
          Left = -1
          Top = 0
          Width = 22
          Height = 22
          HelpContext = 1333010
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
          Layout = blGlyphBottom
          OnClick = btnDeleteClick
        end
      end
      object cboDuration: TwwDBLookupCombo
        Left = 87
        Top = 99
        Width = 88
        Height = 23
        HelpContext = 1333011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'20'#9'Description'#9'F'
          'Qty'#9'10'#9'Qty'#9'F'
          'DurationType'#9'1'#9'Type'#9'F')
        DataField = 'DurationName'
        LookupTable = Qryduration
        LookupField = 'Description'
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboDurationCloseUp
      end
      object btncopyfromProduct: TDNMSpeedButton
        AlignWithMargins = True
        Left = 129
        Top = 39
        Width = 149
        Height = 23
        Hint = 'Choose to copy the Prcie from Product Card'
        HelpContext = 1333012
        Margins.Left = 128
        Align = alTop
        Caption = 'Copy Product Pricing'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 4
        OnClick = btncopyfromProductClick
      end
    end
    object pnlhistoryTab: TDNMPanel
      Left = 283
      Top = 1
      Width = 691
      Height = 352
      HelpContext = 1333013
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object pnlhistory: TDNMPanel
        Left = 1
        Top = 1
        Width = 689
        Height = 350
        HelpContext = 1333014
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 113
    Top = 144
  end
  inherited tmrdelay: TTimer
    Left = 180
    Top = 144
  end
  inherited popSpelling: TPopupMenu
    Left = 213
    Top = 144
  end
  inherited tmrdelayMsg: TTimer
    Left = 146
    Top = 144
  end
  object dsPartHirePricing: TDataSource
    Left = 247
    Top = 144
  end
  object dsPartHirePricingLines: TDataSource
    Left = 279
    Top = 144
  end
  object Qryduration: TERPQuery
    SQL.Strings = (
      'Select * from tblduration Where active ="T" order by Description')
    Left = 367
    Top = 150
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 8
    Top = 119
  end
end
