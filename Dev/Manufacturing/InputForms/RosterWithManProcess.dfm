inherited fmRosterWithManProcess: TfmRosterWithManProcess
  Left = 505
  Top = 169
  HelpContext = 909001
  Caption = 'fmRosterWithManProcess'
  ClientWidth = 998
  ExplicitLeft = 505
  ExplicitTop = 169
  ExplicitWidth = 1014
  DesignSize = (
    998
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Width = 998
    HelpContext = 909002
    ExplicitTop = 399
    ExplicitWidth = 998
  end
  inherited DNMPanel1: TDNMPanel
    Left = 852
    Width = 146
    HelpContext = 909003
    ExplicitLeft = 852
    ExplicitWidth = 146
    inherited btnPrint: TDNMSpeedButton
      Left = 29
      ExplicitLeft = 29
    end
    inherited grdClass: TAdvStringGrid
      Width = 134
      HelpContext = 909004
      ExplicitWidth = 134
    end
    inherited cboClass: TwwDBLookupCombo
      Width = 133
      HelpContext = 909005
      ExplicitWidth = 133
    end
    inherited btnSave: TDNMSpeedButton
      Left = 29
      ExplicitLeft = 29
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 29
      ExplicitLeft = 29
    end
    inherited btnReport: TDNMSpeedButton
      Left = 29
      ExplicitLeft = 29
    end
  end
  inherited DNMPanel2: TDNMPanel
    Width = 998
    HelpContext = 909006
    ExplicitWidth = 998
  end
  inherited pnlMain: TDNMPanel
    Width = 852
    HelpContext = 909007
    ExplicitWidth = 852
    object Horizontal1: TSplitter [0]
      Left = 1
      Top = 330
      Width = 850
      Height = 2
      Cursor = crVSplit
      HelpContext = 909008
      Align = alBottom
      OnMoved = Horizontal1Moved
      ExplicitTop = 348
      ExplicitWidth = 881
    end
    object lblTmrMsg: TLabel [1]
      Left = 1
      Top = 498
      Width = 850
      Height = 16
      HelpContext = 909009
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Timer Msg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitLeft = -4
      ExplicitTop = 508
      ExplicitWidth = 881
    end
    inherited DNMPanel3: TDNMPanel
      Width = 850
      Height = 329
      HelpContext = 909010
      ExplicitWidth = 850
      ExplicitHeight = 329
      inherited PageControl1: TPageControl
        Width = 848
        Height = 327
        HelpContext = 909011
        ExplicitWidth = 848
        ExplicitHeight = 327
        inherited tabWeekly: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 36
          ExplicitWidth = 840
          ExplicitHeight = 287
          inherited plannerWeek: TDBPlanner
            Width = 840
            Height = 287
            HelpContext = 909012
            GridLeftCol = 25
            OnItemDblClick = plannerWeekItemDblClick
            ExplicitWidth = 840
            ExplicitHeight = 287
          end
        end
        inherited tabDaily: TTabSheet
          ExplicitWidth = 840
          ExplicitHeight = 287
          inherited plannerDay: TDBPlanner
            Width = 840
            Height = 287
            HelpContext = 909013
            GridLeftCol = 18
            ExplicitWidth = 840
            ExplicitHeight = 287
          end
        end
      end
    end
    object pnlBottom: TDNMPanel
      Left = 1
      Top = 332
      Width = 850
      Height = 166
      HelpContext = 909014
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object lblHideNonMan: TLabel
        Left = 198
        Top = 1
        Width = 209
        Height = 15
        HelpContext = 909015
        Caption = 'Hide Non Manufacture Roster Entries'
        Transparent = True
      end
      object Label2: TLabel
        Left = 3
        Top = 1
        Width = 87
        Height = 15
        HelpContext = 909016
        Caption = 'Process Steps '
        Color = 12054011
        ParentColor = False
        Transparent = True
      end
      object grdProcesses: TwwDBGrid
        Left = 1
        Top = 19
        Width = 848
        Height = 146
        HelpContext = 909017
        Selected.Strings = (
          'customerName'#9'13'#9'Customer'#9#9
          'sAleId'#9'4'#9'Sale#'#9#9
          'Caption'#9'20'#9'Caption'#9#9
          'Resource'#9'10'#9'Resource'#9#9
          'Processtep'#9'10'#9'Proces Step'#9'F'
          'ScheduledDate'#9'10'#9'Date'#9'Schedule'#9'Schedule'
          'TimeStart'#9'10'#9'From'#9'Schedule'#9'Schedule'
          'sDuration'#9'11'#9'Duration'#9'Schedule'#9'Schedule'
          'TimeEnd'#9'10'#9'To'#9'Schedule'#9'Schedule'
          'srostered'#9'10'#9'Rostered'#9'F'
          'Status'#9'10'#9'Status'#9#9)
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alBottom
        DataSource = dsProcesses
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        PopupMenu = popProcesses
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = False
        UseTFields = False
        OnCalcCellColors = grdProcessesCalcCellColors
        FooterCellColor = clWhite
      end
      object chkHideNonMan: TCheckBox
        Left = 175
        Top = 0
        Width = 17
        Height = 17
        HelpContext = 909018
        TabOrder = 1
        OnClick = chkHideNonManClick
      end
    end
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200C000CC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited WeekSource: TDBWeekSource
    Left = 513
    Top = 255
  end
  inherited dsWeekRoster: TDataSource
    Left = 513
    Top = 224
  end
  inherited dsDayRoster: TDataSource
    Left = 481
    Top = 224
  end
  inherited DaySource: TDBDaySource
    Left = 481
    Top = 255
  end
  inherited PopupMenuPlannerItem: TAdvPopupMenu
    OnPopup = PopupMenuPlannerItemPopup
    Left = 368
    Top = 255
  end
  inherited PopupMenu: TAdvPopupMenu
    Left = 402
    Top = 255
  end
  inherited qryWeekRoster: TERPQuery
    SQL.Strings = (
      
        'Select RosterID, tblroster.GlobalRef, PlannerID, tblroster.Type,' +
        ' tblroster.EmployeeID,tblroster.Date,'
      'tblroster.ClassID, tblroster.Notes,tblroster.Hours,'
      
        'StartTime, EndTime, tblroster.EditedFlag, ClockedOff,TypeCatagor' +
        'y,IsClocked, ProcesstimeID'
      'FROM tblroster'
      'INNER JOIN tblEmployees using (EmployeeID)'
      
        'WHERE IsOnTheRoster = '#39'T'#39' and  Active='#39'T'#39' and  (Type <> '#39'Clocked' +
        #39' or (Type = '#39'Clocked'#39' and ClockedOff = '#39'T'#39'))'
      'and (ifnull(ProcesstimeID,0) <> 0 or :hidenonManroster=False)')
    BeforeOpen = qryWeekRosterBeforeOpen
    Left = 178
    Top = 255
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'hidenonManroster'
      end>
    object qryWeekRosterProcesstimeID: TIntegerField
      FieldName = 'ProcesstimeID'
    end
  end
  inherited qryResources: TERPQuery
    Left = 294
    Top = 255
  end
  inherited qryChkAppoints: TERPQuery
    Left = 333
    Top = 255
  end
  object qryProcesses: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'PR.ProcResourceId,'
      'S.ClassId,'
      'SL.ProducTName , '
      'S.customerName,'
      'S.sAleId, '
      'SL.SaleLineID , '
      's.SAleDate,'
      'PP.ProcessStepID,'
      'PTT.Duration DurationinSeconds,'
      'PT.Caption as PtCaption,'
      
        'Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as Ca' +
        'ption, '
      'ProcessPartStatusToUserStr(PP.Status) Status , '
      'ifnull(PR.Description , PR.Resourcename) Resource,'
      'PS.Description as Processtep , '
      'PTT.TimeStart  as TimeStart, '
      'AddTime(PTT.TimeStart , SEC_TO_TIME(PTT.Duration)) TimeEnd , '
      'SEC_TO_TIME(PTT.Duration) Duration ,'
      'FormatSecondsTotime(PTT.Duration) sDuration ,'
      'PTT.ProcessTimeId,'
      'SEC_TO_TIME(Sum(R.Hours)*60*60) rostered,'
      'FormatSecondsTotime(Sum(R.Hours)*60*60) srostered,'
      'Sum(R.Hours)*60*60 rosteredinseconds'
      '/*'
      'S.ClassId,'
      'SL.ProducTName , '
      'S.customerName,'
      'S.sAleId, SL.SaleLineID , PT.ProcTreeId, PP.ID,'
      ''
      'SEC_TO_TIME(PP.Duration) scheduledduration,'
      'PP.Duration,'
      'Date_add(PTT.TimeStart , INTERVAL PTT.Duration second),'
      'SEC_TO_TIME(PTT.Duration) Duration , '
      'PTT.Duration DurationinSeconds,*/'
      'FROM tblSales                           S '
      'inner join tblsaleslines '#9#9'SL  on s.SaleId          = SL.SAleID'
      
        'INNER JOIN tblProcTree '#9#9#9'PT  on PT.MasterId       = Sl.SaleLine' +
        'ID and PT.Mastertype <> "mtProduct"'
      
        'INNER JOIN tblprocesspart   '#9#9'PP  on PT.ProcTreeId     = PP.Proc' +
        'TreeId'
      'Inner join tblprocesstime '#9#9'PTT on PTT.ProcessPartId = PP.ID'
      
        'INNER JOIN tblProcessStep '#9#9'PS  on PS.Id             = PP.Proces' +
        'sStepID'
      
        'INNER JOIN tblProcResourceProcess  '#9'PRP on PRP.ProcessStepId = P' +
        'S.ID'
      
        'INNER JOIN tblProcResource '#9#9'PR  on PR.ProcResourceId = PRP.Proc' +
        'ResourceId'
      
        'Left join tblroster '#9#9#9'R   on R.ProcesstimeID   = PTT.ProcessTim' +
        'eId'
      'Where ifnull(PTT.Duration,0)>0'
      
        'and ProcessPartStatusToNo(PP.Status) >1 and ProcessPartStatusToN' +
        'o(PP.Status) <6'
      'Group by PTT.ProcessTimeId'
      'ORDER BY  TimeStart DESC')
    BeforeOpen = qryProcessesBeforeOpen
    AfterOpen = qryProcessesAfterOpen
    OnCalcFields = qryProcessesCalcFields
    Left = 216
    Top = 255
    object qryProcessescustomerName: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 13
      FieldName = 'customerName'
      Origin = 'S.customerName'
      Size = 255
    end
    object qryProcessessAleId: TIntegerField
      DisplayLabel = 'Sale#'
      DisplayWidth = 1
      FieldName = 'sAleId'
      Origin = 'S.sAleId'
    end
    object qryProcessesCaption: TWideStringField
      DisplayWidth = 20
      FieldName = 'Caption'
      Origin = 'Caption'
    end
    object qryProcessesResource: TWideStringField
      DisplayWidth = 10
      FieldName = 'Resource'
      Origin = 'Resource'
      Size = 255
    end
    object qryProcessesProcesstep: TWideStringField
      DisplayWidth = 10
      FieldName = 'Processtep'
      Origin = 'PS.Processtep'
      Size = 255
    end
    object qryProcessesScheduledDate: TDateField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ScheduledDate'
      Calculated = True
    end
    object qryProcessesTimeStart: TDateTimeField
      DisplayLabel = 'From'
      DisplayWidth = 10
      FieldName = 'TimeStart'
      Origin = 'PTT.TimeStart'
      DisplayFormat = 'hh:nn:ss am/pm'
    end
    object qryProcessesDuration: TTimeField
      DisplayWidth = 1
      FieldName = 'Duration'
      Origin = 'Duration'
      DisplayFormat = 'hh:nn:ss'
    end
    object qryProcessesTimeEnd: TDateTimeField
      DisplayLabel = 'To'
      DisplayWidth = 10
      FieldName = 'TimeEnd'
      Origin = 'TimeEnd'
      DisplayFormat = 'hh:nn:ss am/pm'
    end
    object qryProcessesrostered: TTimeField
      DisplayLabel = 'Rostered'
      DisplayWidth = 10
      FieldName = 'rostered'
      Origin = 'rostered'
      DisplayFormat = 'hh:nn:ss'
    end
    object qryProcessesStatus: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Status'
      Origin = 'Status'
      BlobType = ftWideMemo
    end
    object qryProcessesrosteredinseconds: TFloatField
      DisplayWidth = 10
      FieldName = 'rosteredinseconds'
      Origin = 'rosteredinseconds'
    end
    object qryProcessesSAleDate: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 10
      FieldName = 'SAleDate'
      Origin = 'S.SAleDate'
      Visible = False
    end
    object qryProcessesClassId: TIntegerField
      FieldName = 'ClassId'
      Origin = 'S.ClassId'
      Visible = False
    end
    object qryProcessesProducTName: TWideStringField
      FieldName = 'ProducTName'
      Origin = 'SL.ProducTName'
      Visible = False
      Size = 60
    end
    object qryProcessesSaleLineID: TIntegerField
      FieldName = 'SaleLineID'
      Origin = 'SL.SaleLineID'
      Visible = False
    end
    object qryProcessesProcessStepID: TIntegerField
      FieldName = 'ProcessStepID'
      Origin = 'PP.ProcessStepID'
      Visible = False
    end
    object qryProcessesDurationinSeconds: TFloatField
      FieldName = 'DurationinSeconds'
      Origin = 'PTT.DurationinSeconds'
      Visible = False
    end
    object qryProcessesPtCaption: TWideStringField
      FieldName = 'PtCaption'
      Origin = 'PT.PtCaption'
      Visible = False
      Size = 255
    end
    object qryProcessesProcessTimeId: TIntegerField
      FieldName = 'ProcessTimeId'
      Origin = 'PTT.ProcessTimeId'
      Visible = False
    end
    object qryProcessessDuration: TWideMemoField
      DisplayLabel = 'Duration'
      FieldName = 'sDuration'
      Origin = 'sDuration'
      BlobType = ftWideMemo
    end
    object qryProcessessrostered: TWideMemoField
      DisplayLabel = 'Rostered'
      FieldName = 'srostered'
      BlobType = ftWideMemo
    end
    object qryProcessesProcResourceId: TIntegerField
      FieldName = 'ProcResourceId'
    end
  end
  object dsProcesses: TDataSource
    DataSet = qryProcesses
    Left = 216
    Top = 224
  end
  object qryEmployeeProcessStep: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'count(*) as ctr'
      'from tblemployeeprocesssteps '
      'where EmployeeId =:EmployeeID '
      'and  processstepId =:processstepId')
    Left = 254
    Top = 255
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeID'
      end
      item
        DataType = ftUnknown
        Name = 'processstepId'
      end>
    object qryEmployeeProcessStepctr: TLargeintField
      FieldName = 'ctr'
    end
  end
  object popProcesses: TAdvPopupMenu
    OnPopup = popProcessesPopup
    Version = '2.5.3.4'
    Left = 440
    Top = 255
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'Distinct E.EmployeeID , E.EmployeeName'
      'From'
      
        'tblemployees E left join tblemployeeprocesssteps EP on E.Employe' +
        'eID = EP.EmployeeID'
      
        'where ((:ProcessStepID=0) or (EP.ProcessStepID = :ProcessStepID)' +
        ')'
      'and E.Active = '#39'T'#39
      'order by EmployeeName')
    Left = 558
    Top = 255
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProcessStepID'
      end
      item
        DataType = ftUnknown
        Name = 'ProcessStepID'
      end>
    object qryEmployeesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryEmployeesEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
  end
  object QryProcessTime: TERPQuery
    SQL.Strings = (
      'Select * from tblprocesstime'
      'Where processtimeId =:ProcesstimeID'
      'order by timestart')
    Left = 143
    Top = 252
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProcesstimeID'
      end>
  end
  object QryProcesstimeroster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select '
      'min(StartTime) startTime, '
      'max(Endtime) endtime, '
      'sum(hours) hours '
      
        'from tblroster where ProcesstimeID  = :ProcesstimeID and TypeCat' +
        'agory = '#39'ProcessStep'#39)
    Left = 111
    Top = 252
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProcesstimeID'
      end>
    object QryProcesstimerosterstartTime: TDateTimeField
      FieldName = 'startTime'
    end
    object QryProcesstimerosterendtime: TDateTimeField
      FieldName = 'endtime'
    end
    object QryProcesstimerosterhours: TFloatField
      FieldName = 'hours'
    end
  end
end
