{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/08/05  1.00.01  BJ  Initial version
}
unit EquipmentListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, AdvOfficeStatusBar, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TEquipmentListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainEquipmentID: TIntegerField;
    qryMainEquipmentName: TWideStringField;
    qryMainEquipmentDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainIsProduct: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainModel: TWideStringField;
    btnAttachments: TDNMSpeedButton;
    qryMainAttachmentID: TIntegerField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainSerialnumber: TWideStringField;
    qryMainOnhire: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAttachmentsClick(Sender: TObject);
    procedure qryMainAttachmentIDGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fsProductName: String;
    procedure SetProductName(const Value: String);
    Procedure selectRecord(Sender: TObject);
    Procedure EquipmentsparePartsBeforeShow(Sender: TObject);
    procedure OnNewEquip(Sender: TObject);
    { Private declarations }
  Protected
    Procedure SetGridColumns;override;
  public
    class function ShowallEquipment(const EquipmentName:String):Integer;
    Property ProductName :String read fsProductName Write SetProductName;

  end;

//var
//  EquipmentListGUI: TEquipmentListGUI;

implementation

uses CommonLib, (*frmEquipmentFrm, *)frmAttachments, CommonDbLib, FastFuncs,
  CommonFormLib, EquipmentspareParts, frmEquip;

{$R *.dfm}

procedure TEquipmentListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TEquipmentListGUI.cmdNewClick(Sender: TObject);
begin
  if fsModal in Self.FormState then begin
    OpenERPFormModal('TfmEquip' , 0 , nil, false, OnNewEquip);
  end else begin
    OpenERPForm('TfmEquip' , 0);
  end;
end;
procedure TEquipmentListGUI.OnNewEquip(Sender:TObject);
begin
  RefreshQuery;
  if sender is TfmEquip then
    qrymain.locate('EquipmentID' ,TfmEquip(Sender).qryEquipmentEquipmentID.asInteger , []);

end;
procedure TEquipmentListGUI.FormShow(Sender: TObject);
begin
  grpFiltersClick(grpFilters);
  inherited;
end;

procedure TEquipmentListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  EquipmentListGUI := nil;
end;
procedure TEquipmentListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbAllowdrilldownwhenModal:= TRue;
end;

procedure TEquipmentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('EquipmentId');
  RemoveFieldfromGrid('ProductId');
end;

class function TEquipmentListGUI.ShowallEquipment(
  const EquipmentName: String): Integer;
begin
  with TEquipmentListGUI.create(nil) do try
    ProductName:=EquipmentName;(*' where EquipmentName = ' +quotedStr(EquipmentName) +
                                ' and ifnull(productId,0) =0';*)

    showModal;
    result := qryMainEquipmentID.asInteger;
  finally
    Free;
  end;
end;

procedure TEquipmentListGUI.SetProductName(const Value: String);
begin
  Caption :='Choose Equipment for Product';
  fsProductName := Value;
  Qrymain.SQL.clear;
  Qrymain.SQL.add(' Select E.GlobalRef, E.EquipmentID, E.EquipmentName, ' +
     ' E.EquipmentDescription, E.Active ,' +
     ' if(ifNull(E.ProductID,0)=0 , "F" , "T") as ISProduct  , ' +
     ' E.Manufacture, E.Model, min(A.AttachmentID) as AttachmentID' +
     ' from tblEquipment e ' +
     ' left join tblAttachments A on A.TableId = e.EquipmentId and A.tablename ="tblEquipment"' +
     ' where EquipmentName = ' +quotedStr(Value) +
                                ' and ifnull(productId,0) =0 group by E.EquipmentID');
  grdMain.OnDblClick := selectRecord;
  FooterPanel.Visible := False;
  
end;

procedure TEquipmentListGUI.selectRecord(Sender: TObject);
begin
  Self.Close;
end;

procedure TEquipmentListGUI.btnAttachmentsClick(Sender: TObject);
var tmpComponent:TComponent;
begin
  if qryMainEquipmentID.AsInteger < 1 then
    exit; // need sales id
  tmpComponent:= TfmAttachments(GetComponentByClassName('TfmAttachments', true, self));
  if not assigned (tmpComponent) then exit;
  with TfmAttachments(tmpComponent) do
  begin
    (*DBConnection := GetNewMyDacConnection(tmpComponent);*)
    AttachObserver(Self);
    TableName := 'tblEquipment';
    TableId := qryMainEquipmentID.AsInteger;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TEquipmentListGUI.qryMainAttachmentIDGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsInteger <> 0 then Text := 'T' else Text := 'F';
end;

procedure TEquipmentListGUI.grdMainDblClick(Sender: TObject);
begin

  if Sysutils.SameText(grdmain.GetActiveField.fieldname , 'AttachmentID') then begin
    btnAttachments.Click;
  end else inherited;
end;

procedure TEquipmentListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TEquipmentsparePartsGUI' , EquipmentsparePartsBeforeShow);
  //Self.close;
end;

procedure TEquipmentListGUI.EquipmentsparePartsBeforeShow(Sender: TObject);
begin
  if not(Sender is TEquipmentsparePartsGUI) then exit;
  
  TEquipmentsparePartsGUI(Sender).FilterString := 'EquipmentId = ' +IntToStr(QrymainEquipmentId.asInteger);
end;

initialization
  RegisterClassOnce(TEquipmentListGUI);
  


end.

