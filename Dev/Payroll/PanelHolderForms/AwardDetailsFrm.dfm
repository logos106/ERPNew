inherited frmAwardDetails: TfrmAwardDetails
  Left = 798
  Top = 103
  HelpContext = 564000
  Caption = 'frmAwardDetails'
  ClientHeight = 685
  ClientWidth = 1002
  OldCreateOrder = True
  ExplicitLeft = 798
  ExplicitTop = 103
  ExplicitWidth = 1010
  ExplicitHeight = 712
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 685
    Width = 1002
    ExplicitTop = 685
    ExplicitWidth = 1002
    HelpContext = 564032
  end
  object DNMPanel4: TDNMPanel [4]
    Left = 18
    Top = 239
    Width = 733
    Height = 212
    HelpContext = 564019
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Category = 'AustPayroll'
    DesignSize = (
      733
      212)
    object DNMPanel7: TDNMPanel
      Left = 10
      Top = 8
      Width = 713
      Height = 196
      HelpContext = 564021
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 859
      object Label13: TLabel
        Left = 153
        Top = 24
        Width = 63
        Height = 15
        HelpContext = 564022
        Alignment = taRightJustify
        Caption = 'Super Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 148
        Top = 68
        Width = 68
        Height = 15
        HelpContext = 564023
        Alignment = taRightJustify
        Caption = 'Super Value'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 258
        Top = 111
        Width = 19
        Height = 16
        HelpContext = 564026
        Caption = 'OR'
        Transparent = True
      end
      object Label5: TLabel
        Left = 416
        Top = 24
        Width = 27
        Height = 15
        HelpContext = 564033
        Caption = 'Area'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object SuperType: TDBComboBox
        Left = 229
        Top = 20
        Width = 133
        Height = 23
        HelpContext = 564027
        Style = csDropDownList
        DataField = 'SuperType'
        DataSource = DSAwards
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'Percentage'
          'Amount')
        ParentFont = False
        TabOrder = 0
      end
      object SuperValue: TwwDBEdit
        Left = 229
        Top = 64
        Width = 133
        Height = 23
        HelpContext = 564028
        DataField = 'SuperValue'
        DataSource = DSAwards
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
      object chkDefaultSuperThreshold: TwwCheckBox
        Left = 33
        Top = 112
        Width = 212
        Height = 15
        HelpContext = 564029
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
        Alignment = taLeftJustify
        Caption = 'Use Default Super Threshold'
        DataField = 'UseCompanySuperThreshold'
        DataSource = DSAwards
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = chkDefaultSuperThresholdClick
      end
      object txtSuperThresholdAmount: TwwDBEdit
        Left = 284
        Top = 108
        Width = 78
        Height = 23
        HelpContext = 564030
        DataField = 'SuperThresholdAmount'
        DataSource = DSAwards
        Enabled = False
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
      object chkSuperOnLeaveLoading: TwwCheckBox
        Left = 30
        Top = 156
        Width = 217
        Height = 18
        HelpContext = 564031
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
        Alignment = taLeftJustify
        Caption = 'Pay Super On Leave Loading'
        DataField = 'PaySuperOnLeaveLoading'
        DataSource = DSAwards
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object cboAreaCode: TwwDBLookupCombo
        Left = 448
        Top = 20
        Width = 94
        Height = 23
        HelpContext = 564034
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
        DataSource = DSAwards
        LookupTable = QryAreaCodes
        LookupField = 'AreaCode'
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 18
    Top = 46
    Width = 733
    Height = 188
    HelpContext = 564001
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object DNMPanel2: TDNMPanel
      Left = 10
      Top = 10
      Width = 372
      Height = 168
      HelpContext = 564004
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 41
        Top = 32
        Width = 73
        Height = 15
        HelpContext = 564005
        Alignment = taRightJustify
        Caption = 'Award Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 47
        Top = 83
        Width = 67
        Height = 15
        HelpContext = 564006
        Alignment = taRightJustify
        Caption = 'Department'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 53
        Top = 134
        Width = 61
        Height = 15
        HelpContext = 564007
        Alignment = taRightJustify
        Caption = 'Pay Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object AwardName: TDBEdit
        Left = 120
        Top = 28
        Width = 238
        Height = 23
        HelpContext = 564008
        DataField = 'AwardName'
        DataSource = DSAwards
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = AwardNameExit
      end
      object cboDepartment: TwwDBLookupCombo
        Left = 120
        Top = 78
        Width = 241
        Height = 23
        HelpContext = 564009
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'30'#9'ClassName'#9'F')
        DataField = 'ClassID'
        DataSource = DSAwards
        LookupTable = qryDepartments
        LookupField = 'ClassID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object PayPeriod: TDBComboBox
        Left = 120
        Top = 129
        Width = 167
        Height = 23
        HelpContext = 564010
        Style = csDropDownList
        DataField = 'PayPeriod'
        DataSource = DSAwards
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'Weekly'
          'Fortnightly'
          'Monthly')
        ParentFont = False
        TabOrder = 2
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 388
      Top = 10
      Width = 336
      Height = 168
      HelpContext = 564011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label12: TLabel
        Left = 117
        Top = 30
        Width = 112
        Height = 15
        HelpContext = 564012
        Caption = 'Sick days leave cap'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 128
        Top = 82
        Width = 101
        Height = 15
        HelpContext = 564013
        Caption = 'Meal Break Hours'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 105
        Top = 135
        Width = 124
        Height = 15
        HelpContext = 564014
        Caption = 'Meal Break Threshold'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 107
        Top = 48
        Width = 131
        Height = 15
        HelpContext = 564035
        Caption = '(Leave blank for no cap)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object edSickDaysThreshold: TwwDBEdit
        Left = 245
        Top = 28
        Width = 79
        Height = 23
        HelpContext = 564015
        DataField = 'SickLeaveDaysThreshold'
        DataSource = DSAwards
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
      object edMealBreakHrs: TwwDBEdit
        Left = 245
        Top = 77
        Width = 79
        Height = 23
        HelpContext = 564016
        DataField = 'MealBreakHours'
        DataSource = DSAwards
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
      object edMealBreakThreshold: TwwDBEdit
        Left = 245
        Top = 127
        Width = 79
        Height = 23
        HelpContext = 564017
        DataField = 'MealBreakThreshold'
        DataSource = DSAwards
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
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102009000900010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object DSAwards: TDataSource
    Left = 448
    Top = 2
  end
  object qryDepartments: TERPQuery
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName'
      'FROM tblClass '
      
        'WHERE ((Not IsNull(tblClass.ClassName)) And (tblClass.Active<>'#39'F' +
        #39'))'
      'OR (tblClass.ClassID= :xClassID )'
      'ORDER BY tblClass.ClassName; ')
    Left = 492
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClassID'
      end>
  end
  object QryAreaCodes: TERPQuery
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 431
    Top = 250
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
