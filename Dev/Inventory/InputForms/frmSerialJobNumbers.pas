unit frmSerialJobNumbers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, StdCtrls, Shader,
  ExtCtrls, DNMPanel, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, BusObjBase, busobjSerialnumbers,
  wwdblook, DBCtrls, Buttons, ProgressDialog, ERPDbLookupCombo;

type
  TfmSerialjobNumbers = class(TBaseInputGUI)
    QrySerialNumbers: TERPQuery;
    dsSerialNumbers: TDataSource;
    QrySerialNumbersID: TIntegerField;
    QrySerialNumbersSerialNo: TWideStringField;
    QrySerialNumbersProductId: TIntegerField;
    QrySerialNumbersProductname: TWideStringField;
    QrySerialNumbersClassId: TIntegerField;
    QrySerialNumbersclassname: TWideStringField;
    qryDefaultDept: TERPQuery;
    qryDefaultDeptClassID: TIntegerField;
    qryDefaultDeptClassName: TWideStringField;
    qryDefaultDeptClassPercent: TFloatField;
    QrySerialNumbersActive: TWideStringField;
    pnlHeader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlTop: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    edtNos: TEdit;
    Label2: TLabel;
    edtLastno: TEdit;
    btnNext: TDNMSpeedButton;
    Label3: TLabel;
    DNMPanel3: TDNMPanel;
    grdmain: TwwDBGrid;
    grdmainIButton: TwwIButton;
    lblHint: TLabel;
    Label5: TLabel;
    DNMPanel4: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    cboDepartment: TwwDBLookupCombo;
    QrySerialNumbersGlobalRef: TWideStringField;
    QrySerialNumbersmsTimeStamp: TDateTimeField;
    QrySerialNumbersmsUpdateSiteCode: TWideStringField;
    Label4: TLabel;
    cboProduct: TwwDBLookupCombo;
    cboProductQry: TERPQuery;
    cboProductQryPartsId: TIntegerField;
    cboProductQrypartname: TWideStringField;
    cboProductQrypartsDescription: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure QrySerialNumbersAfterPost(DataSet: TDataSet);
    procedure edtLastnoEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdmainIButtonClick(Sender: TObject);
    procedure grdmainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);
    procedure grdmainKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    SerialNo :TSerialJobNumbers;
    NextNo:String;
    fOnListSelect: TNotifyEvent;
    fsSearchData:String;
    Procedure DoSearch;
    procedure MakeNextNo;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure InitERPLookupCombonFields; Override;
  end;


implementation

uses CommonLib, BusObjConst, FastFuncs, CommonDbLib,
  BaseFormForm, AppEnvironment, StringUtils, CommonFormLib,
  ProductListExpressForm;


{$R *.dfm}

procedure TfmSerialjobNumbers.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
       if Sender is TSerialJobNumbers then TSerialJobNumbers(Sender).Dataset := QrySerialNumbers;
    end;
end;

procedure TfmSerialjobNumbers.DoSearch;
begin

  if   fsSearchData  = '' then exit;
  QrySerialNumbers.Locate('Serialno', fsSearchData , [loCaseInsensitive, loPartialKey]);
  grdmain.UnselectAll;
  grdmain.SelectRecord;

end;

procedure TfmSerialjobNumbers.FormCreate(Sender: TObject);
begin
  inherited;
  SerialNo := TSerialJobNumbers.create(Self);
  SerialNo.connection := TMyDacDataConnection.Create(SerialNo);
  SerialNo.Connection.Connection := MyConnection;
  SerialNo.BusObjEvent :=DoBusinessObjectEvent;
  QrySerialNumbersAfterPost(QrySerialNumbers); {to get the nextno}
  fOnListSelect := nil;
  if not SerialNo.UserLock.Lock(SerialNo.BusObjectTableName, 0, SerialNo.LockGroupName) then begin
    AccessLevel := 5; // read only

    CommonLib.MessageDlgXP_Vista(SerialNo.UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
      mtWarning, [mbOK], 0);
  end;
end;

procedure TfmSerialjobNumbers.FormShow(Sender: TObject);
begin
  inherited;
  SerialNo.SQLOrder := 'Serialno';
  SerialNo.Load;
  SerialNo.Connection.BeginTransaction;
  OpenQueries;
  qryDefaultDept.First;
  qryDefaultDept.Locate('ClassID' ,Appenv.DefaultClass.ClassID , []);
  cboDepartment.Text :=qryDefaultDeptClassName.asString;
  btnNext.Enabled:= AccessLevel < 5;
  SerialNo.Last;
  MakeNextNo;
