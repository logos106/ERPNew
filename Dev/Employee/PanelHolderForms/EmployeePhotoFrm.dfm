inherited EmployeePhoto: TEmployeePhoto
  Left = 637
  Top = 161
  HelpContext = 120000
  Caption = 'EmployeePhoto'
  ClientHeight = 528
  ClientWidth = 948
  OldCreateOrder = True
  ExplicitLeft = 637
  ExplicitTop = 161
  ExplicitWidth = 964
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 528
    Width = 948
    ExplicitTop = 528
    ExplicitWidth = 948
    HelpContext = 120013
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 948
    Height = 528
    HelpContext = 120001
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      948
      528)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 932
      Height = 513
      HelpContext = 120002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitWidth = 783
      ExplicitHeight = 408
    end
    object imgPhoto: TDBImage
      Left = 16
      Top = 65
      Width = 694
      Height = 447
      Hint = 'Right click to Add/Change Image'
      HelpContext = 120003
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataField = 'EmployeePic'
      DataSource = DataSourceBlob
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnAddPic: TDNMSpeedButton
      Left = 16
      Top = 16
      Width = 106
      Height = 27
      HelpContext = 120004
      Caption = 'Add Picture'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
        BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
        BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
        BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
        BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
        EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
        EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
        EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
        EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
      OnClick = btnAddPicClick
    end
    object btnStretch: TDNMSpeedButton
      Left = 290
      Top = 16
      Width = 106
      Height = 27
      HelpContext = 120005
      AllowAllUp = True
      Caption = 'Stretch to Fit'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      GroupIndex = 1
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 2
      OnClick = btnStretchClick
    end
    object DNMPanel2: TDNMPanel
      Left = 719
      Top = 65
      Width = 210
      Height = 126
      HelpContext = 120006
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label17: TLabel
        Left = 10
        Top = 25
        Width = 63
        Height = 18
        HelpContext = 120007
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Vaild From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Label18: TLabel
        Left = 13
        Top = 77
        Width = 60
        Height = 18
        HelpContext = 120008
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Vaild To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object dtTo: TwwDBDateTimePicker
        Left = 78
        Top = 73
        Width = 121
        Height = 23
        HelpContext = 120009
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'PhotoIDVaildToDate'
        DataSource = DSEmployeesPhoto
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 0
        OnCloseUp = dtToCloseUp
      end
      object dtFrom: TwwDBDateTimePicker
        Left = 78
        Top = 22
        Width = 121
        Height = 23
        HelpContext = 120010
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'PhotoIDVaildFromDate'
        DataSource = DSEmployeesPhoto
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        OnCloseUp = dtFromCloseUp
      end
    end
    object Button1: TDNMSpeedButton
      Left = 777
      Top = 274
      Width = 87
      Height = 27
      HelpContext = 120011
      Anchors = [akTop, akRight]
      Caption = 'Print Photo ID'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 4
      OnClick = Button1Click
    end
    object btnClearPic: TDNMSpeedButton
      Left = 154
      Top = 16
      Width = 106
      Height = 27
      HelpContext = 120012
      Caption = 'Delete Picture'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
        305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
        B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
        B0557777FF577777F7F500000E055550805577777F7555575755500000555555
        05555777775555557F5555000555555505555577755555557555}
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 5
      OnClick = btnClearPicClick
    end
  end
  object qryemployeesphoto: TERPQuery
    SQL.Strings = (
      'Select * From tblemployees'
      'Where EmployeeID=:xID;')
    Left = 781
    Top = 2
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryemployeesphotoEmployeeID: TAutoIncField
      FieldName = 'EmployeeID'
      ReadOnly = True
    end
    object qryemployeesphotoTitle: TWideStringField
      FieldName = 'Title'
      Size = 5
    end
    object qryemployeesphotoFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 40
    end
    object qryemployeesphotoMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Size = 40
    end
    object qryemployeesphotoLastName: TWideStringField
      FieldName = 'LastName'
      Size = 40
    end
    object qryemployeesphotoABN: TWideStringField
      FieldName = 'ABN'
      Size = 15
    end
    object qryemployeesphotoCanvasser: TWideStringField
      FieldName = 'Canvasser'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoRep: TWideStringField
      FieldName = 'Rep'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qryemployeesphotoDateStarted: TDateField
      FieldName = 'DateStarted'
    end
    object qryemployeesphotoDateFinished: TDateField
      FieldName = 'DateFinished'
    end
    object qryemployeesphotoNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryemployeesphotoActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 50
    end
    object qryemployeesphotoCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 50
    end
    object qryemployeesphotoEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoEmployeeNo: TIntegerField
      FieldName = 'EmployeeNo'
    end
    object qryemployeesphotoTFN: TWideStringField
      FieldName = 'TFN'
      Size = 9
    end
    object qryemployeesphotoDOB: TDateField
      FieldName = 'DOB'
    end
    object qryemployeesphotoInitials: TWideStringField
      FieldName = 'Initials'
      FixedChar = True
      Size = 3
    end
    object qryemployeesphotoSex: TWideStringField
      FieldName = 'Sex'
      FixedChar = True
      Size = 11
    end
    object qryemployeesphotoOptionNo: TWordField
      FieldName = 'OptionNo'
    end
    object qryemployeesphotoTax: TFloatField
      FieldName = 'Tax'
    end
    object qryemployeesphotoGross: TFloatField
      FieldName = 'Gross'
    end
    object qryemployeesphotoNet: TFloatField
      FieldName = 'Net'
    end
    object qryemployeesphotoWages: TFloatField
      FieldName = 'Wages'
    end
    object qryemployeesphotoCommission: TFloatField
      FieldName = 'Commission'
    end
    object qryemployeesphotoDeductions: TFloatField
      FieldName = 'Deductions'
    end
    object qryemployeesphotoAllowances: TFloatField
      FieldName = 'Allowances'
    end
    object qryemployeesphotoSundries: TFloatField
      FieldName = 'Sundries'
    end
    object qryemployeesphotoSuper: TFloatField
      FieldName = 'Super'
    end
    object qryemployeesphotoCDEProject: TWideStringField
      FieldName = 'CDEProject'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoFringeBenefits: TFloatField
      FieldName = 'FringeBenefits'
    end
    object qryemployeesphotoDaysPre01071983: TIntegerField
      FieldName = 'DaysPre01071983'
    end
    object qryemployeesphotoDaysPost30061983: TIntegerField
      FieldName = 'DaysPost30061983'
    end
    object qryemployeesphotoCGTExempt: TFloatField
      FieldName = 'CGTExempt'
    end
    object qryemployeesphotoNonQualifyingComponent: TFloatField
      FieldName = 'NonQualifyingComponent'
    end
    object qryemployeesphotoUndeductedContribution: TFloatField
      FieldName = 'UndeductedContribution'
    end
    object qryemployeesphotoConcessionalComponent: TFloatField
      FieldName = 'ConcessionalComponent'
    end
    object qryemployeesphotoRepCode: TWideStringField
      FieldName = 'RepCode'
      Size = 25
    end
    object qryemployeesphotoResident: TWideStringField
      FieldName = 'Resident'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoTFNApplicationMade: TWideStringField
      FieldName = 'TFNApplicationMade'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoUnder18: TWideStringField
      FieldName = 'Under18'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoPensioner: TWideStringField
      FieldName = 'Pensioner'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoIncomeType: TWideStringField
      FieldName = 'IncomeType'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoBasisOfPayment: TWideStringField
      FieldName = 'BasisOfPayment'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoTaxFreeThreshold: TWideStringField
      FieldName = 'TaxFreeThreshold'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoFamilyTaxBenefit: TWideStringField
      FieldName = 'FamilyTaxBenefit'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoZoneDependentSpecial: TWideStringField
      FieldName = 'ZoneDependentSpecial'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoHECSIndicator: TWideStringField
      FieldName = 'HECSIndicator'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoStudentLoanIndicator: TWideStringField
      FieldName = 'StudentLoanIndicator'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoUseOfTFNForSuper: TWideStringField
      FieldName = 'UseOfTFNForSuper'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoAnnuitySuperPension: TWideStringField
      FieldName = 'AnnuitySuperPension'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoSignaturePresent: TWideStringField
      FieldName = 'SignaturePresent'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoDateSigned: TDateField
      FieldName = 'DateSigned'
    end
    object qryemployeesphotoPayVia: TWideStringField
      FieldName = 'PayVia'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 62
    end
    object qryemployeesphotoReportsTo: TIntegerField
      FieldName = 'ReportsTo'
    end
    object qryemployeesphotoPayPeriod: TWideStringField
      FieldName = 'PayPeriod'
      Size = 25
    end
    object qryemployeesphotoAward: TIntegerField
      FieldName = 'Award'
    end
    object qryemployeesphotoClassification: TWideStringField
      FieldName = 'Classification'
      Size = 255
    end
    object qryemployeesphotoWorkersCompInsurer: TIntegerField
      FieldName = 'WorkersCompInsurer'
    end
    object qryemployeesphotoUseAward: TWideStringField
      FieldName = 'UseAward'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoNextOfKin: TWideStringField
      FieldName = 'NextOfKin'
      Size = 150
    end
    object qryemployeesphotoNextOfKinRelationship: TWideStringField
      FieldName = 'NextOfKinRelationship'
      Size = 100
    end
    object qryemployeesphotoNextOfKinPhone: TWideStringField
      FieldName = 'NextOfKinPhone'
      EditMask = '## #### ####;0;_'
    end
    object qryemployeesphotoTaxScaleID: TIntegerField
      FieldName = 'TaxScaleID'
    end
    object qryemployeesphotoLeaveLoading: TFloatField
      DefaultExpression = '0.00'
      FieldName = 'LeaveLoading'
      DisplayFormat = '####0.00%'
      EditFormat = '####0.00'
    end
    object qryemployeesphotoExtraTax: TFloatField
      FieldName = 'ExtraTax'
    end
    object qryemployeesphotoSickHours: TFloatField
      FieldName = 'SickHours'
    end
    object qryemployeesphotoALHours: TFloatField
      FieldName = 'ALHours'
    end
    object qryemployeesphotoLastPaid: TDateField
      FieldName = 'LastPaid'
    end
    object qryemployeesphotoCommissionOnValue: TWideStringField
      FieldName = 'CommissionOnValue'
      FixedChar = True
      Size = 9
    end
    object qryemployeesphotoCommissionLastPaid: TDateField
      FieldName = 'CommissionLastPaid'
    end
    object qryemployeesphotoGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryemployeesphotoPayNotes: TWideMemoField
      FieldName = 'PayNotes'
      BlobType = ftWideMemo
    end
    object qryemployeesphotoIsOnTheRoster: TWideStringField
      FieldName = 'IsOnTheRoster'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoLoadHoursFromRoster: TWideStringField
      FieldName = 'LoadHoursFromRoster'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoLoadLeaveFromRoster: TWideStringField
      FieldName = 'LoadLeaveFromRoster'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoMealBreakHours: TFloatField
      FieldName = 'MealBreakHours'
    end
    object qryemployeesphotoMealBreakThreshold: TFloatField
      FieldName = 'MealBreakThreshold'
    end
    object qryemployeesphotoAreaRange: TWideStringField
      FieldName = 'AreaRange'
      Size = 255
    end
    object qryemployeesphotoPhotoIDVaildFromDate: TDateField
      FieldName = 'PhotoIDVaildFromDate'
    end
    object qryemployeesphotoPhotoIDVaildToDate: TDateField
      FieldName = 'PhotoIDVaildToDate'
    end
    object qryemployeesphotoCDEPWageTotal: TFloatField
      FieldName = 'CDEPWageTotal'
    end
    object qryemployeesphotoIsTerminated: TWideStringField
      FieldName = 'IsTerminated'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoDefaultClassName: TWideStringField
      FieldName = 'DefaultClassName'
      Size = 255
    end
    object qryemployeesphotoDefaultClassID: TIntegerField
      FieldName = 'DefaultClassID'
    end
    object qryemployeesphotoExtraTaxOptions: TWideStringField
      FieldName = 'ExtraTaxOptions'
      FixedChar = True
      Size = 5
    end
    object qryemployeesphotoUseClassificationAdvance: TWideStringField
      FieldName = 'UseClassificationAdvance'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoLastPayPeriod: TSmallintField
      FieldName = 'LastPayPeriod'
    end
    object qryemployeesphotoCommissionFlatRate: TFloatField
      FieldName = 'CommissionFlatRate'
      DisplayFormat = '#0.00'
      EditFormat = '#0.00'
    end
    object qryemployeesphotoCommissionInvoiceExPrice: TWideStringField
      FieldName = 'CommissionInvoiceExPrice'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoCommissionUseEmp: TWideStringField
      FieldName = 'CommissionUseEmp'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoCommissionUseProd: TWideStringField
      FieldName = 'CommissionUseProd'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
    end
    object qryemployeesphotoPaySuperOnLeaveLoading: TWideStringField
      FieldName = 'PaySuperOnLeaveLoading'
    end
    object qryemployeesphotoLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object qryemployeesphotoSalesTarget: TFloatField
      FieldName = 'SalesTarget'
      DisplayFormat = '#,###,##0.00'
      currency = True
    end
    object qryemployeesphotoSendPaySlipViaEmail: TWideStringField
      FieldName = 'SendPaySlipViaEmail'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoEmailsFromEmployeeAddress: TWideStringField
      FieldName = 'EmailsFromEmployeeAddress'
      FixedChar = True
      Size = 1
    end
    object qryemployeesphotoStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryemployeesphotoStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryemployeesphotoSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object qryemployeesphotoPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object qryemployeesphotoState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object qryemployeesphotoCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryemployeesphotoPhone: TWideStringField
      FieldName = 'Phone'
      Size = 255
    end
    object qryemployeesphotoAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Size = 255
    end
    object qryemployeesphotoFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Size = 255
    end
    object qryemployeesphotoMobile: TWideStringField
      FieldName = 'Mobile'
      Size = 255
    end
    object qryemployeesphotoEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
    object qryemployeesphotoAltContact: TWideStringField
      FieldName = 'AltContact'
      Size = 255
    end
    object qryemployeesphotoCompany: TWideStringField
      FieldName = 'Company'
      Size = 35
    end
    object qryemployeesphotoPosition: TWideStringField
      FieldName = 'Position'
      Size = 30
    end
    object qryemployeesphotoOverheadbaserate: TFloatField
      FieldName = 'Overheadbaserate'
    end
  end
  object DSEmployeesPhoto: TDataSource
    DataSet = qryemployeesphoto
    Left = 852
    Top = 122
  end
  object qryPhotoBlob: TERPQuery
    SQL.Strings = (
      'Select * From tblemployeepics'
      'Where EmployeeID=:xID;')
    Left = 856
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryPhotoBlobEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryPhotoBlobEmployeePic: TBlobField
      FieldName = 'EmployeePic'
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'JPEG (*.jpg)|*.jpg|Bitmap (*.bmp)|*.bmp'
    Left = 856
    Top = 232
  end
  object DataSourceBlob: TDataSource
    DataSet = qryPhotoBlob
    Left = 904
    Top = 176
  end
end
