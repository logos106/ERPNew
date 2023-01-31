inherited frmToDo: TfrmToDo
  Left = 119
  Top = 140
  HelpContext = 360000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Items To Do'
  ClientHeight = 501
  ClientWidth = 795
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 119
  ExplicitTop = 140
  ExplicitWidth = 811
  ExplicitHeight = 540
  DesignSize = (
    795
    501)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 452
    Width = 795
    HelpContext = 360027
    ExplicitTop = 328
    ExplicitWidth = 795
  end
  inherited imgGridWatermark: TImage
    HelpContext = 360001
  end
  object pnlResults: TDNMPanel [5]
    Left = 0
    Top = 321
    Width = 795
    Height = 131
    HelpContext = 360031
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label4: TLabel
      Left = 14
      Top = 4
      Width = 42
      Height = 15
      HelpContext = 360009
      AutoSize = False
      Caption = 'Results'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object grdLines: TwwDBGrid
      AlignWithMargins = True
      Left = 10
      Top = 19
      Width = 775
      Height = 109
      HelpContext = 360019
      Margins.Left = 10
      Margins.Right = 10
      ControlType.Strings = (
        'Done;CheckBox;T;F')
      Selected.Strings = (
        'DateCreated'#9'19'#9'Created'#9'T'#9
        'Responded'#9'19'#9'Responded'#9'T'#9
        'Total'#9'14'#9'Total Time'#9'T'#9
        'Results'#9'40'#9'Results'#9'T'
        'Done'#9'1'#9'Done'#9#9)
      MemoAttributes = [mWordWrap, mGridShow, mDisableDialog]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Align = alBottom
      DataSource = dsToDoLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
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
      OnDblClick = grdLinesDblClick
      FooterColor = clWhite
      FooterCellColor = clWhite
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 22
        HelpContext = 360032
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
        OnClick = btnDeleteClick
      end
    end
  end
  object pnlButtons: TDNMPanel [6]
    Left = 0
    Top = 452
    Width = 795
    Height = 49
    HelpContext = 360033
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      795
      49)
    object cmdOK: TDNMSpeedButton
      Left = 110
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 360013
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
      Kind = bkOK
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = cmdOkClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 207
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 360014
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cmdNewClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 403
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 360015
      Anchors = [akBottom]
      Caption = 'Prin&t'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = cmdPrintClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 599
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 360023
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = cmdCancelClick
    end
    object btnEmail: TDNMSpeedButton
      Left = 501
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 360044
      Anchors = [akBottom]
      Caption = 'E&mail'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnEmailClick
    end
    object DNMPanel4: TDNMPanel
      Left = 696
      Top = 11
      Width = 89
      Height = 26
      HelpContext = 360034
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object chkCompleted: TDBCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 81
        Height = 18
        HelpContext = 360022
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Completed'
        DataField = 'Completed'
        DataSource = frmToDoSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 14
      Top = 11
      Width = 74
      Height = 26
      HelpContext = 360035
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object DBCheckBox2: TDBCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 66
        Height = 18
        HelpContext = 360045
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Active'
        DataField = 'Active'
        DataSource = frmToDoSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
    end
    object btnPreview: TDNMSpeedButton
      Left = 305
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 360046
      Anchors = [akBottom]
      Caption = 'Preview'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = cmdPrintClick
    end
  end
  object pnlTop: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 795
    Height = 121
    HelpContext = 360036
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      795
      121)
    object Label29: TLabel
      Left = 16
      Top = 74
      Width = 74
      Height = 15
      HelpContext = 360002
      Caption = 'Date Created'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label34: TLabel
      Left = 198
      Top = 74
      Width = 76
      Height = 15
      HelpContext = 360005
      Caption = 'For Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label2: TLabel
      Left = 350
      Top = 74
      Width = 62
      Height = 15
      HelpContext = 360007
      Caption = 'Created By'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label32: TLabel
      Left = 500
      Top = 74
      Width = 77
      Height = 15
      HelpContext = 360047
      Caption = 'Date To Do By'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label11: TLabel
      Left = 622
      Top = 74
      Width = 41
      Height = 15
      HelpContext = 360048
      Caption = 'Priority'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object pnlTitle: TDNMPanel
      Left = 278
      Top = 13
      Width = 238
      Height = 43
      HelpContext = 360024
      Anchors = [akTop]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
        Height = 39
        HelpContext = 360025
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
          Width = 234
          Height = 39
          HelpContext = 360026
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Items To Do'
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
    object dtpCreatedDate: TwwDBDateTimePicker
      Left = 14
      Top = 90
      Width = 163
      Height = 23
      HelpContext = 360016
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'CreatedDate'
      DataSource = frmToDoSrc
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
      DisplayFormat = 'c'
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 196
      Top = 90
      Width = 121
      Height = 23
      HelpContext = 360012
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'46'#9'EmployeeName'#9#9)
      DataField = 'EmployeeID'
      DataSource = frmToDoSrc
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeID'
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboCreatedBy: TwwDBLookupCombo
      Left = 349
      Top = 90
      Width = 121
      Height = 23
      HelpContext = 360018
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'46'#9'EmployeeName'#9#9)
      DataField = 'CreatedByEmployeeID'
      DataSource = frmToDoSrc
      LookupTable = qryEmployees2
      LookupField = 'EmployeeID'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object dtpToDoByDate: TwwDBDateTimePicker
      Left = 499
      Top = 90
      Width = 98
      Height = 23
      HelpContext = 360049
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'ToDoByDate'
      DataSource = frmToDoSrc
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
      UnboundDataType = wwDTEdtDate
    end
    object btnRepeat: TDNMSpeedButton
      Left = 535
      Top = 26
      Width = 82
      Height = 27
      HelpContext = 360037
      Anchors = [akTop, akRight]
      Caption = '&Repeat'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 5
      OnClick = btnRepeatClick
    end
    object edtToDoPriority: TwwDBSpinEdit
      Left = 622
      Top = 90
      Width = 57
      Height = 23
      HelpContext = 360038
      Increment = 1.000000000000000000
      MaxValue = 100.000000000000000000
      DataField = 'ToDoPriority'
      DataSource = frmToDoSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
    end
    object DNMPanel1: TDNMPanel
      Left = 654
      Top = 24
      Width = 139
      Height = 30
      HelpContext = 360039
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object DBCheckBox1: TDBCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 131
        Height = 22
        HelpContext = 360040
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Synch with Google'
        DataField = 'SynchWithGoogle'
        DataSource = frmToDoSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 695
      Top = 76
      Width = 90
      Height = 42
      HelpContext = 360041
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object chkShowReminder: TDBCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 82
        Height = 34
        HelpContext = 360050
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Show On Reminder'
        DataField = 'ShowReminder'
        DataSource = frmToDoSrc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
    end
  end
  object pnlResult: TDNMPanel [8]
    Left = 0
    Top = 221
    Width = 795
    Height = 100
    HelpContext = 360028
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label6: TLabel
      Left = 15
      Top = 2
      Width = 42
      Height = 16
      HelpContext = 360006
      AutoSize = False
      Caption = 'Result'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label8: TLabel
      Left = 242
      Top = 4
      Width = 64
      Height = 15
      HelpContext = 360004
      Alignment = taRightJustify
      Caption = 'Created On'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label9: TLabel
      Left = 535
      Top = 4
      Width = 83
      Height = 15
      HelpContext = 360042
      Alignment = taRightJustify
      Caption = 'Responded On'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object memResult: TDBMemo
      AlignWithMargins = True
      Left = 10
      Top = 25
      Width = 775
      Height = 72
      HelpContext = 360029
      Margins.Left = 10
      Margins.Right = 10
      Align = alBottom
      DataField = 'Results'
      DataSource = dsToDoLines
      TabOrder = 1
      OnChange = memResultChange
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 312
      Top = 0
      Width = 161
      Height = 23
      HelpContext = 360017
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'DateCreated'
      DataSource = dsToDoLines
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 0
    end
    object wwDBDateTimePicker2: TwwDBDateTimePicker
      Left = 624
      Top = 0
      Width = 161
      Height = 23
      HelpContext = 360043
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'Responded'
      DataSource = dsToDoLines
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
    end
  end
  object pnlDescription: TDNMPanel [9]
    Left = 0
    Top = 121
    Width = 795
    Height = 100
    HelpContext = 360030
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 15
      Top = 3
      Width = 73
      Height = 16
      HelpContext = 360003
      AutoSize = False
      Caption = 'Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object edtDescription: TDBMemo
      AlignWithMargins = True
      Left = 10
      Top = 24
      Width = 775
      Height = 73
      HelpContext = 360011
      Margins.Left = 10
      Margins.Right = 10
      Align = alBottom
      DataField = 'Description'
      DataSource = frmToDoSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnAttachments: TDNMSpeedButton
      Left = 695
      Top = 1
      Width = 90
      Height = 22
      Caption = 'Attach'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
        000557777777777777750BBBBBBBBBBBBBB07F5555FFFFFFF5570BBBB0000000
        BBB07F5557777777FF570BBB077BBB770BB07F557755555775570BBBBBBBBBBB
        BBB07F5555FFFFFFF5570BBBB0000000BBB07F5557777777F5570BBBB0FFFFF0
        BBB07F5557FFFFF7F5570BBBB0000000BBB07F555777777755570BBBBBBBBBBB
        BBB07FFFFFFFFFFFFFF700000000000000007777777777777777500FFFFFFFFF
        F005577FF555FFFFF7755500FFF00000005555775FF7777777F5550F777FFFFF
        F055557F777FFF5557F5550000000FFF00555577777775FF77F5550777777000
        7055557FFFFFF777F7F555000000000000555577777777777755}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnAttachmentsClick
      HelpContext = 360051
    end
  end
  inherited popSpelling: TPopupMenu
    Left = 344
    Top = 256
  end
  inherited tmrdelayMsg: TTimer
    Left = 320
    Top = 248
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 491
    Top = 267
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 639
    Top = 267
  end
  inherited MyConnection: TERPConnection
    Left = 66
    Top = 255
  end
  inherited DataState: TDataState
    Left = 674
    Top = 267
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 420
    Top = 267
  end
  inherited imgsort: TImageList
    Left = 603
    Top = 267
    Bitmap = {
      494C010102006800900010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 274
    Top = 256
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 414
    Top = 256
  end
  inherited qryMemTrans: TERPQuery
    Left = 245
    Top = 256
  end
  object frmToDoSrc: TDataSource
    DataSet = qryToDo
    Left = 96
    Top = 283
  end
  object qryToDo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      '* FROM tblToDo'
      'WHERE ToDoID= :TDID;')
    Left = 101
    Top = 251
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TDID'
      end>
    object qryToDoToDoID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ToDoID'
      Origin = 'tblToDo.ToDoID'
      ReadOnly = True
    end
    object qryToDoCreatedDate: TDateTimeField
      FieldName = 'CreatedDate'
      Origin = 'tblToDo.CreatedDate'
      DisplayFormat = 'c'
    end
    object qryToDoEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblToDo.EmployeeID'
    end
    object qryToDoToDoByDate: TDateTimeField
      FieldName = 'ToDoByDate'
      Origin = 'tblToDo.ToDoByDate'
      DisplayFormat = 'c'
    end
    object qryToDoEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblToDo.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryToDoAppearDays: TIntegerField
      FieldName = 'AppearDays'
      Origin = 'tblToDo.AppearDays'
    end
    object qryToDoResult: TWideStringField
      FieldName = 'Result'
      Origin = 'tblToDo.Result'
      Size = 255
    end
    object qryToDoCreatedByEmployeeID: TIntegerField
      FieldName = 'CreatedByEmployeeID'
      Origin = 'tblToDo.CreatedByEmployeeID'
    end
    object qryToDoCompleted: TWideStringField
      FieldName = 'Completed'
      Origin = 'tblToDo.Completed'
      FixedChar = True
      Size = 1
    end
    object qryToDoActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblToDo.Active'
      FixedChar = True
      Size = 1
    end
    object qryToDoDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblToDo.done'
      Size = 1
    end
    object qryToDoShowReminder: TWideStringField
      FieldName = 'ShowReminder'
      FixedChar = True
      Size = 1
    end
    object qryToDoDescription: TWideMemoField
      FieldName = 'Description'
      BlobType = ftWideMemo
    end
    object qryToDoSynchWithGoogle: TWideStringField
      FieldName = 'SynchWithGoogle'
      FixedChar = True
      Size = 1
    end
    object qryToDoGoogleId: TWideStringField
      FieldName = 'GoogleId'
      Size = 255
    end
    object qryToDoMasterGoogleId: TWideStringField
      FieldName = 'MasterGoogleId'
      Size = 255
    end
    object qryToDoToDoPriority: TSmallintField
      FieldName = 'ToDoPriority'
    end
    object qryToDoGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryToDoPOID: TIntegerField
      FieldName = 'POID'
    end
    object qryToDomsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryToDoType: TWideStringField
      FieldName = 'Type'
      Size = 10
    end
    object qryToDoOtherID: TIntegerField
      FieldName = 'OtherID'
    end
    object qryToDoClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryToDomsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryToDoGoogleUpdated: TDateTimeField
      FieldName = 'GoogleUpdated'
    end
    object qryToDoMasterGoogleUpdated: TDateTimeField
      FieldName = 'MasterGoogleUpdated'
    end
    object qryToDoLinkTo: TWideStringField
      FieldName = 'LinkTo'
      Size = 255
    end
    object qryToDoLinkToID: TIntegerField
      FieldName = 'LinkToID'
    end
  end
  object cboEmployeeLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT tblEmployees.EmployeeID, Concat(firstname,'#39' '#39',Lastname) A' +
        'S EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY Concat(firstname,'#39' '#39',Lastname);')
    Left = 174
    Top = 251
  end
  object DSEmployeeLookup: TDataSource
    AutoEdit = False
    DataSet = cboEmployeeLookup
    Left = 185
    Top = 283
  end
  object memQryTodo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ToDoID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'CreatedDate'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'EmployeeID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ToDoByDate'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'Done'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'AppearDays'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Result'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'CreatedByEmployeeID'
        Attributes = [faFixed]
        DataType = ftInteger
      end>
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
    Left = 526
    Top = 267
  end
  object qryEmployees2: TERPQuery
    SQL.Strings = (
      
        'SELECT tblEmployees.EmployeeID, Concat(firstname,'#39' '#39',Lastname) A' +
        'S EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY Concat(firstname,'#39' '#39',Lastname);')
    Left = 210
    Top = 251
  end
  object qryToDoLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblToDoLines '
      'WHERE ToDoID = :xID')
    OnCalcFields = qryToDoLinesCalcFields
    IndexFieldNames = 'responded desc'
    Left = 136
    Top = 251
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryToDoLinesDateCreated: TDateTimeField
      DisplayLabel = 'Created'
      DisplayWidth = 19
      FieldName = 'DateCreated'
      Origin = 'tbltodolines.DateCreated'
    end
    object qryToDoLinesResponded: TDateTimeField
      DisplayWidth = 19
      FieldName = 'Responded'
      Origin = 'tbltodolines.Responded'
    end
    object qryToDoLinesTotal: TWideStringField
      DisplayLabel = 'Total Time'
      DisplayWidth = 14
      FieldKind = fkCalculated
      FieldName = 'Total'
      Size = 16
      Calculated = True
    end
    object qryToDoLinesResults: TWideMemoField
      DisplayWidth = 40
      FieldName = 'Results'
      Origin = 'tbltodolines.Results'
      BlobType = ftWideMemo
    end
    object qryToDoLinesDone: TWideStringField
      DisplayWidth = 1
      FieldName = 'Done'
      Origin = 'tbltodolines.done'
      Size = 1
    end
    object qryToDoLinesID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbltodolines.ID'
      ReadOnly = True
      Visible = False
    end
    object qryToDoLinesToDoID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ToDoID'
      Origin = 'tbltodolines.ToDoID'
      Visible = False
    end
    object qryToDoLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsToDoLines: TDataSource
    DataSet = qryToDoLines
    Left = 135
    Top = 283
  end
  object DMTextTargetToDo: TDMTextTarget
    AcceptorControl = edtDescription
    AcceptTextFormats = [dtfFiles, dtfCustom]
    OnDrop = DMTextTargetToDoDrop
    Left = 564
    Top = 255
  end
end
