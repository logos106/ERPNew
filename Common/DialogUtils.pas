unit DialogUtils;

interface

uses
  Vista_MessageDlg;

  procedure DialogLicenceOptionNotEnabled;

implementation

uses
  Dialogs;

procedure DialogLicenceOptionNotEnabled;
begin
  Vista_MessageDlg.MessageDlgXP_Vista('This Option is not enabled in your TrueERP Licence, please contact ERP Support.', mtInformation, [mbOk],0);
end;

end.
