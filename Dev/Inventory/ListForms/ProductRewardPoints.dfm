inherited ProductRewardPointsGUI: TProductRewardPointsGUI
  Left = 146
  Top = 159
  HelpContext = 205000
  Caption = 'Product Reward Points List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 205001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 205002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 205003
    end
    inherited lblTotal: TLabel
      HelpContext = 205004
    end
    inherited lblNote: TLabel
      HelpContext = 205005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 205006
    end
    inherited lblTime: TLabel
      HelpContext = 205007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 205008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 205009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 205010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 205011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 205012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 205013
      inherited LblChooseTemplate: TLabel
        HelpContext = 205014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 205015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 205016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 205017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 205018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 205019
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
    HelpContext = 205020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 205021
    end
    inherited lblTo: TLabel
      HelpContext = 205022
    end
    inherited pnlHeader: TPanel
      HelpContext = 205023
      inherited TitleShader: TShader
        HelpContext = 205024
        inherited TitleLabel: TLabel
          HelpContext = 205025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 205026
      inherited grpFilters: TwwRadioGroup
        Width = 240
        HelpContext = 205027
        Align = alLeft
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Not Active'
          'Both')
        ExplicitWidth = 240
      end
      inherited pnlButtons: TPanel
        HelpContext = 205028
        inherited lblcustomReport: TLabel
          HelpContext = 205029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 205030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 205031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 205032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 205033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 205034
        end
      end
      object grpFilters2: TRadioGroup
        Left = 681
        Top = 0
        Width = 317
        Height = 37
        HelpContext = 205035
        Align = alClient
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemIndex = 2
        Items.Strings = (
          'Date Range'
          'No Range'
          'Both')
        ParentFont = False
        TabOrder = 2
        OnClick = grpFiltersClick
        ExplicitLeft = 687
        ExplicitTop = -1
      end
    end
    inherited Panel3: TPanel
      HelpContext = 205036
      inherited lblFilter: TLabel
        HelpContext = 205037
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 205038
      end
      inherited cboFilter: TComboBox
        HelpContext = 205039
      end
      inherited edtSearch: TEdit
        HelpContext = 205040
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 205041
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 205042
    end
    inherited cboDateRange: TComboBox
      HelpContext = 205043
    end
  end
  inherited Panel1: TPanel
    HelpContext = 205044
    inherited lblDateComments: TLabel
      Width = 998
      HelpContext = 205045
    end
    inherited grdMain: TwwDBGrid
      HelpContext = 205045
      ControlType.Strings = (
        'UseDate;CheckBox;T;F'
        'Active;CheckBox;T;F'
        'UseUOM;CheckBox;T;F'
        'UseExpiryDate;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'10'#9'GlobalRef'#9'F'
        'Partname'#9'20'#9'Product'#9'F'
        'UseUOM'#9'1'#9'Use?'#9'F'#9'UOM'
        'UOM'#9'13'#9'Name'#9'F'#9'UOM'
        'UOMMultiplier'#9'10'#9'Multiplier'#9'F'#9'UOM'
        'Points'#9'1'#9'Points'#9'F'
        'Value'#9'1'#9'Value'#9'F'
        'UseDate'#9'1'#9'Use?'#9'F'#9'Date Range'
        'DateFrom'#9'12'#9'From'#9'F'#9'Date Range'
        'DateTo'#9'12'#9'To'#9'F'#9'Date Range'
        'UseExpiryDate'#9'1'#9'Use?'#9'F'#9'Expiry Date'
        'RewardPointExpiresOn'#9'12'#9'Expires On?'#9'F'#9'Expiry Date'
        
          'ExpiresOnNoOfMonthsAfterPurchase'#9'10'#9'Expires in Months'#9'F'#9'Expiry D' +
          'ate'
        'Active'#9'1'#9'Active'#9#9
        'DateCreated'#9'12'#9'Date~Created'#9'F')
      TitleColor = 15527129
      TitleLines = 2
      UseTFields = False
      FooterColor = 15527129
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT '
      'PR.ProductRewardPointsID,'
      'PR.PartsID,'
      'PR.UseUOM,'
      'PR.UOMID,'
      'PR.UOM,'
      'PR.UOMMultiplier,'
      'PR.PartName,'
      'PR.GlobalRef,'
      'PR.Points,'
      'PR.Value,'
      'PR.UseDate,'
      'PR.DateFrom,'
      'PR.DateTo,'
      'PR.UseExpiryDate,'
      'PR.RewardPointExpiresOn,'
      'PR.ExpiresOnNoOfMonthsAfterPurchase,'
      'PR.Active,'
      'PR.DateCreated,'
      'PR.msTimeStamp,'
      'PR.ClientTypeID, '
      'CT.TypeName'
      'FROM tblProductRewardPoints PR'
      'Left Join tblclienttype CT ON PR.ClientTypeID = CT.ClientTypeID'
      
        'WHERE ((:Active = "Both") OR (:Active = "Active" AND PR.Active =' +
        ' "T") OR (:Active = "Not Active" AND PR.Active <> "T")) AND ((:R' +
        'angeFilter = "Both" AND (PR.UseDate = "F" OR PR.DateFrom BETWEEN' +
        ' :DateFrom AND :DateTo)) OR (:RangeFilter = "Date Range" AND PR.' +
        'DateFrom BETWEEN :DateFrom AND :DateTo) OR (:RangeFilter = "No D' +
        'ate Range" AND PR.UseDate = "F"))'
      'ORDER BY PartName, DateFrom;')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Active'
      end
      item
        DataType = ftUnknown
        Name = 'Active'
      end
      item
        DataType = ftUnknown
        Name = 'Active'
      end
      item
        DataType = ftUnknown
        Name = 'RangeFilter'
      end
      item
        DataType = ftUnknown
        Name = 'DateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'DateTo'
      end
      item
        DataType = ftUnknown
        Name = 'RangeFilter'
      end
      item
        DataType = ftUnknown
        Name = 'DateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'DateTo'
      end
      item
        DataType = ftUnknown
        Name = 'RangeFilter'
      end>
    object qryMainProductRewardPointsId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ProductRewardPointsId'
      Origin = 'tblProductRewardPoints.ProductRewardPointsId'
    end
    object qryMainPartname: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldName = 'Partname'
      Origin = 'tblProductRewardPoints.Partname'
      Size = 100
    end
    object qryMainUseUOM: TWideStringField
      DisplayLabel = 'Use UOM?'
      DisplayWidth = 1
      FieldName = 'UseUOM'
      Origin = 'tblProductRewardPoints.UseUOM'
      FixedChar = True
      Size = 1
    end
    object qryMainUOM: TWideStringField
      DisplayWidth = 15
      FieldName = 'UOM'
      Origin = 'tblProductRewardPoints.UOM'
      Size = 60
    end
    object qryMainPoints: TFloatField
      DisplayWidth = 10
      FieldName = 'Points'
      Origin = 'tblProductRewardPoints.Points'
    end
    object qryMainValue: TFloatField
      DisplayWidth = 10
      FieldName = 'Value'
      Origin = 'tblProductRewardPoints.Value'
      currency = True
    end
    object qryMainUseDate: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseDate'
      Origin = 'tblProductRewardPoints.UseDate'
      FixedChar = True
      Size = 1
    end
    object qryMainDateFrom: TDateField
      DisplayWidth = 15
      FieldName = 'DateFrom'
      Origin = 'tblProductRewardPoints.DateFrom'
    end
    object qryMainDateTo: TDateField
      DisplayWidth = 15
      FieldName = 'DateTo'
      Origin = 'tblProductRewardPoints.DateTo'
    end
    object qryMainUseExpiryDate: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseExpiryDate'
      Origin = 'tblProductRewardPoints.UseExpiryDate'
      FixedChar = True
      Size = 1
    end
    object qryMainPartsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'tblProductRewardPoints.PartsId'
    end
    object qryMainUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblProductRewardPoints.UOMID'
    end
    object qryMainUOMMultiplier: TFloatField
      DisplayLabel = 'UOM Multiplier'
      DisplayWidth = 10
      FieldName = 'UOMMultiplier'
      Origin = 'tblProductRewardPoints.UOMMultiplier'
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Origin = 'tblProductRewardPoints.GlobalRef'
      Size = 255
    end
    object qryMainRewardPointExpiresOn: TDateField
      DisplayWidth = 15
      FieldName = 'RewardPointExpiresOn'
      Origin = 'tblProductRewardPoints.RewardPointExpiresOn'
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblProductRewardPoints.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainDateCreated: TDateTimeField
      DisplayWidth = 15
      FieldName = 'DateCreated'
      Origin = 'tblProductRewardPoints.DateCreated'
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblProductRewardPoints.msTimeStamp'
    end
    object qryMainExpiresOnNoOfMonthsAfterPurchase: TIntegerField
      FieldName = 'ExpiresOnNoOfMonthsAfterPurchase'
      Origin = 'tblProductRewardPoints.ExpiresOnNoOfMonthsAfterPurchase'
    end
    object qryMainClientTypeID: TLargeintField
      FieldName = 'ClientTypeID'
    end
    object qryMainTypeName: TWideStringField
      FieldName = 'TypeName'
      Size = 50
    end
  end
end
