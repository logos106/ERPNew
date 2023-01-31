inherited FrForeigncurrencyEdit: TFrForeigncurrencyEdit
  inherited lblMsg: TLabel
    ExplicitTop = 288
  end
  object lstGridColumns: TCheckListBox [1]
    Left = 0
    Top = 0
    Width = 451
    Height = 288
    OnClickCheck = lstGridColumnsClickCheck
    Align = alClient
    Columns = 1
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    Style = lbOwnerDrawFixed
    TabOrder = 0
  end
  object qryFCOnReport: TERPQuery
    Left = 80
    Top = 136
  end
end
