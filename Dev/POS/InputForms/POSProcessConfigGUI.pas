unit POSProcessConfigGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, MemDS,
  CheckLst, wwclearbuttongroup, wwradiogroup, DataState, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog;

type
  TPOSProcessConfigFrm = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    qrySteps: TERPQuery;
    cbSteps: TCheckListBox;
    cbxShowAllSteps: TCheckBox;
    udRefresh: TUpDown;
    edtRefreshIntervalSecs: TEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel2: TBevel;
    cbxShowComplete: TCheckBox;
    Label4: TLabel;
    cbxShowNotComplete: TCheckBox;
    Label5: TLabel;
    cbxShowPriorButtons: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    Bevel3: TBevel;
    cbxTopDown: TCheckBox;
    Label8: TLabel;
    cbxBottomUp: TCheckBox;
    Label9: TLabel;
    btnRefNumber: TDNMSpeedButton;
    qrySeqNum: TERPQuery;
    Bevel4: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtRefreshIntervalSecsKeyPress(Sender: TObject; var Key: char);
    procedure edtRefreshIntervalSecsChange(Sender: TObject);
    procedure udRefreshClick(Sender: TObject; Button: TUDBtnType);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbxShowAllStepsClick(Sender: TObject);
    procedure cbxShowCompleteClick(Sender: TObject);
    procedure cbxShowNotCompleteClick(Sender: TObject);
    procedure cbxTopDownClick(Sender: TObject);
    procedure cbxBottomUpClick(Sender: TObject);
    procedure btnRefNumberClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetProcessSteps;
    procedure GetValues;
    procedure SetValues;
  public
    { Public declarations }
  end;


implementation

uses FastFuncs,DnMExceptions, POSProcessGUI, frameProcessList, frmSeqNumbersGUI, CommonLib,
  tcConst;

{$R *.dfm}

procedure TPOSProcessConfigFrm.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TPOSProcessConfigFrm.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      // Set a non zero KeyID so BaseInputForm does not throw an exception
      // if access is read only
      Self.KeyID := 1;
      inherited;

      // set controlls based on access level
      { 1  - (Full Access)
        2  - (Full Access, No Delete)
        3  - (Create + Read)
        5  - (Read Only)
        6  - (No Access)  }

      //Self.OpenQueries;
      GetProcessSteps;
      GetValues;

      // Exception handler.
    except
      on EABort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TPOSProcessConfigFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.CloseQueries;
  Action := caFree;
//  POSProcessConfigFrm := nil;
  inherited;
end;

procedure TPOSProcessConfigFrm.GetProcessSteps;
begin
  cbSteps.Clear;
  with qrySteps do begin
    Open;
    while not Eof do begin
      cbSteps.Items.AddObject(FieldByName('Description').AsString, TObject(FieldByName('Id').AsInteger));
      Next;
    end;
    Close;
  end;
end;

function CharIsNumber(ch: char): boolean;
begin
  Result := CharInSet(ch,['0'..'9']);
end;

procedure TPOSProcessConfigFrm.edtRefreshIntervalSecsKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if not (CharIsNumber(Key) or (Key = Chr(8))) then Key := Chr(0);
end;

procedure TPOSProcessConfigFrm.edtRefreshIntervalSecsChange(Sender: TObject);
var
  Val: integer;
begin
  inherited;
  with TEdit(Sender) do begin
    if (Text = '') or (FastFuncs.StrToInt(Text) < 1) then Text := '1';
    Val := FastFuncs.StrToInt(Text);
    udRefresh.Position := Val;

    // remove leading zeros's
    Text := IntToStr(Val);
  end;
end;

procedure TPOSProcessConfigFrm.udRefreshClick(Sender: TObject; Button: TUDBtnType);
var
  x: integer;
begin
  inherited;
  x := FastFuncs.StrToInt(edtRefreshIntervalSecs.Text);
  if Button = btNext then begin
    Inc(x);
    edtRefreshIntervalSecs.Text := IntToStr(x);
  end else begin
    Dec(x);
    edtRefreshIntervalSecs.Text := IntToStr(x);
  end;
end;

procedure TPOSProcessConfigFrm.GetValues;
var
  x: integer;
