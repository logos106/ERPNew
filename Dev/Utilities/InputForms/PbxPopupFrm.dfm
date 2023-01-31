inherited PbxPopupGUI: TPbxPopupGUI
  Left = 392
  Top = 178
  Caption = 'Call Monitor'
  ClientHeight = 227
  ClientWidth = 398
  Color = clSkyBlue
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 8
    Top = 138
    Width = 383
    Height = 40
    Shape = bsFrame
  end
  object Bevel1: TBevel [1]
    Left = 8
    Top = 74
    Width = 383
    Height = 57
    Shape = bsFrame
  end
  object lblCallerNum: TLabel [2]
    Left = 89
    Top = 77
    Width = 93
    Height = 24
    Caption = 'Unknown'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 48
    Top = 77
    Width = 34
    Height = 24
    Caption = 'Ph:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 17
    Top = 104
    Width = 64
    Height = 24
    Caption = 'Caller:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblName: TLabel [5]
    Left = 88
    Top = 104
    Width = 299
    Height = 24
    AutoSize = False
    Caption = 'Please Wait ...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblReplyLabel: TLabel [6]
    Left = 24
    Top = 144
    Width = 63
    Height = 24
    Caption = 'Reply:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object lblReply: TLabel [7]
    Left = 104
    Top = 144
    Width = 52
    Height = 24
    Caption = 'None'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object labelCounter: TLabel [8]
    Left = 0
    Top = 0
    Width = 398
    Height = 15
    Align = alTop
    Alignment = taCenter
    Caption = 'Click here to prevent closing this window in 100 seconds'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    Visible = False
    OnClick = labelCounterClick
  end
  object MediaPlayer1: TMediaPlayer [10]
    Left = -216
    Top = 0
    Width = 253
    Height = 30
    Visible = False
    TabOrder = 7
  end
  object btnClose: TDNMSpeedButton [11]
    Left = 304
    Top = 190
    Width = 89
    Height = 27
    Cancel = True
    Caption = '&Close'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object btnTransfer: TDNMSpeedButton [12]
    Left = 206
    Top = 146
    Width = 89
    Height = 27
    Caption = 'Transfer'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 1
    OnClick = btnTransferClick
  end
  object cboTransfer: TwwDBLookupCombo [13]
    Left = 56
    Top = 148
    Width = 137
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'User'#9'25'#9'User'#9'F'#9
      'Extension'#9'12'#9'Extension'#9'F'#9)
    LookupTable = qryExtensions
    LookupField = 'User'
    ParentFont = False
    TabOrder = 2
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object cboReply: TComboBox [14]
    Left = 56
    Top = 148
    Width = 137
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 3
    Text = 'Take Call'
    Visible = False
    Items.Strings = (
      'Back In 5 min'
      'Forward Call To Me'
      'In Meeting'
      'Not In Today'
      'Please Call Me'
      'Take Call'
      'Unavailable')
  end
  object btnReply: TDNMSpeedButton [15]
    Left = 206
    Top = 146
    Width = 89
    Height = 27
    Caption = 'Reply'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 4
    Visible = False
    OnClick = btnReplyClick
  end
  object btnView: TDNMSpeedButton [16]
    Left = 9
    Top = 190
    Width = 89
    Height = 27
    Caption = '&View Client'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 5
    OnClick = btnViewClick
  end
  object btnRecord: TDNMSpeedButton [17]
    Left = 205
    Top = 190
    Width = 89
    Height = 27
    Caption = 'Record'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 6
    OnClick = btnRecordClick
  end
  object btnAddToClient: TDNMSpeedButton [18]
    Left = 298
    Top = 146
    Width = 89
    Height = 27
    Caption = 'Add To Client'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 8
    OnClick = btnAddToClientClick
  end
  object btnMessage: TDNMSpeedButton [19]
    Left = 107
    Top = 190
    Width = 89
    Height = 27
    Caption = 'Message'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 9
    OnClick = btnMessageClick
  end
  object pnlTitle: TDNMPanel [20]
    Left = 47
    Top = 22
    Width = 309
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 305
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
        Width = 305
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'You have a Call...'
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
    Left = 280
    Top = 58
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 312
    Top = 58
  end
  inherited MyConnection: TMyConnection
    Left = 107
    Top = 9
  end
  inherited DataState: TDataState
    Top = 42
  end
  object qryExtensions: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Extension, PC, User FROM tblextensions'
      'WHERE Active = '#39'T'#39
      'Order By User')
    Left = 112
    Top = 138
  end
  object dlgRef: TCustomInputBox
    Caption = 'Reference'
    PasswordCharacter = #0
    EditBoxFont.Charset = DEFAULT_CHARSET
    EditBoxFont.Color = clWindowText
    EditBoxFont.Height = -11
    EditBoxFont.Name = 'MS Sans Serif'
    EditBoxFont.Style = []
    Message = 'Enter Reference (File Name characters Only)'
    MessageFont.Charset = ANSI_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -12
    MessageFont.Name = 'Arial'
    MessageFont.Style = [fsBold]
    Buttons = [sbOK, sbCancel]
    Width = 350
    Height = 150
    Color = 16240330
    Left = 241
    Top = 85
  end
  object timerHide: TTimer
    Enabled = False
    OnTimer = timerHideTimer
    Left = 360
    Top = 24
  end
end
