inherited frmPayBenefits: TfrmPayBenefits
  Left = 1269
  Top = 146
  Width = 857
  Height = 540
  HelpContext = 574000
  Caption = 'frmPayBenefits'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object DNMPanel1: TDNMPanel
    Left = 16
    Top = 24
    Width = 799
    Height = 241
    HelpContext = 574001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Category = 'UKPayroll'
    DesignSize = (
      799
      241)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 226
      HelpContext = 574002
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object grdBenefits: TwwDBGrid
      Left = 15
      Top = 14
      Width = 768
      Height = 214
      HelpContext = 574003
      ControlType.Strings = (
        'IsNICsPayable;CustomEdit;chkIsNicPayable;F'
        'NICsClass;CustomEdit;cboNicClass;F'
        'BenefitOrExpense;CustomEdit;cboBenefitOrExpense;F'
        'Department;CustomEdit;cboDepartment;F'
        'PayID;CustomEdit;cboDepartment;F'
        'ClassName;CustomEdit;cboBenefitDept;F')
      Selected.Strings = (
        'PayID'#9'6'#9'PayID'#9'F'
        'Description'#9'32'#9'Description'#9'F'
        'IsNICsPayable'#9'1'#9'Is NICs Payable'#9'F'
        'NICsClass'#9'8'#9'NICs Class'#9'F'
        'EmployeeNICAmount'#9'10'#9'Employee NIC Amount'#9'F'
        'EmployerNICAmount'#9'10'#9'Employer NIC Amount'#9'F'
        'BenefitOrExpense'#9'10'#9'BenefitOrExpense'#9'F'
        'BenefitReceivedFrom'#9'20'#9'BenefitReceivedFrom'#9'F'
        'ClassName'#9'25'#9'ClassName'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = 15785701
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSpaysbenefits
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
      FooterColor = 15785701
      FooterCellColor = 15785701
      object btnDeleteBenefit: TwwIButton
        Left = 0
        Top = 0
        Width = 23
        Height = 22
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
        OnClick = btnDeleteBenefitClick
      end
    end
    object cboNicClass: TwwDBComboBox
      Left = 240
      Top = 72
      Width = 105
      Height = 23
      HelpContext = 574004
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'NICsClass'
      DataSource = DSpaysbenefits
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Class1'
        'Class1A'
        'Class1B'
        'Class3')
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
    end
    object cboBenefitOrExpense: TwwDBComboBox
      Left = 456
      Top = 64
      Width = 81
      Height = 23
      HelpContext = 574005
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'BenefitOrExpense'
      DataSource = DSpaysbenefits
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Benefit'
        'Expense')
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
    object chkIsNicPayable: TwwCheckBox
      Left = 509
      Top = 86
      Width = 15
      Height = 17
      HelpContext = 574006
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
      DataField = 'IsNICsPayable'
      DataSource = DSpaysbenefits
      TabOrder = 3
    end
    object cboBenefitDept: TwwDBLookupCombo
      Left = 624
      Top = 72
      Width = 143
      Height = 23
      HelpContext = 574007
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Department'#9'F')
      DataField = 'ClassName'
      DataSource = DSpaysbenefits
      LookupTable = qryDepartment
      LookupField = 'ClassName'
      Style = csDropDownList
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      AllowClearKey = False
    end
  end
  object DNMPanel2: TDNMPanel
    Left = 16
    Top = 272
    Width = 799
    Height = 241
    HelpContext = 574008
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Category = 'AustPayroll'
    DesignSize = (
      799
      241)
    object Bevel2: TBevel
      Left = 8
      Top = 8
      Width = 783
      Height = 226
      HelpContext = 574009
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object grdSuper: TwwDBGrid
      Left = 15
      Top = 14
      Width = 768
      Height = 213
      HelpContext = 574010
      ControlType.Strings = (
        'SuperType;CustomEdit;SuperType;T'
        'SuperFund;CustomEdit;SuperFund;T'
        'CalcBy;CustomEdit;SuperCalcBy;T'
        'ClassName;CustomEdit;cboSuperDepartment;F'
        'Amount;CustomEdit;edAmountSuper;T')
      Selected.Strings = (
        'SuperType'#9'20'#9'Type'#9'F'
        'SuperFund'#9'21'#9'Fund'#9'F'#9
        'AccountNo'#9'10'#9'Member No'#9'F'
        'DateJoined'#9'10'#9'Date Joined'#9'F'#9
        'Amount'#9'10'#9'Amount'#9'F'#9
        'CalcBy'#9'4'#9'$/%'#9'F'#9
        'AmountPaid'#9'11'#9'Amount Paid'#9'F'
        'ClassName'#9'20'#9'ClassName'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = 15785701
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSPaySuper
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      FooterColor = 15785701
      FooterCellColor = 15785701
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnSuperDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 23
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnSuperDeleteClick
      end
    end
    object SuperType: TwwDBLookupCombo
      Left = 53
      Top = 69
      Width = 124
      Height = 23
      HelpContext = 574011
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'50'#9'Description'#9#9)
      DataField = 'SuperTypeID'
      DataSource = DSPaySuper
      LookupTable = qrySuperType
      LookupField = 'SuperTypeID'
      Style = csDropDownList
      DropDownWidth = 125
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
    end
    object SuperFund: TwwDBLookupCombo
      Left = 181
      Top = 68
      Width = 137
      Height = 23
      HelpContext = 574012
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'50'#9'Company'#9'F')
      DataField = 'ClientID'
      DataSource = DSPaySuper
      LookupTable = qrySuppliers
      LookupField = 'ClientID'
      DropDownWidth = 125
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
    end
    object edAmountSuper: TwwDBEdit
      Left = 361
      Top = 114
      Width = 57
      Height = 23
      HelpContext = 574013
      DataField = 'Amount'
      DataSource = DSPaySuper
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object SuperCalcBy: TwwDBComboBox
      Left = 548
      Top = 65
      Width = 32
      Height = 23
      HelpContext = 574014
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      DataField = 'CalcBy'
      DataSource = DSPaySuper
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        '$'
        '%')
      ItemIndex = 1
      Sorted = False
      TabOrder = 4
      UnboundDataType = wwDefault
    end
    object cboSuperDepartment: TwwDBLookupCombo
      Left = 616
      Top = 88
      Width = 143
      Height = 23
      HelpContext = 574015
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Department'#9'F')
      DataField = 'ClassName'
      DataSource = DSPaySuper
      LookupTable = qryDepartment
      LookupField = 'ClassName'
      Style = csDropDownList
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      AllowClearKey = False
    end
  end
  object DSpaysbenefits: TDataSource
    Left = 480
  end
  object qryDepartment: TMyQuery
    SQL.Strings = (
      'Select ClassID, ClassName, Active'
      'FROM tblClass WHERE Active = "T"'
      'ORDER BY ClassName')
    Options.FlatBuffers = True
    Left = 606
  end
  object DSPaySuper: TDataSource
    Left = 173
    Top = 8
  end
  object qrySuperType: TMyQuery
    SQL.Strings = (
      'Select SuperTypeID, Description'
      'FROM tblSuperType')
    Options.FlatBuffers = True
    Left = 208
    Top = 8
  end
  object qrySuppliers: TMyQuery
    SQL.Strings = (
      'Select ClientID, Company'
      'FROM tblClients'
      'WHERE Supplier='#39'T'#39
      'Order By Company;')
    Options.FlatBuffers = True
    Left = 259
    Top = 9
  end
end
