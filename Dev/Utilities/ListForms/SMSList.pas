unit SMSList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  HTMLUn2, HtmlView, SMSMessageObj, wwcheckbox;

type
  TSMSListGUI = class(TBaseListingGUI)
    qryMainContactId: TIntegerField;
    qryMainContact: TWideStringField;
    qryMainCustomerId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSupplierId: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainEmployeeId: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainOtherContactId: TIntegerField;
    qryMainOtherContactName: TWideStringField;
    qryMainMarketingContactId: TIntegerField;
    qryMainMarketingContactName: TWideStringField;
    qryMainSubject: TWideStringField;
    qryMainDateTime: TDateTimeField;
    qryMainActive: TWideStringField;
    qryMainMessageFrom: TWideStringField;
    qryMainMessageTo: TWideStringField;
    qryMainMessageId: TWideStringField;
    qryMainMessageData: TBlobField;
    HtmlViewer: THtmlViewer;
    qryMainStatus: TWideStringField;
    qryMainCost: TFloatField;
    qryMainCurrencyCode: TWideStringField;
    qryMainRefType: TWideStringField;
    btnResend: TDNMSpeedButton;
    qryMainRefId: TIntegerField;
    procedure grdMainRowChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure btnResendClick(Sender: TObject);
  private
    SMSMsg: TSMSMessage;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  SMSListGUI: TSMSListGUI;

implementation

uses
  StringUtils, SystemLib, CommonDbLib, SMSUtilsGUI, AppEnvironment, IntegerLIstObj;

{$R *.dfm}

{ TSMSListGUI }

procedure TSMSListGUI.btnResendClick(Sender: TObject);
var
  x: integer;
  bm: TBookmark;
  IdList: TIntegerList;
  qry: TERPQuery;
begin
  inherited;
  qryMain.DisableControls;
  IdList := TIntegerList.Create;
  try
    bm := qryMain.GetBookmark;
    try
      for x := 0 to grdMain.SelectedList.Count -1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[x]);
        if SameText(qryMain.FieldByName('RefType').AsString,'SMS') and
           (qryMain.FieldByName('MessageTo').AsString <> '') then begin
           IdList.Add(qryMain.FieldByName('RefId').AsInteger);
//           qryMain.Edit;
//           qryMain.FieldByName('Status').AsString := 'Waiting';
//           qryMain.Post;
//           found := true;
        end;
      end;
      qryMain.GotoBookmark(bm);
      if IdList.Count > 0 then begin
        qry := TERPQuery.Create(nil);
        try
          qry.Connection := CommonDbLib.GetSharedMyDacConnection;
          qry.SQL.Add('update tblreference');
          qry.SQL.Add('set Status = "Waiting"');
          qry.SQL.Add('where RefId in (' + IdList.CommaText + ')');
          qry.Execute;
        finally
          qry.Free;
        end;
        AppEnv.UtilsClient.TriggerSMSSend;
      end;

    finally
      qryMain.FreeBookmark(bm);
    end;
  finally
    qryMAin.EnableControls;
    if IdList.Count > 0 then
      qryMain.Refresh;
    IdList.Free;
  end;
end;

procedure TSMSListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SMSMsg := TSMSMessage.Create;
end;

procedure TSMSListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  SMSMsg.Free;
end;

procedure TSMSListGUI.grdMainRowChanged(Sender: TObject);
var
  stream: TStream;
begin
  inherited;
  HtmlViewer.Clear;
  stream := qryMain.CreateBlobStream(qryMainMessageData,bmRead);
  try
    SMSMsg.ReadFromStream(stream);
  finally
    stream.Free;
  end;
  HtmlViewer.LoadFromString(SMSMsg.AsHtml);
end;

procedure TSMSListGUI.HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
  var Handled: Boolean);
begin
  inherited;
  SMSUtilsGUI.PlayMessages(SRC);
end;

procedure TSMSListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('DateFrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('DateTo').AsDate := dtTo.DateTime;
  inherited;
end;

initialization
  RegisterClass(TSMSListGUI);

end.
