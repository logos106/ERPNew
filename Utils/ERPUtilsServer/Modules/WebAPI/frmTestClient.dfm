object fmTestClient: TfmTestClient
  Left = 0
  Top = 0
  Caption = 'ERP Web API Test Client'
  ClientHeight = 572
  ClientWidth = 919
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter
    Left = 0
    Top = 208
    Width = 919
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 181
    ExplicitWidth = 581
  end
  object Panel1: TPanel
    Left = 0
    Top = 508
    Width = 919
    Height = 64
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 547
      Top = 0
      Width = 59
      Height = 14
      Caption = 'User Name'
    end
    object Label2: TLabel
      Left = 656
      Top = 0
      Width = 51
      Height = 14
      Caption = 'Password'
    end
    object Label3: TLabel
      Left = 768
      Top = 0
      Width = 50
      Height = 14
      Caption = 'Database'
    end
    object edtURL: TEdit
      Left = 8
      Top = 16
      Width = 321
      Height = 22
      TabOrder = 0
      Text = 'http://localhost/erpapi/'
      OnChange = edtURLChange
    end
    object btnGet: TButton
      Left = 344
      Top = 14
      Width = 57
      Height = 25
      Caption = 'Get'
      TabOrder = 1
      OnClick = btnGetClick
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 44
      Width = 917
      Height = 19
      Panels = <
        item
          Width = 300
        end>
    end
    object btnPost: TButton
      Left = 407
      Top = 13
      Width = 57
      Height = 25
      Caption = 'Post'
      TabOrder = 3
      OnClick = btnPostClick
    end
    object btnPut: TButton
      Left = 470
      Top = 13
      Width = 57
      Height = 25
      Caption = 'Put'
      TabOrder = 4
      Visible = False
      WordWrap = True
      OnClick = btnPutClick
    end
    object edtUser: TEdit
      Left = 544
      Top = 16
      Width = 97
      Height = 22
      TabOrder = 5
      OnChange = edtUserChange
    end
    object edtPass: TEdit
      Left = 656
      Top = 16
      Width = 97
      Height = 22
      TabOrder = 6
      OnChange = edtPassChange
    end
    object edtDatabase: TEdit
      Left = 768
      Top = 16
      Width = 137
      Height = 22
      TabOrder = 7
      OnChange = edtDatabaseChange
    end
  end
  object memOut: TMemo
    Left = 0
    Top = 0
    Width = 919
    Height = 208
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    OnChange = memOutChange
    OnDblClick = memOutDblClick
  end
  object memIn: TMemo
    Left = 0
    Top = 212
    Width = 919
    Height = 296
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object client: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    OnHeadersAvailable = clientHeadersAvailable
    Left = 104
    Top = 56
  end
  object OpenDialog: TOpenDialog
    Left = 504
    Top = 264
  end
end
