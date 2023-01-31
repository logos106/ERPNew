inherited POSSubProdPopUp: TPOSSubProdPopUp
  Left = 406
  Top = 161
  HelpContext = 434000
  Caption = 'Sub Product Selection'
  ClientHeight = 208
  ClientWidth = 343
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 32
    Top = 64
    Width = 273
    Height = 79
    HelpContext = 434002
    Shape = bsFrame
  end
  object Label1: TLabel [1]
    Left = 85
    Top = 90
    Width = 22
    Height = 15
    HelpContext = 434003
    Alignment = taRightJustify
    Caption = 'Unit'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    Left = 67
    Top = 6
    HelpContext = 434001
  end
  object cboUnitofMeasure: TwwDBLookupCombo [3]
    Left = 114
    Top = 86
    Width = 121
    Height = 26
    HelpContext = 434009
    AutoSize = False
    DropDownAlignment = taLeftJustify
    LookupTable = qryUnitOfMeasure
    LookupField = 'UnitName'
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
  end
  object btnSave: TDNMSpeedButton [4]
    Left = 35
    Top = 168
    Width = 87
    Height = 27
    HelpContext = 434015
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
    TabOrder = 1
  end
  object btnCancel: TDNMSpeedButton [5]
    Left = 217
    Top = 168
    Width = 87
    Height = 27
    HelpContext = 434016
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
    TabOrder = 2
  end
  object pnlTitle: TDNMPanel [6]
    Left = 10
    Top = 10
    Width = 329
    Height = 40
    HelpContext = 434017
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 325
      Height = 36
      HelpContext = 434018
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
        Width = 325
        Height = 36
        HelpContext = 434019
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Sub Product Selection'
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
    Left = 48
    Top = 296
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 65520
    Top = 296
  end
  inherited MyConnection: TMyConnection
    Left = 65535
    Top = 93
  end
  inherited DataState: TDataState
    Left = 65534
    Top = 125
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 28
    Top = 95
  end
  object qryUnitOfMeasure: TMyQuery
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND (U.PartID = :xPartID or U.PartID = 0) '
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName')
    Left = 290
    Top = 77
    ParamData = <
      item
        DataType = ftString
        Name = 'xPartID'
        Size = 255
      end>
    object qryUnitOfMeasureUnitName: TStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitDescription: TStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
    object qryUnitOfMeasureMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object qryUnitOfMeasureBaseUnitName: TStringField
      FieldName = 'BaseUnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitID: TIntegerField
      FieldName = 'UnitID'
    end
  end
end
