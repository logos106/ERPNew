unit frmProcTreeProcessStepEdit;
{ Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  13/06/07 1.00.01  DSP - Initial version.
  13.01.2012 - 9.1.6.0 - Binny - this form is not used any more
}
interface

{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, Shader, Grids, BaseGrid,
  AdvGrid, DNMSpeedButton, MemDS, BusObjProcess, MessageConst, ImgList, AdvObj,
  ProgressDialog, DNMPanel;

type
  TfmProcTreeProcessStepEdit = class(TBaseInputGUI)
    asgProcessSteps: TAdvStringGrid;
    lblSteps: TLabel;
    qryProcessSteps: TERPQuery;
    imgDelete: TImage;
    tmrFocus: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure asgProcessStepsGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure asgProcessStepsCellChanging(Sender: TObject; OldRow, OldCol,
      NewRow, NewCol: Integer; var Allow: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure asgProcessStepsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure asgProcessStepsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure asgProcessStepsCellValidate(Sender: TObject; ACol,
      ARow: Integer; var Value: String; var Valid: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmrFocusTimer(Sender: TObject);
    procedure asgProcessStepsGetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure asgProcessStepsComboChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: string);
    procedure asgProcessStepsCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure FormShow(Sender: TObject);
  private
    FModified: Boolean;
    FProcessTreeNode: TProcTreeNode;
    procedure SetProcessTreeNode(const Value: TProcTreeNode);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure SaveData;
    function Validate: Boolean;
    function NextSequenceNumber: Integer;
    procedure PopulateCombo(aProcessStepId: integer = 0);
    Procedure CheckforProcessSteps;
    function IsTemplate:Boolean;
  protected
    Function IsLocalPrefChanged: boolean; override;
  public
    property ProcessTreeNode: TProcTreeNode read FProcessTreeNode write SetProcessTreeNode;
  end;

implementation

uses
  FastFuncs, BusObjNDSBase, BusObjProcessPartNDS, CommonLib,
  BusObjBase, frmProcStepResourceWiz, ProcessUtils, CommonDbLib, ManufactureLib,
  BOMLib;


const
  cPSDescription = 1;
  cDuration =2 ;
  cSetupDuration = 3;
  cBreakupDuration = 4;
  cProcessStepSeq = 5;
  cExtraInfo = 6;
  cQtyPerCoupon = 7;
  cRatepercoupon =8;
  cMakeCoupns =9;
  cBuildingBlocks =10;
{$R *.dfm}

procedure TfmProcTreeProcessStepEdit.FormCreate(Sender: TObject);
begin
  inherited;
  GuiPrefs.Elements.Add('TAdvStringGridGuiElement', asgProcessSteps);

  FModified := False;
  FProcessTreeNode := nil;
  asgProcessSteps.AddBitmap(0, 0, imgDelete.Picture.Bitmap, True, haCenter, vaCenter);
end;

procedure TfmProcTreeProcessStepEdit.FormShow(Sender: TObject);
var
  x: integer;
begin
  inherited;
end;

function TfmProcTreeProcessStepEdit.IsLocalPrefChanged: boolean;
begin
  result := inherited;
end;

function TfmProcTreeProcessStepEdit.IsTemplate: Boolean;
begin
  Result := False;
  if not(Assigned(ProcessTreeNode)) then exit;
  Result := ProcessTreeNode.IsTemplate;
end;

procedure TfmProcTreeProcessStepEdit.asgProcessStepsGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  inherited;

  if ACol = cPSDescription then
    AEditor := edComboEdit
  else if Acol = cMakeCoupns then
    AEditor := edCheckBox
  else if ACol in [cDuration,cSetupDuration,cBreakupDuration] then
    AEditor:= edNormal;
end;


procedure TfmProcTreeProcessStepEdit.PerformStartup(var Msg: TMessage);
begin
  CheckforProcessSteps;
  qryProcessSteps.Connection := TransConnection;
  PopulateCombo;
  if IsTemplate then begin
    asgProcessSteps.ColWidths[cMakeCoupns] :=0;
    Self.Width :=  902;
  end else begin
    Self.Width :=  966;
  end;
end;

procedure TfmProcTreeProcessStepEdit.PopulateCombo(aProcessStepId: integer = 0);
begin
  asgProcessSteps.ComboBox.Items.Clear;
  qryProcessSteps.ParamByName('Id').AsInteger:= aProcessStepId;
  qryProcessSteps.Open;
  while not qryProcessSteps.Eof do begin
    asgProcessSteps.ComboBox.Items.Add(qryProcessSteps.FieldByName('Description').AsString);
    qryProcessSteps.Next;
  end;
  qryProcessSteps.Close;
end;


procedure TfmProcTreeProcessStepEdit.btnSaveClick(Sender: TObject);
begin
  inherited;

  if not Validate then
    Exit;

  SaveData;
  ModalResult := mrOK;
end;

procedure TfmProcTreeProcessStepEdit.CheckforProcessSteps;
begin
  MakeAssemblyProcess;
(*var
  Qry: TERPQuery;
  ProcessId,resourceID:Integer;
begin
  resourceID:= 0;


  Qry := TERPQuery.create(Self);
  try
    Qry.Connection := commondblib.GetNewMyDacConnection(Qry);
    Qry.Connection.StartTransaction;
    try
      if Qry.active then Qry.close;
      Qry.SQL.clear;
      Qry.SQL.add('Select * from tblprocessstep where Description = ' + Quotedstr('Assembly'));
      Qry.open;
      if Qry.recordcount =1 then begin
        if Qry.FieldByname('Active').asBoolean = False then begin
            Qry.Edit;
            Qry.FieldByname('Active').asBoolean := TRue;
            Qry.Post;
        end;
      end else begin
        Qry.Append;
        Qry.FieldByname('Description').asString := 'Assembly';
        Qry.FieldByname('Active').asBoolean := TRue;
        Qry.Post;
      end;
      ProcessId:= Qry.Fieldbyname('ID').asInteger;

      {check for Resource with process Assembly}
            if Qry.active then Qry.close;
            Qry.SQL.clear;
            Qry.SQL.add('Select * from tblprocresourceprocess where tblprocresourceprocess.ProcessStepId =  ' + inttostr(ProcessId));
            Qry.open;
            if Qry.recordcount >0 then begin
              resourceID := Qry.fieldByname('ProcresourceID').asInteger;
              if Qry.active then Qry.close;
                Qry.SQL.clear;
                Qry.SQL.add('Select * from tblProcResource where   ProcresourceID = ' + inttostr(resourceID));
                Qry.open;
                if Qry.recordcount >0 then begin
                  if Qry.FieldByname('Active').asBoolean = False then begin
                      Qry.Edit;
                      Qry.FieldByname('Active').asBoolean := TRue;
                      Qry.Post;
                  end;
                  Exit;
                end;
            end;
      {if resource with process Assembly doesn't exists  - check for resource Assembly and make if missing}
            if resourceID =0 then begin
              if Qry.active then Qry.close;
              Qry.SQL.clear;
              Qry.SQL.add('Select * from tblProcResource where   Description = ' + Quotedstr('Assembly'));
              Qry.open;
              if Qry.recordcount >0 then begin
                if Qry.FieldByname('Active').asBoolean = False then begin
                    Qry.Edit;
                    Qry.FieldByname('Active').asBoolean := TRue;
                    Qry.Post;
                end;
              end else begin
                Qry.Append;
                Qry.FieldByname('Description').asString := 'Assembly';
                Qry.FieldByname('ResourceName').asString := 'Assembly';
                Qry.FieldByname('Active').asBoolean := TRue;
                Qry.FieldByname('ResourceAvailable').asBoolean := TRue;
                Qry.FieldByname('HourlyLabourRate').asFloat := 30;
                Qry.Post;
              end;
              resourceID:= Qry.Fieldbyname('ProcResourceID').asInteger;
            end;

      if Qry.active then Qry.close;
      Qry.SQL.clear;
      Qry.SQL.Add('Select * from tblprocresourcedays where ProcResourceID = ' + inttostr(resourceID));
      Qry.open;
      if Qry.recordcount =0 then begin
        Qry.Append;
        Qry.Fieldbyname('ProcResourceID').asInteger :=resourceID;
        Qry.Fieldbyname('Sunday').asBoolean    := not IsWeekendday(7);
        Qry.Fieldbyname('Monday').asBoolean    := not IsWeekendday(1);
        Qry.Fieldbyname('Tuesday').asBoolean   := not IsWeekendday(2);
        Qry.Fieldbyname('Wednesday').asBoolean := not IsWeekendday(3);
        Qry.Fieldbyname('Thursday').asBoolean  := not IsWeekendday(4);
        Qry.Fieldbyname('Friday').asBoolean    := not IsWeekendday(5);
        Qry.Fieldbyname('Saturday').asBoolean  := not IsWeekendday(6);
        if Qry.Fieldbyname('Sunday').asBoolean    then Qry.Fieldbyname('SundayCapacityHoursDay').asFloat    := 8*60*60;
        if Qry.Fieldbyname('Monday').asBoolean    then Qry.Fieldbyname('MondayCapacityHoursDay').asFloat    := 8*60*60;
        if Qry.Fieldbyname('Tuesday').asBoolean   then Qry.Fieldbyname('TuesdayCapacityHoursDay').asFloat   := 8*60*60;
        if Qry.Fieldbyname('wednesday').asBoolean then Qry.Fieldbyname('WednesdayCapacityHoursDay').asFloat := 8*60*60;
        if Qry.Fieldbyname('Thursday').asBoolean  then Qry.Fieldbyname('ThursdayCapacityHoursDay').asFloat  := 8*60*60;
        if Qry.Fieldbyname('Friday').asBoolean    then Qry.Fieldbyname('FridayCapacityHoursDay').asFloat    := 8*60*60;
        if Qry.Fieldbyname('Saturday').asBoolean  then Qry.Fieldbyname('SauturdayCapacityHoursDay').asFloat := 8*60*60;
        Qry.Post;
      end;

      if Qry.active then Qry.close;
      Qry.SQL.clear;
      Qry.SQL.add('Select * from tblProcResourceProcess '+
                  ' Where /*ProcResourceId = ' + inttostr(resourceID) +
                  '   and */ ProcessStepId = ' +inttostr(ProcessId));
      Qry.open;

      if Qry.recordcount >0 then begin
      end else begin
        Qry.Append;
        Qry.FieldByname('ProcResourceId').asInteger := resourceID;
        Qry.FieldByname('ProcessStepId').asInteger := ProcessId;
        Qry.Post;
      end;
      Qry.Connection.Commit;
    Except
      on E:Exception do begin
        Qry.Connection.Rollback;
      end;
    end;
  finally
    if Qry.active then Qry.close;
    Freeandnil(Qry);
  end;*)

end;

procedure TfmProcTreeProcessStepEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmProcTreeProcessStepEdit.SetProcessTreeNode(const Value: TProcTreeNode);
var
  Index: Integer;
begin
  if Value <> FProcessTreeNode then begin
    FProcessTreeNode := Value;

    if Assigned(FProcessTreeNode) then begin
      for Index := 0 to FProcessTreeNode.ProcessStepList.Count - 1 do begin
        asgProcessSteps.Objects[cPSDescription  , Index + 1] := TObject(FProcessTreeNode.ProcessStepList.Item[Index].ProcessStep.Id);
        asgProcessSteps.Objects[cDuration       , Index + 1] := TObject(FProcessTreeNode.ProcessStepList[Index].ID);
        asgProcessSteps.Cells[cPSDescription    , Index + 1] := FProcessTreeNode.ProcessStepList.Item[Index].ProcessStepDescription;
        asgProcessSteps.Cells[cDuration         , Index + 1] := ProcTimeToStr(FProcessTreeNode.ProcessStepList.Item[Index].Duration);
        asgProcessSteps.Cells[cSetupDuration    , Index + 1] := ProcTimeToStr(FProcessTreeNode.ProcessStepList.Item[Index].SetupDuration);
        asgProcessSteps.Cells[cBreakupDuration  , Index + 1] := ProcTimeToStr(FProcessTreeNode.ProcessStepList.Item[Index].BreakdownDuration);
        asgProcessSteps.Cells[cProcessStepSeq   , Index + 1] := IntToStr(FProcessTreeNode.ProcessStepList.Item[Index].ProcessStepSeq);
        asgProcessSteps.Cells[cExtraInfo        , Index + 1] := FProcessTreeNode.ProcessStepList.Item[Index].ProcessStepExtraInfo;
        asgProcessSteps.Cells[cQtyPerCoupon     , Index + 1] := FloatToStrF(FProcessTreeNode.ProcessStepList.Item[Index].QtyPerCoupon , ffGeneral, 15,2);
        asgProcessSteps.Cells[cRatePErcoupon    , Index + 1] := FloatToStrF(FProcessTreeNode.ProcessStepList.Item[Index].RatePerCoupon, ffGeneral, 15,2);
        asgProcessSteps.SetCheckBoxState(cMakeCoupns   , Index + 1,FProcessTreeNode.ProcessStepList.Item[Index].MakeCoupons);
        asgProcessSteps.Cells[cBuildingBlocks   , Index + 1] := FloatToStrF(FProcessTreeNode.ProcessStepList.Item[Index].BuildingBlockQty, ffGeneral, 15,2);
        asgProcessSteps.AddRow;
      end;

      if asgProcessSteps.RowCount > 2 then
        asgProcessSteps.RowCount := asgProcessSteps.RowCount - 1;
    end;

    FModified := False;
  end;
end;

procedure TfmProcTreeProcessStepEdit.asgProcessStepsCellChanging(Sender: TObject;
  OldRow, OldCol, NewRow, NewCol: Integer; var Allow: Boolean);
var
  CellText: string;
//  ProcStep: TProcessStep;
begin
  inherited;
  Allow := true;

  if (OldCol = cPSDescription) and (OldRow < asgProcessSteps.RowCount) then begin
    CellText := asgProcessSteps.Cells[OldCol, OldRow];

    if (Trim(CellText) <> '') and (asgProcessSteps.Combobox.Items.IndexOf(CellText) = -1) then begin

      if CommonLib.MessageDlgXP_Vista('This item is not in the list. Add new item?', mtInformation, [mbYes, mbNo], 0) = mrYes then begin
        if AddProcessStep(CellText) > 0 then begin
          Allow:= true;
        end
        else begin
          Allow:= false;
          asgProcessSteps.Cells[OldCol, OldRow]:= '';
        end;
      end
      else begin
        Allow:= false;
      end;
    end;
  end;
  if NewRow <> OldRow then begin
    PopulateCombo(Integer(asgProcessSteps.Objects[cPSDescription, NewRow]));
  end;
  if asgProcessSteps.Cells[cProcessStepSeq,asgProcessSteps.Row] = '' then
    asgProcessSteps.Ints[5, asgProcessSteps.Row] := NextSequenceNumber;
end;

procedure TfmProcTreeProcessStepEdit.asgProcessStepsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ARow: Integer;
  ACol: Integer;
  Index:Integer;

begin
  inherited;
  asgProcessSteps.MouseToCell(X, Y, ACol, ARow);

  if (ACol = 0) and (ARow = 0) then begin
   {deleting the process}
    if asgProcessSteps.RowCount > 2 then begin
      asgProcessSteps.RemoveRows(asgProcessSteps.Row, 1);
    end
    else begin
      asgProcessSteps.ClearRows(1, 1);
    end;
  end;
end;

procedure TfmProcTreeProcessStepEdit.asgProcessStepsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if asgProcessSteps.Row = (asgProcessSteps.RowCount - 1) then begin
    if (Key = VK_DOWN) and (asgProcessSteps.Cells[cPSDescription,asgProcessSteps.Row] <> '') then begin
      if asgProcessSteps.Cells[cProcessStepSeq,asgProcessSteps.Row] = '' then
        asgProcessSteps.Ints[5, asgProcessSteps.Row] := NextSequenceNumber;
      asgProcessSteps.AddRow;
      asgProcessSteps.Row := asgProcessSteps.Row + 1;
      asgProcessSteps.Ints[5, asgProcessSteps.Row] := NextSequenceNumber;
    end
    else if (Key = VK_TAB) and
            (asgProcessSteps.Col = (asgProcessSteps.ColCount - 1)) and
            (asgProcessSteps.Cells[cPSDescription,asgProcessSteps.Row] <> '') then begin
      if asgProcessSteps.Cells[cProcessStepSeq,asgProcessSteps.Row] = '' then
        asgProcessSteps.Ints[5, asgProcessSteps.Row] := NextSequenceNumber;
      asgProcessSteps.AddRow;
      asgProcessSteps.Row := asgProcessSteps.Row + 1;
      asgProcessSteps.Ints[5, asgProcessSteps.Row] := NextSequenceNumber;
      asgProcessSteps.Col := cPSDescription;
      Key := 0;
    end;
  end;

  if Key = VK_DOWN then
    tmrFocus.Enabled := True;
end;

procedure TfmProcTreeProcessStepEdit.SaveData;
var
  i,Index: Integer;
  PartData: TProcessPartNDS;
  found:Boolean;
begin

  (*Only delete the process step if the process changed or deleted , otherwise it looses the schedule if already scheduled
  FProcessTreeNode.ProcessStepList.Clear(True);*)

  //clog('');
  for i := FProcessTreeNode.ProcessStepList.count-1 downto 0 do begin
    Found:= False;
    for Index := 1 to asgProcessSteps.RowCount - 1 do begin
      if (FProcessTreeNode.ProcessStepList.Item[i].processstep.id  = integer(TObject(asgProcessSteps.Objects[cPSDescription, index]))) and
         (FProcessTreeNode.ProcessStepList[i].ID =integer(TObject(asgProcessSteps.Objects[cDuration, index]))) and
         (FProcessTreeNode.ProcessStepList[i].ID <>0) then begin
          Found := True;
          //logtext('Found for ID : ' + asgProcessSteps.Cells[cPSDescription, Index] + ',' + asgProcessSteps.Cells[cProcessStepSeq, Index]);
          break;
      end;
      if (FProcessTreeNode.ProcessStepList.Item[i].processstep.id  = integer(TObject(asgProcessSteps.Objects[cPSDescription, index]))) and
         (FProcessTreeNode.ProcessStepList[i].ID =integer(TObject(asgProcessSteps.Objects[cDuration, index]))) and
         (FProcessTreeNode.ProcessStepList[i].ProcessStepSeq = StrToIntDef(asgProcessSteps.Cells[cProcessStepSeq, Index], 0)) and
         (FProcessTreeNode.ProcessStepList[i].ID =0) then begin
         //logtext('Found for Seq : ' + asgProcessSteps.Cells[cPSDescription, Index] + ',' + asgProcessSteps.Cells[cProcessStepSeq, Index]);
          Found := True;
          break;
      end;

    end;
    if not (Found) then begin
      //logtext('Not Found - so deleting: ' + FProcessTreeNode.ProcessStepList[i].ProcessStepDescription+',' + inttostr(FProcessTreeNode.ProcessStepList[i].ProcessStepSeq));
      FProcessTreeNode.ProcessStepList.Clear(True , i);
    end;
  end;

  PartData :=nil;
  for Index := 1 to asgProcessSteps.RowCount - 1 do begin
    if Trim(asgProcessSteps.Cells[cPSDescription, Index]) <> '' then begin
      Found:= False;
      for i :=  0 to FProcessTreeNode.ProcessStepList.count-1 do begin
        {looking for the processs tep with ID}
        if (FProcessTreeNode.ProcessStepList.Item[i].processstep.id  = integer(TObject(asgProcessSteps.Objects[cPSDescription, index]))) and
           (FProcessTreeNode.ProcessStepList[i].ID =integer(TObject(asgProcessSteps.Objects[cDuration, index]))) and
           (FProcessTreeNode.ProcessStepList[i].ID <>0) and
           (FProcessTreeNode.ProcessStepList.Item[i].processstep.id  <> 0)  then begin
            PartData :=FProcessTreeNode.ProcessStepList.Item[i];
            //logtext('Found for ID : ' + asgProcessSteps.Cells[cPSDescription, Index] + ',' + asgProcessSteps.Cells[cProcessStepSeq, Index]);
            found := True;
            break;
        end;
        {for new process steps, when Id = 0, looking for the processs tep with seqno}
        if (FProcessTreeNode.ProcessStepList.Item[i].processstep.id  = integer(TObject(asgProcessSteps.Objects[cPSDescription, index]))) and
           (FProcessTreeNode.ProcessStepList[i].ID =integer(TObject(asgProcessSteps.Objects[cDuration, index]))) and
           (FProcessTreeNode.ProcessStepList[i].ID =0) and
           ( FProcessTreeNode.ProcessStepList[i].ProcessStepSeq = StrToIntDef(asgProcessSteps.Cells[cProcessStepSeq, Index], 0)) and
           (FProcessTreeNode.ProcessStepList.Item[i].processstep.id  <> 0)  then begin
            PartData :=FProcessTreeNode.ProcessStepList.Item[i];
            //logtext('Found for Seq : ' + asgProcessSteps.Cells[cPSDescription, Index] + ',' + asgProcessSteps.Cells[cProcessStepSeq, Index]);
            found := True;
            break;
        end;

      end;
      if not(Found) then begin
        //logtext('Not Found - so adding: ' + asgProcessSteps.Cells[cPSDescription, Index]+',' + asgProcessSteps.Cells[cProcessStepSeq, Index]);
        PartData := TProcessPartNDS.Create(nil);
        FProcessTreeNode.ProcessStepList.Add(PartData);
        PartData.ProcessStepDescription := asgProcessSteps.Cells[cPSDescription, Index];
      end;
      PartData.Duration             := StrToProcTime(asgProcessSteps.Cells[cDuration, Index]);
      PartData.SetupDuration        := StrToProcTime(asgProcessSteps.Cells[cSetupDuration, Index]);
      PartData.BreakdownDuration    := StrToProcTime(asgProcessSteps.Cells[cBreakupDuration, Index]);
      PartData.ProcessStepSeq       := StrToIntDef(asgProcessSteps.Cells[cProcessStepSeq, Index], 0);
      PartData.Processstepextrainfo := asgProcessSteps.Cells[cExtraInfo, Index];
      PartData.QtyPerCoupon         := strValue(asgProcessSteps.Cells[cQtyPerCoupon, Index]);
      PartData.RAtePercoupon        := strValue(asgProcessSteps.Cells[cRatePerCoupon, Index]);
      PartData.BuildingBlockQty     := strValue(asgProcessSteps.Cells[cBuildingBlocks, Index]);
      if not IsTemplate then PartData.MakeCoupons := asgProcessSteps.Cells[cMakecoupns, Index]='T';
      OpenDb(qryProcessSteps);
      if qryProcessSteps.Locate('description' ,PartData.ProcessStepDescription , []) then begin
        PartData.HourlyLabourRate   :=qryProcessSteps.fieldByname('HourlyLabourRate').AsFloat;
        PartData.HourlyOverheadRate :=qryProcessSteps.fieldByname('HourlyOverheadRate').AsFloat;
      end;
      CloseDB(qryProcessSteps);
    end;
  end;
end;

procedure TfmProcTreeProcessStepEdit.asgProcessStepsCellValidate(Sender: TObject;
  ACol, ARow: Integer; var Value: String; var Valid: Boolean);
begin
  inherited;
  FModified := True;
  if ACol in [cDuration,cSetupDuration,cBreakupDuration] then
    Value:= StringReplace(Value,' ','0',[rfReplaceAll]);
end;


procedure TfmProcTreeProcessStepEdit.asgProcessStepsCheckBoxClick(
  Sender: TObject; ACol, ARow: Integer; State: Boolean);
begin
  inherited;
  OpenDb(qryProcessSteps);
  if aCol = cMakeCoupns then begin
    asgProcessSteps.Cells[cMakecoupns, ARow] := BoolToStr(State);
  end;

end;

procedure TfmProcTreeProcessStepEdit.asgProcessStepsComboChange(Sender: TObject;
  ACol, ARow, AItemIndex: Integer; ASelection: string);
begin
  inherited;
  OpenDb(qryProcessSteps);
  if qryProcessSteps.Locate('description' ,asgProcessSteps.Combobox.text, []) then begin
    asgProcessSteps.Objects[cPSDescription, ARow] :=TObject(qryProcessSteps.FieldByName('ID').AsInteger);
    asgProcessSteps.Cells[cDuration, ARow] :=SecondsToTime(trunc(qryProcessSteps.FieldByName('DefaultDuration').asFloat));
  end;
  CloseDB(qryProcessSteps);
end;

procedure TfmProcTreeProcessStepEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Response: TModalResult;
begin
  inherited;

  if FModified and (ModalResult <> mrOK) then begin
    Response := CommonLib.MessageDlgXP_Vista('Save any changes made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);

    case Response of
      mrYes:
      begin
        SaveData;
        ModalResult := mrOK;
      end;

      mrNo:
      begin
        ModalResult := mrCancel;
      end;

      mrCancel:
      begin
        CanClose := False;
      end;
    end;
  end;
end;

function TfmProcTreeProcessStepEdit.Validate: boolean;
var
  x: integer;
begin
  Result:= True;

  if (asgProcessSteps.RowCount > 1) and (asgProcessSteps.Cells[cPSDescription, 1] <> '') then begin
    for x := 1 to asgProcessSteps.RowCount - 1 do begin
      if asgProcessSteps.Cells[cProcessStepSeq,x] = '' then begin
        Result := False;
        CommonLib.MessageDlgXP_Vista('Every step must have a sequence number', mtInformation, [mbOk], 0);
        Break;
      end;
      if asgProcessSteps.Cells[cBuildingBlocks,x] = '' then begin
        asgProcessSteps.Cells[cBuildingBlocks,x] :='1';
      end;
      if asgProcessSteps.Cells[cDuration,x] = '00:00:00' then begin
        Result := False;
        CommonLib.MessageDlgXP_Vista('Every step must have a duration', mtInformation, [mbOk], 0);
        Break;
      end;
      if asgProcessSteps.Cells[cPSDescription,x] = '' then begin
        Result := False;
        CommonLib.MessageDlgXP_Vista('Process Step cannot be blank', mtInformation, [mbOk], 0);
        Break;
      end;
    end;
  end;
end;

function TfmProcTreeProcessStepEdit.NextSequenceNumber: integer;
var
  x: integer;
begin
  Result:= 0;

  for x := 1 to asgProcessSteps.RowCount - 1 do begin
    if asgProcessSteps.Ints[5, x] > Result then
      Result:= asgProcessSteps.Ints[5, x];
  end;

  Result := Result + 10;
end;

procedure TfmProcTreeProcessStepEdit.tmrFocusTimer(Sender: TObject);
begin
  inherited;

  //
  // Done due to bug in TAdvStringGrid where a cell loses focus after the first
  // cell change using arrow keys.
  //
  tmrFocus.Enabled := False;
  SetControlFocus(asgProcessSteps);
end;

procedure TfmProcTreeProcessStepEdit.asgProcessStepsGetEditMask(
  Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
  inherited;
  if ACol in [cDuration,cSetupDuration,cBreakupDuration] then
    Value:= '!90:00:00;1;0';
end;

initialization
  RegisterClassOnce(TfmProcTreeProcessStepEdit);
finalization
  UnregisterClass(TfmProcTreeProcessStepEdit);
end.
