inherited EmbroideryPositionGUI: TEmbroideryPositionGUI
  Left = 325
  Top = 269
  Caption = 'Embroidery Position'
  ClientHeight = 339
  ClientWidth = 560
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 288
    Top = 88
    Width = 241
    Height = 193
  end
  object Label1: TLabel [1]
    Left = 32
    Top = 72
    Width = 65
    Height = 15
    Caption = 'Description'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    Left = 528
    Top = 40
  end
  object Label2: TLabel [3]
    Left = 288
    Top = 72
    Width = 41
    Height = 15
    Caption = 'Picture'
    Transparent = True
  end
  object btnCancel: TDNMSpeedButton [4]
    Left = 437
    Top = 297
    Width = 87
    Height = 27
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
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object btnSave: TDNMSpeedButton [5]
    Left = 37
    Top = 297
    Width = 87
    Height = 27
    Caption = 'Save'
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
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object edtPosition: TwwDBEdit [6]
    Left = 32
    Top = 88
    Width = 241
    Height = 193
    AutoSize = False
    DataField = 'Description'
    DataSource = dsPosition
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = True
    WordWrap = True
  end
  object btnLoadPic: TDNMSpeedButton [7]
    Left = 137
    Top = 297
    Width = 87
    Height = 27
    Caption = 'Load Picture'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 3
    OnClick = btnLoadPicClick
  end
  object btnNew: TDNMSpeedButton [8]
    Left = 237
    Top = 297
    Width = 87
    Height = 27
    Caption = 'New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 2
    OnClick = btnNewClick
  end
  object imgPosition: TDBImage [9]
    Left = 289
    Top = 89
    Width = 238
    Height = 190
    BorderStyle = bsNone
    DataField = 'Image'
    DataSource = dsPosition
    TabOrder = 5
    Visible = False
  end
  object btnClearPicture: TDNMSpeedButton [10]
    Left = 337
    Top = 297
    Width = 87
    Height = 27
    Caption = 'Clear Picture'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 6
    OnClick = btnClearPictureClick
  end
  object pnlTitle: TDNMPanel [11]
    Left = 114
    Top = 11
    Width = 333
    Height = 45
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
      Width = 329
      Height = 41
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
        Width = 329
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Embroidery Position'
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
    Left = 496
  end
  inherited MyConnection: TMyConnection
    Left = 496
    Top = 40
  end
  inherited DataState: TDataState
    Left = 72
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 528
  end
  object qryPosition: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblembroideryposition'
      'WHERE EmbroideryPositionID = :EmbroideryPositionID')
    Left = 528
    Top = 72
    ParamData = <
      item
        DataType = ftString
        Name = 'EmbroideryPositionID'
        Value = ''
      end>
    object qryPositionEmbroideryPositionID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmbroideryPositionID'
      Origin = 'tblembroideryposition.EmbroideryPositionID'
      Visible = False
    end
    object qryPositionGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblembroideryposition.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPositionDescription: TStringField
      FieldName = 'Description'
      Origin = 'tblembroideryposition.Description'
      Size = 255
    end
    object qryPositionImage: TBlobField
      FieldName = 'Image'
      Origin = 'tblembroideryposition.Image'
    end
    object qryPositionmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblembroideryposition.msTimeStamp'
      Visible = False
    end
  end
  object dsPosition: TDataSource
    DataSet = qryPosition
    Left = 496
    Top = 72
  end
  object dlgImage: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp|JPEG Image File (*.jpg)|*.jpg'
    Left = 104
    Top = 8
  end
end
