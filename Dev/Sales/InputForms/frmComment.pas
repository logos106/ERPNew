unit frmComment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusObjComments , CommentsLib;

type
  TfmComment = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DBMemo1: TDBMemo;
    QryComments: TERPQuery;
    dsComments: TDataSource;
    QryCommentsGlobalRef: TWideStringField;
    QryCommentsCommentsID: TIntegerField;
    QryCommentsComments: TWideMemoField;
    QryCommentsEditedFlag: TWideStringField;
    QryCommentsmsTimeStamp: TDateTimeField;
    QryCommentsmsUpdateSiteCode: TWideStringField;
    QryCommentsCommentsType: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QryCommentsAfterInsert(DataSet: TDataSet);
  private
    Comments: TComments;
    fCommentsType: TCommentsType;
    function SaveRecord: Boolean;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property CommentsType :TCommentsType read fCommentsType write fCommentsType;
  end;


implementation

uses CommonLib, BusObjConst, FormFactory;

{$R *.dfm}

procedure TfmComment.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmComment.SaveRecord :Boolean;
begin
  result:= False;
  Comments.PostDB;
  if not(Comments.Save) then exit;
  Result:= True;

end;

procedure TfmComment.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  Comments.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmComment.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited ;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TComments then TComments(Sender).Dataset  := QryComments;
     end;
end;

procedure TfmComment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmComment.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if Comments.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          Comments.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmComment.FormCreate(Sender: TObject);
begin
  inherited;
  Comments := TComments.CreateWithNewConn(Self);
  Comments.Connection.connection := Self.MyConnection;
  Comments.BusObjEvent := DoBusinessObjectEvent;
  fCommentsType := ctGeneral;
end;
procedure TfmComment.FormShow(Sender: TObject);
begin
  inherited;
  Comments.Load(KeyID);
  Comments.connection.BeginTransaction;
  if Comments.count=0 then Comments.new;
  openQueries;
end;

procedure TfmComment.QryCommentsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Comments.CommentsType :=CommentsTypeToStr(CommentsType);
end;

initialization
  RegisterClassOnce(TfmComment);
  with FormFact do  begin
    RegisterMe(TfmComment, 'TCommentsListGUI_*=CommentsID');
  end;
end.

