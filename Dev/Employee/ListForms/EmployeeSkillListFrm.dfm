inherited EmployeeSkillListGUI: TEmployeeSkillListGUI
  Left = 182
  Top = 208
  Caption = 'Employee Skill List'
  ExplicitLeft = 182
  ExplicitTop = 208
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 804001
  inherited FooterPanel: TDnMPanel
    HelpContext = 804004
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 804005
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 804006
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Employee Skill List'
          HelpContext = 804002
        end
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
    HelpContext = 804007
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Renewed;CheckBox;T;F')
      Selected.Strings = (
        'EmployeeName'#9'15'#9'Employee'
        'SkillName'#9'15'#9'Skill'
        'SkillLevel'#9'10'#9'Skill~Level'
        'SkillExpDate'#9'10'#9'Skill~Exp Date'
        'SecurityLevel'#9'10'#9'Security~Level'
        'SecurityExpDate'#9'10'#9'Security~Exp Date'
        'ProviderName'#9'10'#9'Provider~Name'
        'TestMethod'#9'10'#9'Test~Method'
        'Certificate'#9'10'#9'Certificate'
        'ScheduledDate'#9'10'#9'Scheduled~Date'
        'CompletedDate'#9'10'#9'Completed~Date'
        'RenewalDate'#9'10'#9'Renewal~Date'
        'RenewalOptions'#9'10'#9'Renewal~Options'
        'Renewed'#9'1'#9'Renewed?'
        'Comments'#9'10'#9'Comments')
      TitleLines = 2
      inherited btnGrid: TwwIButton
        Height = 33
        ExplicitHeight = 33
        HelpContext = 804003
      end
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '
      '2 as category, '
      'ES.EmployeeID  as EmployeeID, '
      'E.EmployeeName  as EmployeeName, '
      'SkillName  as SkillName, '
      
        'if(ifnull(SkillLevel,0)=1,"Excellent" , if(ifnull(SkillLevel,0)=' +
        '2,"Above average" , if(ifnull(SkillLevel,0)=3,"Mediocre" , if(if' +
        'null(SkillLevel,0)=4,"Lacking" , if(ifnull(SkillLevel,0)=5,"Unfa' +
        'miliar" , "Unknown")))))   as SkillLevel, '
      'SkillExpDate  as SkillExpDate, '
      'SecurityLevel  as SecurityLevel, '
      'SecurityExpDate  as SecurityExpDate, '
      'ProviderName  as ProviderName, '
      
        'if(ifnull(TestMethod,'#39#39')='#39'N'#39' , "None",if(ifnull(TestMethod,'#39#39')='#39 +
        'W'#39' , "Written",if(ifnull(TestMethod,'#39#39')='#39'P'#39' , "Practical","Unkno' +
        'wn")))  as TestMethod, '
      'Certificate  as Certificate, '
      'ScheduledDate  as ScheduledDate, '
      'CompletedDate  as CompletedDate, '
      'RenewalDate  as RenewalDate, '
      
        'if(ifnull(RenewalOptions,0)=0 , NULL , concat(RenewalOptions , "' +
        ' Years"))  as RenewalOptions, '
      'Renewed  as Renewed, '
      'Comments as Comments'
      
        'from tblemployeeskills ES inner join tblemployees E using (Emplo' +
        'yeeID)'
      'union all '
      'Select '
      '1 as category, '
      'E.`EmployeeID` as `EmployeeID`, '
      'E.EmployeeName as EmployeeName, '
      'NULL as `SkillName`, '
      'NULL as `SkillLevel`, '
      'NULL as `SkillExpDate`, '
      'NULL as `SecurityLevel`, '
      'NULL as `SecurityExpDate`, '
      'NULL as `ProviderName`, '
      'NULL as `TestMethod`, '
      'NULL as `Certificate`, '
      'NULL as `ScheduledDate`, '
      'NULL as `CompletedDate`, '
      'NULL as `RenewalDate`, '
      'NULL as `RenewalOptions`, '
      'NULL as `Renewed`, '
      'NULL as `Comments`'
      
        ' from tblemployeeskills ES inner join tblemployees E using (Empl' +
        'oyeeID)'
      'group by EmployeeID'
      'order by EmployeeName , category')
    object qryMainEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'EmployeeName'
      Size = 255
    end
    object qryMainSkillName: TWideStringField
      DisplayLabel = 'Skill'
      DisplayWidth = 15
      FieldName = 'SkillName'
      Origin = 'SkillName'
      Size = 255
    end
    object qryMainSkillLevel: TWideStringField
      DisplayLabel = 'Skill~Level'
      DisplayWidth = 10
      FieldName = 'SkillLevel'
      Origin = 'SkillLevel'
      Size = 13
    end
    object qryMainSkillExpDate: TDateField
      DisplayLabel = 'Skill~Exp Date'
      DisplayWidth = 10
      FieldName = 'SkillExpDate'
      Origin = 'SkillExpDate'
    end
    object qryMainSecurityLevel: TIntegerField
      DisplayLabel = 'Security~Level'
      DisplayWidth = 10
      FieldName = 'SecurityLevel'
      Origin = 'SecurityLevel'
    end
    object qryMainSecurityExpDate: TDateField
      DisplayLabel = 'Security~Exp Date'
      DisplayWidth = 10
      FieldName = 'SecurityExpDate'
      Origin = 'SecurityExpDate'
    end
    object qryMainProviderName: TWideStringField
      DisplayLabel = 'Provider~Name'
      DisplayWidth = 10
      FieldName = 'ProviderName'
      Origin = 'ProviderName'
      Size = 100
    end
    object qryMainTestMethod: TWideStringField
      DisplayLabel = 'Test~Method'
      DisplayWidth = 10
      FieldName = 'TestMethod'
      Origin = 'TestMethod'
      FixedChar = True
      Size = 1
    end
    object qryMainCertificate: TWideStringField
      DisplayWidth = 10
      FieldName = 'Certificate'
      Origin = 'Certificate'
      Size = 255
    end
    object qryMainScheduledDate: TDateField
      DisplayLabel = 'Scheduled~Date'
      DisplayWidth = 10
      FieldName = 'ScheduledDate'
      Origin = 'ScheduledDate'
    end
    object qryMainCompletedDate: TDateField
      DisplayLabel = 'Completed~Date'
      DisplayWidth = 10
      FieldName = 'CompletedDate'
      Origin = 'CompletedDate'
    end
    object qryMainRenewalDate: TDateField
      DisplayLabel = 'Renewal~Date'
      DisplayWidth = 10
      FieldName = 'RenewalDate'
      Origin = 'RenewalDate'
    end
    object qryMainRenewalOptions: TWideStringField
      DisplayLabel = 'Renewal~Options'
      DisplayWidth = 10
      FieldName = 'RenewalOptions'
      Origin = 'RenewalOptions'
      Size = 17
    end
    object qryMainRenewed: TWideStringField
      DisplayLabel = 'Renewed?'
      DisplayWidth = 1
      FieldName = 'Renewed'
      Origin = 'Renewed'
      FixedChar = True
      Size = 1
    end
    object qryMainComments: TWideStringField
      DisplayWidth = 10
      FieldName = 'Comments'
      Origin = 'Comments'
      Size = 255
    end
    object qryMaincategory: TLargeintField
      DisplayWidth = 15
      FieldName = 'category'
      Origin = 'category'
      Visible = False
    end
    object qryMainEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'EmployeeID'
      Visible = False
    end
  end
end
