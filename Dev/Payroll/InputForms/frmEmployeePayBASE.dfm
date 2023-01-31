inherited fmEmployeePayBASE: TfmEmployeePayBASE
  Left = 1367
  Top = 129
  Caption = 'Pay Employee'
  ClientHeight = 529
  ClientWidth = 860
  OldCreateOrder = True
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 15
  object Label14: TLabel [1]
    Left = 749
    Top = 491
    Width = 54
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Prepared'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
  end
  object Label11: TLabel [2]
    Left = 798
    Top = 491
    Width = 54
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Deleted'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 4
    Top = 113
    Width = 852
    Height = 263
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 13
      Top = 12
      Width = 827
      Height = 242
      ActivePage = tabHours
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabIndex = 0
      TabOrder = 0
      TabWidth = 203
      object tabHours: TTabSheet
        Caption = 'Hours'
        object grdHours: TwwDBGrid
          Left = 1
          Top = 1
          Width = 811
          Height = 210
          ControlType.Strings = (
            'PayRateID;CustomEdit;PayRate;F'
            'TypeID;CustomEdit;PayType;F'
            'PayType;CustomEdit;PayType;F'
            'PayRate;CustomEdit;PayRate;F'
            'PayJob;CustomEdit;PayJob;F'
            'Qty;CustomEdit;edtQty;F'
            'ClassName;CustomEdit;PayDepartment;F'
            'SuperInc;CustomEdit;chkSuperIncHours;F')
          Selected.Strings = (
            'PayID'#9'5'#9'PayID'#9'F'#9
            'PayRate'#9'32'#9'Pay Rate'#9'F'#9
            'PayType'#9'20'#9'PayType'#9'F'#9
            'Qty'#9'10'#9'Qty'#9#9
            'Amount'#9'10'#9'Amount'#9#9
            'SuperInc'#9'1'#9'SuperInc'#9#9
            'PayJob'#9'20'#9'Job'#9'F'#9
            'LineTotal'#9'10'#9'Line Total'#9'F'#9
            'ClassName'#9'15'#9'Department'#9'F'#9
            'NICsInc'#9'1'#9'NICsInc'#9'F'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = DSPaysPayRates
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
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
          OnColEnter = grdHoursColEnter
          OnMouseUp = grdHoursMouseUp
          FooterColor = 15785701
          FooterCellColor = 15785701
          object btnHrsDelete: TwwIButton
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
            OnClick = btnHrsDeleteClick
          end
        end
        object PayRate: TwwDBLookupCombo
          Left = 49
          Top = 156
          Width = 112
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'100'#9'Description'#9#9)
          DataField = 'PayRateID'
          DataSource = DSPayRate
          LookupTable = qryPayRates
          LookupField = 'RateID'
          DropDownWidth = 125
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = PayRateCloseUp
        end
        object PayType: TwwDBLookupCombo
          Left = 176
          Top = 157
          Width = 109
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'50'#9'Description'#9#9)
          DataField = 'TypeID'
          DataSource = DSPayRate
          LookupTable = qryPayRateType
          LookupField = 'TypeID'
          DropDownWidth = 125
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object edtQty: TwwDBEdit
          Left = 294
          Top = 157
          Width = 53
          Height = 23
          DataField = 'Qty'
          DataSource = DSPaysPayRates
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object PayJob: TwwDBLookupCombo
          Left = 352
          Top = 154
          Width = 118
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'50'#9'Company'#9'F')
          DataField = 'ClientID'
          DataSource = DSPayRate
          LookupTable = qryJobs
          LookupField = 'ClientID'
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object PayDepartment: TwwDBLookupCombo
          Left = 482
          Top = 154
          Width = 140
          Height = 23
          ControlType.Strings = (
            'Active;CheckBox;T;F')
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'ClassName'#9'30'#9'Department'#9'F')
          DataField = 'ClassID'
          DataSource = DSPaysPayRates
          LookupTable = qryDepartment
          LookupField = 'ClassName'
          Style = csDropDownList
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
      end
      object tabLeaves: TTabSheet
        Caption = 'Leaves'
        ImageIndex = 1
        object grdLeave: TwwDBGrid
          Left = 0
          Top = 0
          Width = 819
          Height = 212
          ControlType.Strings = (
            'LeaveType;CustomEdit;cboLeaveType;F'
            'ClassName;CustomEdit;cboLeaveDept;F'
            'IsCertified;CustomEdit;chkCertified;F')
          Selected.Strings = (
            'LeaveType'#9'12'#9'Leave Type'#9'F'
            'DateTaken'#9'10'#9'Date Taken'#9'F'#9
            'Qty'#9'7'#9'Hours'#9'F'#9
            'ClassName'#9'23'#9'Department'#9'F'
            'IsCertified'#9'1'#9'Certified'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alClient
          DataSource = dsPaysLeave
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
          OnExit = grdLeaveExit
          FooterColor = 15785701
          FooterCellColor = 15785701
          object btnLeaveDelete: TwwIButton
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
            OnClick = btnLeaveDeleteClick
          end
        end
        object cboLeaveType: TwwDBLookupCombo
          Left = 33
          Top = 29
          Width = 208
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'LeaveType'#9'25'#9'LeaveType'#9'F')
          DataField = 'LeaveType'
          DataSource = dsPaysLeave
          LookupTable = qryLeaveTypes
          LookupField = 'LeaveType'
          DropDownWidth = 125
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object cboLeaveDept: TwwDBLookupCombo
          Left = 367
          Top = 29
          Width = 140
          Height = 23
          ControlType.Strings = (
            'Active;CheckBox;T;F')
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'ClassName'#9'30'#9'Department'#9'F')
          DataField = 'ClassName'
          DataSource = dsPaysLeave
          LookupTable = qryDepartment
          LookupField = 'ClassName'
          Style = csDropDownList
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object chkCertified: TwwCheckBox
          Left = 538
          Top = 18
          Width = 17
          Height = 19
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
          DataField = 'IsCertified'
          DataSource = dsPaysLeave
          TabOrder = 3
        end
      end
      object TabBenifits: TTabSheet
        Caption = 'Benefits'
        ImageIndex = 2
        object pnlFringeBenefits: TDNMPanel
          Left = 0
          Top = 0
          Width = 819
          Height = 212
          Align = alClient
          Caption = 'Fringe Benefits'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object pnlNICs: TDNMPanel
          Left = 0
          Top = 0
          Width = 819
          Height = 212
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object grdBenefits: TwwDBGrid
            Left = 1
            Top = 1
            Width = 817
            Height = 210
            ControlType.Strings = (
              'IsNICsPayable;CustomEdit;chkIsNicPayable;F'
              'NICsClass;CustomEdit;cboNicClass;F'
              'BenefitOrExpense;CustomEdit;cboBenefitOrExpense;F')
            Selected.Strings = (
              'PayID'#9'6'#9'PayID'#9'F'
              'Description'#9'32'#9'Description'#9'F'
              'IsNICsPayable'#9'1'#9'Is NICs Payable'#9'F'
              'NICsClass'#9'8'#9'NICs Class'#9'F'
              'BenefitAmount'#9'10'#9'Benefit Amount'#9'F'
              'EmployeeNICAmount'#9'10'#9'Employee NIC Amount'#9'F'
              'EmployerNICAmount'#9'10'#9'Employer NIC Amount'#9'F'
              'BenefitOrExpense'#9'10'#9'BenefitOrExpense'#9'F'
              'BenefitReceivedFrom'#9'20'#9'BenefitReceivedFrom'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = 15785701
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = DBpaysbenefits
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
            OnExit = grdBenefitsExit
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
            Left = 232
            Top = 56
            Width = 105
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'NICsClass'
            DataSource = DBpaysbenefits
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
          object chkIsNicPayable: TwwCheckBox
            Left = 501
            Top = 70
            Width = 15
            Height = 17
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
            DataSource = DBpaysbenefits
            TabOrder = 2
          end
          object cboBenefitOrExpense: TwwDBComboBox
            Left = 448
            Top = 48
            Width = 81
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'BenefitOrExpense'
            DataSource = DBpaysbenefits
            DropDownCount = 8
            ItemHeight = 0
            Items.Strings = (
              'Benefit'
              'Expense')
            Sorted = False
            TabOrder = 3
            UnboundDataType = wwDefault
          end
        end
      end
      object tabDeductions: TTabSheet
        Caption = 'Deductions'
        ImageIndex = 3
        object grdDeductions: TwwDBGrid
          Left = 0
          Top = 0
          Width = 819
          Height = 212
          ControlType.Strings = (
            'Deduction;CustomEdit;Deduction;T'
            'Amount;CustomEdit;Amount;T'
            'TaxExempt;CustomEdit;chkTaxExemptDeduction;T'
            'UnionFees;CustomEdit;chkUnionFeesDeduction;T'
            'CalcBy;CustomEdit;cboDeductCalcBy;T'
            'ClassName;CustomEdit;cboDeductDept;T'
            'BasedOn;CustomEdit;DeductBasedOn;T')
          Selected.Strings = (
            'Deduction'#9'20'#9'Deduction'#9'F'
            'Notes'#9'15'#9'Notes'#9'F'
            'Qty'#9'4'#9'Qty'#9'F'
            'Amount'#9'7'#9'Amount'#9'F'
            'CalcBy'#9'5'#9'$/%'#9'F'
            'BasedOn'#9'20'#9'BasedOn'#9'F'
            'TaxExempt'#9'1'#9'After Tax'#9'F'
            'UnionFees'#9'1'#9'Union Fees'#9'F'
            'MoneyAmount'#9'10'#9'Line Total'#9'F'
            'ClassName'#9'18'#9'Department'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          DataSource = DSPayDeductions
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
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
          object btnDeductionDelete: TwwIButton
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
            OnClick = btnDeductionDeleteClick
          end
        end
        object Deduction: TwwDBLookupCombo
          Left = 27
          Top = 27
          Width = 138
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'50'#9'Description'#9'F')
          DataField = 'DeductionID'
          DataSource = DSPayDeductions
          LookupTable = qryDeductions
          LookupField = 'DeductionID'
          Style = csDropDownList
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = DeductionCloseUp
        end
        object Amount: TwwDBEdit
          Left = 311
          Top = 24
          Width = 53
          Height = 23
          DataField = 'Amount'
          DataSource = DSPayDeductions
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboDeductCalcBy: TwwDBComboBox
          Left = 367
          Top = 26
          Width = 39
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'CalcBy'
          DataSource = DSPayDeductions
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            '$'#9'$'
            '%'#9'%')
          Sorted = False
          TabOrder = 3
          UnboundDataType = wwDefault
        end
        object DeductBasedOn: TwwDBLookupCombo
          Left = 411
          Top = 24
          Width = 125
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'BasedOn'#9'25'#9'BasedOn'#9#9)
          DataField = 'BasedOnID'
          DataSource = DSPayDeductions
          LookupTable = qryBasedOn
          LookupField = 'BasedOnID'
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object chkTaxExemptDeduction: TwwCheckBox
          Left = 549
          Top = 24
          Width = 56
          Height = 18
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
          Color = clWindow
          DataField = 'TaxExempt'
          DataSource = DSPayDeductions
          ParentColor = False
          TabOrder = 5
        end
        object chkUnionFeesDeduction: TwwCheckBox
          Left = 609
          Top = 27
          Width = 66
          Height = 18
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
          Color = clWindow
          DataField = 'UnionFees'
          DataSource = DSPayDeductions
          ParentColor = False
          TabOrder = 6
        end
        object cboDeductDept: TwwDBLookupCombo
          Left = 676
          Top = 25
          Width = 130
          Height = 23
          ControlType.Strings = (
            'Active;CheckBox;T;F')
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'ClassName'#9'30'#9'ClassName'#9'F')
          DataField = 'ClassName'
          DataSource = DSPayDeductions
          LookupTable = qryDepartment
          LookupField = 'ClassName'
          Style = csDropDownList
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
      end
      object TabAllowances: TTabSheet
        Caption = 'Allowances'
        ImageIndex = 4
        object grdAllowances: TwwDBGrid
          Left = 0
          Top = 0
          Width = 819
          Height = 212
          ControlType.Strings = (
            'AllowanceDept;CustomEdit;AllowDept;T'
            'Allowance;CustomEdit;cboAllowance;F'
            'BasedOnID;CustomEdit;AllowBasedOn;T'
            'AllowanceJob;CustomEdit;AllowJob;F'
            'SuperInc;CustomEdit;chkAllowSuper;F'
            'TaxExempt;CustomEdit;chkAllowTaxExempt;F'
            'BasedOn;CustomEdit;AllowBasedOn;T'
            'Qty;CustomEdit;AllowQty;T'
            'Amount;CustomEdit;AllowanceAmount;F'
            'CalcBy;CustomEdit;cboAllowCalcBy;F'
            'ClassName;CustomEdit;cboAllowDepart;F')
          Selected.Strings = (
            'Allowance'#9'20'#9'Allowance'#9'F'
            'Qty'#9'4'#9'Qty'#9'F'
            'Amount'#9'7'#9'Amount'#9'F'
            'CalcBy'#9'5'#9'$/%'#9'F'
            'BasedOn'#9'20'#9'Based On'#9'F'
            'SuperInc'#9'1'#9'Super'#9'F'
            'TaxExempt'#9'1'#9'Tax Exempt'#9'F'
            'AllowanceJob'#9'15'#9'Customer Job'#9'F'
            'ClassName'#9'20'#9'Department'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          OnRowChanged = grdAllowancesRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          DataSource = DSPayAllowances
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
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
          OnExit = grdAllowancesExit
          FooterColor = 15785701
          FooterCellColor = 15785701
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
          object btnAllowanceDelete: TwwIButton
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
          end
        end
        object cboAllowance: TwwDBLookupCombo
          Left = 24
          Top = 27
          Width = 121
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Description'#9'150'#9'Description'#9#9)
          DataField = 'Allowance'
          DataSource = DSPayAllowances
          LookupTable = qryAllowances
          LookupField = 'AllowanceID'
          Style = csDropDownList
          DropDownWidth = 125
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboAllowanceCloseUp
        end
        object AllowQty: TwwDBEdit
          Left = 166
          Top = 27
          Width = 32
          Height = 23
          DataField = 'Qty'
          DataSource = DSPayAllowances
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object AllowBasedOn: TwwDBLookupCombo
          Left = 210
          Top = 26
          Width = 144
          Height = 23
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'BasedOn'#9'25'#9'BasedOn'#9#9)
          DataField = 'BasedOnID'
          DataSource = DSPayAllowances
          LookupTable = qryBasedOn
          LookupField = 'BasedOnID'
          DropDownWidth = 50
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object cboAllowCalcBy: TwwDBComboBox
          Left = 344
          Top = 27
          Width = 33
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'CalcBy'
          DataSource = DSPayAllowances
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            '$'#9'$'
            '%'#9'%')
          Sorted = False
          TabOrder = 4
          UnboundDataType = wwDefault
        end
        object chkAllowSuper: TwwCheckBox
          Left = 379
          Top = 30
          Width = 38
          Height = 18
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
          Color = clWindow
          DataField = 'SuperInc'
          DataSource = DSPayAllowances
          ParentColor = False
          TabOrder = 5
        end
        object chkAllowTaxExempt: TwwCheckBox
          Left = 440
          Top = 31
          Width = 71
          Height = 18
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
          Color = clWindow
          DataField = 'TaxExempt'
          DataSource = DSPayAllowances
          ParentColor = False
          TabOrder = 6
        end
        object AllowJob: TwwDBLookupCombo
          Left = 501
          Top = 25
          Width = 137
          Height = 23
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'Company'#9'40'#9'Company'#9'F')
          DataField = 'AllowanceJob'
          DataSource = DSPayAllowances
          LookupTable = qryJobs
          LookupField = 'ClientID'
          Style = csDropDownList
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object cboAllowDepart: TwwDBLookupCombo
          Left = 657
          Top = 25
          Width = 140
          Height = 23
          ControlType.Strings = (
            'Active;CheckBox;T;F')
          DropDownAlignment = taRightJustify
          Selected.Strings = (
            'ClassName'#9'30'#9'Department'#9'F')
          DataField = 'ClassName'
          DataSource = DSPayAllowances
          LookupTable = qryDepartment
          LookupField = 'ClassName'
          Style = csDropDownList
          TabOrder = 8
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
        end
        object AllowanceAmount: TwwDBEdit
          Left = 284
          Top = 49
          Width = 53
          Height = 23
          DataField = 'Amount'
          DataSource = DSPayAllowances
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
      end
    end
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 4
    Top = 52
    Width = 852
    Height = 55
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label37: TLabel
      Left = 17
      Top = 4
      Width = 33
      Height = 15
      Caption = 'Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label38: TLabel
      Left = 223
      Top = 4
      Width = 50
      Height = 15
      Caption = 'Pay Date'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label49: TLabel
      Left = 333
      Top = 5
      Width = 54
      Height = 15
      Caption = 'Date Paid'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label50: TLabel
      Left = 434
      Top = 6
      Width = 68
      Height = 15
      Alignment = taCenter
      Caption = 'Pay Periods'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblTaxCode: TLabel
      Left = 538
      Top = 6
      Width = 52
      Height = 15
      Caption = 'Tax code'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel1: TBevel
      Left = 722
      Top = 23
      Width = 113
      Height = 21
      Shape = bsFrame
    end
    object Label4: TLabel
      Left = 759
      Top = 26
      Width = 65
      Height = 15
      Caption = 'Manual Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 629
      Top = 6
      Width = 42
      Height = 15
      Caption = 'Pay No.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object PayDate: TwwDBDateTimePicker
      Left = 221
      Top = 22
      Width = 101
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'PayDate'
      DataSource = DSPays
      Date = 39207
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 0
      OnCloseUp = PayDateCloseUp
    end
    object DatePaid: TwwDBDateTimePicker
      Left = 331
      Top = 22
      Width = 92
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DatePaid'
      DataSource = DSPays
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
    object PayPeriods: TDBEdit
      Left = 443
      Top = 22
      Width = 52
      Height = 23
      DataField = 'PayPeriods'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtName: TwwDBEdit
      Left = 17
      Top = 22
      Width = 194
      Height = 23
      DataField = 'EmpName'
      DataSource = DSPays
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
    object edTaxcodeUsed: TDBEdit
      Left = 539
      Top = 22
      Width = 63
      Height = 23
      DataField = 'UKTaxCodeUsed'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object chkManualTax: TwwCheckBox
      Left = 738
      Top = 24
      Width = 15
      Height = 17
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
      DataField = 'ManualTax'
      DataSource = DSPays
      TabOrder = 3
      OnClick = chkManualTaxClick
    end
    object edPayID: TDBEdit
      Left = 628
      Top = 22
      Width = 63
      Height = 23
      DataField = 'PayID'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object DNMPanel4: TDNMPanel [5]
    Left = 4
    Top = 383
    Width = 852
    Height = 102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 35
      Top = 16
      Width = 40
      Height = 15
      Caption = 'Wages'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 4
      Top = 42
      Width = 71
      Height = 15
      Caption = 'Commission'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 11
      Top = 70
      Width = 64
      Height = 15
      Caption = 'Deductions'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 227
      Top = 14
      Width = 66
      Height = 15
      Caption = 'Allowances'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 239
      Top = 45
      Width = 51
      Height = 15
      Caption = 'Sundries'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 669
      Top = 16
      Width = 34
      Height = 15
      Caption = 'Gross'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 669
      Top = 42
      Width = 21
      Height = 15
      Caption = 'Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 669
      Top = 70
      Width = 19
      Height = 15
      Caption = 'Net'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblSuper: TLabel
      Left = 253
      Top = 74
      Width = 34
      Height = 15
      Caption = 'Super'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Wages: TDBEdit
      Left = 89
      Top = 9
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Wages'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object CommissionPay: TDBEdit
      Left = 89
      Top = 37
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Commission'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object DeductionsPay: TDBEdit
      Left = 89
      Top = 66
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Deductions'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object AllowancesPay: TDBEdit
      Left = 296
      Top = 9
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Allowances'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object SundriesPay: TDBEdit
      Left = 296
      Top = 41
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Sundries'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object SuperPay: TDBEdit
      Left = 296
      Top = 70
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Superannuation'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object GrossPay: TDBEdit
      Left = 710
      Top = 9
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Gross'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    object TaxPay: TDBEdit
      Left = 710
      Top = 37
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Tax'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object NetPay: TDBEdit
      Left = 710
      Top = 66
      Width = 121
      Height = 23
      TabStop = False
      DataField = 'Net'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object pnlemployee: TDNMPanel
      Left = 436
      Top = 9
      Width = 218
      Height = 83
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object lblNICsOther: TLabel
        Tag = 1
        Left = 4
        Top = 22
        Width = 68
        Height = 15
        Caption = 'NICs Class1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        Left = 4
        Top = 55
        Width = 61
        Height = 15
        Caption = 'NICs Other'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label16: TLabel
        Left = 63
        Top = 4
        Width = 84
        Height = 15
        Caption = 'Employee NICs'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edNICs: TDBEdit
        Left = 83
        Top = 21
        Width = 121
        Height = 23
        TabStop = False
        DataField = 'UKNICsClass1'
        DataSource = DSPays
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edNICsOther: TDBEdit
        Left = 83
        Top = 50
        Width = 121
        Height = 23
        TabStop = False
        DataField = 'UKNICsOther'
        DataSource = DSPays
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
    object pnlemployer: TDNMPanel
      Left = 436
      Top = 104
      Width = 218
      Height = 86
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object Label13: TLabel
        Tag = 1
        Left = 5
        Top = 27
        Width = 68
        Height = 15
        Caption = 'NICs Class1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label15: TLabel
        Left = 6
        Top = 55
        Width = 61
        Height = 15
        Caption = 'NICs Other'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 63
        Top = 4
        Width = 82
        Height = 15
        Caption = 'Employer NICs'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edEmployerNICsClass1: TDBEdit
        Left = 84
        Top = 21
        Width = 121
        Height = 23
        TabStop = False
        DataField = 'UKEmployerNICsClass1'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edEmployerNICsOther: TDBEdit
        Left = 85
        Top = 50
        Width = 121
        Height = 23
        TabStop = False
        DataField = 'UKEmployerNICsOther'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object DNMSpeedButton1: TDNMSpeedButton [6]
    Left = -8
    Top = 488
    Width = 81
    Height = 25
    Caption = 'Show Pay'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    OnClick = DNMSpeedButton1Click
  end
  object btnProcessPay: TDNMSpeedButton [7]
    Left = 268
    Top = 494
    Width = 93
    Height = 27
    Caption = 'Print Pay Slip'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 4
    OnClick = btnProcessPayClick
  end
  object pnlTitle: TDNMPanel [8]
    Left = 3
    Top = 3
    Width = 852
    Height = 43
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 848
      Height = 39
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 848
        Height = 39
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Employee Pay'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object AdvPicture1: TAdvPicture
        Left = 2
        Top = 8
        Width = 25
        Height = 20
        Animate = True
        Picture.Stretch = False
        Picture.Frame = 0
        PicturePosition = bpTopLeft
        StretchMode = smShrink
        Version = '1.3.1.0'
      end
    end
  end
  object btnOK: TDNMSpeedButton [9]
    Left = 137
    Top = 494
    Width = 87
    Height = 27
    Caption = 'Save'
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 6
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [10]
    Left = 532
    Top = 494
    Width = 87
    Height = 27
    Cancel = True
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 7
    OnClick = btnCancelClick
  end
  object ChkPrepared: TwwCheckBox [11]
    Left = 773
    Top = 505
    Width = 15
    Height = 17
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
    Caption = 'chkApplycredits'
    DataField = 'Prepared'
    DataSource = DSPays
    TabOrder = 8
    Visible = False
  end
  object chkDeleted: TwwCheckBox [12]
    Left = 818
    Top = 505
    Width = 15
    Height = 17
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
    Caption = 'chkApplycredits'
    DataField = 'Deleted'
    DataSource = DSPays
    TabOrder = 9
    OnClick = chkDeletedClick
  end
  object btnEmployerNICs: TDNMSpeedButton [13]
    Left = 400
    Top = 494
    Width = 98
    Height = 27
    Caption = 'Employer NICs'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 10
    OnClick = btnEmployerNICsClick
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 48
  end
  inherited MyConnection: TMyConnection
    Top = 65535
  end
  inherited DataState: TDataState
    Left = 56
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 0
  end
  object qryPaysPayRates: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpayspayrates '
      'Where PayID = :xPayId')
    Left = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayId'
      end>
    object qryPaysPayRatesPayID: TIntegerField
      DisplayWidth = 5
      FieldName = 'PayID'
      Origin = 'tblpayspayrates.PayID'
    end
    object qryPaysPayRatesPayRate: TStringField
      DisplayLabel = 'Pay Rate'
      DisplayWidth = 32
      FieldKind = fkLookup
      FieldName = 'PayRate'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRateID'
      Size = 32
      Lookup = True
    end
    object qryPaysPayRatesPayType: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'PayType'
      LookupDataSet = qryPayRateType
      LookupKeyFields = 'TypeID'
      LookupResultField = 'Description'
      KeyFields = 'TypeID'
      Size = 64
      Lookup = True
    end
    object qryPaysPayRatesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblpayspayrates.Qty'
    end
    object qryPaysPayRatesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Origin = 'tblpayspayrates.Amount'
      currency = True
    end
    object qryPaysPayRatesSuperInc: TStringField
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Origin = 'tblpayspayrates.SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayRatesPayJob: TStringField
      DisplayLabel = 'Job'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'PayJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryPaysPayRatesLineTotal: TFloatField
      DisplayLabel = 'Line Total'
      DisplayWidth = 10
      FieldName = 'LineTotal'
      Origin = 'tblpayspayrates.LineTotal'
      currency = True
    end
    object qryPaysPayRatesClassName: TStringField
      DisplayLabel = 'Department'
      DisplayWidth = 15
      FieldName = 'ClassName'
      Origin = 'tblpayspayrates.ClassName'
      Size = 255
    end
    object qryPaysPayRatesPayRateID: TIntegerField
      DisplayWidth = 5
      FieldName = 'PayRateID'
      Origin = 'tblpayspayrates.PayRateID'
      Visible = False
    end
    object qryPaysPayRatesTypeID: TIntegerField
      DisplayWidth = 5
      FieldName = 'TypeID'
      Origin = 'tblpayspayrates.TypeID'
      Visible = False
    end
    object qryPaysPayRatesGlobalRef: TStringField
      DisplayWidth = 5
      FieldName = 'GlobalRef'
      Origin = 'tblpayspayrates.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPaysPayRatesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblpayspayrates.ClientID'
      Visible = False
    end
    object qryPaysPayRatesClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tblpayspayrates.ClassID'
      Visible = False
    end
    object qryPaysPayRatesEditedFlag: TStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblpayspayrates.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPaysPayRatesTimeSheetId: TIntegerField
      DisplayWidth = 10
      FieldName = 'TimeSheetId'
      Origin = 'tblpayspayrates.TimeSheetId'
      Visible = False
    end
    object qryPaysPayRatesPaysPayRateID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 5
      FieldName = 'PaysPayRateID'
      Origin = 'tblpayspayrates.PaysPayRateID'
      Visible = False
    end
    object qryPaysPayRatesNICsInc: TStringField
      DisplayWidth = 1
      FieldName = 'NICsInc'
      FixedChar = True
      Size = 1
    end
  end
  object DSPaysPayRates: TDataSource
    DataSet = qryPaysPayRates
    Left = 224
  end
  object DSPayRate: TDataSource
    Left = 261
  end
  object qryJobs: TMyQuery
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass'
      'FROM tblclients'
      
        'WHERE Active = '#39'T'#39' AND Customer='#39'T'#39' AND (Company NOT LIKE '#39'Table' +
        '%'#39')'
      'ORDER BY Company')
    Left = 580
    Top = 2
  end
  object qryPayRateType: TMyQuery
    SQL.Strings = (
      'Select TypeID,Description'
      'FROM tblPayRateType')
    Left = 326
  end
  object qryPayRates: TMyQuery
    SQL.Strings = (
      'Select RateID, Description'
      'FROM tblPayRates'
      '#WHERE Active = '#39'T'#39)
    Left = 292
    Top = 1
  end
  object qryDepartment: TMyQuery
    SQL.Strings = (
      'Select ClassID, ClassName, Active'
      'FROM tblClass WHERE Active = "T"'
      'ORDER BY ClassName')
    Left = 606
  end
  object qryPays: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpays')
    Left = 544
    object qryPaysGlobalRef: TStringField
      DisplayWidth = 5
      FieldName = 'GlobalRef'
      Origin = 'tblpays.GlobalRef'
      Size = 255
    end
    object qryPaysPayID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PayID'
      Origin = 'tblpays.PayID'
    end
    object qryPaysEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblpays.EmployeeID'
    end
    object qryPaysPayDate: TDateField
      DisplayWidth = 10
      FieldName = 'PayDate'
      Origin = 'tblpays.PayDate'
    end
    object qryPaysDatePaid: TDateField
      DisplayWidth = 10
      FieldName = 'DatePaid'
      Origin = 'tblpays.DatePaid'
    end
    object qryPaysPayPeriods: TWordField
      DisplayWidth = 10
      FieldName = 'PayPeriods'
      Origin = 'tblpays.PayPeriods'
    end
    object qryPaysWages: TFloatField
      DisplayWidth = 10
      FieldName = 'Wages'
      Origin = 'tblpays.Wages'
      currency = True
    end
    object qryPaysCommission: TFloatField
      DisplayWidth = 10
      FieldName = 'Commission'
      Origin = 'tblpays.Commission'
      currency = True
    end
    object qryPaysDeductions: TFloatField
      DisplayWidth = 10
      FieldName = 'Deductions'
      Origin = 'tblpays.Deductions'
      currency = True
    end
    object qryPaysAllowances: TFloatField
      DisplayWidth = 10
      FieldName = 'Allowances'
      Origin = 'tblpays.Allowances'
      currency = True
    end
    object qryPaysAllowancesBeforeTax: TFloatField
      DisplayWidth = 10
      FieldName = 'AllowancesBeforeTax'
      Origin = 'tblpays.AllowancesBeforeTax'
      currency = True
    end
    object qryPaysSundries: TFloatField
      DisplayWidth = 10
      FieldName = 'Sundries'
      Origin = 'tblpays.Sundries'
      currency = True
    end
    object qryPaysSuperannuation: TFloatField
      DisplayWidth = 10
      FieldName = 'Superannuation'
      Origin = 'tblpays.Superannuation'
      currency = True
    end
    object qryPaysGross: TFloatField
      DisplayWidth = 10
      FieldName = 'Gross'
      Origin = 'tblpays.Gross'
      currency = True
    end
    object qryPaysGrossTaxable: TFloatField
      DisplayWidth = 10
      FieldName = 'GrossTaxable'
      Origin = 'tblpays.GrossTaxable'
    end
    object qryPaysTax: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tblpays.Tax'
      currency = True
    end
    object qryPaysNet: TFloatField
      DisplayWidth = 10
      FieldName = 'Net'
      Origin = 'tblpays.Net'
      currency = True
    end
    object qryPaysPay: TStringField
      DisplayWidth = 1
      FieldName = 'Pay'
      Origin = 'tblpays.Pay'
      FixedChar = True
      Size = 1
    end
    object qryPaysPaid: TStringField
      DisplayWidth = 1
      FieldName = 'Paid'
      Origin = 'tblpays.Paid'
      FixedChar = True
      Size = 1
    end
    object qryPaysEditedFlag: TStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblpays.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryPaysPrinted: TStringField
      DisplayWidth = 1
      FieldName = 'Printed'
      Origin = 'tblpays.Printed'
      FixedChar = True
      Size = 1
    end
    object qryPaysEmpName: TStringField
      DisplayWidth = 30
      FieldName = 'EmpName'
      Origin = 'tblpays.EmpName'
      Size = 50
    end
    object qryPaysLeaveLoading: TFloatField
      DisplayWidth = 10
      FieldName = 'LeaveLoading'
      Origin = 'tblpays.LeaveLoading'
    end
    object qryPaysClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tblpays.ClassID'
    end
    object qryPaysClass: TStringField
      DisplayWidth = 255
      FieldName = 'Class'
      Origin = 'tblpays.Class'
      Size = 255
    end
    object qryPaysIsTimesheet: TStringField
      DisplayWidth = 1
      FieldName = 'IsTimesheet'
      Origin = 'tblpays.IsTimesheet'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayPeriod: TStringField
      DisplayWidth = 255
      FieldName = 'PayPeriod'
      Origin = 'tblpays.PayPeriod'
      Size = 255
    end
    object qryPaysAnnualLeaveRate: TFloatField
      DisplayWidth = 10
      FieldName = 'AnnualLeaveRate'
      Origin = 'tblpays.AnnualLeaveRate'
    end
    object qryPaysCDEPGross: TFloatField
      DisplayWidth = 10
      FieldName = 'CDEPGross'
      Origin = 'tblpays.CDEPGross'
    end
    object qryPaysLumpA: TFloatField
      DisplayWidth = 10
      FieldName = 'LumpA'
      Origin = 'tblpays.LumpA'
    end
    object qryPaysLumpB: TFloatField
      DisplayWidth = 10
      FieldName = 'LumpB'
      Origin = 'tblpays.LumpB'
    end
    object qryPaysLumpD: TFloatField
      DisplayWidth = 10
      FieldName = 'LumpD'
      Origin = 'tblpays.LumpD'
    end
    object qryPaysLumpE: TFloatField
      DisplayWidth = 10
      FieldName = 'LumpE'
      Origin = 'tblpays.LumpE'
    end
    object qryPaysETP: TFloatField
      DisplayWidth = 10
      FieldName = 'ETP'
      Origin = 'tblpays.ETP'
    end
    object qryPaysManualTax: TStringField
      DisplayWidth = 1
      FieldName = 'ManualTax'
      Origin = 'tblpays.ManualTax'
      FixedChar = True
      Size = 1
    end
    object qryPaysDeleted: TStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblpays.Deleted'
      FixedChar = True
      Size = 1
    end
    object qryPaysIsNewTypePay: TStringField
      DisplayWidth = 1
      FieldName = 'IsNewTypePay'
      Origin = 'tblpays.IsNewTypePay'
      FixedChar = True
      Size = 1
    end
    object qryPaysPaySuperOnLeaveLoading: TStringField
      DisplayWidth = 1
      FieldName = 'PaySuperOnLeaveLoading'
      Origin = 'tblpays.PaySuperOnLeaveLoading'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayVersion: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayVersion'
      Origin = 'tblpays.PayVersion'
    end
    object qryPaysPayNotes: TMemoField
      DisplayWidth = 10
      FieldName = 'PayNotes'
      Origin = 'tblpays.PayNotes'
      BlobType = ftMemo
    end
    object qryPaysPayXMLData: TMemoField
      DisplayWidth = 10
      FieldName = 'PayXMLData'
      Origin = 'tblpays.PayXMLData'
      BlobType = ftMemo
    end
    object qryPaysPrepared: TStringField
      DisplayWidth = 1
      FieldName = 'Prepared'
      Origin = 'tblpays.Prepared'
      FixedChar = True
      Size = 1
    end
    object qryPaysUKTaxCodeUsed: TStringField
      FieldName = 'UKTaxCodeUsed'
      Origin = 'tblpays.UKTaxCodeUsed'
      Size = 32
    end
    object qryPaysIsContractedOut: TStringField
      FieldName = 'IsContractedOut'
      FixedChar = True
      Size = 1
    end
    object qryPaysUKNICsClass1: TFloatField
      FieldName = 'UKNICsClass1'
      currency = True
    end
    object qryPaysUKNICsOther: TFloatField
      FieldName = 'UKNICsOther'
      currency = True
    end
    object qryPaysUKEmployerNICsClass1: TFloatField
      FieldName = 'UKEmployerNICsClass1'
      currency = True
    end
    object qryPaysUKEmployerNICsOther: TFloatField
      FieldName = 'UKEmployerNICsOther'
      currency = True
    end
    object qryPaysRegion: TStringField
      FieldName = 'Region'
    end
  end
  object DSPays: TDataSource
    DataSet = qryPays
    Left = 504
  end
  object qryLeavePayTypes: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select TypeID,Description'
      'FROM tblPayRateType')
    Left = 635
    Top = 2
  end
  object qryLeaveTypes: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT LeaveTypeID,LeaveType FROM tblleavetypes WHERE Active = '#39 +
        'T'#39)
    Left = 673
    Top = 2
  end
  object qryPaysLeave: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblPaysLeave'
      'Where PayID=:xPayID;')
    Left = 719
    Top = 2
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPaysLeaveDateTaken: TDateField
      DisplayLabel = 'Date Taken'
      DisplayWidth = 10
      FieldName = 'DateTaken'
    end
    object qryPaysLeaveLeaveType: TStringField
      FieldName = 'LeaveType'
      Size = 255
    end
    object qryPaysLeaveQty: TFloatField
      DisplayLabel = 'Hours'
      DisplayWidth = 7
      FieldName = 'Qty'
    end
    object qryPaysLeaveLeavePayType: TStringField
      DisplayLabel = 'Pay Type'
      DisplayWidth = 16
      FieldName = 'LeavePayType'
      Visible = False
      FixedChar = True
      Size = 24
    end
    object qryPaysLeaveAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
      currency = True
    end
    object qryPaysLeavelookupJob: TStringField
      DisplayLabel = 'Job'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'lookupJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Visible = False
      Size = 25
      Lookup = True
    end
    object qryPaysLeaveGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPaysLeavePayLeaveID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'PayLeaveID'
      ReadOnly = True
      Visible = False
    end
    object qryPaysLeavePayID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayID'
      Visible = False
    end
    object qryPaysLeaveClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryPaysLeaveClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryPaysLeaveEditedFlag: TStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPaysLeaveClassName: TStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryPaysLeaveSuperInc: TStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPaysLeaveIsCertified: TStringField
      FieldName = 'IsCertified'
      FixedChar = True
      Size = 1
    end
  end
  object dsPaysLeave: TDataSource
    DataSet = qryPaysLeave
    Left = 745
    Top = 11
  end
  object qryEmployeePaySettings: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblemployeepaysettings WHERE EmployeeID =:xID;')
    Left = 816
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
  end
  object qryPaysBenefits: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblpaysukbenefits')
    Left = 768
    object qryPaysBenefitsPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPaysBenefitsDescription: TStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryPaysBenefitsIsNICsPayable: TStringField
      FieldName = 'IsNICsPayable'
      FixedChar = True
      Size = 1
    end
    object qryPaysBenefitsNICsClass: TStringField
      FieldName = 'NICsClass'
      Size = 32
    end
    object qryPaysBenefitsAmount: TFloatField
      FieldName = 'Amount'
    end
    object qryPaysBenefitsEmployeeNICAmount: TFloatField
      FieldName = 'EmployeeNICAmount'
    end
    object qryPaysBenefitsEmployerNICAmount: TFloatField
      FieldName = 'EmployerNICAmount'
    end
    object qryPaysBenefitsBenefitReceivedFrom: TStringField
      FieldName = 'BenefitReceivedFrom'
      Size = 255
    end
    object qryPaysBenefitsBenefitOrExpense: TStringField
      FieldName = 'BenefitOrExpense'
      FixedChar = True
      Size = 15
    end
  end
  object DBpaysbenefits: TDataSource
    DataSet = qryPaysBenefits
    Left = 792
  end
  object qryPaydeductions: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblpaysdeductions'
      'Where PayID=:xPayID;')
    Left = 162
    Top = 266
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPaydeductionsPayDeductionID: TAutoIncField
      FieldName = 'PayDeductionID'
      ReadOnly = True
    end
    object qryPaydeductionsPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPaydeductionsDeductionID: TIntegerField
      FieldName = 'DeductionID'
    end
    object qryPaydeductionsNotes: TStringField
      FieldName = 'Notes'
      Size = 50
    end
    object qryPaydeductionsQty: TFloatField
      FieldName = 'Qty'
    end
    object qryPaydeductionsAmount: TFloatField
      FieldName = 'Amount'
      DisplayFormat = '0.00'
    end
    object qryPaydeductionsCalcBy: TStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsUnionFees: TStringField
      FieldName = 'UnionFees'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsTaxExempt: TStringField
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsDeduction: TStringField
      FieldKind = fkLookup
      FieldName = 'Deduction'
      LookupDataSet = qryDeductions
      LookupKeyFields = 'DeductionID'
      LookupResultField = 'Description'
      KeyFields = 'DeductionID'
      Lookup = True
    end
    object qryPaydeductionsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPaydeductionsClassName: TStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryPaydeductionsBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryPaydeductionsBasedOn: TStringField
      FieldKind = fkLookup
      FieldName = 'BasedOn'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 25
      Lookup = True
    end
    object qryPaydeductionsMoneyAmount: TFloatField
      FieldName = 'MoneyAmount'
    end
  end
  object DSPayDeductions: TDataSource
    DataSet = qryPaydeductions
    Left = 162
    Top = 298
  end
  object qryDeductions: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select DeductionID, Description, BasedOnID, TaxExempt, UnionFees' +
        ', CalcBy, Amount'
      'FROM tblDeductions')
    Left = 215
    Top = 266
  end
  object qryBasedOn: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 167
    Top = 201
    object qryBasedOnBasedOn: TStringField
      DisplayWidth = 25
      FieldName = 'BasedOn'
      Size = 25
    end
    object qryBasedOnBasedOnID: TAutoIncField
      FieldName = 'BasedOnID'
      ReadOnly = True
      Visible = False
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 640
    Top = 472
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer2Timer
    Left = 680
    Top = 472
  end
  object DSPayAllowances: TDataSource
    DataSet = qryPayAllowances
    Left = 266
    Top = 298
  end
  object qryPayAllowances: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblpaysallowances'
      'Where PayID=:xPayID;')
    Left = 264
    Top = 267
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPayAllowancesPayAllowanceID: TAutoIncField
      FieldName = 'PayAllowanceID'
      ReadOnly = True
    end
    object qryPayAllowancesPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPayAllowancesAllowanceID: TIntegerField
      FieldName = 'AllowanceID'
    end
    object qryPayAllowancesQty: TFloatField
      FieldName = 'Qty'
    end
    object qryPayAllowancesAmount: TFloatField
      FieldName = 'Amount'
    end
    object qryPayAllowancesCalcBy: TStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryPayAllowancesSuperInc: TStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPayAllowancesTaxExempt: TStringField
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryPayAllowancesClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryPayAllowancesClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPayAllowancesAllowance: TStringField
      FieldKind = fkLookup
      FieldName = 'Allowance'
      LookupDataSet = qryAllowances
      LookupKeyFields = 'AllowanceID'
      LookupResultField = 'Description'
      KeyFields = 'AllowanceID'
      Lookup = True
    end
    object qryPayAllowancesAllowanceJob: TStringField
      FieldKind = fkLookup
      FieldName = 'AllowanceJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryPayAllowancesLineTotal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'LineTotal'
      Calculated = True
    end
    object qryPayAllowancesClassName: TStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryPayAllowancesBasedOn: TStringField
      FieldKind = fkLookup
      FieldName = 'BasedOn'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 25
      Lookup = True
    end
    object qryPayAllowancesBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryPayAllowancesMoneyAmount: TFloatField
      FieldName = 'MoneyAmount'
    end
  end
  object qryAllowances: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AllowanceID, Description, SuperInc, TaxExempt, PayrollTax' +
        'Exempt, '
      
        'WorkcoverExempt, DisplayIn, Amount, Percentage, BasedOnID, Activ' +
        'e,'
      'Percentage AS Qty, CalcBy'
      'FROM tblAllowances'
      'WHERE Active='#39'T'#39
      ''
      '')
    Left = 263
    Top = 224
    object qryAllowancesDescription: TStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Size = 150
    end
    object qryAllowancesAllowanceID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AllowanceID'
      ReadOnly = True
      Visible = False
    end
    object qryAllowancesSuperInc: TStringField
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesTaxExempt: TStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Visible = False
    end
    object qryAllowancesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
    end
    object qryAllowancesBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
    object qryAllowancesCalcBy: TStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
  end
end
