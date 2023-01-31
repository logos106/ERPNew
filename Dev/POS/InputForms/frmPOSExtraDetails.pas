unit frmPOSExtraDetails;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, busobjPOS, StdCtrls, ExtCtrls, DNMPanel, wwdblook,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMSpeedButton, Menus;

type
  TExtraDetailItem = (ediNone =0,ediPOSPostCode=1, ediPOSSource=2, ediPOSPONumber=3);
  TfmPOSExtraDetails = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    edtPostCode: TEdit;
    Label2: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMediaType: TERPQuery;
    cboMediaType: TwwDBLookupCombo;
    Label3: TLabel;
    Label4: TLabel;
    edtPONumber: TEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cboMediaTypeExit(Sender: TObject);
    procedure edtPostCodeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtPONumberExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fPosObj: TPos;
    fExtraDetailItem: TExtraDetailItem;
    procedure setPosObj(const Value: TPos);
    Function Validated :Boolean;
  public
    Property PosObj :TPos read fPosObj write setPosObj;
    Property ExtraDetailItem:TExtraDetailItem read fExtraDetailItem Write fExtraDetailItem;
  end;

implementation

uses CommonLib, CommonDbLib, FastFuncs, BusobjSaleBase, POSScreenGUI;

{$R *.dfm}
procedure TfmPOSExtraDetails.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmPOSExtraDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := CaFree;
end;

procedure TfmPOSExtraDetails.FormShow(Sender: TObject);
begin
  inherited;
  if qryMediaType.active = False then begin
      qryMediaType.connection := GetSharedMyDacConnection;
      qryMediaType.open;
  end;
  edtPostCode.Text :=PosObj.POSPostCode;
  edtPONumber.Text := PosObj.CustPONumber;
  if PosObj.MedtypeId<> 0 then
    if qryMediaType.locate('MedTypeID' , PosObj.MedtypeId , []) then
      cboMediaType.text :=qryMediaType.fieldByname('MediaType').asString;

        if (fExtraDetailItem = ediPOSPostCode) or (fExtraDetailItem = ediNone) then SetControlFocus(edtPostCode)
  else  if fExtraDetailItem = ediPOSSource then SetControlFocus(cboMediaType)
  else  if fExtraDetailItem = ediPOSPONumber then begin
    SetControlFocus(edtPONumber);
    edtPONumber.hint := 'You must provide a Customer P.O. Number to Create an Invoice For '+ POSObj.CustomerName;
    edtPONumber.ShowHint:= True;
    btnCancel.enabled := False;
  end;
end;

procedure TfmPOSExtraDetails.btnOkClick(Sender: TObject);
begin
  inherited;
  if not validated then exit;
  self.close;
end;

procedure TfmPOSExtraDetails.setPosObj(const Value: TPos);
begin
  fPosObj := Value;
end;

procedure TfmPOSExtraDetails.cboMediaTypeExit(Sender: TObject);
begin
  inherited;
   PosObj.MedtypeId  := qryMediaType.fieldbyname('MedTypeID').asInteger;
   PosObj.Medtype     := qryMediaType.fieldbyname('MediaType').aSString;
   PosObj.PostDB;
end;

procedure TfmPOSExtraDetails.edtPostCodeExit(Sender: TObject);
begin
  inherited;
  PosObj.POSPostCode := Trim(edtPostCode.text);
  PosObj.PostDB;
end;

procedure TfmPOSExtraDetails.FormCreate(Sender: TObject);
begin
  inherited;
  if Assigned(Self.Owner) then
    if self.owner is TBaseForm then
      Self.Color := TBaseForm(Self.Owner).Color;
  fExtraDetailItem := ediNone;
end;

procedure TfmPOSExtraDetails.FormPaint(Sender: TObject);
begin
//  inherited;
// gets the colour from the owner 
end;

procedure TfmPOSExtraDetails.edtPONumberExit(Sender: TObject);
begin
  inherited;
  PosObj.CustPONumber := Trim(edtPONumber.text);
  PosObj.PostDB;
end;

function TfmPOSExtraDetails.Validated: Boolean;
begin
  result := True;
  if ExtraDetailItem <> ediPOSPONumber then exit;
  if Trim(edtPONumber.text) = '' then begin
    result := False;
    CommonLib.MessageDlgXP_Vista('You must provide a Customer P.O. Number to Create an Invoice For '+ POSObj.CustomerName, mtWarning, [mbOK], 0);
  end;
end;

procedure TfmPOSExtraDetails.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  canclose:=   Validated;
end;

initialization
  RegisterClassOnce(TfmPOSExtraDetails);

end.
