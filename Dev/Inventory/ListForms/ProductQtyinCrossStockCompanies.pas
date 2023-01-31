unit ProductQtyinCrossStockCompanies;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, BusobjCrossStockCompanies, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCrossStockCompaniesProc = Procedure (Sender :TCrossStockCompanies ; cssTablename:String) of Object;
  TProductQtyinCrossStockCompaniesGUI = class(TBaseListingGUI)
    btnproducts: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnproductsClick(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    Tablename :string;
    stProductnames:tStringlist;
    fdReportdate: Tdatetime;
    fOnRecordChange: TNotifyEvent;
    fOnRefreshQuery: TCrossStockCompaniesProc;
    fbShowDefaultDept: Boolean;
    function ProductIDs(DBConn:TERPConnection) :String;
    //Function Productnames :String;
    procedure MakeQrymain;
    //procedure initselection(Sender: TObject);
    procedure gettselection(Sender: TwwDBGrid);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
    Procedure AddProductname(const Productname:string);
    Property Reportdate :Tdatetime read fdReportdate write fdReportdate;
    Procedure LocateProduct(productname: String);
    Property OnRecordChange:TNotifyEvent read fOnRecordChange write fOnRecordChange;
    Property OnRefreshQuery:TCrossStockCompaniesProc read fOnRefreshQuery write fOnRefreshQuery;
    Property ShowDefaultDept :Boolean read fbShowDefaultDept write fbShowDefaultDept;
  end;


implementation

uses CommonLib, CommonDbLib, DbSharedObjectsObj,
  ProductQtyLib, tcDataUtils, PQALib, tcConst, AppEnvironment, CommonFormLib,
  ProductListExpressForm, LogLib, MySQLConst;

{$R *.dfm}

{ TProductQtyinCrossStockCompaniesGUI }

procedure TProductQtyinCrossStockCompaniesGUI.AddProductname(const Productname: string);
begin
  stProductnames.Add(Productname);
end;

procedure TProductQtyinCrossStockCompaniesGUI.btnproductsClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil , gettselection);
end;
procedure TProductQtyinCrossStockCompaniesGUI.gettselection(Sender: TwwDBGrid);
begin
  //TProductListExpressGUI(Sender.Owner).SelectedIDs('Partname' ,stProductnames , True);
  CommonLib.SelectedDatas(Sender, 'ProductName', stProductnames, True);
  RefreshQuery;
end;
procedure TProductQtyinCrossStockCompaniesGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if sametext(Copy(Field.fieldname, 1, length(Instock_Qty_fieldname) ) , Instock_Qty_fieldname) or
     sametext(Copy(Field.fieldname, 1, length(Available_Qty_fieldname) ) , Available_Qty_fieldname) then begin
      DoGreenhighlight(AFont,ABrush);
      BignBold(AFont);
  end;
end;

procedure TProductQtyinCrossStockCompaniesGUI.LocateProduct(  productname: String);
begin
  if Qrymain.active then
    if Qrymain.FieldByName('Productname').asstring <>ProductName then
      Qrymain.Locate('ProductName' , ProductName , []);
end;

procedure TProductQtyinCrossStockCompaniesGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('CrossStockQty');
  stProductnames:= tStringlist.Create;
  Reportdate := Now;
  Qrymain.SQL.Text := 'Select * from '+ tablename ;
  fOnRecordChange := nil;
  fOnRefreshQuery := nil;
  inherited;
  HaveDateRangeSelection:=False;
  SearchMode:= smFullList;
  ShowDefaultDept := True;
end;

procedure TProductQtyinCrossStockCompaniesGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  Freeandnil(stProductnames);
  inherited;
end;

procedure TProductQtyinCrossStockCompaniesGUI.FormShow(Sender: TObject);
begin
  inherited;
  if stProductnames.Count =0 then begin
    highlightcontrol(btnproducts);
    MessageDlgXP_vista('None of the Products are Selected for the report. Please Choose ''Products'' for Selection', mtInformation, [mbOK], 0);
  end;
end;

function TProductQtyinCrossStockCompaniesGUI.ProductIDs(DBConn:TERPConnection): String;
var
  ctr:Integer;
