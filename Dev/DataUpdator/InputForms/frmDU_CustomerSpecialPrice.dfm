inherited fmDU_CustomerSpecialPrice: TfmDU_CustomerSpecialPrice
  Left = 50
  Top = 201
  Caption = ''
  ExplicitLeft = 50
  ExplicitTop = 201
  ExplicitHeight = 194
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1636002
  inherited pnlMain: TDNMPanel
    HelpContext = 1636009
    inherited pnlTop: TDNMPanel
      HelpContext = 1636010
      inherited Shader1: TShader
        inherited lblCaption: TLabel
          Caption = 'Customer Special Price'
          HelpContext = 1636003
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      HelpContext = 1636011
      object DNMPanel1: TDNMPanel
        Left = 1
        Top = 1
        Width = 820
        Height = 80
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 1636004
        object edtupdateSpecialPrice: TLabeledEdit
          Left = 706
          Top = 30
          Width = 62
          Height = 23
          HelpContext = 1636005
          EditLabel.Width = 44
          EditLabel.Height = 15
          EditLabel.Caption = 'Amount'
          EditLabel.Transparent = True
          EditLabel.Layout = tlCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '1.00'
        end
        object OptupdateSpecialPricetype: TRadioGroup
          AlignWithMargins = True
          Left = 506
          Top = 17
          Width = 193
          Height = 44
          HelpContext = 1636006
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            '&Percentage'
            '&Dollars')
          TabOrder = 1
        end
        object OptupdateSpecialPriceOption: TRadioGroup
          AlignWithMargins = True
          Left = 215
          Top = 17
          Width = 290
          Height = 44
          Hint = 
            'Choosing Amount here will update all 3 costs of the product to v' +
            'alue given'
          HelpContext = 1636007
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            '&Increase By'
            '&Decrease By'
            '&Amount')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object chkupdateSpecialPrice: TCheckBox
          Left = 13
          Top = 30
          Width = 196
          Height = 17
          HelpContext = 1636008
          Alignment = taLeftJustify
          Caption = 'Update Customer Special Price'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
      end
    end
  end
end
