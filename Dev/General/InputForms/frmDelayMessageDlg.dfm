object fmDelayMessageDlg: TfmDelayMessageDlg
  Left = 348
  Top = 205
  BorderStyle = bsDialog
  Caption = 'fmDelayMessageDlg'
  ClientHeight = 130
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 360
    Top = 16
  end
end
