unit StockAdjustEntryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, ComCtrls, wwriched,
  BusObjBase, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup;

type
  TStockAdjustEntryListGUI = class(TBaseListingGUI)
    btnDetails: TDNMSpeedButton;
    qryMainGlobalRef: TWideStringField;
    qryMainStockAdjustEntryID: TIntegerField;
    qryMainCreationDate: TDateField;
    qryMainAccountID: TIntegerField;
    qryMainAccountname: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainIsStocktake: TWideStringField;
    qryMainEmployee: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainProcessed: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainAdjustmentdate: TDateField;
    qryMainOriginalno: TWideStringField;
    btnProcessallintheGroup: TDNMSpeedButton;
    qryMainAdjusttype: TWideStringField;
    btnFlat: TDNMSpeedButton;
    btnDeleteall: TDNMSpeedButton;
    btnProcessAll: TDNMSpeedButton;
    ProgressBar: TProgressBar;
    lblMsg: TLabel;
    chkPrintallinGroup: TCheckBox;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProcessallintheGroupClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnFlatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDeleteallClick(Sender: TObject);
    procedure btnProcessAllClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    procedure Processall;
    Procedure Progressmsg(Const Value :String);
    //procedure flagtodelete(Sender: TObject);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
      procedure SetGridColumns; Override;
      procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
      procedure BeforePopup(Popupform:TComponent);Override;
  public
    Procedure RefreshQuery; override;
    Function IdfieldFor(Const IDfieldForClassname:String) : TField;override;
  end;


implementation

uses CommonLib, StockAdjustEntryDetailList, AppEnvironment,
  CommonDbLib, BusobjStockAdjustEntry, dateutils, frmStockAdjustEntryTree, CommonFormLib, frmStockAdjustEntry, LogLib, tcConst, BusObjConst;

{$R *.dfm}
procedure TStockAdjustEntryListGUI.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'Processed <> ' + quotedStr('T') + ' and Deleted <> ' + quotedStr('T');
    1:GroupFilterString := 'Processed =  ' + quotedStr('T') + ' and Deleted <> ' + quotedStr('T');
    2:GroupFilterString := 'Deleted   =  ' + quotedStr('T');
    else GroupFilterString := '';
  end;
  inherited;
end;

function TStockAdjustEntryListGUI.IdfieldFor(const IDfieldForClassname: String): TField;
begin
  Result := nil;
  if sametext(IDfieldForClassname , 'TfmExportImportData') then result := qrymainStockAdjustEntryID;
end;

procedure TStockAdjustEntryListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  StockAdjust :TStockAdjustEntry;
begin
  inherited;
  if IterateProcNo=1 then begin
    //OpenERPForm('TfmStockAdjustEntry' ,qryMainStockAdjustEntryID.AsInteger , flagtodelete)
    StockAdjust := TStockAdjustEntry.CreateWithNewConn(Self);
    try
      StockAdjust.Load(qryMainStockAdjustEntryID.AsInteger);
      StockAdjust.Connection.BeginNestedTransaction;
      try
        StockAdjust.Deleted := true;
        StockAdjust.Save;
        StockAdjust.Connection.CommitTransaction;
      Except
        on E:Exception do begin
          StockAdjust.Connection.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(StockAdjust);
    end;

  end;
end;
(*procedure TStockAdjustEntryListGUI.flagtodelete(Sender: TObject);
begin
  if not(Sender is TfmStockAdjustEntry) then exit;
    SetFocusedControl(TfmStockAdjustEntry(Sender).chkDeleted);
    EditDB(TfmStockAdjustEntry(Sender).qryStockAdjustEntry);
    TfmStockAdjustEntry(Sender).chkDeleted.checked := True;
    TfmStockAdjustEntry(Sender).btnCompleted.click;
  end;

end;*)
(*Function TStockAdjustEntryListGUI.DoExport :boolean;
var
  filename:String;
  Ids :String;
  obj : TMultiStockAdjustExport;
begin
  result := False;
  if SelectedRecords =0 then exit;
  Ids := SelectedIds(grdmain , qryMainStockAdjustEntryID.fieldname);
  if Ids = '' then exit;
  if MessageDlgXP_Vista('Do you want to Export All ' + inttostr(SelectedRecords) +' Selected Entrie(s) into one file?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  filename := Savefilename('ini');
  if filename = '' then exit;

  obj := TMultiStockAdjustExport.CreateWithNewConn(Self);
  Try
    obj.loadSelect('StockAdjustEntryID in (' + Ids+')');
    if obj.count =0 then exit;

  Finally
    Freeandnil(obj)
  End;
end;*)
procedure TStockAdjustEntryListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmStockAdjustEntryTree');
  if Assigned(Form) then begin 
    with TfmStockAdjustEntryTree(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;

end;
procedure TStockAdjustEntryListGUI.cmdPrintClick(Sender: TObject);
var
  ssQL:String;
begin
//  inherited;
  ReportToPrint := 'Stock Adjustment (Summary)';
  ssql:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
        ' ~|||~{Details}'+
        ' select distinct SAL.StockAdjustEntryID , ProductId, Productname, ClassId, Classname, concat(SAL.UOM , "(" , SAL.UOMMultiplier, ")") as UOM,  SAL.AvailableUOMQty , SAL.InStockUOMQty, SAL.AdjustUOMQty , SAL.FinalUOMQty'+
        '  from  tblstockadjustentry SA inner join tblstockadjustentrylines SAL  on SA.StockAdjustEntryID = SAL.StockAdjustEntryID  and ifnull(SAL.AdjustQty,0)<> 0';
  if chkPrintallinGroup.checked and (trim(qryMainOriginalno.asString) <> '') then ssql:= ssql+' where  Sa.ImportgroupOriginalno =' +Quotedstr(qryMainOriginalno.asString) else
                                                                                  ssql := ssql + ' where SA.StockAdjustEntryID =' + inttostr(qrymainStockAdjustEntryID.asInteger);
  ssql:= ssql+'    order by StockAdjustEntryID, productname, classname, uom';

  ReportSQLSupplied := true;
  logtext(ssql);
  PrintTemplateReport(ReportToPrint , ssql , false, 1);
end;

procedure TStockAdjustEntryListGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
function ProgressMsg :String;
begin
  Result := sender.ProgressMsg;
  if result = '' then result := WaitMsg;
end;
begin
    inherited;
    if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_ShowProgressbar) then begin
      DoShowProgressbar(Sender.Progresscount , ProgressMsg );
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_HideProgressbar) then begin
      doHideProgressbar;
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_ProgressbarProgress) then begin
      doStepProgressbar(sender.ProgressMsg);
    end;