begin
//  if POSProcessFrm <> nil then with POSProcessFrm do begin
    if FormStillOpen('TPOSProcessFrm') then begin
      with TPOSProcessFrm(FindExistingComponent('TPOSProcessFrm')) do begin
        cbxShowAllSteps.Checked := ProcessList.ShowAllSteps;
        cbxShowComplete.Checked := ProcessList.ShowComplete;
        cbxShowNotComplete.Checked := ProcessList.ShowNotComplete;
        edtRefreshIntervalSecs.Text := IntToStr(ProcessList.RefreshIntervalSecs);
        udRefresh.Position := ProcessList.RefreshIntervalSecs;
        cbxTopDown.Checked := (ProcessList.DisplayOrder = doTopDown);
        cbxBottomUp.Checked := (ProcessList.DisplayOrder = doBottomUp);
        cbxShowPriorButtons.Checked := ProcessList.ShowPriorButtons;

        for x := 0 to cbSteps.Count - 1 do begin
            cbSteps.Checked[x] :=
            (ProcessList.ProcessStepList.IndexOfObject(cbSteps.Items.Objects[x]) > -1);
        end;
      end;
    end;
end;

procedure TPOSProcessConfigFrm.SetValues;
var
  x: integer;
begin
//  if POSProcessFrm <> nil then with POSProcessFrm do begin
    if FormStillOpen('TPOSProcessFrm') then begin
      with TPOSProcessFrm(FindExistingComponent('TPOSProcessFrm')) do begin
          ProcessList.ShowAllSteps := cbxShowAllSteps.Checked;
          ProcessList.ShowComplete := cbxShowComplete.Checked;
          ProcessList.ShowNotComplete := cbxShowNotComplete.Checked;
          ProcessList.RefreshIntervalSecs := FastFuncs.StrToInt(edtRefreshIntervalSecs.Text);
          if cbxTopDown.Checked then ProcessList.DisplayOrder := doTopDown;
          if cbxBottomUp.Checked then ProcessList.DisplayOrder := doBottomUp;
          ProcessList.ShowPriorButtons := cbxShowPriorButtons.Checked;

          while ProcessList.ProcessStepList.Count > 0 do ProcessList.ProcessStepList.Delete(0);

          for x := 0 to cbSteps.Count - 1 do begin
            if cbSteps.Checked[x] then ProcessList.ProcessStepList.AddObject(cbSteps.Items[x], cbSteps.Items.Objects[x]);
          end;

          // set the caption
          UpdateCaption;
      end;
    end;
end;

procedure TPOSProcessConfigFrm.btnOKClick(Sender: TObject);
begin
  inherited;
  SetValues;
  Close;
end;

procedure TPOSProcessConfigFrm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPOSProcessConfigFrm.cbxShowAllStepsClick(Sender: TObject);
begin
  inherited;
  cbSteps.Enabled := not cbxShowAllSteps.Checked;
end;

procedure TPOSProcessConfigFrm.cbxShowCompleteClick(Sender: TObject);
begin
  inherited;
  // must be at least one checked
  if (not cbxShowComplete.Checked) and (not cbxShowNotComplete.Checked) then cbxShowComplete.Checked := true;
end;

procedure TPOSProcessConfigFrm.cbxShowNotCompleteClick(Sender: TObject);
begin
  inherited;
  // must be at least one checked
  if (not cbxShowComplete.Checked) and (not cbxShowNotComplete.Checked) then cbxShowComplete.Checked := true;
end;

procedure TPOSProcessConfigFrm.cbxTopDownClick(Sender: TObject);
begin
  inherited;
  // can only be one or other
  if cbxTopDown.Checked then cbxBottomUp.Checked := false;
end;

procedure TPOSProcessConfigFrm.cbxBottomUpClick(Sender: TObject);
begin
  inherited;
  // can only be one or other
  if cbxBottomUp.Checked then cbxTopDown.Checked := false;
end;

procedure TPOSProcessConfigFrm.btnRefNumberClick(Sender: TObject);
var
  SeqId: integer;
  tmpComponent: TComponent;
begin
  inherited;
  // get the id used
  qrySeqNum.SQL.Text := 'SELECT * FROM tblSeqNumbers WHERE SeqName = ''' + SEQ_ORDER_CUSTDOCKETREF + '''';
  qrySeqNum.Open;
  SeqId := qrySeqNum.FieldByName('Id').AsInteger;
  qrySeqNum.Close;

  tmpComponent := GetComponentByClassName('TfmSeqNumbersGUI');
  If not Assigned(tmpComponent) then Exit;
  with TfmSeqNumbersGUI(tmpComponent) do begin
    KeyId     := SeqId;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;


initialization
  RegisterClassOnce(TPOSProcessConfigFrm);

end.
