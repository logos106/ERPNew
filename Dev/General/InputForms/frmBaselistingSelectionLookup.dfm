inherited fmBaselistingSelectionLookup: TfmBaselistingSelectionLookup
  Left = 1033
  Top = 311
  HelpContext = 1261002
  ClientWidth = 350
  ExplicitLeft = 1033
  ExplicitTop = 311
  ExplicitWidth = 366
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Width = 350
    HelpContext = 1261007
    ExplicitWidth = 350
  end
  object pnl: TPanel [4]
    AlignWithMargins = True
    Left = 6
    Top = 8
    Width = 200
    Height = 50
    HelpContext = 1261003
    Margins.Left = 1
    Margins.Right = 1
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object lblTitle: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 190
      Height = 16
      HelpContext = 1261004
      Align = alTop
      AutoSize = False
      Caption = 'Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 265
    end
    object Panel1: TPanel
      Left = 2
      Top = 24
      Width = 191
      Height = 24
      HelpContext = 1261008
      Margins.Left = 1
      Margins.Right = 1
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        191
        24)
      object cbo: TwwDBLookupCombo
        Left = 0
        Top = 0
        Width = 145
        Height = 23
        HelpContext = 1261006
        Anchors = [akLeft, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'60'#9'Name'#9'F')
        DataField = 'Class'
        LookupTable = cboQry
        LookupField = 'Name'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboCloseUp
      end
      object chkAll: TwwCheckBox
        Left = 150
        Top = 5
        Width = 37
        Height = 13
        HelpContext = 1261005
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Anchors = [akRight]
        Caption = 'All'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = chkAllClick
      end
    end
  end
  object cboQry: TERPQuery
    SQL.Strings = (
      'SELECT EmployeeId as ID, employeeName as Name'
      'FROM tblemployees'
      'WHERE employeeName Is Not Null '
      
        'And (Active<>'#39'F'#39' or :ShowInactive ="T" or EmployeeId = :Employee' +
        'Id )'
      'ORDER BY employeeName;')
    Left = 14
    Top = 28
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ShowInactive'
      end
      item
        DataType = ftUnknown
        Name = 'EmployeeId'
      end>
    object cboQryName: TWideStringField
      DisplayWidth = 60
      FieldName = 'Name'
      Size = 60
    end
    object cboQryID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'Id'
      Visible = False
    end
  end
end
