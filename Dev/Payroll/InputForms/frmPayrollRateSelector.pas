///////////////////////////////////////////////////////////////////////////////
  // NOTE: PLEASE READ!
  //
  // This form requires to be setup by code during runtime before showing
  // to the user.  You will need to use the EmployeeID property and
  // you must also initialise one of the below 4 properties.
  //
  // WriteResultToRecord  - Selected Information is Saved to a PSelectedPayRate Record.
  // WriteResultToEditbox - Selected Rate value is Saved to a editbox control.
  // WriteResultToDouble  - Selected Rate value is Saved to a double datatype pointer.
  // WriteResultToField   - Selected Rate value is Saved to a float / double database persistant field.
  //
  ///////////////////////////////////////////////////////////////////////////////
unit frmPayrollRateSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, StdCtrls,
  Buttons, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, DNMPanel, PayCommon,
  DBAccess, MyAccess,ERPdbComponents, DataState, MemDS, Menus, AdvMenus, Shader,
  ImgList;

type
  TfrmPayrollRateSelectorGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    grdRates: TwwDBGrid;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    Label2: TLabel;
    txtNewRate: TEdit;
    qryEmployeeRates: TERPQuery;
    qryEmployeeRatesRate: TFloatField;
    dsRates: TDataSource;
    qryEmployeeRatesEmployeeRateID: TAutoIncField;
    qryEmployeeRatesClassID: TIntegerField;
    qryEmployeeRatesLineTotal: TFloatField;
    qryEmployeeRatesQty: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure txtNewRateExit(Sender: TObject);
    procedure txtNewRateKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure grdRatesDblClick(Sender: TObject);

  private
    { Private declarations }
    fiEmployeeID: integer;
    oWriteLocationField: TFloatField;
    oWriteLocationEditbox: TEdit;
    ptrDouble: PDouble;
    recData: PSelectedPayRate;

    procedure SetupEmployee(Value: integer);

  public
    { Public declarations }
    
    property EmployeeID: integer read fiEmployeeID write SetupEmployee;

    //////////////////////////////////////////////////////////////////////
    // We use these properties for the method in how we want our selected
    // information returned to us so we can use it in other forms when
    // this form shutsdown.
    //////////////////////////////////////////////////////////////////////
    property WriteResultToField: TFloatField read oWriteLocationField write oWriteLocationField;
    property WriteResultToEditbox: TEdit read oWriteLocationEditbox write oWriteLocationEditbox;
    property WriteResultToDouble: PDouble read ptrDouble write ptrDouble;
    property WriteResultToRecord: PSelectedPayRate read recData write recData;
  end;

implementation

uses
  CommonDbLib, DNMExceptions, CommonLib;

{$R *.dfm}

{ TfrmPayrollRateSelectorGUI }

procedure TfrmPayrollRateSelectorGUI.SetupEmployee(Value: integer);
var
  qry: TERPQuery;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EmployeeID, Concat_WS('' '', FirstName, LastName) AS EmpName');
    qry.SQL.Add('FROM tblemployees');
    qry.SQL.Add('WHERE EmployeeID = :xEmpID');
    qry.ParamByName('xEmpID').asInteger := Value;
    qry.Open;

    if qry.RecordCount > 0 then begin
      Label1.Caption := qry.FieldByName('EmpName').AsString + ' has more than one hourly rate ' +
        'assigned to their pay rates table.  Please either select an hourly rate from the given list ' +
        'below by double left clicking on its value or by specifying a new hourly rate to use.';
    end else begin
      Label1.Caption := 'The Employee - Reference is Invalid!';
    end;

    qryEmployeeRates.Close;
    qryEmployeeRates.ParamByName('xEmpID').asInteger := Value;
    qryEmployeeRates.Open;

    if qryEmployeeRates.RecordCount < 1 then begin
      grdRates.Enabled := false;
      label2.Enabled := false;
      txtNewRate.Enabled := false;
    end else begin
      grdRates.Enabled := true;
      label2.Enabled := true;
      txtNewRate.Enabled := true;
    end;

    txtNewRate.Text := '0.00';
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmPayrollRateSelectorGUI.FormCreate(Sender: TObject);
begin
  // This form does not require access levels.
  fbIgnoreAccessLevels := true;
  inherited;
  qryEmployeeRates.Connection := CommonDbLib.GetSharedMyDacConnection;
  recData := nil;
  oWriteLocationField := nil;
  oWriteLocationEditbox := nil;
  ptrDouble := nil;
