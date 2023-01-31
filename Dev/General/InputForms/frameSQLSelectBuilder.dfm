object frSQLSelectBuilder: TfrSQLSelectBuilder
  Left = 0
  Top = 0
  Width = 584
  Height = 307
  HelpContext = 594000
  TabOrder = 0
  object pnlFrame: TDNMPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 307
    HelpContext = 594001
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object lblSearchCriteria: TLabel
      Left = 16
      Top = 20
      Width = 98
      Height = 15
      HelpContext = 594002
      Caption = 'Selection Criteria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 16
      Top = 246
      Width = 50
      Height = 15
      HelpContext = 594003
      Caption = 'AND / OR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 90
      Top = 246
      Width = 26
      Height = 15
      HelpContext = 594004
      Caption = 'Field'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 256
      Top = 246
      Width = 69
      Height = 15
      HelpContext = 594005
      Caption = 'Comparison'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 392
      Top = 246
      Width = 31
      Height = 15
      HelpContext = 594006
      Caption = 'Value'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lstLines: TListBox
      Left = 16
      Top = 40
      Width = 433
      Height = 177
      HelpContext = 594007
      ItemHeight = 15
      TabOrder = 0
      OnClick = lstLinesClick
    end
    object cboAndOr: TComboBox
      Left = 16
      Top = 264
      Width = 65
      Height = 23
      HelpContext = 594008
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = ControlChange
      Items.Strings = (
        'AND'
        'OR')
    end
    object cboField: TComboBox
      Left = 88
      Top = 264
      Width = 161
      Height = 23
      HelpContext = 594009
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = ControlChange
    end
    object cboOperator: TComboBox
      Left = 256
      Top = 264
      Width = 129
      Height = 23
      HelpContext = 594010
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = ControlChange
      Items.Strings = (
        'all'
        'equal to'
        'not equal to'
        'greater than'
        'less than'
        'greater or equal to'
        'less or equal to'
        'is blank'
        'is not blank'
        'starts with'
        ''
        '')
    end
    object edtConstValue: TEdit
      Left = 392
      Top = 264
      Width = 177
      Height = 23
      HelpContext = 594011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = ControlChange
    end
    object btnAddListItem: TDNMSpeedButton
      Left = 471
      Top = 46
      Width = 87
      Height = 27
      HelpContext = 594012
      Caption = 'Add'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 5
      OnClick = btnAddListItemClick
    end
    object btnDeleteListItem: TDNMSpeedButton
      Left = 471
      Top = 78
      Width = 87
      Height = 27
      HelpContext = 594013
      Caption = 'Delete'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 6
      OnClick = btnDeleteListItemClick
    end
  end
end
