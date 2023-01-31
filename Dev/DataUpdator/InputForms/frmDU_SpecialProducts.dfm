inherited fmDU_SpecialProducts: TfmDU_SpecialProducts
  Left = 218
  Top = 192
  Caption = 'Customer Special Products'
  ExplicitLeft = 218
  ExplicitTop = 192
  ExplicitWidth = 840
  ExplicitHeight = 420
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1637002
  inherited pnlMain: TDNMPanel
    HelpContext = 1637006
    inherited pnlTop: TDNMPanel
      HelpContext = 1637007
      inherited Shader1: TShader
        inherited lblCaption: TLabel
          Caption = 'Customer Special Products'
          HelpContext = 1637003
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      HelpContext = 1637008
      inherited grdmain: TwwDBGrid
        ControlType.Strings = (
          'Name;CustomEdit;cboProd;F'
          'IncludeInRun;CheckBox;T;F'
          'UOM;CustomEdit;cboUOM;F'
          'VariationOption;CustomEdit;OptVariation;F'
          'Variationtype;CustomEdit;opttype;F')
        Selected.Strings = (
          'Name'#9'16'#9'Name'#9'F'
          'OrigPrice'#9'12'#9'Original Price (ex)'#9'T'
          'LinePrice'#9'13'#9'Line Price (ex)'#9'F'
          'UOM'#9'17'#9'UOM'#9'F'
          'DateFrom'#9'9'#9'Date From'#9'F'
          'DateTo'#9'9'#9'Date To'#9'F'
          'VariationOption'#9'40'#9'Variation Option'#9'F'
          'Variationtype'#9'25'#9'Variation Type'#9'F'
          'VariationAmt'#9'15'#9'Variation~Amount'#9'F'
          'Description'#9'34'#9'Description'#9'T')
        inherited btnDelete: TwwIButton
          OnClick = btnDeleteClick
        end
      end
      object cboProd: TERPDbLookupCombo
        Left = 376
        Top = 96
        Width = 121
        Height = 23
        HelpContext = 1637004
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'PARTNAME'#9'15'#9'PARTNAME'#9'T'
          'PARTSDESCRIPTION'#9'30'#9'PARTSDESCRIPTION'#9'T')
        DataField = 'Name'
        DataSource = dsmain
        LookupTable = cboProductQry
        LookupField = 'Partname'
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        LookupFormClassName = 'TProductListExpressGUI'
        EditFormClassName = 'TfrmParts'
        LookupFormKeyStringFieldName = 'ProductName'
        LookupComboType = ctProduct
        AllowFullListSearchMode = False
        DisableNotInList = False
        AllowMultipleSelectFromList = True
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        DataIDField = 'ProductID'
        LookupIDField = 'PartsID'
        LookupFieldAlt = 'ProductPrintName'
      end
      object cboUOM: TwwDBLookupCombo
        Left = 153
        Top = 63
        Width = 109
        Height = 23
        HelpContext = 1637005
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Unitname'#9'15'#9'Unit Name'#9'F'
          'multiplier'#9'10'#9'Multiplier'#9'F')
        DataField = 'UOM'
        LookupTable = QryUOM
        LookupField = 'Unitname'
        AutoSelect = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboUOMCloseUp
      end
    end
  end
  inherited dsmain: TDataSource
    DataSet = fmDataUpdator.QrySpecialProducts
  end
  object cboProductQry: TERPQuery
    Connection = fmDataUpdator.MyConnection
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
    Options.LongStrings = False
    Left = 96
    Top = 33
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
  object QryUOM: TERPQuery
    Connection = fmDataUpdator.MyConnection
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, U.Pa' +
        'rtID'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :KeyId'
      'union all '
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, U.Pa' +
        'rtID'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :KeyId  )'
      'Order By UnitID desc ,UnitName;')
    Options.LongStrings = False
    Left = 861
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end
      item
        DataType = ftUnknown
        Name = 'KeyId'
      end>
    object QryUOMUnitname: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'Unitname'
      Origin = '.UnitName'
      Size = 15
    end
    object QryUOMmultiplier: TFloatField
      DisplayLabel = 'Multiplier'
      DisplayWidth = 10
      FieldName = 'multiplier'
      Origin = '.Multiplier'
    end
    object QryUOMUnitId: TIntegerField
      FieldName = 'UnitId'
      Origin = '.UnitID'
      Visible = False
    end
    object QryUOMPartID: TIntegerField
      FieldName = 'PartID'
      Origin = '.PartID'
      Visible = False
    end
  end
end