end;

procedure TStockAdjustEntryListGUI.BeforePopup(Popupform: TComponent);
begin
  inherited;
  if popupform is TfmStockAdjustEntry then begin
    TfmStockAdjustEntry(popupform).Listprogressbar := ProgressBar;
    TfmStockAdjustEntry(popupform).ListShowStatus := Progressmsg;
  end;

end;

procedure TStockAdjustEntryListGUI.btnDeleteallClick(Sender: TObject);
begin
  inherited;
  IterateProcno := 1;
  IterateRecords(true);
end;

procedure TStockAdjustEntryListGUI.btnDetailsClick(Sender: TObject);
Var
  Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TStockAdjustEntryDetailListGUI') then begin
    Form := GetComponentByClassName('TStockAdjustEntryDetailListGUI');
    if Assigned(Form) then begin
      with TStockAdjustEntryDetailListGUI(Form) do begin
          FormStyle :=fsMDIChild;
          grpFilters.ItemIndex := Self.grpFilters.ItemIndex;
          BringToFront;
      end;
    end;
  end else begin
    TStockAdjustEntryDetailListGUI(FindExistingComponent('TStockAdjustEntryDetailListGUI')).grpFilters.ItemIndex := Self.grpFilters.ItemIndex;
    TStockAdjustEntryDetailListGUI(FindExistingComponent('TStockAdjustEntryDetailListGUI')).show;
  end;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TStockAdjustEntryListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  self.fbEnableWebSearch:= true;
  grpFilters.Width := (btnDetails.Left + btnDetails.Width) - grpFilters.Left;
end;

procedure TStockAdjustEntryListGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnFlat.visible := Devmode;
  btnDeleteall.visible := Devmode;
end;

procedure TStockAdjustEntryListGUI.RefreshQuery;
begin
  Qrymain.Parambyname('DateFrom').asDateTime := FilterDateFrom;
  Qrymain.Parambyname('DateTo').asDateTime := FilterDateTo;
  inherited;
  GuiPrefs.DbGridElement[grdMain].HideFields('StockAdjustentryID,AccountId,mstimestamp');
end;

procedure TStockAdjustEntryListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainAdjusttype.FieldName);
end;

procedure TStockAdjustEntryListGUI.btnFlatClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmStockAdjustEntryflat' , qryMainStockAdjustEntryID.AsInteger);
end;

procedure TStockAdjustEntryListGUI.btnProcessAllClick(Sender: TObject);
var
  cleanfilter:String;
  s:String;
