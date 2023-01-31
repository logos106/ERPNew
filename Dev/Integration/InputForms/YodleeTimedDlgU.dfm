object YodleeTimedDlg: TYodleeTimedDlg
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Yodlee Accounts Linking......'
  ClientHeight = 167
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 20
    Top = 3
    Width = 281
    Height = 26
    Margins.Left = 20
    Align = alTop
    Caption = 
      'This dialog will automatically close after 5 minutes or on succe' +
      'ssful linking of Yodlee accounts.'
    WordWrap = True
    ExplicitWidth = 267
  end
  object Label2: TLabel
    Left = 73
    Top = 101
    Width = 86
    Height = 13
    Caption = 'Time Left to Close'
  end
  object Label3: TLabel
    Left = 198
    Top = 101
    Width = 22
    Height = 13
    Caption = 'Secs'
  end
  object Label4: TLabel
    AlignWithMargins = True
    Left = 20
    Top = 42
    Width = 281
    Height = 13
    Margins.Left = 20
    Margins.Top = 10
    Align = alTop
    Caption = 'Press Abort if you want to cancel the linking operation.'
    WordWrap = True
    ExplicitWidth = 263
  end
  object Label5: TLabel
    AlignWithMargins = True
    Left = 20
    Top = 58
    Width = 281
    Height = 26
    Margins.Left = 20
    Margins.Top = 0
    Align = alTop
    Caption = 
      'Press Wait if you want to wait for 5 more minutes to continue th' +
      'e linking operation.'
    WordWrap = True
    ExplicitWidth = 253
  end
  object Panel1: TPanel
    Left = 0
    Top = 126
    Width = 304
    Height = 41
    Align = alBottom
    BorderStyle = bsSingle
    TabOrder = 0
    object btnWait: TButton
      Left = 40
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Wait'
      TabOrder = 0
      OnClick = btnWaitClick
    end
    object btnAbort: TButton
      Left = 163
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Abort'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnAbortClick
    end
  end
  object edSecs: TEdit
    Left = 165
    Top = 98
    Width = 27
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 1
    Text = '300'
  end
  object tmCountDown: TTimer
    Interval = 10000
    OnTimer = tmCountDownTimer
    Left = 256
    Top = 8
  end
end
