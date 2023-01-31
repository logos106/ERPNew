inherited FuncBookingsListGUI: TFuncBookingsListGUI
  Left = 117
  Top = 137
  Caption = 'Function Bookings List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 13037551
  end
  inherited HeaderPanel: TPanel
    Color = 13037551
    inherited pnlHeader: TPanel
      Caption = 'Function Bookings List'
      Color = 13037551
      ParentColor = False
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Current'
          'Converted'
          'All')
      end
      inherited pnlButtons: TPanel
        Color = 13037551
        ParentColor = False
      end
    end
    inherited Panel3: TPanel
      Color = 13037551
      ParentColor = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9'F'#9
        'FuncBookingID'#9'10'#9'FuncBookingID'#9'F'#9
        'Booking'#9'10'#9'Booking'#9'F'#9
        'ClientID'#9'10'#9'ClientID'#9#9
        'StartBooking'#9'22'#9'StartBooking'#9#9
        'EndBooking'#9'22'#9'EndBooking'#9#9
        'Company'#9'80'#9'Company'#9#9
        'BookingDescription'#9'30'#9'Booking Description'#9'F'#9
        'RoomID'#9'10'#9'RoomID'#9#9
        'Function'#9'25'#9'Function'#9'F'#9
        'RoomPrice'#9'10'#9'Rooms'#9#9
        'MealsPrice'#9'10'#9'Meals'#9#9
        'DrinksPrice'#9'10'#9'Drinks'#9#9
        'Extras'#9'10'#9'Extras'#9'F'#9
        'TotalInc'#9'10'#9'Total Inc'#9#9
        'Status1'#9'1'#9'Status1'#9'F'#9
        'Status2'#9'1'#9'Status2'#9'F'#9
        'Status3'#9'1'#9'Status3'#9'F'#9
        'Status4'#9'1'#9'Status4'#9'F'#9
        'Status5'#9'1'#9'Status5'#9'F'#9
        'Status6'#9'1'#9'Status6'#9'F'#9
        'Cancelled'#9'1'#9'Cancelled'#9'F'#9
        'Rescheduled'#9'1'#9'Rescheduled'#9'F'#9
        'Converted'#9'1'#9'Converted'#9'F'#9)
      TitleColor = 13037551
      FooterColor = 14155775
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT tblfuncbookings.GlobalRef, FuncBookingID, FuncBookingID a' +
        's Booking, tblfuncbookings.ClientID, '
      'StartBooking, EndBooking, Converted,'
      'Company,  RoomID,  RoomPrice, BookingDescription,'
      
        'MealsPrice, DrinksPrice, Extras, TotalInc, FuncTypeName as Funct' +
        'ion,'
      'Status1, Status2, Status3, Status4, Status5, Status6, '
      'Cancellation as Cancelled, Reschedulled as Rescheduled'
      'FROM tblfuncbookings'
      'LEFT JOIN tblclients using (ClientID)'
      
        'LEFT JOIN tblfunctypes ON tblfuncbookings.FuncTypeID = tblfuncty' +
        'pes.FuncTypeID')
    object qryMainGlobalRef: TStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainFuncBookingID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FuncBookingID'
      ReadOnly = True
    end
    object qryMainBooking: TAutoIncField
      DisplayWidth = 10
      FieldName = 'Booking'
      ReadOnly = True
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
    end
    object qryMainStartBooking: TDateTimeField
      DisplayWidth = 22
      FieldName = 'StartBooking'
    end
    object qryMainEndBooking: TDateTimeField
      DisplayWidth = 22
      FieldName = 'EndBooking'
    end
    object qryMainCompany: TStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Size = 80
    end
    object qryMainBookingDescription: TStringField
      DisplayLabel = 'Booking Description'
      DisplayWidth = 30
      FieldName = 'BookingDescription'
      Size = 255
    end
    object qryMainRoomID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RoomID'
    end
    object qryMainFunction: TStringField
      DisplayWidth = 25
      FieldName = 'Function'
      Size = 255
    end
    object qryMainRoomPrice: TFloatField
      DisplayLabel = 'Rooms'
      DisplayWidth = 10
      FieldName = 'RoomPrice'
      currency = True
    end
    object qryMainMealsPrice: TFloatField
      DisplayLabel = 'Meals'
      DisplayWidth = 10
      FieldName = 'MealsPrice'
      currency = True
    end
    object qryMainDrinksPrice: TFloatField
      DisplayLabel = 'Drinks'
      DisplayWidth = 10
      FieldName = 'DrinksPrice'
      currency = True
    end
    object qryMainExtras: TFloatField
      DisplayWidth = 10
      FieldName = 'Extras'
      currency = True
    end
    object qryMainTotalInc: TFloatField
      DisplayLabel = 'Total Inc'
      DisplayWidth = 10
      FieldName = 'TotalInc'
      currency = True
    end
    object qryMainStatus1: TStringField
      DisplayWidth = 1
      FieldName = 'Status1'
      FixedChar = True
      Size = 1
    end
    object qryMainStatus2: TStringField
      DisplayWidth = 1
      FieldName = 'Status2'
      FixedChar = True
      Size = 1
    end
    object qryMainStatus3: TStringField
      DisplayWidth = 1
      FieldName = 'Status3'
      FixedChar = True
      Size = 1
    end
    object qryMainStatus4: TStringField
      DisplayWidth = 1
      FieldName = 'Status4'
      FixedChar = True
      Size = 1
    end
    object qryMainStatus5: TStringField
      DisplayWidth = 1
      FieldName = 'Status5'
      FixedChar = True
      Size = 1
    end
    object qryMainStatus6: TStringField
      DisplayWidth = 1
      FieldName = 'Status6'
      FixedChar = True
      Size = 1
    end
    object qryMainCancelled: TStringField
      DisplayWidth = 1
      FieldName = 'Cancelled'
      FixedChar = True
      Size = 1
    end
    object qryMainRescheduled: TStringField
      DisplayWidth = 1
      FieldName = 'Rescheduled'
      FixedChar = True
      Size = 1
    end
    object qryMainConverted: TStringField
      DisplayWidth = 1
      FieldName = 'Converted'
      FixedChar = True
      Size = 1
    end
  end
  inherited qryPersonalPrefs: TMyQuery
    Left = 264
    Top = 8
  end
  object qryFuncStatuses: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblFuncStatuses')
    Left = 368
    object qryFuncStatusesGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryFuncStatusesID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qryFuncStatusesStatus1: TStringField
      FieldName = 'Status1'
      Size = 255
    end
    object qryFuncStatusesStatus2: TStringField
      FieldName = 'Status2'
      Size = 255
    end
    object qryFuncStatusesStatus3: TStringField
      FieldName = 'Status3'
      Size = 255
    end
    object qryFuncStatusesStatus4: TStringField
      FieldName = 'Status4'
      Size = 255
    end
    object qryFuncStatusesStatus5: TStringField
      FieldName = 'Status5'
      Size = 255
    end
    object qryFuncStatusesStatus6: TStringField
      FieldName = 'Status6'
      Size = 255
    end
    object qryFuncStatusesEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
end
