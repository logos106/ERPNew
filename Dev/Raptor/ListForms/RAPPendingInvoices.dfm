inherited RAPPendingInvoiceGUI: TRAPPendingInvoiceGUI
  Left = 240
  Top = 140
  Caption = 'Sales Orders to Submit'
  ClientWidth = 821
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    Width = 821
  end
  inherited FooterPanel: TPanel
    Width = 821
    Color = 14144187
    inherited Label121: TLabel
      Left = 197
      Alignment = taCenter
      Caption = '"Hold down the shift key to make multiple Selection"'
    end
    inherited lblTimeLabel: TLabel
      Left = 582
    end
    inherited lblTime: TLabel
      Left = 653
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 475
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 192
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 481
      Top = 72
      Enabled = False
      WordWrap = True
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 272
      Top = 72
      Enabled = False
      WordWrap = True
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 169
      Top = 72
      Enabled = False
      WordWrap = True
    end
    inherited barStatus: TStatusBar
      Width = 821
    end
    inherited pnlAdvPrinting: TDNMPanel
      Left = 280
    end
    object cmdSelect: TDNMSpeedButton
      Left = 262
      Top = 32
      Width = 87
      Height = 27
      Hint = '"Add A New Entry"'
      Anchors = [akBottom]
      Caption = '&Ok'
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
      TabOrder = 9
      TabStop = False
      OnClick = cmdSelectClick
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 368
      Top = 32
      Width = 87
      Height = 27
      Hint = '"Add A New Entry"'
      Anchors = [akBottom]
      Caption = 'Select &All'
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
      TabOrder = 10
      TabStop = False
      OnClick = DNMSpeedButton1Click
    end
  end
  inherited HeaderPanel: TPanel
    Width = 821
    Color = 14144187
    inherited lblFrom: TLabel
      Left = 596
    end
    inherited lblTo: TLabel
      Left = 719
      Visible = False
    end
    inherited pnlHeader: TPanel
      Left = 112
      Width = 597
      Caption = 'sales Orders to Submit'
      inherited TitleShader: TShader
        Width = 595
        inherited TitleLabel: TLabel
          Width = 595
        end
      end
    end
    inherited Panel2: TPanel
      Width = 821
      Visible = False
      inherited grpFilters: TRadioGroup
        Width = 380
      end
    end
    inherited Panel3: TPanel
      Width = 821
      Visible = False
      inherited edtSearch: TEdit
        Width = 212
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Left = 632
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Left = 736
      Visible = False
    end
    inherited cboDateRange: TComboBox
      Left = 632
    end
  end
  inherited Panel1: TPanel
    Width = 821
    inherited grdMain: TwwDBGrid
      Width = 821
      Selected.Strings = (
        'SaleId'#9'10'#9'Invoice Num'#9#9
        'ShipDate'#9'10'#9'ShipDate'#9#9
        'VeteranName'#9'60'#9'Veteran'#9#9
        'PriorApprovalRefNo'#9'19'#9'Prior Approval~RefNo'#9#9
        'DVADeliveryCode'#9'10'#9'Delivery~Code'#9#9)
      TitleColor = 14144187
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
      UseTFields = False
      FooterColor = 14144187
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT'
      'Distinct'
      '`tblsales`.SaleId,'
      '`tblsales`.`ShipDate`,'
      
        'Concat_WS('#39' '#39' , `tblsales`.Veteranfirstname,tblsales.VeteranInit' +
        'ial, tblsales.VeteranSurname) as VeteranName,'
      '`tblsales`.PriorApprovalRefNo,'
      '`tblsales`.DVADeliveryCode, '
      
        'if(tblsales.IsSalesOrder = '#39'T'#39' , '#39'Sales Order'#39' , '#39'Invoice'#39') as C' +
        'ategory'
      'FROM'
      '`tblsales`'
      
        'Inner Join `tblsaleslines` ON `tblsales`.`SaleID` = `tblsaleslin' +
        'es`.`SaleID`'
      
        'Left join tblSales as converted  on converted.SalesorderGlobalRE' +
        'f = tblsales.globalREf'
      'Where ifnull(`tblsales`.VeteranID,0) <> 0 '
      
        'and (`tblsales`.RapSubmitstatus = '#39'F'#39' or `tblsales`.RapSubmitsta' +
        'tus = '#39#39')'
      
        'and ISRapProduct = '#39'T'#39' and  (tblsales.IsSalesOrder = '#39'T'#39' /*or tb' +
        'lsales.IsInvoice = '#39'T'#39'*/)'
      'and tblsaleslines.Invoiced = '#39'T'#39
      
        'and ((tblsales.isPriorApprovalRequired ='#39'T'#39' and ifnull(tblsales.' +
        'PriorApprovalRefNo,'#39#39') <> '#39#39') or (tblsales.isPriorApprovalRequir' +
        'ed  = '#39'F'#39'))'
      'and ifnull(converted.SalesorderGlobalREf , '#39#39') = '#39#39)
    object qryMainSaleId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Invoice Num'
      DisplayWidth = 10
      FieldName = 'SaleId'
      Origin = 'tblsales.SaleId'
    end
    object qryMainShipDate: TDateField
      DisplayWidth = 10
      FieldName = 'ShipDate'
      Origin = 'tblsales.ShipDate'
    end
    object qryMainVeteranName: TStringField
      DisplayLabel = 'Veteran'
      DisplayWidth = 60
      FieldName = 'VeteranName'
      Origin = 'tblsales.VeteranName'
      Size = 203
    end
    object qryMainPriorApprovalRefNo: TStringField
      DisplayLabel = 'Prior Approval~RefNo'
      DisplayWidth = 19
      FieldName = 'PriorApprovalRefNo'
      Origin = 'tblsales.PriorApprovalRefNo'
      Size = 30
    end
    object qryMainDVADeliveryCode: TStringField
      DisplayLabel = 'Delivery~Code'
      DisplayWidth = 10
      FieldName = 'DVADeliveryCode'
      Origin = 'tblsales.DVADeliveryCode'
      Size = 4
    end
    object qryMainCategory: TStringField
      DisplayWidth = 11
      FieldName = 'Category'
      Origin = 'tblsales.Category'
      Visible = False
      Size = 11
    end
  end
  inherited ExportDialog: TProgressDialog
    Left = 251
    Top = 10
  end
end
