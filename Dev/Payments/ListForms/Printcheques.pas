unit Printcheques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPrintchequesGUI = class(TBaseListingGUI)
    qryMainTranstypeno: TLargeintField;
    qryMainTranstype: TWideStringField;
    qryMainTransID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainClientname: TWideStringField;
    qryMainTransNo: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainComments: TWideStringField;
    qryMainContact1: TWideStringField;
    qryMainIsPrinted: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMaintotalAmountEx: TFloatField;
    qryMaintotalTax: TFloatField;
    qryMaintotalAmountInc: TFloatField;
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    chkshowPrinted: TwwCheckBox;
    btnPrint: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    Label4: TLabel;
    chkUseChequeNo: TwwCheckBox;
    qryMainForeignTotalAmount: TFloatField;
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure chkshowPrintedClick(Sender: TObject);
  private
    fsReporttoPrint1, fsReporttoPrint2, fsReportToPrint3 :String;
    IgnorePrintingtranstype :TStringlist;
    Function TemplateToPrint: String;
    Function ChequeSQL:string;
    Function SupplierPaymentChequeSQL:string;
    Function SupplierPrepaymentChequeSQL:String;
    function ChooseTemplate: string;

    Procedure InitReportoPrint;
  Protected
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses BusObjPrintDoc, CommonLib, CommonDbLib, AppEnvironment, busobjExpenses, FastFuncs, tcDataUtils, tcConst, SystemLib, DNMLib, chequeLib, BusObjPayments, busobjPrepayments;

{$R *.dfm}

procedure TPrintchequesGUI.btnPrintClick(Sender: TObject);
var
  i: integer;
  SavedPrintDialogPref:Boolean;
  fPrintDoc :TBusObjPrintDoc;
  chequeno,s :String;
  sSQL: string;


  Procedure NextChequeno;
  begin
    try
      if chkUseChequeNo.Checked then
        chequeno := CommonDbLib.GetSequenceNumber(SEQ_LAST_CHEQUENO)
      else
        chequeno := inttostr(strtoInt(trim(chequeno))+1);
    Except
    end;
  end;
  Procedure showUserlockMsg(value:String);
  begin
        value:= replacestr(value, 'Unable to update data.' ,  'Unable to print cheque for ' +Qrymaintranstype.AsString +' # ' + inttostr(QrymaintransID.AsInteger));
        MessageDlgXP_Vista(value, mtWarning, [mbOK], 0);
  end;
  function PrintType : TDocumentOutputType;
  begin
    if chkPreview.Checked then result := dotPreview else result := dotPrint;
  end;
  function UpdatePrintedFlag:Boolean;
  begin
    result:=  False;
    if Qrymaintranstypeno.asInteger = 1 then begin
      with TCheque.CreateWithNewConn(Self) do try
        Load(QrymaintransID.AsInteger);
        if count =0 then exit;
        connection.BeginTransaction;
        try
          if not LockInUse then begin
            showUserlockMsg(Userlock.LockMessage);
            Exit;
          end;
          if chequeno <> '' then
//            SupplierInvoiceNumber := chequeno;
            if i = 0 then
              SupplierInvoiceNumber := chequeno
            else begin
              NextChequeno;
              SupplierInvoiceNumber := chequeno;
            end;
          PostDB;
          //if not save then exit;
          fPrintDoc.Printdoc(Classname ,   ID, dtMain, Self.Classname ,PrintType , ReportToPrint);
          connection.CommitTransaction;
          REsult:= True;
          Exit;
        Except
          on E:Exception do begin
            Connection.RollbackTransaction;
          end;
        end;
      finally
        Free;
      end;
    end else if Qrymaintranstypeno.asInteger = 2 then begin
      with TSuppPayments.CreateWithNewConn(Self) do try
        Load(QrymaintransID.AsInteger);
        if count =0 then exit;
        connection.BeginTransaction;
        try
          if not LockInUse then begin
            showUserlockMsg(Userlock.LockMessage);
            Exit;
          end;
          ChequePrinted := TRue;
          if chequeno <> '' then
