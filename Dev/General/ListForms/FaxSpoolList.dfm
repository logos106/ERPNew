inherited FaxSpoolListingGUI: TFaxSpoolListingGUI
  Left = 124
  Top = 126
  HelpContext = 132000
  Caption = 'Fax Spool List'
  Color = 14153215
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 132001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 132002
    Color = 14153215
    inherited Label3: TLabel
      HelpContext = 132003
    end
    inherited lblTotal: TLabel
      HelpContext = 132004
    end
    inherited lblNote: TLabel
      HelpContext = 132005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 132006
    end
    inherited lblTime: TLabel
      HelpContext = 132007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 132008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 132009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 132010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 132011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 132012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 132013
      inherited LblChooseTemplate: TLabel
        HelpContext = 132014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 132015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 132016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 132017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 132018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 132019
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 132020
    Color = 14153215
    inherited lblFrom: TLabel
      HelpContext = 132021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 132022
      Visible = False
    end
    inherited pnlHeader: TPanel
      Left = 276
      Width = 462
      HelpContext = 132023
      Caption = 'Fax Spool List'
      Color = 14153215
      ParentColor = False
      ExplicitLeft = 276
      ExplicitWidth = 462
      inherited TitleShader: TShader
        Width = 460
        HelpContext = 132024
        ExplicitWidth = 460
        inherited TitleLabel: TLabel
          Width = 460
          HelpContext = 132025
          ExplicitWidth = 460
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 132026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 132027
        ItemIndex = 0
        Items.Strings = (
          'Spooled'
          'Cancelled'
          'Completed')
      end
      inherited pnlButtons: TPanel
        HelpContext = 132028
        inherited lblcustomReport: TLabel
          HelpContext = 132029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 132030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 132031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 132032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 132033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 132034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 132035
      inherited lblFilter: TLabel
        HelpContext = 132036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 132037
      end
      inherited cboFilter: TComboBox
        HelpContext = 132038
      end
      inherited edtSearch: TEdit
        HelpContext = 132039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 132040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 132041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 132042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 132043
    inherited grdMain: TwwDBGrid
      HelpContext = 132044
      PictureMasks.Strings = (
        'SpooledAt'#9'dd/mm/yyyy'#9'T'#9'T')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9#9
        'FaxSpoolID'#9'10'#9'FaxSpoolID'#9#9
        'SpooledAt'#9'13'#9'SpooledAt'#9#9
        'CurrentStatus'#9'11'#9'CurrentStatus'#9#9
        'FaxBy'#9'10'#9'FaxBy'#9#9
        'FaxTo'#9'10'#9'FaxTo'#9#9
        'FaxNumber'#9'10'#9'FaxNumber'#9#9
        'StartedSending'#9'13'#9'StartedSending'#9'F'
        'CompletedSending'#9'13'#9'CompletedSending'#9'F'
        'DialAttempts'#9'10'#9'DialAttempts'#9#9
        'Priority'#9'5'#9'Priority'#9#9
        'Cancelled'#9'8'#9'Cancelled'#9#9
        'SentOk'#9'6'#9'SentOk'#9#9)
      TitleColor = 14153215
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT '
      'tblfaxspool.GlobalRef as GlobalRef, '
      'FaxSpoolID AS FaxSpoolID,'
      'DateSpooled as SpooledAt,'
      'Status as CurrentStatus, '
      'EmployeeName as FaxBy, '
      'ClientName as FaxTo, '
      'FaxNumber as FaxNumber,  '
      'TransType as TransType, '
      'TransGlobal as TransGlobal, '
      'DateStarted as StartedSending,  '
      'DateCompleted as CompletedSending,  '
      'RetryCount as DialAttempts, '
      'RetryInMins as RetryWait, '
      'Priority as Priority, '
      'Cancelled as Cancelled, '
      'SentOk as SentOk'
      'FROM tblfaxspool')
    Left = 85
    Top = 5
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Origin = 'tblfaxspool.GlobalRef'
      Size = 255
    end
    object qryMainFaxSpoolID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'FaxSpoolID'
      Origin = 'tblfaxspool.FaxSpoolID'
      ReadOnly = True
    end
    object qryMainSpooledAt: TDateTimeField
      DisplayWidth = 13
      FieldName = 'SpooledAt'
      Origin = 'tblfaxspool.SpooledAt'
      DisplayFormat = 'd mmm yyyy h:nn am/pm'
    end
    object qryMainCurrentStatus: TWideStringField
      DisplayWidth = 11
      FieldName = 'CurrentStatus'
      Origin = 'tblfaxspool.CurrentStatus'
      Size = 255
    end
    object qryMainFaxBy: TWideStringField
      DisplayWidth = 10
      FieldName = 'FaxBy'
      Origin = 'tblfaxspool.FaxBy'
      Size = 255
    end
    object qryMainFaxTo: TWideStringField
      DisplayWidth = 10
      FieldName = 'FaxTo'
      Origin = 'tblfaxspool.FaxTo'
      Size = 255
    end
    object qryMainFaxNumber: TWideStringField
      DisplayWidth = 10
      FieldName = 'FaxNumber'
      Origin = 'tblfaxspool.FaxNumber'
      Size = 255
    end
    object qryMainStartedSending: TDateTimeField
      DisplayWidth = 13
      FieldName = 'StartedSending'
      Origin = 'tblfaxspool.StartedSending'
      DisplayFormat = 'd mmm yyyy h:nn am/pm'
    end
    object qryMainCompletedSending: TDateTimeField
      DisplayWidth = 13
      FieldName = 'CompletedSending'
      Origin = 'tblfaxspool.CompletedSending'
      DisplayFormat = 'd mmm yyyy h:nn am/pm'
    end
    object qryMainDialAttempts: TIntegerField
      DisplayWidth = 10
      FieldName = 'DialAttempts'
      Origin = 'tblfaxspool.DialAttempts'
    end
    object qryMainPriority: TIntegerField
      DisplayWidth = 5
      FieldName = 'Priority'
      Origin = 'tblfaxspool.Priority'
    end
    object qryMainCancelled: TWideStringField
      DisplayWidth = 8
      FieldName = 'Cancelled'
      Origin = 'tblfaxspool.Cancelled'
      FixedChar = True
      Size = 1
    end
    object qryMainSentOk: TWideStringField
      DisplayWidth = 6
      FieldName = 'SentOk'
      Origin = 'tblfaxspool.SentOk'
      FixedChar = True
      Size = 1
    end
    object qryMainTransType: TWideStringField
      FieldName = 'TransType'
      Origin = 'tblfaxspool.TransType'
      Visible = False
      Size = 255
    end
    object qryMainTransGlobal: TWideStringField
      FieldName = 'TransGlobal'
      Origin = 'tblfaxspool.TransGlobal'
      Visible = False
      Size = 255
    end
    object qryMainRetryWait: TIntegerField
      FieldName = 'RetryWait'
      Origin = 'tblfaxspool.RetryWait'
      Visible = False
    end
  end
end
