inherited fmCoreEDITest: TfmCoreEDITest
  HelpContext = 1634002
  Caption = 'Core EDI Test'
  ClientHeight = 487
  ClientWidth = 730
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 746
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 487
    Width = 730
    HelpContext = 1634003
    ExplicitTop = 487
    ExplicitWidth = 730
  end
  object btnSendInvToQB: TButton [4]
    Left = 112
    Top = 23
    Width = 113
    Height = 25
    HelpContext = 1634004
    Caption = 'Send Inv QB'
    TabOrder = 0
    OnClick = btnSendInvToQBClick
  end
  object memLog: TMemo [5]
    Left = 8
    Top = 83
    Width = 714
    Height = 391
    HelpContext = 1634005
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object edtInvNo: TEdit [6]
    Left = 114
    Top = 54
    Width = 121
    Height = 23
    HelpContext = 1634006
    TabOrder = 2
    Text = '2670'
  end
  object btnGetQBInv: TButton [7]
    Left = 264
    Top = 23
    Width = 113
    Height = 25
    HelpContext = 1634007
    Caption = 'Get Inv QB'
    TabOrder = 3
    OnClick = btnGetQBInvClick
  end
  object edtQBInv: TEdit [8]
    Left = 266
    Top = 54
    Width = 121
    Height = 23
    HelpContext = 1634008
    TabOrder = 4
    Text = '1038'
  end
  object btnConnect: TButton [9]
    Left = 8
    Top = 23
    Width = 75
    Height = 25
    HelpContext = 1634009
    Caption = 'Connect'
    TabOrder = 5
    OnClick = btnConnectClick
  end
  object Button1: TButton [10]
    Left = 8
    Top = 52
    Width = 75
    Height = 25
    HelpContext = 1634010
    Caption = 'Initialize'
    TabOrder = 6
    OnClick = Button1Click
  end
  object btnGetCustId: TButton [11]
    Left = 408
    Top = 23
    Width = 75
    Height = 25
    HelpContext = 1634011
    Caption = 'Get Cust ID'
    TabOrder = 7
    OnClick = btnGetCustIdClick
  end
  object edtCustName: TEdit [12]
    Left = 408
    Top = 54
    Width = 121
    Height = 23
    HelpContext = 1634012
    TabOrder = 8
    Text = 'Cool Cars'
  end
  object btnSynch: TButton [13]
    Left = 544
    Top = 23
    Width = 75
    Height = 25
    HelpContext = 1634013
    Caption = 'Synch To QB'
    TabOrder = 9
    OnClick = btnSynchClick
  end
  object btnStopSynch: TButton [14]
    Left = 544
    Top = 54
    Width = 75
    Height = 25
    HelpContext = 1634014
    Caption = 'Stop'
    TabOrder = 10
    OnClick = btnStopSynchClick
  end
  inherited tmrProcessMessage: TTimer
    Left = 353
    Top = 19
  end
  inherited tmrdelay: TTimer
    Left = 312
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 648
    Top = 16
  end
  inherited tmrdelayMsg: TTimer
    Left = 264
    Top = 8
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 201
    Top = 65528
  end
end
