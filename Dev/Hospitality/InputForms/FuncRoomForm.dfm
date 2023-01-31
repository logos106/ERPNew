inherited frmFuncRoomGUI: TfrmFuncRoomGUI
  Left = 411
  Top = 254
  HelpContext = 641000
  Caption = 'Function Room'
  ClientHeight = 348
  ClientWidth = 512
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel2: TDNMPanel [1]
    Left = 0
    Top = 59
    Width = 512
    Height = 289
    HelpContext = 641001
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      512
      289)
    object Bevel3: TBevel
      Left = 277
      Top = 116
      Width = 195
      Height = 113
      HelpContext = 641002
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 39
      Top = 116
      Width = 195
      Height = 113
      HelpContext = 641003
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 39
      Top = 9
      Width = 433
      Height = 97
      HelpContext = 641004
      Shape = bsFrame
    end
    object lblRoomName: TLabel
      Left = 58
      Top = 35
      Width = 75
      Height = 15
      HelpContext = 641005
      Alignment = taRightJustify
      Caption = 'Room Name :'
      Transparent = True
    end
    object lblResetTime: TLabel
      Left = 308
      Top = 183
      Width = 70
      Height = 15
      HelpContext = 641006
      Alignment = taRightJustify
      Caption = 'Reset Time :'
      Transparent = True
    end
    object Label1: TLabel
      Left = 83
      Top = 135
      Width = 50
      Height = 15
      HelpContext = 641007
      Alignment = taRightJustify
      Caption = 'Per Day :'
      Transparent = True
    end
    object lblPerHalfDay: TLabel
      Left = 63
      Top = 159
      Width = 70
      Height = 15
      HelpContext = 641008
      Alignment = taRightJustify
      Caption = 'Per 1/2 Day :'
      Transparent = True
    end
    object lblPerHour: TLabel
      Left = 77
      Top = 183
      Width = 56
      Height = 15
      HelpContext = 641009
      Alignment = taRightJustify
      Caption = 'Per Hour :'
      Transparent = True
    end
    object Label2: TLabel
      Left = 469
      Top = 246
      Width = 35
      Height = 15
      HelpContext = 641010
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      Transparent = True
    end
    object Label3: TLabel
      Left = 324
      Top = 140
      Width = 52
      Height = 15
      HelpContext = 641011
      Caption = 'Capacity'
      Transparent = True
    end
    object Label4: TLabel
      Left = 56
      Top = 68
      Width = 77
      Height = 15
      HelpContext = 641012
      Alignment = taRightJustify
      Caption = 'Parent Room:'
      Transparent = True
    end
    object cmdOk: TDNMSpeedButton
      Left = 63
      Top = 250
      Width = 87
      Height = 27
      HelpContext = 641013
      Anchors = [akBottom]
      Caption = '&Save'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 8
      OnClick = cmdOkClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 211
      Top = 250
      Width = 87
      Height = 27
      Hint = '"Add A Class"'
      HelpContext = 641014
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = cmdNewClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 359
      Top = 250
      Width = 87
      Height = 27
      HelpContext = 641015
      Anchors = [akBottom]
      Caption = '&Cancel'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 10
      OnClick = cmdCancelClick
    end
    object chkActive: TwwCheckBox
      Left = 478
      Top = 261
      Width = 17
      Height = 17
      HelpContext = 641016
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight, akBottom]
      Checked = True
      DataField = 'Active'
      DataSource = dsFuncRooms
      State = cbChecked
      TabOrder = 7
    end
    object edtPerHour: TwwDBEdit
      Left = 147
      Top = 180
      Width = 69
      Height = 23
      HelpContext = 641017
      DataField = 'PerHour'
      DataSource = dsFuncRooms
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtPerHalfDay: TwwDBEdit
      Left = 147
      Top = 156
      Width = 69
      Height = 23
      HelpContext = 641018
      DataField = 'PerHalfDay'
      DataSource = dsFuncRooms
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtPerDay: TwwDBEdit
      Left = 147
      Top = 132
      Width = 69
      Height = 23
      HelpContext = 641019
      DataField = 'PerDay'
      DataSource = dsFuncRooms
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtRoomName: TwwDBEdit
      Left = 147
      Top = 32
      Width = 269
      Height = 23
      HelpContext = 641020
      DataField = 'Name'
      DataSource = dsFuncRooms
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtCapacity: TwwDBSpinEdit
      Left = 392
      Top = 140
      Width = 57
      Height = 23
      HelpContext = 641021
      Increment = 1
      DataField = 'Capacity'
      DataSource = dsFuncRooms
      TabOrder = 5
      UnboundDataType = wwDefault
    end
    object cboParentRoom: TwwDBLookupCombo
      Left = 148
      Top = 65
      Width = 269
      Height = 23
      HelpContext = 641022
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'50'#9'Name'#9'F')
      DataField = 'ParentRoomID'
      DataSource = dsFuncRooms
      LookupTable = qryParentRooms
      LookupField = 'RoomID'
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object dtpResetTime: TwwDBDateTimePicker
      Left = 391
      Top = 180
      Width = 57
      Height = 23
      HelpContext = 641023
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ResetTime'
      DataSource = dsFuncRooms
      Epoch = 1950
      Interval.MinutesInterval = 15
      Interval.RoundMinutes = True
      ShowButton = False
      TabOrder = 6
      DisplayFormat = ' h:nn'
    end
  end
  object DNMPanel3: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 512
    Height = 59
    HelpContext = 641024
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
      512
      59)
    object pnlTitle: TDNMPanel
      Left = 136
      Top = 6
      Width = 238
      Height = 45
      HelpContext = 641025
      Anchors = [akLeft, akTop, akRight]
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
        Height = 41
        HelpContext = 641026
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
          Width = 234
          Height = 41
          HelpContext = 641027
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Function Room'
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
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 368
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 304
    Top = 0
  end
  object dsFuncRooms: TDataSource
    DataSet = qryFuncRooms
    Left = 152
    Top = 24
  end
  object qryParentRooms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RoomID, Name'
      'FROM tblFuncRooms'
      'WHERE ParentRoomID = 0 AND'
      '  RoomID <>:xRoomID;')
    Left = 432
    Top = 144
    ParamData = <
      item
        DataType = ftString
        Name = 'xRoomID'
        Size = 255
      end>
  end
  object qryFuncRooms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT RoomID, Active, Name, PerHour, PerHalfDay, PerDay, ResetT' +
        'ime,'
      'Capacity, ParentRoomID '
      'FROM tblfuncrooms '
      'WHERE RoomID =:xRoomID;')
    Left = 210
    Top = 23
    ParamData = <
      item
        DataType = ftString
        Name = 'xRoomID'
        Size = 255
      end>
    object qryFuncRoomsRoomID: TAutoIncField
      FieldName = 'RoomID'
      ReadOnly = True
    end
    object qryFuncRoomsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryFuncRoomsName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object qryFuncRoomsPerHour: TFloatField
      FieldName = 'PerHour'
      currency = True
    end
    object qryFuncRoomsPerHalfDay: TFloatField
      FieldName = 'PerHalfDay'
      currency = True
    end
    object qryFuncRoomsPerDay: TFloatField
      FieldName = 'PerDay'
      currency = True
    end
    object qryFuncRoomsResetTime: TTimeField
      FieldName = 'ResetTime'
      DisplayFormat = 'h:nn'
    end
    object qryFuncRoomsCapacity: TIntegerField
      FieldName = 'Capacity'
    end
    object qryFuncRoomsParentRoomID: TIntegerField
      FieldName = 'ParentRoomID'
    end
  end
end
