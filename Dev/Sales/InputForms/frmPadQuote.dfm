inherited fmPadQuote: TfmPadQuote
  HelpContext = 830001
  Caption = 'Insurance Pad'
  ClientWidth = 998
  OnResize = FormResize
  ExplicitTop = 206
  ExplicitWidth = 1014
  ExplicitHeight = 571
  DesignSize = (
    998
    532)
  PixelsPerInch = 96
  TextHeight = 18
  inherited lblSkingroupMsg: TLabel
    Width = 998
    ExplicitWidth = 998
    HelpContext = 830070
  end
  inherited shapehint: TShape
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  inherited imgGridWatermark: TImage
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  inherited shapehintextra1: TShape
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
  end
  inherited segMain: TAdvSmoothExpanderGroup
    Width = 998
    HelpContext = 830002
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 998
    DesignSize = (
      998
      532)
    object btnSave: TAdvSmoothButton
      Left = 136
      Top = 491
      Width = 120
      Height = 35
      Action = actSave
      Anchors = [akLeft, akBottom]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Color = clGreen
      TabOrder = 1
      Version = '1.6.9.2'
      HelpContext = 830071
    end
    object btnCancel: TAdvSmoothButton
      Left = 429
      Top = 491
      Width = 120
      Height = 35
      Action = actCancel
      Anchors = [akLeft, akBottom]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Color = clGreen
      TabOrder = 2
      Version = '1.6.9.2'
      HelpContext = 830072
    end
    object tpMain: TAdvSmoothTabPager
      Left = 0
      Top = 3
      Width = 995
      Height = 479
      HelpContext = 830005
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Anchors = [akLeft, akTop, akRight, akBottom]
      ActivePage = tabHeader
      TabSettings.StartMargin = 4
      TabSettings.Height = 40
      TabSettings.Width = 500
      TabReorder = False
      OnChange = tpMainChange
      OnChanging = tpMainChanging
      TabOrder = 3
      object tabHeader: TAdvSmoothTabPage
        Left = 1
        Top = 40
        Width = 993
        Height = 437
        HelpContext = 830006
        Caption = 'Header'
        PageAppearance.Color = clWhite
        PageAppearance.ColorTo = clSilver
        PageAppearance.ColorMirror = clNone
        PageAppearance.ColorMirrorTo = clNone
        PageAppearance.GradientMirrorType = gtVertical
        PageAppearance.BorderColor = 13815240
        PageAppearance.Rounding = 0
        PageAppearance.ShadowOffset = 0
        TabAppearance.Appearance.Font.Charset = ANSI_CHARSET
        TabAppearance.Appearance.Font.Color = clWindowText
        TabAppearance.Appearance.Font.Height = -16
        TabAppearance.Appearance.Font.Name = 'Arial'
        TabAppearance.Appearance.Font.Style = []
        TabAppearance.Status.Caption = '0'
        TabAppearance.Status.Appearance.Fill.Color = clRed
        TabAppearance.Status.Appearance.Fill.ColorMirror = clNone
        TabAppearance.Status.Appearance.Fill.ColorMirrorTo = clNone
        TabAppearance.Status.Appearance.Fill.GradientType = gtSolid
        TabAppearance.Status.Appearance.Fill.BorderColor = clGray
        TabAppearance.Status.Appearance.Fill.Rounding = 0
        TabAppearance.Status.Appearance.Fill.ShadowOffset = 0
        TabAppearance.Status.Appearance.Font.Charset = DEFAULT_CHARSET
        TabAppearance.Status.Appearance.Font.Color = clWhite
        TabAppearance.Status.Appearance.Font.Height = -11
        TabAppearance.Status.Appearance.Font.Name = 'Tahoma'
        TabAppearance.Status.Appearance.Font.Style = []
        TabAppearance.BevelColor = 16379876
        TabAppearance.BevelColorDown = 13815240
        TabAppearance.BevelColorSelected = 13815240
        TabAppearance.BevelColorHot = 16315891
        TabAppearance.BevelColorDisabled = 16379876
        TabAppearance.Color = 16379876
        TabAppearance.ColorDown = clWhite
        TabAppearance.ColorSelected = clWhite
        TabAppearance.ColorDisabled = 15921906
        object lblCustomer: TLabel
          Left = 18
          Top = 20
          Width = 75
          Height = 19
          HelpContext = 830007
          Caption = 'Customer'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblJobName: TLabel
          Left = 312
          Top = 20
          Width = 158
          Height = 19
          HelpContext = 830008
          Caption = 'Job Name / Claim No'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblJobNumber: TLabel
          Left = 636
          Top = 20
          Width = 94
          Height = 19
          HelpContext = 830009
          Caption = 'Job Number'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 18
          Top = 85
          Width = 64
          Height = 19
          HelpContext = 830010
          Caption = 'Address'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblSuburb: TLabel
          Left = 312
          Top = 85
          Width = 30
          Height = 19
          HelpContext = 830011
          Caption = 'City'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblState: TLabel
          Left = 684
          Top = 85
          Width = 39
          Height = 19
          HelpContext = 830012
          Caption = 'State'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblPostCode: TLabel
          Left = 859
          Top = 85
          Width = 80
          Height = 19
          HelpContext = 830013
          Caption = 'Post Code'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblPhone: TLabel
          Left = 312
          Top = 149
          Width = 50
          Height = 19
          HelpContext = 830014
          Caption = 'Phone'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblMobile: TLabel
          Left = 489
          Top = 149
          Width = 50
          Height = 19
          HelpContext = 830015
          Caption = 'Mobile'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblEmail: TLabel
          Left = 682
          Top = 149
          Width = 42
          Height = 19
          HelpContext = 830016
          Caption = 'Email'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblInsuranceCompany: TLabel
          Left = 18
          Top = 322
          Width = 154
          Height = 19
          HelpContext = 830017
          Caption = 'Insurance Company'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblAssessorsName: TLabel
          Left = 360
          Top = 322
          Width = 129
          Height = 19
          HelpContext = 830018
          Caption = 'Assessors Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblExcessAmount: TLabel
          Left = 571
          Top = 322
          Width = 119
          Height = 19
          HelpContext = 830019
          Caption = 'Excess Amount'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblStormLocation: TLabel
          Left = 16
          Top = 380
          Width = 117
          Height = 19
          HelpContext = 830020
          Caption = 'Storm Location'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblStormDate: TLabel
          Left = 360
          Top = 380
          Width = 85
          Height = 19
          HelpContext = 830021
          Caption = 'Storm Date'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblVehicleVinNo: TLabel
          Left = 843
          Top = 210
          Width = 110
          Height = 19
          HelpContext = 830022
          Caption = 'Vehicle Vin No'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblRegoNumber: TLabel
          Left = 365
          Top = 210
          Width = 67
          Height = 19
          HelpContext = 830023
          Caption = 'Rego No'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label3: TLabel
          Left = 19
          Top = 266
          Width = 33
          Height = 19
          HelpContext = 830024
          Caption = 'Year'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblMake: TLabel
          Left = 18
          Top = 210
          Width = 40
          Height = 19
          HelpContext = 830025
          Caption = 'Make'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblModel: TLabel
          Left = 189
          Top = 210
          Width = 46
          Height = 19
          HelpContext = 830026
          Caption = 'Model'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblColour: TLabel
          Left = 682
          Top = 210
          Width = 52
          Height = 19
          HelpContext = 830027
          Caption = 'Colour'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblBodyType: TLabel
          Left = 521
          Top = 210
          Width = 82
          Height = 19
          HelpContext = 830028
          Caption = 'Body Type'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblSpedoReading: TLabel
          Left = 189
          Top = 265
          Width = 127
          Height = 19
          HelpContext = 830029
          Caption = 'Speedo Reading'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblEmployee: TLabel
          Left = 571
          Top = 380
          Width = 76
          Height = 19
          HelpContext = 830030
          Caption = 'Employee'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblClass: TLabel
          Left = 772
          Top = 20
          Width = 43
          Height = 19
          HelpContext = 830031
          Caption = 'Class'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object cboCustomer: TERPDbLookupCombo
          Left = 18
          Top = 40
          Width = 273
          Height = 32
          HelpContext = 830032
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'40'#9'Company'#9'F')
          DataField = 'CustomerName'
          DataSource = dsSales
          LookupTable = qryCustomerLookup
          LookupField = 'Company'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 0
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          LookupFormClassName = 'TCustomerExpressListGUI'
          EditFormClassName = 'TfrmCustomer'
          LookupFormKeyStringFieldName = 'Company'
          LookupComboType = ctCustomer
          AllowFullListSearchMode = False
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        end
        object edtJobName: TwwDBEdit
          Left = 312
          Top = 40
          Width = 305
          Height = 32
          HelpContext = 830033
          DataField = 'JobName'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnExit = edtJobNameExit
        end
        object edtJobNumber: TwwDBEdit
          Left = 636
          Top = 40
          Width = 117
          Height = 32
          HelpContext = 830034
          DataField = 'JobNumber'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtStreet1: TwwDBEdit
          Left = 18
          Top = 105
          Width = 273
          Height = 32
          HelpContext = 830035
          DataField = 'Street'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtStreet2: TwwDBEdit
          Left = 18
          Top = 137
          Width = 273
          Height = 32
          HelpContext = 830036
          DataField = 'Street2'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtStreet3: TwwDBEdit
          Left = 18
          Top = 169
          Width = 273
          Height = 32
          HelpContext = 830037
          DataField = 'Street3'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object Suburb: TwwDBLookupCombo
          Left = 312
          Top = 105
          Width = 305
          Height = 32
          HelpContext = 830038
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'20'#9'Suburb'#9'T'
            'State'#9'4'#9'State'#9'T'
            'Postcode'#9'10'#9'Postcode'#9'T')
          DataField = 'Suburb'
          DataSource = dsClient
          LookupTable = qrySuburb
          LookupField = 'City_sub'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = SuburbCloseUp
        end
        object State: TwwDBEdit
          Left = 684
          Top = 105
          Width = 156
          Height = 32
          HelpContext = 830039
          DataField = 'State'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object PostCode: TwwDBEdit
          Left = 859
          Top = 105
          Width = 121
          Height = 32
          HelpContext = 830040
          DataField = 'PostCode'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtPhone: TwwDBEdit
          Left = 312
          Top = 169
          Width = 158
          Height = 32
          HelpContext = 830041
          DataField = 'Phone'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtMobile: TwwDBEdit
          Left = 489
          Top = 169
          Width = 169
          Height = 32
          HelpContext = 830042
          DataField = 'Mobile'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtEmail: TwwDBEdit
          Left = 682
          Top = 169
          Width = 298
          Height = 32
          HelpContext = 830043
          DataField = 'Email'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboInsuranceCompany: TERPDbLookupCombo
          Left = 18
          Top = 342
          Width = 324
          Height = 32
          HelpContext = 830044
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'40'#9'Company'#9'F')
          DataField = 'InsuranceCompanyName'
          DataSource = dsClient
          LookupTable = qryInsuranceCompanyLookup
          LookupField = 'Company'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 21
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          LookupFormClassName = 'TSupplierExpressListGUI'
          EditFormClassName = 'TfmSupplier'
          LookupFormKeyStringFieldName = 'SupplierName'
          LookupComboType = ctSupplier
          AllowFullListSearchMode = False
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        end
        object edtAssessorsName: TwwDBEdit
          Left = 360
          Top = 342
          Width = 195
          Height = 32
          HelpContext = 830045
          DataField = 'AssessorsName'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtExcessAmount: TwwDBEdit
          Left = 571
          Top = 342
          Width = 153
          Height = 32
          HelpContext = 830046
          DataField = 'ExcessAmount'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 23
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboStormLocation: TwwDBLookupCombo
          Left = 16
          Top = 399
          Width = 326
          Height = 32
          HelpContext = 830047
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'20'#9'Suburb'#9'T'
            'State'#9'4'#9'State'#9'T'
            'Postcode'#9'10'#9'Postcode'#9'T')
          DataField = 'StormLocation'
          DataSource = dsClient
          LookupTable = qrySuburb
          LookupField = 'City_sub'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 24
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object edtDateOfStorm: TwwDBDateTimePicker
          Left = 360
          Top = 399
          Width = 143
          Height = 26
          HelpContext = 830048
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'StormDate'
          DataSource = dsClient
          Epoch = 1950
          ButtonWidth = 30
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 25
        end
        object edtVehicalVin: TwwDBEdit
          Left = 843
          Top = 229
          Width = 137
          Height = 32
          HelpContext = 830049
          DataField = 'SerialNumber'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtRegistrationNumber: TwwDBEdit
          Left = 365
          Top = 229
          Width = 137
          Height = 32
          HelpContext = 830050
          DataField = 'JobRegistration'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtYear: TwwDBDateTimePicker
          Left = 19
          Top = 285
          Width = 153
          Height = 26
          HelpContext = 830051
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'Year'
          DataSource = dsClient
          Epoch = 1950
          ButtonWidth = 30
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 19
          DisplayFormat = 'yyyy'
        end
        object cboModel: TwwDBLookupCombo
          Left = 189
          Top = 229
          Width = 153
          Height = 32
          HelpContext = 830052
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'ModelNumber'
          DataSource = dsClient
          LookupTable = qryModel
          LookupField = 'Name'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 14
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnNotInList = cboModelNotInList
        end
        object edtColour: TwwDBEdit
          Left = 682
          Top = 229
          Width = 137
          Height = 32
          HelpContext = 830053
          DataField = 'Colour'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtBodyType: TwwDBEdit
          Left = 521
          Top = 229
          Width = 137
          Height = 32
          HelpContext = 830054
          DataField = 'BodyType'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtSpeedoReading: TwwDBEdit
          Left = 189
          Top = 284
          Width = 153
          Height = 32
          HelpContext = 830055
          DataField = 'HoursTakenForJob'
          DataSource = dsClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboEmployee: TwwDBLookupCombo
          Left = 571
          Top = 399
          Width = 153
          Height = 32
          HelpContext = 830056
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'30'#9'Employee Name'#9'F')
          DataField = 'EmployeeName'
          DataSource = dsSales
          LookupTable = qryEmployee
          LookupField = 'EmployeeName'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 26
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboClass: TwwDBLookupCombo
          Left = 772
          Top = 40
          Width = 209
          Height = 32
          HelpContext = 830057
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'Class'
          DataSource = dsSales
          LookupTable = gryClass
          LookupField = 'ClassName'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboMake: TwwDBLookupCombo
          Left = 19
          Top = 229
          Width = 153
          Height = 32
          HelpContext = 830058
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'Manufacture'
          DataSource = dsClient
          LookupTable = qryManufacture
          LookupField = 'Name'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 13
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnNotInList = cboMakeNotInList
        end
      end
      object tabDetails: TAdvSmoothTabPage
        Left = 1
        Top = 40
        Width = 993
        Height = 437
        HelpContext = 830059
        Caption = 'Details'
        PageAppearance.Color = clWhite
        PageAppearance.ColorTo = clSilver
        PageAppearance.ColorMirror = clNone
        PageAppearance.ColorMirrorTo = clNone
        PageAppearance.GradientMirrorType = gtVertical
        PageAppearance.BorderColor = 13815240
        PageAppearance.Rounding = 0
        PageAppearance.ShadowOffset = 0
        TabAppearance.Appearance.Font.Charset = ANSI_CHARSET
        TabAppearance.Appearance.Font.Color = clWindowText
        TabAppearance.Appearance.Font.Height = -16
        TabAppearance.Appearance.Font.Name = 'Arial'
        TabAppearance.Appearance.Font.Style = []
        TabAppearance.Status.Caption = '0'
        TabAppearance.Status.Appearance.Fill.Color = clRed
        TabAppearance.Status.Appearance.Fill.ColorMirror = clNone
        TabAppearance.Status.Appearance.Fill.ColorMirrorTo = clNone
        TabAppearance.Status.Appearance.Fill.GradientType = gtSolid
        TabAppearance.Status.Appearance.Fill.BorderColor = clGray
        TabAppearance.Status.Appearance.Fill.Rounding = 0
        TabAppearance.Status.Appearance.Fill.ShadowOffset = 0
        TabAppearance.Status.Appearance.Font.Charset = DEFAULT_CHARSET
        TabAppearance.Status.Appearance.Font.Color = clWhite
        TabAppearance.Status.Appearance.Font.Height = -11
        TabAppearance.Status.Appearance.Font.Name = 'Tahoma'
        TabAppearance.Status.Appearance.Font.Style = []
        TabAppearance.BevelColor = 16379876
        TabAppearance.BevelColorDown = 13815240
        TabAppearance.BevelColorSelected = 13815240
        TabAppearance.BevelColorHot = 16315891
        TabAppearance.BevelColorDisabled = 16379876
        TabAppearance.Color = 16379876
        TabAppearance.ColorDown = clWhite
        TabAppearance.ColorSelected = clWhite
        TabAppearance.ColorDisabled = 15921906
        DesignSize = (
          993
          437)
        inline ButtonArray: TfrButtonArray
          Left = 492
          Top = 16
          Width = 494
          Height = 409
          HelpContext = 830062
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clActiveBorder
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          ExplicitLeft = 492
          ExplicitTop = 16
          ExplicitWidth = 494
          ExplicitHeight = 409
        end
        object grdSalesLines: TwwDBGrid
          Left = 9
          Top = 16
          Width = 474
          Height = 409
          HelpContext = 830063
          Selected.Strings = (
            'UnitofMeasureQtySold'#9'4'#9'Qty'#9'F'#9
            'Product_Description'#9'20'#9'Description'#9'F'#9
            'TotalLineAmountInc'#9'10'#9'Total Inc'#9'F'#9
            'TotalLineAmount'#9'10'#9'Total Ex'#9'F'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akBottom]
          DataSource = dsSalesLines
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
          ParentFont = False
          TabOrder = 1
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnColEnter = grdSalesLinesColEnter
          OnColExit = grdSalesLinesColExit
          OnDblClick = grdSalesLinesDblClick
          FooterColor = clWhite
          FooterCellColor = clWhite
          object grdSalesLinesIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 27
            Height = 22
            HelpContext = 830064
            AllowAllUp = True
            Glyph.Data = {
              26040000424D2604000000000000360000002800000012000000120000000100
              180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
              636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
              7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
              00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
              FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
              000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
              D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
              0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
              FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
              D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
              00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
              00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
              0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
              E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
              AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
              07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
              0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
              00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
              FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
              FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
              007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
              CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
              0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
              FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
              1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
              C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
              D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
              E0E3FFFFFFFFFFFF0000}
            OnClick = grdSalesLinesIButtonClick
          end
        end
        object keyNumeric: TAdvSmoothTouchKeyBoard
          Left = 489
          Top = 16
          Width = 245
          Height = 300
          HelpContext = 830065
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWhite
          AutoCompletion.Font.Height = -19
          AutoCompletion.Font.Name = 'Tahoma'
          AutoCompletion.Font.Style = []
          AutoCompletion.Color = clBlack
          Fill.ColorMirror = clNone
          Fill.ColorMirrorTo = clNone
          Fill.BorderColor = clNone
          Fill.Rounding = 0
          Fill.ShadowOffset = 0
          KeyboardType = ktNUMERIC
          Keys = <
            item
              Caption = 'Num Lock'
              KeyValue = 144
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNum
              Color = 10526880
              X = 2
              Y = 1
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '/'
              KeyValue = 111
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skDivide
              X = 62
              Y = 1
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '*'
              KeyValue = 106
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skMultiply
              X = 123
              Y = 1
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '-'
              KeyValue = 109
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skSubstract
              X = 183
              Y = 1
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '7'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 2
              Y = 61
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '8'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 62
              Y = 61
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '9'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 123
              Y = 61
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '+'
              KeyValue = 107
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skAdd
              X = 183
              Y = 61
              Height = 119
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '4'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 2
              Y = 120
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '5'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 62
              Y = 120
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '6'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 123
              Y = 120
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '1'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 2
              Y = 180
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '2'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 62
              Y = 180
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '3'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 123
              Y = 180
              Height = 59
              Width = 60
              SubKeys = <>
            end
            item
              Caption = 'Enter'
              KeyValue = 13
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skReturn
              Color = 10526880
              X = 183
              Y = 180
              Height = 119
              Width = 60
              SubKeys = <>
            end
            item
              Caption = '0'
              KeyValue = -1
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skNone
              X = 2
              Y = 239
              Height = 59
              Width = 121
              SubKeys = <>
            end
            item
              Caption = '.'
              KeyValue = 110
              ShiftKeyValue = -1
              AltGrKeyValue = -1
              SpecialKey = skDecimal
              X = 123
              Y = 239
              Height = 59
              Width = 60
              SubKeys = <>
            end>
          SmallFont.Charset = ANSI_CHARSET
          SmallFont.Color = clWindowText
          SmallFont.Height = -21
          SmallFont.Name = 'Arial'
          SmallFont.Style = []
          Version = '1.5.1.0'
          OnKeyClick = keyNumericKeyClick
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = []
          Visible = False
        end
      end
    end
    object AdvSmoothButton1: TAdvSmoothButton
      Left = 282
      Top = 491
      Width = 120
      Height = 35
      Action = actNext
      Anchors = [akLeft, akBottom]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Color = clGreen
      TabOrder = 4
      Version = '1.6.9.2'
      HelpContext = 830073
    end
    object btnCustomise: TAdvSmoothButton
      Left = 576
      Top = 491
      Width = 120
      Height = 35
      Action = actKeypadHome
      Anchors = [akRight, akBottom]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Color = clGreen
      TabOrder = 5
      Version = '1.6.9.2'
      HelpContext = 830074
    end
    object btnHome: TAdvSmoothButton
      Left = 723
      Top = 491
      Width = 120
      Height = 35
      Action = actCustomiseKeypad
      Anchors = [akRight, akBottom]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Color = clGreen
      TabOrder = 6
      Version = '1.6.9.2'
      HelpContext = 830075
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102002C00340010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 258
    Top = 8
  end
  inherited ActionList: TActionList
    Left = 144
    Top = 48
    inherited actSave: TAction
      OnExecute = actSaveExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
    object actCustomiseKeypad: TAction
      Caption = 'Customise'
      HelpContext = 830067
      OnExecute = actCustomiseKeypadExecute
    end
    object actKeypadHome: TAction
      Caption = 'Home'
      HelpContext = 830068
      OnExecute = actKeypadHomeExecute
    end
    object actNext: TAction
      Caption = 'Next'
      HelpContext = 830069
      OnExecute = actNextExecute
    end
  end
  object qrySales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblSales where SaleID = :ID')
    Left = 312
    Top = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qrySalesSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object qrySalesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrySalesInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Size = 30
    end
    object qrySalesOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Size = 255
    end
    object qrySalesBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Size = 255
    end
    object qrySalesAccount: TWideStringField
      FieldName = 'Account'
      Size = 255
    end
    object qrySalesAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qrySalesBOID: TWideStringField
      FieldName = 'BOID'
      Size = 255
    end
    object qrySalesCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 255
    end
    object qrySalesClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qrySalesInvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Size = 255
    end
    object qrySalesShipTo: TWideStringField
      FieldName = 'ShipTo'
      Size = 255
    end
    object qrySalesPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Size = 255
    end
    object qrySalesSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object qrySalesTotalTax: TFloatField
      FieldName = 'TotalTax'
    end
    object qrySalesTotalWETTax: TFloatField
      FieldName = 'TotalWETTax'
    end
    object qrySalesTotalWEGTax: TFloatField
      FieldName = 'TotalWEGTax'
    end
    object qrySalesTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
    object qrySalesTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
    end
    object qrySalesTotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
    end
    object qrySalesTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
    end
    object qrySalesEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qrySalesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qrySalesClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qrySalesClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object qrySalesOrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Size = 30
    end
    object qrySalesPONumber: TWideStringField
      FieldName = 'PONumber'
      Size = 30
    end
    object qrySalesChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Size = 45
    end
    object qrySalesShipDate: TDateField
      FieldName = 'ShipDate'
    end
    object qrySalesFutureSO: TWideStringField
      FieldName = 'FutureSO'
      FixedChar = True
      Size = 1
    end
    object qrySalesDueDate: TDateField
      FieldName = 'DueDate'
    end
    object qrySalesConNote: TWideStringField
      FieldName = 'ConNote'
      Size = 25
    end
    object qrySalesMemo: TWideMemoField
      FieldName = 'Memo'
      BlobType = ftWideMemo
    end
    object qrySalesComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object qrySalesInvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Size = 255
    end
    object qrySalesPickMemo: TWideMemoField
      FieldName = 'PickMemo'
      BlobType = ftWideMemo
      Size = 255
    end
    object qrySalesPrintHold: TWideStringField
      FieldName = 'PrintHold'
      FixedChar = True
      Size = 1
    end
    object qrySalesShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object qrySalesTerms: TWideStringField
      FieldName = 'Terms'
      Size = 255
    end
    object qrySalesPayMethod: TWideStringField
      FieldName = 'PayMethod'
      Size = 50
    end
    object qrySalesPayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Size = 11
    end
    object qrySalesPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object qrySalesBalance: TFloatField
      FieldName = 'Balance'
    end
    object qrySalesSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object qrySalesPayment: TFloatField
      FieldName = 'Payment'
    end
    object qrySalesApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object qrySalesAmountDue: TFloatField
      FieldName = 'AmountDue'
    end
    object qrySalesTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Size = 11
    end
    object qrySalesIsPOS: TWideStringField
      FieldName = 'IsPOS'
      FixedChar = True
      Size = 1
    end
    object qrySalesPOS: TWideStringField
      FieldName = 'POS'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsRefund: TWideStringField
      FieldName = 'IsRefund'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsQuote: TWideStringField
      FieldName = 'IsQuote'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsLayby: TWideStringField
      FieldName = 'IsLayby'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object qrySalesDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object qrySalesCancelled: TWideStringField
      FieldName = 'Cancelled'
      FixedChar = True
      Size = 1
    end
    object qrySalesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qrySalesTotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
    end
    object qrySalesLaybyID: TWideStringField
      FieldName = 'LaybyID'
      Size = 14
    end
    object qrySalesDeposited: TWideStringField
      FieldName = 'Deposited'
      FixedChar = True
      Size = 1
    end
    object qrySalesTillID: TSmallintField
      FieldName = 'TillID'
    end
    object qrySalesHoldSale: TWideStringField
      FieldName = 'HoldSale'
      FixedChar = True
      Size = 1
    end
    object qrySalesSaleConfirmed: TWideStringField
      FieldName = 'SaleConfirmed'
      FixedChar = True
      Size = 1
    end
    object qrySalesFreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object qrySalesConverted: TWideStringField
      FieldName = 'Converted'
      FixedChar = True
      Size = 1
    end
    object qrySalesEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Size = 255
    end
    object qrySalesEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Size = 255
    end
    object qrySalesCommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object qrySalesIsManifest: TWideStringField
      FieldName = 'IsManifest'
      FixedChar = True
      Size = 1
    end
    object qrySalesUsedOnManifest: TWideStringField
      FieldName = 'UsedOnManifest'
      FixedChar = True
      Size = 1
    end
    object qrySalesAddToManifest: TWideStringField
      FieldName = 'AddToManifest'
      FixedChar = True
      Size = 1
    end
    object qrySalesSalesOrderGlobalRef: TWideStringField
      FieldName = 'SalesOrderGlobalRef'
      Size = 255
    end
    object qrySalesQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Size = 255
    end
    object qrySalesRepairGlobalRef: TWideStringField
      FieldName = 'RepairGlobalRef'
      Size = 255
    end
    object qrySalesSOProgressPaymentGlobalRef: TWideStringField
      FieldName = 'SOProgressPaymentGlobalRef'
      Size = 255
    end
    object qrySalesSOProgressPaymentOriginalRef: TWideStringField
      FieldName = 'SOProgressPaymentOriginalRef'
      Size = 255
    end
    object qrySalesIsBarcodePicking: TWideStringField
      FieldName = 'IsBarcodePicking'
      FixedChar = True
      Size = 1
    end
    object qrySalesBarcodePickingDone: TWideStringField
      FieldName = 'BarcodePickingDone'
      FixedChar = True
      Size = 1
    end
    object qrySalesARNotes: TWideMemoField
      FieldName = 'ARNotes'
      BlobType = ftWideMemo
    end
    object qrySalesOriginalCreationDate: TDateField
      FieldName = 'OriginalCreationDate'
    end
    object qrySalesQuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Size = 255
    end
    object qrySalesDespatchID: TIntegerField
      FieldName = 'DespatchID'
    end
    object qrySalesRunID: TIntegerField
      FieldName = 'RunID'
    end
    object qrySalesRunName: TWideStringField
      FieldName = 'RunName'
      Size = 255
    end
    object qrySalesReference: TWideStringField
      FieldName = 'Reference'
      Size = 255
    end
    object qrySalesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qrySalesPOCreated: TWideStringField
      FieldName = 'POCreated'
      FixedChar = True
      Size = 1
    end
    object qrySalesLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object qrySalesForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object qrySalesForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
    end
    object qrySalesForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
    end
    object qrySalesForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
    end
    object qrySalesForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
    end
    object qrySalesIsGeneratedFromHire: TWideStringField
      FieldName = 'IsGeneratedFromHire'
      FixedChar = True
      Size = 1
    end
    object qrySalesBlindBalancePeriodID: TIntegerField
      FieldName = 'BlindBalancePeriodID'
    end
    object qrySalesSaleDateTime: TDateTimeField
      FieldName = 'SaleDateTime'
    end
    object qrySalesAutoSmartOrderRef: TWideStringField
      FieldName = 'AutoSmartOrderRef'
      Size = 255
    end
    object qrySalesIsInternalOrder: TWideStringField
      FieldName = 'IsInternalOrder'
      FixedChar = True
      Size = 1
    end
    object qrySalesShippingCost: TFloatField
      FieldName = 'ShippingCost'
    end
    object qrySalescontactID: TLargeintField
      FieldName = 'contactID'
    end
    object qrySalesContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 100
    end
    object qrySalesPOSPostCode: TWideStringField
      FieldName = 'POSPostCode'
      Size = 4
    end
    object qrySalesRepairID: TLargeintField
      FieldName = 'RepairID'
    end
    object qrySalesMedtypeID: TIntegerField
      FieldName = 'MedtypeID'
    end
    object qrySalesMedtype: TWideStringField
      FieldName = 'Medtype'
      Size = 100
    end
    object qrySalesNoOfBoxes: TLargeintField
      FieldName = 'NoOfBoxes'
    end
    object qrySalesContributionAmount: TFloatField
      FieldName = 'ContributionAmount'
    end
  end
  object qrySalesLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblSalesLines where SaleID = :ID')
    Filtered = True
    Filter = 'Deleted = "F"'
    Left = 360
    Top = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qrySalesLinesUnitofMeasureQtySold: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 4
      FieldName = 'UnitofMeasureQtySold'
      Origin = 'tblsaleslines.UnitofMeasureQtySold'
    end
    object qrySalesLinesProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldName = 'Product_Description'
      Origin = 'tblsaleslines.Product_Description'
      Size = 255
    end
    object qrySalesLinesTotalLineAmountInc: TFloatField
      DisplayLabel = 'Total Inc'
      DisplayWidth = 10
      FieldName = 'TotalLineAmountInc'
      Origin = 'tblsaleslines.TotalLineAmountInc'
      currency = True
    end
    object qrySalesLinesTotalLineAmount: TFloatField
      DisplayLabel = 'Total Ex'
      DisplayWidth = 10
      FieldName = 'TotalLineAmount'
      Origin = 'tblsaleslines.TotalLineAmount'
      currency = True
    end
    object qrySalesLinesProductName: TWideStringField
      DisplayLabel = 'Item'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'tblsaleslines.ProductName'
      Visible = False
      Size = 60
    end
    object qrySalesLinesSaleLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Origin = 'tblsaleslines.SaleLineID'
      Visible = False
    end
    object qrySalesLinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblsaleslines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tblsaleslines.SaleID'
      Visible = False
    end
    object qrySalesLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblsaleslines.ProductID'
      Visible = False
    end
    object qrySalesLinesPARTTYPE: TWideStringField
      DisplayWidth = 13
      FieldName = 'PARTTYPE'
      Origin = 'tblsaleslines.PARTTYPE'
      Visible = False
      Size = 13
    end
    object qrySalesLinesINCOMEACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'INCOMEACCNT'
      Origin = 'tblsaleslines.INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object qrySalesLinesASSETACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'ASSETACCNT'
      Origin = 'tblsaleslines.ASSETACCNT'
      Visible = False
      Size = 50
    end
    object qrySalesLinesCOGSACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'COGSACCNT'
      Origin = 'tblsaleslines.COGSACCNT'
      Visible = False
      Size = 50
    end
    object qrySalesLinesProductGroup: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductGroup'
      Origin = 'tblsaleslines.ProductGroup'
      Visible = False
      Size = 255
    end
    object qrySalesLinesProduct_Description_Memo: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Product_Description_Memo'
      Origin = 'tblsaleslines.Product_Description_Memo'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesOrgLinePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'OrgLinePrice'
      Origin = 'tblsaleslines.OrgLinePrice'
      Visible = False
    end
    object qrySalesLinesLinePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Origin = 'tblsaleslines.LinePrice'
      Visible = False
    end
    object qrySalesLinesLinePriceInc: TFloatField
      DisplayWidth = 10
      FieldName = 'LinePriceInc'
      Origin = 'tblsaleslines.LinePriceInc'
      Visible = False
    end
    object qrySalesLinesLineWholesalePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LineWholesalePrice'
      Origin = 'tblsaleslines.LineWholesalePrice'
      Visible = False
    end
    object qrySalesLinesLineTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Origin = 'tblsaleslines.LineTaxRate'
      Visible = False
    end
    object qrySalesLinesLineCost: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCost'
      Origin = 'tblsaleslines.LineCost'
      Visible = False
    end
    object qrySalesLinesLineCostInc: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCostInc'
      Origin = 'tblsaleslines.LineCostInc'
      Visible = False
    end
    object qrySalesLinesLineTaxCode: TWideStringField
      DisplayWidth = 15
      FieldName = 'LineTaxCode'
      Origin = 'tblsaleslines.LineTaxCode'
      Visible = False
      Size = 15
    end
    object qrySalesLinesLineTax: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTax'
      Origin = 'tblsaleslines.LineTax'
      Visible = False
    end
    object qrySalesLinesQtySold: TFloatField
      DisplayWidth = 10
      FieldName = 'QtySold'
      Origin = 'tblsaleslines.QtySold'
      Visible = False
    end
    object qrySalesLinesShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'Shipped'
      Origin = 'tblsaleslines.Shipped'
      Visible = False
    end
    object qrySalesLinesUnitofMeasureShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureShipped'
      Origin = 'tblsaleslines.UnitofMeasureShipped'
      Visible = False
    end
    object qrySalesLinesBackOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'BackOrder'
      Origin = 'tblsaleslines.BackOrder'
      Visible = False
    end
    object qrySalesLinesUnitofMeasureBackorder: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureBackorder'
      Origin = 'tblsaleslines.UnitofMeasureBackorder'
      Visible = False
    end
    object qrySalesLinesUnitofMeasureSaleLines: TWideStringField
      DisplayWidth = 255
      FieldName = 'UnitofMeasureSaleLines'
      Origin = 'tblsaleslines.UnitofMeasureSaleLines'
      Visible = False
      Size = 255
    end
    object qrySalesLinesUnitOfMeasureID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureID'
      Origin = 'tblsaleslines.UnitOfMeasureID'
      Visible = False
    end
    object qrySalesLinesUnitofMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureMultiplier'
      Origin = 'tblsaleslines.UnitofMeasureMultiplier'
      Visible = False
    end
    object qrySalesLinesInvoiced: TWideStringField
      DisplayWidth = 1
      FieldName = 'Invoiced'
      Origin = 'tblsaleslines.Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesDiscounts: TFloatField
      DisplayWidth = 10
      FieldName = 'Discounts'
      Origin = 'tblsaleslines.Discounts'
      Visible = False
    end
    object qrySalesLinesMarkup: TFloatField
      DisplayWidth = 10
      FieldName = 'Markup'
      Origin = 'tblsaleslines.Markup'
      Visible = False
    end
    object qrySalesLinesMarkupPercent: TFloatField
      DisplayWidth = 10
      FieldName = 'MarkupPercent'
      Origin = 'tblsaleslines.MarkupPercent'
      Visible = False
    end
    object qrySalesLinesDiscountPercent: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscountPercent'
      Origin = 'tblsaleslines.DiscountPercent'
      Visible = False
    end
    object qrySalesLinesTimecostused: TWideStringField
      DisplayWidth = 1
      FieldName = 'Timecostused'
      Origin = 'tblsaleslines.Timecostused'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblsaleslines.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblsaleslines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesRefundQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RefundQty'
      Origin = 'tblsaleslines.RefundQty'
      Visible = False
    end
    object qrySalesLinesLaybyID: TWideStringField
      DisplayWidth = 14
      FieldName = 'LaybyID'
      Origin = 'tblsaleslines.LaybyID'
      Visible = False
      Size = 14
    end
    object qrySalesLinesSoldSerials: TWideMemoField
      DisplayWidth = 10
      FieldName = 'SoldSerials'
      Origin = 'tblsaleslines.SoldSerials'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesAttrib1Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1Sale'
      Origin = 'tblsaleslines.Attrib1Sale'
      Visible = False
    end
    object qrySalesLinesAttrib2Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2Sale'
      Origin = 'tblsaleslines.Attrib2Sale'
      Visible = False
    end
    object qrySalesLinesAttrib1SaleRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1SaleRate'
      Origin = 'tblsaleslines.Attrib1SaleRate'
      Visible = False
    end
    object qrySalesLinesLastLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LastLineID'
      Origin = 'tblsaleslines.LastLineID'
      Visible = False
    end
    object qrySalesLinesDescAttrib3: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib3'
      Origin = 'tblsaleslines.DescAttrib3'
      Visible = False
      Size = 255
    end
    object qrySalesLinesDescAttrib1: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib1'
      Origin = 'tblsaleslines.DescAttrib1'
      Visible = False
      Size = 255
    end
    object qrySalesLinesDescAttrib2: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib2'
      Origin = 'tblsaleslines.DescAttrib2'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSupplier: TWideStringField
      DisplayWidth = 255
      FieldName = 'Supplier'
      Origin = 'tblsaleslines.Supplier'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSupplierContact: TWideStringField
      DisplayWidth = 255
      FieldName = 'SupplierContact'
      Origin = 'tblsaleslines.SupplierContact'
      Visible = False
      Size = 255
    end
    object qrySalesLinesDescAttrib4: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib4'
      Origin = 'tblsaleslines.DescAttrib4'
      Visible = False
      Size = 255
    end
    object qrySalesLinesDescAttrib5: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib5'
      Origin = 'tblsaleslines.DescAttrib5'
      Visible = False
      Size = 255
    end
    object qrySalesLinesForeignExchangeSellRate: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignExchangeSellRate'
      Origin = 'tblsaleslines.ForeignExchangeSellRate'
      Visible = False
    end
    object qrySalesLinesForeignExchangeSellCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblsaleslines.ForeignExchangeSellCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
    object qrySalesLinesForeignCurrencyLinePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignCurrencyLinePrice'
      Origin = 'tblsaleslines.ForeignCurrencyLinePrice'
      Visible = False
    end
    object qrySalesLinesForeignTotalLineAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignTotalLineAmount'
      Origin = 'tblsaleslines.ForeignTotalLineAmount'
      Visible = False
    end
    object qrySalesLinesArea: TWideStringField
      DisplayWidth = 255
      FieldName = 'Area'
      Origin = 'tblsaleslines.Area'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSearchFilter: TWideStringField
      DisplayWidth = 255
      FieldName = 'SearchFilter'
      Origin = 'tblsaleslines.SearchFilter'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSearchFilterCopy: TWideStringField
      DisplayWidth = 255
      FieldName = 'SearchFilterCopy'
      Origin = 'tblsaleslines.SearchFilterCopy'
      Visible = False
      Size = 255
    end
    object qrySalesLinesIsRelatedProduct: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsRelatedProduct'
      Origin = 'tblsaleslines.IsRelatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesRelatedParentProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RelatedParentProductID'
      Origin = 'tblsaleslines.RelatedParentProductID'
      Visible = False
    end
    object qrySalesLinesLastUpdated: TDateTimeField
      DisplayWidth = 18
      FieldName = 'LastUpdated'
      Origin = 'tblsaleslines.LastUpdated'
      Visible = False
    end
    object qrySalesLinesHireID: TIntegerField
      DisplayWidth = 10
      FieldName = 'HireID'
      Origin = 'tblsaleslines.HireID'
      Visible = False
    end
    object qrySalesLinesHireQty: TFloatField
      DisplayWidth = 10
      FieldName = 'HireQty'
      Origin = 'tblsaleslines.HireQty'
      Visible = False
    end
    object qrySalesLinesHireToBeReturned: TDateField
      DisplayWidth = 10
      FieldName = 'HireToBeReturned'
      Origin = 'tblsaleslines.HireToBeReturned'
      Visible = False
    end
    object qrySalesLinesHireSerials: TWideMemoField
      DisplayWidth = 10
      FieldName = 'HireSerials'
      Origin = 'tblsaleslines.HireSerials'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesIsQuote: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsQuote'
      Origin = 'tblsaleslines.IsQuote'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesCostCentreId: TIntegerField
      DisplayWidth = 10
      FieldName = 'CostCentreId'
      Origin = 'tblsaleslines.CostCentreId'
      Visible = False
    end
    object qrySalesLinesClonedFromId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClonedFromId'
      Origin = 'tblsaleslines.ClonedFromId'
      Visible = False
    end
    object qrySalesLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblsaleslines.msTimeStamp'
      Visible = False
    end
    object qrySalesLinesDocketNumber: TWideStringField
      DisplayWidth = 255
      FieldName = 'DocketNumber'
      Origin = 'tblsaleslines.DocketNumber'
      Visible = False
      Size = 255
    end
    object qrySalesLinesUseHedging: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseHedging'
      Origin = 'tblsaleslines.UseHedging'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesPartSpecID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartSpecID'
      Origin = 'tblsaleslines.PartSpecID'
      Visible = False
    end
    object qrySalesLinesSpecDescription: TWideStringField
      DisplayWidth = 255
      FieldName = 'SpecDescription'
      Origin = 'tblsaleslines.SpecDescription'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSpecValue: TFloatField
      DisplayWidth = 10
      FieldName = 'SpecValue'
      Origin = 'tblsaleslines.SpecValue'
      Visible = False
    end
    object qrySalesLinesCreationDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CreationDate'
      Origin = 'tblsaleslines.CreationDate'
      Visible = False
    end
    object qrySalesLinesWarrantyPeriod: TWideStringField
      DisplayWidth = 100
      FieldName = 'WarrantyPeriod'
      Origin = 'tblsaleslines.WarrantyPeriod'
      Visible = False
      Size = 100
    end
    object qrySalesLinesWarrantyEndsOn: TDateField
      DisplayWidth = 10
      FieldName = 'WarrantyEndsOn'
      Origin = 'tblsaleslines.WarrantyEndsOn'
      Visible = False
    end
    object qrySalesLinesSalesLinesCustField1: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField1'
      Origin = 'tblsaleslines.SalesLinesCustField1'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField2: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField2'
      Origin = 'tblsaleslines.SalesLinesCustField2'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField3: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField3'
      Origin = 'tblsaleslines.SalesLinesCustField3'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField4: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField4'
      Origin = 'tblsaleslines.SalesLinesCustField4'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField5: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField5'
      Origin = 'tblsaleslines.SalesLinesCustField5'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField6: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField6'
      Origin = 'tblsaleslines.SalesLinesCustField6'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField7: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField7'
      Origin = 'tblsaleslines.SalesLinesCustField7'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField8: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField8'
      Origin = 'tblsaleslines.SalesLinesCustField8'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField9: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField9'
      Origin = 'tblsaleslines.SalesLinesCustField9'
      Visible = False
      Size = 255
    end
    object qrySalesLinesSalesLinesCustField10: TWideStringField
      DisplayWidth = 255
      FieldName = 'SalesLinesCustField10'
      Origin = 'tblsaleslines.SalesLinesCustField10'
      Visible = False
      Size = 255
    end
    object qrySalesLinesLineNotes: TWideMemoField
      DisplayWidth = 10
      FieldName = 'LineNotes'
      Origin = 'tblsaleslines.LineNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesCustomData: TWideMemoField
      DisplayWidth = 10
      FieldName = 'CustomData'
      Origin = 'tblsaleslines.CustomData'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesINCOMEACCNTID: TIntegerField
      DisplayWidth = 10
      FieldName = 'INCOMEACCNTID'
      Origin = 'tblsaleslines.INCOMEACCNTID'
      Visible = False
    end
    object qrySalesLinesASSETACCNTID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ASSETACCNTID'
      Origin = 'tblsaleslines.ASSETACCNTID'
      Visible = False
    end
    object qrySalesLinesCOGSACCNTID: TIntegerField
      DisplayWidth = 10
      FieldName = 'COGSACCNTID'
      Origin = 'tblsaleslines.COGSACCNTID'
      Visible = False
    end
    object qrySalesLinesSortId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SortId'
      Origin = 'tblsaleslines.SortId'
      Visible = False
    end
    object qrySalesLinesLinesOrder: TIntegerField
      DisplayWidth = 10
      FieldName = 'LinesOrder'
      Origin = 'tblsaleslines.LinesOrder'
      Visible = False
    end
    object qrySalesLinesMemoLine: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MemoLine'
      Origin = 'tblsaleslines.MemoLine'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesSeqNo: TIntegerField
      DisplayWidth = 10
      FieldName = 'SeqNo'
      Origin = 'tblsaleslines.SeqNo'
      Visible = False
    end
    object qrySalesLinesRelatedParentLineRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'RelatedParentLineRef'
      Origin = 'tblsaleslines.RelatedParentLineRef'
      Visible = False
      Size = 255
    end
    object qrySalesLinesRelatedProductQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RelatedProductQty'
      Origin = 'tblsaleslines.RelatedProductQty'
      Visible = False
    end
    object qrySalesLinesIsFormulaRElatedProduct: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsFormulaRElatedProduct'
      Origin = 'tblsaleslines.IsFormulaRElatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesFormulaID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FormulaID'
      Origin = 'tblsaleslines.FormulaID'
      Visible = False
    end
    object qrySalesLinesAutoSmartOrder: TWideStringField
      DisplayWidth = 1
      FieldName = 'AutoSmartOrder'
      Origin = 'tblsaleslines.AutoSmartOrder'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesSmartOrderCreated: TWideStringField
      DisplayWidth = 1
      FieldName = 'SmartOrderCreated'
      Origin = 'tblsaleslines.SmartOrderCreated'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySalesLinesShipDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ShipDate'
      Origin = 'tblsaleslines.ShipDate'
      Visible = False
    end
    object qrySalesLinesBaseLineno: TIntegerField
      DisplayWidth = 10
      FieldName = 'BaseLineno'
      Origin = 'tblsaleslines.BaseLineno'
      Visible = False
    end
    object qrySalesLinesPartBarcode: TWideStringField
      DisplayWidth = 255
      FieldName = 'PartBarcode'
      Origin = 'tblsaleslines.PartBarcode'
      Visible = False
      Size = 255
    end
    object qrySalesLinesProgresspaymentRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProgresspaymentRef'
      Origin = 'tblsaleslines.ProgresspaymentRef'
      Visible = False
      Size = 255
    end
    object qrySalesLinesMatrixDesc: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      Origin = 'tblsaleslines.MatrixDesc'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Origin = 'tblsaleslines.MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object qrySalesLinesMatrixPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      Origin = 'tblsaleslines.MatrixPrice'
      Visible = False
    end
  end
  object dsSalesLines: TDataSource
    DataSet = qrySalesLines
    Left = 360
    Top = 448
  end
  object dsSales: TDataSource
    DataSet = qrySales
    Left = 320
    Top = 448
  end
  object qryCustomerLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ClientID as ClientID,'
      'Company as Company'
      'FROM tblclients'
      'WHERE Customer='#39'T'#39' AND char_length(Company)>0'
      'AND Active = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 208
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryCustomerLookupCompany: TWideStringField
      DisplayWidth = 40
      FieldName = 'Company'
      Size = 160
    end
    object qryCustomerLookupClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
  end
  object qryClient: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblClients where ClientId = :ID')
    Left = 408
    Top = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryClientGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblclients.GlobalRef'
      Size = 255
    end
    object qryClientClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
    end
    object qryClientClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
      Origin = 'tblclients.ClientTypeID'
    end
    object qryClientCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 160
    end
    object qryClientABN: TWideStringField
      FieldName = 'ABN'
      Origin = 'tblclients.ABN'
      Size = 15
    end
    object qryClientTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblclients.Title'
      Size = 32
    end
    object qryClientFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblclients.FirstName'
      Size = 40
    end
    object qryClientMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblclients.MiddleName'
      Size = 40
    end
    object qryClientLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblclients.LastName'
      Size = 40
    end
    object qryClientSkypeName: TWideStringField
      FieldName = 'SkypeName'
      Origin = 'tblclients.SkypeName'
      Size = 100
    end
    object qryClientPosition: TWideStringField
      FieldName = 'Position'
      Origin = 'tblclients.Position'
      Size = 30
    end
    object qryClientStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Size = 255
    end
    object qryClientStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Size = 255
    end
    object qryClientSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Size = 255
    end
    object qryClientState: TWideStringField
      FieldName = 'State'
      Origin = 'tblclients.State'
      Size = 255
    end
    object qryClientCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblclients.Country'
      Size = 255
    end
    object qryClientPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Size = 255
    end
    object qryClientBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      Size = 255
    end
    object qryClientBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      Size = 255
    end
    object qryClientBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      Size = 255
    end
    object qryClientBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      Size = 255
    end
    object qryClientBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      Size = 255
    end
    object qryClientBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      Size = 255
    end
    object qryClientPOBox: TWideStringField
      FieldName = 'POBox'
      Origin = 'tblclients.POBox'
      Size = 255
    end
    object qryClientPOSuburb: TWideStringField
      FieldName = 'POSuburb'
      Origin = 'tblclients.POSuburb'
      Size = 255
    end
    object qryClientPOState: TWideStringField
      FieldName = 'POState'
      Origin = 'tblclients.POState'
      Size = 255
    end
    object qryClientPOCountry: TWideStringField
      FieldName = 'POCountry'
      Origin = 'tblclients.POCountry'
      Size = 255
    end
    object qryClientPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Origin = 'tblclients.POPostcode'
      Size = 255
    end
    object qryClientPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
    end
    object qryClientFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
    end
    object qryClientMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
    end
    object qryClientEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblclients.Email'
      Size = 80
    end
    object qryClientAltContact: TWideStringField
      FieldName = 'AltContact'
      Origin = 'tblclients.AltContact'
      Size = 50
    end
    object qryClientAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
    end
    object qryClientPhoneSupportTill: TDateField
      FieldName = 'PhoneSupportTill'
      Origin = 'tblclients.PhoneSupportTill'
    end
    object qryClientContact1: TWideStringField
      FieldName = 'Contact1'
      Origin = 'tblclients.Contact1'
      Size = 50
    end
    object qryClientContact2: TWideStringField
      FieldName = 'Contact2'
      Origin = 'tblclients.Contact2'
      Size = 50
    end
    object qryClientContact1Phone: TWideStringField
      FieldName = 'Contact1Phone'
      Origin = 'tblclients.Contact1Phone'
    end
    object qryClientContact2Phone: TWideStringField
      FieldName = 'Contact2Phone'
      Origin = 'tblclients.Contact2Phone'
    end
    object qryClientCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblclients.CreationDate'
    end
    object qryClientUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Origin = 'tblclients.UpdateDate'
    end
    object qryClientDateInactive: TDateField
      FieldName = 'DateInactive'
      Origin = 'tblclients.DateInactive'
    end
    object qryClientNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblclients.Notes'
      BlobType = ftWideMemo
    end
    object qryClientClientNo: TWideStringField
      FieldName = 'ClientNo'
      Origin = 'tblclients.ClientNo'
      Size = 50
    end
    object qryClientMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblclients.MedTypeID'
    end
    object qryClientTYPE: TWideStringField
      FieldName = 'TYPE'
      Origin = 'tblclients.TYPE'
      Size = 50
    end
    object qryClientTAXID: TIntegerField
      FieldName = 'TAXID'
      Origin = 'tblclients.TAXID'
    end
    object qryClientCreditLimit: TFloatField
      FieldName = 'CreditLimit'
      Origin = 'tblclients.CreditLimit'
    end
    object qryClientARBalance: TFloatField
      FieldName = 'ARBalance'
      Origin = 'tblclients.ARBalance'
    end
    object qryClientAPBalance: TFloatField
      FieldName = 'APBalance'
      Origin = 'tblclients.APBalance'
    end
    object qryClientBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblclients.Balance'
    end
    object qryClientSOBalance: TFloatField
      FieldName = 'SOBalance'
      Origin = 'tblclients.SOBalance'
    end
    object qryClientTERMS: TWideStringField
      FieldName = 'TERMS'
      Origin = 'tblclients.TERMS'
      Size = 30
    end
    object qryClientTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblclients.TermsID'
    end
    object qryClientShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblclients.ShippingMethod'
      Size = 30
    end
    object qryClientShippingID: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'tblclients.ShippingID'
    end
    object qryClientDiscount: TFloatField
      FieldName = 'Discount'
      Origin = 'tblclients.Discount'
    end
    object qryClientSpecialDiscount: TFloatField
      FieldName = 'SpecialDiscount'
      Origin = 'tblclients.SpecialDiscount'
    end
    object qryClientJobName: TWideStringField
      FieldName = 'JobName'
      Origin = 'tblclients.JobName'
      Size = 79
    end
    object qryClientJobRegistration: TWideStringField
      FieldName = 'JobRegistration'
      Origin = 'tblclients.JobRegistration'
      Size = 50
    end
    object qryClientWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Origin = 'tblclients.WarrantyFinishDate'
    end
    object qryClientHoursTakenForJob: TFloatField
      FieldName = 'HoursTakenForJob'
      Origin = 'tblclients.HoursTakenForJob'
    end
    object qryClientIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      FixedChar = True
      Size = 1
    end
    object qryClientCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblclients.CUSTFLD1'
      Size = 255
    end
    object qryClientCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblclients.CUSTFLD2'
      Size = 255
    end
    object qryClientCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblclients.CUSTFLD3'
      Size = 255
    end
    object qryClientCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblclients.CUSTFLD4'
      Size = 255
    end
    object qryClientCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblclients.CUSTFLD5'
      Size = 255
    end
    object qryClientCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblclients.CUSTFLD6'
      Size = 255
    end
    object qryClientCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblclients.CUSTFLD7'
      Size = 255
    end
    object qryClientCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblclients.CUSTFLD8'
      Size = 255
    end
    object qryClientCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblclients.CUSTFLD9'
      Size = 255
    end
    object qryClientCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblclients.CUSTFLD10'
      Size = 255
    end
    object qryClientCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblclients.CUSTFLD11'
      Size = 255
    end
    object qryClientCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblclients.CUSTFLD12'
      Size = 255
    end
    object qryClientCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblclients.CUSTFLD13'
      Size = 255
    end
    object qryClientCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblclients.CUSTFLD14'
      Size = 255
    end
    object qryClientCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblclients.CUSTFLD15'
      Size = 255
    end
    object qryClientPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
      Origin = 'tblclients.PayMethodID'
    end
    object qryClientFeedback: TWideStringField
      FieldName = 'Feedback'
      Origin = 'tblclients.Feedback'
      FixedChar = True
      Size = 1
    end
    object qryClientCustomer: TWideStringField
      FieldName = 'Customer'
      Origin = 'tblclients.Customer'
      FixedChar = True
      Size = 1
    end
    object qryClientSupplier: TWideStringField
      FieldName = 'Supplier'
      Origin = 'tblclients.Supplier'
      FixedChar = True
      Size = 1
    end
    object qryClientOtherContact: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'tblclients.OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryClientOtherContactType: TIntegerField
      FieldName = 'OtherContactType'
      Origin = 'tblclients.OtherContactType'
    end
    object qryClientRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblclients.RepID'
    end
    object qryClientRepName: TWideStringField
      FieldName = 'RepName'
      Origin = 'tblclients.RepName'
      Size = 255
    end
    object qryClientAction: TDateTimeField
      FieldName = 'Action'
      Origin = 'tblclients.Action'
    end
    object qryClientGlobal: TWideStringField
      FieldName = 'Global'
      Origin = 'tblclients.Global'
      FixedChar = True
      Size = 1
    end
    object qryClientDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblclients.Done'
      FixedChar = True
      Size = 1
    end
    object qryClientDateEntered: TDateField
      FieldName = 'DateEntered'
      Origin = 'tblclients.DateEntered'
    end
    object qryClientActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblclients.Active'
      FixedChar = True
      Size = 1
    end
    object qryClientEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblclients.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryClientCorrespondenceMethod: TWideStringField
      FieldName = 'CorrespondenceMethod'
      Origin = 'tblclients.CorrespondenceMethod'
      Size = 30
    end
    object qryClientDontContact: TWideStringField
      FieldName = 'DontContact'
      Origin = 'tblclients.DontContact'
      FixedChar = True
      Size = 1
    end
    object qryClientCompletionDate: TDateField
      FieldName = 'CompletionDate'
      Origin = 'tblclients.CompletionDate'
    end
    object qryClientParentClientID: TIntegerField
      FieldName = 'ParentClientID'
      Origin = 'tblclients.ParentClientID'
    end
    object qryClientShipTime: TWordField
      FieldName = 'ShipTime'
      Origin = 'tblclients.ShipTime'
    end
    object qryClientGracePeriod: TWordField
      FieldName = 'GracePeriod'
      Origin = 'tblclients.GracePeriod'
    end
    object qryClientLastContactDate: TDateField
      FieldName = 'LastContactDate'
      Origin = 'tblclients.LastContactDate'
    end
    object qryClientLoyaltyValue: TFloatField
      FieldName = 'LoyaltyValue'
      Origin = 'tblclients.LoyaltyValue'
    end
    object qryClientLastSaleDate: TDateField
      FieldName = 'LastSaleDate'
      Origin = 'tblclients.LastSaleDate'
    end
    object qryClientAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Origin = 'tblclients.AccountNo'
      Size = 50
    end
    object qryClientBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'tblclients.BankAccountName'
      Size = 255
    end
    object qryClientBankCode: TWideStringField
      FieldName = 'BankCode'
      Origin = 'tblclients.BankCode'
      FixedChar = True
      Size = 3
    end
    object qryClientBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Origin = 'tblclients.BankAccountBSB'
      Size = 7
    end
    object qryClientBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Origin = 'tblclients.BankAccountNo'
      Size = 10
    end
    object qryClientURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblclients.URL'
      Size = 255
    end
    object qryClientCombinedInvoiceBOID: TWideStringField
      FieldName = 'CombinedInvoiceBOID'
      Origin = 'tblclients.CombinedInvoiceBOID'
      Size = 255
    end
    object qryClientCombinedPurchaseBOID: TWideStringField
      FieldName = 'CombinedPurchaseBOID'
      Origin = 'tblclients.CombinedPurchaseBOID'
      Size = 255
    end
    object qryClientCombinedSaleOrderBOID: TWideStringField
      FieldName = 'CombinedSaleOrderBOID'
      Origin = 'tblclients.CombinedSaleOrderBOID'
      Size = 255
    end
    object qryClientStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblclients.StopCredit'
      FixedChar = True
      Size = 1
    end
    object qryClientRequired: TWideStringField
      FieldName = 'Required'
      Origin = 'tblclients.Required'
      FixedChar = True
      Size = 1
    end
    object qryClientSecurityLevel: TIntegerField
      FieldName = 'SecurityLevel'
      Origin = 'tblclients.SecurityLevel'
    end
    object qryClientForcePOOnBooking: TWideStringField
      FieldName = 'ForcePOOnBooking'
      Origin = 'tblclients.ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object qryClientForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Origin = 'tblclients.ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object qryClientForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      Origin = 'tblclients.ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object qryClientPickingPriority: TIntegerField
      FieldName = 'PickingPriority'
      Origin = 'tblclients.PickingPriority'
    end
    object qryClientCallPriority: TIntegerField
      FieldName = 'CallPriority'
      Origin = 'tblclients.CallPriority'
    end
    object qryClientJobNumber: TIntegerField
      FieldName = 'JobNumber'
      Origin = 'tblclients.JobNumber'
    end
    object qryClientDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
      Origin = 'tblclients.DefaultInvoiceTemplateID'
    end
    object qryClientDefaultDeliveryTemplateID: TIntegerField
      FieldName = 'DefaultDeliveryTemplateID'
      Origin = 'tblclients.DefaultDeliveryTemplateID'
    end
    object qryClientLoyaltyDateSaleDays: TDateField
      FieldName = 'LoyaltyDateSaleDays'
      Origin = 'tblclients.LoyaltyDateSaleDays'
    end
    object qryClientLoyaltyDateAmount: TDateField
      FieldName = 'LoyaltyDateAmount'
      Origin = 'tblclients.LoyaltyDateAmount'
    end
    object qryClientLoyaltyDateAppointDays: TDateField
      FieldName = 'LoyaltyDateAppointDays'
      Origin = 'tblclients.LoyaltyDateAppointDays'
    end
    object qryClientGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      Origin = 'tblclients.GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryClientForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object qryClientCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Origin = 'tblclients.CardNumber'
      Size = 255
    end
    object qryClientDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Origin = 'tblclients.DefaultClass'
      Size = 255
    end
    object qryClientArea: TWideStringField
      FieldName = 'Area'
      Origin = 'tblclients.Area'
    end
    object qryClientDischargeDate: TDateField
      FieldName = 'DischargeDate'
      Origin = 'tblclients.DischargeDate'
    end
    object qryClientJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblclients.JobTitle'
      Size = 255
    end
    object qryClientUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Origin = 'tblclients.UseInvBase'
      FixedChar = True
      Size = 1
    end
    object qryClientInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Origin = 'tblclients.InvBaseNumber'
    end
    object qryClientApprovalFromDate: TDateTimeField
      FieldName = 'ApprovalFromDate'
      Origin = 'tblclients.ApprovalFromDate'
    end
    object qryClientApprovalToDate: TDateTimeField
      FieldName = 'ApprovalToDate'
      Origin = 'tblclients.ApprovalToDate'
    end
    object qryClientTasks: TWideMemoField
      FieldName = 'Tasks'
      Origin = 'tblclients.Tasks'
      BlobType = ftWideMemo
    end
    object qryClientReminderDateTime: TDateTimeField
      FieldName = 'ReminderDateTime'
      Origin = 'tblclients.ReminderDateTime'
    end
    object qryClientSpecialInstructions: TWideMemoField
      FieldName = 'SpecialInstructions'
      Origin = 'tblclients.SpecialInstructions'
      BlobType = ftWideMemo
    end
    object qryClientCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
      Origin = 'tblclients.CUSTDATE1'
    end
    object qryClientCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
      Origin = 'tblclients.CUSTDATE2'
    end
    object qryClientCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
      Origin = 'tblclients.CUSTDATE3'
    end
    object qryClientSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Origin = 'tblclients.SerialNumber'
      Size = 255
    end
    object qryClientModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Origin = 'tblclients.ModelNumber'
      Size = 255
    end
    object qryClientManufacture: TWideStringField
      FieldName = 'Manufacture'
      Origin = 'tblclients.Manufacture'
      Size = 255
    end
    object qryClientParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
      Origin = 'tblclients.ParentRelatedClientID'
    end
    object qryClientDeliveryNotes: TWideMemoField
      FieldName = 'DeliveryNotes'
      Origin = 'tblclients.DeliveryNotes'
      BlobType = ftWideMemo
    end
    object qryClientDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblclients.DefaultContactMethod'
      Size = 255
    end
    object qryClientCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Origin = 'tblclients.CreditCardNumber'
      Size = 255
    end
    object qryClientCreditCardExpiryDate: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Origin = 'tblclients.CreditCardExpiryDate'
      Size = 255
    end
    object qryClientCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Origin = 'tblclients.CreditCardCardHolderName'
      Size = 40
    end
    object qryClientCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Origin = 'tblclients.CreditCardNotes'
      Size = 255
    end
    object qryClientCompanyTypeId: TIntegerField
      FieldName = 'CompanyTypeId'
      Origin = 'tblclients.CompanyTypeId'
    end
    object qryClientCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Origin = 'tblclients.CreditCardType'
      Size = 255
    end
    object qryClientLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblclients.LastUpdated'
    end
    object qryClientmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblclients.msTimeStamp'
    end
    object qryClientWarrantyPeriod: TFloatField
      FieldName = 'WarrantyPeriod'
      Origin = 'tblclients.WarrantyPeriod'
    end
    object qryClientCustomerJobNumber: TWideStringField
      FieldName = 'CustomerJobNumber'
      Origin = 'tblclients.CustomerJobNumber'
    end
    object qryClienthours: TFloatField
      FieldName = 'hours'
      Origin = 'tblclients.hours'
    end
    object qryClientEmailXML: TWideStringField
      FieldName = 'EmailXML'
      Origin = 'tblclients.EmailXML'
      Size = 80
    end
    object qryClientInvoiceComment: TWideMemoField
      FieldName = 'InvoiceComment'
      Origin = 'tblclients.InvoiceComment'
      BlobType = ftWideMemo
    end
    object qryClientPOComment: TWideMemoField
      FieldName = 'POComment'
      Origin = 'tblclients.POComment'
      BlobType = ftWideMemo
    end
    object qryClientInvoiceCommentPopup: TWideStringField
      FieldName = 'InvoiceCommentPopup'
      Origin = 'tblclients.InvoiceCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qryClientPOCommentPopup: TWideStringField
      FieldName = 'POCommentPopup'
      Origin = 'tblclients.POCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qryClientSendXMLInvoices: TWideStringField
      FieldName = 'SendXMLInvoices'
      Origin = 'tblclients.SendXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qryClientDefaultPurchaseOrderTemplateID: TIntegerField
      FieldName = 'DefaultPurchaseOrderTemplateID'
      Origin = 'tblclients.DefaultPurchaseOrderTemplateID'
    end
    object qryClientStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object qryClientBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object qryClientIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      Origin = 'tblclients.IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qryClientShowInShipContainers: TWideStringField
      FieldName = 'ShowInShipContainers'
      Origin = 'tblclients.ShowInShipContainers'
      FixedChar = True
      Size = 1
    end
    object qryClientForcePOOnRepair: TWideStringField
      FieldName = 'ForcePOOnRepair'
      Origin = 'tblclients.ForcePOOnRepair'
      FixedChar = True
      Size = 1
    end
    object qryClientBPAYBillerCode: TWideStringField
      FieldName = 'BPAYBillerCode'
      Origin = 'tblclients.BPAYBillerCode'
      Size = 255
    end
    object qryClientBPAYReference: TWideStringField
      FieldName = 'BPAYReference'
      Origin = 'tblclients.BPAYReference'
      Size = 255
    end
    object qryClientManufactureID: TIntegerField
      FieldName = 'ManufactureID'
      Origin = 'tblclients.ManufactureID'
    end
    object qryClientSpecialProductPriceOverridesAll: TWideStringField
      FieldName = 'SpecialProductPriceOverridesAll'
      Origin = 'tblclients.SpecialProductPriceOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryClientPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Origin = 'tblclients.PortOfLanding'
      Size = 100
    end
    object qryClientPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Origin = 'tblclients.PortOfDischarge'
      Size = 100
    end
    object qryClientFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Origin = 'tblclients.FinalDestination'
      Size = 100
    end
    object qryClientIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Origin = 'tblclients.IncoPlace'
      Size = 100
    end
    object qryClientShippingAgentID: TIntegerField
      FieldName = 'ShippingAgentID'
      Origin = 'tblclients.ShippingAgentID'
    end
    object qryClientDefaultStatementTemplateId: TIntegerField
      FieldName = 'DefaultStatementTemplateId'
      Origin = 'tblclients.DefaultStatementTemplateId'
    end
    object qryClientTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Origin = 'tblclients.TeamviewerID'
      Size = 9
    end
    object qryClientInsuranceCompanyName: TWideStringField
      FieldName = 'InsuranceCompanyName'
      Origin = 'tblclients.InsuranceCompanyName'
      Size = 255
    end
    object qryClientClaimNumber: TWideStringField
      FieldName = 'ClaimNumber'
      Origin = 'tblclients.ClaimNumber'
      Size = 255
    end
    object qryClientStormLocation: TWideStringField
      FieldName = 'StormLocation'
      Origin = 'tblclients.StormLocation'
      Size = 255
    end
    object qryClientStormDate: TDateField
      FieldName = 'StormDate'
      Origin = 'tblclients.StormDate'
    end
    object qryClientYear: TDateField
      FieldName = 'Year'
      Origin = 'tblclients.Year'
    end
    object qryClientColour: TWideStringField
      FieldName = 'Colour'
      Origin = 'tblclients.Colour'
      Size = 255
    end
    object qryClientBodyType: TWideStringField
      FieldName = 'BodyType'
      Origin = 'tblclients.BodyType'
      Size = 255
    end
    object qryClientAssessorsName: TWideStringField
      FieldName = 'AssessorsName'
      Origin = 'tblclients.AssessorsName'
      Size = 255
    end
    object qryClientExcessAmount: TFloatField
      FieldName = 'ExcessAmount'
      Origin = 'tblclients.ExcessAmount'
      currency = True
    end
    object qryClientBailmentNumber: TWideStringField
      FieldName = 'BailmentNumber'
      Size = 255
    end
    object qryClientBailmentAmountEx: TFloatField
      FieldName = 'BailmentAmountEx'
      currency = True
    end
    object qryClientStockReceivedDate: TDateField
      FieldName = 'StockReceivedDate'
    end
    object qryClientNewOrUsed: TWideStringField
      FieldName = 'NewOrUsed'
      Size = 255
    end
  end
  object dsClient: TDataSource
    DataSet = qryClient
    Left = 400
    Top = 448
  end
  object qrySuburb: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country'
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub;')
    Options.LongStrings = False
    Left = 438
    Top = 141
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryInsuranceCompanyLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ClientID, Company from tblClients'
      'where Supplier = "T" and Active = "T"'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by Company')
    Left = 680
    Top = 480
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  object qryModel: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select Id, Name from tblModel where Active = '#39'T'#39' order by `Name`')
    Options.LongStrings = False
    Left = 474
    Top = 493
    object qryModelName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 30
    end
    object qryModelId: TIntegerField
      FieldName = 'Id'
      Visible = False
    end
  end
  object qryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName '
      'FROM tblEmployees WHERE Active = '#39'T'#39
      'Order By EmployeeName;')
    Options.LongStrings = False
    Left = 548
    Top = 493
  end
  object gryClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblClass.ClassID, tblClass.ClassName, ClassPercent, AutoC' +
        'reateSmartOrders'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName')
    Options.LongStrings = False
    Left = 717
    Top = 56
  end
  object qryManufacture: TERPQuery
    SQL.Strings = (
      
        'Select ID, Name from tblManufacture where Active = '#39'T'#39' order by ' +
        '`Name`')
    Options.LongStrings = False
    Left = 611
    Top = 477
    object qryManufactureName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblmanufacture.Name'
      Size = 30
    end
    object qryManufactureID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblmanufacture.ID'
      Visible = False
    end
  end
end
