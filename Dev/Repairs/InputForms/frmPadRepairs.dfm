inherited fmPadRepairs: TfmPadRepairs
  Left = 697
  Top = 196
  HelpContext = 830001
  Caption = 'Service Pad'
  ClientHeight = 565
  ClientWidth = 996
  OnResize = FormResize
  ExplicitLeft = 697
  ExplicitTop = 196
  ExplicitWidth = 1012
  ExplicitHeight = 604
  DesignSize = (
    996
    565)
  PixelsPerInch = 96
  TextHeight = 18
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 996
    HelpContext = 830070
    ExplicitTop = 565
    ExplicitWidth = 998
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
    Width = 996
    Height = 565
    HelpContext = 830002
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 996
    ExplicitHeight = 565
    DesignSize = (
      996
      565)
    object btnSave: TAdvSmoothButton
      Left = 54
      Top = 524
      Width = 120
      Height = 35
      Action = actSave
      Anchors = [akBottom]
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
      TabOrder = 0
      Version = '1.6.9.2'
      HelpContext = 830177
    end
    object btnCancel: TAdvSmoothButton
      Left = 514
      Top = 524
      Width = 120
      Height = 35
      Action = actCancel
      Anchors = [akBottom]
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
      HelpContext = 830178
    end
    object tpMain: TAdvSmoothTabPager
      Left = 0
      Top = 0
      Width = 995
      Height = 512
      HelpContext = 830005
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      ActivePage = tabLabour
      TabSettings.StartMargin = 4
      TabSettings.Height = 40
      TabSettings.Width = 190
      TabReorder = False
      OnChange = tpMainChange
      OnChanging = tpMainChanging
      TabOrder = 6
      ExplicitWidth = 996
      object tabHeader: TAdvSmoothTabPage
        Left = 1
        Top = 40
        Width = 993
        Height = 470
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
        DesignSize = (
          993
          470)
        object Shape2: TShape
          Left = 18
          Top = 58
          Width = 978
          Height = 132
          HelpContext = 830073
          Anchors = [akLeft, akTop, akRight]
          Brush.Style = bsClear
          ExplicitWidth = 968
        end
        object lblCustomer: TLabel
          Left = 18
          Top = 3
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
        object Label4: TLabel
          Left = 25
          Top = 66
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
          Left = 301
          Top = 66
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
          Left = 500
          Top = 66
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
          Left = 659
          Top = 66
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
          Left = 301
          Top = 131
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
          Left = 822
          Top = 131
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
          Visible = False
        end
        object lblEmail: TLabel
          Left = 500
          Top = 131
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
        object lblClass: TLabel
          Left = 17
          Top = 201
          Width = 89
          Height = 19
          HelpContext = 830031
          Caption = 'Department'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label1: TLabel
          Left = 17
          Top = 226
          Width = 368
          Height = 18
          HelpContext = 830074
          AutoSize = False
          Caption = 'Notes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label9: TLabel
          Left = 651
          Top = 3
          Width = 83
          Height = 19
          HelpContext = 830127
          Anchors = [akTop, akRight]
          Caption = 'Equipment'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 641
        end
        object Label10: TLabel
          Left = 891
          Top = 3
          Width = 25
          Height = 19
          HelpContext = 830128
          Anchors = [akTop, akRight]
          Caption = 'ID#'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label27: TLabel
          Left = 413
          Top = 3
          Width = 119
          Height = 19
          HelpContext = 830129
          Anchors = [akTop, akRight]
          Caption = 'Contact Person'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 403
        end
        object Label3: TLabel
          Left = 598
          Top = 225
          Width = 124
          Height = 19
          HelpContext = 830075
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Feedback Notes'
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
          Top = 20
          Width = 393
          Height = 32
          HelpContext = 830032
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'40'#9'Company'#9'F')
          DataField = 'CustomerName'
          DataSource = dsrepairs
          LookupTable = qryCustomerLookup
          LookupField = 'Company'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 0
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnExit = cboCustomerExit
          LookupFormClassName = 'TCustomerExpressListGUI'
          EditFormClassName = 'TfrmCustomer'
          LookupFormKeyStringFieldName = 'Company'
          LookupComboType = ctCustomer
          AllowFullListSearchMode = False
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
          LookupIDField = 'ClientID'
          LookupFieldAlt = 'PrintName'
        end
        object edtStreet1: TwwDBEdit
          Left = 25
          Top = 86
          Width = 273
          Height = 32
          HelpContext = 830035
          DataField = 'ShipAddress'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtStreet2: TwwDBEdit
          Left = 25
          Top = 118
          Width = 273
          Height = 32
          HelpContext = 830036
          DataField = 'ShipAddress1'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtStreet3: TwwDBEdit
          Left = 25
          Top = 150
          Width = 273
          Height = 32
          HelpContext = 830037
          DataField = 'ShipAddress2'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtState: TwwDBEdit
          Left = 500
          Top = 86
          Width = 156
          Height = 32
          HelpContext = 830039
          DataField = 'ShipState'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtPostCode: TwwDBEdit
          Left = 659
          Top = 86
          Width = 121
          Height = 32
          HelpContext = 830040
          DataField = 'ShipPostCode'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtPhone: TwwDBEdit
          Left = 301
          Top = 150
          Width = 196
          Height = 32
          HelpContext = 830041
          DataField = 'Phone'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtMobile: TwwDBEdit
          Left = 822
          Top = 150
          Width = 156
          Height = 32
          HelpContext = 830042
          DataField = 'Mobile'
          DataSource = dsClientcontact
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          UnboundDataType = wwDefault
          Visible = False
          WantReturns = False
          WordWrap = False
        end
        object edtEmail: TwwDBEdit
          Left = 500
          Top = 150
          Width = 318
          Height = 32
          HelpContext = 830043
          DataField = 'email'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnClick = edtEmailClick
        end
        object cboClass: TwwDBLookupCombo
          Left = 115
          Top = 194
          Width = 216
          Height = 32
          HelpContext = 830057
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ClassName'#9'60'#9'ClassName'#9'F')
          DataField = 'DeptClassname'
          DataSource = dsrepairs
          LookupTable = gryClass
          LookupField = 'ClassID'
          ButtonWidth = 30
          ParentFont = False
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object txtNotes: TDBMemo
          Left = 18
          Top = 243
          Width = 573
          Height = 220
          HelpContext = 830076
          Anchors = [akLeft, akTop, akBottom]
          DataField = 'Notes'
          DataSource = dsrepairs
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 12
        end
        object edtcity: TwwDBEdit
          Left = 301
          Top = 86
          Width = 196
          Height = 32
          HelpContext = 830130
          DataField = 'ShipCity'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtEquip: TwwDBEdit
          Left = 651
          Top = 20
          Width = 235
          Height = 32
          HelpContext = 830131
          Anchors = [akTop, akRight]
          DataField = 'EquipName'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit4: TwwDBEdit
          Left = 891
          Top = 20
          Width = 90
          Height = 32
          HelpContext = 830132
          Anchors = [akTop, akRight]
          DataField = 'RepairDocNo'
          DataSource = dsrepairs
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit16: TwwDBEdit
          Left = 413
          Top = 20
          Width = 235
          Height = 32
          HelpContext = 830133
          Anchors = [akTop, akRight]
          DataField = 'ContactName'
          DataSource = dsShippingAddress
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object txtFeedback: TDBMemo
          Left = 596
          Top = 243
          Width = 400
          Height = 220
          HelpContext = 830077
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'FeedbackNotes'
          DataSource = dsrepairs
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 15
          OnEnter = txtFeedbackEnter
          OnExit = txtFeedbackExit
        end
        object btntoggle: TAdvSmoothButton
          Left = 782
          Top = 82
          Width = 197
          Height = 35
          HelpContext = 830067
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
          Caption = 'Show Customer Details'
          Color = clGreen
          TabOrder = 16
          Version = '1.6.9.2'
          OnClick = btntoggleClick
        end
        object btnAttach: TAdvSmoothButton
          Left = 470
          Top = 194
          Width = 120
          Height = 35
          HelpContext = 830134
          Anchors = [akTop, akRight]
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
          Caption = 'Attach'
          Color = clGreen
          Picture.Data = {
            424DF60000000000000076000000280000001000000010000000010004000000
            000080000000120B0000120B0000000000000000000000000000000080000080
            00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
            000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0050000000000000050BBB
            BBBBBBBBBBB00BBBB0000000BBB00BBB077BBB770BB00BBBBBBBBBBBBBB00BBB
            B0000000BBB00BBBB0FFFFF0BBB00BBBB0000000BBB00BBBBBBBBBBBBBB00000
            000000000000500FFFFFFFFFF0055500FFF000000055550F777FFFFFF0555500
            00000FFF005555077777700070555500000000000055}
          TabOrder = 17
          Version = '1.6.9.2'
          OnClick = btnAttachClick
        end
        object AdvSmoothButton3: TAdvSmoothButton
          Left = 344
          Top = 194
          Width = 120
          Height = 35
          HelpContext = 830135
          Anchors = [akTop, akRight]
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
          Caption = 'Take Photo'
          Color = clGreen
          TabOrder = 18
          Version = '1.6.9.2'
          OnClick = AdvSmoothButton3Click
        end
        object btnAddDate: TAdvSmoothButton
          Left = 892
          Top = 206
          Width = 94
          Height = 35
          HelpContext = 830136
          Anchors = [akTop, akRight]
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
          Caption = 'Add Date'
          Color = clGreen
          TabOrder = 19
          Version = '1.6.9.2'
          OnClick = btnAddDateClick
        end
      end
      object tpEquip: TAdvSmoothTabPage
        Left = 1
        Top = 40
        Width = 993
        Height = 470
        HelpContext = 830078
        Caption = 'Equipment Details'
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
          470)
        object Shape1: TShape
          Left = 115
          Top = 399
          Width = 869
          Height = 66
          HelpContext = 830079
          Anchors = [akLeft, akRight, akBottom]
          Brush.Style = bsClear
          ExplicitWidth = 859
        end
        object Label11: TLabel
          Left = 18
          Top = 12
          Width = 83
          Height = 19
          HelpContext = 830137
          Caption = 'Equipment'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label12: TLabel
          Left = 18
          Top = 133
          Width = 312
          Height = 19
          HelpContext = 830080
          AutoSize = False
          Caption = 'Street Map'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label13: TLabel
          Left = 340
          Top = 133
          Width = 312
          Height = 19
          HelpContext = 830081
          AutoSize = False
          Caption = 'Building Map'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label14: TLabel
          Left = 18
          Top = 428
          Width = 68
          Height = 19
          HelpContext = 830138
          Anchors = [akLeft, akBottom]
          Caption = 'Warranty'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label16: TLabel
          Left = 132
          Top = 405
          Width = 148
          Height = 19
          HelpContext = 830139
          Anchors = [akBottom]
          AutoSize = False
          Caption = 'Start Date'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 131
        end
        object Label17: TLabel
          Left = 302
          Top = 405
          Width = 148
          Height = 19
          HelpContext = 830140
          Anchors = [akBottom]
          AutoSize = False
          Caption = 'Period'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 301
        end
        object Label15: TLabel
          Left = 480
          Top = 405
          Width = 148
          Height = 19
          HelpContext = 830141
          Anchors = [akBottom]
          AutoSize = False
          Caption = 'Finish Date'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 471
        end
        object Label18: TLabel
          Left = 650
          Top = 405
          Width = 148
          Height = 19
          HelpContext = 830142
          Anchors = [akBottom]
          AutoSize = False
          Caption = 'Used'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 641
        end
        object Label19: TLabel
          Left = 821
          Top = 405
          Width = 148
          Height = 19
          HelpContext = 830143
          Anchors = [akBottom]
          AutoSize = False
          Caption = 'Left'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 811
        end
        object Label20: TLabel
          Left = 595
          Top = 12
          Width = 37
          Height = 19
          HelpContext = 830144
          Caption = 'UOM'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label21: TLabel
          Left = 836
          Top = 12
          Width = 64
          Height = 19
          HelpContext = 830145
          Caption = 'Quantity'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label22: TLabel
          Left = 18
          Top = 72
          Width = 46
          Height = 19
          HelpContext = 830146
          Caption = 'Model'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label23: TLabel
          Left = 260
          Top = 72
          Width = 95
          Height = 19
          HelpContext = 830147
          Caption = 'Manufacture'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label24: TLabel
          Left = 502
          Top = 72
          Width = 93
          Height = 19
          HelpContext = 830148
          Caption = 'Registration'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label25: TLabel
          Left = 745
          Top = 72
          Width = 56
          Height = 19
          HelpContext = 830149
          Caption = 'Serial #'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label26: TLabel
          Left = 662
          Top = 133
          Width = 322
          Height = 19
          HelpContext = 830150
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Notes'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitWidth = 312
        end
        object Label2: TLabel
          Left = 355
          Top = 12
          Width = 38
          Height = 19
          HelpContext = 830151
          Caption = 'Fault'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object wwDBEdit2: TwwDBEdit
          Left = 18
          Top = 32
          Width = 333
          Height = 32
          HelpContext = 830152
          DataField = 'EquipName'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object DBImage2: TDBImage
          AlignWithMargins = True
          Left = 18
          Top = 151
          Width = 312
          Height = 239
          Hint = 'Double click to Change/Assign Image'
          HelpContext = 830082
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 0
          Anchors = [akLeft, akTop, akBottom]
          DataField = 'StreetMap'
          DataSource = dsRepairEquip
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 7
        end
        object DBImage3: TDBImage
          AlignWithMargins = True
          Left = 340
          Top = 151
          Width = 312
          Height = 239
          HelpContext = 830083
          Margins.Left = 8
          Margins.Top = 0
          Margins.Right = 8
          Margins.Bottom = 8
          Anchors = [akLeft, akTop, akBottom]
          DataField = 'BuildingMap'
          DataSource = dsRepairEquip
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 8
        end
        object wwDBEdit3: TwwDBEdit
          Left = 132
          Top = 426
          Width = 148
          Height = 32
          HelpContext = 830153
          Anchors = [akBottom]
          DataField = 'WarantystartDate'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit6: TwwDBEdit
          Left = 302
          Top = 426
          Width = 148
          Height = 32
          HelpContext = 830154
          Anchors = [akBottom]
          DataField = 'WarantyPeriod'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit5: TwwDBEdit
          Left = 480
          Top = 426
          Width = 148
          Height = 32
          HelpContext = 830155
          Anchors = [akBottom]
          DataField = 'Warantyfinishdate'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit8: TwwDBEdit
          Left = 821
          Top = 426
          Width = 148
          Height = 32
          HelpContext = 830156
          Anchors = [akBottom]
          DataField = 'WarantyPeriodLeft'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit9: TwwDBEdit
          Left = 650
          Top = 426
          Width = 148
          Height = 32
          HelpContext = 830157
          Anchors = [akBottom]
          DataField = 'WarrantyPeriodUsed'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit7: TwwDBEdit
          Left = 595
          Top = 32
          Width = 237
          Height = 32
          HelpContext = 830158
          DataField = 'UOM'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit10: TwwDBEdit
          Left = 836
          Top = 32
          Width = 141
          Height = 32
          HelpContext = 830159
          DataField = 'Quantity'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit11: TwwDBEdit
          Left = 18
          Top = 93
          Width = 232
          Height = 32
          HelpContext = 830160
          DataField = 'model'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit12: TwwDBEdit
          Left = 260
          Top = 93
          Width = 232
          Height = 32
          HelpContext = 830161
          DataField = 'Manufacture'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit13: TwwDBEdit
          Left = 502
          Top = 93
          Width = 232
          Height = 32
          HelpContext = 830162
          DataField = 'Registration'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit14: TwwDBEdit
          Left = 745
          Top = 93
          Width = 232
          Height = 32
          HelpContext = 830163
          DataField = 'Serialno'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit15: TwwDBEdit
          Left = 662
          Top = 151
          Width = 322
          Height = 239
          HelpContext = 830164
          Anchors = [akLeft, akTop, akRight, akBottom]
          AutoSize = False
          DataField = 'EquipNotes'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = True
          OnDblClick = edtEquipDblClick
        end
        object wwDBEdit1: TwwDBEdit
          Left = 355
          Top = 32
          Width = 237
          Height = 32
          HelpContext = 830165
          DataField = 'RepairFault'
          DataSource = dsRepairEquip
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 15
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnDblClick = edtEquipDblClick
        end
      end
      object tpDetails: TAdvSmoothTabPage
        Left = 1
        Top = 40
        Width = 993
        Height = 470
        HelpContext = 830059
        Caption = 'Products'
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
        inline ButtonArray: TfrButtonArray
          Left = 509
          Top = 2
          Width = 482
          Height = 466
          HelpContext = 830062
          Align = alClient
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
          ExplicitLeft = 509
          ExplicitTop = 2
          ExplicitWidth = 483
          ExplicitHeight = 466
        end
        object grdRepairParts: TwwDBGrid
          Left = 2
          Top = 2
          Width = 507
          Height = 466
          HelpContext = 830063
          Selected.Strings = (
            'UOMQty'#9'6'#9'Qty'
            'PartName'#9'10'#9'Product'
            'Description'#9'10'#9'Description'
            'PriceInc'#9'9'#9'Price')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alLeft
          DataSource = dsrepairparts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
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
          OnColEnter = grdRepairPartsColEnter
          OnColExit = grdRepairPartsColExit
          OnDblClick = grdRepairPartsDblClick
          FooterColor = clWhite
          FooterCellColor = clWhite
          object grdRepairPartsIButton: TwwIButton
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
            OnClick = grdRepairPartsIButtonClick
          end
        end
        object keyNumeric: TAdvSmoothTouchKeyBoard
          Left = 489
          Top = 0
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
      object tabLabour: TAdvSmoothTabPage
        Left = 1
        Top = 40
        Width = 993
        Height = 470
        HelpContext = 830084
        Caption = 'Labour'
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
          470)
        object Shape3: TShape
          Left = 515
          Top = 259
          Width = 469
          Height = 190
          HelpContext = 830085
          Anchors = [akLeft, akTop, akRight, akBottom]
          Brush.Style = bsClear
          Pen.Color = clGray
          ExplicitWidth = 465
        end
        object Label5: TLabel
          Left = 534
          Top = 65
          Width = 45
          Height = 19
          HelpContext = 830086
          Caption = 'Date :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label7: TLabel
          Left = 529
          Top = 110
          Width = 50
          Height = 19
          HelpContext = 830087
          Caption = 'From :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label8: TLabel
          Left = 802
          Top = 110
          Width = 29
          Height = 19
          HelpContext = 830088
          Caption = 'To :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 774
          Top = 65
          Width = 57
          Height = 19
          HelpContext = 830166
          Caption = 'Hours :'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblMsg: TLabel
          Left = 2
          Top = 449
          Width = 989
          Height = 19
          HelpContext = 830089
          Align = alBottom
          Alignment = taCenter
          Caption = 'Msg'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
          ExplicitWidth = 32
        end
        object Label28: TLabel
          Left = 764
          Top = 156
          Width = 67
          Height = 19
          HelpContext = 830167
          Caption = 'Service :'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label29: TLabel
          Left = 565
          Top = 416
          Width = 37
          Height = 19
          HelpContext = 830090
          Anchors = [akLeft, akBottom]
          Caption = 'Time'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label30: TLabel
          Left = 528
          Top = 265
          Width = 74
          Height = 19
          HelpContext = 830091
          Caption = 'Signature'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label31: TLabel
          Left = 558
          Top = 380
          Width = 44
          Height = 19
          HelpContext = 830168
          Anchors = [akLeft, akBottom]
          Caption = 'Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label35: TLabel
          Left = 520
          Top = 156
          Width = 59
          Height = 19
          HelpContext = 830092
          Caption = 'Status :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object dtServicedate: TwwDBDateTimePicker
          Left = 586
          Top = 58
          Width = 151
          Height = 32
          HelpContext = 830093
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'ServiceDate'
          DataSource = DSTimesheet
          Epoch = 1950
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 1
          OnEnter = LocateThisLabourRec
        end
        object txtStartTime: TComboBox
          Left = 586
          Top = 103
          Width = 151
          Height = 32
          HelpContext = 830094
          AutoDropDown = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnChange = dttimefromChange
          OnEnter = LocateThisLabourRec
          Items.Strings = (
            '00:00 AM'
            '00:30 AM'
            '01:00 AM'
            '01:30 AM'
            '02:00 AM'
            '02:30 AM'
            '03:00 AM'
            '03:30 AM'
            '04:00 AM'
            '04:30 AM'
            '05:00 AM'
            '05:30 AM'
            '06:00 AM'
            '06:30 AM'
            '07:00 AM'
            '07:30 AM'
            '08:00 AM'
            '08:30 AM'
            '09:00 AM'
            '09:30 AM'
            '10:00 AM'
            '10:30 AM'
            '11:00 AM'
            '11:30 AM'
            '12:00 PM'
            '12:30 PM'
            '01:00 PM'
            '01:30 PM'
            '02:00 PM'
            '02:30 PM'
            '03:00 PM'
            '03:30 PM'
            '04:00 PM'
            '04:30 PM'
            '05:00 PM'
            '05:30 PM'
            '06:00 PM'
            '06:30 PM'
            '07:00 PM'
            '07:30 PM'
            '08:00 PM'
            '08:30 PM'
            '09:00 PM'
            '09:30 PM'
            '10:00 PM'
            '10:30 PM'
            '11:00 PM'
            '11:30 PM'
            '12:00 AM'
            '12:30 AM')
        end
        object txtEndtime: TComboBox
          Left = 836
          Top = 103
          Width = 150
          Height = 32
          HelpContext = 830095
          AutoDropDown = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnChange = dttimefromChange
          OnEnter = LocateThisLabourRec
          Items.Strings = (
            '00:00 AM'
            '00:30 AM'
            '01:00 AM'
            '01:30 AM'
            '02:00 AM'
            '02:30 AM'
            '03:00 AM'
            '03:30 AM'
            '04:00 AM'
            '04:30 AM'
            '05:00 AM'
            '05:30 AM'
            '06:00 AM'
            '06:30 AM'
            '07:00 AM'
            '07:30 AM'
            '08:00 AM'
            '08:30 AM'
            '09:00 AM'
            '09:30 AM'
            '10:00 AM'
            '10:30 AM'
            '11:00 AM'
            '11:30 AM'
            '12:00 PM'
            '12:30 PM'
            '01:00 PM'
            '01:30 PM'
            '02:00 PM'
            '02:30 PM'
            '03:00 PM'
            '03:30 PM'
            '04:00 PM'
            '04:30 PM'
            '05:00 PM'
            '05:30 PM'
            '06:00 PM'
            '06:30 PM'
            '07:00 PM'
            '07:30 PM'
            '08:00 PM'
            '08:30 PM'
            '09:00 PM'
            '09:30 PM'
            '10:00 PM'
            '10:30 PM'
            '11:00 PM'
            '11:30 PM'
            '12:00 AM'
            '12:30 AM')
        end
        object edtHours: TwwDBEdit
          Left = 836
          Top = 58
          Width = 105
          Height = 32
          HelpContext = 830169
          DataField = 'Qty'
          DataSource = DSTimesheet
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnEnter = LocateThisLabourRec
        end
        object grdTimesheet: TwwDBGrid
          Left = 2
          Top = 2
          Width = 510
          Height = 447
          HelpContext = 830170
          Selected.Strings = (
            'EmployeeName'#9'10'#9'Name'#9#9
            'ServiceName'#9'10'#9'Service Name'#9#9
            'ServiceDate'#9'11'#9'Service Date'#9#9
            'Qty'#9'6'#9'Hours'#9#9
            'SignatureMemo'#9'1'#9'Signature'#9'F'
            'SignatureTime'#9'18'#9'SignatureTime'#9'F'#9
            'ContactName'#9'10'#9'ContactName'#9'F'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          OnRowChanged = grdTimesheetRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alLeft
          DataSource = DSTimesheet
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnCalcCellColors = grdTimesheetCalcCellColors
          OnColEnter = grdRepairPartsColEnter
          OnColExit = grdRepairPartsColExit
          OnDblClick = grdRepairPartsDblClick
          FooterColor = clWhite
          FooterCellColor = clWhite
          object ibtimesheet: TwwIButton
            Left = 0
            Top = 0
            Width = 27
            Height = 22
            HelpContext = 830171
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
            OnClick = ibtimesheetClick
          end
        end
        object btnGo: TAdvSmoothToggleButton
          Left = 610
          Top = 14
          Width = 120
          Height = 35
          HelpContext = 830096
          Color = clGreen
          ColorDown = clRed
          BorderColor = clBtnFace
          BorderInnerColor = clWhite
          BevelWidth = 0
          BevelColorDisabled = clWhite
          Caption = 'Start'
          Version = '1.1.8.1'
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
          TabOrder = 5
          OnClick = btnGoClick
          OnEnter = LocateThisLabourRec
        end
        object edttime: TEdit
          Left = 759
          Top = 15
          Width = 91
          Height = 32
          HelpContext = 830172
          Alignment = taCenter
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          Text = '00:00:00'
          Visible = False
        end
        object optRepairStatus: TRadioGroup
          Left = 515
          Top = 188
          Width = 469
          Height = 67
          HelpContext = 830097
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Repair Status'
          Columns = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemIndex = 0
          Items.Strings = (
            'None'
            'Hold Repair'
            'Done')
          ParentFont = False
          TabOrder = 7
          OnClick = optRepairStatusClick
        end
        object cboServices: TwwDBLookupCombo
          Left = 836
          Top = 149
          Width = 150
          Height = 32
          HelpContext = 830098
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'ServiceName'#9'30'#9'ServiceName'#9'F')
          DataField = 'ServiceName'
          DataSource = DSTimesheet
          LookupTable = qryServices
          LookupField = 'ServiceName'
          Style = csDropDownList
          ParentFont = False
          TabOrder = 8
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object pnlsignature: TDNMPanel
          Left = 608
          Top = 267
          Width = 367
          Height = 103
          HelpContext = 830099
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelInner = bvRaised
          BevelKind = bkFlat
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 9
          OnExit = pnlsignatureExit
          Transparent = False
        end
        object wwDBEdit17: TwwDBEdit
          Left = 608
          Top = 409
          Width = 97
          Height = 32
          HelpContext = 830173
          Anchors = [akLeft, akRight, akBottom]
          DataField = 'SignatureTime'
          DataSource = DSTimesheet
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnEnter = LocateThisLabourRec
        end
        object wwDBLookupCombo1: TwwDBLookupCombo
          Left = 608
          Top = 373
          Width = 367
          Height = 32
          HelpContext = 830100
          Anchors = [akLeft, akRight, akBottom]
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'contactName'#9'30'#9'contactName'#9'F')
          DataField = 'ContactName'
          DataSource = DSTimesheet
          LookupTable = qryContacts
          LookupField = 'contactName'
          ParentFont = False
          TabOrder = 11
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
          OnNotInList = wwDBLookupCombo1NotInList
        end
        object btnEmail: TAdvSmoothButton
          Left = 855
          Top = 408
          Width = 120
          Height = 35
          HelpContext = 830069
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
          Caption = 'Email'
          Color = clGreen
          TabOrder = 12
          Version = '1.6.9.2'
          OnClick = btnEmailClick
        end
        object cboStatus: TwwDBLookupCombo
          Left = 585
          Top = 150
          Width = 151
          Height = 32
          HelpContext = 830101
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'Status'
          DataSource = dsrepairs
          LookupTable = qryStatus
          LookupField = 'Name'
          ParentFont = False
          TabOrder = 13
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = cboStatusDblClick
          OnCloseUp = cboStatusCloseUp
          OnNotInList = cboStatusNotInList
        end
        object btnPreview: TAdvSmoothButton
          Left = 725
          Top = 408
          Width = 120
          Height = 35
          HelpContext = 830174
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
          Caption = 'Preview'
          Color = clGreen
          TabOrder = 14
          Version = '1.6.9.2'
          OnClick = btnPreviewClick
        end
      end
      object AdvSmoothTabPage1: TAdvSmoothTabPage
        Left = 1
        Top = 40
        Width = 993
        Height = 470
        HelpContext = 830102
        Caption = 'Extra Info'
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
        object DNMPanel3: TDNMPanel
          Left = 2
          Top = 2
          Width = 989
          Height = 466
          HelpContext = 830103
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          Transparent = False
          ExplicitWidth = 990
          object Label33: TLabel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 981
            Height = 18
            HelpContext = 830104
            Align = alTop
            AutoSize = False
            Caption = 'Followups'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitLeft = -1
            ExplicitWidth = 982
          end
          object DNMPanel1: TDNMPanel
            Left = 1
            Top = 25
            Width = 987
            Height = 209
            HelpContext = 830105
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Transparent = False
            ExplicitWidth = 988
            object grdOtherFollowUp: TwwDBGrid
              Left = 1
              Top = 1
              Width = 985
              Height = 207
              HelpContext = 830106
              ControlType.Strings = (
                'EquipmentName;CustomEdit;cboEquipment;F'
                'FollowUpDate;CustomEdit;dtpFollowUpDate;F'
                'EmployeeName;CustomEdit;cboEmployeeOthersFollowUp;F'
                'Done;CheckBox;T;F')
              Selected.Strings = (
                'FollowUpDate'#9'15'#9'Follow Up Date'#9'F'#9
                'Notes'#9'20'#9'Notes'#9'F'#9
                'EmployeeName'#9'16'#9'Employee Name'#9'F'#9
                'Done'#9'1'#9'Done'#9'F'#9)
              MemoAttributes = [mSizeable, mWordWrap, mGridShow]
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alClient
              DataSource = dsOtherFollowUp
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -16
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              OnExit = grdOtherFollowUpExit
              PaintOptions.AlternatingRowRegions = [arrActiveDataColumn]
              PaintOptions.BackgroundOptions = [coBlendFixedRow]
              ExplicitWidth = 986
              object btnDeleteOtherFollowUp: TwwIButton
                Left = 0
                Top = 0
                Width = 23
                Height = 23
                HelpContext = 830107
                AllowAllUp = True
                Glyph.Data = {
                  DE010000424DDE01000000000000760000002800000024000000120000000100
                  0400000000006801000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                  333333333333333333333333000033338833333333333333333F333333333333
                  0000333911833333983333333388F333333F3333000033391118333911833333
                  38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
                  911118111118333338F3338F833338F3000033333911111111833333338F3338
                  3333F8330000333333911111183333333338F333333F83330000333333311111
                  8333333333338F3333383333000033333339111183333333333338F333833333
                  00003333339111118333333333333833338F3333000033333911181118333333
                  33338333338F333300003333911183911183333333383338F338F33300003333
                  9118333911183333338F33838F338F33000033333913333391113333338FF833
                  38F338F300003333333333333919333333388333338FFF830000333333333333
                  3333333333333333333888330000333333333333333333333333333333333333
                  0000}
                NumGlyphs = 2
              end
            end
            object dtpFollowUpDate: TwwDBDateTimePicker
              Left = 25
              Top = 27
              Width = 112
              Height = 23
              HelpContext = 830108
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'MS Sans Serif'
              CalendarAttributes.Font.Style = []
              DataField = 'FollowUpDate'
              Epoch = 1950
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ShowButton = True
              TabOrder = 1
            end
            object cboEmployeeOthersFollowUp: TwwDBLookupCombo
              Left = 248
              Top = 44
              Width = 119
              Height = 23
              HelpContext = 830109
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'EmployeeName'#9'20'#9'EmployeeName'#9'F')
              DataField = 'EmployeeName'
              DataSource = dsOtherFollowUp
              LookupTable = qryEmployees
              LookupField = 'EmployeeName'
              ParentFont = False
              TabOrder = 2
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
          end
          object DNMPanel2: TDNMPanel
            Left = 1
            Top = 234
            Width = 303
            Height = 231
            HelpContext = 830110
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            TabOrder = 1
            Transparent = False
            object Label32: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 295
              Height = 18
              HelpContext = 830111
              Align = alTop
              AutoSize = False
              Caption = 'Repair Faults'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
              ExplicitLeft = 0
              ExplicitTop = 3
              ExplicitWidth = 987
            end
            object grdParts: TwwDBGrid
              Left = 1
              Top = 25
              Width = 301
              Height = 205
              HelpContext = 830112
              ControlType.Strings = (
                'PartName;CustomEdit;cboProductR;F'
                'Discount;CustomEdit;edDiscountMarkup;F'
                'TaxCode;CustomEdit;cboTax;F'
                'ClassName;CustomEdit;cboClassRepairParts;F'
                'ConvertToInvoice;CheckBox;True;False'
                'ETADate;CustomEdit;edtETADate;F'
                'Equipment;CustomEdit;cboEquipname;F'
                'UnitofMeasure;CustomEdit;cboUnitOfMeasure;F'
                'Deleted;CheckBox;T;F'
                'MemoLine;CustomEdit;edtMemoLine;F'
                'Done;CheckBox;T;F'
                'RepairFault;CustomEdit;cboRepairFault;F')
              Selected.Strings = (
                'RepairFault'#9'30'#9'Repair Fault'
                'Done'#9'1'#9'Done?')
              MemoAttributes = [mSizeable, mWordWrap, mGridShow]
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              Align = alClient
              DataSource = dsrepairsFaults
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgRowResize]
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 2
              TitleButtons = True
              FooterColor = clWindow
              FooterCellColor = clWhite
              PaintOptions.AlternatingRowRegions = [arrFixedColumns, arrDataColumns]
              PaintOptions.BackgroundOptions = [coBlendFixedRow]
              object btnDeleteParts: TwwIButton
                Left = 0
                Top = 0
                Width = 23
                Height = 34
                Hint = 'Delete Current Part Line'
                HelpContext = 830113
                AllowAllUp = True
                Glyph.Data = {
                  DE010000424DDE01000000000000760000002800000024000000120000000100
                  0400000000006801000000000000000000001000000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                  333333333333333333333333000033338833333333333333333F333333333333
                  0000333911833333983333333388F333333F3333000033391118333911833333
                  38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
                  911118111118333338F3338F833338F3000033333911111111833333338F3338
                  3333F8330000333333911111183333333338F333333F83330000333333311111
                  8333333333338F3333383333000033333339111183333333333338F333833333
                  00003333339111118333333333333833338F3333000033333911181118333333
                  33338333338F333300003333911183911183333333383338F338F33300003333
                  9118333911183333338F33838F338F33000033333913333391113333338FF833
                  38F338F300003333333333333919333333388333338FFF830000333333333333
                  3333333333333333333888330000333333333333333333333333333333333333
                  0000}
                NumGlyphs = 2
                ParentShowHint = False
                ShowHint = True
                OnClick = btnDeletePartsClick
              end
            end
            object cboRepairFault: TwwDBLookupCombo
              Left = 81
              Top = 102
              Width = 121
              Height = 23
              HelpContext = 830114
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Name'#9'10'#9'Name'#9'F')
              DataField = 'RepairFault'
              DataSource = dsrepairsFaults
              LookupTable = QryrepairFaults
              LookupField = 'NAme'
              TabOrder = 1
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnDblClick = cboRepairFaultDblClick
              OnNotInList = cboRepairFaultNotInList
            end
          end
          object DNMPanel4: TDNMPanel
            Left = 304
            Top = 234
            Width = 684
            Height = 231
            HelpContext = 830115
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            ExplicitWidth = 685
            DesignSize = (
              684
              231)
            object Label34: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 676
              Height = 18
              HelpContext = 830116
              Align = alTop
              AutoSize = False
              Caption = 'Documents'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
              ExplicitLeft = 0
              ExplicitTop = 3
              ExplicitWidth = 987
            end
            object grdDocs: TwwDBGrid
              AlignWithMargins = True
              Left = 4
              Top = 25
              Width = 587
              Height = 202
              HelpContext = 830117
              ControlType.Strings = (
                'active;CheckBox;T;F')
              Selected.Strings = (
                'Date'#9'10'#9'Date'#9#9
                'CustomerName'#9'16'#9'Customer'#9'F'
                'ContactName'#9'16'#9'Contact'#9'F'
                'Type'#9'10'#9'Type'#9#9
                'Reference'#9'22'#9'Reference'#9'F'
                'MessageFrom'#9'15'#9'From'#9'F'
                'MessageTo'#9'15'#9'To'#9'F'
                'active'#9'1'#9'Active'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clWhite
              DataSource = DSDocuments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              UseTFields = False
              FooterColor = clWhite
              FooterCellColor = clWhite
              object grdDocsIButton: TwwIButton
                Left = 0
                Top = 0
                Width = 18
                Height = 22
                HelpContext = 830118
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
              end
            end
            object LetterBtn: TDNMSpeedButton
              Left = 598
              Top = 63
              Width = 82
              Height = 27
              HelpContext = 830119
              Anchors = [akTop, akRight]
              Caption = '&Letter'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4210688
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentFont = False
              TabOrder = 1
              OnClick = LetterBtnClick
            end
            object EmailBtn: TDNMSpeedButton
              Left = 598
              Top = 96
              Width = 82
              Height = 27
              HelpContext = 830120
              Anchors = [akTop, akRight]
              Caption = 'E-Mail'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4210688
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentFont = False
              TabOrder = 2
              OnClick = EmailBtnClick
            end
          end
        end
      end
    end
    object AdvSmoothButton1: TAdvSmoothButton
      Left = 207
      Top = 524
      Width = 120
      Height = 35
      Action = actNext
      Anchors = [akBottom]
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
      HelpContext = 830179
    end
    object btnCustomise: TAdvSmoothButton
      Left = 668
      Top = 524
      Width = 120
      Height = 35
      Action = actKeypadHome
      Anchors = [akBottom]
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
      TabOrder = 3
      Version = '1.6.9.2'
      HelpContext = 830180
    end
    object btnHome: TAdvSmoothButton
      Left = 822
      Top = 524
      Width = 120
      Height = 35
      Action = actCustomiseKeypad
      Anchors = [akBottom]
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
      HelpContext = 830181
    end
    object AdvSmoothButton2: TAdvSmoothButton
      Left = 361
      Top = 524
      Width = 120
      Height = 35
      Action = actInvoice
      Anchors = [akBottom]
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
      TabOrder = 7
      Version = '1.6.9.2'
      HelpContext = 830182
    end
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200D000E00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 85
    Top = 216
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
      HelpContext = 830175
      OnExecute = actCustomiseKeypadExecute
    end
    object actKeypadHome: TAction
      Caption = 'Home'
      HelpContext = 830068
      OnExecute = actKeypadHomeExecute
    end
    object actNext: TAction
      Caption = 'Next'
      HelpContext = 830176
      OnExecute = actNextExecute
    end
    object actInvoice: TDNMAction
      Caption = 'Make Invocie'
      HelpContext = 830125
      OnExecute = actInvoiceExecute
      buttoncolor = clWhite
    end
    object DNMAction1: TDNMAction
      Category = 'DNMAction'
      Caption = 'DNMAction1'
      HelpContext = 830126
      buttoncolor = clWhite
    end
  end
  object Qryrepairs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblrepairs where RepairID =  :ID')
    AfterOpen = QryrepairsAfterOpen
    Left = 85
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object QryrepairsRepairID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RepairID'
      Origin = 'tblrepairs.RepairID'
    end
    object QryrepairsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblrepairs.GlobalRef'
      Size = 255
    end
    object QryrepairsRepairDocNo: TWideStringField
      FieldName = 'RepairDocNo'
      Origin = 'tblrepairs.RepairDocNo'
      Size = 50
    end
    object QryrepairsCusID: TIntegerField
      FieldName = 'CusID'
      Origin = 'tblrepairs.CusID'
    end
    object QryrepairsCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblrepairs.CreationDate'
    end
    object QryrepairsNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblrepairs.Notes'
      BlobType = ftWideMemo
    end
    object QryrepairsFeedbackNotes: TWideMemoField
      FieldName = 'FeedbackNotes'
      Origin = 'tblrepairs.FeedbackNotes'
      BlobType = ftWideMemo
    end
    object QryrepairsClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblrepairs.ClassID'
    end
    object QryrepairsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblrepairs.EmployeeID'
    end
    object QryrepairsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblrepairs.msTimeStamp'
    end
    object QryrepairsCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tblrepairs.CustomerName'
      Size = 255
    end
    object QryrepairsDeptClassname: TStringField
      FieldKind = fkLookup
      FieldName = 'DeptClassname'
      LookupDataSet = gryClass
      LookupKeyFields = 'ClassID'
      LookupResultField = 'ClassName'
      KeyFields = 'ClassID'
      Size = 100
      Lookup = True
    end
    object QryrepairsCancelled: TWideStringField
      FieldName = 'Cancelled'
      Origin = 'tblrepairs.Cancelled'
      FixedChar = True
      Size = 1
    end
    object QryrepairsUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Origin = 'tblrepairs.UpdateDate'
    end
    object QryrepairsDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblrepairs.Done'
      FixedChar = True
      Size = 1
    end
    object QryrepairsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblrepairs.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QryrepairsCustomerDetails: TWideStringField
      FieldName = 'CustomerDetails'
      Origin = 'tblrepairs.CustomerDetails'
      Size = 255
    end
    object QryrepairsPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblrepairs.Phone'
      Size = 30
    end
    object QryrepairsAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblrepairs.AltPhone'
      Size = 30
    end
    object QryrepairsFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'tblrepairs.Fax'
      Size = 30
    end
    object QryrepairsJobDueDate: TDateTimeField
      FieldName = 'JobDueDate'
      Origin = 'tblrepairs.JobDueDate'
    end
    object QryrepairsConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblrepairs.Converted'
      FixedChar = True
      Size = 1
    end
    object QryrepairsStatus: TWideStringField
      FieldName = 'Status'
      Origin = 'tblrepairs.Status'
      Size = 100
    end
    object QryrepairsBillToCustomerDetails: TWideStringField
      FieldName = 'BillToCustomerDetails'
      Origin = 'tblrepairs.BillToCustomerDetails'
      Size = 255
    end
    object QryrepairsBillCusID: TIntegerField
      FieldName = 'BillCusID'
      Origin = 'tblrepairs.BillCusID'
    end
    object QryrepairsUseBillCust: TWideStringField
      FieldName = 'UseBillCust'
      Origin = 'tblrepairs.UseBillCust'
      FixedChar = True
      Size = 1
    end
    object QryrepairsBillPhone: TWideStringField
      FieldName = 'BillPhone'
      Origin = 'tblrepairs.BillPhone'
      Size = 30
    end
    object QryrepairsBillAltPhone: TWideStringField
      FieldName = 'BillAltPhone'
      Origin = 'tblrepairs.BillAltPhone'
      Size = 30
    end
    object QryrepairsBillFax: TWideStringField
      FieldName = 'BillFax'
      Origin = 'tblrepairs.BillFax'
      Size = 30
    end
    object QryrepairsSOGlobalRef: TWideStringField
      FieldName = 'SOGlobalRef'
      Origin = 'tblrepairs.SOGlobalRef'
      Size = 255
    end
    object QryrepairsQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Origin = 'tblrepairs.QuoteGlobalRef'
      Size = 255
    end
    object QryrepairsCustomerPONumber: TWideStringField
      FieldName = 'CustomerPONumber'
      Origin = 'tblrepairs.CustomerPONumber'
      Size = 255
    end
    object QryrepairsCompletionTime: TWideStringField
      FieldName = 'CompletionTime'
      Origin = 'tblrepairs.CompletionTime'
      Size = 255
    end
    object QryrepairsShipping: TWideStringField
      FieldName = 'Shipping'
      Origin = 'tblrepairs.Shipping'
      Size = 255
    end
    object QryrepairsAllocatedEmployeeID: TIntegerField
      FieldName = 'AllocatedEmployeeID'
      Origin = 'tblrepairs.AllocatedEmployeeID'
    end
    object QryrepairsTermsId: TLargeintField
      FieldName = 'TermsId'
      Origin = 'tblrepairs.TermsId'
    end
    object QryrepairsTerms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblrepairs.Terms'
      Size = 50
    end
    object QryrepairsMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblrepairs.Mobile'
      Size = 50
    end
    object QryrepairsBillMobile: TWideStringField
      FieldName = 'BillMobile'
      Origin = 'tblrepairs.BillMobile'
      Size = 50
    end
    object QryrepairsContactID: TLargeintField
      FieldName = 'ContactID'
      Origin = 'tblrepairs.ContactID'
    end
    object QryrepairsQuotedAmount: TFloatField
      FieldName = 'QuotedAmount'
      Origin = 'tblrepairs.QuotedAmount'
    end
    object QryrepairsQuotedAmountinc: TFloatField
      FieldName = 'QuotedAmountinc'
      Origin = 'tblrepairs.QuotedAmountinc'
    end
    object QryrepairsHoldRepair: TWideStringField
      FieldName = 'HoldRepair'
      Origin = 'tblrepairs.HoldRepair'
      FixedChar = True
      Size = 1
    end
    object QryrepairsCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblrepairs.CUSTFLD1'
      Size = 255
    end
    object QryrepairsCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblrepairs.CUSTFLD2'
      Size = 255
    end
    object QryrepairsCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblrepairs.CUSTFLD3'
      Size = 255
    end
    object QryrepairsCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblrepairs.CUSTFLD4'
      Size = 255
    end
    object QryrepairsCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblrepairs.CUSTFLD5'
      Size = 255
    end
    object QryrepairsCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblrepairs.CUSTFLD6'
      Size = 255
    end
    object QryrepairsCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblrepairs.CUSTFLD7'
      Size = 255
    end
    object QryrepairsCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblrepairs.CUSTFLD8'
      Size = 255
    end
    object QryrepairsCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblrepairs.CUSTFLD9'
      Size = 255
    end
    object QryrepairsCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblrepairs.CUSTFLD10'
      Size = 255
    end
    object QryrepairsCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblrepairs.CUSTFLD11'
      Size = 255
    end
    object QryrepairsCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblrepairs.CUSTFLD12'
      Size = 255
    end
    object QryrepairsCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblrepairs.CUSTFLD13'
      Size = 255
    end
    object QryrepairsCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblrepairs.CUSTFLD14'
      Size = 255
    end
    object QryrepairsCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblrepairs.CUSTFLD15'
      Size = 255
    end
    object QryrepairsCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
      Origin = 'tblrepairs.CUSTDATE1'
    end
    object QryrepairsCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
      Origin = 'tblrepairs.CUSTDATE2'
    end
    object QryrepairsCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
      Origin = 'tblrepairs.CUSTDATE3'
    end
    object QryrepairsDetailsExported: TWideStringField
      FieldName = 'DetailsExported'
      Origin = 'tblrepairs.DetailsExported'
      FixedChar = True
      Size = 1
    end
    object QryrepairsBillCustomerName: TWideStringField
      FieldName = 'BillCustomerName'
      Origin = 'tblrepairs.BillCustomerName'
      Size = 255
    end
    object QryrepairsBilltotalPrice: TFloatField
      FieldName = 'BilltotalPrice'
      Origin = 'tblrepairs.BilltotalPrice'
    end
    object QryrepairsShipToID: TIntegerField
      FieldName = 'ShipToID'
      Origin = 'tblrepairs.ShipToID'
    end
    object QryrepairsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblrepairs.msUpdateSiteCode'
      Size = 3
    end
  end
  object qryrepairparts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblrepairparts where RepairID = :ID')
    Filtered = True
    Filter = 'Deleted = "F"'
    Left = 122
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryrepairpartsUOMQty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 6
      FieldName = 'UOMQty'
      Origin = 'tblrepairparts.UOMQty'
    end
    object qryrepairpartsPartName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 10
      FieldName = 'PartName'
      Origin = 'tblrepairparts.PartName'
      Size = 255
    end
    object qryrepairpartsDescription: TWideStringField
      DisplayWidth = 10
      FieldName = 'Description'
      Origin = 'tblrepairparts.Description'
      Size = 255
    end
    object qryrepairpartsPriceInc: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 9
      FieldName = 'PriceInc'
      Origin = 'tblrepairparts.PriceInc'
    end
    object qryrepairpartsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblrepairparts.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryrepairpartsRepairPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RepairPartsID'
      Origin = 'tblrepairparts.RepairPartsID'
      Visible = False
    end
    object qryrepairpartsRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Origin = 'tblrepairparts.RepairID'
      Visible = False
    end
    object qryrepairpartsPartsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsID'
      Origin = 'tblrepairparts.PartsID'
      Visible = False
    end
    object qryrepairpartsQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblrepairparts.Qty'
      Visible = False
    end
    object qryrepairpartsPriceEx: TFloatField
      DisplayWidth = 10
      FieldName = 'PriceEx'
      Origin = 'tblrepairparts.PriceEx'
      Visible = False
    end
    object qryrepairpartsClassName: TWideStringField
      DisplayWidth = 255
      FieldName = 'ClassName'
      Origin = 'tblrepairparts.ClassName'
      Visible = False
      Size = 255
    end
    object qryrepairpartsClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tblrepairparts.ClassID'
      Visible = False
    end
    object qryrepairpartsPartType: TWideStringField
      DisplayWidth = 255
      FieldName = 'PartType'
      Origin = 'tblrepairparts.PartType'
      Visible = False
      Size = 255
    end
    object qryrepairpartsUnitofMeasure: TWideStringField
      DisplayWidth = 50
      FieldName = 'UnitofMeasure'
      Origin = 'tblrepairparts.UnitofMeasure'
      Visible = False
      Size = 50
    end
    object qryrepairpartsUnitofMeasureID: TLargeintField
      DisplayWidth = 15
      FieldName = 'UnitofMeasureID'
      Origin = 'tblrepairparts.UnitofMeasureID'
      Visible = False
    end
    object qryrepairpartsUnitofMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureMultiplier'
      Origin = 'tblrepairparts.UnitofMeasureMultiplier'
      Visible = False
    end
    object qryrepairpartsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblrepairparts.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryrepairpartsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblrepairparts.msTimeStamp'
      Visible = False
    end
    object qryrepairpartsDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblrepairparts.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryrepairpartsCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
      Origin = 'tblrepairparts.CustomerEquipmentID'
      Visible = False
    end
    object qryrepairpartsTaxCode: TWideStringField
      FieldName = 'TaxCode'
      Origin = 'tblrepairparts.TaxCode'
      Visible = False
      Size = 15
    end
    object qryrepairpartsTaxRate: TFloatField
      FieldName = 'TaxRate'
      Origin = 'tblrepairparts.TaxRate'
      Visible = False
    end
    object qryrepairpartsDiscount: TFloatField
      FieldName = 'Discount'
      Origin = 'tblrepairparts.Discount'
      Visible = False
    end
    object qryrepairpartsMarkup: TFloatField
      FieldName = 'Markup'
      Origin = 'tblrepairparts.Markup'
      Visible = False
    end
    object qryrepairpartsDiscountPercent: TFloatField
      FieldName = 'DiscountPercent'
      Origin = 'tblrepairparts.DiscountPercent'
      Visible = False
    end
    object qryrepairpartsMarkupPercent: TFloatField
      FieldName = 'MarkupPercent'
      Origin = 'tblrepairparts.MarkupPercent'
      Visible = False
    end
    object qryrepairpartsLineTotalEx: TFloatField
      FieldName = 'LineTotalEx'
      Origin = 'tblrepairparts.LineTotalEx'
      Visible = False
    end
    object qryrepairpartsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblrepairparts.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryrepairpartsConvertToInvoice: TWideStringField
      FieldName = 'ConvertToInvoice'
      Origin = 'tblrepairparts.ConvertToInvoice'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryrepairpartsETADate: TDateField
      FieldName = 'ETADate'
      Origin = 'tblrepairparts.ETADate'
      Visible = False
    end
    object qryrepairpartsPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
      Origin = 'tblrepairparts.PurchaseOrderID'
      Visible = False
    end
    object qryrepairpartsMemoLine: TWideMemoField
      FieldName = 'MemoLine'
      Origin = 'tblrepairparts.MemoLine'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryrepairpartsInvoiceLineRef: TWideStringField
      FieldName = 'InvoiceLineRef'
      Origin = 'tblrepairparts.InvoiceLineRef'
      Visible = False
      Size = 255
    end
    object qryrepairpartsEquipment: TWideStringField
      FieldName = 'Equipment'
      Origin = 'tblrepairparts.Equipment'
      Visible = False
      Size = 100
    end
    object qryrepairpartsPartIssuedOn: TDateTimeField
      FieldName = 'PartIssuedOn'
      Origin = 'tblrepairparts.PartIssuedOn'
      Visible = False
    end
    object qryrepairpartsSerialNos: TWideMemoField
      FieldName = 'SerialNos'
      Origin = 'tblrepairparts.SerialNos'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryrepairpartsLinecost: TFloatField
      FieldName = 'Linecost'
      Origin = 'tblrepairparts.Linecost'
      Visible = False
    end
    object qryrepairpartsParentProductID: TLargeintField
      FieldName = 'ParentProductID'
      Origin = 'tblrepairparts.ParentProductID'
      Visible = False
    end
    object qryrepairpartsParentLineRef: TWideStringField
      FieldName = 'ParentLineRef'
      Origin = 'tblrepairparts.ParentLineRef'
      Visible = False
      Size = 255
    end
    object qryrepairpartsRelatedProductQty: TFloatField
      FieldName = 'RelatedProductQty'
      Origin = 'tblrepairparts.RelatedProductQty'
      Visible = False
    end
    object qryrepairpartsIsRelatedProduct: TWideStringField
      FieldName = 'IsRelatedProduct'
      Origin = 'tblrepairparts.IsRelatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryrepairpartsSaleLineId: TIntegerField
      FieldName = 'SaleLineId'
      Origin = 'tblrepairparts.SaleLineId'
      Visible = False
    end
    object qryrepairpartsMatrixDesc: TWideMemoField
      FieldName = 'MatrixDesc'
      Origin = 'tblrepairparts.MatrixDesc'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryrepairpartsMatrixRef: TWideMemoField
      FieldName = 'MatrixRef'
      Origin = 'tblrepairparts.MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryrepairpartsMatrixPrice: TFloatField
      FieldName = 'MatrixPrice'
      Origin = 'tblrepairparts.MatrixPrice'
      Visible = False
    end
    object qryrepairpartsCustfld1: TWideStringField
      FieldName = 'Custfld1'
      Origin = 'tblrepairparts.Custfld1'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld2: TWideStringField
      FieldName = 'CustFld2'
      Origin = 'tblrepairparts.CustFld2'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld3: TWideStringField
      FieldName = 'CustFld3'
      Origin = 'tblrepairparts.CustFld3'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld4: TWideStringField
      FieldName = 'CustFld4'
      Origin = 'tblrepairparts.CustFld4'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld5: TWideStringField
      FieldName = 'CustFld5'
      Origin = 'tblrepairparts.CustFld5'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld6: TWideStringField
      FieldName = 'CustFld6'
      Origin = 'tblrepairparts.CustFld6'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld7: TWideStringField
      FieldName = 'CustFld7'
      Origin = 'tblrepairparts.CustFld7'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld8: TWideStringField
      FieldName = 'CustFld8'
      Origin = 'tblrepairparts.CustFld8'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld9: TWideStringField
      FieldName = 'CustFld9'
      Origin = 'tblrepairparts.CustFld9'
      Visible = False
      Size = 255
    end
    object qryrepairpartsCustFld10: TWideStringField
      FieldName = 'CustFld10'
      Origin = 'tblrepairparts.CustFld10'
      Visible = False
      Size = 255
    end
    object qryrepairpartsFormulaQtyValue1: TFloatField
      FieldName = 'FormulaQtyValue1'
      Origin = 'tblrepairparts.FormulaQtyValue1'
      Visible = False
    end
    object qryrepairpartsFormulaQtyValue2: TFloatField
      FieldName = 'FormulaQtyValue2'
      Origin = 'tblrepairparts.FormulaQtyValue2'
      Visible = False
    end
    object qryrepairpartsFormulaQtyValue3: TFloatField
      FieldName = 'FormulaQtyValue3'
      Origin = 'tblrepairparts.FormulaQtyValue3'
      Visible = False
    end
    object qryrepairpartsFormulaQtyValue4: TFloatField
      FieldName = 'FormulaQtyValue4'
      Origin = 'tblrepairparts.FormulaQtyValue4'
      Visible = False
    end
    object qryrepairpartsFormulaQtyValue5: TFloatField
      FieldName = 'FormulaQtyValue5'
      Origin = 'tblrepairparts.FormulaQtyValue5'
      Visible = False
    end
    object qryrepairpartsFormulaQtyValue: TFloatField
      FieldName = 'FormulaQtyValue'
      Origin = 'tblrepairparts.FormulaQtyValue'
      Visible = False
    end
    object qryrepairpartscalcTax: TFloatField
      DisplayLabel = 'Tax Rate'
      DisplayWidth = 7
      FieldKind = fkCalculated
      FieldName = 'calcTax'
      Visible = False
      DisplayFormat = '#.00%'
      currency = True
      Calculated = True
    end
    object qryrepairpartscalcTotalEx: TFloatField
      DisplayLabel = 'Amount (Ex)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'calcTotalEx'
      Visible = False
      currency = True
      Calculated = True
    end
    object qryrepairpartscalcTotalInc: TFloatField
      FieldKind = fkCalculated
      FieldName = 'calcTotalInc'
      Visible = False
      currency = True
      Calculated = True
    end
    object qryrepairpartscalcTotalIncBase: TFloatField
      FieldKind = fkCalculated
      FieldName = 'calcTotalIncBase'
      Visible = False
      currency = True
      Calculated = True
    end
  end
  object dsrepairparts: TDataSource
    DataSet = qryrepairparts
    Left = 122
    Top = 152
  end
  object dsrepairs: TDataSource
    DataSet = Qryrepairs
    Left = 85
    Top = 152
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
    Left = 234
    Top = 216
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
    Left = 159
    Top = 184
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
    Left = 159
    Top = 152
  end
  object qryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName '
      'FROM tblEmployees WHERE Active = '#39'T'#39
      'Order By EmployeeName;')
    Options.LongStrings = False
    Left = 123
    Top = 216
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
    Left = 346
    Top = 216
  end
  object QryRepairEquip: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'CE.ID as customerequipID,'
      'R.RepairID,'
      'CE.EquipName AS EquipName,'
      'CE.StreetMap , '
      'CE.BuildingMap , '
      'CE.Warantyfinishdate,'
      'CE.WarantystartDate,'
      'RE.Quantity,'
      'RE.WarantyPeriodLeft,'
      'concat(CE.UOM , '#39'('#39' , CE.UOMMultiplier, '#39')'#39') as UOM, '
      'CE.Manufacture,'
      'CE.model, '
      'CE.Serialno,'
      'CE.Registration,'
      'CE.Notes EquipNotes,'
      'CE.WarantyPeriod,'
      'RE.Notes,'
      'RE.CustomField1,'
      'RE.CustomField2,'
      'RE.CustomField3,'
      'RE.CustomField4,'
      'RE.CustomField5,'
      'RE.CustomField6,'
      'RE.CustomField7,'
      'RE.CustomField8,'
      'RE.CustomField9,'
      'RE.CustomField10,'
      'RE.CustomerEquipmentID,'
      'RE.OnSite,'
      'RE.RepairFault'
      'FROM tblrepairs AS R'
      'Left Join tblEquipmentxRef AS RE ON R.RepairID = RE.RepairID'
      
        'Left Join tblcustomerequip AS CE ON RE.CustomerEquipmentID = CE.' +
        'id'
      'where R.RepairID = :ID')
    Filtered = True
    OnCalcFields = QryRepairEquipCalcFields
    Left = 48
    Top = 184
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        Value = 3
      end>
    object QryRepairEquipRepairID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RepairID'
      Origin = 'R.RepairID'
    end
    object QryRepairEquipEquipName: TWideStringField
      FieldName = 'EquipName'
      Origin = 'CE.EquipName'
      Size = 255
    end
    object QryRepairEquipStreetMap: TBlobField
      FieldName = 'StreetMap'
      Origin = 'CE.StreetMap'
    end
    object QryRepairEquipBuildingMap: TBlobField
      FieldName = 'BuildingMap'
      Origin = 'CE.BuildingMap'
    end
    object QryRepairEquipcustomerequipID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'customerequipID'
      Origin = 'CE.customerequipID'
    end
    object QryRepairEquipWarantyfinishdate: TDateTimeField
      FieldName = 'Warantyfinishdate'
      Origin = 'CE.Warantyfinishdate'
    end
    object QryRepairEquipWarantystartDate: TDateTimeField
      FieldName = 'WarantystartDate'
      Origin = 'CE.WarantystartDate'
    end
    object QryRepairEquipQuantity: TFloatField
      FieldName = 'Quantity'
      Origin = 'RE.Quantity'
    end
    object QryRepairEquipWarantyPeriodLeft: TLargeintField
      FieldName = 'WarantyPeriodLeft'
      Origin = 'RE.WarantyPeriodLeft'
    end
    object QryRepairEquipNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'RE.Notes'
      Size = 100
    end
    object QryRepairEquipCustomField1: TWideStringField
      FieldName = 'CustomField1'
      Origin = 'RE.CustomField1'
      Size = 255
    end
    object QryRepairEquipCustomField2: TWideStringField
      FieldName = 'CustomField2'
      Origin = 'RE.CustomField2'
      Size = 255
    end
    object QryRepairEquipCustomField3: TWideStringField
      FieldName = 'CustomField3'
      Origin = 'RE.CustomField3'
      Size = 255
    end
    object QryRepairEquipCustomField4: TWideStringField
      FieldName = 'CustomField4'
      Origin = 'RE.CustomField4'
      Size = 255
    end
    object QryRepairEquipCustomField5: TWideStringField
      FieldName = 'CustomField5'
      Origin = 'RE.CustomField5'
      Size = 255
    end
    object QryRepairEquipCustomField6: TWideStringField
      FieldName = 'CustomField6'
      Origin = 'RE.CustomField6'
      Size = 255
    end
    object QryRepairEquipCustomField7: TWideStringField
      FieldName = 'CustomField7'
      Origin = 'RE.CustomField7'
      Size = 255
    end
    object QryRepairEquipCustomField8: TWideStringField
      FieldName = 'CustomField8'
      Origin = 'RE.CustomField8'
      Size = 255
    end
    object QryRepairEquipCustomField9: TWideStringField
      FieldName = 'CustomField9'
      Origin = 'RE.CustomField9'
      Size = 255
    end
    object QryRepairEquipCustomField10: TWideStringField
      FieldName = 'CustomField10'
      Origin = 'RE.CustomField10'
      Size = 255
    end
    object QryRepairEquipCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
      Origin = 'RE.CustomerEquipmentID'
    end
    object QryRepairEquipOnSite: TWideStringField
      FieldName = 'OnSite'
      Origin = 'RE.OnSite'
      FixedChar = True
      Size = 1
    end
    object QryRepairEquipWarantyPeriod: TFloatField
      FieldName = 'WarantyPeriod'
      Origin = 'CE.WarantyPeriod'
    end
    object QryRepairEquipWarrantyPeriodUsed: TFloatField
      FieldKind = fkCalculated
      FieldName = 'WarrantyPeriodUsed'
      Calculated = True
    end
    object QryRepairEquipUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'UOM'
      Size = 64
    end
    object QryRepairEquipManufacture: TWideStringField
      FieldName = 'Manufacture'
      Size = 100
    end
    object QryRepairEquipmodel: TWideStringField
      FieldName = 'model'
      Size = 100
    end
    object QryRepairEquipSerialno: TWideStringField
      FieldName = 'Serialno'
      Size = 100
    end
    object QryRepairEquipRegistration: TWideStringField
      FieldName = 'Registration'
      Size = 100
    end
    object QryRepairEquipEquipNotes: TWideMemoField
      FieldName = 'EquipNotes'
      BlobType = ftWideMemo
    end
    object QryRepairEquipRepairFault: TWideStringField
      FieldName = 'RepairFault'
      Size = 255
    end
  end
  object dsRepairEquip: TDataSource
    DataSet = QryRepairEquip
    Left = 48
    Top = 152
  end
  object qryTimeSheetEntry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tbltimesheetentry')
    Left = 196
    Top = 184
    object qryTimeSheetEntryGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryTimeSheetEntryTimesheetEntryID: TIntegerField
      FieldName = 'TimesheetEntryID'
    end
    object qryTimeSheetEntryEntryDate: TDateTimeField
      FieldName = 'EntryDate'
    end
    object qryTimeSheetEntryType: TWideStringField
      FieldName = 'Type'
      Size = 64
    end
    object qryTimeSheetEntryTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object qryTimeSheetEntryWhoEntered: TWideStringField
      FieldName = 'WhoEntered'
      Size = 64
    end
    object qryTimeSheetEntrymsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object qryTimesheets: TERPQuery
    Connection = MyConnection
    ParamCheck = False
    SQL.Strings = (
      '##################################################'
      '# PLEASE READ!'
      
        '# If modifying this SQL statement then please keep your *WHERE* ' +
        'clause'
      
        '# on one line.  Also if ReadOnlyMode is set, then the *WHERE* cl' +
        'ause'
      '# is fully removed.'
      '#'
      '##################################################'
      ''
      'SELECT '
      'ID, timesheetDate, Hours, Total, Job, JobID, EmployeeName,'
      'EmployeeID, LabourCost, ClassName, ClassID, GlobalRef,'
      
        'ServiceID, ServiceName, ServiceDate, Qty,ChargeRate, PartID, Par' +
        'tName,'
      
        'PayRateTypeName, PayRateTypeID, HourlyRate, SuperInc,  TotalServ' +
        'icecharge,'
      
        'SuperAmount,Notes,Active,UseTimeCost, SalesID,Qty, PartsDescript' +
        'ion, Tax, SaleLineID, AllowEdit , '
      
        'customerEquipmentID,timesheetentryID, Equipment, repairId,roster' +
        'Id, signature , SignatureTime, ContactName'
      'FROM tbltimesheets'
      'WHERE Active = '#39'T'#39' and TimesheetEntryID = :TimesheetEntryID'
      'ORDER BY timesheetDate')
    AutoCalcFields = False
    AfterOpen = qryTimesheetsAfterOpen
    OnCalcFields = qryTimesheetsCalcFields
    Left = 233
    Top = 184
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TimesheetEntryID'
        Value = 0
      end>
    object qryTimesheetsEmployeeName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 10
      FieldName = 'EmployeeName'
      Origin = 'tbltimesheets.EmployeeName'
      Size = 255
    end
    object qryTimesheetsServiceName: TWideStringField
      DisplayLabel = 'Service Name'
      DisplayWidth = 10
      FieldName = 'ServiceName'
      Origin = 'tbltimesheets.ServiceName'
      Size = 255
    end
    object qryTimesheetsServiceDate: TDateField
      DisplayLabel = 'Service Date'
      DisplayWidth = 11
      FieldName = 'ServiceDate'
      Origin = 'tbltimesheets.ServiceDate'
    end
    object qryTimesheetsQty: TFloatField
      DisplayLabel = 'Hours'
      DisplayWidth = 6
      FieldName = 'Qty'
      Origin = 'tbltimesheets.Qty'
      OnChange = qryTimesheetsQtyChange
    end
    object qryTimesheetsSignatureMemo: TStringField
      DisplayLabel = 'Signature'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'SignatureMemo'
      Size = 10
      Calculated = True
    end
    object qryTimesheetsSignatureTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'SignatureTime'
    end
    object qryTimesheetsContactName: TWideStringField
      DisplayWidth = 10
      FieldName = 'ContactName'
    end
    object qryTimesheetssignature: TBlobField
      DisplayWidth = 10
      FieldName = 'signature'
      Visible = False
    end
    object qryTimesheetstimesheetDate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 9
      FieldName = 'timesheetDate'
      Origin = 'tbltimesheets.TimesheetDate'
      Visible = False
    end
    object qryTimesheetsEquipment: TWideStringField
      DisplayWidth = 12
      FieldName = 'Equipment'
      Origin = 'tbltimesheets.Equipment'
      Visible = False
      Size = 100
    end
    object qryTimesheetsRepairDocNo: TStringField
      DisplayLabel = 'Repair #'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'RepairDocNo'
      LookupDataSet = Qryrepairs
      LookupKeyFields = 'RepairID'
      LookupResultField = 'RepairDocNo'
      KeyFields = 'RepairID'
      Visible = False
      Size = 255
      Lookup = True
    end
    object qryTimesheetsJob: TWideStringField
      DisplayWidth = 12
      FieldName = 'Job'
      Origin = 'tbltimesheets.Job'
      Visible = False
      Size = 255
    end
    object qryTimesheetsPayRateTypeName: TWideStringField
      DisplayLabel = 'Rate'
      DisplayWidth = 7
      FieldName = 'PayRateTypeName'
      Origin = 'tbltimesheets.PayRateTypeName'
      Visible = False
      Size = 255
    end
    object qryTimesheetsLabourCost: TFloatField
      DisplayLabel = 'Rate/Salary'
      DisplayWidth = 9
      FieldName = 'LabourCost'
      Origin = 'tbltimesheets.LabourCost'
      Visible = False
      currency = True
    end
    object qryTimesheetsHours: TFloatField
      DisplayWidth = 4
      FieldName = 'Hours'
      Origin = 'tbltimesheets.Hours'
      Visible = False
    end
    object qryTimesheetsChargeRate: TFloatField
      DisplayLabel = 'Rate per Hour (Inc)'
      DisplayWidth = 15
      FieldName = 'ChargeRate'
      Origin = 'tbltimesheets.ChargeRate'
      Visible = False
      currency = True
    end
    object qryTimesheetsClassName: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 9
      FieldName = 'ClassName'
      Origin = 'tbltimesheets.ClassName'
      Visible = False
      Size = 255
    end
    object QryTimeSheetsNotes: TWideMemoField
      DisplayWidth = 22
      FieldName = 'Notes'
      Origin = 'tbltimesheets.Notes'
      Visible = False
      BlobType = ftWideMemo
      Size = 255
    end
    object qryTimesheetsAllowEdit: TWideStringField
      DisplayWidth = 7
      FieldName = 'AllowEdit'
      Origin = 'tbltimesheets.AllowEdit'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsUseTimeCost: TWideStringField
      DisplayWidth = 10
      FieldName = 'UseTimeCost'
      Origin = 'tbltimesheets.UseTimeCost'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsTotal: TFloatField
      DisplayWidth = 5
      FieldName = 'Total'
      Origin = 'tbltimesheets.Total'
      Visible = False
      currency = True
    end
    object qryTimesheetsTotalServicecharge: TFloatField
      DisplayWidth = 15
      FieldName = 'TotalServicecharge'
      Origin = 'tbltimesheets.TotalServicecharge'
      Visible = False
      DisplayFormat = '$#######0.00'
      currency = True
    end
    object qryTimesheetsRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Origin = 'tbltimesheets.RepairID'
      Visible = False
    end
    object qryTimesheetscustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'customerEquipmentID'
      Origin = 'tbltimesheets.CustomerEquipmentID'
      Visible = False
    end
    object qryTimesheetsTimesheetEntryID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TimesheetEntryID'
      Origin = 'tbltimesheets.TimesheetEntryID'
      Visible = False
    end
    object qryTimesheetsSuperInc: TWideStringField
      DisplayLabel = 'Super'
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Origin = 'tbltimesheets.SuperInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tbltimesheets.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryTimesheetsID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbltimesheets.ID'
      ReadOnly = True
      Visible = False
    end
    object qryTimesheetsJobID: TIntegerField
      DisplayWidth = 10
      FieldName = 'JobID'
      Origin = 'tbltimesheets.JobID'
      Visible = False
    end
    object qryTimesheetsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tbltimesheets.EmployeeID'
      Visible = False
    end
    object qryTimesheetsClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tbltimesheets.ClassID'
      Visible = False
    end
    object qryTimesheetsRosterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RosterID'
      Origin = 'tbltimesheets.RosterID'
      Visible = False
    end
    object qryTimesheetsServiceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ServiceID'
      Origin = 'tbltimesheets.ServiceID'
      Visible = False
    end
    object qryTimesheetsPartID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartID'
      Origin = 'tbltimesheets.PartID'
      Visible = False
    end
    object qryTimesheetsPartName: TWideStringField
      DisplayWidth = 40
      FieldName = 'PartName'
      Origin = 'tbltimesheets.PartName'
      Visible = False
      Size = 255
    end
    object qryTimesheetsPayRateTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayRateTypeID'
      Origin = 'tbltimesheets.PayRateTypeID'
      Visible = False
    end
    object qryTimesheetsHourlyRate: TFloatField
      DisplayWidth = 10
      FieldName = 'HourlyRate'
      Origin = 'tbltimesheets.HourlyRate'
      Visible = False
      currency = True
    end
    object qryTimesheetsSuperAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'SuperAmount'
      Origin = 'tbltimesheets.SuperAmount'
      Visible = False
      currency = True
    end
    object qryTimesheetsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltimesheets.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTimesheetsSalesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SalesID'
      Origin = 'tbltimesheets.SalesID'
      Visible = False
    end
    object qryTimesheetsTax: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tbltimesheets.Tax'
      Visible = False
      currency = True
    end
    object qryTimesheetsPartsDescription: TWideStringField
      DisplayWidth = 40
      FieldName = 'PartsDescription'
      Origin = 'tbltimesheets.PartsDescription'
      Visible = False
      Size = 255
    end
    object qryTimesheetsSaleLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Origin = 'tbltimesheets.SaleLineID'
      Visible = False
    end
  end
  object DSTimesheet: TDataSource
    DataSet = qryTimesheets
    Left = 233
    Top = 152
  end
  object dsTimeSheetEntry: TDataSource
    DataSet = qryTimeSheetEntry
    Left = 196
    Top = 152
  end
  object tmrGo: TTimer
    Enabled = False
    OnTimer = tmrGoTimer
    Left = 737
    Top = 107
  end
  object qryClientcontact: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select CL.clientID, CL.company, '
      
        'trim(concat(ifnull(C.ContactTitle,'#39#39') , '#39' '#39' ,  ifnull(C.ContactF' +
        'irstName, '#39#39'),'#39' '#39' , ifnull(C.ContactSurName,'#39#39'))) contactname,'
      
        '/*ifnull(C.ContactAddress   , CL.street)   */ C.ContactAddress  ' +
        'as Street , '
      
        '/*ifnull(C.ContactAddress2  , CL.street2)  */ C.ContactAddress2 ' +
        'as street2 , '
      
        '/*ifnull(C.ContactAddress3  , CL.street3 ) */ C.ContactAddress3 ' +
        'as street3 , '
      
        '/*ifnull(C.ContactState     , CL.state )   */ C.ContactState    ' +
        'as state , '
      
        '/*ifnull(C.ContactPcode     , CL.postcode) */ C.ContactPcode    ' +
        'as postcode , '
      
        '/*ifnull(C.ContactPH        , CL.phone)    */ C.ContactPH       ' +
        'as phone , '
      
        '/*ifnull(C.ContactMOB       , CL.Mobile)   */ C.ContactMOB      ' +
        'as Mobile , '
      
        '/*ifnull(C.ContactEmail     , CL.Email)    */ C.ContactEmail    ' +
        'as Email , '
      
        '/*ifnull(C.ContactCity      , CL.Suburb )  */ C.ContactCity     ' +
        'as Suburb  '
      'from tblClients CL '
      
        'left join tblcontacts C  on  CL.clientID = C.ClientID and  conta' +
        'ctId = :ContactID'
      'where CL.ClientId = :ClientID')
    Left = 271
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ContactID'
      end
      item
        DataType = ftUnknown
        Name = 'ClientID'
      end>
    object qryClientcontactclientID: TIntegerField
      FieldName = 'clientID'
    end
    object qryClientcontactcompany: TWideStringField
      FieldName = 'company'
      Size = 160
    end
    object qryClientcontactStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryClientcontactstreet2: TWideStringField
      FieldName = 'street2'
      Size = 255
    end
    object qryClientcontactstreet3: TWideStringField
      FieldName = 'street3'
      Size = 255
    end
    object qryClientcontactstate: TWideStringField
      FieldName = 'state'
      Size = 255
    end
    object qryClientcontactpostcode: TWideStringField
      FieldName = 'postcode'
      Size = 255
    end
    object qryClientcontactphone: TWideStringField
      FieldName = 'phone'
      Size = 255
    end
    object qryClientcontactMobile: TWideStringField
      FieldName = 'Mobile'
      Size = 255
    end
    object qryClientcontactEmail: TWideStringField
      FieldName = 'Email'
      Size = 255
    end
    object qryClientcontactSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object qryClientcontactcontactname: TWideStringField
      FieldName = 'contactname'
      Size = 94
    end
  end
  object dsClientcontact: TDataSource
    DataSet = qryClientcontact
    Left = 271
    Top = 152
  end
  object qryServices: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ID, ServiceName, EmployeeID, Rate, PartID, PartName'
      'FROM tblpaysemployeeservices'
      'WHERE (EmployeeID = :xEmpID)'
      'ORDER BY ServiceName')
    Left = 160
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xEmpID'
      end>
    object qryServicesServiceName: TWideStringField
      DisplayWidth = 30
      FieldName = 'ServiceName'
      Size = 255
    end
    object qryServicesID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object qryServicesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryServicesRate: TFloatField
      FieldName = 'Rate'
      Visible = False
    end
    object qryServicesPartID: TIntegerField
      FieldName = 'PartID'
      Visible = False
    end
    object qryServicesPartName: TWideStringField
      FieldName = 'PartName'
      Visible = False
      Size = 255
    end
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ContactID, concat_ws('#39' '#39' , ContactTitle , ContactFirstNam' +
        'e, ContactSurname) as contactName'
      'FROM tblContacts'
      'WHERE ClientID = :ClientID')
    Left = 271
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientID'
      end>
    object qryContactscontactName: TWideStringField
      DisplayWidth = 30
      FieldName = 'contactName'
      Size = 94
    end
    object qryContactsContactID: TIntegerField
      FieldName = 'ContactID'
      Visible = False
    end
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT E.EmployeeID, Concat(E.FirstName,'#39' '#39',E.LastName) AS Emplo' +
        'yeeName'
      'FROM tblEmployees AS E'
      'WHERE E.Active = '#39'T'#39
      'ORDER BY EmployeeName;')
    Left = 48
    Top = 216
  end
  object dsOtherFollowUp: TDataSource
    DataSet = tbOtherFollowUp
    Left = 308
    Top = 152
  end
  object tbOtherFollowUp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblotherfollowup'
      'Where RepairID= :ID;')
    Left = 308
    Top = 184
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tbOtherFollowUpFollowUpDate: TDateTimeField
      DisplayLabel = 'Follow Up Date'
      DisplayWidth = 15
      FieldName = 'FollowUpDate'
    end
    object tbOtherFollowUpNotes: TWideMemoField
      DisplayWidth = 20
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object tbOtherFollowUpEmployeeName: TWideStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = qryEmployees
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Size = 30
      Lookup = True
    end
    object tbOtherFollowUpDone: TWideStringField
      DisplayWidth = 1
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tbOtherFollowUpFollowUpID: TAutoIncField
      FieldName = 'FollowUpID'
      ReadOnly = True
      Visible = False
    end
    object tbOtherFollowUpOtherContactID: TIntegerField
      FieldName = 'OtherContactID'
      Visible = False
    end
    object tbOtherFollowUpRepairID: TIntegerField
      FieldName = 'RepairID'
      Visible = False
    end
    object tbOtherFollowUpEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object tbOtherFollowUpClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object tbOtherFollowUpEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpAppearDays: TIntegerField
      FieldName = 'AppearDays'
      Visible = False
    end
    object tbOtherFollowUpCreationDate: TDateTimeField
      FieldName = 'CreationDate'
      Visible = False
    end
    object tbOtherFollowUpUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Visible = False
    end
    object tbOtherFollowUpIsSupplier: TWideStringField
      FieldName = 'IsSupplier'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsOtherContact: TWideStringField
      FieldName = 'IsOtherContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsCustomer: TWideStringField
      FieldName = 'IsCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object tblrepairsFaults: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrepairsfaults'
      'Where RepairID= :ID'
      'and CustomerEquipmentID = :CustomerEquipmentID;')
    Filtered = True
    Filter = 'Deleted ='#39'F'#39
    BeforeOpen = tblrepairsFaultsBeforeOpen
    AfterInsert = tblrepairsFaultsAfterInsert
    Left = 345
    Top = 184
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end
      item
        DataType = ftUnknown
        Name = 'CustomerEquipmentID'
      end>
    object tblrepairsFaultsRepairFault: TWideStringField
      DisplayLabel = 'Repair Fault'
      DisplayWidth = 30
      FieldName = 'RepairFault'
      Origin = 'tblrepairsfaults.RepairFault'
      Size = 255
    end
    object tblrepairsFaultsDone: TWideStringField
      DisplayLabel = 'Done?'
      DisplayWidth = 1
      FieldName = 'Done'
      Origin = 'tblrepairsfaults.Done'
      FixedChar = True
      Size = 1
    end
    object tblrepairsFaultsEquipment: TWideStringField
      DisplayWidth = 50
      FieldName = 'Equipment'
      Origin = 'tblrepairsfaults.Equipment'
      Visible = False
      Size = 100
    end
    object tblrepairsFaultsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblrepairsfaults.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblrepairsFaultsRepairsFaultId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RepairsFaultId'
      Origin = 'tblrepairsfaults.RepairsFaultId'
      Visible = False
    end
    object tblrepairsFaultsRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Origin = 'tblrepairsfaults.RepairID'
      Visible = False
    end
    object tblrepairsFaultsTimeSheetID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TimeSheetID'
      Origin = 'tblrepairsfaults.TimeSheetID'
      Visible = False
    end
    object tblrepairsFaultsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblrepairsfaults.msTimeStamp'
      Visible = False
    end
    object tblrepairsFaultsCustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Origin = 'tblrepairsfaults.CustomerEquipmentID'
      Visible = False
    end
    object tblrepairsFaultsDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblrepairsfaults.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblrepairsFaultsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblrepairsfaults.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsrepairsFaults: TDataSource
    DataSet = tblrepairsFaults
    Left = 345
    Top = 152
  end
  object QryrepairFaults: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Typecode,Name,Description FROM tblsimpletypes '
      
        'WHERE Typecode = '#39'RepairFault'#39' and ((Active = "T") or (Name = :x' +
        'Name))'
      'ORDER BY Name')
    Left = 197
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xName'
      end>
    object QryrepairFaultsName: TWideStringField
      DisplayWidth = 10
      FieldName = 'Name'
      Size = 255
    end
    object QryrepairFaultsDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Size = 255
    end
    object QryrepairFaultsTypecode: TWideStringField
      FieldName = 'Typecode'
      Visible = False
      Size = 30
    end
  end
  object qryDocuments: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      
        'tblReference.RefID, tblReference.Ref_Date as Date, tblReference.' +
        'Ref_type as Type,'
      
        'tblReference.Referencetxt as Reference, tblReference.CusID, tblR' +
        'eference.ContactID,'
      'tblClients.company as CustomerName,'
      
        'Concat_Ws(" ",tblContacts.ContactFirstName,tblContacts.ContactSu' +
        'rname) as ContactName,'
      'tblContacts.ContactID,'
      'tblReference.active,'
      'tblReference.EditedFlag,'
      'tblReference.MessageId,'
      'tblReference.ReferenceData,'
      'tblReference.MessageFrom,'
      'tblReference.MessageTo'
      'FROM tblReference'
      'LEFT JOIN tblClients ON tblReference.CusID=tblClients.ClientID'
      
        'LEFT JOIN tblContacts ON tblReference.ContactID=tblContacts.Cont' +
        'actID'
      'WHERE tblReference.RepairID=:RepairID'
      'ORDER BY tblReference.Ref_Date DESC;')
    Filtered = True
    Filter = 'Active ='#39'T'#39
    Left = 382
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepairID'
      end>
  end
  object DSDocuments: TDataSource
    DataSet = qryDocuments
    Left = 382
    Top = 152
  end
  object qryStatus: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblsimpletypes '
      'WHERE (TypeCode='#39'StatusType'#39') AND (Active='#39'T'#39')')
    Left = 308
    Top = 216
    object qryStatusName: TWideStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
  end
  object QryAttachments: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select * from tblattachments where tablename = '#39'tblRepairs'#39' and ' +
        'TableId = :RepairID')
    Filtered = True
    Left = 419
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepairID'
      end>
    object QryAttachmentsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryAttachmentsAttachmentId: TIntegerField
      FieldName = 'AttachmentId'
    end
    object QryAttachmentsTableName: TWideStringField
      FieldName = 'TableName'
      Size = 40
    end
    object QryAttachmentsTableId: TIntegerField
      FieldName = 'TableId'
    end
    object QryAttachmentsAttachment: TBlobField
      FieldName = 'Attachment'
    end
    object QryAttachmentsAttachmentName: TWideStringField
      FieldName = 'AttachmentName'
      Size = 255
    end
    object QryAttachmentsDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object QryAttachmentsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryAttachmentsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object qryShippingAddress: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblShippingAddress')
    Left = 448
    Top = 232
    object qryShippingAddressGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryShippingAddressShipAddressID: TIntegerField
      FieldName = 'ShipAddressID'
    end
    object qryShippingAddressCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 255
    end
    object qryShippingAddressCustomer_ID: TIntegerField
      FieldName = 'Customer_ID'
    end
    object qryShippingAddressContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 255
    end
    object qryShippingAddressShipAddress: TWideStringField
      FieldName = 'ShipAddress'
      Size = 255
    end
    object qryShippingAddressShipAddress1: TWideStringField
      FieldName = 'ShipAddress1'
      Size = 255
    end
    object qryShippingAddressShipCity: TWideStringField
      FieldName = 'ShipCity'
      Size = 255
    end
    object qryShippingAddressShipPostCode: TWideStringField
      FieldName = 'ShipPostCode'
      Size = 255
    end
    object qryShippingAddressShipState: TWideStringField
      FieldName = 'ShipState'
      Size = 255
    end
    object qryShippingAddressShipCountry: TWideStringField
      FieldName = 'ShipCountry'
      Size = 255
    end
    object qryShippingAddressEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryShippingAddressmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryShippingAddressShipAddress2: TWideStringField
      FieldName = 'ShipAddress2'
      Size = 255
    end
    object qryShippingAddressActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryShippingAddressPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Size = 100
    end
    object qryShippingAddressPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Size = 100
    end
    object qryShippingAddressFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Size = 100
    end
    object qryShippingAddressIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Size = 100
    end
    object qryShippingAddressPhone: TWideStringField
      FieldName = 'Phone'
    end
    object qryShippingAddressmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryShippingAddressemail: TWideStringField
      FieldName = 'email'
      Size = 255
    end
  end
  object dsShippingAddress: TDataSource
    DataSet = qryShippingAddress
    Left = 456
    Top = 200
  end
end
