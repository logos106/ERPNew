inherited fmDU_MiscDataUpdates: TfmDU_MiscDataUpdates
  Left = 360
  Top = 152
  Caption = 'fmDU_MiscDataUpdates'
  ExplicitLeft = 360
  ExplicitTop = 152
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TDNMPanel
    inherited pnlTop: TDNMPanel
      inherited Shader1: TShader
        inherited lblCaption: TLabel
          Caption = 'Data Updates'
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      object pnlMakePrimaryContacts: TDNMPanel
        Left = 1
        Top = 1
        Width = 820
        Height = 44
        HelpContext = 1142006
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object chkfixUOM: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 117
          Height = 36
          HelpContext = 1142007
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 'Fix UOM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
        end
      end
    end
  end
end
