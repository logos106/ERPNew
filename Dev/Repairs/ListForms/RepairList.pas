unit RepairList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/05/05  1.00.01 BJ   The list is filtered for all the repair records with
                        a completion date within the date range given
                        Also the records with blank completion date included
                        as the completion date is not compulsory any more.
                        (based on Preference).
                        Note : When the date is not given, it gets initialised
                        to 0 which is 30/12/1899. In order to display the
                        records, 30/12/1899 is replaced to null.
 07/09/05  1.00.02 IJB  Modified to use new filtering on base listing.
 25/10/05  1.00.03 DSP  Added 'Job Employee Name' field to the grid using a
                        lookup field. This displays the name of the employee
                        to whom the job is allocated.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,
  wwdblook, wwcheckbox, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog,  Shader, kbmMemTable, AdvOfficeStatusBar, BaseRepairsList,
  DAScript, MyScript, CustomInputBox(*, RepairsPrefs *);


type
  TRepairsList = class(TBaseRepairsListGUI)
    btnExpressDetail: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);

  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

procedure TRepairsList.btnExpressDetailClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm('TRepairListExpressGUI');
  Self.Close;
end;

procedure TRepairsList.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

initialization
  RegisterClassOnce(TRepairsList);
end.
