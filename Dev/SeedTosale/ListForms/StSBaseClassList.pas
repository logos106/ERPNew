unit StSBaseClassList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,ClassListForm;

type
  TStSBaseClassListGUI = class(TClassListGUI)
    qryMainStsClassId: TIntegerField;
    qryMainLicenseNumber: TWideStringField;
    qryMainPrincipleContact: TWideStringField;
    qryMainPrincipleContactPhone: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    procedure MakeStsClass(Sender: TwwDBGrid);
    procedure FocusStsPage(Sender: TObject);
    procedure MakeStsClassRec(Sender: TObject);
  Protected
    procedure AfterPopup(Popupform:TComponent);Override;
    procedure SetGridColumns; override;
  public
  end;

implementation

uses CommonLib, frmClassFrm, AppEnvironment, CommonFormLib, StSConst;

{$R *.dfm}
{ TStSClassListGUI }

procedure TStSBaseClassListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if Popupform is TfrmClass then
    TfrmClass(Popupform).PgMain.activepageindex :=1;
end;

procedure TStSBaseClassListGUI.cmdNewClick(Sender: TObject);
begin
  //inherited;
  case MessageDlg('Assign An Existing '+AppEnv.DefaultClass.ClassHeading+' To Seed To Sale?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    mryes: OpenERPListFormSingleselectModal('TClassListGUI' , MakeStsClass, nil );
    mrno: OpenERPForm('TfrmClass' , 0, MakeStsClassRec , nil, False, true, False);
    else Exit;
  end;
end;
procedure TStSBaseClassListGUI.MakeStsClassRec(Sender: TObject);
begin
    if sender is TfrmClass then
      TfrmClass(Sender).InitStsClassMode := True;
end;
procedure TStSBaseClassListGUI.MakeStsClass(Sender: TwwDBGrid);
var
  fiKeyID:Integer;
begin
  fiKeyID:=0;
  if Assigned(Sender.owner) then
    if Sender.owner is  TBaseListingGUI then
      fiKeyID:= TBaseListingGUI(Sender.Owner).SelectedID['ClassID'];
  if fiKeyID <> 0 then
     OpenERPForm('TfrmClass' , fiKeyID, FocusStsPage , nil, False, true, False);
end;
procedure TStSBaseClassListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainstsClassID.fieldname);
end;

procedure TStSBaseClassListGUI.FocusStsPage(Sender: TObject);
begin
  if sender is TfrmClass then begin
    TfrmClass(SendeR).pgmain.activePageindex := 1;
    Setcontrolfocus(TfrmClass(SendeR).cboPrincipleContact);
  end;
end;
procedure TStSBaseClassListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := STS_CAPTION+' '+ AppEnv.DefaultClass.ClassHeading;
end;

procedure TStSBaseClassListGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkTreeMode.Checked := False;
end;


end.
