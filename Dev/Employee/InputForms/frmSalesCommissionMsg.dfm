inherited fmSalesCommissionMsg: TfmSalesCommissionMsg
  Left = 1769
  Top = 194
  BorderStyle = bsSingle
  Caption = 'Information'
  ClientHeight = 409
  ClientWidth = 463
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 711000
  object GeneralNote: TRTFLabel
    Left = 0
    Top = 44
    Width = 463
    Height = 322
    RichText = 
      '{\rtf1\ansi\ansicpg1252\deff0{\fonttbl{\f0\fnil\fcharset0 Arial;' +
      '}{\f1\fnil\fcharset2 Symbol;}}'#13#10'{\colortbl ;\red0\green0\blue0;}' +
      #13#10'\viewkind4\uc1\pard\li200\lang1033\b\fs18 Please Check the Fol' +
      'lowing :'#13#10'\par \pard '#13#10'\par \pard{\pntext\f1\'#39'B7\tab}{\*\pn\pnlv' +
      'lblt\pnf1\pnindent0{\pntxtb\'#39'B7}}\fi-200\li400\cf1\b0 Commission' +
      ' on all Sales Enabled  for the Employee'#13#10'\par \pard\li600\cf0 Pr' +
      'oduct(s) is not Excluded from Commission Calculation by Selectin' +
      'g it in                  '#13#10'\par \pard\li200         '#39'Products to' +
      ' Exclude from Sales Commission for the Employee'#39' \i '#13#10'\par '#13#10'\pa' +
      'r \i0 '#13#10'\par \pard{\pntext\f1\'#39'B7\tab}{\*\pn\pnlvlblt\pnf1\pnind' +
      'ent0{\pntxtb\'#39'B7}}\fi-200\li400\cf1 Commission on Products Enabl' +
      'ed for the Employee'#13#10'\par \pard\li600\cf0 Product(s) is Selected' +
      ' in '#13#10'\par \pard\li400         '#39'Product Commission for the Emplo' +
      'yee'#39' and is Active '#13#10'\par                                OR'#13#10'\pa' +
      'r \pard\li600 Product(s) is Selected in '#13#10'\par \pard\li400      ' +
      '   '#39'Product Commission for all Employees'#39' and is Active'#13#10'\par '#13#10 +
      '\par \pard{\pntext\f1\'#39'B7\tab}{\*\pn\pnlvlblt\pnf1\pnindent0{\pn' +
      'txtb\'#39'B7}}\fi-200\li400 Invoice is Fully Paid if  '#39'Commission is' +
      ' only for Paid Invoices'#39#13#10'\par \pard\li200 '#13#10'\par \pard{\pntext\' +
      'f1\'#39'B7\tab}{\*\pn\pnlvlblt\pnf1\pnindent0{\pntxtb\'#39'B7}}\fi-200\l' +
      'i400 Invoice has a Value'#13#10'\par \pard\li200 '#13#10'\par Note:Employee ' +
      '/ Product Sales Commission Configuration is Recorded Against the' +
      ' Sales Record for the First Time Only when the Commission is Cal' +
      'culated for any Sales Transaction. '#13#10'\par }'#13#10#0
    Transparent = True
    WordWrap = True
    Version = '1.3.0.0'
    HelpContext = 711001
  end
  object Label1: TLabel
    Left = 0
    Top = 13
    Width = 457
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '0 Record Found to Calculate Commission'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'MS Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
    HelpContext = 711002
  end
  object Bevel1: TBevel
    Left = 6
    Top = 66
    Width = 451
    Height = 299
    HelpContext = 711003
  end
  object cmdNew: TDNMSpeedButton
    Left = 188
    Top = 373
    Width = 87
    Height = 27
    Hint = '"Add A New Entry"'
    Anchors = [akBottom]
    Caption = '&Ok'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TabStop = False
    OnClick = cmdNewClick
    HelpContext = 711004
  end
end
