inherited fmManufacture: TfmManufacture
  Left = 253
  Top = 218
  HelpContext = 735000
  Caption = 'Manufacture'
  ClientHeight = 206
  ClientWidth = 439
  OldCreateOrder = True
  DesignSize = (
    439
    206)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [1]
    Left = 19
    Top = 80
    Width = 33
    Height = 15
    HelpContext = 735011
    Caption = 'Name'
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 385
    Top = 167
    Width = 35
    Height = 15
    HelpContext = 735012
    Caption = 'Active'
    Transparent = True
  end
  object pnlTitle: TDNMPanel [3]
    Left = 107
    Top = 9
    Width = 228
    Height = 42
    HelpContext = 735013
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Invoice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 226
      Height = 40
      HelpContext = 735014
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
        Width = 226
        Height = 40
        HelpContext = 735015
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Manufacture'
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
  object edName: TwwDBEdit [4]
    Left = 104
    Top = 76
    Width = 230
    Height = 23
    HelpContext = 735010
    DataField = 'Name'
    DataSource = DSManufacture
    Font.Charset = ANSI_CHARSET
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
  object btnSave: TDNMSpeedButton [5]
    Left = 43
    Top = 167
    Width = 87
    Height = 27
    HelpContext = 735016
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
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 159
    Top = 166
    Width = 86
    Height = 28
    HelpContext = 735017
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
  object btnNew: TDNMSpeedButton [7]
    Left = 275
    Top = 167
    Width = 87
    Height = 27
    HelpContext = 735018
    Caption = '&New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 3
    OnClick = btnNewClick
  end
  object chkActive: TwwCheckBox [8]
    Left = 395
    Top = 180
    Width = 17
    Height = 17
    HelpContext = 735019
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
    Caption = 'chkActive'
    Checked = True
    DataField = 'Active'
    DataSource = DSManufacture
    State = cbChecked
    TabOrder = 4
  end
  object btnconfig: TDNMSpeedButton [9]
    Left = 104
    Top = 111
    Width = 230
    Height = 27
    HelpContext = 735020
    Caption = 'Repair Export Configuration'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 6
    OnClick = btnconfigClick
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  object DSManufacture: TDataSource
    DataSet = qryManufacture
    Left = 360
    Top = 88
  end
  object qryManufacture: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblManufacture'
      'WHERE ID=:KeyID')
    AfterInsert = qryManufactureAfterInsert
    Left = 368
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryManufactureGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryManufactureID: TIntegerField
      FieldName = 'ID'
    end
    object qryManufactureName: TWideStringField
      FieldName = 'Name'
      Size = 50
    end
    object qryManufactureActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryManufactureCreatedOn: TDateTimeField
      FieldName = 'CreatedOn'
    end
    object qryManufacturemsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
end
