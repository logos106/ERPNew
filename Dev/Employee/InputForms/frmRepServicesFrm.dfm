inherited frmRepServices: TfrmRepServices
  Left = 290
  Top = 234
  HelpContext = 345000
  Caption = 'Service'
  ClientHeight = 254
  ClientWidth = 451
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 20
    Top = 64
    Width = 413
    Height = 137
    HelpContext = 345002
    Shape = bsFrame
  end
  object Label1: TLabel [1]
    Left = 45
    Top = 81
    Width = 123
    Height = 16
    HelpContext = 345003
    Caption = 'Service Description'
    FocusControl = txtDesc
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 262
    Top = 81
    Width = 110
    Height = 16
    HelpContext = 345004
    Caption = 'Charge Rate (Inc)'
    FocusControl = txtDesc
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [3]
    Left = 261
    Top = 161
    Width = 39
    Height = 16
    HelpContext = 345006
    Caption = 'Active'
    FocusControl = txtDesc
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [4]
    Left = 46
    Top = 161
    Width = 83
    Height = 16
    HelpContext = 345009
    Caption = 'Is Fixed Rate'
    FocusControl = txtDesc
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 345001
  end
  object btnSave: TDNMSpeedButton [6]
    Left = 99
    Top = 216
    Width = 93
    Height = 27
    HelpContext = 345011
    Anchors = [akLeft, akBottom]
    Caption = '&Save'
    Default = True
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [7]
    Left = 263
    Top = 216
    Width = 93
    Height = 27
    HelpContext = 345012
    Anchors = [akLeft, akBottom]
    Cancel = True
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
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object wwCheckBox3: TwwCheckBox [8]
    Left = 313
    Top = 160
    Width = 15
    Height = 17
    HelpContext = 345015
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
    Caption = 'wwCheckBox1'
    DataField = 'Active'
    DataSource = dsService
    TabOrder = 2
  end
  object txtDesc: TDBEdit [9]
    Left = 45
    Top = 109
    Width = 158
    Height = 23
    HelpContext = 345016
    DataField = 'ServiceDesc'
    DataSource = dsService
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object wwCheckBox4: TwwCheckBox [10]
    Left = 144
    Top = 160
    Width = 15
    Height = 17
    HelpContext = 345017
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
    Caption = 'wwCheckBox1'
    DataField = 'IsFixedRate'
    DataSource = dsService
    TabOrder = 5
  end
  object DBEdit2: TDBEdit [11]
    Left = 262
    Top = 109
    Width = 103
    Height = 23
    HelpContext = 345018
    DataField = 'StandardRate'
    DataSource = dsService
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object pnlTitle: TDNMPanel [12]
    Left = 111
    Top = 8
    Width = 238
    Height = 42
    HelpContext = 345019
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 38
      HelpContext = 345020
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
        Height = 38
        HelpContext = 345021
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Service'
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
    Left = 90
    Top = 34
  end
  object qryServices: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * From tblServices WHERE ServiceID =  :xServiceID')
    AfterOpen = qryServicesAfterOpen
    Left = 168
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xServiceID'
      end>
    object qryServicesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryServicesServiceID: TAutoIncField
      FieldName = 'ServiceID'
      ReadOnly = True
    end
    object qryServicesServiceDesc: TWideStringField
      FieldName = 'ServiceDesc'
      Size = 50
    end
    object qryServicesActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryServicesIsSoftware: TWideStringField
      FieldName = 'IsSoftware'
      FixedChar = True
      Size = 1
    end
    object qryServicesIsHardware: TWideStringField
      FieldName = 'IsHardware'
      FixedChar = True
      Size = 1
    end
    object qryServicesCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qryServicesUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object qryServicesStandardRate: TFloatField
      DefaultExpression = '0'
      FieldName = 'StandardRate'
      currency = True
    end
    object qryServicesRanking: TSmallintField
      FieldName = 'Ranking'
    end
    object qryServicesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryServicesIsFixedRate: TWideStringField
      FieldName = 'IsFixedRate'
      FixedChar = True
      Size = 1
    end
  end
  object dsService: TDataSource
    DataSet = qryServices
    Left = 136
    Top = 8
  end
  object memQryServices: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'GlobalRef'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ServiceID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'ServiceDesc'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Active'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsSoftware'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsHardware'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'CreationDate'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'UpdateDate'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'StandardRate'
        Attributes = [faFixed]
        DataType = ftBCD
        Precision = 15
        Size = 4
      end
      item
        Name = 'Ranking'
        Attributes = [faFixed]
        DataType = ftSmallint
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 186
    Top = 25
  end
end
