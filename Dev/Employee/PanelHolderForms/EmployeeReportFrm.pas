unit EmployeeReportFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, frmBase;

type
  TfrmEmployeeReport = class(TfrmBaseGUI)
  private
    { Private declarations }
  public
  end;


implementation

uses
  CommonLib;

{$R *.dfm}


initialization
  RegisterClassOnce(TfrmEmployeeReport);
end.

