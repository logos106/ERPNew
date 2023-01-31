inherited NegativePOBOGUI: TNegativePOBOGUI
  Left = 127
  Top = 312
  HelpContext = 747000
  Caption = 'Negative Purchase Orders'
  PixelsPerInch = 96
  TextHeight = 13
  inherited HeaderPanel: TPanel
    HelpContext = 747001
    inherited lblFrom: TLabel
      HelpContext = 747002
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 747003
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 747004
      inherited TitleShader: TShader
        HelpContext = 747005
        inherited TitleLabel: TLabel
          HelpContext = 747006
          Caption = 'Negative Purchase Orders'
        end
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 747007
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 747008
      Visible = False
    end
    inherited IgnoreDates: TCheckBox
      HelpContext = 747009
      Visible = False
    end
  end
  inherited Panel1: TPanel
    HelpContext = 747010
    inherited grdMain: TwwDBGrid
      HelpContext = 747011
      Selected.Strings = (
        'Baseno'#9'10'#9'Baseno'#9#9
        'BOID'#9'10'#9'BOID'#9#9
        'Company'#9'20'#9'Company'#9#9
        'PartName'#9'20'#9'PartName'#9#9
        'UnitofMeasurePOLines'#9'10'#9'Unit of Measure'#9#9
        'OriginalQty'#9'10'#9'Original Qty'#9#9
        'PurchaseLineID'#9'10'#9'PurchaseLineID'#9#9
        'Class'#9'10'#9'Class'#9'F'#9
        'Deleted'#9'1'#9'Deleted'#9#9
        'BackOrder'#9'10'#9'Back Order Qty'#9#9
        'RepairID'#9'10'#9'Repair #'#9'F'#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      'SC.ContainerName,'
      '" " as Firstcolumn, '
      '" " as Secondcolumn, '
      '" " as Thirdcolumn,'
      'tblClients.Company as Company,'
      'tblParts.PartName as PartName,'
      'tblPurchaseOrders.BOID as BOID,'
      'tblPurchaseLines.Product_Description AS PurchaseDesc,'
      'tblPurchaseLines.UnitofMeasureQtySold as BackOrder,'
      'tblPurchaseLines.REpairId as RepairID, '
      'tblPurchaseLines.BackOrder as OriginalQty,'
      'tblPurchaseLines.UnitofMeasurePOLines,'
      'tblPurchaseLines.PurchaseLineID as PurchaseLineID,'
      'tblParts.COST1 as PartCost,'
      'tblParts.COST1*tblPurchaseLines.BackOrder AS PartCostAmount,'
      'date(tblPurchaseOrders.OrderDate) as OrderDate,'
      'tblPurchaseOrders.EmployeeName as EmployeeName,'
      'tblPurchaseOrders.SupplierName as SupplierName,'
      'tblPurchaseOrders.baseno as baseno,'
      'tblParts.PARTSID as PARTSID,'
      'tblPurchaseOrders.Comments as Comments,'
      'tblPurchaseOrders.GlobalRef as GlobalRef,'
      'tblPurchaseOrders.OriginalNo as OriginalNo,'
      
        'if (isnull(original.PurchaseOrderNumber) , tblPurchaseOrders.Pur' +
        'chaseOrderNumber, if(isnull(tblPurchaseOrders.SeqNo) ,tblPurchas' +
        'eOrders.PurchaseOrderNumber,concat(tblPurchaseOrders.PurchaseOrd' +
        'erNumber, '#39'('#39' , original.PurchaseOrderNumber , '#39'_'#39' , tblPurchase' +
        'Orders.SeqNo, '#39')'#39')))  as "P/O Num",'
      'tblPurchaseLines.LineCost as LineCost,'
      
        'tblPurchaseLines.LineCost*tblPurchaseLines.BackOrder as LineCost' +
        'Amount,'
      'tblPurchaseLines.ETADate as ETADate,'
      'tblPurchaseLines.CustomField1,'
      'tblPurchaseLines.CustomField2,'
      'tblPurchaseLines.CustomField3,'
      'tblPurchaseLines.CustomField4,'
      'tblPurchaseLines.CustomField5,'
      'tblPurchaseLines.CustomField6,'
      'tblPurchaseLines.CustomField7,'
      'tblPurchaseLines.CustomField8,'
      'tblPurchaseLines.CustomField9,'
      'tblPurchaseLines.CustomField10,'
      'tblPurchaseOrders.PurchaseOrderID as PurchaseOrderID,'
      'tblPurchaseLines.Invoiced as Invoiced,'
      'tblPurchaseLines.Class as Class,'
      'tblPurchaseLines.CustomerJob as CustomerJob,'
      'tblPurchaseOrders.Deleted as Deleted,'
      'tblClients.Phone as Phone,'
      'tblPurchaseOrders.CustPONumber as CustPONumber,'
      'tblPurchaseOrders.Approved, '
      'tblPurchaseLines.RepairID, tblPurchaseLines.Equipmentname'
      'FROM tblPurchaseLines'
      
        'INNER JOIN tblParts ON tblPurchaseLines.ProductID=tblParts.PARTS' +
        'ID'
      
        'INNER JOIN tblPurchaseOrders ON tblPurchaseOrders.PurchaseOrderI' +
        'D=tblPurchaseLines.PurchaseOrderID'
      
        'INNER JOIN tblClients ON tblPurchaseOrders.ClientID= tblClients.' +
        'ClientID'
      
        'LEFT JOIN tblEmployees ON  tblPurchaseOrders.EmployeeID = tblEmp' +
        'loyees.EmployeeID'
      
        'LEFT Join tblPurchaseOrders as original  on original.GlobalRef =' +
        '  tblPurchaseOrders.Originalno'
      
        'LEFT JOIN tblshipcontainerdetails SD ON tblPurchaseLines.Purchas' +
        'eLineId = SD.PurchaseLineId'
      
        'LEFT JOIN tblshippingContainer SC ON SD.ShippingContainerID=SC.S' +
        'hippingContainerid '
      
        '#LEFT  Join `tblsaleslines` SL ON `tblpurchaselines`.`SaleLineID' +
        '` = SL.`baselineno` and (ifnull(SL.shipped,0) = 0  or ifnull(SL.' +
        'backorder,0) =0)'
      
        'WHERE tblPurchaseOrders.IsPO = '#39'T'#39' AND tblPurchaseOrders.Deleted' +
        '='#39'F'#39' and tblPurchaseOrders.OrderDate Between :txtfrom AND :txtto'
      
        'AND ((:Approved = "T" AND tblPurchaseOrders.Approved = "T") OR (' +
        ':Approved = "F")) '
      
        '#AND ((tblPurchaseLines.LineCost*tblPurchaseLines.BackOrder <= :' +
        'EmployeeApprovalValue) OR (:EmployeeApprovalValue = 0))'
      
        'AND (((tblPurchaseLines.LineCost*tblPurchaseLines.BackOrder <= :' +
        'EmployeeApprovalValueH) AND (tblPurchaseLines.LineCost*tblPurcha' +
        'seLines.BackOrder >= :EmployeeApprovalValueL)) OR ((:EmployeeApp' +
        'rovalValueH = 0)OR (tblPurchaseOrders.EnteredBy = :EnteredBy  ))' +
        ')'
      'AND   ifnull(tblPurchaseOrders.BOID , '#39#39') = '#39#39
      'and tblPurchaseLines.UnitofMeasureQtySold <0'
      'GROUP BY tblPurchaseLines.PurchaseLineID')
    Filtered = True
    Filter = 'BackOrder <0'
    Left = 276
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'txtfrom'
      end
      item
        DataType = ftUnknown
        Name = 'txtto'
      end
      item
        DataType = ftUnknown
        Name = 'Approved'
      end
      item
        DataType = ftUnknown
        Name = 'Approved'
      end
      item
        DataType = ftUnknown
        Name = 'EmployeeApprovalValueH'
      end
      item
        DataType = ftUnknown
        Name = 'EmployeeApprovalValueL'
      end
      item
        DataType = ftUnknown
        Name = 'EmployeeApprovalValueH'
      end
      item
        DataType = ftUnknown
        Name = 'EnteredBy'
      end>
    object qryMainBaseno: TWideStringField [0]
      DisplayWidth = 10
      FieldName = 'Baseno'
      Origin = 'tblPurchaseOrders.BaseNo'
      Size = 255
    end
    object qryMainBOID: TWideStringField [1]
      DisplayWidth = 10
      FieldName = 'BOID'
      Origin = 'tblPurchaseOrders.BOID'
      Size = 255
    end
    inherited qryMainCompany: TWideStringField
      DisplayWidth = 20
      Origin = 'tblClients.Company'
    end
    inherited qryMainPartName: TWideStringField
      DisplayWidth = 20
      Origin = 'tblParts.PARTNAME'
    end
    inherited qryMainUnitofMeasurePOLines: TWideStringField [4]
      DisplayWidth = 10
      Origin = 'tblPurchaseLines.UnitofMeasurePOLines'
    end
    inherited qryMainOriginalQty: TFloatField [5]
      Origin = 'tblPurchaseLines.BackOrder'
    end
    inherited qryMainPurchaseLineID: TIntegerField [6]
      AutoGenerateValue = arAutoInc
      Origin = 'tblPurchaseLines.PurchaseLineID'
    end
    inherited qryMainClass: TWideStringField [7]
      DisplayWidth = 10
      Origin = 'tblPurchaseLines.Class'
    end
    inherited qryMainDeleted: TWideStringField [8]
      Origin = 'tblPurchaseOrders.Deleted'
    end
    inherited qryMainBackOrder: TFloatField [9]
      Origin = 'tblPurchaseLines.UnitofMeasureQtySold'
    end
    inherited qryMainRepairID: TIntegerField [10]
      Origin = 'tblPurchaseLines.RepairId'
    end
    inherited qryMainPurchaseDesc: TWideStringField [11]
      Origin = 'tblPurchaseLines.Product_Description'
      Visible = False
    end
    inherited qryMainPartCost: TFloatField [12]
      Origin = 'tblParts.COST1'
      Visible = False
    end
    inherited qryMainPartCostAmount: TFloatField [13]
      Origin = '.PartCostAmount'
      Visible = False
    end
    inherited qryMainLineCost: TFloatField [14]
      Origin = 'tblPurchaseLines.LineCost'
      Visible = False
    end
    inherited qryMainLineCostAmount: TFloatField [15]
      Origin = '.LineCostAmount'
      Visible = False
    end
    inherited qryMainEmployeeName: TWideStringField [16]
      Origin = 'tblPurchaseOrders.EmployeeName'
      Visible = False
    end
    inherited qryMainSupplierName: TWideStringField [17]
      Origin = 'tblPurchaseOrders.SupplierName'
      Visible = False
    end
    inherited qryMainPARTSID: TIntegerField [18]
      AutoGenerateValue = arAutoInc
      Origin = 'tblParts.PARTSID'
      Visible = False
    end
    inherited qryMainComments: TWideStringField [19]
      Origin = 'tblPurchaseOrders.Comments'
      Visible = False
    end
    inherited qryMainGlobalRef: TWideStringField [20]
      Origin = 'tblPurchaseOrders.GlobalRef'
      Visible = False
    end
    inherited qryMainOriginalNo: TWideStringField [21]
      Origin = 'tblPurchaseOrders.OriginalNo'
      Visible = False
    end
    inherited qryMainPONum: TWideStringField [22]
      Origin = '.`P/O Num`'
      Visible = False
      Size = 74
    end
    inherited qryMainETADate: TDateField [23]
      Origin = 'tblPurchaseLines.ETADate'
      Visible = False
    end
    inherited qryMainCustomField1: TWideStringField [24]
      Origin = 'tblPurchaseLines.CustomField1'
      Visible = False
    end
    inherited qryMainCustomField2: TWideStringField [25]
      Origin = 'tblPurchaseLines.CustomField2'
      Visible = False
    end
    inherited qryMainCustomField3: TWideStringField [26]
      Origin = 'tblPurchaseLines.CustomField3'
      Visible = False
    end
    inherited qryMainCustomField4: TWideStringField [27]
      Origin = 'tblPurchaseLines.CustomField4'
      Visible = False
    end
    inherited qryMainCustomField5: TWideStringField [28]
      Origin = 'tblPurchaseLines.CustomField5'
      Visible = False
    end
    inherited qryMainCustomField6: TWideStringField [29]
      Origin = 'tblPurchaseLines.CustomField6'
      Visible = False
    end
    inherited qryMainCustomField7: TWideStringField [30]
      Origin = 'tblPurchaseLines.CustomField7'
      Visible = False
    end
    inherited qryMainCustomField8: TWideStringField [31]
      Origin = 'tblPurchaseLines.CustomField8'
      Visible = False
    end
    inherited qryMainCustomField9: TWideStringField [32]
      Origin = 'tblPurchaseLines.CustomField9'
      Visible = False
    end
    inherited qryMainCustomField10: TWideStringField [33]
      Origin = 'tblPurchaseLines.CustomField10'
      Visible = False
    end
    inherited qryMainPurchaseOrderID: TIntegerField [34]
      AutoGenerateValue = arAutoInc
      Origin = 'tblPurchaseOrders.PurchaseOrderID'
      Visible = False
    end
    inherited qryMainInvoiced: TWideStringField [35]
      Origin = 'tblPurchaseLines.Invoiced'
      Visible = False
    end
    inherited qryMainCustomerJob: TWideStringField [36]
      Origin = 'tblPurchaseLines.CustomerJob'
      Visible = False
    end
    inherited qryMainPhone: TWideStringField [37]
      Origin = 'tblClients.Phone'
      Visible = False
    end
    inherited qryMainCustPONumber: TWideStringField [38]
      Origin = 'tblPurchaseOrders.CustPONumber'
      Visible = False
    end
    inherited qryMainApproved: TWideStringField [39]
      Origin = 'tblPurchaseOrders.Approved'
      Visible = False
    end
    inherited qryMainOrderDate: TDateField [40]
      Origin = '.OrderDate'
      Visible = False
    end
    inherited qryMainContainerName: TWideStringField [41]
      Origin = 'SC.ContainerName'
      Visible = False
    end
    inherited qryMainFirstcolumn: TWideStringField [42]
      Origin = '.Firstcolumn'
      Visible = False
    end
    inherited qryMainSecondcolumn: TWideStringField [43]
      Origin = '.Secondcolumn'
      Visible = False
    end
    inherited qryMainThirdcolumn: TWideStringField [44]
      Origin = '.Thirdcolumn'
      Visible = False
    end
  end
  inherited qryCurrencyConversion: TERPQuery
    Left = 384
  end
end
