unit frmRapCategories;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, wwcheckbox,
  DNMSpeedButton, DBCtrls, wwdblook, Mask, wwdbedit, DNMPanel, BusObjRap,
  MemDS, Shader;

type
  TfmRapCategories = class(TBaseInputGUI)
    Panel1: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtItemName: TwwDBEdit;
    wwDBLookupCombo1: TwwDBLookupCombo;
    edtNotes: TDBMemo;
    edtItemNo: TwwDBEdit;
    HeaderPanel: TDNMPanel;
    Panel2: TDNMPanel;
    Label32: TLabel;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    qryRAPCategory: TMyQuery;
    qryRAPCategoryLk: TMyQuery;
    qryRAPCategoryCategoryID: TAutoIncField;
    qryRAPCategoryItemCode: TStringField;
    qryRAPCategoryItemNo: TStringField;
    qryRAPCategoryItemName: TStringField;
    qryRAPCategorySeeAlsoCategory: TStringField;
    qryRAPCategoryNote: TMemoField;
    qryRAPCategoryActive: TStringField;
    qryRAPCategoryLkCategoryID: TAutoIncField;
    qryRAPCategoryLkItemCode: TStringField;
    qryRAPCategoryLkItemNo: TStringField;
    qryRAPCategoryLkItemName: TStringField;
    qryRAPCategoryLkSeeAlsoCategory: TStringField;
    qryRAPCategoryLkNote: TMemoField;
    qryRAPCategoryLkActive: TStringField;
    dsRAPCategory: TDataSource;
    qryRAPCategoryGlobalRef: TStringField;
    qryRAPCategoryLkGlobalRef: TStringField;
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
  private
    RAPObj :TRAPCategory;
  public
    { Public declarations }
  end;

implementation

uses BusObjBase, FormFactory, CommonLib;


{$R *.dfm}

procedure TfmRapCategories.FormCreate(Sender: TObject);
begin
  inherited;
    RapObj := TRAPCategory.Create(Self);
    RapObj.connection := TMyDacDataConnection.Create(RapObj);
    TMyDacDataConnection(RapObj.connection).MyDacConnection := MyConnection;
    RapObj.Dataset := qryRAPCategory;
end;

procedure TfmRapCategories.FormDestroy(Sender: TObject);
begin
  FreeAndNil(RapObj);
  Notify;
  inherited;
end;

procedure TfmRapCategories.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    Action := caFree;
end;

procedure TfmRapCategories.btnCompletedClick(Sender: TObject);
begin
  inherited;
if RapObj.Save then Self.Close;
end;

procedure TfmRapCategories.btnCloseClick(Sender: TObject);
begin
  inherited;
        Self.Close;
end;

procedure TfmRapCategories.cmdNewClick(Sender: TObject);
begin
  inherited;
    if not RapObj.Save then Exit;
    RapObj.New;
    SetFocusedControl(edtItemNo);

end;

procedure TfmRapCategories.FormCloseQuery(Sender: TObject;
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

procedure TfmRapCategories.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
 RapObj.load(KeyID);
    SetLength(QueryNamesNotToOpen, 1);
    QueryNamesNotToOpen[0] := 'qryRAPCategory';
    OpenQueries(QueryNamesNotToOpen);
end;
initialization
  RegisterClassOnce(TfmRapCategories);

  with FormFact do  begin
    RegisterMe(TfmRapCategories, 'TRapCategoryListGUI_*=Categoryid');
    RegisterMe(TfmRapCategories, 'TRapPrescriberTypeListGUI_ItemNo=CategoryID');
    RegisterMe(TfmRapCategories, 'TRapPrescriberTypeListGUI_ItemName=CategoryID');
  End;

end.
