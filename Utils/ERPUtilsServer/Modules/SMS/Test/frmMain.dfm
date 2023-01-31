object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'SMS API Test'
  ClientHeight = 571
  ClientWidth = 827
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    827
    571)
  PixelsPerInch = 96
  TextHeight = 17
  object Button1: TButton
    Left = 16
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 0
    OnClick = Button1Click
  end
  object memLog: TMemo
    Left = 8
    Top = 128
    Width = 811
    Height = 435
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button2: TButton
    Left = 16
    Top = 63
    Width = 75
    Height = 25
    Caption = 'User Info'
    TabOrder = 2
    OnClick = Button2Click
  end
  object edtTo: TEdit
    Left = 112
    Top = 32
    Width = 121
    Height = 25
    TabOrder = 3
    Text = '+61405419565'
  end
  object edtMsg: TEdit
    Left = 248
    Top = 32
    Width = 401
    Height = 25
    TabOrder = 4
    Text = 'Test message'
  end
  object rgType: TRadioGroup
    Left = 665
    Top = 24
    Width = 154
    Height = 33
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'SMS'
      'Voice')
    TabOrder = 5
  end
  object Button3: TButton
    Left = 16
    Top = 94
    Width = 105
    Height = 25
    Caption = 'Check Replies'
    TabOrder = 6
    OnClick = Button3Click
  end
  object chkConfirm: TCheckBox
    Left = 136
    Top = 98
    Width = 97
    Height = 17
    Caption = 'Confirm'
    TabOrder = 7
  end
  object rgService: TRadioGroup
    Left = 272
    Top = 72
    Width = 377
    Height = 50
    Caption = 'Service'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'Message Media'
      'Twilio')
    TabOrder = 8
  end
end