begin
  REsult :='0';
  if stProductnames.Count > 0 then begin
    for ctr := 0 to stProductnames.Count -1 do begin
      result := result +',' + inttostr(getProduct(stProductnames[ctr] , DBConn));
    end;
  end;

end;

(*function TProductQtyinCrossStockCompaniesGUI.Productnames: String;
var
  ctr:Integer;
begin
  REsult :='0';
  if stProductnames.Count > 0 then begin
    for ctr := 0 to stProductnames.Count -1 do begin
      result := result +',' + Quotedstr(stProductnames[ctr] );
    end;
  end;
end;*)

procedure TProductQtyinCrossStockCompaniesGUI.qryMainAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if assigned(fOnRecordChange) then fOnRecordChange(DataSet);
end;

procedure TProductQtyinCrossStockCompaniesGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if stProductnames.count =0 then
    if GuiPrefs.Node.Exists('Options.Productnames') then
      stProductnames.text :=  GuiPrefs.Node['Options.Productnames'].asString;
end;

procedure TProductQtyinCrossStockCompaniesGUI.RefreshQuery;
var
  CC:  TCrossStockCompanies;
  scompanyname:String;
  dbconn :TERPConnection;
begin
        closedb(qrymain);
        MakeQrymain;

        inherited;

        fieldList := TStringList.create;
        try
          AddGridSelectedfield('Productname'  , 20 , AppEnv.DefaultClass.PartColumn );
          AddGridSelectedfield('ProductPrintName'  , 20 , AppEnv.companyprefs.ProductPrintNameHeading );
          if ShowDefaultDept then begin
            AddGridSelectedfield(Instock_Qty_fieldname      , 10 , Instock_Qty_fieldname , AppEnv.DefaultClass.DEfaultclassName);
            AddGridSelectedfield(Available_Qty_fieldname    , 10 , Available_Qty_fieldname, AppEnv.DefaultClass.DEfaultclassName);
          end;
          cc:= TCrossStockCompanies.CreateWithNewConn(self);
          try
            cc.Load;
            if cc.Count > 0 then begin
              cc.first;
              While cc.EOF = false do begin
                if DBExists(cc.dbname) then begin
                  DBConn := GetNewMyDacConnection(Self, cc.dbname);
                  try
                    scompanyname := GetCompanyname(dbconn);
                  finally
                    Freeandnil(dbconn);
                  end;
                  AddGridSelectedfield(Instock_Qty_fieldname+ trim(inttostr((*cc.dataset.recno*)cc.id))      , 10 , Instock_Qty_fieldname , scompanyname);
                  AddGridSelectedfield(Available_Qty_fieldname+ trim(inttostr((*cc.dataset.recno*)cc.id))    , 10 , Available_Qty_fieldname , scompanyname);
                end;
                cc.Next;
              end;
            end;
          finally
            Freeandnil(cc);
          end;
          //logtext(Fieldlist.Text);
          grdMain.Selected := FieldList;
          grdMain.ApplySelected;
        finally
            Freeandnil(fieldList );
        end;
end;

procedure TProductQtyinCrossStockCompaniesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Productnames'].asString := stProductnames.text ;
end;

procedure TProductQtyinCrossStockCompaniesGUI.MakeQrymain;
var
  CC:  TCrossStockCompanies;
//  qry: TERPQuery;
  dbConn:TERPConnection;
//  ctr:Integer;
  sCompanyname:String;
