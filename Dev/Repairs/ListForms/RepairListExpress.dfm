inherited RepairListExpressGUI: TRepairListExpressGUI
  Left = 1428
  Top = 145
  Caption = 'Repair Express List'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 866001
  inherited HeaderPanel: TPanel
    HelpContext = 866006
    inherited pnlHeader: TPanel
      Left = 281
      Width = 422
      ExplicitLeft = 281
      ExplicitWidth = 422
      HelpContext = 866002
      inherited TitleShader: TShader
        Width = 420
        ExplicitWidth = 420
        HelpContext = 866003
        inherited TitleLabel: TLabel
          Width = 420
          Caption = 'Repair Express List'
          ExplicitWidth = 420
          HelpContext = 866004
        end
      end
    end
    inherited chkIgnoreDates: TCheckBox
      Visible = True
    end
  end
  inherited Panel1: TPanel
    HelpContext = 866007
    inherited lblDateComments: TLabel
      Width = 998
      HelpContext = 866005
    end
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Converted;CheckBox;T;F'
        'Done;CheckBox;T;F'
        'UseBillCust;CheckBox;T;F')
      Selected.Strings = (
        'RepairID'#9'10'#9'ID'#9#9
        'CustomerName'#9'20'#9'Customer'#9#9
        'RepairDocNo'#9'10'#9'Doc No'#9#9
        'CreationDate'#9'12'#9'Creation~Date'#9#9
        'Done'#9'1'#9'Done?'#9#9
        'Phone'#9'10'#9'Phone'#9#9
        'Mobile'#9'10'#9'Mobile'#9#9
        'Converted'#9'1'#9'Converted?'#9#9
        'Status'#9'11'#9'Status'#9#9
        'CustomerPONumber'#9'10'#9'Customer~PO Number'#9#9
        'JobDueDate'#9'12'#9'Job Due~Date'#9#9
        'CompletionTime'#9'10'#9'Completion~Time'#9#9
        'UseBillCust'#9'1'#9'Bill Customer Different?'#9'F'#9)
      TitleLines = 2
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '
      'RepairID as RepairID, '
      'CustomerName as CustomerName, '
      'RepairDocNo as RepairDocNo, '
      'CreationDate as CreationDate, '
      'Done as Done, '
      'Phone as Phone, '
      'Mobile as Mobile, '
      'Converted as Converted, '
      'Status as Status, '
      'CustomerPONumber as CustomerPONumber, '
      'JobDueDate as JobDueDate, '
      'CompletionTime as CompletionTime,'
      'UseBillCust as UseBillCust'
      'from tblrepairs'
      
        'Where ((CreationDate Between   :dtfrom and  :dtto) or (isnull(Cr' +
        'eationDate)) or (CreationDate='#39'1899-12-30'#39' ) )'
      'and (CusId = :CustomerID or :CustomerID=0)'
      ' and Cancelled = "F"'
      'Order by  RepairID desc')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dtfrom'
      end
      item
        DataType = ftUnknown
        Name = 'dtto'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end
      item
        DataType = ftUnknown
        Name = 'CustomerID'
      end>
    object qryMainRepairID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'ID'
      DisplayWidth = 10
      FieldName = 'RepairID'
      Origin = 'tblrepairs.RepairID'
    end
    object qryMainCustomerName: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 20
      FieldName = 'CustomerName'
      Origin = 'tblrepairs.CustomerName'
      Size = 255
    end
    object qryMainRepairDocNo: TWideStringField
      DisplayLabel = 'Doc No'
      DisplayWidth = 10
      FieldName = 'RepairDocNo'
      Origin = 'tblrepairs.RepairDocNo'
      Size = 50
    end
    object qryMainCreationDate: TDateField
      DisplayLabel = 'Creation~Date'
      DisplayWidth = 12
      FieldName = 'CreationDate'
      Origin = 'tblrepairs.CreationDate'
    end
    object qryMainDone: TWideStringField
      DisplayLabel = 'Done?'
      DisplayWidth = 1
      FieldName = 'Done'
      Origin = 'tblrepairs.Done'
      FixedChar = True
      Size = 1
    end
    object qryMainPhone: TWideStringField
      DisplayWidth = 10
      FieldName = 'Phone'
      Origin = 'tblrepairs.Phone'
      Size = 30
    end
    object qryMainMobile: TWideStringField
      DisplayWidth = 10
      FieldName = 'Mobile'
      Origin = 'tblrepairs.Mobile'
      Size = 50
    end
    object qryMainConverted: TWideStringField
      DisplayLabel = 'Converted?'
      DisplayWidth = 1
      FieldName = 'Converted'
      Origin = 'tblrepairs.Converted'
      FixedChar = True
      Size = 1
    end
    object qryMainStatus: TWideStringField
      DisplayWidth = 11
      FieldName = 'Status'
      Origin = 'tblrepairs.Status'
      Size = 100
    end
    object qryMainCustomerPONumber: TWideStringField
      DisplayLabel = 'Customer~PO Number'
      DisplayWidth = 10
      FieldName = 'CustomerPONumber'
      Origin = 'tblrepairs.CustomerPONumber'
      Size = 255
    end
    object qryMainJobDueDate: TDateTimeField
      DisplayLabel = 'Job Due~Date'
      DisplayWidth = 12
      FieldName = 'JobDueDate'
      Origin = 'tblrepairs.JobDueDate'
    end
    object qryMainCompletionTime: TWideStringField
      DisplayLabel = 'Completion~Time'
      DisplayWidth = 10
      FieldName = 'CompletionTime'
      Origin = 'tblrepairs.CompletionTime'
      Size = 255
    end
    object qryMainUseBillCust: TWideStringField
      DisplayLabel = 'Bill Customer Different?'
      DisplayWidth = 1
      FieldName = 'UseBillCust'
      FixedChar = True
      Size = 1
    end
  end
end
