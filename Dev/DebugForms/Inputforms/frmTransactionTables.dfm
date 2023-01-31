inherited fmTransactionTables: TfmTransactionTables
  Left = 524
  Top = 160
  Caption = 'fmTransactionTables'
  ClientHeight = 457
  ClientWidth = 988
  ExplicitLeft = 524
  ExplicitTop = 160
  ExplicitWidth = 996
  ExplicitHeight = 484
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 457
    Width = 988
  end
  object Label1: TLabel [3]
    Left = 184
    Top = 51
    Width = 97
    Height = 15
    Alignment = taRightJustify
    Caption = 'SQL Number'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtNumebr: TEdit [4]
    Left = 288
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '01'
  end
  object Button1: TButton [5]
    Left = 424
    Top = 48
    Width = 153
    Height = 25
    Caption = 'generate'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo [6]
    Left = 0
    Top = 88
    Width = 988
    Height = 369
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
end
