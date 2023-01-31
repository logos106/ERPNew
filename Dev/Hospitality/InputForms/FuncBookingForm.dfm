inherited FuncBookingGUI: TFuncBookingGUI
  Left = 120
  Top = 118
  Caption = 'Function Booking'
  ClientHeight = 570
  ClientWidth = 1002
  OldCreateOrder = True
  DesignSize = (
    1002
    570)
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel4: TDNMPanel [1]
    Left = 871
    Top = 49
    Width = 131
    Height = 514
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel10: TBevel
      Left = 14
      Top = 1
      Width = 107
      Height = 187
      Shape = bsFrame
    end
    object Bevel11: TBevel
      Left = 14
      Top = 198
      Width = 107
      Height = 121
      Shape = bsFrame
    end
    object Bevel12: TBevel
      Left = 14
      Top = 333
      Width = 107
      Height = 118
      Shape = bsFrame
    end
    object Bevel13: TBevel
      Left = 14
      Top = 469
      Width = 107
      Height = 44
      Shape = bsFrame
    end
    object cmdNew: TDNMSpeedButton
      Left = 23
      Top = 44
      Width = 87
      Height = 27
      Hint = '"Save This Appointment And Open A New Appointment"'
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = cmdNewClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 23
      Top = 80
      Width = 87
      Height = 27
      Hint = '"Print This Appointment"'
      Caption = 'Prin&t'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = cmdPrintClick
    end
    object cmdEmail: TDNMSpeedButton
      Left = 23
      Top = 246
      Width = 87
      Height = 27
      Hint = '"Send This Appointment Via Email To The Customer"'
      Caption = '&E-mail'
      DisableTransparent = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = cmdEmailClick
    end
    object btnCompleted: TDNMSpeedButton
      Left = 23
      Top = 8
      Width = 87
      Height = 27
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 23
      Top = 152
      Width = 87
      Height = 27
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      OnClick = btnCloseClick
    end
    object btnRepeat: TDNMSpeedButton
      Left = 23
      Top = 116
      Width = 87
      Height = 27
      Hint = '"Repeat This Room Booking"'
      Caption = 'Repeat'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnRepeatClick
    end
    object btnFax: TDNMSpeedButton
      Left = 23
      Top = 282
      Width = 87
      Height = 27
      Hint = '"Fax the Customer"'
      Caption = '&Fax'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 7
      OnClick = btnFaxClick
    end
    object btnInvoice: TDNMSpeedButton
      Left = 23
      Top = 379
      Width = 87
      Height = 27
      Hint = '"Convert Booking to Invoice"'
      Caption = 'Invoice'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = btnInvoiceClick
    end
    object btnPos: TDNMSpeedButton
      Left = 23
      Top = 343
      Width = 87
      Height = 27
      Hint = '"Covert Booking to POS"'
      Caption = 'POS'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnPosClick
    end
    object btnLetter: TDNMSpeedButton
      Left = 23
      Top = 210
      Width = 87
      Height = 27
      Hint = '"Create Letter to Customer"'
      Caption = '&Letter'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnLetterClick
    end
    object btnSortMeals: TDNMSpeedButton
      Left = 23
      Top = 478
      Width = 87
      Height = 27
      Hint = '"Sort Meals & Beverages in Order"'
      Caption = 'Sort Meals'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = btnSortMealsClick
    end
    object btnConvert2SalesOrder: TDNMSpeedButton
      Left = 23
      Top = 414
      Width = 87
      Height = 27
      Hint = '"Convert Booking to Sales Order"'
      Caption = 'Sales Order'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = btnInvoiceClick
    end
  end
  object DNMPanel5: TDNMPanel [2]
    Left = 0
    Top = 49
    Width = 9
    Height = 514
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object DNMPanel6: TDNMPanel [3]
    Left = 0
    Top = 563
    Width = 1002
    Height = 7
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object pageControlMain: TPageControl [4]
    Left = 9
    Top = 49
    Width = 862
    Height = 514
    ActivePage = tabRooms
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabHeight = 26
    TabIndex = 1
    TabOrder = 0
    TabWidth = 429
    OnChange = pageControlMainChange
    OnChanging = pageControlMainChanging
    object tabBooking: TTabSheet
      Caption = 'Booking'
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 854
        Height = 478
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel2: TBevel
          Left = 12
          Top = 34
          Width = 277
          Height = 231
          Shape = bsFrame
        end
        object Bevel14: TBevel
          Left = 74
          Top = 72
          Width = 206
          Height = 23
        end
        object Bevel7: TBevel
          Left = 585
          Top = 5
          Width = 263
          Height = 469
          Shape = bsFrame
        end
        object Bevel8: TBevel
          Left = 12
          Top = 266
          Width = 181
          Height = 98
          Shape = bsFrame
        end
        object Bevel4: TBevel
          Left = 12
          Top = 367
          Width = 566
          Height = 48
          Shape = bsFrame
        end
        object Label7: TLabel
          Left = 12
          Top = 50
          Width = 58
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Company'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label15: TLabel
          Left = 22
          Top = 100
          Width = 48
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Details'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Cus_Alt_PH_Label: TLabel
          Left = 14
          Top = 206
          Width = 57
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Alt Phone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label6: TLabel
          Left = 27
          Top = 180
          Width = 41
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Phone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Start_Time_Label: TLabel
          Left = 23
          Top = 269
          Width = 34
          Height = 16
          AutoSize = False
          Caption = 'Start'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object End_Time_Label: TLabel
          Left = 22
          Top = 316
          Width = 26
          Height = 17
          AutoSize = False
          Caption = 'End'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label12: TLabel
          Left = 454
          Top = 370
          Width = 49
          Height = 16
          AutoSize = False
          Caption = 'Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label10: TLabel
          Left = 348
          Top = 370
          Width = 44
          Height = 18
          AutoSize = False
          Caption = 'Extras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel5: TBevel
          Left = 200
          Top = 266
          Width = 377
          Height = 98
          Shape = bsFrame
        end
        object lblRescheduledDate: TLabel
          Left = 223
          Top = 291
          Width = 31
          Height = 18
          AutoSize = False
          Caption = 'Date'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblCancellationDate: TLabel
          Left = 222
          Top = 339
          Width = 31
          Height = 17
          AutoSize = False
          Caption = 'Date'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel6: TBevel
          Left = 12
          Top = 419
          Width = 567
          Height = 55
          Shape = bsFrame
        end
        object lblStatus1: TLabel
          Left = 24
          Top = 421
          Width = 153
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Status1'
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
        object lblStatus2: TLabel
          Left = 24
          Top = 437
          Width = 153
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Status2'
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
        object lblStatus3: TLabel
          Left = 24
          Top = 454
          Width = 153
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Status3'
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
        object lblStatus5: TLabel
          Left = 208
          Top = 439
          Width = 122
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Status5'
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
        object lblStatus4: TLabel
          Left = 208
          Top = 422
          Width = 122
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Status4'
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
        object lblStatus6: TLabel
          Left = 208
          Top = 456
          Width = 122
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Status6'
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
        object Label24: TLabel
          Left = 433
          Top = 426
          Width = 88
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Other'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label1: TLabel
          Left = 24
          Top = 370
          Width = 106
          Height = 17
          AutoSize = False
          Caption = 'Rooms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label19: TLabel
          Left = 132
          Top = 370
          Width = 34
          Height = 15
          Caption = 'Meals'
          Transparent = True
        end
        object Label20: TLabel
          Left = 239
          Top = 370
          Width = 61
          Height = 15
          Caption = 'Beverages'
          Transparent = True
        end
        object Label4: TLabel
          Left = 597
          Top = 16
          Width = 96
          Height = 15
          Caption = 'Rooms Allocated'
          Transparent = True
        end
        object Label5: TLabel
          Left = 766
          Top = 16
          Width = 48
          Height = 15
          Caption = 'Persons'
          Transparent = True
        end
        object Label8: TLabel
          Left = 605
          Top = 168
          Width = 34
          Height = 15
          Caption = 'Meals'
          Transparent = True
        end
        object Label11: TLabel
          Left = 784
          Top = 168
          Width = 19
          Height = 15
          Caption = 'Qty'
          Transparent = True
        end
        object Label22: TLabel
          Left = 384
          Top = 269
          Width = 33
          Height = 15
          Caption = 'Notes'
          Transparent = True
        end
        object lblRoomName: TDBText
          Left = 640
          Top = 168
          Width = 137
          Height = 17
          DataField = 'RoomNameLookup'
          DataSource = dsAllocRooms
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          ParentFont = False
          Transparent = True
        end
        object Fax: TLabel
          Left = 48
          Top = 232
          Width = 20
          Height = 15
          Caption = 'Fax'
          Transparent = True
        end
        object Label25: TLabel
          Left = 311
          Top = 9
          Width = 78
          Height = 15
          Caption = 'Function Type'
          Transparent = True
        end
        object Label3: TLabel
          Left = 20
          Top = 75
          Width = 48
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Contact'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblContact: TDBText
          Left = 79
          Top = 76
          Width = 194
          Height = 17
          DataField = 'Contact'
          DataSource = DSFuncBookings
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Bevel15: TBevel
          Left = 12
          Top = 2
          Width = 277
          Height = 30
          Shape = bsFrame
        end
        object Label29: TLabel
          Left = 37
          Top = 9
          Width = 33
          Height = 15
          Caption = 'Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel9: TBevel
          Left = 299
          Top = 2
          Width = 278
          Height = 30
          Shape = bsFrame
        end
        object Label2: TLabel
          Left = 213
          Top = 269
          Width = 67
          Height = 15
          Caption = 'Reschedule'
          Transparent = True
        end
        object Label30: TLabel
          Left = 209
          Top = 317
          Width = 70
          Height = 15
          Caption = 'Cancellation'
          Transparent = True
        end
        object edtAltPhone: TDBEdit
          Left = 74
          Top = 203
          Width = 121
          Height = 23
          DataField = 'AltPhone'
          DataSource = DSFuncBookings
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object cboClient: TwwDBLookupCombo
          Left = 74
          Top = 46
          Width = 177
          Height = 23
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ControlType.Strings = (
            'StopCreditImage;ImageIndex;Shrink To Fit')
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'80'#9'Company'#9'T'
            'StopCreditImage'#9'3'#9'StopCreditImage'#9'T')
          DataField = 'ClientID'
          DataSource = DSFuncBookings
          LookupTable = qryClientsLookup
          LookupField = 'ClientID'
          Options = [loColLines, loSearchOnBackspace]
          DropDownWidth = 600
          ImageList = imgCredit
          ParentFont = False
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboClientCloseUp
        end
        object edtClientDetails: TDBMemo
          Left = 74
          Top = 98
          Width = 207
          Height = 76
          DataField = 'CustomerDetails'
          DataSource = DSFuncBookings
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnEnter = edtClientDetailsEnter
        end
        object edtPhone: TDBEdit
          Left = 74
          Top = 177
          Width = 121
          Height = 23
          DataField = 'Phone'
          DataSource = DSFuncBookings
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object edtTotal: TDBEdit
          Left = 455
          Top = 386
          Width = 89
          Height = 23
          DataField = 'TotalInc'
          DataSource = DSFuncBookings
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 22
        end
        object edtExtrasPrice: TDBEdit
          Left = 347
          Top = 386
          Width = 89
          Height = 23
          DataField = 'Extras'
          DataSource = DSFuncBookings
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
        end
        object cboRescheduledDate: TwwDBDateTimePicker
          Left = 262
          Top = 288
          Width = 116
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'RescheduledDate'
          DataSource = DSFuncBookings
          Epoch = 1950
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 15
          UnboundDataType = wwDTEdtDate
        end
        object cboCancellationDate: TwwDBDateTimePicker
          Left = 263
          Top = 336
          Width = 116
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'CancellationDate'
          DataSource = DSFuncBookings
          Epoch = 1950
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 16
          UnboundDataType = wwDTEdtDate
        end
        object edtOther: TDBEdit
          Left = 439
          Top = 444
          Width = 104
          Height = 23
          DataField = 'Othertxt'
          DataSource = DSFuncBookings
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 30
        end
        object chkStatus1: TwwCheckBox
          Left = 181
          Top = 422
          Width = 16
          Height = 14
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
          Color = 13686993
          DataField = 'Status1'
          DataSource = DSFuncBookings
          ParentColor = False
          TabOrder = 23
          Visible = False
        end
        object chkStatus2: TwwCheckBox
          Left = 181
          Top = 438
          Width = 16
          Height = 14
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
          Color = 13686993
          DataField = 'Status2'
          DataSource = DSFuncBookings
          ParentColor = False
          TabOrder = 24
          Visible = False
        end
        object chkStatus3: TwwCheckBox
          Left = 181
          Top = 455
          Width = 16
          Height = 14
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
          Color = 13686993
          DataField = 'Status3'
          DataSource = DSFuncBookings
          ParentColor = False
          TabOrder = 25
          Visible = False
        end
        object chkStatus4: TwwCheckBox
          Left = 334
          Top = 424
          Width = 16
          Height = 14
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
          Color = 13686993
          DataField = 'Status4'
          DataSource = DSFuncBookings
          ParentColor = False
          TabOrder = 26
          Visible = False
        end
        object chkStatus6: TwwCheckBox
          Left = 334
          Top = 456
          Width = 16
          Height = 14
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
          Color = 13686993
          DataField = 'Status6'
          DataSource = DSFuncBookings
          ParentColor = False
          TabOrder = 28
          Visible = False
        end
        object chkOther: TwwCheckBox
          Left = 526
          Top = 426
          Width = 16
          Height = 16
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
          Color = 13686993
          DataField = 'Other'
          DataSource = DSFuncBookings
          ParentColor = False
          TabOrder = 29
        end
        object chkStatus5: TwwCheckBox
          Left = 334
          Top = 440
          Width = 16
          Height = 14
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
          Color = 13686993
          DataField = 'Status4'
          DataSource = DSFuncBookings
          ParentColor = False
          TabOrder = 27
          Visible = False
        end
        object edtRoomPrice: TwwDBEdit
          Left = 23
          Top = 386
          Width = 89
          Height = 23
          DataField = 'RoomPrice'
          DataSource = DSFuncBookings
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object dtpStart: TwwDBDateTimePicker
          Left = 21
          Top = 288
          Width = 93
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'StartBooking'
          DataSource = DSFuncBookings
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MinDate = 37622
          Interval.MinutesInterval = 30
          ParentFont = False
          ShowButton = True
          TabOrder = 9
          DisplayFormat = 'dd-mmm-yy'
        end
        object dtpEnd: TwwDBDateTimePicker
          Left = 21
          Top = 334
          Width = 93
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'EndBooking'
          DataSource = DSFuncBookings
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MinDate = 37622
          Interval.MinutesInterval = 30
          ParentFont = False
          ShowButton = True
          TabOrder = 11
          DisplayFormat = 'dd-mmm-yy'
        end
        object edtMealsPrice: TwwDBEdit
          Left = 131
          Top = 386
          Width = 89
          Height = 23
          DataField = 'MealsPrice'
          DataSource = DSFuncBookings
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object edtDrinksPrice: TwwDBEdit
          Left = 239
          Top = 386
          Width = 89
          Height = 23
          DataField = 'DrinksPrice'
          DataSource = DSFuncBookings
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 20
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object DBCtrlGrid1: TDBCtrlGrid
          Left = 592
          Top = 32
          Width = 245
          Height = 120
          ColCount = 1
          Color = 14155775
          DataSource = dsAllocRooms
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          PanelHeight = 24
          PanelWidth = 229
          ParentColor = False
          ParentFont = False
          TabOrder = 31
          RowCount = 5
          SelectedColor = 10813439
          object lblRoom: TDBText
            Left = 8
            Top = 3
            Width = 161
            Height = 17
            DataField = 'RoomNameLookup'
            DataSource = dsAllocRooms
          end
          object lblNumber: TDBText
            Left = 176
            Top = 3
            Width = 46
            Height = 17
            Alignment = taRightJustify
            DataField = 'NumPersons'
            DataSource = dsAllocRooms
          end
        end
        object DBCtrlGrid2: TDBCtrlGrid
          Left = 595
          Top = 184
          Width = 243
          Height = 270
          ColCount = 1
          Color = 14155775
          DataSource = dsFuncBookingMeals
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          PanelHeight = 30
          PanelWidth = 227
          ParentColor = False
          ParentFont = False
          TabOrder = 32
          RowCount = 9
          object lblMeal: TDBText
            Left = 8
            Top = 3
            Width = 161
            Height = 17
            DataField = 'ProductName'
            DataSource = dsFuncBookingMeals
          end
          object lblQty: TDBText
            Left = 181
            Top = 3
            Width = 38
            Height = 17
            Alignment = taRightJustify
            DataField = 'Qty'
            DataSource = dsFuncBookingMeals
          end
        end
        object DBMemo2: TDBMemo
          Left = 384
          Top = 288
          Width = 177
          Height = 69
          DataField = 'Notes'
          DataSource = DSFuncBookings
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object edtFax: TDBEdit
          Left = 74
          Top = 229
          Width = 121
          Height = 23
          DataField = 'Fax'
          DataSource = DSFuncBookings
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object pnlBillTo: TDNMPanel
          Left = 294
          Top = 32
          Width = 283
          Height = 233
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object Bevel3: TBevel
            Left = 5
            Top = 2
            Width = 278
            Height = 231
            Shape = bsFrame
          end
          object Label9: TLabel
            Left = 13
            Top = 44
            Width = 58
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Company'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label23: TLabel
            Left = 24
            Top = 69
            Width = 48
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Details'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label26: TLabel
            Left = 29
            Top = 149
            Width = 41
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Phone'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label27: TLabel
            Left = 16
            Top = 176
            Width = 57
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Alt Phone'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label28: TLabel
            Left = 50
            Top = 202
            Width = 20
            Height = 15
            Caption = 'Fax'
            Enabled = False
            Transparent = True
          end
          object lblBillTo: TLabel
            Left = 42
            Top = 16
            Width = 177
            Height = 15
            Caption = 'Use this Customer for Invoicing'
            Transparent = True
          end
          object cboBillClient: TwwDBLookupCombo
            Left = 75
            Top = 40
            Width = 199
            Height = 23
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ControlType.Strings = (
              'StopCreditImage;ImageIndex;Shrink To Fit')
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Company'#9'30'#9'Company'#9'T'
              'StopCreditImage'#9'10'#9'StopCreditImage'#9'T')
            DataField = 'BillToClientID'
            DataSource = DSFuncBookings
            LookupTable = qryClientsLookup
            LookupField = 'ClientID'
            Options = [loColLines, loSearchOnBackspace]
            DropDownWidth = 150
            Enabled = False
            ParentFont = False
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            AllowClearKey = False
            OnCloseUp = cboBillClientCloseUp
          end
          object edtBillClientDetails: TDBMemo
            Left = 75
            Top = 66
            Width = 197
            Height = 78
            DataField = 'BillToDetails'
            DataSource = DSFuncBookings
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object edtBillPhone: TDBEdit
            Left = 75
            Top = 147
            Width = 121
            Height = 23
            DataField = 'BillPhone'
            DataSource = DSFuncBookings
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object edtBillAltPhone: TDBEdit
            Left = 76
            Top = 173
            Width = 121
            Height = 23
            DataField = 'BillAltPhone'
            DataSource = DSFuncBookings
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object edtBillFax: TDBEdit
            Left = 76
            Top = 199
            Width = 121
            Height = 23
            DataField = 'BillFax'
            DataSource = DSFuncBookings
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object chkBillTo: TwwCheckBox
            Left = 20
            Top = 15
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
            Caption = 'chkBillTo'
            DataField = 'UseBillTo'
            DataSource = DSFuncBookings
            TabOrder = 4
            OnClick = chkBillToClick
          end
        end
        object btnContacts: TDNMSpeedButton
          Left = 254
          Top = 45
          Width = 25
          Height = 23
          Action = actContacts
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
            055557777777777775F508888888888880557F5FFFFFFFFFF75F080000000000
            88057577777777775F755080FFFFFF05088057F7FFFFFF7575F70000000000F0
            F08077777777775757F70FFFFFFFFF0F008075F5FF5FF57577F750F00F00FFF0
            F08057F775775557F7F750FFFFFFFFF0F08057FF5555555757F7000FFFFFFFFF
            0000777FF5FFFFF577770900F00000F000907F775777775777F7090FFFFFFFFF
            00907F7F555555557757000FFFFFFFFF0F00777F5FFF5FF57F77550F000F00FF
            0F05557F777577557F7F550FFFFFFFFF0005557F555FFFFF7775550FFF000000
            05555575FF777777755555500055555555555557775555555555}
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          NumGlyphs = 2
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object cboFuncType: TwwDBLookupCombo
          Left = 395
          Top = 5
          Width = 174
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'FuncTypeName'#9'30'#9'Name'#9'F')
          DataField = 'FuncTypeID'
          DataSource = DSFuncBookings
          LookupTable = qryFuncTypes
          LookupField = 'FuncTypeID'
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          AllowClearKey = False
          OnNotInList = cboFuncTypeNotInList
        end
        object cboStartTime: TwwDBComboBox
          Left = 116
          Top = 288
          Width = 72
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            '00:00'
            '00:30'
            '01:00'
            '01:30'
            '02:00'
            '02:30'
            '03:00'
            '03:30'
            '04:00'
            '04:30'
            '05:00'
            '05:30'
            '06:00'
            '06:30'
            '07:00'
            '07:30'
            '08:00'
            '08:30'
            '09:00'
            '09:30'
            '10:00'
            '10:30'
            '11:00'
            '11:30'
            '12:00'
            '12:30'
            '13:00'
            '13:30'
            '14:00'
            '14:30'
            '15:00'
            '15:30'
            '16:00'
            '16:30'
            '17:00'
            '17:30'
            '18:00'
            '18:30'
            '19:00'
            '19:30'
            '20:00'
            '20:30'
            '21:00'
            '21:30'
            '22:00'
            '22:30'
            '23:00'
            '23:30'
            '24:00')
          ParentFont = False
          Sorted = False
          TabOrder = 10
          UnboundDataType = wwDefault
          OnCloseUp = cboStartTimeCloseUp
        end
        object cboEndTime: TwwDBComboBox
          Left = 117
          Top = 334
          Width = 72
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            '00:00'
            '00:30'
            '01:00'
            '01:30'
            '02:00'
            '02:30'
            '03:00'
            '03:30'
            '04:00'
            '04:30'
            '05:00'
            '05:30'
            '06:00'
            '06:30'
            '07:00'
            '07:30'
            '08:00'
            '08:30'
            '09:00'
            '09:30'
            '10:00'
            '10:30'
            '11:00'
            '11:30'
            '12:00'
            '12:30'
            '13:00'
            '13:30'
            '14:00'
            '14:30'
            '15:00'
            '15:30'
            '16:00'
            '16:30'
            '17:00'
            '17:30'
            '18:00'
            '18:30'
            '19:00'
            '19:30'
            '20:00'
            '20:30'
            '21:00'
            '21:30'
            '22:00'
            '22:30'
            '23:00'
            '23:30'
            '24:00')
          ParentFont = False
          Sorted = False
          TabOrder = 13
          UnboundDataType = wwDefault
          Visible = False
          OnCloseUp = cboEndTimeCloseUp
        end
        object edtDescription: TDBEdit
          Left = 74
          Top = 5
          Width = 206
          Height = 23
          DataField = 'BookingDescription'
          DataSource = DSFuncBookings
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object chkRescheduled: TwwCheckBox
          Left = 288
          Top = 269
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
          Alignment = taLeftJustify
          DataField = 'Reschedulled'
          DataSource = DSFuncBookings
          TabOrder = 12
          OnClick = chkRescheduledClick
        end
        object chkCancellation: TwwCheckBox
          Left = 288
          Top = 316
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
          Alignment = taLeftJustify
          DataField = 'Cancellation'
          DataSource = DSFuncBookings
          TabOrder = 14
          OnClick = chkCancellationClick
        end
      end
    end
    object tabRooms: TTabSheet
      Caption = 'Rooms'
      ImageIndex = 1
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 854
        Height = 478
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label13: TLabel
          Left = 21
          Top = 4
          Width = 113
          Height = 15
          Caption = 'Rooms this Booking'
          Transparent = True
        end
        object grdRooms: TwwDBGrid
          Left = 22
          Top = 20
          Width = 811
          Height = 109
          ControlType.Strings = (
            'IntervalCalc;CustomEdit;;F'
            'RateType;CustomEdit;cboLineRateType;F'
            'Start;CustomEdit;dtpRoomStart;F'
            'End;CustomEdit;dtpRoomEnd;F'
            'ResetTime;CustomEdit;dtpResetTime;F'
            'RoomAllocDate;CustomEdit;dtpRoomAllocDate;F'
            'StartDummy;CustomEdit;cboStartAlloc;T'
            'EndDummy;CustomEdit;cboEndAlloc;F')
          Selected.Strings = (
            'RoomNameLookup'#9'17'#9'Name'#9'F'#9
            'NumPersons'#9'7'#9'Persons'#9#9
            'RoomAllocDate'#9'10'#9'Date'#9'F'#9
            'StartDummy'#9'7'#9'Start'#9'F'#9
            'EndDummy'#9'7'#9'End'#9'F'#9
            'RateType'#9'10'#9'RateType'#9'F'#9
            'Rate'#9'9'#9'Rate'#9#9
            'IntervalCalc'#9'8'#9'Interval'#9#9
            'LinePriceInc'#9'10'#9'Price'#9'T'#9
            'Extras'#9'8'#9'Extras'#9#9
            'ResetTime'#9'10'#9'ResetTime'#9'F'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Color = clWhite
          DataSource = dsAllocRooms
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
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
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
          object grdRoomsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 20
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
            OnClick = grdRoomsIButtonClick
          end
        end
        object pageControlRooms: TPageControl
          Left = 16
          Top = 136
          Width = 817
          Height = 342
          ActivePage = tabAllRooms
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabHeight = 23
          TabIndex = 0
          TabOrder = 1
          TabWidth = 271
          object tabAllRooms: TTabSheet
            Caption = 'Room Select'
            object DNMPanel7: TDNMPanel
              Left = 0
              Top = 0
              Width = 809
              Height = 309
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object Label14: TLabel
                Left = 9
                Top = 3
                Width = 72
                Height = 15
                Caption = 'Select Room'
                Transparent = True
              end
              object Label16: TLabel
                Left = 88
                Top = 4
                Width = 130
                Height = 15
                Caption = '(Double Click to Select)'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsItalic]
                ParentFont = False
                Transparent = True
              end
              object grdAllRooms: TwwDBGrid
                Left = 8
                Top = 18
                Width = 793
                Height = 286
                ControlType.Strings = (
                  'PerHour;CustomEdit;;F')
                Selected.Strings = (
                  'Name'#9'25'#9'Room'#9'T'#9
                  'ResetTime'#9'10'#9'Reset Time'#9'T'#9
                  'PerDay'#9'10'#9'Day Rate'#9'T'#9
                  'PerHalfDay'#9'10'#9'Half Day Rate'#9'T'#9
                  'PerHour'#9'10'#9'Hourly Rate'#9'T'#9)
                IniAttributes.Delimiter = ';;'
                TitleColor = clWhite
                FixedCols = 0
                ShowHorzScrollBar = True
                Color = clWhite
                DataSource = dsAllRooms
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                KeyOptions = [dgAllowInsert]
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                TitleAlignment = taLeftJustify
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Arial'
                TitleFont.Style = [fsBold]
                TitleLines = 1
                TitleButtons = False
                OnDblClick = grdAllRoomsDblClick
                PaintOptions.BackgroundOptions = [coBlendFixedRow]
                object grdAllRoomsIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 20
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
                  OnClick = grdAllRoomsIButtonClick
                end
              end
            end
          end
          object tabMenu: TTabSheet
            Caption = 'Meals'
            ImageIndex = 1
            object DNMPanel8: TDNMPanel
              Left = 0
              Top = 0
              Width = 809
              Height = 309
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object Label17: TLabel
                Left = 9
                Top = 0
                Width = 34
                Height = 15
                Caption = 'Meals'
                Transparent = True
              end
              object Label18: TLabel
                Left = 9
                Top = 184
                Width = 61
                Height = 15
                Caption = 'Beverages'
                Transparent = True
              end
              object grdMeals: TwwDBGrid
                Left = 9
                Top = 13
                Width = 793
                Height = 164
                ControlType.Strings = (
                  'Course;CustomEdit;cboCourse;F'
                  'Date;CustomEdit;dtpDate;F'
                  'Time;CustomEdit;dtpTime;F'
                  'ProductName;CustomEdit;cboProduct;F'
                  'Meal;CustomEdit;cboMeal;F')
                Selected.Strings = (
                  'Meal'#9'15'#9'Meal'#9'F'#9
                  'Course'#9'15'#9'Course'#9#9
                  'Date'#9'10'#9'Date'#9#9
                  'Time'#9'10'#9'Time'#9#9
                  'ProductName'#9'20'#9'Product'#9#9
                  'Qty'#9'5'#9'Qty'#9#9
                  'Price'#9'10'#9'Price'#9#9
                  'Description'#9'32'#9'Description'#9#9)
                IniAttributes.Delimiter = ';;'
                TitleColor = clWhite
                FixedCols = 0
                ShowHorzScrollBar = True
                Color = clWhite
                DataSource = dsFuncBookingMeals
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
                OnExit = grdMealsExit
                FooterColor = clWhite
                FooterCellColor = clWhite
                PaintOptions.BackgroundOptions = [coBlendFixedRow]
                object grdMealsIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 20
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
                  OnClick = grdMealsIButtonClick
                end
              end
              object cboCourse: TwwDBLookupCombo
                Left = 80
                Top = 72
                Width = 49
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'CourseName'#9'20'#9'Course'#9'F')
                DataField = 'Course'
                DataSource = dsFuncBookingMeals
                LookupTable = qryCourses
                LookupField = 'CourseName'
                ParentFont = False
                TabOrder = 1
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
              object cboProduct: TwwDBLookupCombo
                Left = 152
                Top = 72
                Width = 65
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'PartName'#9'25'#9'Product'#9'F'
                  'PartsDescription'#9'40'#9'Description'#9'F')
                DataField = 'ProductName'
                DataSource = dsFuncBookingMeals
                LookupTable = qryMealProducts
                LookupField = 'PartName'
                ParentFont = False
                TabOrder = 2
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
                OnCloseUp = cboProductCloseUp
              end
              object dtpDate: TwwDBDateTimePicker
                Left = 231
                Top = 70
                Width = 57
                Height = 23
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'Date'
                DataSource = dsFuncBookingMeals
                Epoch = 1950
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                Interval.MinutesInterval = 15
                ParentFont = False
                ShowButton = True
                TabOrder = 3
                DisplayFormat = 'dd-mmm-yy'
              end
              object grdDrinks: TwwDBGrid
                Left = 8
                Top = 200
                Width = 793
                Height = 108
                ControlType.Strings = (
                  'Course;CustomEdit;cboDrinkCourses;F'
                  'Date;CustomEdit;dtpDrinkDate;F'
                  'Time;CustomEdit;dtpDrinkTime;F'
                  'ProductName;CustomEdit;cboDrinkProduct;F'
                  'Meal;CustomEdit;cboDrinkMeal;F')
                Selected.Strings = (
                  'Meal'#9'15'#9'Meal'#9'F'#9
                  'Course'#9'15'#9'Course'#9#9
                  'Date'#9'10'#9'Date'#9#9
                  'Time'#9'10'#9'Time'#9#9
                  'ProductName'#9'19'#9'Product'#9#9
                  'Qty'#9'5'#9'Qty'#9#9
                  'Price'#9'10'#9'Price'#9#9
                  'Description'#9'33'#9'Description'#9#9)
                IniAttributes.Delimiter = ';;'
                TitleColor = clWhite
                FixedCols = 0
                ShowHorzScrollBar = True
                Color = clWhite
                DataSource = dsFuncBookingDrinks
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
                TitleAlignment = taLeftJustify
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Arial'
                TitleFont.Style = [fsBold]
                TitleLines = 1
                TitleButtons = False
                OnExit = grdDrinksExit
                FooterColor = clWhite
                FooterCellColor = clWhite
                PaintOptions.BackgroundOptions = [coBlendFixedRow]
                object grdDrinksIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 20
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
                  OnClick = grdDrinksIButtonClick
                end
              end
              object cboDrinkCourses: TwwDBLookupCombo
                Left = 128
                Top = 256
                Width = 73
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'CourseName'#9'20'#9'Course'#9'F')
                DataField = 'Course'
                DataSource = dsFuncBookingDrinks
                LookupTable = qryDrinkCourses
                LookupField = 'CourseName'
                ParentFont = False
                TabOrder = 5
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
              object cboDrinkProduct: TwwDBLookupCombo
                Left = 208
                Top = 256
                Width = 81
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'PartName'#9'25'#9'Product'#9'F'
                  'PartsDescription'#9'40'#9'Description'#9'F')
                DataField = 'ProductName'
                DataSource = dsFuncBookingDrinks
                LookupTable = qryDrinkProducts
                LookupField = 'PartName'
                ParentFont = False
                TabOrder = 6
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
                OnCloseUp = cboDrinkProductCloseUp
              end
              object dtpDrinkDate: TwwDBDateTimePicker
                Left = 296
                Top = 256
                Width = 73
                Height = 23
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'Date'
                DataSource = dsFuncBookingDrinks
                Epoch = 1950
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                Interval.MinutesInterval = 15
                ParentFont = False
                ShowButton = True
                TabOrder = 7
                DisplayFormat = 'dd-mmm-yy'
              end
              object cboMeal: TwwDBLookupCombo
                Left = 16
                Top = 72
                Width = 57
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'MealName'#9'25'#9'MealName'#9'F')
                DataField = 'Meal'
                DataSource = dsFuncBookingMeals
                LookupTable = qryMealsLookup
                LookupField = 'MealName'
                ParentFont = False
                TabOrder = 8
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
              object cboDrinkMeal: TwwDBLookupCombo
                Left = 40
                Top = 256
                Width = 73
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ControlType.Strings = (
                  'MealName;CustomEdit;cboDrinkMeal;F')
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'MealName'#9'25'#9'Meal'#9'F')
                DataField = 'Meal'
                DataSource = dsFuncBookingDrinks
                LookupTable = qryDrinksMealsLookup
                LookupField = 'MealName'
                ParentFont = False
                TabOrder = 9
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
              end
              object dtpTime: TwwDBComboBox
                Left = 292
                Top = 73
                Width = 72
                Height = 23
                ShowButton = True
                Style = csDropDownList
                MapList = False
                AllowClearKey = True
                AutoDropDown = True
                DataField = 'Time'
                DataSource = dsFuncBookingMeals
                DropDownCount = 8
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ItemHeight = 0
                Items.Strings = (
                  '00:00'
                  '00:30'
                  '01:00'
                  '01:30'
                  '02:00'
                  '02:30'
                  '03:00'
                  '03:30'
                  '04:00'
                  '04:30'
                  '05:00'
                  '05:30'
                  '06:00'
                  '06:30'
                  '07:00'
                  '07:30'
                  '08:00'
                  '08:30'
                  '09:00'
                  '09:30'
                  '10:00'
                  '10:30'
                  '11:00'
                  '11:30'
                  '12:00'
                  '12:30'
                  '13:00'
                  '13:30'
                  '14:00'
                  '14:30'
                  '15:00'
                  '15:30'
                  '16:00'
                  '16:30'
                  '17:00'
                  '17:30'
                  '18:00'
                  '18:30'
                  '19:00'
                  '19:30'
                  '20:00'
                  '20:30'
                  '21:00'
                  '21:30'
                  '22:00'
                  '22:30'
                  '23:00'
                  '23:30'
                  '24:00')
                ParentFont = False
                Sorted = False
                TabOrder = 10
                UnboundDataType = wwEdtTime
                OnChange = dtpTimeChange
              end
              object dtpDrinkTime: TwwDBComboBox
                Left = 372
                Top = 257
                Width = 72
                Height = 23
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                AutoDropDown = True
                DataField = 'Time'
                DataSource = dsFuncBookingMeals
                DropDownCount = 8
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ItemHeight = 0
                Items.Strings = (
                  '00:00'
                  '00:30'
                  '01:00'
                  '01:30'
                  '02:00'
                  '02:30'
                  '03:00'
                  '03:30'
                  '04:00'
                  '04:30'
                  '05:00'
                  '05:30'
                  '06:00'
                  '06:30'
                  '07:00'
                  '07:30'
                  '08:00'
                  '08:30'
                  '09:00'
                  '09:30'
                  '10:00'
                  '10:30'
                  '11:00'
                  '11:30'
                  '12:00'
                  '12:30'
                  '13:00'
                  '13:30'
                  '14:00'
                  '14:30'
                  '15:00'
                  '15:30'
                  '16:00'
                  '16:30'
                  '17:00'
                  '17:30'
                  '18:00'
                  '18:30'
                  '19:00'
                  '19:30'
                  '20:00'
                  '20:30'
                  '21:00'
                  '21:30'
                  '22:00'
                  '22:30'
                  '23:00'
                  '23:30'
                  '24:00')
                ParentFont = False
                Sorted = False
                TabOrder = 11
                UnboundDataType = wwDefault
              end
            end
          end
          object tabResources: TTabSheet
            Caption = 'Resources'
            ImageIndex = 2
            object DNMPanel3: TDNMPanel
              Left = 0
              Top = 0
              Width = 809
              Height = 309
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object Label21: TLabel
                Left = 16
                Top = 16
                Width = 62
                Height = 15
                Caption = 'Resources'
                Transparent = True
              end
              object grdResources: TwwDBGrid
                Left = 8
                Top = 32
                Width = 585
                Height = 265
                ControlType.Strings = (
                  'ResourceName;CustomEdit;cboResource;F')
                Selected.Strings = (
                  'ResourceName'#9'30'#9'Resource Name'#9#9
                  'Qty'#9'10'#9'Qty'#9#9)
                IniAttributes.Delimiter = ';;'
                TitleColor = clWhite
                FixedCols = 0
                ShowHorzScrollBar = True
                DataSource = dsFuncResourceAllocations
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
                OnExit = grdResourcesExit
                FooterColor = clWhite
                PaintOptions.BackgroundOptions = [coBlendFixedRow]
                object grdResourcesIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 13
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
                  OnClick = grdResourcesIButtonClick
                end
              end
              object cboResource: TwwDBLookupCombo
                Left = 32
                Top = 128
                Width = 65
                Height = 23
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'ResourceName'#9'50'#9'Resource Name'#9'F')
                DataField = 'ResourceName'
                DataSource = dsFuncResourceAllocations
                LookupTable = qryFuncResources
                LookupField = 'ResourceName'
                ParentFont = False
                TabOrder = 1
                AutoDropDown = True
                ShowButton = True
                AllowClearKey = False
                OnCloseUp = cboResourceCloseUp
              end
            end
          end
        end
        object cboLineRateType: TwwDBComboBox
          Left = 136
          Top = 50
          Width = 65
          Height = 23
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'RateType'
          DataSource = dsAllocRooms
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            'PerDay'
            'PerHalfDay'
            'PerHour')
          ParentFont = False
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
          OnCloseUp = cboLineRateTypeCloseUp
        end
        object dtpResetTime: TwwDBDateTimePicker
          Left = 449
          Top = 48
          Width = 57
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'ResetTime'
          DataSource = dsAllocRooms
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 3
          DisplayFormat = 'hh:nn'
        end
        object dtpRoomAllocDate: TwwDBDateTimePicker
          Left = 208
          Top = 50
          Width = 65
          Height = 23
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'RoomAllocDate'
          DataSource = dsAllocRooms
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 4
          DisplayFormat = 'dd-mmm-yy'
        end
        object cboStartAlloc: TwwDBComboBox
          Left = 284
          Top = 49
          Width = 72
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'StartDummy'
          DataSource = dsAllocRooms
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            '00:00'
            '00:30'
            '01:00'
            '01:30'
            '02:00'
            '02:30'
            '03:00'
            '03:30'
            '04:00'
            '04:30'
            '05:00'
            '05:30'
            '06:00'
            '06:30'
            '07:00'
            '07:30'
            '08:00'
            '08:30'
            '09:00'
            '09:30'
            '10:00'
            '10:30'
            '11:00'
            '11:30'
            '12:00'
            '12:30'
            '13:00'
            '13:30'
            '14:00'
            '14:30'
            '15:00'
            '15:30'
            '16:00'
            '16:30'
            '17:00'
            '17:30'
            '18:00'
            '18:30'
            '19:00'
            '19:30'
            '20:00'
            '20:30'
            '21:00'
            '21:30'
            '22:00'
            '22:30'
            '23:00'
            '23:30')
          ParentFont = False
          Sorted = False
          TabOrder = 5
          UnboundDataType = wwDefault
          OnCloseUp = cboStartAllocCloseUp
        end
        object cboEndAlloc: TwwDBComboBox
          Left = 368
          Top = 48
          Width = 72
          Height = 23
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          AutoDropDown = True
          DataField = 'EndDummy'
          DataSource = dsAllocRooms
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            '00:00'
            '00:30'
            '01:00'
            '01:30'
            '02:00'
            '02:30'
            '03:00'
            '03:30'
            '04:00'
            '04:30'
            '05:00'
            '05:30'
            '06:00'
            '06:30'
            '07:00'
            '07:30'
            '08:00'
            '08:30'
            '09:00'
            '09:30'
            '10:00'
            '10:30'
            '11:00'
            '11:30'
            '12:00'
            '12:30'
            '13:00'
            '13:30'
            '14:00'
            '14:30'
            '15:00'
            '15:30'
            '16:00'
            '16:30'
            '17:00'
            '17:30'
            '18:00'
            '18:30'
            '19:00'
            '19:30'
            '20:00'
            '20:30'
            '21:00'
            '21:30'
            '22:00'
            '22:30'
            '23:00'
            '23:30')
          ParentFont = False
          Sorted = False
          TabOrder = 6
          UnboundDataType = wwDefault
          OnCloseUp = cboEndAllocCloseUp
        end
      end
    end
  end
  object pnlHeader: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1002
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object lblEmail: TLabel
      Left = 689
      Top = 14
      Width = 182
      Height = 19
      Caption = 'Emailing, Please Wait.... '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblConverted: TLabel
      Left = 33
      Top = 14
      Width = 227
      Height = 19
      Caption = 'Booking has been Converted.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
  end
  object pnlTitle: TDNMPanel [6]
    Left = 308
    Top = 5
    Width = 268
    Height = 38
    Anchors = [akLeft, akTop, akRight]
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
      Width = 264
      Height = 34
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
        Width = 264
        Height = 34
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Function Booking'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 461
    Top = 10
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 397
    Top = 10
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 168
    inherited CustomiseGrid: TMenuItem
      OnClick = mnuCustomiseGridClick
    end
  end
  object DSFuncBookings: TDataSource
    DataSet = qryFuncBookings
    Left = 699
    Top = 154
  end
  object qryClientsLookup: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ClientID, Company, Customer, IF(StopCredit='#39'T'#39',0,1) as St' +
        'opCredit'
      'FROM tblclients'
      
        'WHERE not IsNull(tblclients.Company) And (tblclients.Active <> '#39 +
        'F'#39')'
      '  AND (tblclients.Customer = '#39'T'#39')'
      'ORDER BY tblclients.Company')
    OnCalcFields = qryClientsLookupCalcFields
    Left = 362
    Top = 4
    object qryClientsLookupCompany: TStringField
      DisplayWidth = 80
      FieldName = 'Company'
      FixedChar = True
      Size = 80
    end
    object qryClientsLookupStopCreditImage: TIntegerField
      DisplayWidth = 3
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Calculated = True
    end
    object qryClientsLookupClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object qryClientsLookupCustomer: TStringField
      FieldName = 'Customer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryClientsLookupStopCredit: TLargeintField
      FieldName = 'StopCredit'
      ReadOnly = True
      Visible = False
    end
  end
  object DSClientLookup: TDataSource
    AutoEdit = False
    DataSet = qryClientsLookup
    Left = 610
    Top = 310
  end
  object tbTimeInc: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tbltimeinc'
      'Where EmployeeID= :ID;')
    Left = 579
    Top = 279
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object qryRoomLookup: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RoomID, Name,  ResetTime, PerDay, PerHalfDay, PerHour'
      'FROM tblfuncrooms '
      'WHERE Active = '#39'T'#39' ')
    Left = 716
    Top = 313
  end
  object cboClassQry: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName')
    Left = 663
    Top = 288
  end
  object cboClassSrc: TDataSource
    AutoEdit = False
    DataSet = cboClassQry
    Left = 645
    Top = 334
  end
  object cboServiceIDQry: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblServices.ServiceID, tblTrainerRates.Rate As Rate, tblS' +
        'ervices.ServiceDesc As '#39'Service Description'#39', tblTrainerRates.Pa' +
        'yRate,tblTrainerRates.EmployeeID'
      'FROM tblServices '
      'INNER JOIN tblTrainerRates '
      'ON tblServices.ServiceID=tblTrainerRates.ServiceID '
      'WHERE tblTrainerRates.EmployeeID=:cboTrainerID')
    Left = 609
    Top = 251
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cboTrainerID'
      end>
    object cboServiceIDQryServiceID: TAutoIncField
      FieldName = 'ServiceID'
      ReadOnly = True
    end
    object cboServiceIDQryRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Rate'
      currency = True
    end
    object cboServiceIDQryServiceDescription: TStringField
      DisplayWidth = 30
      FieldName = 'Service Description'
      FixedChar = True
      Size = 50
    end
    object cboServiceIDQryPayRate: TFloatField
      FieldName = 'PayRate'
      currency = True
    end
    object cboServiceIDQryEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
  end
  object DSTrainerRates: TDataSource
    AutoEdit = False
    DataSet = cboServiceIDQry
    Left = 602
    Top = 345
  end
  object cboEquipmentLookup: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT EquipmentID,EquipmentName,EquipmentDescription  FROM tble' +
        'quipment')
    Left = 615
    Top = 379
  end
  object DSEquipment: TDataSource
    AutoEdit = False
    DataSet = cboEquipmentLookup
    Left = 588
    Top = 408
  end
  object qryContactsLookup: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ContactID, CusID, '
      ' CONCAT_WS('#39' '#39', ContactFirstName, ContactSurName) as Name,'
      ' ContactFirstName, ContactSurName, ContactTitle,'
      
        ' ContactAddress, ContactCity, ContactState, ContactPCode, Contac' +
        'tPh,'
      ' ContactAltPh, ContactMOB, ContactFax'
      'FROM tblcontacts'
      'WHERE CusID = :xCusID'
      'ORDER BY name')
    Left = 675
    Top = 473
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xCusID'
      end>
    object qryContactsLookupContactID: TAutoIncField
      FieldName = 'ContactID'
      ReadOnly = True
    end
    object qryContactsLookupCusID: TIntegerField
      FieldName = 'CusID'
    end
    object qryContactsLookupName: TStringField
      FieldName = 'Name'
      ReadOnly = True
      Size = 61
    end
    object qryContactsLookupContactFirstName: TStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object qryContactsLookupContactSurName: TStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object qryContactsLookupContactTitle: TStringField
      FieldName = 'ContactTitle'
      Size = 10
    end
    object qryContactsLookupContactAddress: TStringField
      FieldName = 'ContactAddress'
      Size = 100
    end
    object qryContactsLookupContactCity: TStringField
      FieldName = 'ContactCity'
      Size = 30
    end
    object qryContactsLookupContactState: TStringField
      FieldName = 'ContactState'
      Size = 5
    end
    object qryContactsLookupContactPCode: TStringField
      FieldName = 'ContactPCode'
      Size = 255
    end
    object qryContactsLookupContactPh: TStringField
      FieldName = 'ContactPh'
    end
    object qryContactsLookupContactAltPh: TStringField
      FieldName = 'ContactAltPh'
    end
    object qryContactsLookupContactMOB: TStringField
      FieldName = 'ContactMOB'
    end
    object qryContactsLookupContactFax: TStringField
      FieldName = 'ContactFax'
    end
  end
  object dsAllRooms: TDataSource
    DataSet = qryAllRooms
    Left = 776
    Top = 488
  end
  object qryAllRooms: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RoomID, Name,  ResetTime, PerDay, PerHalfDay, PerHour, '
      'Capacity'
      'FROM tblfuncrooms'
      'WHERE Active = '#39'T'#39' '
      'ORDER BY Name')
    Left = 340
    Top = 225
    object qryAllRoomsName: TStringField
      DisplayLabel = 'Room'
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 255
    end
    object qryAllRoomsResetTime: TTimeField
      DisplayLabel = 'Reset Time'
      DisplayWidth = 10
      FieldName = 'ResetTime'
      DisplayFormat = 'hh '#39'hr'#39' nn '#39'min'#39
    end
    object qryAllRoomsPerDay: TFloatField
      DisplayLabel = 'Day Rate'
      DisplayWidth = 10
      FieldName = 'PerDay'
      currency = True
    end
    object qryAllRoomsPerHalfDay: TFloatField
      DisplayLabel = 'Half Day Rate'
      DisplayWidth = 10
      FieldName = 'PerHalfDay'
      currency = True
    end
    object qryAllRoomsPerHour: TFloatField
      DisplayLabel = 'Hourly Rate'
      DisplayWidth = 10
      FieldName = 'PerHour'
      currency = True
    end
    object qryAllRoomsRoomID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'RoomID'
      ReadOnly = True
      Visible = False
    end
    object qryAllRoomsCapacity: TIntegerField
      FieldName = 'Capacity'
      Visible = False
    end
  end
  object qryAllocRooms: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT RoomAllocationID, FuncBookingID, '
      'RoomID,  NumPersons, Start, End,'
      'StartDummy, EndDummy,  PerDay,'
      'PerHalfDay, PerHour, RateType, Rate,'
      'Extras, LinePriceInc, ResetTime, RoomAllocDate'
      'FROM tblfuncroomallocation'
      'WHERE  FuncBookingID = :xFuncBookingID')
    AfterScroll = qryAllocRoomsAfterScroll
    OnCalcFields = qryAllocRoomsCalcFields
    Left = 615
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xFuncBookingID'
      end>
    object qryAllocRoomsRoomNameLookup: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 17
      FieldKind = fkLookup
      FieldName = 'RoomNameLookup'
      LookupDataSet = qryAllRooms
      LookupKeyFields = 'RoomID'
      LookupResultField = 'Name'
      KeyFields = 'RoomID'
      Size = 50
      Lookup = True
    end
    object qryAllocRoomsNumPersons: TIntegerField
      DisplayLabel = 'Persons'
      DisplayWidth = 7
      FieldName = 'NumPersons'
    end
    object qryAllocRoomsRoomAllocDate: TDateField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'RoomAllocDate'
      OnChange = qryAllocRoomsRoomAllocDateChange
      DisplayFormat = 'dd-mmm-yy'
    end
    object qryAllocRoomsStartDummy: TStringField
      DisplayLabel = 'Start'
      DisplayWidth = 7
      FieldName = 'StartDummy'
      Size = 255
    end
    object qryAllocRoomsEndDummy: TStringField
      DisplayLabel = 'End'
      DisplayWidth = 7
      FieldName = 'EndDummy'
      Size = 255
    end
    object qryAllocRoomsRateType: TStringField
      DisplayWidth = 10
      FieldName = 'RateType'
      OnChange = qryAllocRoomsRateTypeChange
      Size = 255
    end
    object qryAllocRoomsRate: TFloatField
      DisplayWidth = 9
      FieldName = 'Rate'
      OnChange = qryAllocRoomsRateChange
      currency = True
    end
    object qryAllocRoomsIntervalCalc: TStringField
      DisplayLabel = 'Interval'
      DisplayWidth = 8
      FieldKind = fkCalculated
      FieldName = 'IntervalCalc'
      OnChange = qryAllocRoomsIntervalCalcChange
      Calculated = True
    end
    object qryAllocRoomsLinePriceInc: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 10
      FieldName = 'LinePriceInc'
      currency = True
    end
    object qryAllocRoomsExtras: TFloatField
      DisplayWidth = 8
      FieldName = 'Extras'
      currency = True
    end
    object qryAllocRoomsResetTime: TDateTimeField
      DisplayWidth = 10
      FieldName = 'ResetTime'
      DisplayFormat = 'hh:nn'
    end
    object qryAllocRoomsStart: TDateTimeField
      DisplayWidth = 7
      FieldName = 'Start'
      Visible = False
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryAllocRoomsEnd: TDateTimeField
      DisplayWidth = 7
      FieldName = 'End'
      Visible = False
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryAllocRoomsPerDay: TFloatField
      DisplayWidth = 10
      FieldName = 'PerDay'
      Visible = False
    end
    object qryAllocRoomsPerHalfDay: TFloatField
      DisplayWidth = 10
      FieldName = 'PerHalfDay'
      Visible = False
    end
    object qryAllocRoomsPerHour: TFloatField
      DisplayLabel = 'Per Hour'
      DisplayWidth = 10
      FieldName = 'PerHour'
      Visible = False
    end
    object qryAllocRoomsRoomAllocationID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'RoomAllocationID'
      ReadOnly = True
      Visible = False
    end
    object qryAllocRoomsFuncBookingID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncBookingID'
      Visible = False
    end
    object qryAllocRoomsRoomID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RoomID'
      Visible = False
    end
  end
  object dsAllocRooms: TDataSource
    DataSet = qryAllocRooms
    Left = 616
    Top = 136
  end
  object qryFuncBookings: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblFuncBookings'
      'WHERE FuncBookingID =:xFuncBookingID')
    AutoCalcFields = False
    Left = 133
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xFuncBookingID'
      end>
    object qryFuncBookingsFuncBookingID: TAutoIncField
      FieldName = 'FuncBookingID'
      ReadOnly = True
    end
    object qryFuncBookingsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryFuncBookingsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryFuncBookingsBookingDate: TDateField
      FieldName = 'BookingDate'
    end
    object qryFuncBookingsCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qryFuncBookingsUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object qryFuncBookingsCancellation: TStringField
      FieldName = 'Cancellation'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsCancellationDate: TDateField
      FieldName = 'CancellationDate'
    end
    object qryFuncBookingsRoomRateID: TIntegerField
      FieldName = 'RoomRateID'
    end
    object qryFuncBookingsRoomID: TIntegerField
      FieldName = 'RoomID'
    end
    object qryFuncBookingsContact: TStringField
      FieldName = 'Contact'
      Size = 50
    end
    object qryFuncBookingsContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object qryFuncBookingsReschedulled: TStringField
      FieldName = 'Reschedulled'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsRescheduledDate: TDateField
      FieldName = 'RescheduledDate'
    end
    object qryFuncBookingsStart_Time: TStringField
      FieldName = 'Start_Time'
      Size = 50
    end
    object qryFuncBookingsEnd_Time: TStringField
      FieldName = 'End_Time'
      Size = 50
    end
    object qryFuncBookingsStartVal: TFloatField
      FieldName = 'StartVal'
    end
    object qryFuncBookingsEndVal: TFloatField
      FieldName = 'EndVal'
    end
    object qryFuncBookingsRate: TFloatField
      FieldName = 'Rate'
      currency = True
    end
    object qryFuncBookingsRateType: TStringField
      FieldName = 'RateType'
      Size = 255
    end
    object qryFuncBookingsRoomPrice: TFloatField
      FieldName = 'RoomPrice'
      currency = True
    end
    object qryFuncBookingsNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qryFuncBookingsFeedbackNotes: TMemoField
      FieldName = 'FeedbackNotes'
      BlobType = ftMemo
    end
    object qryFuncBookingsCalloutValue: TFloatField
      FieldName = 'CalloutValue'
    end
    object qryFuncBookingsStatus1: TStringField
      FieldName = 'Status1'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsStatus2: TStringField
      FieldName = 'Status2'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsStatus3: TStringField
      FieldName = 'Status3'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsStatus4: TStringField
      FieldName = 'Status4'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsStatus5: TStringField
      FieldName = 'Status5'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsStatus6: TStringField
      FieldName = 'Status6'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsOther: TStringField
      FieldName = 'Other'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsOthertxt: TStringField
      FieldName = 'Othertxt'
      Size = 50
    end
    object qryFuncBookingsFeedback: TStringField
      FieldName = 'Feedback'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsTotalInc: TFloatField
      FieldName = 'TotalInc'
      currency = True
    end
    object qryFuncBookingsTotalCost: TFloatField
      FieldName = 'TotalCost'
      currency = True
    end
    object qryFuncBookingsEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsAppearDays: TIntegerField
      FieldName = 'AppearDays'
    end
    object qryFuncBookingsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryFuncBookingsRescheduledFrom: TDateField
      FieldName = 'RescheduledFrom'
    end
    object qryFuncBookingsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryFuncBookingsCustomerDetails: TStringField
      FieldName = 'CustomerDetails'
      Size = 255
    end
    object qryFuncBookingsPhone: TStringField
      FieldName = 'Phone'
      Size = 30
    end
    object qryFuncBookingsAltPhone: TStringField
      FieldName = 'AltPhone'
      Size = 30
    end
    object qryFuncBookingsFax: TStringField
      FieldName = 'Fax'
      Size = 30
    end
    object qryFuncBookingsStartBooking: TDateTimeField
      FieldName = 'StartBooking'
    end
    object qryFuncBookingsEndBooking: TDateTimeField
      FieldName = 'EndBooking'
    end
    object qryFuncBookingsServiceID: TWordField
      FieldName = 'ServiceID'
    end
    object qryFuncBookingsResourceID: TIntegerField
      FieldName = 'ResourceID'
    end
    object qryFuncBookingsConverted: TStringField
      FieldName = 'Converted'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsUnavailable: TStringField
      FieldName = 'Unavailable'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsNumPersons: TIntegerField
      FieldName = 'NumPersons'
    end
    object qryFuncBookingsExtras: TFloatField
      FieldName = 'Extras'
      OnChange = qryFuncBookingsExtrasChange
      currency = True
    end
    object qryFuncBookingsMealsPrice: TFloatField
      FieldName = 'MealsPrice'
      currency = True
    end
    object qryFuncBookingsDrinksPrice: TFloatField
      FieldName = 'DrinksPrice'
      currency = True
    end
    object qryFuncBookingsUseBillTo: TStringField
      FieldName = 'UseBillTo'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsBillToClientID: TIntegerField
      FieldName = 'BillToClientID'
    end
    object qryFuncBookingsBillToDetails: TStringField
      FieldName = 'BillToDetails'
      Size = 255
    end
    object qryFuncBookingsBillPhone: TStringField
      FieldName = 'BillPhone'
      Size = 255
    end
    object qryFuncBookingsBillAltPhone: TStringField
      FieldName = 'BillAltPhone'
      Size = 255
    end
    object qryFuncBookingsBillFax: TStringField
      FieldName = 'BillFax'
      Size = 255
    end
    object qryFuncBookingsBillToContactID: TIntegerField
      FieldName = 'BillToContactID'
    end
    object qryFuncBookingsFuncTypeID: TIntegerField
      FieldName = 'FuncTypeID'
    end
    object qryFuncBookingsBookingDescription: TStringField
      FieldName = 'BookingDescription'
      Size = 255
    end
    object qryFuncBookingsCreatedSO: TStringField
      FieldName = 'CreatedSO'
      FixedChar = True
      Size = 1
    end
    object qryFuncBookingsCreatedINV: TStringField
      FieldName = 'CreatedINV'
      FixedChar = True
      Size = 1
    end
  end
  object qryFuncBookingMeals: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FuncMealID, ProductID, Meal, MealSortOrder, '
      'Course, CourseSortOrder, Qty, Date, Time, '
      'ProductName, Description, Price, '
      'FuncBookingID, RoomAllocationID '
      'FROM tblfuncbookingmeals'
      'WHERE '
      '  FuncBookingID = :xFuncBookingID AND '
      '  RoomAllocationID = :xRoomAllocationID'
      'ORDER BY MealSortOrder, CourseSortOrder')
    OnNewRecord = qryFuncBookingMealsNewRecord
    Left = 255
    Top = 273
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xFuncBookingID'
      end
      item
        DataType = ftUnknown
        Name = 'xRoomAllocationID'
      end>
    object qryFuncBookingMealsMeal: TStringField
      DisplayWidth = 15
      FieldName = 'Meal'
      OnChange = qryFuncBookingMealsMealChange
      Size = 255
    end
    object qryFuncBookingMealsCourse: TStringField
      DisplayWidth = 15
      FieldName = 'Course'
      OnChange = qryFuncBookingMealsCourseChange
      Size = 255
    end
    object qryFuncBookingMealsDate: TDateField
      DisplayWidth = 10
      FieldName = 'Date'
    end
    object qryFuncBookingMealsTime: TTimeField
      DisplayWidth = 10
      FieldName = 'Time'
      DisplayFormat = 'h:nn am/pm'
    end
    object qryFuncBookingMealsProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Size = 255
    end
    object qryFuncBookingMealsQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
      OnChange = qryFuncBookingMealsQtyChange
    end
    object qryFuncBookingMealsPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'Price'
      currency = True
    end
    object qryFuncBookingMealsDescription: TStringField
      DisplayWidth = 32
      FieldName = 'Description'
      Size = 255
    end
    object qryFuncBookingMealsFuncBookingID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncBookingID'
      Visible = False
    end
    object qryFuncBookingMealsRoomAllocationID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RoomAllocationID'
      Visible = False
    end
    object qryFuncBookingMealsFuncMealID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FuncMealID'
      ReadOnly = True
      Visible = False
    end
    object qryFuncBookingMealsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object qryFuncBookingMealsMealSortOrder: TWordField
      DisplayWidth = 10
      FieldName = 'MealSortOrder'
      Visible = False
    end
    object qryFuncBookingMealsCourseSortOrder: TWordField
      DisplayWidth = 10
      FieldName = 'CourseSortOrder'
      Visible = False
    end
  end
  object dsFuncBookingMeals: TDataSource
    DataSet = qryFuncBookingMeals
    Left = 512
    Top = 376
  end
  object qryCourses: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CourseName, CourseOrder FROM tblFuncCourses'
      'ORDER BY CourseOrder')
    Left = 544
    Top = 264
  end
  object qryMealProducts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PARTSID, PartName, PartsDescription '
      'FROM tblparts'
      'WHERE Active = '#39'T'#39
      'ORDER BY PartName, PartsDescription')
    Left = 672
    Top = 104
  end
  object qryFuncBookingDrinks: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FuncDrinkID, ProductID, '
      'Meal, MealSortOrder, Course, CourseSortOrder, Qty, Date, Time, '
      'ProductName, Description, Price, '
      'FuncBookingID, RoomAllocationID '
      'FROM tblfuncbookingdrinks'
      'WHERE '
      '  FuncBookingID = :xFuncBookingID AND '
      '  RoomAllocationID = :xRoomAllocationID'
      'ORDER BY MealSortOrder, CourseSortOrder'
      '')
    OnNewRecord = qryFuncBookingDrinksNewRecord
    Left = 136
    Top = 504
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xFuncBookingID'
      end
      item
        DataType = ftUnknown
        Name = 'xRoomAllocationID'
      end>
    object qryFuncBookingDrinksMeal: TStringField
      DisplayWidth = 15
      FieldName = 'Meal'
      OnChange = qryFuncBookingDrinksMealChange
      Size = 255
    end
    object qryFuncBookingDrinksCourse: TStringField
      DisplayWidth = 15
      FieldName = 'Course'
      OnChange = qryFuncBookingDrinksCourseChange
      Size = 255
    end
    object qryFuncBookingDrinksDate: TDateField
      DisplayWidth = 10
      FieldName = 'Date'
    end
    object qryFuncBookingDrinksTime: TTimeField
      DisplayWidth = 10
      FieldName = 'Time'
      DisplayFormat = 'hh:nn am/pm'
    end
    object qryFuncBookingDrinksProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 19
      FieldName = 'ProductName'
      Size = 255
    end
    object qryFuncBookingDrinksQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
      OnChange = qryFuncBookingDrinksQtyChange
    end
    object qryFuncBookingDrinksPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'Price'
      currency = True
    end
    object qryFuncBookingDrinksDescription: TStringField
      DisplayWidth = 33
      FieldName = 'Description'
      Size = 255
    end
    object qryFuncBookingDrinksFuncBookingID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncBookingID'
      Visible = False
    end
    object qryFuncBookingDrinksRoomAllocationID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RoomAllocationID'
      Visible = False
    end
    object qryFuncBookingDrinksProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object qryFuncBookingDrinksFuncDrinkID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FuncDrinkID'
      ReadOnly = True
      Visible = False
    end
    object qryFuncBookingDrinksMealSortOrder: TWordField
      DisplayWidth = 10
      FieldName = 'MealSortOrder'
      Visible = False
    end
    object qryFuncBookingDrinksCourseSortOrder: TWordField
      DisplayWidth = 10
      FieldName = 'CourseSortOrder'
      Visible = False
    end
  end
  object dsFuncBookingDrinks: TDataSource
    DataSet = qryFuncBookingDrinks
    Left = 504
    Top = 456
  end
  object qryDrinkCourses: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CourseName, CourseOrder FROM tblFuncCourses'
      'ORDER BY CourseOrder')
    Left = 224
    Top = 464
  end
  object qryDrinkProducts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PARTSID, PartName, PartsDescription '
      'FROM tblparts'
      'WHERE Active = '#39'T'#39)
    Left = 768
    Top = 144
  end
  object dsFuncResourceAllocations: TDataSource
    DataSet = qryFuncResourceAllocations
    Left = 720
    Top = 360
  end
  object qryFuncResourceAllocations: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT FuncResourceAllocationID, FuncBookingID, RoomAllocationID' +
        ', '
      'FuncResourceID, ResourceName, Qty'
      'FROM tblfuncresourceallocation'
      'WHERE FuncBookingID =:xFuncBookingID AND '
      '      RoomAllocationID =:xRoomAllocationID')
    Left = 512
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xFuncBookingID'
      end
      item
        DataType = ftUnknown
        Name = 'xRoomAllocationID'
      end>
    object qryFuncResourceAllocationsResourceName: TStringField
      DisplayLabel = 'Resource Name'
      DisplayWidth = 30
      FieldName = 'ResourceName'
      Size = 255
    end
    object qryFuncResourceAllocationsQty: TIntegerField
      DisplayWidth = 10
      FieldName = 'Qty'
    end
    object qryFuncResourceAllocationsFuncResourceAllocationID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FuncResourceAllocationID'
      ReadOnly = True
      Visible = False
    end
    object qryFuncResourceAllocationsFuncBookingID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncBookingID'
      Visible = False
    end
    object qryFuncResourceAllocationsRoomAllocationID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RoomAllocationID'
      Visible = False
    end
    object qryFuncResourceAllocationsFuncResourceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncResourceID'
      Visible = False
    end
  end
  object qryFuncResources: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FuncResourceID, ResourceName, Qty  FROM tblFuncResources')
    Left = 760
    Top = 256
  end
  object qryFuncTypes: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FuncTypeID, FuncTypeName FROM tblFuncTypes'
      'ORDER BY FuncTypeName')
    Left = 200
    Top = 192
  end
  object qryMealsLookup: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT MealName, MealOrder FROM tblFuncMeals'
      'ORDER BY MealOrder')
    Left = 248
    Top = 216
  end
  object qryDrinksMealsLookup: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT MealName, MealOrder FROM tblFuncMeals'
      'ORDER BY MealOrder')
    Left = 128
    Top = 464
  end
  object qryContacts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ContactID, CusID, '
      ' CONCAT_WS('#39' '#39', ContactFirstName, ContactSurName) as Name,'
      ' ContactFirstName, ContactSurName, ContactTitle,'
      
        ' ContactAddress, ContactAddress2, ContactCity, ContactState, Con' +
        'tactPCode,'
      ' ContactPh, ContactAltPh, ContactMOB, ContactFax'
      'FROM tblcontacts'
      ''
      '')
    Left = 325
    Top = 2
  end
  object ActionList1: TActionList
    Left = 285
    Top = 10
    object actContacts: TAction
      OnExecute = actContactsExecute
      OnUpdate = actContactsUpdate
    end
    object actReschedule: TAction
    end
    object actCancellation: TAction
    end
  end
  object imgCredit: TImageList
    Left = 201
    Top = 9
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000000080808000000000000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000008000808080000000FF000000800000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000800000008000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000FF0000008000000080000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000800000800000000000000000FF00000080000000800000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000FF0000008000808080000000FF0000008000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000808080000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000808080000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000F98FF9FF00000000E10FF0FF00000000
      F01FE07F00000000F83FE03F00000000FC3FE01F00000000F81FE20F00000000
      F00FFF0700000000F00FFF8700000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object qryTempMeals: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FuncMealID, ProductID, Meal, MealSortOrder, '
      'Course, CourseSortOrder, Qty, Date, Time, '
      'ProductName, Description, Price, '
      'FuncBookingID, RoomAllocationID '
      'FROM tblfuncbookingmeals')
    Left = 199
    Top = 305
  end
  object qryTempDrinks: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT FuncDrinkID, ProductID, '
      'Meal, MealSortOrder, Course, CourseSortOrder, Qty, Date, Time, '
      'ProductName, Description, Price, '
      'FuncBookingID, RoomAllocationID '
      'FROM tblfuncbookingdrinks'
      ''
      '')
    Left = 88
    Top = 504
    object StringField1: TStringField
      DisplayWidth = 15
      FieldName = 'Meal'
      Size = 255
    end
    object StringField2: TStringField
      DisplayWidth = 15
      FieldName = 'Course'
      Size = 255
    end
    object DateField1: TDateField
      DisplayWidth = 10
      FieldName = 'Date'
    end
    object TimeField1: TTimeField
      DisplayWidth = 10
      FieldName = 'Time'
      DisplayFormat = 'hh:nn am/pm'
    end
    object StringField3: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 19
      FieldName = 'ProductName'
      Size = 255
    end
    object FloatField1: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
    end
    object FloatField2: TFloatField
      DisplayWidth = 10
      FieldName = 'Price'
      currency = True
    end
    object StringField4: TStringField
      DisplayWidth = 33
      FieldName = 'Description'
      Size = 255
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncBookingID'
      Visible = False
    end
    object IntegerField2: TIntegerField
      DisplayWidth = 10
      FieldName = 'RoomAllocationID'
      Visible = False
    end
    object IntegerField3: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object AutoIncField1: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FuncDrinkID'
      ReadOnly = True
      Visible = False
    end
    object WordField1: TWordField
      DisplayWidth = 10
      FieldName = 'MealSortOrder'
      Visible = False
    end
    object WordField2: TWordField
      DisplayWidth = 10
      FieldName = 'CourseSortOrder'
      Visible = False
    end
  end
  object qryTempRecource: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT FuncResourceAllocationID, FuncBookingID, RoomAllocationID' +
        ', '
      'FuncResourceID, ResourceName, Qty'
      'FROM tblfuncresourceallocation')
    Left = 488
    Top = 336
    object StringField5: TStringField
      DisplayLabel = 'Resource Name'
      DisplayWidth = 30
      FieldName = 'ResourceName'
      Size = 255
    end
    object IntegerField4: TIntegerField
      DisplayWidth = 10
      FieldName = 'Qty'
    end
    object AutoIncField2: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FuncResourceAllocationID'
      ReadOnly = True
      Visible = False
    end
    object IntegerField5: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncBookingID'
      Visible = False
    end
    object IntegerField6: TIntegerField
      DisplayWidth = 10
      FieldName = 'RoomAllocationID'
      Visible = False
    end
    object IntegerField7: TIntegerField
      DisplayWidth = 10
      FieldName = 'FuncResourceID'
      Visible = False
    end
  end
end
