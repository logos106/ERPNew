unit BarcodePickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBarcodePickListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainstatus: TWideStringField;
    qryMainPickingAssemblyID: TIntegerField;
    qryMainInvoiceNo: TIntegerField;
    qryMainPickingEmployee: TWideStringField;
    qryMainStartPickingTime: TDateTimeField;
    qryMainFinishedPickingTime: TDateTimeField;
    qryMainPickingDuration: TTimeField;
    qryMainPickingToPackingDuration: TTimeField;
    qryMainPackingEmployee: TWideStringField;
    qryMainStartPackingTime: TDateTimeField;
    qryMainFinishedPackingTime: TDateTimeField;
    qryMainPackingDuration: TTimeField;
    qryMainConNote: TWideStringField;
    qryMainVia: TWideStringField;
    qryMainShipCost: TFloatField;
    qryMaincustomername: TWideStringField;
    qryMainSalestype: TWideStringField;
    qryMainstatusnumber: TLargeintField;
    qryMainFinishedPacking: TWideStringField;
    qryMainFinishedPicking: TWideStringField;
    qryMainStartPicking: TWideStringField;
    qryMainStartPacking: TWideStringField;
    qryMainPickingAssemblyEntryID: TIntegerField;
    qryMainEntryId: TIntegerField;
    qryMainEntrycreatedon: TDateTimeField;
    qryMainConverted: TWideStringField;
    qryMainFinishedDispatch: TWideStringField;
    qryMainStartDispatch: TWideStringField;
    qryMainStartDispatchTime: TDateTimeField;
    qryMainFinishedDispatchTime: TDateTimeField;
    qryMainDispatchDuration: TTimeField;
    qryMainDispatchingEmployee: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns; override;
    procedure AfterPopup(Popupform:TComponent);Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, FastFuncs, CommonFormLib, frmBarcodePicking, ProductQtyLib,
  AppEnvironment;

{$R *.dfm}

procedure TBarcodePickListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if  not(Popupform is TfmBarcodePicking) then exit;
  if (QrymainentryID.asInteger=0) and (Sysutils.SameText(grdMain.GetActiveField.FieldName,Qrymainstatus.fieldname)) then begin
    TfmBarcodePicking(Popupform).SaleIDToPick := QrymainInvoiceNo.AsInteger;
    MessageDlgXP_vista('Please do the employee login', mtInformation, [mbOK], 0);
  end;
end;

procedure TBarcodePickListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmBarcodePicking' , 0);
end;

