inherited RollaBlindViewDatabaseListGUI: TRollaBlindViewDatabaseListGUI
  Left = 205
  Top = 195
  Caption = 'View Database List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = clSilver
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
    end
  end
  inherited HeaderPanel: TPanel
    Color = clSilver
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'LeadNumber'#9'7'#9'Lead Number'
        'SheetID'#9'10'#9'Sheet Number'
        'FirstName'#9'20'#9'First Name'
        'Surname'#9'20'#9'Surname'
        'ShutterNumber'#9'3'#9'Shutter Number'
        'Operator'#9'20'#9'Created By')
      TitleColor = clSilver
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT * '
      'FROM tblrollasheet1;')
  end
end
