unit EmployeeClientList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, DNMAction, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TEmployeeClientListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainname: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainISEmployee: TWideStringField;
    qryMainISCustomer: TWideStringField;
    qryMainISSupplier: TWideStringField;
    qryMainISOthercontact: TWideStringField;
    qryMainclientID: TIntegerField;
    qryMainemployeeId: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
    fiSupplierID :Integer;
    Procedure doChoosenMakeSupplier(Sender: TwwDbGrid);
    procedure CopyCustomerToSupplier(Const CustomerID:Integer);
    procedure CopyOthercontactToSupplier(Const OCID:Integer);
    Procedure CopyEmployeeToSupplier(Const EmployeeID:Integer);
  Protected
    procedure SetGridColumns; Override;
  public
    class Function ChoosenMakeSupplier :Integer;
    Property SupplierID :Integer read fiSupplierID write fiSupplierID;
  end;

implementation

uses CommonLib, BusObjClient, BusObjEmployee;

{$R *.dfm}

{ TEmployeeClientListGUI }

class function TEmployeeClientListGUI.ChoosenMakeSupplier: Integer;
var
  Form :TComponent;
begin
  REsult:= 0;
  form := GetComponentByClassName('TEmployeeClientListGUI' , true , nil);
  if not(Assigned(form)) then exit;
  try
      TEmployeeClientListGUI(Form).OnGridDataSelect := TEmployeeClientListGUI(Form).doChoosenMakeSupplier;
      TEmployeeClientListGUI(Form).TimerMsg(TEmployeeClientListGUI(Form).FilterLabel, 'Select an entry from the list which will be converted into a supplier');
      TEmployeeClientListGUI(Form).Showmodal;
      Result:= TEmployeeClientListGUI(Form).SupplierID;
  finally
    Freeandnil(Form);
  end;

end;
procedure TEmployeeClientListGUI.CopyOthercontactToSupplier(Const OCID:Integer);
begin
    With TOtherContact.CreateWithNewConn(Self) do try
      Load(OCID);
      if count =0 then begin
        MessageDlgXP_Vista('Prospect record not found for ' + Quotedstr(qrymainname.asString ), mtWarning, [mbOK], 0);
        Exit;
      end;
      if Lock = False then begin
        MessageDlgXP_Vista(replacestr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to convert Prospect ' + QuotedStr(Qrymainname.AsString)+' to supplier.'), mtWarning, [mbOK], 0);
        Exit;
      end;
      connection.BeginTransaction;
      try
        Supplier    := True;
        SupplierID      := ID;
        OtherContact:= False;
        PostDB;
        connection.CommitTransaction;
      Except
        on E:Exception do begin
          Connection.RollbackTransaction;
        end;
      end;
      UnLock;
    finally
      Free;
    end;

end;
Procedure TEmployeeClientListGUI.CopyCustomerToSupplier(Const CustomerID:Integer);
begin
      With Tcustomer.CreateWithNewConn(Self) do try
      Load(CustomerID);
      if count =0 then begin
        MessageDlgXP_Vista('Customer record not found for ' + Quotedstr(qrymainname.asString ), mtWarning, [mbOK], 0);
        Exit;
      end;
      if Lock = False then begin
        MessageDlgXP_Vista(replacestr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to convert Customer ' + QuotedStr(Qrymainname.AsString)+' to supplier.'), mtWarning, [mbOK], 0);
        Exit;
      end;
      connection.BeginTransaction;
      try
        Supplier:= True;
        SupplierID:= ID;
        PostDB;
        Connection.CommitTransaction;
      Except
        on E:Exception do begin
          connection.RollbackTransaction;
        end;
      end;
      UnLock;
    finally
      Free;
    end;

end;
procedure TEmployeeClientListGUI.CopyEmployeeToSupplier(Const EmployeeID:Integer);
begin
  With TEmployee.CreateWithNewConn(Self) do try
    Load(EmployeeID);

      if count =0 then begin
        MessageDlgXP_Vista('Employee record not found for ' + Quotedstr(qrymainname.asString ), mtWarning, [mbOK], 0);
        Exit;
      end;
      if Lock = False then begin
        MessageDlgXP_Vista(replacestr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to convert Employee ' + QuotedStr(Qrymainname.AsString)+' to supplier.'), mtWarning, [mbOK], 0);
        Exit;
      end;
      connection.BeginTransaction;
      try
      (*if fClient.count> 0 then  begin
          if fclient.isSupplier then begin
            REsult := fclient.ID;
            Exit;
          end else if fclient.IsCustomer then begin
            CopyCustomerToSupplier(fclient.ID);
            exit;
          end else if fclient.IsOtherContact then begin
            CopyOthercontactToSupplier(fclient.ID);
            exit;
          end;
      end;*)
        if not(Lock) then begin
          MessageDlg(replacestr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to flag ' +Quotedstr(company)+' as Client/Customer.'), mtWarning, [mbOK], 0);
          Exit;
        end;
        SupplierID:= CopyTosupplier;
        connection.CommitTransaction;
      Except
        on E:Exception do begin
          connection.RollbackTransaction;
        end;
      end;


    unlock;
  finally
    Free;
  end;
end;

procedure TEmployeeClientListGUI.doChoosenMakeSupplier(Sender: TwwDbGrid);
begin
  SupplierId := 0;
  if QrymainIsSupplier.asBoolean then begin
    SupplierId := QrymainId.asInteger;
  end else if  Qrymainiscustomer.AsBoolean      then begin
    CopyCustomerToSupplier(QrymainId.asInteger);
  end else if  QryMainISOthercontact.AsBoolean  then begin
    CopyOthercontactToSupplier(QrymainId.asInteger);
  end else if  QrymainisEmployee.AsBoolean      then begin
    CopyEmployeeToSupplier(QrymainId.asInteger);
  end;
end;

procedure TEmployeeClientListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiSupplierID:= 0;

end;

procedure TEmployeeClientListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainemployeeId.fieldname);
  RemoveFieldfromGrid(QrymainId.fieldname);
  RemoveFieldfromGrid(QrymainClientId.fieldname);
end;

Initialization
  RegisterClassOnce(TEmployeeClientListGUI);

end.

