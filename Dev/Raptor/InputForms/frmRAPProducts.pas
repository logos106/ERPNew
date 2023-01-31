unit frmRAPProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, StdCtrls, wwclearbuttongroup,
  wwradiogroup, DBCtrls, wwdblook, wwcheckbox, Mask, wwdbedit, ExtCtrls,
  DNMPanel, Menus, AdvMenus, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  BusObjRap, MemDS, Shader;

type
  TfmRAPProducts = class(TBaseInputGUI)
    HeaderPanel: TDNMPanel;
    Panel1: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label32: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel66: TBevel;
    Label11: TLabel;
    PnlApprovalLimits: TDNMPanel;
    Label1: TLabel;
    Label4: TLabel;
    edtPriorApprovalQtyLimit: TwwDBEdit;
    edtPriorApprovalAmtLimit: TwwDBEdit;
    edtProductCode: TwwDBEdit;
    chkPriorApprovalRequired: TwwCheckBox;
    cboRapCategoryCode: TwwDBLookupCombo;
    chkGST: TwwCheckBox;
    edtSpecialConsitions: TDBMemo;
    cboProduct: TwwDBLookupCombo;
    wwDBEdit1: TwwDBEdit;
    rdoCardType: TwwRadioGroup;
    chkContracted: TwwCheckBox;
    Panel2: TDNMPanel;
    Label8: TLabel;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    qryRapProducts: TMyQuery;
    dsDeliveryCodes: TDataSource;
    qryRapProductsRapProductID: TAutoIncField;
    qryRapProductsRapCategoryID: TIntegerField;
    qryRapProductsRapCategoryCode: TStringField;
    qryRapProductsProductCode: TStringField;
    qryRapProductsDescription: TStringField;
    qryRapProductsPriorApprovalRequired: TStringField;
    qryRapProductsPriorApprovalQtyLimit: TFloatField;
    qryRapProductsPriorApprovalAmtLimit: TFloatField;
    qryRapProductsGST: TStringField;
    qryRapProductsSpecialConsitions: TMemoField;
    qryRapProductsActive: TStringField;
    qryRapProductsCardType: TStringField;
    qryRapProductsContracted: TStringField;
    qryRAPCategory: TMyQuery;
    qryRAPCategoryItemName: TStringField;
    qryRAPCategoryCategoryID: TIntegerField;
    qryRAPCategoryItemCode: TStringField;
    qryRAPCategoryItemNo: TStringField;
    qryRAPCategorySeeAlsoCategory: TStringField;
    qryRAPCategoryNote: TMemoField;
    qryRAPCategoryActive: TStringField;
    cboProductQry: TMyQuery;
    cboProductQryPARTNAME: TStringField;
    cboProductQryPARTSID: TIntegerField;
    qryRapProductsGlobalRef: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure chkPriorApprovalRequiredClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    RapObj :TRAPproducts;
    Procedure ShowApprovalLimitFields(Const Value :Boolean);
  public
  end;


implementation

uses BusObjBase, FormFactory, CommonLib;


{$R *.dfm}
Procedure TfmRAPProducts.ShowApprovalLimitFields(Const Value :Boolean);
var
    Index : Integer;
begin
    for Index := 0 to PnlApprovalLimits.ControlCount - 1 do begin
        if (PnlApprovalLimits.Controls[Index] is TLabel) then
            TLabel(PnlApprovalLimits.Controls[Index]).Enabled := Value
        else if (PnlApprovalLimits.Controls[Index] is TCustomEdit ) then
            TCustomEdit(PnlApprovalLimits.Controls[Index]).Enabled := Value;
    end;
end;

procedure TfmRAPProducts.FormCreate(Sender: TObject);
begin
  inherited;
    RapObj := TRAPproducts.Create(self);
    RapObj.Connection := TMyDacDataConnection.Create(RapObj);
    TMyDacDataConnection(RapObj.connection).MyDacConnection := Self.MyConnection;
    RapObj.Dataset := qryRapProducts;
    RapObj.ShowApprovalLimitFields := ShowApprovalLimitFields;
end;

procedure TfmRAPProducts.FormDestroy(Sender: TObject);
begin
  FreeAndNil(RapObj);
  Notify;
  inherited;
end;

procedure TfmRAPProducts.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
Action := caFree;
end;

procedure TfmRAPProducts.btnCompletedClick(Sender: TObject);
begin
  inherited;
if RapObj.Save then Self.Close;
end;

procedure TfmRAPProducts.btnCloseClick(Sender: TObject);
begin
  inherited;
Self.Close;
end;

procedure TfmRAPProducts.cmdNewClick(Sender: TObject);
begin
  inherited;
if not RapObj.Save then Exit;
    RapObj.New;
    SetFocusedControl(cboRapCategoryCode);
end;

procedure TfmRAPProducts.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
CanClose := false;
  if RapObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if RapObj.Save then begin
            CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          RollbackTransaction;
          RapObj.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TfmRAPProducts.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
    RapObj.load(KeyID);
    SetLength(QueryNamesNotToOpen, 1);
    QueryNamesNotToOpen[0] := 'qryRapProducts';
    OpenQueries(QueryNamesNotToOpen);

end;

procedure TfmRAPProducts.chkPriorApprovalRequiredClick(Sender: TObject);
begin
  inherited;
    if not (Screen.Activecontrol = chkPriorApprovalRequired) then exit;
    ShowApprovalLimitFields(chkPriorApprovalRequired.Checked);
end;

procedure TfmRAPProducts.FormResize(Sender: TObject);
begin
  inherited;
   //rdoCardType.Repaint;
   rdoCardType.width := rdoCardType.width+1;
   rdoCardType.width := rdoCardType.width-1;
end;

initialization
  RegisterClassOnce(TfmRAPProducts);
  with FormFact do  begin
    RegisterMe(TfmRAPProducts, 'TRapProductListGUI_*=RapProductID');
    RegisterMe(TfmRAPProducts, 'TRapPrescriberTypeListGUI_ProductCode=RapProductID');
    RegisterMe(TfmRAPProducts, 'TRapPrescriberTypeListGUI_Description=RapProductID');
  End;

end.
