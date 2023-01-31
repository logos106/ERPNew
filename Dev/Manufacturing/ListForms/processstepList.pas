
unit processstepList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwradiogroup, wwclearbuttongroup;

type
  TprocessstepListGUI = class(TBaseListingGUI)
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainDetails: TLargeintField;
    qryMainID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainEmployeeId: TIntegerField;
    qryMainEmpProcessStepsID: TIntegerField;
    QryProcessStep: TERPQuery;
    QryEmpProcessStep: TERPQuery;
    btnDetails: TDNMSpeedButton;
    QryUsedPS: TERPQuery;
    dsUsedPS: TDataSource;
    pnlUsedPS: TdnmPanel;
    wwDBGrid1: TwwDBGrid;
    wwIButton1: TwwIButton;
    QryUsedPSCaption: TWideStringField;
    QryUsedPSemployeeName: TWideStringField;
    QryUsedPSDescription: TWideStringField;
    QryUsedPSTimeStart: TDateTimeField;
    QryUsedPSDuration: TWideMemoField;
    Label2: TLabel;
    QryUsedPSsaleId: TIntegerField;
    QryUsedPSmasterId: TIntegerField;
    QryUsedPSActive: TWideStringField;
    Label4: TLabel;
    grpExtraFilters: TwwRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
  private
    function ProcesSNotUsed(const PsID: Integer): Boolean;
    function EmpProcesSNotUsed(const PsID, EmpId:Integer):Boolean;
    procedure initProcessStepsInBOMList(Sender: TObject);
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public

  end;


implementation

uses CommonLib, frmProcessStep, CommonDbLib, SharedObjs, LogLib, tcConst,
  CommonFormLib, ProcessStepsinBOMList;

{$R *.dfm}
{ TprocessstepListGUI }

procedure TprocessstepListGUI.btnDetailsClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProcessStepsInBOMListGUI', initProcessStepsInBOMList );
end;
procedure TprocessstepListGUI.initProcessStepsInBOMList(Sender: TObject);
begin
  if Sender is TProcessStepsInBOMListGUI then begin
    TProcessStepsInBOMListGUI(Sender).PSID := QrymainID.asInteger;
  end;
end;
procedure TprocessstepListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := FindExistingComponent('TfmProcessStep',0);
    if Assigned(Form) then
      TForm(Form).BringToFront
    else begin
      Form := GetComponentByClassName('TfmProcessStep');
      if Assigned(Form) then begin
        with TfmProcessStep(Form) do begin
          AttachObserver(Self);
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TprocessstepListGUI.DNMSpeedButton1Click(Sender: TObject);
var
  i :Integer;
