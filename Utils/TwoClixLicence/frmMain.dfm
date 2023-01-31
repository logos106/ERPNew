object fmMain: TfmMain
  Left = 385
  Top = 373
  BorderStyle = bsSingle
  Caption = '2Clix Licence'
  ClientHeight = 516
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 750
    Height = 516
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lbKey: TLabel
      Tag = 1
      Left = 535
      Top = 392
      Width = 9
      Height = 15
      HelpContext = 341059
      Caption = '...'
    end
    object lbxml: TLabel
      Tag = 1
      Left = 16
      Top = 264
      Width = 718
      Height = 41
      HelpContext = 341054
      AutoSize = False
      Caption = '***'
      Color = clMoneyGreen
      ParentColor = False
      WordWrap = True
    end
    object Label1: TLabel
      Left = 16
      Top = 376
      Width = 45
      Height = 15
      Caption = 'Client Id'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Tag = 1
      Left = 18
      Top = 425
      Width = 43
      Height = 15
      HelpContext = 341057
      Caption = 'Licence'
      Transparent = True
      Visible = False
    end
    object Label14: TLabel
      Tag = 1
      Left = 256
      Top = 424
      Width = 41
      Height = 15
      HelpContext = 341051
      Caption = 'Expires'
      Transparent = True
    end
    object Label2: TLabel
      Tag = 1
      Left = 152
      Top = 424
      Width = 32
      Height = 15
      HelpContext = 341051
      Caption = 'Starts'
      Transparent = True
    end
    object lbxmlOut: TLabel
      Tag = 1
      Left = 16
      Top = 312
      Width = 716
      Height = 41
      HelpContext = 341056
      AutoSize = False
      Caption = '***'
      Color = clMoneyGreen
      ParentColor = False
      WordWrap = True
    end
    object memClientEmail: TMemo
      Left = 8
      Top = 8
      Width = 728
      Height = 243
      Lines.Strings = (
        '')
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object btnReadLicence: TButton
      Left = 16
      Top = 480
      Width = 97
      Height = 25
      Caption = 'Read Licence'
      TabOrder = 9
      OnClick = btnReadLicenceClick
    end
    object edtClientId: TEdit
      Left = 16
      Top = 392
      Width = 57
      Height = 23
      TabOrder = 1
    end
    object edMID: TLabeledEdit
      Tag = 1
      Left = 86
      Top = 392
      Width = 121
      Height = 23
      HelpContext = 341070
      EditLabel.Width = 61
      EditLabel.Height = 15
      EditLabel.Caption = 'Machine ID'
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      LabelPosition = lpAbove
      LabelSpacing = 3
      ParentFont = False
      TabOrder = 2
    end
    object edLicenceID: TLabeledEdit
      Tag = 1
      Left = 214
      Top = 392
      Width = 121
      Height = 23
      HelpContext = 341071
      EditLabel.Width = 58
      EditLabel.Height = 15
      EditLabel.Caption = 'Licence ID'
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      LabelPosition = lpAbove
      LabelSpacing = 3
      ParentFont = False
      TabOrder = 3
    end
    object edCompanyName: TLabeledEdit
      Left = 344
      Top = 392
      Width = 177
      Height = 23
      HelpContext = 341069
      EditLabel.Width = 153
      EditLabel.Height = 15
      EditLabel.Caption = 'Company Name (on Server)'
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      LabelPosition = lpAbove
      LabelSpacing = 3
      ParentFont = False
      TabOrder = 4
    end
    object btnEncodeLicence: TButton
      Left = 128
      Top = 480
      Width = 121
      Height = 25
      Caption = 'Encode Licence'
      TabOrder = 10
      OnClick = btnEncodeLicenceClick
    end
    object edNoMultiSites: TLabeledEdit
      Tag = 1
      Left = 356
      Top = 442
      Width = 77
      Height = 23
      HelpContext = 341073
      EditLabel.Width = 72
      EditLabel.Height = 15
      EditLabel.Caption = 'No MultiSites'
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      LabelPosition = lpAbove
      LabelSpacing = 3
      ParentFont = False
      TabOrder = 7
      Text = '1'
    end
    object dtExpires: TDateTimePicker
      Tag = 1
      Left = 256
      Top = 442
      Width = 97
      Height = 23
      HelpContext = 341068
      CalAlignment = dtaLeft
      Date = 38321.5464185995
      Time = 38321.5464185995
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 6
    end
    object dtStarts: TDateTimePicker
      Tag = 1
      Left = 144
      Top = 442
      Width = 97
      Height = 23
      HelpContext = 341068
      CalAlignment = dtaLeft
      Date = 38321.5464185995
      Time = 38321.5464185995
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 5
      OnChange = dtStartsChange
    end
    object edNoClientSlots: TLabeledEdit
      Tag = 1
      Left = 436
      Top = 442
      Width = 109
      Height = 23
      HelpContext = 341072
      EditLabel.Width = 82
      EditLabel.Height = 15
      EditLabel.Caption = 'No Client Slots'
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      LabelPosition = lpAbove
      LabelSpacing = 3
      ParentFont = False
      TabOrder = 8
    end
    object cboLicence: TComboBox
      Left = 16
      Top = 440
      Width = 105
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 11
      Items.Strings = (
        'Install'
        'Stage60'
        'Stage365'
        'Stage365+')
    end
  end
  object LbBlowfish: TLbBlowfish
    CipherMode = cmECB
    Left = 587
    Top = 32
  end
  object XMLDocument: TALXMLDocument
    Left = 555
    Top = 32
  end
end
