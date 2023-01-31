object fmHireGroups: TfmHireGroups
  Left = 0
  Top = 0
  Caption = 'Groups exist'
  ClientHeight = 192
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1464002
  object lblHeader1: TLabel
    Left = 64
    Top = 27
    Width = 149
    Height = 15
    Caption = 'You Already Have A Line For'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    HelpContext = 1464003
  end
  object lblProduct: TLabel
    Left = 112
    Top = 48
    Width = 58
    Height = 15
    Caption = 'lblProduct'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1464004
  end
  object lblHeader2: TLabel
    Left = 31
    Top = 69
    Width = 220
    Height = 15
    Caption = 'Would You Like To Add To This Line Qty?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    HelpContext = 1464005
  end
  object btnAdd: TDNMSpeedButton
    Left = 8
    Top = 152
    Width = 100
    Height = 23
    Caption = 'Add To Selected'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    ModalResult = 1
    TabOrder = 0
    HelpContext = 1464006
  end
  object btnDoNotAdd: TDNMSpeedButton
    Left = 117
    Top = 152
    Width = 100
    Height = 23
    Caption = 'Make New Line'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    ModalResult = 5
    TabOrder = 1
    HelpContext = 1464007
  end
  object cbGroups: TComboBox
    Left = 8
    Top = 104
    Width = 318
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = 'Hire: 2016/11/30 06:30 AM To 2016/12/01 05:00 AM'
    Items.Strings = (
      'Hire: 2016/11/30 06:30 AM To 2016/12/01 05:00 AM')
    HelpContext = 1464008
  end
  object btnCancel: TDNMSpeedButton
    Left = 226
    Top = 152
    Width = 100
    Height = 23
    Caption = 'Cancel'
    DisableTransparent = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    ModalResult = 2
    TabOrder = 3
    HelpContext = 1464009
  end
end
