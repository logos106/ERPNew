unit frmPaySummaryUSA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPaySummaryFrm, DB, DAScript, MyScript, ERPdbComponents,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, wwcheckbox, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwdblook, wwclearbuttongroup, wwradiogroup,
  DNMSpeedButton, Shader, GIFImg, DNMPanel;

type
  TfmPaySummaryUSA = class(TfrmPaySummary)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TfmPaySummaryUSA);

end.