procedure TBarcodePickListGUI.FormCreate(Sender: TObject);
begin
  if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
    grpFilters.Items.CommaText := 'Printed,Picking,Packing,Dispatching,Finished,"Not Printed",All';
    grpFilters.Columns := 7;
  end
  else begin
    grpFilters.Items.CommaText := 'Printed,Picking,Packing,Finished,"Not Printed",All';
    grpFilters.Columns := 6;
  end;




  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT distinct');
  qryMain.SQL.Add('"" as Salestype,');
  qryMain.SQL.Add('PAE.PickingAssemblyEntryID as EntryId,');
  qryMain.SQL.Add('PAE.CreatedOn as Entrycreatedon,');
  qryMain.SQL.Add('ifnull(PA.GlobalRef, PAE.GlobalRef)         as GlobalRef,');
  qryMain.SQL.Add('ifnull(PA.FinishedDispatch, PAE.FinishedDispatch) as FinishedDispatch,');
  qryMain.SQL.Add('ifnull(PA.FinishedPacking, PAE.FinishedPacking) as FinishedPacking,');
  qryMain.SQL.Add('ifnull(PA.FinishedPicking, PAE.FinishedPicking ) as FinishedPicking,');
  qryMain.SQL.Add('ifnull(PA.StartDispatch, PAE.StartDispatch ) as StartDispatch,');
  qryMain.SQL.Add('ifnull(PA.StartPicking, PAE.StartPicking ) as StartPicking,');
  qryMain.SQL.Add('ifnull(PA.StartPacking, PAE.StartPacking ) as StartPacking,');
  if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
    qryMain.SQL.Add('if(Ifnull(PA.FinishedDispatch,Ifnull(PAE.FinishedDispatch,"F")) ="T" , "Finished" ,'+
                    'if(Ifnull(PA.StartDispatch,Ifnull(PAE.StartDispatch,"F")) ="T" , "Dispatching" ,' +
                    'if(Ifnull(PA.FinishedPacking,Ifnull(PAE.FinishedPacking,"F")) ="T" , "Packed" ,' +
                    'if(Ifnull(PA.StartPacking,Ifnull(PAE.StartPacking,"F")) ="T" , "Packing" ,' +
                    'if(Ifnull(PA.FinishedPicking,Ifnull(PAE.FinishedPicking,"F")) ="T" , "Picked" ,'+
                    'if(Ifnull(PA.StartPicking,Ifnull(PAE.StartPicking,"F")) ="T" , "Picking" ,' +
                    'if(ifnull(PA.PickingAssemblyID,0)<> 0 , "Printed" , "Not Started"))))))) as status,');
    qryMain.SQL.Add('convert(IFNULL(if(Ifnull(PA.FinishedDispatch,Ifnull(PAE.FinishedDispatch,"F")) ="T" , 7 ,'+  { finished }
                    'if(Ifnull(PA.StartDispatch,Ifnull(PAE.StartDispatch,"F")) ="T" , 6 ,' +                      { Dispatching }
                    'if(Ifnull(PA.FinishedPacking,Ifnull(PAE.FinishedPacking,"F")) ="T" , 5 ,' +                  { Packed }
                    'if(Ifnull(PA.StartPacking,Ifnull(PAE.StartPacking,"F")) ="T" , 4 ,' +                        { Packing }
                    'if(Ifnull(PA.FinishedPicking,Ifnull(PAE.FinishedPicking,"F")) ="T" , 3 ,' +                  { Picked }
                    'if(Ifnull(PA.StartPicking,Ifnull(PAE.StartPicking,"F")) ="T" , 2 ,' +                        { Picking }
                    'if(ifnull(PA.PickingAssemblyID,0)<> 0 , 1,0))))))),0),unsigned)  as statusnumber,');           { not started }
  end
  else begin
    qryMain.SQL.Add('if(Ifnull(PA.FinishedPacking,Ifnull(PAE.FinishedPacking,"F")) ="T" , "Finished" ,'+
                    'if(Ifnull(PA.StartPacking,Ifnull(PAE.StartPacking,"F")) ="T" , "Packing" ,' +
                    'if(Ifnull(PA.FinishedPicking,Ifnull(PAE.FinishedPicking,"F")) ="T" , "Picked" ,'+
                    'if(Ifnull(PA.StartPicking,Ifnull(PAE.StartPicking,"F")) ="T" , "Picking" ,' +
                    'if(ifnull(PA.PickingAssemblyID,0)<> 0 , "Printed" , "Not Started"))))) as status,');
    qryMain.SQL.Add('convert(IFNULL(if(Ifnull(PA.FinishedPacking,Ifnull(PAE.FinishedPacking,"F")) ="T" , 5 ,'+
                    'if(Ifnull(PA.StartPacking,Ifnull(PAE.StartPacking,"F")) ="T" , 4 ,' +
                    'if(Ifnull(PA.FinishedPicking,Ifnull(PAE.FinishedPicking,"F")) ="T" , 3 ,' +
                    'if(Ifnull(PA.StartPicking,Ifnull(PAE.StartPicking,"F")) ="T" , 2 ,' +
                    'if(ifnull(PA.PickingAssemblyID,0)<> 0 , 1,0))))),0),unsigned)  as statusnumber,');
  end;
  qryMain.SQL.Add('PickingAssemblyID    as PickingAssemblyID,');
  qryMain.SQL.Add('S.SaleID             as InvoiceNo,');
  qryMain.SQL.Add('E.EmployeeName       as PickingEmployee,');
  qryMain.SQL.Add('ifnull(PA.StartPickingTime ,PAE.StartPickingTime)    as StartPickingTime,');
  qryMain.SQL.Add('ifnull(PA.FinishedPickingTime,PAE.FinishedPickingTime)  as FinishedPickingTime,');
  qryMain.SQL.Add('SEC_TO_TIME( TIME_TO_SEC(ifnull(PA.FinishedPickingTime,PAE.FinishedPickingTime))-TIME_TO_SEC(ifnull(PA.StartPickingTime,PAE.StartPickingTime)))   as PickingDuration,');
  qryMain.SQL.Add('SEC_TO_TIME( TIME_TO_SEC(ifnull(PA.StartPackingTime,PAE.StartPackingTime))-TIME_TO_SEC(ifnull(PA.FinishedPickingTime,PAE.FinishedPickingTime)) )  as PickingToPackingDuration,');
  qryMain.SQL.Add('E2.EmployeeName      as PackingEmployee,');
  qryMain.SQL.Add('ifnull(PA.StartPackingTime , PAE.StartPackingTime)     as StartPackingTime,');
  qryMain.SQL.Add('ifnull(PA.FinishedPackingTime, PAE.FinishedPackingTime)  as FinishedPackingTime,');
  qryMain.SQL.Add('SEC_TO_TIME( TIME_TO_SEC(ifnull(PA.FinishedPackingTime,PAE.FinishedPackingTime))-TIME_TO_SEC(ifnull(PA.StartPackingTime,PAE.StartPackingTime)))   as PackingDuration,');

  qryMain.SQL.Add('ifnull(PA.StartDispatchTime , PAE.StartDispatchTime)     as StartDispatchTime,');
  qryMain.SQL.Add('ifnull(PA.FinishedDispatchTime, PAE.FinishedDispatchTime)  as FinishedDispatchTime,');
  qryMain.SQL.Add('SEC_TO_TIME( TIME_TO_SEC(ifnull(PA.FinishedDispatchTime,PAE.FinishedDispatchTime))-TIME_TO_SEC(ifnull(PA.StartDispatchTime,PAE.StartDispatchTime)))   as DispatchDuration,');
  qryMain.SQL.Add('E3.EmployeeName      as DispatchingEmployee,');

  qryMain.SQL.Add('S.ConNote            as ConNote,');
  qryMain.SQL.Add('S.Shipping           as Via,');
  qryMain.SQL.Add('S.ShippingCost       as ShipCost , S.customername,');
  qryMain.SQL.Add('PAE.PickingAssemblyEntryID,');
  qryMain.SQL.Add('PAE.Converted as Converted');
  qryMain.SQL.Add('FROM tblSales S INNER JOIN tblSalesLines SL Using(SaleID)');
  qryMain.SQL.Add('INNER JOIN tblClients C  ON C.ClientID= S.ClientID');
  qryMain.SQL.Add('Left join tblpickingassemblyentry PAE ON S.SaleID=PAE.SaleID');
  qryMain.SQL.Add('Left join tblpickingassembly PA on PAE.PickingAssemblyEntryID = PA.PickingAssemblyEntryID');
  qryMain.SQL.Add('LEFT JOIN tblemployees E ON E.EmployeeID = PA.PickingEmployeeID or E.EmployeeID = PAE.PickingEmployeeID');
  qryMain.SQL.Add('LEFT JOIN tblemployees E2 ON E2.EmployeeID = PA.PackingEmployeeID or E2.EmployeeID = PAE.PackingEmployeeID');
  qryMain.SQL.Add('LEFT JOIN tblemployees E3 ON E3.EmployeeID = PA.DispatchingEmployeeID or E3.EmployeeID = PAE.DispatchingEmployeeID');

  qryMain.SQL.Add('where S.converted ="F" and s.saleDAte between :Datefrom and :Dateto');
  qryMain.SQL.Add('and (S.IsInvoice = "T" or S.IsSalesOrder = "T")');
  qryMain.SQL.Add('Order by EntryId desc , PickingPriority Desc,s.SaleId, SaleDate, S.SaleID;');

  Qrymain.SQL.Text := replacestr(Qrymain.SQL.Text, '"" as Salestype,' , SaleType('S') +' as Salestype,');
  self.RefreshOrignalSQL();
  //NoDateRange := true;
  inherited;

