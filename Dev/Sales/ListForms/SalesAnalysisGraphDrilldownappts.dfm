inherited SalesAnalysisGraphDrilldownapptsGUI: TSalesAnalysisGraphDrilldownapptsGUI
  Caption = 'Appointment Summary'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 991001
  inherited HeaderPanel: TPanel
    HelpContext = 991003
    inherited pnlHeader: TPanel
      HelpContext = 991004
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Appointment Summary'
          HelpContext = 991002
        end
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 991005
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'LeadEmployeeName'#9'20'#9'Lead Employee'
        'company'#9'50'#9'Name'
        'FirstApptdate'#9'12'#9'First Appt Date'
        'totalAppts'#9'1'#9'Total Appointemnts')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '
      'C.company,'
      'A.AppointID , '
      'space(100) as LeadEmployeeName,'
      'min(A.AppDate) FirstApptdate , '
      'count(A.AppointID) totalAppts'
      'from tblappointments A '
      'inner join tblclients C on A.CusID = C.ClientID'
      'group by c.ClientID')
    Active = True
    object qryMainLeadEmployeeName: TWideStringField
      DisplayLabel = 'Lead Employee'
      DisplayWidth = 20
      FieldName = 'LeadEmployeeName'
      Origin = 'LeadEmployeeName'
      Size = 100
    end
    object qryMaincompany: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 50
      FieldName = 'company'
      Origin = 'C.company'
      Size = 160
    end
    object qryMainFirstApptdate: TDateField
      DisplayLabel = 'First Appt Date'
      DisplayWidth = 12
      FieldName = 'FirstApptdate'
      Origin = 'FirstApptdate'
    end
    object qryMaintotalAppts: TLargeintField
      DisplayLabel = 'Total Appointemnts'
      DisplayWidth = 1
      FieldName = 'totalAppts'
      Origin = 'totalAppts'
    end
    object qryMainAppointID: TIntegerField
      FieldName = 'AppointID'
      Origin = 'A.AppointID'
      Visible = False
    end
  end
end
