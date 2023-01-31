unit frmPayrollServices;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/08/05  1.00.01 IJB  Converted to MyDac, added mass create/update.
 26/08/05  1.00.02 IJ   Added validation for duplicate service name and blank
                        servicename or part
 12/09/05  1.00.03 DSP  Deleting a record did not work when there was only a
                        single record. This has been fixed.
 19/10/05  1.00.04 DLS  Added RegisterClass
 09/02/06  1.00.05  AL  comented qryServicesAfterPost

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,   wwdblook,
  StdCtrls, wwdbdatetimepicker, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ExtCtrls, DNMPanel, ActnList, DBAccess, MyAccess,ERPdbComponents, DataState, MemDS, Menus,
  AdvMenus, Shader,BusObjEmployeeServices,BusObjBase, ImgList, ProgressDialog;

type
  TDuplicateResult = (drNone, drActiveDuplicate, drInactiveDuplicate);

  TfrmPayrollServicesGUI = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    cboName: TwwDBLookupCombo;
    grdServices: TwwDBGrid;
    DSEmployee: TDataSource;
    dsServices: TDataSource;
    Label1: TLabel;
    grdServicesIButton: TwwIButton;
    ActionList1: TActionList;
    actSave: TAction;
    btnClose: TDNMSpeedButton;
    DSParts: TDataSource;
    cboParts: TwwDBLookupCombo;
    btnMassCreate: TDNMSpeedButton;
    qryServices: TERPQuery;
    qryEmployee: TERPQuery;
    qryParts: TERPQuery;
    qryServicesID: TIntegerField;
    qryServicesGlobalRef: TWideStringField;
    qryServicesEmployeeID: TIntegerField;
    qryServicesServiceName: TWideStringField;
    qryServicesRate: TFloatField;
    qryServicesEditedFlag: TWideStringField;
    qryServicesActive: TWideStringField;
    qryServicesPartID: TIntegerField;
    qryServicesPartName: TWideStringField;
    qryServicesPartDescription: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryPartsPartsID: TIntegerField;
    qryPartsPartName: TWideStringField;
    qryPartsPrice1: TFloatField;
    qryPartsTAXCODE: TWideStringField;
    qryPartsPriceInc1: TFloatField;
    qryServicesPriceInc1: TFloatField;
    qryServicesIsFixed: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdServicesIButtonClick(Sender: TObject);
    procedure cboNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure qryServicesAfterPost(DataSet: TDataSet);
    procedure actSaveExecute(Sender: TObject);
    procedure cboPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnMassCreateClick(Sender: TObject);
    procedure grdServicesExit(Sender: TObject);
    procedure qryServicesBeforePost(DataSet: TDataSet);
    procedure qryServicesAfterInsert(DataSet: TDataSet);
  private
    sNewServiceName: string;
    EmployeeServices:TEmployeeServices;
   // function IsDuplicateRec: TDuplicateResult;
    //procedure ActivateRecord;
    procedure HandleEmployeeServiceErrors;
  protected
    fbClosingDown: boolean;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    iEmployeeID: integer;
    property NewServiceName: string read sNewServiceName write sNewServiceName;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  end;

implementation

uses
  DNMLib, DNMExceptions,BusObjConst,
  frmPayrollServicesCreate, CommonLib, FastFuncs;

{$R *.dfm}

procedure TfrmPayrollServicesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbClosingDown := false;
  EmployeeServices := TEmployeeServices.Create(Self);
end;

procedure TfrmPayrollServicesGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    try
      // Inherit from our Base Input Class.
      inherited;
      Setlength(QueryNamesNotToOpen, 1);
      QueryNamesNotToOpen[0] := 'qryServices';

      // Open our Queries
      OpenQueries(QueryNamesNotToOpen);


      EmployeeServices.Connection  := TMyDacDataConnection.Create(EmployeeServices);
      TMyDacDataConnection(EmployeeServices.Connection).MydacConnection  := Self.MyConnection;
      EmployeeServices.BusObjEvent := DoBusinessObjectEvent;

      if KeyID <> 0 then begin
        qryEmployee.Locate('EmployeeID', KeyID, [loCaseInsensitive]);
        cboName.Text := qryEmployee.FieldByName('EmployeeName').AsString;
        grdServices.Enabled := true;

        EmployeeServices.LoadSelect('EmployeeID = ' + IntToStr(KeyID));
        EmployeeServices.CurrentEmployeeID := KeyID;
        EmployeeServices.New;
        EmployeeServices.ServiceName := NewServiceName;
        SetControlFocus(grdServices);
      end else begin
        cboName.Text := qryEmployee.FieldByName('EmployeeName').AsString;

        EmployeeServices.LoadSelect('EmployeeID = ' + IntToStr(qryEmployee.FieldByName('EmployeeId').AsInteger));
        EmployeeServices.CurrentEmployeeID := qryEmployee.FieldByName('EmployeeId').AsInteger;
        if not qryServices.IsEmpty then grdServices.Enabled := true
        else begin
          if cboName.LookupTable.Active = false then cboName.LookupTable.Open;
          cboNameCloseUp(CboName, cboName.LookupTable, nil, true);
        end;
      end;

      BeginTransaction;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPayrollServicesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  Action := caFree;
  RollbackTransaction;
  inherited;
