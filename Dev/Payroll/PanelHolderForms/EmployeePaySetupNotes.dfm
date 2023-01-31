inherited frmEmployeePaySetupNotes: TfrmEmployeePaySetupNotes
  Left = 270
  Top = 200
  HelpContext = 571000
  Caption = 'Employee Pay Setup Notes'
  ClientHeight = 513
  ClientWidth = 859
  OldCreateOrder = True
  ExplicitLeft = 270
  ExplicitTop = 200
  ExplicitWidth = 875
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 513
    Width = 859
    HelpContext = 571001
    ExplicitTop = 513
    ExplicitWidth = 859
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 859
    Height = 513
    HelpContext = 571002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object memPayNotes: TMemo
      AlignWithMargins = True
      Left = 12
      Top = 12
      Width = 835
      Height = 489
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 11
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnExit = memPayNotesExit
      HelpContext = 571003
    end
  end
  object DSEmployees: TDataSource
    Left = 508
    Top = 2
  end
end
