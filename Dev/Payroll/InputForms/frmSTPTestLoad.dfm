inherited fmSTPTestLoad: TfmSTPTestLoad
  HelpContext = 1672002
  BorderStyle = bsSingle
  Caption = 'STP Test Load'
  ClientHeight = 565
  ClientWidth = 564
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 570
  ExplicitHeight = 594
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 564
    HelpContext = 1672003
    ExplicitTop = 454
    ExplicitWidth = 564
  end
  object Label1: TLabel [4]
    Left = 24
    Top = 29
    Width = 101
    Height = 15
    HelpContext = 1672004
    Caption = 'Main File (Header)'
  end
  object Label2: TLabel [5]
    Left = 24
    Top = 80
    Width = 113
    Height = 15
    HelpContext = 1672005
    Caption = 'Files (EMP Records)'
  end
  object Label3: TLabel [6]
    Left = 24
    Top = 215
    Width = 166
    Height = 15
    HelpContext = 1672006
    Caption = 'PaymentRecordTransactionD'
  end
  object Label4: TLabel [7]
    Left = 25
    Top = 243
    Width = 190
    Height = 15
    HelpContext = 1672007
    Caption = 'MessageTimestampGenerationDt'
  end
  object Label5: TLabel [8]
    Left = 25
    Top = 272
    Width = 106
    Height = 15
    HelpContext = 1672008
    Caption = 'EmploymentStartD'
  end
  object Label6: TLabel [9]
    Left = 25
    Top = 300
    Width = 36
    Height = 15
    HelpContext = 1672009
    Caption = 'StartD'
  end
  object Label7: TLabel [10]
    Left = 25
    Top = 329
    Width = 29
    Height = 15
    HelpContext = 1672010
    Caption = 'EndD'
  end
  object Label8: TLabel [11]
    Left = 24
    Top = 358
    Width = 231
    Height = 15
    HelpContext = 1672011
    Caption = 'PaymentRecordPaymentEffectiveD (ETP)'
  end
  object lblRecCount: TLabel [12]
    Left = 427
    Top = 74
    Width = 90
    Height = 15
    HelpContext = 1672012
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Record Count: 0'
  end
  object Label9: TLabel [13]
    Left = 25
    Top = 438
    Width = 92
    Height = 15
    HelpContext = 1672013
    Caption = 'Test Case Name'
  end
  object Label10: TLabel [14]
    Left = 25
    Top = 385
    Width = 63
    Height = 15
    HelpContext = 1672014
    Caption = 'SignatureD'
  end
  object btnSubmit: TDNMSpeedButton [15]
    Left = 172
    Top = 530
    Width = 87
    Height = 27
    HelpContext = 1672015
    Anchors = [akBottom]
    Caption = 'Load'
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
    AutoDisableParentOnclick = True
    OnClick = btnSubmitClick
  end
  object btnCancel: TDNMSpeedButton [16]
    Left = 305
    Top = 530
    Width = 87
    Height = 27
    HelpContext = 1672016
    Anchors = [akBottom]
    Caption = '&Close'
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
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
  end
  object edtFile: TEdit [17]
    Left = 24
    Top = 46
    Width = 497
    Height = 23
    HelpContext = 1672017
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btnLoadHeader: TBitBtn [18]
    Left = 523
    Top = 45
    Width = 33
    Height = 25
    HelpContext = 1672018
    Caption = '...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = btnLoadHeaderClick
  end
  object memFiles: TMemo [19]
    Left = 24
    Top = 96
    Width = 497
    Height = 105
    HelpContext = 1672019
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 4
    WordWrap = False
  end
  object btnLoadFiles: TBitBtn [20]
    Left = 523
    Top = 95
    Width = 33
    Height = 25
    HelpContext = 1672020
    Caption = '...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = btnLoadFilesClick
  end
  object dtPaymentRecordTransactionD: TDateTimePicker [21]
    Left = 400
    Top = 207
    Width = 121
    Height = 23
    HelpContext = 1672021
    Date = 43417.412421215270000000
    Time = 43417.412421215270000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object dtMessageTimestampGenerationDt_Date: TDateTimePicker [22]
    Left = 321
    Top = 235
    Width = 97
    Height = 23
    HelpContext = 1672022
    Date = 43417.412421215270000000
    Time = 43417.412421215270000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object dtMessageTimestampGenerationDt_Time: TDateTimePicker [23]
    Left = 424
    Top = 235
    Width = 97
    Height = 23
    HelpContext = 1672023
    Date = 43417.412421215270000000
    Time = 43417.412421215270000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Kind = dtkTime
    ParentFont = False
    TabOrder = 8
  end
  object dtEmploymentStartD: TDateTimePicker [24]
    Left = 401
    Top = 264
    Width = 121
    Height = 23
    HelpContext = 1672024
    Date = 43417.412421215270000000
    Time = 43417.412421215270000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object dtStartD: TDateTimePicker [25]
    Left = 401
    Top = 292
    Width = 121
    Height = 23
    HelpContext = 1672025
    Date = 43417.412421215270000000
    Time = 43417.412421215270000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object dtEndD: TDateTimePicker [26]
    Left = 401
    Top = 321
    Width = 121
    Height = 23
    HelpContext = 1672026
    Date = 43417.412421215270000000
    Time = 43417.412421215270000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object chkUpdate: TCheckBox [27]
    Left = 424
    Top = 15
    Width = 97
    Height = 17
    HelpContext = 1672027
    Alignment = taLeftJustify
    Caption = 'Update'
    TabOrder = 12
    OnClick = chkUpdateClick
  end
  object dtPaymentRecordPaymentEffectiveD: TDateTimePicker [28]
    Left = 400
    Top = 350
    Width = 121
    Height = 23
    HelpContext = 1672028
    Date = 43417.412421215270000000
    Time = 43417.412421215270000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object chkReplaceDates: TCheckBox [29]
    Left = 24
    Top = 414
    Width = 386
    Height = 17
    HelpContext = 1672029
    Alignment = taLeftJustify
    Caption = 'Replace Dates In Message'
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
  object memTestCaseName: TMemo [30]
    Left = 25
    Top = 456
    Width = 497
    Height = 61
    HelpContext = 1672030
    TabOrder = 15
  end
  object chkInvalidated: TCheckBox [31]
    Left = 280
    Top = 15
    Width = 97
    Height = 17
    HelpContext = 1672031
    Alignment = taLeftJustify
    Caption = 'Invalidated'
    TabOrder = 16
    OnClick = chkUpdateClick
  end
  object edtSignatureD: TEdit [32]
    Left = 401
    Top = 379
    Width = 121
    Height = 23
    HelpContext = 1672032
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    Text = 'edtSignatureD'
  end
  inherited tmrProcessMessage: TTimer
    Left = 137
    Top = 11
  end
  inherited tmrdelay: TTimer
    Left = 48
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 152
    Top = 65528
  end
  inherited tmrdelayMsg: TTimer
    Left = 96
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 97
    Top = 0
  end
  object OpenDialog: TOpenDialog
    Filter = 'XML Files|*.xml|All Files|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 448
    Top = 152
  end
end
