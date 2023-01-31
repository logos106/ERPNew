inherited fmdebugclosingsdates: Tfmdebugclosingsdates
  Caption = 'fmdebugclosingsdates'
  ClientHeight = 637
  ClientWidth = 1055
  ExplicitWidth = 1063
  ExplicitHeight = 664
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 813001
  object Label6: TLabel
    Left = 16
    Top = 245
    Width = 50
    Height = 13
    HelpContext = 813002
    Caption = 'date From '
    Transparent = True
  end
  object Label7: TLabel
    Left = 240
    Top = 245
    Width = 33
    Height = 13
    HelpContext = 813003
    Caption = 'DAteto'
    Transparent = True
  end
  object DNMPanel1: TDNMPanel
    Left = 31
    Top = 18
    Width = 376
    Height = 195
    HelpContext = 813004
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      376
      195)
    object Bevel1: TBevel
      Left = 14
      Top = 14
      Width = 360
      Height = 179
      HelpContext = 813005
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitWidth = 529
    end
    object Label1: TLabel
      Left = 14
      Top = 14
      Width = 78
      Height = 15
      HelpContext = 813006
      Caption = 'Closing Dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 248
      Top = 40
      Width = 53
      Height = 15
      HelpContext = 813007
      Caption = '(2) Global'
      Transparent = True
    end
    object Label3: TLabel
      Left = 24
      Top = 88
      Width = 137
      Height = 15
      HelpContext = 813008
      Caption = '(3) Accounts Receivable'
      Transparent = True
    end
    object Label4: TLabel
      Left = 248
      Top = 88
      Width = 120
      Height = 15
      HelpContext = 813009
      Caption = '(4) Accounts Payable'
      Transparent = True
    end
    object Label5: TLabel
      Left = 24
      Top = 40
      Width = 210
      Height = 15
      HelpContext = 813010
      Caption = '(1) Summarised Transactions Before'
      Transparent = True
    end
    object cboGlobal: TwwDBDateTimePicker
      Left = 248
      Top = 56
      Width = 119
      Height = 23
      HelpContext = 813011
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Date = 39263.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
    end
    object cboAccountsRec: TwwDBDateTimePicker
      Left = 24
      Top = 104
      Width = 119
      Height = 23
      HelpContext = 813012
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Date = 39263.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
    end
    object cboAccountsPay: TwwDBDateTimePicker
      Left = 248
      Top = 104
      Width = 119
      Height = 23
      HelpContext = 813013
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Date = 39263.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 3
    end
    object cboSummarisedTransDate: TwwDBDateTimePicker
      Left = 24
      Top = 56
      Width = 119
      Height = 23
      HelpContext = 813014
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Date = 39263.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 159
      Top = 146
      Width = 75
      Height = 25
      Caption = 'refresh'
      TabOrder = 4
      OnClick = Button1Click
      HelpContext = 813015
    end
  end
  object dtFrom: TwwDBDateTimePicker
    Left = 16
    Top = 264
    Width = 193
    Height = 21
    HelpContext = 813016
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Date = 39263.000000000000000000
    Epoch = 1950
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 1
  end
  object dtTo: TwwDBDateTimePicker
    Left = 240
    Top = 264
    Width = 193
    Height = 21
    HelpContext = 813017
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Date = 39263.000000000000000000
    Epoch = 1950
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 2
  end
  object Button2: TButton
    Left = 134
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    HelpContext = 813018
  end
  object Memo1: TMemo
    Left = 439
    Top = 0
    Width = 616
    Height = 637
    Align = alRight
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
    HelpContext = 813019
  end
end
