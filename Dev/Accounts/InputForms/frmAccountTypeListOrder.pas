unit frmAccountTypeListOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmAccountTypeListOrder = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdCancel: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    grdAccountTypes: TwwDBGrid;
    qryAccType: TMyQuery;
    dsAccType: TDataSource;
    qryAccTypeGlobalRef: TWideStringField;
    qryAccTypeAccType: TWideStringField;
    qryAccTypeAccDesc: TWideStringField;
    qryAccTypeOriginalDesc: TWideStringField;
    qryAccTypeEditedFlag: TWideStringField;
    qryAccTypeTypeID: TIntegerField;
    qryAccTypeSortOrder: TIntegerField;
    qryAccTypemsTimeStamp: TDateTimeField;
    qryAccTypemsUpdateSiteCode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure qryAccTypeAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAccountTypeListOrder: TfmAccountTypeListOrder;

implementation

{$R *.dfm}

uses
  DNMExceptions;

procedure TfmAccountTypeListOrder.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmAccountTypeListOrder.cmdOkClick(Sender: TObject);
begin
  inherited;
  PostDB(qryAccType);
  self.CommitTransaction;
  Notify;
  Close;
end;

procedure TfmAccountTypeListOrder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmAccountTypeListOrder.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryAccType.Active then begin
        if not (qryAccType.State in [dsBrowse]) then begin
          qryAccType.Post;
          Notify;
        end;
        CloseQueries;
      end;
      OpenQueries;
      qryAccType.Edit;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmAccountTypeListOrder.qryAccTypeAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.Cancel;
end;

initialization

  RegisterClass(TfmAccountTypeListOrder);

end.
