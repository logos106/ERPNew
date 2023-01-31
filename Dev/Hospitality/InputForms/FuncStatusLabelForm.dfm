inherited FuncStatusLabelGUI: TFuncStatusLabelGUI
  Left = 340
  Top = 225
  Caption = 'Function Status Labels'
  ClientHeight = 348
  ClientWidth = 400
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 48
    Top = 69
    Width = 305
    Height = 225
    Shape = bsFrame
  end
  object Label1: TLabel [1]
    Left = 104
    Top = 85
    Width = 38
    Height = 15
    Caption = 'Label1'
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 104
    Top = 120
    Width = 38
    Height = 15
    Caption = 'Label2'
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 104
    Top = 156
    Width = 38
    Height = 15
    Caption = 'Label3'
    Transparent = True
  end
  object Label4: TLabel [4]
    Left = 104
    Top = 191
    Width = 38
    Height = 15
    Caption = 'Label4'
    Transparent = True
  end
  object Label5: TLabel [5]
    Left = 104
    Top = 227
    Width = 38
    Height = 15
    Caption = 'Label5'
    Transparent = True
  end
  object Label6: TLabel [6]
    Left = 104
    Top = 263
    Width = 38
    Height = 15
    Caption = 'Label6'
    Transparent = True
  end
  object btnCancel: TDNMSpeedButton [8]
    Left = 244
    Top = 305
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
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object edtLabel1: TwwDBEdit [9]
    Left = 163
    Top = 81
    Width = 150
    Height = 23
    DataField = 'Status1'
    DataSource = dsFuncStatuses
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
  object edtLabel2: TwwDBEdit [10]
    Left = 163
    Top = 116
    Width = 150
    Height = 23
    DataField = 'Status2'
    DataSource = dsFuncStatuses
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtLabel3: TwwDBEdit [11]
    Left = 163
    Top = 151
    Width = 150
    Height = 23
    DataField = 'Status3'
    DataSource = dsFuncStatuses
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtLabel4: TwwDBEdit [12]
    Left = 163
    Top = 186
    Width = 150
    Height = 23
    DataField = 'Status4'
    DataSource = dsFuncStatuses
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtLabel5: TwwDBEdit [13]
    Left = 163
    Top = 221
    Width = 150
    Height = 23
    DataField = 'Status5'
    DataSource = dsFuncStatuses
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtLabel6: TwwDBEdit [14]
    Left = 163
    Top = 257
    Width = 150
    Height = 23
    DataField = 'Status6'
    DataSource = dsFuncStatuses
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object btnSave: TDNMSpeedButton [15]
    Left = 67
    Top = 305
    Width = 87
    Height = 27
    Caption = 'Save'
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
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object pnlTitle: TDNMPanel [16]
    Left = 27
    Top = 6
    Width = 348
    Height = 45
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 344
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
        Width = 344
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Function Status Labels'
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
    Left = 80
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 7
    Top = 25
  end
  inherited MyConnection: TMyConnection
    Left = 118
    Top = 4
  end
  inherited DataState: TDataState
    Left = 7
    Top = 49
  end
  object qryFuncStatuses: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFuncStatuses')
    Left = 293
    Top = 8
    object qryFuncStatusesStatus1: TStringField
      FieldName = 'Status1'
      Size = 255
    end
    object qryFuncStatusesStatus2: TStringField
      FieldName = 'Status2'
      Size = 255
    end
    object qryFuncStatusesStatus3: TStringField
      FieldName = 'Status3'
      Size = 255
    end
    object qryFuncStatusesStatus4: TStringField
      FieldName = 'Status4'
      Size = 255
    end
    object qryFuncStatusesStatus5: TStringField
      FieldName = 'Status5'
      Size = 255
    end
    object qryFuncStatusesStatus6: TStringField
      FieldName = 'Status6'
      Size = 255
    end
  end
  object dsFuncStatuses: TDataSource
    DataSet = qryFuncStatuses
    Left = 232
    Top = 8
  end
end
