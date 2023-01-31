inherited DespatchRunListGUI: TDespatchRunListGUI
  Left = 87
  Top = 555
  Caption = 'Dispatch List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
    inherited cmdClose: TDNMSpeedButton
      Left = 619
      TabOrder = 5
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 231
      Top = -16
      TabOrder = 0
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 504
      TabOrder = 4
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 389
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 276
      TabOrder = 2
    end
    inherited pnlAdvPrinting: TDNMPanel
      inherited ChkChooseRpt: TCheckBox
        TabOrder = 1
      end
      inherited chkPreview: TCheckBox
        TabOrder = 0
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      TabOrder = 1
    end
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited pnlHeader: TPanel
      Caption = 'Dispatch List'
      Color = 15527129
      ParentColor = False
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Outstanding'
          'Completed'
          'All')
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'IsPublicHoliday;CheckBox;T;F'
        'InvoicesGenerated;CheckBox;T;F'
        'Done;CheckBox;T;F'
        'Rescheduled;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'Global Ref'#9'F'#9
        'DespatchID'#9'5'#9'Dispatch ID'#9'F'#9
        'RunName'#9'25'#9'Run Name'#9#9
        'Operator'#9'20'#9'Operator'#9#9
        'RunDate'#9'10'#9'Run Date'#9#9
        'ClassName'#9'20'#9'Department Name'#9#9
        'IsPublicHoliday'#9'1'#9'Is Public Holiday'#9#9
        'InvoicesGenerated'#9'1'#9'Invoices Created'#9#9
        'Done'#9'1'#9'Done'#9#9)
      TitleColor = 15527129
      FooterColor = clWhite
    end
  end
  inherited imgPopup: TImageList
    Left = 160
    Top = 216
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT GlobalRef , '
      'RunName, RunID, Operator, RunDate, DespatchID,'
      
        'ClassName, IsPublicHoliday, InvoicesGenerated, Done, Rescheduled' +
        ', RescheduleDate'
      'FROM tbldespatchruns'
      'WHERE RunDate >= :xDateFrom AND RunDate <= :xDateTo;')
    AfterOpen = qryMainAfterOpen
    ParamData = <
      item
        DataType = ftString
        Name = 'xDateFrom'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'xDateTo'
      end>
    object qryMainGlobalRef: TStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainDespatchID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Dispatch ID'
      DisplayWidth = 5
      FieldName = 'DespatchID'
      Origin = 'tbldespatchruns.DespatchID'
    end
    object qryMainRunName: TStringField
      DisplayLabel = 'Run Name'
      DisplayWidth = 25
      FieldName = 'RunName'
      Origin = 'tbldespatchruns.RunName'
      ReadOnly = True
      Size = 255
    end
    object qryMainOperator: TStringField
      DisplayWidth = 20
      FieldName = 'Operator'
      Origin = 'tbldespatchruns.Operator'
      ReadOnly = True
      Size = 255
    end
    object qryMainRunDate: TDateField
      DisplayLabel = 'Run Date'
      DisplayWidth = 10
      FieldName = 'RunDate'
      Origin = 'tbldespatchruns.RunDate'
      ReadOnly = True
    end
    object qryMainClassName: TStringField
      DisplayLabel = 'Department Name'
      DisplayWidth = 20
      FieldName = 'ClassName'
      Origin = 'tbldespatchruns.ClassName'
      ReadOnly = True
      Size = 255
    end
    object qryMainIsPublicHoliday: TStringField
      DisplayLabel = 'Is Public Holiday'
      DisplayWidth = 1
      FieldName = 'IsPublicHoliday'
      Origin = 'tbldespatchruns.IsPublicHoliday'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryMainInvoicesGenerated: TStringField
      DisplayLabel = 'Invoices Created'
      DisplayWidth = 1
      FieldName = 'InvoicesGenerated'
      Origin = 'tbldespatchruns.InvoicesGenerated'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryMainDone: TStringField
      DisplayWidth = 1
      FieldName = 'Done'
      Origin = 'tbldespatchruns.Done'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object qryMainRescheduled: TStringField
      DisplayWidth = 1
      FieldName = 'Rescheduled'
      Origin = 'tbldespatchruns.Rescheduled'
      ReadOnly = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainRescheduleDate: TDateField
      DisplayLabel = 'Reschedule Date'
      DisplayWidth = 10
      FieldName = 'RescheduleDate'
      Origin = 'tbldespatchruns.RescheduleDate'
      ReadOnly = True
      Visible = False
    end
    object qryMainRunID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RunID'
      Origin = 'tbldespatchruns.RunID'
      ReadOnly = True
      Visible = False
    end
  end
end
