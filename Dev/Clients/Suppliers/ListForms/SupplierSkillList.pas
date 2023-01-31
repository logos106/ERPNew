unit SupplierSkillList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TSupplierSkillListGUI = class(TBaseListingGUI)
    qryMainclientId: TIntegerField;
    qryMaincompany: TWideStringField;
    qryMainskillname: TWideStringField;
    qryMainskillactive: TWideStringField;
    qryMainsupplieractive: TWideStringField;
    qryMainSkillId: TIntegerField;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    chkAllsuppliers: TwwCheckBox;
    btnAddSkills: TDNMSpeedButton;
    qryMainproviderSkillId: TIntegerField;
    procedure chkAllsuppliersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnAddSkillsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiSkillIDforlist :Integer;
    fsSupplierSearching:String;
    function getAllsuppliers: Boolean;
    procedure SetAllsuppliers(const Value: Boolean);
    procedure onSaveSuppliler(Sender: TObject);
    procedure beforeshowSupplierform(Sender: TObject);
    procedure beforeAddsupplier(Sender: TObject);
    procedure ApplySupplierSearching;
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
    procedure AfterPopup(Popupform:TComponent);Override;
    procedure BeforePopup(Popupform:TComponent);Override;
  public
    Procedure RefreshQuery;Override;
    Property showAllsuppliers :Boolean read getAllsuppliers write SetAllsuppliers;
    Property SkillIDforlist :Integer read fiSkillIDforlist write fiSkillIDforlist;
    Property SupplierSearching :String read fsSupplierSearching write fsSupplierSearching;
  end;


implementation

uses CommonLib, SystemLib, CommonFormLib, frmSupplier;

{$R *.dfm}
{ TSupplierSkillListGUI }
procedure TSupplierSkillListGUI.beforeshowSupplierform(Sender: TObject);
begin
  if not(Sender is TfmSupplier) then exit;
  TfmSupplier(Sender).addingskill := TRue;
end;
procedure TSupplierSkillListGUI.btnAddSkillsClick(Sender: TObject);
begin
  inherited;
  if qryMainclientId.AsInteger =0 then begin
    if MessageDlgXP_Vista('You haven''t selected the Provider to add skill. Do you want to create a new Provider?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
      cmdNew.click;
  end else begin
    if fsModal in FormState then
      OpenERPFormModal('TfmSupplier' , qryMainclientId.AsInteger ,  beforeshowSupplierform, False, onSaveSuppliler)
    else OpenERPForm('TfmSupplier' , qryMainclientId.AsInteger ,nil,  beforeshowSupplierform, False);
  end;
end;

procedure TSupplierSkillListGUI.chkAllsuppliersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;
procedure TSupplierSkillListGUI.onSaveSuppliler(Sender:TObject);
var
  fiClientID:Integer;
begin
  fiClientID:= QrymainClientID.asInteger;
  closeDB(Qrymain);
  RefreshQuery;
  Qrymain.locate('clientID' , fiClientID, []);
end;
procedure TSupplierSkillListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
    OpenERPFormModal('TfmSupplier' , 0 , nil, False)
  else OpenERPForm('TfmSupplier' , 0 );
end;

procedure TSupplierSkillListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SkillIDforlist := 0;
  SupplierSearching:='';
end;

procedure TSupplierSkillListGUI.FormShow(Sender: TObject);
begin
  if SupplierSearching <> '' then fbEnableWebSearch := false;
  inherited;
  Application.ProcessMessages;
  ApplySupplierSearching;
end;
procedure TSupplierSkillListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
end;

procedure TSupplierSkillListGUI.ApplySupplierSearching;
begin
  if SupplierSearching <> '' then begin
    if not Qrymain.Locate('company' ,SupplierSearching , []) then begin
      if OpenERPFormModal('TfmSupplier' , 0 , beforeAddsupplier) = mrok then begin
        RefreshQuery;
        Qrymain.Locate('company' ,SupplierSearching , []);
      end;
    end else if trim(Qrymainskillname.AsString) = '' then begin
      btnAddSkills.Click;
    end;
  end;
  SupplierSearching:= '';
end;
procedure TSupplierSkillListGUI.beforeAddsupplier(Sender:TObject);
begin
   if not(Sender is TfmSupplier) then exit;
   TfmSupplier(Sender).SupplierNameToCreate := SupplierSearching;
end;
procedure TSupplierSkillListGUI.BeforePopup(Popupform: TComponent);
begin
  inherited;
  if popupform is TfmSupplier then begin
    TfmSupplier(popupform).SkillIdtoLocate := qryMainproviderSkillId.AsInteger;
  end;
end;

function TSupplierSkillListGUI.getAllsuppliers: Boolean;
begin
  REsult:= chkAllsuppliers.Checked;
end;

procedure TSupplierSkillListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if trim(qryMainskillname.AsString) = '' then
    if Sametext(field.FieldName ,qryMainskillname.fieldname ) then
      ABrush.Color := clInactiveCaptionText;
  if SupplierSearching <> '' then
    if sameText(Qrymaincompany.asString , SupplierSearching) then
      AFont.color := clred;
end;

procedure TSupplierSkillListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('ShowAll').AsString := BooleanToStr(showAllsuppliers);
  Qrymain.ParamByName('SkillIDforlist').AsInteger :=SkillIDforlist;
  inherited;
end;

procedure TSupplierSkillListGUI.SetAllsuppliers(const Value: Boolean);
begin
  chkAllsuppliers.Checked := Value;
end;

procedure TSupplierSkillListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainclientId.fieldname);
  RemoveFieldfromGrid(QrymainskillId.fieldname);
  RemoveFieldfromGrid(QrymainproviderSkillId.fieldname);
end;

initialization

RegisterClass(TSupplierSkillListGUI);

end.

