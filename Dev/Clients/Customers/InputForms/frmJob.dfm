inherited JobGUI: TJobGUI
  Left = 490
  Top = 139
  HelpContext = 377000
  Caption = 'Customer Job'
  ClientHeight = 563
  ClientWidth = 861
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 867
  ExplicitHeight = 592
  DesignSize = (
    861
    563)
  PixelsPerInch = 96
  TextHeight = 15
  object Label12: TLabel [0]
    Left = 811
    Top = 527
    Width = 35
    Height = 15
    HelpContext = 377002
    Anchors = [akRight, akBottom]
    Caption = 'Active'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 563
    Width = 861
    HelpContext = 377258
    ExplicitTop = 542
    ExplicitWidth = 832
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    Left = 398
    Top = 2
    HelpContext = 377001
    ExplicitLeft = 398
    ExplicitTop = 2
  end
  inherited shapehintextra1: TShape
    Left = 55
    ExplicitLeft = 55
  end
  object btnInvoice: TDNMSpeedButton [6]
    Left = 329
    Top = 530
    Width = 87
    Height = 27
    HelpContext = 377008
    Anchors = [akBottom]
    Caption = 'Invoice'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnInvoiceClick
  end
  object btnSalesOrder: TDNMSpeedButton [7]
    Left = 445
    Top = 531
    Width = 87
    Height = 27
    HelpContext = 377009
    Anchors = [akBottom]
    Caption = 'Sales Order'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = btnSalesOrderClick
  end
  object btnAppointment: TDNMSpeedButton [8]
    Left = 562
    Top = 531
    Width = 87
    Height = 27
    HelpContext = 377010
    Anchors = [akBottom]
    Caption = 'Appointment'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 8
    AutoDisableParentOnclick = True
    OnClick = btnAppointmentClick
  end
  object pgeControl: TPageControl [9]
    Left = 8
    Top = 84
    Width = 842
    Height = 440
    HelpContext = 377011
    ActivePage = tabMain
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    TabHeight = 25
    TabOrder = 0
    TabWidth = 134
    OnChange = pgeControlChange
    OnChanging = pgeControlChanging
    OnResize = pgeControlResize
    object tabMain: TTabSheet
      HelpContext = 377012
      Caption = '&Main'
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377013
        Align = alClient
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel2: TBevel
          Left = 16
          Top = 9
          Width = 769
          Height = 54
          HelpContext = 377259
          Shape = bsFrame
        end
        object Label9: TLabel
          Left = 552
          Top = 16
          Width = 57
          Height = 15
          HelpContext = 377016
          Caption = 'Job Name'
          Transparent = True
        end
        object Label25: TLabel
          Left = 270
          Top = 16
          Width = 39
          Height = 15
          HelpContext = 377017
          Caption = 'Job No'
          FocusControl = AccountNo
          Transparent = True
        end
        object Label11: TLabel
          Left = 29
          Top = 143
          Width = 33
          Height = 15
          HelpContext = 377028
          Caption = 'Notes'
          Transparent = True
        end
        object Label55: TLabel
          Left = 410
          Top = 16
          Width = 125
          Height = 15
          HelpContext = 377029
          Caption = 'CustomerJob Number'
          Transparent = True
        end
        object lblClientPrintNameHeading: TLabel
          Left = 29
          Top = 12
          Width = 63
          Height = 15
          HelpContext = 377478
          Caption = 'Print Name'
          Transparent = True
        end
        object Bevel1: TBevel
          Left = 16
          Top = 66
          Width = 769
          Height = 55
          HelpContext = 377259
          Shape = bsFrame
        end
        object Label2: TLabel
          Left = 708
          Top = 96
          Width = 9
          Height = 15
          HelpContext = 377478
          Caption = '%'
          Transparent = True
        end
        object Label3: TLabel
          Left = 223
          Top = 95
          Width = 87
          Height = 15
          HelpContext = 377017
          Caption = 'Time Sheet Hrs'
          FocusControl = AccountNo
          Transparent = True
        end
        object Label4: TLabel
          Left = 317
          Top = 71
          Width = 83
          Height = 15
          HelpContext = 377478
          Caption = 'COGS Account'
          Transparent = True
        end
        object Label5: TLabel
          Left = 508
          Top = 71
          Width = 99
          Height = 15
          HelpContext = 377478
          Caption = 'Expense Account'
          Transparent = True
        end
        object edtJobName: TwwDBEdit
          Left = 552
          Top = 33
          Width = 222
          Height = 23
          HelpContext = 377031
          DataField = 'JobName'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtJobNo: TwwDBEdit
          Left = 270
          Top = 33
          Width = 125
          Height = 23
          HelpContext = 377032
          DataField = 'JobNumber'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtNotes: TwwDBRichEdit
          Left = 16
          Top = 125
          Width = 769
          Height = 179
          HelpContext = 377038
          ScrollBars = ssVertical
          AutoURLDetect = False
          DataField = 'Notes'
          DataSource = dsJob
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HideSelection = False
          ParentFont = False
          ParentShowHint = False
          PrintJobName = 'Delphi 6'
          ShowHint = False
          TabOrder = 4
          EditorCaption = 'Edit Rich Text'
          EditorPosition.Left = 0
          EditorPosition.Top = 0
          EditorPosition.Width = 0
          EditorPosition.Height = 0
          MeasurementUnits = muInches
          PrintMargins.Top = 1.000000000000000000
          PrintMargins.Bottom = 1.000000000000000000
          PrintMargins.Left = 1.000000000000000000
          PrintMargins.Right = 1.000000000000000000
          PrintHeader.VertMargin = 0.500000000000000000
          PrintHeader.Font.Charset = DEFAULT_CHARSET
          PrintHeader.Font.Color = clWindowText
          PrintHeader.Font.Height = -11
          PrintHeader.Font.Name = 'Tahoma'
          PrintHeader.Font.Style = []
          PrintFooter.VertMargin = 0.500000000000000000
          PrintFooter.Font.Charset = DEFAULT_CHARSET
          PrintFooter.Font.Color = clWindowText
          PrintFooter.Font.Height = -11
          PrintFooter.Font.Name = 'Tahoma'
          PrintFooter.Font.Style = []
          RichEditVersion = 2
          Data = {
            740000007B5C727466315C616E73695C616E7369637067313235325C64656666
            305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C20
            417269616C3B7D7D0D0A5C766965776B696E64345C7563315C706172645C6630
            5C66733138206564744E6F7465735C7061720D0A7D0D0A00}
        end
        object btnAddDateTime: TDNMSpeedButton
          Left = 711
          Top = 314
          Width = 74
          Height = 23
          HelpContext = 377039
          Caption = 'Add Date'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          AutoDisableParentOnclick = True
          OnClick = btnAddDateTimeClick
        end
        object edtcustjobno: TwwDBEdit
          Left = 410
          Top = 33
          Width = 125
          Height = 23
          HelpContext = 377040
          DataField = 'CustomerJobNumber'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtPrintname: TwwDBEdit
          Left = 29
          Top = 33
          Width = 222
          Height = 23
          HelpContext = 377479
          DataField = 'PrintJobName'
          DataSource = dsJob
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
          OnChange = edtPrintnameChange
          OnExit = edtPrintnameExit
        end
        object cboAccount1: TwwDBLookupCombo
          Left = 316
          Top = 92
          Width = 169
          Height = 23
          HelpContext = 414230
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AccountName'#9'30'#9'Account Name'#9'T'
            'Type'#9'20'#9'Type'#9'T')
          DataField = 'Account1Name'
          DataSource = dsJob
          LookupTable = qryAccount1
          LookupField = 'AccountName'
          Options = [loColLines]
          ParentFont = False
          TabOrder = 6
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboAccount2: TwwDBLookupCombo
          Left = 508
          Top = 91
          Width = 169
          Height = 23
          HelpContext = 414230
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AccountName'#9'30'#9'Account Name'#9'T'
            'Type'#9'20'#9'Type'#9'T')
          DataField = 'Account2Name'
          DataSource = dsJob
          LookupTable = qryAccount2
          LookupField = 'AccountName'
          Options = [loColLines]
          ParentFont = False
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object edtBurden: TwwDBSpinEdit
          Left = 729
          Top = 91
          Width = 45
          Height = 23
          Increment = 1.000000000000000000
          DataField = 'Burden'
          DataSource = dsJob
          TabOrder = 8
          UnboundDataType = wwDefault
        end
      end
    end
    object tabAddress: TTabSheet
      HelpContext = 377070
      Caption = '&Address Info'
      ImageIndex = 1
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377071
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel6: TBevel
          Left = 74
          Top = 15
          Width = 273
          Height = 283
          HelpContext = 377072
          Shape = bsFrame
        end
        object Bevel5: TBevel
          Left = 449
          Top = 15
          Width = 273
          Height = 283
          HelpContext = 377073
          Shape = bsFrame
        end
        object Label1: TLabel
          Left = 487
          Top = 53
          Width = 48
          Height = 15
          HelpContext = 377074
          Alignment = taRightJustify
          Caption = 'Address'
          Transparent = True
        end
        object Label13: TLabel
          Left = 477
          Top = 88
          Width = 58
          Height = 15
          HelpContext = 377075
          Alignment = taRightJustify
          Caption = 'Address 2'
          Transparent = True
        end
        object lblBillSuburb: TLabel
          Left = 514
          Top = 158
          Width = 21
          Height = 15
          HelpContext = 377076
          Alignment = taRightJustify
          Caption = 'City'
          Transparent = True
        end
        object lblBillState: TLabel
          Left = 505
          Top = 193
          Width = 30
          Height = 15
          HelpContext = 377077
          Alignment = taRightJustify
          Caption = 'State'
          Transparent = True
        end
        object lblBillPostCode: TLabel
          Left = 474
          Top = 228
          Width = 58
          Height = 15
          HelpContext = 377078
          Alignment = taRightJustify
          Caption = 'Post Code'
          Transparent = True
        end
        object Label17: TLabel
          Left = 539
          Top = 19
          Width = 33
          Height = 15
          HelpContext = 377079
          Caption = 'Bill To'
          Transparent = True
        end
        object Label18: TLabel
          Left = 111
          Top = 53
          Width = 48
          Height = 15
          HelpContext = 377080
          Alignment = taRightJustify
          Caption = 'Address'
          Transparent = True
        end
        object Label19: TLabel
          Left = 101
          Top = 88
          Width = 58
          Height = 15
          HelpContext = 377081
          Alignment = taRightJustify
          Caption = 'Address 2'
          Transparent = True
        end
        object lblSuburb: TLabel
          Left = 138
          Top = 158
          Width = 21
          Height = 15
          HelpContext = 377082
          Alignment = taRightJustify
          Caption = 'City'
          Transparent = True
        end
        object lblState: TLabel
          Left = 129
          Top = 193
          Width = 30
          Height = 15
          HelpContext = 377083
          Alignment = taRightJustify
          Caption = 'State'
          Transparent = True
        end
        object lblPostCode: TLabel
          Left = 98
          Top = 228
          Width = 61
          Height = 15
          HelpContext = 377084
          Alignment = taRightJustify
          Caption = 'Post Code '
          Transparent = True
        end
        object Label23: TLabel
          Left = 162
          Top = 19
          Width = 99
          Height = 15
          HelpContext = 377085
          Caption = 'Physical Address'
          Transparent = True
        end
        object Label14: TLabel
          Left = 469
          Top = 263
          Width = 66
          Height = 18
          HelpContext = 377086
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label15: TLabel
          Left = 93
          Top = 263
          Width = 66
          Height = 18
          HelpContext = 377087
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country'
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
          Left = 89
          Top = 318
          Width = 208
          Height = 14
          HelpContext = 377088
          AutoSize = False
          Caption = 'Send XML Invoices on Invoice Run :'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label20: TLabel
          Left = 89
          Top = 347
          Width = 59
          Height = 15
          HelpContext = 377089
          Caption = 'XMLEmail:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblAddress3: TLabel
          Left = 101
          Top = 123
          Width = 58
          Height = 15
          HelpContext = 377090
          Alignment = taRightJustify
          Caption = 'Address 3'
          Transparent = True
        end
        object lblBillAddress3: TLabel
          Left = 477
          Top = 123
          Width = 58
          Height = 15
          HelpContext = 377091
          Alignment = taRightJustify
          Caption = 'Address 3'
          Transparent = True
        end
        object edtBillStreet: TwwDBEdit
          Left = 538
          Top = 53
          Width = 177
          Height = 23
          HelpContext = 377092
          DataField = 'BillStreet'
          DataSource = dsJob
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
        object edtBillStreet2: TwwDBEdit
          Left = 538
          Top = 88
          Width = 177
          Height = 23
          HelpContext = 377093
          DataField = 'BillStreet2'
          DataSource = dsJob
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
        object BillState: TwwDBEdit
          Left = 538
          Top = 191
          Width = 121
          Height = 23
          HelpContext = 377094
          DataField = 'BillState'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object BillPostCode: TwwDBEdit
          Left = 538
          Top = 226
          Width = 121
          Height = 23
          HelpContext = 377095
          DataField = 'BillPostCode'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtStreet: TwwDBEdit
          Left = 162
          Top = 53
          Width = 177
          Height = 23
          HelpContext = 377096
          DataField = 'Street'
          DataSource = dsJob
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
        object edtStreet2: TwwDBEdit
          Left = 162
          Top = 88
          Width = 177
          Height = 23
          HelpContext = 377097
          DataField = 'Street2'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object State: TwwDBEdit
          Left = 162
          Top = 191
          Width = 121
          Height = 23
          HelpContext = 377098
          DataField = 'State'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object PostCode: TwwDBEdit
          Left = 162
          Top = 226
          Width = 121
          Height = 23
          HelpContext = 377099
          DataField = 'PostCode'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object btnOrigAdd: TDNMSpeedButton
          Left = 410
          Top = 338
          Width = 113
          Height = 27
          HelpContext = 377100
          Caption = 'Original Address'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 14
          AutoDisableParentOnclick = True
          OnClick = btnOrigAddClick
        end
        object BillSuburb: TwwDBLookupCombo
          Left = 538
          Top = 157
          Width = 177
          Height = 23
          HelpContext = 377101
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'20'#9'Suburb'#9'T'
            'State'#9'4'#9'State'#9'T'
            'Postcode'#9'10'#9'Postcode'#9'T')
          DataField = 'BillSuburb'
          DataSource = dsJob
          LookupTable = qrySuburb
          LookupField = 'City_sub'
          ParentFont = False
          TabOrder = 10
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = BillSuburbCloseUp
          OnEnter = BillSuburbEnter
        end
        object Suburb: TwwDBLookupCombo
          Left = 162
          Top = 157
          Width = 177
          Height = 23
          HelpContext = 377102
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'20'#9'Suburb'#9'T'
            'State'#9'4'#9'State'#9'T'
            'Postcode'#9'10'#9'Postcode'#9'T')
          DataField = 'Suburb'
          DataSource = dsJob
          LookupTable = qrySuburb
          LookupField = 'City_sub'
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = SuburbCloseUp
          OnEnter = BillSuburbEnter
        end
        object Country: TDBEdit
          Left = 162
          Top = 261
          Width = 177
          Height = 23
          HelpContext = 377103
          TabStop = False
          DataField = 'Country'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object BillCountry: TDBEdit
          Left = 538
          Top = 261
          Width = 177
          Height = 23
          HelpContext = 377104
          TabStop = False
          DataField = 'BillCountry'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object DBCheckBox1: TDBCheckBox
          Left = 297
          Top = 317
          Width = 14
          Height = 16
          HelpContext = 377105
          Color = 14867920
          DataField = 'SendXMLInvoices'
          DataSource = dsJob
          ParentColor = False
          TabOrder = 15
          ValueChecked = 'T'
          ValueUnchecked = 'F'
        end
        object XMLEmail: TDBEdit
          Left = 151
          Top = 343
          Width = 222
          Height = 23
          HelpContext = 377106
          DataField = 'EmailXML'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object edtStreet3: TwwDBEdit
          Left = 162
          Top = 122
          Width = 177
          Height = 23
          HelpContext = 377107
          DataField = 'Street3'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtBillStreet3: TwwDBEdit
          Left = 538
          Top = 122
          Width = 177
          Height = 23
          HelpContext = 377108
          DataField = 'BillStreet3'
          DataSource = dsJob
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
        object cmdCopy: TDNMSpeedButton
          Left = 359
          Top = 144
          Width = 72
          Height = 24
          Hint = '"Copy The Bill To Details In To The Physical Address"'
          HelpContext = 377274
          Caption = '>>Cop&y>>'
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
          TabOrder = 17
          AutoDisableParentOnclick = True
          OnClick = cmdCopyClick
        end
      end
    end
    object tabCustomer: TTabSheet
      HelpContext = 377044
      Caption = 'Cus&tomer'
      ImageIndex = 13
      object DNMPanel11: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377045
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel30: TBevel
          Left = 128
          Top = 271
          Width = 540
          Height = 105
          HelpContext = 377058
          Shape = bsFrame
        end
        object Bevel12: TBevel
          Left = 128
          Top = 141
          Width = 540
          Height = 70
          HelpContext = 377046
          Shape = bsFrame
        end
        object Bevel7: TBevel
          Left = 128
          Top = 15
          Width = 540
          Height = 115
          HelpContext = 377047
          Shape = bsFrame
        end
        object Label24: TLabel
          Left = 168
          Top = 29
          Width = 61
          Height = 15
          HelpContext = 377048
          Caption = 'First Name'
          Transparent = True
        end
        object Label39: TLabel
          Left = 168
          Top = 64
          Width = 61
          Height = 15
          HelpContext = 377049
          Caption = 'Last Name'
          Transparent = True
        end
        object Label42: TLabel
          Left = 139
          Top = 99
          Width = 90
          Height = 18
          HelpContext = 377050
          AutoSize = False
          Caption = 'Customer Type'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel11: TBevel
          Left = 401
          Top = 15
          Width = 267
          Height = 115
          HelpContext = 377051
          Shape = bsFrame
        end
        object Label43: TLabel
          Left = 414
          Top = 30
          Width = 84
          Height = 15
          HelpContext = 377052
          Caption = 'Phone Number'
          Transparent = True
        end
        object Label48: TLabel
          Left = 478
          Top = 63
          Width = 20
          Height = 15
          HelpContext = 377053
          Caption = 'Fax'
          Transparent = True
        end
        object Label49: TLabel
          Left = 444
          Top = 98
          Width = 54
          Height = 15
          HelpContext = 377054
          Caption = 'Alt Phone'
          Transparent = True
        end
        object Label50: TLabel
          Left = 195
          Top = 155
          Width = 22
          Height = 15
          HelpContext = 377055
          Caption = 'Rep'
          Transparent = True
        end
        object Label51: TLabel
          Left = 436
          Top = 155
          Width = 41
          Height = 15
          HelpContext = 377056
          Caption = 'Source'
          Transparent = True
        end
        object Label53: TLabel
          Left = 128
          Top = 183
          Width = 89
          Height = 23
          HelpContext = 377057
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Security Level'
          Transparent = True
          WordWrap = True
        end
        object Bevel18: TBevel
          Left = 128
          Top = 223
          Width = 540
          Height = 37
          HelpContext = 377481
          Shape = bsFrame
        end
        object Label54: TLabel
          Left = 252
          Top = 233
          Width = 75
          Height = 15
          HelpContext = 377059
          Alignment = taRightJustify
          Caption = 'Default Class'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label104: TLabel
          Left = 135
          Top = 278
          Width = 113
          Height = 16
          HelpContext = 377482
          AutoSize = False
          Caption = 'Sales Comments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label105: TLabel
          Left = 135
          Top = 357
          Width = 526
          Height = 14
          HelpContext = 377483
          Alignment = taCenter
          AutoSize = False
          Caption = 
            '(Please Note that Changing the Sales Comments in the Parent Cust' +
            'omer Card will Update this Information)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object edtFirstName: TwwDBEdit
          Left = 235
          Top = 25
          Width = 154
          Height = 23
          HelpContext = 377060
          DataField = 'FirstName'
          DataSource = dsJob
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
        object edtLastName: TwwDBEdit
          Left = 235
          Top = 60
          Width = 154
          Height = 23
          HelpContext = 377061
          DataField = 'LastName'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboClientType: TwwDBLookupCombo
          Left = 235
          Top = 97
          Width = 154
          Height = 23
          HelpContext = 377062
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TypeName'#9'25'#9'TypeName'#9'F')
          DataField = 'ClientTypeID'
          DataSource = dsJob
          LookupTable = qryClientTypes
          LookupField = 'ClientTypeID'
          Options = [loColLines, loTitles]
          ParentFont = False
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object edtPhone: TwwDBEdit
          Left = 504
          Top = 25
          Width = 152
          Height = 23
          HelpContext = 377063
          DataField = 'Phone'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtFax: TwwDBEdit
          Left = 504
          Top = 60
          Width = 152
          Height = 23
          HelpContext = 377064
          DataField = 'FaxNumber'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtAltPhone: TwwDBEdit
          Left = 504
          Top = 97
          Width = 152
          Height = 23
          HelpContext = 377065
          DataField = 'AltPhone'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboRep: TwwDBLookupCombo
          Left = 233
          Top = 151
          Width = 153
          Height = 23
          HelpContext = 377066
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'T')
          DataField = 'RepID'
          DataSource = dsJob
          LookupTable = qryRep
          LookupField = 'EmployeeID'
          ParentFont = False
          TabOrder = 6
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboSource: TwwDBLookupCombo
          Left = 491
          Top = 151
          Width = 165
          Height = 23
          HelpContext = 377067
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'MediaType'#9'30'#9'MediaType'#9'T')
          DataField = 'MedTypeID'
          DataSource = dsJob
          LookupTable = qryMediaType
          LookupField = 'MedTypeID'
          ParentFont = False
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object wwDBEdit2: TwwDBEdit
          Left = 233
          Top = 180
          Width = 28
          Height = 23
          HelpContext = 377068
          DataField = 'SecurityLevel'
          DataSource = dsJob
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
        object cboClassName: TwwDBLookupCombo
          Left = 343
          Top = 230
          Width = 140
          Height = 23
          HelpContext = 377069
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ClassName'#9'20'#9'Class Name'#9#9)
          DataField = 'DefaultClass'
          DataSource = dsJob
          LookupTable = cboClassQry
          LookupField = 'ClassName'
          ParentFont = False
          TabOrder = 9
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          ShowMatchText = True
        end
        object wwCheckBox6: TwwCheckBox
          Left = 604
          Top = 277
          Width = 57
          Height = 17
          HelpContext = 377484
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Caption = 'PopUp'
          DataField = 'InvoiceCommentPopup'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 10
        end
        object memoSalesComments: TDBMemo
          Left = 135
          Top = 296
          Width = 526
          Height = 57
          HelpContext = 377485
          DataField = 'InvoiceComment'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 11
        end
      end
    end
    object tabGeneral: TTabSheet
      HelpContext = 377109
      Caption = '&General'
      ImageIndex = 5
      object DNMPanel4: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377110
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel26: TBevel
          Left = 337
          Top = 257
          Width = 444
          Height = 41
          HelpContext = 377118
          Shape = bsFrame
        end
        object Bevel13: TBevel
          Left = 337
          Top = 212
          Width = 444
          Height = 41
          HelpContext = 377416
          Shape = bsFrame
        end
        object Bevel25: TBevel
          Left = 337
          Top = 91
          Width = 444
          Height = 71
          HelpContext = 377111
          Shape = bsFrame
        end
        object Bevel17: TBevel
          Left = 26
          Top = 21
          Width = 287
          Height = 49
          HelpContext = 377417
          Shape = bsFrame
        end
        object Bevel9: TBevel
          Left = 337
          Top = 304
          Width = 224
          Height = 41
          HelpContext = 377112
          Shape = bsFrame
        end
        object Box71: TBevel
          Left = 26
          Top = 76
          Width = 287
          Height = 269
          HelpContext = 377113
          Shape = bsFrame
        end
        object Label56: TLabel
          Left = 70
          Top = 39
          Width = 76
          Height = 16
          HelpContext = 377114
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Account No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label52: TLabel
          Left = 99
          Top = 94
          Width = 47
          Height = 16
          HelpContext = 377115
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Terms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label26: TLabel
          Left = 53
          Top = 138
          Width = 93
          Height = 15
          HelpContext = 377116
          Alignment = taRightJustify
          Caption = 'Credit Limit ($'#39's)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label27: TLabel
          Left = 33
          Top = 182
          Width = 113
          Height = 15
          HelpContext = 377117
          Alignment = taRightJustify
          Caption = 'Grace Period (Days)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Bevel8: TBevel
          Left = 337
          Top = 16
          Width = 444
          Height = 69
          HelpContext = 377119
          Shape = bsFrame
        end
        object Label77: TLabel
          Left = 459
          Top = 29
          Width = 35
          Height = 15
          HelpContext = 377120
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel10: TBevel
          Left = 337
          Top = 167
          Width = 444
          Height = 41
          HelpContext = 377121
          Shape = bsFrame
        end
        object Label28: TLabel
          Left = 389
          Top = 178
          Width = 105
          Height = 18
          HelpContext = 377122
          AutoSize = False
          Caption = 'Payment Method '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label29: TLabel
          Left = 344
          Top = 223
          Width = 150
          Height = 18
          HelpContext = 377123
          AutoSize = False
          Caption = 'Default Invoice Template'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object cboShippingMethod_Label: TLabel
          Left = 47
          Top = 271
          Width = 99
          Height = 18
          HelpContext = 377124
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Shipping Method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label30: TLabel
          Left = 43
          Top = 227
          Width = 103
          Height = 16
          HelpContext = 377125
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Default Tax Code '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label128: TLabel
          Left = 403
          Top = 59
          Width = 91
          Height = 15
          HelpContext = 377126
          Caption = 'Ph Support Until'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label33: TLabel
          Left = 348
          Top = 317
          Width = 77
          Height = 15
          HelpContext = 377127
          Caption = 'Creation Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label34: TLabel
          Left = 59
          Top = 316
          Width = 87
          Height = 15
          HelpContext = 377128
          Alignment = taRightJustify
          Caption = 'Discharge Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Bevel24: TBevel
          Left = 581
          Top = 304
          Width = 200
          Height = 41
          HelpContext = 377129
          Shape = bsFrame
        end
        object lblForcePORepairs: TLabel
          Left = 595
          Top = 317
          Width = 143
          Height = 15
          HelpContext = 377130
          Caption = 'Force PO Entry On Repair'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label21: TLabel
          Left = 429
          Top = 100
          Width = 65
          Height = 15
          HelpContext = 377275
          Alignment = taRightJustify
          Caption = 'Call Priority'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label31: TLabel
          Left = 362
          Top = 135
          Width = 132
          Height = 15
          HelpContext = 377276
          Alignment = taRightJustify
          Caption = 'Default Contact Method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblArea: TLabel
          Left = 419
          Top = 270
          Width = 75
          Height = 15
          HelpContext = 377277
          Alignment = taRightJustify
          Caption = 'Area Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object AccountNo: TDBEdit
          Left = 151
          Top = 35
          Width = 157
          Height = 23
          HelpContext = 377131
          DataField = 'ClientNo'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object cboTerms: TwwDBLookupCombo
          Left = 151
          Top = 91
          Width = 157
          Height = 23
          Hint = '"What Are Your Trading Terms For This Customer"'
          HelpContext = 377132
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Terms'#9'40'#9'Terms'#9'F')
          DataField = 'TERMS'
          DataSource = dsJob
          LookupTable = qryTerms
          LookupField = 'Terms'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboTermsCloseUp
        end
        object CreditLimit: TwwDBEdit
          Left = 151
          Top = 135
          Width = 79
          Height = 23
          HelpContext = 377133
          DataField = 'CreditLimit'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object GracePeriod: TwwDBEdit
          Left = 151
          Top = 178
          Width = 39
          Height = 23
          HelpContext = 377134
          DataField = 'GracePeriod'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object Email: TDBEdit
          Left = 507
          Top = 25
          Width = 250
          Height = 23
          HelpContext = 377135
          DataField = 'Email'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object cboPaymentMethod: TwwDBLookupCombo
          Left = 507
          Top = 176
          Width = 157
          Height = 23
          HelpContext = 377136
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'PayMethodID'
          DataSource = dsJob
          LookupTable = qryPayMethod
          LookupField = 'PayMethodID'
          Style = csDropDownList
          DropDownCount = 5
          DropDownWidth = 150
          ParentFont = False
          TabOrder = 11
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboInvoiceTemplate: TwwDBLookupCombo
          Left = 507
          Top = 221
          Width = 157
          Height = 23
          HelpContext = 377137
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TemplName'#9'20'#9'TemplName'#9'T')
          DataField = 'DefaultInvoiceTemplateID'
          DataSource = dsJob
          LookupTable = qryInvoiceTemplates
          LookupField = 'TemplID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboVia: TwwDBLookupCombo
          Left = 151
          Top = 267
          Width = 157
          Height = 23
          Hint = 
            '"What Is The Customers Preferred Shipping Method For Any Goods T' +
            'hat Are Sold To Them"'
          HelpContext = 377138
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ShippingMethod'#9'20'#9'ShippingMethod'#9#9)
          DataField = 'ShippingID'
          DataSource = dsJob
          LookupTable = qryShipping
          LookupField = 'ShippingMethodID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboTaxCode: TwwDBLookupCombo
          Left = 151
          Top = 223
          Width = 157
          Height = 23
          HelpContext = 377139
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'5'#9'Name'#9'F'
            'Description'#9'25'#9'Description'#9'F'
            'Rate'#9'10'#9'Rate'#9'F')
          DataField = 'TAXID'
          DataSource = dsJob
          LookupTable = qryTaxCodes
          LookupField = 'TaxCodeID'
          Style = csDropDownList
          ParentFont = False
          TabOrder = 6
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object btnLoadCredit: TDNMSpeedButton
          Left = 196
          Top = 176
          Width = 110
          Height = 27
          Hint = 'Load Credit from Parent Customer'
          HelpContext = 377140
          Caption = 'Import Customer'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          AutoDisableParentOnclick = True
          OnClick = btnLoadCreditClick
        end
        object PhoneSupport: TwwDBDateTimePicker
          Left = 507
          Top = 55
          Width = 157
          Height = 23
          HelpContext = 377141
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'PhoneSupportTill'
          DataSource = dsJob
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 10
        end
        object wwDBDateTimePicker1: TwwDBDateTimePicker
          Left = 431
          Top = 313
          Width = 123
          Height = 23
          HelpContext = 377142
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'CreationDate'
          DataSource = dsJob
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
        object wwDBDateTimePicker2: TwwDBDateTimePicker
          Left = 151
          Top = 312
          Width = 157
          Height = 23
          HelpContext = 377143
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'DischargeDate'
          DataSource = dsJob
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 8
        end
        object chkForcePOOnCustomer: TwwCheckBox
          Left = 751
          Top = 313
          Width = 15
          Height = 23
          HelpContext = 377144
          DisableThemes = False
          AlwaysTransparent = True
          Frame.Enabled = True
          Frame.Transparent = True
          Frame.FocusBorders = []
          Frame.NonFocusBorders = []
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          DataField = 'ForcePOOnCustomer'
          DataSource = dsJob
          TabOrder = 15
        end
        object wwDBComboBox1: TwwDBComboBox
          Left = 507
          Top = 97
          Width = 157
          Height = 23
          HelpContext = 377278
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          DataField = 'CallPriority'
          DataSource = dsJob
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            '10 - High'#9'10'
            '9'#9'9'
            '8'#9'8'
            '7'#9'7'
            '6'#9'6'
            '5  - Standard'#9'5'
            '4'#9'4'
            '3'#9'3'
            '2'#9'2'
            '1'#9'1'
            '0  - Low'#9'0')
          ParentFont = False
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
          UnboundAlignment = taCenter
        end
        object cboDefaultContactMethod: TwwDBComboBox
          Left = 507
          Top = 133
          Width = 157
          Height = 23
          HelpContext = 377279
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          DataField = 'DefaultContactMethod'
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            'Email'
            'Fax'
            'Print'
            'Phone'
            'Mobile'
            'Visit')
          ParentFont = False
          Sorted = False
          TabOrder = 16
          UnboundDataType = wwDefault
        end
        object cboAreaCode: TwwDBLookupCombo
          Left = 507
          Top = 266
          Width = 157
          Height = 23
          Hint = '"Enter Where This Customer Came From"'
          HelpContext = 377280
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
          LookupTable = QryAreaCodes
          LookupField = 'AreaCode'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
      end
    end
    object tabHistory: TTabSheet
      HelpContext = 377145
      Caption = '&History'
      ImageIndex = 2
      object pnlHistory: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377146
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grpHistory: TRadioGroup
          Left = 0
          Top = 0
          Width = 834
          Height = 73
          HelpContext = 377147
          Align = alTop
          Color = 14609623
          Columns = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemIndex = 0
          Items.Strings = (
            'Appointment'
            'Sales Orders'
            'Quotes'
            'Invoices'
            'Repairs'
            'Job Profit'
            'Payroll Jobs'
            'Timesheets'
            'Product Sales'
            'Bill Expenses'
            'Purchase Orders')
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          OnClick = grpHistoryClick
        end
      end
    end
    object tabContacts: TTabSheet
      HelpContext = 377187
      Caption = 'C&ontacts'
      ImageIndex = 7
      object DNMPanel6: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377188
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          834
          355)
        object Bevel16: TBevel
          Left = 8
          Top = 6
          Width = 832
          Height = 346
          HelpContext = 377281
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitHeight = 371
        end
        object Label22: TLabel
          Left = 28
          Top = 327
          Width = 133
          Height = 15
          HelpContext = 377282
          Anchors = [akLeft, akBottom]
          Caption = 'Show inactive Contacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitTop = 331
        end
        object chkShowAll: TCheckBox
          Left = 10
          Top = 327
          Width = 15
          Height = 17
          HelpContext = 377194
          Anchors = [akLeft, akBottom]
          Color = 14867920
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          OnClick = chkShowAllClick
        end
        object cmdNewContact: TDNMSpeedButton
          Left = 688
          Top = 174
          Width = 129
          Height = 27
          HelpContext = 377195
          Anchors = [akRight]
          Caption = '&New'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          AutoDisableParentOnclick = True
          OnClick = cmdNewContactClick
        end
        object EditBtn: TDNMSpeedButton
          Left = 688
          Top = 139
          Width = 129
          Height = 27
          HelpContext = 377196
          Anchors = [akRight]
          Caption = '&Edit'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          AutoDisableParentOnclick = True
          OnClick = EditBtnClick
        end
        object EmailBtn: TDNMSpeedButton
          Left = 688
          Top = 105
          Width = 129
          Height = 27
          HelpContext = 377197
          Anchors = [akRight]
          Caption = 'E-Mail'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          AutoDisableParentOnclick = True
          OnClick = EmailBtnClick
        end
        object FaxBtn: TDNMSpeedButton
          Left = 688
          Top = 70
          Width = 129
          Height = 27
          HelpContext = 377198
          Anchors = [akRight]
          Caption = '&Fax'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = FaxBtnClick
        end
        object LetterBtn: TDNMSpeedButton
          Left = 688
          Top = 36
          Width = 129
          Height = 27
          HelpContext = 377199
          Anchors = [akRight]
          Caption = '&Letter'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = LetterBtnClick
        end
        object grdContact: TwwDBGrid
          Left = 6
          Top = 15
          Width = 667
          Height = 302
          HelpContext = 377283
          ControlType.Strings = (
            'UseOnRun;CheckBox;T;F'
            'isPrimarycontact;CheckBox;T;F'
            'IsPrimarycontact;CheckBox;T;F')
          Selected.Strings = (
            'ContactName'#9'28'#9'Contact'#9'T'
            'ContactPH'#9'13'#9'Phone'#9'T'
            'ContactFax'#9'13'#9'Fax'#9'T'
            'ContactMOB'#9'13'#9'Mobile'#9'T'
            'isPrimarycontact'#9'1'#9'Primary Contact?'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          OnRowChanged = grdContactRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = DSContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          ParentFont = False
          TabOrder = 6
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = EditBtnClick
          object wwIButton2: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            Hint = 'Click this button to Deactivate the selected contact'
            HelpContext = 377284
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
            OnClick = btnInactiveClick
          end
        end
        object btnLoadCustomercontacts: TDNMSpeedButton
          Left = 688
          Top = 208
          Width = 129
          Height = 33
          HelpContext = 377422
          Anchors = [akRight]
          Caption = 'Load Customer Contacts'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          WordWrap = True
          AutoDisableParentOnclick = True
          OnClick = btnLoadCustomercontactsClick
        end
      end
    end
    object tabDocuments: TTabSheet
      HelpContext = 377200
      Caption = '&Documents'
      ImageIndex = 7
      object pnlDocuments: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377285
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
        DesignSize = (
          834
          355)
        object Label72: TLabel
          Left = 914
          Top = 256
          Width = 183
          Height = 14
          HelpContext = 377286
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Drag and drop attachments into list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitLeft = 885
        end
        object pnlDocumentsInner: TDNMPanel
          Left = 9
          Top = 6
          Width = 822
          Height = 344
          HelpContext = 377287
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 0
            Top = 177
            Width = 822
            Height = 3
            Cursor = crVSplit
            HelpContext = 377288
            Align = alTop
            ExplicitWidth = 225
          end
          object pnlDocumentsList: TDNMPanel
            Left = 0
            Top = 0
            Width = 822
            Height = 177
            HelpContext = 377289
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label73: TLabel
              Left = 641
              Top = 6
              Width = 178
              Height = 13
              HelpContext = 377291
              Alignment = taCenter
              Caption = 'Double click to open correspondence'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object grdCorrespondence: TwwDBGrid
              AlignWithMargins = True
              Left = 3
              Top = 27
              Width = 816
              Height = 147
              HelpContext = 377292
              ControlType.Strings = (
                'active;CheckBox;T;F')
              Selected.Strings = (
                'Ref_Date'#9'12'#9'Date'#9'F'
                'Ref_type'#9'10'#9'Type'#9'F'
                'Contact'#9'22'#9'Contact'#9'F'
                'Referencetxt'#9'22'#9'Reference'#9'F'
                'MessageFrom'#9'15'#9'From'#9'F'
                'MessageTo'#9'15'#9'To'#9'F'
                'active'#9'1'#9'Active'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              OnRowChanged = grdCorrespondenceRowChanged
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alBottom
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
              OnDblClick = grdCorrespondenceDblClick
              FooterColor = clWhite
              FooterCellColor = clWhite
              object grdDocsIButton: TwwIButton
                Left = 0
                Top = 0
                Width = 18
                Height = 22
                HelpContext = 377293
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
            object btnGetEmails: TButton
              AlignWithMargins = True
              Left = 5
              Top = 0
              Width = 75
              Height = 25
              HelpContext = 377294
              Margins.Top = 1
              Margins.Bottom = 1
              Caption = 'Get Emails'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnGetEmailsClick
            end
            object chkdocuments: TCheckBox
              AlignWithMargins = True
              Left = 91
              Top = -2
              Width = 221
              Height = 29
              HelpContext = 377295
              Margins.Top = 0
              Margins.Bottom = 0
              Caption = 'Show inactive Documents'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = chkdocumentsClick
            end
          end
          object pnlDocumentsMessage: TDNMPanel
            Left = 0
            Top = 180
            Width = 822
            Height = 164
            HelpContext = 377296
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object HtmlViewer: THtmlViewer
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 543
              Height = 130
              HelpContext = 377297
              TabOrder = 0
              Align = alClient
              BorderStyle = htFocused
              CharSet = DEFAULT_CHARSET
              DefBackground = clWhite
              DefFontName = 'Arial'
              DefFontSize = 9
              DefPreFontName = 'Courier New'
              HistoryMaxCount = 0
              NoSelect = False
              PrintMarginBottom = 2.000000000000000000
              PrintMarginLeft = 2.000000000000000000
              PrintMarginRight = 2.000000000000000000
              PrintMarginTop = 2.000000000000000000
              PrintScale = 1.000000000000000000
              QuirksMode = qmDetect
              OnHotSpotClick = HtmlViewerHotSpotClick
              OnImageRequest = HtmlViewerImageRequest
            end
            object lvAttachments: TListView
              AlignWithMargins = True
              Left = 552
              Top = 3
              Width = 267
              Height = 130
              HelpContext = 377298
              Align = alRight
              Columns = <>
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ViewStyle = vsSmallIcon
              OnDblClick = lvAttachmentsDblClick
            end
            object pnlDocsBottom: TDNMPanel
              Left = 0
              Top = 136
              Width = 822
              Height = 28
              HelpContext = 377423
              Align = alBottom
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              object lblDocumentPath: TDBText
                Left = 218
                Top = 6
                Width = 95
                Height = 15
                HelpContext = 377424
                AutoSize = True
                DataField = 'cDocumentPath'
                DataSource = dsJob
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
              end
              object btnOpenDocumentPath: TDNMSpeedButton
                AlignWithMargins = True
                Left = 5
                Top = 0
                Width = 93
                Height = 27
                HelpContext = 377425
                Margins.Top = 1
                Margins.Bottom = 1
                Caption = 'Open Doc Path'
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
                TabOrder = 0
                AutoDisableParentOnclick = True
                OnClick = btnOpenDocumentPathClick
              end
              object btnSetDocumentPath: TDNMSpeedButton
                AlignWithMargins = True
                Left = 104
                Top = 0
                Width = 93
                Height = 27
                HelpContext = 377426
                Margins.Top = 1
                Margins.Bottom = 1
                Caption = 'Set Doc Path'
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
                TabOrder = 1
                AutoDisableParentOnclick = True
                OnClick = btnSetDocumentPathClick
              end
            end
          end
        end
      end
    end
    object Custom_Fields: TTabSheet
      HelpContext = 377151
      Caption = 'Custom Fields'
      ImageIndex = 4
      object pnlCustFields: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377152
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Box181: TBevel
          Left = 42
          Top = 60
          Width = 721
          Height = 242
          HelpContext = 377153
        end
        object Label179: TLabel
          Left = 309
          Top = 12
          Width = 193
          Height = 26
          HelpContext = 377154
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
        object Bevel14: TBevel
          Left = 300
          Top = 8
          Width = 206
          Height = 32
          HelpContext = 377155
          Style = bsRaised
        end
        object cmdCustomLabelsOld: TDNMSpeedButton
          Left = 359
          Top = 275
          Width = 87
          Height = 27
          HelpContext = 377171
          Caption = '&Add Labels'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Visible = False
          AutoDisableParentOnclick = True
        end
        object pgCustomFields: TPageControl
          Left = 0
          Top = 0
          Width = 834
          Height = 355
          HelpContext = 377427
          ActivePage = TabSheet3
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          TabWidth = 387
          object tabCustomFields: TTabSheet
            HelpContext = 377428
            Caption = 'Customisable List'
            object pnlcustomfieldList: TDNMPanel
              Left = 0
              Top = 0
              Width = 826
              Height = 325
              HelpContext = 377429
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object DNMPanel13: TDNMPanel
                Left = 1
                Top = 1
                Width = 824
                Height = 34
                HelpContext = 377430
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
                Width = 824
                Height = 289
                HelpContext = 377431
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -24
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                Lines.Strings = (
                  'Steps to add Customisable list to any form'
                  '=============================================='
                  
                    '1: CustomFieldListFormExtender.ClassExtenderList.AddExtender    ' +
                    ' '
                  '2: TCustomFieldListFormExtender.InitForm       '
                  '3: Busobjcustomfields.ListType'
                  '4: Create table and busobj. eg : in Busobjcustomfields'
                  '5: create a new from TfmCustomFieldValue ONLY if there are new '
                  'fields and OVERRIDE the INSTANCE procedure to create its '
                  'instance. '
                  'Otehrwise the wrong form will be created'
                  '6: Override CustomFieldExtenderListtype in the input form using '
                  'custom fields'
                  '7: TfmCustomFieldValue.MakeCustomFieldForm : Add the new class'
                  '8: the name of the page control has to be '#39'TABCTL20'#39
                  '9: Name of the tabsheet has to be '#39'CUSTOM_FIELDS'#39
                  '10: Save button name : cmdOk'
                  '11:Newbutton name :cmdNew'
                  '12: TfmCustomfieldList.SetListType(const Value: TListType)'
                  '13: change enum field - tblcustomfieldlist.ListType to have new '
                  'listtype')
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 1
                Visible = False
              end
            end
          end
          object TabSheet3: TTabSheet
            HelpContext = 377432
            Caption = 'Customisable Fields'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ImageIndex = 1
            ParentFont = False
            object pnlCustFldsFixed: TDNMPanel
              Left = 0
              Top = 0
              Width = 826
              Height = 325
              HelpContext = 377433
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
              object Bevel27: TBevel
                Left = 292
                Top = 25
                Width = 206
                Height = 32
                HelpContext = 377434
                Style = bsRaised
              end
              object Bevel28: TBevel
                Left = 8
                Top = 70
                Width = 809
                Height = 242
                HelpContext = 377435
              end
              object Label96: TLabel
                Left = 301
                Top = 29
                Width = 193
                Height = 26
                HelpContext = 377436
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
                Left = 109
                Top = 93
                Width = 17
                Height = 15
                HelpContext = 377437
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
                Left = 109
                Top = 131
                Width = 17
                Height = 15
                HelpContext = 377438
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
                Left = 109
                Top = 170
                Width = 17
                Height = 15
                HelpContext = 377439
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
                Left = 109
                Top = 208
                Width = 17
                Height = 15
                HelpContext = 377440
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
                Left = 109
                Top = 247
                Width = 17
                Height = 15
                HelpContext = 377441
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
                Left = 109
                Top = 286
                Width = 17
                Height = 15
                HelpContext = 377442
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
                Left = 381
                Top = 93
                Width = 17
                Height = 15
                HelpContext = 377443
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
                Left = 381
                Top = 131
                Width = 17
                Height = 15
                HelpContext = 377444
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
                Left = 381
                Top = 170
                Width = 17
                Height = 15
                HelpContext = 377445
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
                Left = 374
                Top = 208
                Width = 24
                Height = 15
                HelpContext = 377446
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
                Left = 375
                Top = 247
                Width = 23
                Height = 15
                HelpContext = 377447
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
                Left = 374
                Top = 286
                Width = 24
                Height = 15
                HelpContext = 377448
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
                Left = 646
                Top = 93
                Width = 24
                Height = 15
                HelpContext = 377449
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
                Left = 646
                Top = 131
                Width = 24
                Height = 15
                HelpContext = 377450
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
                Left = 646
                Top = 170
                Width = 24
                Height = 15
                HelpContext = 377451
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
                Left = 646
                Top = 208
                Width = 24
                Height = 15
                HelpContext = 377452
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
              object Label101: TLabel
                Left = 631
                Top = 215
                Width = 3
                Height = 15
                HelpContext = 377453
                Alignment = taRightJustify
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Label102: TLabel
                Left = 631
                Top = 247
                Width = 3
                Height = 15
                HelpContext = 377454
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
                Left = 646
                Top = 247
                Width = 24
                Height = 15
                HelpContext = 377455
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
                Left = 646
                Top = 286
                Width = 24
                Height = 15
                HelpContext = 377456
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
              object CUSTFLD1: TwwDBComboBox
                Left = 129
                Top = 89
                Width = 130
                Height = 23
                HelpContext = 377457
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD1'
                DataSource = dsJob
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
                Left = 129
                Top = 127
                Width = 130
                Height = 23
                HelpContext = 377458
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD2'
                DataSource = dsJob
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
                Left = 129
                Top = 166
                Width = 130
                Height = 23
                HelpContext = 377459
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD3'
                DataSource = dsJob
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
                Left = 129
                Top = 204
                Width = 130
                Height = 23
                HelpContext = 377460
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD4'
                DataSource = dsJob
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
                Left = 129
                Top = 243
                Width = 130
                Height = 23
                HelpContext = 377461
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD5'
                DataSource = dsJob
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
                Left = 401
                Top = 204
                Width = 130
                Height = 23
                HelpContext = 377462
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD10'
                DataSource = dsJob
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
                Left = 401
                Top = 166
                Width = 130
                Height = 23
                HelpContext = 377463
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD9'
                DataSource = dsJob
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
                Left = 401
                Top = 127
                Width = 130
                Height = 23
                HelpContext = 377464
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD8'
                DataSource = dsJob
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
                Left = 401
                Top = 89
                Width = 130
                Height = 23
                HelpContext = 377465
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD7'
                DataSource = dsJob
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
                Left = 129
                Top = 282
                Width = 130
                Height = 23
                HelpContext = 377466
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD6'
                DataSource = dsJob
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
                Left = 401
                Top = 243
                Width = 130
                Height = 23
                HelpContext = 377467
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD11'
                DataSource = dsJob
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
                Left = 401
                Top = 282
                Width = 130
                Height = 23
                HelpContext = 377468
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD12'
                DataSource = dsJob
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
                Left = 673
                Top = 89
                Width = 130
                Height = 23
                HelpContext = 377469
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD13'
                DataSource = dsJob
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
                Left = 673
                Top = 127
                Width = 130
                Height = 23
                HelpContext = 377470
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD14'
                DataSource = dsJob
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
                Left = 673
                Top = 166
                Width = 130
                Height = 23
                HelpContext = 377471
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD15'
                DataSource = dsJob
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
                Left = 673
                Top = 204
                Width = 130
                Height = 23
                HelpContext = 377472
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'CUSTDATE1'
                DataSource = dsJob
                Epoch = 1950
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
                Left = 673
                Top = 243
                Width = 130
                Height = 23
                HelpContext = 377473
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'CUSTDATE2'
                DataSource = dsJob
                Epoch = 1950
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
                Left = 673
                Top = 282
                Width = 130
                Height = 23
                HelpContext = 377474
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'CUSTDATE3'
                DataSource = dsJob
                Epoch = 1950
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ShowButton = True
                TabOrder = 17
              end
              object DNMSpeedButton2: TDNMSpeedButton
                Left = 369
                Top = 319
                Width = 87
                Height = 27
                Hint = '"Add A New Customised Field For All Employee'#39's"'
                HelpContext = 377477
                Caption = '&Add Labels'
                DisableTransparent = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
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
                OnClick = DNMSpeedButton2Click
              end
            end
          end
        end
      end
    end
    object tabfollowup: TTabSheet
      HelpContext = 377226
      Caption = 'Followup / Jobcards'
      ImageIndex = 10
      object DNMPanel5: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 179
        HelpContext = 377227
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          834
          179)
        object Label74: TLabel
          Left = 3
          Top = 1
          Width = 50
          Height = 15
          HelpContext = 377418
          Caption = 'Followup'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object grdFollowUp: TwwDBGrid
          Left = 3
          Top = 21
          Width = 700
          Height = 152
          HelpContext = 377228
          ControlType.Strings = (
            'FollowUpDate;CustomEdit;dtpDatePicker;T'
            'EmployeeID;CustomEdit;cboEmployee;T'
            'Done;CheckBox;T;F'
            'EmployeeName;CustomEdit;cboEmployee;T')
          Selected.Strings = (
            'FollowUpDate'#9'12'#9'Follow Up Date'#9#9
            'Notes'#9'40'#9'Notes'#9#9
            'EmployeeName'#9'22'#9'Employee'#9#9
            'Hours'#9'9'#9'Hours'#9'F'#9
            'Done'#9'4'#9'Done'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Color = clWhite
          DataSource = dsOtherFollowUp
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
          OnExit = grdFollowUpExit
          FooterColor = clWhite
          FooterCellColor = clWhite
          object btnInactiveFollowUp: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            HelpContext = 377299
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
            OnClick = btnInactiveFollowUpClick
          end
        end
        object dtpDatePicker: TwwDBDateTimePicker
          Left = 24
          Top = 80
          Width = 88
          Height = 23
          HelpContext = 377300
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'FollowUpDate'
          DataSource = dsOtherFollowUp
          Epoch = 1950
          ShowButton = True
          TabOrder = 1
          OnExit = dtpDatePickerExit
        end
        object cboEmployee: TwwDBLookupCombo
          Left = 408
          Top = 48
          Width = 158
          Height = 23
          HelpContext = 377301
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'47'#9'EmployeeName'#9#9)
          DataField = 'EmployeeName'
          DataSource = dsOtherFollowUp
          LookupTable = qryEmployees
          LookupField = 'EmployeeID'
          DropDownWidth = 25
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object btnRepeat: TDNMSpeedButton
          Left = 736
          Top = 58
          Width = 87
          Height = 27
          HelpContext = 377229
          Action = actRepeat
          Anchors = [akBottom]
          Caption = '&Repeat'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 3
          AutoDisableParentOnclick = True
        end
        object btnServiceCycle: TDNMSpeedButton
          Left = 736
          Top = 25
          Width = 87
          Height = 27
          HelpContext = 377230
          Action = actServiceCycle
          Anchors = [akBottom]
          Caption = 'Service C&ycle'
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 4
          AutoDisableParentOnclick = True
        end
      end
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 179
        Width = 834
        Height = 176
        HelpContext = 377253
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 10
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label75: TLabel
          Left = 3
          Top = 2
          Width = 54
          Height = 15
          HelpContext = 377419
          Caption = 'Jobcards'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object grdEmp: TwwDBGrid
          Left = 2
          Top = 18
          Width = 820
          Height = 156
          HelpContext = 377254
          ControlType.Strings = (
            'EmployeeId;CustomEdit;cboEmp;F'
            'EmployeeName;CustomEdit;cboEmp;F'
            'TemplateName;CustomEdit;cboTemplate;F')
          Selected.Strings = (
            'EmployeeName'#9'20'#9'Employee Name'#9'F'
            'TemplateName'#9'40'#9'TemplateName'#9'F'
            'Notes'#9'43'#9'Notes'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWindow
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = wa
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
          UseTFields = False
          object grdEmpIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 23
            Height = 22
            HelpContext = 377302
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
            OnClick = grdEmpIButtonClick
          end
        end
        object cboEmp: TwwDBLookupCombo
          Left = 88
          Top = 58
          Width = 216
          Height = 23
          HelpContext = 377303
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'81'#9'EmployeeName'#9'F')
          DataField = 'EmployeeName'
          DataSource = wa
          LookupTable = qryEmpLookup
          LookupField = 'EmployeeID'
          TabOrder = 1
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDropDown = cboEmpDropDown
          OnCloseUp = cboEmpCloseUp
        end
        object cboTemplate: TwwDBLookupCombo
          Left = 448
          Top = 50
          Width = 216
          Height = 23
          HelpContext = 377304
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TemplName'#9'30'#9'TemplName'#9'F')
          DataField = 'TemplateName'
          DataSource = wa
          LookupTable = qryTemplate
          LookupField = 'TemplID'
          TabOrder = 2
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboTemplateCloseUp
        end
      end
    end
    object tabSpecialproducts: TTabSheet
      HelpContext = 377252
      Caption = 'Discounts'
      ImageIndex = 12
      object DNMPanel10: TDNMPanel
        Left = 0
        Top = 199
        Width = 834
        Height = 156
        HelpContext = 377305
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          830
          152)
        object Label80: TLabel
          Left = 10
          Top = 4
          Width = 108
          Height = 18
          HelpContext = 377306
          AutoSize = False
          Caption = 'Group Discounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label81: TLabel
          Left = 215
          Top = 2
          Width = 223
          Height = 15
          HelpContext = 377307
          Caption = 'Group Discount Overrides All Discounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label82: TLabel
          Left = 484
          Top = 2
          Width = 259
          Height = 15
          HelpContext = 377308
          Caption = 'Special Product Price Overrides All Discounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object grdProdGroupDiscs: TwwDBGrid
          Left = 8
          Top = 19
          Width = 800
          Height = 185
          HelpContext = 377309
          ControlType.Strings = (
            'Col1;CustomEdit;cboCol1;F'
            'Col2;CustomEdit;cboCol2;F'
            'Col3;CustomEdit;cboCol3;F')
          Selected.Strings = (
            'Col1'#9'20'#9'Col1'#9'F'#9
            'Col2'#9'20'#9'Col2'#9'F'#9
            'Col3'#9'20'#9'Col3'#9'F'#9
            'Discount'#9'10'#9'% Discount'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = dsProdGroupDiscs
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnExit = grdProdGroupDiscsExit
          OnFieldChanged = grdProdGroupDiscsFieldChanged
          FooterColor = clWhite
          FooterCellColor = clWhite
          object grdProdGroupDiscsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 23
            Height = 22
            HelpContext = 377310
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
            OnClick = grdProdGroupDiscsIButtonClick
          end
        end
        object cboCol1: TwwDBLookupCombo
          Left = 39
          Top = 56
          Width = 121
          Height = 23
          HelpContext = 377311
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PartLevel'#9'20'#9'PartLevel'#9'F')
          DataField = 'Col1'
          DataSource = dsProdGroupDiscs
          LookupTable = qryProductGroupcol1
          LookupField = 'PartLevel'
          Style = csDropDownList
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboCol2: TwwDBLookupCombo
          Left = 39
          Top = 80
          Width = 121
          Height = 23
          HelpContext = 377312
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PartLevel'#9'20'#9'PartLevel'#9'F')
          DataField = 'Col2'
          DataSource = dsProdGroupDiscs
          LookupTable = qryProductGroupcol2
          LookupField = 'PartLevel'
          Style = csDropDownList
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboCol3: TwwDBLookupCombo
          Left = 39
          Top = 109
          Width = 121
          Height = 23
          HelpContext = 377313
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PartLevel'#9'20'#9'PartLevel'#9'F')
          DataField = 'Col3'
          DataSource = dsProdGroupDiscs
          LookupTable = qryProductGroupcol3
          LookupField = 'PartLevel'
          Style = csDropDownList
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object chkgroupdiscount: TwwCheckBox
          Left = 457
          Top = 1
          Width = 15
          Height = 16
          HelpContext = 377314
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
          Caption = 'chkgroupdiscount'
          DataField = 'GroupDiscountOverridesAll'
          DataSource = dsJob
          TabOrder = 0
        end
        object chksplPrductdiscount: TwwCheckBox
          Left = 748
          Top = 1
          Width = 15
          Height = 16
          HelpContext = 377315
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
          Caption = 'wwCheckBox1'
          DataField = 'SpecialProductPriceOverridesAll'
          DataSource = dsJob
          TabOrder = 1
        end
      end
      object DNMPanel7: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 199
        HelpContext = 377316
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Transparent = False
        DesignSize = (
          830
          195)
        object Label78: TLabel
          Left = 118
          Top = 11
          Width = 144
          Height = 18
          HelpContext = 377317
          AutoSize = False
          Caption = 'Permanent Discount (%):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label79: TLabel
          Left = 335
          Top = 11
          Width = 171
          Height = 18
          HelpContext = 377318
          AutoSize = False
          Caption = 'Special Product Discount (%):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label76: TLabel
          Left = 3
          Top = 11
          Width = 108
          Height = 18
          HelpContext = 377319
          AutoSize = False
          Caption = 'Special Products'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object grdSpecials: TwwDBGrid
          AlignWithMargins = True
          Left = 4
          Top = 38
          Width = 819
          Height = 153
          HelpContext = 377320
          Margins.Right = 6
          ControlType.Strings = (
            'ProductID;CustomEdit;cboProd;F'
            'Name;CustomEdit;cboProd;F'
            'IncludeInRun;CheckBox;T;F')
          Selected.Strings = (
            'Name'#9'26'#9'Name'#9'F'
            'Description'#9'45'#9'Description'#9'T'
            'OrigPrice'#9'18'#9'Original Price (ex)'#9'T'
            'LinePrice'#9'18'#9'Line Price (ex)'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alBottom
          Color = clWhite
          DataSource = DSSpecials
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize, dgFixedProportionalResize]
          ParentFont = False
          TabOrder = 2
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnExit = grdSpecialsExit
          OnFieldChanged = grdSpecialsFieldChanged
          FooterColor = clWhite
          FooterCellColor = clWhite
          object grdSpecialsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            HelpContext = 377321
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
            OnClick = grdSpecialsIButtonClick
          end
        end
        object cboProd: TERPDbLookupCombo
          Left = 376
          Top = 96
          Width = 121
          Height = 26
          HelpContext = 377322
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PARTNAME'#9'15'#9'PARTNAME'#9'T'
            'PARTSDESCRIPTION'#9'30'#9'PARTSDESCRIPTION'#9'T')
          DataField = 'Name'
          DataSource = DSSpecials
          LookupTable = cboProductQry
          LookupField = 'Partname'
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnChange = cboProdChange
          OnCloseUp = cboProdCloseUp
          LookupFormClassName = 'TProductListExpressGUI'
          EditFormClassName = 'TfrmParts'
          LookupFormKeyStringFieldName = 'ProductName'
          LookupComboType = ctProduct
          AllowFullListSearchMode = False
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
          LookupIDField = 'PartsID'
          LookupFieldAlt = 'ProductPrintName'
        end
        object btnNewProd: TDNMSpeedButton
          Left = 681
          Top = -41
          Width = 115
          Height = 27
          Hint = 'Use this button to add a new product line to the grid'
          HelpContext = 377323
          Anchors = [akBottom]
          Caption = 'Add Ne&w Product'
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
          TabOrder = 4
          AutoDisableParentOnclick = True
        end
        object edtSpecDisc: TEdit
          Left = 505
          Top = 9
          Width = 65
          Height = 23
          HelpContext = 377324
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'edtSpecDisc'
          OnExit = edtSpecDiscExit
        end
        object edtDisc: TEdit
          Left = 261
          Top = 9
          Width = 65
          Height = 23
          HelpContext = 377325
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = 'edtDisc'
          OnExit = edtDiscExit
        end
        object btnCopySpecialPrices: TDNMSpeedButton
          Left = 604
          Top = 6
          Width = 73
          Height = 27
          Hint = '"Go To The Notes Field"'
          HelpContext = 377326
          Anchors = [akTop, akRight]
          Caption = 'Copy'
          DisableTransparent = False
          Font.Charset = RUSSIAN_CHARSET
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
          TabOrder = 3
          AutoDisableParentOnclick = True
          OnClick = btnCopySpecialPricesClick
        end
        object DNMSpeedButton1: TDNMSpeedButton
          Left = 681
          Top = 6
          Width = 115
          Height = 27
          Hint = 'Use this button to add a new product line to the grid'
          HelpContext = 377327
          Anchors = [akBottom]
          Caption = 'Add Ne&w Product'
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
          TabOrder = 6
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
      end
    end
    object tabEquip: TTabSheet
      HelpContext = 377148
      Caption = '&Equipment'
      ImageIndex = 3
      object CustEquipDNMPanel: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377149
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object tabServices: TTabSheet
      HelpContext = 377209
      Caption = 'Miscellaneous'
      ImageIndex = 8
      object MiscPageControl: TPageControl
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377328
        ActivePage = TabAuseParcel
        Align = alClient
        TabOrder = 0
        OnChange = MiscPageControlChange
        OnChanging = MiscPageControlChanging
        object TabSheet1: TTabSheet
          HelpContext = 377329
          Caption = 'Services'
          object pnlServices: TDNMPanel
            Left = 0
            Top = 0
            Width = 826
            Height = 324
            HelpContext = 377210
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              826
              324)
            object Bevel4: TBevel
              Left = 1
              Top = 3
              Width = 823
              Height = 340
              HelpContext = 377202
              Anchors = [akLeft, akTop, akRight, akBottom]
              ExplicitWidth = 794
              ExplicitHeight = 178
            end
            object lblServicesWarning: TLabel
              Left = 479
              Top = 12
              Width = 319
              Height = 15
              HelpContext = 377213
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = 'Please Save New Customer Job before Adding Services '
              Color = clBlack
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Visible = False
              ExplicitLeft = 450
            end
            object Label71: TLabel
              Left = 16
              Top = 12
              Width = 50
              Height = 15
              HelpContext = 377330
              Caption = 'Services'
            end
            object grdServices: TwwDBGrid
              Left = 16
              Top = 33
              Width = 782
              Height = 304
              HelpContext = 377211
              ControlType.Strings = (
                'RepLookup;CustomEdit;cboServiceReps;F'
                'ServiceLookup;CustomEdit;cboServices;F'
                'RatingLookup;CustomEdit;cboServiceRatings;F')
              Selected.Strings = (
                'RepLookup'#9'30'#9'Rep'#9#9
                'ServiceLookup'#9'25'#9'Service'#9#9
                'RatingLookup'#9'18'#9'Rating'#9#9)
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Anchors = [akLeft, akTop, akRight, akBottom]
              DataSource = dsCustomerServices
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
              OnExit = grdServicesExit
            end
            object cboServiceReps: TwwDBLookupCombo
              Left = 394
              Top = 64
              Width = 121
              Height = 23
              HelpContext = 377331
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'EmployeeName'#9'46'#9'EmployeeName'#9#9)
              LookupTable = qryEmpID
              LookupField = 'EmployeeID'
              TabOrder = 1
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnExit = cboServiceRepsExit
            end
            object cboServices: TwwDBLookupCombo
              Left = 394
              Top = 128
              Width = 121
              Height = 23
              HelpContext = 377332
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'ServiceDesc'#9'50'#9'ServiceDesc'#9#9)
              LookupTable = qryServices
              LookupField = 'ServiceID'
              TabOrder = 2
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnExit = cboServiceRepsExit
            end
            object cboServiceRatings: TwwDBLookupCombo
              Left = 394
              Top = 96
              Width = 121
              Height = 23
              HelpContext = 377333
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'RatingDesc'#9'25'#9'RatingDesc'#9'F')
              LookupTable = qryRating
              LookupField = 'RatingID'
              TabOrder = 3
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnExit = cboServiceRepsExit
            end
          end
        end
        object TabSheet2: TTabSheet
          HelpContext = 377334
          Caption = 'Attachments'
          ImageIndex = 1
          object pnlServicesBottom: TDNMPanel
            Left = 0
            Top = 0
            Width = 826
            Height = 324
            HelpContext = 377335
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              826
              324)
            object Bevel15: TBevel
              Left = 0
              Top = 11
              Width = 823
              Height = 314
              HelpContext = 377420
              Anchors = [akLeft, akTop, akRight, akBottom]
              ExplicitWidth = 794
              ExplicitHeight = 165
            end
            object Label64: TLabel
              Left = 15
              Top = 18
              Width = 111
              Height = 18
              HelpContext = 377205
              AutoSize = False
              Caption = 'Attachments'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label66: TLabel
              Left = 497
              Top = 18
              Width = 300
              Height = 14
              HelpContext = 377206
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              AutoSize = False
              Caption = 'Drag and drop attachments into list'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
              WordWrap = True
              ExplicitLeft = 468
            end
            object pnlAttachments: TPanel
              Left = 16
              Top = 39
              Width = 781
              Height = 276
              HelpContext = 377208
              Anchors = [akLeft, akTop, akRight, akBottom]
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
            end
          end
        end
        object TabAuseParcel: TTabSheet
          HelpContext = 377336
          Caption = 'eParcel'
          ImageIndex = 2
          object DNMPanel12: TDNMPanel
            Left = 0
            Top = 0
            Width = 826
            Height = 324
            HelpContext = 377337
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              826
              324)
            object Shape8: TShape
              Left = 580
              Top = 240
              Width = 242
              Height = 21
              HelpContext = 377338
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape10: TShape
              Left = 580
              Top = 260
              Width = 242
              Height = 33
              HelpContext = 377339
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape9: TShape
              Left = 580
              Top = 220
              Width = 242
              Height = 21
              HelpContext = 377340
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape6: TShape
              Left = 580
              Top = 172
              Width = 242
              Height = 49
              HelpContext = 377341
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape5: TShape
              Left = 580
              Top = 128
              Width = 242
              Height = 45
              HelpContext = 377342
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape2: TShape
              Left = 580
              Top = 67
              Width = 242
              Height = 62
              HelpContext = 377343
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape3: TShape
              Left = 81
              Top = 20
              Width = 244
              Height = 305
              HelpContext = 377344
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape1: TShape
              Left = 580
              Top = 9
              Width = 242
              Height = 59
              HelpContext = 377345
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Label83: TLabel
              Left = 17
              Top = 29
              Width = 61
              Height = 18
              HelpContext = 377346
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
            object Label84: TLabel
              Left = 8
              Top = 58
              Width = 69
              Height = 18
              HelpContext = 377347
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Name'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label85: TLabel
              Left = 11
              Top = 88
              Width = 66
              Height = 18
              HelpContext = 377348
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
            object Label86: TLabel
              Left = 11
              Top = 117
              Width = 66
              Height = 18
              HelpContext = 377349
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Address 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label87: TLabel
              Left = 11
              Top = 147
              Width = 66
              Height = 18
              HelpContext = 377350
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Address 3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label88: TLabel
              Left = 11
              Top = 177
              Width = 66
              Height = 18
              HelpContext = 377351
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'City'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label89: TLabel
              Left = 11
              Top = 206
              Width = 66
              Height = 18
              HelpContext = 377352
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'State'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label90: TLabel
              Left = 11
              Top = 236
              Width = 66
              Height = 18
              HelpContext = 377353
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Postcode'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label91: TLabel
              Left = 11
              Top = 266
              Width = 66
              Height = 18
              HelpContext = 377354
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Country'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label92: TLabel
              Left = 82
              Top = 5
              Width = 89
              Height = 15
              HelpContext = 377355
              Caption = 'Return Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label93: TLabel
              Left = 330
              Top = 5
              Width = 99
              Height = 15
              HelpContext = 377356
              Caption = 'Redirect Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label94: TLabel
              Left = 585
              Top = 10
              Width = 69
              Height = 15
              HelpContext = 377357
              Alignment = taRightJustify
              Caption = 'Reference 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label95: TLabel
              Left = 585
              Top = 50
              Width = 88
              Height = 15
              HelpContext = 377358
              Alignment = taRightJustify
              Caption = 'Print on Label? '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Shape4: TShape
              Left = 330
              Top = 20
              Width = 244
              Height = 273
              HelpContext = 377359
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Label97: TLabel
              Left = 585
              Top = 68
              Width = 69
              Height = 15
              HelpContext = 377360
              Alignment = taRightJustify
              Caption = 'Reference 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label98: TLabel
              Left = 585
              Top = 108
              Width = 88
              Height = 15
              HelpContext = 377361
              Alignment = taRightJustify
              Caption = 'Print on Label? '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label114: TLabel
              Left = 587
              Top = 134
              Width = 78
              Height = 30
              HelpContext = 377362
              Alignment = taRightJustify
              Caption = 'Extra Delivery Instructions'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object lblAccount: TLabel
              Left = 585
              Top = 175
              Width = 119
              Height = 15
              HelpContext = 377363
              Caption = 'Chargeback Account'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Shape7: TShape
              Left = 457
              Top = 292
              Width = 365
              Height = 36
              HelpContext = 377364
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Label99: TLabel
              Left = 351
              Top = 302
              Width = 94
              Height = 15
              HelpContext = 377365
              Alignment = taRightJustify
              Caption = 'Email Notiication'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label100: TLabel
              Left = 619
              Top = 223
              Width = 175
              Height = 15
              HelpContext = 377366
              Alignment = taRightJustify
              Caption = 'Print Phone Number on Label ?'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label113: TLabel
              Left = 675
              Top = 243
              Width = 119
              Height = 15
              HelpContext = 377367
              Alignment = taRightJustify
              Caption = 'Signature Required ?'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label112: TLabel
              Left = 592
              Top = 261
              Width = 202
              Height = 30
              HelpContext = 377368
              Alignment = taRightJustify
              Caption = 
                'If the Premises unattended, leave in a secure location out of we' +
                'ather ?'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object DBEdit1: TDBEdit
              Left = 85
              Top = 27
              Width = 229
              Height = 23
              HelpContext = 377369
              DataField = 'Return_Company'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object DBEdit2: TDBEdit
              Left = 85
              Top = 56
              Width = 229
              Height = 23
              HelpContext = 377370
              DataField = 'Return_Name'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object DBEdit3: TDBEdit
              Left = 85
              Top = 86
              Width = 229
              Height = 23
              HelpContext = 377371
              DataField = 'Return_Street1'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object DBEdit4: TDBEdit
              Left = 85
              Top = 116
              Width = 229
              Height = 23
              HelpContext = 377372
              DataField = 'Return_Street2'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object DBEdit5: TDBEdit
              Left = 85
              Top = 145
              Width = 229
              Height = 23
              HelpContext = 377373
              DataField = 'Return_Street3'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object wwDBLookupCombo1: TwwDBLookupCombo
              Left = 85
              Top = 175
              Width = 229
              Height = 23
              HelpContext = 377374
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'Return_Suburb'
              DataSource = dsclients_eParcel
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 5
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = wwDBLookupCombo2CloseUp
            end
            object DBEdit6: TDBEdit
              Left = 85
              Top = 205
              Width = 89
              Height = 23
              HelpContext = 377375
              DataField = 'Return_State'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object DBEdit7: TDBEdit
              Left = 85
              Top = 234
              Width = 89
              Height = 23
              HelpContext = 377376
              DataField = 'Return_Postcode'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object DBEdit8: TDBEdit
              Left = 85
              Top = 264
              Width = 229
              Height = 23
              HelpContext = 377377
              DataField = 'Return_Country'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object DBEdit9: TDBEdit
              Left = 335
              Top = 27
              Width = 234
              Height = 23
              HelpContext = 377378
              DataField = 'ReDir_Company'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object DBEdit10: TDBEdit
              Left = 335
              Top = 56
              Width = 234
              Height = 23
              HelpContext = 377379
              DataField = 'ReDir_Name'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object DBEdit11: TDBEdit
              Left = 335
              Top = 86
              Width = 234
              Height = 23
              HelpContext = 377380
              DataField = 'ReDir_Street1'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
            end
            object DBEdit12: TDBEdit
              Left = 335
              Top = 115
              Width = 234
              Height = 23
              HelpContext = 377381
              DataField = 'ReDir_Street2'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object DBEdit13: TDBEdit
              Left = 335
              Top = 145
              Width = 234
              Height = 23
              HelpContext = 377382
              DataField = 'ReDir_Street3'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
            end
            object wwDBLookupCombo2: TwwDBLookupCombo
              Left = 335
              Top = 175
              Width = 234
              Height = 23
              HelpContext = 377383
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'ReDir_Suburb'
              DataSource = dsclients_eParcel
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 14
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object DBEdit14: TDBEdit
              Left = 335
              Top = 204
              Width = 89
              Height = 23
              HelpContext = 377384
              DataField = 'ReDir_State'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
            end
            object DBEdit15: TDBEdit
              Left = 335
              Top = 234
              Width = 89
              Height = 23
              HelpContext = 377385
              DataField = 'ReDir_Postcode'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 16
            end
            object DBEdit16: TDBEdit
              Left = 335
              Top = 264
              Width = 234
              Height = 23
              HelpContext = 377386
              DataField = 'ReDir_Country'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 17
            end
            object DBEdit17: TDBEdit
              Left = 585
              Top = 27
              Width = 233
              Height = 23
              HelpContext = 377387
              DataField = 'eParcelreference1'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 18
            end
            object wwCheckBox1: TwwCheckBox
              Left = 682
              Top = 51
              Width = 15
              Height = 12
              HelpContext = 377388
              DisableThemes = False
              AlwaysTransparent = True
              Frame.Enabled = True
              Frame.Transparent = True
              Frame.FocusBorders = []
              Frame.NonFocusBorders = []
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'T'
              DisplayValueUnchecked = 'F'
              NullAndBlankState = cbUnchecked
              Caption = 'ChkStopCredit'
              DataField = 'PrinteParcelreference1'
              DataSource = dsclients_eParcel
              TabOrder = 19
            end
            object btnCopyReturnAddress: TDNMSpeedButton
              Left = 85
              Top = 294
              Width = 229
              Height = 27
              HelpContext = 377421
              Caption = 'Copy Address From Company Info'
              DisableTransparent = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              HotTrackFont.Charset = ANSI_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = [fsBold]
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 20
              AutoDisableParentOnclick = True
              OnClick = btnCopyReturnAddressClick
            end
            object DBEdit18: TDBEdit
              Left = 585
              Top = 84
              Width = 233
              Height = 23
              HelpContext = 377389
              DataField = 'eParcelreference2'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 21
            end
            object wwCheckBox2: TwwCheckBox
              Left = 685
              Top = 109
              Width = 15
              Height = 12
              HelpContext = 377390
              DisableThemes = False
              AlwaysTransparent = True
              Frame.Enabled = True
              Frame.Transparent = True
              Frame.FocusBorders = []
              Frame.NonFocusBorders = []
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'T'
              DisplayValueUnchecked = 'F'
              NullAndBlankState = cbUnchecked
              Caption = 'ChkStopCredit'
              DataField = 'PrinteParcelreference2'
              DataSource = dsclients_eParcel
              TabOrder = 22
            end
            object txtExtraDeliveryInstructions: TDBMemo
              Left = 671
              Top = 127
              Width = 147
              Height = 38
              HelpContext = 377391
              Anchors = [akLeft, akBottom]
              DataField = 'ExtraDeliveryInstructions'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ScrollBars = ssVertical
              ShowHint = True
              TabOrder = 23
            end
            object cboAccount: TwwDBLookupCombo
              Left = 585
              Top = 190
              Width = 233
              Height = 23
              HelpContext = 377392
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'AccountName'#9'50'#9'AccountName'#9'F')
              DataField = 'ChargeBackAcnt'
              DataSource = dsclients_eParcel
              LookupTable = cboAccountQry
              LookupField = 'AccountName'
              ParentFont = False
              TabOrder = 24
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
            end
            object wwRadioGroup1: TwwRadioGroup
              Left = 462
              Top = 294
              Width = 352
              Height = 32
              HelpContext = 377393
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              DisableThemes = False
              Columns = 3
              DataField = 'EmailNotification'
              DataSource = dsclients_eParcel
              Items.Strings = (
                'NONE'
                'DESPATCH'
                'TRACK ADV')
              TabOrder = 25
              Values.Strings = (
                'NONE'
                'DESPATCH'
                'TRACKADV')
            end
            object wwCheckBox3: TwwCheckBox
              Left = 801
              Top = 221
              Width = 15
              Height = 19
              HelpContext = 377394
              DisableThemes = False
              AlwaysTransparent = True
              Frame.Enabled = True
              Frame.Transparent = True
              Frame.FocusBorders = []
              Frame.NonFocusBorders = []
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'T'
              DisplayValueUnchecked = 'F'
              NullAndBlankState = cbUnchecked
              DataField = 'consigneePhoneonLabel'
              DataSource = dsclients_eParcel
              TabOrder = 26
            end
            object wwCheckBox4: TwwCheckBox
              Left = 801
              Top = 241
              Width = 15
              Height = 19
              HelpContext = 377395
              DisableThemes = False
              AlwaysTransparent = True
              Frame.Enabled = True
              Frame.Transparent = True
              Frame.FocusBorders = []
              Frame.NonFocusBorders = []
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'T'
              DisplayValueUnchecked = 'F'
              NullAndBlankState = cbUnchecked
              DataField = 'consigneePhoneonLabel'
              DataSource = dsclients_eParcel
              TabOrder = 27
            end
            object wwCheckBox5: TwwCheckBox
              Left = 801
              Top = 267
              Width = 15
              Height = 19
              HelpContext = 377396
              DisableThemes = False
              AlwaysTransparent = True
              Frame.Enabled = True
              Frame.Transparent = True
              Frame.FocusBorders = []
              Frame.NonFocusBorders = []
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'T'
              DisplayValueUnchecked = 'F'
              NullAndBlankState = cbUnchecked
              DataField = 'LeaveAtAddress'
              DataSource = dsclients_eParcel
              TabOrder = 28
            end
          end
        end
      end
    end
    object tabReferrals: TTabSheet
      HelpContext = 377214
      Caption = 'Referrals'
      ImageIndex = 9
      TabVisible = False
      object DNMPanel14: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377215
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          834
          355)
        object Bevel21: TBevel
          Left = 151
          Top = 40
          Width = 532
          Height = 301
          HelpContext = 377216
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitWidth = 503
          ExplicitHeight = 305
        end
        object Label37: TLabel
          Left = 155
          Top = 58
          Width = 36
          Height = 14
          HelpContext = 377217
          AutoSize = False
          Caption = 'Delete'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label40: TLabel
          Left = 164
          Top = 88
          Width = 38
          Height = 15
          HelpContext = 377218
          Caption = 'Label3'
        end
        object Label41: TLabel
          Left = 371
          Top = 45
          Width = 91
          Height = 24
          HelpContext = 377219
          Anchors = [akTop]
          Caption = 'Referrals'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 357
        end
        object lblReferralsWarning: TLabel
          Left = 210
          Top = 16
          Width = 319
          Height = 15
          HelpContext = 377220
          Caption = 'Please Save New Customer Job before Adding Referrals'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Visible = False
        end
        object Label46: TLabel
          Left = 51
          Top = 326
          Width = 53
          Height = 15
          HelpContext = 377221
          Anchors = [akLeft, akBottom]
          Caption = 'Select All'
          Transparent = True
          ExplicitTop = 330
        end
        object Label47: TLabel
          Left = 204
          Top = 320
          Width = 345
          Height = 14
          HelpContext = 377222
          Anchors = [akBottom]
          AutoSize = False
          Caption = 'To Select individual Referrals hold down CTRL Key and Click'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitLeft = 191
          ExplicitTop = 324
        end
        object grdReferrals: TwwDBGrid
          Left = 151
          Top = 72
          Width = 509
          Height = 237
          HelpContext = 377223
          ControlType.Strings = (
            'CompanyLookup;CustomEdit;cboClients;F')
          Selected.Strings = (
            'CompanyLookup'#9'27'#9'Name'#9'F'
            'PhoneLookup'#9'17'#9'Phone'#9'F'
            'FaxLookup'#9'17'#9'Fax'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          OnRowChanged = grdContactRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = dsReferrals
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoShiftSelect]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = EditBtnClick
          OnExit = grdReferralsExit
          object btnDeleteReferral: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            Hint = 'Click this button to Deactivate the selected contact'
            HelpContext = 377397
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
            OnClick = btnDeleteReferralClick
          end
        end
        object cboClients: TwwDBLookupCombo
          Left = 178
          Top = 104
          Width = 121
          Height = 23
          HelpContext = 377398
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'40'#9'Company'#9'F'#9)
          LookupTable = qryClients
          LookupField = 'Company'
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnExit = cboClientsExit
        end
        object btnLetters: TDNMSpeedButton
          Left = 691
          Top = 40
          Width = 87
          Height = 27
          HelpContext = 377224
          Action = actReferralsPrint
          Anchors = [akTop, akRight]
          Caption = 'Letters'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 2
          AutoDisableParentOnclick = True
        end
        object chkAllRefs: TCheckBox
          Left = 33
          Top = 324
          Width = 13
          Height = 17
          HelpContext = 377225
          Anchors = [akLeft, akBottom]
          Caption = 'chkAllRefs'
          TabOrder = 3
          OnClick = chkAllRefsClick
        end
      end
    end
    object tabCarePlan: TTabSheet
      HelpContext = 377231
      Caption = 'Care Plan'
      ImageIndex = 11
      TabVisible = False
      object DNMPanel8: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377232
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grdCarePlan: TwwDBGrid
          Left = 0
          Top = 0
          Width = 834
          Height = 177
          HelpContext = 377233
          ControlType.Strings = (
            'ServiceDesc;CustomEdit;cboCareServices;F')
          Selected.Strings = (
            'ServiceDesc'#9'20'#9'Service Description'#9'F'
            'SundayFromTime'#9'10'#9'From'#9'F'#9'Sunday'
            'SundayToTime'#9'10'#9'To'#9'F'#9'Sunday'
            'MondayFromTime'#9'10'#9'From'#9'F'#9'Monday'
            'MondayToTime'#9'10'#9'To'#9'F'#9'Monday'
            'TuesdayFromTime'#9'10'#9'From'#9'F'#9'Tuesday'
            'TuesdayToTime'#9'10'#9'To'#9'F'#9'Tuesday'
            'WednesdayFromTime'#9'10'#9'From'#9'F'#9'Wednesday'
            'WednesdayToTime'#9'10'#9'To'#9'F'#9'Wednesday'
            'ThursdayFromTime'#9'10'#9'From'#9'F'#9'Thursday'
            'ThursdayToTime'#9'10'#9'To'#9'F'#9'Thursday'
            'FridayFromTime'#9'10'#9'From'#9'F'#9'Friday'
            'FridayToTime'#9'10'#9'To'#9'F'#9'Friday'
            'SaturdayFromTime'#9'10'#9'From'#9'F'#9'Saturday'
            'SaturdayToTime'#9'10'#9'To'#9'F'#9'Saturday')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          OnRowChanged = grdContactRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alClient
          Color = clWhite
          DataSource = DSCarePlan
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoShiftSelect]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = False
          UseTFields = False
          OnDblClick = EditBtnClick
          OnExit = grdCarePlanExit
          object wwIButton1: TwwIButton
            Left = -1
            Top = 0
            Width = 22
            Height = 34
            Hint = 'Click this button to Deactivate the selected contact'
            HelpContext = 377399
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
            OnClick = wwIButton1Click
          end
        end
        object DNMPanel9: TDNMPanel
          Left = 0
          Top = 177
          Width = 834
          Height = 178
          HelpContext = 377234
          Align = alBottom
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Bevel22: TBevel
            Left = 4
            Top = 45
            Width = 397
            Height = 101
            HelpContext = 377235
            Shape = bsFrame
          end
          object Bevel23: TBevel
            Left = 408
            Top = 45
            Width = 395
            Height = 101
            HelpContext = 377236
            Shape = bsFrame
          end
          object Bevel20: TBevel
            Left = 408
            Top = 3
            Width = 395
            Height = 37
            HelpContext = 377237
            Shape = bsFrame
          end
          object Bevel19: TBevel
            Left = 4
            Top = 3
            Width = 397
            Height = 37
            HelpContext = 377238
            Shape = bsFrame
          end
          object Label35: TLabel
            Left = 17
            Top = 47
            Width = 34
            Height = 15
            HelpContext = 377239
            Caption = 'Tasks'
            FocusControl = Task
            Transparent = True
          end
          object Label36: TLabel
            Left = 417
            Top = 47
            Width = 113
            Height = 15
            HelpContext = 377240
            Caption = 'Special Instructions'
            FocusControl = SpecialInstructions
            Transparent = True
          end
          object Label38: TLabel
            Left = 271
            Top = 13
            Width = 13
            Height = 15
            HelpContext = 377241
            Caption = 'To'
            FocusControl = SpecialInstructions
            Transparent = True
          end
          object Label44: TLabel
            Left = 10
            Top = 13
            Width = 130
            Height = 15
            HelpContext = 377242
            Caption = 'Weekly Approval  From'
            Transparent = True
          end
          object Label45: TLabel
            Left = 468
            Top = 14
            Width = 55
            Height = 15
            HelpContext = 377243
            Caption = 'Reminder'
            Transparent = True
          end
          object wwDBDateTimePicker3: TwwDBDateTimePicker
            Left = 289
            Top = 9
            Width = 105
            Height = 23
            HelpContext = 377244
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'ApprovalToDate'
            DataSource = dsJob
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 1
            UnboundDataType = wwDTEdtDate
          end
          object wwDBDateTimePicker4: TwwDBDateTimePicker
            Left = 144
            Top = 10
            Width = 105
            Height = 23
            HelpContext = 377245
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'ApprovalFromDate'
            DataSource = dsJob
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 0
            UnboundDataType = wwDTEdtDate
          end
          object Task: TDBMemo
            Left = 17
            Top = 60
            Width = 374
            Height = 79
            HelpContext = 377246
            DataField = 'Tasks'
            DataSource = dsJob
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object SpecialInstructions: TDBMemo
            Left = 417
            Top = 60
            Width = 374
            Height = 79
            HelpContext = 377247
            DataField = 'SpecialInstructions'
            DataSource = dsJob
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object wwDBDateTimePicker5: TwwDBDateTimePicker
            Left = 526
            Top = 10
            Width = 153
            Height = 23
            HelpContext = 377248
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'ReminderDateTime'
            DataSource = dsJob
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 2
          end
          object cmdPrint: TDNMSpeedButton
            Left = 414
            Top = 150
            Width = 89
            Height = 27
            HelpContext = 377249
            Caption = 'Prin&t'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            AutoDisableParentOnclick = True
            OnClick = cmdPrintClick
          end
          object Button1: TDNMSpeedButton
            Left = 11
            Top = 368
            Width = 88
            Height = 27
            HelpContext = 377250
            Caption = 'Load From App'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            AutoDisableParentOnclick = True
          end
          object btnSortMeals: TDNMSpeedButton
            Left = 234
            Top = 150
            Width = 95
            Height = 27
            Hint = '"Sort Meals && Beverages in Order"'
            HelpContext = 377251
            Caption = ' Load From App'
            DisableTransparent = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            AutoDisableParentOnclick = True
          end
        end
        object cboCareServices: TwwDBLookupCombo
          Left = 29
          Top = 43
          Width = 121
          Height = 23
          HelpContext = 377400
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ServiceDescription'#9'50'#9'ServiceDescription'#9'F')
          DataField = 'ServiceDesc'
          DataSource = DSCarePlan
          LookupTable = cboServiceIDQry
          LookupField = 'ServiceDescription'
          TabOrder = 2
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboCareServicesCloseUp
        end
      end
    end
    object tabInsurance: TTabSheet
      Caption = '&Insurance'
      ImageIndex = 14
      object DNMPanel15: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377013
        Align = alClient
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel31: TBevel
          Left = 16
          Top = 138
          Width = 466
          Height = 182
          HelpContext = 377260
          Shape = bsFrame
        end
        object Bevel32: TBevel
          Left = 16
          Top = 18
          Width = 777
          Height = 104
          HelpContext = 377261
          Shape = bsFrame
        end
        object Label108: TLabel
          Left = 22
          Top = 24
          Width = 112
          Height = 15
          HelpContext = 377019
          Caption = 'Manufacture / Make'
          Transparent = True
        end
        object Label109: TLabel
          Left = 393
          Top = 24
          Width = 69
          Height = 15
          HelpContext = 377020
          Caption = 'Registration'
          Transparent = True
        end
        object Label110: TLabel
          Left = 688
          Top = 71
          Width = 78
          Height = 15
          HelpContext = 377021
          Caption = 'Serial No / Vin'
          Transparent = True
        end
        object Label111: TLabel
          Left = 207
          Top = 24
          Width = 44
          Height = 15
          HelpContext = 377022
          Caption = 'Model #'
          Transparent = True
        end
        object Label115: TLabel
          Left = 29
          Top = 141
          Width = 118
          Height = 15
          HelpContext = 377024
          Caption = 'Warranty Finish Date'
          Transparent = True
        end
        object Label116: TLabel
          Left = 162
          Top = 141
          Width = 93
          Height = 15
          HelpContext = 377025
          Caption = 'Warranty Period'
          Transparent = True
          WordWrap = True
        end
        object Label117: TLabel
          Left = 260
          Top = 161
          Width = 42
          Height = 15
          HelpContext = 377026
          Alignment = taRightJustify
          Caption = 'Km/Hrs'
          Transparent = True
        end
        object Label118: TLabel
          Left = 133
          Top = 71
          Width = 86
          Height = 15
          HelpContext = 377027
          Caption = 'Kms/Hrs Taken'
          Transparent = True
        end
        object Label121: TLabel
          Left = 244
          Top = 71
          Width = 83
          Height = 15
          HelpContext = 377030
          Caption = 'Remaining Hrs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label122: TLabel
          Left = 22
          Top = 71
          Width = 25
          Height = 15
          HelpContext = 377404
          Caption = 'Year'
          Transparent = True
        end
        object Label123: TLabel
          Left = 660
          Top = 24
          Width = 37
          Height = 15
          HelpContext = 377405
          Caption = 'Colour'
          Transparent = True
        end
        object Label124: TLabel
          Left = 520
          Top = 24
          Width = 57
          Height = 15
          HelpContext = 377406
          Caption = 'Body Type'
          Transparent = True
        end
        object Label125: TLabel
          Left = 29
          Top = 185
          Width = 113
          Height = 15
          HelpContext = 377407
          Caption = 'Insurance Company'
          Transparent = True
        end
        object Label126: TLabel
          Left = 234
          Top = 185
          Width = 98
          Height = 15
          HelpContext = 377408
          Caption = 'Assessors Name'
          Transparent = True
        end
        object Label127: TLabel
          Left = 359
          Top = 185
          Width = 89
          Height = 15
          HelpContext = 377409
          Caption = 'Excess Amount'
          Transparent = True
        end
        object Label129: TLabel
          Left = 28
          Top = 227
          Width = 87
          Height = 15
          HelpContext = 377410
          Caption = 'Storm Location'
          Transparent = True
        end
        object Label130: TLabel
          Left = 234
          Top = 227
          Width = 64
          Height = 15
          HelpContext = 377411
          Caption = 'Storm Date'
          Transparent = True
        end
        object Label131: TLabel
          Left = 466
          Top = 71
          Width = 94
          Height = 15
          HelpContext = 377412
          Caption = 'Stock Recd Date'
          Transparent = True
        end
        object Label132: TLabel
          Left = 28
          Top = 271
          Width = 98
          Height = 15
          HelpContext = 377413
          Caption = 'Bailment Number'
          Transparent = True
        end
        object Label133: TLabel
          Left = 234
          Top = 271
          Width = 114
          Height = 15
          HelpContext = 377414
          Caption = 'Bailment Amount Ex'
          Transparent = True
        end
        object Label134: TLabel
          Left = 355
          Top = 71
          Width = 72
          Height = 15
          HelpContext = 377415
          Caption = 'New or Used'
          Transparent = True
        end
        object Label135: TLabel
          Left = 577
          Top = 71
          Width = 64
          Height = 15
          HelpContext = 377475
          Caption = 'Expiry Date'
          Transparent = True
        end
        object edtRegistration: TwwDBEdit
          Left = 393
          Top = 41
          Width = 105
          Height = 23
          HelpContext = 377033
          DataField = 'JobRegistration'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBDateTimePicker7: TwwDBDateTimePicker
          Left = 29
          Top = 158
          Width = 122
          Height = 23
          HelpContext = 377035
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'WarrantyFinishDate'
          DataSource = dsJob
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 12
        end
        object wwDBEdit5: TwwDBEdit
          Left = 162
          Top = 158
          Width = 95
          Height = 23
          HelpContext = 377036
          DataField = 'WarrantyPeriod'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object editKms: TwwDBEdit
          Left = 133
          Top = 87
          Width = 93
          Height = 23
          HelpContext = 377037
          DataField = 'HoursTakenForJob'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboManufacture: TwwDBLookupCombo
          Left = 22
          Top = 42
          Width = 157
          Height = 23
          HelpContext = 377041
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'Manufacture'
          DataSource = dsJob
          LookupTable = qryManufacture
          LookupField = 'Name'
          ParentFont = False
          TabOrder = 0
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnNotInList = cboManufactureNotInList
        end
        object cboModel: TwwDBLookupCombo
          Left = 207
          Top = 41
          Width = 158
          Height = 23
          HelpContext = 377042
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'ModelNumber'
          DataSource = dsJob
          LookupTable = qryModel
          LookupField = 'Name'
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnNotInList = cboModelNotInList
        end
        object edtHours: TwwDBEdit
          Left = 244
          Top = 87
          Width = 93
          Height = 23
          HelpContext = 377043
          DataField = 'hours'
          DataSource = dsJob
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
        object edtColor: TwwDBEdit
          Left = 660
          Top = 41
          Width = 121
          Height = 23
          HelpContext = 377262
          DataField = 'Colour'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboYear: TwwDBDateTimePicker
          Left = 22
          Top = 87
          Width = 93
          Height = 23
          HelpContext = 377263
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'Year'
          DataSource = dsJob
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 5
          DisplayFormat = 'yyyy'
        end
        object edtBodyType: TwwDBEdit
          Left = 520
          Top = 41
          Width = 121
          Height = 23
          HelpContext = 377264
          DataField = 'BodyType'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit11: TwwDBEdit
          Left = 234
          Top = 201
          Width = 111
          Height = 23
          HelpContext = 377265
          DataField = 'AssessorsName'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit12: TwwDBEdit
          Left = 359
          Top = 201
          Width = 108
          Height = 23
          HelpContext = 377266
          DataField = 'ExcessAmount'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtStormLocation: TwwDBLookupCombo
          Left = 28
          Top = 243
          Width = 193
          Height = 23
          HelpContext = 377267
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'30'#9'Location'#9'F')
          DataField = 'StormLocation'
          DataSource = dsJob
          LookupTable = qrySuburb
          LookupField = 'City_sub'
          ParentFont = False
          TabOrder = 17
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = edtStormLocationEnter
        end
        object cboStormDate: TwwDBDateTimePicker
          Left = 227
          Top = 242
          Width = 93
          Height = 23
          HelpContext = 377268
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'StormDate'
          DataSource = dsJob
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 18
        end
        object ERPDbLookupCombo1: TERPDbLookupCombo
          Left = 29
          Top = 201
          Width = 192
          Height = 23
          HelpContext = 377269
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'30'#9'Company'#9'F')
          DataField = 'InsuranceCompanyName'
          DataSource = dsJob
          LookupTable = qryInsuranceCompanyLookup
          LookupField = 'Company'
          ParentFont = False
          TabOrder = 14
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
          LookupIDField = 'ClientID'
          LookupFieldAlt = 'PrintName'
        end
        object wwDBDateTimePicker10: TwwDBDateTimePicker
          Left = 466
          Top = 87
          Width = 93
          Height = 23
          HelpContext = 377270
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'StockReceivedDate'
          DataSource = dsJob
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 9
        end
        object wwDBEdit13: TwwDBEdit
          Left = 28
          Top = 288
          Width = 121
          Height = 23
          HelpContext = 377271
          DataField = 'BailmentNumber'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit14: TwwDBEdit
          Left = 234
          Top = 288
          Width = 108
          Height = 23
          HelpContext = 377272
          DataField = 'BailmentAmountEx'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit15: TwwDBEdit
          Left = 355
          Top = 87
          Width = 93
          Height = 23
          HelpContext = 377273
          DataField = 'NewOrUsed'
          DataSource = dsJob
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
        object wwDBEdit16: TwwDBEdit
          Left = 688
          Top = 87
          Width = 93
          Height = 23
          HelpContext = 377034
          DataField = 'SerialNumber'
          DataSource = dsJob
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBDateTimePicker11: TwwDBDateTimePicker
          Left = 577
          Top = 87
          Width = 93
          Height = 23
          HelpContext = 377476
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          DataField = 'ExpiryDate'
          DataSource = dsJob
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 10
        end
      end
    end
    object tabProducts: TTabSheet
      Caption = '&Products'
      ImageIndex = 15
      object DNMPanel16: TDNMPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 355
        HelpContext = 377013
        Align = alClient
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grdProducts: TwwDBGrid
          AlignWithMargins = True
          Left = 20
          Top = 25
          Width = 797
          Height = 326
          HelpContext = 619011
          ControlType.Strings = (
            'Deleted;CheckBox;T;F'
            'Processed;CheckBox;T;F')
          Selected.Strings = (
            'ProductName'#9'20'#9'Product Name'#9'F'
            'Description'#9'20'#9'Description'#9'F'
            'AvailableUOMQty'#9'10'#9'Available'#9'F'#9'Quantity'
            'FinalUOMQty'#9'10'#9'Final'#9'F'#9'Quantity'
            'AdjustUOMQty'#9'10'#9'Adjust'#9'F'#9'Quantity'
            'UOM'#9'10'#9'UOM'#9'F'
            'UOMCost'#9'10'#9'Cost'#9'F'
            'TotalCost'#9'10'#9'Total Cost'#9'F')
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Color = clWhite
          DataSource = dsStockAdjustEntries
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = True
          UseTFields = False
          LineColors.GroupingColor = clSilver
          OnUpdateFooter = grdProductsUpdateFooter
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          object btnGrid: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 22
            AllowAllUp = True
          end
        end
      end
    end
  end
  object pnlTitle: TDNMPanel [10]
    Left = 284
    Top = 4
    Width = 244
    Height = 39
    HelpContext = 377255
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 240
      Height = 35
      HelpContext = 377256
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
        Width = 240
        Height = 35
        HelpContext = 377257
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customer JOB'
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
  object btnCompleted: TDNMSpeedButton [11]
    Left = 96
    Top = 530
    Width = 87
    Height = 27
    HelpContext = 377004
    Anchors = [akBottom]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnCompletedClick
  end
  object lblCompany: TStaticText [12]
    Left = 548
    Top = 8
    Width = 293
    Height = 29
    HelpContext = 377003
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Caption = 'lblCompany'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object btnClose: TDNMSpeedButton [13]
    Left = 678
    Top = 531
    Width = 87
    Height = 27
    HelpContext = 377005
    Anchors = [akBottom]
    Caption = '&Cancel'
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = btnCloseClick
  end
  object chkActive: TwwCheckBox [14]
    Left = 821
    Top = 541
    Width = 15
    Height = 17
    HelpContext = 377006
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Anchors = [akRight, akBottom]
    Caption = 'Active'
    Color = 14867920
    DataField = 'Active'
    DataSource = dsJob
    ParentColor = False
    TabOrder = 6
    OnClick = chkActiveClick
  end
  object btnPrint: TDNMSpeedButton [15]
    Left = 212
    Top = 531
    Width = 87
    Height = 27
    HelpContext = 377007
    Anchors = [akBottom]
    Caption = '&Print'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = btnPrintClick
  end
  object lblPrintName: TStaticText [16]
    Left = 118
    Top = 49
    Width = 625
    Height = 29
    HelpContext = 377480
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Caption = 'lblCompany'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 10
  end
  inherited tmrProcessMessage: TTimer
    Left = 429
    Top = 1
  end
  inherited tmrdelay: TTimer
    Left = 464
    Top = 1
  end
  inherited popSpelling: TPopupMenu
    Left = 85
    Top = 1
  end
  inherited tmrdelayMsg: TTimer
    Left = 51
    Top = 1
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 257
    Top = 1
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 292
    Top = 1
  end
  inherited MyConnection: TERPConnection
    Database = 'wang_developer'
    Connected = True
    Left = 19
    Top = 32
  end
  inherited DataState: TDataState
    Left = 17
    Top = 1
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 120
    Top = 1
  end
  inherited imgsort: TImageList
    Left = 326
    Top = 1
    Bitmap = {
      494C01010200C800A80110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 300
    Top = 89
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 360
    Top = 65535
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 188
    Top = 1
  end
  inherited qryMemTrans: TERPQuery
    Left = 702
    Top = 30
  end
  object qryJob: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblClients WHERE ClientID = :xClientID')
    AutoCalcFields = False
    AfterOpen = qryJobAfterOpen
    AfterInsert = qryJobAfterInsert
    AfterPost = qryJobAfterPost
    OnCalcFields = qryJobCalcFields
    Left = 288
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryJobClientID: TAutoIncField
      FieldName = 'ClientID'
      ReadOnly = True
    end
    object qryJobCompany: TWideStringField
      FieldName = 'Company'
      Size = 80
    end
    object qryJobABN: TWideStringField
      FieldName = 'ABN'
      Size = 15
    end
    object qryJobTitle: TWideStringField
      FieldName = 'Title'
      Size = 32
    end
    object qryJobFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 40
    end
    object qryJobMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Size = 40
    end
    object qryJobLastName: TWideStringField
      FieldName = 'LastName'
      Size = 40
    end
    object qryJobPosition: TWideStringField
      FieldName = 'Position'
      Size = 30
    end
    object qryJobPhone: TWideStringField
      FieldName = 'Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryJobFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      EditMask = '## #### ####;0;_'
    end
    object qryJobMobile: TWideStringField
      FieldName = 'Mobile'
      EditMask = '## #### ####;0;_'
    end
    object qryJobEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
    object qryJobAltContact: TWideStringField
      FieldName = 'AltContact'
      Size = 50
    end
    object qryJobAltPhone: TWideStringField
      FieldName = 'AltPhone'
      EditMask = '## #### ####;0;_'
    end
    object qryJobContact1: TWideStringField
      FieldName = 'Contact1'
      Size = 50
    end
    object qryJobPhoneSupportTill: TDateField
      FieldName = 'PhoneSupportTill'
    end
    object qryJobContact2: TWideStringField
      FieldName = 'Contact2'
      Size = 50
    end
    object qryJobContact1Phone: TWideStringField
      FieldName = 'Contact1Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryJobContact2Phone: TWideStringField
      FieldName = 'Contact2Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryJobNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryJobClientNo: TWideStringField
      FieldName = 'ClientNo'
      Size = 50
    end
    object qryJobClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
    end
    object qryJobMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
    end
    object qryJobTYPE: TWideStringField
      FieldName = 'TYPE'
      Size = 50
    end
    object qryJobTAXID: TIntegerField
      FieldName = 'TAXID'
    end
    object qryJobCreditLimit: TFloatField
      FieldName = 'CreditLimit'
      currency = True
    end
    object qryJobBalance: TFloatField
      FieldName = 'Balance'
    end
    object qryJobTERMS: TWideStringField
      FieldName = 'TERMS'
      Size = 30
    end
    object qryJobTermsID: TIntegerField
      FieldName = 'TermsID'
    end
    object qryJobShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Size = 30
    end
    object qryJobShippingID: TIntegerField
      FieldName = 'ShippingID'
    end
    object qryJobSpecialDiscount: TFloatField
      FieldName = 'SpecialDiscount'
    end
    object qryJobJobName: TWideStringField
      FieldName = 'JobName'
      Size = 39
    end
    object qryJobIsJob: TWideStringField
      FieldName = 'IsJob'
      FixedChar = True
      Size = 1
    end
    object qryJobPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
    end
    object qryJobFeedback: TWideStringField
      FieldName = 'Feedback'
      FixedChar = True
      Size = 1
    end
    object qryJobCustomer: TWideStringField
      FieldName = 'Customer'
      FixedChar = True
      Size = 1
    end
    object qryJobSupplier: TWideStringField
      FieldName = 'Supplier'
      FixedChar = True
      Size = 1
    end
    object qryJobOtherContact: TWideStringField
      FieldName = 'OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryJobOtherContactType: TIntegerField
      FieldName = 'OtherContactType'
    end
    object qryJobRepID: TIntegerField
      FieldName = 'RepID'
      OnChange = qryJobRepIDChange
    end
    object qryJobGlobal: TWideStringField
      FieldName = 'Global'
      FixedChar = True
      Size = 1
    end
    object qryJobDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object qryJobActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryJobEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryJobDontContact: TWideStringField
      FieldName = 'DontContact'
      FixedChar = True
      Size = 1
    end
    object qryJobParentClientID: TIntegerField
      FieldName = 'ParentClientID'
    end
    object qryJobCompletionDate: TDateField
      FieldName = 'CompletionDate'
    end
    object qryJobCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qryJobSecurityLevel: TIntegerField
      FieldName = 'SecurityLevel'
    end
    object qryJobJobNumber: TIntegerField
      FieldName = 'JobNumber'
      OnValidate = qryJobJobNumberValidate
    end
    object qryJobGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryJobUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object qryJobDateInactive: TDateField
      FieldName = 'DateInactive'
    end
    object qryJobSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object qryJobAction: TDateTimeField
      FieldName = 'Action'
    end
    object qryJobDateEntered: TDateField
      FieldName = 'DateEntered'
    end
    object qryJobCorrespondenceMethod: TWideStringField
      FieldName = 'CorrespondenceMethod'
      Size = 30
    end
    object qryJobShipTime: TWordField
      FieldName = 'ShipTime'
    end
    object qryJobGracePeriod: TWordField
      FieldName = 'GracePeriod'
    end
    object qryJobLastContactDate: TDateField
      FieldName = 'LastContactDate'
    end
    object qryJobLoyaltyValue: TFloatField
      FieldName = 'LoyaltyValue'
    end
    object qryJobLastSaleDate: TDateField
      FieldName = 'LastSaleDate'
    end
    object qryJobAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 50
    end
    object qryJobBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Size = 255
    end
    object qryJobBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Size = 7
    end
    object qryJobBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Size = 10
    end
    object qryJobURL: TWideStringField
      FieldName = 'URL'
      Size = 255
    end
    object qryJobCombinedInvoiceBOID: TWideStringField
      FieldName = 'CombinedInvoiceBOID'
      Size = 255
    end
    object qryJobCombinedSaleOrderBOID: TWideStringField
      FieldName = 'CombinedSaleOrderBOID'
      Size = 255
    end
    object qryJobStopCredit: TWideStringField
      FieldName = 'StopCredit'
      FixedChar = True
      Size = 1
    end
    object qryJobRequired: TWideStringField
      FieldName = 'Required'
      FixedChar = True
      Size = 1
    end
    object qryJobForcePOOnBooking: TWideStringField
      FieldName = 'ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object qryJobForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object qryJobPickingPriority: TIntegerField
      FieldName = 'PickingPriority'
    end
    object qryJobDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
    end
    object qryJobRepName: TWideStringField
      FieldName = 'RepName'
      Size = 255
    end
    object qryJobBankCode: TWideStringField
      FieldName = 'BankCode'
      FixedChar = True
      Size = 3
    end
    object qryJobLoyaltyDateSaleDays: TDateField
      FieldName = 'LoyaltyDateSaleDays'
    end
    object qryJobLoyaltyDateAmount: TDateField
      FieldName = 'LoyaltyDateAmount'
    end
    object qryJobLoyaltyDateAppointDays: TDateField
      FieldName = 'LoyaltyDateAppointDays'
    end
    object qryJobStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryJobStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryJobSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object qryJobState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object qryJobCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryJobPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object qryJobBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Size = 255
    end
    object qryJobBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Size = 255
    end
    object qryJobBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Size = 255
    end
    object qryJobBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Size = 255
    end
    object qryJobBillState: TWideStringField
      FieldName = 'BillState'
      Size = 255
    end
    object qryJobBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Size = 255
    end
    object qryJobBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Size = 255
    end
    object qryJobPOBox: TWideStringField
      FieldName = 'POBox'
      Size = 255
    end
    object qryJobPOSuburb: TWideStringField
      FieldName = 'POSuburb'
      Size = 255
    end
    object qryJobPOState: TWideStringField
      FieldName = 'POState'
      Size = 255
    end
    object qryJobPOCountry: TWideStringField
      FieldName = 'POCountry'
      Size = 255
    end
    object qryJobPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Size = 255
    end
    object qryJobCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object qryJobCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object qryJobCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object qryJobCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object qryJobCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qryJobCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object qryJobCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object qryJobCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object qryJobCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object qryJobCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object qryJobCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object qryJobCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object qryJobCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object qryJobCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object qryJobCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object qryJobGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryJobCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object qryJobForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object qryJobDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Size = 255
    end
    object qryJobArea: TWideStringField
      FieldName = 'Area'
    end
    object qryJobDischargeDate: TDateField
      FieldName = 'DischargeDate'
    end
    object qryJobJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryJobUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      FixedChar = True
      Size = 1
    end
    object qryJobInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
    end
    object qryJobApprovalFromDate: TDateTimeField
      FieldName = 'ApprovalFromDate'
    end
    object qryJobApprovalToDate: TDateTimeField
      FieldName = 'ApprovalToDate'
    end
    object qryJobTasks: TWideMemoField
      FieldName = 'Tasks'
      BlobType = ftWideMemo
    end
    object qryJobReminderDateTime: TDateTimeField
      FieldName = 'ReminderDateTime'
      DisplayFormat = 'dd/mm/yyyy hh:nn am/pm'
    end
    object qryJobSpecialInstructions: TWideMemoField
      FieldName = 'SpecialInstructions'
      BlobType = ftWideMemo
    end
    object qryJobSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Size = 255
    end
    object qryJobModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Size = 255
    end
    object qryJobManufacture: TWideStringField
      FieldName = 'Manufacture'
      Size = 255
    end
    object qryJobJobRegistration: TWideStringField
      FieldName = 'JobRegistration'
      Size = 50
    end
    object qryJobHoursTakenForJob: TFloatField
      FieldName = 'HoursTakenForJob'
      Precision = 10
    end
    object qryJobWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
    end
    object qryJobWarrantyPeriod: TFloatField
      FieldName = 'WarrantyPeriod'
    end
    object qryJobCustomerJobNumber: TWideStringField
      FieldName = 'CustomerJobNumber'
    end
    object qryJobhours: TFloatField
      FieldName = 'hours'
    end
    object qryJobLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object qryJobForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object qryJobEmailXML: TWideStringField
      FieldName = 'EmailXML'
      Size = 80
    end
    object qryJobSendXMLInvoices: TWideStringField
      FieldName = 'SendXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qryJobSpecialProductPriceOverridesAll: TWideStringField
      FieldName = 'SpecialProductPriceOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryJobCallPriority: TIntegerField
      FieldName = 'CallPriority'
    end
    object qryJobDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
    end
    object qryJobSkypeName: TWideStringField
      FieldName = 'SkypeName'
      Size = 100
    end
    object qryJobARBalance: TFloatField
      FieldName = 'ARBalance'
    end
    object qryJobAPBalance: TFloatField
      FieldName = 'APBalance'
    end
    object qryJobCombinedPurchaseBOID: TWideStringField
      FieldName = 'CombinedPurchaseBOID'
      Size = 255
    end
    object qryJobDefaultDeliveryTemplateID: TIntegerField
      FieldName = 'DefaultDeliveryTemplateID'
    end
    object qryJobCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
    end
    object qryJobCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
    end
    object qryJobCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
    end
    object qryJobParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
    end
    object qryJobDeliveryNotes: TWideMemoField
      FieldName = 'DeliveryNotes'
      BlobType = ftWideMemo
    end
    object qryJobCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Size = 255
    end
    object qryJobCreditCardExpiryDate: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Size = 255
    end
    object qryJobCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Size = 40
    end
    object qryJobCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Size = 255
    end
    object qryJobCompanyTypeId: TIntegerField
      FieldName = 'CompanyTypeId'
    end
    object qryJobCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Size = 255
    end
    object qryJobmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryJobInvoiceComment: TWideMemoField
      FieldName = 'InvoiceComment'
      BlobType = ftWideMemo
    end
    object qryJobPOComment: TWideMemoField
      FieldName = 'POComment'
      BlobType = ftWideMemo
    end
    object qryJobInvoiceCommentPopup: TWideStringField
      FieldName = 'InvoiceCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qryJobPOCommentPopup: TWideStringField
      FieldName = 'POCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qryJobDefaultPurchaseOrderTemplateID: TIntegerField
      FieldName = 'DefaultPurchaseOrderTemplateID'
    end
    object qryJobIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qryJobShowInShipContainers: TWideStringField
      FieldName = 'ShowInShipContainers'
      FixedChar = True
      Size = 1
    end
    object qryJobForcePOOnRepair: TWideStringField
      FieldName = 'ForcePOOnRepair'
      FixedChar = True
      Size = 1
    end
    object qryJobBPAYBillerCode: TWideStringField
      FieldName = 'BPAYBillerCode'
      Size = 255
    end
    object qryJobBPAYReference: TWideStringField
      FieldName = 'BPAYReference'
      Size = 255
    end
    object qryJobManufactureID: TIntegerField
      FieldName = 'ManufactureID'
    end
    object qryJobPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Size = 100
    end
    object qryJobPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Size = 100
    end
    object qryJobFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Size = 100
    end
    object qryJobIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Size = 100
    end
    object qryJobShippingAgentID: TIntegerField
      FieldName = 'ShippingAgentID'
    end
    object qryJobDefaultStatementTemplateId: TIntegerField
      FieldName = 'DefaultStatementTemplateId'
    end
    object qryJobTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object qryJobInsuranceCompanyName: TWideStringField
      FieldName = 'InsuranceCompanyName'
      Size = 255
    end
    object qryJobClaimNumber: TWideStringField
      FieldName = 'ClaimNumber'
      Size = 255
    end
    object qryJobStormLocation: TWideStringField
      FieldName = 'StormLocation'
      Size = 255
    end
    object qryJobStormDate: TDateField
      FieldName = 'StormDate'
    end
    object qryJobYear: TDateField
      FieldName = 'Year'
    end
    object qryJobColour: TWideStringField
      FieldName = 'Colour'
      Size = 255
    end
    object qryJobBodyType: TWideStringField
      FieldName = 'BodyType'
      Size = 255
    end
    object qryJobAssessorsName: TWideStringField
      FieldName = 'AssessorsName'
      Size = 255
    end
    object qryJobExcessAmount: TFloatField
      FieldName = 'ExcessAmount'
      currency = True
    end
    object qryJobBailmentNumber: TWideStringField
      FieldName = 'BailmentNumber'
      Size = 255
    end
    object qryJobBailmentAmountEx: TFloatField
      FieldName = 'BailmentAmountEx'
      currency = True
    end
    object qryJobStockReceivedDate: TDateField
      FieldName = 'StockReceivedDate'
    end
    object qryJobNewOrUsed: TWideStringField
      FieldName = 'NewOrUsed'
      Size = 255
    end
    object qryJobDocumentPath: TWideStringField
      FieldName = 'DocumentPath'
      Size = 255
    end
    object qryJobcDocumentPath: TStringField
      FieldKind = fkCalculated
      FieldName = 'cDocumentPath'
      Size = 255
      Calculated = True
    end
    object qryJobExpiryDate: TDateField
      FieldName = 'ExpiryDate'
    end
    object qryJobPrintName: TWideStringField
      FieldName = 'PrintName'
      Size = 255
    end
    object qryJobPrintJobName: TWideStringField
      FieldName = 'PrintJobName'
      Size = 255
    end
    object qryJobBurden: TIntegerField
      FieldName = 'Burden'
    end
    object qryJobAccount1ID: TIntegerField
      FieldName = 'Account1ID'
    end
    object qryJobAccount1Name: TWideStringField
      FieldName = 'Account1Name'
      Size = 50
    end
    object qryJobAccount2ID: TIntegerField
      FieldName = 'Account2ID'
    end
    object qryJobAccount2Name: TWideStringField
      FieldName = 'Account2Name'
      Size = 50
    end
    object qryJobStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryJobDiscount: TFloatField
      FieldName = 'Discount'
    end
  end
  object dsJob: TDataSource
    DataSet = qryJob
    Left = 55
    Top = 61
  end
  object memQryJob: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ClientID'
        DataType = ftAutoInc
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'ABN'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Title'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'MiddleName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'LastName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Position'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Street'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Street2'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Suburb'
        DataType = ftString
        Size = 27
      end
      item
        Name = 'State'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Postcode'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'BillStreet'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'BillStreet2'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'BillSuburb'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'BillState'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BillCountry'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BillPostcode'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'POBox'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POSuburb'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POState'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POCountry'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'POPostcode'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FaxNumber'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Mobile'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Email'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'AltContact'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AltPhone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Contact1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PhoneSupportTill'
        DataType = ftDate
      end
      item
        Name = 'Contact2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Contact1Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Contact2Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'ClientNo'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ClientTypeID'
        DataType = ftInteger
      end
      item
        Name = 'MedTypeID'
        DataType = ftInteger
      end
      item
        Name = 'TYPE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TAXID'
        DataType = ftInteger
      end
      item
        Name = 'CreditLimit'
        DataType = ftFloat
      end
      item
        Name = 'Balance'
        DataType = ftFloat
      end
      item
        Name = 'TERMS'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'TermsID'
        DataType = ftInteger
      end
      item
        Name = 'ShippingMethod'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShippingID'
        DataType = ftInteger
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'SpecialDiscount'
        DataType = ftFloat
      end
      item
        Name = 'JobName'
        DataType = ftString
        Size = 39
      end
      item
        Name = 'IsJob'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CUSTFLD1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD3'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD4'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD5'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD6'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD7'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD8'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD9'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD10'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD11'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD12'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD13'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD14'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD15'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PayMethodID'
        DataType = ftInteger
      end
      item
        Name = 'Feedback'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Customer'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Supplier'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'OtherContact'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'OtherContactType'
        DataType = ftInteger
      end
      item
        Name = 'RepID'
        DataType = ftInteger
      end
      item
        Name = 'Global'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Done'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Active'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'EditedFlag'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DontContact'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ParentClientID'
        DataType = ftInteger
      end
      item
        Name = 'CompletionDate'
        DataType = ftDate
      end
      item
        Name = 'CreationDate'
        DataType = ftDate
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 498
    Top = 1
  end
  object memqryContacts: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 636
    Top = 1
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT * , Concat_Ws('#39' '#39',ContactFirstName,ContactSurName) AS Con' +
        'tactName'
      'FROM tblContacts'
      'WHERE ClientID = :CusID;')
    AfterOpen = qryContactsAfterOpen
    Left = 236
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object qryContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryContactsContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object qryContactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object qryContactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object qryContactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object qryContactsIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 61
    end
    object qryContactsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object qryContactsContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object qryContactsContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object qryContactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object qryContactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object qryContactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object qryContactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object qryContactsContactState: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object qryContactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object qryContactsContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object qryContactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object qryContactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object qryContactsJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryContactsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryContactsClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 255
    end
  end
  object qryDocuments: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'tblReference.RefID, '
      'tblReference.Ref_Date, '
      'tblReference.Ref_type,'
      'tblReference.Referencetxt, '
      'tblReference.CusID, '
      'tblReference.ContactID,'
      
        'Concat_WS('#39' '#39',tblContacts.ContactFirstName,tblContacts.ContactSu' +
        'rname) as Contact,'
      'tblReference.EditedFlag,'
      'tblReference.active,'
      'tblReference.MessageId,'
      'tblReference.ReferenceData,'
      'tblReference.MessageFrom,'
      'tblReference.MessageTo'
      'FROM tblReference'
      'LEFT JOIN tblClients'
      'ON tblReference.CusID=tblClients.ClientID'
      'LEFT JOIN tblContacts'
      'ON tblReference.ContactID=tblContacts.ContactID'
      'WHERE tblReference.CusID=:CusID'
      'ORDER BY tblReference.Ref_Date DESC;')
    Filtered = True
    Filter = 'Active ='#39'T'#39
    Left = 344
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
  end
  object DSContacts: TDataSource
    DataSet = qryContacts
    Left = 235
    Top = 61
  end
  object DSDocuments: TDataSource
    DataSet = qryDocuments
    Left = 343
    Top = 61
  end
  object WordApplication1: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 567
    Top = 1
  end
  object qryCustomerServices: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT CustomerServicesID, ClientID, EmployeeID, ServiceID, Rati' +
        'ngID, EditedFlag'
      'FROM tblCustomerServices'
      'WHERE ClientID =:xClientID'
      'ORDER BY ServiceID')
    BeforePost = qryCustomerServicesBeforePost
    Left = 416
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryCustomerServicesRepLookup: TWideStringField
      DisplayLabel = 'Rep'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'RepLookup'
      LookupDataSet = qryEmployees
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Size = 80
      Lookup = True
    end
    object qryCustomerServicesServiceLookup: TWideStringField
      DisplayLabel = 'Service'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'ServiceLookup'
      LookupDataSet = qryServices
      LookupKeyFields = 'ServiceID'
      LookupResultField = 'ServiceDesc'
      KeyFields = 'ServiceID'
      Size = 80
      Lookup = True
    end
    object qryCustomerServicesRatingLookup: TWideStringField
      DisplayLabel = 'Rating'
      DisplayWidth = 18
      FieldKind = fkLookup
      FieldName = 'RatingLookup'
      LookupDataSet = qryRating
      LookupKeyFields = 'RatingID'
      LookupResultField = 'RatingDesc'
      KeyFields = 'RatingID'
      Size = 25
      Lookup = True
    end
    object qryCustomerServicesCustomerServicesID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'CustomerServicesID'
      ReadOnly = True
      Visible = False
    end
    object qryCustomerServicesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryCustomerServicesServiceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ServiceID'
      Visible = False
    end
    object qryCustomerServicesRatingID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RatingID'
      Visible = False
    end
    object qryCustomerServicesEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryCustomerServicesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
  end
  object dsCustomerServices: TDataSource
    DataSet = qryCustomerServices
    Left = 415
    Top = 61
  end
  object qryReferrals: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ReferralID, ClientID, ReferredClientID, EditedFlag'
      'FROM tblReferrals'
      'WHERE ClientID = :xClientID')
    BeforePost = qryReferralsBeforePost
    Left = 272
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryReferralsReferralID: TAutoIncField
      FieldName = 'ReferralID'
      ReadOnly = True
    end
    object qryReferralsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryReferralsReferredClientID: TIntegerField
      FieldName = 'ReferredClientID'
    end
    object qryReferralsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryReferralsCompanyLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'CompanyLookup'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ReferredClientID'
      Size = 80
      Lookup = True
    end
    object qryReferralsPhoneLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'PhoneLookup'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Phone'
      KeyFields = 'ReferredClientID'
      EditMask = '## #### ####;0;_'
      Size = 25
      Lookup = True
    end
    object qryReferralsFaxLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'FaxLookup'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'FaxNumber'
      KeyFields = 'ReferredClientID'
      EditMask = '## #### ####;0;_'
      Size = 25
      Lookup = True
    end
  end
  object dsReferrals: TDataSource
    DataSet = qryReferrals
    Left = 271
    Top = 61
  end
  object ActionList1: TActionList
    Left = 154
    Top = 1
    object actReferralsPrint: TAction
      Caption = 'Letters'
      HelpContext = 377401
      OnExecute = actReferralsPrintExecute
      OnUpdate = actReferralsPrintUpdate
    end
    object actRepeat: TAction
      Caption = '&Repeat'
      HelpContext = 377402
      OnExecute = actRepeatExecute
      OnUpdate = actRepeatUpdate
    end
    object actServiceCycle: TAction
      Caption = 'Service C&ycle'
      HelpContext = 377403
      OnExecute = actServiceCycleExecute
      OnUpdate = actServiceCycleUpdate
    end
  end
  object EquipNotesDialog1: TwwMemoDialog
    DataField = 'Notes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    OnUserButton1Click = EquipNotesDialog1UserButton1Click
    UserButton1Caption = 'Add Date'
    Left = 223
    Top = 1
  end
  object qryCarePlan: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblClientCarePlan'
      'Where ClientID = :xClientID;')
    BeforePost = qryCarePlanBeforePost
    Left = 308
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryCarePlanServiceDesc: TWideStringField
      DisplayWidth = 20
      FieldName = 'ServiceDesc'
      Size = 255
    end
    object qryCarePlanSundayFromTime: TDateTimeField
      DisplayLabel = 'From'
      DisplayWidth = 18
      FieldName = 'SundayFromTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanSundayToTime: TDateTimeField
      DisplayLabel = 'To'
      DisplayWidth = 18
      FieldName = 'SundayToTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanMondayFromTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'MondayFromTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanMondayToTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'MondayToTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanTuesdayFromTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'TuesdayFromTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanTuesdayToTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'TuesdayToTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanWednesdayFromTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'WednesdayFromTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanWednesdayToTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'WednesdayToTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanThursdayFromTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ThursdayFromTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanThursdayToTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ThursdayToTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanFridayFromTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'FridayFromTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanFridayToTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'FridayToTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanSaturdayFromTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'SaturdayFromTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanSaturdayToTime: TDateTimeField
      DisplayWidth = 18
      FieldName = 'SaturdayToTime'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryCarePlanGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryCarePlanClientCarePlanID: TAutoIncField
      FieldName = 'ClientCarePlanID'
      ReadOnly = True
      Visible = False
    end
    object qryCarePlanClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object qryCarePlanServiceID: TIntegerField
      FieldName = 'ServiceID'
      Visible = False
    end
    object qryCarePlanEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object DSCarePlan: TDataSource
    DataSet = qryCarePlan
    Left = 307
    Top = 61
  end
  object tbOtherFollowUp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblotherfollowup'
      'WHERE ClientID= :xClientID;')
    AfterOpen = tbOtherFollowUpAfterOpen
    BeforePost = tbOtherFollowUpBeforePost
    Left = 92
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object tbOtherFollowUpFollowUpDate: TDateTimeField
      DisplayLabel = 'Follow Up Date'
      DisplayWidth = 12
      FieldName = 'FollowUpDate'
    end
    object tbOtherFollowUpEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = qryEmployees
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Size = 30
      Lookup = True
    end
    object tbOtherFollowUpHours: TFloatField
      DisplayWidth = 9
      FieldName = 'Hours'
    end
    object tbOtherFollowUpDone: TWideStringField
      DisplayWidth = 4
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpEmployeeID: TIntegerField
      DisplayLabel = 'Employee'
      DisplayWidth = 13
      FieldName = 'EmployeeID'
      Visible = False
    end
    object tbOtherFollowUpFollowUpID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FollowUpID'
      ReadOnly = True
      Visible = False
    end
    object tbOtherFollowUpOtherContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'OtherContactID'
      Visible = False
    end
    object tbOtherFollowUpRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Visible = False
    end
    object tbOtherFollowUpEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpAppearDays: TIntegerField
      DisplayWidth = 10
      FieldName = 'AppearDays'
      Visible = False
    end
    object tbOtherFollowUpCreationDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CreationDate'
      Visible = False
    end
    object tbOtherFollowUpClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object tbOtherFollowUpIsSupplier: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsSupplier'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsOtherContact: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsOtherContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsCustomer: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tbOtherFollowUpUpdateDate: TDateField
      DisplayWidth = 10
      FieldName = 'UpdateDate'
      Visible = False
    end
    object tbOtherFollowUpNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
  end
  object memtbOtherFollowUp: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 532
    Top = 1
  end
  object dsOtherFollowUp: TDataSource
    DataSet = tbOtherFollowUp
    Left = 91
    Top = 61
  end
  object qryClients: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, Phone, FaxNumber'
      'FROM tblClients WHERE Active = '#39'T'#39
      'ORDER BY Company;')
    Options.LongStrings = False
    Left = 651
    Top = 89
  end
  object qryDocPath: TERPQuery
    SQL.Strings = (
      'Select DPID, DocumentPath '
      'FROM tblDocPath;')
    Options.LongStrings = False
    Left = 686
    Top = 89
  end
  object qrySuburb: TERPQuery
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country'
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub;')
    BeforeOpen = qrySuburbBeforeOpen
    Options.LongStrings = False
    Left = 483
    Top = 30
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryEmployees: TERPQuery
    SQL.Strings = (
      
        'SELECT E.EmployeeID, Concat(E.FirstName,'#39' '#39',E.LastName) AS Emplo' +
        'yeeName'
      'FROM tblEmployees AS E'
      'WHERE E.Active = '#39'T'#39
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 476
    Top = 89
  end
  object qrySource: TERPQuery
    SQL.Strings = (
      'SELECT MedTypeID, MediaType FROM tblSource '
      'WHERE Active = '#39'T'#39
      'ORDER By MediaType;')
    Options.LongStrings = False
    Left = 47
    Top = 89
  end
  object qryServices: TERPQuery
    SQL.Strings = (
      'SELECT ServiceID, ServiceDesc FROM tblServices'
      'WHERE Active = '#39'T'#39';')
    Options.LongStrings = False
    Left = 335
    Top = 89
  end
  object qryRating: TERPQuery
    SQL.Strings = (
      'SELECT RatingID, RatingDesc'
      'FROM tblcustomerservicesratings;')
    Options.LongStrings = False
    Left = 265
    Top = 89
  end
  object qryEmpID: TERPQuery
    SQL.Strings = (
      
        'SELECT EmployeeID, Concat(Firstname, '#39' '#39', LastName) AS EmployeeN' +
        'ame,'
      ' Active, AreaRange'
      'FROM tblEmployees '
      'WHERE Concat(Firstname, '#39' '#39', LastName)>" " And Active<>'#39'F'#39
      'ORDER BY Concat(Firstname, '#39' '#39', LastName); ')
    Options.LongStrings = False
    Left = 195
    Top = 89
  end
  object qryMediaType: TERPQuery
    SQL.Strings = (
      
        'SELECT  tblSource.MedTypeID, tblSource.MediaType, tblSource.Acti' +
        've '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType; ')
    Options.LongStrings = False
    Left = 160
    Top = 89
  end
  object qryInvoiceTemplates: TERPQuery
    SQL.Strings = (
      
        'SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TypeID` = '#39 +
        '11'#39';')
    Options.LongStrings = False
    Left = 791
    Top = 89
  end
  object qryPayMethod: TERPQuery
    SQL.Strings = (
      
        'SELECT PayMethodID, Name, IsCreditCard FROM tblpaymentmethods wh' +
        'ere Active ="T";')
    Options.LongStrings = False
    Left = 756
    Top = 89
  end
  object qryShipping: TERPQuery
    SQL.Strings = (
      
        'SELECT tblShippingMethods.ShippingMethodID, tblShippingMethods.S' +
        'hippingMethod '
      'FROM tblShippingMethods '
      
        'GROUP BY tblShippingMethods.ShippingMethodID, tblShippingMethods' +
        '.ShippingMethod '
      'ORDER BY tblShippingMethods.ShippingMethod; ')
    Options.LongStrings = False
    Left = 639
    Top = 30
  end
  object qryClientTypes: TERPQuery
    SQL.Strings = (
      'SELECT ClientTypeID, TypeName, TypeDescription ,'
      ' TermsID, CreditLimit,GracePeriod'
      'FROM tblClientType'
      'WHERE Active = '#39'T'#39
      'Order By TypeName;')
    Options.LongStrings = False
    Left = 608
    Top = 30
  end
  object qryTaxCodes: TERPQuery
    SQL.Strings = (
      'Select TaxCodeID, Name, Description, Rate'
      'From tblTaxCodes '
      'Where Active = "T" AND  RegionID= :xRegionID;')
    BeforeOpen = qryTaxCodesBeforeOpen
    Options.LongStrings = False
    Left = 545
    Top = 30
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryTerms: TERPQuery
    SQL.Strings = (
      'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.Active '
      
        'FROM tblTerms WHERE (((tblTerms.Terms)>" ") And ((tblTerms.Activ' +
        'e)<>'#39'F'#39')) '
      'ORDER BY tblTerms.Terms; ')
    Options.LongStrings = False
    Left = 514
    Top = 30
  end
  object cboServiceIDQry: TERPQuery
    SQL.Strings = (
      'SELECT tblServices.ServiceID,'
      'tblServices.ServiceDesc As '#39'ServiceDescription'#39
      'FROM tblServices;')
    Options.LongStrings = False
    Left = 721
    Top = 89
  end
  object qryCustomFields: TERPQuery
    SQL.Strings = (
      'SELECT'
      'CFLabel1,CFCust1, CFEmpl1, CFSupp1, CFLabel2,'
      'CFCust2, CFEmpl2, CFSupp2, CFLabel3, CFCust3, CFEmpl3,'
      'CFSupp3, CFLabel4, CFCust4, CFEmpl4, CFSupp4, CFLabel5,'
      'CFCust5, CFEmpl5, CFSupp5, CFLabel6, CFCust6, CFEmpl6,'
      'CFSupp6, CFLabel7, CFCust7, CFEmpl7, CFSupp7, CFLabel8,'
      'CFCust8, CFEmpl8, CFSupp8, CFLabel9, CFCust9, CFEmpl9,'
      'CFSupp9, CFLabel10, CFCust10, CFEmpl10, CFSupp10, CFLabel11,'
      ' CFCust11, CFEmpl11, CFSupp11, CFLabel12, CFCust12, CFEmpl12,'
      'CFSupp12, CFLabel13, CFCust13, CFEmpl13, CFSupp13, CFLabel14,'
      'CFCust14, CFEmpl14, CFSupp14, CFLabel15, CFCust15, CFEmpl15,'
      
        ' CFSupp15, EditedFlag, CFOthr1, CFOthr2, CFOthr3, CFOthr4, CFOth' +
        'r5,'
      
        'CFOthr6, CFOthr7, CFOthr8, CFOthr9, CFOthr10, CFOthr11, CFOthr12' +
        ','
      'CFOthr13, CFOthr14, CFOthr15,'
      'CFIsCombo1, CFIsCombo2, CFIsCombo3, CFIsCombo4, CFIsCombo5,'
      'CFIsCombo6, CFIsCombo7, CFIsCombo8, CFIsCombo9, CFIsCombo10,'
      'CFIsCombo11, CFIsCombo12, CFIsCombo13, CFIsCombo14, CFIsCombo15'
      'FROM tblcustomfields;')
    Options.LongStrings = False
    Left = 577
    Top = 30
  end
  object qryRep: TERPQuery
    SQL.Strings = (
      
        'SELECT EmployeeID, Concat_WS( '#39' '#39',FirstName, LastName) as '#39'Name'#39 +
        ' '
      'FROM tblEmployees WHERE Active = '#39'T'#39
      'Order By FirstName;')
    Options.LongStrings = False
    Left = 511
    Top = 89
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT C.ClassID, C.ClassName '
      'FROM tblClass AS C'
      'WHERE C.Active='#39'T'#39
      'ORDER BY C.ClassName; ')
    Options.LongStrings = False
    Left = 441
    Top = 89
    object cboClassQryClassID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClassID'
      Origin = 'tblClass.ClassID'
    end
    object cboClassQryClassName: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 20
      FieldName = 'ClassName'
      Origin = 'tblClass.ClassName'
      Size = 60
    end
  end
  object qryJobcards: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select  ID,ClientID'#9', EmployeeId , Notes, TemplateId    from tbl' +
        'Customerjobcards '
      'Where ClientID'#9' = :XClientID')
    AutoCalcFields = False
    AfterOpen = qryJobAfterOpen
    AfterInsert = qryJobcardsAfterInsert
    BeforePost = qryJobcardsBeforePost
    Left = 200
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'XClientID'
      end>
    object qryJobcardsEmployeeName: TWideStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = qryEmpLookup
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeId'
      Lookup = True
    end
    object qryJobcardsNotes: TWideStringField
      DisplayWidth = 60
      FieldName = 'Notes'
      Size = 255
    end
    object qryJobcardsEmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeId'
      Visible = False
    end
    object qryJobcardsClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryJobcardsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qryJobcardsTemplateId: TIntegerField
      FieldName = 'TemplateId'
    end
    object qryJobcardsTemplateName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'TemplateName'
      LookupDataSet = qryTemplate
      LookupKeyFields = 'TemplID'
      LookupResultField = 'TemplName'
      KeyFields = 'TemplateId'
      Size = 100
      Lookup = True
    end
  end
  object wa: TDataSource
    DataSet = qryJobcards
    Left = 199
    Top = 61
  end
  object qryEmpLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT E.EmployeeID, '
      'Concat(E.FirstName,'#39' '#39',E.LastName) AS EmployeeName , '
      'DefaultInvoiceTemplateID'
      'FROM tblEmployees AS E'
      'WHERE E.Active = '#39'T'#39
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Filtered = True
    AfterOpen = qryJobAfterOpen
    Left = 370
    Top = 89
    object qryEmpLookupEmployeeName: TWideStringField
      DisplayWidth = 81
      FieldName = 'EmployeeName'
      ReadOnly = True
      Size = 81
    end
    object qryEmpLookupEmployeeID: TAutoIncField
      FieldName = 'EmployeeID'
      ReadOnly = True
      Visible = False
    end
    object qryEmpLookupDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
    end
  end
  object qryTemplate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TemplID,TemplName FROM tbltemplates  '
      'WHERE TypeID = 64;')
    AutoCalcFields = False
    Filtered = True
    Filter = 'TemplId = 3120'
    AfterOpen = qryJobAfterOpen
    Left = 230
    Top = 89
    object qryTemplateTemplName: TWideStringField
      DisplayWidth = 30
      FieldName = 'TemplName'
      Size = 30
    end
    object qryTemplateTemplID: TAutoIncField
      FieldName = 'TemplID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryCustomer: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblClients '
      'WHERE isJob <> '#39'T'#39'  AND Active = '#39'T'#39'  AND Customer = '#39'T'#39
      'ORDER BY Company ')
    Left = 405
    Top = 89
    object qryCustomerCompany: TWideStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Size = 80
    end
    object qryCustomerclientID: TAutoIncField
      FieldName = 'clientID'
      ReadOnly = True
      Visible = False
    end
    object qryCustomerGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryCustomerClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
    end
    object qryCustomerABN: TWideStringField
      FieldName = 'ABN'
      Size = 15
    end
    object qryCustomerTitle: TWideStringField
      FieldName = 'Title'
      Size = 32
    end
    object qryCustomerFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 40
    end
    object qryCustomerMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Size = 40
    end
    object qryCustomerLastName: TWideStringField
      FieldName = 'LastName'
      Size = 40
    end
    object qryCustomerPosition: TWideStringField
      FieldName = 'Position'
      Size = 30
    end
    object qryCustomerStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryCustomerStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryCustomerSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object qryCustomerState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object qryCustomerCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryCustomerPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object qryCustomerBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Size = 255
    end
    object qryCustomerBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Size = 255
    end
    object qryCustomerBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Size = 255
    end
    object qryCustomerBillState: TWideStringField
      FieldName = 'BillState'
      Size = 255
    end
    object qryCustomerBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Size = 255
    end
    object qryCustomerBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Size = 255
    end
    object qryCustomerPOBox: TWideStringField
      FieldName = 'POBox'
      Size = 255
    end
    object qryCustomerPOSuburb: TWideStringField
      FieldName = 'POSuburb'
      Size = 255
    end
    object qryCustomerPOState: TWideStringField
      FieldName = 'POState'
      Size = 255
    end
    object qryCustomerPOCountry: TWideStringField
      FieldName = 'POCountry'
      Size = 255
    end
    object qryCustomerPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Size = 255
    end
    object qryCustomerPhone: TWideStringField
      FieldName = 'Phone'
    end
    object qryCustomerFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
    end
    object qryCustomerMobile: TWideStringField
      FieldName = 'Mobile'
    end
    object qryCustomerEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
    object qryCustomerAltContact: TWideStringField
      FieldName = 'AltContact'
      Size = 50
    end
    object qryCustomerAltPhone: TWideStringField
      FieldName = 'AltPhone'
    end
    object qryCustomerPhoneSupportTill: TDateField
      FieldName = 'PhoneSupportTill'
    end
    object qryCustomerContact1: TWideStringField
      FieldName = 'Contact1'
      Size = 50
    end
    object qryCustomerContact2: TWideStringField
      FieldName = 'Contact2'
      Size = 50
    end
    object qryCustomerContact1Phone: TWideStringField
      FieldName = 'Contact1Phone'
    end
    object qryCustomerContact2Phone: TWideStringField
      FieldName = 'Contact2Phone'
    end
    object qryCustomerCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qryCustomerUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object qryCustomerDateInactive: TDateField
      FieldName = 'DateInactive'
    end
    object qryCustomerNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryCustomerClientNo: TWideStringField
      FieldName = 'ClientNo'
      Size = 50
    end
    object qryCustomerMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
    end
    object qryCustomerTYPE: TWideStringField
      FieldName = 'TYPE'
      Size = 50
    end
    object qryCustomerTAXID: TIntegerField
      FieldName = 'TAXID'
    end
    object qryCustomerCreditLimit: TFloatField
      FieldName = 'CreditLimit'
    end
    object qryCustomerBalance: TFloatField
      FieldName = 'Balance'
    end
    object qryCustomerSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object qryCustomerTERMS: TWideStringField
      FieldName = 'TERMS'
      Size = 30
    end
    object qryCustomerTermsID: TIntegerField
      FieldName = 'TermsID'
    end
    object qryCustomerShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Size = 30
    end
    object qryCustomerShippingID: TIntegerField
      FieldName = 'ShippingID'
    end
    object qryCustomerDiscount: TFloatField
      FieldName = 'Discount'
    end
    object qryCustomerSpecialDiscount: TFloatField
      FieldName = 'SpecialDiscount'
    end
    object qryCustomerJobName: TWideStringField
      FieldName = 'JobName'
      Size = 39
    end
    object qryCustomerJobRegistration: TWideStringField
      FieldName = 'JobRegistration'
      Size = 50
    end
    object qryCustomerWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
    end
    object qryCustomerHoursTakenForJob: TFloatField
      FieldName = 'HoursTakenForJob'
      Precision = 10
    end
    object qryCustomerIsJob: TWideStringField
      FieldName = 'IsJob'
      FixedChar = True
      Size = 1
    end
    object qryCustomerCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object qryCustomerCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object qryCustomerCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object qryCustomerCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object qryCustomerCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qryCustomerCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object qryCustomerCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object qryCustomerCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object qryCustomerCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object qryCustomerCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object qryCustomerCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object qryCustomerCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object qryCustomerCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object qryCustomerCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object qryCustomerCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object qryCustomerPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
    end
    object qryCustomerFeedback: TWideStringField
      FieldName = 'Feedback'
      FixedChar = True
      Size = 1
    end
    object qryCustomerCustomer: TWideStringField
      FieldName = 'Customer'
      FixedChar = True
      Size = 1
    end
    object qryCustomerSupplier: TWideStringField
      FieldName = 'Supplier'
      FixedChar = True
      Size = 1
    end
    object qryCustomerOtherContact: TWideStringField
      FieldName = 'OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryCustomerOtherContactType: TIntegerField
      FieldName = 'OtherContactType'
    end
    object qryCustomerRepID: TIntegerField
      FieldName = 'RepID'
    end
    object qryCustomerRepName: TWideStringField
      FieldName = 'RepName'
      Size = 255
    end
    object qryCustomerAction: TDateTimeField
      FieldName = 'Action'
    end
    object qryCustomerGlobal: TWideStringField
      FieldName = 'Global'
      FixedChar = True
      Size = 1
    end
    object qryCustomerDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object qryCustomerDateEntered: TDateField
      FieldName = 'DateEntered'
    end
    object qryCustomerActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryCustomerEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryCustomerCorrespondenceMethod: TWideStringField
      FieldName = 'CorrespondenceMethod'
      Size = 30
    end
    object qryCustomerDontContact: TWideStringField
      FieldName = 'DontContact'
      FixedChar = True
      Size = 1
    end
    object qryCustomerCompletionDate: TDateField
      FieldName = 'CompletionDate'
    end
    object qryCustomerParentClientID: TIntegerField
      FieldName = 'ParentClientID'
    end
    object qryCustomerShipTime: TWordField
      FieldName = 'ShipTime'
    end
    object qryCustomerGracePeriod: TWordField
      FieldName = 'GracePeriod'
    end
    object qryCustomerLastContactDate: TDateField
      FieldName = 'LastContactDate'
    end
    object qryCustomerLoyaltyValue: TFloatField
      FieldName = 'LoyaltyValue'
    end
    object qryCustomerLastSaleDate: TDateField
      FieldName = 'LastSaleDate'
    end
    object qryCustomerAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 50
    end
    object qryCustomerBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Size = 255
    end
    object qryCustomerBankCode: TWideStringField
      FieldName = 'BankCode'
      FixedChar = True
      Size = 3
    end
    object qryCustomerBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Size = 7
    end
    object qryCustomerBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Size = 10
    end
    object qryCustomerURL: TWideStringField
      FieldName = 'URL'
      Size = 255
    end
    object qryCustomerCombinedInvoiceBOID: TWideStringField
      FieldName = 'CombinedInvoiceBOID'
      Size = 255
    end
    object qryCustomerCombinedSaleOrderBOID: TWideStringField
      FieldName = 'CombinedSaleOrderBOID'
      Size = 255
    end
    object qryCustomerStopCredit: TWideStringField
      FieldName = 'StopCredit'
      FixedChar = True
      Size = 1
    end
    object qryCustomerRequired: TWideStringField
      FieldName = 'Required'
      FixedChar = True
      Size = 1
    end
    object qryCustomerSecurityLevel: TIntegerField
      FieldName = 'SecurityLevel'
    end
    object qryCustomerForcePOOnBooking: TWideStringField
      FieldName = 'ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object qryCustomerForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object qryCustomerPickingPriority: TIntegerField
      FieldName = 'PickingPriority'
    end
    object qryCustomerJobNumber: TIntegerField
      FieldName = 'JobNumber'
    end
    object qryCustomerDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
    end
    object qryCustomerLoyaltyDateSaleDays: TDateField
      FieldName = 'LoyaltyDateSaleDays'
    end
    object qryCustomerLoyaltyDateAmount: TDateField
      FieldName = 'LoyaltyDateAmount'
    end
    object qryCustomerLoyaltyDateAppointDays: TDateField
      FieldName = 'LoyaltyDateAppointDays'
    end
    object qryCustomerGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryCustomerForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object qryCustomerCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object qryCustomerDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Size = 255
    end
    object qryCustomerArea: TWideStringField
      FieldName = 'Area'
    end
    object qryCustomerDischargeDate: TDateField
      FieldName = 'DischargeDate'
    end
    object qryCustomerJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryCustomerUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      FixedChar = True
      Size = 1
    end
    object qryCustomerInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
    end
    object qryCustomerApprovalFromDate: TDateTimeField
      FieldName = 'ApprovalFromDate'
    end
    object qryCustomerApprovalToDate: TDateTimeField
      FieldName = 'ApprovalToDate'
    end
    object qryCustomerTasks: TWideMemoField
      FieldName = 'Tasks'
      BlobType = ftWideMemo
    end
    object qryCustomerReminderDateTime: TDateTimeField
      FieldName = 'ReminderDateTime'
    end
    object qryCustomerSpecialInstructions: TWideMemoField
      FieldName = 'SpecialInstructions'
      BlobType = ftWideMemo
    end
    object qryCustomerCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
    end
    object qryCustomerCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
    end
    object qryCustomerCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
    end
    object qryCustomerSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Size = 255
    end
    object qryCustomerModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Size = 255
    end
    object qryCustomerManufacture: TWideStringField
      FieldName = 'Manufacture'
      Size = 255
    end
    object qryCustomerParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
    end
    object qryCustomerDeliveryNotes: TWideMemoField
      FieldName = 'DeliveryNotes'
      BlobType = ftWideMemo
    end
    object qryCustomerDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Size = 255
    end
    object qryCustomerCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Size = 255
    end
    object qryCustomerCreditCardExpiryDate: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Size = 255
    end
    object qryCustomerCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Size = 40
    end
    object qryCustomerCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Size = 255
    end
    object qryCustomerCompanyTypeId: TIntegerField
      FieldName = 'CompanyTypeId'
    end
    object qryCustomerCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Size = 255
    end
    object qryCustomerLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object qryCustomermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryCustomerWarrantyPeriod: TFloatField
      FieldName = 'WarrantyPeriod'
    end
  end
  object qryModel: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select Id, Name from tblModel where Active = '#39'T'#39' order by Name')
    Options.LongStrings = False
    Left = 452
    Top = 30
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
  object qryManufacture: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select ID, Name from tblManufacture where Active = '#39'T'#39' order by ' +
        'Name')
    Options.LongStrings = False
    Left = 90
    Top = 89
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
  object qryInsuranceCompanyLookup: TERPQuery
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
    Left = 616
    Top = 89
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
  object qrySpecials: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT CustomerLinesID, CustomerId,ProductID, LinePrice, OrigPri' +
        'ce,'
      'Name, Description, EditedFlag, IncludeInRun '
      'FROM tblCustomerLines'
      'Where CustomerID = :CusID'
      'ORDER BY ProductID')
    AfterOpen = qrySpecialsAfterOpen
    AfterInsert = qrySpecialsAfterInsert
    AfterPost = qrySpecialsAfterPost
    Left = 128
    Top = 32
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CusID'
      end>
    object qrySpecialsName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Origin = 'tblCustomerLines.Name'
      OnChange = qrySpecialsNameChange
      Size = 40
    end
    object qrySpecialsDescription: TWideStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblCustomerLines.Description'
      Size = 255
    end
    object qrySpecialsOrigPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'OrigPrice'
      Origin = 'tblCustomerLines.OrigPrice'
      currency = True
    end
    object qrySpecialsLinePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Origin = 'tblCustomerLines.LinePrice'
      currency = True
    end
    object qrySpecialsCustomerLinesID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'CustomerLinesID'
      Origin = 'tblCustomerLines.CustomerLinesID'
      ReadOnly = True
      Visible = False
    end
    object qrySpecialsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblCustomerLines.ProductID'
      Visible = False
    end
    object qrySpecialsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblCustomerLines.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySpecialsCustomerId: TIntegerField
      FieldName = 'CustomerId'
      Origin = 'tblCustomerLines.CustomerId'
    end
  end
  object DSSpecials: TDataSource
    DataSet = qrySpecials
    Left = 127
    Top = 61
  end
  object qryProdGroupDiscs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT GrpDiscID, ClientID, Col1, Col2, Col3, Discount '
      'FROM tblprodgroupdiscs'
      'WHERE ClientID=:xClientID')
    BeforeOpen = qryProdGroupDiscsBeforeOpen
    AfterOpen = qryProdGroupDiscsAfterOpen
    AfterInsert = qryProdGroupDiscsAfterInsert
    BeforePost = qryProdGroupDiscsBeforePost
    AfterPost = qryProdGroupDiscsAfterPost
    Left = 164
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryProdGroupDiscsCol1: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col1'
      Size = 255
    end
    object qryProdGroupDiscsCol2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col2'
      Size = 255
    end
    object qryProdGroupDiscsCol3: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col3'
      Size = 255
    end
    object qryProdGroupDiscsDiscount: TFloatField
      DisplayLabel = '% Discount'
      DisplayWidth = 10
      FieldName = 'Discount'
    end
    object qryProdGroupDiscsClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryProdGroupDiscsGrpDiscID: TIntegerField
      FieldName = 'GrpDiscID'
    end
  end
  object dsProdGroupDiscs: TDataSource
    DataSet = qryProdGroupDiscs
    Left = 163
    Top = 61
  end
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PARTSID,PARTTYPE, PRODUCTGROUP, PARTNAME,'
      ' PARTSDESCRIPTION,  INCOMEACCNT,'
      ' ASSETACCNT, COGSACCNT, BARCODE, PRODUCTCODE, '
      'TAXCODE,   '
      'SpecialDiscount, SNTracking,  BuyQTY1, BuyQTY2,'
      ' BuyQTY3, COST1, COST2, COST3, SellQTY1, SellQTY2, SellQTY3,'
      ' PRICE1, PRICE2, PRICE3, WHOLESALEPRICE, Active, EditedFlag  '
      'FROM tblparts WHERE Active = '#39'T'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((PartName LIKE Concat(:SearchValue,"%' +
        '")) or (PARTSDESCRIPTION LIKE Concat(:SearchValue,"%"))) )'
      
        'or ((:SearchMode = 2) and ((PartName LIKE Concat("%",:SearchValu' +
        'e,"%")) or (PARTSDESCRIPTION LIKE Concat("%",:SearchValue,"%")))' +
        ' ))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by PartName')
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 671
    Top = 30
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
      end>
  end
  object qryProductGroupcol1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '"" AS PartLevel'
      'FROM tblparts'
      'where char_length(SUBSTRING_INDEX(PRODUCTGROUP,'#39'^'#39',1))<>0'
      'Group by PartLevel'
      'Order by PartLevel;')
    Options.LongStrings = False
    Left = 125
    Top = 89
  end
  object qryProductGroupcol2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      '"" AS PartLevel'
      'FROM tblparts'
      'WHERE INSTR(PRODUCTGROUP,"^")<>0'
      'Group by PartLevel'
      'Order by PartLevel;')
    Options.LongStrings = False
    Left = 733
    Top = 30
  end
  object qryProductGroupcol3: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '"" AS PartLevel'
      'FROM tblparts'
      
        'WHERE INSTR(IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(PRODU' +
        'CTGROUP,"^",2),""),"^")<>0'
      'Group by PartLevel'
      'Order by PartLevel;')
    Options.LongStrings = False
    Left = 765
    Top = 30
  end
  object memqrySpecials: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 601
    Top = 1
  end
  object Qryclients_eParcel: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblclients_eParcel'
      'WHERE ClientID = :CusID;')
    AfterInsert = Qryclients_eParcelAfterInsert
    Left = 380
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object Qryclients_eParcelGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object Qryclients_eParcelID: TIntegerField
      FieldName = 'ID'
    end
    object Qryclients_eParcelClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object Qryclients_eParceleParcelreference1: TWideStringField
      FieldName = 'eParcelreference1'
      Size = 100
    end
    object Qryclients_eParceleParcelreference2: TWideStringField
      FieldName = 'eParcelreference2'
      Size = 100
    end
    object Qryclients_eParcelPrinteParcelreference1: TWideStringField
      FieldName = 'PrinteParcelreference1'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelPrinteParcelreference2: TWideStringField
      FieldName = 'PrinteParcelreference2'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelReturn_Company: TWideStringField
      FieldName = 'Return_Company'
      Size = 160
    end
    object Qryclients_eParcelReturn_Name: TWideStringField
      FieldName = 'Return_Name'
      Size = 40
    end
    object Qryclients_eParcelReturn_Street1: TWideStringField
      FieldName = 'Return_Street1'
      Size = 255
    end
    object Qryclients_eParcelReturn_Street2: TWideStringField
      FieldName = 'Return_Street2'
      Size = 255
    end
    object Qryclients_eParcelReturn_Street3: TWideStringField
      FieldName = 'Return_Street3'
      Size = 255
    end
    object Qryclients_eParcelReturn_Suburb: TWideStringField
      FieldName = 'Return_Suburb'
      Size = 255
    end
    object Qryclients_eParcelReturn_State: TWideStringField
      FieldName = 'Return_State'
      Size = 255
    end
    object Qryclients_eParcelReturn_Country: TWideStringField
      FieldName = 'Return_Country'
      Size = 255
    end
    object Qryclients_eParcelReturn_Postcode: TWideStringField
      FieldName = 'Return_Postcode'
      Size = 255
    end
    object Qryclients_eParcelReDir_Company: TWideStringField
      FieldName = 'ReDir_Company'
      Size = 160
    end
    object Qryclients_eParcelReDir_Name: TWideStringField
      FieldName = 'ReDir_Name'
      Size = 40
    end
    object Qryclients_eParcelReDir_Street1: TWideStringField
      FieldName = 'ReDir_Street1'
      Size = 255
    end
    object Qryclients_eParcelReDir_Street2: TWideStringField
      FieldName = 'ReDir_Street2'
      Size = 255
    end
    object Qryclients_eParcelReDir_Street3: TWideStringField
      FieldName = 'ReDir_Street3'
      Size = 255
    end
    object Qryclients_eParcelReDir_Suburb: TWideStringField
      FieldName = 'ReDir_Suburb'
      Size = 255
    end
    object Qryclients_eParcelReDir_State: TWideStringField
      FieldName = 'ReDir_State'
      Size = 255
    end
    object Qryclients_eParcelReDir_Country: TWideStringField
      FieldName = 'ReDir_Country'
      Size = 255
    end
    object Qryclients_eParcelReDir_Postcode: TWideStringField
      FieldName = 'ReDir_Postcode'
      Size = 255
    end
    object Qryclients_eParcelEmailNotification: TWideStringField
      FieldName = 'EmailNotification'
      FixedChar = True
      Size = 8
    end
    object Qryclients_eParcelconsigneePhoneonLabel: TWideStringField
      FieldName = 'consigneePhoneonLabel'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelLeaveAtAddress: TWideStringField
      FieldName = 'LeaveAtAddress'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelSignatureReqd: TWideStringField
      FieldName = 'SignatureReqd'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelExtraDeliveryInstructions: TWideStringField
      FieldName = 'ExtraDeliveryInstructions'
      Size = 255
    end
    object Qryclients_eParcelChargeBackAcntID: TIntegerField
      FieldName = 'ChargeBackAcntID'
    end
    object Qryclients_eParcelChargeBackAcnt: TWideStringField
      FieldName = 'ChargeBackAcnt'
      Size = 100
    end
  end
  object dsclients_eParcel: TDataSource
    DataSet = Qryclients_eParcel
    Left = 379
    Top = 61
  end
  object cboAccountQry: TERPQuery
    SQL.Strings = (
      'SELECT AccountID, AccountName'
      'FROM tblchartofaccounts'
      'WHERE IsHeader = '#39'F'#39)
    Options.LongStrings = False
    Left = 581
    Top = 89
  end
  object QryAreaCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 546
    Top = 89
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
  object QryJobcontacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblContacts'
      'WHERE ClientID = :CusID;')
    BeforeOpen = QryJobcontactsBeforeOpen
    Left = 827
    Top = 89
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object QryJobcontactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryJobcontactsContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object QryJobcontactsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object QryJobcontactsClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 255
    end
    object QryJobcontactsCompany: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object QryJobcontactsContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object QryJobcontactsContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object QryJobcontactsContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object QryJobcontactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object QryJobcontactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object QryJobcontactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object QryJobcontactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object QryJobcontactsContactState: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object QryJobcontactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object QryJobcontactsContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object QryJobcontactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object QryJobcontactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object QryJobcontactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object QryJobcontactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object QryJobcontactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object QryJobcontactsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object QryJobcontactsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object QryJobcontactsAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 255
    end
    object QryJobcontactsJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object QryJobcontactsUseOnRun: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryJobcontactsLogMeInComputerIPAddress: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
    end
    object QryJobcontactsLogMeInEmailPassword: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Size = 100
    end
    object QryJobcontactsLogMeInUserName: TWideStringField
      FieldName = 'LogMeInUserName'
      Size = 100
    end
    object QryJobcontactsLogMeInPassword: TWideStringField
      FieldName = 'LogMeInPassword'
      Size = 100
    end
    object QryJobcontactsLogMeInERPUserName: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Size = 100
    end
    object QryJobcontactsLogMeInERPPassword: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Size = 100
    end
    object QryJobcontactsLogMeIncomputerPassword: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
    object QryJobcontactsIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforCashSale: TWideStringField
      FieldName = 'MainContactforCashSale'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforVoucher: TWideStringField
      FieldName = 'MainContactforVoucher'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforPOS: TWideStringField
      FieldName = 'MainContactforPOS'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforRefund: TWideStringField
      FieldName = 'MainContactforRefund'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforInvoice: TWideStringField
      FieldName = 'MainContactforInvoice'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforSalesOrder: TWideStringField
      FieldName = 'MainContactforSalesOrder'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforQuote: TWideStringField
      FieldName = 'MainContactforQuote'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforCheque: TWideStringField
      FieldName = 'MainContactforCheque'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforCredit: TWideStringField
      FieldName = 'MainContactforCredit'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforBill: TWideStringField
      FieldName = 'MainContactforBill'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforPO: TWideStringField
      FieldName = 'MainContactforPO'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforRA: TWideStringField
      FieldName = 'MainContactforRA'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforRepair: TWideStringField
      FieldName = 'MainContactforRepair'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsMainContactforStatements: TWideStringField
      FieldName = 'MainContactforStatements'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsNotaMainContact: TWideStringField
      FieldName = 'NotaMainContact'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsDoNotContact: TWideStringField
      FieldName = 'DoNotContact'
      FixedChar = True
      Size = 1
    end
    object QryJobcontactsTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object QryJobcontactsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object QryJobcontactsMainContactForSupplierPayment: TWideStringField
      FieldName = 'MainContactForSupplierPayment'
      FixedChar = True
      Size = 1
    end
  end
  object qryStockAdjustEntries: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT distinct '
      #9'SL.`Adjustmentdate` ,'
      #9'`SL`.`Processed`,'
      #9'`SL`.`Deleted`,'
      #9'`SLL`.`GlobalRef`,'
      #9'`SLL`.`StockAdjustEntryID`,'
      #9'`SLL`.`AccountID`,'
      #9'`SLL`.`AccountName`,'
      #9'P.PREFEREDSUPP as PreferedSupplier,'
      #9'`SLL`.`ProductID`,'
      #9'`SLL`.`ProductName`,'
      #9'`SLL`.`Description`,'
      #9'`SLL`.`ClassID`,'
      #9'`SLL`.`ClassName`,'
      #9'`SLL`.`AvailableQty`,'
      #9'`SLL`.`FinalQty`,'
      #9'`SLL`.`AdjustQty`,'
      #9'`SLL`.`AvailableUOMQty`,'
      #9'`SLL`.`FinalUOMQty`,'
      #9'`SLL`.`AdjustUOMQty`,'
      #9'`SLL`.`Cost`,'
      #9'`SLL`.`UOM`,'
      #9'`SLL`.`UOMMultiplier`,'
      #9'`SLL`.`UOMID`,'
      #9'(`SLL`.`Cost` * `SLL`.`UOMMultiplier`) AS UOMCost,'
      #9'(`SLL`.`Cost` * `SLL`.`AdjustQty`) AS TotalCost,'
      #9'SL.Adjusttype AS Adjusttype'
      'FROM tblStockAdjustEntrylines AS SLL'
      
        #9'INNER JOIN  tblStockAdjustEntry AS SL ON SL.StockAdjustEntryID ' +
        '= SLL.StockAdjustEntryID'
      #9'LEFT JOIN tblParts P ON SLL.ProductID = P.PartsID'
      'WHERE IFNULL(`SLL`.`Deleted`,"F") <> "T"'
      #9'AND SLL.`JobID` = :jobID'
      'ORDER BY SL.`Adjustmentdate` DESC')
    Left = 208
    Top = 360
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'jobID'
      end>
    object qryStockAdjustEntriesAdjustmentdate: TDateTimeField
      FieldName = 'Adjustmentdate'
    end
    object qryStockAdjustEntriesProcessed: TWideStringField
      FieldName = 'Processed'
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntriesDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntriesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryStockAdjustEntriesStockAdjustEntryID: TIntegerField
      FieldName = 'StockAdjustEntryID'
    end
    object qryStockAdjustEntriesAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryStockAdjustEntriesAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 255
    end
    object qryStockAdjustEntriesPreferedSupplier: TWideStringField
      FieldName = 'PreferedSupplier'
      Size = 55
    end
    object qryStockAdjustEntriesProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object qryStockAdjustEntriesProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 255
    end
    object qryStockAdjustEntriesDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryStockAdjustEntriesClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryStockAdjustEntriesClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryStockAdjustEntriesAvailableQty: TFloatField
      FieldName = 'AvailableQty'
    end
    object qryStockAdjustEntriesFinalQty: TFloatField
      FieldName = 'FinalQty'
    end
    object qryStockAdjustEntriesAdjustQty: TFloatField
      FieldName = 'AdjustQty'
    end
    object qryStockAdjustEntriesAvailableUOMQty: TFloatField
      FieldName = 'AvailableUOMQty'
    end
    object qryStockAdjustEntriesFinalUOMQty: TFloatField
      FieldName = 'FinalUOMQty'
    end
    object qryStockAdjustEntriesAdjustUOMQty: TFloatField
      FieldName = 'AdjustUOMQty'
    end
    object qryStockAdjustEntriesUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
    end
    object qryStockAdjustEntriesUOMID: TIntegerField
      FieldName = 'UOMID'
    end
    object qryStockAdjustEntriesAdjusttype: TWideStringField
      FieldName = 'Adjusttype'
      FixedChar = True
      Size = 5
    end
    object qryStockAdjustEntriesUOM: TWideStringField
      FieldName = 'UOM'
      Size = 50
    end
    object qryStockAdjustEntriesCost: TFloatField
      FieldName = 'Cost'
      DisplayFormat = '$0.00'
    end
    object qryStockAdjustEntriesUOMCost: TFloatField
      FieldName = 'UOMCost'
      DisplayFormat = '$0.00'
    end
    object qryStockAdjustEntriesTotalCost: TFloatField
      FieldName = 'TotalCost'
      DisplayFormat = '$0.00'
    end
  end
  object dsStockAdjustEntries: TDataSource
    DataSet = qryStockAdjustEntries
    Left = 212
    Top = 416
  end
  object qryAccount1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT AccountID, AccountName FROM tblchartofaccounts ORDER BY A' +
        'ccountName')
    Left = 624
    Top = 312
    object qryAccount1AccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryAccount1AccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
  end
  object qryAccount2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT AccountID, AccountName FROM tblchartofaccounts ORDER BY A' +
        'ccountName')
    Left = 536
    Top = 320
    object qryAccount2AccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryAccount2AccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
  end
  object qrySASum: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      #9'SUM(`AvailableUOMQty`) AS AQty,'
      #9'SUM(`Cost` * `AdjustQty`) AS TotalCost'
      'FROM tblStockAdjustEntrylines'
      'WHERE IFNULL(Deleted, "F") <> "T" AND JobID = 10')
    Left = 304
    Top = 360
    object qrySASumAQty: TFloatField
      FieldName = 'AQty'
    end
    object qrySASumTotalCost: TFloatField
      FieldName = 'TotalCost'
    end
  end
end
