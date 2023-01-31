inherited GoogleLeadsummaryGUI: TGoogleLeadsummaryGUI
  Left = 557
  Top = 488
  Caption = 'GoogleLeadsummaryGUI'
  ClientHeight = 131
  ClientWidth = 276
  ExplicitLeft = 557
  ExplicitTop = 488
  ExplicitWidth = 284
  ExplicitHeight = 158
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 955001
  inherited lblSkingroupMsg: TLabel
    Top = 131
    Width = 276
    ExplicitTop = 301
    ExplicitWidth = 405
    HelpContext = 955002
  end
  object pnlMain: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 276
    Height = 131
    Align = alClient
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      272
      127)
    HelpContext = 955003
    object lblNewLeads: TLabel
      Left = 44
      Top = 32
      Width = 66
      Height = 15
      Anchors = []
      Caption = 'New  Leads'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 45
      ExplicitTop = 33
      HelpContext = 955004
    end
    object lblNewVisits: TLabel
      Left = 50
      Top = 55
      Width = 60
      Height = 15
      Anchors = []
      Caption = 'New Visits'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 51
      ExplicitTop = 57
      HelpContext = 955005
    end
    object lblconversionRate: TLabel
      Left = 15
      Top = 79
      Width = 93
      Height = 15
      Anchors = []
      AutoSize = False
      Caption = 'Conversion Rate'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 16
      ExplicitTop = 82
      HelpContext = 955006
    end
    object lblcostperLead: TLabel
      Left = 27
      Top = 104
      Width = 80
      Height = 15
      Anchors = []
      AutoSize = False
      Caption = 'Cost Per Lead'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 28
      ExplicitTop = 107
      HelpContext = 955007
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 270
      Height = 15
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Google Lead Summary'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitLeft = 53
      ExplicitTop = 41
      ExplicitWidth = 63
      HelpContext = 955008
    end
    object edtNewLeads: TEdit
      Left = 129
      Top = 28
      Width = 121
      Height = 23
      Alignment = taRightJustify
      Anchors = []
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnDblClick = edtNewLeadsDblClick
      ExplicitLeft = 132
      ExplicitTop = 29
      HelpContext = 955009
    end
    object edtNewVisits: TEdit
      Left = 129
      Top = 51
      Width = 121
      Height = 23
      Alignment = taRightJustify
      Anchors = []
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 132
      ExplicitTop = 53
      HelpContext = 955010
    end
    object Edtconversionrate: TEdit
      Left = 129
      Top = 75
      Width = 121
      Height = 23
      Alignment = taRightJustify
      Anchors = []
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 132
      ExplicitTop = 78
      HelpContext = 955011
    end
    object edtcostperLead: TEdit
      Left = 129
      Top = 100
      Width = 121
      Height = 23
      Alignment = taRightJustify
      Anchors = []
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnDblClick = edtcostperLeadDblClick
      ExplicitLeft = 132
      ExplicitTop = 103
      HelpContext = 955012
    end
  end
end
