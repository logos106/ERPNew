unit PoolProfileTestList;
  { Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
  23/03/05  1.00.00  BJ  Initial verson.
  16/01/06  1.00.01  BJ  Changes made so that the form can be called from the pool
                         Profile form for a selected pool and from the main menu for the
                         list of pool tests done for all customers.   }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls, ProgressDialog, kbmMemTable, CustomInputBox,
  wwdblook, Shader;

type
  TPoolProfileTestListGUI = class(TBaseListingGUI)
    qryMainAlgaeDefaultID: TIntegerField;
    qryMainPoolProfileID: TIntegerField;
    qryMainTemperature: TFloatField;
    qryMainTDS: TIntegerField;
    qryMainStabilizerLevel: TFloatField;
    qryMainTotalSanitizer: TFloatField;
    qryMainFreeSanitizer: TFloatField;
    qryMainpH: TFloatField;
    qryMainAlkalineDemand: TFloatField;
    qryMainTotalAlkalinity: TFloatField;
    qryMainCalciumHardness: TFloatField;
    qryMainMetals: TFloatField;
    qryMainPhosphate: TFloatField;
    qryMainSalt: TFloatField;
    qryMainDateOfTest: TDateField;
    qryMainAlgaeName: TStringField;
    actNew: TAction;
    actdblClickGird: TAction;
    qryMainActive: TStringField;
    qryMainCompany: TStringField;
    qryMainPhone: TStringField;
    qryMainFaxNumber: TStringField;
    qryMainMobile: TStringField;
    qryMainVolume: TIntegerField;
    qryMainLocation: TStringField;
    qryMainConstruction: TStringField;
    qryMainSanitizer: TStringField;
    qryMainUsesMSA: TStringField;
    qryMainIsSpa: TStringField;
    qryMainSaltRequired: TIntegerField;
    qryMainPoolTestsID: TIntegerField;
    qryProfile: TMyQuery;
    qryProfileCompany: TStringField;
    qryProfileAddress: TStringField;
    qryProfilePhone: TStringField;
    qryProfileFaxNumber: TStringField;
    qryProfileMobile: TStringField;
    qryProfilePoolProfileID: TIntegerField;
    qryProfileClient: TStringField;
    qryProfileVolume: TIntegerField;
    qryProfileLocation: TStringField;
    qryProfileConstruction: TStringField;
    qryProfileSanitizer: TStringField;
    qryProfileUsesMSA: TStringField;
    qryProfileIsSpa: TStringField;
    qryProfileSaltRequired: TIntegerField;
    qryProfileDateEntered: TDateField;
    qryProfileGlobalRef: TStringField;
    qryProfileActive: TStringField;
    qryMainTurbidity: TStringField;
    qryMainSanitizerlvl: TIntegerField;
    qryProfileSanitizerlvl: TIntegerField;
    qryMainStreet: TStringField;
    qryMainStreet2: TStringField;
    qryMainSuburb: TStringField;
    qryMainState: TStringField;
    qryMainCountry: TStringField;
    qryMainPostcode: TStringField;
    qryProfileconstruct: TStringField;
    qryProfileSanit: TStringField;
    qryProfileClientID: TIntegerField;
    qryMainAddress: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actdblClickGirdExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
    fiPoolProfileId: integer;
    profileIdfornew :Integer;
    procedure GetProfileID(grdMain: TwwDbGrid);
  public
    { Public declarations }
    property PoolProfileId: integer read fiPoolProfileId write fiPoolProfileId;
    //class function Instance: TBaseListingGUI;
  end;

//var
//  PoolProfileTestListGUI: TPoolProfileTestListGUI;

implementation

uses FastFuncs,frmPoolProfileTest, CommonLib, PoolProfileList, Forms;

{$R *.dfm}

procedure TPoolProfileTestListGUI.FormShow(Sender: TObject);
var
    i :Integer;
begin
  inherited;

  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  if qrymain.Active then qrymain.Close;
  if fiPoolProfileId <> 0 then begin
    for i:= 0 to Qrymain.Sql.Count-1 do
        qrymain.SQL[i] := ReplaceStr(qrymain.SQL[i] ,
                                     'WHERE ' ,
                                     'Where  tblpooltests.PoolProfileID = ' + FastFuncs.IntToStr(fiPoolProfileId ) + ' AND ');
  end;
  with qryMain do begin
      ParamByName('txtfrom').AsDate := dtFrom.DateTime;
      ParamByName('txtto').AsDate := dtTo.DateTime;
      Open;
    end;
  with qryProfile do begin
    if Active then Close;
    Parambyname('PoolProfileID').AsInteger := fiPoolProfileId;
    Open;
  end;

end;

procedure TPoolProfileTestListGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  // If user does not have access to this form so don't process any further
  if ErrorOccurred then Exit;
end;

procedure TPoolProfileTestListGUI.GetProfileID(grdMain: TwwDbGrid);
begin
  profileIdfornew  := grdMain.DataSource.DataSet.FieldByName('PoolProfileId').AsInteger;
end;