begin
  inherited;
  Closedb(QryUsedPS);
  try
    QryUsedPS.Sql.clear;
      if SelectedRecords  =0 then begin
        MessageDlgXP_Vista('Please Choose the Process Steps to be Deleted', mtWarning, [mbOK], 0);
        Exit;
      end;

      if grpFilters.itemIndex = 0 then
        if MessageDlgXP_vista('Please Note that the Process Step can be deleted only if there is no ''Employee'' Assigned to it.'+NL+NL+
                            'Select ''Details'' Option to Get the List with Employees, so You Can Delete.'+NL+NL+NL+
                            'Do you wish to continue with the current Selection?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

      ScriptMain.SQL.Clear;
        ScriptMain.SQL.Add(ERPFixtableSQL('tblempresprocschedule'    , 'Del_PS'));
        ScriptMain.SQL.Add(ERPFixtableSQL('tblemployeeprocesssteps' , 'Del_PS'));
        ScriptMain.SQL.Add(ERPFixtableSQL('tblProcResourceProcess'  , 'Del_PS'));
        ScriptMain.SQL.Add(ERPFixtableSQL('tblProcessStep'          , 'Del_PS'));
        i := ScriptMain.SQL.Count;

        IterateProcNo := 1;
        IterateselectedRecords(True);

        IterateProcNo := 2;
        IterateselectedRecords(True);
        if ScriptMain.SQL.Count >i then begin
          clog(ScriptMain.SQL.Text);
          DoShowProgressbar(ScriptMain.SQL.Count, WAITMSG);
          try
            ScriptMain.Execute;
          finally
            DoHideProgressbar;
          end;
          RefreshQuery;
        end;

  finally
    if QryUsedPS.SQl.count =0 then QryUsedPS.SQl.add(' Order by description, employeeName Limit 0')
    else QryUsedPS.SQl.add(' Order by description, employeeName ');

    QryUsedPS.SQl.TExt := 'select distinct sl.saleId , PT.masterId,'+
                          ' convert(concat(if(PT.mastertype ="mtProduct" , "Product # " , "Sale #"),  '+
                                  ' if(PT.mastertype ="mtProduct" , "" , SL.saleId),  '+
                                  ' ":" , RPT.caption, "." , PT.caption ) , char(255)) as Caption  , '+
                          ' E.employeeName ,  '+
                          ' PS.Description,   '+
                          ' PST.TimeStart ,  '+
                          ' FormatSecondsTotime(PST.Duration) Duration , PS.Active' +
                          ' from  tblProctree PT Left join  tblProctree RPT on PT.TreeRootId = RPT.proctreeid ' +
                          ' left join tblsaleslines sl on sl.salelineId = PT.masterId ' +
                          ' left join tblprocesspart PP  on PT.proctreeId = PP.proctreeId ' +
                          ' left join tblprocesstime PST on PP.ID = PST.ProcessPartId ' +
                          ' left join tblEmployees E on E.EmployeeId = PST.EmployeeId ' +
                          ' left join tblprocessstep PS on PS.ID = PP.ProcessStepID ' +
                            QryUsedPS.SQl.TExt;

    logtext(QryUsedPS.SQl.TExt);
    Opendb(QryUsedPS);
    pnlUsedPS.visible := QryUsedPS.recordcount >0;
  end;
end;
Function TprocessstepListGUI.ProcesSNotUsed(const PsID:Integer):Boolean;
begin
  if (QryProcessStep.active =False) or (QryProcessStep.Parambyname('PSID').asInteger <> PSID) then begin
    CloseDB(QryProcessStep);
    QryProcessStep.Parambyname('PSID').asInteger :=  PSID;
    OpenDB(QryProcessStep);
  end;
  Result := QryProcessStep.RecordCount=0;
  if not(result) then begin
    if QryUsedPS.SQL.count =0 then QryUsedPS.SQL.add('where ' ) else QryUsedPS.SQL.add(' Or ');
    QryUsedPS.SQL.add('(PP.ProcessStepID = '+inttostr(PSID) +')');
  end;

end;

Function TprocessstepListGUI.EmpProcesSNotUsed(const PsID, EmpId:Integer):Boolean;
begin
  if (QryEmpProcessStep.active =False) or (QryEmpProcessStep.Parambyname('PSID').asInteger <> PSID)  or (QryEmpProcessStep.Parambyname('EmpId').asInteger <> EmpId) then begin
    CloseDB(QryEmpProcessStep);
    QryEmpProcessStep.Parambyname('PSID').asInteger :=  PSID;
    QryEmpProcessStep.Parambyname('EmpId').asInteger :=  EmpId;
    OpenDB(QryEmpProcessStep);
  end;
  Result := QryEmpProcessStep.RecordCount=0;
  if not(result) then begin
    if QryUsedPS.SQL.count =0 then QryUsedPS.SQL.add('where ' ) else QryUsedPS.SQL.add(' Or ');
    QryUsedPS.SQL.add('(PP.ProcessStepID = '+inttostr(PSID) +' and PST.EmployeeId= '+inttostr(EmpId)+')');
  end;
end;
procedure TprocessstepListGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);
begin
  inherited;
  if IterateProcNo  = 1 then begin
    if qryMainID.AsInteger <> 0 then begin
      if EmpProcesSNotUsed(qryMainID.AsInteger , qryMainEmployeeID.AsInteger) then begin
        ScriptMain.SQL.Add('Delete from tblempresprocschedule where EmployeeId = ' +inttostr(QrymainEmployeeId.AsInteger)+' and ProcessStepId = ' + inttostr(qryMainID.AsInteger)+';');
        ScriptMain.SQL.Add('Delete from tblemployeeprocesssteps where EmployeeId = ' +inttostr(QrymainEmployeeId.AsInteger)+' and ProcessStepId = ' + inttostr(qryMainID.AsInteger)+';');
      end else begin
        ScriptMain.SQL.Add('update tblemployeeprocesssteps Set ACtive ="F" where EmployeeId = ' +inttostr(QrymainEmployeeId.AsInteger)+' and ProcessStepId = ' + inttostr(qryMainID.AsInteger)+';');
      end;
    end;
  end else if IterateProcNo  = 2 then begin
    if ProcesSNotUsed(qryMainID.AsInteger) then begin
      ScriptMain.SQL.Add('Delete from tblProcResourceProcess where ProcessStepId = ' + inttostr(qryMainID.AsInteger)+';');
      ScriptMain.SQL.Add('Delete from tblProcessStep where Id = ' + inttostr(qryMainID.AsInteger)+' and Id not in (Select ProcessStepID from tblemployeeprocesssteps);');
    end else begin
      ScriptMain.SQL.Add('update tblProcessStep set Active ="F" where Id = ' + inttostr(qryMainID.AsInteger)+';');
      ScriptMain.SQL.Add('update tblemployeeprocesssteps Set ACtive ="F" where ProcessStepId = ' + inttostr(qryMainID.AsInteger)+';');
    end;
  end;
end;

procedure TprocessstepListGUI.Label2DblClick(Sender: TObject);
begin
  inherited;
  setcontrolfocus(grdmain);
  pnlUsedPS.visible := False;
end;

procedure TprocessstepListGUI.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TprocessstepListGUI.grpFiltersClick(Sender: TObject);
var
  s1,s2:String;
begin
  InitGroupfilterString(qryMainDetails.fieldname  , ['1','2'], True , grpFilters);
  s1:= groupfilterString;
  InitGroupfilterString(qryMainactive.fieldname  , ['T','F'], False , grpExtraFilters);
  s2:= groupfilterString;
  if (s1<>'') and (s2<> '') then groupfilterString := '('+s1+') and (' + s2 +')'
  else if (s1<>'')  then groupfilterString := s1
  else if (s2<>'')  then groupfilterString := s2
  else groupfilterString := '';

  inherited;
  if Grpfilters.Itemindex =0 then RemoveFieldfromGrid(qryMainEmployeeName.fieldname)
  else AddFieldtoGrid(qryMainEmployeeName.fieldname , 1);
end;


procedure TprocessstepListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  InitGroupfilterString(qryMainDetails.fieldname  , ['1','2'], True);
  grpFiltersClick(grpFilters);
end;

procedure TprocessstepListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainDetails.fieldname);
  RemoveFieldfromGrid(qryMainEmployeeId.fieldname);
  RemoveFieldfromGrid(qryMainEmpProcessStepsID.fieldname);
end;

procedure TprocessstepListGUI.wwDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if QryUsedPSsaleId.asInteger <> 0 then OpenERPForm('TSalesOrderGUI' , QryUsedPSsaleId.asInteger)
  else OpenERPForm('TfrmParts' , QryUsedPSmasterId.asInteger);
end;

initialization
  RegisterClassOnce(TprocessstepListGUI);

end.

