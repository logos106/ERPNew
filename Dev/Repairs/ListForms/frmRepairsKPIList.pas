unit frmRepairsKPIList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseRepairsList, kbmMemTable,  Menus, AdvMenus,
  ProgressDialog, DB, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TfmRepairsKPIList = class(TBaseRepairsListGUI)
    qryMainCreationToArrivalDays: TIntegerField;
    qryMainCollectionToDeliverDays: TFloatField;
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRepairsKPIList: TfmRepairsKPIList;

implementation

{$R *.dfm}

procedure TfmRepairsKPIList.qryMainCalcFields(DataSet: TDataSet);
var
  days: integer;
begin
  inherited;
  if (qryMainCUSTDATE1.AsDateTime > 0) and (qryMainCreationDate.AsDateTime > 0) and
    (qryMainCUSTDATE1.AsDateTime > qryMainCreationDate.AsDateTime) then begin
    days := Trunc(qryMainCUSTDATE1.AsDateTime - qryMainCreationDate.AsDateTime);
    self.qryMainCreationToArrivalDays.AsInteger := days;
  end;
//  if (qryMainCUSTDATE3.AsDateTime > 0) and (qryMainCUSTDATE2.AsDateTime > 0) and
//    (qryMainCUSTDATE3.AsDateTime > qryMainCUSTDATE2.AsDateTime) then begin
//    days := Trunc(qryMainCUSTDATE3.AsDateTime - qryMainCUSTDATE2.AsDateTime);
//    self.qryMainCollectionToDeliverDays.AsInteger := days;
//  end;
end;

initialization
  RegisterClass(TfmRepairsKPIList);

end.
