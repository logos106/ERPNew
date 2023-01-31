unit frmProductGroupEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Mask, wwdbedit, Shader, DNMSpeedButton, DNMPanel, DBCtrls,
  BusObjProductGroup, BusObjBase, ActnList, wwdblook, wwcheckbox, ProgressDialog;

type
  TfmProductGroupEdit = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryProductGroup: TERPQuery;
    qryProductGroupGlobalRef: TWideStringField;
    qryProductGroupProductGroupID: TIntegerField;
    qryProductGroupGroupName: TWideStringField;
    qryProductGroupDescription: TWideMemoField;
    qryProductGroupPicture: TBlobField;
    qryProductGroupmsTimeStamp: TDateTimeField;
    dsProductGroup: TDataSource;
    Label2: TLabel;
    edtGroupName: TwwDBEdit;
    edtDescription: TDBMemo;
    Label1: TLabel;
    imgPicture: TDBImage;
    Label3: TLabel;
    btnAddPic: TDNMSpeedButton;
    btnStretch: TDNMSpeedButton;
    btnClearPic: TDNMSpeedButton;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    qryProductGroupParentGroupName: TWideStringField;
    qryParentProductGroup: TERPQuery;
    cboParent: TwwDBLookupCombo;
    Label4: TLabel;
    qryProductGroupActive: TWideStringField;
    chkActive: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddPicClick(Sender: TObject);
    procedure btnStretchClick(Sender: TObject);
    procedure btnClearPicClick(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure chkActiveClick(Sender: TObject);
  private
    ProductGroup: TProductGroup;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); Override;

  public
    { Public declarations }
  end;

var
  fmProductGroupEdit: TfmProductGroupEdit;

implementation

{$R *.dfm}

uses
  jpeg, BusObjConst, DNMExceptions, FormFactory;

procedure TfmProductGroupEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmProductGroupEdit.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actSave.Enabled:= ProductGroup.Dirty;
end;

procedure TfmProductGroupEdit.actSaveExecute(Sender: TObject);
begin
  inherited;
  PostDB(qryProductGroup);
  if not ProductGroup.Save then Exit;
  CommitTransaction;
  Notify;
  Close;
end;

procedure TfmProductGroupEdit.btnAddPicClick(Sender: TObject);
var
  Bmp: TBitmap;
  Jpg: TJpegImage;
  JpgStream: TMemoryStream;
begin
  DisableForm;
  try
    with TOpenDialog.Create(Self) do
    try
      Filter := 'JPEG (*.jpg)|*.jpg|Bitmap (*.bmp)|*.bmp';
      if Execute then
      begin
        if Filename <> '' then begin // filename is '' when Dialoge box is cancelled
          if uppercase(copy(filename, Length(filename) - 2, 3)) = 'JPG' then
          begin
            Bmp := TBitmap.Create;
            Jpg := TJpegImage.Create;
            JpgStream := TMemoryStream.Create;
            try
              Jpg.LoadFromFile(FileName);
              Bmp.Assign(Jpg);
              bmp.SaveToStream(JpgStream);
              JpgStream.Position := 0;
              EditDb(qryProductGroup);
              qryProductGroupPicture.LoadFromStream(JpgStream);
            finally
              FreeandNil(Bmp);
              FreeandNil(Jpg);
              FreeandNil(JpgStream);
            end;
          end
          else begin
            EditDb(qryProductGroup);
            qryProductGroupPicture.LoadFromFile(Filename);
          end;
        end;
      end;
    finally
      free;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmProductGroupEdit.btnClearPicClick(Sender: TObject);
begin
  imgPicture.Picture := nil;
end;

procedure TfmProductGroupEdit.btnStretchClick(Sender: TObject);
begin
  DisableForm;
  try
    if imgPicture.Stretch then begin
      imgPicture.Stretch := False;
    end else begin
      imgPicture.Stretch := True;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmProductGroupEdit.chkActiveClick(Sender: TObject);
begin
  inherited;
  ProductGroup.PostDb;
end;

procedure TfmProductGroupEdit.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProductGroup then
      TProductGroup(Sender).DataSet:= qryProductGroup;
  end;
end;

procedure TfmProductGroupEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmProductGroupEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfmProductGroupEdit.FormCreate(Sender: TObject);
begin
  inherited;
  ProductGroup:= TProductGroup.Create(self);
  ProductGroup.Connection := TMyDacDataConnection.Create(ProductGroup);
  ProductGroup.Connection.MyDacConnection := MyConnection;
  ProductGroup.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmProductGroupEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmProductGroupEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

     // qryProcResource.ParamByName('ProcResourceId').asInteger := KeyID;

      if KeyID = 0 then begin
        //ProductGroup.New;
        { not allowed to create new from here, only from Product ProductGroup }
        raise Exception.Create('TfmProductGroupEdit - Invalid KeyID of 0, creation of new ProductGroups not allowed from here');
      end else begin
        ProductGroup.Load(KeyId);
        qryParentProductGroup.ParamByName('ExcludeGroup').AsString:= ProductGroup.GroupName;
      end;
      qryParentProductGroup.Open;

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

initialization
  RegisterClass(TfmProductGroupEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmProductGroupEdit, 'TfmProductGroupList_*=ProductGroupID');
  end;

end.
