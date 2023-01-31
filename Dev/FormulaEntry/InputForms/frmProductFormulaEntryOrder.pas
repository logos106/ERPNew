unit frmProductFormulaEntryOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmProductFormulaEntry, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DNMSpeedButton, wwcheckbox, Shader, DNMPanel,BusobjProductFormula;

type
  TfmProductFormulaEntryOrder = class(TfmProductFormulaEntry)
    DNMPanel3: TDNMPanel;
    btndown: TDNMSpeedButton;
    btnup: TDNMSpeedButton;
    qryformulaEntryID: TIntegerField;
    qryformulaEntryActualFieldOrderno: TLargeintField;
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
  private
    fiformulaId: Integer;
  Protected
    Function NewFormulaEntryObj : TFormulaEntry;Override;
    Procedure Openrec;Override;
  public
    Property formulaId :Integer read fiformulaId write fiformulaId;
  end;


implementation

uses TrainingLib, CommonLib, DbSharedObjectsObj, CommonDbLib;

{$R *.dfm}
Function TfmProductFormulaEntryOrder.NewFormulaEntryObj : TFormulaEntry;
begin
  result := TFormulaEntry(TFieldFormulaEntry.Create(Self));
end;
procedure TfmProductFormulaEntryOrder.Openrec;
var
  cmd :TERPCommand;
begin
  inherited;
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    cmd.sql.text := 'insert ignore into tblfeformulanameorder (FormulaID, FEnameId, Fieldorderno) ' +
                    ' Select '+ inttostr(formulaId) +' as FormulaId, FE.FormulaEntryID, FE.fieldorderno  ' +
                    ' from tblFENames FE Left join tblfeformulaNameorder FEO on FE.formulaentryId = FEO.FormulaID order by FieldOrderno';
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
  inherited Openrec;
end;

procedure TfmProductFormulaEntryOrder.btnCompletedClick(Sender: TObject);
begin
  //inherited;
 CloseIt;
end;

procedure TfmProductFormulaEntryOrder.btndownClick(Sender: TObject);
begin
  inherited;
  MoveRecEntry(mmdown, FormulaEntry , 'FieldOrderno');
end;

procedure TfmProductFormulaEntryOrder.btnupClick(Sender: TObject);
begin
  inherited;
  MoveRecEntry(mmUp, FormulaEntry , 'FieldOrderno');
end;

procedure TfmProductFormulaEntryOrder.FormCreate(Sender: TObject);
begin
  inherited;
  FormulaEntry.SQLOrder := 'ActualFieldOrderno';
end;
procedure TfmProductFormulaEntryOrder.FormShow(Sender: TObject);
begin
  inherited;
  lblMSg.Caption := 'Change the Order of the Fields - Fields Are Read-Only.';
end;

initialization
  RegisterClassOnce(TfmProductFormulaEntryOrder);

end.
