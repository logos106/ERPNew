unit frmPrintRepots;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjTemplateOptions, Grids, Wwdbigrd,
  Wwdbgrid, wwdblook, Mask, wwdbedit, Wwdotdot, Wwdbcomb;

type

  TfmPrintRepots = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    wwDBGrid1: TwwDBGrid;
    qryTemplateOptions: TERPQuery;
    dsTemplateOptions: TDataSource;
    qrytemplatesLookup: TERPQuery;
    cbotemplatesLookup: TwwDBLookupCombo;
    qryTemplateOptionsID: TIntegerField;
    qryTemplateOptionsTemplateID: TIntegerField;
    qryTemplateOptionsTemplateName: TWideStringField;
    qryTemplateOptionsFormID: TIntegerField;
    qryTemplateOptionsUserId: TIntegerField;
    qryTemplateOptionsPrinterName: TWideStringField;
    qryTemplateOptionsPrint: TWideStringField;
    qryTemplateOptionsPreview: TWideStringField;
    qryTemplateOptionsEmail: TWideStringField;
    qryTemplateOptionsActive: TWideStringField;
    qryTemplateOptionsmsTimestamp: TDateTimeField;
    qryTemplateOptionsmsupdatesitecode: TWideStringField;
    qrytemplatesLookuptemplid: TIntegerField;
    qrytemplatesLookuptemplname: TWideStringField;
    cboPrinterList: TwwDBComboBox;
    qryTemplateOptionstypeID: TIntegerField;
    qryemployee: TERPQuery;
    qryTemplateOptionsEmployeeName: TWideStringField;
    cboEmployees: TwwDBLookupCombo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure cbotemplatesLookupCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryTemplateOptionsAfterInsert(DataSet: TDataSet);
  private
    TemplateOptions: TTemplateOptions;
    fsTemplateType: String;
    fsformName: string;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    //procedure NewRecord;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CommitAndNotify;override;
  public
    Property TemplateType:String read fsTemplateType write fsTemplateType;
    Property formName :string read fsformName write fsformName;
    Procedure  Printreports(aTemplatetype, aformname :string; OnPrint:TPrintTemplateEvent); Overload;
    class Procedure  DoPrintTemplateReport(AOwner:Tcomponent;aTemplatetype, aformname :string; OnPrint:TPrintTemplateEvent);
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, tcDataUtils , printers, LogLib,
  PreferancesLib;

{$R *.dfm}

procedure TfmPrintRepots.cbotemplatesLookupCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  TemplateOptions.TemplateId :=qrytemplatesLookuptemplid.asInteger;
end;

procedure TfmPrintRepots.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmPrintRepots.SaveRecord :Boolean;
begin
  result:= False;
  TemplateOptions.PostDB;
  if not(TemplateOptions.Save) then exit;
  Result:= True;

end;

procedure TfmPrintRepots.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  TemplateOptions.Connection.CommitTransaction;
  PreferancesLib.DoPrefAuditTrail;
  Self.Close;

end;

procedure TfmPrintRepots.btnPrintClick(Sender: TObject);
begin
  inherited;
   if not SaveRecord then exit;
  TemplateOptions.Connection.CommitTransaction;
  modalresult := mryes;
  Self.Close;
end;

procedure TfmPrintRepots.CommitAndNotify;
begin
  inherited;
  CommitTransaction;

  Notify;

end;

procedure TfmPrintRepots.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TTemplateOptions then TTemplateOptions(Sender).Dataset  := qryTemplateOptions;
     end;
end;



procedure TfmPrintRepots.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if TemplateOptions.Dirty then begin
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
          TemplateOptions.Dirty := false;
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

procedure TfmPrintRepots.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  cboPrinterList.items.Clear;
  for ctr:= 0 to Printer.Printers.count-1 do
    cboPrinterList.items.add(Printer.Printers[ctr]+#9+Printer.Printers[ctr]);

   NewBusObjinstance;
end;
procedure TfmPrintRepots.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
end;

procedure TfmPrintRepots.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  TemplateOptions := TTemplateOptions.CreateWithNewConn(Self);
  TemplateOptions.Connection.connection := Self.MyConnection;
  TemplateOptions.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}

end;

(*procedure TfmPrintRepots.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;*)

procedure TfmPrintRepots.Openrec;
var
  s:String;
begin
  s := '';
  if (TemplateType <> '') then s := ' typeid = ' + inttostr(TemplateTypeID(TemplateType));
  if (Formname     <> '') then begin if s<> '' then s:= s +' and '; s := '  formId = ' + inttostr(getformID(Formname));end;
  TemplateOptions.LoadSelect(s);
  TemplateOptions.connection.BeginTransaction;
  if TemplateOptions.count=0 then TemplateOptions.new;
  if (TemplateType <> '')  then qrytemplatesLookup.ParamByName('typeID').AsInteger  := TemplateTypeID(TemplateType) else qrytemplatesLookup.ParamByName('typeID').AsInteger  := 0;
  openQueries;
  TemplateOptions.Dirty := false;
end;

procedure TfmPrintRepots.qryTemplateOptionsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  TemplateOptions.FormID := getformID(Formname);
  TemplateOptions.typeId := TemplateTypeID(TemplateType);
end;
procedure TfmPrintRepots.Printreports(aTemplatetype, aformname: string;OnPrint: TPrintTemplateEvent);
begin
  Templatetype      := aTemplatetype;
  formname          := aformname;
  btnPrint.Visible  := Assigned(OnPrint);
  ShowModal;
  if modalresult = mryes then if assigned(OnPrint) then OnPrint(Self.TemplateOptions);
end;

class procedure TfmPrintRepots.DoPrintTemplateReport(AOwner:Tcomponent;aTemplatetype, aformname: string;  OnPrint: TPrintTemplateEvent(*; aApplyTemplateType ,aApplyFormfilter:Boolean*));
var
  form : TfmPrintRepots;
begin
  form := TfmPrintRepots.Create(AOwner);
  try
    form.Printreports(aTemplatetype, aformname , OnPrint );
  finally
    Freeandnil(form);
  end;
end;

initialization
  RegisterClassOnce(TfmPrintRepots);

end.

