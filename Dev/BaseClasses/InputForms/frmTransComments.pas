unit frmTransComments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjTRansComments, Buttons, Wwdbigrd, Grids,
  Wwdbgrid;

type
  TfmTransComments = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlFooter: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    QryTransComments: TERPQuery;
    dsTransComments: TDataSource;
    QryTransCommentsID: TIntegerField;
    QryTransCommentsGlobalRef: TWideStringField;
    QryTransCommentsTransID: TIntegerField;
    QryTransCommentsTranstype: TWideStringField;
    QryTransCommentsCommentID: TIntegerField;
    QryTransCommentsSeqno: TIntegerField;
    QryTransCommentsmstimeStamp: TDateTimeField;
    QryTransCommentsmsUpdatesiteCode: TWideStringField;
    grdComments: TwwDBGrid;
    btnGrid: TwwIButton;
    qryMain: TERPQuery;
    qryMainCommentsID: TIntegerField;
    qryMainComments: TWideMemoField;
    dsMain: TDataSource;
    QryTransCommentsComments: TStringField;
    DNMPanel4: TDNMPanel;
    lblCaption1: TLabel;
    grdMain: TwwDBGrid;
    wwIButton2: TwwIButton;
    btnup: TDNMSpeedButton;
    btndown: TDNMSpeedButton;
    lblTransDetails: TLabel;
    qryMainTransID: TIntegerField;
    lblMsg: TLabel;
    Label2: TLabel;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    btnList: TDNMSpeedButton;
    Label1: TLabel;
    DNMSpeedButton3: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure QryTransCommentsAfterInsert(DataSet: TDataSet);
    procedure btnGridClick(Sender: TObject);
    procedure btnupClick(Sender: TObject);
    procedure btndownClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
    procedure btnListClick(Sender: TObject);
    procedure QryTransCommentsAfterPost(DataSet: TDataSet);
    procedure DNMSpeedButton3Click(Sender: TObject);
  private
    TransComments: TTransComments;
    fsTranstype: String;
    fiTransID: integer;
    function SaveRecord: Boolean;
    procedure Moveit(const MoveUp: Boolean);
    Procedure REfreshList;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property Transtype :String  read fsTranstype write fsTranstype;
    Property TransID   :integer read fiTransID   write fiTransID;
  end;


implementation

uses CommonLib, BusObjConst, tcConst, CommonDbLib, CommonFormLib;

{$R *.dfm}
procedure TfmTransComments.Moveit(Const MoveUp:Boolean);
var
  id1, id2, s1, s2:Integer;
begin
  TransComments.PostDB;
  if TransComments.count <=1 then exit;
  if Moveup and  TransComments.bof then exit;
  if not(Moveup) and  TransComments.eof then exit;
  id1 := TransComments.ID; s1 := TransComments.Seqno;
  if moveup then TransComments.Prior else TransComments.Next;
  Id2 := TransComments.ID; s2 := TransComments.Seqno;

  TransComments.locate(TransComments.IDfieldname , id2 , []);
  TransComments.Seqno := s1;
  TransComments.PostDB;

  TransComments.locate(TransComments.IDfieldname , id1 , []);
  TransComments.Seqno := s2;
  TransComments.PostDB;
  Setcontrolfocus(grdComments);
end;
procedure TfmTransComments.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Qrymain.ParamByName('Transtype').AsString:= TransType;
  Qrymain.ParamByName('transId').asInteger := TransId;
end;

procedure TfmTransComments.btndownClick(Sender: TObject);
begin
  inherited;
  Moveit(False);
end;

procedure TfmTransComments.btnGridClick(Sender: TObject);
begin
  inherited;
  TransComments.PostDB;
  if TransComments.count =0 then exit;
  TransComments.delete;
end;

procedure TfmTransComments.btnListClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmComment' , 0  );
  REfreshList;
end;

procedure TfmTransComments.btnupClick(Sender: TObject);
begin
  inherited;
  Moveit(true);
end;

procedure TfmTransComments.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmTransComments.SaveRecord :Boolean;
begin
  result:= False;
  TransComments.PostDB;
  if not(TransComments.Save) then exit;
  Result:= True;

end;

procedure TfmTransComments.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymaintransId.AsInteger <> 0 then
    Afont.Color := Inactivefontcolor;
end;

procedure TfmTransComments.grdMainDblClick(Sender: TObject);
begin
  inherited;
  if qrymaintransId.AsInteger <> 0 then begin
     timerMsg(lblMsg , 'This Comment is already added to the transaction');
     TransComments.Locate(TransComments.Idfieldname, qrymaintransId.AsInteger , []);
     Exit;
  end;
  TransComments.New;
  TransComments.commentId := qryMainCommentsID.AsInteger;
  TransComments.PostDB;
  Setcontrolfocus(grdComments);
end;

procedure TfmTransComments.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  TransComments.Connection.CommitNestedTransaction;
  Self.Close;

end;

procedure TfmTransComments.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
    OpenERPFormModal('TfmComment' , qryMainCommentsID.asInteger );
  REfreshList;
end;

procedure TfmTransComments.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
      inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTransComments then TTransComments(Sender).Dataset  := QryTransComments;
     end;
end;

procedure TfmTransComments.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if TransComments.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            TransComments.Connection.CommitNestedTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          TransComments.Connection.RollbackNestedTransaction;
          TransComments.Dirty := false;
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

procedure TfmTransComments.FormCreate(Sender: TObject);
begin
  inherited;
  TransComments := TTransComments.CreateWithNewConn(Self);
  TransComments.BusObjEvent := DoBusinessObjectEvent;
  fsTranstype := '';
  fiTransID := 0;
  AlignbuttonTopnHeight(pnlFooter);
  //lblCaption1.caption := 'List of Comments'+NL+'Double Click to Choose the Comments for the Transaction';
end;
procedure TfmTransComments.FormShow(Sender: TObject);
begin
  inherited;
  //TransComments.Load(KeyID);
  if Assigned(TransConnection) then    TransComments.connection.connection := TransConnection else  TransComments.Connection.connection := Self.MyConnection;
  TransComments.LoadSelect('Transtype =' +quotedstr(Transtype) +' and TransID = ' + inttostr(TransID));
  TransComments.connection.BeginTransaction;
  //if TransComments.count=0 then TransComments.new;
  openQueries;
  lblTransDetails.Caption := Transtype +' # ' + inttostr(TransID);
  lblTransDetails.Refresh;
end;

procedure TfmTransComments.QryTransCommentsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  TransComments.Transtype := TRanstype;
  TransComments.TransId := TransID;
end;

procedure TfmTransComments.QryTransCommentsAfterPost(DataSet: TDataSet);
begin
  inherited;
  RefreshList;
end;

procedure TfmTransComments.REfreshList;
begin
  CloseDb(Qrymain);
  Qrymain.connection := QryTransComments.connection;
  OpenDb(Qrymain);
end;

initialization
  RegisterClassOnce(TfmTransComments);

end.

