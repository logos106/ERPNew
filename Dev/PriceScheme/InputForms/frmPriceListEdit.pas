unit frmPriceListEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, Shader,
  wwcheckbox, DNMSpeedButton, DNMPanel,
  BusObjBase, BusObjPriceScheme, MemDS, Mask, wwdbedit, ActnList, Grids,
  Wwdbigrd, Wwdbgrid, wwdblook, Buttons, ProgressDialog, ImgList;

type
  TfmPriceListEdit = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryPriceList: TERPQuery;
    dsPriceList: TDataSource;
    Label2: TLabel;
    edtListName: TwwDBEdit;
    Label1: TLabel;
    edtListNumber: TwwDBEdit;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    grdParts: TwwDBGrid;
    qryPriceListItem: TERPQuery;
    dsPriceListItem: TDataSource;
    qryParts: TERPQuery;
    qryPriceListItemPriceListItemID: TIntegerField;
    qryPriceListItemPriceListID: TIntegerField;
    qryPriceListItemProductID: TIntegerField;
    cboProduct: TwwDBLookupCombo;
    qryPriceListItemProductName: TWideStringField;
    qryPartsDetail: TERPQuery;
    qryPriceListItemProductDescription: TWideStringField;
    grdPartsIDeleteButton: TwwIButton;
    qryPriceListItemCost: TFloatField;
    qryPriceListItemSellPrice: TFloatField;
    qryPriceListItemListPrice: TFloatField;
    actAddProducts: TAction;
    btnProductList: TDNMSpeedButton;
    Label3: TLabel;
    cmdExport: TDNMSpeedButton;
    dlgSave: TSaveDialog;
    ExportDialog: TProgressDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure qryPriceListItemAfterPost(DataSet: TDataSet);
    procedure grdPartsIDeleteButtonClick(Sender: TObject);
    procedure actAddProductsExecute(Sender: TObject);
    procedure edtListNameExit(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cboProductEnter(Sender: TObject);
  private
    PriceList: TPriceList;
    function SaveData: boolean;
    procedure DoOnGridDataSelect(Sender: TwwDbGrid);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

var
  fmPriceListEdit: TfmPriceListEdit;

implementation

{$R *.dfm}
uses
  DNMExceptions, FormFactory, CommonLib, BusObjConst, 
  BaseListingForm, FastFuncs, wwexport;


procedure TfmPriceListEdit.FormCreate(Sender: TObject);
begin
  inherited;
  PriceList:= TPriceList.Create(self);
  PriceList.Connection := TMyDacDataConnection.Create(PriceList);
  PriceList.Connection.MyDacConnection := MyConnection;
  PriceList.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmPriceListEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

      qryPartsDetail.Open;

      if KeyID = 0 then begin
        PriceList.New;
      end else begin
        PriceList.Load(KeyId);
      end;
      PriceList.Items;
      qryParts.ParamByName('PriceListId').AsInteger:= PriceList.Id;
      qryParts.Open;

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

procedure TfmPriceListEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfmPriceListEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  RollbackTransaction;
  Action := caFree;
  inherited;
end;

procedure TfmPriceListEdit.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TfmPriceListEdit.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TPriceList then
      TPriceList(Sender).DataSet:= qryPriceList
    else if Sender is TPriceListItem then
      TPriceListItem(Sender).DataSet:= qryPriceListItem;
  end;
end;

function TfmPriceListEdit.SaveData: boolean;
begin
  result:= true;
  { validate data and return true if all ok }
  if PriceList.Dirty then begin
    if (not PriceList.ValidateData) or (not PriceList.Save) then
      result:= false;
  end;
end;

procedure TfmPriceListEdit.actSaveExecute(Sender: TObject);
begin
  inherited;
  if qryPriceList.State in [dsInsert, dsEdit] then
    qryPriceList.post;
  if grdParts.DataSource.DataSet.State in [dsEdit, dsInsert] then
    grdParts.DataSource.DataSet.Post;
  if not SaveData then Exit;
  CommitTransaction;
  Notify;
  Close;
end;

procedure TfmPriceListEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPriceListEdit.actNewExecute(Sender: TObject);
begin
  inherited;
  if qryPriceList.State in [dsInsert, dsEdit] then
    qryPriceList.post;
  if PriceList.Dirty then begin
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
  PriceList.Dirty := false;
end;

procedure TfmPriceListEdit.qryPriceListItemAfterPost(DataSet: TDataSet);
begin
  inherited;
  qryParts.Close;
  qryParts.ParamByName('PriceListId').AsInteger:= PriceList.Id;
  qryParts.Open;
end;

procedure TfmPriceListEdit.grdPartsIDeleteButtonClick(Sender: TObject);
begin
  inherited;
  PriceList.Items.Delete;
end;

procedure TfmPriceListEdit.actAddProductsExecute(Sender: TObject);
var
  SelectForm: TBaseListingGUI;
begin
  inherited;
  SelectForm:= TBaseListingGUI(GetComponentByClassName('TProductListExpressGUI', false));
  If not Assigned(SelectForm) then Exit;
  SelectForm.OnGridDataSelect:= DoOnGridDataSelect;
  SelectForm.grdMain.Options:= SelectForm.grdMain.Options + [dgMultiSelect];
  SelectForm.grdMain.MultiSelectOptions:=
    SelectForm.grdMain.MultiSelectOptions + [msoShiftSelect, msoAutoUnselect];
  SelectForm.ShowModal;
end;

procedure TfmPriceListEdit.DoOnGridDataSelect(Sender: TwwDbGrid);
var
  x: integer;
begin
  if Sender.SelectedList.Count > 0 then begin
    for x:= 0 to Sender.SelectedList.Count -1 do begin
      Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList[x]);
      PriceList.Items.New;
      PriceList.Items.ProductId:= Sender.DataSource.DataSet.FieldByName('PartsId').AsInteger;
      PriceList.Items.PostDb;
    end;
  end;
