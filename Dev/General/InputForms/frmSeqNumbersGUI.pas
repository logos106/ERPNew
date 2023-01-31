unit frmSeqNumbersGUI;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 19/04/05  1.00.01 IJB  Fixed bug with form opening in read only.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  StdCtrls, MemDS, Mask, DBCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  wwcheckbox, DataState, Menus, AdvMenus, Shader, ImgList, ProgressDialog;

type
  TfmSeqNumbersGUI = class(TBaseInputGUI)
    qrySeqNum: TERPQuery;
    dsSeqNum: TDataSource;
    pnlBottom: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtValue: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtMin: TDBEdit;
    Label3: TLabel;
    edtMax: TDBEdit;
    Label4: TLabel;
    edtStep: TDBEdit;
    cbxRecycle: TwwCheckBox;
    Label5: TLabel;
    Bevel1: TBevel;
    edtPadTopDigits: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    lblPaddedValue: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure dsSeqNumDataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoSequenceNumberConfig(const SeqName, FormCaption: string; FormAccessLevel: integer; CreateSeqIfNotFound: boolean = false);


implementation

{$R *.dfm}

uses
  DnMExceptions, CommonDbLib, CommonLib,
  FastFuncs, PreferancesLib;

procedure DoSequenceNumberConfig(const SeqName, FormCaption: string; FormAccessLevel: integer;
  CreateSeqIfNotFound: boolean = false);
var
  qry: TERPQuery;
  Id: integer;
begin
  Id := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   := 'SELECT * FROM tblSeqNumbers WHERE SeqName = ' + QuotedStr(SeqName);
    qry.Open;
    if qry.IsEmpty and CreateSeqIfNotFound then begin
      qry.Close;
      qry.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblSeqNumbers SET' + ' SeqName = ' + QuotedStr(SeqName) + ',' +
        ' SeqValue = 0,' + ' SeqMin = 1,' + ' SeqMax = 0,' + ' SeqStep = 1,' + ' SeqRecycle = "F",' + ' PadToDigits = 0';
      qry.Execute;
      qry.Close;
      qry.SQL.Text := 'Select * from tblSeqNumbers where SeqName = ''' + SeqName + '''';
      qry.Open;
    end;
    if not qry.IsEmpty then Id := qry.FieldByName('Id').AsInteger;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
  if Id > 0 then begin
    with TfmSeqNumbersGUI.CreateWithAccessLevel(Application, FormAccessLevel) do begin
      if FormCaption <> '' then begin
        Caption := StringReplace(Caption, 'Sequence Number', FormCaption,[rfReplaceAll,rfIgnoreCase]);
        TitleLabel.Caption := FormCaption;
      end;
      KeyId := Id;
      FormStyle := fsMdiChild;
      BringToFront;
    end;
  end;
end;

procedure TfmSeqNumbersGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfmSeqNumbersGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      if ErrorOccurred then Exit;

      // set controlls based on access level
      { 1  - (Full Access)
        2  - (Full Access, No Delete)
        3  - (Create + Read)
        5  - (Read Only)
        6  - (No Access)  }

      if AccessLevel > 2 then qrySeqNum.ReadOnly := true
      else qrySeqNum.ReadOnly := false;

      qrySeqNum.Close;
      qrySeqNum.Params.ParamByName('Id').AsInteger := Self.KeyID;
      Self.OpenQueries;

      if qrySeqNum.FieldByName('PadToDigits').AsInteger > 0 then lblPaddedValue.Caption :=
          CommonLib.LeftPadStr(qrySeqNum.FieldByName('SeqValue').AsString, qrySeqNum.FieldByName('PadToDigits').AsInteger, '0')
      else lblPaddedValue.Caption := '';

      // Exception handler.
    except
      on EABort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfmSeqNumbersGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.CloseQueries;
  Action := caFree;
//  fmSeqNumbersGUI := nil;
  inherited;
end;

procedure TfmSeqNumbersGUI.btnOKClick(Sender: TObject);
begin
  inherited;
  if qrySeqNum.State in [dsEdit, dsInsert] then qrySeqNum.Post;
  PreferancesLib.DoPrefAuditTrail;
  Close;
end;

procedure TfmSeqNumbersGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  if qrySeqNum.State in [dsEdit, dsInsert] then qrySeqNum.Cancel;
  Close;
end;

procedure TfmSeqNumbersGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  CanClose := true;
  if qrySeqNum.FieldByName('PadToDigits').AsInteger > 0 then begin
    if (qrySeqNum.FieldByName('SeqMax').AsInteger > 0) and
      (char_length(qrySeqNum.FieldByName('SeqMax').AsString) > qrySeqNum.FieldByName('PadToDigits').AsInteger) then begin
      CommonLib.MessageDlgXP_Vista('Pad To Width is to small for this Max Value', mtWarning, [mbOK], 0);
      CanClose := false;
    end else if (qrySeqNum.FieldByName('SeqMax').AsInteger = 0) and
      (char_length(IntToStr(High(integer))) > qrySeqNum.FieldByName('PadToDigits').AsInteger) then begin
      CommonLib.MessageDlgXP_Vista('Pad To Width is to small for the defailt maximum value of: ' + IntToStr(High(integer)),
        mtWarning, [mbOK], 0);
      CanClose := false;
    end;
  end;
end;

procedure TfmSeqNumbersGUI.dsSeqNumDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if qrySeqNum.FieldByName('PadToDigits').AsInteger > 0 then lblPaddedValue.Caption :=
      CommonLib.LeftPadStr(qrySeqNum.FieldByName('SeqValue').AsString, qrySeqNum.FieldByName('PadToDigits').AsInteger, '0')
  else lblPaddedValue.Caption := '';
end;

initialization
  RegisterClassOnce(TfmSeqNumbersGUI);

end.
