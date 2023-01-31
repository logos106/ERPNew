inherited PCCAttendant: TPCCAttendant
  Left = 376
  Top = 270
  Caption = 'Attendant'
  ClientHeight = 255
  ClientWidth = 335
  OldCreateOrder = True
  DesignSize = (
    335
    255)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [1]
    Left = 31
    Top = 64
    Width = 273
    Height = 137
    Shape = bsFrame
  end
  object Label1: TLabel [2]
    Left = 40
    Top = 80
    Width = 55
    Height = 15
    Caption = 'Attendant'
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 40
    Top = 108
    Width = 58
    Height = 15
    Caption = 'Password'
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 40
    Top = 140
    Width = 65
    Height = 15
    Caption = 'Description'
    Transparent = True
  end
  object Label4: TLabel [5]
    Left = 40
    Top = 172
    Width = 55
    Height = 15
    Caption = 'Employee'
    Transparent = True
  end
  object Label5: TLabel [6]
    Left = 296
    Top = 210
    Width = 35
    Height = 15
    Caption = 'Active'
    Transparent = True
  end
  object btnOK: TDNMSpeedButton [7]
    Left = 57
    Top = 212
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'OK'
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
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [8]
    Left = 191
    Top = 212
    Width = 87
    Height = 27
    Anchors = [akBottom]
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
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object edtDescription: TwwDBEdit [9]
    Left = 112
    Top = 136
    Width = 181
    Height = 23
    DataField = 'Description'
    DataSource = dsAttendant
    Font.Charset = ANSI_CHARSET
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
  object cboEmployee: TwwDBLookupCombo [10]
    Left = 112
    Top = 168
    Width = 181
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'EmployeeName'#9'30'#9'EmployeeName'#9'F')
    DataField = 'EmployeeID'
    DataSource = dsAttendant
    LookupTable = qryEmployee
    LookupField = 'EmployeeID'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
  end
  object edtPassword: TwwDBEdit [11]
    Left = 112
    Top = 106
    Width = 181
    Height = 23
    DataField = 'Password'
    DataSource = dsAttendant
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtAttendant: TwwDBEdit [12]
    Left = 112
    Top = 77
    Width = 181
    Height = 23
    DataField = 'AttendantID'
    DataSource = dsAttendant
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cbActive: TwwCheckBox [13]
    Left = 307
    Top = 225
    Width = 17
    Height = 17
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbChecked
    Checked = True
    DataField = 'Active'
    DataSource = dsAttendant
    State = cbChecked
    TabOrder = 6
  end
  object pnlTitle: TDNMPanel [14]
    Left = 51
    Top = 6
    Width = 238
    Height = 40
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 36
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
        Height = 36
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Attendant'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 65
    Top = 47
  end
  inherited MyConnection: TMyConnection
    Left = 97
    Top = 46
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 129
    Top = 47
  end
  object qryAttendants: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPCCAttendants'
      'WHERE PCCAttendantID = :PCCAttendantID')
    Left = 3
    Top = 117
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PCCAttendantID'
      end>
    object qryAttendantsPCCAttendantID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PCCAttendantID'
      Origin = 'tblPCCAttendants.PCCAttendantID'
    end
    object qryAttendantsAttendantID: TWordField
      FieldName = 'AttendantID'
      Origin = 'tblPCCAttendants.AttendantID'
    end
    object qryAttendantsPassword: TIntegerField
      FieldName = 'Password'
      Origin = 'tblPCCAttendants.Password'
    end
    object qryAttendantsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblPCCAttendants.EmployeeID'
    end
    object qryAttendantsDescription: TStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryAttendantsActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object dsAttendant: TDataSource
    DataSet = qryAttendants
    Left = 280
    Top = 40
  end
  object qryEmployee: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'CONCAT_WS(SPACE(1),FirstName,LastName) EmployeeName, EmployeeID'
      'FROM tblEmployees')
    Left = 3
    Top = 73
    object qryEmployeeEmployeeName: TStringField
      DisplayWidth = 30
      FieldName = 'EmployeeName'
      Size = 81
    end
    object qryEmployeeEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
  end
end
