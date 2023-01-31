{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/09/05  1.00.00 BJ  Initial version.
 17/02/06  1.00.01 BJ  Open the budget form when Save the record
                        Default class should is selected by default for a new budget.
	}

unit frmBudgetDef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, wwcheckbox, Mask, wwdbedit, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, MemDS, Grids, Wwdbigrd, Wwdbgrid, Wwdotdot, Wwdbcomb,
  wwdbdatetimepicker, BusObjBudgetDef, Wwdbspin, wwdblook,
  Menus, AdvMenus, Shader, BusObjBase, ImgList, ProgressDialog;

type
  TfmBudgetDef = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel4: TDNMPanel;
    Label1: TLabel;
    edtName: TwwDBEdit;
    Label2: TLabel;
    edtDescription: TwwDBEdit;
    btnNew: TDNMSpeedButton;
    edtAmount1Label: TwwDBEdit;
    edtAmount2Label: TwwDBEdit;
    chkShowAmount1: TwwCheckBox;
    chkShowAmount2: TwwCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel113: TBevel;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    cboIntervalPeriod: TwwDBComboBox;
    chkActive: TwwCheckBox;
    Label3: TLabel;
    dtStartDate: TwwDBDateTimePicker;
    dtEndDate: TwwDBDateTimePicker;
    spnIntervalDuration: TwwDBSpinEdit;
    BudgetClass_Dataset: TERPQuery;
    ClassNameLookup: TERPQuery;
    ClassNameLookupClassID: TIntegerField;
    ClassNameLookupClassName: TWideStringField;
    BudgetClass_DatasetID: TIntegerField;
    BudgetClass_DatasetBudgetId: TIntegerField;
    BudgetClass_DatasetClassId: TIntegerField;
    BudgetClass_DatasetActive: TWideStringField;
    BudgetClass_DatasetmsTimeStamp: TDateTimeField;
    BudgetClass_DatasetClassname: TWideStringField;
    dsBudgetDef: TDataSource;
    dsBudgetClass: TDataSource;
    BudgetDef_Dataset: TERPQuery;
    BudgetDef_DatasetGlobalRef: TWideStringField;
    BudgetDef_DatasetBudgetID: TIntegerField;
    BudgetDef_DatasetName: TWideStringField;
    BudgetDef_DatasetDescription: TWideStringField;
    BudgetDef_DatasetAmount1Label: TWideStringField;
    BudgetDef_DatasetAmount2Label: TWideStringField;
    BudgetDef_DatasetShowAmount1: TWideStringField;
    BudgetDef_DatasetShowAmount2: TWideStringField;
    BudgetDef_DatasetStartDate: TDateTimeField;
    BudgetDef_DatasetEndDate: TDateTimeField;
    BudgetDef_DatasetIntervalPeriod: TSmallintField;
    BudgetDef_DatasetIntervalDuration: TSmallintField;
    BudgetDef_DatasetActive: TWideStringField;
    BudgetDef_DatasetEditedFlag: TWideStringField;
    BudgetDef_DatasetmsTimeStamp: TDateTimeField;
    Label13: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    grdBudgetClasses: TwwDBGrid;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure chkShowAmount2Click(Sender: TObject);
    procedure chkShowAmount1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BudgetClass_DatasetBeforePost(DataSet: TDataSet);
    procedure grdBudgetClassesRowChanged(Sender: TObject);
    procedure grdBudgetClassesEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    BudgetDef: TBusObjBudgetDef;
    fbSaveBtnClicked: boolean;
    ClassACtive :Boolean;
    function SaveBudget: boolean;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

var
  fmBudgetDef: TfmBudgetDef;

implementation

uses FormFactory, CommonLib, frmBudget, DNMExceptions, BusObjConst;



{$R *.dfm}