end;

procedure TfmSerialjobNumbers.btnNextClick(Sender: TObject);
var
  ctr:Integer;
  SerialNoID:Integer;
begin
  inherited;
  if edtNos.text = '' then exit;
  PostDB(QrySerialNumbers);
  {next no}
  if edtLastno.text <> '' then
    if edtLastno.Text <>  nextno then
        nextno :=edtLastno.Text;

  {default classs}
  if cboDepartment.Text = '' then begin
    qryDefaultDept.First;
    qryDefaultDept.Locate('ClassID' ,Appenv.DefaultClass.ClassID , []);
    cboDepartment.Text :=qryDefaultDeptClassName.asString;
  end;

  {generate numbers}
  QrySerialNumbers.DisableControls;
  try
    SerialNoId:=0;
    SerialNo.DoFieldChangewhenDisabled := True;
    for ctr := 1 to strToInt(edtNos.text)  do begin
        while QrySerialNumbers.Locate('Serialno' , nextno , [])=true do
          nextno:= incStr(nextno);//nextno:= nextno+1;
        SerialNo.New;
        SerialNo.SerialNo:= nextno;
        SerialNo.DeptID := qryDefaultDeptClassID.asInteger;
        SerialNo.DeptName :=qryDefaultDeptClassName.asString;
        if cboproduct.Text <> '' then begin
          SerialNo.Productname :=cboproduct.Text;
        end;
        SerialNo.PostDB;
        SerialNoID:=SerialNo.Id;
    end;
    if SerialNoId <> 0 then
      try
        SerialNo.CloseDb;
        SerialNo.Load;
      finally
        SerialNo.Locate(SerialNo.IDFieldNAme , SerialNoId , []);
      end;
  finally
      QrySerialNumbers.EnableControls;
  end;
  SerialNo.PostDB;
end;

procedure TfmSerialjobNumbers.btnCompletedClick(Sender: TObject);
begin
  inherited;
    SerialNo.Save;
    SerialNo.Connection.CommitTransaction;

    Self.Close;
end;

procedure TfmSerialjobNumbers.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmSerialjobNumbers.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ExitResult: Word;
begin
  inherited;
  if SerialNo.Dirty then begin
    ExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
    case ExitResult of
      mrYes: if SerialNo.Save = False  then begin
                CanClose:= false;
              end else SerialNo.connection.CommitTransaction;
      mrNo: begin
              SerialNo.connection.RollbackTransaction;
            end;
      mrCancel: begin
                CanClose:= false;
              end;
    end;
  end;
end;
procedure TfmSerialjobNumbers.QrySerialNumbersAfterPost(DataSet: TDataSet);
begin
  MakeNextNo;
end;
procedure TfmSerialjobNumbers.MakeNextNo;
begin
  inherited;
  NextNo := incStr(QrySerialNumbersSerialno.asString);
  edtLastno.Text := NextNo;
end;

procedure TfmSerialjobNumbers.edtLastnoEnter(Sender: TObject);
begin
  inherited;
  SerialNo.PostDB;
end;

procedure TfmSerialjobNumbers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TfmSerialjobNumbers.grdmainIButtonClick(Sender: TObject);
begin
  inherited;
  SerialNo.Active := False;
  SerialNo.PostDB;
end;

procedure TfmSerialjobNumbers.grdmainKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
  function SearchCharpressed:Boolean;
  begin
      result := ((Key>=32) and (Key<= 126))
  end;
begin
  inherited;
  if (Key = VK_DELETE) and (Shift = [ssAlt]) then begin
    fsSearchData := '';
    QrySerialNumbers.First;
  end else if SearchCharpressed then begin
    fsSearchData:=fsSearchData +Chr(Key);
    DoSearch;
  end;

end;

procedure TfmSerialjobNumbers.InitERPLookupCombonFields;
begin
  inherited;
end;

procedure TfmSerialjobNumbers.grdmainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not QrySerialNumbersActive.AsBoolean   then begin
      Afont.Color := clInactiveCaption;
  end else begin
      Afont.Color := clblack;
  end;

end;
{}
procedure TfmSerialjobNumbers.grdmainDblClick(Sender: TObject);
begin
  inherited;
  if SerialNo.Active = False then begin
    SerialNo.Active := true;
    SerialNo.PostDB;
  end;
end;

initialization
  RegisterClassOnce(TfmSerialjobNumbers);

end.
