unit frmPrintWorkOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, DNMSpeedButton, wwcheckbox,
  CheckLst, IntegerListObj;

type
  TfmPrintWorkOrders = class(TBaseInputGUI)
    pnlDetails: TDNMPanel;
    pnltop: TDNMPanel;
    pnlBottom: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    lstProcesses: TCheckListBox;
    DNMPanel2: TDNMPanel;
    lstEmployees: TCheckListBox;
    lblProcesses: TLabel;
    lblEmployees: TLabel;
    pnlOptions: TDNMPanel;
    chkChooseRpt: TcheckBox;
    lblReportName: TLabel;
    chkPreview: TcheckBox;
    btnPrint: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    QryProcesses: TERPQuery;
    Qryemployees: TERPQuery;
    QryProcessesProcessStepID: TIntegerField;
    QryProcessesProcessStep: TWideStringField;
    QryemployeesEmployeeID: TIntegerField;
    QryemployeesEmployeeName: TWideStringField;
    DNMPanel3: TDNMPanel;
    lblProcessunSelectAll: TLabel;
    lblProcessSelectAll: TLabel;
    DNMPanel4: TDNMPanel;
    lblEmployeeUnSelectAll: TLabel;
    lblEmployeeSelectAll: TLabel;
    chkIncludeAllocation: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lstProcessesClick(Sender: TObject);
    procedure lstEmployeesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintClick(Sender: TObject);
    procedure lblProcessSelectAllClick(Sender: TObject);
    procedure lblProcessunSelectAllClick(Sender: TObject);
    procedure lblEmployeeSelectAllClick(Sender: TObject);
    procedure lblEmployeeUnSelectAllClick(Sender: TObject);
  private
    fstmp_EmpWorkOrder: String;
    fstmp_SimpeWorkOrder: String;
    fsCallingFormname: String;
    fOnSelection: TNotifyEvent;
    fProcessStepIDs:TIntegerList;
    fEmployeeIDs:TIntegerList;
    fddateTo: Tdatetime;
    fddatefrom: TdateTime;
    fsProcessPartIDs: String;
    procedure OnSelect(CheckList: TCheckListBox; IntList: TIntegerList);
  Protected
    function GetReportTypeID: integer; Override;
    Procedure ReadExtraguiprefs;
    Procedure WriteExtraguiprefs;
  public
    Property ProcessStepIDs:TIntegerList read fProcessStepIDs;
    Property EmployeeIDs:TIntegerList read fEmployeeIDs;
    Property tmp_EmpWorkOrder :String read fstmp_EmpWorkOrder write fstmp_EmpWorkOrder;
    Property tmp_SimpeWorkOrder :String read fstmp_SimpeWorkOrder write fstmp_SimpeWorkOrder;
    Property CallingFormname :String read fsCallingFormname write fsCallingFormname;
    Property OnSelection : TNotifyEvent read fOnSelection write fOnSelection;
    Property datefrom :TdateTime read fddatefrom  write fddatefrom ;
    Property dateTo :Tdatetime read fddateTo write fddateTo;
    Property ProcessPartIDs:String read fsProcessPartIDs write fsProcessPartIDs;
  end;


implementation

uses CommonLib, LogLib, tcDataUtils, TemplateReportsLib;

{$R *.dfm}
{ TfmPrintWorkOrders }