procedure TPoolProfileTestListGUI.actNewExecute(Sender: TObject);
var
    frm :TComponent;

begin
  inherited;
  {when the test list is directly called from the menu, new should select the prool
  profile before adding a enw record.}
  profileIdfornew :=fiPoolProfileId;
  if profileIdfornew = 0 then begin
    frm := GetComponentByClassName('TPoolProfileListGUI');
    if Assigned(frm) then begin
      with TPoolProfileListGUI(frm) do try
        OnGridDataSelect := GetProfileID;
        FormShow(frm);
        //frm.Caption := frm.Caption + '  Double click to select Pool Profile for which the test is to be created';
        ShowModal;
        {if the pool profile is not selected then new test cannot be added}
        if profileIdfornew = 0 then Exit;
        if qryProfile.Active then qryProfile.close;
        qryProfile.Params.Parambyname('PoolProfileID').asInteger :=profileIdfornew;
        qryProfile.Open;
      finally
        freeandnil(frm);
      end;
    end;  
  end;

  frm := TfmPoolProfileTest(GetComponentByClassName('TfmPoolProfileTest'));
  if Assigned(frm) then begin
    with TfmPoolProfileTest(frm) do begin
      KeyId := 0;
      PoolProfileId           := profileIdfornew;
      edtCompany.Text         := qryProfile.FieldByName('Company').AsString;
      edtAddress.Text         := qryProfile.FieldByName('Address').AsString;
      edtPhone.Text           := qryProfile.FieldByName('Phone').AsString;
      edtFax.Text             := qryProfile.FieldByName('FaxNumber').AsString;
      //edtMobile.Text        := qryProfile.FieldByName('Mobile').AsString;
      edtlocation.Text        := qryProfile.FieldByName('Location').AsString;
      edtSanitName.Text       := qryProfile.FieldByName('Sanit').AsString;
      edtSanitizer.Text       := qryProfile.FieldByName('Sanitizer').AsString;
      edtSanitizerLvl.Text    := qryProfile.FieldByName('Sanitizerlvl').AsString;
      edtVolume.Text          := qryProfile.FieldByName('Volume').AsString;
      edtConstructName.Text   := qryProfile.FieldByName('Construct').AsString;
      edtConstruction.Text    := qryProfile.FieldByName('Construction').AsString;
      cbxMSA.Checked          := qryProfile.FieldByName('UsesMSA').AsBoolean;
      cbxSpa.Checked          := qryProfile.FieldByName('IsSpa').AsBoolean;
      FormStyle               := fsMdiChild;
      BringToFront;
    end;
  end;  
end;

procedure TPoolProfileTestListGUI.actdblClickGirdExecute(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if qryMain.RecordCount = 0 then Exit;
  form := GetComponentByClassName('TfmPoolProfileTest');
  if Assigned(Form) then begin
    with  TfmPoolProfileTest(GetComponentByClassName('TfmPoolProfileTest')) do begin
      KeyId := qryMain.FieldByName('PoolTestsID').AsInteger;
      if fiPoolProfileId = 0 then begin
          fiPoolProfileId := qryMainPoolProfileID.asInteger;
          with qryProfile do begin
              if Active then Close;
              Parambyname('PoolProfileID').AsInteger := fiPoolProfileId;
              Open;
          end;
      end;
      PoolProfileId        := fiPoolProfileId;
      edtCompany.Text      := qryProfile.FieldByName('Company').AsString;
      edtAddress.Text      := qryProfile.FieldByName('Address').AsString;
      edtPhone.Text        := qryProfile.FieldByName('Phone').AsString;
      edtFax.Text          := qryProfile.FieldByName('FaxNumber').AsString;
      //edtMobile.Text     := qryProfile.FieldByName('Mobile').AsString;
      edtlocation.Text     := qryProfile.FieldByName('Location').AsString;
      edtSanitName.Text    := qryProfile.FieldByName('Sanit').AsString;
      edtSanitizer.Text    := qryProfile.FieldByName('Sanitizer').AsString;
      edtSanitizerLvl.Text := qryProfile.FieldByName('Sanitizerlvl').AsString;
      edtVolume.Text       := qryProfile.FieldByName('Volume').AsString;
      edtConstructName.Text:= qryProfile.FieldByName('Construct').AsString;
      edtConstruction.Text := qryProfile.FieldByName('Construction').AsString;
      cbxMSA.Checked       := qryProfile.FieldByName('IsSpa').AsBoolean;
      cbxSpa.Checked       := qryProfile.FieldByName('UsesMSA').AsBoolean;
      FormStyle            := fsMdiChild;
      Top := 10;
      BringToFront;
      //fiPoolProfileId := 0;
    end;
  end;
end;

procedure TPoolProfileTestListGUI.FormActivate(Sender: TObject);
begin
  inherited;
  if QryMain.Active then   QryMain.Refresh;
end;

procedure TPoolProfileTestListGUI.cmdNewClick(Sender: TObject);
begin
  actNewExecute(Sender);
end;

initialization
  RegisterClassOnce(TPoolProfileTestListGUI);

end.
