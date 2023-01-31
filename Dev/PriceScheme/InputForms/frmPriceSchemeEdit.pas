unit frmPriceSchemeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, ActnList, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, DNMPanel,
  BusObjBase, MemDS, Mask, wwdbedit, BusObjPriceScheme, Wwdotdot, Wwdbcomb,
  wwdbdatetimepicker, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Buttons, ImgList,
  ProgressDialog;

type
  TfmPriceSchemeEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    Label2: TLabel;
    edtSchemeName: TwwDBEdit;
    Label1: TLabel;
    edtSchemeNumber: TwwDBEdit;
    qryScheme: TERPQuery;
    dsScheme: TDataSource;
    qrySchemeItems: TERPQuery;
    dsSchemeItems: TDataSource;
    cboSchemeType: TwwDBComboBox;
    Label4: TLabel;
    edtDateFrom: TwwDBDateTimePicker;
    edtDateTo: TwwDBDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cboRelatedScheme: TwwDBLookupCombo;
    qryPriceSchemeLookup: TERPQuery;
    Label9: TLabel;
    edtCredit: TwwDBEdit;
    qrySchemePriceSchemeID: TIntegerField;
    qrySchemeGlobalRef: TWideStringField;
    qrySchemeSchemeNumber: TWideStringField;
    qrySchemeSchemeName: TWideStringField;
    qrySchemeSchemeType: TIntegerField;
    qrySchemePrice: TFloatField;
    qrySchemeDateFrom: TDateField;
    qrySchemeDateTo: TDateField;
    qrySchemeCredit: TFloatField;
    qrySchemeRelatedSchemeID: TIntegerField;
    qrySchemeDiscountOrQtyFree: TFloatField;
    qrySchemeActive: TWideStringField;
    qrySchememsTimeStamp: TDateTimeField;
    Label10: TLabel;
    edtPrice: TwwDBEdit;
    Label11: TLabel;
    edtDiscount: TwwDBEdit;
    grdItems: TwwDBGrid;
    qrySchemeItemsSchemePriceListItemID: TIntegerField;
    qrySchemeItemsPriceSchemeID: TIntegerField;
    qrySchemeItemsPriceListID: TIntegerField;
    qrySchemeItemsPriceListNumber: TWideStringField;
    qrySchemeItemsPriceListName: TWideStringField;
    qryPriceListLookup2: TERPQuery;
    cboGridListNumber: TwwDBLookupCombo;
    cboGridListName: TwwDBLookupCombo;
    wwDBGrid1IButton: TwwIButton;
    qrySchemeItemsQuantityThreshold: TFloatField;
    memTypeDesc: TMemo;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure qrySchemeAfterPost(DataSet: TDataSet);
    procedure qrySchemeItemsAfterPost(DataSet: TDataSet);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure cboSchemeTypeCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cboSchemeTypeChange(Sender: TObject);
    procedure edtSchemeNameExit(Sender: TObject);
    procedure qrySchemeItemsAfterOpen(DataSet: TDataSet);
  private
    PriceScheme: TPriceScheme;
    function SaveData: boolean;
    procedure SetDisplayForType;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

var
  fmPriceSchemeEdit: TfmPriceSchemeEdit;

implementation

{$R *.dfm}

uses
  DNMExceptions, FormFactory, CommonLib, BusObjConst, FastFuncs;

procedure TfmPriceSchemeEdit.FormCreate(Sender: TObject);
var
  PST: TPriceSchemeType;