procedure TfmPrintWorkOrders.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmPrintWorkOrders.btnPrintClick(Sender: TObject);
Var sSQL : string;
begin
  DisableForm;
  try
    if EmployeeIDs.count =0 then begin
      EmployeeIDs.Add(0);
      (*MessageDlgXP_Vista('Please Choose the Processes to Print', mtInformation, [mbOK], 0);
      Exit;*)
    end;
    if ProcessStepIDs.count =0 then begin
      ProcessStepIDs.Add(0);
      (*MessageDlgXP_Vista('Please Choose the Employees to Print', mtInformation, [mbOK], 0);
      Exit;*)
    end;
    fbReportSQLSupplied := true;
    if (ReportToPrint ='') or (chkChooseRpt.Checked) then TemplateReportName[chkChooseRpt.Checked , iif(tmp_SimpeWorkOrder = '' , ' and not(TemplName like ' + Quotedstr('%(Simple)%')+')' , '')];
    if ReportToPrint = '' then exit;

    sSQL := companyInfoSQL('' , dateFrom, dateTo);

         if POs('(Employee)' ,  ReportToPrint) >0 then sSQL := sSQL +'~|||~ {Details}Select * from '+ tmp_EmpWorkOrder +' where EmployeeId in (' + EmployeeIDs.commatext +') and ProcessStepId in ( ' + ProcessStepIDs.commatext +') ' +
                                                                     ' and ifnull(details,0)= 2  '+
                                                                     iif(fsProcessPartIDs <> ''  , ' and ProcessPartId in (' + fsProcessPartIDs +')' , '') +
                                                                     ' Order by EmployeeName , TimeStart, SaleId, SaleLineId, Level , ProctreeId , ProcessPartId , Builddate  ,Resource , Resourcedetails ,  details'
    else if POs('(Summary)' ,  ReportToPrint) >0 then sSQL := sSQL + '~|||~ {Details}Select * from '+ tmp_EmpWorkOrder +'  where ProcessStepId in ( ' + ProcessStepIDs.commatext +') ' +
                                                                     ' and ifnull(details,0)= 1  '+
                                                                     iif(fsProcessPartIDs <> ''  , ' and ProcessPartId in (' + fsProcessPartIDs +') ' , ' ') +
                                                                      ' Order by SaleId, SaleLineId, Level , ProctreeId , ProcessPartId , Builddate  ,Resource , Resourcedetails ,  details'
    else if POs('(Simple)' ,  ReportToPrint) >0 then sSQL := sSQL + '~|||~ {Details}Select * from '+ tmp_SimpeWorkOrder +
                                                                       iif(fsProcessPartIDs <> ''  , ' Where  PPID in (' + fsProcessPartIDs +') ' , ' ') ;

    PrintTemplateReport(ReportToPrint, sSQL, false, 1);
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.TemplateName'].asString := ReportToPrint;
    fbReportSQLSupplied := false;
    Self.Close;
  finally
    EnableForm;
  end;

end;

procedure TfmPrintWorkOrders.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  WriteExtraguiprefs;
  inherited;
  lstProcesses.CheckAll(cbUnChecked); lstProcessesClick (lstProcesses);
  lstEmployees.CheckAll(cbUnChecked); lstEmployeesclick(lstEmployees);
  Action := CaFree;
end;

procedure TfmPrintWorkOrders.FormCreate(Sender: TObject);
begin
  inherited;
  lblReportName.caption := '';
  fOnSelection := nil;
  fProcessStepIDs:= TIntegerList.Create;
  fEmployeeIDs:= TIntegerList.Create;
  fsCallingFormname :=Owner.classname;
  fsProcessPartIDs := '';
end;

procedure TfmPrintWorkOrders.FormDestroy(Sender: TObject);
begin
  Freeandnil(fProcessStepIDs);
  Freeandnil(fEmployeeIDs);
  inherited;
end;

procedure TfmPrintWorkOrders.FormShow(Sender: TObject);
begin
  inherited;
  ReadExtraguiprefs;
  lstProcesses.Items.Clear;
  lstEmployees.Items.Clear;


    closedb(QryProcesses);
    QryProcesses.SQL.text := 'select Distinct ProcessStepID, ProcessStep  ' +
                    ' from ' + tmp_EmpWorkOrder +' where ifnull(ProcessStep,"")<> ""  ' +
                    ' order by ProcessStep ';
    logtext(QryProcesses.SQL.text);
    OpenDB(QryProcesses);

    QryProcesses.first;
    while QryProcesses.Eof = False do begin
      lstProcesses.Items.AddObject(QryProcessesProcessStep.AsString, TObject(QryProcessesProcessStepID.AsInteger));
      QryProcesses.Next;
    end;
    lstProcesses.CheckAll(cbChecked);

    closedb(Qryemployees);
    Qryemployees.SQL.text := 'Select distinct EmployeeID,  EmployeeName  from  ' + tmp_EmpWorkOrder +' where ifnull(Employeename,"")<>""  order by EmployeeName';
    Qryemployees.open;
    Qryemployees.first;
    while Qryemployees.Eof = False do begin
      lstEmployees.Items.AddObject(QryemployeesEmployeeName.AsString, TObject(QryemployeesEmployeeID.asInteger));
      Qryemployees.Next;
    end;
    lstEmployees.CheckAll(cbChecked);

  if lblReportName.caption = '' then lblReportName.caption := TemplateReportName[False , ''];
  OnSelect(lstProcesses ,  fProcessStepIDs) ;
  OnSelect(lstEmployees ,  fEmployeeIDs) ;
