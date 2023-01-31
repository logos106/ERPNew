inherited fmTasks: TfmTasks
  Left = 890
  Top = 213
  HelpContext = 880001
  Caption = 'Tasks'
  ClientHeight = 562
  ClientWidth = 510
  ExplicitLeft = 890
  ExplicitTop = 213
  ExplicitWidth = 526
  ExplicitHeight = 601
  DesignSize = (
    510
    562)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 508
    Width = 510
    HelpContext = 880002
    ExplicitTop = 329
    ExplicitWidth = 451
  end
  inherited shapehint: TShape
    Left = 14
    ExplicitLeft = 14
  end
  inherited shapehintextra1: TShape
    Left = 62
    ExplicitLeft = 61
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 508
    Width = 510
    Height = 54
    HelpContext = 880022
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      510
      54)
    object btnSave: TDNMSpeedButton
      Left = 79
      Top = 15
      Width = 87
      Height = 27
      HelpContext = 880023
      Anchors = []
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
      Kind = bkOK
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnNew: TDNMSpeedButton
      Left = 211
      Top = 15
      Width = 87
      Height = 27
      HelpContext = 880024
      Anchors = []
      Caption = '&New'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      OnClick = btnNewClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 344
      Top = 14
      Width = 86
      Height = 28
      HelpContext = 880025
      Anchors = []
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
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object chkActive: TwwCheckBox
      Left = 440
      Top = 20
      Width = 55
      Height = 15
      HelpContext = 880035
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Active'
      DataField = 'Active'
      DataSource = dsTasks
      TabOrder = 3
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 510
    Height = 62
    HelpContext = 880003
    Align = alTop
    BevelEdges = [beLeft, beTop, beRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      510
      62)
    object lblID: TLabel
      Left = 411
      Top = 10
      Width = 21
      Height = 15
      HelpContext = 880027
      Alignment = taRightJustify
      Caption = 'ID #'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 122
      Top = 9
      Width = 267
      Height = 42
      HelpContext = 880004
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Invoice'
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
        Width = 265
        Height = 40
        HelpContext = 880005
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
          Width = 265
          Height = 40
          HelpContext = 880006
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Task'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -1
          ExplicitTop = 5
          ExplicitWidth = 206
        end
      end
    end
    object edtID: TwwDBEdit
      Left = 411
      Top = 27
      Width = 95
      Height = 23
      HelpContext = 880033
      DataField = 'ID'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 62
    Width = 510
    Height = 446
    HelpContext = 880007
    Align = alClient
    BevelEdges = [beLeft, beRight, beBottom]
    BevelOuter = bvSpace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      510
      446)
    object Label2: TLabel
      Left = 38
      Top = 56
      Width = 43
      Height = 15
      HelpContext = 880009
      Alignment = taRightJustify
      Caption = 'Version'
      Transparent = True
    end
    object SaleDate_Label: TLabel
      Left = 46
      Top = 89
      Width = 35
      Height = 18
      HelpContext = 880010
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel
      Left = 13
      Top = 155
      Width = 68
      Height = 15
      HelpContext = 880011
      Alignment = taRightJustify
      Caption = 'Seq/Subject'
      Transparent = True
    end
    object Label4: TLabel
      Left = 42
      Top = 209
      Width = 39
      Height = 15
      HelpContext = 880012
      Alignment = taRightJustify
      Caption = 'Details'
      Transparent = True
    end
    object Label5: TLabel
      Left = 326
      Top = 258
      Width = 57
      Height = 30
      HelpContext = 880013
      Alignment = taRightJustify
      Caption = 'Time Estimated'
      Transparent = True
      WordWrap = True
    end
    object Label6: TLabel
      Left = 290
      Top = 295
      Width = 98
      Height = 15
      HelpContext = 880014
      Alignment = taRightJustify
      Caption = 'Percentage Done'
      Transparent = True
    end
    object Label7: TLabel
      Left = 257
      Top = 320
      Width = 48
      Height = 15
      HelpContext = 880026
      Alignment = taRightJustify
      Anchors = [akTop]
      Caption = 'Modules'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblHelp: TLabel
      Left = 351
      Top = 91
      Width = 39
      Height = 15
      HelpContext = 880042
      Alignment = taRightJustify
      Caption = 'Help ID'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 29
      Top = 253
      Width = 52
      Height = 30
      HelpContext = 880028
      Alignment = taRightJustify
      Caption = 'Refrence Link'
      Transparent = True
      WordWrap = True
    end
    object Label9: TLabel
      Left = 25
      Top = 122
      Width = 56
      Height = 15
      HelpContext = 880037
      Alignment = taRightJustify
      Caption = 'Customer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 93
      Top = 320
      Width = 73
      Height = 15
      HelpContext = 880040
      Alignment = taRightJustify
      Anchors = [akTop]
      Caption = 'Attachments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 8
      Top = 295
      Width = 73
      Height = 15
      HelpContext = 880043
      Alignment = taRightJustify
      Caption = 'ERP PDF Doc'
      Transparent = True
    end
    object wwDBGrid1: TwwDBGrid
      Left = 255
      Top = 341
      Width = 239
      Height = 99
      HelpContext = 880029
      ControlType.Strings = (
        'PageName;CustomEdit;cboPagename;F'
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'PageName'#9'22'#9'PageName'#9'F'
        'Active'#9'1'#9'Active'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsTasksPages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = wwDBGrid1CalcCellColors
      OnDblClick = wwDBGrid1DblClick
      FooterColor = clWhite
      object wwDBGrid1IButton: TwwIButton
        Left = 0
        Top = 0
        Width = 18
        Height = 22
        HelpContext = 880030
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
        OnClick = wwDBGrid1IButtonClick
      end
    end
    object opttype: TwwRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 1
      Width = 502
      Height = 44
      HelpContext = 880015
      Margins.Top = 0
      Margins.Bottom = 0
      DisableThemes = False
      Align = alTop
      Caption = 'Type'
      Columns = 2
      DataField = 'Tasktype'
      DataSource = dsTasks
      Items.Strings = (
        'Feature'
        'Bug')
      TabOrder = 0
      Values.Strings = (
        'Feature'
        'Bug')
    end
    object edtVersion: TwwDBEdit
      Left = 92
      Top = 52
      Width = 296
      Height = 23
      HelpContext = 880016
      DataField = 'VersionNo'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
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
    object cboCreationDate: TwwDBDateTimePicker
      Left = 92
      Top = 87
      Width = 206
      Height = 23
      HelpContext = 880017
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'CreatedOn'
      DataSource = dsTasks
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 3
    end
    object edName: TwwDBEdit
      Left = 149
      Top = 151
      Width = 345
      Height = 23
      HelpContext = 880018
      DataField = 'Subject'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object DBMemo1: TDBMemo
      Left = 92
      Top = 186
      Width = 402
      Height = 61
      HelpContext = 880019
      DataField = 'Details'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 8
    end
    object wwDBEdit1: TwwDBEdit
      Left = 394
      Top = 262
      Width = 95
      Height = 23
      HelpContext = 880020
      DataField = 'EstimatedHrs'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit2: TwwDBEdit
      Left = 394
      Top = 291
      Width = 95
      Height = 23
      HelpContext = 880021
      DataField = 'Percentagedone'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboPagename: TwwDBLookupCombo
      Left = 257
      Top = 381
      Width = 133
      Height = 23
      HelpContext = 880031
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Pagename'#9'30'#9'Pagename'#9'F')
      DataField = 'Pagename'
      DataSource = dsTasksPages
      LookupTable = QryPagenames
      LookupField = 'Pagename'
      ParentFont = False
      TabOrder = 13
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = wwDBGrid1DblClick
    end
    object btnVideo: TDNMSpeedButton
      Left = 394
      Top = 50
      Width = 100
      Height = 27
      HelpContext = 880032
      Action = actVideo
      Caption = 'Video'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
    end
    object edtHelp: TwwDBEdit
      Left = 396
      Top = 89
      Width = 95
      Height = 23
      HelpContext = 880044
      DataField = 'HelpContextID'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit3: TwwDBEdit
      Left = 92
      Top = 257
      Width = 183
      Height = 23
      HelpContext = 880034
      DataField = 'HyperlinkText'
      DataSource = dsTasks
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cbocustomer: TwwDBLookupCombo
      Left = 92
      Top = 118
      Width = 402
      Height = 23
      HelpContext = 880038
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'50'#9'Company'#9'F')
      DataField = 'CustomerName'
      DataSource = dsTasks
      LookupTable = QryCustomer
      LookupField = 'Company'
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = wwDBGrid1DblClick
    end
    object edTaskNo: TwwDBEdit
      Left = 92
      Top = 151
      Width = 55
      Height = 23
      HelpContext = 880039
      DataField = 'TaskNo'
      DataSource = dsTasks
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
    object pnlAttachments: TPanel
      Left = 93
      Top = 341
      Width = 158
      Height = 99
      HelpContext = 880041
      TabOrder = 14
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 92
      Top = 291
      Width = 183
      Height = 23
      HelpContext = 880045
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'20'#9'Description'#9'F')
      DataField = 'erphelpdocDesc'
      DataSource = dsTasks
      LookupTable = qryERPHelpDocs
      LookupField = 'Description'
      ParentFont = False
      TabOrder = 15
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = wwDBGrid1DblClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 283
    Top = 305
  end
  inherited tmrdelay: TTimer
    Left = 316
    Top = 305
  end
  inherited popSpelling: TPopupMenu
    Left = 218
    Top = 277
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 155
    Top = 305
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 282
    Top = 277
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 90
    Top = 277
  end
  inherited DataState: TDataState
    Left = 251
    Top = 305
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 250
    Top = 277
  end
  inherited imgsort: TImageList
    Left = 187
    Top = 305
    Bitmap = {
      494C01010200A800DC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 186
    Top = 277
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 219
    Top = 305
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 315
    Top = 277
  end
  inherited qryMemTrans: TERPQuery
    Connection = MyConnection
    Left = 154
    Top = 277
  end
  object QryTasks: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblTasks'
      'WHERE ID = :ID')
    AfterOpen = QryTasksAfterOpen
    AfterInsert = QryTasksAfterInsert
    AfterPost = QryTasksAfterPost
    Left = 122
    Top = 277
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QryTasksGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tbltasks.GlobalRef'
      Size = 255
    end
    object QryTasksID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tbltasks.ID'
    end
    object QryTasksTasktype: TWideStringField
      FieldName = 'Tasktype'
      Origin = 'tbltasks.Tasktype'
      Size = 50
    end
    object QryTasksVersionNo: TWideStringField
      FieldName = 'VersionNo'
      Origin = 'tbltasks.VersionNo'
      Size = 50
    end
    object QryTasksCreatedOn: TDateTimeField
      FieldName = 'CreatedOn'
      Origin = 'tbltasks.CreatedOn'
    end
    object QryTasksEnteredByID: TIntegerField
      FieldName = 'EnteredByID'
      Origin = 'tbltasks.EnteredByID'
    end
    object QryTasksEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Origin = 'tbltasks.EnteredBy'
      Size = 50
    end
    object QryTasksSubject: TWideStringField
      FieldName = 'Subject'
      Origin = 'tbltasks.Subject'
      Size = 50
    end
    object QryTasksDetails: TWideMemoField
      FieldName = 'Details'
      Origin = 'tbltasks.Details'
      BlobType = ftWideMemo
    end
    object QryTaskserphelpdocDesc: TWideStringField
      FieldName = 'erphelpdocDesc'
      Origin = 'tbltasks.erphelpdocDesc'
    end
    object QryTasksEstimatedHrs: TFloatField
      FieldName = 'EstimatedHrs'
      Origin = 'tbltasks.EstimatedHrs'
    end
    object QryTasksPercentagedone: TFloatField
      FieldName = 'Percentagedone'
      Origin = 'tbltasks.Percentagedone'
    end
    object QryTasksmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
      Origin = 'tbltasks.mstimeStamp'
    end
    object QryTasksmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tbltasks.msUpdateSiteCode'
      Size = 3
    end
    object QryTasksHelpcontextID: TIntegerField
      FieldName = 'HelpcontextID'
      Origin = 'tbltasks.HelpcontextID'
    end
    object QryTasksActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tbltasks.Active'
      FixedChar = True
      Size = 1
    end
    object QryTasksHyperlinkText: TWideStringField
      FieldName = 'HyperlinkText'
      Size = 255
    end
    object QryTasksCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 100
    end
    object QryTasksClientCode: TWideStringField
      FieldName = 'ClientCode'
      Size = 5
    end
    object QryTasksSeqno: TIntegerField
      FieldName = 'Seqno'
    end
    object QryTasksTaskNo: TIntegerField
      FieldName = 'TaskNo'
    end
  end
  object dsTasks: TDataSource
    DataSet = QryTasks
    Left = 122
    Top = 305
  end
  object QryPagenames: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select Modulename as Pagename  from tblerpModules order by pagen' +
        'ame')
    Options.LongStrings = False
    Left = 376
    Top = 278
    object QryPagenamesPagename: TWideStringField
      DisplayWidth = 30
      FieldName = 'Pagename'
      Size = 255
    end
  end
  object ActionList1: TActionList
    Left = 304
    Top = 142
    object actVideo: TDNMAction
      Category = 'DNMAction'
      Caption = 'Video'
      HelpContext = 880036
      OnExecute = actVideoExecute
      OnUpdate = actVideoUpdate
      buttoncolor = clWhite
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'wfs'
    Filter = 'MP4|*.Mp4|AVI|*.AVi'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Choose the Workflow Files'
    Left = 176
    Top = 128
  end
  object QryTaskPages: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblTasksPages'
      'WHERE ID = :ID')
    AfterOpen = QryTasksAfterOpen
    Left = 346
    Top = 277
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QryTaskPagesPageName: TWideStringField
      DisplayWidth = 22
      FieldName = 'PageName'
      Origin = 'tbltaskspages.PageName'
      Size = 40
    end
    object QryTaskPagesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltaskspages.Active'
      FixedChar = True
      Size = 1
    end
    object QryTaskPagesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbltaskspages.ID'
      Visible = False
    end
    object QryTaskPagesGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tbltaskspages.Globalref'
      Visible = False
      Size = 255
    end
    object QryTaskPagesTaskID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TaskID'
      Origin = 'tbltaskspages.TaskID'
      Visible = False
    end
    object QryTaskPagesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tbltaskspages.msTimeStamp'
      Visible = False
    end
    object QryTaskPagesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tbltaskspages.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsTasksPages: TDataSource
    DataSet = QryTaskPages
    Left = 346
    Top = 305
  end
  object QryCustomer: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select distinct Company, ClientCode from tblclients where custom' +
        'er ="T" and active ="T" order by  Company')
    Options.LongStrings = False
    Left = 408
    Top = 278
    object QryCustomerCompany: TWideStringField
      DisplayWidth = 50
      FieldName = 'Company'
      Size = 160
    end
    object QryCustomerClientCode: TWideStringField
      FieldName = 'ClientCode'
      Visible = False
      Size = 5
    end
  end
  object qryERPHelpDocs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select'
      'Description as Description,'
      'Filetype as Filetype'
      'from erpdocumentaion.tblhelpdocs'
      'Order by Description')
    Options.LongStrings = False
    Left = 440
    Top = 278
    object qryERPHelpDocsDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Size = 255
    end
    object qryERPHelpDocsFiletype: TWideStringField
      DisplayWidth = 4
      FieldName = 'Filetype'
      Visible = False
      FixedChar = True
      Size = 4
    end
  end
end
