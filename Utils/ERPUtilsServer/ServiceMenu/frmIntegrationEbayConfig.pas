Unit frmIntegrationEbayConfig;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, FrmConfigBase, Shader, ExtCtrls, DNMPanel, DNMSpeedButton, StdCtrls, JSONObject, ComCtrls, Mask, Wwdbedit,
  Wwdotdot, Wwdbcomb, DB, DBAccess, MyAccess, wwdbdatetimepicker, Grids,
  Wwdbigrd, Wwdbgrid ;

Type
  TfmIntegrationEbayConfig = Class(TfmConfigBase)
    Label2: TLabel;
    EdtAcountName: TEdit;
    Label3: TLabel;
    EdtUserTocken: TMemo;
    Label4: TLabel;
    EdtAppID: TEdit;
    EdtDevID: TEdit;
    Label5: TLabel;
    EdtCertID: TEdit;
    Label6: TLabel;
    EdtReqVersion: TEdit;
    edtEbayCustomer: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    CboDatabases: TwwDBComboBox;
    DtNextDate: TwwDBDAteTimePicker;
    Label9: TLabel;
    RgSiteIntegrationLoggingLevel: TRadioGroup;
    Label10: TLabel;
    DtFrom: TwwDBDAteTimePicker;
    Label11: TLabel;
    btnchooseCustomer: TDNMSpeedButton;
    chkSingleCustomer: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnchooseCustomerClick(Sender: TObject);
  Private
    procedure GetDataBases;
    procedure OnChooseEbayCustomer(Sender: TwwDBGrid);
    function ValidCustomerforDB(AOwner: Tcomponent; dbname,
      customername: String): Boolean;
  Protected
    //function MakeinStance :TfmConfigBase;Override;
    Procedure initIt(form :TfmConfigBase);Override;
    Procedure SaveIt(form :TfmConfigBase);Override;
    function ValidateData:Boolean;Override;
  Public
    { Public declarations }
  End;

Implementation

Uses
  DAteUtils , Vista_MessageDlg , ERPdbComponents, MySQLUtils, DbConst(*, tcconst,
  tcDataUtils, CommonFormLib, CommonDbLib*);

{$R *.dfm}
{ TfmConfigBase1 }


procedure TfmIntegrationEbayConfig.btnchooseCustomerClick(Sender: TObject);
var
  conn :TERPConnection;
begin
  inherited;
  {binny - the following is commented off temporarly for the service menu to work}
  (*if cboDatabases.text='' then begin
    MessageDlgXP_Vista('Please Choose the Database, before Choosing Customer', mtWarning, [mbOK], 0);
    Exit;
  end;
  conn:=GetNewMyDacConnection(self, cboDatabases.text);
  try
    OpenERPListFormSingleselectModal('TCustomerExpressListGUI', OnChooseEbayCustomer, nil,False, conn );
  finally
    Freeandnil(Conn);
  end;*)
end;
procedure TfmIntegrationEbayConfig.OnChooseEbayCustomer(Sender :TwwDBGrid);
begin
  try
    edtEbayCustomer.text := Sender.datasource.Dataset.Fieldbyname('company').asString;
    chkSingleCustomer.checked := trim(edtEbayCustomer.text)<> '';
  Except

  end;
end;
procedure TfmIntegrationEbayConfig.FormCreate(Sender: TObject);
begin
  inherited;
  chkSingleCustomer.caption := '  Use Single ERP Customer'+chr(13)+'  for Ebay Orders';
end;

procedure TfmIntegrationEbayConfig.FormShow(Sender: TObject);
begin
  inherited;
  GetDataBases;
end;

procedure TfmIntegrationEbayConfig.GetDataBases;
var
  conn : TERPConnection;
  st:TStringlist;
  ctr:Integer;
begin
  conn :=  TERPConnection.Create(Self);
  try
    SetConnectionProps(conn, SERVICES_DATABASE , UtilsClient.Client.ServerName);
    conn.Connect;
    cboDatabases.Items.Clear;
    st:= TStringlist.Create;
    try
      st.CommaText:= DatabaseList(Conn, True);
      for ctr:= 0 to st.Count -1 do
        if sametext(st[ctr] , 'erpnewdb') then
        else cboDatabases.Items.Add(st[ctr]);
    finally
      Freeandnil(st);
    end;
    Conn.Disconnect;
  finally
    Freeandnil(Conn);
  end;
