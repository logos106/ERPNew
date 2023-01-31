unit BOMJobsForWorkOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMJobs, DAScript, MyScript, ERPdbComponents, DB, SelectionDialog,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel ,
  DNMAction (*, frmWorkOrder*);

type
  TBOMJobsForWorkOrdersGUI = class(TBOMJobsGUI)
    QryPS: TERPQuery;
    procedure mnuFilterPopup(Sender: TObject);
  private
    function ISProcessSelected:Boolean;
    function ISNodeSelected:Boolean;
    //function ISSaleSelected:Boolean;

    function ProcessStepID:Integer;
    Function ProctreeID:Integer;
    Function ProcessPartID:Integer;
    function Levelselected:Integer;

    Procedure DeleteMenuItemsOfSelected;
    procedure OnSelectEmployeeForProcessstep(Sender: TObject);
    Procedure Allocate(PPID, PSID, PTID, employeeId: Integer; aDate:TDate; aDuration:Integer);
    //Function BOMWorkScheduler :TfmBOMWorkScheduler;
    function ProcessStepName: String;
  Protected
    procedure SetupFormInPanel; Override;
  public

  end;


implementation

uses CommonLib, CommonDbLib, frmDateSelectDialog, tcDataUtils;

const
  Nodefields        :Array [1..1] of String = ('Caption');
  ProcessStepfields :Array [1..4] of String = ('process' , 'Duration' , 'setupduration' , 'breakdownduration');
  SalesFields       :Array [1..4] of String = ('saleID' , 'DueDate' , 'productName' , 'Shipped');
{$R *.dfm}

(*function TBOMJobsForWorkOrdersGUI.BOMWorkScheduler: TfmBOMWorkScheduler;
begin
  Result := nil;
  if Assigned(Owner) then
    if Owner is TfmBOMWorkScheduler then
      Result :=TfmBOMWorkScheduler(Owner);
end;*)

procedure TBOMJobsForWorkOrdersGUI.DeleteMenuItemsOfSelected;
var
  ctr:Integer;
begin
  for ctr:= mnuFilter.Items.Count-1 downto 0 do
    if mnuFilter.Items[ctr].Tag <>0   then
      mnuFilter.items.Delete(ctr);
end;

function TBOMJobsForWorkOrdersGUI.ISNodeSelected: Boolean;
var
  ctr:Integer;
begin
  REsult := false;
  for ctr:= low(Nodefields) to high(Nodefields) do
    if StartsWith(ActiveFieldNAme ,Nodefields[ctr]) then begin
      REsult := true;
      break;
    end;
end;
function TBOMJobsForWorkOrdersGUI.ISProcessSelected: Boolean;
var
  ctr:Integer;
begin
  REsult := false;
  for ctr:= low(ProcessStepfields) to high(ProcessStepfields) do
    if StartsWith(ActiveFieldNAme ,ProcessStepfields[ctr]) then begin
      REsult := true;
      break;
    end;
end;

(*function TBOMJobsForWorkOrdersGUI.ISSaleSelected: Boolean;
var
  ctr:Integer;
begin
  REsult := false;
  for ctr:= low(SalesFields) to high(SalesFields) do
    if StartsWith(ActiveFieldNAme ,SalesFields[ctr]) then begin
      REsult := true;
      break;
    end;
end;*)

function TBOMJobsForWorkOrdersGUI.Levelselected: Integer;
var
  ctr:Integer;
begin
  REsult := 0;
  for ctr:= low(ProcessStepfields) to high(ProcessStepfields) do
    if StartsWith(ActiveFieldNAme ,ProcessStepfields[ctr]) then begin
      try
        REsult := strToInt(REplaceStr(ActiveFieldNAme ,ProcessStepfields[ctr] , ''));
        exit;
      Except
        // kill the exception
      end;
    end;

  for ctr:= low(Nodefields) to high(Nodefields) do
    if StartsWith(ActiveFieldNAme ,Nodefields[ctr]) then begin
      try
        REsult := strToInt(ReplaceStr(ActiveFieldNAme ,Nodefields[ctr] , ''));
        exit;
      Except
        // kill the exception
      end;
    end;
end;
Procedure TBOMJobsForWorkOrdersGUI.Allocate(PPID, PSID, PTID, employeeId: Integer; aDate:TDate; aDuration:Integer);
begin
  try
    //BOMWorkScheduler.Allocate(PPID, PSID, PTID, employeeId , aDate, aDuration);
  Except
    // kill the exception;
  end;
