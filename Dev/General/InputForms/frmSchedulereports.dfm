inherited fmSchedulereports: TfmSchedulereports
  Left = 279
  Top = 133
  HelpContext = 1121002
  Caption = 'Report Scheduler'
  ClientHeight = 475
  ClientWidth = 996
  ExplicitLeft = 279
  ExplicitTop = 133
  ExplicitWidth = 1012
  ExplicitHeight = 514
  DesignSize = (
    996
    475)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 425
    Width = 996
    HelpContext = 1121003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 52
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
    Left = 119
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 50
    Width = 996
    Height = 375
    HelpContext = 1121008
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 56
    ExplicitWidth = 995
    object Label1: TLabel
      Left = 3
      Top = 13
      Width = 110
      Height = 15
      HelpContext = 1121009
      Caption = 'Report To Schedule'
    end
    object pgMain: TPageControl
      Left = 1
      Top = 34
      Width = 994
      Height = 340
      HelpContext = 1121010
      ActivePage = tabSchedule
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      RaggedRight = True
      TabHeight = 23
      TabOrder = 0
      TabWidth = 143
      OnChange = pgMainChange
      ExplicitLeft = 2
      object tabSchedule: TTabSheet
        HelpContext = 1121011
        Caption = 'Schedule Details'
        object pnloptions: TDNMPanel
          Left = 0
          Top = 0
          Width = 986
          Height = 307
          HelpContext = 1121012
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnExit = pnloptionsExit
          object grdemployees: TwwDBGrid
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 265
            Height = 299
            HelpContext = 1121013
            ControlType.Strings = (
              'Employeename;CustomEdit;cboEmployee;F'
              'Active;CheckBox;T;F')
            Selected.Strings = (
              'Employeename'#9'14'#9'Employee'#9'F'#9
              'NextDueDate'#9'12'#9'Next Date'#9#9
              'Active'#9'1'#9'Active'#9#9
              'SatAction'#9'1'#9'SatAction'#9#9
              'sunAction'#9'1'#9'sunAction'#9#9
              'HolidayAction'#9'1'#9'HolidayAction'#9#9
              'employeeListcaption'#9'255'#9'employeeListcaption'#9'F'#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
            Align = alLeft
            DataSource = dsReportSchedules
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = [dgAllowInsert]
            ParentFont = False
            TabOrder = 1
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            FooterColor = clWhite
            object grdemployeesIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 19
              Height = 22
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
              OnClick = grdemployeesIButtonClick
              HelpContext = 1121022
            end
          end
          object cboEmployee: TwwDBLookupCombo
            Left = 82
            Top = 96
            Width = 111
            Height = 23
            HelpContext = 1121014
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'25'#9'EmployeeName'#9'F')
            DataField = 'EmployeeName'
            LookupTable = cboEmployeeLookup
            LookupField = 'EmployeeName'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
            OnCloseUp = cboEmployeeCloseUp
          end
        end
      end
      object tabScheduledReports: TTabSheet
        HelpContext = 1121015
        Caption = 'All Scheduled Reports'
        ImageIndex = 1
        object pnlScheduledReprots: TDNMPanel
          Left = 0
          Top = 0
          Width = 986
          Height = 307
          HelpContext = 1121016
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnExit = pnloptionsExit
          object wwDBGrid1: TwwDBGrid
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 265
            Height = 299
            HelpContext = 1121017
            ControlType.Strings = (
              'Active;CheckBox;T;F')
            Selected.Strings = (
              'Employeename'#9'14'#9'Employee'
              'NextDueDate'#9'12'#9'Next Date'
              'Active'#9'1'#9'Active'
              'SatAction'#9'1'#9'SatAction'
              'sunAction'#9'1'#9'sunAction'
              'HolidayAction'#9'1'#9'HolidayAction'
              'employeeListcaption'#9'255'#9'employeeListcaption')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
            Align = alLeft
            DataSource = dsReportSchedules
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            OnEnter = wwDBGrid1Enter
            FooterColor = clWhite
          end
        end
      end
    end
    object wwDBEdit1: TwwDBEdit
      Left = 135
      Top = 6
      Width = 835
      Height = 23
      HelpContext = 1121018
      DataField = 'Description'
      DataSource = dsForms
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 425
    Width = 996
    Height = 50
    HelpContext = 1121019
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      996
      50)
    object cmdClose: TDNMSpeedButton
      Left = 361
      Top = 9
      Width = 93
      Height = 29
      HelpContext = 1121020
      Anchors = [akBottom]
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
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 552
      Top = 9
      Width = 93
      Height = 29
      HelpContext = 1121021
      Anchors = [akBottom]
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
      OnClick = cmdCancelClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 996
    Height = 50
    HelpContext = 1121004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      50)
    object pnlTitle: TDNMPanel
      Left = 295
      Top = 4
      Width = 409
      Height = 39
      HelpContext = 1121005
      Anchors = []
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
        Width = 407
        Height = 37
        HelpContext = 1121006
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
          Width = 407
          Height = 37
          HelpContext = 1121007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Report Scheduler'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 2
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 357
    Top = 231
  end
  inherited tmrdelay: TTimer
    Left = 503
    Top = 231
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 394
    Top = 231
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 539
    Top = 231
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Left = 576
    Top = 231
  end
  inherited DataState: TDataState
    Left = 430
    Top = 231
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 612
    Top = 231
  end
  inherited imgsort: TImageList
    Left = 467
    Top = 231
    Bitmap = {
      494C01010200C400D80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 321
    Top = 231
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 649
    Top = 231
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 688
    Top = 232
  end
  object QryForms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblforms')
    Left = 789
    Top = 223
    object QryFormsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblforms.GlobalRef'
      Size = 255
    end
    object QryFormsFormID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'FormID'
      Origin = 'tblforms.FormID'
    end
    object QryFormsFormName: TWideStringField
      FieldName = 'FormName'
      Origin = 'tblforms.FormName'
      Size = 50
    end
    object QryFormsBusinessObjectName: TWideStringField
      FieldName = 'BusinessObjectName'
      Origin = 'tblforms.BusinessObjectName'
      Size = 255
    end
    object QryFormsDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblforms.Description'
      Size = 50
    end
    object QryFormsTabGroup: TIntegerField
      FieldName = 'TabGroup'
      Origin = 'tblforms.TabGroup'
    end
    object QryFormsIsForm: TWideStringField
      FieldName = 'IsForm'
      Origin = 'tblforms.IsForm'
      FixedChar = True
      Size = 1
    end
    object QryFormsAccessLevels: TWideStringField
      FieldName = 'AccessLevels'
      Origin = 'tblforms.AccessLevels'
      FixedChar = True
      Size = 1
    end
    object QryFormsSkinsGroup: TWideStringField
      FieldName = 'SkinsGroup'
      Origin = 'tblforms.SkinsGroup'
      Size = 255
    end
    object QryFormsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblforms.msTimeStamp'
    end
    object QryFormsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblforms.msUpdateSiteCode'
      Size = 3
    end
  end
  object dsForms: TDataSource
    DataSet = QryForms
    Left = 789
    Top = 251
  end
  object dsReportSchedules: TDataSource
    DataSet = QryReportSchedules
    Left = 829
    Top = 251
  end
  object QryReportSchedules: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM `tblscheduledreports`')
    AfterInsert = QryReportSchedulesAfterInsert
    BeforePost = QryReportSchedulesBeforePost
    Left = 829
    Top = 223
    object QryReportSchedulesEmployeename: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 14
      FieldName = 'Employeename'
      Origin = 'tblscheduledreports.Employeename'
      Size = 100
    end
    object QryReportSchedulesNextDueDate: TDateTimeField
      DisplayLabel = 'Next Date'
      DisplayWidth = 12
      FieldName = 'NextDueDate'
      Origin = 'tblscheduledreports.NextDueDate'
    end
    object QryReportSchedulesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblscheduledreports.Active'
      FixedChar = True
      Size = 1
    end
    object QryReportSchedulesSatAction: TWideStringField
      DisplayWidth = 1
      FieldName = 'SatAction'
      Origin = 'tblscheduledreports.SatAction'
      FixedChar = True
      Size = 1
    end
    object QryReportSchedulessunAction: TWideStringField
      DisplayWidth = 1
      FieldName = 'sunAction'
      Origin = 'tblscheduledreports.sunAction'
      FixedChar = True
      Size = 1
    end
    object QryReportSchedulesHolidayAction: TWideStringField
      DisplayWidth = 1
      FieldName = 'HolidayAction'
      Origin = 'tblscheduledreports.HolidayAction'
      FixedChar = True
      Size = 1
    end
    object QryReportSchedulesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblscheduledreports.ID'
      Visible = False
    end
    object QryReportSchedulesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblscheduledreports.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryReportSchedulesFormID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FormID'
      Origin = 'tblscheduledreports.FormID'
      Visible = False
    end
    object QryReportSchedulesEmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeId'
      Origin = 'tblscheduledreports.EmployeeId'
      Visible = False
    end
    object QryReportSchedulesStartDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'StartDate'
      Origin = 'tblscheduledreports.StartDate'
      Visible = False
    end
    object QryReportSchedulesEndDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'EndDate'
      Origin = 'tblscheduledreports.EndDate'
      Visible = False
    end
    object QryReportSchedulesFrequency: TWideStringField
      DisplayWidth = 1
      FieldName = 'Frequency'
      Origin = 'tblscheduledreports.Frequency'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryReportSchedulesEvery: TIntegerField
      DisplayWidth = 10
      FieldName = 'Every'
      Origin = 'tblscheduledreports.Every'
      Visible = False
    end
    object QryReportSchedulesWeekDay: TIntegerField
      DisplayWidth = 10
      FieldName = 'WeekDay'
      Origin = 'tblscheduledreports.WeekDay'
      Visible = False
    end
    object QryReportSchedulesBeginFromOption: TWideStringField
      DisplayWidth = 1
      FieldName = 'BeginFromOption'
      Origin = 'tblscheduledreports.BeginFromOption'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryReportSchedulesmsUpdatesiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdatesiteCode'
      Origin = 'tblscheduledreports.msUpdatesiteCode'
      Visible = False
      Size = 3
    end
    object QryReportSchedulesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblscheduledreports.msTimeStamp'
      Visible = False
    end
    object QryReportSchedulesMonthDays: TIntegerField
      DisplayWidth = 10
      FieldName = 'MonthDays'
      Origin = 'tblscheduledreports.MonthDays'
      Visible = False
    end
    object QryReportSchedulesContinueIndefinitely: TWideStringField
      DisplayWidth = 1
      FieldName = 'ContinueIndefinitely'
      Origin = 'tblscheduledreports.ContinueIndefinitely'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryReportSchedulesLastEmaileddate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'LastEmaileddate'
      Origin = 'tblscheduledreports.LastEmaileddate'
      Visible = False
    end
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 859
    Top = 221
  end
end
