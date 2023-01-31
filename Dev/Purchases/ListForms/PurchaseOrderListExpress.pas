unit PurchaseOrderListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, BaseInputForm,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPurchaseOrderListExpressGUI = class(TBaseListExpressGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainComments: TWideStringField;
    qryMainETADate: TDateField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainInvoiceDate: TDateField;
    qryMainApproved: TWideStringField;
    qryMainPaid: TWideStringField;
    qryMainSupplierName: TWideStringField;
    chkShowNonApproved: TCheckBox;
    lblApproval: TLabel;
    btnBOList: TDNMSpeedButton;
    qryMainSmartOrderId: TIntegerField;
    qryMainSmartOrderApprovedBy: TWideStringField;
    qryMainFuturePo: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainOrderStatus: TWideStringField;
    qryMainPOApprovedBy: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure btnBOListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkShowNonApprovedClick(Sender: TObject);
  private

    procedure FindNonApproved;

    { Private declarations }
  Protected
    Function ExpressDetailListName:String;Override;

  public

    Procedure RefreshQuery;Override;
    Procedure RefreshTotals;Override;

  end;


implementation

uses CommonLib, AppEnvironment, tcDataUtils, BusObjApprovals, CommonDbLib, dateutils,
  CommonFormLib;

{$R *.dfm}
{ TPurchaseOrderListExpressGUI }


procedure TPurchaseOrderListExpressGUI.btnBOListClick(Sender: TObject);
begin
  inherited;
  if OpenERPListForm('TBackorderPurchaseOrderExpressGUI') then
    Close;
end;

procedure TPurchaseOrderListExpressGUI.chkShowNonApprovedClick(Sender: TObject);
begin
  inherited;
  if chkShowNonApproved.focused then
    RefreshQuery;
end;

procedure TPurchaseOrderListExpressGUI.cmdNewClick(Sender: TObject);
begin
  if not EmployeeHasAccess('FnCreatePurchaseOrder') then
  begin
    CommonLib.MessageDlgXP_Vista('You Do Not Have Rights To Create New Purchase Orders', mtWarning, [mbOK], 0);
    Exit;
  end;
  inherited;
  OpenERPForm('TPurchaseGUI' , 0);
end;

function TPurchaseOrderListExpressGUI.ExpressDetailListName: String;
begin
  result := 'TPurchaseOrderListGUI';
end;

procedure TPurchaseOrderListExpressGUI.RefreshQuery;
begin

  qryMain.Params.ParamByName('txtfrom').asDatetime:= filterdateFrom;
  qryMain.Params.ParamByName('txtto').asDateTime := Filterdateto;

  if AppEnv.CompanyPrefs.UseApprovalLevels then begin
    if chkShowNonApproved.Checked then qryMain.Params.ParamByName('Approved').AsString := 'F'
     else qryMain.Params.ParamByName('Approved').AsString := 'T';
    qryMain.Params.ParamByName('EmployeeApprovalValueH').AsString :=
       FormatFloat('########0.00',tcDataUtils.GetEmployeeApprovalValueH(AppEnv.Employee.EmployeeID,ApprovalTypePurchaseOrder));

    qryMain.Params.ParamByName('EmployeeApprovalValueL').AsString :=
     FormatFloat('########0.00',tcDataUtils.GetEmployeeApprovalValueL(AppEnv.Employee.EmployeeID,ApprovalTypePurchaseOrder));
  end else begin
    qryMain.Params.ParamByName('EmployeeApprovalValueH').AsFloat := 0;
    qryMain.Params.ParamByName('EmployeeApprovalValueL').AsFloat := 0;
    qryMain.Params.ParamByName('Approved').AsString := 'F';
  end;
  FindNonApproved;
  inherited;
end;
procedure TPurchaseOrderListExpressGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPurchaseOrderListExpressGUI.FindNonApproved;
begin
//lblApproval.Visible := False;

lblApproval.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
chkShowNonApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels;


(*lblApproval.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
        if POLib.FindNonApproved(self) then begin
          lblApproval.Visible := True;
          chkShowNonApproved.Visible := True;
        end else begin
          lblApproval.Visible := False;
          chkShowNonApproved.Visible := False;
        end;*)

(* var
  NonApprovedFound:Boolean;
  qry:TERPQuery;
  SQLstr:string;
  ToDate, FromDate: TDateTime;
begin
  SQLstr := qryMain.SQL.Text;
  NonApprovedFound := False;
  try
    if AppEnv.CompanyPrefs.UseApprovalLevels then begin
      ToDate   := incDay(dtto.DateTime,1);
      FromDate := dtfrom.DateTime;
      qry := CommonDbLib.TempMyQuery;
      try
        qry.SQL.Clear;
        qry.SQL.Add(SQLstr);

        qry.Params.ParamByName('txtfrom').AsDate :=  FromDate;
        qry.Params.ParamByName('txtto').AsDate :=  ToDate;
        qry.Params.ParamByName('EmployeeApprovalValueH').AsFloat := 0;
        qry.Params.ParamByName('Approved').AsString := 'F';
        qryMain.Params.ParamByName('EnteredBy').AsString := AppEnv.Employee.EmployeeName;
        qry.Open;
        qry.First;
        while not qry.Eof do begin
          if qry.FieldByName('Approved').AsString = 'F' then begin
            NonApprovedFound := True;
            break;
          end;
          qry.Next;
        end;

        if NonApprovedFound then begin
          lblApproval.Visible := True;
          chkShowNonApproved.Visible := True;
        end else begin
          lblApproval.Visible := False;
          chkShowNonApproved.Visible := False;
        end;
      finally
        FreeAndNil(qry);
      end;
    end;
  finally

  end; *)
end;

procedure TPurchaseOrderListExpressGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Addcalccolumn(qryMainTotalAmountInc.FieldName, true);
end;

initialization
  RegisterClassOnce(TPurchaseOrderListExpressGUI);

end.