end;
procedure TBOMJobsForWorkOrdersGUI.OnSelectEmployeeForProcessstep(Sender: TObject);
var
  dt:TDatetime;
  PPID, PSID, PTID, employeeId :Integer;

begin
  if TMenuItem(Sender).Tag =0 then exit;

  dt:= date;
  employeeId := TMenuItem(Sender).Tag;
  if employeeId <=0 then exit;
  if TfmDateSelectDialog.SelectDateAtCursor('Choose Date for ' +quotedstr(getEmployeename(employeeId)), dt, self) then begin
    PSID:= ProcessStepID;
    PTID := ProctreeID;
    PPID := ProcessPartID;
    Allocate(PPID, PSID, PTID, employeeId , dt ,0);
  end;
end;
procedure TBOMJobsForWorkOrdersGUI.mnuFilterPopup(Sender: TObject);
var
  i:Integer;
  NewItem : TMenuItem;
begin
  inherited;
        i:= 0;
  try
    DeleteMenuItemsOfSelected;
    i := ProcessStepID;
    if i <> 0 then begin
      Closedb(QryPS);
      QryPS.Parambyname('PSID').AsInteger := i;
      Opendb(QryPS);
      if QryPS.RecordCount >0 then begin
        QryPS.First;
        i:= 0;
        NewItem := TMenuItem.Create(mnuCharts);
        NewItem.Caption := 'Choose Employee For ' +Quotedstr(ProcessStepName);
        NewItem.Tag := 99;
        mnuFilter.Items.Insert(i , NewItem);
        i:= i+1;
        while QryPS.Eof = false do begin
          if QryPS.fieldbyname('employeeName').AsString <> '' then begin
            NewItem := TMenuItem.Create(mnuCharts);
            if QryPS.recno < QryPS.recordcount then NewItem.Caption := '  ├──  ' +QryPS.fieldbyname('employeeName').asString
            else NewItem.Caption := '  └──  ' +QryPS.fieldbyname('employeeName').asString;
            NewItem.OnClick := OnSelectEmployeeForProcessstep;
            NewItem.Tag :=QryPS.fieldbyname('employeeID').AsInteger;
            mnuFilter.Items.Insert(i , NewItem);
            i:= i+1;
          end;
          QryPS.next;
        end;
      end;
    end else begin
      i:= 0;
    end;
  finally
    if i>0 then begin
      NewItem := TMenuItem.Create(mnuCharts);
      NewItem.Tag := 99;
      NewItem.Caption := '-';
      MnuFilter.Items.Insert(i , NewItem);
    end;
  end;
end;

function TBOMJobsForWorkOrdersGUI.ProcessPartID: Integer;
var
  i:Integer;
begin
    REsult := 0;
    if not(ISNodeSelected) then exit;
   i:= Levelselected;
   if i =0 then exit;
   REsult := Qrymain.FieldByName('PPID'+ trim(inttostr(i))).AsInteger;
end;
function TBOMJobsForWorkOrdersGUI.ProcessStepName: String;
var
  i:Integer;
begin
   REsult := '';
   if not(ISProcessSelected) then exit;
   i:= Levelselected;
   if i =0 then exit;
   REsult := Qrymain.FieldByName('Process'+ trim(inttostr(i))).AsSTring;
end;
function TBOMJobsForWorkOrdersGUI.ProcessStepID: Integer;
var
  i:Integer;
begin
   REsult := 0;
   if not(ISProcessSelected) then exit;
   i:= Levelselected;
   if i =0 then exit;
   REsult := Qrymain.FieldByName('PSID'+ trim(inttostr(i))).AsInteger;
end;

function TBOMJobsForWorkOrdersGUI.ProctreeID: Integer;
var
  i:Integer;
begin
    REsult := 0;
    if not(ISNodeSelected) then exit;
   i:= Levelselected;
   if i =0 then exit;
   REsult := Qrymain.FieldByName('PTID'+ trim(inttostr(i))).AsInteger;

end;

procedure TBOMJobsForWorkOrdersGUI.SetupFormInPanel;
begin
  inherited;
end;

initialization
 RegisterClassOnce(TBOMJobsForWorkOrdersGUI);

end.
