inherited fmDU_Client: TfmDU_Client
  Left = 810
  Top = 201
  HelpContext = 1142002
  Caption = 'fmDU_Client'
  ClientHeight = 458
  ExplicitLeft = 810
  ExplicitTop = 201
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 458
    ExplicitTop = 458
  end
  inherited pnlMain: TDNMPanel
    Height = 458
    HelpContext = 1142003
    ExplicitHeight = 458
    inherited pnlTop: TDNMPanel
      HelpContext = 1142015
      inherited Shader1: TShader
        inherited lblCaption: TLabel
          HelpContext = 1142004
          Caption = 'Client Properties'
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      Height = 409
      HelpContext = 1142005
      ExplicitHeight = 409
      object pnlUpdatecontacts: TDNMPanel
        Left = 1
        Top = 138
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
        object chkUpdatecontacts: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 321
          Height = 36
          HelpContext = 1142007
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 'Fix Contact Mobile numbers with the correct format '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = ValidateSelection
        end
        object chkUseRegionCountryforFax: TCheckBox
          Left = 362
          Top = 6
          Width = 261
          Height = 31
          HelpContext = 1142009
          Caption = 'Use Region country if the country is blank'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = ValidateSelection
        end
      end
      object pnlClient: TDNMPanel
        Left = 1
        Top = 1
        Width = 820
        Height = 137
        HelpContext = 1142008
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object chkClient: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 320
          Height = 129
          HelpContext = 1142011
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 'Fix Mobile numbers with the correct format '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = ValidateSelection
        end
        object optclient: TRadioGroup
          AlignWithMargins = True
          Left = 352
          Top = 4
          Width = 464
          Height = 92
          HelpContext = 1142010
          Items.Strings = (
            'Use Physical Address Country'#39's ISD Code'
            'Use Billto/Postal Address Country'#39's ISD Code')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = optclientClick
        end
        object chkUseRegionCountry: TCheckBox
          Left = 362
          Top = 100
          Width = 261
          Height = 31
          HelpContext = 1142012
          Caption = 'Use Region country if the country is blank'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          WordWrap = True
          OnClick = ValidateSelection
        end
      end
      object pnlMakePrimaryContacts: TDNMPanel
        Left = 1
        Top = 182
        Width = 820
        Height = 44
        HelpContext = 1142013
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object chkMakecontact: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 508
          Height = 36
          HelpContext = 1142014
          Align = alLeft
          Alignment = taLeftJustify
          Caption = 
            'Make a Contact Record for the Clients , Using Client Details , i' +
            'f None Created Already'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = ValidateSelection
        end
      end
    end
  end
end