end;

procedure TBarcodePickListGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  if AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
    //grpFilters.Items.CommaText := 'Printed,Picking,Packing,Dispatching,Finished,"Not Printed",All';
    case grpFilters.ItemIndex of
      0:Qrymain.Filter := 'statusnumber = 1 ';
      1:Qrymain.Filter := 'statusnumber = 2 or statusnumber = 3 ';
      2:Qrymain.Filter := 'statusnumber = 4 or statusnumber = 5 ';
      3:Qrymain.Filter := 'statusnumber = 6 ';
      4:Qrymain.Filter := 'statusnumber = 7 ';
      5:Qrymain.Filter := 'statusnumber = 0 ';
      6:Qrymain.Filter := ' ';
    end;
  end
  else begin
    case grpFilters.ItemIndex of
      0:Qrymain.Filter := 'statusnumber = 1 ';
      1:Qrymain.Filter := 'statusnumber = 2 or statusnumber = 3 ';
      2:Qrymain.Filter := 'statusnumber = 4 ';
      3:Qrymain.Filter := 'statusnumber = 5 ';
      4:Qrymain.Filter := 'statusnumber = 0 ';
      5:Qrymain.Filter := ' ';
    end;
  end;
  Qrymain.Filtered := True;
end;

procedure TBarcodePickListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('dateFrom').AsDateTime := filterDateFrom;
  Qrymain.ParamByName('dateTo').AsDateTime   := filterDateTo;
  inherited;
