inherited FuncRoomAllocationListGUI: TFuncRoomAllocationListGUI
  Left = 74
  Top = 559
  Caption = 'Function Room Allocation List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 13037551
    inherited cmdClose: TDNMSpeedButton
      Left = 638
    end
    inherited cmdNew: TDNMSpeedButton
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 515
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 393
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 271
    end
  end
  inherited HeaderPanel: TPanel
    Color = 13037551
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'
        'FuncBookingID'#9'10'#9'FuncBookingID'
        'Booking'#9'10'#9'Booking'
        'Date'#9'9'#9'Date'
        'Room'#9'50'#9'Room'#9'F'
        'Company'#9'80'#9'Company'
        'Start'#9'8'#9'Start'
        'End'#9'8'#9'End')
      TitleColor = 13037551
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT RA.GlobalRef, RA.FuncBookingID, RA.FuncBookingID as Booki' +
        'ng, '
      '  DATE_FORMAT(RA.Start, "%d-%b-%y") AS  Date, '
      '  tblfuncrooms.Name as Room, C.Company,   '
      '  DATE_FORMAT(RA.Start, "%h:%i %p") AS Start, '
      '  DATE_FORMAT(RA.End, "%h:%i %p") AS End'
      'FROM tblfuncroomallocation  AS RA'
      'INNER JOIN tblfuncrooms USING (RoomID)'
      
        'INNER JOIN tblfuncbookings AS B ON RA.FuncBookingID = B.FuncBook' +
        'ingID'
      'INNER JOIN tblclients AS C USING (ClientID)'
      'WHERE RA.Start BETWEEN  :xFrom AND  :xTo'
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
