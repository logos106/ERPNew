unit ClientcontactList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TclientcontactListGUI = class(TBaseListingGUI)
    qryMainContactID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainCustomerId: TLargeintField;
    qryMainCompanyName: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainContactIsCustomer: TWideStringField;
    qryMainContactIsSupplier: TWideStringField;
    qryMainContactIsOtherContact: TWideStringField;
    qryMainContactIsJob: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainBillcountry: TWideStringField;
    qryMaincontact: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainContactCountry: TWideStringField;
    qryMainContactMOB: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainhasContact: TWideStringField;
  private
  Protected
      procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
      procedure SetGridColumns; Override;
  public
    Procedure DoSelectOnlyWithcountry;
    Procedure DoSelectOnlyWithBillcountry;
    procedure DoSelectOnlyWithBillcountrynMobileno;
    procedure DoSelectOnlyWithcountrynMobileno;
    Procedure DoSelectOnlycontactcountry;
    Procedure DoSelectOnlycontactcountrynMobileno;
    procedure DoSelectOnlyWithMobileno;
    procedure DoSelectOnlycontactMobileno;
    Procedure DoSelectClientsWithNocontact;
    Procedure RefreshQuery ;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TclientcontactListGUI }

procedure TclientcontactListGUI.DoSelectOnlyWithBillcountry         ;begin  IterateProcNo := 1;  IterateselectedRecordsReverse(True);end;
procedure TclientcontactListGUI.DoSelectOnlyWithcountry             ;begin  IterateProcNo := 2;  IterateselectedRecordsReverse(True);end;
procedure TclientcontactListGUI.DoSelectOnlycontactcountry          ;begin  IterateProcNo := 3;  IterateselectedRecordsReverse(True);end;
procedure TclientcontactListGUI.DoSelectOnlycontactcountrynMobileno ;begin  IterateProcNo := 4;  IterateselectedRecordsReverse(True);end;
procedure TclientcontactListGUI.DoSelectOnlyWithBillcountrynMobileno;begin  IterateProcNo := 5;  IterateselectedRecordsReverse(True);end;
procedure TclientcontactListGUI.DoSelectOnlyWithcountrynMobileno    ;begin  IterateProcNo := 6;  IterateselectedRecordsReverse(True);end;
procedure TclientcontactListGUI.DoSelectOnlyWithMobileno            ;begin  IterateProcNo := 7;  IterateselectedRecordsReverse(True);end;
procedure TclientcontactListGUI.DoSelectOnlycontactMobileno         ;begin  IterateProcNo := 8;  IterateselectedRecordsReverse(True);end;
Procedure TclientcontactListGUI.DoSelectClientsWithNocontact        ;begin  IterateProcNo := 9;  IterateselectedRecordsReverse(True);end;

procedure TclientcontactListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
            if IterateProcNo = 1 then begin if (trim(qryMainBillcountry.AsString)   ='') then grdmain.UnselectRecord;
  end  else if IterateProcNo = 2 then begin if (trim(qryMaincountry.AsString)       ='') then grdmain.UnselectRecord;
  end  else if IterateProcNo = 3 then begin if (trim(qryMainContactCountry.AsString)='') or (qryMainContactID.asinteger=0)          then grdmain.UnselectRecord;
  end  else if IterateProcNo = 4 then begin if (trim(qryMainContactCountry.AsString)='') or (trim(qrymaincontactmob.asString)='')   or (qryMainContactID.asinteger=0) then grdmain.UnselectRecord;
  end  else if IterateProcNo = 5 then begin if (trim(qryMainBillcountry.AsString)   ='') or (trim(Qrymainmobile.asString)    = '')  then grdmain.UnselectRecord;
  end  else if IterateProcNo = 6 then begin if (trim(qryMaincountry.AsString)       ='') or (trim(Qrymainmobile.asString)    = '')  then grdmain.UnselectRecord;
  end  else if IterateProcNo = 7 then begin if (trim(Qrymainmobile.asString)        ='')                                            then grdmain.UnselectRecord;
  end  else if IterateProcNo = 8 then begin if (trim(qrymaincontactmob.asString)    ='') or (qryMainContactID.asinteger=0)          then grdmain.UnselectRecord;
  end  else if IterateProcNo = 9 then begin if (qryMainContactID.asInteger          <>0)                                            then grdmain.UnselectRecord;
  end;
end;

procedure TclientcontactListGUI.RefreshQuery;
begin
  inherited;
end;

procedure TclientcontactListGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainContactID.FieldName);
    RemoveFieldfromGrid(qryMainClientID.FieldName);
    RemoveFieldfromGrid(qryMainCustomerId.FieldName);
end;

initialization
  RegisterClass(TclientcontactListGUI);

end.