end;

procedure TfrmPayrollRateSelectorGUI.txtNewRateExit(Sender: TObject);
begin
  inherited;
  try
    if txtNewRate.Text = '' then begin
      txtNewRate.Text := '0.00';
      Exit;
    end;

    // Do a test conversion
    StrToFloat(txtNewRate.Text);
  except
    // If this exceptions, then the result is 0.00
    txtNewRate.Text := '0.00';
  end;
end;

procedure TfrmPayrollRateSelectorGUI.txtNewRateKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if ((Key <> '.') and (Key <> '-') or ((Key < '0') and (Key > '9'))) then begin
    Key := #0;
  end;
end;

procedure TfrmPayrollRateSelectorGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPayrollRateSelectorGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Close down our query controls.
  CloseQueries;

  // Free form from memory.
  Action := caFree;
  
end;

procedure TfrmPayrollRateSelectorGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Assigned(recData) then begin
    if txtNewRate.Text <> '0.00' then begin
      qryEmployeeRates.First;
      recData^.IndexID := 0;
      recData^.ClassID := qryEmployeeRates.FieldByName('ClassID').AsInteger;
      recData^.HourlyRate := StrToFloat(txtNewRate.Text);
      recData^.Qty := qryEmployeeRates.FieldByName('Qty').AsFloat;
      recData^.LineTotal := qryEmployeeRates.FieldByName('LineTotal').AsFloat;
    end else begin
      recData^.IndexID := qryEmployeeRates.FieldByName('EmployeeRateID').AsInteger;
      recData^.ClassID := qryEmployeeRates.FieldByName('ClassID').AsInteger;
      recData^.HourlyRate := qryEmployeeRates.FieldByName('Rate').AsFloat;
      recData^.Qty := qryEmployeeRates.FieldByName('Qty').AsFloat;
      recData^.LineTotal := qryEmployeeRates.FieldByName('LineTotal').AsFloat;
    end;
    Close;
    Exit;
  end;

  if Assigned(oWriteLocationField) then begin
    if txtNewRate.Text <> '0.00' then begin
      oWriteLocationField.DataSet.Edit;
      oWriteLocationField.AsFloat := StrToFloat(txtNewRate.Text);
    end else begin
      oWriteLocationField.DataSet.Edit;
      oWriteLocationField.AsFloat := qryEmployeeRates.FieldByName('Rate').AsFloat;
    end;

    Close;
    Exit;
  end;

  if Assigned(oWriteLocationEditbox) then begin
    if txtNewRate.Text <> '0.00' then begin
      oWriteLocationEditbox.Text := txtNewRate.Text;
    end else begin
      oWriteLocationEditbox.Text := qryEmployeeRates.FieldByName('Rate').AsString;
    end;

    Close;
    Exit;
  end;

  if Assigned(ptrDouble) then begin
    if txtNewRate.Text <> '0.00' then begin
      ptrDouble^ := StrToFloat(txtNewRate.Text);
    end else begin
      ptrDouble^ := qryEmployeeRates.FieldByName('Rate').AsFloat;
    end;

    Close;
    Exit;
  end;
end;

procedure TfrmPayrollRateSelectorGUI.grdRatesDblClick(Sender: TObject);
begin
  inherited;
  txtNewRate.Text := '0.00';
  btnSave.Click;
end;

initialization
  RegisterClassOnce(TfrmPayrollRateSelectorGUI);

end.