begin
  inherited;
  if Qrymain.recordcount = 0 then exit;
  if grdmain.SelectedList.Count =0 then begin
       CommonLib.MessageDlgXP_Vista('Please Select the stock adjustments to be processed. ' , mtinformation , [mbok], 0);
       exit;
  end;

  cleanfilter := qrymain.filter;
  try
    s:= SelectedIDs('StockAdjustEntryID');
    if s= '' then exit;
    s:= 'StockAdjustEntryID = ' + replacestr(s, ',' , ' or StockAdjustEntryID = ');

    if CommonLib.MessageDlgXP_Vista('Do you Wish To Process All Selected Stock Adjustments ? ' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;

    if cleanfilter<> '' then s:= '(' + cleanfilter +') and (' + s+')';
    Qrymain.Filter := s;
    qrymain.Filtered:= true;
  ProcessAll;

  finally
     qrymain.Filter := cleanfilter;
     qrymain.filtered := cleanfilter<>'';
    RefreshQuery;
  end;
end;
Procedure TStockAdjustEntryListGUI.Processall;
var
  startedat:Tdatetime;
  StockAdjust :TStockAdjustEntry;
begin
  startedat:= now;
  Qrymain.First;
  while Qrymain.Eof = false do begin
    StockAdjust:= TStockAdjustEntry.create(Self);
    try
      StockAdjust.BusObjEvent := DoBusinessObjectEvent;
      StockAdjust.connection := TMyDacDataConnection.create(StockAdjust);
      StockAdjust.Connection.Connection := CommonDbLib.GetNewMyDacConnection(StockAdjust);
      (*StockAdjust.ProgressBar := ProgressBar;*)
      if devmode then StockAdjust.ShowStatus :=  Progressmsg;
      StockAdjust.Load(qryMainStockAdjustEntryID.asInteger);
      if (StockAdjust.count = 0) or (StockAdjust.processed) then begin
      end else begin
          StockAdjust.CountCaption:= inttostr(Qrymain.recno) +' of ' + intToStr(Qrymain.recordcount);
          StockAdjust.Process ;
      end;
    finally
      //StockAdjust.Connection.Connection.Free;
      FreeandNil(StockAdjust);
    end;
    Qrymain.Next;
  end;
  CommonLib.MessageDlgXP_Vista('Processing completed' +chr(13) +chr(13)+
            'From ' + FormatDateTime('dd-mm-yyyy hh:nn' ,startedat) +'  to ' + FormatDateTime('dd-mm-yyyy hh:nn' ,now) + '     ' + intToStr( MinutesBetween(Startedat, now)), mtInformation , [mbok], 0);

end;
procedure TStockAdjustEntryListGUI.Progressmsg(const Value: String);
begin
  if lblmsg.visible = false then lblmsg.visible := True;
  lblmsg.caption := Value;
  lblmsg.refresh;
//  Logtext(Value)
end;

procedure TStockAdjustEntryListGUI.btnProcessallintheGroupClick(Sender: TObject);
(*var
  strSQL:String;
  StockAdjust :TStockAdjustEntry;*)

var
  //StockAdjust :TStockAdjustEntry;
  s:String;
  cleanfilter:String;

begin
  inherited;
  clog('');
  if Qrymain.recordcount = 0 then exit;
  if qrymainOriginalno.asString = '' then begin
       CommonLib.MessageDlgXP_Vista('This Stock Adjustment is not a Part of any Group. Please Open the Stock Adjustment and Process it. ' , mtinformation , [mbok], 0);
       exit;
  end;
  cleanfilter := qrymain.filter;
  try
      s:= 'Originalno = ' +QuotedStr(qrymainOriginalno.asString);
      if pos (s , cleanfilter)=0 then begin
        if CommonLib.MessageDlgXP_Vista('Do you Wish To Process All Stock Adjustments in the Group? ' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;

          if cleanfilter<> '' then s:= '(' + cleanfilter +') and (' + s+')';
          Qrymain.Filter := s;
          qrymain.Filtered:= true;
      end;

      Processall;

  finally
     qrymain.Filter := cleanfilter;
     qrymain.filtered := cleanfilter<>'';
    RefreshQuery;
  end;

(*  if qryMainOriginalno.asString = '' then begin
      if MessageDlgXP_Vista('Selected record is not in a group.' , )
  end;*)
(*  strSQL:= 'Select StockAdjustEntryID from tblstockadjustentry where ImportgroupOriginalno = ' + quotedStr(qryMainOriginalno.asSTring) = ' and ifnull(Processed, "") <> "T"';
  With CommonDbLib.TempMyQuery do try
    if recordcount = 0 then exit;
    first;
    while Eof = false do begin
      StockAdjust := TStockAdjustEntry.create(self);
      try
        StockAdjust.connection := TMyDacDataConnection.create(StockAdjust);
        StockAdjust.connection.connection := GetNewMyDacConnection(self);
        StockAdjust.Load(fieldByname('StockAdjustEntryID').asInteger;
        if StockAdjust.count <> 0 then begin

            if StockAdjust.Process then begin
              StockAdjust.connection.CommitTransaction;
            end;
        end;
      finally
          FreeandNil(StockAdjust);
      end;
      next;
    end;
  finally
      if active then close;
      free;
  end;*)

end;

procedure TStockAdjustEntryListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
(*  if not btnProcessall.visible then exit;
  if qryMainProcessed.asBoolean =False then ABrush.Color := clgreen;*)
end;

procedure TStockAdjustEntryListGUI.grdMainDblClick(Sender: TObject);
begin
  if self.classnameis('TStockAdjustEntryListGUI') then SubsequentID := Chr(95) + qryMainAdjusttype.AsString;
  inherited;
end;

initialization
  RegisterClassOnce(TStockAdjustEntryListGUI);
end.

