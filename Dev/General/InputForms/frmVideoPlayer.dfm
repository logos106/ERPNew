object fmVideo: TfmVideo
  Left = 569
  Top = 188
  BorderStyle = bsDialog
  Caption = 'Video'
  ClientHeight = 510
  ClientWidth = 640
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    640
    510)
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 786001
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    Anchors = []
    Color = clWhite
    TabOrder = 0
    HelpContext = 786002
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 480
    Width = 640
    Height = 30
    Align = alBottom
    Color = clWhite
    TabOrder = 1
    DesignSize = (
      640
      30)
    HelpContext = 786003
    object MediaPlayer: TMediaPlayer
      Left = 221
      Top = 0
      Width = 197
      Height = 30
      ColoredButtons = []
      VisibleButtons = [btPlay, btPause, btStop, btNext, btPrev, btStep, btBack]
      Anchors = [akTop]
      Display = pnlMain
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      HelpContext = 786004
    end
  end
end
