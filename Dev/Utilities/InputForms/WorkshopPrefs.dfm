inherited WorkshopPrefsGUI: TWorkshopPrefsGUI
  Left = 537
  Top = 276
  HelpContext = 554000
  Caption = 'Workshop Preferences'
  ClientHeight = 638
  ClientWidth = 910
  OldCreateOrder = True
  ExplicitLeft = 537
  ExplicitTop = 276
  ExplicitWidth = 926
  ExplicitHeight = 677
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 638
    Width = 910
    HelpContext = 554038
    ExplicitTop = 515
    ExplicitWidth = 910
  end
  object lblWidth: TLabel [1]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 554001
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited sbpanels: TAdvScrollBox
    Width = 910
    Height = 638
    VertScrollBar.Position = 197
    ExplicitWidth = 910
    ExplicitHeight = 638
    HelpContext = 554061
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 152
      Width = 891
      Height = 151
      HelpContext = 554029
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 883
        Height = 143
        HelpContext = 554030
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 135
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 117
        Height = 15
        HelpContext = 554031
        Caption = 'Customisable Fields '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 24
        Top = 40
        Width = 84
        Height = 15
        HelpContext = 554033
        Caption = 'Job Name Title'
        Transparent = True
      end
      object Label5: TLabel
        Left = 24
        Top = 93
        Width = 96
        Height = 15
        HelpContext = 554034
        Caption = 'Job Number Title'
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 24
        Top = 56
        Width = 225
        Height = 23
        HelpContext = 554036
        DataField = 'JobNameHeader'
        DataSource = dsPrefs
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
      object wwDBEdit2: TwwDBEdit
        Left = 24
        Top = 109
        Width = 225
        Height = 23
        HelpContext = 554037
        DataField = 'JobNumberHeader'
        DataSource = dsPrefs
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
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = -197
      Width = 891
      Height = 349
      HelpContext = 554040
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 883
        Height = 341
        HelpContext = 554041
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 6
      end
      object Label3: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 554042
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 24
        Top = 35
        Width = 287
        Height = 15
        HelpContext = 554043
        Caption = 'Default Status for Sales order when Repair is Done'
        Transparent = True
      end
      object Label4: TLabel
        Left = 24
        Top = 92
        Width = 261
        Height = 15
        HelpContext = 554044
        Caption = 'Default Status for Invoice when Repair is Done'
        Transparent = True
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 24
        Top = 52
        Width = 139
        Height = 23
        HelpContext = 554045
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'name'#9'20'#9'Name'#9'F')
        DataField = 'DefaultStatusforSOofDoneRepair'
        DataSource = dsPrefs
        LookupTable = qrySalesOrderStatus
        LookupField = 'Name'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 24
        Top = 110
        Width = 139
        Height = 23
        HelpContext = 554046
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'name'#9'20'#9'Name'#9'F')
        DataField = 'DefaultStatusForInvoiceofdonerepair'
        DataSource = dsPrefs
        LookupTable = qryInvoiceStatus
        LookupField = 'NAme'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwCheckBox4: TwwCheckBox
        Left = 24
        Top = 144
        Width = 333
        Height = 17
        HelpContext = 554057
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
        Caption = 'Force Customer PO # Prior to any data entry in Repairs'
        Checked = True
        DataField = 'EnforceCustPOInrepairbeforeOtherInfo'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object memNewRepairNotes: TDBMemo
        Left = 48
        Top = 192
        Width = 489
        Height = 126
        HelpContext = 554059
        DataField = 'NewRepairNotesText'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object chkAddNotesToNewRepair: TwwCheckBox
        Left = 24
        Top = 171
        Width = 333
        Height = 17
        HelpContext = 554060
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
        Caption = 'Add Notes To a New Repair'
        Checked = True
        DataField = 'AddNotesToNewRepair'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 4
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 493
      Width = 891
      Height = 143
      HelpContext = 554015
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 883
        Height = 135
        HelpContext = 554016
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 127
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 80
        Height = 15
        HelpContext = 554017
        Caption = 'Invoice Repair'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 24
        Top = 105
        Width = 221
        Height = 15
        HelpContext = 554054
        Caption = 'Repair Has to be approved for Invoicing'
        Transparent = True
      end
      object wwCheckBox6: TwwCheckBox
        Left = 24
        Top = 45
        Width = 333
        Height = 17
        HelpContext = 554019
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
        Caption = 'Show  Invoice Form when Repair  is Invoiced'
        Checked = True
        DataField = 'ShowInvoiceFormwhenRepairInvoiced'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwCheckBox2: TwwCheckBox
        Left = 24
        Top = 76
        Width = 333
        Height = 17
        HelpContext = 554055
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
        Caption = 'Combine Time Sheet Lines on Invoiced'
        Checked = True
        DataField = 'CombineRepairTimeSheetLinesOnInvoice'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object cboStatusforInvoice: TwwDBLookupCombo
        Left = 259
        Top = 99
        Width = 225
        Height = 23
        HelpContext = 554039
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'name'#9'20'#9'name'#9'F')
        DataField = 'RepairStatustoMakeInvoice'
        DataSource = dsPrefs
        LookupTable = QryStatusforInvoice
        LookupField = 'name'
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 303
      Width = 891
      Height = 190
      HelpContext = 554002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 883
        Height = 182
        HelpContext = 554003
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 97
      end
      object Label7: TLabel
        Left = 14
        Top = 14
        Width = 67
        Height = 15
        HelpContext = 554005
        Caption = 'Print Repair'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox5: TwwCheckBox
        Left = 26
        Top = 50
        Width = 333
        Height = 17
        HelpContext = 554013
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
        Caption = 'Print Best Practices'
        Checked = True
        DataField = 'PrintRepairsBestPractices'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
      object wwCheckBox1: TwwCheckBox
        Left = 26
        Top = 85
        Width = 333
        Height = 17
        HelpContext = 554050
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
        Caption = 'Hold Repair on Printing'
        Checked = True
        DataField = 'HoldRepairOnPrinting'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 1
      end
      object chkRepairDoneOnConversion: TwwCheckBox
        Left = 26
        Top = 120
        Width = 333
        Height = 17
        HelpContext = 554051
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
        Caption = 'Flag Repair Done on Conversion'
        Checked = True
        DataField = 'RepairDoneOnConversion'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 2
      end
      object wwCheckBox3: TwwCheckBox
        Left = 26
        Top = 156
        Width = 333
        Height = 17
        HelpContext = 554052
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
        Caption = 'Lock Repair When Done'
        Checked = True
        DataField = 'LockRepairwhenDone'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 3
      end
    end
  end
  object MyConnection: TERPConnection
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Left = 672
    Top = 56
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AddNotesToNewRepair'
      'CombineRepairTimeSheetLinesOnInvoice'
      'DefaultStatusForInvoiceofdonerepair'
      'DefaultStatusforSOofDoneRepair'
      'EndOfDay'
      'EnforceCustPOInrepairbeforeOtherInfo'
      'HoldRepairOnPrinting'
      'JobNameHeader'
      'JobNumberHeader'
      'LockRepairwhenDone'
      'NewRepairNotesText'
      'PrintRepairsBestPractices'
      'RepairDoneOnConversion'
      'RepairStatustoMakeInvoice'
      'ShowInvoiceFormwhenRepairInvoiced'
      'StartOfDay')
    Left = 712
    Top = 56
  end
  object qryInvoiceStatus: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'LeadStatusType'#39
      'ORDER BY Name')
    Left = 630
    Top = 136
  end
  object qrySalesOrderStatus: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'LeadStatusType'#39
      'ORDER BY Name')
    Left = 734
    Top = 144
  end
  object QryStatusforInvoice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'LeadStatusType'#39
      'ORDER BY Name')
    Left = 779
    Top = 45
    object QryStatusforInvoicename: TWideStringField
      DisplayWidth = 20
      FieldName = 'name'
      Size = 255
    end
    object QryStatusforInvoiceid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
  end
  object dsColumnHeadings: TDataSource
    DataSet = qryColumnHeadings
    Left = 768
    Top = 96
  end
  object qryColumnHeadings: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblcolumnheadings')
    Left = 728
    Top = 96
  end
end
