inherited RepairsGUI: TRepairsGUI
  Left = 353
  Top = 136
  HelpContext = 653000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Repairs'
  ClientHeight = 590
  ClientWidth = 1045
  DefaultMonitor = dmMainForm
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 353
  ExplicitTop = 136
  ExplicitWidth = 1061
  ExplicitHeight = 629
  DesignSize = (
    1045
    590)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 590
    Width = 1045
    HelpContext = 653455
    ExplicitTop = 486
    ExplicitWidth = 952
  end
  inherited shapehint: TShape
    Left = 13
    Pen.Color = 12058623
    ExplicitLeft = 12
  end
  inherited shapehintextra1: TShape
    Left = 60
    ExplicitLeft = 56
  end
  object pnlbody: TDNMPanel [5]
    Left = 144
    Top = 0
    Width = 901
    Height = 590
    HelpContext = 653051
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlPagecontrol: TDNMPanel
      Left = 0
      Top = 0
      Width = 901
      Height = 590
      HelpContext = 653456
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TABCTL20: TPageControl
        Left = 1
        Top = 88
        Width = 799
        Height = 458
        HelpContext = 653052
        ActivePage = tabEquipment
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabHeight = 25
        TabOrder = 0
        TabWidth = 66
        OnChange = TABCTL20Change
        OnChanging = TABCTL20Changing
        OnEnter = TABCTL20Enter
        OnResize = TABCTL20Resize
        object TabMain: TTabSheet
          HelpContext = 653457
          Caption = 'Main'
          ImageIndex = 15
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlTitle: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 255
            HelpContext = 653001
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PopupMenu = popOptions
            TabOrder = 0
            TabStop = True
            object Bevel15: TBevel
              Left = 641
              Top = 216
              Width = 98
              Height = 37
              HelpContext = 653005
              Shape = bsFrame
            end
            object Bevel8: TBevel
              Left = 224
              Top = 216
              Width = 311
              Height = 37
              HelpContext = 653006
              Shape = bsFrame
            end
            object Bevel3: TBevel
              Left = 6
              Top = 216
              Width = 215
              Height = 37
              HelpContext = 653564
              Shape = bsFrame
            end
            object Bevel5: TBevel
              Left = 538
              Top = 216
              Width = 99
              Height = 37
              HelpContext = 653565
              Shape = bsFrame
            end
            object Label10: TLabel
              Left = 548
              Top = 219
              Width = 52
              Height = 30
              HelpContext = 653013
              Alignment = taRightJustify
              Caption = 'Choose Template'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Bevel4: TBevel
              Left = 426
              Top = 3
              Width = 369
              Height = 212
              HelpContext = 653002
              Shape = bsFrame
            end
            object Bevel2: TBevel
              Left = 6
              Top = 3
              Width = 395
              Height = 212
              HelpContext = 653566
              Shape = bsFrame
            end
            object Label15: TLabel
              Left = 21
              Top = 42
              Width = 48
              Height = 18
              Hint = 'Double click for Address List'
              HelpContext = 653008
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Details'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              Transparent = True
              WordWrap = True
              OnDblClick = addresslist
            end
            object Label7: TLabel
              Left = 11
              Top = 13
              Width = 58
              Height = 16
              HelpContext = 653007
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Company'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object lblShipTo: TLabel
              Left = 14
              Top = 63
              Width = 55
              Height = 14
              Hint = 'Double click for Address List'
              HelpContext = 653458
              Caption = '(Dbl Click)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              Transparent = True
              WordWrap = True
            end
            object Label22: TLabel
              Left = 11
              Top = 227
              Width = 86
              Height = 15
              HelpContext = 653015
              Alignment = taRightJustify
              Caption = 'Customer PO #'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label46: TLabel
              Left = 236
              Top = 227
              Width = 36
              Height = 15
              HelpContext = 653459
              Caption = 'Terms'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label42: TLabel
              Left = 402
              Top = 227
              Width = 18
              Height = 15
              HelpContext = 653016
              Caption = 'Via'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label6: TLabel
              Left = 10
              Top = 170
              Width = 84
              Height = 15
              HelpContext = 653460
              Caption = 'Phone Number'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label9: TLabel
              Left = 130
              Top = 170
              Width = 37
              Height = 15
              HelpContext = 653461
              Caption = 'Mobile'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label2: TLabel
              Left = 434
              Top = 32
              Width = 58
              Height = 16
              HelpContext = 653038
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Company'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label8: TLabel
              Left = 444
              Top = 62
              Width = 48
              Height = 18
              HelpContext = 653039
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Details'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label12: TLabel
              Left = 434
              Top = 170
              Width = 84
              Height = 15
              HelpContext = 653462
              Alignment = taRightJustify
              Caption = 'Phone Number'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label13: TLabel
              Left = 555
              Top = 170
              Width = 37
              Height = 15
              HelpContext = 653463
              Alignment = taRightJustify
              Caption = 'Mobile'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label19: TLabel
              Left = 664
              Top = 219
              Width = 37
              Height = 30
              HelpContext = 653017
              Alignment = taRightJustify
              Caption = 'Hold Repair'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label16: TLabel
              Left = 250
              Top = 170
              Width = 20
              Height = 15
              HelpContext = 653464
              Caption = 'Fax'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label79: TLabel
              Left = 677
              Top = 170
              Width = 20
              Height = 15
              HelpContext = 653465
              Alignment = taRightJustify
              Caption = 'Fax'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label78: TLabel
              Left = 525
              Top = 12
              Width = 214
              Height = 15
              HelpContext = 653014
              Alignment = taRightJustify
              Caption = 'Use different Customer for Invoicing ?'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object cboClientJob: TERPDbLookupCombo
              Left = 72
              Top = 10
              Width = 239
              Height = 23
              HelpContext = 653018
              BiDiMode = bdLeftToRight
              ParentBiDiMode = False
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ControlType.Strings = (
                'StopCredit;ImageIndex;Shrink To Fit'
                'StopCreditImage;ImageIndex;Shrink To Fit')
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Company'#9'65'#9'Company'#9'F'
                'StopCreditImage'#9'1'#9'StopCreditImage'#9'T'#9)
              DataField = 'CustomerName'
              DataSource = DSMaster
              LookupTable = qryClientLookup
              LookupField = 'Company'
              Options = [loColLines, loSearchOnBackspace]
              ImageList = imgCredit
              ParentFont = False
              TabOrder = 5
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnDropDown = cboClientJobDropDown
              OnCloseUp = cboClientJobCloseUp
              OnEnter = cboClientJobEnter
              OnExit = cboClientJobExit
              LookupFormClassName = 'TCustomerExpressListGUI'
              EditFormClassName = 'TfrmCustomer'
              LookupFormKeyStringFieldName = 'Company'
              LookupComboType = ctCustomer
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = False
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
              DataIDField = 'CusID'
              LookupIDField = 'ClientID'
              LookupFieldAlt = 'PrintName'
            end
            object btnContacts: TDNMSpeedButton
              Left = 335
              Top = 10
              Width = 25
              Height = 23
              Hint = 'Show Contact List'
              HelpContext = 653184
              Action = actCompany
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
                055557777777777775F508888888888880557F5FFFFFFFFFF75F080000000000
                88057577777777775F755080FFFFFF05088057F7FFFFFF7575F70000000000F0
                F08077777777775757F70FFFFFFFFF0F008075F5FF5FF57577F750F00F00FFF0
                F08057F775775557F7F750FFFFFFFFF0F08057FF5555555757F7000FFFFFFFFF
                0000777FF5FFFFF577770900F00000F000907F775777775777F7090FFFFFFFFF
                00907F7F555555557757000FFFFFFFFF0F00777F5FFF5FF57F77550F000F00FF
                0F05557F777577557F7F550FFFFFFFFF0005557F555FFFFF7775550FFF000000
                05555575FF777777755555500055555555555557775555555555}
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              MaxTextDisplay = False
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 8
              AutoDisableParentOnclick = True
            end
            object txtClientDetails: TDBMemo
              Left = 72
              Top = 42
              Width = 288
              Height = 120
              Hint = 'Double click for Address List'
              HelpContext = 653019
              DataField = 'CustomerDetails'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 9
              OnDblClick = addresslist
            end
            object edCustomerPO: TDBEdit
              Left = 111
              Top = 223
              Width = 107
              Height = 23
              HelpContext = 653047
              DataField = 'CustomerPONumber'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
              OnExit = edCustomerPOExit
            end
            object cboTerms: TwwDBLookupCombo
              Left = 278
              Top = 223
              Width = 100
              Height = 23
              HelpContext = 653049
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Terms'#9'50'#9'Terms'#9'F')
              DataField = 'Terms'
              DataSource = DSMaster
              LookupTable = cboTermsQry
              LookupField = 'Terms'
              ParentFont = False
              TabOrder = 11
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboTermsCloseUp
            end
            object cboVia: TwwDBLookupCombo
              Left = 426
              Top = 223
              Width = 100
              Height = 23
              HelpContext = 653048
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'ShippingMethod'#9'20'#9'ShippingMethod'#9'F'#9)
              DataField = 'Shipping'
              DataSource = DSMaster
              LookupTable = qryVia
              LookupField = 'ShippingMethod'
              ParentFont = False
              TabOrder = 4
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object BillClientName: TERPDbLookupCombo
              Left = 498
              Top = 33
              Width = 288
              Height = 23
              HelpContext = 653040
              BiDiMode = bdLeftToRight
              ParentBiDiMode = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Company'#9'30'#9'Company'#9'F')
              DataField = 'BillCustomerName'
              DataSource = DSMaster
              LookupTable = qryClientInvoicetoLookup
              LookupField = 'Company'
              Options = [loSearchOnBackspace]
              Style = csDropDownList
              DropDownWidth = 150
              ParentFont = False
              TabOrder = 0
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = BillClientNameCloseUp
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
            object BillToCustomerDetails: TDBMemo
              Left = 498
              Top = 62
              Width = 288
              Height = 103
              HelpContext = 653041
              DataField = 'BillToCustomerDetails'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object edtPhone: TDBEdit
              Left = 434
              Top = 185
              Width = 110
              Height = 23
              HelpContext = 653042
              DataField = 'BillPhone'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object DBEdit2: TDBEdit
              Left = 555
              Top = 185
              Width = 110
              Height = 23
              HelpContext = 653043
              DataField = 'BillMobile'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object edtCPhone: TDBEdit
              Left = 10
              Top = 185
              Width = 110
              Height = 23
              HelpContext = 653034
              DataField = 'Phone'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object DBEdit3: TDBEdit
              Left = 130
              Top = 185
              Width = 110
              Height = 23
              HelpContext = 653035
              DataField = 'Mobile'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object chkChooseTemplate: TCheckBox
              Left = 612
              Top = 227
              Width = 13
              Height = 15
              HelpContext = 653033
              TabOrder = 12
            end
            object wwCheckBox1: TwwCheckBox
              Left = 710
              Top = 227
              Width = 15
              Height = 15
              HelpContext = 653050
              DisableThemes = False
              AlwaysTransparent = True
              Frame.Enabled = True
              Frame.Transparent = True
              Frame.FocusBorders = []
              Frame.NonFocusBorders = []
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'True'
              DisplayValueUnchecked = 'False'
              NullAndBlankState = cbUnchecked
              Caption = 'chkUseBillCust'
              DataField = 'HoldRepair'
              DataSource = DSMaster
              TabOrder = 13
              OnClick = chkUseBillCustClick
            end
            object DBEdit1: TDBEdit
              Left = 254
              Top = 185
              Width = 110
              Height = 23
              HelpContext = 653567
              DataField = 'Fax'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 14
            end
            object DBEdit4: TDBEdit
              Left = 677
              Top = 185
              Width = 110
              Height = 23
              HelpContext = 653568
              DataField = 'BillFax'
              DataSource = DSMaster
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
            end
            object chkUseBillCust: TwwCheckBox
              Left = 745
              Top = 12
              Width = 13
              Height = 15
              HelpContext = 653046
              DisableThemes = False
              AlwaysTransparent = True
              Frame.Enabled = True
              Frame.Transparent = True
              Frame.FocusBorders = []
              Frame.NonFocusBorders = []
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'True'
              DisplayValueUnchecked = 'False'
              NullAndBlankState = cbUnchecked
              Caption = 'chkUseBillCust'
              DataField = 'UseBillCust'
              DataSource = DSMaster
              TabOrder = 16
              OnClick = chkUseBillCustClick
            end
            object btnCreateJob: TDNMSpeedButton
              Left = 310
              Top = 10
              Width = 25
              Height = 23
              Hint = 'Create a Job'
              HelpContext = 653623
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                04000000000080000000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0050FF00055555
                555558070F00555555550800FFF8055555550880000F800555555007FFF08800
                055555500FF800BBB0055555500BBBBBBBB05555500000000BB855500BBBBBBB
                B000550BB000000B000F50B00BBBBB0B0B50500BBBBBBB0B0B55550BBBBBB0B0
                B0555550BBBB0B0B055555550000B00055555555550000555555}
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              NumGlyphs = 1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 17
              AutoDisableParentOnclick = True
              OnClick = btnCreateJobClick
            end
          end
          object DNMPanel2: TDNMPanel
            Left = 0
            Top = 255
            Width = 791
            Height = 168
            HelpContext = 653149
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = True
            object Shape3: TBevel
              AlignWithMargins = True
              Left = 478
              Top = 1
              Width = 170
              Height = 166
              HelpContext = 653466
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Shape = bsFrame
              ExplicitTop = 3
              ExplicitHeight = 163
            end
            object Shape1: TBevel
              AlignWithMargins = True
              Left = 2
              Top = 1
              Width = 228
              Height = 166
              HelpContext = 653467
              Margins.Left = 2
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alClient
              Shape = bsFrame
              ExplicitLeft = 6
              ExplicitTop = 3
              ExplicitWidth = 215
              ExplicitHeight = 163
            end
            object Shape2: TBevel
              AlignWithMargins = True
              Left = 232
              Top = 1
              Width = 116
              Height = 166
              HelpContext = 653468
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Shape = bsFrame
              ExplicitLeft = 224
              ExplicitTop = 3
              ExplicitHeight = 163
            end
            object lblClassHeader: TLabel
              Left = 239
              Top = 2
              Width = 32
              Height = 15
              HelpContext = 653150
              Alignment = taRightJustify
              Caption = 'Class'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label5: TLabel
              Left = 239
              Top = 42
              Width = 97
              Height = 15
              HelpContext = 653153
              Caption = 'Status (Dbl Click)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label48: TLabel
              Left = 239
              Top = 82
              Width = 86
              Height = 15
              HelpContext = 653154
              Caption = 'Representative'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label21: TLabel
              Left = 33
              Top = 13
              Width = 77
              Height = 15
              HelpContext = 653155
              Alignment = taRightJustify
              Caption = 'Creation Date'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label1: TLabel
              Left = 15
              Top = 87
              Width = 95
              Height = 15
              HelpContext = 653156
              Alignment = taRightJustify
              Caption = 'Completion Time'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label17: TLabel
              Left = 17
              Top = 50
              Width = 93
              Height = 15
              HelpContext = 653157
              Alignment = taRightJustify
              Caption = 'Completion Date'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblInvoices: TLabel
              Left = 604
              Top = 6
              Width = 40
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653151
              AutoSize = False
              Caption = 'Invoices'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblInvoicesClick
            end
            object lblAppointment: TLabel
              Left = 604
              Top = 25
              Width = 40
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653571
              AutoSize = False
              Caption = 'Appointments'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblAppointmentClick
            end
            object lblbills: TLabel
              Left = 604
              Top = 45
              Width = 40
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653572
              AutoSize = False
              Caption = 'Bills'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblbillsClick
            end
            object lblsmartOrders: TLabel
              Left = 604
              Top = 84
              Width = 40
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653573
              AutoSize = False
              Caption = 'Smart Orders'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblsmartOrdersClick
            end
            object lblRAs: TLabel
              Left = 604
              Top = 144
              Width = 40
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653574
              AutoSize = False
              Caption = 'RAs'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblRAsClick
            end
            object lblSalesOrders: TLabel
              Left = 604
              Top = 65
              Width = 40
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653575
              AutoSize = False
              Caption = 'Orders'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblSalesOrdersClick
            end
            object Label72: TLabel
              Left = 535
              Top = 6
              Width = 61
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653576
              Alignment = taRightJustify
              Caption = 'Invoice(s) :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblInvoicesClick
            end
            object Label73: TLabel
              Left = 503
              Top = 25
              Width = 93
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653577
              Alignment = taRightJustify
              Caption = 'Appointment(s) :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblAppointmentClick
            end
            object Label74: TLabel
              Left = 558
              Top = 45
              Width = 38
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653578
              Alignment = taRightJustify
              Caption = 'Bill(s) :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblbillsClick
            end
            object Label75: TLabel
              Left = 507
              Top = 65
              Width = 89
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653579
              Alignment = taRightJustify
              Caption = 'Sales Order(s) :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblSalesOrdersClick
            end
            object Label76: TLabel
              Left = 504
              Top = 84
              Width = 92
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653580
              Alignment = taRightJustify
              Caption = 'Smart Order(s) :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblsmartOrdersClick
            end
            object Label77: TLabel
              Left = 559
              Top = 144
              Width = 37
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653581
              Alignment = taRightJustify
              Caption = 'RA(s) :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblRAsClick
            end
            object lblEnteredbyHead: TLabel
              Left = 24
              Top = 125
              Width = 86
              Height = 15
              HelpContext = 653470
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Entered By '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblEnteredBy: TDBText
              Left = 115
              Top = 125
              Width = 86
              Height = 15
              HelpContext = 653471
              DataField = 'EnteredBy'
              DataSource = DSMaster
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object lblPOBos: TLabel
              Left = 538
              Top = 124
              Width = 58
              Height = 15
              Cursor = crHandPoint
              Hint = 
                'PO BO(s) is the count of Products in the Backorder - either in t' +
                'he same back order  or different. It doesn'#39't include the Smart O' +
                'rders which are not converted in to a Purchase Order/Back Order'
              HelpContext = 653582
              Alignment = taRightJustify
              Caption = 'PO BO(s) :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              Transparent = True
              OnClick = lblPOBosClick
            end
            object lblPOBSs: TLabel
              Left = 604
              Top = 124
              Width = 40
              Height = 15
              Cursor = crHandPoint
              Hint = 
                'PO BO(s) is the count of Products in the Backorder - either in t' +
                'he same back order  or different. It doesn'#39't include the Smart O' +
                'rders which are not converted in to a Purchase Order/Back Order'
              HelpContext = 653583
              AutoSize = False
              Caption = 'POBOs'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              Transparent = True
              OnClick = lblPOBosClick
            end
            object lblAllgood: TLabel
              Left = 604
              Top = 104
              Width = 40
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653584
              AutoSize = False
              Caption = 'lblAllgood'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblAllgoodClick
            end
            object Label80: TLabel
              Left = 482
              Top = 104
              Width = 114
              Height = 15
              Cursor = crHandPoint
              HelpContext = 653585
              Alignment = taRightJustify
              Caption = 'All Good Received? :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              OnClick = lblsmartOrdersClick
            end
            object lblArea: TLabel
              Left = 239
              Top = 122
              Width = 75
              Height = 15
              HelpContext = 653472
              Caption = 'Area Number'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Bevel19: TBevel
              AlignWithMargins = True
              Left = 350
              Top = 1
              Width = 126
              Height = 166
              HelpContext = 653624
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Shape = bsFrame
              ExplicitLeft = 346
              ExplicitTop = 3
              ExplicitHeight = 163
            end
            object Label3: TLabel
              Left = 387
              Top = 6
              Width = 83
              Height = 15
              HelpContext = 653625
              Alignment = taRightJustify
              Caption = 'Contract Value'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label14: TLabel
              Left = 371
              Top = 55
              Width = 99
              Height = 30
              HelpContext = 653626
              Alignment = taRightJustify
              Caption = 'Suggested Sales Amount'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label27: TLabel
              Left = 384
              Top = 120
              Width = 86
              Height = 15
              HelpContext = 653627
              Alignment = taRightJustify
              Caption = 'Estimated Cost'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Bevel18: TBevel
              AlignWithMargins = True
              Left = 650
              Top = 1
              Width = 140
              Height = 166
              HelpContext = 653682
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Shape = bsFrame
              ExplicitLeft = 651
            end
            object cboClass: TwwDBLookupCombo
              Left = 239
              Top = 16
              Width = 99
              Height = 23
              HelpContext = 653158
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'ClassName'#9'30'#9'ClassName'#9'T')
              DataField = 'ClassID'
              DataSource = DSMaster
              LookupTable = cboClassQry
              LookupField = 'ClassID'
              ParentFont = False
              TabOrder = 3
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object cboEmployee: TwwDBLookupCombo
              Left = 239
              Top = 97
              Width = 99
              Height = 23
              HelpContext = 653159
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'EmployeeName'#9'46'#9'Employee Name'#9'F')
              DataField = 'EmployeeID'
              DataSource = DSMaster
              LookupTable = qryEmployees
              LookupField = 'EmployeeID'
              ParentFont = False
              TabOrder = 5
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object dtCreationDate: TwwDBDateTimePicker
              Left = 115
              Top = 9
              Width = 99
              Height = 23
              HelpContext = 653160
              AutoFillDateAndTime = True
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'Arial'
              CalendarAttributes.Font.Style = []
              DataField = 'CreationDate'
              DataSource = DSMaster
              Epoch = 1950
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ShowButton = False
              TabOrder = 0
              UnboundDataType = wwDTEdtDate
            end
            object cboStatus: TwwDBLookupCombo
              Left = 239
              Top = 56
              Width = 99
              Height = 23
              HelpContext = 653161
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              DataField = 'Status'
              DataSource = DSMaster
              LookupTable = qryStatus
              LookupField = 'Name'
              ParentFont = False
              TabOrder = 4
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnDblClick = cboStatusDblClick
              OnNotInList = cboStatusNotInList
            end
            object cboJobDueDate: TwwDBDateTimePicker
              Left = 115
              Top = 47
              Width = 99
              Height = 23
              HelpContext = 653163
              AutoFillDateAndTime = True
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'Arial'
              CalendarAttributes.Font.Style = []
              DataField = 'JobDueDate'
              DataSource = DSMaster
              Epoch = 1950
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ShowButton = True
              TabOrder = 1
              UnboundDataType = wwDTEdtDate
            end
            object cboTime: TwwDBComboBox
              Left = 115
              Top = 86
              Width = 99
              Height = 23
              HelpContext = 653164
              ShowButton = True
              Style = csDropDownList
              MapList = False
              AllowClearKey = False
              AutoDropDown = True
              DataField = 'CompletionTime'
              DataSource = DSMaster
              DropDownCount = 8
              DropDownWidth = 121
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ItemHeight = 0
              Items.Strings = (
                '12:00 AM'
                '12:15 AM'
                '12:30 AM'
                '12:45 AM'
                '01:00 AM'
                '01:15 AM'
                '01:30 AM'
                '01:45 AM'
                '02:00 AM'
                '02:15 AM'
                '02:30 AM'
                '02:45 AM'
                '03:00 AM'
                '03:15 AM'
                '03:30 AM'
                '03:45 AM'
                '04:00 AM'
                '04:15 AM'
                '04:30 AM'
                '04:45 AM'
                '05:00 AM'
                '05:15 AM'
                '05:30 AM'
                '05:45 AM'
                '06:00 AM'
                '06:15 AM'
                '06:30 AM'
                '06:45 AM'
                '07:00 AM'
                '07:15 AM'
                '07:30 AM'
                '07:45 AM'
                '08:00 AM'
                '08:15 AM'
                '08:30 AM'
                '08:45 AM'
                '09:00 AM'
                '09:15 AM'
                '09:30 AM'
                '09:45 AM'
                '10:00 AM'
                '10:15 AM'
                '10:30 AM'
                '10:45 AM'
                '11:00 AM'
                '11:15 AM'
                '11:30 AM'
                '11:45 AM'
                '12:00 PM'
                '12:15 PM'
                '12:30 PM'
                '12:45 PM'
                '01:00 PM'
                '01:15 PM'
                '01:30 PM'
                '01:45 PM'
                '02:00 PM'
                '02:15 PM'
                '02:30 PM'
                '02:45 PM'
                '03:00 PM'
                '03:15 PM'
                '03:30 PM'
                '03:45 PM'
                '04:00 PM'
                '04:15 PM'
                '04:30 PM'
                '04:45 PM'
                '05:00 PM'
                '05:15 PM'
                '05:30 PM'
                '05:45 PM'
                '06:00 PM'
                '06:15 PM'
                '06:30 PM'
                '06:45 PM'
                '07:00 PM'
                '07:15 PM'
                '07:30 PM'
                '07:45 PM'
                '08:00 PM'
                '08:15 PM'
                '08:30 PM'
                '08:45 PM'
                '09:00 PM'
                '09:15 PM'
                '09:30 PM'
                '09:45 PM'
                '10:00 PM'
                '10:15 PM'
                '10:30 PM'
                '10:45 PM'
                '11:00 PM'
                '11:15 PM'
                '11:30 PM'
                '11:45 PM')
              ParentFont = False
              Sorted = False
              TabOrder = 2
              UnboundDataType = wwDefault
            end
            object cboAreaCode: TwwDBLookupCombo
              Left = 239
              Top = 138
              Width = 102
              Height = 23
              HelpContext = 653473
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'AreaCode'#9'10'#9'Code'#9'F'
                'AreaName'#9'20'#9'Name'#9'F')
              DataField = 'Area'
              DataSource = DSMaster
              LookupTable = QryAreaCodes
              LookupField = 'AreaCode'
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object edtEstimatedCost: TwwDBEdit
              Left = 354
              Top = 138
              Width = 116
              Height = 23
              HelpContext = 653630
              DataField = 'EstimatedCost'
              DataSource = DSMaster
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
            object edtSalesAmount: TwwDBEdit
              Left = 354
              Top = 87
              Width = 116
              Height = 23
              HelpContext = 653631
              DataField = 'SuggestedSalesAmount'
              DataSource = DSMaster
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
            object edtContractValue: TwwDBEdit
              Left = 354
              Top = 24
              Width = 116
              Height = 23
              HelpContext = 653632
              DataField = 'ContractValue'
              DataSource = DSMaster
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
            end
            object btnTotalCost: TDNMSpeedButton
              AlignWithMargins = True
              Left = 655
              Top = 6
              Width = 130
              Height = 23
              HelpContext = 653628
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 1
              Alignment = taRightJustify
              Caption = 'Total Cost '
              Color = clGrayText
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentColor = False
              ParentFont = False
              Style = bsModern
              TabOrder = 10
              AutoDisableParentOnclick = True
              OnClick = btnTotalCostClick
            end
            object txtCost: TEdit
              AlignWithMargins = True
              Left = 655
              Top = 31
              Width = 130
              Height = 23
              HelpContext = 653586
              Margins.Left = 5
              Margins.Top = 1
              Margins.Right = 5
              Margins.Bottom = 1
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 11
              Text = '0.00'
              OnDblClick = txtCostDblClick
            end
            object btnTotalAmount: TDNMSpeedButton
              AlignWithMargins = True
              Left = 655
              Top = 59
              Width = 130
              Height = 23
              HelpContext = 653629
              Margins.Left = 5
              Margins.Top = 4
              Margins.Right = 5
              Margins.Bottom = 1
              Alignment = taRightJustify
              Caption = 'Total Amount '
              Color = clGrayText
              DisableTransparent = False
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentColor = False
              ParentFont = False
              Style = bsModern
              TabOrder = 12
              AutoDisableParentOnclick = True
              OnClick = btnTotalAmountClick
            end
            object txtTotal: TEdit
              AlignWithMargins = True
              Left = 655
              Top = 84
              Width = 130
              Height = 23
              HelpContext = 653162
              Margins.Left = 5
              Margins.Top = 1
              Margins.Right = 5
              Margins.Bottom = 1
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 13
              Text = '0.00'
              OnDblClick = txtTotalDblClick
            end
            object btnShowTotalAmountInc: TDNMSpeedButton
              AlignWithMargins = True
              Left = 655
              Top = 112
              Width = 130
              Height = 23
              HelpContext = 653683
              Margins.Left = 5
              Margins.Top = 4
              Margins.Right = 5
              Margins.Bottom = 1
              Alignment = taRightJustify
              Caption = 'Total Invoiced Amt '
              Color = clGrayText
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentColor = False
              ParentFont = False
              Style = bsModern
              TabOrder = 14
              AutoDisableParentOnclick = True
              OnClick = btnShowTotalAmountIncClick
            end
            object edtInvoicetotal: TEdit
              AlignWithMargins = True
              Left = 655
              Top = 137
              Width = 130
              Height = 23
              HelpContext = 653684
              Margins.Left = 5
              Margins.Top = 1
              Margins.Right = 5
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 15
              OnDblClick = edtInvoicetotalDblClick
            end
          end
        end
        object tabFollowupnProducts: TTabSheet
          HelpContext = 653053
          Caption = 'Products'
          ImageIndex = 1
          object DNMPanel7: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653054
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Transparent = False
            DesignSize = (
              791
              423)
            object Label20: TLabel
              Left = 75
              Top = 1
              Width = 121
              Height = 16
              HelpContext = 653055
              Caption = '(F9 to enter barcode)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object grdParts: TwwDBGrid
              Left = 1
              Top = 1
              Width = 789
              Height = 421
              HelpContext = 653056
              ControlType.Strings = (
                'PartName;CustomEdit;cboProductR;F'
                'Discount;CustomEdit;edDiscountMarkup;F'
                'ClassName;CustomEdit;cboClassRepairParts;F'
                'ConvertToInvoice;CheckBox;T;F'
                'ETADate;CustomEdit;edtETADate;F'
                'Equipment;CustomEdit;cboEquipname;F'
                'UnitofMeasure;CustomEdit;cboUnitOfMeasure;F'
                'Deleted;CheckBox;T;F'
                'MemoLine;CustomEdit;edtMemoLine;F'
                'TaxCode;CustomEdit;cboTax;F')
              Selected.Strings = (
                'PartBarcode'#9'10'#9'PartBarcode'#9'F'#9
                'PartName'#9'20'#9'Name'#9#9
                'UOMQty'#9'8'#9'Quantity'#9#9
                'Equipment'#9'16'#9'Equipment~(Choose First)'#9'F'#9
                'UnitofMeasure'#9'8'#9'Unit'#9#9
                'Description'#9'31'#9'Description'#9#9
                'PriceEx'#9'10'#9'Price (Ex)'#9#9
                'TaxCode'#9'15'#9'Code'#9'T'#9
                'calcTax'#9'7'#9'Tax Rate'#9#9
                'DiscountPercent'#9'10'#9'Discount (%)'#9#9
                'Discount'#9'10'#9'Discount'#9#9
                'MarkupPercent'#9'10'#9'Markup (%)'#9#9
                'Markup'#9'10'#9'Markup'#9#9
                'ConvertToInvoice'#9'1'#9'Convert To~Invoice'#9'T'#9
                'ClassName'#9'21'#9'Department'#9#9
                'MemoLine'#9'10'#9'Memo'#9#9
                'Deleted'#9'1'#9'Deleted'#9#9
                'PartIssuedOn'#9'18'#9'Part~Issued On'#9#9
                'Linecost'#9'10'#9'Line Cost'#9#9
                'LinecostInc'#9'10'#9'Line Cost(Inc)'#9#9
                'SerialNos'#9'10'#9'Serial No(s)'#9#9
                'MatrixDesc'#9'10'#9'Matrix Details'#9#9
                'MatrixPrice'#9'10'#9'Matrix Price'#9#9
                'Custfld1'#9'10'#9'Custfld1'#9#9
                'CustFld2'#9'10'#9'CustFld2'#9#9
                'CustFld3'#9'10'#9'CustFld3'#9#9
                'CustFld4'#9'10'#9'CustFld4'#9#9
                'CustFld5'#9'10'#9'CustFld5'#9#9
                'CustFld6'#9'10'#9'CustFld6'#9#9
                'CustFld7'#9'10'#9'CustFld7'#9#9
                'CustFld8'#9'10'#9'CustFld8'#9#9
                'CustFld9'#9'10'#9'CustFld9'#9#9
                'CustFld10'#9'10'#9'CustFld10'#9#9
                'FormulaQtyValue'#9'10'#9'FormulaQtyValue'#9#9
                'FormulaQtyValue1'#9'10'#9'FormulaQtyValue1'#9#9
                'FormulaQtyValue2'#9'10'#9'FormulaQtyValue2'#9#9
                'FormulaQtyValue3'#9'10'#9'FormulaQtyValue3'#9#9
                'FormulaQtyValue4'#9'10'#9'FormulaQtyValue4'#9#9
                'FormulaQtyValue5'#9'10'#9'FormulaQtyValue5'#9#9
                'SerialNo'#9'20'#9'SerialNo'#9'F'#9
                'Manucature'#9'20'#9'Manucature'#9'F'#9
                'Model'#9'20'#9'Model'#9'F'#9
                'Registration'#9'20'#9'Registration'#9'F'#9
                'PurchaseLineId'#9'10'#9'PurchaseLineId'#9'F'#9)
              MemoAttributes = [mSizeable, mWordWrap, mGridShow]
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              OnRowChanged = grdPartsRowChanged
              FixedCols = 0
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              Align = alClient
              DataSource = dsrepairparts
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgRowResize]
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 6
              TitleAlignment = taLeftJustify
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 2
              TitleButtons = True
              OnCalcCellColors = grdPartsCalcCellColors
              OnCalcTitleAttributes = grdPartsCalcTitleAttributes
              OnTitleButtonClick = grdPartsTitleButtonClick
              OnColEnter = grdPartsColEnter
              OnDblClick = grdPartsDblClick
              OnEnter = grdPartsEnter
              OnExit = grdPartsExit
              OnKeyDown = grdPartsKeyDown
              OnKeyUp = grdPartsKeyUp
              OnUpdateFooter = grdPartsUpdateFooter
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
                HelpContext = 653057
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
            object cboTax: TwwDBLookupCombo
              Left = 472
              Top = 29
              Width = 41
              Height = 23
              HelpContext = 653059
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Name'#9'5'#9'Name'#9'F'
                'Rate'#9'5'#9'Rate'#9'F')
              DataField = 'TaxCode'
              DataSource = dsrepairparts
              LookupTable = TaxCodeDetails
              LookupField = 'Name'
              TabOrder = 2
              AutoDropDown = False
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object cboClassRepairParts: TwwDBLookupCombo
              Left = 454
              Top = 84
              Width = 154
              Height = 23
              HelpContext = 653060
              Anchors = []
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'ClassName'#9'30'#9'ClassName'#9'T')
              DataField = 'ClassName'
              DataSource = dsrepairparts
              LookupTable = qryClass
              LookupField = 'ClassName'
              Style = csDropDownList
              ParentFont = False
              TabOrder = 1
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboClassRepairPartsCloseUp
            end
            object edtETADate: TwwDBEdit
              Left = 736
              Top = 37
              Width = 121
              Height = 23
              HelpContext = 653061
              DataField = 'ETADate'
              DataSource = dsrepairparts
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              OnDblClick = edtETADateDblClick
            end
            object cboUnitOfMeasure: TwwDBLookupCombo
              Left = 243
              Top = 20
              Width = 85
              Height = 26
              HelpContext = 653063
              AutoSize = False
              DropDownAlignment = taLeftJustify
              DataField = 'UnitofMeasure'
              DataSource = dsrepairparts
              LookupTable = qryUnitOfMeasure
              LookupField = 'UnitName'
              TabOrder = 5
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboUnitOfMeasureCloseUp
            end
            object cboProductR: TERPDbLookupCombo
              Left = 334
              Top = 30
              Width = 113
              Height = 23
              HelpContext = 653058
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'PARTNAME'#9'15'#9'Name'#9'F'
                'Manuf'#9'10'#9'Manuf'#9'F'
                'Type'#9'15'#9'Type'#9'F'
                'Dept'#9'10'#9'Dept'#9'F'
                'PARTSDESCRIPTION'#9'50'#9'PARTSDESCRIPTION'#9'F'
                'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
              DataField = 'PartName'
              DataSource = dsrepairparts
              LookupTable = qryParts
              LookupField = 'Partname'
              Options = [loTitles]
              TabOrder = 3
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnChange = cboProductRChange
              OnDblClick = cboProductRDblClick
              OnDropDown = cboProductRDropDown
              OnCloseUp = cboProductRCloseUp
              LookupFormClassName = 'TProductListExpressGUI'
              EditFormClassName = 'TfrmParts'
              LookupFormKeyStringFieldName = 'ProductName'
              LookupComboType = ctProduct
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = True
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
              DataIDField = 'PartsID'
              LookupIDField = 'PartsID'
              LookupFieldAlt = 'ProductPrintName'
            end
            object edtMemoLine: TwwDBEdit
              Left = 544
              Top = 56
              Width = 121
              Height = 23
              HelpContext = 653474
              DataField = 'MemoLine'
              DataSource = dsrepairparts
              TabOrder = 7
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              OnDblClick = edtMemoLineDblClick
            end
            object cboEquipname: TwwDBLookupCombo
              Left = 116
              Top = 23
              Width = 121
              Height = 23
              HelpContext = 653062
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'EquipName'#9'15'#9'Name'#9'F'
                'Manufacture'#9'10'#9'Manufacture'#9'F'
                'model'#9'10'#9'Model'#9'F'
                'Registration'#9'10'#9'Registration'#9'F'
                'Serialno'#9'10'#9'Serial#'#9'F'
                'WarantyFinishDate'#9'18'#9'Warranty Finish Date'#9'F'
                'WarantyPeriod'#9'10'#9'Warranty Period'#9'F')
              DataField = 'Equipment'
              DataSource = dsrepairparts
              LookupTable = qryPartsEquip
              LookupField = 'EquipName'
              Options = [loTitles]
              TabOrder = 4
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnDblClick = cboEquipnameDblClick
              OnCloseUp = cboEquipnameCloseUp
              OnNotInList = cboEquipnameNotInList
            end
            object cboPrintProductR: TERPDbLookupCombo
              Left = 342
              Top = 38
              Width = 113
              Height = 23
              HelpContext = 653689
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'PARTNAME'#9'15'#9'Name'#9'F'
                'Manuf'#9'10'#9'Manuf'#9'F'
                'Type'#9'15'#9'Type'#9'F'
                'Dept'#9'10'#9'Dept'#9'F'
                'PARTSDESCRIPTION'#9'50'#9'PARTSDESCRIPTION'#9'F'
                'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
              DataField = 'PartName'
              DataSource = dsrepairparts
              LookupTable = qryParts
              LookupField = 'Partname'
              Options = [loTitles]
              TabOrder = 8
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnChange = cboProductRChange
              OnDblClick = cboProductRDblClick
              OnDropDown = cboProductRDropDown
              OnCloseUp = cboProductRCloseUp
              LookupFormClassName = 'TProductListExpressGUI'
              EditFormClassName = 'TfrmParts'
              LookupFormKeyStringFieldName = 'ProductName'
              LookupComboType = ctProduct
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = True
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
              DataIDField = 'PartsID'
              LookupIDField = 'PartsID'
              LookupFieldAlt = 'ProductPrintName'
            end
          end
        end
        object tabEquipment: TTabSheet
          HelpContext = 653064
          Caption = 'Equipment'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            HelpContext = 653065
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
            OnClick = btnDeleteClick
          end
          object wwIButton2: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            HelpContext = 653066
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
            OnClick = btnDeleteClick
          end
          object pnlEquipments: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653067
            Align = alClient
            BevelOuter = bvNone
            Caption = '"TfmEquipmentxRef" is dynamically created here at run time'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
        end
        object tabAssets: TTabSheet
          HelpContext = 653475
          Caption = 'Assets'
          ImageIndex = 12
          object grdAssets: TwwDBGrid
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653476
            ControlType.Strings = (
              'AssetId;CustomEdit;cboAsset;F'
              'AssetName;CustomEdit;cboAssetName;F'
              'AssetCode;CustomEdit;cboAssetCode;F')
            Selected.Strings = (
              'AssetName'#9'20'#9'Asset Name'
              'AssetCode'#9'10'#9'Asset Code'
              'PurchaseDate'#9'10'#9'Purchase Date'
              'PurchaseCost'#9'10'#9'Purchase Cost'
              'BrandName'#9'10'#9'Brand Name'
              'Manufacture'#9'10'#9'Manufacture'
              'Model'#9'10'#9'Model'
              'Serial'#9'10'#9'Serial'
              'Notes'#9'27'#9'Notes')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = dsAssetXRef
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            FooterColor = clWhite
            object btnDeleteAsset: TwwIButton
              Left = 0
              Top = 0
              Width = 22
              Height = 22
              HelpContext = 653477
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
              OnClick = btnDeleteAssetClick
            end
          end
          object cboAssetName: TwwDBLookupCombo
            Left = 496
            Top = 24
            Width = 121
            Height = 23
            HelpContext = 653478
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AssetName'#9'20'#9'Asset Name'#9'F')
            DataField = 'AssetId'
            DataSource = dsAssetXRef
            LookupTable = qryAssetLookup
            LookupField = 'AssetID'
            ParentFont = False
            TabOrder = 1
            AutoDropDown = False
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object cboAssetCode: TwwDBLookupCombo
            Left = 504
            Top = 64
            Width = 121
            Height = 23
            HelpContext = 653479
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'AssetCode'#9'20'#9'Asset Code'#9'F')
            DataField = 'AssetCode'
            DataSource = dsAssetXRef
            LookupTable = qryAssetLookup
            LookupField = 'AssetID'
            ParentFont = False
            TabOrder = 2
            AutoDropDown = False
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
        end
        object tabTimesheetEntries: TTabSheet
          HelpContext = 653068
          Caption = 'Timesheet'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnltimesheetentries: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653069
            Align = alClient
            Caption = '"TfrmTimeSheet" is dynamically created here at run time'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
        end
        object tabNotes: TTabSheet
          HelpContext = 653076
          Caption = 'Notes'
          ImageIndex = 5
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Splitter1: TSplitter
            Left = 0
            Top = 281
            Width = 791
            Height = 3
            Cursor = crVSplit
            HelpContext = 653480
            Align = alBottom
            Beveled = True
            ExplicitTop = 279
            ExplicitWidth = 741
          end
          object DNMPanel4: TDNMPanel
            Left = 0
            Top = 284
            Width = 791
            Height = 139
            HelpContext = 653077
            Align = alBottom
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              791
              139)
            object lblTmrMsg: TLabel
              Left = 0
              Top = 121
              Width = 791
              Height = 18
              HelpContext = 653587
              Align = alBottom
              Alignment = taCenter
              AutoSize = False
              Caption = 'Timer Msg'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Visible = False
              ExplicitTop = 122
              ExplicitWidth = 741
            end
            object Label70: TLabel
              Left = 4
              Top = 7
              Width = 73
              Height = 15
              HelpContext = 653078
              Caption = 'Attachments'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object btnAttachments: TDNMSpeedButton
              Left = 665
              Top = 4
              Width = 65
              Height = 22
              HelpContext = 653082
              Caption = 'Attach'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
                000557777777777777750BBBBBBBBBBBBBB07F5555FFFFFFF5570BBBB0000000
                BBB07F5557777777FF570BBB077BBB770BB07F557755555775570BBBBBBBBBBB
                BBB07F5555FFFFFFF5570BBBB0000000BBB07F5557777777F5570BBBB0FFFFF0
                BBB07F5557FFFFF7F5570BBBB0000000BBB07F555777777755570BBBBBBBBBBB
                BBB07FFFFFFFFFFFFFF700000000000000007777777777777777500FFFFFFFFF
                F005577FF555FFFFF7755500FFF00000005555775FF7777777F5550F777FFFFF
                F055557F777FFF5557F5550000000FFF00555577777775FF77F5550777777000
                7055557FFFFFF777F7F555000000000000555577777777777755}
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 0
              Visible = False
              AutoDisableParentOnclick = True
              OnClick = btnAttachmentsClick
            end
            object pnlAttachments: TPanel
              Left = 1
              Top = 28
              Width = 786
              Height = 90
              HelpContext = 653481
              Anchors = [akLeft, akTop, akRight, akBottom]
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Color = clWhite
              TabOrder = 1
            end
          end
          object pnlNotesTop: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 281
            HelpContext = 653482
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnResize = pnlNotesTopResize
            object Label4: TLabel
              Left = 4
              Top = 2
              Width = 33
              Height = 15
              HelpContext = 653588
              Caption = 'Notes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label11: TLabel
              Left = 373
              Top = 2
              Width = 91
              Height = 15
              HelpContext = 653079
              Caption = 'Feedback Notes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object txtNotes: TAddictSpellDBMemo
              Left = 4
              Top = 18
              Width = 363
              Height = 257
              HelpContext = 653081
              DataField = 'Notes'
              DataSource = DSMaster
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              PopupMenu = popInsert
              ScrollBars = ssVertical
              TabOrder = 0
              OnDblClick = txtNotesDblClick
              OnEnter = UnlockedcompOnenter
              OnExit = UnlockedcompOnexit
            end
            object txtFeedbackNotes: TAddictSpellDBMemo
              Left = 373
              Top = 18
              Width = 356
              Height = 257
              HelpContext = 653483
              DataField = 'FeedbackNotes'
              DataSource = DSMaster
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              PopupMenu = popInsert
              ScrollBars = ssVertical
              TabOrder = 1
              OnDblClick = txtFeedbackNotesDblClick
              OnEnter = UnlockedcompOnenter
              OnExit = UnlockedcompOnexit
            end
            object DNMSpeedButton3: TDNMSpeedButton
              Left = 292
              Top = 0
              Width = 75
              Height = 18
              HelpContext = 653621
              Caption = 'Add Date'
              DisableTransparent = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              AutoDisableParentOnclick = True
              OnClick = DNMSpeedButton3Click
            end
            object DNMSpeedButton4: TDNMSpeedButton
              Left = 654
              Top = 0
              Width = 75
              Height = 18
              HelpContext = 653622
              Caption = 'Add Date'
              DisableTransparent = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              AutoDisableParentOnclick = True
              OnClick = DNMSpeedButton4Click
            end
          end
        end
        object tabInvoices: TTabSheet
          HelpContext = 653484
          Caption = 'Invoices'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ImageIndex = 6
          ParentFont = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel6: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653485
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object grdInvoices: TwwDBGrid
              Left = 1
              Top = 1
              Width = 789
              Height = 421
              HelpContext = 653486
              ControlType.Strings = (
                'Deleted;CheckBox;T;F')
              Selected.Strings = (
                'SaleID'#9'10'#9'Sale#'#9#9
                'CustomerName'#9'24'#9'Customer'#9#9
                'EmployeeName'#9'15'#9'Employee'#9#9
                'SaleDate'#9'12'#9'Sale Date'#9#9
                'TotalAmountInc'#9'14'#9'Total Amount(Inc)'#9#9
                'Payment'#9'10'#9'Payment'#9#9
                'Balance'#9'10'#9'Balance'#9#9
                'Terms'#9'15'#9'Terms'#9#9
                'Class'#9'13'#9'Class'#9#9
                'Deleted'#9'1'#9'Deleted'#9'F'#9
                'TotalAmount'#9'10'#9'TotalAmount'#9'F'#9)
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alClient
              DataSource = dsInvoices
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              OnDblClick = grdInvoicesDblClick
              FooterColor = clWhite
            end
          end
        end
        object tabappointment: TTabSheet
          HelpContext = 653487
          Caption = 'Appointments'
          ImageIndex = 7
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel5: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653488
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object grdAppointments: TwwDBGrid
              Left = 1
              Top = 1
              Width = 789
              Height = 421
              HelpContext = 653489
              Selected.Strings = (
                'AppointID'#9'8'#9'Appoint~No'#9'F'
                'CustomerDetails'#9'20'#9'Customer'#9'F'
                'AppDate'#9'12'#9'Scheduled'#9'F'#9'Date'
                'Actual_AppDate'#9'12'#9'Started'#9'F'#9'Date'
                'Actual_Endtime'#9'18'#9'Ended'#9'F'#9'Date'
                'ServiceDesc'#9'15'#9'Service'#9'F'
                'TotalInc'#9'10'#9'Total Amount'#9'F'
                'Status'#9'10'#9'Status'#9'F'
                'Notes'#9'20'#9'Notes'#9'F'
                'Rep'#9'15'#9'Rep'#9'F')
              MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alClient
              DataSource = dsAppointments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 2
              TitleButtons = False
              UseTFields = False
              OnDblClick = grdAppointmentsDblClick
              FooterColor = clWhite
            end
          end
        end
        object tabBills: TTabSheet
          HelpContext = 653490
          Caption = 'Bills'
          ImageIndex = 10
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          DesignSize = (
            791
            423)
          object Label58: TLabel
            Left = 515
            Top = 403
            Width = 80
            Height = 15
            HelpContext = 653491
            Anchors = [akLeft, akBottom]
            Caption = 'Bill Total Price'
            ExplicitTop = 378
          end
          object grdBills: TwwDBGrid
            Left = 0
            Top = 0
            Width = 791
            Height = 386
            HelpContext = 653492
            ControlType.Strings = (
              'Deleted;CheckBox;T;F')
            Selected.Strings = (
              'PurchaseOrderNumber'#9'9'#9'Bill #'#9'F'
              'SupplierName'#9'15'#9'Supplier'#9'F'
              'AccountName'#9'20'#9'Account'#9'F'
              'EquipmentName'#9'20'#9'Equipment'#9'F'
              'LineTaxCode'#9'10'#9'Tax Code'#9'F'
              'LineTaxRate'#9'10'#9'Tax Rate'#9'F'
              'TotalLineAmount'#9'15'#9'Amount(Ex)'#9'F'
              'LineTax'#9'10'#9'Tax'#9'F'
              'TotalLineAmountInc'#9'15'#9'Amount(Inc)'#9'F'
              'InvoiceNumber'#9'15'#9'Invoice No'#9'F'
              'Deleted'#9'1'#9'Deleted'#9'F')
            MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alTop
            DataSource = dsBills
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
            ParentFont = False
            PopupMenu = popCustomiseGrid
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
            OnDblClick = grdBillsDblClick
            FooterColor = clWhite
          end
          object edtBillPrice: TwwDBEdit
            Left = 601
            Top = 399
            Width = 121
            Height = 23
            HelpContext = 653493
            Anchors = [akLeft, akBottom]
            DataField = 'BilltotalPrice'
            DataSource = DSMaster
            TabOrder = 1
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
        end
        object tabSmartOrders: TTabSheet
          HelpContext = 653494
          Caption = 'Smart Orders'
          ImageIndex = 9
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel9: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653495
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object SmartOrderSpliter: TSplitter
              Left = 232
              Top = 1
              Width = 2
              Height = 421
              HelpContext = 653496
              ExplicitHeight = 347
            end
            object grdSmartOrder: TwwDBGrid
              Left = 234
              Top = 1
              Width = 556
              Height = 421
              HelpContext = 653497
              Selected.Strings = (
                'ClassName'#9'10'#9'Department'#9'F'
                'PARTSNAME'#9'10'#9'Product'#9'F'
                'Qty'#9'8'#9'Order~Quantity'#9'F'
                'UnitofMeasure'#9'10'#9'Unit of ~Measure'#9'F'
                'PurchaseOrderID'#9'8'#9'PO#'#9'F'
                'POInvoiceNumber'#9'10'#9'PO Invoice No'#9'F'
                'QtySold'#9'8'#9'Qty~Ordered'#9'F'
                'Shipped'#9'8'#9'Qty'#9'F'#9'Received'
                'TotalLineAmount'#9'10'#9'Cost'#9'F'#9'Received'
                'BackOrder'#9'8'#9'Qty'#9'F'#9'BackOrder'
                'BackOrdercost'#9'10'#9'Cost'#9'F'#9'BackOrder')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alClient
              DataSource = dsSmartOrders
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 2
              TitleButtons = False
              UseTFields = False
              OnDblClick = grdSmartOrderDblClick
              FooterColor = clWhite
            end
            object grdSO: TwwDBGrid
              Left = 1
              Top = 1
              Width = 231
              Height = 421
              HelpContext = 653498
              Selected.Strings = (
                'SmartOrderID'#9'8'#9'ID'#9'F'
                'SmartOrderDesc'#9'19'#9'Description'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alLeft
              DataSource = dsSmartOrderHeader
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 1
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              UseTFields = False
              OnDblClick = grdSODblClick
              FooterColor = clWhite
            end
          end
        end
        object tabSalesOrders: TTabSheet
          HelpContext = 653499
          Caption = 'Sales Orders'
          ImageIndex = 11
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object grdSalesOrders: TwwDBGrid
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653500
            ControlType.Strings = (
              'Deleted;CheckBox;T;F')
            Selected.Strings = (
              'SaleID'#9'10'#9'Sale#'#9#9
              'CustomerName'#9'24'#9'Customer'#9#9
              'EmployeeName'#9'15'#9'Employee'#9#9
              'SaleDate'#9'12'#9'Sale Date'#9#9
              'TotalAmountInc'#9'14'#9'Total Amount(Inc)'#9#9
              'Payment'#9'10'#9'Payment'#9#9
              'Balance'#9'10'#9'Balance'#9#9
              'Terms'#9'15'#9'Terms'#9#9
              'Class'#9'13'#9'Class'#9#9
              'QuoteStatus'#9'255'#9'QuoteStatus'#9'F'#9
              'Deleted'#9'1'#9'Deleted'#9'F'#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = dsSalesOrders
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            ParentFont = False
            PopupMenu = popCustomiseGrid
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            OnDblClick = grdSalesOrdersDblClick
            FooterColor = clWhite
          end
        end
        object tabRa: TTabSheet
          HelpContext = 653070
          Caption = 'Return Authorities'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel10: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653501
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object RASpliter: TSplitter
              Left = 328
              Top = 1
              Width = 2
              Height = 421
              HelpContext = 653502
              ExplicitHeight = 347
            end
            object grdRAs: TwwDBGrid
              Left = 330
              Top = 1
              Width = 460
              Height = 421
              HelpContext = 653503
              Selected.Strings = (
                'Class'#9'10'#9'Class'#9'F'
                'ProductName'#9'10'#9'Product'#9'F'
                'UnitofMeasureShipped'#9'10'#9'Quantity'#9'F'
                'UOM'#9'20'#9'UOM'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alClient
              DataSource = dsRAs
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
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
              OnDblClick = grdRAsDblClick
              FooterColor = clWhite
            end
            object grdRAHeader: TwwDBGrid
              Left = 1
              Top = 1
              Width = 327
              Height = 421
              HelpContext = 653504
              ControlType.Strings = (
                'Deleted;CheckBox;T;F')
              Selected.Strings = (
                'PurchaseOrderID'#9'10'#9'ID#'#9'F'
                'OrderDate'#9'10'#9'Date'#9'F'
                'SupplierName'#9'20'#9'Supplier'#9'F'
                'Deleted'#9'1'#9'Deleted'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alLeft
              DataSource = dsRAHeaders
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 1
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              UseTFields = False
              OnDblClick = grdRAHeaderDblClick
              FooterColor = clWhite
            end
          end
        end
        object TabFaultsnfollowups: TTabSheet
          HelpContext = 653505
          Caption = 'Faults/Follow Up'
          ImageIndex = 14
          object FaultsSpliter: TSplitter
            Left = 434
            Top = 0
            Width = 2
            Height = 423
            HelpContext = 653506
            ExplicitLeft = 431
            ExplicitTop = -2
            ExplicitHeight = 398
          end
          object pnlRepairFaults: TDNMPanel
            Left = 0
            Top = 0
            Width = 434
            Height = 423
            HelpContext = 653589
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Transparent = False
            object grdRepairFaults: TwwDBGrid
              Left = 1
              Top = 1
              Width = 432
              Height = 421
              HelpContext = 653590
              ControlType.Strings = (
                'Equipment;CustomEdit;cboEquipment;F'
                'Done;CheckBox;T;F'
                'RepairFault;CustomEdit;cboRepairFault;F')
              Selected.Strings = (
                'Equipment'#9'26'#9'Equipment'
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
              object wwIButton3: TwwIButton
                Left = 0
                Top = 0
                Width = 23
                Height = 34
                Hint = 'Delete Current Part Line'
                HelpContext = 653591
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
                OnClick = wwIButton3Click
              end
            end
            object cboRepairFault: TwwDBLookupCombo
              Left = 349
              Top = 46
              Width = 121
              Height = 23
              HelpContext = 653507
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
            object cboEquipment: TwwDBLookupCombo
              Left = 197
              Top = 48
              Width = 121
              Height = 23
              HelpContext = 653592
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'EquipName'#9'15'#9'Name'#9'F'
                'Manufacture'#9'10'#9'Manufacture'#9'F'
                'model'#9'10'#9'Model'#9'F'
                'Registration'#9'10'#9'Registration'#9'F'
                'Serialno'#9'10'#9'Serial#'#9'F'
                'WarantyFinishDate'#9'18'#9'Warranty Finish Date'#9'F'
                'WarantyPeriod'#9'10'#9'Warranty Period'#9'F')
              DataField = 'Equipment'
              DataSource = dsrepairsFaults
              LookupTable = QryRepairFaultsEquip
              LookupField = 'EquipName'
              Options = [loTitles]
              TabOrder = 2
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnDblClick = cboEquipmentDblClick
              OnCloseUp = cboEquipmentCloseUp
              OnNotInList = cboEquipmentNotInList
            end
          end
          object DNMPanel3: TDNMPanel
            Left = 436
            Top = 0
            Width = 355
            Height = 423
            HelpContext = 653071
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            Transparent = False
            object dtpFollowUpDate: TwwDBDateTimePicker
              Left = 25
              Top = 27
              Width = 112
              Height = 23
              HelpContext = 653074
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'Arial'
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
              TabOrder = 0
            end
            object cboEmployeeOthersFollowUp: TwwDBLookupCombo
              Left = 248
              Top = 44
              Width = 119
              Height = 23
              HelpContext = 653075
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
              LookupField = 'EmployeeID'
              ParentFont = False
              TabOrder = 1
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object grdOtherFollowUp: TwwDBGrid
              Left = 1
              Top = 1
              Width = 353
              Height = 421
              HelpContext = 653072
              ControlType.Strings = (
                'FollowUpDate;CustomEdit;dtpFollowUpDate;F'
                'EmployeeName;CustomEdit;cboEmployeeOthersFollowUp;F'
                'Done;CheckBox;T;F')
              Selected.Strings = (
                'FollowUpDate'#9'15'#9'Follow Up Date'
                'Notes'#9'20'#9'Notes'
                'EmployeeName'#9'16'#9'Employee Name'
                'Done'#9'1'#9'Done')
              MemoAttributes = [mSizeable, mWordWrap, mGridShow]
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alClient
              DataSource = dsOtherFollowUp
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              PopupMenu = popCustomiseGrid
              TabOrder = 2
              TitleAlignment = taLeftJustify
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              OnExit = grdOtherFollowUpExit
              PaintOptions.AlternatingRowRegions = [arrActiveDataColumn]
              PaintOptions.BackgroundOptions = [coBlendFixedRow]
              object btnDeleteOtherFollowUp: TwwIButton
                Left = 0
                Top = 0
                Width = 23
                Height = 23
                HelpContext = 653073
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
                OnClick = btnDeleteOtherFollowUpClick
              end
            end
          end
        end
        object tabExtrainfo: TTabSheet
          HelpContext = 653508
          Caption = 'Extra Info'
          ImageIndex = 8
          object DNMPanel8: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653509
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Transparent = False
            object Bevel9: TBevel
              Left = 5
              Top = 276
              Width = 258
              Height = 41
              HelpContext = 653510
              Shape = bsFrame
            end
            object Bevel1: TBevel
              Left = 5
              Top = 229
              Width = 258
              Height = 41
              HelpContext = 653511
              Shape = bsFrame
            end
            object Bevel14: TBevel
              Left = 294
              Top = 1
              Width = 190
              Height = 113
              HelpContext = 653512
              Shape = bsFrame
            end
            object Bevel11: TBevel
              Left = 516
              Top = 164
              Width = 269
              Height = 199
              HelpContext = 653513
              Shape = bsFrame
            end
            object Bevel10: TBevel
              Left = 516
              Top = 1
              Width = 269
              Height = 160
              HelpContext = 653514
              Shape = bsFrame
            end
            object Bevel17: TBevel
              Left = 5
              Top = 322
              Width = 258
              Height = 95
              HelpContext = 653515
              Shape = bsFrame
            end
            object Bevel16: TBevel
              Left = 465
              Top = 369
              Width = 224
              Height = 48
              HelpContext = 653516
              Shape = bsFrame
            end
            object lblDetailsExportedStatus: TLabel
              Left = 480
              Top = 384
              Width = 132
              Height = 19
              HelpContext = 653593
              Alignment = taCenter
              Caption = 'Already Exported'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label64: TLabel
              Left = 9
              Top = 325
              Width = 114
              Height = 15
              HelpContext = 653594
              Caption = 'ASC Claim Remarks'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label65: TLabel
              Left = 588
              Top = 10
              Width = 53
              Height = 15
              HelpContext = 653517
              Caption = 'Man Inv #'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label67: TLabel
              Left = 528
              Top = 91
              Width = 113
              Height = 15
              HelpContext = 653518
              Caption = 'Warranty Start Date'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label68: TLabel
              Left = 607
              Top = 51
              Width = 34
              Height = 15
              HelpContext = 653519
              Caption = 'Model'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label69: TLabel
              Left = 601
              Top = 135
              Width = 40
              Height = 15
              HelpContext = 653520
              Caption = 'Serial#'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label71: TLabel
              Left = 538
              Top = 180
              Width = 44
              Height = 15
              HelpContext = 653521
              Alignment = taRightJustify
              Caption = 'Retailer'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblSuburb: TLabel
              Left = 525
              Top = 219
              Width = 57
              Height = 18
              HelpContext = 653522
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label62: TLabel
              Left = 300
              Top = 72
              Width = 127
              Height = 15
              HelpContext = 653523
              Caption = 'Authorisation Number '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Bevel12: TBevel
              Left = 294
              Top = 123
              Width = 190
              Height = 199
              HelpContext = 653524
              Shape = bsFrame
            end
            object Label59: TLabel
              Left = 300
              Top = 139
              Width = 75
              Height = 15
              HelpContext = 653525
              Caption = 'Material Cost'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label60: TLabel
              Left = 300
              Top = 205
              Width = 68
              Height = 15
              HelpContext = 653526
              Caption = 'Freight Cost'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label61: TLabel
              Left = 300
              Top = 272
              Width = 79
              Height = 15
              HelpContext = 653527
              Caption = 'Other Amount'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object DBText1: TDBText
              Left = 300
              Top = 6
              Width = 47
              Height = 15
              HelpContext = 653528
              AutoSize = True
              DataField = 'ReceiptNumberCaption'
              DataSource = dsrepairdetails
            end
            object Bevel13: TBevel
              Left = 5
              Top = 1
              Width = 258
              Height = 223
              HelpContext = 653529
              Shape = bsFrame
            end
            object Label23: TLabel
              Left = 8
              Top = 10
              Width = 72
              Height = 15
              HelpContext = 653530
              Caption = 'Manufacture'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label43: TLabel
              Left = 27
              Top = 56
              Width = 53
              Height = 15
              HelpContext = 653531
              Alignment = taRightJustify
              Caption = 'Condition'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label47: TLabel
              Left = 26
              Top = 103
              Width = 54
              Height = 15
              HelpContext = 653532
              Alignment = taRightJustify
              Caption = 'Symptom'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label49: TLabel
              Left = 43
              Top = 149
              Width = 37
              Height = 15
              HelpContext = 653533
              Alignment = taRightJustify
              Caption = 'Defect'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label50: TLabel
              Left = 43
              Top = 196
              Width = 37
              Height = 15
              HelpContext = 653534
              Alignment = taRightJustify
              Caption = 'Repair'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label51: TLabel
              Left = 37
              Top = 242
              Width = 43
              Height = 15
              HelpContext = 653535
              Alignment = taRightJustify
              Caption = 'Section'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label57: TLabel
              Left = 11
              Top = 289
              Width = 69
              Height = 15
              HelpContext = 653536
              Caption = 'Repair Code'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Bevel7: TBevel
              Left = 694
              Top = 369
              Width = 40
              Height = 48
              HelpContext = 653537
              Shape = bsFrame
            end
            object DNMSpeedButton1: TDNMSpeedButton
              Left = 618
              Top = 380
              Width = 67
              Height = 27
              HelpContext = 653024
              Caption = 'Export'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 20
              AutoDisableParentOnclick = True
              OnClick = DNMSpeedButton1Click
            end
            object memAscClaimRemarks: TDBMemo
              Left = 9
              Top = 344
              Width = 247
              Height = 67
              HelpContext = 653080
              DataField = 'AscClaimRemarks'
              DataSource = dsrepairdetails
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              PopupMenu = popInsert
              TabOrder = 19
              OnEnter = UnlockedcompOnenter
              OnExit = UnlockedcompOnexit
            end
            object edtManInv: TDBEdit
              Left = 657
              Top = 6
              Width = 120
              Height = 23
              HelpContext = 653595
              DataField = 'ManInvNo'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object cboWarrantydate: TwwDBDateTimePicker
              Left = 657
              Top = 88
              Width = 119
              Height = 23
              HelpContext = 653538
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'Arial'
              CalendarAttributes.Font.Style = []
              DataField = 'ManInvDate'
              DataSource = dsrepairdetails
              Epoch = 1950
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ShowButton = True
              TabOrder = 14
            end
            object edtmodel: TDBEdit
              Left = 657
              Top = 48
              Width = 120
              Height = 23
              HelpContext = 653596
              DataField = 'Model'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
            end
            object edtDerial: TDBEdit
              Left = 657
              Top = 133
              Width = 119
              Height = 23
              HelpContext = 653597
              DataField = 'SerialNo'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
            end
            object cboRetailer: TwwDBLookupCombo
              Left = 588
              Top = 177
              Width = 189
              Height = 23
              HelpContext = 653539
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Company'#9'80'#9'Company'#9'F')
              DataField = 'RetailerName'
              DataSource = dsrepairdetails
              LookupTable = QryRetailer
              LookupField = 'Company'
              ParentFont = False
              TabOrder = 16
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboRetailerCloseUp
              OnEnter = cboRetailerEnter
            end
            object DBMemo2: TDBMemo
              Left = 588
              Top = 216
              Width = 189
              Height = 140
              HelpContext = 653598
              DataField = 'RetailerAddress'
              DataSource = dsrepairdetails
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              PopupMenu = popInsert
              ReadOnly = True
              TabOrder = 17
              OnEnter = UnlockedcompOnenter
              OnExit = UnlockedcompOnexit
            end
            object grdServiceType: TDBRadioGroup
              Left = 270
              Top = 328
              Width = 190
              Height = 89
              HelpContext = 653540
              Caption = 'Service Type'
              DataField = 'Servicetype'
              DataSource = dsrepairdetails
              Items.Strings = (
                'In home'
                'Carry In')
              ParentBackground = True
              TabOrder = 18
              TabStop = True
              Values.Strings = (
                'IH'
                'CI')
            end
            object edtReceiptNo: TDBEdit
              Left = 298
              Top = 22
              Width = 179
              Height = 23
              HelpContext = 653599
              DataField = 'GSFSReceiptNo'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object edtauthno: TDBEdit
              Left = 298
              Top = 88
              Width = 179
              Height = 23
              HelpContext = 653600
              DataField = 'Authorisationnumber'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object edtmaterialcost: TDBEdit
              Left = 298
              Top = 155
              Width = 179
              Height = 23
              HelpContext = 653601
              DataField = 'Materialcost'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object edtFrightCost: TDBEdit
              Left = 298
              Top = 222
              Width = 179
              Height = 23
              HelpContext = 653602
              DataField = 'Freightcost'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object edtOtheramt: TDBEdit
              Left = 298
              Top = 293
              Width = 179
              Height = 23
              HelpContext = 653603
              DataField = 'Otheramount'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
            end
            object cboManufacture: TwwDBLookupCombo
              Left = 84
              Top = 6
              Width = 174
              Height = 23
              HelpContext = 653541
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Name'#9'30'#9'Name'#9'F')
              DataField = 'Manufacture'
              DataSource = dsrepairdetails
              LookupTable = qryManufacture
              LookupField = 'Name'
              ParentFont = False
              TabOrder = 0
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboManufactureCloseUp
              OnEnter = cboManufactureEnter
            end
            object cboFaultConditionDesc: TwwDBLookupCombo
              Left = 84
              Top = 52
              Width = 174
              Height = 23
              HelpContext = 653604
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Details'#9'30'#9'Details'#9'F')
              DataField = 'FaultConditionDesc'
              DataSource = dsrepairdetails
              LookupTable = QryRepairFaultsCondition
              LookupField = 'Details'
              ParentFont = False
              TabOrder = 1
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboFaultConditionDescCloseUp
            end
            object cboFaultSymptomDesc: TwwDBLookupCombo
              Left = 84
              Top = 99
              Width = 174
              Height = 23
              HelpContext = 653605
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Details'#9'30'#9'Details'#9'F')
              DataField = 'FaultSymptomDesc'
              DataSource = dsrepairdetails
              LookupTable = QryRepairFaultsSymptom
              LookupField = 'Details'
              ParentFont = False
              TabOrder = 2
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboFaultSymptomDescCloseUp
            end
            object cboFaultDefectDesc: TwwDBLookupCombo
              Left = 84
              Top = 145
              Width = 174
              Height = 23
              HelpContext = 653606
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Details'#9'30'#9'Details'#9'F')
              DataField = 'FaultDefectDesc'
              DataSource = dsrepairdetails
              LookupTable = QryRepairFaultsDefect
              LookupField = 'Details'
              ParentFont = False
              TabOrder = 3
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboFaultDefectDescCloseUp
            end
            object cboFaultRepairDesc: TwwDBLookupCombo
              Left = 84
              Top = 192
              Width = 174
              Height = 23
              HelpContext = 653607
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Details'#9'30'#9'Details'#9'F')
              DataField = 'FaultRepairDesc'
              DataSource = dsrepairdetails
              LookupTable = QryRepairFaultsRepair
              LookupField = 'Details'
              ParentFont = False
              TabOrder = 4
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboFaultRepairDescCloseUp
            end
            object cboFaultSectionDesc: TwwDBLookupCombo
              Left = 84
              Top = 238
              Width = 174
              Height = 23
              HelpContext = 653608
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Details'#9'30'#9'Details'#9'F')
              DataField = 'FaultSectionDesc'
              DataSource = dsrepairdetails
              LookupTable = QryRepairFaultsSection
              LookupField = 'Details'
              ParentFont = False
              TabOrder = 5
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboFaultSectionDescCloseUp
            end
            object DBEdit8: TDBEdit
              Left = 84
              Top = 285
              Width = 174
              Height = 23
              HelpContext = 653609
              DataField = 'Repaircode'
              DataSource = dsrepairdetails
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object DNMSpeedButton2: TDNMSpeedButton
              Left = 702
              Top = 380
              Width = 24
              Height = 27
              Hint = 'Details of the Export Fields'
              HelpContext = 653610
              Caption = '?'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 21
              AutoDisableParentOnclick = True
              OnClick = DNMSpeedButton2Click
            end
          end
        end
        object Custom_Fields: TTabSheet
          HelpContext = 653083
          Caption = 'Custom Fields'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label24: TLabel
            Left = 631
            Top = 179
            Width = 3
            Height = 15
            HelpContext = 653084
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label25: TLabel
            Left = 371
            Top = 179
            Width = 3
            Height = 15
            HelpContext = 653085
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label26: TLabel
            Left = 113
            Top = 179
            Width = 3
            Height = 15
            HelpContext = 653086
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object pnlCustFieldsTab: TDNMPanel
            Left = 0
            Top = 0
            Width = 791
            Height = 423
            HelpContext = 653087
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object pgCustomFields: TPageControl
              Left = 0
              Top = 0
              Width = 791
              Height = 423
              HelpContext = 653633
              ActivePage = tabCustomFields
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              TabWidth = 387
              object tabCustomFields: TTabSheet
                HelpContext = 653634
                Caption = 'Customisable List'
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object pnlcustomfieldList: TDNMPanel
                  Left = 0
                  Top = 0
                  Width = 783
                  Height = 393
                  HelpContext = 653635
                  Align = alClient
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  object DNMPanel11: TDNMPanel
                    Left = 1
                    Top = 1
                    Width = 781
                    Height = 34
                    HelpContext = 653636
                    Align = alTop
                    Caption = 'Customisable List'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clMaroon
                    Font.Height = -19
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    TabOrder = 0
                  end
                  object Memo1: TMemo
                    Left = 1
                    Top = 35
                    Width = 781
                    Height = 357
                    HelpContext = 653637
                    Align = alClient
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clBlue
                    Font.Height = -24
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    Lines.Strings = (
                      'Steps to add Customisable list to any form'
                      '=============================================='
                      '1: '
                      'CustomFieldListFormExtender.ClassExtenderList.AddExten'
                      'der     '
                      '2: TCustomFieldListFormExtender.InitForm       '
                      '3: Busobjcustomfields.ListType'
                      '4: Create table and busobj. eg : in Busobjcustomfields'
                      '5: create a new from TfmCustomFieldValue ONLY if there are '
                      'new '
                      'fields and OVERRIDE the INSTANCE procedure to create its '
                      'instance. '
                      'Otehrwise the wrong form will be created'
                      '6: Override CustomFieldExtenderListtype in the input form '
                      'using '
                      'custom fields'
                      '7: TfmCustomFieldValue.MakeCustomFieldForm : Add the '
                      'new class'
                      '8: the name of the page control has to be '#39'TABCTL20'#39
                      '9: Name of the tabsheet has to be '#39'CUSTOM_FIELDS'#39
                      '10: Save button name : cmdOk'
                      '11:Newbutton name :cmdNew'
                      '12: TfmCustomfieldList.SetListType(const Value: TListType)'
                      '13: change enum field - tblcustomfieldlist.ListType to have '
                      'new '
                      'listtype')
                    ParentFont = False
                    ScrollBars = ssVertical
                    TabOrder = 1
                    Visible = False
                  end
                end
              end
              object TabSheet2: TTabSheet
                HelpContext = 653638
                Caption = 'Customisable Fields'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = []
                ImageIndex = 1
                ParentFont = False
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object pnlCustFldsFixed: TDNMPanel
                  Left = 0
                  Top = 0
                  Width = 783
                  Height = 393
                  HelpContext = 653639
                  Align = alClient
                  BevelOuter = bvNone
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Arial'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  Transparent = False
                  object Bevel6: TBevel
                    Left = 292
                    Top = 25
                    Width = 206
                    Height = 32
                    HelpContext = 653640
                    Style = bsRaised
                  end
                  object Box181: TBevel
                    Left = 0
                    Top = 70
                    Width = 776
                    Height = 247
                    HelpContext = 653641
                  end
                  object Label95: TLabel
                    Left = 301
                    Top = 29
                    Width = 193
                    Height = 26
                    HelpContext = 653642
                    AutoSize = False
                    Caption = 'Customisable Fields'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -19
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                    WordWrap = True
                  end
                  object CUSTLBL1: TLabel
                    Left = 99
                    Top = 93
                    Width = 17
                    Height = 15
                    HelpContext = 653643
                    Alignment = taRightJustify
                    Caption = 'cl1'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL2: TLabel
                    Left = 99
                    Top = 131
                    Width = 17
                    Height = 15
                    HelpContext = 653644
                    Alignment = taRightJustify
                    Caption = 'cl2'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL3: TLabel
                    Left = 99
                    Top = 170
                    Width = 17
                    Height = 15
                    HelpContext = 653645
                    Alignment = taRightJustify
                    Caption = 'cl3'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL4: TLabel
                    Left = 99
                    Top = 208
                    Width = 17
                    Height = 15
                    HelpContext = 653646
                    Alignment = taRightJustify
                    Caption = 'cl4'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL5: TLabel
                    Left = 99
                    Top = 247
                    Width = 17
                    Height = 15
                    HelpContext = 653647
                    Alignment = taRightJustify
                    Caption = 'cl5'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL6: TLabel
                    Left = 99
                    Top = 286
                    Width = 17
                    Height = 15
                    HelpContext = 653648
                    Alignment = taRightJustify
                    Caption = 'cl6'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL7: TLabel
                    Left = 358
                    Top = 93
                    Width = 17
                    Height = 15
                    HelpContext = 653649
                    Alignment = taRightJustify
                    Caption = 'cl7'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL8: TLabel
                    Left = 358
                    Top = 131
                    Width = 17
                    Height = 15
                    HelpContext = 653650
                    Alignment = taRightJustify
                    Caption = 'cl8'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL9: TLabel
                    Left = 358
                    Top = 170
                    Width = 17
                    Height = 15
                    HelpContext = 653651
                    Alignment = taRightJustify
                    Caption = 'cl9'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL10: TLabel
                    Left = 351
                    Top = 208
                    Width = 24
                    Height = 15
                    HelpContext = 653652
                    Alignment = taRightJustify
                    Caption = 'cl10'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL11: TLabel
                    Left = 351
                    Top = 247
                    Width = 23
                    Height = 15
                    HelpContext = 653653
                    Alignment = taRightJustify
                    Caption = 'cl11'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL12: TLabel
                    Left = 350
                    Top = 286
                    Width = 24
                    Height = 15
                    HelpContext = 653654
                    Alignment = taRightJustify
                    Caption = 'cl12'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL13: TLabel
                    Left = 610
                    Top = 93
                    Width = 24
                    Height = 15
                    HelpContext = 653655
                    Alignment = taRightJustify
                    Caption = 'cl13'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL14: TLabel
                    Left = 610
                    Top = 131
                    Width = 24
                    Height = 15
                    HelpContext = 653656
                    Alignment = taRightJustify
                    Caption = 'cl14'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL15: TLabel
                    Left = 610
                    Top = 170
                    Width = 24
                    Height = 15
                    HelpContext = 653657
                    Alignment = taRightJustify
                    Caption = 'cl15'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL16: TLabel
                    Left = 610
                    Top = 208
                    Width = 24
                    Height = 15
                    HelpContext = 653658
                    Alignment = taRightJustify
                    Caption = 'cl16'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object Label93: TLabel
                    Left = 631
                    Top = 215
                    Width = 3
                    Height = 15
                    HelpContext = 653659
                    Alignment = taRightJustify
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object Label94: TLabel
                    Left = 631
                    Top = 247
                    Width = 3
                    Height = 15
                    HelpContext = 653660
                    Alignment = taRightJustify
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL17: TLabel
                    Left = 610
                    Top = 247
                    Width = 24
                    Height = 15
                    HelpContext = 653661
                    Alignment = taRightJustify
                    Caption = 'cl17'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object CUSTLBL18: TLabel
                    Left = 610
                    Top = 286
                    Width = 24
                    Height = 15
                    HelpContext = 653662
                    Alignment = taRightJustify
                    Caption = 'cl18'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentFont = False
                    Transparent = True
                  end
                  object cmdCustomLabelsOld: TDNMSpeedButton
                    Left = 355
                    Top = 328
                    Width = 87
                    Height = 27
                    Hint = '"Add A New Customised Field For All Employee'#39's"'
                    HelpContext = 653663
                    Caption = '&Add Labels'
                    DisableTransparent = False
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    HotTrackFont.Charset = DEFAULT_CHARSET
                    HotTrackFont.Color = clWindowText
                    HotTrackFont.Height = -12
                    HotTrackFont.Name = 'Arial'
                    HotTrackFont.Style = []
                    ParentFont = False
                    ParentShowHint = False
                    ShowHint = True
                    TabOrder = 18
                    AutoDisableParentOnclick = True
                    OnClick = cmdCustomLabelsOldClick
                  end
                  object CUSTFLD1: TwwDBComboBox
                    Left = 119
                    Top = 89
                    Width = 130
                    Height = 23
                    HelpContext = 653664
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD1'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 0
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD2: TwwDBComboBox
                    Left = 119
                    Top = 127
                    Width = 130
                    Height = 23
                    HelpContext = 653665
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD2'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 1
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD3: TwwDBComboBox
                    Left = 119
                    Top = 166
                    Width = 130
                    Height = 23
                    HelpContext = 653666
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD3'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 2
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD4: TwwDBComboBox
                    Left = 119
                    Top = 204
                    Width = 130
                    Height = 23
                    HelpContext = 653667
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD4'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 3
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD5: TwwDBComboBox
                    Left = 119
                    Top = 243
                    Width = 130
                    Height = 23
                    HelpContext = 653668
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD5'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 4
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD10: TwwDBComboBox
                    Left = 378
                    Top = 204
                    Width = 130
                    Height = 23
                    HelpContext = 653669
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD10'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 9
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD9: TwwDBComboBox
                    Left = 378
                    Top = 166
                    Width = 130
                    Height = 23
                    HelpContext = 653670
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD9'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 8
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD8: TwwDBComboBox
                    Left = 378
                    Top = 127
                    Width = 130
                    Height = 23
                    HelpContext = 653671
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD8'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 7
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD7: TwwDBComboBox
                    Left = 378
                    Top = 89
                    Width = 130
                    Height = 23
                    HelpContext = 653672
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD7'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 6
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD6: TwwDBComboBox
                    Left = 119
                    Top = 282
                    Width = 130
                    Height = 23
                    HelpContext = 653673
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD6'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 5
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD11: TwwDBComboBox
                    Left = 378
                    Top = 243
                    Width = 130
                    Height = 23
                    HelpContext = 653674
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD11'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 10
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD12: TwwDBComboBox
                    Left = 378
                    Top = 282
                    Width = 130
                    Height = 23
                    HelpContext = 653675
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD12'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 11
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD13: TwwDBComboBox
                    Left = 637
                    Top = 89
                    Width = 130
                    Height = 23
                    HelpContext = 653676
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD13'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 12
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD14: TwwDBComboBox
                    Left = 637
                    Top = 127
                    Width = 130
                    Height = 23
                    HelpContext = 653677
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD14'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 13
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD15: TwwDBComboBox
                    Left = 637
                    Top = 166
                    Width = 130
                    Height = 23
                    HelpContext = 653678
                    ShowButton = True
                    Style = csDropDown
                    MapList = False
                    AllowClearKey = False
                    DataField = 'CUSTFLD15'
                    DataSource = DSMaster
                    DropDownCount = 8
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ButtonWidth = -1
                    ItemHeight = 0
                    ParentFont = False
                    Sorted = False
                    TabOrder = 14
                    UnboundDataType = wwDefault
                  end
                  object CUSTFLD16: TwwDBDateTimePicker
                    Left = 637
                    Top = 204
                    Width = 130
                    Height = 23
                    HelpContext = 653679
                    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                    CalendarAttributes.Font.Color = clWindowText
                    CalendarAttributes.Font.Height = -11
                    CalendarAttributes.Font.Name = 'Arial'
                    CalendarAttributes.Font.Style = []
                    DataField = 'CUSTDATE1'
                    DataSource = DSMaster
                    Epoch = 1950
                    Enabled = False
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ParentFont = False
                    ShowButton = True
                    TabOrder = 15
                  end
                  object CUSTFLD17: TwwDBDateTimePicker
                    Left = 637
                    Top = 243
                    Width = 130
                    Height = 23
                    HelpContext = 653680
                    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                    CalendarAttributes.Font.Color = clWindowText
                    CalendarAttributes.Font.Height = -11
                    CalendarAttributes.Font.Name = 'Arial'
                    CalendarAttributes.Font.Style = []
                    DataField = 'CUSTDATE2'
                    DataSource = DSMaster
                    Epoch = 1950
                    Enabled = False
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ParentFont = False
                    ShowButton = True
                    TabOrder = 16
                  end
                  object CUSTFLD18: TwwDBDateTimePicker
                    Left = 637
                    Top = 282
                    Width = 130
                    Height = 23
                    HelpContext = 653681
                    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                    CalendarAttributes.Font.Color = clWindowText
                    CalendarAttributes.Font.Height = -11
                    CalendarAttributes.Font.Name = 'Arial'
                    CalendarAttributes.Font.Style = []
                    DataField = 'CUSTDATE3'
                    DataSource = DSMaster
                    Epoch = 1950
                    Enabled = False
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -12
                    Font.Name = 'Arial'
                    Font.Style = []
                    ParentFont = False
                    ShowButton = True
                    TabOrder = 17
                  end
                end
              end
            end
          end
        end
        object tabDocuments: TTabSheet
          HelpContext = 653542
          Caption = 'Documents'
          ImageIndex = 13
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          DesignSize = (
            791
            423)
          object grdDocs: TwwDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 785
            Height = 375
            HelpContext = 653543
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
            Align = alTop
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
              HelpContext = 653544
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
              OnClick = grdDocsIButtonClick
            end
          end
          object LetterBtn: TDNMSpeedButton
            Left = 324
            Top = 387
            Width = 82
            Height = 27
            HelpContext = 653545
            Anchors = [akRight, akBottom]
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
            AutoDisableParentOnclick = True
            OnClick = LetterBtnClick
          end
          object EmailBtn: TDNMSpeedButton
            Left = 435
            Top = 387
            Width = 82
            Height = 27
            HelpContext = 653546
            Anchors = [akRight, akBottom]
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
            AutoDisableParentOnclick = True
            OnClick = EmailBtnClick
          end
        end
      end
      object Shader1: TShader
        Left = 1
        Top = 58
        Width = 899
        Height = 30
        HelpContext = 653547
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object pnlActiveForm: TLabel
          Left = 0
          Top = 0
          Width = 899
          Height = 30
          HelpContext = 653548
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Main'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = 5
        end
      end
      object pnlconvertToOptions: TDNMPanel
        Left = 800
        Top = 88
        Width = 100
        Height = 458
        HelpContext = 653549
        Margins.Left = 90
        Margins.Right = 90
        Align = alRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnDblClick = pnlconvertToOptionsDblClick
        object btnAppointment: TDNMSpeedButton
          Left = 6
          Top = 34
          Width = 90
          Height = 27
          Hint = 'Create An Appointment'
          HelpContext = 653031
          Caption = '&Appts'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = btnAppointmentClick
        end
        object btnInvoice: TDNMSpeedButton
          Left = 6
          Top = 134
          Width = 87
          Height = 27
          Hint = 'Create an Invoice for the Repair'
          HelpContext = 653181
          Action = actInvoice
          Caption = '&Invoice'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          AutoDisableParentOnclick = True
        end
        object btnRAs: TDNMSpeedButton
          Left = 6
          Top = 234
          Width = 87
          Height = 27
          Hint = 'Create a Return Authority for the Repair'
          HelpContext = 653030
          Caption = 'RA'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          AutoDisableParentOnclick = True
          OnClick = btnRAsClick
        end
        object btnSmartOrder: TDNMSpeedButton
          Left = 6
          Top = 301
          Width = 87
          Height = 27
          Hint = 'Create a Smart Order for the Repair'
          HelpContext = 653611
          Caption = '&Smart Order'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          AutoDisableParentOnclick = True
          OnClick = btnSmartOrderClick
        end
        object btnBill: TDNMSpeedButton
          Left = 6
          Top = 67
          Width = 87
          Height = 27
          Hint = 'Create a Bill for the Repair'
          HelpContext = 653612
          Caption = 'Bill'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = btnBillClick
        end
        object btnSalesOrder: TDNMSpeedButton
          Left = 6
          Top = 267
          Width = 87
          Height = 27
          Hint = 'Create a Sales Order for the Repair'
          HelpContext = 653613
          Caption = 'Sales Order'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          AutoDisableParentOnclick = True
          OnClick = btnSalesOrderClick
        end
        object btnEmail: TDNMSpeedButton
          Left = 6
          Top = 100
          Width = 87
          Height = 27
          Hint = 'Email the Repair'
          HelpContext = 653027
          Caption = 'Email'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btnEmailClick
        end
        object btnQtyVarify: TDNMSpeedButton
          Left = 6
          Top = 200
          Width = 90
          Height = 27
          Hint = 'Varify the Inventoy'
          HelpContext = 653614
          Caption = 'Qty'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          AutoDisableParentOnclick = True
          OnClick = btnQtyVarifyClick
        end
        object btnCashSale: TDNMSpeedButton
          Left = 6
          Top = 167
          Width = 87
          Height = 27
          HelpContext = 653550
          Action = actCashSale
          Caption = 'Cash Sale'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          AutoDisableParentOnclick = True
        end
        object DNMPanel13: TDNMPanel
          AlignWithMargins = True
          Left = 4
          Top = 420
          Width = 92
          Height = 34
          HelpContext = 653685
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          DesignSize = (
            92
            34)
          object cbDone: TwwCheckBox
            Left = 20
            Top = 10
            Width = 51
            Height = 15
            HelpContext = 653032
            DisableThemes = False
            AlwaysTransparent = True
            Frame.Enabled = True
            Frame.Transparent = True
            Frame.FocusBorders = []
            Frame.NonFocusBorders = []
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Alignment = taLeftJustify
            Anchors = []
            Caption = 'Done '
            Color = clBtnFace
            DataField = 'Done'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            OnEnter = UnlockedcompOnenter
            OnExit = UnlockedcompOnexit
          end
        end
      end
      object DNMPanel1: TDNMPanel
        Left = 1
        Top = 546
        Width = 899
        Height = 43
        HelpContext = 653551
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        DesignSize = (
          899
          43)
        object btnRepeat: TDNMSpeedButton
          Left = 280
          Top = 6
          Width = 87
          Height = 27
          HelpContext = 653183
          Action = actRepeat
          Anchors = [akTop]
          Caption = '&Repeat'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          AutoDisableParentOnclick = True
        end
        object btnPrint: TDNMSpeedButton
          Left = 655
          Top = 6
          Width = 87
          Height = 27
          Hint = 'Print the Repair'
          HelpContext = 653615
          Anchors = [akTop]
          Caption = 'Prin&t'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = btnPrintClick
        end
        object btnPreview: TDNMSpeedButton
          Left = 530
          Top = 6
          Width = 87
          Height = 27
          Hint = 'Preview the Repair'
          HelpContext = 653552
          Anchors = [akTop]
          Caption = 'Pre&view'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btnPreviewClick
        end
        object btnCancel: TDNMSpeedButton
          Left = 780
          Top = 6
          Width = 87
          Height = 27
          Hint = 'Cancel the Changes'
          HelpContext = 653026
          Anchors = [akTop]
          Caption = 'Cancel'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
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
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          AutoDisableParentOnclick = True
          OnClick = btnCancelClick
        end
        object cmdOk: TDNMSpeedButton
          Left = 31
          Top = 6
          Width = 87
          Height = 27
          Hint = 'Save the Repair'
          HelpContext = 653025
          Anchors = [akTop]
          Caption = '&Save'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333330000333333333333333333333333F33333333333
            00003333344333333333333333388F3333333333000033334224333333333333
            338338F3333333330000333422224333333333333833338F3333333300003342
            222224333333333383333338F3333333000034222A22224333333338F338F333
            8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
            33333338F83338F338F33333000033A33333A222433333338333338F338F3333
            0000333333333A222433333333333338F338F33300003333333333A222433333
            333333338F338F33000033333333333A222433333333333338F338F300003333
            33333333A222433333333333338F338F00003333333333333A22433333333333
            3338F38F000033333333333333A223333333333333338F830000333333333333
            333A333333333333333338330000333333333333333333333333333333333333
            0000}
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          AutoDisableParentOnclick = True
          OnClick = cmdOkClick
        end
        object cmdNew: TDNMSpeedButton
          Left = 155
          Top = 6
          Width = 87
          Height = 27
          Hint = '"Save This Repair And Open A New Repair"'
          HelpContext = 653616
          Anchors = [akTop]
          Caption = '&New'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          AutoDisableParentOnclick = True
          OnClick = cmdNewClick
        end
        object btnSignature: TDNMSpeedButton
          Left = 405
          Top = 6
          Width = 87
          Height = 27
          HelpContext = 653686
          Action = actSignature
          Anchors = [akTop]
          Caption = 'Signat&ure'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 6
          UseHotTrackFont = True
          AutoDisableParentOnclick = True
        end
      end
      object pnlTitle1: TDNMPanel
        Left = 1
        Top = 1
        Width = 899
        Height = 57
        HelpContext = 653617
        Align = alTop
        BevelEdges = []
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PopupMenu = popOptions
        TabOrder = 4
        TabStop = True
        DesignSize = (
          899
          57)
        object lblRepairNo: TLabel
          Left = 737
          Top = 31
          Width = 58
          Height = 15
          HelpContext = 653009
          Anchors = [akTop, akRight]
          Caption = 'Repair No:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 687
        end
        object lblConverted: TLabel
          Left = 592
          Top = 13
          Width = 80
          Height = 38
          HelpContext = 653618
          Alignment = taCenter
          Anchors = [akTop]
          Caption = 'Has Been Converted'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
          WordWrap = True
          ExplicitLeft = 557
        end
        object lbMemTrans: TLabel
          Left = 753
          Top = 5
          Width = 124
          Height = 14
          HelpContext = 653553
          Anchors = [akTop, akRight]
          Caption = 'Right-Click For More ...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 703
        end
        object DNMPanel12: TDNMPanel
          Left = 331
          Top = 8
          Width = 238
          Height = 40
          HelpContext = 653021
          Anchors = [akTop]
          BevelInner = bvRaised
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object TitleShader: TShader
            Left = 2
            Top = 2
            Width = 234
            Height = 36
            HelpContext = 653022
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            FromColor = clBtnFace
            ToColor = clWhite
            FromColorMirror = clWhite
            ToColorMirror = clBtnFace
            Steps = 10
            Direction = False
            Version = '1.4.0.0'
            object TitleLabel: TLabel
              Left = 0
              Top = 0
              Width = 234
              Height = 36
              HelpContext = 653023
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Repairs'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -29
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
            end
          end
        end
        object edtRepairNo: TwwDBEdit
          Left = 801
          Top = 28
          Width = 73
          Height = 23
          HelpContext = 653554
          TabStop = False
          Anchors = [akTop, akRight]
          DataField = 'RepairDocno'
          DataSource = DSMaster
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
      end
    end
  end
  object sbButtons: TScrollBox [6]
    Left = 0
    Top = 0
    Width = 144
    Height = 590
    HelpContext = 653555
    HorzScrollBar.Visible = False
    Align = alLeft
    BorderStyle = bsNone
    TabOrder = 1
    object pnlButtons: TDNMPanel
      Left = 7
      Top = 3
      Width = 160
      Height = 556
      HelpContext = 653556
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 916
    Top = 61
  end
  inherited tmrdelay: TTimer
    Left = 880
    Top = 61
  end
  object DSDetails: TDataSource [9]
    DataSet = tblDetails
    Left = 60
    Top = 399
  end
  object DSMaster: TDataSource [10]
    DataSet = tblMaster
    Left = 30
    Top = 399
  end
  object dsOtherFollowUp: TDataSource [11]
    DataSet = tbOtherFollowUp
    Left = 89
    Top = 283
  end
  object dsrepairparts: TDataSource [12]
    DataSet = tblrepairparts
    Left = 89
    Top = 399
  end
  object popDscntMrkup: TAdvPopupMenu [13]
    HelpContext = 653175
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 195
    Top = 37
    object mnuDiscountDollar: TMenuItem
      Caption = 'Discount $'
      HelpContext = 653176
      OnClick = mnuDiscountDollarClick
    end
    object mnuDiscountPerc: TMenuItem
      Caption = 'Discount %'
      HelpContext = 653177
      OnClick = mnuDiscountPercClick
    end
    object mnuMarkupDollar: TMenuItem
      Caption = 'Markup $'
      HelpContext = 653178
      OnClick = mnuMarkupDollarClick
    end
    object mnuMarkupPerc: TMenuItem
      Caption = 'Markup %'
      HelpContext = 653179
      OnClick = mnuMarkupPercClick
    end
  end
  object actlstRepairs: TActionList [14]
    Left = 227
    Top = 37
    object actInvoice: TAction
      Caption = '&Invoice'
      HelpContext = 653619
      OnExecute = actInvoiceExecute
      OnUpdate = actInvoiceUpdate
    end
    object actServiceLog: TAction
      Caption = 'Service Log'
      HelpContext = 653182
    end
    object actRepeat: TAction
      Caption = '&Repeat'
      HelpContext = 653620
      OnExecute = btnRepeatClick
      OnUpdate = actRepeatUpdate
    end
    object actCompany: TAction
      HelpContext = 653184
      OnExecute = actCompanyExecute
    end
    object actCashSale: TAction
      Caption = 'Cash Sale'
      HelpContext = 653557
      OnExecute = actCashSaleExecute
    end
    object actSignature: TAction
      Caption = 'Signature'
      HelpContext = 653687
      OnExecute = actSignatureExecute
      OnUpdate = actSignatureUpdate
    end
  end
  object tblMaster: TERPQuery [15]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrepairs'
      'Where RepairID=:ID;')
    AfterOpen = tblMasterAfterOpen
    AfterInsert = tblMasterAfterInsert
    AfterPost = tblMasterAfterPost
    Left = 30
    Top = 370
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterRepairID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'RepairID'
      Origin = 'tblrepairs.RepairID'
      ReadOnly = True
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblrepairs.GlobalRef'
      Size = 255
    end
    object tblMasterCusID: TIntegerField
      FieldName = 'CusID'
      Origin = 'tblrepairs.CusID'
    end
    object tblMasterCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblrepairs.CreationDate'
    end
    object tblMasterUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Origin = 'tblrepairs.UpdateDate'
    end
    object tblMasterClientPrintName: TWideStringField
      FieldName = 'ClientPrintName'
      Size = 255
    end
    object tblMasterDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblrepairs.Done'
      FixedChar = True
      Size = 1
    end
    object tblMasterArea: TWideStringField
      FieldName = 'Area'
      Origin = 'tblrepairs.Area'
      Size = 50
    end
    object tblMasterNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblrepairs.Notes'
      BlobType = ftWideMemo
    end
    object tblMasterFeedbackNotes: TWideMemoField
      FieldName = 'FeedbackNotes'
      Origin = 'tblrepairs.FeedbackNotes'
      BlobType = ftWideMemo
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblrepairs.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblrepairs.ClassID'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblrepairs.EmployeeID'
    end
    object tblMasterCustomerDetails: TWideStringField
      FieldName = 'CustomerDetails'
      Origin = 'tblrepairs.CustomerDetails'
      Size = 255
    end
    object tblMasterPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblrepairs.Phone'
      EditMask = '## #### ####;0;_'
      Size = 30
    end
    object tblMasterAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblrepairs.AltPhone'
      Size = 30
    end
    object tblMasterFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'tblrepairs.Fax'
      EditMask = '## #### ####;0;_'
      Size = 30
    end
    object tblMasterJobDueDate: TDateTimeField
      FieldName = 'JobDueDate'
      Origin = 'tblrepairs.JobDueDate'
    end
    object tblMasterConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblrepairs.Converted'
      FixedChar = True
      Size = 1
    end
    object tblMasterStatus: TWideStringField
      FieldName = 'Status'
      Origin = 'tblrepairs.Status'
      Size = 100
    end
    object tblMasterBillToCustomerDetails: TWideStringField
      FieldName = 'BillToCustomerDetails'
      Origin = 'tblrepairs.BillToCustomerDetails'
      Size = 255
    end
    object tblMasterBillCusID: TIntegerField
      FieldName = 'BillCusID'
      Origin = 'tblrepairs.BillCusID'
    end
    object tblMasterUseBillCust: TWideStringField
      FieldName = 'UseBillCust'
      Origin = 'tblrepairs.UseBillCust'
      FixedChar = True
      Size = 1
    end
    object tblMasterBillPhone: TWideStringField
      FieldName = 'BillPhone'
      Origin = 'tblrepairs.BillPhone'
      EditMask = '## #### ####;0;_'
      Size = 30
    end
    object tblMasterBillAltPhone: TWideStringField
      FieldName = 'BillAltPhone'
      Origin = 'tblrepairs.BillAltPhone'
      Size = 30
    end
    object tblMasterBillFax: TWideStringField
      FieldName = 'BillFax'
      Origin = 'tblrepairs.BillFax'
      EditMask = '## #### ####;0;_'
      Size = 30
    end
    object tblMasterSOGlobalRef: TWideStringField
      FieldName = 'SOGlobalRef'
      Origin = 'tblrepairs.SOGlobalRef'
      Size = 255
    end
    object tblMasterCustomerPONumber: TWideStringField
      FieldName = 'CustomerPONumber'
      Origin = 'tblrepairs.CustomerPONumber'
      Size = 255
    end
    object tblMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Origin = 'tblrepairs.Shipping'
      Size = 255
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblrepairs.msTimeStamp'
    end
    object tblMasterQuoteGlobalRef: TWideStringField
      FieldName = 'QuoteGlobalRef'
      Origin = 'tblrepairs.QuoteGlobalRef'
      Size = 255
    end
    object tblMasterCompletionTime: TWideStringField
      FieldName = 'CompletionTime'
      Origin = 'tblrepairs.CompletionTime'
      Size = 255
    end
    object tblMasterTermsId: TLargeintField
      FieldName = 'TermsId'
      Origin = 'tblrepairs.TermsId'
    end
    object tblMasterTerms: TWideStringField
      FieldName = 'Terms'
      Origin = 'tblrepairs.Terms'
      Size = 50
    end
    object tblMasterMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblrepairs.Mobile'
      Size = 50
    end
    object tblMasterBillMobile: TWideStringField
      FieldName = 'BillMobile'
      Origin = 'tblrepairs.BillMobile'
      Size = 50
    end
    object tblMasterContactID: TLargeintField
      FieldName = 'ContactID'
      Origin = 'tblrepairs.ContactID'
    end
    object tblMasterQuotedAmount: TFloatField
      FieldName = 'QuotedAmount'
    end
    object tblMasterQuotedAmountinc: TFloatField
      FieldName = 'QuotedAmountinc'
    end
    object tblMasterAllocatedEmployeeID: TIntegerField
      FieldName = 'AllocatedEmployeeID'
    end
    object tblMasterHoldRepair: TWideStringField
      FieldName = 'HoldRepair'
      FixedChar = True
      Size = 1
    end
    object tblMasterCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object tblMasterCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object tblMasterCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object tblMasterCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object tblMasterCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object tblMasterCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object tblMasterCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object tblMasterCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object tblMasterCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object tblMasterCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object tblMasterCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object tblMasterCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object tblMasterCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object tblMasterCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object tblMasterCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object tblMasterCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
    end
    object tblMasterCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
    end
    object tblMasterCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
    end
    object tblMasterDetailsExported: TWideStringField
      FieldName = 'DetailsExported'
      FixedChar = True
      Size = 1
    end
    object tblMasterRepairDocNo: TWideStringField
      FieldName = 'RepairDocNo'
      OnSetText = tblMasterRepairDocNoSetText
      Size = 50
    end
    object tblMasterCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 255
    end
    object tblMasterBillCustomerName: TWideStringField
      FieldName = 'BillCustomerName'
      Size = 255
    end
    object tblMasterShipToID: TIntegerField
      FieldName = 'ShipToID'
    end
    object tblMasterCancelled: TWideStringField
      FieldName = 'Cancelled'
      FixedChar = True
      Size = 1
    end
    object tblMasterBilltotalPrice: TFloatField
      FieldName = 'BilltotalPrice'
      currency = True
    end
    object tblMasterEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Size = 100
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblMasterContractValue: TFloatField
      FieldName = 'ContractValue'
      currency = True
    end
    object tblMasterSuggestedSalesAmount: TFloatField
      FieldName = 'SuggestedSalesAmount'
      currency = True
    end
    object tblMasterEstimatedCost: TFloatField
      FieldName = 'EstimatedCost'
      currency = True
    end
    object tblMasterSignature: TBlobField
      FieldName = 'Signature'
    end
    object tblMasterSignatureTime: TDateTimeField
      FieldName = 'SignatureTime'
    end
  end
  object tblDetails: TERPQuery [16]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblEquipmentxRef'
      'Where RepairID= :ID')
    Left = 60
    Top = 370
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblDetailsWarantyPeriodTaken: TLargeintField
      DisplayLabel = 'Used'
      DisplayWidth = 15
      FieldName = 'WarantyPeriodTaken'
      Origin = 'tblequipmentxref.WarantyPeriodTaken'
      OnChange = tblDetailsWarantyPeriodTakenChange
    end
    object tblDetailsWarantyPeriodLeft: TLargeintField
      DisplayLabel = 'Left'
      DisplayWidth = 15
      FieldName = 'WarantyPeriodLeft'
      Origin = 'tblequipmentxref.WarantyPeriodLeft'
      OnChange = tblDetailsWarantyPeriodLeftChange
    end
    object tblDetailsCustomField1: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField1'
      Origin = 'tblequipmentxref.CustomField1'
      Size = 255
    end
    object tblDetailsCustomField2: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField2'
      Origin = 'tblequipmentxref.CustomField2'
      Size = 255
    end
    object tblDetailsCustomField3: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField3'
      Origin = 'tblequipmentxref.CustomField3'
      Size = 255
    end
    object tblDetailsCustomField4: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField4'
      Origin = 'tblequipmentxref.CustomField4'
      Size = 255
    end
    object tblDetailsCustomField5: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField5'
      Origin = 'tblequipmentxref.CustomField5'
      Size = 255
    end
    object tblDetailsCustomField6: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField6'
      Origin = 'tblequipmentxref.CustomField6'
      Size = 255
    end
    object tblDetailsCustomField7: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField7'
      Origin = 'tblequipmentxref.CustomField7'
      Size = 255
    end
    object tblDetailsCustomField8: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField8'
      Origin = 'tblequipmentxref.CustomField8'
      Size = 255
    end
    object tblDetailsCustomField9: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField9'
      Origin = 'tblequipmentxref.CustomField9'
      Size = 255
    end
    object tblDetailsCustomField10: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField10'
      Origin = 'tblequipmentxref.CustomField10'
      Size = 255
    end
    object tblDetailsCustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Origin = 'tblequipmentxref.CustomerEquipmentID'
    end
    object tblDetailsRepairfault: TWideStringField
      DisplayLabel = 'Repair Fault'
      DisplayWidth = 10
      FieldName = 'Repairfault'
      Origin = 'tblequipmentxref.Repairfault'
      Size = 255
    end
    object tblDetailsOnSite: TWideStringField
      DisplayWidth = 1
      FieldName = 'OnSite'
      Origin = 'tblequipmentxref.OnSite'
      FixedChar = True
      Size = 1
    end
    object tblDetailsUOM: TWideStringField
      DisplayWidth = 50
      FieldName = 'UOM'
      Origin = 'tblequipmentxref.UOM'
      Size = 50
    end
    object tblDetailsUOMID: TLargeintField
      DisplayWidth = 15
      FieldName = 'UOMID'
      Origin = 'tblequipmentxref.UOMID'
    end
    object tblDetailsUOMMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMMultiplier'
      Origin = 'tblequipmentxref.UOMMultiplier'
    end
    object tblDetailsUOMQty: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblequipmentxref.UOMQty'
    end
    object tblDetailsQuantity: TFloatField
      DisplayWidth = 10
      FieldName = 'Quantity'
      Origin = 'tblequipmentxref.Quantity'
    end
    object tblDetailsInvoiceID: TLargeintField
      DisplayWidth = 15
      FieldName = 'InvoiceID'
      Origin = 'tblequipmentxref.InvoiceID'
    end
    object tblDetailsAppointmentID: TLargeintField
      DisplayWidth = 15
      FieldName = 'AppointmentID'
      Origin = 'tblequipmentxref.AppointmentID'
    end
    object tblDetailsNotes: TWideStringField
      DisplayWidth = 100
      FieldName = 'Notes'
      Origin = 'tblequipmentxref.Notes'
      Size = 100
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblequipmentxref.msTimeStamp'
    end
    object tblDetailsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblequipmentxref.msUpdateSiteCode'
      Size = 3
    end
    object tblDetailsNextServiceDate: TDateTimeField
      DisplayLabel = 'Next Service~Due Date'
      DisplayWidth = 12
      FieldName = 'NextServiceDate'
      Origin = 'tblequipmentxref.NextServiceDate'
    end
    object tblDetailsCode: TWideStringField
      DisplayWidth = 12
      FieldName = 'Code'
      Origin = 'tblequipmentxref.Code'
      Visible = False
      Size = 255
    end
    object tblDetailsDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Origin = 'tblequipmentxref.Description'
      Visible = False
      Size = 255
    end
    object tblDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblequipmentxref.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsid: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'tblequipmentxref.id'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsRepairID: TIntegerField
      FieldName = 'RepairID'
      Origin = 'tblequipmentxref.RepairID'
      Visible = False
    end
    object tblDetailsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblequipmentxref.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblequipmentxref.CreationDate'
      Visible = False
    end
    object tblDetailsUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Origin = 'tblequipmentxref.UpdateDate'
      Visible = False
    end
    object tblDetailsSaleId: TLargeintField
      DisplayWidth = 15
      FieldName = 'SaleId'
      Origin = 'tblequipmentxref.SaleId'
      Visible = False
    end
    object tblDetailsVehicleRego_IDNo: TWideStringField
      DisplayLabel = 'Vehicle Identification Number (VIN)'
      DisplayWidth = 10
      FieldName = 'VehicleRego_IDNo'
      Size = 255
    end
    object tblDetailsVehicleRego_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 10
      FieldName = 'VehicleRego_Description'
      Size = 255
    end
    object tblDetailsVehicleRego_PurposeOfUse: TWideStringField
      DisplayLabel = 'Purpose of use'
      DisplayWidth = 10
      FieldName = 'VehicleRego_PurposeOfUse'
      Size = 255
    end
    object tblDetailsVehicleRego_Status: TWideStringField
      DisplayLabel = 'Status'
      DisplayWidth = 10
      FieldName = 'VehicleRego_Status'
      Size = 255
    end
    object tblDetailsVehicleRego_Expiry: TDateTimeField
      DisplayLabel = 'Expiry'
      DisplayWidth = 10
      FieldName = 'VehicleRego_Expiry'
    end
  end
  object tblrepairparts: TERPQuery [17]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrepairparts'
      'Where RepairID= :ID;')
    AfterOpen = tblrepairpartsAfterOpen
    OnCalcFields = tblrepairpartsCalcFields
    Left = 89
    Top = 370
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblrepairpartsPartBarcode: TWideStringField
      DisplayWidth = 10
      FieldName = 'PartBarcode'
      Size = 255
    end
    object tblRepairPartsPartName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'PartName'
      Origin = 'tblrepairparts.PartName'
      Size = 255
    end
    object tblrepairpartsUOMQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 8
      FieldName = 'UOMQty'
      Origin = 'tblrepairparts.UOMQty'
    end
    object tblrepairpartsEquipment: TWideStringField
      DisplayLabel = 'Equipment~(Choose First)'
      DisplayWidth = 16
      FieldName = 'Equipment'
      Origin = 'tblrepairparts.Equipment'
      Size = 100
    end
    object tblrepairpartsUnitofMeasure: TWideStringField
      DisplayLabel = 'Unit'
      DisplayWidth = 8
      FieldName = 'UnitofMeasure'
      Origin = 'tblrepairparts.UnitofMeasure'
      Size = 50
    end
    object tblrepairpartsDescription: TWideStringField
      DisplayWidth = 31
      FieldName = 'Description'
      Origin = 'tblrepairparts.Description'
      Size = 50
    end
    object tblrepairpartsPriceEx: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 10
      FieldName = 'PriceEx'
      Origin = 'tblrepairparts.PriceEx'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblrepairpartsTaxCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 15
      FieldName = 'TaxCode'
      Origin = 'tblrepairparts.TaxCode'
      Size = 15
    end
    object tblrepairpartscalcTax: TFloatField
      DisplayLabel = 'Tax Rate'
      DisplayWidth = 7
      FieldKind = fkCalculated
      FieldName = 'calcTax'
      DisplayFormat = '#.00%'
      currency = True
      Calculated = True
    end
    object tblrepairpartsDiscountPercent: TFloatField
      DisplayLabel = 'Discount (%)'
      DisplayWidth = 10
      FieldName = 'DiscountPercent'
      Origin = 'tblrepairparts.DiscountPercent'
      DisplayFormat = '0.00%'
    end
    object tblrepairpartsDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Origin = 'tblrepairparts.Discount'
      currency = True
    end
    object tblrepairpartsMarkupPercent: TFloatField
      DisplayLabel = 'Markup (%)'
      DisplayWidth = 10
      FieldName = 'MarkupPercent'
      Origin = 'tblrepairparts.MarkupPercent'
      DisplayFormat = '0.00%'
    end
    object tblrepairpartsMarkup: TFloatField
      DisplayWidth = 10
      FieldName = 'Markup'
      Origin = 'tblrepairparts.Markup'
      currency = True
    end
    object tblrepairpartsConvertToInvoice: TWideStringField
      DisplayLabel = 'Convert To~Invoice'
      DisplayWidth = 1
      FieldName = 'ConvertToInvoice'
      Origin = 'tblrepairparts.ConvertToInvoice'
      FixedChar = True
      Size = 1
    end
    object tblrepairpartsClassName: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 21
      FieldName = 'ClassName'
      Origin = 'tblrepairparts.ClassName'
      Size = 255
    end
    object tblrepairpartsMemoLine: TWideMemoField
      DisplayLabel = 'Memo'
      DisplayWidth = 10
      FieldName = 'MemoLine'
      Origin = 'tblrepairparts.MemoLine'
      BlobType = ftWideMemo
    end
    object tblrepairpartsDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblrepairparts.Deleted'
      FixedChar = True
      Size = 1
    end
    object tblrepairpartsPartIssuedOn: TDateTimeField
      DisplayLabel = 'Part~Issued On'
      DisplayWidth = 18
      FieldName = 'PartIssuedOn'
      Origin = 'tblrepairparts.PartIssuedOn'
    end
    object tblrepairpartsLinecost: TFloatField
      DisplayLabel = 'Line Cost'
      DisplayWidth = 10
      FieldName = 'Linecost'
      Origin = 'tblrepairparts.Linecost'
      currency = True
    end
    object tblrepairpartsLinecostInc: TFloatField
      DisplayLabel = 'Line Cost(Inc)'
      DisplayWidth = 10
      FieldName = 'LinecostInc'
      Origin = 'tblrepairparts.LinecostInc'
      currency = True
    end
    object tblrepairpartsSerialNos: TWideMemoField
      DisplayLabel = 'Serial No(s)'
      DisplayWidth = 10
      FieldName = 'SerialNos'
      Origin = 'tblrepairparts.SerialNos'
      BlobType = ftWideMemo
    end
    object tblrepairpartsMatrixDesc: TWideMemoField
      DisplayLabel = 'Matrix Details'
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      Origin = 'tblrepairparts.MatrixDesc'
      BlobType = ftWideMemo
    end
    object tblrepairpartsMatrixPrice: TFloatField
      DisplayLabel = 'Matrix Price'
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      Origin = 'tblrepairparts.MatrixPrice'
    end
    object tblrepairpartsCustfld1: TWideStringField
      DisplayWidth = 10
      FieldName = 'Custfld1'
      Origin = 'tblrepairparts.Custfld1'
      Size = 255
    end
    object tblrepairpartsCustFld2: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld2'
      Origin = 'tblrepairparts.CustFld2'
      Size = 255
    end
    object tblrepairpartsCustFld3: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld3'
      Origin = 'tblrepairparts.CustFld3'
      Size = 255
    end
    object tblrepairpartsCustFld4: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld4'
      Origin = 'tblrepairparts.CustFld4'
      Size = 255
    end
    object tblrepairpartsCustFld5: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld5'
      Origin = 'tblrepairparts.CustFld5'
      Size = 255
    end
    object tblrepairpartsCustFld6: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld6'
      Origin = 'tblrepairparts.CustFld6'
      Size = 255
    end
    object tblrepairpartsCustFld7: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld7'
      Origin = 'tblrepairparts.CustFld7'
      Size = 255
    end
    object tblrepairpartsCustFld8: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld8'
      Origin = 'tblrepairparts.CustFld8'
      Size = 255
    end
    object tblrepairpartsCustFld9: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld9'
      Origin = 'tblrepairparts.CustFld9'
      Size = 255
    end
    object tblrepairpartsCustFld10: TWideStringField
      DisplayWidth = 10
      FieldName = 'CustFld10'
      Origin = 'tblrepairparts.CustFld10'
      Size = 255
    end
    object tblrepairpartsFormulaQtyValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue'
      Origin = 'tblrepairparts.FormulaQtyValue'
    end
    object tblrepairpartsFormulaQtyValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue1'
      Origin = 'tblrepairparts.FormulaQtyValue1'
    end
    object tblrepairpartsFormulaQtyValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue2'
      Origin = 'tblrepairparts.FormulaQtyValue2'
    end
    object tblrepairpartsFormulaQtyValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue3'
      Origin = 'tblrepairparts.FormulaQtyValue3'
    end
    object tblrepairpartsFormulaQtyValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue4'
      Origin = 'tblrepairparts.FormulaQtyValue4'
    end
    object tblrepairpartsFormulaQtyValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue5'
      Origin = 'tblrepairparts.FormulaQtyValue5'
    end
    object tblrepairpartsSerialNo: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'SerialNo'
      LookupDataSet = qryPartsEquip
      LookupKeyFields = 'ID'
      LookupResultField = 'Serialno'
      KeyFields = 'CustomerEquipmentID'
      ReadOnly = True
      Size = 100
      Lookup = True
    end
    object tblrepairpartsManucature: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Manucature'
      LookupDataSet = qryPartsEquip
      LookupKeyFields = 'ID'
      LookupResultField = 'Manufacture'
      KeyFields = 'CustomerEquipmentID'
      ReadOnly = True
      Size = 100
      Lookup = True
    end
    object tblrepairpartsModel: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Model'
      LookupDataSet = qryPartsEquip
      LookupKeyFields = 'ID'
      LookupResultField = 'model'
      KeyFields = 'CustomerEquipmentID'
      ReadOnly = True
      Size = 100
      Lookup = True
    end
    object tblrepairpartsRegistration: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Registration'
      LookupDataSet = qryPartsEquip
      LookupKeyFields = 'ID'
      LookupResultField = 'Registration'
      KeyFields = 'CustomerEquipmentID'
      ReadOnly = True
      Size = 100
      Lookup = True
    end
    object tblrepairpartsPurchaseLineId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseLineId'
    end
    object tblrepairpartsIsRelatedProduct: TWideStringField
      DisplayLabel = 'Is Related~Product?'
      DisplayWidth = 1
      FieldName = 'IsRelatedProduct'
      Origin = 'tblrepairparts.IsRelatedProduct'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblrepairpartsQty: TFloatField
      DisplayWidth = 7
      FieldName = 'Qty'
      Origin = 'tblrepairparts.Qty'
      Visible = False
    end
    object tblrepairpartsUnitofMeasureID: TLargeintField
      DisplayWidth = 15
      FieldName = 'UnitofMeasureID'
      Origin = 'tblrepairparts.UnitofMeasureID'
      Visible = False
    end
    object tblrepairpartsUnitofMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureMultiplier'
      Origin = 'tblrepairparts.UnitofMeasureMultiplier'
      Visible = False
    end
    object tblrepairpartsETADate: TDateField
      DisplayLabel = 'ETA Date'
      DisplayWidth = 10
      FieldName = 'ETADate'
      Origin = 'tblrepairparts.ETADate'
      Visible = False
    end
    object tblrepairpartsPriceInc: TFloatField
      FieldName = 'PriceInc'
      Origin = 'tblrepairparts.PriceInc'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblrepairpartsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblrepairparts.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblrepairpartsRepairPartsID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'RepairPartsID'
      Origin = 'tblrepairparts.RepairPartsID'
      ReadOnly = True
      Visible = False
    end
    object tblrepairpartsRepairID: TIntegerField
      FieldName = 'RepairID'
      Origin = 'tblrepairparts.RepairID'
      Visible = False
    end
    object tblrepairpartsPartsID: TIntegerField
      FieldName = 'PartsID'
      Origin = 'tblrepairparts.PartsID'
      Visible = False
    end
    object tblrepairpartsTaxRate: TFloatField
      DefaultExpression = '0'
      FieldName = 'TaxRate'
      Origin = 'tblrepairparts.TaxRate'
      Visible = False
    end
    object tblrepairpartsLineTotalEx: TFloatField
      DisplayLabel = 'Amount (Ex)'
      FieldName = 'LineTotalEx'
      Origin = 'tblrepairparts.LineTotalEx'
      Visible = False
      currency = True
    end
    object tblrepairpartscalcTotalInc: TFloatField
      FieldKind = fkCalculated
      FieldName = 'calcTotalInc'
      Visible = False
      currency = True
      Calculated = True
    end
    object tblrepairpartscalcTotalIncBase: TFloatField
      FieldKind = fkCalculated
      FieldName = 'calcTotalIncBase'
      Visible = False
      currency = True
      Calculated = True
    end
    object tblrepairpartsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblrepairparts.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblrepairpartsClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblrepairparts.ClassID'
      Visible = False
    end
    object tblrepairpartsPartType: TWideStringField
      FieldName = 'PartType'
      Origin = 'tblrepairparts.PartType'
      Visible = False
      Size = 255
    end
    object tblrepairpartsPurchaseOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseOrderID'
      Origin = 'tblrepairparts.PurchaseOrderID'
      Visible = False
    end
    object tblrepairpartsCustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Origin = 'tblrepairparts.CustomerEquipmentID'
      Visible = False
    end
    object tblrepairpartsParentProductID: TLargeintField
      FieldName = 'ParentProductID'
      Origin = 'tblrepairparts.ParentProductID'
      Visible = False
    end
    object tblrepairpartsParentLineRef: TWideStringField
      FieldName = 'ParentLineRef'
      Origin = 'tblrepairparts.ParentLineRef'
      Visible = False
      Size = 255
    end
    object tblrepairpartsInvoiceLineRef: TWideStringField
      FieldName = 'InvoiceLineRef'
      Origin = 'tblrepairparts.InvoiceLineRef'
      Visible = False
      Size = 255
    end
    object tblrepairpartsRelatedProductQty: TFloatField
      FieldName = 'RelatedProductQty'
      Origin = 'tblrepairparts.RelatedProductQty'
      Visible = False
    end
    object tblrepairpartsMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Origin = 'tblrepairparts.MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
  end
  object tbOtherFollowUp: TERPQuery [18]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblotherfollowup'
      'Where RepairID= :ID;')
    OnNewRecord = tbOtherFollowUpNewRecord
    Left = 89
    Top = 255
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
      Origin = 'tblotherfollowup.FollowUpDate'
    end
    object tbOtherFollowUpNotes: TWideMemoField
      DisplayWidth = 20
      FieldName = 'Notes'
      Origin = 'tblotherfollowup.Notes'
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
      Origin = 'tblotherfollowup.Done'
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblotherfollowup.GlobalRef'
      Visible = False
      Size = 255
    end
    object tbOtherFollowUpFollowUpID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'FollowUpID'
      Origin = 'tblotherfollowup.FollowUpID'
      ReadOnly = True
      Visible = False
    end
    object tbOtherFollowUpOtherContactID: TIntegerField
      FieldName = 'OtherContactID'
      Origin = 'tblotherfollowup.OtherContactID'
      Visible = False
    end
    object tbOtherFollowUpRepairID: TIntegerField
      FieldName = 'RepairID'
      Origin = 'tblotherfollowup.RepairID'
      Visible = False
    end
    object tbOtherFollowUpEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblotherfollowup.EmployeeID'
      Visible = False
    end
    object tbOtherFollowUpClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblotherfollowup.ClientID'
      Visible = False
    end
    object tbOtherFollowUpEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblotherfollowup.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpAppearDays: TIntegerField
      FieldName = 'AppearDays'
      Origin = 'tblotherfollowup.AppearDays'
      Visible = False
    end
    object tbOtherFollowUpCreationDate: TDateTimeField
      FieldName = 'CreationDate'
      Origin = 'tblotherfollowup.CreationDate'
      Visible = False
    end
    object tbOtherFollowUpUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Origin = 'tblotherfollowup.UpdateDate'
      Visible = False
    end
    object tbOtherFollowUpIsSupplier: TWideStringField
      FieldName = 'IsSupplier'
      Origin = 'tblotherfollowup.IsSupplier'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsOtherContact: TWideStringField
      FieldName = 'IsOtherContact'
      Origin = 'tblotherfollowup.IsOtherContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsCustomer: TWideStringField
      FieldName = 'IsCustomer'
      Origin = 'tblotherfollowup.IsCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object imgCredit: TImageList [19]
    Left = 163
    Top = 29
    Bitmap = {
      494C010102004C02240410001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000000080808000000000000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000008000808080000000FF000000800000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000800000008000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000FF0000008000000080000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000800000800000000000000000FF00000080000000800000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000FF0000008000808080000000FF0000008000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000808080000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000808080000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000F98FF9FF00000000E10FF0FF00000000
      F01FE07F00000000F83FE03F00000000FC3FE01F00000000F81FE20F00000000
      F00FFF0700000000F00FFF8700000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object qryEmployees: TERPQuery [20]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT E.EmployeeID, Concat(E.FirstName,'#39' '#39',E.LastName) AS Emplo' +
        'yeeName'
      'FROM tblEmployees AS E'
      'WHERE E.Active = '#39'T'#39
      'ORDER BY EmployeeName;')
    Left = 29
    Top = 81
  end
  object TaxCodeDetails: TERPQuery [21]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TaxCodeID, Name, Rate  '
      'FROM tbltaxcodes'
      'Where RegionID= :xRegionID;')
    BeforeOpen = TaxCodeDetailsBeforeOpen
    Left = 60
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object cboClassQry: TERPQuery [22]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Top = 81
  end
  object qryParts: TERPQuery [23]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'Left(SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1),255) AS Manuf  , '
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) AS Type  ,'
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) AS Dept  ,'
      'P.PARTSID as PARTSID,'
      'P.PARTTYPE as PARTTYPE,'
      'P.PRODUCTGROUP as PRODUCTGROUP,'
      'P.PARTNAME as PARTNAME,'
      'P.PARTSDESCRIPTION as PARTSDESCRIPTION,'
      'P.INCOMEACCNT as INCOMEACCNT,'
      'P.PurchaseDesc as PurchaseDesc,'
      'P.ASSETACCNT as ASSETACCNT,'
      'P.COGSACCNT as COGSACCNT,'
      'P.BARCODE as BARCODE,'
      'P.PRODUCTCODE as PRODUCTCODE,'
      'P.PURCHTAXCODE as PURCHTAXCODE,'
      'P.PREFEREDSUPP as PREFEREDSUPP,'
      'P.Batch as Batch,'
      'P.SpecialDiscount as SpecialDiscount,'
      'P.SNTracking as SNTracking,'
      'P.BuyQTY1 as BuyQTY1,'
      'P.BuyQTY2 as BuyQTY2,'
      'P.BuyQTY3 as BuyQTY3,'
      'P.COST1 as COST1,'
      'P.COST2 as COST2,'
      'P.COST3 as COST3,'
      'P.SellQTY1 as SellQTY1,'
      'P.SellQTY2 as SellQTY2,'
      'P.SellQTY3 as SellQTY3,'
      'P.PRICE1 as PRICE1,'
      'P.PRICE2 as PRICE2,'
      'P.PRICE3 as PRICE3,'
      'P.WHOLESALEPRICE as WHOLESALEPRICE,'
      'P.Active as Active,'
      'P.EditedFlag as EditedFlag,'
      'P.MultipleBins as MultipleBins,'
      'P.AvgCost as AvgCost,'
      'P.Discontinued as Discontinued,'
      'P.Attrib1Purchase as Attrib1Purchase,'
      'P.Attrib2Purchase as Attrib2Purchase,'
      'P.Attrib1PurchaseRate as Attrib1PurchaseRate,'
      
        'if (ifnull(LatestCost ,0) = 0 , cost1, LatestCost ) as LatestCos' +
        'tPrice ,'
      'P.taxcode as TaxCode,'
      'p.LatestCost as LatestCost,'
      'p.AutoBatch as AutoBatch, '
      'p.Attrib1Sale as Attrib1Sale,'
      'p.Attrib2Sale as Attrib2Sale,'
      'p.Attrib1SaleRate as Attrib1SaleRate,'
      'P.LatestCostDate as LatestCostDate,'
      'SupplierProductCode,'
      '`P`.`CUSTFLD1`,'
      '`P`.`CUSTFLD2`,'
      '`P`.`CUSTFLD3`,'
      '`P`.`CUSTFLD4`,'
      '`P`.`CUSTFLD5`,'
      '`P`.`CUSTFLD6`,'
      '`P`.`CUSTFLD7`,'
      '`P`.`CUSTFLD8`,'
      '`P`.`CUSTFLD9`,'
      '`P`.`CUSTFLD10`,'
      '`P`.`CUSTFLD11`,'
      '`P`.`CUSTFLD12`,'
      '`P`.`CUSTFLD13`,'
      '`P`.`CUSTFLD14`,'
      '`P`.`CUSTFLD15`,'
      '`P`.`CUSTDATE1`,'
      '`P`.`CUSTDATE2`,'
      '`P`.`CUSTDATE3`'
      'FROM `tblParts` P'
      'WHERE P.Active = "T"'
      ' AND ('
      '  ((:SearchMode = 0) or (IsNull(:SearchMode))) '
      
        'or ((:SearchMode = 1) and ((Partname  LIKE Concat(:SearchValue,"' +
        '%"))  or (PREFEREDSUPP  LIKE Concat(:SearchValue,"%"))   or (PAR' +
        'TSDESCRIPTION LIKE Concat(:SearchValue,"%"))   or (Left(SUBSTRIN' +
        'G_INDEX(P.ProductGroup,'#39'^'#39',1),255) LIKE Concat(:SearchValue,"%")' +
        ')   or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),cha' +
        'r_length(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Con' +
        'cat(:SearchValue,"%"))   or (Left(substring(substring_index(P.Pr' +
        'oductGroup,'#39'^'#39',3),char_length(substring_index(P.ProductGroup,'#39'^'#39 +
        ',2))+2),255) LIKE Concat(:SearchValue,"%"))  )) '
      
        'or ((:SearchMode = 2) and (Trim(:SearchValue) <> "") and ((Partn' +
        'ame  LIKE Concat("%",:SearchValue,"%"))   or (PREFEREDSUPP  LIKE' +
        ' Concat("%",:SearchValue,"%"))   or (PARTSDESCRIPTION LIKE Conca' +
        't("%",:SearchValue,"%"))  or (Left(SUBSTRING_INDEX(P.ProductGrou' +
        'p,'#39'^'#39',1),255) LIKE Concat("%",:SearchValue,"%"))  or (Left(subst' +
        'ring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(substring' +
        '_index(P.ProductGroup,'#39'^'#39',1))+2),255) LIKE Concat("%",:SearchVal' +
        'ue,"%"))  or (Left(substring(substring_index(P.ProductGroup,'#39'^'#39',' +
        '3),char_length(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) LI' +
        'KE Concat("%",:SearchValue,"%"))  )) '
      ')'
      'and IfNull(:SearchValue,"") <> ""')
    Top = 197
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
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
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
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryPartsManuf: TWideStringField
      FieldName = 'Manuf'
      Origin = 'Manuf'
      Size = 255
    end
    object qryPartsType: TWideStringField
      FieldName = 'Type'
      Origin = 'Type'
      Size = 255
    end
    object qryPartsDept: TWideStringField
      FieldName = 'Dept'
      Origin = 'Dept'
      Size = 255
    end
    object qryPartsPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Origin = 'P.PARTNAME'
      Size = 60
    end
    object qryPartsPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Origin = 'P.PARTSDESCRIPTION'
      Size = 255
    end
    object qryPartsPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PARTSID'
      Origin = 'P.PARTSID'
    end
    object qryPartsPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Origin = 'P.PARTTYPE'
      Size = 13
    end
    object qryPartsPRODUCTGROUP: TWideStringField
      FieldName = 'PRODUCTGROUP'
      Origin = 'P.PRODUCTGROUP'
      Size = 255
    end
    object qryPartsINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Origin = 'P.INCOMEACCNT'
      Size = 50
    end
    object qryPartsASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Origin = 'P.ASSETACCNT'
      Size = 50
    end
    object qryPartsCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Origin = 'P.COGSACCNT'
      Size = 50
    end
    object qryPartsBARCODE: TWideStringField
      FieldName = 'BARCODE'
      Origin = 'P.BARCODE'
      Size = 35
    end
    object qryPartsPRODUCTCODE: TWideStringField
      FieldName = 'PRODUCTCODE'
      Origin = 'P.PRODUCTCODE'
      Size = 11
    end
    object qryPartsTAXCODE: TWideStringField
      FieldName = 'TAXCODE'
      Origin = 'P.TaxCode'
      Size = 15
    end
    object qryPartsSpecialDiscount: TWideStringField
      FieldName = 'SpecialDiscount'
      Origin = 'P.SpecialDiscount'
      FixedChar = True
      Size = 1
    end
    object qryPartsSNTracking: TWideStringField
      FieldName = 'SNTracking'
      Origin = 'P.SNTracking'
      FixedChar = True
      Size = 1
    end
    object qryPartsBuyQTY1: TIntegerField
      FieldName = 'BuyQTY1'
      Origin = 'P.BuyQTY1'
    end
    object qryPartsBuyQTY2: TIntegerField
      FieldName = 'BuyQTY2'
      Origin = 'P.BuyQTY2'
    end
    object qryPartsBuyQTY3: TIntegerField
      FieldName = 'BuyQTY3'
      Origin = 'P.BuyQTY3'
    end
    object qryPartsCOST1: TFloatField
      FieldName = 'COST1'
      Origin = 'P.COST1'
    end
    object qryPartsCOST2: TFloatField
      FieldName = 'COST2'
      Origin = 'P.COST2'
    end
    object qryPartsCOST3: TFloatField
      FieldName = 'COST3'
      Origin = 'P.COST3'
    end
    object qryPartsSellQTY1: TIntegerField
      FieldName = 'SellQTY1'
      Origin = 'P.SellQTY1'
    end
    object qryPartsSellQTY2: TIntegerField
      FieldName = 'SellQTY2'
      Origin = 'P.SellQTY2'
    end
    object qryPartsSellQTY3: TIntegerField
      FieldName = 'SellQTY3'
      Origin = 'P.SellQTY3'
    end
    object qryPartsPRICE1: TFloatField
      FieldName = 'PRICE1'
      Origin = 'P.PRICE1'
    end
    object qryPartsPRICE2: TFloatField
      FieldName = 'PRICE2'
      Origin = 'P.PRICE2'
    end
    object qryPartsPRICE3: TFloatField
      FieldName = 'PRICE3'
      Origin = 'P.PRICE3'
    end
    object qryPartsWHOLESALEPRICE: TFloatField
      FieldName = 'WHOLESALEPRICE'
      Origin = 'P.WHOLESALEPRICE'
    end
    object qryPartsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'P.Active'
      FixedChar = True
      Size = 1
    end
    object qryPartsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'P.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryPartsAvgCost: TFloatField
      FieldName = 'AvgCost'
      Origin = 'P.AvgCost'
    end
    object qryPartsSupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Origin = 'P.SupplierProductCode'
      Size = 50
    end
  end
  object qryfixedAssetParts: TERPQuery [24]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'FA.PARTSID, FA.Serial,'
      
        'LEFT(IF(NOT ISNULL(FA.Serial) OR FA.Serial <> '#39#39', CONCAT_WS('#39' - ' +
        #39', FA.PartName, FA.Serial), FA.PartName), 200) AS PartName'
      'FROM tblfixedassets AS FA'
      'INNER JOIN tblParts Using(PARTSID)'
      'WHERE tblParts.Active = '#39'T'#39
      'GROUP BY FA.PARTSID, FA.Serial;')
    Left = 60
    Top = 226
    object qryfixedAssetPartsPARTSID: TIntegerField
      FieldName = 'PARTSID'
      Origin = 'tblfixedassets.PARTSID'
    end
    object qryfixedAssetPartsPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Origin = '.PartName'
      Size = 200
    end
    object qryfixedAssetPartsSerial: TWideStringField
      FieldName = 'Serial'
      Origin = 'tblfixedassets.Serial'
      Size = 30
    end
  end
  object qryClientLookup: TERPQuery [25]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'CT.DefaultPostAccount AS DefaultPostAccount,'
      'CT.DefaultPostAccountID AS DefaultPostAccountID,'
      'C1.ClientID as ClientID,'
      'C1.Company as Company,'
      'C1.FaxNumber as FaxNumber,'
      'C1.jobnumber, '
      'C1.JobName,'
      'C1.StopCredit,'
      'C1.PrintName as PrintName,'
      'C1.FirstName,'
      'C1.isjob as isjob, '
      'C1.Lastname,'
      'C1.Mobile,'
      'C1.Title,'
      'C1.ForcePOOnCustomer,'
      'C1.Supplier as Supplier, '
      'C1.Customer as Customer, '
      'C1.OtherContact as OtherContact, '
      'C1.Street as Street,'
      'C1.ParentClientID,'
      'C1.Street2 as Street2,'
      'C1.Street3 as Street3,'
      'C1.Suburb as Suburb,'
      'C1.State as State,'
      'C1.Country as Country,'
      'C1.Postcode as Postcode,'
      'C1.BillStreet as BillStreet,'
      'C1.BillStreet2 as BillStreet2,'
      'C1.BillStreet3 as BillStreet3,'
      'C1.BillSuburb as BillSuburb,'
      'C1.BillState as BillState,'
      'C1.BillPostcode as BillPostcode,'
      'C1.BillCountry as BillCountry,'
      'C1.TERMS as TERMS,'
      'C1.TermsID as TermsID,'
      'C1.ShippingMethod as ShippingMethod,'
      'C1.ShippingID as ShippingID,'
      'C1.RepID as RepID,'
      'C1.TaxID as TaxID,'
      'C1.Phone as Phone,'
      'C1.FaxNumber as Fax,'
      'C1.AltPhone as AltPhone,'
      'IF(C1.IsJob = "T",C2.StopCredit,C1.StopCredit) AS StopCredits,'
      'C1.ForcePOOnInvoice as ForcePOOnInvoice,'
      'C1.UseInvBase as UseInvBase,'
      'C1.InvBaseNumber as InvBaseNumber,'
      'C1.WarrantyFinishDate, C1.IsJob'
      'FROM tblclients as C1'
      
        'LEFT JOIN tblClientType AS CT on C1.ClientTypeID = CT.ClientType' +
        'ID'
      'LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID'
      
        'WHERE (70 <> 0 and C1.clientId =  70 ) or  (char_length(C1.Compa' +
        'ny)>0)'
      ' AND (C1.Customer ="T" OR C1.IsJob ="T")'
      ''
      ' Order by Company ASC')
    Filtered = True
    Filter = 'jobnumber = 0'
    BeforeOpen = qryClientLookupBeforeOpen
    OnCalcFields = qryClientLookupCalcFields
    Top = 226
    object qryClientLookupCompany: TWideStringField
      DisplayWidth = 65
      FieldName = 'Company'
      Origin = 'C1.Company'
      Size = 80
    end
    object qryClientLookupStopCreditImage: TIntegerField
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Calculated = True
    end
    object qryClientLookupClientID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'C1.ClientID'
      ReadOnly = True
      Visible = False
    end
    object qryClientLookupStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'C1.Street'
      Visible = False
      Size = 255
    end
    object qryClientLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'C1.Street2'
      Visible = False
      Size = 255
    end
    object qryClientLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'C1.Suburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupState: TWideStringField
      FieldName = 'State'
      Origin = 'C1.State'
      Visible = False
      FixedChar = True
      Size = 255
    end
    object qryClientLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'C1.Postcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'C1.Phone'
      Visible = False
    end
    object qryClientLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'C1.AltPhone'
      Visible = False
    end
    object qryClientLookupFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'C1.FaxNumber'
      Visible = False
    end
    object qryClientLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'C1.BillStreet'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'C1.BillStreet2'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'C1.BillSuburb'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'C1.BillState'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'C1.BillCountry'
      Visible = False
      Size = 255
    end
    object qryClientLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'C1.BillPostcode'
      Visible = False
      Size = 255
    end
    object qryClientLookupjobnumber: TIntegerField
      DisplayWidth = 10
      FieldName = 'jobnumber'
      Origin = 'C1.JobNumber'
      Visible = False
    end
    object qryClientLookupJobname: TWideStringField
      DisplayWidth = 39
      FieldName = 'Jobname'
      Origin = 'C1.JobName'
      Visible = False
      Size = 39
    end
    object qryClientLookupWarrantyFinishDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'WarrantyFinishDate'
      Origin = 'C1.WarrantyFinishDate'
      Visible = False
    end
    object qryClientLookupIsJob: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsJob'
      Origin = 'C1.IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupParentClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ParentClientID'
      Origin = 'C1.ParentClientID'
      Visible = False
    end
    object qryClientLookupForcePOOnCustomer: TWideStringField
      DisplayWidth = 1
      FieldName = 'ForcePOOnCustomer'
      Origin = 'C1.ForcePOOnCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Origin = 'C1.TAXID'
      Visible = False
    end
    object qryClientLookupStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'C1.StopCredit'
      FixedChar = True
      Size = 1
    end
    object qryClientLookupterms: TWideStringField
      FieldName = 'terms'
      Origin = 'C1.TERMS'
      Size = 30
    end
    object qryClientLookuptermsid: TIntegerField
      FieldName = 'termsid'
      Origin = 'C1.TermsID'
    end
    object qryClientLookupmobile: TWideStringField
      FieldName = 'mobile'
      Origin = 'C1.Mobile'
    end
    object qryClientLookuptitle: TWideStringField
      FieldName = 'title'
      Origin = 'C1.Title'
      Size = 32
    end
    object qryClientLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'C1.Street3'
      Size = 255
    end
    object qryClientLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'C1.BillStreet3'
      Size = 255
    end
    object qryClientLookupfirstname: TWideStringField
      FieldName = 'firstname'
      Origin = 'C1.FirstName'
      Size = 40
    end
    object qryClientLookuplastname: TWideStringField
      FieldName = 'lastname'
      Origin = 'C1.LastName'
      Size = 40
    end
    object qryClientLookupCustomer: TWideStringField
      FieldName = 'Customer'
      Origin = 'C1.Customer'
      FixedChar = True
      Size = 1
    end
    object qryClientLookupSupplier: TWideStringField
      FieldName = 'Supplier'
      Origin = 'C1.Supplier'
      FixedChar = True
      Size = 1
    end
    object qryClientLookupOtherContact: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'C1.OtherContact'
      FixedChar = True
      Size = 1
    end
  end
  object qryClass: TERPQuery [26]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 118
    Top = 168
  end
  object DMTextTargetRepairs: TDMTextTarget [27]
    AcceptTextFormats = [dtfFiles, dtfCustom]
    OnDrop = DMTextTargetRepairsDrop
    Left = 773
    Top = 29
  end
  object qryCustomFields: TERPQuery [28]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`CF`.`CFLabel2`,'
      '`CF`.`CFLabel3`,'
      '`CF`.`CFLabel4`,'
      '`CF`.`CFLabel5`,'
      '`CF`.`CFLabel6`,'
      '`CF`.`CFLabel7`,'
      '`CF`.`CFLabel8`,'
      '`CF`.`CFLabel9`,'
      '`CF`.`CFLabel10`,'
      '`CF`.`CFLabel11`,'
      '`CF`.`CFLabel12`,'
      '`CF`.`CFLabel13`,'
      '`CF`.`CFLabel14`,'
      '`CF`.`CFLabel15`,'
      '`CF`.`CFLabel16`,'
      '`CF`.`CFLabel17`,'
      '`CF`.`CFLabel18`,'
      '`CF`.`CFIsCombo1`,'
      '`CF`.`CFIsCombo2`,'
      '`CF`.`CFIsCombo3`,'
      '`CF`.`CFIsCombo4`,'
      '`CF`.`CFIsCombo5`,'
      '`CF`.`CFIsCombo6`,'
      '`CF`.`CFIsCombo7`,'
      '`CF`.`CFIsCombo8`,'
      '`CF`.`CFIsCombo9`,'
      '`CF`.`CFIsCombo10`,'
      '`CF`.`CFIsCombo11`,'
      '`CF`.`CFIsCombo12`,'
      '`CF`.`CFIsCombo13`,'
      '`CF`.`CFIsCombo14`,'
      '`CF`.`CFIsCombo15`,'
      '`CF`.`CFLabel1`,'
      '`CF`.`CFRepairs1`,'
      '`CF`.`CFRepairs2`,'
      '`CF`.`CFRepairs3`,'
      '`CF`.`CFRepairs4`,'
      '`CF`.`CFRepairs5`,'
      '`CF`.`CFRepairs6`,'
      '`CF`.`CFRepairs7`,'
      '`CF`.`CFRepairs8`,'
      '`CF`.`CFRepairs9`,'
      '`CF`.`CFRepairs10`,'
      '`CF`.`CFRepairs11`,'
      '`CF`.`CFRepairs12`,'
      '`CF`.`CFRepairs13`,'
      '`CF`.`CFRepairs14`,'
      '`CF`.`CFRepairs15`,'
      '`CF`.`CFRepairs16`,'
      '`CF`.`CFRepairs17`,'
      '`CF`.`CFRepairs18`,'
      '`CF`.`CFIsRequired1`,'
      '`CF`.`CFIsRequired2`,'
      '`CF`.`CFIsRequired3`,'
      '`CF`.`CFIsRequired4`,'
      '`CF`.`CFIsRequired5`,'
      '`CF`.`CFIsRequired6`,'
      '`CF`.`CFIsRequired7`,'
      '`CF`.`CFIsRequired8`,'
      '`CF`.`CFIsRequired9`,'
      '`CF`.`CFIsRequired10`,'
      '`CF`.`CFIsRequired11`,'
      '`CF`.`CFIsRequired12`,'
      '`CF`.`CFIsRequired13`,'
      '`CF`.`CFIsRequired14`,'
      '`CF`.`CFIsRequired15`,'
      '`CF`.`CFIsRequired16`,'
      '`CF`.`CFIsRequired17`,'
      '`CF`.`CFIsRequired18`'
      'FROM'
      '`tblcustomfields` AS `CF`')
    Options.LongStrings = False
    Left = 60
    Top = 110
  end
  object dsCustomerSrc: TDataSource [29]
    DataSet = qryCustomers
    OnStateChange = dsStateChange
    Left = 89
    Top = 341
  end
  object qryStatus: TERPQuery [30]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblsimpletypes '
      'WHERE (TypeCode='#39'StatusType'#39') AND (Active='#39'T'#39')')
    BeforeOpen = qryStatusBeforeOpen
    Left = 118
    Top = 226
    object qryStatusName: TWideStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
  end
  object popInsert: TAdvPopupMenu [31]
    HelpContext = 653453
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 116
    Top = 21
    object InsertDateandTime1: TMenuItem
      Caption = 'Add Date && Time'
      HelpContext = 653454
      OnClick = InsertDateandTime1Click
    end
    object Spelling1: TMenuItem
      Caption = 'Spelling'
      HelpContext = 653558
      OnClick = Spelling1Click
    end
  end
  object qryClientInvoicetoLookup: TERPQuery [32]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ClientID, Company, Street, Street2, Street3, Suburb, Stat' +
        'e, Postcode, Phone, AltPhone, FaxNumber,'
      
        'BillStreet, BillStreet2,BillStreet3, BillSuburb, BillState, Bill' +
        'Country, BillPostcode,mobile,'
      
        'StopCredit, jobnumber, ForcePOOnCustomer, Jobname, tblclients.Wa' +
        'rrantyFinishDate, '
      
        'tblclients.IsJob, ParentClientID, TaxID, title , firstname, last' +
        'name'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active = '#39'T'#39 +
        ' And tblclients.Customer = '#39'T'#39' and JobNumber = 0'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY tblclients.Company')
    Filtered = True
    OnCalcFields = qryClientInvoicetoLookupCalcFields
    Left = 60
    Top = 197
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
    object qryClientInvoicetoLookupCompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryClientInvoicetoLookupClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      Visible = False
    end
    object qryClientInvoicetoLookupStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupStopCreditImage: TIntegerField
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Visible = False
      Calculated = True
    end
    object qryClientInvoicetoLookupStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupState: TWideStringField
      FieldName = 'State'
      Origin = 'tblclients.State'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
      Visible = False
    end
    object qryClientInvoicetoLookupAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
      Visible = False
    end
    object qryClientInvoicetoLookupFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
      Visible = False
    end
    object qryClientInvoicetoLookupmobile: TWideStringField
      FieldName = 'mobile'
      Origin = 'tblclients.Mobile'
      Visible = False
    end
    object qryClientInvoicetoLookupBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      Visible = False
      Size = 255
    end
    object qryClientInvoicetoLookupStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblclients.StopCredit'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientInvoicetoLookupjobnumber: TIntegerField
      FieldName = 'jobnumber'
      Origin = 'tblclients.JobNumber'
      Visible = False
    end
    object qryClientInvoicetoLookupForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      Origin = 'tblclients.ForcePOOnCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientInvoicetoLookupJobname: TWideStringField
      FieldName = 'Jobname'
      Origin = 'tblclients.JobName'
      Visible = False
      Size = 39
    end
    object qryClientInvoicetoLookupWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
      Origin = 'tblclients.WarrantyFinishDate'
      Visible = False
    end
    object qryClientInvoicetoLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientInvoicetoLookupParentClientID: TIntegerField
      FieldName = 'ParentClientID'
      Origin = 'tblclients.ParentClientID'
      Visible = False
    end
    object qryClientInvoicetoLookupTaxID: TIntegerField
      FieldName = 'TaxID'
      Origin = 'tblclients.TAXID'
      Visible = False
    end
    object qryClientInvoicetoLookuptitle: TWideStringField
      FieldName = 'title'
      Origin = 'tblclients.Title'
      Size = 32
    end
    object qryClientInvoicetoLookupStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object qryClientInvoicetoLookupBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object qryClientInvoicetoLookupfirstname: TWideStringField
      FieldName = 'firstname'
      Origin = 'tblclients.FirstName'
      Size = 40
    end
    object qryClientInvoicetoLookuplastname: TWideStringField
      FieldName = 'lastname'
      Origin = 'tblclients.LastName'
      Size = 40
    end
  end
  object qryVia: TERPQuery [33]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ShippingMethodID, ShippingMethod'
      'FROM tblShippingMethods '
      'WHERE Active='#39'T'#39' '
      'ORDER BY ShippingMethod; '
      ''
      '')
    Left = 89
    Top = 168
    object qryViaShippingMethod: TWideStringField
      DisplayWidth = 20
      FieldName = 'ShippingMethod'
      Origin = 'tblShippingMethods.ShippingMethod'
    end
    object qryViaShippingMethodID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ShippingMethodID'
      Origin = 'tblShippingMethods.ShippingMethodID'
      Visible = False
    end
  end
  object qryTimesheets: TERPQuery [34]
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
      'SELECT '
      'ID, timesheetDate, Hours, Total, Job, JobID, T.EmployeeName,'
      'T.EmployeeID, LabourCost, ClassName, ClassID, T.GlobalRef,'
      
        'ServiceID, ServiceName, ServiceDate, Qty,ChargeRate, PartID, Par' +
        'tName,'
      
        'PayRateTypeName, PayRateTypeID, HourlyRate, SuperInc,  TotalServ' +
        'icecharge,'
      
        'SuperAmount,T.Notes, T.Active,UseTimeCost, SalesID,Qty, PartsDes' +
        'cription, T.Tax, SaleLineID, AllowEdit , CustomerEquipmentId , t' +
        'imesheetEntryId, RepairID , signature, '
      'SignatureTime, ContactName, T.area,InvoiceNotes,'
      'IFNULL(T.OverheadRate, IFNULL(E.OverheadRate, 0)) OverheadRate,'
      'TotalAdjusted'
      
        'FROM tbltimesheets T inner join tblemployees E on (T.EmployeeID ' +
        '= E.EmployeeID)'
      'WHERE T.Active = '#39'T'#39
      'ORDER BY TimesheetDate')
    AutoCalcFields = False
    OnCalcFields = qryTimesheetsCalcFields
    Left = 118
    Top = 312
    object qryTimesheetsEmployeeName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 19
      FieldName = 'EmployeeName'
      Origin = 'tbltimesheets.EmployeeName'
      Size = 255
    end
    object qryTimesheetsarea: TWideStringField
      DisplayWidth = 20
      FieldName = 'Area'
      Size = 50
    end
    object qryTimesheetstimesheetDate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 9
      FieldName = 'timesheetDate'
      Origin = 'tbltimesheets.TimesheetDate'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryTimesheetsJob: TWideStringField
      DisplayWidth = 12
      FieldName = 'Job'
      Origin = 'tbltimesheets.Job'
      Size = 255
    end
    object qryTimesheetsPayRateTypeName: TWideStringField
      DisplayLabel = 'Rate Type'
      DisplayWidth = 15
      FieldName = 'PayRateTypeName'
      Origin = 'tbltimesheets.PayRateTypeName'
      Size = 255
    end
    object qryTimesheetsLabourCost: TFloatField
      DisplayLabel = 'Salary / Rate'
      DisplayWidth = 10
      FieldName = 'LabourCost'
      Origin = 'tbltimesheets.LabourCost'
      currency = True
    end
    object qryTimesheetsHours: TFloatField
      DisplayWidth = 7
      FieldName = 'Hours'
      Origin = 'tbltimesheets.Hours'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryTimesheetsTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'Total'
      Origin = 'tbltimesheets.Total'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object qryTimesheetsServiceName: TWideStringField
      DisplayLabel = 'Service Name'
      DisplayWidth = 30
      FieldName = 'ServiceName'
      Origin = 'tbltimesheets.ServiceName'
      Size = 255
    end
    object qryTimesheetsQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tbltimesheets.Qty'
    end
    object qryTimesheetsChargeRate: TFloatField
      DisplayLabel = 'Rate per Hour (Inc)'
      DisplayWidth = 13
      FieldName = 'ChargeRate'
      Origin = 'tbltimesheets.ChargeRate'
      currency = True
    end
    object qryTimesheetsServiceDate: TDateField
      DisplayLabel = 'Service Date'
      DisplayWidth = 10
      FieldName = 'ServiceDate'
      Origin = 'tbltimesheets.ServiceDate'
    end
    object qryTimesheetsClassName: TWideStringField
      DisplayWidth = 255
      FieldName = 'ClassName'
      Origin = 'tbltimesheets.ClassName'
      Size = 255
    end
    object qryTimesheetsNotes: TWideMemoField
      DisplayWidth = 40
      FieldName = 'Notes'
      Origin = 'tbltimesheets.Notes'
      BlobType = ftWideMemo
    end
    object qryTimesheetsInvoiceNotes: TWideMemoField
      DisplayLabel = 'Invoice Notes'
      DisplayWidth = 40
      FieldName = 'InvoiceNotes'
      Origin = 'tbltimesheets.InvoiceNotes'
      BlobType = ftWideMemo
    end
    object qryTimesheetsAllowEdit: TWideStringField
      FieldName = 'AllowEdit'
      Origin = 'tbltimesheets.AllowEdit'
      FixedChar = True
      Size = 1
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
    object qryTimesheetsUseTimeCost: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseTimeCost'
      Origin = 'tbltimesheets.UseTimeCost'
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
    object qryTimesheetsCustomerEquipmentId: TIntegerField
      FieldName = 'CustomerEquipmentId'
      Origin = 'tbltimesheets.CustomerEquipmentID'
    end
    object qryTimesheetsEquipment: TWideStringField
      FieldName = 'Equipment'
      Size = 100
    end
    object qryTimesheetsTotalServicecharge: TFloatField
      FieldName = 'TotalServicecharge'
      currency = True
    end
    object qryTimesheetsAppointmentID: TIntegerField
      FieldName = 'AppointmentID'
    end
    object qryTimesheetsRepairID: TIntegerField
      FieldName = 'RepairID'
    end
    object qryTimesheetsRepairDocNo: TStringField
      FieldKind = fkLookup
      FieldName = 'RepairDocNo'
      LookupDataSet = qryRepairLookup
      LookupKeyFields = 'RepairID'
      LookupResultField = 'RepairDocNo'
      KeyFields = 'RepairID'
      Size = 255
      Lookup = True
    end
    object qryTimesheetssignature: TBlobField
      FieldName = 'signature'
    end
    object qryTimesheetsSignatureTime: TDateTimeField
      FieldName = 'SignatureTime'
    end
    object qryTimesheetsContactName: TWideStringField
      FieldName = 'ContactName'
    end
    object qryTimesheetsOverheadRate: TFloatField
      DisplayLabel = 'Overhead~Rate'
      FieldName = 'OverheadRate'
    end
    object qryTimesheetsTotalAdjusted: TFloatField
      DisplayLabel = 'Total~Adjusted'
      FieldName = 'TotalAdjusted'
    end
    object qryTimesheetsSignatureMemo: TStringField
      FieldKind = fkCalculated
      FieldName = 'SignatureMemo'
      Calculated = True
    end
    object qryTimesheetsOverheadCost: TFloatField
      DisplayLabel = 'Overhead~Cost'
      FieldKind = fkCalculated
      FieldName = 'OverheadCost'
      DisplayFormat = '#####00.##'
      Calculated = True
    end
  end
  object dsTimeSheets: TDataSource [35]
    AutoEdit = False
    DataSet = qryTimesheets
    Left = 118
    Top = 341
  end
  object qryEmployee: TERPQuery [36]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'EmployeeID,'
      'CONCAT_WS('#39' '#39', FirstName, LastName) As EmployeeName'
      'FROM tblEmployees'
      'WHERE Active = '#39'T'#39
      'ORDER BY EmployeeName')
    Left = 89
    Top = 226
  end
  object qryServices: TERPQuery [37]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ID, ServiceName, EmployeeID, Rate, PartID, PartName'
      'FROM tblpaysemployeeservices'
      'WHERE (EmployeeID = :xEmpID)'
      'ORDER BY ServiceName')
    Top = 110
    ParamData = <
      item
        DataType = ftString
        Name = 'xEmpID'
        Value = ''
      end>
  end
  object qryRateType: TERPQuery [38]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'RateID, Description, Multiplier'
      'FROM tblpayrates'
      
        'WHERE (Active = "T" AND IsLeave = "F" AND Description NOT LIKE "' +
        '%Leave%" AND Description NOT LIKE "Termination%")'
      'ORDER BY Description;')
    Left = 30
    Top = 110
  end
  object qryGridClass: TERPQuery [39]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName, tblClass.Active'
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Top = 139
  end
  object qryPOLines: TERPQuery [40]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PurchaseOrderID, Shipped, BackOrder, LineCost, TotalLineA' +
        'mount, ETADate'
      'FROM tblpurchaselines'
      'WHERE CustomerJobID=:JobID AND ProductID=:ProductID')
    Left = 89
    Top = 197
    ParamData = <
      item
        DataType = ftString
        Name = 'JobID'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
  end
  object DSTimesheetEntry: TDataSource [41]
    DataSet = qryTimesheetEntry
    Left = 60
    Top = 283
  end
  object qryTimesheetEntry: TERPQuery [42]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tbltimesheetentry')
    Left = 60
    Top = 255
  end
  object qryPayRates: TERPQuery [43]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'RateID, Description, Multiplier'
      'FROM tblpayrates'
      
        'WHERE (Active = "T" AND IsLeave = "F" AND Description NOT LIKE "' +
        '%Leave%" AND Description NOT LIKE "Termination%")'
      'ORDER BY Description;')
    Left = 30
    Top = 168
  end
  object cboTermsQry: TERPQuery [44]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.TermsAmount, t' +
        'blTerms.EOM, tblTerms.EOMPlus, tblTerms.Active '
      'FROM tblTerms '
      'WHERE (tblTerms.Active='#39'T'#39' OR tblTerms.Terms=:xTerms)'
      'ORDER BY tblTerms.Terms; ')
    AfterOpen = cboTermsQryAfterOpen
    CommandTimeout = 30
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xTerms'
      end>
    object cboTermsQryTerms: TWideStringField
      DisplayWidth = 50
      FieldName = 'Terms'
      Size = 50
    end
    object cboTermsQryTermsID: TIntegerField
      FieldName = 'TermsID'
      Visible = False
    end
    object cboTermsQryTermsAmount: TIntegerField
      FieldName = 'TermsAmount'
      Visible = False
    end
    object cboTermsQryEOM: TWideStringField
      FieldName = 'EOM'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboTermsQryEOMPlus: TWideStringField
      FieldName = 'EOMPlus'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboTermsQryActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryPartsEquip: TERPQuery [45]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblcustomerequip.ID, '
      'tblcustomerequip.EquipmentID,'
      'tblcustomerequip.EquipName,'
      'tblcustomerequip.Description,'
      'tblcustomerequip.Manufacture,'
      'tblcustomerequip.model,'
      'tblcustomerequip.Serialno,'
      'tblcustomerequip.Registration,'
      'tblcustomerequip.WarantyPeriod,'
      'tblcustomerequip.WarantyFinishDate,'
      'tblcustomerequip.WarantyStartDate, '
      'tblequipment.ProductId,'
      'tblcustomerequip.Active, '
      'tblcustomerequip.Notes'
      'from tblcustomerequip '
      
        'Inner Join tblequipment ON tblcustomerequip.EquipmentID = tblequ' +
        'ipment.EquipmentID'
      'Where tblcustomerequip.ClientId = :ClientId '
      'and tblcustomerequip.Quantity <> 0'
      'order by tblcustomerequip.EquipName')
    AutoCalcFields = False
    Left = 30
    Top = 226
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientId'
      end>
    object qryPartsEquipID: TIntegerField
      FieldName = 'ID'
    end
    object qryPartsEquipEquipmentID: TIntegerField
      FieldName = 'EquipmentID'
    end
    object qryPartsEquipEquipName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 15
      FieldName = 'EquipName'
      Size = 255
    end
    object qryPartsEquipDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryPartsEquipManufacture: TWideStringField
      DisplayWidth = 10
      FieldName = 'Manufacture'
      Size = 100
    end
    object qryPartsEquipmodel: TWideStringField
      DisplayLabel = 'Model'
      DisplayWidth = 10
      FieldName = 'model'
      Size = 100
    end
    object qryPartsEquipSerialno: TWideStringField
      DisplayLabel = 'Serial#'
      DisplayWidth = 10
      FieldName = 'Serialno'
      Size = 100
    end
    object qryPartsEquipRegistration: TWideStringField
      DisplayWidth = 10
      FieldName = 'Registration'
      Size = 100
    end
    object qryPartsEquipWarantyPeriod: TFloatField
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 10
      FieldName = 'WarantyPeriod'
    end
    object qryPartsEquipWarantyFinishDate: TDateTimeField
      DisplayLabel = 'Warranty Finish Date'
      DisplayWidth = 18
      FieldName = 'WarantyFinishDate'
    end
    object qryPartsEquipWarantyStartDate: TDateTimeField
      FieldName = 'WarantyStartDate'
    end
    object qryPartsEquipProductId: TLargeintField
      FieldName = 'ProductId'
    end
    object qryPartsEquipActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryPartsEquipNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
  end
  object qryUnitOfMeasure: TERPQuery [46]
    Connection = MyConnection
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :xPartID or U.Pa' +
        'rtID = 0) '
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName'
      '*/'
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )'
      'Order By UnitID desc ,UnitName;')
    Left = 88
    Top = 81
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end>
    object qryUnitOfMeasureUnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object qryUnitOfMeasureUnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
    object qryUnitOfMeasureMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object qryUnitOfMeasureBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Size = 15
    end
  end
  object QryInvoices: TERPQuery [47]
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSales')
    AfterOpen = QryInvoicesAfterOpen
    Top = 312
    object QryInvoicesSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Sale#'
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
    end
    object QryInvoicesCustomerName: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 24
      FieldName = 'CustomerName'
      Origin = 'tblsales.CustomerName'
      Size = 255
    end
    object QryInvoicesEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblsales.EmployeeName'
      Size = 255
    end
    object QryInvoicesSaleDate: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 12
      FieldName = 'SaleDate'
      Origin = 'tblsales.SaleDate'
    end
    object QryInvoicesTotalAmountInc: TFloatField
      DisplayLabel = 'Total Amount(Inc)'
      DisplayWidth = 14
      FieldName = 'TotalAmountInc'
      Origin = 'tblsales.TotalAmountInc'
      currency = True
    end
    object QryInvoicesPayment: TFloatField
      DisplayWidth = 10
      FieldName = 'Payment'
      Origin = 'tblsales.Payment'
      currency = True
    end
    object QryInvoicesBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'Balance'
      Origin = 'tblsales.Balance'
      currency = True
    end
    object QryInvoicesTerms: TWideStringField
      DisplayWidth = 15
      FieldName = 'Terms'
      Origin = 'tblsales.Terms'
      Size = 255
    end
    object QryInvoicesClass: TWideStringField
      DisplayWidth = 13
      FieldName = 'Class'
      Origin = 'tblsales.Class'
      Size = 255
    end
    object QryInvoicesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object QryInvoicesQuoteStatus: TWideStringField
      FieldName = 'QuoteStatus'
      Origin = 'tblsales.QuoteStatus'
      Visible = False
      Size = 255
    end
    object QryInvoicesTotalAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalAmount'
    end
  end
  object QryAppointments: TERPQuery [48]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      
        'A.AppDate , A.Actual_AppDate, A.ServiceDesc, A.totalInc, a.statu' +
        's, A.appointID, A.CustomerDetails,A.Notes, '
      'A.TrainerID, A.Actual_starttime, A.Actual_Endtime'
      'FROM'
      '`tblappointments` AS `a`'
      'Inner Join `tblclients` AS `c` ON `a`.`CusID` = `c`.`ClientID`'
      ''
      'WHERE'
      '`a`.`RepairID` =  :RepairId')
    AfterOpen = QryAppointmentsAfterOpen
    Left = 30
    Top = 312
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RepairId'
        Value = 0
      end>
    object QryAppointmentsAppDate: TDateField
      DisplayLabel = 'Date'
      DisplayWidth = 12
      FieldName = 'AppDate'
      Origin = 'tblappointments.AppDate'
    end
    object QryAppointmentsActual_AppDate: TDateField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'Actual_AppDate'
      Origin = 'tblappointments.Actual_AppDate'
    end
    object QryAppointmentsServiceDesc: TWideStringField
      DisplayWidth = 50
      FieldName = 'ServiceDesc'
      Origin = 'tblappointments.ServiceDesc'
      Size = 50
    end
    object QryAppointmentsTotalInc: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalInc'
      Origin = 'tblappointments.totalInc'
      currency = True
    end
    object QryAppointmentsStatus: TWideStringField
      DisplayWidth = 255
      FieldName = 'Status'
      Origin = 'tblappointments.status'
      Size = 255
    end
    object QryAppointmentsAppointID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AppointID'
      Origin = 'tblappointments.appointID'
      Visible = False
    end
    object QryAppointmentsCustomerDetails: TWideStringField
      FieldName = 'CustomerDetails'
      Origin = 'tblappointments.CustomerDetails'
      Size = 255
    end
    object QryAppointmentsNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblappointments.Notes'
      BlobType = ftWideMemo
    end
    object QryAppointmentsTrainerID: TIntegerField
      FieldName = 'TrainerID'
      Visible = False
    end
    object QryAppointmentsRep: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'Rep'
      LookupDataSet = QryapptTrainer
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'TrainerID'
      Size = 100
      Lookup = True
    end
    object QryAppointmentsActual_Endtime: TDateTimeField
      DisplayLabel = 'End Date'
      FieldName = 'Actual_Endtime'
    end
  end
  object dsInvoices: TDataSource [49]
    DataSet = QryInvoices
    Top = 341
  end
  object dsAppointments: TDataSource [50]
    DataSet = QryAppointments
    Left = 30
    Top = 341
  end
  object Qryrepairdetails: TERPQuery [51]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrepairdetails'
      'Where RepairID= :ID;')
    OnCalcFields = tblrepairpartsCalcFields
    Left = 60
    Top = 312
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object QryrepairdetailsRepairDetailId: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'RepairDetailId'
      Origin = 'tblrepairdetails.RepairDetailId'
    end
    object QryrepairdetailsGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tblrepairdetails.Globalref'
      Size = 255
    end
    object QryrepairdetailsRepairID: TLargeintField
      FieldName = 'RepairID'
      Origin = 'tblrepairdetails.RepairID'
    end
    object QryrepairdetailsGSFSReceiptNo: TWideStringField
      FieldName = 'GSFSReceiptNo'
      Origin = 'tblrepairdetails.GSFSReceiptNo'
      Size = 255
    end
    object QryrepairdetailsFaultConditionID: TLargeintField
      FieldName = 'FaultConditionID'
      Origin = 'tblrepairdetails.FaultConditionID'
    end
    object QryrepairdetailsFaultConditionDesc: TWideStringField
      FieldName = 'FaultConditionDesc'
      Origin = 'tblrepairdetails.FaultConditionDesc'
      Size = 255
    end
    object QryrepairdetailsFaultSymptomID: TLargeintField
      FieldName = 'FaultSymptomID'
      Origin = 'tblrepairdetails.FaultSymptomID'
    end
    object QryrepairdetailsFaultSymptomDesc: TWideStringField
      FieldName = 'FaultSymptomDesc'
      Origin = 'tblrepairdetails.FaultSymptomDesc'
      Size = 255
    end
    object QryrepairdetailsFaultDefectID: TLargeintField
      FieldName = 'FaultDefectID'
      Origin = 'tblrepairdetails.FaultDefectID'
    end
    object QryrepairdetailsFaultDefectDesc: TWideStringField
      FieldName = 'FaultDefectDesc'
      Origin = 'tblrepairdetails.FaultDefectDesc'
      Size = 255
    end
    object QryrepairdetailsFaultRepairID: TLargeintField
      FieldName = 'FaultRepairID'
      Origin = 'tblrepairdetails.FaultRepairID'
    end
    object QryrepairdetailsFaultRepairDesc: TWideStringField
      FieldName = 'FaultRepairDesc'
      Origin = 'tblrepairdetails.FaultRepairDesc'
      Size = 255
    end
    object QryrepairdetailsFaultSectionId: TLargeintField
      FieldName = 'FaultSectionId'
      Origin = 'tblrepairdetails.FaultSectionId'
    end
    object QryrepairdetailsFaultSectionDesc: TWideStringField
      FieldName = 'FaultSectionDesc'
      Origin = 'tblrepairdetails.FaultSectionDesc'
      Size = 255
    end
    object QryrepairdetailsRepaircode: TWideStringField
      FieldName = 'Repaircode'
      Origin = 'tblrepairdetails.Repaircode'
      Size = 255
    end
    object QryrepairdetailsMaterialcost: TFloatField
      FieldName = 'Materialcost'
      Origin = 'tblrepairdetails.Materialcost'
      currency = True
    end
    object QryrepairdetailsFreightcost: TFloatField
      FieldName = 'Freightcost'
      Origin = 'tblrepairdetails.Freightcost'
      currency = True
    end
    object QryrepairdetailsOtheramount: TFloatField
      FieldName = 'Otheramount'
      Origin = 'tblrepairdetails.Otheramount'
      currency = True
    end
    object QryrepairdetailsServicetype: TWideStringField
      FieldName = 'Servicetype'
      Origin = 'tblrepairdetails.Servicetype'
      FixedChar = True
      Size = 2
    end
    object QryrepairdetailsAuthorisationnumber: TWideStringField
      FieldName = 'Authorisationnumber'
      Origin = 'tblrepairdetails.Authorisationnumber'
      Size = 255
    end
    object Qryrepairdetailsmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblrepairdetails.mstimestamp'
    end
    object QryrepairdetailsFaultConditionCode: TWideStringField
      FieldName = 'FaultConditionCode'
      Origin = 'tblrepairdetails.FaultConditionCode'
    end
    object QryrepairdetailsFaultSymptomcode: TWideStringField
      FieldName = 'FaultSymptomcode'
      Origin = 'tblrepairdetails.FaultSymptomcode'
    end
    object QryrepairdetailsFaultDefectCode: TWideStringField
      FieldName = 'FaultDefectCode'
      Origin = 'tblrepairdetails.FaultDefectCode'
    end
    object QryrepairdetailsFaultRepairCode: TWideStringField
      FieldName = 'FaultRepairCode'
      Origin = 'tblrepairdetails.FaultRepairCode'
    end
    object QryrepairdetailsFaultSectionCode: TWideStringField
      FieldName = 'FaultSectionCode'
      Origin = 'tblrepairdetails.FaultSectionCode'
    end
    object QryrepairdetailsAscClaimRemarks: TWideMemoField
      FieldName = 'AscClaimRemarks'
      Origin = 'tblrepairdetails.AscClaimRemarks'
      BlobType = ftWideMemo
    end
    object QryrepairdetailsManInvNo: TLargeintField
      FieldName = 'ManInvNo'
      Origin = 'tblrepairdetails.ManInvNo'
    end
    object QryrepairdetailsManInvDate: TDateTimeField
      FieldName = 'ManInvDate'
      Origin = 'tblrepairdetails.ManInvDate'
    end
    object QryrepairdetailsModel: TWideStringField
      FieldName = 'Model'
      Origin = 'tblrepairdetails.Model'
      Size = 50
    end
    object QryrepairdetailsSerialNo: TWideStringField
      FieldName = 'SerialNo'
      Origin = 'tblrepairdetails.SerialNo'
      Size = 255
    end
    object QryrepairdetailsManufactureID: TIntegerField
      FieldName = 'ManufactureID'
      Origin = 'tblrepairdetails.ManufactureID'
    end
    object QryrepairdetailsManufacture: TWideStringField
      FieldName = 'Manufacture'
      Origin = 'tblrepairdetails.Manufacture'
      Size = 100
    end
    object QryrepairdetailsRetailerID: TIntegerField
      FieldName = 'RetailerID'
      Origin = 'tblrepairdetails.RetailerID'
    end
    object QryrepairdetailsRetailerName: TWideStringField
      FieldName = 'RetailerName'
      Origin = 'tblrepairdetails.RetailerName'
      Size = 100
    end
    object QryrepairdetailsReceiptNumberCaption: TWideStringField
      FieldName = 'ReceiptNumberCaption'
      Origin = 'tblrepairdetails.ReceiptNumberCaption'
      Size = 100
    end
    object QryrepairdetailsRetailerAddress: TWideStringField
      FieldKind = fkLookup
      FieldName = 'RetailerAddress'
      LookupDataSet = QryRetailer
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Address'
      KeyFields = 'RetailerID'
      Size = 256
      Lookup = True
    end
  end
  object dsrepairdetails: TDataSource [52]
    DataSet = Qryrepairdetails
    Left = 60
    Top = 341
  end
  object QryRepairFaultsCondition: TERPQuery [53]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT *, concat_ws('#39'-'#39' , Code,Description) as Details FROM tblr' +
        'epairfaults'
      
        'Where Category = '#39'C'#39' and (ifnull(ManufactureID,0) = 0 or ifnull(' +
        'ManufactureID,0) =:ManufactureID)')
    OnCalcFields = tblrepairpartsCalcFields
    Left = 89
    Top = 139
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ManufactureID'
      end>
    object QryRepairFaultsConditionDetails: TWideStringField
      DisplayWidth = 30
      FieldName = 'Details'
      Size = 121
    end
    object QryRepairFaultsConditionDescription: TWideStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Visible = False
      Size = 100
    end
    object QryRepairFaultsConditionRepairFaultID: TLargeintField
      FieldName = 'RepairFaultID'
      Visible = False
    end
    object QryRepairFaultsConditionGlobalref: TWideStringField
      FieldName = 'Globalref'
      Visible = False
      Size = 255
    end
    object QryRepairFaultsConditioncode: TWideStringField
      FieldName = 'code'
      Visible = False
    end
    object QryRepairFaultsConditionCategory: TWideStringField
      FieldName = 'Category'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsConditionActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsConditionmsTimestamp: TDateTimeField
      FieldName = 'msTimestamp'
      Visible = False
    end
  end
  object QryRepairFaultsSymptom: TERPQuery [54]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT *, concat_ws('#39'-'#39' , Code,Description) as Details FROM tblr' +
        'epairfaults'
      
        'Where Category = '#39'S'#39' and (ifnull(ManufactureID,0) = 0 or ifnull(' +
        'ManufactureID,0) =:ManufactureID)')
    OnCalcFields = tblrepairpartsCalcFields
    Left = 60
    Top = 139
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ManufactureID'
      end>
    object QryRepairFaultsSymptomDetails: TWideStringField
      DisplayWidth = 30
      FieldName = 'Details'
      Origin = '.Details'
      Size = 121
    end
    object QryRepairFaultsSymptomRepairFaultID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'RepairFaultID'
      Origin = 'tblrepairfaults.RepairFaultID'
      Visible = False
    end
    object QryRepairFaultsSymptomGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tblrepairfaults.Globalref'
      Visible = False
      Size = 255
    end
    object QryRepairFaultsSymptomcode: TWideStringField
      FieldName = 'code'
      Origin = 'tblrepairfaults.code'
      Visible = False
    end
    object QryRepairFaultsSymptomCategory: TWideStringField
      FieldName = 'Category'
      Origin = 'tblrepairfaults.Category'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsSymptomDescription: TWideStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Origin = 'tblrepairfaults.Description'
      Visible = False
      Size = 100
    end
    object QryRepairFaultsSymptomActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblrepairfaults.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsSymptommsTimestamp: TDateTimeField
      FieldName = 'msTimestamp'
      Origin = 'tblrepairfaults.msTimestamp'
      Visible = False
    end
  end
  object QryRepairFaultsDefect: TERPQuery [55]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT *, concat_ws('#39'-'#39' , Code,Description) as Details FROM tblr' +
        'epairfaults'
      
        'Where Category = '#39'D'#39' and (ifnull(ManufactureID,0) = 0 or ifnull(' +
        'ManufactureID,0) =:ManufactureID)')
    OnCalcFields = tblrepairpartsCalcFields
    Left = 59
    Top = 53
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ManufactureID'
      end>
    object QryRepairFaultsDefectDetails: TWideStringField
      DisplayWidth = 30
      FieldName = 'Details'
      Size = 121
    end
    object QryRepairFaultsDefectRepairFaultID: TLargeintField
      FieldName = 'RepairFaultID'
      Visible = False
    end
    object QryRepairFaultsDefectGlobalref: TWideStringField
      FieldName = 'Globalref'
      Visible = False
      Size = 255
    end
    object QryRepairFaultsDefectcode: TWideStringField
      FieldName = 'code'
      Visible = False
    end
    object QryRepairFaultsDefectCategory: TWideStringField
      FieldName = 'Category'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsDefectDescription: TWideStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Visible = False
      Size = 100
    end
    object QryRepairFaultsDefectActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsDefectmsTimestamp: TDateTimeField
      FieldName = 'msTimestamp'
      Visible = False
    end
  end
  object QryRepairFaultsRepair: TERPQuery [56]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT *, concat_ws('#39'-'#39' , Code,Description) as Details FROM tblr' +
        'epairfaults'
      
        'Where Category = '#39'R'#39' and (ifnull(ManufactureID,0) = 0 or ifnull(' +
        'ManufactureID,0) =:ManufactureID)')
    OnCalcFields = tblrepairpartsCalcFields
    Left = 118
    Top = 139
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ManufactureID'
      end>
    object QryRepairFaultsRepairDetails: TWideStringField
      DisplayWidth = 30
      FieldName = 'Details'
      Size = 121
    end
    object QryRepairFaultsRepairRepairFaultID: TLargeintField
      FieldName = 'RepairFaultID'
      Visible = False
    end
    object QryRepairFaultsRepairGlobalref: TWideStringField
      FieldName = 'Globalref'
      Visible = False
      Size = 255
    end
    object QryRepairFaultsRepaircode: TWideStringField
      FieldName = 'code'
      Visible = False
    end
    object QryRepairFaultsRepairCategory: TWideStringField
      FieldName = 'Category'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsRepairDescription: TWideStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Visible = False
      Size = 100
    end
    object QryRepairFaultsRepairActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsRepairmsTimestamp: TDateTimeField
      FieldName = 'msTimestamp'
      Visible = False
    end
  end
  object QryRepairFaultsSection: TERPQuery [57]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT *, concat_ws('#39'-'#39' , Code,Description) as Details FROM tblr' +
        'epairfaults'
      
        'Where Category = '#39'L'#39' and (ifnull(ManufactureID,0) = 0 or ifnull(' +
        'ManufactureID,0) =:ManufactureID)')
    OnCalcFields = tblrepairpartsCalcFields
    Left = 30
    Top = 139
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ManufactureID'
      end>
    object QryRepairFaultsSectionDetails: TWideStringField
      DisplayWidth = 30
      FieldName = 'Details'
      Size = 121
    end
    object QryRepairFaultsSectionRepairFaultID: TLargeintField
      FieldName = 'RepairFaultID'
      Visible = False
    end
    object QryRepairFaultsSectionGlobalref: TWideStringField
      FieldName = 'Globalref'
      Visible = False
      Size = 255
    end
    object QryRepairFaultsSectioncode: TWideStringField
      FieldName = 'code'
      Visible = False
    end
    object QryRepairFaultsSectionCategory: TWideStringField
      FieldName = 'Category'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsSectionDescription: TWideStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Visible = False
      Size = 100
    end
    object QryRepairFaultsSectionActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryRepairFaultsSectionmsTimestamp: TDateTimeField
      FieldName = 'msTimestamp'
      Visible = False
    end
  end
  object qryManufacture: TERPQuery [58]
    Connection = MyConnection
    SQL.Strings = (
      
        'Select ID, Name  from tblManufacture where Active = '#39'T'#39' order by' +
        ' name')
    Options.LongStrings = False
    Left = 30
    Top = 197
    object qryManufactureName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 30
    end
    object qryManufactureID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
  end
  object QryRetailer: TERPQuery [59]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ClientID, Company, replace(replace(replace(replace(replac' +
        'e(Concat_ws('#39', '#39'  , Street, Street2, Street3, Suburb, State, Pos' +
        'tcode),'#39', ,'#39','#39','#39'),'#39', ,'#39','#39','#39'),'#39', ,'#39','#39','#39'),'#39', ,'#39','#39','#39'),'#39', ,'#39','#39','#39') as' +
        ' Address'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active = '#39'T'#39 +
        ' And tblclients.Customer = '#39'T'#39' '
      'ORDER BY tblclients.Company')
    Filtered = True
    Left = 118
    Top = 255
    object QryRetailerCompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object QryRetailerClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      Visible = False
    end
    object QryRetailerAddress: TWideStringField
      FieldName = 'Address'
      Origin = '.Address'
      Visible = False
      Size = 1540
    end
  end
  object dsRetailer: TDataSource [60]
    DataSet = QryRetailer
    Left = 118
    Top = 283
  end
  object dsSmartOrders: TDataSource [61]
    DataSet = QrySmartOrders
    Top = 283
  end
  object QrySmartOrders: TERPQuery [62]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'SL.SmartOrderID,'
      'SL.PARTSNAME,'
      'SL.ClassName,'
      'SL.Qty,'
      'SL.UnitofMeasure,'
      'PL.QtySold,'
      
        'ifnull(PL.UnitofMeasureShipped,0)+ifnull((Select Sum(BOL.Shipped' +
        ') from tblpurchaselines BOL where  BOL.baseLineNo = PL.PurchaseL' +
        'ineId),0)  as Shipped,'
      
        'ifnull(PL.TotalLineAmount,0)+ifnull((Select Sum(BOL.TotalLineAmo' +
        'untinc) from tblpurchaselines BOL where  BOL.baseLineNo = PL.Pur' +
        'chaseLineId),0)  as TotalLineAmount,'
      
        'ifnull((Select Max(BOL.LineCost) from tblpurchaselines BOL where' +
        '  BOL.baseLineNo = PL.PurchaseLineId and ifnull(BOL.Shipped,0)=0' +
        '),SL.LinePrice)   as BOCost,'
      'PL.UnitofMeasurePOLines, '
      'PL.PurchaseOrderID,'
      'P.InvoiceNumber as POInvoiceNumber'
      'FROM'
      'tblsmartorderlines AS SL '
      
        'Left Join tblpurchaselines AS PL ON SL.SmartOrderID = PL.SmartOr' +
        'derID AND SL.SmartOrderLinesId = PL.SmartOrderLineID'
      
        'left join tblpurchaseorders as P on P.PurchaseOrderID = PL.Purch' +
        'aseOrderID'
      'WHERE'
      'SL.RepairId = :repairID'
      'and SL.SmartOrderID = :SmartOrderID'
      'Order by SL.PARTSNAME')
    OnCalcFields = QrySmartOrdersCalcFields
    DetailFields = 'SmartOrderID'
    Top = 255
    ParamData = <
      item
        DataType = ftInteger
        Name = 'repairID'
        Value = 0
      end
      item
        DataType = ftUnknown
        Name = 'SmartOrderID'
      end>
    object QrySmartOrdersPARTSNAME: TWideStringField
      FieldName = 'PARTSNAME'
      Origin = 'tblsmartorderlines.PARTSNAME'
      Size = 255
    end
    object QrySmartOrdersClassName: TWideStringField
      FieldName = 'ClassName'
      Origin = 'tblsmartorderlines.ClassName'
      Size = 255
    end
    object QrySmartOrdersQty: TFloatField
      FieldName = 'Qty'
      Origin = 'tblsmartorderlines.Qty'
    end
    object QrySmartOrdersUnitofMeasure: TWideStringField
      FieldName = 'UnitofMeasure'
      Origin = 'tblsmartorderlines.UnitofMeasure'
      Size = 255
    end
    object QrySmartOrdersUnitofMeasurePOLines: TWideStringField
      FieldName = 'UnitofMeasurePOLines'
      Origin = 'PL.UnitofMeasurePOLines'
      Size = 255
    end
    object QrySmartOrdersPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
      Origin = 'PL.PurchaseOrderID'
    end
    object QrySmartOrdersBackOrder: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BackOrder'
      Calculated = True
    end
    object QrySmartOrdersQtySold: TFloatField
      FieldName = 'QtySold'
      Origin = 'PL.QtySold'
    end
    object QrySmartOrdersShipped: TFloatField
      FieldName = 'Shipped'
      Origin = '.Shipped'
    end
    object QrySmartOrdersTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
      currency = True
    end
    object QrySmartOrdersBOCost: TFloatField
      FieldName = 'BOCost'
    end
    object QrySmartOrdersBackOrdercost: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BackOrdercost'
      currency = True
      Calculated = True
    end
    object QrySmartOrdersSmartOrderID: TIntegerField
      FieldName = 'SmartOrderID'
    end
    object QrySmartOrdersPOInvoiceNumber: TWideStringField
      DisplayLabel = 'PO Invoice No'
      DisplayWidth = 10
      FieldName = 'POInvoiceNumber'
      Size = 30
    end
  end
  object QrySmartOrderHeader: TERPQuery [63]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'SO.SmartOrderID,'
      'SO.CreationDate,'
      'SO.SmartOrderDesc'
      'FROM'
      'tblsmartorder AS SO'
      'WHERE'
      
        'SO.SmartOrderId in (select tblSmartOrderLines.SmartOrderId from ' +
        'tblSmartOrderLines where tblSmartOrderLines.repairId =:RepairID)')
    AfterOpen = QrySmartOrderHeaderAfterOpen
    AfterScroll = QrySmartOrderHeaderAfterScroll
    Left = 118
    Top = 370
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepairID'
      end>
    object QrySmartOrderHeaderSmartOrderID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SmartOrderID'
      Origin = 'tblsmartorder.SmartOrderID'
    end
    object QrySmartOrderHeaderCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblsmartorder.CreationDate'
    end
    object QrySmartOrderHeaderSmartOrderDesc: TWideStringField
      FieldName = 'SmartOrderDesc'
      Origin = 'tblsmartorder.SmartOrderDesc'
      Size = 255
    end
  end
  object dsSmartOrderHeader: TDataSource [64]
    DataSet = QrySmartOrderHeader
    Left = 118
    Top = 399
  end
  inherited popSpelling: TPopupMenu
    Left = 88
    Top = 21
  end
  inherited tmrdelayMsg: TTimer
    Left = 32
    Top = 21
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 674
    Top = 37
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 60
    Top = 21
  end
  inherited MyConnection: TERPConnection
    Left = 5
    Top = 557
  end
  inherited DataState: TDataState
    Left = 260
    Top = 45
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 653169
    Left = 308
    Top = 37
    inherited CustomiseGrid: TMenuItem
      HelpContext = 653170
      OnClick = mnuCustomiseGridClick
    end
    object mnuProductStatus: TMenuItem
      Caption = 'Product Status'
      HelpContext = 653559
      Visible = False
      OnClick = mnuProductStatusClick
    end
    object CustomFields1: TMenuItem
      Caption = 'Custom Fields'
      HelpContext = 653560
      OnClick = CustomFields1Click
    end
    object mnuAlternateProduct: TMenuItem
      Caption = 'Alternate Products'
      HelpContext = 653688
      OnClick = mnuAlternateProductClick
    end
  end
  inherited imgsort: TImageList
    Left = 4
    Top = 21
    Bitmap = {
      494C010102005002280410001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object QryapptTrainer: TERPQuery [73]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'EmployeeID,'
      'CONCAT_WS('#39' '#39', FirstName, LastName) As EmployeeName'
      'FROM tblEmployees')
    Left = 118
    Top = 197
  end
  object dsBills: TDataSource [74]
    DataSet = qrybills
    Left = 30
    Top = 283
  end
  object qrybills: TERPQuery [75]
    Connection = MyConnection
    SQL.Strings = (
      'select'
      'PO.PurchaseOrderNumber,'
      'PO.SupplierName,'
      'PO.InvoiceNumber,'
      'PO.Deleted , '
      
        'PL.PurchaseOrderID,PL.`AccountName`,PL.`EquipmentName`,PL.`Total' +
        'LineAmountInc` , '
      
        'PL.`LineTaxRate`*100 LineTaxRate,PL.`LineTaxCode`,PL.`LineTax`,P' +
        'L.`TotalLineAmount`'
      'from `tblpurchaselines` PL'
      
        'inner join tblpurchaseorders PO on PO.PurchaseOrderID = PL.Purch' +
        'aseOrderID'
      'where PL.repairID=  :RepairId'
      'and PO.ISBill ='#39'T'#39)
    AfterOpen = qrybillsAfterOpen
    Left = 30
    Top = 255
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RepairId'
        Value = 0
      end>
    object qrybillsAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object qrybillsEquipmentName: TWideStringField
      FieldName = 'EquipmentName'
      Size = 100
    end
    object qrybillsTotalLineAmountInc: TFloatField
      FieldName = 'TotalLineAmountInc'
      currency = True
    end
    object qrybillsPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object qrybillsLineTaxCode: TWideStringField
      FieldName = 'LineTaxCode'
      Size = 5
    end
    object qrybillsLineTax: TFloatField
      FieldName = 'LineTax'
      currency = True
    end
    object qrybillsTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
      currency = True
    end
    object qrybillsSupplierName: TWideStringField
      FieldName = 'SupplierName'
      Size = 255
    end
    object qrybillsPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
      Size = 30
    end
    object qrybillsLineTaxRate: TFloatField
      FieldName = 'LineTaxRate'
      DisplayFormat = '##0.0#%'
    end
    object qrybillsInvoiceNumber: TWideStringField
      FieldName = 'InvoiceNumber'
      Size = 30
    end
    object qrybillsDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
  end
  object QrySalesOrders: TERPQuery [76]
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSales')
    AfterOpen = QrySalesOrdersAfterOpen
    Left = 89
    Top = 457
    object IntegerField1: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Sale#'
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tblSales.SaleID'
    end
    object WideStringField1: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 24
      FieldName = 'CustomerName'
      Origin = 'tblSales.CustomerName'
      Size = 255
    end
    object WideStringField2: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblSales.EmployeeName'
      Size = 255
    end
    object DateField1: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 12
      FieldName = 'SaleDate'
      Origin = 'tblSales.SaleDate'
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Total Amount(Inc)'
      DisplayWidth = 14
      FieldName = 'TotalAmountInc'
      Origin = 'tblSales.TotalAmountInc'
      currency = True
    end
    object FloatField2: TFloatField
      DisplayWidth = 10
      FieldName = 'Payment'
      Origin = 'tblSales.Payment'
      currency = True
    end
    object FloatField3: TFloatField
      DisplayWidth = 10
      FieldName = 'Balance'
      Origin = 'tblSales.Balance'
      currency = True
    end
    object WideStringField3: TWideStringField
      DisplayWidth = 15
      FieldName = 'Terms'
      Origin = 'tblSales.Terms'
      Size = 255
    end
    object WideStringField4: TWideStringField
      DisplayWidth = 13
      FieldName = 'Class'
      Origin = 'tblSales.Class'
      Size = 255
    end
    object QrySalesOrdersQuoteStatus: TWideStringField
      DisplayWidth = 255
      FieldName = 'QuoteStatus'
      Size = 255
    end
    object QrySalesOrdersDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
  end
  object dsSalesOrders: TDataSource [77]
    DataSet = QrySalesOrders
    Left = 89
    Top = 428
  end
  object QryRAs: TERPQuery [78]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'PurchaseOrderID,'
      'ProductName,'
      'PL.Class,'
      'PL.UnitofMeasureShipped,'
      
        'concat(PL.UnitofMeasurePOLines,'#39'('#39' , PL.UnitofMeasureMultiplier,' +
        #39')'#39') as UOM, '
      'PL.UnitofMeasureQtySold'
      'FROM'
      'tblpurchaseLines PL'
      'WHERE'
      'PL.RepairId = :repairID'
      'Order by ProductName')
    OnCalcFields = QrySmartOrdersCalcFields
    MasterSource = dsRAHeaders
    MasterFields = 'PurchaseOrderID'
    DetailFields = 'PurchaseOrderID'
    Left = 30
    Top = 457
    ParamData = <
      item
        DataType = ftInteger
        Name = 'repairID'
        Value = 0
      end
      item
        DataType = ftUnknown
        Name = 'PurchaseOrderID'
      end>
    object QryRAsPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object QryRAsProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 60
    end
    object QryRAsClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object QryRAsUnitofMeasureShipped: TFloatField
      FieldName = 'UnitofMeasureShipped'
    end
    object QryRAsUOM: TWideStringField
      FieldName = 'UOM'
      Size = 279
    end
    object QryRAsUnitofMeasureQtySold: TFloatField
      FieldName = 'UnitofMeasureQtySold'
    end
  end
  object dsRAs: TDataSource [79]
    DataSet = QryRAs
    Left = 30
    Top = 428
  end
  object QryRAHeaders: TERPQuery [80]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      
        'distinct PO.PurchaseOrderID , PO.OrderDate , PO.SupplierName, PO' +
        '.Deleted'
      'FROM'
      'tblpurchaseorders AS PO'
      
        'inner join  tblpurchaselines  PL on PL.PurchaseOrderID  = PO.Pur' +
        'chaseOrderID and repairId =:RepairID'
      'WHERE isRA='#39'T'#39)
    AfterOpen = QryRAHeadersAfterOpen
    Top = 457
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepairID'
      end>
    object QryRAHeadersPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object QryRAHeadersOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
    object QryRAHeadersSupplierName: TWideStringField
      FieldName = 'SupplierName'
      Size = 255
    end
    object QryRAHeadersDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
  end
  object dsRAHeaders: TDataSource [81]
    DataSet = QryRAHeaders
    Top = 428
  end
  object popOptions: TAdvPopupMenu [82]
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 845
    Top = 29
    object mnuAuditTrial: TMenuItem
      Caption = 'Audit Trail'
      HelpContext = 653561
      OnClick = mnuAuditTrialClick
    end
    object menMeomoriseTransaction: TMenuItem
      Caption = 'Memorise Transaction'
      HelpContext = 653562
      OnClick = DoMemoriseRepairs
    end
    object menAutoMemoriseTransaction: TMenuItem
      Caption = 'Auto Memorise Transaction'
      HelpContext = 653563
      OnClick = DoMemoriseRepairs
    end
  end
  object qryRepairLookup: TERPQuery [83]
    Connection = MyConnection
    SQL.Strings = (
      'select RepairID, RepairDocNo, CustomerName from tblRepairs')
    Left = 118
    Top = 110
    object qryRepairLookupRepairDocNo: TWideStringField
      DisplayLabel = 'Repair #'
      DisplayWidth = 20
      FieldName = 'RepairDocNo'
      Size = 50
    end
    object qryRepairLookupCustomerName: TWideStringField
      DisplayLabel = 'Customer Name'
      DisplayWidth = 30
      FieldName = 'CustomerName'
      Size = 255
    end
    object qryRepairLookupRepairID: TIntegerField
      FieldName = 'RepairID'
      Visible = False
    end
  end
  object dsAssetXRef: TDataSource [84]
    DataSet = qryAssetXRef
    Top = 370
  end
  object qryAssetXRef: TERPQuery [85]
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblRepairAssetXRef')
    Top = 399
    object qryAssetXRefAssetName: TStringField
      DisplayLabel = 'Asset Name'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'AssetName'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'AssetName'
      KeyFields = 'AssetId'
      Size = 255
      Lookup = True
    end
    object qryAssetXRefAssetCode: TStringField
      DisplayLabel = 'Asset Code'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AssetCode'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'AssetCode'
      KeyFields = 'AssetId'
      Size = 50
      Lookup = True
    end
    object qryAssetXRefPurchaseDate: TDateField
      DisplayLabel = 'Purchase Date'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PurchaseDate'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'PurchDate'
      KeyFields = 'AssetId'
      Lookup = True
    end
    object qryAssetXRefPurchaseCost: TFloatField
      DisplayLabel = 'Purchase Cost'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PurchaseCost'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'PurchCost'
      KeyFields = 'AssetId'
      currency = True
      Lookup = True
    end
    object qryAssetXRefBrandName: TStringField
      DisplayLabel = 'Brand Name'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'BrandName'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'BrandName'
      KeyFields = 'AssetId'
      Size = 50
      Lookup = True
    end
    object qryAssetXRefManufacture: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Manufacture'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'Manufacture'
      KeyFields = 'AssetId'
      Size = 50
      Lookup = True
    end
    object qryAssetXRefModel: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Model'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'Model'
      KeyFields = 'AssetId'
      Size = 30
      Lookup = True
    end
    object qryAssetXRefSerial: TStringField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Serial'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'Serial'
      KeyFields = 'AssetId'
      Size = 30
      Lookup = True
    end
    object qryAssetXRefNotes: TStringField
      DisplayWidth = 27
      FieldKind = fkLookup
      FieldName = 'Notes'
      LookupDataSet = qryAssetLookup
      LookupKeyFields = 'AssetID'
      LookupResultField = 'Notes'
      KeyFields = 'AssetId'
      Size = 255
      Lookup = True
    end
    object qryAssetXRefAssetId: TIntegerField
      DisplayLabel = 'Asset Id'
      DisplayWidth = 10
      FieldName = 'AssetId'
      Origin = 'tblrepairassetxref.AssetId'
      Visible = False
    end
    object qryAssetXRefGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblrepairassetxref.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryAssetXRefRepairAssetXRefId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RepairAssetXRefId'
      Origin = 'tblrepairassetxref.RepairAssetXRefId'
      Visible = False
    end
    object qryAssetXRefRepairId: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairId'
      Origin = 'tblrepairassetxref.RepairId'
      Visible = False
    end
    object qryAssetXRefmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblrepairassetxref.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object qryAssetLookup: TERPQuery [86]
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblfixedassets')
    Left = 118
    Top = 81
  end
  object qryCustomers: TERPQuery [87]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      
        'ClientID,ClientTypeID,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFL' +
        'D5,CUSTFLD6,CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTF' +
        'LD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,'
      'CUSTDATE1,CUSTDATE2,CUSTDATE3,'
      
        'Company,Street,Street2,Street3,Suburb,State,Postcode ,billstreet' +
        '3,'
      'Phone,FaxNumber,AltPhone, Mobile,'
      
        'IsJob, Customer, Supplier, OtherContact,  ForcePOOnCustomer, War' +
        'rantyFinishDate, ForcePOOnRepair,EMail, BillStreet,BillStreet2,B' +
        'illSuburb,BillState,BillCountry,BillPostcode,TERMS,TERMSID, repa' +
        'irComment , RepairCommentPopUp '
      'FROM tblclients'
      'WHERE Customer='#39'T'#39' AND ClientID = :CustomerID')
    Left = 89
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end>
    object qryCustomersClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryCustomersClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
    end
    object qryCustomersCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object qryCustomersCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object qryCustomersCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object qryCustomersCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object qryCustomersCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qryCustomersCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object qryCustomersCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object qryCustomersCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object qryCustomersCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object qryCustomersCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object qryCustomersCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object qryCustomersCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object qryCustomersCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object qryCustomersCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object qryCustomersCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object qryCustomersCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
    end
    object qryCustomersCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
    end
    object qryCustomersCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
    end
    object qryCustomersCompany: TWideStringField
      FieldName = 'Company'
      Size = 160
    end
    object qryCustomersStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryCustomersStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryCustomersStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryCustomersSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object qryCustomersState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object qryCustomersPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object qryCustomersPhone: TWideStringField
      FieldName = 'Phone'
    end
    object qryCustomersFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
    end
    object qryCustomersAltPhone: TWideStringField
      FieldName = 'AltPhone'
    end
    object qryCustomersIsJob: TWideStringField
      FieldName = 'IsJob'
      FixedChar = True
      Size = 1
    end
    object qryCustomersForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object qryCustomersWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
    end
    object qryCustomersForcePOOnRepair: TWideStringField
      FieldName = 'ForcePOOnRepair'
      FixedChar = True
      Size = 1
    end
    object qryCustomersEMail: TWideStringField
      FieldName = 'EMail'
      Size = 80
    end
    object qryCustomersBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Size = 255
    end
    object qryCustomersBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Size = 255
    end
    object qryCustomersBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Size = 255
    end
    object qryCustomersBillState: TWideStringField
      FieldName = 'BillState'
      Size = 255
    end
    object qryCustomersBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Size = 255
    end
    object qryCustomersBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Size = 255
    end
    object qryCustomersMobile: TWideStringField
      FieldName = 'Mobile'
    end
    object qryCustomersTERMS: TWideStringField
      FieldName = 'TERMS'
      Size = 30
    end
    object qryCustomersTERMSID: TIntegerField
      FieldName = 'TERMSID'
    end
    object qryCustomersrepairComment: TWideMemoField
      FieldName = 'repairComment'
      BlobType = ftWideMemo
    end
    object qryCustomersRepairCommentPopUp: TWideStringField
      FieldName = 'RepairCommentPopUp'
      FixedChar = True
      Size = 1
    end
    object qryCustomersbillstreet3: TWideStringField
      FieldName = 'billstreet3'
      Size = 255
    end
    object qryCustomersCustomer: TWideStringField
      FieldName = 'Customer'
      FixedChar = True
      Size = 1
    end
    object qryCustomersSupplier: TWideStringField
      FieldName = 'Supplier'
      FixedChar = True
      Size = 1
    end
    object qryCustomersOtherContact: TWideStringField
      FieldName = 'OtherContact'
      FixedChar = True
      Size = 1
    end
  end
  object QryrepairFaults: TERPQuery [88]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Typecode,Name,Description FROM tblsimpletypes '
      
        'WHERE Typecode = '#39'RepairFault'#39' and ((Active = "T") or (Name = :x' +
        'Name))'
      'ORDER BY Name')
    Top = 53
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
      Visible = False
      Size = 255
    end
    object QryrepairFaultsTypecode: TWideStringField
      FieldName = 'Typecode'
      Visible = False
      Size = 30
    end
  end
  object qryDocuments: TERPQuery [89]
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
    Left = 118
    Top = 457
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RepairID'
      end>
  end
  object DSDocuments: TDataSource [90]
    DataSet = qryDocuments
    Left = 118
    Top = 428
  end
  object dsrepairsFaults: TDataSource [91]
    DataSet = tblrepairsFaults
    Left = 60
    Top = 428
  end
  object tblrepairsFaults: TERPQuery [92]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblrepairsfaults'
      'Where RepairID= :ID;')
    Filtered = True
    Filter = 'Deleted ='#39'F'#39
    Left = 60
    Top = 457
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblrepairsFaultsEquipment: TWideStringField
      DisplayWidth = 26
      FieldName = 'Equipment'
      Origin = 'tblrepairsfaults.Equipment'
      Size = 100
    end
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
  object QryRepairFaultsEquip: TERPQuery [93]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblcustomerequip.ID, '
      'tblcustomerequip.EquipmentID,'
      'tblcustomerequip.EquipName,'
      'tblcustomerequip.Description,'
      'tblcustomerequip.Manufacture,'
      'tblcustomerequip.model,'
      'tblcustomerequip.Serialno,'
      'tblcustomerequip.Registration,'
      'tblcustomerequip.WarantyPeriod,'
      'tblcustomerequip.WarantyFinishDate,'
      'tblcustomerequip.WarantyStartDate, '
      'tblequipment.ProductId,'
      'tblcustomerequip.Active, '
      'tblcustomerequip.Notes'
      'from tblcustomerequip '
      
        'Inner Join tblequipment ON tblcustomerequip.EquipmentID = tblequ' +
        'ipment.EquipmentID'
      'Where tblcustomerequip.ClientId = :ClientId '
      'and tblcustomerequip.Quantity <> 0'
      'order by tblcustomerequip.EquipName')
    AutoCalcFields = False
    Left = 29
    Top = 53
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientId'
      end>
    object IntegerField2: TIntegerField
      FieldName = 'ID'
    end
    object IntegerField3: TIntegerField
      FieldName = 'EquipmentID'
    end
    object WideStringField5: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 15
      FieldName = 'EquipName'
      Size = 255
    end
    object WideStringField6: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object WideStringField7: TWideStringField
      DisplayWidth = 10
      FieldName = 'Manufacture'
      Size = 100
    end
    object WideStringField8: TWideStringField
      DisplayLabel = 'Model'
      DisplayWidth = 10
      FieldName = 'model'
      Size = 100
    end
    object WideStringField9: TWideStringField
      DisplayLabel = 'Serial#'
      DisplayWidth = 10
      FieldName = 'Serialno'
      Size = 100
    end
    object WideStringField10: TWideStringField
      DisplayWidth = 10
      FieldName = 'Registration'
      Size = 100
    end
    object FloatField4: TFloatField
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 10
      FieldName = 'WarantyPeriod'
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Warranty Finish Date'
      DisplayWidth = 18
      FieldName = 'WarantyFinishDate'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'WarantyStartDate'
    end
    object LargeintField1: TLargeintField
      FieldName = 'ProductId'
    end
    object WideStringField11: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object WideMemoField1: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
  end
  object QryPOs: TERPQuery [94]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'SL.SmartOrderID,'
      'SmartOrderLinesID,'
      'P.OriginalNo,'
      'SL.PARTSNAME,'
      'SL.Qty,'
      'sum(ifnull(PL.UnitofMeasureShipped,0)) as Shipped,'
      'sum(if(ifnull(P.BOID,'#39#39')='#39#39' , PL.BackOrder , 0)) as BOQty,'
      'if(ifnull(P.PurchaseOrderID,0)=0 , SL.Qty,0) as toOrder '
      'FROM'
      'tblsmartorderlines AS SL '
      
        'Left Join tblpurchaselines AS PL ON SL.SmartOrderID = PL.SmartOr' +
        'derID AND SL.SmartOrderLinesId = PL.SmartOrderLineID'
      
        'left join tblpurchaseorders as P on P.PurchaseOrderID = PL.Purch' +
        'aseOrderID'
      'WHERE SL.RepairId = :RepairID'
      'Group by SL.SmartOrderID, P.OriginalNo , SmartOrderLinesID'
      'Order by SL.PARTSNAME')
    BeforeOpen = QryPOsBeforeOpen
    AfterOpen = QryPOsAfterOpen
    DetailFields = 'SmartOrderID'
    Left = 89
    Top = 53
    ParamData = <
      item
        DataType = ftInteger
        Name = 'repairID'
        Value = 0
      end>
    object QryPOsSmartOrderID: TIntegerField
      FieldName = 'SmartOrderID'
    end
    object QryPOsSmartOrderLinesID: TIntegerField
      FieldName = 'SmartOrderLinesID'
    end
    object QryPOsOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Size = 255
    end
    object QryPOsPARTSNAME: TWideStringField
      FieldName = 'PARTSNAME'
      Size = 255
    end
    object QryPOsQty: TFloatField
      FieldName = 'Qty'
    end
    object QryPOsShipped: TFloatField
      FieldName = 'Shipped'
    end
    object QryPOsBOQty: TFloatField
      FieldName = 'BOQty'
    end
    object QryPOstoOrder: TFloatField
      FieldName = 'toOrder'
    end
  end
  inherited QryCustomField: TERPQuery
    Left = 89
    Top = 110
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 952
    Top = 61
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 801
    Top = 29
  end
  inherited qryMemTrans: TERPQuery
    Left = 59
    Top = 81
  end
  object QryAreaCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 119
    Top = 53
    object QryAreaCodesAreaCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodesAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'AreaName'
      Size = 100
    end
  end
end
