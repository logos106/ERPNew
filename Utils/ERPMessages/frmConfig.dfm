object fmConfig: TfmConfig
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Config'
  ClientHeight = 342
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    251
    342)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 9
    Top = 8
    Width = 32
    Height = 15
    Caption = 'Show'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 17
    Width = 232
    Height = 12
    Shape = bsBottomLine
  end
  object Label2: TLabel
    Left = 12
    Top = 96
    Width = 76
    Height = 15
    Caption = 'Message List'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 11
    Top = 105
    Width = 232
    Height = 12
    Shape = bsBottomLine
  end
  object Label3: TLabel
    Left = 32
    Top = 137
    Width = 45
    Height = 15
    Caption = 'List size'
  end
  object btnOk: TDNMSpeedButton
    Left = 19
    Top = 307
    Width = 87
    Height = 27
    HelpContext = 1064075
    Anchors = [akBottom]
    Caption = 'OK'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    Style = bsModern
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TDNMSpeedButton
    Left = 131
    Top = 307
    Width = 87
    Height = 27
    HelpContext = 1064075
    Anchors = [akBottom]
    Caption = 'Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    Style = bsModern
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object rbMessages: TRadioButton
    Left = 32
    Top = 42
    Width = 81
    Height = 17
    Caption = 'Messages'
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = rbMessagesClick
  end
  object rbDeleted: TRadioButton
    Left = 137
    Top = 42
    Width = 81
    Height = 17
    Caption = 'Deleted'
    TabOrder = 3
    OnClick = rbDeletedClick
  end
  object edtListSize: TAdvEdit
    Left = 112
    Top = 134
    Width = 49
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 4
    Text = '100'
    Visible = True
    OnChange = edtListSizeChange
    Version = '2.8.6.9'
  end
end
