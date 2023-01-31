inherited ShippingAgentGUI: TShippingAgentGUI
  Left = 121
  Top = 274
  HelpContext = 749000
  Caption = 'Shipping Agent List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    HelpContext = 749001
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 749002
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 749003
    inherited pnlHeader: TPanel
      HelpContext = 749004
      inherited TitleShader: TShader
        HelpContext = 749005
        inherited TitleLabel: TLabel
          HelpContext = 749006
          Caption = 'Shipping Agent List'
        end
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 749007
    inherited grdMain: TwwDBGrid
      HelpContext = 749008
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'Code'#9'20'#9'Code'#9'F'#9
        'Insurance'#9'50'#9'Insurance'#9'F'
        'Description'#9'50'#9'Description'#9#9
        'Active'#9'1'#9'Active'#9#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select * from tblShippingAgent')
    object qryMainCode: TWideStringField
      DisplayWidth = 20
      FieldName = 'Code'
      Origin = 'tblShippingAgent.Code'
      Size = 10
    end
    object qryMainInsurance: TWideStringField
      DisplayWidth = 50
      FieldName = 'Insurance'
      Size = 255
    end
    object qryMainDescription: TWideStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Origin = 'tblShippingAgent.Description'
      Size = 100
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblShippingAgent.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tblShippingAgent.Globalref'
      Visible = False
      Size = 255
    end
    object qryMainShippingAgentID: TLargeintField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'ShippingAgentID'
      Origin = 'tblShippingAgent.ShippingAgentID'
      Visible = False
    end
    object qryMainmstimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimeStamp'
      Origin = 'tblShippingAgent.mstimeStamp'
      Visible = False
    end
  end
end