end;

procedure TfmPriceListEdit.edtListNameExit(Sender: TObject);
begin
  inherited;
  if (edtListNumber.Text = '') and (edtListName.Text <> '') then
    PriceList.ListNumber:= IntToStr(PriceList.PriceListId);
end;

procedure TfmPriceListEdit.cmdExportClick(Sender: TObject);
var
  sFileExt: string;
begin
  DisableForm;
  try
    dlgSave.Title := 'Export - ' + Caption;
    if dlgSave.Execute then begin
      grdParts.ExportOptions.FileName := dlgSave.FileName;
      grdParts.ExportOptions.TitleName := Self.Caption;
      sFileExt := ExtractFileExt(dlgSave.FileName);
      if Sysutils.SameText(FastFuncs.LowerCase(sFileExt), '.txt') then begin
        grdParts.ExportOptions.ExportType := wwgetTxt;
        grdParts.ExportOptions.Delimiter := #9;
      end else if Sysutils.SameText(FastFuncs.LowerCase(sFileExt), '.csv') then begin
        grdParts.ExportOptions.ExportType := wwgetTxt;
        grdParts.ExportOptions.Delimiter := ',';
      end else if Sysutils.SameText(FastFuncs.LowerCase(sFileExt), '.slk') then begin
        grdParts.ExportOptions.ExportType := wwgetSYLK;
      end else if Sysutils.SameText(FastFuncs.LowerCase(sFileExt), '.html') then begin
        grdParts.ExportOptions.ExportType := wwgetHTML;
      end else begin
        CommonLib.MessageDlgXP_Vista('Unsupported Export Format.' + #13 + #10 + '' + #13 + #10 + 'Defaulted To Text (*.TXT) Format Export.',
          mtWarning, [mbOK], 0);
        grdParts.ExportOptions.ExportType := wwgetTxt;
        grdParts.ExportOptions.Delimiter := #9;
      end;

      Enabled := false;
      ExportDialog.Caption := 'Exporting ' + replacestr(TitleLabel.Caption , '&&' , '&');
      ExportDialog.Execute;
      try
        Try
          grdParts.ExportOptions.Save;
        except
          on E:EFCreateError do Begin
            CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
          end;
        end;
      finally
        Enabled := true;
        ExportDialog.CloseDialog;
      end;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TfmPriceListEdit.cboProductEnter(Sender: TObject);
begin
  inherited;
  if Empty(edtListName.Text) then  begin
    CommonLib.MessageDlgXP_Vista('Requires List Name !', mtWarning, [mbOk], 0);
    if edtListName.Visible and edtListName.Enabled then
      SetControlFocus(edtListName);
  end;      
end;

initialization
  RegisterClassOnce(TfmPriceListEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmPriceListEdit, 'TfmPriceListsList_*=PriceListId');
  end;

end.