begin
  inherited;
  cboSchemeType.Items.Clear;
  cboSchemeType.MapList:= true;
  for PST:= Low(TPriceSchemeType) to High(TPriceSchemeType) do begin
    cboSchemeType.Items.Add(PriceSchemeTypeName[PST] + #9 + IntToStr(Ord(PST)));
  end;
  PriceScheme:= TPriceScheme.Create(self);
  PriceScheme.Connection := TMyDacDataConnection.Create(PriceScheme);
  PriceScheme.Connection.MyDacConnection := MyConnection;
  PriceScheme.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmPriceSchemeEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

      if KeyID = 0 then begin
        PriceScheme.New;
      end else begin
        PriceScheme.Load(KeyId);
      end;
      PriceScheme.PriceListItems;
      qryPriceSchemeLookup.ParamByName('PriceSchemeId').AsInteger:= PriceScheme.Id;
      qryPriceSchemeLookup.Open;
      qryPriceListLookup2.ParamByName('PriceSchemeId').AsInteger:= PriceScheme.Id;
      qryPriceListLookup2.Open;


      //DataState.Activate;

      // Exception Handler
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

procedure TfmPriceSchemeEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfmPriceSchemeEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmPriceSchemeEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmPriceSchemeEdit.DoBusinessObjectEvent(  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TPriceScheme then
      TPriceScheme(Sender).DataSet:= qryScheme
    else if Sender is TSchemePriceListItem then
      TSchemePriceListItem(Sender).DataSet:= qrySchemeItems;
  end;
end;

function TfmPriceSchemeEdit.SaveData: boolean;
begin
  result:= true;
  { validate data and return true if all ok }
  if PriceScheme.Dirty then begin
    if (not PriceScheme.ValidateData) or (not PriceScheme.Save) then
      result:= false;
  end;
end;

procedure TfmPriceSchemeEdit.actSaveExecute(Sender: TObject);
begin
  inherited;
  if qryScheme.State in [dsInsert, dsEdit] then
    qryScheme.post;
  if grdItems.DataSource.DataSet.State in [dsEdit, dsInsert] then
    grdItems.DataSource.DataSet.Post;
  if not SaveData then Exit;
  CommitTransaction;
  Notify;
  Close;
end;

procedure TfmPriceSchemeEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPriceSchemeEdit.actNewExecute(Sender: TObject);
begin
  inherited;
  if qryScheme.State in [dsInsert, dsEdit] then
    qryScheme.post;
  if PriceScheme.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  FormShow(nil);
  PriceScheme.Dirty := false;
end;

procedure TfmPriceSchemeEdit.qrySchemeAfterPost(DataSet: TDataSet);
begin
  inherited;
  qryPriceSchemeLookup.Close;
  qryPriceSchemeLookup.ParamByName('PriceSchemeId').AsInteger:= PriceScheme.Id;
  qryPriceSchemeLookup.Open;
  qryPriceListLookup2.Close;
  qryPriceListLookup2.ParamByName('PriceSchemeId').AsInteger:= PriceScheme.Id;
  qryPriceListLookup2.Open;
end;

procedure TfmPriceSchemeEdit.qrySchemeItemsAfterPost(DataSet: TDataSet);
begin
  inherited;
  qryPriceListLookup2.Close;
  qryPriceListLookup2.ParamByName('PriceSchemeId').AsInteger:= PriceScheme.Id;
  qryPriceListLookup2.Open;
end;

procedure TfmPriceSchemeEdit.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  PriceScheme.PriceListItems.Delete;
end;

procedure TfmPriceSchemeEdit.SetDisplayForType;
begin
  grdItems.AddField('QuantityThreshold');
  case PriceScheme.SchemeType of
    pstPriceList:
      begin
        PriceScheme.Price:= 0;
        PriceScheme.DiscountOrQtyFree:= 0;
        PriceScheme.Credit:= 0;
        PriceScheme.RelatedSchemeId:= 0;
        grdItems.RemoveField('QuantityThreshold');
      end;
    pstQtyFree:
      begin
        PriceScheme.Price:= 0;
        PriceScheme.Credit:= 0;
        PriceScheme.RelatedSchemeId:= 0;
      end;
    pstDiscount:
      begin
        PriceScheme.Price:= 0;
        PriceScheme.Credit:= 0;
        PriceScheme.RelatedSchemeId:= 0;
      end;
    pstQtyDiscount:
      begin
        PriceScheme.Price:= 0;
        PriceScheme.RelatedSchemeId:= 0;
        PriceScheme.Credit:= 0;
      end;
    pstPrice:
      begin
        PriceScheme.DiscountOrQtyFree:= 0;
        PriceScheme.Credit:= 0;
        PriceScheme.RelatedSchemeId:= 0;
      end;
    pstCredit:
      begin
        PriceScheme.Price:= 0;
        PriceScheme.DiscountOrQtyFree:= 0;
      end;
    pstCombo:
      begin
        PriceScheme.DiscountOrQtyFree:= 0;
        PriceScheme.Credit:= 0;
        PriceScheme.RelatedSchemeId:= 0;
      end;
  end;
end;

procedure TfmPriceSchemeEdit.cboSchemeTypeCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  if Select then begin
    PriceScheme.SchemeTypeName:= cboSchemeType.Text;
    SetDisplayForType;
    memTypeDesc.Text:= PriceScheme.SchemeTypeDescription;
  end;
end;

procedure TfmPriceSchemeEdit.cboSchemeTypeChange(Sender: TObject);
begin
  inherited;
  memTypeDesc.Text:= PriceScheme.SchemeTypeDescription;
end;

procedure TfmPriceSchemeEdit.edtSchemeNameExit(Sender: TObject);
begin
  inherited;
  if (edtSchemeName.Text <> '') and (edtSchemeNumber.Text = '') then
    PriceScheme.SchemeNumber:= IntToStr(PriceScheme.PriceSchemeId);
end;

procedure TfmPriceSchemeEdit.qrySchemeItemsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if PriceScheme.SchemeType = pstPriceList then
    grdItems.RemoveField('QuantityThreshold')
  else
    grdItems.AddField('QuantityThreshold');
end;

initialization
  RegisterClassOnce(TfmPriceSchemeEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmPriceSchemeEdit, 'TfmPriceSchemeList_*=PriceSchemeId');
  end;

end.
