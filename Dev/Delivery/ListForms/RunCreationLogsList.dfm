inherited RunCreationLogsListGUI: TRunCreationLogsListGUI
  Left = 53
  Top = 581
  Caption = 'Run Creation Logs'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'Run Creation Logs'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Summary All'
          'Summary'
          'Details All'
          'Details')
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'RunDate'#9'10'#9'Run Date'
        'DespatchRunID'#9'10'#9'Despatch ID'#9'F'
        'State'#9'15'#9'State'
        'Company'#9'30'#9'Company'
        'Contact'#9'30'#9'Contact'
        'Description'#9'50'#9'Description')
      TitleColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tmp_logs_admin_52e07ca6;')
    AfterOpen = qryMainAfterOpen
    Left = 88
    object qryMainRunDate: TDateField
      DisplayLabel = 'Run Date'
      DisplayWidth = 10
      FieldName = 'RunDate'
      Origin = 'tmp_logs_admin_52e07ca6.RunDate'
    end
    object qryMainDespatchRunID: TIntegerField
      DisplayLabel = 'Despatch ID'
      DisplayWidth = 10
      FieldName = 'DespatchRunID'
      Origin = 'tmp_logs_admin_52e07ca6.DespatchRunID'
    end
    object qryMainState: TStringField
      DisplayWidth = 15
      FieldName = 'State'
      Origin = 'tmp_logs_admin_52e07ca6.State'
      Size = 255
    end
    object qryMainCompany: TStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Origin = 'tmp_logs_admin_52e07ca6.Company'
      Size = 255
    end
    object qryMainContact: TStringField
      DisplayWidth = 30
      FieldName = 'Contact'
      Origin = 'tmp_logs_admin_52e07ca6.Contact'
      Size = 255
    end
    object qryMainDescription: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Origin = 'tmp_logs_admin_52e07ca6.Description'
      Size = 255
    end
    object qryMainDetail: TIntegerField
      DisplayWidth = 10
      FieldName = 'Detail'
      Origin = 'tmp_logs_admin_52e07ca6.Detail'
      Visible = False
    end
  end
end
