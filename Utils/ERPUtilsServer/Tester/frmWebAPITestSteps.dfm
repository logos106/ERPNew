inherited fmWebApiTestSteps: TfmWebApiTestSteps
  Caption = 'Web API Test'
  ClientHeight = 533
  ClientWidth = 915
  Font.Height = -13
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 931
  ExplicitHeight = 572
  PixelsPerInch = 96
  TextHeight = 16
  inherited pnlMain: TDNMPanel
    Width = 915
    Height = 533
    ExplicitWidth = 915
    ExplicitHeight = 533
    object Label3: TLabel [0]
      Left = 655
      Top = 73
      Width = 242
      Height = 15
      Caption = '( eg 74.125.237.83 leave blank if unknown )'
    end
    object Label1: TLabel [1]
      Left = 2
      Top = 73
      Width = 100
      Height = 15
      Caption = 'ERP Server Name'
    end
    object lblInternetAddress: TLabel [2]
      Left = 335
      Top = 73
      Width = 95
      Height = 15
      Caption = 'Internet Address'
    end
    inherited ScrollBox: TScrollBox
      Left = 5
      Top = 98
      TabOrder = 4
      ExplicitLeft = 5
      ExplicitTop = 98
    end
    inherited btnTest: TDNMSpeedButton
      Left = 343
      TabOrder = 5
      OnClick = btnTestClick
      ExplicitLeft = 343
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 485
      ExplicitLeft = 485
    end
    inherited pnlTitle: TDNMPanel
      Left = 245
      ExplicitLeft = 245
    end
    object edtERPServer: TEdit
      Left = 109
      Top = 69
      Width = 204
      Height = 23
      TabOrder = 0
      Text = 'ERPServer1'
    end
    object edtPublicIP: TEdit
      Left = 436
      Top = 69
      Width = 205
      Height = 23
      TabOrder = 1
      Text = 'erpclientserver.dyndns.org'
    end
  end
end
