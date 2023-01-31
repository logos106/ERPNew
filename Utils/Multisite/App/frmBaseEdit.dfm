inherited fmBaseEdit: TfmBaseEdit
  Caption = 'fmBaseEdit'
  OldCreateOrder = True
  OnPaint = nil
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TDNMPanel
    Left = 0
    Top = 277
    Width = 472
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object btnOK: TDNMSpeedButton
      Left = 174
      Top = 13
      Width = 87
      Height = 27
      Caption = 'OK'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
    end
    object btnCancel: TDNMSpeedButton
      Left = 302
      Top = 13
      Width = 87
      Height = 27
      Caption = 'Cancel'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
    end
  end
end
