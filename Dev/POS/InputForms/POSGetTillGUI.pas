unit POSGetTillGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DB,  BaseInputForm,
  Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, MemDS,
  Shader, DNMPanel, ProgressDialog, ImgList;

type
  TPOSGetTillPopUp = class(TBaseInputGUI)
    btnOK: TDNMSpeedButton;
    dsTills: TDataSource;
    qryTills: TERPQuery;
    lbxTills: TListBox;
    btnPermanent: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPermanentClick(Sender: TObject);
  private
    { Private declarations }
    lstTills: TStringList;
    procedure PopulateTillCombo;
    procedure AssignTill;
  public
    { Public declarations }
    fiTillID: integer;
    function IsOkToAllocate(bIsPermanent: boolean): boolean;
  end;


implementation

uses FastFuncs,Forms, CommonDbLib, CommonLib;

{$R *.dfm}

procedure TPOSGetTillPopUp.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  fiTillID := 0;
  lstTills := TStringList.Create;
  qryTills.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTills.Open;
  PopulateTillCombo;
end;

procedure TPOSGetTillPopUp.PopulateTillCombo;
var
  sTill: string;
begin
  if not qryTills.IsEmpty then begin
    lbxTills.Items.Clear;
    qryTills.First;
    while not qryTills.Eof do begin
      sTill := Trim(qryTills.FieldByName('TillName').AsString);
      lstTills.Add(sTill);
      if not Empty(qryTills.FieldByName('ComputerName').AsString) then begin
        sTill := sTill + ' (' + qryTills.FieldByName('ComputerName').AsString + ')';
      end;
      lbxTills.Items.Add(sTill);
      qryTills.Next;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('No Active Tills Registered In Database', mtWarning, [mbOK], 0);
  end;
  lbxTills.ItemIndex := 0;
end;

procedure TPOSGetTillPopUp.btnOKClick(Sender: TObject);
begin
  if IsOkToAllocate(false) then begin
    AssignTill;
    Self.Close;
  end;
end;

function TPOSGetTillPopUp.IsOkToAllocate(bIsPermanent: boolean): boolean;
var
  sTill: string;
  sMsg: string;
begin
  Result := false;
  if not (lbxTills.ItemIndex >= 0) then Exit;
  sTill := lstTills.Strings[lbxTills.ItemIndex];
  qryTills.Connection := MyConnection;
  if not qryTills.Active then qryTills.Open;
  if qryTills.Locate('TillName', sTill, [loCaseInsensitive]) then begin
    if Empty(qryTills.FieldByName('ComputerName').AsString) then begin
      Result := true;
    end else begin
      if bIsPermanent then begin
        sMsg := 'The Selected Till is Already Permanently Allocated to ' +
          qryTills.FieldByName('ComputerName').AsString + '.'#10#13'Do you wish to transfer this Allocation to your Computer?';
      end else begin
        sMsg := 'The Selected Till is Permanently Allocated to ' + qryTills.FieldByName('ComputerName').AsString +
          '.'#10#13'Do you still wish to use it?';
      end;
      if CommonLib.MessageDlgXP_Vista(sMsg, mtWarning, [mbYes, mbCancel], 0) = mrYes then begin
        Result := true;
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('TPOSGetTillPopUp(IsOkToAllocate): Till could not be Allocated', mtWarning, [mbOK], 0);
  end;
end;

procedure TPOSGetTillPopUp.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstTills);
  inherited;
end;

procedure TPOSGetTillPopUp.btnPermanentClick(Sender: TObject);
begin
  inherited;
  if IsOkToAllocate(true) then begin
    AssignTill;
    qryTills.Edit;
    qryTills.FieldByName('ComputerName').AsString := GetPCName;
    qryTills.Post;
    qryTills.Close;
  end;
  self.Close;
end;

procedure TPOSGetTillPopUp.AssignTill;
begin
  if not (lbxTills.ItemIndex >= 0) then Exit;
  with qryTills do begin
    filtered := false;
    filter   := 'TillName = ' + QuotedStr(lstTills[lbxTills.ItemIndex]);
    filtered := true;
    if not IsEmpty then begin
      fiTillID := FieldByName('TillID').AsInteger;
    end else begin
      CommonLib.MessageDlgXP_Vista('Till not found in table tblPOSTills',
        mtWarning, [mbOK], 0);
      fiTillID := 0;
    end;
  end;
end;

Initialization
  RegisterClassOnce(TPOSGetTillPopUp);

end.
