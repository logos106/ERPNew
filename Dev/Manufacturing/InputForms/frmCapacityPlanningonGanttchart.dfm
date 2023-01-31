inherited fmCapacityPlanningonGanttchart: TfmCapacityPlanningonGanttchart
  Left = 668
  Top = 185
  HelpContext = 927001
  Caption = 'Capacity Planning'
  ExplicitLeft = 668
  ExplicitTop = 185
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    ExplicitTop = 558
    ExplicitWidth = 1008
  end
  inherited shapehint: TShape
    Left = 19
    ExplicitLeft = 19
  end
  inherited shapehintextra1: TShape
    Left = 66
    ExplicitLeft = 55
  end
  inherited GanttGraph: TWGSGanttGraph
    ExplicitHeight = 341
  end
  inherited DNMPanel2: TDNMPanel
    ExplicitLeft = -56
    ExplicitTop = 114
    HelpContext = 927009
    inherited Label8: TLabel
      Left = 839
      Top = 10
      ExplicitLeft = 839
      ExplicitTop = 10
    end
    inherited grpTimeMode: TRadioGroup
      Width = 828
      HelpContext = 927004
      ExplicitWidth = 828
    end
    inherited spincolWidth: TSpinEdit
      Left = 922
      Top = 5
      OnExit = spincolWidthExit
      ExplicitLeft = 922
      ExplicitTop = 5
    end
  end
  inherited pnlBottom: TDNMPanel
    ExplicitTop = 485
    HelpContext = 927010
    inherited btnSave: TDNMSpeedButton
      Left = 351
      OnClick = btnSaveClick
      ExplicitLeft = 294
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 723
      ExplicitLeft = 612
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 537
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 927002
      Anchors = [akBottom]
      Caption = 'Clear'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
    object btnAutoSchedule: TDNMSpeedButton
      Left = 17
      Top = 6
      Width = 110
      Height = 27
      HelpContext = 927003
      Anchors = [akLeft, akBottom]
      Caption = 'Auto Schedule'
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
      AutoDisableParentOnclick = True
      OnClick = btnAutoScheduleClick
    end
  end
  inherited pnlTop: TDNMPanel
    ExplicitLeft = -8
    ExplicitTop = -2
    ExplicitWidth = 1008
    HelpContext = 927011
    inherited Label1: TLabel
      Left = 813
      ExplicitLeft = 813
    end
    inherited pnlOptions: TDNMPanel
      Left = 5
      Width = 725
      Height = 45
      HelpContext = 927005
      ExplicitLeft = 5
      ExplicitWidth = 725
      ExplicitHeight = 45
      inherited Label4: TLabel
        Top = 2
        ExplicitTop = 2
      end
      inherited lblResource: TLabel
        Left = 147
        Top = 2
        ExplicitLeft = 147
        ExplicitTop = 2
      end
      inherited Label3: TLabel
        Left = 294
        Top = 2
        ExplicitLeft = 294
        ExplicitTop = 2
      end
      inherited Label7: TLabel
        Left = 427
        Top = 2
        ExplicitLeft = 427
        ExplicitTop = 2
      end
      inherited lblSelectionoption: TLabel
        Left = 569
        Top = 4
        Width = 125
        Height = 32
        HelpContext = 927006
        Anchors = [akRight]
        AutoSize = True
        ExplicitLeft = 569
        ExplicitTop = 10
        ExplicitWidth = 125
        ExplicitHeight = 32
      end
      inherited cboCustomers: TComboBox
        Top = 18
        Width = 132
        HelpContext = 927007
        ExplicitTop = 18
        ExplicitWidth = 132
      end
      inherited cboResource: TComboBox
        Left = 147
        Top = 18
        ExplicitLeft = 147
        ExplicitTop = 18
      end
      inherited cboResourceProcess: TComboBox
        Left = 294
        Top = 18
        ExplicitLeft = 294
        ExplicitTop = 18
      end
      inherited cboSOIds: TComboBox
        Left = 427
        Top = 18
        ExplicitLeft = 427
        ExplicitTop = 18
      end
      inherited chkSelectionoption: TwwCheckBox
        Left = 698
        Top = 11
        ExplicitLeft = 698
        ExplicitTop = 11
      end
    end
    inherited edtDateFrom: TwwDBDateTimePicker
      Left = 813
      ExplicitLeft = 813
    end
    inherited pnlTitle: TDNMPanel
      Anchors = []
      HelpContext = 927012
      inherited TitleShader: TShader
        ExplicitWidth = 291
        inherited TitleLabel: TLabel
          ExplicitWidth = 291
        end
      end
    end
    inherited btnPrevPage: TDNMSpeedButton
      Left = 718
      ExplicitLeft = 718
    end
    inherited grpGridDetail: TwwRadioGroup
      Left = 731
      Top = 75
      Width = 264
      Height = 33
      HelpContext = 927008
      ExplicitLeft = 731
      ExplicitTop = 75
      ExplicitWidth = 264
      ExplicitHeight = 33
    end
    inherited btnfirstpage: TDNMSpeedButton
      Left = 623
      ExplicitLeft = 623
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102006001680110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryMaster: TERPQuery
    SQL.Strings = (
      
        'SELECT pt.parentId, pt.ProcTreeId, pt.TreeRootId, s.SaleId, s.In' +
        'voiceDocNumber as SaleDocNumber, s.CustomerName as SaleCustomerN' +
        'ame, s.SaleDate, s.ShipDate as SaleShipDate, sl.SaleLineId, sl.P' +
        'roductName as SaleLineProductName, sl.Product_Description as Sal' +
        'eLineProductDescription,  sl.UnitofMeasureQtySold as SaleLineQua' +
        'ntity, sl.ShipDate as SaleLineShipDate, pt.Caption as ProcTreeCa' +
        'ption, pt.Description as ProcTreeDescription,  if(pt.ParentId=0 ' +
        'and pt.masterId = Sl.saleLineId,pt.TotalQty , pt.TreePartUOMTota' +
        'lQty) as ProcTreeTotalQty, pt.PartsId as ProcTreePartId, pt.Leve' +
        'l as ProcTreeLevel, pt.SequenceDown as ProcTreeSequenceDown, pt.' +
        'Complete as ProcTreeComplete, ps.Description as ProcessDesc, pp.' +
        'Id as ProcessPartId, pp.Duration as ProcessPartDuration, pp.Stat' +
        'us as ProcessStatus, pp.TimeStart as ProcessTimeStart, pp.SetupD' +
        'uration as ProcessPartSetupDuration, pp.BreakdownDuration as Pro' +
        'cessPartBreakdownDuration, pp.ProcessStepSeq as ProcessSequence,' +
        ' pp.ProcessStepId, rp.ProcResourceId as ProcessResourceId, psl.P' +
        'rocPickSlipId FROM tblSales s JOIN tblSalesLines sl ON s.SaleId ' +
        '= sl.SaleId JOIN tblProcTree pt on pt.MasterId = sl.SaleLineId a' +
        'nd pt.IsTemplate = "F" JOIN tblProcessPart pp ON pp.ProcTreeId =' +
        ' pt.ProcTreeId JOIN tblProcessStep ps ON ps.Id = pp.ProcessStepI' +
        'd JOIN tblProcResourceProcess rp ON rp.ProcessStepId = ps.Id LEF' +
        'T JOIN tblProcPickSlipLine psl ON psl.ProcTreeId = pt.ProcTreeId' +
        ' WHERE s.IsSalesOrder = "T" and if(pt.ParentId=0 and pt.masterId' +
        ' = Sl.saleLineId,pt.TotalQty , pt.TreePartUOMTotalQty)  <> 0 AND' +
        ' (pp.Status = "psNotScheduled" OR  ((pp.TimeStart >= '#39'2012-04-18' +
        #39' AND pp.TimeStart <= '#39'2012-05-18'#39'))) ORDER BY sl.ShipDate, s.In' +
        'voiceDocNumber, pt.TreeRootId, pt.SequenceDown, pp.ProcessStepSe' +
        'q, processtimestart')
    OnCalcFields = QryMasterCalcFields
    object QryMasterparentId: TIntegerField
      FieldName = 'parentId'
    end
    object QryMasterProcTreeId: TIntegerField
      FieldName = 'ProcTreeId'
    end
    object QryMasterTreeRootId: TIntegerField
      FieldName = 'TreeRootId'
    end
    object QryMasterSaleId: TIntegerField
      FieldName = 'SaleId'
    end
    object QryMasterSaleDocNumber: TWideStringField
      FieldName = 'SaleDocNumber'
      Size = 30
    end
    object QryMasterSaleCustomerName: TWideStringField
      FieldName = 'SaleCustomerName'
      Size = 255
    end
    object QryMasterSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object QryMasterSaleShipDate: TDateField
      FieldName = 'SaleShipDate'
    end
    object QryMasterSaleLineId: TIntegerField
      FieldName = 'SaleLineId'
    end
    object QryMasterSaleLineProductName: TWideStringField
      FieldName = 'SaleLineProductName'
      Size = 60
    end
    object QryMasterSaleLineProductDescription: TWideStringField
      FieldName = 'SaleLineProductDescription'
      Size = 255
    end
    object QryMasterSaleLineQuantity: TFloatField
      FieldName = 'SaleLineQuantity'
    end
    object QryMasterSaleLineShipDate: TDateTimeField
      FieldName = 'SaleLineShipDate'
    end
    object QryMasterProcTreeCaption: TWideStringField
      FieldName = 'ProcTreeCaption'
      Size = 255
    end
    object QryMasterProcTreeDescription: TWideStringField
      FieldName = 'ProcTreeDescription'
      Size = 255
    end
    object QryMasterProcTreeTotalQty: TFloatField
      FieldName = 'ProcTreeTotalQty'
    end
    object QryMasterProcTreePartId: TIntegerField
      FieldName = 'ProcTreePartId'
    end
    object QryMasterProcTreeLevel: TIntegerField
      FieldName = 'ProcTreeLevel'
    end
    object QryMasterProcTreeSequenceDown: TIntegerField
      FieldName = 'ProcTreeSequenceDown'
    end
    object QryMasterProcTreeComplete: TWideStringField
      FieldName = 'ProcTreeComplete'
      FixedChar = True
      Size = 1
    end
    object QryMasterProcessDesc: TWideStringField
      FieldName = 'ProcessDesc'
      Size = 255
    end
    object QryMasterProcessPartId: TIntegerField
      FieldName = 'ProcessPartId'
    end
    object QryMasterProcessPartDuration: TFloatField
      FieldName = 'ProcessPartDuration'
    end
    object QryMasterProcessStatus: TWideStringField
      FieldName = 'ProcessStatus'
      Size = 255
    end
    object QryMasterProcessTimeStart: TDateTimeField
      FieldName = 'ProcessTimeStart'
    end
    object QryMasterProcessPartSetupDuration: TFloatField
      FieldName = 'ProcessPartSetupDuration'
    end
    object QryMasterProcessPartBreakdownDuration: TFloatField
      FieldName = 'ProcessPartBreakdownDuration'
    end
    object QryMasterProcessSequence: TIntegerField
      FieldName = 'ProcessSequence'
    end
    object QryMasterProcessStepId: TIntegerField
      FieldName = 'ProcessStepId'
    end
    object QryMasterProcessResourceId: TIntegerField
      FieldName = 'ProcessResourceId'
    end
    object QryMasterProcPickSlipId: TIntegerField
      FieldName = 'ProcPickSlipId'
    end
    object QryMastercProcessPartDuration: TStringField
      FieldKind = fkCalculated
      FieldName = 'cProcessPartDuration'
      Size = 100
      Calculated = True
    end
  end
  inherited QryDetails: TERPQuery
    SQL.Strings = (
      'SELECT '
      'ProcesstimeID, ProcessPartID, TimeStart, '
      
        ' if(ifnull(TimeEnd,0)='#39'1899-12-30 00:00:00'#39' , Date_add(Timestart' +
        ' , Interval Duration Second), TimeEnd) timeend'
      'FROM tblProcessTime   PT'
      'where ifnull(timeStart,0)<> '#39'1899-12-30 00:00:00'#39
      'ORDER BY TimeStart')
    MasterSource = dsMaster
    MasterFields = 'ProcessPartId'
    DetailFields = 'ProcessPartId'
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProcessPartId'
      end>
    object QryDetailsProcesstimeID: TIntegerField
      FieldName = 'ProcesstimeID'
    end
    object QryDetailsProcessPartID: TIntegerField
      FieldName = 'ProcessPartID'
    end
    object QryDetailsTimeStart: TDateTimeField
      FieldName = 'TimeStart'
    end
    object QryDetailstimeend: TDateTimeField
      FieldName = 'timeend'
    end
  end
  inherited Datasource: TWGSDataSource
    OnChange = DatasourceChange
    Left = 226
    Top = 236
  end
end