end;
procedure TfmIntegrationEbayConfig.initIt(form: TfmConfigBase);
begin
  inherited;
  if not(form is   TfmIntegrationEbayConfig) then exit;
  with TfmIntegrationEbayConfig(form) do begin
    EdtAcountName.Text := ConfigObj.S['Name'];
    EdtUserTocken.Lines.Clear;
    EdtUserTocken.Lines.Text := ConfigObj.S['UserTocken'];
    EdtAppID.Text            := ConfigObj.S['AppID'];
    EdtDevID.Text            := ConfigObj.S['DevID'];
    EdtCertID.Text           := ConfigObj.S['CertID'];
    //EdtReqVersion.Text       := ConfigObj.S['ReqVersion'];
    //if EdtReqVersion.Text = '' then EdtReqVersion.Text := '827';
    edtEbayCustomer.Text       := ConfigObj.S['EbayCustomer'];
    chkSingleCustomer.Checked  := ConfigObj.B['SingleCustomer'];
    CboDatabases.Text        := ConfigObj.S['Database'];
    Try
      DtNextDate.Datetime      := ConfigObj.DT['NextSyncTime'];
    Except
      DtNextDate.Datetime   := Now;
    End;
    Try
      DtFrom.Date    := ConfigObj.DT['SyncDatefrom'];
    Except
      DtFrom.Date := IncDay(Date, -3);
    End;
    RgSiteIntegrationLoggingLevel.Itemindex := ConfigObj.I['LoggingLevel'];
    ChkActive.Checked                  := ConfigObj.B['Active'];
  end;
end;

(*function TfmIntegrationEbayConfig.MakeinStance: TfmConfigBase;
begin
  result:= TfmIntegrationEbayConfig.Create(Nil);
end;*)
Function TfmIntegrationEbayConfig.ValidCustomerforDB(AOwner:Tcomponent; dbname, customername:String):Boolean;
begin
  Result := True;
{binny - the following is commented off temporarly for the service menu to work}
(*REsult := tcdatautils.ValidCustomerforDB(AOwner, dbname, customername);*)
end;
procedure TfmIntegrationEbayConfig.SaveIt(form: TfmConfigBase);
begin
  inherited;
  if not(form is   TfmIntegrationEbayConfig) then exit;
  with TfmIntegrationEbayConfig(form) do begin
      ConfigObj.S['Name']          := EdtAcountName.Text;
      ConfigObj.S['UserTocken']    := EdtUserTocken.Lines.Text;
      ConfigObj.S['AppID']         := EdtAppID.Text;
      ConfigObj.S['DevID']         := EdtDevID.Text;
      ConfigObj.S['CertID']        := EdtCertID.Text;
      //ConfigObj.S['ReqVersion']    := EdtReqVersion.Text;
      ConfigObj.B['SingleCustomer']:= chkSingleCustomer.Checked;
      if (edtEbayCustomer.Text <> '') and (ValidCustomerforDB(self, CboDatabases.Text,edtEbayCustomer.Text)) then begin
        ConfigObj.S['EbayCustomer']  := edtEbayCustomer.Text;
      end else begin
        MessageDlgXP_Vista('This is not a Valid Customer for Databsae '+ quotedstr(CboDatabases.Text), mtWarning, [mbOK], 0);
        ConfigObj.S['EbayCustomer']  := '';
        ConfigObj.B['SingleCustomer']:= False;
      end;
      ConfigObj.S['Database']      := CboDatabases.Text;
      ConfigObj.DT['NextSyncTime'] := DtNextDate.Datetime;
      ConfigObj.DT['SyncDatefrom'] := DtFrom.Date;
      ConfigObj.I['LoggingLevel'] := RgSiteIntegrationLoggingLevel.Itemindex;
      ConfigObj.B['Active']       := ChkActive.Checked;
  end;
end;

function TfmIntegrationEbayConfig.ValidateData: Boolean;
begin
  REsult:= False;
  if edtAcountName.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Account Name is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtAppID.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('App-ID  is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtDEVID.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Dev-ID  is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if edtCertID.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Cert ID  is missing',mtInformation,[mbOk],0);
    exit;
  end;
(*  if EdtReqVersion.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Required Version  is missing',mtInformation,[mbOk],0);
    exit;
  end;*)
  if cboDatabases.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Database  is missing',mtInformation,[mbOk],0);
    exit;
  end;
  if dtNextDate.Datetime = 0 then dtNextDate.DateTime := now;
  if DtFrom.DateTime     = 0 then DtFrom.DateTime     := incday(Date , -3);
  REsult:= True;

end;

End.