//            ReferenceNo :=chequeno;
            if i = 0 then
              ReferenceNo := chequeno
            else begin
              NextChequeno;
              ReferenceNo := chequeno;
            end;
          PostDB;
          //if not save then exit;
          connection.CommitTransaction;
          REsult:= True;
          Exit;
        Except
          on E:Exception do begin
            Connection.RollbackTransaction;
          end;
        end;
      finally
        Free;
      end;
    end else if Qrymaintranstypeno.asInteger = 3 then begin
      with TSuppPrePayments.CreateWithNewConn(Self) do try
        Load(QrymaintransID.AsInteger);
        if count =0 then exit;
        connection.BeginTransaction;
        try
          if not LockInUse then begin
            showUserlockMsg(Userlock.LockMessage);
            Exit;
          end;
          ChequePrinted := TRue;
          if chequeno <> '' then
//            ReferenceNo :=chequeno;
            if i = 0 then
              ReferenceNo := chequeno
            else begin
              NextChequeno;
              ReferenceNo := chequeno;
            end;
          PostDB;
          //if not save then exit;
          connection.CommitTransaction;
          REsult:= True;
          Exit;
        Except
          on E:Exception do begin
            Connection.RollbackTransaction;
          end;
        end;
      finally
        Free;
      end;

    end;
  end;
begin
  DisableForm;
  SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
  try
    if Qrymain.RecordCount = 0 then Exit;
    if grdmain.SelectedList.Count =0 then exit;
    fPrintDoc := TBusObjPrintDoc.Create(self);
    Try
      Chequeno:= '';
      if chkUseChequeNo.Checked then begin
        Chequeno:= GetNextSequenceNumber(SEQ_LAST_CHEQUENO);
        Repeat
          s := trim(inputbox('Cheque no' , 'Please provide the first cheque number. (Cheque number has to be a number)' , chequeno));
        Until IsInteger(s) or (s='');
        if s = '' then exit;
        if s <> Chequeno then
          CommonDbLib.SetSequenceNumber(SEQ_LAST_CHEQUENO,s);
        Chequeno := s;
      end else begin
        Chequeno := '';
      end;

      for i := 0 to grdmain.SelectedList.Count - 1 do begin
        Qrymain.GotoBookmark(grdmain.SelectedList.Items[i]);
        ReportToPrint := TemplateToPrint;
        if ReportToPrint = '' then Continue;
               if Qrymaintranstypeno.asInteger = 1 then sSQL := ChequeSQL
          else if Qrymaintranstypeno.asInteger = 2 then sSQL := SupplierPaymentChequeSQL
          else if Qrymaintranstypeno.asInteger = 3 then sSQL := SupplierPrepaymentChequeSQL
          else Continue;

        if UpdatePrintedFlag then begin
          ReportSQLSupplied := true;
          try
            PrintTemplateReport(ReportToPrint, sSQL, chkPreview.Checked = False , 1,nil , '', i < grdmain.SelectedList.Count -1 );
          finally
            ReportSQLSupplied := False;
          end;
          if Printtemplate.CancelPreviewAll then break;
          AppEnv.Employee.ShowPrintDialog := False;
        end;
      end;
    Finally
      InitReportoPrint;
      Freeandnil(fPrintDoc);
    End;
    Self.Close;
  finally
    EnableForm;
    AppEnv.Employee.ShowPrintDialog := SavedPrintDialogPref;
  end;
end;

procedure TPrintchequesGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + Qrymaintranstype.AsString;
  inherited;
end;

procedure TPrintchequesGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Transtypeno =1';
    1:  GroupFilterString := 'Transtypeno =2';
    2:  GroupFilterString := 'Transtypeno =3';
    3:  GroupFilterString := ''
  end;
  inherited;

end;


procedure TPrintchequesGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.ShowPrinted')  then chkshowPrinted.checked :=  GuiPrefs.Node['Options.ShowPrinted'].asBoolean;
    if GuiPrefs.Node.Exists('Options.cheqenoinSeq') then chkUseChequeNo.checked :=  GuiPrefs.Node['Options.cheqenoinSeq'].asBoolean;
end;
procedure TPrintchequesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.ShowPrinted'].asBoolean  := chkshowPrinted.checked;
  GuiPrefs.Node['Options.cheqenoinSeq'].asBoolean := chkUseChequeNo.checked;
