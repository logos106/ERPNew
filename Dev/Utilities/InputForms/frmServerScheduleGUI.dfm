inherited ServerScheduleGUI: TServerScheduleGUI
  Left = 366
  Top = 128
  HelpContext = 491000
  Caption = 'Server Schedule'
  ClientHeight = 440
  ClientWidth = 520
  OldCreateOrder = True
  ExplicitLeft = 366
  ExplicitTop = 128
  ExplicitWidth = 528
  ExplicitHeight = 467
  DesignSize = (
    520
    440)
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel [0]
    Left = 18
    Top = 137
    Width = 22
    Height = 15
    HelpContext = 491002
    Caption = 'Due'
    Transparent = True
  end
  object Label3: TLabel [1]
    Left = 18
    Top = 192
    Width = 65
    Height = 15
    HelpContext = 491003
    Caption = 'Description'
    Transparent = True
  end
  object Label4: TLabel [2]
    Left = 18
    Top = 240
    Width = 22
    Height = 15
    HelpContext = 491004
    Caption = 'Xml'
    Transparent = True
  end
  object Label1: TLabel [3]
    Left = 36
    Top = 366
    Width = 108
    Height = 15
    HelpContext = 491005
    Caption = 'Log When Dropped'
    Transparent = True
  end
  object Label5: TLabel [4]
    Left = 37
    Top = 344
    Width = 89
    Height = 15
    HelpContext = 491006
    Caption = 'Log When Done'
    Transparent = True
  end
  object Label6: TLabel [5]
    Left = 429
    Top = 337
    Width = 40
    Height = 15
    HelpContext = 491007
    Caption = 'Repeat'
    Transparent = True
  end
  object Label8: TLabel [6]
    Left = 18
    Top = 80
    Width = 27
    Height = 15
    HelpContext = 491008
    Caption = 'Task'
    Transparent = True
  end
  object Label9: TLabel [7]
    Left = 256
    Top = 140
    Width = 31
    Height = 15
    HelpContext = 491009
    Caption = 'Mode'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 491001
  end
  inherited lblSkingroupMsg: TLabel
    Top = 440
    Width = 520
  end
  object cmdCancel: TDNMSpeedButton [12]
    Left = 293
    Top = 406
    Width = 87
    Height = 27
    HelpContext = 491013
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 10
    OnClick = cmdCancelClick
  end
  object edDue: TwwDBDateTimePicker [13]
    Left = 18
    Top = 152
    Width = 185
    Height = 23
    HelpContext = 491014
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 1
    DisplayFormat = 'dd/mm/yyyy hh:nn:ss am/pm'
  end
  object cbRepeatAlarm: TwwCheckBox [14]
    Left = 410
    Top = 337
    Width = 17
    Height = 17
    HelpContext = 491015
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Transparent = True
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    TabOrder = 7
    OnClick = cbRepeatAlarmClick
  end
  object btnRepeatForm: TDNMSpeedButton [15]
    Left = 409
    Top = 361
    Width = 87
    Height = 27
    HelpContext = 491016
    Caption = 'Repeat...'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 8
    OnClick = btnRepeatFormClick
  end
  object edDescription: TEdit [16]
    Left = 18
    Top = 208
    Width = 480
    Height = 23
    HelpContext = 491017
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object memXml: TMemo [17]
    Left = 18
    Top = 257
    Width = 480
    Height = 65
    HelpContext = 491018
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnExit = memXmlExit
  end
  object pnlDrop: TDNMPanel [18]
    Left = 154
    Top = 336
    Width = 237
    Height = 57
    HelpContext = 491019
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object Label7: TLabel
      Left = 3
      Top = 1
      Width = 102
      Height = 15
      HelpContext = 491020
      Caption = 'Drop if overdue by'
      Transparent = True
    end
    object seDropAfterMinutes: TSpinEdit
      Left = 20
      Top = 22
      Width = 57
      Height = 24
      HelpContext = 491021
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 0
      Value = 0
    end
    object rgDropTime: TwwRadioGroup
      Left = 82
      Top = 15
      Width = 169
      Height = 35
      HelpContext = 491022
      DisableThemes = False
      TransparentActiveItem = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.MouseEnterSameAsFocus = True
      Transparent = True
      Columns = 2
      Items.Strings = (
        'Minutes'
        'Days')
      TabOrder = 1
    end
  end
  object cbAlarmSelector: TwwDBComboBox [19]
    Left = 18
    Top = 96
    Width = 302
    Height = 23
    HelpContext = 491023
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'AutoUpdate'
      'Backup'
      'Verify & Fix'
      'Batch Update'
      'Broadcast (replace with your message)'
      'Broadcast Flashing (replace with your message)'
      'Broadcast Popup (replace with your message)'
      'Terminate All Users')
    ParentFont = False
    Sorted = False
    TabOrder = 0
    UnboundDataType = wwDefault
    OnChange = cbAlarmSelectorChange
  end
  object cboMode: TwwDBComboBox [20]
    Left = 254
    Top = 154
    Width = 145
    Height = 23
    HelpContext = 491024
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = False
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Once'
      'Daily'
      'Weekly')
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 2
    UnboundDataType = wwDefault
    OnChange = cboModeChange
  end
  object pnlTitle: TDNMPanel [21]
    Left = 133
    Top = 6
    Width = 259
    Height = 45
    HelpContext = 491025
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 255
      Height = 41
      HelpContext = 491026
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
        Width = 255
        Height = 41
        HelpContext = 491027
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Server Schedule'
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
  object cbLogWhenDropped: TwwCheckBox [22]
    Left = 18
    Top = 366
    Width = 17
    Height = 17
    HelpContext = 491011
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    Frame.MouseEnterSameAsFocus = True
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    TabOrder = 6
  end
  object cbLogWhenDone: TwwCheckBox [23]
    Left = 18
    Top = 342
    Width = 17
    Height = 17
    HelpContext = 491010
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    Frame.MouseEnterSameAsFocus = True
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    TabOrder = 5
  end
  object cmdOK: TDNMSpeedButton [24]
    Left = 130
    Top = 406
    Width = 87
    Height = 27
    HelpContext = 491012
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 9
    OnClick = cmdOKClick
  end
  inherited MyConnection: TERPConnection
    Database = 'Services'
    Left = 80
    Top = 63
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102002800280010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryServerSchedule: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ID, DatabaseName, repeatalarmID, Due, Description, Xml, L' +
        'ogWhenDropped, LogWhenDone, Mode FROM tblschedule'
      'WHERE ID = :ID')
    OnNewRecord = qryServerScheduleNewRecord
    Left = 486
    Top = 16
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
      end>
    object qryServerScheduleID: TIntegerField
      FieldName = 'ID'
      Origin = 'tblschedule.ID'
    end
    object qryServerScheduleDatabaseName: TWideStringField
      FieldName = 'DatabaseName'
      Origin = 'tblschedule.DatabaseName'
      Size = 50
    end
    object qryServerSchedulerepeatalarmID: TIntegerField
      FieldName = 'repeatalarmID'
      Origin = 'tblschedule.repeatalarmID'
    end
    object qryServerScheduleDue: TDateTimeField
      FieldName = 'Due'
      Origin = 'tblschedule.Due'
    end
    object qryServerScheduleDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblschedule.Description'
      Size = 255
    end
    object qryServerScheduleXml: TWideMemoField
      FieldName = 'Xml'
      Origin = 'tblschedule.Xml'
      BlobType = ftWideMemo
    end
    object qryServerScheduleLogWhenDone: TWideStringField
      FieldName = 'LogWhenDone'
      Origin = 'tblschedule.LogWhenDone'
      FixedChar = True
      Size = 1
    end
    object qryServerScheduleLogWhenDropped: TWideStringField
      FieldName = 'LogWhenDropped'
      Origin = 'tblschedule.LogWhenDropped'
      FixedChar = True
      Size = 1
    end
    object qryServerScheduleMode: TWideStringField
      FieldName = 'Mode'
      Size = 50
    end
  end
  object dsServerSchedule: TDataSource
    DataSet = qryServerSchedule
    Left = 486
    Top = 46
  end
  object MyCommand: TERPCommand
    Connection = MyConnection
    Left = 144
    Top = 64
  end
  object qryRepeatAlarms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrepeatalarms WHERE ID = :ID')
    Left = 455
    Top = 15
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
      end>
    object qryRepeatAlarmsID: TIntegerField
      FieldName = 'ID'
    end
    object qryRepeatAlarmsDatabaseName: TWideStringField
      FieldName = 'DatabaseName'
      Size = 50
    end
    object qryRepeatAlarmsDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryRepeatAlarmsXml: TWideMemoField
      FieldName = 'Xml'
      BlobType = ftWideMemo
    end
    object qryRepeatAlarmsEvery: TIntegerField
      FieldName = 'Every'
    end
    object qryRepeatAlarmsDayOfWeek: TWideStringField
      FieldName = 'DayOfWeek'
      FixedChar = True
      Size = 3
    end
    object qryRepeatAlarmsOfPeriod: TWideStringField
      FieldName = 'OfPeriod'
      FixedChar = True
      Size = 5
    end
    object qryRepeatAlarmsMonthOffset: TIntegerField
      FieldName = 'MonthOffset'
    end
    object qryRepeatAlarmsOnSaturday: TWideStringField
      FieldName = 'OnSaturday'
      FixedChar = True
      Size = 6
    end
    object qryRepeatAlarmsOnSunday: TWideStringField
      FieldName = 'OnSunday'
      FixedChar = True
      Size = 6
    end
    object qryRepeatAlarmsOnHoliday: TWideStringField
      FieldName = 'OnHoliday'
      FixedChar = True
      Size = 6
    end
    object qryRepeatAlarmsDueTime: TTimeField
      FieldName = 'DueTime'
    end
    object qryRepeatAlarmsActiveFirst: TDateField
      FieldName = 'ActiveFirst'
    end
    object qryRepeatAlarmsActiveLast: TDateField
      FieldName = 'ActiveLast'
    end
    object qryRepeatAlarmsDropAfterMinutes: TIntegerField
      FieldName = 'DropAfterMinutes'
    end
    object qryRepeatAlarmsLogWhenDone: TWideStringField
      FieldName = 'LogWhenDone'
      FixedChar = True
      Size = 1
    end
    object qryRepeatAlarmsLogWhenDropped: TWideStringField
      FieldName = 'LogWhenDropped'
      FixedChar = True
      Size = 1
    end
  end
  object XMLDocument: TALXMLDocument
    Options = [doNodeAutoIndent, doAttrNull, doAutoSave]
    ParseOptions = [poPreserveWhiteSpace]
    Left = 421
    Top = 15
  end
end
