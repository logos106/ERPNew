{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/06/05  1.00.01 BJ   Added new field in the table to indicate a fixed rate service.
                        When a fixedrate service is selected in the appointment, the
                        Rate will not be multiplied by the time, just the rate is
                        the total amount.
 19/10/05  1.00.02 DLS  Added RegisterClass
}
unit frmRepServicesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, DNMPanel, DB,
  StdCtrls, Mask, DBCtrls, Buttons, DNMSpeedButton, AppEvnts, wwcheckbox, SelectionDialog, 
  kbmMemTable, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader,
  ImgList;

type
  TfrmRepServices = class(TBaseInputGUI)
    qryServices: TERPQuery;
    dsService: TDataSource;
    txtDesc: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label4: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel2: TBevel;
    wwCheckBox3: TwwCheckBox;
    memQryServices: TkbmMemTable;
    qryServicesGlobalRef: TWideStringField;
    qryServicesServiceID: TAutoIncField;
    qryServicesServiceDesc: TWideStringField;
    qryServicesActive: TWideStringField;
    qryServicesIsSoftware: TWideStringField;
    qryServicesIsHardware: TWideStringField;
    qryServicesCreationDate: TDateField;
    qryServicesUpdateDate: TDateField;
    qryServicesStandardRate: TFloatField;
    qryServicesRanking: TSmallintField;
    qryServicesEditedFlag: TWideStringField;
    Label7: TLabel;
    wwCheckBox4: TwwCheckBox;
    qryServicesIsFixedRate: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure qryServicesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    fsServiceDesc: string;
    fsNewService: string;
    fiNewServiceID: integer;
  end;

implementation

uses
  FormFactory, DNMExceptions, CommonLib, DNMLib, FastFuncs;

{$R *.dfm}

procedure TfrmRepServices.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    try
      if qryServices.Active then begin
        if not (qryServices.State in [dsBrowse]) then begin
          qryServices.Post;
          Notify;
        end;
        CloseQueries;
      end;

      qryServices.ParamByName('xServiceID').asInteger := KeyID;
      OpenQueries;

      if KeyID = 0 then begin
        qryServices.Insert;
        qryServices.FieldByName('StandardRate').AsCurrency := 0.00;
        qryServices.FieldByName('ServiceDesc').AsString := fsServiceDesc;
        qryServices.FieldByName('Active').AsString := 'T';
      end else begin
        qryServices.Edit;
      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmRepServices.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  inherited;
  Action := caFree;
end;

procedure TfrmRepServices.btnSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    try
      if char_length(txtDesc.Text) <> 0 then begin
        if not (qryServices.State in [dsBrowse]) then begin
          qryServices.Post;
          fiNewServiceID := qryServices.FieldByName('ServiceID').AsInteger;
          fsNewService := Trim(qryServices.FieldByName('ServiceDesc').AsString);

          ProcessEditedFlag('Main', Self, memqryServices, qryServices, nil);
          qryServices.Edit;
          qryServices.Post;

          Notify(False);
        end;
        Self.Close;
      end else begin
        CommonLib.MessageDlgXP_Vista('Service Description cannot be blank.', mtWarning, [mbOK], 0);
        SetControlFocus(txtDesc);
      end;
    except
      on EAbort do HandleEAbortException;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmRepServices.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmRepServices.qryServicesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryServices, memqryServices);
end;

initialization
  RegisterClassOnce(TfrmRepServices);
  with FormFact do begin
    RegisterMe(TfrmRepServices, 'TRepServicesListGUI_*=ServiceID');
    RegisterControl(TfrmRepServices, '*_cboServiceID=ServiceID');
    RegisterControl(TfrmRepServices, '*_dboService=ServiceID');
  end;
end.
