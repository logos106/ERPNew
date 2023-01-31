inherited fmPayrollServicesCreate: TfmPayrollServicesCreate
  Left = 499
  Top = 215
  HelpContext = 176000
  Caption = 'Mass Employee Service Creation'
  ClientHeight = 429
  ClientWidth = 398
  OldCreateOrder = True
  ExplicitTop = 8
  ExplicitWidth = 404
  ExplicitHeight = 461
  DesignSize = (
    398
    429)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 42
    Top = 224
    Width = 313
    Height = 41
    HelpContext = 176002
    Shape = bsFrame
  end
  object Bevel1: TBevel [1]
    Left = 42
    Top = 136
    Width = 313
    Height = 81
    HelpContext = 176003
    Shape = bsFrame
  end
  object lblCopyFromEmployee: TLabel [2]
    Left = 96
    Top = 148
    Width = 118
    Height = 15
    HelpContext = 176004
    Caption = 'Copy From Employee'
    Transparent = True
  end
  object lblCreateFromParts: TLabel [3]
    Left = 96
    Top = 236
    Width = 125
    Height = 15
    HelpContext = 176005
    Caption = 'Create From Products'
    Transparent = True
  end
  object Bevel3: TBevel [4]
    Left = 42
    Top = 272
    Width = 313
    Height = 105
    HelpContext = 176006
    Shape = bsFrame
  end
  object Label3: TLabel [5]
    Left = 96
    Top = 309
    Width = 187
    Height = 15
    HelpContext = 176007
    Caption = 'Create/Update For This Employee'
    Transparent = True
  end
  object Label4: TLabel [6]
    Left = 96
    Top = 284
    Width = 184
    Height = 15
    HelpContext = 176008
    Caption = 'Create/Update For All Employees'
    Transparent = True
  end
  object Bevel4: TBevel [7]
    Left = 42
    Top = 64
    Width = 313
    Height = 62
    HelpContext = 176009
    Shape = bsFrame
  end
  object Label5: TLabel [8]
    Left = 88
    Top = 76
    Width = 177
    Height = 15
    HelpContext = 176010
    Caption = 'Create New Employee Services'
    Transparent = True
  end
  object Label6: TLabel [9]
    Left = 88
    Top = 101
    Width = 257
    Height = 15
    HelpContext = 176011
    Caption = 'Update Existing Service Rates From Products'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 176001
  end
  object chkFromProducts: TCheckBox [13]
    Left = 72
    Top = 236
    Width = 17
    Height = 18
    HelpContext = 176014
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = chkFromProductsClick
  end
  object chkThisEmployee: TCheckBox [14]
    Left = 72
    Top = 308
    Width = 17
    Height = 17
    HelpContext = 176015
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = chkThisEmployeeClick
  end
  object chkAllEmployees: TCheckBox [15]
    Left = 72
    Top = 284
    Width = 17
    Height = 17
    HelpContext = 176016
    TabOrder = 5
    OnClick = chkAllEmployeesClick
  end
  object cboTemplateEmployee: TwwDBLookupCombo [16]
    Left = 72
    Top = 176
    Width = 249
    Height = 23
    HelpContext = 176017
    DropDownAlignment = taLeftJustify
    LookupTable = qrySourceEmployee
    LookupField = 'EmployeeName'
    Style = csDropDownList
    DropDownWidth = 40
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object cboUpdateEmployee: TwwDBLookupCombo [17]
    Left = 72
    Top = 336
    Width = 249
    Height = 23
    HelpContext = 176018
    DropDownAlignment = taLeftJustify
    LookupTable = qryDestEmployee
    LookupField = 'EmployeeName'
    Style = csDropDownList
    DropDownWidth = 40
    TabOrder = 7
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object chkCreateNew: TCheckBox [18]
    Left = 64
    Top = 76
    Width = 17
    Height = 17
    HelpContext = 176019
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = chkCreateNewClick
  end
  object chkUpdate: TCheckBox [19]
    Left = 64
    Top = 100
    Width = 17
    Height = 17
    HelpContext = 176020
    TabOrder = 1
    OnClick = chkUpdateClick
  end
  object btnCreate: TDNMSpeedButton [20]
    Left = 90
    Top = 389
    Width = 87
    Height = 27
    HelpContext = 176021
    Anchors = [akLeft, akBottom]
    Caption = '&Process'
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
    TabOrder = 8
    OnClick = btnCreateClick
  end
  object pnlTitle: TDNMPanel [21]
    Left = 11
    Top = 8
    Width = 377
    Height = 39
    HelpContext = 176022
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Invoice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 10
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 375
      Height = 37
      HelpContext = 176023
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
        Width = 375
        Height = 37
        HelpContext = 176024
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Employee Services Create'
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
  object chkFromEmployee: TCheckBox [22]
    Left = 72
    Top = 148
    Width = 17
    Height = 17
    HelpContext = 176013
    TabOrder = 2
    OnClick = chkFromEmployeeClick
  end
  object btnCancel: TDNMSpeedButton [23]
    Left = 222
    Top = 389
    Width = 85
    Height = 27
    HelpContext = 176012
    Anchors = [akLeft, akBottom]
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
    NumGlyphs = 2
    TabOrder = 9
    OnClick = btnCancelClick
  end
  inherited MyConnection: TERPConnection
    Username = 'DnM'
  end
  inherited DataState: TDataState
    Top = 56
  end
  object qrySourceEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'EmployeeID,'
      'CONCAT_WS(" ", FirstName, LastName) As EmployeeName'
      'FROM tblEmployees'
      'WHERE Active = "T"'
      'ORDER BY EmployeeName')
    Left = 288
    Top = 64
  end
  object qryDestEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'EmployeeID,'
      'EmployeeName'
      'FROM tblEmployees'
      'WHERE Active = "T"'
      'ORDER BY EmployeeName')
    Left = 280
    Top = 224
  end
end