(*Procedure TfmBudgetDef.LoadHelpNotes;
begin
    inherited;
    AddHelp(Self.ClassName , 'Budget Definition' ,Self.Classname ,
            'The form defines Budget definitions. It is mandatory to give the BudgetName, '+
            'start date, Interval and the classes for the Budget.  ERP allows you to have '+
            '2 different budget amounts, the screen has an option to hide one of them if not '+
            'required.  It also allows you to have a customised label for the budget amount');
    AddHelp(edtName.Name , 'Name of the Budget' ,edtName.Name ,
            'This is the unique name which identifies the Budget definition.  The name of the '+
            'budget is a mnadatory field which cannot be blank');
    AddHelp(dtStartDate.Name , 'Budget Start Date' ,dtStartDate.Name ,
            'This is the date on which the budget starts - the period dates are calculated on '+
            'the basis of this date. Once if the budget periods are defined, the start date '+
            'becomes readonly' );
    AddHelp(dtEndDate.Name , 'Budget End Date' ,dtEndDate.Name ,
            'The end date of the budget is automatically calculated based on the start date, '+
            'periods and Interval. This is a readonly field' );
    AddHelp(spnIntervalDuration.Name , 'Budget Periods' ,spnIntervalDuration.Name ,
            'The Budget Periods indicates the number of small periods between the start date '+
            'and end date' );
    AddHelp(cboIntervalPeriod.Name , 'Budget Interval' ,cboIntervalPeriod.Name ,
            'This is the period interval, a fixed list is provided and alue can be selected '+
            'only from the list' );
    AddHelp(chkShowAmount1.Name , 'Amount Visible' ,chkShowAmount1.Name ,
            'It is possible to have 2 different budget amounts. If one is not required, unselect '+
            'the amount here. A valid budget definition needs one amount' );
    AddHelp(chkShowAmount2.Name , 'Amount Visible' ,chkShowAmount2.Name ,
            'It is possible to have 2 different budget amounts. If one is not required, unselect '+
            'the amount here. A valid budget definition needs one amount' );
    AddHelp(edtAmount1Label.Name , 'Description' ,edtAmount1Label.Name ,
            'The user defined caption for the budget amount.' );
    AddHelp(edtAmount2Label.Name , 'Description' ,edtAmount2Label.Name ,
            'The user defined caption for the budget amount.' );
    AddHelp(grdBudgetClasses.Name , 'Budget Classes' ,grdBudgetClasses.Name ,
            'This is the list of classes and select them by selecting the checkbox if the budget '+
            'is applicable for the class. By default the default class will be shown as selected. '+
            'The amounts can be only entered for the selected classes.' );
    AddHelp(btnSave.Name , 'Save Budget Definition' ,btnSave.Name ,
            'Saves the budget definition after validation and opens the budget amount screen.' );
    AddHelp(btnNew.Name , 'New Budget Definition' ,btnSave.Name ,
            'Saves the budget definition after validation and opens a new blank budget definition record' );
    AddHelp(btnCancel.Name , 'Cancel Budget Definition' ,btnCancel.Name ,
            'Cancels the changes in the current record and closes the form. If the record was new and not saved, the record will be deleted' );
    AddHelp(chkActive.Name , 'Budget Active?' ,chkActive.Name ,
            'Not selecting this check box makes the current budget definition inactive. '+
            'This means that budget definition will remain in the database but will not be visible '+
            'in the normal lists ' );
end;*)
function TfmBudgetDef.SaveBudget: boolean;
begin
  ExitFocus(self);
  Result := BudgetDef.Save;
end;



procedure TfmBudgetDef.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmBudgetDef.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
      if (KeyID = 0) and (AccessLevel > 2) then
      begin
        PostMessage(Handle, WM_CLOSE, 0, 0);
        Exit;
      end;
    Try
      fbSaveBtnClicked := false;
      if BudgetDef.Connection.Connected = false then BudgetDef.Connection.Connected := true;
      BudgetDef.Connection.BeginTransaction;
      if KeyId <= 0 then begin
        BudgetDef.New;
        BudgetDef.EditDB;
        KeyId := BudgetDef.ID;
      end else begin
        BudgetDef.Load(KeyID);
        edtAmount1Label.Visible := BudgetDef.ShowAmount1 = 'T';
        edtAmount2Label.Visible := BudgetDef.ShowAmount2 = 'T';
      end;
      SetControlFocus(edtName);
      dtStartDate.Readonly := BudgetDef.IsUsed;
      spnIntervalDuration.Readonly := BudgetDef.IsUsed;
      cboIntervalPeriod.Readonly := BudgetDef.IsUsed;
    except
      on EAbort do HandleEAbortException;

      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;

      on e: Exception do raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TfmBudgetDef.btnSaveClick(Sender: TObject);
