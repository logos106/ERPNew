inherited frmAwardsList: TfrmAwardsList
  Left = 104
  Top = 147
  HelpContext = 231000
  Caption = 'Awards List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 231001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 231002
    Color = 15785701
    inherited Label3: TLabel
      HelpContext = 231003
    end
    inherited lblTotal: TLabel
      HelpContext = 231004
    end
    inherited lblNote: TLabel
      HelpContext = 231005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 231006
    end
    inherited lblTime: TLabel
      HelpContext = 231007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 231008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 231009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 231010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 231011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 231012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 231013
      inherited LblChooseTemplate: TLabel
        HelpContext = 231014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 231015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 231016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 231017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 231018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 231019
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
    HelpContext = 231020
    Color = 15785701
    inherited lblFrom: TLabel
      HelpContext = 231021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 231022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 231023
      Font.Color = 14221420
      inherited TitleShader: TShader
        HelpContext = 231024
        inherited TitleLabel: TLabel
          HelpContext = 231025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 231026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 231027
      end
      inherited pnlButtons: TPanel
        HelpContext = 231028
        inherited lblcustomReport: TLabel
          HelpContext = 231029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 231030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 231031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 231032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 231033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 231034
        end
      end
      object grpFilter: TRadioGroup
        Left = 441
        Top = 0
        Width = 557
        Height = 37
        HelpContext = 231035
        Align = alClient
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Active Awards'
          'Inactive Awards'
          'All Awards')
        TabOrder = 2
        OnClick = grpFilterClick
      end
    end
    inherited Panel3: TPanel
      HelpContext = 231036
      inherited lblFilter: TLabel
        HelpContext = 231037
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 231038
      end
      inherited cboFilter: TComboBox
        HelpContext = 231039
      end
      inherited edtSearch: TEdit
        HelpContext = 231040
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 231041
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 231042
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 231043
    end
  end
  inherited Panel1: TPanel
    HelpContext = 231044
    inherited grdMain: TwwDBGrid
      HelpContext = 231045
      ControlType.Strings = (
        'Active;CustomEdit;chkActive;F')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9'F'
        'Award Name'#9'150'#9'Award Name'#9#9
        'Department'#9'60'#9'Department'#9#9
        'Pay Period'#9'37'#9'Pay Period'#9#9
        'Super Type'#9'17'#9'Super Type'#9#9
        'Super Value'#9'8192'#9'Super Value'#9#9
        'A/L Loading'#9'10'#9'A/L Loading'#9#9
        'Active'#9'5'#9'Active'#9'F'#9)
      TitleColor = clwhite
      FooterColor = 15785701
      FooterCellColor = 15785701
    end
    object chkActive: TwwCheckBox
      Left = 312
      Top = 232
      Width = 62
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      DynamicCaption = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'Yes'
      DisplayValueUnchecked = 'No'
      NullAndBlankState = cbUnchecked
      Caption = 'No'
      DataField = 'Active'
      DataSource = dsMain
      TabOrder = 1
      HelpContext = 231045
    end
  end
  inherited CloseModalTimer: TTimer
    Left = 129
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select tblAwards.GlobalRef,AwardID ,AwardName AS '#39'Award Name'#39','
      'ClassName AS Department,PayPeriod AS '#39'Pay Period'#39','
      'SuperType AS '#39'Super Type'#39','
      
        'if(SuperType='#39'Percentage'#39',Concat(Format(SuperValue,2),'#39'%'#39'),Conca' +
        't('#39'$'#39',Format(SuperValue,2))) As '#39'Super Value'#39','
      '# AnnualLeaveLoading AS '#39'A/L Loading'#39','
      'tblAwards.Active'
      'FROM tblAwards'
      'LEFT JOIN tblClass'
      'ON tblAwards.ClassID=tblClass.ClassID'
      'WHERE not ISNULL(AwardName)'
      'Order By AwardName;')
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainAwardName: TWideStringField
      DisplayWidth = 150
      FieldName = 'Award Name'
      Origin = 'tblAwards.`Award Name`'
      Size = 150
    end
    object qryMainDepartment: TWideStringField
      DisplayWidth = 60
      FieldName = 'Department'
      Origin = 'tblClass.Department'
      Size = 60
    end
    object qryMainPayPeriod: TWideStringField
      DisplayWidth = 37
      FieldName = 'Pay Period'
      Origin = 'tblAwards.`Pay Period`'
      FixedChar = True
      Size = 37
    end
    object qryMainSuperType: TWideStringField
      DisplayWidth = 17
      FieldName = 'Super Type'
      Origin = 'tblAwards.`Super Type`'
      FixedChar = True
      Size = 10
    end
    object qryMainSuperValue: TWideStringField
      Alignment = taRightJustify
      DisplayWidth = 8192
      FieldName = 'Super Value'
      Origin = 'tblAwards.`Super Value`'
      ReadOnly = True
      Size = 8192
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 5
      FieldName = 'Active'
      Origin = 'tblAwards.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainAwardID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AwardID'
      Origin = 'tblAwards.AwardID'
      Visible = False
    end
  end
end