end;

function TfmPrintWorkOrders.GetReportTypeID: integer;
begin
  //REsult := tcdatautils.TemplateTypeID(  iif(chkIncludeAllocation.checked ,'Production Work Sheet with allocation' ,'BOM Work Order'));
  REsult := tcdatautils.TemplateTypeID(  'BOM Work Order');
end;

procedure TfmPrintWorkOrders.OnSelect(CheckList :TCheckListBox; IntList :TIntegerList);
var
  x:Integer;
begin
   IntList.Clear;
   for x:= 0 to CheckList.Count -1 do begin
        if CheckList.Checked[x] then
          IntList.Add(Integer(CheckList.Items.Objects[x]));
   end;
end;

procedure TfmPrintWorkOrders.lblEmployeeSelectAllClick  (Sender: TObject);begin  inherited;  lstEmployees.CheckAll(cbChecked  ); lstEmployeesclick(lstEmployees );end;
procedure TfmPrintWorkOrders.lblEmployeeUnSelectAllClick(Sender: TObject);begin  inherited;  lstEmployees.CheckAll(cbUnChecked); lstEmployeesclick(lstEmployees );end;
procedure TfmPrintWorkOrders.lblProcessSelectAllClick   (Sender: TObject);begin  inherited;  lstProcesses.CheckAll(cbChecked  ); lstProcessesClick (lstProcesses);end;
procedure TfmPrintWorkOrders.lblProcessunSelectAllClick (Sender: TObject);begin  inherited;  lstProcesses.CheckAll(cbUnChecked); lstProcessesClick (lstProcesses);end;

procedure TfmPrintWorkOrders.lstEmployeesClick(Sender: TObject);
begin
  inherited;
  OnSelect(lstEmployees ,  fEmployeeIDs) ;
  if Assigned(fOnSelection) then    fOnSelection(Self);
end;

procedure TfmPrintWorkOrders.lstProcessesClick(Sender: TObject);
begin
  inherited;
  OnSelect(lstProcesses ,  fProcessStepIDs) ;
  if Assigned(fOnSelection) then    fOnSelection(Self);
end;

procedure TfmPrintWorkOrders.ReadExtraguiprefs;
var
  s:String;
begin
    if GuiPrefs.active =False then GuiPrefs.Active := True;
    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.ChooseTemplate')     then chkChooseRpt.checked         :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.ChooseTemplate'].asBoolean;
    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.IncludeAllocation')  then chkIncludeAllocation.checked :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludeAllocation'].asBoolean;
//    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.IncludewholeTree')   then chkIncludeallsubnode.checked :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludewholeTree'].asBoolean;
    if GuiPrefs.Node.Exists('Options.'+ fsCallingFormname +'.Previewreport')      then chkPreview.checked           :=  GuiPrefs.Node['Options.'+ fsCallingFormname +'.Previewreport'].asBoolean;
    s:=GuiPrefs.Node['Options.'+ fsCallingFormname +'.TemplateName'].asString;
    if s<> '' then begin
      ReportToPrint := s;
      lblReportName.caption :=s ;
    end;
end;

procedure TfmPrintWorkOrders.WriteExtraguiprefs;
begin
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.ChooseTemplate'].asBoolean   := chkChooseRpt.checked           ;
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludeAllocation'].asBoolean:= chkIncludeAllocation.checked   ;
//    GuiPrefs.Node['Options.'+ fsCallingFormname +'.IncludewholeTree'].asBoolean := chkIncludeallsubnode.checked   ;
    GuiPrefs.Node['Options.'+ fsCallingFormname +'.Previewreport'].asBoolean    := chkPreview.checked   ;

end;

initialization
  RegisterClassOnce(TfmPrintWorkOrders);

end.
