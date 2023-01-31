inherited RapSalesGUI: TRapSalesGUI
  Left = 342
  Top = 186
  Caption = 'Raptor Details'
  ClientHeight = 437
  ClientWidth = 477
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 477
    Height = 378
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 99
      Top = 18
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Veteran'
      Transparent = True
    end
    object Label80: TLabel
      Left = 102
      Top = 87
      Width = 47
      Height = 16
      Alignment = taRightJustify
      Caption = 'Gender'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel19: TBevel
      Left = 157
      Top = 81
      Width = 159
      Height = 29
    end
    object Label73: TLabel
      Left = 87
      Top = 223
      Width = 62
      Height = 16
      Alignment = taRightJustify
      Caption = 'Phone No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 29
      Top = 256
      Width = 120
      Height = 16
      Alignment = taRightJustify
      Caption = 'Delivery Post Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 43
      Top = 114
      Width = 106
      Height = 16
      Alignment = taRightJustify
      Caption = 'Delivery Address'
      Transparent = True
    end
    object Label4: TLabel
      Left = 45
      Top = 51
      Width = 104
      Height = 16
      Alignment = taRightJustify
      Caption = 'DVA file number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 60
      Top = 285
      Width = 89
      Height = 16
      Alignment = taRightJustify
      Caption = 'Delivery Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 243
      Top = 256
      Width = 64
      Height = 16
      Alignment = taRightJustify
      Caption = 'Post Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblPriorApprovalRefNo: TLabel
      Left = 7
      Top = 318
      Width = 142
      Height = 16
      Alignment = taRightJustify
      Caption = 'Prior Approval Ref No '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object cboClient: TwwDBLookupCombo
      Left = 157
      Top = 14
      Width = 302
      Height = 24
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'StopCreditImage;ImageIndex;Shrink To Fit')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'70'#9'Company'#9'F')
      DataField = 'VeteranID'
      DataSource = BaseSaleGUI.DSMaster
      LookupTable = cboClientLookup
      LookupField = 'ClientID'
      Options = [loSearchOnBackspace]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
    end
    object rdoGender: TwwRadioGroup
      Left = 160
      Top = 84
      Width = 145
      Height = 22
      TransparentActiveItem = True
      Indents.TextX = 5
      ShowGroupCaption = False
      Transparent = True
      NoSpacing = True
      Columns = 2
      DataField = 'VeteranGender'
      DataSource = BaseSaleGUI.DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Items.Strings = (
        'Male'
        'Female')
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Values.Strings = (
        'M'
        'F')
    end
    object edtPhonenumber: TwwDBEdit
      Left = 157
      Top = 218
      Width = 159
      Height = 24
      DataField = 'VeteranPhoneNo'
      DataSource = BaseSaleGUI.DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtPostCode: TwwDBEdit
      Left = 157
      Top = 252
      Width = 60
      Height = 24
      DataField = 'VeteranShipPostcode'
      DataSource = BaseSaleGUI.DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object txtClientDetails: TDBMemo
      Left = 157
      Top = 114
      Width = 302
      Height = 99
      DataField = 'ShipTo'
      DataSource = BaseSaleGUI.DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chkSubmitted: TwwCheckBox
      Left = 75
      Top = 343
      Width = 98
      Height = 20
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
      Caption = 'Submitted? '
      DataField = 'RapSubmitstatus'
      DataSource = BaseSaleGUI.DSMaster
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      ReadOnly = True
    end
    object edtDVAFilenumber: TwwDBEdit
      Left = 157
      Top = 46
      Width = 159
      Height = 24
      DataField = 'DVAFileNum'
      DataSource = BaseSaleGUI.DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboDVADeliveryCode: TwwDBLookupCombo
      Left = 157
      Top = 281
      Width = 234
      Height = 24
      Hint = '"Who Is The Rep For This Customer"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'DeliveryCode'#9'6'#9'DeliveryCode'#9'F'
        'Description'#9'30'#9'Description'#9'F')
      DataField = 'DVADeliveryCode'
      DataSource = BaseSaleGUI.DSMaster
      LookupTable = qryDVADeliveryCodes
      LookupField = 'DeliveryCode'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = True
    end
    object edtVeteranPostcode: TwwDBEdit
      Left = 326
      Top = 252
      Width = 60
      Height = 24
      DataField = 'VeteranPostcode'
      DataSource = BaseSaleGUI.DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtPriorApprovalRefNo: TwwDBEdit
      Left = 157
      Top = 313
      Width = 60
      Height = 24
      DataField = 'PriorApprovalRefNo'
      DataSource = BaseSaleGUI.DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel2: TDNMPanel [2]
    Left = 0
    Top = 378
    Width = 477
    Height = 59
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      477
      59)
    object btnCompleted: TDNMSpeedButton
      Left = 210
      Top = 9
      Width = 100
      Height = 31
      Anchors = [akTop, akRight]
      Caption = '&Ok'
      Default = True
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 0
      TabStop = False
      OnClick = btnCompletedClick
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 5
    Top = 98
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 5
  end
  inherited MyConnection: TMyConnection
    Left = 5
    Top = 129
  end
  inherited DataState: TDataState
    Left = 5
    Top = 38
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 5
    Top = 159
  end
  object cboClientLookup: TMyQuery
    Connection = BaseSaleGUI.MyConnection
    SQL.Strings = (
      'SELECT'
      
        'C1.ClientID AS ClientID,C1.Company AS Company,C1.Gender,C1.Phone' +
        ',C1.POPostcode,C1.FirstName,C1.MiddleName,C1.LastName , C1.DVANu' +
        'mber'
      'FROM tblclients as C1 Where C1.Active = '#39'T'#39' and Isveteran= '#39'T'#39)
    Options.LongStrings = False
    Left = 5
    Top = 189
    object cboClientLookupCompany: TStringField
      DisplayWidth = 70
      FieldName = 'Company'
      Size = 80
    end
    object cboClientLookupClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object cboClientLookupGender: TStringField
      FieldName = 'Gender'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupPhone: TStringField
      FieldName = 'Phone'
    end
    object cboClientLookupPOPostcode: TStringField
      FieldName = 'POPostcode'
      Size = 255
    end
    object cboClientLookupFirstName: TStringField
      FieldName = 'FirstName'
      Size = 40
    end
    object cboClientLookupMiddleName: TStringField
      FieldName = 'MiddleName'
      Size = 40
    end
    object cboClientLookupLastName: TStringField
      FieldName = 'LastName'
      Size = 40
    end
    object cboClientLookupDVANumber: TStringField
      FieldName = 'DVANumber'
      Size = 100
    end
  end
  object qryDVADeliveryCodes: TMyQuery
    SQL.Strings = (
      'Select * from tblRAPDeliveryCodes'
      'where Active = '#39'T'#39)
    Options.LongStrings = False
    Left = 5
    Top = 220
    object qryDVADeliveryCodesDeliveryCode: TStringField
      DisplayWidth = 6
      FieldName = 'DeliveryCode'
      Size = 4
    end
    object qryDVADeliveryCodesDescription: TStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Size = 100
    end
    object qryDVADeliveryCodesDeliveryCodeID: TIntegerField
      FieldName = 'DeliveryCodeID'
      Visible = False
    end
    object qryDVADeliveryCodesActive: TStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
end