end;

procedure TfrmPayrollServicesGUI.grdServicesIButtonClick(Sender: TObject);
begin
  inherited;
  EmployeeServices.delete;
end;

procedure TfrmPayrollServicesGUI.cboNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  grdServices.Enabled := true;
  iEmployeeID := LookupTable.FieldByName('EmployeeID').AsInteger;
  EmployeeServices.LoadSelect('EmployeeId = ' + IntToStr(iEmployeeID));
  EmployeeServices.CurrentEmployeeID := iEmployeeID;
end;

procedure TfrmPayrollServicesGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  fbClosingDown := true;
  Close;
end;

procedure TfrmPayrollServicesGUI.actSaveUpdate(Sender: TObject);
begin
  inherited;
  if qryServices.Active then
    btnSave.Enabled := true
  else
    btnSave.Enabled := false;
end;

procedure TfrmPayrollServicesGUI.qryServicesAfterPost(DataSet: TDataSet);
begin
  {inherited;
  DataSet.Edit;
  DataSet.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + Dataset.FieldByName('ID').AsString;
  if fbClosingDown then Exit;}
end;

procedure TfrmPayrollServicesGUI.actSaveExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    try
      if HasPayrollAccess()  //and (qryServices.Active) then begin
        then if not EmployeeServices.Save then exit;
      if MyConnection.intransaction then CommitTransaction;
    except
      RollbackTransaction;
    end;
    fbClosingDown := true;
    Close;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPayrollServicesGUI.cboPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.Edit;
  FillTable.FieldByName('PartID').AsInteger := LookupTable.FieldByName('PartsID').AsInteger;
  FillTable.FieldByName('Rate').AsFloat := GetAmountInc(LookupTable.FieldByName('Price1').AsFloat,
    GetTaxRate(LookupTable.FieldByName('TAXCODE').AsString));
end;

procedure TfrmPayrollServicesGUI.btnMassCreateClick(Sender: TObject);
var tmpComponent:TComponent;
begin
  inherited;
  tmpComponent:= GetComponentByClassName('TfmPayrollServicesCreate');
  if not assigned(tmpComponent) then exit;
  with TfmPayrollServicesCreate(tmpComponent) do begin
    AttachObserver(self);
    //FormStyle:= fsMdiChild;
    DbConnection := MyConnection;
    if cboName.Text <> '' then CreateForEmployeeID := qryEmployee.FieldByName('EmployeeID').AsInteger;
    //BringToFront;
    ShowModal;
  end;
  qryServices.Close;
  qryServices.Open;
end;

procedure TfrmPayrollServicesGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject = nil);
begin
  if qryServices.Active and (aObject is TfmPayrollServicesCreate) then begin
    iEmployeeID := qryEmployee.FieldByName('EmployeeId').AsInteger;
    EmployeeServices.LoadSelect('EmployeeId = ' + IntToStr(iEmployeeID));
    EmployeeServices.CurrentEmployeeID := iEmployeeId;
  end;
end;

procedure TfrmPayrollServicesGUI.grdServicesExit(Sender: TObject);
begin
  inherited;

end;

//function TfrmPayrollServicesGUI.IsDuplicateRec: TDuplicateResult;
//var
//  Qry: TERPQuery;
//begin
//  Result := drNone;
//  Qry := TERPQuery.Create(nil);
//
//  with Qry do try
//      Qry.Options.FlatBuffers := True;
//      Connection := QryServices.Connection;
//      SQL.Add('SELECT * from tblpaysemployeeservices ');
//      SQL.Add('WHERE EmployeeId = ' + qryServicesEmployeeId.AsString);
//      SQL.Add(' AND Servicename = ' + QuotedStr(qryServicesServiceName.AsString));
//
//      if qryServicesID.AsString <> '' then SQl.Add(' AND ID <> ' + qryServicesID.AsString);
//
//      Open;
//
//      if RecordCount > 0 then if FieldByName('Active').AsString = 'T' then Result := drActiveDuplicate
//        else Result := drInactiveDuplicate;
//    finally
//      Free;
//    end;
//end;

