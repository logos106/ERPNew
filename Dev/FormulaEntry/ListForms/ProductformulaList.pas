unit ProductformulaList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfmProductformulaList = class(TBaseListingGUI)
    qryMainFormulaID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainFormulaName: TWideStringField;
    qryMainFormuladetails: TWideStringField;
    qryMainFormula: TWideStringField;
    qryMainActive: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    Function getKeyIdfieldname:String; override;
  public
  end;


implementation

uses frmProductformula, CommonLib;

{$R *.dfm}
procedure TfmProductformulaList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    Action := caFree;
end;

procedure TfmProductformulaList.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

function TfmProductformulaList.getKeyIdfieldname: String;
begin
  Result :='formulaId';
end;

procedure TfmProductformulaList.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmProductFormula');
  if Assigned(Form) then begin
    with TfmProductFormula(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

initialization
  RegisterClassOnce(TfmProductformulaList);
finalization
  UnRegisterClass(TfmProductformulaList);

end.




