unit cleintHRForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , IntegerListObj;

type
  TcleintHRFormsGUI = class(TBaseListingGUI)
    qryMainId: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainHRFormname: TWideStringField;
    qryMainTemplateName: TWideStringField;
    qryMainPrintedOn: TDateTimeField;
    qryMainclientID: TIntegerField;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    aHRIds : TIntegerList;
    procedure initHRFormsList(Sender: TObject);
    procedure OnSelectHRForms(Sender: TwwDbGrid);
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, HRForms, HRFormsLib;

{$R *.dfm}

{ TcleintHRFormsGUI }

procedure TcleintHRFormsGUI.cmdPrintClick(Sender: TObject);
begin
//  inherited;
  OpenERPListFormultiselectModal('THRFormsGUI',initHRFormsList, OnSelectHRForms);
end;
Procedure TcleintHRFormsGUI.OnSelectHRForms(Sender: TwwDbGrid);
var
  ds:Tdataset;
  hrformID:Integer;
begin
    ds := Sender.DataSource.DataSet;
    if ds.findfield('ID') = nil then exit;
    //hrformID := ds.fieldbyname('ID').asInteger;
    commonlib.SelectedIds(sender ,'ID' , aHRIds);
    if aHRIds.Count > 0 then
    TPrintHRForm.PrintTemplate(Self, qryMainclientID.asInteger,  aHRIds , false);
end;
procedure TcleintHRFormsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  aHRIds := TIntegerList.Create;
end;

procedure TcleintHRFormsGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(aHRIds);
  inherited;
end;

procedure TcleintHRFormsGUI.initHRFormsList(Sender : TObject);
begin
  if not(Sender is  THRFormsGUI) then exit;
  THRFormsGUI(Sender).FilterString := 'formtype = ' +quotedstr('C');
end;
procedure TcleintHRFormsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;

end;

procedure TcleintHRFormsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainId.fieldname);
  RemoveFieldfromGrid(qryMainclientID.fieldname);
end;

initialization
  RegisterClassOnce(TcleintHRFormsGUI);

end.
