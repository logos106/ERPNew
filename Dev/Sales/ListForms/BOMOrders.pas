unit BOMOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TBOMOrdersGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainconverted: TWideStringField;
    qryMainIsInternalOrder: TWideStringField;
    btnUpdate: TDNMSpeedButton;
    qryaccountposting: TERPQuery;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure btnUpdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure BackupTables;
    //procedure initBOMProgressbuildReport(Sender: TObject);
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses BusObjSales, BusObjProcess, CommonLib, ProcessDataUtils,
  BusObjAccountPosting, CommonDbLib, SharedObjs, LogLib, tcConst, BusObjNDSBase,
  BOMProgressbuildReport, CommonFormLib;

{$R *.dfm}

{ TBOMOrdersGUI }

procedure TBOMOrdersGUI.btnUpdateClick(Sender: TObject);
begin
  inherited;
  CLOG('');
  BackupTables;
  IterateProcno := 1;
  IterateSelectedRecords(True);
  lblDateComments.Visible := False;
end;
procedure TBOMOrdersGUI.FormShow(Sender: TObject);
begin
  inherited;
  ShowControlhint(btnUpdate ,'Costs were Altered after Purchase and Before the Completion of the Build.'+NL+'This will Update these Costs to the Current Posting to Match the Balance Sheet'+NL );
end;

procedure TBOMOrdersGUI.BackupTables;
begin
  if not devmode then begin
    with Scriptmain do begin
      SQL.clear;
      SQL.add(ERPFixtableSQL('tblsales'               , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblsaleslines'          , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblproctree'            , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblaccountposting'      , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblaccountpostingdetail', 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblproctree'            , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblproctreePart'        , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblprocesspart'         , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblpqa'                 , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblpqadetails'          , 'BOMOrders'));
      showProgressbar(WAITMSG, SQL.count);
      try
        clog(SQL.Text);
        Execute;
      finally
        HideProgressbar;
      end;
    end;
  end;
end;
procedure TBOMOrdersGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);
var
  SalesOrder :TSalesOrder;
  fbTreeLinefound:Boolean;
  msg :String;
  Function CleanPostingDate(const aSourceName: string;aSourceId: integer) :TdateTime;
  begin
     if (qryaccountposting.active =False) or
        (qryaccountposting.ParamByName('SourceName').AsString  <>aSourceName) or
        (qryaccountposting.ParamByName('SourceId').AsInteger  <> aSourceId) then begin
           closedb(qryaccountposting);
           qryaccountposting.Connection := Qrymain.Connection ;
           qryaccountposting.ParamByName('SourceName').AsString  := aSourceName;
           qryaccountposting.ParamByName('SourceId').AsInteger  := aSourceId;
           Opendb(qryaccountposting);
     end;
     Result := qryaccountposting.FieldByName('Date').AsDateTime;
  end;
begin
  inherited;
  if iterateProcno = 1 then begin
    ListMsg('Processing Sale #' + inttostr(QrymainSaleId.AsInteger)+' (' + inttostr(SelIndex) +' of ' + inttoStr(grdMain.SelectedList.Count)+' )');
    fbTreeLinefound:= False;
    if Qrymainconverted.asBoolean then begin
      SalesOrder := TSalesOrder.CreateWithNewConn(Self);
      try
        SalesOrder.LogChangesOnSave := False;
        SalesOrder.LoadXMLinLoad := False;
        SalesOrder.silentMode := True;
        SalesOrder.Load(QrymainsaleId.AsInteger);
        if SalesOrder.lines.Count >0 then begin
          SalesOrder.connection.BeginTransaction;
          try
            SalesOrder.Lines.First;
            While SalesOrder.Lines.EOF = False do begin
              if SalesOrder.Lines.Tree(False) <> nil then begin
                if salesorder.converted then begin

                  With TSalesLineProcTree(SalesOrder.Lines.Tree) do begin
                    DoNotCreateSmartOrder := True;
                    //CalcQty;
                    CalcCost;
                    if not Complete  then Complete  := TRue;
                    ForcePQACreationonSave:= True;
                    VarifyMastertype(mtSalesOrder);
                    SAveNocheck;
                    DoTreeAccountPosting(SalesOrder.Lines.Tree,Storer.Connection,msg,Qrymaincustomername.asString , CleanPostingDate(AccountPostingSource_Manufacturing, Id));
                    fbTreeLinefound:=True;
                  end;
                end;
              end;
              SalesOrder.Lines.Next;
            end;
            if fbTreeLinefound then begin
              //if SalesOrder.Save Then begin
                SalesOrder.Connection.CommitTransaction;
                Exit;
              //end;
            end;
            SalesOrder.connection.RollbackTransaction;
          Except
            on E:Exception do begin
              logtext(e.Message);
              SalesOrder.connection.RollbackTransaction;
            end;
          end;
        end;
      finally
        FreeandNil(SalesOrder);
      end;
    end;
  end;

end;

(*procedure TBOMOrdersGUI.initBOMProgressbuildReport(Sender: TObject);
begin
   if sender is TBOMProgressbuildReportGUI then begin
     TBOMProgressbuildReportGUI(Sender).saleId := QrymainsaleID.asInteger;
   end;
end;*)
procedure TBOMOrdersGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Converted' , ['F','T','']);
  inherited;
end;

procedure TBOMOrdersGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

initialization
  RegisterClass(TBOMOrdersGUI);

end.
