unit frmNumberSequenceListPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, ProgressDialog;

type
  TfmNumberSequenceListPopup = class(TBaseInputGUI)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryTransactiontype: TERPQuery;
    QryTransactiontypeTransactionType: TWideStringField;
    QryTransactiontypeTransType: TWideStringField;
    dsTransactiontype: TDataSource;
    grdTransactiontype: TwwDBGrid;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    QryTransactiontypeID: TIntegerField;
    QryTransactiontypeSeqnoTostart: TIntegerField;
    chkhide: TCheckBox;
    Label1: TLabel;
    procedure QryTransactiontypeBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure grdTransactiontypeColEnter(Sender: TObject);
    procedure grdTransactiontypeEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Class Procedure  NumberSequenceListPopup(stablename :String;showPopup:boolean);
  end;


implementation

uses Commonlib,systemlib, UserLockObj, CommonDbLib, FastFuncs;

{$R *.dfm}

procedure TfmNumberSequenceListPopup.btnCloseClick(Sender: TObject);
begin
  inherited;
  Canceldb(QryTransactiontype);
  RollbackTransaction;
  Self.close;
end;

procedure TfmNumberSequenceListPopup.btnCompletedClick(Sender: TObject);
begin
  inherited;
  PostDB(QryTransactiontype);
  CommitTransaction;
  Self.close;
end;

procedure TfmNumberSequenceListPopup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UserLock.unLock('tblnumbersequencelistseqno');
  GuiPrefs.Node['General.Hideform'].AsString                  := BooleanToStr(chkhide.checked);
  inherited;
end;

procedure TfmNumberSequenceListPopup.FormCreate(Sender: TObject);
begin
  inherited;
  GuiPrefs.active := TRue;
end;

procedure TfmNumberSequenceListPopup.FormShow(Sender: TObject);
begin
  inherited;
  if not(UserLock.Lock('tblnumbersequencelistseqno' ,0 , Self.Classname)) then
    Accesslevel :=5;
  Openqueries;
end;

class procedure TfmNumberSequenceListPopup.NumberSequenceListPopup(stablename:String;showPopup:boolean);
var
  form :TfmNumberSequenceListPopup;
begin
  form := TfmNumberSequenceListPopup(commonlib.GetComponentByClassName('TfmNumberSequenceListPopup' , False ));
  try
    if not(Assigned(form)) then exit;
    ExecuteSQL('insert ignore into tblnumbersequencelistseqno (TransactionType , TransType , SeqnoTostart ) Select Distinct TransactionType , TransType , 1 from '+sTablename  , Form.myConnection);

      if form.GuiPrefs.Node.Exists('General') then
        if not showPopup then begin
          if StrToBoolean(Form.GuiPrefs.Node['General.Hideform'].AsString) then Exit;
        end else begin
          Form.chkhide.checked:= StrToBoolean(Form.GuiPrefs.Node['General.Hideform'].AsString);
        end;
    form.showmodal;
  finally
    freeandnil(Form);
  end;
end;

procedure TfmNumberSequenceListPopup.QryTransactiontypeBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  if QryTransactiontypeSeqnoTostart.asInteger <1 then QryTransactiontypeSeqnoTostart.asInteger := 1;
end;

procedure TfmNumberSequenceListPopup.grdTransactiontypeColEnter(Sender: TObject);
begin
  inherited;
  if Sametext(grdTransactiontype.getActiveField.fieldname ,QryTransactiontypeTransactionType.fieldName) then
    grdTransactiontype.SetActiveField(QryTransactiontypeSeqnoTostart.fieldName);
end;

procedure TfmNumberSequenceListPopup.grdTransactiontypeEnter(Sender: TObject);
begin
  inherited;
  grdTransactiontype.SetActiveField(QryTransactiontypeSeqnoTostart.fieldName);
end;

initialization
  RegisterClass(TfmNumberSequenceListPopup);
end.
