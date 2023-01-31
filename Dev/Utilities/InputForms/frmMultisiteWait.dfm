inherited MultisiteWaitGUI: TMultisiteWaitGUI
  Left = 439
  Top = 325
  Caption = 'Please Wait.......'
  ClientHeight = 156
  FormStyle = fsStayOnTop
  OnCloseQuery = FormCloseQuery
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 73
    Top = 28
    Enabled = False
    Visible = False
  end
  inherited btnClose: TDNMSpeedButton [1]
    Left = 142
    Top = 84
    Enabled = False
    Visible = False
  end
  inherited chkDontShowHint: TwwCheckBox [2]
    Left = 57
    Top = 27
    Enabled = False
    Visible = False
  end
  inherited Panel1: TPanel [3]
    Height = 116
    inherited HintHeader: TLabel
      Width = 231
      Caption = 'Multisite Transfer Initialising'
      Font.Height = -16
    end
    inherited HintMemo: TMemo
      Left = 59
      Top = 51
      Width = 197
      Height = 48
      Font.Height = -13
      Lines.Strings = (
        'Performing Verification of Tables'
        ''
        'Please Wait...................')
    end
  end
  object ProgressTime1: TProgressTime
    Left = 0
    Top = 122
    Width = 332
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    Active = False
    BarWidth = 9
    BarColor = clCream
    MilliSec = False
  end
end