begin
  With ScriptMain do begin
    SQL.clear;
    SQL.add('drop table if exists ' +tablename +' ;');
    SQL.add('CREATE TABLE  ' +tablename +' ( '+
	          ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
            ' ProductId int(11) default null, '+
	          ' ProductName varchar(255) DEFAULT NULL, '+
            ' ProductPrintName varchar(255) DEFAULT NULL, '+
            ' Instock double,'+
            ' Available double , '+
            ' ToUseAvailable double , '+
	          ' PRIMARY KEY (ID) '+
	          ' ) ENGINE=Myisam AUTO_INCREMENT=1;');
    SQL.add('ALTER TABLE ' +tablename +' 	ADD INDEX `ProductName` (`ProductName`);');

      cc:= TCrossStockCompanies.CreateWithNewConn(self);
      try
        cc.Load;
        if cc.Count > 0 then begin
          cc.first;
          scompanyname := GetCompanyname(dbconn);
          While cc.EOF = false do begin
            AddGridSelectedfield(Instock_Qty_fieldname      , 10 , Instock_Qty_fieldname , scompanyname);
            AddGridSelectedfield(Available_Qty_fieldname    , 10 , Available_Qty_fieldname , scompanyname);
            SQL.add('Alter table ' + tablename +'  add column   '+Instock_Qty_fieldname+ trim(inttostr((*cc.dataset.recno*)cc.id))+' double,'+
                                                '  add column   ToUseAvailable'+ trim(inttostr((*cc.dataset.recno*)cc.id))+' double,'+
                                                '  add column   '+Available_Qty_fieldname+ trim(inttostr((*cc.dataset.recno*)cc.id))+' double ;');
            cc.Next;
          end;

          if stProductnames.count > 0 then begin
            SQL.add('insert ignore into ' + tablename +' (ProductId , Productname , ProductPrintName , Instock , Available) select ' +
                ' P.partsId , P.partname,P.ProductPrintName ,   '+
                ' Round(IF(P.Parttype = "INV",' +ProductQtylib.SQL4Qty(tInstock   ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "InStock",'+
                ' Round(IF(P.Parttype = "INV",' +ProductQtylib.SQL4Qty(tAvailable ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "Available"'+
                ' from tblparts P '+
                ' inner join tblPQA as PQA on P.partsId = PQA.ProductID '+
                ' where P.partsId in (' +ProductIDs(GetSharedMyDacConnection)+ ') group by p.partname order by partname;');
              cc.first;
              While cc.EOF = false do begin
                try
                  if DBExists(cc.dbname) then begin
                    DBConn := GetNewMyDacConnection(Self, cc.dbname);
                    try
                        scompanyname := GetCompanyname(dbconn);
                          SQL.add('Drop table if exists '+tablename +'2;');
                          SQL.add('Create table  '+tablename +'2  select ' +
                                  ' P.partsId , P.partname , '+
                                  ' Round(IF(P.Parttype = "INV",' +ProductQtylib.SQL4Qty(tInstock   ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "InStock",'+
                                  ' Round(IF(P.Parttype = "INV",' +ProductQtylib.SQL4Qty(tAvailable ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "Available"'+
                                  ' from ' + cc.dbname +'.tblparts P '+
                                  ' inner join ' + cc.dbname +'.tblPQA as PQA on P.partsId = PQA.ProductID '+
                                  ' where P.partsId in (' +ProductIDs(dbconn)+ ') '+
                                  ' and (PQA.TransDate < '+Quotedstr(FormatdateTime(mysqldatetimeFormat , reportdate)) +' )'+
                                  ' group by p.partname order by partname ;');

                          SQL.add('ALTER TABLE ' +tablename +'2 	ADD INDEX `partname` (`partname`);');
                          SQL.add('update  ' +tablename +' T inner join  ' +tablename +'2 T2 on T.productname = t2.partname set T.instock'+ trim(inttostr((*cc.dataset.recno*)cc.id))+'= t2.instock , '+
                                    ' T.Available'+ trim(inttostr((*cc.dataset.recno*)cc.id))+'= t2.Available;');
                          SQL.add('Drop table if exists '+tablename +'2;');
                        //end;
                    finally
                      Freeandnil(dbconn)
                    end;
                  end;
                Except
                  // kill the exception
                end;
                cc.next;
              end;
          end;
        end;
        DoShowProgressbar(SQl.Count , WAITMSG);
        try
          logtext(SQL.Text);
          Execute;
        finally
          DoHideProgressbar;
        end;
        if assigned(fOnRefreshQuery) then fOnRefreshQuery(cc , Tablename );
      finally
        Freeandnil(cc);
      end;
  end;
  inherited;

end;

initialization
  RegisterClassOnce(TProductQtyinCrossStockCompaniesGUI);

end.