Var
    Form :TfmBudget;
    ctr :Integer;
begin
  DisableForm;
  try
    inherited;
    if SaveBudget then begin
        Try
            IF BudgetDef.Active = 'T'  then begin
                Form := TfmBudget(GetComponentByClassName('TfmBudget'));
                with  Form do begin
                    ctr := BudgetDef.BudgetCreated(1);
                    if ctr > 0 then begin
                        Form.KeyId := ctr;
                        FormStyle := fsMDIChild;
                        if FindExistingComponent('TfmBudget') = nil then Exit;
                        BringToFront;
                    end else  begin
                        Form.BudgetDefId :=BudgetDef.ID;
                        FormStyle := fsMDIChild;
                        if FindExistingComponent('TfmBudget') = nil then Exit;
                        BringToFront;
                        if  cboBudgetName.Lookuptable.Locate('budgetId' , BudgetDef.ID, []) then
                            cboBudgetNameCloseUp(cboBudgetName, cboBudgetName.LookupTable , Nil, True);
                    end;
                end;
            end;
        Finally
            fbSaveBtnClicked := true;
            Notify(False);
            Self.Close;
        End;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfmBudgetDef.btnNewClick(Sender: TObject);
begin
  inherited;
  if SaveBudget then begin
    KeyId := 0;
    FormShow(nil);
  end;
end;

procedure TfmBudgetDef.btnCancelClick(Sender: TObject);
begin
  inherited;
  fbSaveBtnClicked := false;
  Notify;
  Self.Close;
end;


procedure TfmBudgetDef.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  MsgOption: integer;
begin
  inherited;
  if BudgetDef.Dirty = false then CanClose := true
  else if fbSaveBtnClicked = false then begin
    MsgOption := CommonLib.MessageDlgXP_Vista('Do you wish to Save changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if msgOption = mrYes then begin
      if SaveBudget = false then CanClose := false;
    end else if MsgOption = mrNo then RollbackTransaction
    else CanClose := false;
  end;
end;

procedure TfmBudgetDef.chkShowAmount2Click(Sender: TObject);
begin
  inherited;
  if Self.Visible then edtAmount2Label.Visible := chkShowAmount2.Checked;
end;

procedure TfmBudgetDef.chkShowAmount1Click(Sender: TObject);
begin
  inherited;
  if Self.Visible then edtAmount1Label.Visible := chkShowAmount1.Checked;
end;
procedure TfmBudgetDef.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TBusObjBudgetDef then TBusObjBudgetDef(Sender).Dataset := BudgetDef_Dataset
        else if Sender is TBusObj then TBusObj(Sender).Dataset              := BudgetClass_dataset;
    end;
end;

procedure TfmBudgetDef.FormCreate(Sender: TObject);
begin
  inherited;
  BudgetDef                             := TBusObjBudgetDef.Create(Self);
  BudgetDef.Connection                  := TMyDacDataconnection.Create(BudgetDef);
  BudgetDef.Connection.Connection       := MyConnection;
  BudgetDef.BusobjEvent                 :=  DoBusinessObjectEvent;
end;

procedure TfmBudgetDef.BudgetClass_DatasetBeforePost(DataSet: TDataSet);
begin
  inherited;
  {if the budgets are already created for the budget, cannot remove any class form it}
  if Assigned(BudgetDef) then
    if BudgetDef.IsUsed then
        if (ClassACtive) and (ClassACtive <> Dataset.fieldByname('Active').ASBoolean) then
            Dataset.fieldByname('Active').ASBoolean := classActive;
end;

procedure TfmBudgetDef.grdBudgetClassesRowChanged(Sender: TObject);
begin
  inherited;
    ClassACtive := BudgetClass_Dataset.fieldByname('Active').ASBoolean;

end;

procedure TfmBudgetDef.grdBudgetClassesEnter(Sender: TObject);
begin
  inherited;
    ClassACtive := BudgetClass_Dataset.fieldByname('Active').ASBoolean;
end;

procedure TfmBudgetDef.FormDestroy(Sender: TObject);
begin
  inherited;
  fmBudgetDef := nil;
end;

initialization
  RegisterClassOnce(TfmBudgetDef);

  with FormFact do begin
    RegisterMe(TfmBudgetDef, 'TBudgetDefGUI_*=BudgetID');
  end;
end.