procedure TfrmPayrollServicesGUI.qryServicesBeforePost(DataSet: TDataSet);
//var
//  DuplicateRecord: TDuplicateResult;
begin
  inherited;
  //if Trim(qryServicesServiceName.AsString) = '' then if qryServicesPartId.AsInteger = 0 then
//      if qryServicesRate.AsFloat = 0 then begin
//        Dataset.Cancel;
//        Abort;
//        Exit;
//      end;
//
//  if Trim(qryServicesServiceName.AsString) = '' then begin
//    CommonLib.MessageDlgXP_Vista('Service name should not be blank.', mtWarning, [mbOK], 0);
//    grdServices.SetActiveField('ServiceName');
//    Abort;
//    Exit;
//  end;
//
//  if qryServicesPartId.AsInteger = 0 then begin
//    CommonLib.MessageDlgXP_Vista('You must assign a product', mtWarning, [mbOK], 0);
//    grdServices.SetActiveField('PartName');
//    Abort;
//    Exit;
//  end;
//
//  DuplicateRecord := IsDuplicateRec;
//
//  if DuplicateRecord = drActiveDuplicate then begin
//    CommonLib.MessageDlgXP_Vista(qryServicesServiceName.AsString + ' already created for ' + cboName.Text, mtWarning, [mbOK], 0);
//    grdServices.SetActiveField('ServiceName');
//    Abort;
//    Exit;
//  end else if DuplicateRecord = drInactiveDuplicate then begin
//    if CommonLib.MessageDlgXP_Vista('''' + qryServicesServiceName.AsString + ''' is already an inactive record for ''' +
//      cboName.Text + '''' + #13#10#13#10 + 'Do you want to activate this record?',
//      mtWarning, [mbYes, mbNo], 0) = mrYes then ActivateRecord;
//
//    grdServices.SetActiveField('ServiceName');
//    Abort;
//    Exit;
//  end;
end;

procedure TfrmPayrollServicesGUI.qryServicesAfterInsert(DataSet: TDataSet);
begin
  inherited;

end;

//procedure TfrmPayrollServicesGUI.ActivateRecord;
//var
//  Qry: TERPQuery;
//  ServiceName: string;
//begin
//  Qry := TERPQuery.Create(nil);
//  with Qry do try
//      Qry.Options.FlatBuffers := True;
//      ServiceName := qryServicesServiceName.AsString;
//      Connection := QryServices.Connection;
//      SQL.Add('SELECT * from tblpaysemployeeservices ');
//      SQL.Add('WHERE EmployeeId = ' + qryServicesEmployeeId.AsString);
//      SQL.Add(' AND ServiceName = ' + QuotedStr(ServiceName));
//
//      if qryServicesID.AsString <> '' then SQl.Add(' and ID <> ' + qryServicesID.AsString);
//
//      Open;
//
//      //if RecordCount > 0 then begin
////        qryServices.DisableControls;
////        qryServices.Delete;
////        Edit;
////        FieldByName('Active').AsString := 'T';
////        Post;
////        qryServices.Close;
////        qryServices.Open;
////        qryServices.Locate('ServiceName', ServiceName, [loCaseInsensitive]);
////        qryServices.Edit;
////      end;
//    finally
//      if qryServices.ControlsDisabled then qryServices.EnableControls;
//      FreeAndNil(qry);
//    end;
//end;

procedure TfrmPayrollServicesGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
 inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TEmployeeServices then TEmployeeServices(Sender).DataSet := qryServices;
  end;
  if Value = BusobjEventVal_FailedEmpServicesValidateData then begin
    HandleEmployeeServiceErrors;
  end;
end;

procedure TfrmPayrollServicesGUI.HandleEmployeeServiceErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := EmployeeServices.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_No_EmpService_Name : begin
                                 grdServices.SetActiveField('ServiceName');
                                 SetControlFocus(grdServices);
                               end;
      BOR_No_EmpService_Part : begin
                                 grdServices.SetActiveField('PartName');
                                 SetControlFocus(grdServices);
                               end;
      BOR_No_EmpService_Rate : begin
                                 grdServices.SetActiveField('Rate');
                                 SetControlFocus(grdServices);
                               end; 
    end;
  end;
end;


initialization
  RegisterClassOnce(TfrmPayrollServicesGUI);
end.
