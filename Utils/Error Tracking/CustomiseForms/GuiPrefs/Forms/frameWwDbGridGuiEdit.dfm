inherited frWwDbGridGuiEdit: TfrWwDbGridGuiEdit
  Width = 556
  Height = 395
  Constraints.MinHeight = 395
  Constraints.MinWidth = 556
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 556
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlColumns: TPanel
      Left = 0
      Top = 0
      Width = 556
      Height = 395
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object pnlColumnsTop: TPanel
        Left = 0
        Top = 0
        Width = 556
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Label1: TLabel
          Left = 18
          Top = 9
          Width = 50
          Height = 15
          Caption = 'Columns'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
      end
      object pnlColumnsLeft: TPanel
        Left = 0
        Top = 25
        Width = 17
        Height = 370
        Align = alLeft
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
      end
      object lstGridColumns: TCheckListBox
        Left = 17
        Top = 25
        Width = 376
        Height = 370
        OnClickCheck = lstGridColumnsClickCheck
        Align = alLeft
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 15
        ParentFont = False
        TabOrder = 2
      end
      object chkGridLines: TCheckBox
        Left = 409
        Top = 143
        Width = 120
        Height = 17
        Caption = 'Enable Grid Lines'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = chkGridLinesClick
      end
      object btnGridTitleFont: TDNMSpeedButton
        Left = 408
        Top = 24
        Width = 135
        Height = 29
        Caption = 'Grid Title Font'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 1
        ParentColor = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 3
        OnClick = btnGridTitleFontClick
      end
      object btnGridFont: TDNMSpeedButton
        Left = 408
        Top = 64
        Width = 135
        Height = 29
        Caption = 'Grid Font'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 1
        ParentColor = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 4
        OnClick = btnGridFontClick
      end
      object btnAltRowColour: TDNMSpeedButton
        Left = 408
        Top = 104
        Width = 135
        Height = 29
        Caption = 'Alternate Row Colour '
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 1
        ParentColor = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 5
        OnClick = btnAltRowColourClick
      end
    end
  end
  object pumFormula: TPopupMenu
    Left = 336
    Top = 16
    object mnuColumns: TMenuItem
      Caption = 'Columns'
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = 'add'
    end
    object N2: TMenuItem
      Caption = 'subtract'
    end
    object multiply1: TMenuItem
      Caption = 'multiply'
    end
    object divide1: TMenuItem
      Caption = 'divide'
    end
    object N3: TMenuItem
      Caption = '('
    end
    object N4: TMenuItem
      Caption = ')'
    end
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 248
    Top = 16
  end
  object dlgColor: TColorDialog
    Ctl3D = True
    Left = 168
    Top = 24
  end
end
