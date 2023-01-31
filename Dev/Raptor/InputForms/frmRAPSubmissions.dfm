inherited fmRAPSubmissions: TfmRAPSubmissions
  Left = 217
  Top = 174
  Caption = 'RAP Submissions'
  ClientHeight = 530
  ClientWidth = 574
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object HeaderPanel: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 574
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    Caption = 'RAP Submission'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object DBText1: TDBText
      Left = 492
      Top = 46
      Width = 66
      Height = 19
      Alignment = taRightJustify
      AutoSize = True
      DataField = 'SubmissionID'
      DataSource = dsRAPProducts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlTitle: TDNMPanel
      Left = 157
      Top = 6
      Width = 267
      Height = 45
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 263
        Height = 41
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
          Width = 263
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'RAP Submission'
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
  end
  object Panel2: TDNMPanel [2]
    Left = 0
    Top = 479
    Width = 574
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      574
      51)
    object Label8: TLabel
      Left = 496
      Top = 20
      Width = 42
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Active?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnCompleted: TDNMSpeedButton
      Left = 85
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
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
    object cmdNew: TDNMSpeedButton
      Left = 183
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
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
      TabOrder = 1
      OnClick = cmdNewClick
    end
    object btnClose: TDNMSpeedButton
      Left = 379
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
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
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object chkActive: TwwCheckBox
      Left = 549
      Top = 18
      Width = 15
      Height = 17
      TabStop = False
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
      Anchors = [akTop, akRight]
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsRAPProducts
      TabOrder = 3
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 281
      Top = 12
      Width = 87
      Height = 27
      Action = actResubmit
      Anchors = [akBottom]
      Caption = '&Re-submit'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
    end
  end
  object Panel1: TDNMPanel [3]
    Left = 0
    Top = 62
    Width = 574
    Height = 417
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      574
      417)
    object pnlInvoices: TDNMPanel
      Left = 0
      Top = 0
      Width = 574
      Height = 169
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        574
        169)
      object lblXMLFileName: TLabel
        Left = 11
        Top = 142
        Width = 83
        Height = 15
        Caption = 'XML File Name'
        Transparent = True
      end
      object lblSubmitted: TLabel
        Left = 11
        Top = 15
        Width = 96
        Height = 15
        Caption = 'Submission Date'
        Transparent = True
      end
      object edtXMLFileName: TwwDBEdit
        Left = 122
        Top = 138
        Width = 380
        Height = 23
        DataField = 'XMLFileName'
        DataSource = dsRAPProducts
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object grdRapSubmissionLines: TwwDBGrid
        Left = 16
        Top = 41
        Width = 541
        Height = 90
        Selected.Strings = (
          'SORef'#9'15'#9'SO Ref'
          'shipDate'#9'10'#9'Ship Date'
          'Veteranno'#9'1'#9'Veteran No'
          'Prescriber'#9'18'#9'Prescriber'#9'F'
          'deliveryCode'#9'15'#9'Delivery code')
        IniAttributes.Delimiter = ';;'
        TitleColor = 14144187
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dsRAPSubmissionSales
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        TabOrder = 1
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnDblClick = grdRapSubmissionLinesDblClick
        FooterColor = 14144187
        object btnRapSubmissionLines: TwwIButton
          Left = 0
          Top = 0
          Width = 23
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
          OnClick = btnRapSubmissionLinesClick
        end
      end
      object dtSubmissionDate: TwwDBDateTimePicker
        Left = 120
        Top = 11
        Width = 121
        Height = 23
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'SubmissionDate'
        DataSource = dsRAPProducts
        Epoch = 1950
        ShowButton = True
        TabOrder = 2
      end
      object btnInvoivces: TDNMSpeedButton
        Left = 277
        Top = 9
        Width = 137
        Height = 27
        Anchors = []
        Caption = 'Select Sales Orders'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
        TabOrder = 3
        OnClick = btnInvoivcesClick
      end
      object btnCreateXML: TDNMSpeedButton
        Left = 478
        Top = 9
        Width = 81
        Height = 27
        Action = actCreateXML
        Anchors = []
        Caption = 'Create XML'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
        TabOrder = 4
      end
      object btnDeleteXML: TDNMSpeedButton
        Left = 478
        Top = 9
        Width = 81
        Height = 27
        Action = actDeleteXML
        Anchors = []
        Caption = 'Delete XML'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
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
        TabOrder = 5
      end
      object cbosalesID: TwwDBLookupCombo
        Left = 312
        Top = 56
        Width = 121
        Height = 23
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'SaleID'#9'10'#9'SaleID'#9'F')
        DataField = 'SaleID'
        DataSource = dsRAPSubmissionSales
        LookupTable = qryLookupSales
        LookupField = 'SaleID'
        TabOrder = 6
        Visible = False
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
    end
    object pnlReport: TDNMPanel
      Left = 0
      Top = 199
      Width = 574
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label3: TLabel
        Left = 11
        Top = 10
        Width = 173
        Height = 15
        Alignment = taRightJustify
        Caption = 'Received Submission Report ?'
        Transparent = True
      end
      object chkReceivedSubmissionReport: TwwCheckBox
        Left = 199
        Top = 12
        Width = 15
        Height = 16
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        DataField = 'ReceivedSubmissionReport'
        DataSource = dsRAPProducts
        TabOrder = 0
        OnClick = chkReceivedSubmissionReportClick
      end
    end
    object pnlamount: TDNMPanel
      Left = 0
      Top = 367
      Width = 574
      Height = 50
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label9: TLabel
        Left = 411
        Top = 11
        Width = 52
        Height = 30
        Caption = 'Amount Received'
        Transparent = True
        WordWrap = True
      end
      object Label7: TLabel
        Left = 274
        Top = 11
        Width = 59
        Height = 30
        Alignment = taRightJustify
        Caption = 'Payment Received? '
        Transparent = True
        WordWrap = True
      end
      object Label6: TLabel
        Left = 11
        Top = 11
        Width = 64
        Height = 30
        Caption = 'Requested Amount'
        Transparent = True
        WordWrap = True
      end
      object edtAmountReceived: TwwDBEdit
        Left = 467
        Top = 15
        Width = 96
        Height = 23
        DataField = 'AmountReceived'
        DataSource = dsRAPProducts
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object chkPaymentReceived: TwwCheckBox
        Left = 341
        Top = 18
        Width = 18
        Height = 17
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        DataField = 'PaymentReceived'
        DataSource = dsRAPProducts
        TabOrder = 1
        OnClick = chkPaymentReceivedClick
        OnEnter = chkPaymentReceivedEnter
      end
      object edtRequestedAmount: TwwDBEdit
        Left = 128
        Top = 15
        Width = 96
        Height = 23
        DataField = 'RequestedAmount'
        DataSource = dsRAPProducts
        ReadOnly = True
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object pnlErrors: TDNMPanel
      Left = 0
      Top = 232
      Width = 574
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label4: TLabel
        Left = 99
        Top = 10
        Width = 83
        Height = 15
        Caption = 'Errors Found ?'
        Transparent = True
      end
      object chkfoundErrors: TwwCheckBox
        Left = 199
        Top = 9
        Width = 15
        Height = 16
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        DataField = 'foundErrors'
        DataSource = dsRAPProducts
        TabOrder = 0
        OnClick = chkfoundErrorsClick
      end
    end
    object pnlErrorDesc: TDNMPanel
      Left = 0
      Top = 272
      Width = 574
      Height = 95
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label5: TLabel
        Left = 19
        Top = 12
        Width = 91
        Height = 15
        Caption = 'Error Messages'
        Transparent = True
      end
      object memSubmissionErrorMessage: TDBMemo
        Left = 128
        Top = 1
        Width = 434
        Height = 89
        DataField = 'SubmissionErrorMessage'
        DataSource = dsRAPProducts
        TabOrder = 0
      end
    end
    object btnViewXML: TDNMSpeedButton
      Left = 508
      Top = 136
      Width = 49
      Height = 28
      Anchors = []
      Caption = 'View'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 5
      OnClick = btnViewXMLClick
    end
    object pnlSubmission: TDNMPanel
      Left = 0
      Top = 166
      Width = 574
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Label10: TLabel
        Left = 118
        Top = 18
        Width = 65
        Height = 15
        Caption = 'Submitted?'
        Transparent = True
      end
      object chkSubmitted: TwwCheckBox
        Left = 200
        Top = 17
        Width = 16
        Height = 16
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        DataField = 'Submitted'
        DataSource = dsRAPProducts
        TabOrder = 0
        OnClick = chkSubmittedClick
      end
    end
  end
  object qryRAPSubmission: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRAPSubmission'
      '')
    Left = 253
    Top = 12
    object qryRAPSubmissionSubmissionID: TAutoIncField
      FieldName = 'SubmissionID'
      ReadOnly = True
    end
    object qryRAPSubmissionSubmissionDate: TDateField
      FieldName = 'SubmissionDate'
    end
    object qryRAPSubmissionTotalInvoices: TIntegerField
      FieldName = 'TotalInvoices'
    end
    object qryRAPSubmissionSubmitted: TStringField
      FieldName = 'Submitted'
      FixedChar = True
      Size = 1
    end
    object qryRAPSubmissionXMLFileName: TStringField
      FieldName = 'XMLFileName'
      Size = 255
    end
    object qryRAPSubmissionReceivedSubmissionReport: TStringField
      FieldName = 'ReceivedSubmissionReport'
      FixedChar = True
      Size = 1
    end
    object qryRAPSubmissionfoundErrors: TStringField
      FieldName = 'foundErrors'
      FixedChar = True
      Size = 1
    end
    object qryRAPSubmissionSubmissionErrorMessage: TMemoField
      FieldName = 'SubmissionErrorMessage'
      BlobType = ftMemo
    end
    object qryRAPSubmissionParentSubmissionId: TIntegerField
      FieldName = 'ParentSubmissionId'
    end
    object qryRAPSubmissionRequestedAmount: TFloatField
      FieldName = 'RequestedAmount'
    end
    object qryRAPSubmissionPaymentReceived: TStringField
      FieldName = 'PaymentReceived'
      FixedChar = True
      Size = 1
    end
    object qryRAPSubmissionAmountReceived: TFloatField
      FieldName = 'AmountReceived'
    end
    object qryRAPSubmissionActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryRAPSubmissionResubmittedID: TIntegerField
      FieldName = 'ResubmittedID'
    end
    object qryRAPSubmissionDepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object qryRAPSubmissionGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object dsRAPProducts: TDataSource
    DataSet = qryRAPSubmission
    Left = 208
    Top = 8
  end
  object qryRAPSubmissionLines: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from  tblrapsubmissionlines order by saleLineId'
      '')
    Left = 333
    Top = 12
    object qryRAPSubmissionLinesSubmissionLineID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'SubmissionLineID'
      ReadOnly = True
    end
    object qryRAPSubmissionLinesSubmissionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SubmissionID'
    end
    object qryRAPSubmissionLinesSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
    end
    object qryRAPSubmissionLinesSaleLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
    end
    object qryRAPSubmissionLinesGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object dsIncvoices: TDataSource
    DataSet = qryRAPSubmissionLines
    Left = 288
    Top = 8
  end
  object qryLookupSales: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`tblsales`.`SaleID`,'
      '`tblsales`.`ShipDate`,'
      '`tblsales`.`DVAFileNum`,'
      '`tblsales`.`InvoiceDocNumber`,'
      '`tblsales`.`ProviderNum`,'
      '`tblsales`.`DVADeliveryCode`'
      'FROM'
      '`tblsales`')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 224
    Top = 168
    object qryLookupSalesSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
    end
    object qryLookupSalesShipDate: TDateField
      FieldName = 'ShipDate'
      Origin = 'tblsales.ShipDate'
      Visible = False
    end
    object qryLookupSalesDVAFileNum: TStringField
      FieldName = 'DVAFileNum'
      Origin = 'tblsales.DVAFileNum'
      Visible = False
      Size = 100
    end
    object qryLookupSalesInvoiceDocNumber: TStringField
      FieldName = 'InvoiceDocNumber'
      Origin = 'tblsales.InvoiceDocNumber'
      Visible = False
      Size = 30
    end
    object qryLookupSalesProviderNum: TStringField
      FieldName = 'ProviderNum'
      Origin = 'tblsales.ProviderNum'
      Visible = False
      Size = 15
    end
    object qryLookupSalesDVADeliveryCode: TStringField
      FieldName = 'DVADeliveryCode'
      Origin = 'tblsales.DVADeliveryCode'
      Visible = False
      Size = 4
    end
  end
  object lsTDNMSpeedButtonActions: TActionList
    Left = 274
    Top = 18
    object actCreateXML: TAction
      Caption = 'Create XML'
      OnExecute = actCreateXMLExecute
      OnUpdate = actCreateXMLUpdate
    end
    object actDeleteXML: TAction
      Caption = 'Delete XML'
      OnExecute = actDeleteXMLExecute
      OnUpdate = actCreateXMLUpdate
    end
    object actResubmit: TAction
      Caption = '&Re-submit'
      OnExecute = actResubmitExecute
      OnUpdate = actResubmitUpdate
    end
  end
  object qryRAPSubmissionSales: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT distinct '
      '`tblrapsubmissionlines`.`SubmissionID`,'
      '`tblrapsubmissionlines`.`SaleID`'
      'from  tblrapsubmissionlines'
      ' Where SubmissionID = :xSubmissionID')
    Left = 77
    Top = 44
    ParamData = <
      item
        DataType = ftString
        Name = 'xSubmissionID'
        Size = 255
      end>
    object qryRAPSubmissionSalesSORef: TStringField
      DisplayLabel = 'SO Ref'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'SORef'
      LookupDataSet = qryLookupSales
      LookupKeyFields = 'SaleID'
      LookupResultField = 'InvoiceDocNumber'
      KeyFields = 'SaleID'
      Lookup = True
    end
    object qryRAPSubmissionSalesshipDate: TDateField
      DisplayLabel = 'Ship Date'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'shipDate'
      LookupDataSet = qryLookupSales
      LookupKeyFields = 'SaleID'
      LookupResultField = 'ShipDate'
      KeyFields = 'SaleID'
      Lookup = True
    end
    object qryRAPSubmissionSalesVeteranno: TStringField
      DisplayLabel = 'Veteran No'
      DisplayWidth = 1
      FieldKind = fkLookup
      FieldName = 'Veteranno'
      LookupDataSet = qryLookupSales
      LookupKeyFields = 'SaleID'
      LookupResultField = 'DVAFileNum'
      KeyFields = 'SaleID'
      Lookup = True
    end
    object qryRAPSubmissionSalesPrescriber: TStringField
      DisplayWidth = 18
      FieldKind = fkLookup
      FieldName = 'Prescriber'
      LookupDataSet = qryLookupSales
      LookupKeyFields = 'SaleID'
      LookupResultField = 'ProviderNum'
      KeyFields = 'SaleID'
      Lookup = True
    end
    object qryRAPSubmissionSalesdeliveryCode: TStringField
      DisplayLabel = 'Delivery code'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'deliveryCode'
      LookupDataSet = qryLookupSales
      LookupKeyFields = 'SaleID'
      LookupResultField = 'DVADeliveryCode'
      KeyFields = 'SaleID'
      Lookup = True
    end
    object IntegerField2: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
      Visible = False
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'SubmissionID'
      Visible = False
    end
  end
  object dsRAPSubmissionSales: TDataSource
    DataSet = qryRAPSubmissionSales
    Left = 48
    Top = 40
  end
end
