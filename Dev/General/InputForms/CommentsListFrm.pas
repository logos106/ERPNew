unit CommentsListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup , CommentsLib;

type
  TCommentsListGUI = class(TBaseListingGUI)
    btnDelete: TDNMSpeedButton;
    btnEdit: TDNMSpeedButton;
    qryMainCommentsID: TIntegerField;
    qryMainComments: TWideMemoField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fCommentsType: TCommentsType;
    procedure initCommentsform(Sender: TObject);
    procedure initComments(Sender: TObject);
    //Procedure Editcomments(ID:Integer);
  public
    Property CommentsType :TCommentsType read fCommentsType write fCommentsType;

    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib,CommonFormLib, frmComment;

{$R *.dfm}                           

procedure TCommentsListGUI.grdMainDblClick(Sender: TObject);
begin
  inherited;
  (*if assigned(OnGridDataSelect) then begin
      OnGridDataSelect(TwwDbGrid(Sender));
      if CloseOnRecSelect then CloseList;
      exit;
  end else if fsModal in FormState  then begin
    modalresult := mrOk;
  end else begin
    Editcomments(Self.qryMain.FieldByName('CommentsID').AsInteger);
  end;*)
end;


procedure TCommentsListGUI.RefreshQuery;
begin
  Qrymain.parambyname('CommentsType').asString := CommentsTypeToStr(CommentsType);
  inherited;
end;

procedure TCommentsListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (AccessLevel <> 6) and (dsMain.State <> dsBrowse) then qryMain.Post;
  inherited;
end;

procedure TCommentsListGUI.FormShow(Sender: TObject);
begin
  inherited;
  cmdNew.Enabled := True;
  if fsModal in FormState then grdMain.Hint := 'Double Click Or Close To Copy Comment';
end;

procedure TCommentsListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmComment' , 0  , initComments);
  closedb(qrymain);
  RefreshQuery;
  //Editcomments(0);
end;
procedure TCommentsListGUI.initComments(Sender:TObject);
begin
  if Sender is  TfmComment then
    TfmComment(Sender).CommentsType := CommentsType;
end;
(*procedure TCommentsListGUI.Editcomments(ID: Integer);
var
  Form:TComponent;
begin
  Form := GetComponentByClassName('TfmComment');
    if Assigned(Form) then begin //if has acess
      with TfmComment(Form) do begin
          if (AccessLevel <> 6) then begin
            //CallerEdit := editField;
            TfmComment(Form).TransID := ID;
            ShowModal;
            RefreshQuery;
          end else begin
            Close;
          end;
      end;
    end;
end;*)

procedure TCommentsListGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if qryMain.RecordCount > 0 then
    qryMain.Delete;
end;

procedure TCommentsListGUI.btnEditClick(Sender: TObject);
begin
  //Editcomments(Self.qryMain.FieldByName('CommentsID').AsInteger);
  OpenERPFormModal('TfmComment' , qryMainCommentsID.asInteger , initCommentsform );
end;
procedure TCommentsListGUI.initCommentsform(Sender: TObject);
begin
  if sender is TfmComment then begin
    TfmComment(Sender).CommentsType := CommentsType;
  end;
end;
procedure TCommentsListGUI.FormCreate(Sender: TObject);
begin
  NonSearchMode := True;
  fCommentsType := ctGeneral;
  inherited;
end;

initialization
  RegisterClassOnce(TCommentsListGUI);
end.