end;

procedure TPrintchequesGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    Qrymain.parambyname('dtfrom').asDateTime  := 0;
    Qrymain.parambyname('dtto').asDateTime    := MaxDateTime;
  end
  else begin
    Qrymain.parambyname('dtfrom').asDateTime  := FilterDateFrom;
    Qrymain.parambyname('dtto').asDateTime    := FilterDateto;
  end;
  Qrymain.parambyname('IncludePrinted').asString := booleantostr(chkshowPrinted.checked);
  inherited;
end;


procedure TPrintchequesGUI.SetGridColumns;
begin
  inherited;
end;

procedure TPrintchequesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  initReporToPrint;
  IgnorePrintingtranstype := TStringlist.Create;
end;

procedure TPrintchequesGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(IgnorePrintingtranstype);
  inherited;
end;

function TPrintchequesGUI.GetReportTypeID: integer;
begin
         if QrymainTranstypeno.AsInteger = 1 then result := 7
    else if QrymainTranstypeno.AsInteger = 2 then result := 133
    else if QrymainTranstypeno.AsInteger = 3 then result := 134
    else result := 0;
end;

function TPrintchequesGUI.ChequeSQL: string;
begin
  result:= chequeLib.chequeSQL(QrymaintransId.asInteger, Qrymaintotalamountinc.AsFloat);
end;
procedure TPrintchequesGUI.chkshowPrintedClick(Sender: TObject);
begin
  inherited;
  if not chkShowPrinted.Focused then exit;
  RefreshQuery;
end;

function TPrintchequesGUI.SupplierPaymentChequeSQL: string;
begin
  result:= chequeLib.SupplierPaychequeSQL(QrymaintransId.asInteger, Qrymaintotalamountinc.AsFloat, qryMainForeignTotalAmount.AsFloat);
end;

function TPrintchequesGUI.SupplierPrepaymentChequeSQL: String;
begin
 result:= chequeLib.SupplierPrePaychequeSQL(QrymaintransId.asInteger, Qrymaintotalamountinc.AsFloat);

end;
procedure TPrintchequesGUI.InitReportoPrint;
begin
  fsReporttoPrint1:= '';
  fsReporttoPrint2:= '';
  fsReportToPrint3:= '';
end;

function TPrintchequesGUI.TemplateToPrint: String;
begin
            if QrymainTranstypeno.AsInteger = 1 then begin if fsReportToPrint1 = '' then fsreporttoPrint1 := ChooseTemplate; result := fsReportToPrint1;
  end else  if QrymainTranstypeno.AsInteger = 2 then begin if fsReportToPrint2 = '' then fsreporttoPrint2 := ChooseTemplate; result := fsReportToPrint2;
  end else  if QrymainTranstypeno.AsInteger = 3 then begin if fsReportToPrint3 = '' then fsreporttoPrint3 := ChooseTemplate; result := fsReportToPrint3;
  end;
end;

Function TPrintchequesGUI.ChooseTemplate:string;
function PrintOrPreview:String;
begin
    if chkPreview.Checked = False then result := 'Print' else result := 'Preview';
end;
begin
  result:= '';
  if ChkChooseRpt.Checked =False then begin
    result := tcdatautils.GetDefaultReport(GetReportTypeID);
  end;
  if (ChkChooseRpt.Checked) or (Result ='') then begin
    if IgnorePrintingtranstype.IndexOf(Qrymaintranstype.AsString) >=0 then exit;
    LoadReportTypes;
    dlgReportSelect.Message := 'Please select a report to ' + PrintOrPreview +' for all selected ' + Quotedstr(Qrymaintranstype.AsString+'(s)');
    if (ChkChooseRpt.Checked=False) and (Result ='') then TimerMsg(FilterLabel ,  'There is no Default templte for ' + quotedstr(Qrymaintranstype.AsString)+'.' );
    if dlgReportSelect.Execute then result:= dlgReportSelect.SelectedItems.Text
    else IgnorePrintingtranstype.Add(Qrymaintranstype.AsString);
    //if result = '' then result := GetDefaultReport(GetReportTypeID);
  end;
end;

Initialization
  RegisterClassOnce(TPrintchequesGUI);
end.

