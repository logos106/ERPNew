inherited AssessmentListGUI: TAssessmentListGUI
  Left = 118
  Top = 153
  HelpContext = 21000
  Caption = 'Assessment List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 21001
  end
  inherited FooterPanel: TPanel
    HelpContext = 21002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 21003
    end
    inherited lblTotal: TLabel
      HelpContext = 21004
    end
    inherited lblNote: TLabel
      HelpContext = 21005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 21006
    end
    inherited lblTime: TLabel
      HelpContext = 21007
    end
    inherited cmdClose: TDNMSpeedButton
      TabOrder = 8
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 523
      HelpContext = 21009
      TabOrder = 0
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 660
      HelpContext = 21010
      TabOrder = 1
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 249
      HelpContext = 21011
      TabOrder = 2
    end
    inherited btnCustomize: TDNMSpeedButton
      TabOrder = 6
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 21013
      TabOrder = 4
      inherited LblChooseTemplate: TLabel
        HelpContext = 21014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 21015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 21016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 21017
      end
    end
    object btnInvoice: TDNMSpeedButton [11]
      Left = 386
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 21020
      Action = actInvoice
      Anchors = [akBottom]
      Caption = 'Invoice'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 21018
      TabOrder = 5
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 21019
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
    HelpContext = 21021
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 21022
    end
    inherited lblTo: TLabel
      HelpContext = 21023
    end
    inherited pnlHeader: TPanel
      HelpContext = 21024
      Caption = 'Assessment List'
      inherited TitleShader: TShader
        HelpContext = 21025
        inherited TitleLabel: TLabel
          HelpContext = 21026
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 21027
      inherited grpFilters: TRadioGroup
        HelpContext = 21028
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'Converted'
          'All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 21029
        inherited lblcustomReport: TLabel
          HelpContext = 21030
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 21031
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 21032
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 21033
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 21034
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 21035
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 21036
      inherited Label1: TLabel
        HelpContext = 21037
      end
      inherited Label2: TLabel
        HelpContext = 21038
      end
      inherited cboFilter: TComboBox
        HelpContext = 21039
      end
      inherited edtSearch: TEdit
        HelpContext = 21040
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 21041
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 21042
    end
    inherited cboDateRange: TComboBox
      HelpContext = 21043
      Visible = True
    end
  end
  inherited Panel1: TPanel
    HelpContext = 21044
    inherited grdMain: TwwDBGrid
      HelpContext = 21045
      Selected.Strings = (
        'GlobalRef'#9'10'#9'GlobalRef'#9'F'#9
        'AssessmentNo'#9'15'#9'AssessmentNo'#9#9
        'AssessmentType'#9'50'#9'AssessmentType'#9#9
        'Assessor'#9'40'#9'Assessor'#9#9
        'Driver'#9'121'#9'Driver'#9#9
        'TimeOn'#9'10'#9'TimeOn'#9#9
        'TimeOff'#9'10'#9'TimeOff'#9#9
        'Date'#9'10'#9'Date'#9#9
        'AssessmentToday'#9'15'#9'AssessmentToday'#9#9
        'UniformWorn'#9'1'#9'UniformWorn'#9#9
        'Route'#9'50'#9'Route'#9#9
        'Covert'#9'1'#9'Covert'#9'F'#9
        'Garage'#9'50'#9'Garage'#9#9
        'RegNumber'#9'20'#9'RegNumber'#9#9
        'RunningNumber'#9'20'#9'RunningNumber'#9#9
        'FleetNumber'#9'20'#9'FleetNumber'#9#9
        'VehicleType'#9'50'#9'VehicleType'#9#9
        'WeatherType'#9'50'#9'WeatherType'#9#9
        'BusDestination'#9'50'#9'BusDestination'#9#9
        'JourneyTo'#9'50'#9'JourneyTo'#9#9
        'JourneyFrom'#9'50'#9'JourneyFrom'#9#9
        'Score'#9'15'#9'Score'#9#9
        'Rating'#9'3'#9'Rating'#9#9
        'Active'#9'1'#9'Active'#9#9
        'Converted'#9'1'#9'Converted'#9#9)
      TitleColor = 15527129
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
      FooterColor = 15527129
    end
  end
  inherited actlstFilters: TActionList
    object actInvoice: TAction
      Caption = 'Invoice'
      OnExecute = actInvoiceExecute
      OnUpdate = actInvoiceUpdate
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT'
      'tblassessments.GlobalRef as GlobalRef,'
      'tblassessments.AssessmentID as AssessmentNo,'
      'tblassessmenttypes.TypeName as AssessmentType,'
      'tblassessments.TimeOn,'
      'tblassessments.TimeOff,'
      'tblassessments.Date,'
      'tblassessments.AssessmentToday,'
      'tblassessments.UniformWorn,'
      'tblassessments.Covert,'
      'tblassessments.Route,'
      'tblassessments.Garage,'
      'tblassessments.RegNumber,'
      'tblassessments.RunningNumber,'
      'tblassessments.FleetNumber,'
      'tblassessments.VehicleType,'
      'tblassessments.WeatherType,'
      'tblassessments.BusDestination,'
      'tblassessments.JourneyTo,'
      'tblassessments.JourneyFrom,'
      'tblemployees.EmployeeName as Assessor,'
      
        'CONCAT_WS('#39' '#39',tblassessmentdrivers.FirstName,tblassessmentdriver' +
        's.LastName) AS Driver,'
      'tblassessments.Converted,'
      'tblassessments.Score,'
      'tblassessments.Rating,'
      'tblassessments.Active,'
      'tblassessments.AssessorID,'
      'tblassessments.DriverID,'
      'tblassessments.AssessmentID'
      'FROM tblassessments'
      
        'LEFT Join tblemployees ON tblassessments.AssessorID  = tblemploy' +
        'ees.EmployeeID'
      
        'LEFT Join tblassessmentdrivers ON tblassessments.DriverID = tbla' +
        'ssessmentdrivers.DriverID'
      
        'Inner Join tblassessmenttypes ON tblassessments.TypeID = tblasse' +
        'ssmenttypes.TypeID'
      'WHERE tblassessments.Date Between :txtfrom AND :txtto')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'txtfrom'
      end
      item
        DataType = ftUnknown
        Name = 'txtto'
      end>
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Origin = 'tblassessments.GlobalRef'
      Size = 255
    end
    object qryMainAssessmentNo: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'AssessmentNo'
      Origin = 'tblassessments.AssessmentNo'
    end
    object qryMainAssessmentType: TWideStringField
      DisplayWidth = 50
      FieldName = 'AssessmentType'
      Origin = 'tblassessmenttypes.AssessmentType'
      Size = 50
    end
    object qryMainAssessor: TWideStringField
      DisplayWidth = 40
      FieldName = 'Assessor'
      Origin = 'tblemployees.Assessor'
      Size = 255
    end
    object qryMainDriver: TWideStringField
      DisplayWidth = 121
      FieldName = 'Driver'
      Origin = 'tblassessments.Driver'
      Size = 121
    end
    object qryMainTimeOn: TTimeField
      DisplayWidth = 10
      FieldName = 'TimeOn'
      Origin = 'tblassessments.TimeOn'
    end
    object qryMainTimeOff: TTimeField
      DisplayWidth = 10
      FieldName = 'TimeOff'
      Origin = 'tblassessments.TimeOff'
    end
    object qryMainDate: TDateField
      DisplayWidth = 10
      FieldName = 'Date'
      Origin = 'tblassessments.Date'
    end
    object qryMainAssessmentToday: TIntegerField
      DisplayWidth = 15
      FieldName = 'AssessmentToday'
      Origin = 'tblassessments.AssessmentToday'
    end
    object qryMainUniformWorn: TWideStringField
      DisplayWidth = 1
      FieldName = 'UniformWorn'
      Origin = 'tblassessments.UniformWorn'
      FixedChar = True
      Size = 1
    end
    object qryMainRoute: TWideStringField
      DisplayWidth = 50
      FieldName = 'Route'
      Origin = 'tblassessments.Route'
      Size = 50
    end
    object qryMainCovert: TWideStringField
      DisplayWidth = 1
      FieldName = 'Covert'
      FixedChar = True
      Size = 1
    end
    object qryMainGarage: TWideStringField
      DisplayWidth = 50
      FieldName = 'Garage'
      Origin = 'tblassessments.Garage'
      Size = 80
    end
    object qryMainRegNumber: TWideStringField
      DisplayWidth = 20
      FieldName = 'RegNumber'
      Origin = 'tblassessments.RegNumber'
    end
    object qryMainRunningNumber: TWideStringField
      DisplayWidth = 20
      FieldName = 'RunningNumber'
      Origin = 'tblassessments.RunningNumber'
    end
    object qryMainFleetNumber: TWideStringField
      DisplayWidth = 20
      FieldName = 'FleetNumber'
      Origin = 'tblassessments.FleetNumber'
    end
    object qryMainVehicleType: TWideStringField
      DisplayWidth = 50
      FieldName = 'VehicleType'
      Origin = 'tblassessments.VehicleType'
      Size = 50
    end
    object qryMainWeatherType: TWideStringField
      DisplayWidth = 50
      FieldName = 'WeatherType'
      Origin = 'tblassessments.WeatherType'
      Size = 50
    end
    object qryMainBusDestination: TWideStringField
      DisplayWidth = 50
      FieldName = 'BusDestination'
      Origin = 'tblassessments.BusDestination'
      Size = 50
    end
    object qryMainJourneyTo: TWideStringField
      DisplayWidth = 50
      FieldName = 'JourneyTo'
      Origin = 'tblassessments.JourneyTo'
      Size = 50
    end
    object qryMainJourneyFrom: TWideStringField
      DisplayWidth = 50
      FieldName = 'JourneyFrom'
      Origin = 'tblassessments.JourneyFrom'
      Size = 50
    end
    object qryMainScore: TIntegerField
      DisplayWidth = 15
      FieldName = 'Score'
      Origin = 'tblassessments.Score'
    end
    object qryMainRating: TWideStringField
      DisplayWidth = 3
      FieldName = 'Rating'
      Origin = 'tblassessments.Rating'
      FixedChar = True
      Size = 3
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblassessments.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainConverted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Converted'
      Origin = 'tblassessments.Converted'
      FixedChar = True
      Size = 1
    end
    object qryMainAssessmentID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'AssessmentID'
      Origin = 'tblassessments.AssessmentID'
      Visible = False
    end
    object qryMainAssessorID: TIntegerField
      FieldName = 'AssessorID'
      Origin = 'tblassessments.AssessorID'
      Visible = False
    end
    object qryMainDriverID: TIntegerField
      FieldName = 'DriverID'
      Origin = 'tblassessments.DriverID'
      Visible = False
    end
  end
  inherited MyConnection1: TERPConnection
    Left = 55
  end
end
