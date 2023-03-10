inherited fmAccountListEditPopUp: TfmAccountListEditPopUp
  BorderStyle = bsDialog
  Caption = 'Choose Edit Action'
  ClientHeight = 313
  ClientWidth = 396
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitWidth = 412
  ExplicitHeight = 352
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = -1
    Width = 396
    ExplicitTop = 187
    ExplicitWidth = 396
  end
  object btnAccountType: TAdvGlowButton [4]
    AlignWithMargins = True
    Left = 11
    Top = 10
    Width = 374
    Height = 100
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Align = alBottom
    Caption = 'Change the Default Account Type Name '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnAccountTypeClick
    Appearance.Color = 11599792
    Appearance.ColorChecked = 11599792
    Appearance.ColorCheckedTo = 11599792
    Appearance.ColorDisabled = 11599792
    Appearance.ColorDisabledTo = 11599792
    Appearance.ColorDown = 11599792
    Appearance.ColorDownTo = 11599792
    Appearance.ColorHot = 11599792
    Appearance.ColorHotTo = 11599792
    Appearance.ColorMirror = 11599792
    Appearance.ColorMirrorHot = 11599792
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 11599792
    Appearance.ColorMirrorDownTo = 11599792
    Appearance.ColorMirrorChecked = 11599792
    Appearance.ColorMirrorCheckedTo = 11599792
    Appearance.ColorMirrorDisabled = 11599792
    Appearance.ColorMirrorDisabledTo = 11599792
    ExplicitLeft = 6
    ExplicitTop = 18
    ExplicitWidth = 394
  end
  object btnAccountOrder: TAdvGlowButton [5]
    AlignWithMargins = True
    Left = 11
    Top = 132
    Width = 374
    Height = 100
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Align = alBottom
    Caption = 'Change the Order that the Accounts will be displayed in'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnAccountOrderClick
    Appearance.Color = 11599792
    Appearance.ColorChecked = 11599792
    Appearance.ColorCheckedTo = 11599792
    Appearance.ColorDisabled = 11599792
    Appearance.ColorDisabledTo = 11599792
    Appearance.ColorDown = 11599792
    Appearance.ColorDownTo = 11599792
    Appearance.ColorHot = 11599792
    Appearance.ColorHotTo = 11599792
    Appearance.ColorMirror = 11599792
    Appearance.ColorMirrorHot = 11599792
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 11599792
    Appearance.ColorMirrorDownTo = 11599792
    Appearance.ColorMirrorChecked = 11599792
    Appearance.ColorMirrorCheckedTo = 11599792
    Appearance.ColorMirrorDisabled = 11599792
    Appearance.ColorMirrorDisabledTo = 11599792
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 8
  end
  object btnCancel: TAdvGlowButton [6]
    AlignWithMargins = True
    Left = 133
    Top = 244
    Width = 130
    Height = 58
    Margins.Left = 133
    Margins.Top = 1
    Margins.Right = 133
    Margins.Bottom = 11
    Align = alBottom
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelClick
    Appearance.Color = 10921727
    Appearance.ColorChecked = 10921727
    Appearance.ColorCheckedTo = 10921727
    Appearance.ColorDisabled = 10921727
    Appearance.ColorDisabledTo = 10921727
    Appearance.ColorDown = 10921727
    Appearance.ColorDownTo = 10921727
    Appearance.ColorHot = 10921727
    Appearance.ColorHotTo = 10921727
    Appearance.ColorMirror = 10921727
    Appearance.ColorMirrorHot = 10921727
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 10921727
    Appearance.ColorMirrorDownTo = 10921727
    Appearance.ColorMirrorChecked = 10921727
    Appearance.ColorMirrorCheckedTo = 10921727
    Appearance.ColorMirrorDisabled = 10921727
    Appearance.ColorMirrorDisabledTo = 10921727
    ExplicitLeft = 138
  end
  inherited popSpelling: TPopupMenu
    Left = 224
    Top = 0
  end
  inherited tmrdelayMsg: TTimer
    Left = 152
    Top = 65528
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 113
    Top = 65520
  end
end
