inherited fmSplitInvoicePayment: TfmSplitInvoicePayment
  Left = 292
  Top = 190
  HelpContext = 1245002
  Caption = 'Split Sale Payments'
  ClientHeight = 564
  ClientWidth = 779
  ExplicitLeft = 292
  ExplicitTop = 190
  ExplicitWidth = 795
  ExplicitHeight = 603
  DesignSize = (
    779
    564)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 348
    Width = 779
    HelpContext = 1245003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 95
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 205
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object lblMsg: TLabel [5]
    Left = 0
    Top = 348
    Width = 779
    Height = 15
    HelpContext = 1245004
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblMsg'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
    ExplicitTop = 346
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 113
    Width = 779
    Height = 235
    HelpContext = 1245005
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object grdPayments: TwwDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 771
      Height = 227
      HelpContext = 1245006
      ControlType.Strings = (
        'Apply;CheckBox;T;F'
        'IsCreditcard;CheckBox;T;F'
        'PayMethod;CustomEdit;cboPaymentMethod;F')
      Selected.Strings = (
        'ForeignExchangeCode'#9'15'#9'Currency'#9'T'#9
        'ForeignExchangeRate'#9'10'#9'Rate'#9#9
        'ForeignCurrencyAmount'#9'20'#9'Amount In~Currency'#9#9
        'PayMethod'#9'15'#9'Payment Method'#9#9
        'Amount'#9'20'#9'Amount in~Base Currency'#9#9
        'Percentage'#9'19'#9'Percentage of~Sale Amount'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = 16776176
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = dsSplitMaymentLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      ParentFont = False
      PopupMenu = mnugrdPayments
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnDblClick = grdPaymentsDblClick
      FooterColor = 16776176
      object grdPaymentsIButton: TwwIButton
        Left = -1
        Top = 0
        Width = 22
        Height = 35
        HelpContext = 1245007
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
        OnClick = grdPaymentsIButtonClick
      end
    end
    object cboPaymentMethod: TwwDBLookupCombo
      Left = 339
      Top = 124
      Width = 160
      Height = 23
      HelpContext = 1245008
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'IsCreditCard;CheckBox;T;F')
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'PaymentMethod'#9'20'#9'Name'#9'F'
        'IsCreditCard'#9'1'#9'Credit Card?'#9'F')
      DataField = 'PayMethod'
      DataSource = dsSplitMaymentLines
      LookupTable = qryPayMethod
      LookupField = 'PaymentMethod'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboForeignCurrencyCode: TwwDBLookupCombo
      Left = 35
      Top = 129
      Width = 98
      Height = 24
      HelpContext = 1245009
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Code'#9'3'#9'Code'#9#9)
      DataField = 'ForeignExchangeCode'
      LookupTable = qryForeignCurrency
      LookupField = 'Code'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 2
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 779
    Height = 59
    HelpContext = 1245010
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      779
      59)
    object pnlTitle: TDNMPanel
      Left = 162
      Top = 9
      Width = 456
      Height = 39
      HelpContext = 1245011
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 454
        Height = 37
        HelpContext = 1245012
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
          Width = 454
          Height = 37
          HelpContext = 1245013
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Split Sale Payments'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 171
        end
      end
    end
  end
  object DNMPanel4: TDNMPanel [8]
    Left = 0
    Top = 59
    Width = 779
    Height = 54
    HelpContext = 1245014
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      779
      54)
    object Label81: TLabel
      Left = 348
      Top = 6
      Width = 208
      Height = 16
      HelpContext = 1245015
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Bank Account'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitLeft = 221
    end
    object lblVariationAccount: TLabel
      Left = 565
      Top = 6
      Width = 208
      Height = 16
      HelpContext = 1245016
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Variation Account'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitLeft = 438
    end
    object ClassLabel: TLabel
      Left = 5
      Top = 6
      Width = 208
      Height = 16
      HelpContext = 1245017
      AutoSize = False
      Caption = 'Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object cboClass: TwwDBLookupCombo
      Left = 5
      Top = 28
      Width = 201
      Height = 23
      HelpContext = 1245018
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Class Name'#9'T')
      DataField = 'ClassID'
      DataSource = dsSplitPayments
      LookupTable = cboClassQry
      LookupField = 'ClassID'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAccount: TwwDBLookupCombo
      Left = 348
      Top = 28
      Width = 201
      Height = 23
      HelpContext = 1245019
      TabStop = False
      Anchors = [akTop, akRight]
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'20'#9'Account Name'#9'T'
        'Type'#9'20'#9'Type'#9'T')
      DataField = 'AccountID'
      DataSource = dsSplitPayments
      LookupTable = cboAccountQry
      LookupField = 'AccountID'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboVariationAccount: TwwDBLookupCombo
      Left = 565
      Top = 28
      Width = 201
      Height = 23
      HelpContext = 1245020
      Anchors = [akTop, akRight]
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'50'#9'AccountName'#9#9)
      DataField = 'ForeignVariationAccountID'
      DataSource = dsSplitPayments
      LookupTable = qryVariationAccount
      LookupField = 'AccountID'
      DropDownWidth = 150
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object DNMPanel5: TDNMPanel [9]
    Left = 0
    Top = 363
    Width = 779
    Height = 160
    HelpContext = 1245021
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      779
      160)
    object Label28: TLabel
      Left = 4
      Top = 9
      Width = 45
      Height = 15
      HelpContext = 1245022
      AutoSize = False
      Caption = 'Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Notes: TDBMemo
      AlignWithMargins = True
      Left = 4
      Top = 31
      Width = 388
      Height = 125
      HelpContext = 1245023
      Margins.Top = 30
      Align = alClient
      Color = clWhite
      DataField = 'Notes'
      DataSource = dsSplitPayments
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = NotesEnter
      OnExit = NotesExit
    end
    object btnAddDate: TDNMSpeedButton
      Left = 327
      Top = 11
      Width = 64
      Height = 15
      HelpContext = 1245024
      Anchors = [akTop, akRight]
      Caption = 'Add Date'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnAddDateClick
    end
    object pnlFC: TDNMPanel
      Left = 645
      Top = 1
      Width = 133
      Height = 158
      HelpContext = 1245025
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object DBText1: TDBText
        Left = 2
        Top = 1
        Width = 127
        Height = 17
        HelpContext = 1245026
        Alignment = taCenter
        DataField = 'ForeignExchangeCode'
        DataSource = dsSales
      end
      object DBEdit4: TDBEdit
        Left = 2
        Top = 24
        Width = 126
        Height = 23
        HelpContext = 1245027
        TabStop = False
        Color = clWhite
        DataField = 'ForeignTotalAmount'
        DataSource = dsSales
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit5: TDBEdit
        Left = 2
        Top = 50
        Width = 126
        Height = 23
        HelpContext = 1245028
        TabStop = False
        Color = clWhite
        DataField = 'ForeignPaidAmount'
        DataSource = dsSales
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit6: TDBEdit
        Left = 2
        Top = 76
        Width = 126
        Height = 23
        HelpContext = 1245029
        TabStop = False
        Color = clWhite
        DataField = 'ForeignBalanceAmount'
        DataSource = dsSales
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object pnltotals: TDNMPanel
      Left = 395
      Top = 1
      Width = 250
      Height = 158
      HelpContext = 1245030
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object lblLocalcurency: TLabel
        Left = 110
        Top = 3
        Width = 127
        Height = 15
        HelpContext = 1245031
        Alignment = taCenter
        AutoSize = False
        Caption = 'AUD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 37
        Top = 28
        Width = 55
        Height = 15
        HelpContext = 1245032
        Alignment = taRightJustify
        Caption = 'Sale Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 67
        Top = 54
        Width = 25
        Height = 15
        HelpContext = 1245033
        Alignment = taRightJustify
        Caption = 'Paid'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 4
        Top = 80
        Width = 88
        Height = 15
        HelpContext = 1245034
        Alignment = taRightJustify
        Caption = 'Total To be Paid'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label44: TLabel
        Left = 34
        Top = 106
        Width = 58
        Height = 19
        HelpContext = 1245035
        Alignment = taRightJustify
        Caption = 'Applied'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label36: TLabel
        Left = 36
        Top = 135
        Width = 56
        Height = 15
        HelpContext = 1245036
        Alignment = taRightJustify
        Caption = 'Unapplied'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 110
        Top = 24
        Width = 127
        Height = 23
        HelpContext = 1245037
        DataField = 'TotalAmountInc'
        DataSource = dsSales
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
      object wwDBEdit2: TwwDBEdit
        Left = 110
        Top = 50
        Width = 127
        Height = 23
        HelpContext = 1245038
        DataField = 'Payment'
        DataSource = dsSales
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit3: TwwDBEdit
        Left = 110
        Top = 76
        Width = 127
        Height = 23
        HelpContext = 1245039
        DataField = 'Balance'
        DataSource = dsSales
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit4: TwwDBEdit
        Left = 96
        Top = 102
        Width = 141
        Height = 27
        HelpContext = 1245040
        DataField = 'TotalApplied'
        DataSource = dsSplitPayments
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit5: TwwDBEdit
        Left = 110
        Top = 131
        Width = 127
        Height = 23
        HelpContext = 1245041
        DataField = 'TotalUnApplied'
        DataSource = dsSplitPayments
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
  end
  object DNMPanel3: TDNMPanel [10]
    Left = 0
    Top = 523
    Width = 779
    Height = 41
    HelpContext = 1245042
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object cmdClose: TDNMSpeedButton
      Left = 279
      Top = 5
      Width = 93
      Height = 29
      HelpContext = 1245043
      Caption = '&Save'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 406
      Top = 5
      Width = 93
      Height = 29
      HelpContext = 1245044
      Cancel = True
      Caption = '&Cancel'
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 151
    Top = 13
  end
  inherited tmrdelay: TTimer
    Left = 316
    Top = 13
  end
  inherited popSpelling: TPopupMenu
    Left = 118
    Top = 13
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 184
    Top = 13
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 349
    Top = 13
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 24
    Top = 79
  end
  inherited DataState: TDataState
    Left = 250
    Top = 13
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 382
    Top = 13
  end
  inherited imgsort: TImageList
    Left = 283
    Top = 13
    Bitmap = {
      494C01010200F800140110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 85
    Top = 13
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 415
    Top = 13
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 217
    Top = 13
  end
  inherited qryMemTrans: TERPQuery
    Left = 52
    Top = 13
  end
  object QrySplitPayments: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsplitpayments '
      'Where SplitPaymentID  =:ID;')
    Left = 24
    Top = 199
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QrySplitPaymentsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblsplitpayments.GlobalRef'
      Size = 255
    end
    object QrySplitPaymentsSplitPaymentID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SplitPaymentID'
      Origin = 'tblsplitpayments.SplitPaymentID'
    end
    object QrySplitPaymentsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblsplitpayments.EmployeeID'
    end
    object QrySplitPaymentsEmployee: TWideStringField
      DisplayWidth = 1
      FieldName = 'Employee'
      Origin = 'tblsplitpayments.Employee'
      FixedChar = True
      Size = 1
    end
    object QrySplitPaymentsEnteredAt: TDateTimeField
      DisplayWidth = 18
      FieldName = 'EnteredAt'
      Origin = 'tblsplitpayments.EnteredAt'
    end
    object QrySplitPaymentsSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tblsplitpayments.SaleID'
    end
    object QrySplitPaymentsPaymentDate: TDateField
      DisplayWidth = 10
      FieldName = 'PaymentDate'
      Origin = 'tblsplitpayments.PaymentDate'
    end
    object QrySplitPaymentsAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Origin = 'tblsplitpayments.Amount'
    end
    object QrySplitPaymentsNotes: TWideStringField
      DisplayWidth = 255
      FieldName = 'Notes'
      Origin = 'tblsplitpayments.Notes'
      Size = 255
    end
    object QrySplitPaymentsClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tblsplitpayments.ClassID'
    end
    object QrySplitPaymentsAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblsplitpayments.AccountID'
    end
    object QrySplitPaymentsForeignVariationAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ForeignVariationAccountID'
      Origin = 'tblsplitpayments.ForeignVariationAccountID'
    end
    object QrySplitPaymentsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblsplitpayments.msTimeStamp'
    end
    object QrySplitPaymentsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsplitpayments.msUpdateSiteCode'
      Size = 3
    end
    object QrySplitPaymentsTotalApplied: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalApplied'
      currency = True
      Calculated = True
    end
    object QrySplitPaymentsTotalUnApplied: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUnApplied'
      currency = True
      Calculated = True
    end
  end
  object dsSplitPayments: TDataSource
    DataSet = QrySplitPayments
    Left = 23
    Top = 235
  end
  object QrySplitMaymentLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM `tblsplitpaymentlines` '
      'Where `SplitPaymentID`  =:ID;')
    Filtered = True
    Filter = 'Deleted = '#39'F'#39
    Left = 72
    Top = 199
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QrySplitMaymentLinesForeignExchangeCode: TWideStringField
      DisplayLabel = 'Currency'
      DisplayWidth = 15
      FieldName = 'ForeignExchangeCode'
      Origin = 'tblsplitpaymentlines.ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object QrySplitMaymentLinesForeignExchangeRate: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldName = 'ForeignExchangeRate'
      Origin = 'tblsplitpaymentlines.ForeignExchangeRate'
    end
    object QrySplitMaymentLinesForeignCurrencyAmount: TFloatField
      DisplayLabel = 'Amount In~Currency'
      DisplayWidth = 20
      FieldName = 'ForeignCurrencyAmount'
      Origin = 'tblsplitpaymentlines.ForeignCurrencyAmount'
      DisplayFormat = '###,###,###,##0.00'
    end
    object QrySplitMaymentLinesPayMethod: TWideStringField
      DisplayLabel = 'Payment Method'
      DisplayWidth = 15
      FieldName = 'PayMethod'
      Origin = 'tblsplitpaymentlines.PayMethod'
      Size = 100
    end
    object QrySplitMaymentLinesAmount: TFloatField
      DisplayLabel = 'Amount in~Base Currency'
      DisplayWidth = 20
      FieldName = 'Amount'
      Origin = 'tblsplitpaymentlines.Amount'
      currency = True
    end
    object QrySplitMaymentLinesPercentage: TFloatField
      DisplayLabel = 'Percentage of~Sale Amount'
      DisplayWidth = 19
      FieldName = 'Percentage'
      Origin = 'tblsplitpaymentlines.Percentage'
      DisplayFormat = '##0.0#%'
    end
    object QrySplitMaymentLinesCardholdersName: TWideStringField
      DisplayWidth = 20
      FieldName = 'CardholdersName'
      Origin = 'tblsplitpaymentlines.CardholdersName'
      Visible = False
      Size = 50
    end
    object QrySplitMaymentLinesCreditCardNumber: TWideStringField
      DisplayWidth = 20
      FieldName = 'CreditCardNumber'
      Origin = 'tblsplitpaymentlines.CreditCardNumber'
      Visible = False
      Size = 50
    end
    object QrySplitMaymentLinesCreditCardExpDate: TDateField
      DisplayWidth = 10
      FieldName = 'CreditCardExpDate'
      Origin = 'tblsplitpaymentlines.CreditCardExpDate'
      Visible = False
    end
    object QrySplitMaymentLinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblsplitpaymentlines.GlobalRef'
      Visible = False
      Size = 255
    end
    object QrySplitMaymentLinesSplitPaymentLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SplitPaymentLineID'
      Origin = 'tblsplitpaymentlines.SplitPaymentLineID'
      Visible = False
    end
    object QrySplitMaymentLinesSplitPaymentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SplitPaymentID'
      Origin = 'tblsplitpaymentlines.SplitPaymentID'
      Visible = False
    end
    object QrySplitMaymentLinesPayMethodID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayMethodID'
      Origin = 'tblsplitpaymentlines.PayMethodID'
      Visible = False
    end
    object QrySplitMaymentLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblsplitpaymentlines.msTimeStamp'
      Visible = False
    end
    object QrySplitMaymentLinesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsplitpaymentlines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object QrySplitPaymentlinesReferenceNo: TWideStringField
      DisplayWidth = 50
      FieldName = 'ReferenceNo'
      Origin = 'tblsplitpaymentlines.ReferenceNo'
      Visible = False
      Size = 50
    end
    object QrySplitPaymentlinesBankAccountName: TWideStringField
      DisplayWidth = 255
      FieldName = 'BankAccountName'
      Origin = 'tblsplitpaymentlines.BankAccountName'
      Visible = False
      Size = 255
    end
    object QrySplitPaymentlinesBankAccountBSB: TWideStringField
      DisplayWidth = 7
      FieldName = 'BankAccountBSB'
      Origin = 'tblsplitpaymentlines.BankAccountBSB'
      Visible = False
      Size = 7
    end
    object QrySplitPaymentlinesBankAccountNo: TWideStringField
      DisplayWidth = 10
      FieldName = 'BankAccountNo'
      Origin = 'tblsplitpaymentlines.BankAccountNo'
      Visible = False
      Size = 10
    end
    object QrySplitMaymentLinesdeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'deleted'
      Origin = 'tblsplitpaymentlines.deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsSplitMaymentLines: TDataSource
    DataSet = QrySplitMaymentLines
    Left = 71
    Top = 235
  end
  object qryPayMethod: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PayMethodID, Name as PaymentMethod,IsCreditCard'
      'FROM tblpaymentmethods where Active ="T" '
      'Order By Name')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 162
    Top = 202
    object qryPayMethodPaymentMethod: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'PaymentMethod'
      Origin = 'tblpaymentmethods.NAME'
      Size = 255
    end
    object qryPayMethodIsCreditCard: TWideStringField
      DisplayLabel = 'Credit Card?'
      DisplayWidth = 1
      FieldName = 'IsCreditCard'
      Origin = 'tblpaymentmethods.IsCreditCard'
      FixedChar = True
      Size = 1
    end
    object qryPayMethodPayMethodID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PayMethodID'
      Origin = 'tblpaymentmethods.PayMethodID'
      Visible = False
    end
  end
  object qryVariationAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*'
      'FROM tblChartofAccounts'
      
        'WHERE (AccountType = '#39'EXP'#39' or AccountType = '#39'EXEXP'#39') AND Active ' +
        '= '#39'T'#39
      'AND IsHeader = '#39'F'#39
      'Order By AccountName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 201
    Top = 202
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 235
    Top = 201
  end
  object cboAccountQry: TERPQuery
    SQL.Strings = (
      'SELECT tblChartofAccounts.* ,AccDesc as Type'
      'FROM tblChartofAccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      'WHERE (Active = '#39'T'#39' OR AccountID=:CurrentID) AND IsHeader = '#39'F'#39
      'Order By AccDesc,AccountName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 275
    Top = 201
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CurrentID'
      end>
  end
  object qryForeignCurrency: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate , Active  '
      'FROM tblcurrencyconversion'
      'Where BuyRate <>0;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 115
    Top = 208
  end
  object QrySales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsales'
      'where saleId =:saleID')
    Left = 312
    Top = 207
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'saleID'
      end>
    object QrySalesSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
    end
    object QrySalesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsales.GlobalRef'
      Size = 255
    end
    object QrySalesInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Origin = 'tblsales.InvoiceDocNumber'
      Size = 30
    end
    object QrySalesOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Origin = 'tblsales.OriginalNo'
      Size = 255
    end
    object QrySalesBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Origin = 'tblsales.BaseNo'
      Size = 255
    end
    object QrySalesAccount: TWideStringField
      FieldName = 'Account'
      Origin = 'tblsales.Account'
      Size = 255
    end
    object QrySalesAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblsales.AccountID'
    end
    object QrySalesBOID: TWideStringField
      FieldName = 'BOID'
      Origin = 'tblsales.BOID'
      Size = 255
    end
    object QrySalesCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tblsales.CustomerName'
      Size = 255
    end
    object QrySalesClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblsales.ClientID'
    end
    object QrySalesInvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Origin = 'tblsales.InvoiceTo'
      Size = 255
    end
    object QrySalesShipTo: TWideStringField
      FieldName = 'ShipTo'
      Origin = 'tblsales.ShipTo'
      Size = 255
    end
    object QrySalesPickupFromID: TIntegerField
      FieldName = 'PickupFromID'
      Origin = 'tblsales.PickupFromID'
    end
    object QrySalesPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Origin = 'tblsales.PickupFrom'
      Size = 255
    end
    object QrySalesSaleDate: TDateField
      FieldName = 'SaleDate'
      Origin = 'tblsales.SaleDate'
    end
    object QrySalesTotalTax: TFloatField
      FieldName = 'TotalTax'
      Origin = 'tblsales.TotalTax'
    end
    object QrySalesTotalWETTax: TFloatField
      FieldName = 'TotalWETTax'
      Origin = 'tblsales.TotalWETTax'
    end
    object QrySalesTotalWEGTax: TFloatField
      FieldName = 'TotalWEGTax'
      Origin = 'tblsales.TotalWEGTax'
    end
    object QrySalesTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      Origin = 'tblsales.TotalAmount'
      currency = True
    end
    object QrySalesTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
      Origin = 'tblsales.TotalAmountInc'
      currency = True
    end
    object QrySalesTotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
      Origin = 'tblsales.TotalMarkup'
    end
    object QrySalesTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
      Origin = 'tblsales.TotalDiscount'
    end
    object QrySalesEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblsales.EmployeeName'
      Size = 255
    end
    object QrySalesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblsales.EmployeeID'
    end
    object QrySalesClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblsales.ClassID'
    end
    object QrySalesClass: TWideStringField
      FieldName = 'Class'
      Origin = 'tblsales.Class'
      Size = 255
    end
    object QrySalesOrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Origin = 'tblsales.OrderNumber'
      Size = 30
    end
    object QrySalesPONumber: TWideStringField
      FieldName = 'PONumber'
      Origin = 'tblsales.PONumber'
      Size = 30
    end
    object QrySalesChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Origin = 'tblsales.ChequeNo'
      Size = 45
    end
    object QrySalesShipDate: TDateField
      FieldName = 'ShipDate'
      Origin = 'tblsales.ShipDate'
    end
    object QrySalesFutureSO: TWideStringField
      FieldName = 'FutureSO'
      Origin = 'tblsales.FutureSO'
      FixedChar = True
      Size = 1
    end
    object QrySalesDueDate: TDateField
      FieldName = 'DueDate'
      Origin = 'tblsales.DueDate'
    end
    object QrySalesConNote: TWideStringField
      FieldName = 'ConNote'
      Origin = 'tblsales.ConNote'
      Size = 25
    end
    object QrySalesMemo: TWideMemoField
      FieldName = 'Memo'
      Origin = 'tblsales.Memo'
      BlobType = ftWideMemo
    end
    object QrySalesComments: TWideMemoField
      FieldName = 'Comments'
      Origin = 'tblsales.Comments'
      BlobType = ftWideMemo
    end
    object QrySalesInvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Origin = 'tblsales.InvoicePrintDesc'
      Size = 255
    end
    object QrySalesPickMemo: TWideMemoField
      FieldName = 'PickMemo'
      Origin = 'tblsales.PickMemo'
      BlobType = ftWideMemo
    end
    object QrySalesPrintHold: TWideStringField
      FieldName = 'PrintHold'
      Origin = 'tblsales.PrintHold'
      FixedChar = True
      Size = 1
    end
    object QrySalesShipping: TWideStringField
      FieldName = 'Shipping'
      Origin = 'tblsales.Shipping'
      Size = 255
    end
    object QrySalesTerms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblsales.Terms'
      Size = 255
    end
    object QrySalesPayMethod: TWideStringField
      FieldName = 'PayMethod'
      Origin = 'tblsales.PayMethod'
      Size = 50
    end
    object QrySalesPayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Origin = 'tblsales.PayDueDate'
      Size = 11
    end
    object QrySalesPaid: TWideStringField
      FieldName = 'Paid'
      Origin = 'tblsales.Paid'
      FixedChar = True
      Size = 1
    end
    object QrySalesBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblsales.Balance'
      currency = True
    end
    object QrySalesSOBalance: TFloatField
      FieldName = 'SOBalance'
      Origin = 'tblsales.SOBalance'
    end
    object QrySalesPayment: TFloatField
      FieldName = 'Payment'
      Origin = 'tblsales.Payment'
      currency = True
    end
    object QrySalesApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      Origin = 'tblsales.ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object QrySalesAmountDue: TFloatField
      FieldName = 'AmountDue'
      Origin = 'tblsales.AmountDue'
    end
    object QrySalesTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Origin = 'tblsales.TimeOfSale'
      Size = 15
    end
    object QrySalesIsPOS: TWideStringField
      FieldName = 'IsPOS'
      Origin = 'tblsales.IsPOS'
      FixedChar = True
      Size = 1
    end
    object QrySalesPOS: TWideStringField
      FieldName = 'POS'
      Origin = 'tblsales.POS'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsRefund: TWideStringField
      FieldName = 'IsRefund'
      Origin = 'tblsales.IsRefund'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      Origin = 'tblsales.IsCashSale'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      Origin = 'tblsales.IsInvoice'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsQuote: TWideStringField
      FieldName = 'IsQuote'
      Origin = 'tblsales.IsQuote'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      Origin = 'tblsales.IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      Origin = 'tblsales.IsVoucher'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsLayby: TWideStringField
      FieldName = 'IsLayby'
      Origin = 'tblsales.IsLayby'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      Origin = 'tblsales.IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      Origin = 'tblsales.IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsCustomerReturn: TWideStringField
      FieldName = 'IsCustomerReturn'
      Origin = 'tblsales.IsCustomerReturn'
      FixedChar = True
      Size = 1
    end
    object QrySalesDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblsales.Deleted'
      FixedChar = True
      Size = 1
    end
    object QrySalesCancelled: TWideStringField
      FieldName = 'Cancelled'
      Origin = 'tblsales.Cancelled'
      FixedChar = True
      Size = 1
    end
    object QrySalesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblsales.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QrySalesTotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
      Origin = 'tblsales.TotalQuoteAmount'
    end
    object QrySalesLaybyID: TWideStringField
      FieldName = 'LaybyID'
      Origin = 'tblsales.LaybyID'
      Size = 14
    end
    object QrySalesDeposited: TWideStringField
      FieldName = 'Deposited'
      Origin = 'tblsales.Deposited'
      FixedChar = True
      Size = 1
    end
    object QrySalesTillID: TSmallintField
      FieldName = 'TillID'
      Origin = 'tblsales.TillID'
    end
    object QrySalesHoldSale: TWideStringField
      FieldName = 'HoldSale'
      Origin = 'tblsales.HoldSale'
      FixedChar = True
      Size = 1
    end
    object QrySalesSaleConfirmed: TWideStringField
      FieldName = 'SaleConfirmed'
      Origin = 'tblsales.SaleConfirmed'
      FixedChar = True
      Size = 1
    end
    object QrySalesFreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      Origin = 'tblsales.FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object QrySalesConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblsales.Converted'
      FixedChar = True
      Size = 1
    end
    object QrySalesEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Origin = 'tblsales.EnteredBy'
      Size = 255
    end
    object QrySalesEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Origin = 'tblsales.EnteredAt'
      Size = 255
    end
    object QrySalesCommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      Origin = 'tblsales.CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object QrySalesIsManifest: TWideStringField
      FieldName = 'IsManifest'
      Origin = 'tblsales.IsManifest'
      FixedChar = True
      Size = 1
    end
    object QrySalesUsedOnManifest: TWideStringField
      FieldName = 'UsedOnManifest'
      Origin = 'tblsales.UsedOnManifest'
      FixedChar = True
      Size = 1
    end
    object QrySalesAddToManifest: TWideStringField
      FieldName = 'AddToManifest'
      Origin = 'tblsales.AddToManifest'
      FixedChar = True
      Size = 1
    end
    object QrySalesSalesOrderGlobalRef: TWideStringField
      FieldName = 'SalesOrderGlobalRef'
      Origin = 'tblsales.SalesOrderGlobalRef'
      Size = 255
    end
    object QrySalesQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Origin = 'tblsales.QuoteGlobalRef'
      Size = 255
    end
    object QrySalesRepairGlobalRef: TWideStringField
      FieldName = 'RepairGlobalRef'
      Origin = 'tblsales.RepairGlobalRef'
      Size = 255
    end
    object QrySalesSOProgressPaymentGlobalRef: TWideStringField
      FieldName = 'SOProgressPaymentGlobalRef'
      Origin = 'tblsales.SOProgressPaymentGlobalRef'
      Size = 255
    end
    object QrySalesSOProgressPaymentOriginalRef: TWideStringField
      FieldName = 'SOProgressPaymentOriginalRef'
      Origin = 'tblsales.SOProgressPaymentOriginalRef'
      Size = 255
    end
    object QrySalesIsBarcodePicking: TWideStringField
      FieldName = 'IsBarcodePicking'
      Origin = 'tblsales.IsBarcodePicking'
      FixedChar = True
      Size = 1
    end
    object QrySalesBarcodePickingDone: TWideStringField
      FieldName = 'BarcodePickingDone'
      Origin = 'tblsales.BarcodePickingDone'
      FixedChar = True
      Size = 1
    end
    object QrySalesARNotes: TWideMemoField
      FieldName = 'ARNotes'
      Origin = 'tblsales.ARNotes'
      BlobType = ftWideMemo
    end
    object QrySalesOriginalCreationDate: TDateField
      FieldName = 'OriginalCreationDate'
      Origin = 'tblsales.OriginalCreationDate'
    end
    object QrySalesQuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Origin = 'tblsales.QuoteStatus'
      Size = 255
    end
    object QrySalesDespatchID: TIntegerField
      FieldName = 'DespatchID'
      Origin = 'tblsales.DespatchID'
    end
    object QrySalesRunID: TIntegerField
      FieldName = 'RunID'
      Origin = 'tblsales.RunID'
    end
    object QrySalesRunName: TWideStringField
      FieldName = 'RunName'
      Origin = 'tblsales.RunName'
      Size = 255
    end
    object QrySalesReference: TWideStringField
      FieldName = 'Reference'
      Origin = 'tblsales.Reference'
      Size = 255
    end
    object QrySalesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblsales.msTimeStamp'
    end
    object QrySalesPOCreated: TWideStringField
      FieldName = 'POCreated'
      Origin = 'tblsales.POCreated'
      FixedChar = True
      Size = 1
    end
    object QrySalesLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblsales.LastUpdated'
    end
    object QrySalesForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      Origin = 'tblsales.ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object QrySalesForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      Origin = 'tblsales.ForeignExchangeRate'
    end
    object QrySalesForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
      Origin = 'tblsales.ForeignTotalAmount'
    end
    object QrySalesForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
      Origin = 'tblsales.ForeignPaidAmount'
    end
    object QrySalesForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
      Origin = 'tblsales.ForeignBalanceAmount'
    end
    object QrySalesIsGeneratedFromHire: TWideStringField
      FieldName = 'IsGeneratedFromHire'
      Origin = 'tblsales.IsGeneratedFromHire'
      FixedChar = True
      Size = 1
    end
    object QrySalesBlindBalancePeriodID: TIntegerField
      FieldName = 'BlindBalancePeriodID'
      Origin = 'tblsales.BlindBalancePeriodID'
    end
    object QrySalesSaleDateTime: TDateTimeField
      FieldName = 'SaleDateTime'
      Origin = 'tblsales.SaleDateTime'
    end
    object QrySalesAutoSmartOrderRef: TWideStringField
      FieldName = 'AutoSmartOrderRef'
      Origin = 'tblsales.AutoSmartOrderRef'
      Size = 255
    end
    object QrySalesIsInternalOrder: TWideStringField
      FieldName = 'IsInternalOrder'
      Origin = 'tblsales.IsInternalOrder'
      FixedChar = True
      Size = 1
    end
    object QrySalesShippingCost: TFloatField
      FieldName = 'ShippingCost'
      Origin = 'tblsales.ShippingCost'
    end
    object QrySalescontactID: TLargeintField
      FieldName = 'contactID'
      Origin = 'tblsales.contactID'
    end
    object QrySalesContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'tblsales.ContactName'
      Size = 100
    end
    object QrySalesPOSPostCode: TWideStringField
      FieldName = 'POSPostCode'
      Origin = 'tblsales.POSPostCode'
      Size = 4
    end
    object QrySalesRepairID: TLargeintField
      FieldName = 'RepairID'
      Origin = 'tblsales.RepairID'
    end
    object QrySalesMedtypeID: TIntegerField
      FieldName = 'MedtypeID'
      Origin = 'tblsales.MedtypeID'
    end
    object QrySalesMedtype: TWideStringField
      FieldName = 'Medtype'
      Origin = 'tblsales.Medtype'
      Size = 100
    end
    object QrySalesNoOfBoxes: TLargeintField
      FieldName = 'NoOfBoxes'
      Origin = 'tblsales.NoOfBoxes'
    end
    object QrySalesContributionAmount: TFloatField
      FieldName = 'ContributionAmount'
      Origin = 'tblsales.ContributionAmount'
    end
    object QrySalesShipToID: TIntegerField
      FieldName = 'ShipToID'
      Origin = 'tblsales.ShipToID'
    end
    object QrySalesSalesCategory: TWideStringField
      FieldName = 'SalesCategory'
      Origin = 'tblsales.SalesCategory'
      Size = 255
    end
    object QrySalesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsales.msUpdateSiteCode'
      Size = 3
    end
    object QrySalesCustomerReturnRef: TWideStringField
      FieldName = 'CustomerReturnRef'
      Origin = 'tblsales.CustomerReturnRef'
      Size = 255
    end
    object QrySalesSOInvoiced: TWideStringField
      FieldName = 'SOInvoiced'
      Origin = 'tblsales.SOInvoiced'
      FixedChar = True
      Size = 1
    end
    object QrySalesSOInvoiceRef: TWideStringField
      FieldName = 'SOInvoiceRef'
      Origin = 'tblsales.SOInvoiceRef'
      Size = 255
    end
    object QrySalesArea: TWideStringField
      FieldName = 'Area'
      Origin = 'tblsales.Area'
      Size = 50
    end
  end
  object dsSales: TDataSource
    DataSet = QrySales
    Left = 311
    Top = 243
  end
  object mnugrdPayments: TAdvPopupMenu
    OnPopup = mnugrdPaymentsPopup
    Version = '2.5.3.4'
    Left = 542
    Top = 184
    object mnuLoadFromLastTransactionForCustomer: TMenuItem
      Caption = 'Load From Last Transaction For the Customer'
      HelpContext = 1245045
      OnClick = LoadFromLastTransactionForCustomer
    end
  end
end
