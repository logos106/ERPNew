object fmMain: TfmMain
  Left = 207
  Top = 306
  Width = 763
  Height = 625
  Caption = 'TCP XML Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 299
    Width = 755
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsLine
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 755
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 28
      Height = 13
      Caption = 'In File'
    end
    object Label2: TLabel
      Left = 16
      Top = 61
      Width = 31
      Height = 13
      Caption = 'Server'
    end
    object edtInFile: TEdit
      Left = 56
      Top = 20
      Width = 569
      Height = 21
      TabOrder = 0
      OnChange = edtInFileChange
    end
    object btnInFile: TButton
      Left = 624
      Top = 20
      Width = 33
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnInFileClick
    end
    object edtServer: TEdit
      Left = 56
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'edtServer'
      OnChange = edtServerChange
    end
  end
  object memResult: TMemo
    Left = 0
    Top = 304
    Width = 755
    Height = 246
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 1
    WantReturns = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 550
    Width = 755
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object memRequest: TMemo
    Left = 0
    Top = 89
    Width = 755
    Height = 210
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object OpenDialog: TOpenDialog
    Left = 512
    Top = 72
  end
  object TCPClient: TIdTCPClient
    IOHandler = IdSSLIOHandlerSocket
    MaxLineAction = maException
    Host = '127.0.0.1'
    Port = 9009
    Left = 336
    Top = 120
  end
  object IdSSLIOHandlerSocket: TIdSSLIOHandlerSocket
    SSLOptions.Method = sslvTLSv1
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 381
    Top = 113
  end
end
