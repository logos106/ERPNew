object frmBaseGUI: TfrmBaseGUI
  Left = 630
  Top = 367
  ClientHeight = 155
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSkingroupMsg: TLabel
    Left = 0
    Top = 155
    Width = 299
    Height = 0
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblSkingroupMsg'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
    ExplicitTop = 131
  end
  object shapehint: TShape
    Left = 10
    Top = 2
    Width = 33
    Height = 23
    Brush.Style = bsClear
    Pen.Color = clYellow
    Pen.Width = 4
    Visible = False
  end
  object shapehintextra1: TShape
    Left = 50
    Top = 2
    Width = 33
    Height = 23
    Brush.Style = bsClear
    Pen.Color = clYellow
    Pen.Width = 4
    Visible = False
  end
  object shapehintextra2: TShape
    Left = 58
    Top = 10
    Width = 33
    Height = 23
    Brush.Style = bsClear
    Pen.Color = clYellow
    Pen.Width = 4
    Visible = False
  end
  object tmrProcessMessage: TTimer
    OnTimer = tmrProcessMessageTimer
    Left = 1
    Top = 3
  end
  object tmrdelay: TTimer
    Left = 56
    Top = 8
  end
  object popSpelling: TPopupMenu
    Left = 136
    Top = 48
    object Undo1: TMenuItem
      Caption = 'Undo'
      OnClick = HandlePopupClick
    end
    object Line1: TMenuItem
      Caption = '-'
    end
    object cut_1: TMenuItem
      Caption = 'Cut'
      OnClick = HandlePopupClick
    end
    object copy_1: TMenuItem
      Caption = 'Copy'
      OnClick = HandlePopupClick
    end
    object Paste_1: TMenuItem
      Caption = 'Paste'
      OnClick = HandlePopupClick
    end
    object delete_1: TMenuItem
      Caption = 'Delete'
      OnClick = HandlePopupClick
    end
    object Line2: TMenuItem
      Caption = '-'
    end
    object mnuSpelling: TMenuItem
      Caption = 'Spelling'
      OnClick = mnuSpellingClick
    end
    object mnuSpellingOptions: TMenuItem
      Caption = 'Spelling Options'
      OnClick = mnuSpellingOptionsClick
    end
  end
  object tmrdelayMsg: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrdelayMsgTimer
    Left = 56
    Top = 56
  end
end
