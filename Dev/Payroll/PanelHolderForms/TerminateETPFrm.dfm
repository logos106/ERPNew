inherited frmTerminateETP: TfrmTerminateETP
  Left = 262
  Top = 252
  HelpContext = 583000
  Caption = 'frmTerminateETP'
  ClientHeight = 441
  ClientWidth = 813
  OldCreateOrder = True
  ExplicitLeft = 262
  ExplicitTop = 252
  ExplicitWidth = 829
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 441
    Width = 813
    ExplicitTop = 441
    ExplicitWidth = 813
    HelpContext = 583007
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 40
    Width = 799
    Height = 283
    HelpContext = 583001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Category = 'AustPayroll'
    DesignSize = (
      799
      283)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 268
      HelpContext = 583002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label17: TLabel
      Left = 143
      Top = 16
      Width = 529
      Height = 25
      HelpContext = 583003
      AutoSize = False
      Caption = 
        'Will this termination pay include any Eligible Termination Payme' +
        'nts?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel7: TBevel
      Left = 119
      Top = 48
      Width = 577
      Height = 217
      HelpContext = 583004
      Shape = bsFrame
    end
    object lblMain: TLabel
      Left = 229
      Top = 56
      Width = 384
      Height = 54
      HelpContext = 583005
      AutoSize = False
      Caption = 
        'ETP'#39's can include unused sick leave, pay in lieu of notice, unus' +
        'ed RDO'#39's, Golden Handshakes,  compensation for unfair dismissal ' +
        'and invalidity.'
      WordWrap = True
    end
    object rgETP: TwwRadioGroup
      Left = 227
      Top = 128
      Width = 385
      Height = 105
      HelpContext = 583006
      DisableThemes = False
      TransparentActiveItem = True
      Indents.TextX = 5
      Transparent = True
      Caption = 'Eligible Termination Payments (ETP)'
      Items.Strings = (
        'Yes'
        'No')
      TabOrder = 0
      Values.Strings = (
        'T'
        'F')
      OnClick = rgETPClick
    end
  end
  object qryEmpTerminate: TERPQuery
    SQL.Strings = (
      'select * from tblemployeeterminations')
    Left = 584
    object qryEmpTerminateTerminationID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TerminationID'
      Origin = 'tblemployeeterminations.TerminationID'
    end
    object qryEmpTerminateEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblemployeeterminations.EmployeeID'
    end
    object qryEmpTerminateGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblemployeeterminations.GlobalRef'
      Size = 255
    end
    object qryEmpTerminateEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblemployeeterminations.EmployeeName'
      Size = 255
    end
    object qryEmpTerminateStartDate: TDateTimeField
      FieldName = 'StartDate'
      Origin = 'tblemployeeterminations.StartDate'
    end
    object qryEmpTerminateEndDate: TDateTimeField
      FieldName = 'EndDate'
      Origin = 'tblemployeeterminations.EndDate'
    end
    object qryEmpTerminateDaysServicePre01071983: TIntegerField
      FieldName = 'DaysServicePre01071983'
      Origin = 'tblemployeeterminations.DaysServicePre01071983'
    end
    object qryEmpTerminateDaysServicePost30061983: TIntegerField
      FieldName = 'DaysServicePost30061983'
      Origin = 'tblemployeeterminations.DaysServicePost30061983'
    end
    object qryEmpTerminateETPpre071983: TFloatField
      FieldName = 'ETPpre071983'
      Origin = 'tblemployeeterminations.ETPpre071983'
    end
    object qryEmpTerminateETPpost061983Untaxed: TFloatField
      FieldName = 'ETPpost061983Untaxed'
      Origin = 'tblemployeeterminations.ETPpost061983Untaxed'
    end
    object qryEmpTerminateETPpost061994Component: TFloatField
      FieldName = 'ETPpost061994Component'
      Origin = 'tblemployeeterminations.ETPpost061994Component'
    end
    object qryEmpTerminateGrossTermination: TFloatField
      FieldName = 'GrossTermination'
      Origin = 'tblemployeeterminations.GrossTermination'
    end
    object qryEmpTerminateTaxWithheld: TFloatField
      FieldName = 'TaxWithheld'
      Origin = 'tblemployeeterminations.TaxWithheld'
    end
    object qryEmpTerminateETPAssessable: TFloatField
      FieldName = 'ETPAssessable'
      Origin = 'tblemployeeterminations.ETPAssessable'
    end
    object qryEmpTerminateDeathBenefit: TWideStringField
      FieldName = 'DeathBenefit'
      Origin = 'tblemployeeterminations.DeathBenefit'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateTypeOfDeathBenefit: TWideStringField
      FieldName = 'TypeOfDeathBenefit'
      Origin = 'tblemployeeterminations.TypeOfDeathBenefit'
      Size = 64
    end
    object qryEmpTerminateLumpSumA: TFloatField
      FieldName = 'LumpSumA'
      Origin = 'tblemployeeterminations.LumpSumA'
    end
    object qryEmpTerminateLumpSumB: TFloatField
      FieldName = 'LumpSumB'
      Origin = 'tblemployeeterminations.LumpSumB'
    end
    object qryEmpTerminateLumpSumD: TFloatField
      FieldName = 'LumpSumD'
      Origin = 'tblemployeeterminations.LumpSumD'
    end
    object qryEmpTerminateLumpSumE: TFloatField
      FieldName = 'LumpSumE'
      Origin = 'tblemployeeterminations.LumpSumE'
    end
    object qryEmpTerminateReasonLeft: TWideStringField
      FieldName = 'ReasonLeft'
      Origin = 'tblemployeeterminations.ReasonLeft'
      Size = 32
    end
    object qryEmpTerminateGrossETP: TFloatField
      FieldName = 'GrossETP'
      Origin = 'tblemployeeterminations.GrossETP'
    end
    object qryEmpTerminateCDEP: TFloatField
      FieldName = 'CDEP'
      Origin = 'tblemployeeterminations.CDEP'
    end
    object qryEmpTerminateReportableFB: TFloatField
      FieldName = 'ReportableFB'
      Origin = 'tblemployeeterminations.ReportableFB'
    end
    object qryEmpTerminateTotalAllowances: TFloatField
      FieldName = 'TotalAllowances'
      Origin = 'tblemployeeterminations.TotalAllowances'
    end
    object qryEmpTerminateIsETPEntitled: TWideStringField
      FieldName = 'IsETPEntitled'
      Origin = 'tblemployeeterminations.IsETPEntitled'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateDeathBeneficiaryHasTFN: TWideStringField
      FieldName = 'DeathBeneficiaryHasTFN'
      Origin = 'tblemployeeterminations.DeathBeneficiaryHasTFN'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateIsPayEntitled: TWideStringField
      FieldName = 'IsPayEntitled'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateIsManualLongService: TWideStringField
      FieldName = 'IsManualLongService'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateIsManualAnnualLeave: TWideStringField
      FieldName = 'IsManualAnnualLeave'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateLongServicePre16081978: TFloatField
      FieldName = 'LongServicePre16081978'
      currency = True
    end
    object qryEmpTerminateLongServicePost16081978: TFloatField
      FieldName = 'LongServicePost16081978'
      currency = True
    end
    object qryEmpTerminateLongServicePost17081993: TFloatField
      FieldName = 'LongServicePost17081993'
      currency = True
    end
  end
  object DSEmpTerminate: TDataSource
    DataSet = qryEmpTerminate
    Left = 512
  end
end
