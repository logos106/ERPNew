unit frmProductFormulaEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, MemDS, DNMSpeedButton,
  StdCtrls, wwcheckbox, DNMPanel, Buttons, Wwdbigrd, Grids, BusobjProductFormula, Wwdbgrid,
  BusObjBase, Shader, ImgList, ProgressDialog;

type
  TfmProductFormulaEntry = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlFooter: TDNMPanel;
    Label4: TLabel;
    wwCheckBox1: TwwCheckBox;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    qryformulaEntry: TERPQuery;
    qryformulaEntryFormulaEntryID: TIntegerField;
    qryformulaEntryFormulaEntryNo: TIntegerField;
    qryformulaEntryFormulaEntryName: TWideStringField;
    qryformulaEntryActive: TWideStringField;
    qryformulaEntryIsQtyfield: TWideStringField;
    grdFormulaEntries: TwwDBGrid;
    dsformulaEntry: TDataSource;
    qryformulaEntryGlobalRef: TWideStringField;
    lblMSg: TLabel;
    Bevel41: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnVariableDelete: TwwIButton;
    DNMPanel1: TDNMPanel;
    lblcustomReport: TLabel;
    edtFeQtyFieldInfodisplayLabel: TEdit;
    lblQtyMsg: TLabel;
    Shape1: TShape;
    qryformulaEntrymsTimeStamp: TDateTimeField;
    qryformulaEntrymsUpdateSiteCode: TWideStringField;
    qryformulaEntryFieldOrderno: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdFormulaEntriesColEnter(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnVariableDeleteClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  Protected
    FormulaEntry : TFormulaEntry;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Function NewFormulaEntryObj : TFormulaEntry;Virtual;
    Procedure Openrec;virtual;
  public
    { Public declarations }
  end;


implementation

uses FastFuncs,CommonLib, BusobjSaleBase, BusObjFeTransLines, AppEnvironment,
  BusObjConst, tcConst, PreferancesLib;

{$R *.dfm}
function TfmProductFormulaEntry.NewFormulaEntryObj: TFormulaEntry;
begin
  result := TFormulaEntry.Create(Self);
end;

procedure TfmProductFormulaEntry.Openrec;
begin
  formulaEntry.Load;
end;

procedure TfmProductFormulaEntry.FormCreate(Sender: TObject);
begin
  FormulaEntry := NewFormulaEntryObj ;
  FormulaEntry.connection := TMydacDataConnection.Create(FormulaEntry);
  FormulaEntry.Connection.Connection := self.MyConnection;
  FormulaEntry.BusObjEvent := DoBusinessObjectEvent;
  inherited;
  //FormulaEntry.dataset := qryformulaEntry;
end;

procedure TfmProductFormulaEntry.btnCompletedClick(Sender: TObject);
begin
  inherited;

    if FormulaEntry.Save then begin
        FormulaEntry.Connection.CommitTransaction;
        Self.close;
    end;
end;

procedure TfmProductFormulaEntry.btnCloseClick(Sender: TObject);
begin
  inherited;
    Self.close;
end;

procedure TfmProductFormulaEntry.cmdNewClick(Sender: TObject);
begin
  inherited;
    if formulaEntry.Save then formulaEntry.New;
end;

procedure TfmProductFormulaEntry.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    openrec;
    openQueries;
    formulaEntry.Connection.BeginTransaction;
    SetControlFocus(grdFormulaEntries);
    with TFESalesLines.Create(Self) do try
        lblMSg.Caption := 'Maximum ' + IntToStr(FieldEntrycount) +' entries allowed.';
    Finally
        Free;
    end;
    edtFeQtyFieldInfodisplayLabel.text := Appenv.companyprefs.FeQtyFieldInfodisplayLabel;
    if edtFeQtyFieldInfodisplayLabel.text = '' then edtFeQtyFieldInfodisplayLabel.text := 'Qty';
    lblQtyMsg.caption :=  'The Qty Field and it''s Heading is Used to Populate the "Info" Column in the Sales Order BOM Tree, Using the Formula Field Values.'+NL+
                          'Please Note that Changing this, will NOT Update Existing Sales Orders';

      if not formulaEntry.LockInUse then begin
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.', mtWarning, [mbOK], 0);
      end;

  finally
    EnableForm;
  end;  
end;

procedure TfmProductFormulaEntry.FormDestroy(Sender: TObject);
begin
  freeandnil(formulaEntry);
  inherited;
end;

procedure TfmProductFormulaEntry.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    Action := caFree;
end;

procedure TfmProductFormulaEntry.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := false;
  if formulaEntry.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
            formulaEntry.Save;
            formulaEntry.Connection.CommitTransaction;
            CanClose := true;
        end;
      mrNo:
        begin
          formulaEntry.Connection.RollbackTransaction;
          formulaEntry.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;

end;

procedure TfmProductFormulaEntry.grdFormulaEntriesColEnter(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(grdFormulaEntries.GetActiveField.FieldName , 'FormulaEntryNo') then
        grdFormulaEntries.SetActiveField('FormulaentryName');
end;


procedure TfmProductFormulaEntry.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmProductFormulaEntry.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TFormulaEntry     then TFormulaEntry(Sender).Dataset      :=qryformulaEntry;
     end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusObjEventVal_OnAfterSave  ) then begin
      if edtFeQtyFieldInfodisplayLabel.text = '' then edtFeQtyFieldInfodisplayLabel.text := 'Qty';
      Appenv.companyprefs.FeQtyFieldInfodisplayLabel := edtFeQtyFieldInfodisplayLabel.text;
      PreferancesLib.DoPrefAuditTrail;
     end;

end;

procedure TfmProductFormulaEntry.btnVariableDeleteClick(Sender: TObject);
var
  sFormulaName,sFormulaField:string;
  function VariableUsedInFormula(sVariableName:string):Boolean;
  var
    qry,qryField:TERPQuery;
    sFormula,sFormulaFound:string;
    i:integer;
  begin
    Result := False;
    qryField := TERPQuery.Create(nil);
    try
      qryField.Connection := Self.MyConnection;
      qryField.SQL.Add('SELECT FormulaEntryName FROM tblfenames');
      qryField.Open;
      qryField.First;
      i := 1;    
      while not qryField.Eof do begin
        if sVariableName = qryField.FieldByName('FormulaEntryName').AsString then begin
          sFormulaField := 'Field' + IntToStr(i);
          break;
        end;
        i := i + 1;
        qryField.Next;
      end;
    finally
      FreeAndNil(qryField);
    end;

    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Self.MyConnection;
      qry.SQL.Add('Select * FROM tblfeformula');
      qry.Open;
      qry.First;
      while not qry.Eof do begin
        sFormula := qry.fieldByName('Formula').AsString;
        if Pos(sFormulaField,sFormula) > 0 then begin
          Result := True;
          sFormulaFound := sFormula;
          sFormulaName  := qry.fieldByName('FormulaName').AsString;
          exit;
        end;
        qry.Next;
      end;
    finally
      FreeandNil(qry);
    end;
  end;

begin  //delete
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this variable?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not VariableUsedInFormula(FormulaEntry.formulaEntryName) then begin
        FormulaEntry.formulaEntryName := sFormulaField;
        FormulaEntry.FormulaEntryActive := False;
      end else
        CommonLib.MessageDlgXP_Vista('This Entry Name is used by the formula ' + sFormulaName +
        '. The formula will have to be modified before you can delete this Entry Name.',mtInformation,[mbOK], 0);
    except

    end;
  end;
end;


initialization
  RegisterClassOnce(TfmProductFormulaEntry);
finalization
  UnRegisterClass(TfmProductFormulaEntry);

end.
