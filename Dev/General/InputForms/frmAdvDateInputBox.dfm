inherited fmAdvDateInputBox: TfmAdvDateInputBox
  Left = 637
  Top = 74
  Caption = 'fmAdvDateInputBox'
  ClientHeight = 175
  ExplicitLeft = 637
  ExplicitTop = 74
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1376002
  inherited lblPrompt: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 11
    Width = 343
    Margins.Top = 11
    Margins.Bottom = 11
    Align = alTop
    ExplicitLeft = 3
    ExplicitTop = 11
    ExplicitWidth = 343
    HelpContext = 1376003
  end
  inherited edtDate: TDateTimePicker
    AlignWithMargins = True
    Top = 48
    Margins.Left = 94
    Margins.Top = 11
    Margins.Right = 94
    Margins.Bottom = 11
    Align = alTop
    ExplicitTop = 48
  end
  inherited DNMPanel1: TDNMPanel
    Left = 0
    Top = 121
    Width = 349
    Height = 54
    Align = alClient
    ExplicitLeft = 0
    ExplicitTop = 121
    ExplicitWidth = 349
    ExplicitHeight = 54
    HelpContext = 1376004
    inherited btnOk: TDNMSpeedButton
      Left = 71
      Top = 13
      Anchors = []
      Default = True
      ModalResult = 0
      OnClick = btnOkClick
      ExplicitLeft = 71
      ExplicitTop = 13
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 191
      Top = 13
      Anchors = []
      Cancel = True
      ModalResult = 0
      OnClick = btnCancelClick
      ExplicitLeft = 191
      ExplicitTop = 13
    end
  end
  object chkOption: TCheckBox
    AlignWithMargins = True
    Left = 11
    Top = 93
    Width = 335
    Height = 17
    Margins.Left = 11
    Margins.Top = 11
    Margins.Bottom = 11
    Align = alTop
    Caption = 'Option'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    WordWrap = True
    HelpContext = 1376005
  end
end