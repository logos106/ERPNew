inherited CustomerEquipmentGUI: TCustomerEquipmentGUI
  Left = 84
  Top = 479
  Caption = 'Customer Equipment'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
    end
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'Customer Equipment Report'
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Notes;RichEdit;;F')
      Selected.Strings = (
        'CompanyName'#9'80'#9'CompanyName'#9#9
        'JobName'#9'39'#9'JobName'#9#9
        'JobNumber'#9'10'#9'JobNumber'#9#9
        'EquipmentName'#9'50'#9'EquipmentName'#9#9
        'Description'#9'255'#9'Description'#9#9
        'Notes'#9'10'#9'Notes'#9#9
        'IsJob'#9'1'#9'IsJob'#9#9
        'id'#9'10'#9'id'#9#9
        'EquipmentID'#9'10'#9'EquipmentID'#9#9
        'ClientID'#9'10'#9'ClientID'#9#9)
      TitleColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      
        'SELECT If(InStr(C.Company,'#39'^'#39') -1 >0,Left(C.Company,InStr(C.Comp' +
        'any,'#39'^'#39')-1),C.Company) AS'
      'CompanyName, JobName, JobNumber,'
      'EquipmentName, Description, tblcustomerequip.Notes ,IsJob,'
      'id, tblcustomerequip.EquipmentID, tblcustomerequip.ClientID'
      'FROM tblcustomerequip'
      'INNER JOIN tblClients C Using(ClientID)'
      
        'INNER JOIN tblEquipment  ON tblEquipment.EquipmentID=tblcustomer' +
        'equip.EquipmentID'
      'WHERE Customer='#39'T'#39' '
      'ORDER BY C.Company, JobName;')
  end
end
