object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'DTD To XML'
  ClientHeight = 401
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 635
    Height = 81
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 25
      Height = 15
      Caption = 'DTD'
    end
    object Label2: TLabel
      Left = 16
      Top = 46
      Width = 23
      Height = 15
      Caption = 'XML'
    end
    object edtDTD: TEdit
      Left = 48
      Top = 16
      Width = 281
      Height = 23
      TabOrder = 0
      Text = 'edtDTD'
      OnChange = edtDTDChange
    end
    object edtXML: TEdit
      Left = 48
      Top = 43
      Width = 281
      Height = 23
      TabOrder = 1
      Text = 'edtXML'
      OnChange = edtXMLChange
    end
    object btnDTD: TButton
      Left = 328
      Top = 16
      Width = 27
      Height = 23
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnDTDClick
    end
    object btnXML: TButton
      Left = 328
      Top = 43
      Width = 27
      Height = 23
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnXMLClick
    end
    object btnConvert: TButton
      Left = 376
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Convert'
      TabOrder = 4
      OnClick = btnConvertClick
    end
    object chkQuantifier: TCheckBox
      Left = 472
      Top = 16
      Width = 129
      Height = 17
      Caption = 'Show Quantifiers'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object chkRequired: TCheckBox
      Left = 472
      Top = 39
      Width = 129
      Height = 17
      Caption = 'Required Only'
      TabOrder = 6
    end
  end
  object memLog: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 320
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object OpenDialog: TOpenDialog
    Left = 224
    Top = 120
  end
  object SaveDialog: TSaveDialog
    Left = 232
    Top = 192
  end
end
