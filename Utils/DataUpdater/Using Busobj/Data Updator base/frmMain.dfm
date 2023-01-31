inherited fmMain: TfmMain
  Left = 261
  Top = 106
  Width = 483
  Height = 637
  Caption = 'ERP Data Update'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 475
  end
  inherited pnlBottom: TPanel
    Top = 560
    Width = 475
    object ProgressBar: TProgressBar
      Left = 144
      Top = 16
      Width = 713
      Height = 16
      Min = 0
      Max = 100
      TabOrder = 1
      Visible = False
    end
  end
  inherited pnlLeft: TPanel
    Height = 455
  end
  inherited pnlRight: TPanel
    Left = 458
    Height = 455
  end
  inherited memLog: TMemo
    Width = 408
    Height = 455
    Align = alNone
  end
  object grdInvalidTrans: TwwDBGrid [5]
    Left = 432
    Top = 104
    Width = 0
    Height = 65
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsInvalidTrans
    TabOrder = 5
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    Visible = False
  end
  inherited DbConn: TMyConnection
    Username = '`'
  end
  object InvalidTrans: TMyQuery
    Left = 320
    Top = 56
  end
  object dsInvalidTrans: TDataSource
    DataSet = InvalidTrans
    Left = 352
    Top = 64
  end
end
