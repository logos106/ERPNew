inherited FuncResourceAllocationListGUI: TFuncResourceAllocationListGUI
  Left = 71
  Top = 529
  Caption = 'Function Resource Allocation List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 12054011
    inherited cmdClose: TDNMSpeedButton
      Left = 635
    end
    inherited cmdNew: TDNMSpeedButton
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 515
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 395
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 276
    end
  end
  inherited HeaderPanel: TPanel
    Color = 12054011
    inherited pnlHeader: TPanel
      Left = 176
      Width = 577
      inherited TitleShader: TShader
        Width = 575
        inherited TitleLabel: TLabel
          Width = 575
        end
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'
        'FuncBookingID'#9'15'#9'FuncBookingID'
        'Booking'#9'15'#9'Booking'
        'Date'#9'9'#9'Date'
        'Room'#9'50'#9'Room'
        'Company'#9'80'#9'Company'
        'Resource'#9'50'#9'Resource'#9'F'
        'Pool'#9'15'#9'Pool'
        'Qty'#9'15'#9'Qty'
        'Start'#9'8'#9'Start'
        'End'#9'8'#9'End')
      TitleColor = 12054011
    end
  end
  inherited wwLocateDialog1: TwwLocateDialog
    Left = 199
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT RES.GlobalRef, RES.FuncBookingID,RES.FuncBookingID as Boo' +
        'king, DATE_FORMAT(RA.Start, "%d-%b-%y") AS  Date, '
      'R.Name as Room, C.Company, '
      
        'RES.ResourceName as Resource, tblfuncresources.Qty as Pool, RES.' +
        'Qty, '
      
        'DATE_FORMAT(RA.Start, "%h:%i %p") AS Start, DATE_FORMAT(RA.End, ' +
        '"%h:%i %p") AS End'
      'FROM tblfuncresourceallocation AS RES'
      'INNER JOIN tblfuncroomallocation  AS RA USING (RoomAllocationID)'
      'INNER JOIN tblfuncrooms AS R USING (RoomID)'
      
        'INNER JOIN tblfuncbookings AS B ON RES.FuncBookingID = B.FuncBoo' +
        'kingID'
      'INNER JOIN tblclients AS C USING (ClientID)'
      
        'INNER JOIN tblfuncresources ON RES.FuncResourceID = tblfuncresou' +
        'rces.FuncResourceID'
      'WHERE RA.Start BETWEEN :xFrom AND :xTo'
      'ORDER BY RA.Start')
    ParamData = <
      item
        DataType = ftString
        Name = 'xFrom'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'xTo'
      end>
  end
end
