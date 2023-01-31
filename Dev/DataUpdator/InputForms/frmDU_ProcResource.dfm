inherited fmDU_ProcResource: TfmDU_ProcResource
  Left = 339
  Top = 246
  Caption = 'fmDU_ProcResource'
  ExplicitLeft = 339
  ExplicitTop = 246
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TDNMPanel
    inherited pnlTop: TDNMPanel
      inherited Shader1: TShader
        inherited lblCaption: TLabel
          Caption = 'BOM Resource Properties'
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
        object pnlUOM: TLabel
          AlignWithMargins = True
          Left = 167
          Top = 4
          Width = 123
          Height = 36
          HelpContext = 984042
          Align = alLeft
          Caption = 'Resource Hourly Rate'
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = 4
          ExplicitHeight = 15
        end
        object chkupdateHourlyRate: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 157
          Height = 36
          HelpContext = 1142007
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 'Update Hourly Rate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = chkupdateHourlyRateClick
          ExplicitLeft = 75
          ExplicitTop = 28
        end
        object edtHourlyRate: TEdit
          AlignWithMargins = True
          Left = 296
          Top = 9
          Width = 84
          Height = 26
          HelpContext = 984050
          Margins.Top = 8
          Margins.Right = 44
          Margins.Bottom = 8
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ExplicitLeft = 133
          ExplicitHeight = 23
        end
        object chkMakeRate0: TCheckBox
          AlignWithMargins = True
          Left = 427
          Top = 4
          Width = 182
          Height = 36
          HelpContext = 1142007
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 'Clear Hourly Rate (Make it 0)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          WordWrap = True
          OnClick = chkMakeRate0Click
        end
      end
    end
  end
end
