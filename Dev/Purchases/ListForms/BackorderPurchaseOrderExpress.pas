unit BackorderPurchaseOrderExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBackorderPurchaseOrderExpressGUI = class(TBaseListExpressGUI)
    qryMainSupplierName: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainlineNotes: TWideMemofield;
    qryMainBackOrder: TFloatField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainOrderDate: TDateField;
    qryMainEmployeeName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainComments: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainLineCost: TFloatField;
    qryMainLineCostAmount: TFloatField;
    qryMainETADate: TDateField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClass: TWideStringField;
    qryMainApproved: TWideStringField;
    chkShowNonApproved: TCheckBox;
    lblApproval: TLabel;
    chkHide0LinesQty: TCheckBox;
    btnPOList: TDNMSpeedButton;
    qryMainConNote: TWideStringField;
    qryMainOrderStatus: TWideStringField;
    qryMainSmartOrderId: TIntegerField;
    qryMainSmartOrderApprovedBy: TWideStringField;
    qryMainFuturePo: TWideStringField;
    qryMainLeadDays: TLargeIntField;
    qryMainPrintName: TWideStringField;
    qryMainOrderLineCustomField1: TWideStringField;
    qryMainOrderLineCustomField2: TWideStringField;
    qryMainOrderLineCustomField3: TWideStringField;
    qryMainOrderLineCustomField4: TWideStringField;
    qryMainOrderLineCustomField5: TWideStringField;
    qryMainOrderLineCustomField6: TWideStringField;
    qryMainOrderLineCustomField7: TWideStringField;
    qryMainOrderLineCustomField8: TWideStringField;
    qryMainOrderLineCustomField9: TWideStringField;
    qryMainOrderLineCustomField10: TWideStringField;
    qryMainMemoLine: TWideMemoField;
    qryMainContainerName: TWideStringField;
    qryMainShippingContainerETA: TDateField;
    procedure chkHide0LinesQtyClick(Sender: TObject);
    procedure chkShowNonApprovedClick(Sender: TObject);
    procedure btnPOListClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    procedure FindNonApproved;
  Protected
    procedure SetGridColumns; Override;
    Function ExpressDetailListName:String;Override;
  public
    Procedure RefreshQuery; override;
    Procedure RefreshTotals;Override;
  end;


implementation

uses CommonLib, dateutils, AppEnvironment, tcDataUtils, CommonDbLib,
  BusObjApprovals, CommonFormLib, Busobjcustomfields;

{$R *.dfm}
{ TBackorderPurchaseOrderExpressGUI }

procedure TBackorderPurchaseOrderExpressGUI.btnPOListClick(Sender: TObject);
begin
  inherited;
  if OpenERPListForm('TPurchaseOrderListExpressGUI') then
    Close;
end;

procedure TBackorderPurchaseOrderExpressGUI.chkHide0LinesQtyClick(
  Sender: TObject);
begin
  inherited;
  if chkHide0LinesQty.checked then GroupFilterString := 'Backorder <> 0' else GroupFilterString := '';
  inherited grpFiltersClick(grpFilters);

end;

procedure TBackorderPurchaseOrderExpressGUI.chkShowNonApprovedClick(
  Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TBackorderPurchaseOrderExpressGUI.cmdNewClick(Sender: TObject);
begin
  if not EmployeeHasAccess('FnCreatePurchaseOrder') then
  begin
    CommonLib.MessageDlgXP_Vista('You Do Not Have Rights To Create New Purchase Orders', mtWarning, [mbOK], 0);
    Exit;
  end;

  inherited;

  OpenERPForm('TPurchaseGUI' , 0);
end;

function TBackorderPurchaseOrderExpressGUI.ExpressDetailListName: String;
begin
  Result := 'TBackOrderPurchaseListGUI';
end;

procedure TBackorderPurchaseOrderExpressGUI.FindNonApproved;
begin
  lblApproval.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
(*        if POLib.FindNonApproved(self) then begin
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

procedure TBackorderPurchaseOrderExpressGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Addcalccolumn(qryMainLineCostAmount.FieldName, true);
end;

procedure TBackorderPurchaseOrderExpressGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkShowNonApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
end;

procedure TBackorderPurchaseOrderExpressGUI.grdMainDblClick(Sender: TObject);
begin
  if grdMain.SelectedField <> qryMainMemoLine then
   inherited;

end;

procedure TBackorderPurchaseOrderExpressGUI.RefreshQuery;
begin

  InitDateFromnDateto('txtfrom' , 'txtto');
  if AppEnv.CompanyPrefs.UseApprovalLevels then begin
    if chkShowNonApproved.Checked then qryMain.Params.ParamByName('Approved').AsString := 'F'
    else qryMain.Params.ParamByName('Approved').AsString := 'T';
  end else begin
    qryMain.Params.ParamByName('Approved').AsString := 'F';
  end;
  inherited;
  if qryMain.Active then qryMain.First;
  FindNonApproved;

end;

procedure TBackorderPurchaseOrderExpressGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TBackorderPurchaseOrderExpressGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PurchaseOrderId');
  RemoveFieldfromGrid('PurchaseLineId');
  RemoveFieldfromGrid('ProductId');
  SetUpcustomFields(
    'OrderLineCustomField1,OrderLineCustomField2,OrderLineCustomField3,' +
    'OrderLineCustomField4,OrderLineCustomField5,OrderLineCustomField6,' +
    'OrderLineCustomField7,OrderLineCustomField8,OrderLineCustomField9,' +
    'OrderLineCustomField10', ltOrderLines);
end;

initialization
  RegisterClassOnce(TBackorderPurchaseOrderExpressGUI);

end.

