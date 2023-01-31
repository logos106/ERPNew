inherited fmMain: TfmMain
  Left = 557
  Top = 107
  Width = 462
  Height = 637
  Caption = 'ERP Data Update'
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 454
  end
  inherited pnlBottom: TPanel
    Top = 560
    Width = 454
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
    Left = 437
    Height = 455
  end
  inherited memLog: TMemo
    Width = 408
    Height = 455
    Align = alNone
    Lines.Strings = (
      '1: Re-Compile APIDLL.dll(P1\Utils\APIDLL) : Updates the '
      '     DLL with the latest version of busobj'
      ''
      
        '2.  Please Add the following to the Tools..Environment Options..' +
        '..Library'
      '      C:\P1\Dev\General\Objects\CommonObjects'
      '      C:\P1\Dev\General\Objects\CommonObjects\FastFuncs')
  end
  object grdInvalidTrans: TwwDBGrid [5]
    Left = 432
    Top = 104
    Width = 0
    Height = 65
    Selected.Strings = (
      'TransID'#9'10'#9'Sale Id'#9'F'
      'Transtype'#9'10'#9'Type'#9'F'
      'OHeader'#9'10'#9'Header'#9'F'#9'Before Update'
      'OLines'#9'10'#9'Lines'#9'F'#9'Before Update'
      'NHEader'#9'10'#9'Header'#9'F'#9'After Update'
      'Payment'#9'10'#9'Payment'#9'F'
      'description'#9'100'#9'Description'#9'F')
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
    TitleLines = 2
    TitleButtons = False
    UseTFields = False
    Visible = False
  end
  inherited DbConn: TMyConnection
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
  end
  object InvalidTrans: TMyQuery
    Connection = DbConn
    SQL.Strings = (
      'select * from tmp_log')
    AutoCalcFields = False
    Left = 320
    Top = 56
    object InvalidTransID: TIntegerField
      FieldName = 'ID'
    end
    object InvalidTransTransID: TIntegerField
      FieldName = 'TransID'
    end
    object InvalidTransTranstype: TStringField
      FieldName = 'Transtype'
      Size = 255
    end
    object InvalidTransOHeader: TFloatField
      FieldName = 'OHeader'
    end
    object InvalidTransOLines: TFloatField
      FieldName = 'OLines'
    end
    object InvalidTransPayment: TFloatField
      FieldName = 'Payment'
    end
    object InvalidTransNHEader: TFloatField
      FieldName = 'NHEader'
    end
    object InvalidTransdescription: TStringField
      FieldName = 'description'
      Size = 100
    end
  end
  object dsInvalidTrans: TDataSource
    DataSet = InvalidTrans
    Left = 352
    Top = 64
  end
end