end;

procedure TBarcodePickListGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFilters.ItemIndex:= 5;
end;

procedure TBarcodePickListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID :=  '';
  if ((Sysutils.SameText(grdMain.GetActiveField.FieldName,'Invoiceno')) or (Sysutils.SameText(grdMain.GetActiveField.FieldName,'customername')))
     and (qryMainInvoiceNo.asInteger <> 0 ) then begin
      SubsequentID := Chr(95) + qryMainSalestype.asString;
  end else if (QrymainentryID.asInteger=0) and (Sysutils.SameText(grdMain.GetActiveField.FieldName,Qrymainstatus.fieldname)) then begin
    if MessageDlgXP_Vista('Picking is not started. Do you want to create a new Packing?' ,mtconfirmation , [mbyes,mbno],0)= mrno then exit;
(*  end else if qryMainFinishedPicking.asBoolean =False  then begin
    OpenERPForm('TfmBarcodePicking' ,qryMainPickingAssemblyEntryID.AsInteger );
    Exit;*)
  end;
  inherited;
end;

procedure TBarcodePickListGUI.SetGridColumns;
begin
  inherited;
  //RemoveFieldfromGrid(qrymainSalestype.FieldName);
  RemoveFieldfromGrid(QrymainPickingAssemblyID.FieldName);
  RemoveFieldfromGrid(qryMainPickingAssemblyEntryID.FieldName);
  RemoveFieldfromGrid(qryMainglobalref.FieldName);
  if not AppEnv.CompanyPrefs.UseBarcodeDispatch then begin
    RemoveFieldfromGrid(qryMainStartDispatch.FieldName);
    RemoveFieldfromGrid(qryMainStartDispatchTime.FieldName);
    RemoveFieldfromGrid(qryMainFinishedDispatch.FieldName);
    RemoveFieldfromGrid(qryMainFinishedDispatchTime.FieldName);
    RemoveFieldfromGrid(qryMainDispatchDuration.FieldName);
    RemoveFieldfromGrid(qryMainDispatchingEmployee.FieldName);
  end;

end;

initialization
  RegisterClassOnce(TBarcodePickListGUI);

end.

