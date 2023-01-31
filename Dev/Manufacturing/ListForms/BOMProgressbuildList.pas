unit BOMProgressbuildList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TBOMProgressbuildListGUI = class(TBaseListingGUI)
    DNMPanel1: TDNMPanel;
    chkshowconverted: TCheckBox;
    btnFixsaledate: TDNMSpeedButton;
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainBuiltQty: TFloatField;
    qryMainFirstBuild: TDateTimeField;
    qryMainSaleDateTime: TDateTimeField;
    qryMainLastbuild: TDateTimeField;
    qryMainconverted: TWideStringField;
    procedure btnFixsaledateClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    procedure BackupTables;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses BusObjSales , dateutils, CommonLib , SystemLib, tcConst, SharedObjs,
  LogLib;

{$R *.dfm}

{ TBOMProgressbuildListGUI }

procedure TBOMProgressbuildListGUI.btnFixsaledateClick(Sender: TObject);
begin
  inherited;
  if SelectedRecords = 0 then begin
    MessageDlgXP_Vista('Please Choose The Sales to Be fixed. '+#13+#10+'The lines in Red Color Needs to be fixed', mtInformation, [mbOK], 0);
  end;
  IterateProcNo := 1;
  BackupTables;
  IterateSelectedRecords(true, 'Updating Unconverted Sales Orders SaleDate to MAtch the Progress Builds');
  RefreshQuery;
end;
procedure TBOMProgressbuildListGUI.BackupTables;
begin
    with Scriptmain do begin
      SQL.clear;
      SQL.add(ERPFixtableSQL('tblsales'               , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblproctree'            , 'BOMOrders'));
      SQL.add(ERPFixtableSQL('tblproctreePart'            , 'BOMOrders'));
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
procedure TBOMProgressbuildListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbRemeberIgnoreDateSelection := True;
  Showcontrolhint( btnFixsaledate , 'Future Dated Sales Orders Cannot be built.'+NL+
                  'Choose to Change The Sales Order''s SaleDate to a Date and Time Prior to it''s the First Progress Build Date.'+NL );
end;

procedure TBOMProgressbuildListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (qryMainSaleDateTime.asDatetime >0) and ( qryMainFirstBuild.asdatetime >0) and (qryMainSaleDateTime.asDatetime > qryMainFirstBuild.asdatetime) then begin
    ABrush.color := GridColhighLightRed;
  end;

end;

procedure TBOMProgressbuildListGUI.IterateselectedRecordsCallback( var Abort: boolean; SelIndex: Integer);
var
  SalesOrder :TSalesOrder;
  dt:TDateTime;
begin
  inherited;
  if IterateProcNo = 1 then begin
      if Qrymainconverted.AsBoolean  then exit;
      SalesOrder := TSalesOrder.CreateWithNewConn(Self);
      try
        SalesOrder.Load(QrymainsaleId.AsInteger);
        if SalesOrder.count =0 then exit;
        dt :=SalesOrder.FirstPPGDate;
        if dt=0 then exit;
        Salesorder.Connection.BeginTransaction;
        try
          Salesorder.comments := trim(Salesorder.comments  + NL +formatdateTime(FormatSettings.ShortDateFormat +' HH:NN:SS Am/ PM' , Now) + ' : Sale Date is Changed '+
                                                                ' from ' +QuotedStr(formatdateTime(FormatSettings.ShortDateFormat +' HH:NN:SS Am/ PM' , Salesorder.saleDatetime)) +
                                                                ' to  ' +QuotedStr(formatdateTime(FormatSettings.ShortDateFormat +' HH:NN:SS Am/ PM' , incSecond(dt, -1)) )+
                                                                ' to Match Progress Build.');
          Salesorder.saleDatetime := incSecond(dt, -1);
          Salesorder.PostDB;
          Salesorder.Connection.CommitTransaction;
        Except
          on E:Exception do begin
            Salesorder.Connection.RollbackTransaction;
          end;
        end;
      finally
        Freeandnil(SalesOrder);
      end;
  end;
end;

procedure TBOMProgressbuildListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainFirstBuild.Displayformat   := FormatSettings.ShortDateFormat;
  qryMainSaleDateTime.Displayformat := FormatSettings.ShortDateFormat;
  qryMainLastbuild.Displayformat    := FormatSettings.ShortDateFormat;
end;

procedure TBOMProgressbuildListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  Qrymain.ParamByName('Showconverted').asString := BooleanToStr(chkshowconverted.checked);
  inherited;
end;

initialization
  RegisterClassOnce(TBOMProgressbuildListGUI);
end.
