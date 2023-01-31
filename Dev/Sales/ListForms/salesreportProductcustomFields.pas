unit salesreportProductcustomFields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesReportCustomFieldsForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, StdCtrls,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript,
  MyScript;

type
  TsalesreportProductcustomFieldsGUI = class(TSalesReportCustomFieldsGUI)
    qryMainPARTSCUSTFLD1: TWideStringField;
    qryMainPARTSCUSTFLD2: TWideStringField;
    qryMainPARTSCUSTFLD3: TWideStringField;
    qryMainPARTSCUSTFLD4: TWideStringField;
    qryMainPARTSCUSTFLD5: TWideStringField;
    qryMainPARTSCUSTFLD6: TWideStringField;
    qryMainPARTSCUSTFLD7: TWideStringField;
    qryMainPARTSCUSTFLD8: TWideStringField;
    qryMainPARTSCUSTFLD9: TWideStringField;
    qryMainPARTSCUSTFLD10: TWideStringField;
    qryMainPARTSCUSTFLD11: TWideStringField;
    qryMainPARTSCUSTFLD12: TWideStringField;
    qryMainPARTSCUSTFLD13: TWideStringField;
    qryMainPARTSCUSTFLD14: TWideStringField;
    qryMainPARTSCUSTFLD15: TWideStringField;
    qryMainPARTSCUSTDATE1: TWideStringField;
    qryMainPARTSCUSTDATE2: TWideStringField;
    qryMainPRODUCTID: TIntegerField;
    qryMainPRODUCTNAME: TWideStringField;
    QrycF: TERPQuery;
    QrycFCFLabel1: TWideStringField;
    QrycFCFLabel2: TWideStringField;
    QrycFCFLabel3: TWideStringField;
    QrycFCFLabel4: TWideStringField;
    QrycFCFLabel5: TWideStringField;
    QrycFCFLabel6: TWideStringField;
    QrycFCFLabel7: TWideStringField;
    QrycFCFLabel8: TWideStringField;
    QrycFCFLabel9: TWideStringField;
    QrycFCFLabel10: TWideStringField;
    QrycFCFLabel11: TWideStringField;
    QrycFCFLabel12: TWideStringField;
    QrycFCFLabel13: TWideStringField;
    QrycFCFLabel14: TWideStringField;
    QrycFCFLabel15: TWideStringField;
    QrycFCFLabel16: TWideStringField;
    QrycFCFLabel17: TWideStringField;
    QrycFCFLabel18: TWideStringField;
    QrycFCFProduct1: TWideStringField;
    QrycFCFProduct2: TWideStringField;
    QrycFCFProduct3: TWideStringField;
    QrycFCFProduct4: TWideStringField;
    QrycFCFProduct5: TWideStringField;
    QrycFCFProduct6: TWideStringField;
    QrycFCFProduct7: TWideStringField;
    QrycFCFProduct8: TWideStringField;
    QrycFCFProduct9: TWideStringField;
    QrycFCFProduct10: TWideStringField;
    QrycFCFProduct11: TWideStringField;
    QrycFCFProduct12: TWideStringField;
    QrycFCFProduct13: TWideStringField;
    QrycFCFProduct14: TWideStringField;
    QrycFCFProduct15: TWideStringField;
    QrycFCFProduct16: TWideStringField;
    QrycFCFProduct17: TWideStringField;
    QrycFCFProduct18: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
  private

    { Private declarations }
  Protected
    Procedure SetQrymainSQL;Override;
    function salesreportcustomfieldname:String ; Override;
    procedure SetGridColumns; Override;

    procedure MakeQrySQL(SQLList:TStringList);Override;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, MySQLConst;

{$R *.dfm}

{ TsalesreportProductcustomFieldsGUI }

procedure TsalesreportProductcustomFieldsGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
             if SameText(Field.Fieldname , 'PARTSCUSTFLD1') then begin if not (QryCFCFProduct1.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD2') then begin if not (QryCFCFProduct2.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD3') then begin if not (QryCFCFProduct3.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD4') then begin if not (QryCFCFProduct4.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD5') then begin if not (QryCFCFProduct5.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD6') then begin if not (QryCFCFProduct6.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD7') then begin if not (QryCFCFProduct7.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD8') then begin if not (QryCFCFProduct8.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD9') then begin if not (QryCFCFProduct9.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD10') then begin if not (QryCFCFProduct10.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD11') then begin if not (QryCFCFProduct11.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD12') then begin if not (QryCFCFProduct12.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD13') then begin if not (QryCFCFProduct13.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD14') then begin if not (QryCFCFProduct14.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTFLD15') then begin if not (QryCFCFProduct15.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTDATE1') then begin if not (QryCFCFProduct16.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.Fieldname , 'PARTSCUSTDATE2') then begin if not (QryCFCFProduct17.asBoolean) then AFont.color := clInactiveCaption;
    end;

end;

procedure TsalesreportProductcustomFieldsGUI.grdMainCalcTitleAttributes(
  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
             if SameText(AFieldName , 'PARTSCUSTFLD1') then begin if not (QryCFCFProduct1.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD2') then begin if not (QryCFCFProduct2.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD3') then begin if not (QryCFCFProduct3.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD4') then begin if not (QryCFCFProduct4.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD5') then begin if not (QryCFCFProduct5.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD6') then begin if not (QryCFCFProduct6.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD7') then begin if not (QryCFCFProduct7.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD8') then begin if not (QryCFCFProduct8.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD9') then begin if not (QryCFCFProduct9.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD10') then begin if not (QryCFCFProduct10.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD11') then begin if not (QryCFCFProduct11.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD12') then begin if not (QryCFCFProduct12.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD13') then begin if not (QryCFCFProduct13.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD14') then begin if not (QryCFCFProduct14.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTFLD15') then begin if not (QryCFCFProduct15.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTDATE1') then begin if not (QryCFCFProduct16.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldName , 'PARTSCUSTDATE2') then begin if not (QryCFCFProduct17.asBoolean) then AFont.color := clInactiveCaption;
    end;

end;

procedure TsalesreportProductcustomFieldsGUI.MakeQrySQL(SQLList: TStringList);
begin
       SQLList.Add('truncate  ' + fstablename + ';');
        SQLList.Add('Insert into ' + fstablename + '(' +
        'PRODUCTID, PRODUCTNAME )'+
        ' SELECT ' +
        ' SL.ProductID as ProductID,' +
        ' SL.ProductName as ProductName' +
        ' FROM tblSales S ' +
        ' INNER JOIN tblSalesLines SL ON  S.SaleID = SL.SaleID ' +
        ' WHERE (S.IsRefund ="T" OR S.IsCashSale="T" OR ' +
        ' S.IsInvoice="T" OR S.IsPOS="T") ' +
        ' AND S.IsQuote="F" AND S.IsLayby="F" ');
        if not chkAllClass.Checked then  SQLList.add('AND S.ClassID = ' + IntToStr(cboClassQry.Fieldbyname('classId').asInteger));
        if not chkBaseOnShipped.Checked then SQLList.add('AND S.SaleDate Between ' +
                            quotedstr(FormatDateTime(MysqlDateFormat, dtfrom.DateTime)) +
                            ' AND ' + quotedstr(FormatDateTime(MysqlDateFormat, dtto.DateTime)) )
        else SQLList.add('AND S.ShipDate Between ' +
                            quotedstr(FormatDateTime(MysqlDateFormat, dtfrom.DateTime)) +
                            ' AND ' + quotedstr(FormatDateTime(MysqlDateFormat, dtto.DateTime)) );
        SQLList.add('GROUP BY SL.SaleLineID');
        SQLList.add('Order BY SL.SaleID Desc; ');

      				SQLList.add('update '+fstablename +' T  ' +
                    ' inner join tblparts P on P.PartsID = T.ProductId Set '+
				                  ' T.PartsCustFld1=P.CUSTFLD1, '+
				                  ' T.PartsCustFld2=P.CUSTFLD2, '+
				                  ' T.PartsCustFld3=P.CUSTFLD3, '+
				                  ' T.PartsCustFld4=P.CUSTFLD4, '+
				                  ' T.PartsCustFld5=P.CUSTFLD5, '+
				                  ' T.PartsCustFld6=P.CUSTFLD6, '+
				                  ' T.PartsCustFld7=P.CUSTFLD7, '+
				                  ' T.PartsCustFld8=P.CUSTFLD8, '+
				                  ' T.PartsCustFld9=P.CUSTFLD9, '+
				                  ' T.PartsCustFld10=P.CUSTFLD10, '+
				                  ' T.PartsCustFld11=P.CUSTFLD11, '+
				                  ' T.PartsCustFld12=P.CUSTFLD12, '+
				                  ' T.PartsCustFld13=P.CUSTFLD13, '+
				                  ' T.PartsCustFld14=P.CUSTFLD14, '+
				                  ' T.PartsCustFld15=P.CUSTFLD15, '+
				                  ' T.PartsCustDate1=P.CUSTDATE1, '+
				                  ' T.PartsCustDate2=P.CUSTDATE2        ; ');
end;


procedure TsalesreportProductcustomFieldsGUI.RefreshQuery;
begin
  inherited;
    if QrycF.active = False then QrycF.open;
    if QrycFCFLabel1.asString <> '' then qryMainPARTSCUSTFLD1.DisplayLabel := QrycFCFLabel1.asString else qryMainPARTSCUSTFLD1.visible := QrycFCFProduct1.AsBoolean;
    if QrycFCFLabel2.asString <> '' then qryMainPARTSCUSTFLD2.DisplayLabel := QrycFCFLabel2.asString else qryMainPARTSCUSTFLD2.visible := QrycFCFProduct2.AsBoolean;
    if QrycFCFLabel3.asString <> '' then qryMainPARTSCUSTFLD3.DisplayLabel := QrycFCFLabel3.asString else qryMainPARTSCUSTFLD3.visible := QrycFCFProduct3.AsBoolean;
    if QrycFCFLabel4.asString <> '' then qryMainPARTSCUSTFLD4.DisplayLabel := QrycFCFLabel4.asString else qryMainPARTSCUSTFLD4.visible := QrycFCFProduct4.AsBoolean;
    if QrycFCFLabel5.asString <> '' then qryMainPARTSCUSTFLD5.DisplayLabel := QrycFCFLabel5.asString else qryMainPARTSCUSTFLD5.visible := QrycFCFProduct5.AsBoolean;
    if QrycFCFLabel6.asString <> '' then qryMainPARTSCUSTFLD6.DisplayLabel := QrycFCFLabel6.asString else qryMainPARTSCUSTFLD6.visible := QrycFCFProduct6.AsBoolean;
    if QrycFCFLabel7.asString <> '' then qryMainPARTSCUSTFLD7.DisplayLabel := QrycFCFLabel7.asString else qryMainPARTSCUSTFLD7.visible := QrycFCFProduct7.AsBoolean;
    if QrycFCFLabel8.asString <> '' then qryMainPARTSCUSTFLD8.DisplayLabel := QrycFCFLabel8.asString else qryMainPARTSCUSTFLD8.visible := QrycFCFProduct8.AsBoolean;
    if QrycFCFLabel9.asString <> '' then qryMainPARTSCUSTFLD9.DisplayLabel := QrycFCFLabel9.asString else qryMainPARTSCUSTFLD9.visible := QrycFCFProduct9.AsBoolean;
    if QrycFCFLabel10.asString <> '' then qryMainPARTSCUSTFLD10.DisplayLabel := QrycFCFLabel10.asString else qryMainPARTSCUSTFLD10.visible := QrycFCFProduct10.AsBoolean;
    if QrycFCFLabel11.asString <> '' then qryMainPARTSCUSTFLD11.DisplayLabel := QrycFCFLabel11.asString else qryMainPARTSCUSTFLD11.visible := QrycFCFProduct11.AsBoolean;
    if QrycFCFLabel12.asString <> '' then qryMainPARTSCUSTFLD12.DisplayLabel := QrycFCFLabel12.asString else qryMainPARTSCUSTFLD12.visible := QrycFCFProduct12.AsBoolean;
    if QrycFCFLabel13.asString <> '' then qryMainPARTSCUSTFLD13.DisplayLabel := QrycFCFLabel13.asString else qryMainPARTSCUSTFLD13.visible := QrycFCFProduct13.AsBoolean;
    if QrycFCFLabel14.asString <> '' then qryMainPARTSCUSTFLD14.DisplayLabel := QrycFCFLabel14.asString else qryMainPARTSCUSTFLD14.visible := QrycFCFProduct14.AsBoolean;
    if QrycFCFLabel15.asString <> '' then qryMainPARTSCUSTFLD15.DisplayLabel := QrycFCFLabel15.asString else qryMainPARTSCUSTFLD15.visible := QrycFCFProduct15.AsBoolean;
    if QrycFCFLabel16.asString <> '' then qryMainPARTSCUSTDATE1.DisplayLabel := QrycFCFLabel16.asString else qryMainPARTSCUSTDATE1.visible := QrycFCFProduct16.AsBoolean;
    if QrycFCFLabel17.asString <> '' then qryMainPARTSCUSTDATE2.DisplayLabel := QrycFCFLabel17.asString else qryMainPARTSCUSTDATE2.visible := QrycFCFProduct17.AsBoolean;
    (*
    if QrycFCFLabel1.asString <> '' then qryMainPARTSCUSTFLD1.DisplayLabel := QrycFCFLabel1.asString ;
    if QrycFCFLabel2.asString <> '' then qryMainPARTSCUSTFLD2.DisplayLabel := QrycFCFLabel2.asString ;
    if QrycFCFLabel3.asString <> '' then qryMainPARTSCUSTFLD3.DisplayLabel := QrycFCFLabel3.asString ;
    if QrycFCFLabel4.asString <> '' then qryMainPARTSCUSTFLD4.DisplayLabel := QrycFCFLabel4.asString ;
    if QrycFCFLabel5.asString <> '' then qryMainPARTSCUSTFLD5.DisplayLabel := QrycFCFLabel5.asString ;
    if QrycFCFLabel6.asString <> '' then qryMainPARTSCUSTFLD6.DisplayLabel := QrycFCFLabel6.asString ;
    if QrycFCFLabel7.asString <> '' then qryMainPARTSCUSTFLD7.DisplayLabel := QrycFCFLabel7.asString ;
    if QrycFCFLabel8.asString <> '' then qryMainPARTSCUSTFLD8.DisplayLabel := QrycFCFLabel8.asString ;
    if QrycFCFLabel9.asString <> '' then qryMainPARTSCUSTFLD9.DisplayLabel := QrycFCFLabel9.asString ;
    if QrycFCFLabel10.asString <> '' then qryMainPARTSCUSTFLD10.DisplayLabel := QrycFCFLabel10.asString ;
    if QrycFCFLabel11.asString <> '' then qryMainPARTSCUSTFLD11.DisplayLabel := QrycFCFLabel11.asString ;
    if QrycFCFLabel12.asString <> '' then qryMainPARTSCUSTFLD12.DisplayLabel := QrycFCFLabel12.asString ;
    if QrycFCFLabel13.asString <> '' then qryMainPARTSCUSTFLD13.DisplayLabel := QrycFCFLabel13.asString ;
    if QrycFCFLabel14.asString <> '' then qryMainPARTSCUSTFLD14.DisplayLabel := QrycFCFLabel14.asString ;
    if QrycFCFLabel15.asString <> '' then qryMainPARTSCUSTFLD15.DisplayLabel := QrycFCFLabel15.asString ;
    if QrycFCFLabel16.asString <> '' then qryMainPARTSCUSTDATE1.DisplayLabel := QrycFCFLabel16.asString ;
    if QrycFCFLabel17.asString <> '' then qryMainPARTSCUSTDATE2.DisplayLabel := QrycFCFLabel17.asString ;

    qryMainPARTSCUSTFLD1.visible := QrycFCFProduct1.AsBoolean;
    qryMainPARTSCUSTFLD2.visible := QrycFCFProduct2.AsBoolean;
    qryMainPARTSCUSTFLD3.visible := QrycFCFProduct3.AsBoolean;
    qryMainPARTSCUSTFLD4.visible := QrycFCFProduct4.AsBoolean;
    qryMainPARTSCUSTFLD5.visible := QrycFCFProduct5.AsBoolean;
    qryMainPARTSCUSTFLD6.visible := QrycFCFProduct6.AsBoolean;
    qryMainPARTSCUSTFLD7.visible := QrycFCFProduct7.AsBoolean;
    qryMainPARTSCUSTFLD8.visible := QrycFCFProduct8.AsBoolean;
    qryMainPARTSCUSTFLD9.visible := QrycFCFProduct9.AsBoolean;
    qryMainPARTSCUSTFLD10.visible := QrycFCFProduct10.AsBoolean;
    qryMainPARTSCUSTFLD11.visible := QrycFCFProduct11.AsBoolean;
    qryMainPARTSCUSTFLD12.visible := QrycFCFProduct12.AsBoolean;
    qryMainPARTSCUSTFLD13.visible := QrycFCFProduct13.AsBoolean;
    qryMainPARTSCUSTFLD14.visible := QrycFCFProduct14.AsBoolean;
    qryMainPARTSCUSTFLD15.visible := QrycFCFProduct15.AsBoolean;
    qryMainPARTSCUSTDATE1.visible := QrycFCFProduct16.AsBoolean;
    qryMainPARTSCUSTDATE2.visible := QrycFCFProduct17.AsBoolean;*)
end;

function TsalesreportProductcustomFieldsGUI.salesreportcustomfieldname: String;
begin
  result := 'Product';
end;

procedure TsalesreportProductcustomFieldsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainproductID.fieldname);
end;

procedure TsalesreportProductcustomFieldsGUI.SetQrymainSQL;
begin
  inherited;
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select  Distinct ');
  Qrymain.SQL.add('PRODUCTID as  PRODUCTID , ');
  Qrymain.SQL.add('PRODUCTNAME as  PRODUCTNAME , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD1,"")) as  PARTSCUSTFLD1 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD2,"")) as  PARTSCUSTFLD2 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD3,"")) as  PARTSCUSTFLD3 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD4,"")) as  PARTSCUSTFLD4 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD5,"")) as  PARTSCUSTFLD5 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD6,"")) as  PARTSCUSTFLD6 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD7,"")) as  PARTSCUSTFLD7 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD8,"")) as  PARTSCUSTFLD8 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD9,"")) as  PARTSCUSTFLD9 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD10,"")) as  PARTSCUSTFLD10 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD11,"")) as  PARTSCUSTFLD11 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD12,"")) as  PARTSCUSTFLD12 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD13,"")) as  PARTSCUSTFLD13 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD14,"")) as  PARTSCUSTFLD14 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTFLD15,"")) as  PARTSCUSTFLD15 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTDATE1,0)) as  PARTSCUSTDATE1 , ');
  Qrymain.SQL.add('Trim(ifnull(PARTSCUSTDATE2,0)) as  PARTSCUSTDATE2  ');
  Qrymain.SQL.add('from '+fstablename);
end;
initialization
  RegisterClassOnce(TsalesreportProductcustomFieldsGUI);
end.
