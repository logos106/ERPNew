unit salesreportCustomercustomFields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesReportCustomFieldsForm, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, StdCtrls,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript,
  MyScript;

type
  TsalesreportCustomercustomFieldsGUI = class(TSalesReportCustomFieldsGUI)
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCLIENTID: TIntegerField;
    qryMainCUSTOMERNAME: TWideStringField;
    QryCF: TERPQuery;
    QryCFCFLabel1: TWideStringField;
    QryCFCFLabel2: TWideStringField;
    QryCFCFLabel3: TWideStringField;
    QryCFCFLabel4: TWideStringField;
    QryCFCFLabel5: TWideStringField;
    QryCFCFLabel6: TWideStringField;
    QryCFCFLabel7: TWideStringField;
    QryCFCFLabel8: TWideStringField;
    QryCFCFLabel9: TWideStringField;
    QryCFCFLabel10: TWideStringField;
    QryCFCFLabel11: TWideStringField;
    QryCFCFLabel12: TWideStringField;
    QryCFCFLabel13: TWideStringField;
    QryCFCFLabel14: TWideStringField;
    QryCFCFLabel15: TWideStringField;
    QryCFCFLabel16: TWideStringField;
    QryCFCFLabel17: TWideStringField;
    QryCFCFLabel18: TWideStringField;
    QryCFCFCust1: TWideStringField;
    QryCFCFCust2: TWideStringField;
    QryCFCFCust3: TWideStringField;
    QryCFCFCust4: TWideStringField;
    QryCFCFCust5: TWideStringField;
    QryCFCFCust6: TWideStringField;
    QryCFCFCust7: TWideStringField;
    QryCFCFCust8: TWideStringField;
    QryCFCFCust9: TWideStringField;
    QryCFCFCust10: TWideStringField;
    QryCFCFCust11: TWideStringField;
    QryCFCFCust12: TWideStringField;
    QryCFCFCust13: TWideStringField;
    QryCFCFCust14: TWideStringField;
    QryCFCFCust15: TWideStringField;
    QryCFCFCust16: TWideStringField;
    QryCFCFCust17: TWideStringField;
    QryCFCFCust18: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
  private

    { Private declarations }
  Protected
    Procedure SetQrymainSQL;Override;
    function salesreportcustomfieldname:String ; Override;

    procedure MakeQrySQL(SQLList:TStringList);Override;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, MySQLConst;

{$R *.dfm}

{ TsalesreportCustomercustomFieldsGUI }
procedure TsalesreportCustomercustomFieldsGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
             if SameText(Field.fieldName , 'CUSTFLD1') then begin if not (QryCFCFCust1.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD2') then begin if not (QryCFCFCust2.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD3') then begin if not (QryCFCFCust3.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD4') then begin if not (QryCFCFCust4.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD5') then begin if not (QryCFCFCust5.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD6') then begin if not (QryCFCFCust6.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD7') then begin if not (QryCFCFCust7.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD8') then begin if not (QryCFCFCust8.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD9') then begin if not (QryCFCFCust9.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD10') then begin if not (QryCFCFCust10.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD11') then begin if not (QryCFCFCust11.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD12') then begin if not (QryCFCFCust12.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD13') then begin if not (QryCFCFCust13.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD14') then begin if not (QryCFCFCust14.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(Field.fieldName , 'CUSTFLD15') then begin if not (QryCFCFCust15.asBoolean) then AFont.color := clInactiveCaption;
    end;
end;

procedure TsalesreportCustomercustomFieldsGUI.grdMainCalcTitleAttributes(
  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
             if SameText(AFieldname , 'CUSTFLD1') then begin if not (QryCFCFCust1.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD2') then begin if not (QryCFCFCust2.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD3') then begin if not (QryCFCFCust3.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD4') then begin if not (QryCFCFCust4.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD5') then begin if not (QryCFCFCust5.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD6') then begin if not (QryCFCFCust6.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD7') then begin if not (QryCFCFCust7.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD8') then begin if not (QryCFCFCust8.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD9') then begin if not (QryCFCFCust9.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD10') then begin if not (QryCFCFCust10.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD11') then begin if not (QryCFCFCust11.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD12') then begin if not (QryCFCFCust12.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD13') then begin if not (QryCFCFCust13.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD14') then begin if not (QryCFCFCust14.asBoolean) then AFont.color := clInactiveCaption;
    end else if SameText(AFieldname , 'CUSTFLD15') then begin if not (QryCFCFCust15.asBoolean) then AFont.color := clInactiveCaption;
    end;
end;

procedure TsalesreportCustomercustomFieldsGUI.MakeQrySQL(SQLList: TStringList);
begin
       SQLList.Add('truncate  ' + fstablename + ';');
        SQLList.Add('Insert into ' + fstablename + '(' +
        'CLIENTID,  CUSTOMERNAME )'+
        ' SELECT ' +
        ' S.ClientID as ClientID,' +
        ' S.CustomerName as CustomerName' +
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
                    ' inner join tblClients C on C.ClientId = T.ClientID Set '+
				                  ' T.CUSTFLD1=C.CUSTFLD1, '+
				                  ' T.CUSTFLD2=C.CUSTFLD2, '+
				                  ' T.CUSTFLD3=C.CUSTFLD3, '+
				                  ' T.CUSTFLD4=C.CUSTFLD4, '+
				                  ' T.CUSTFLD5=C.CUSTFLD5, '+
				                  ' T.CUSTFLD6=C.CUSTFLD6, '+
				                  ' T.CUSTFLD7=C.CUSTFLD7, '+
				                  ' T.CUSTFLD8=C.CUSTFLD8, '+
				                  ' T.CUSTFLD9=C.CUSTFLD9, '+
				                  ' T.CUSTFLD10=C.CUSTFLD10, '+
				                  ' T.CUSTFLD11=C.CUSTFLD11, '+
				                  ' T.CUSTFLD12=C.CUSTFLD12, '+
				                  ' T.CUSTFLD13=C.CUSTFLD13, '+
				                  ' T.CUSTFLD14=C.CUSTFLD14, '+
				                  ' T.CUSTFLD15=C.CUSTFLD15; ');
end;



procedure TsalesreportCustomercustomFieldsGUI.RefreshQuery;
begin
  inherited;
    if QrycF.active = False then QrycF.open;
    if QrycFCFLabel1.asString <> '' then  qryMainCUSTFLD1.DisplayLabel := QrycFCFLabel1.asString;
    if QrycFCFLabel2.asString <> '' then  qryMainCUSTFLD2.DisplayLabel := QrycFCFLabel2.asString;
    if QrycFCFLabel3.asString <> '' then  qryMainCUSTFLD3.DisplayLabel := QrycFCFLabel3.asString;
    if QrycFCFLabel4.asString <> '' then  qryMainCUSTFLD4.DisplayLabel := QrycFCFLabel4.asString;
    if QrycFCFLabel5.asString <> '' then  qryMainCUSTFLD5.DisplayLabel := QrycFCFLabel5.asString;
    if QrycFCFLabel6.asString <> '' then  qryMainCUSTFLD6.DisplayLabel := QrycFCFLabel6.asString;
    if QrycFCFLabel7.asString <> '' then  qryMainCUSTFLD7.DisplayLabel := QrycFCFLabel7.asString;
    if QrycFCFLabel8.asString <> '' then  qryMainCUSTFLD8.DisplayLabel := QrycFCFLabel8.asString;
    if QrycFCFLabel9.asString <> '' then  qryMainCUSTFLD9.DisplayLabel := QrycFCFLabel9.asString;
    if QrycFCFLabel10.asString <> '' then  qryMainCUSTFLD10.DisplayLabel := QrycFCFLabel10.asString;
    if QrycFCFLabel11.asString <> '' then  qryMainCUSTFLD11.DisplayLabel := QrycFCFLabel11.asString;
    if QrycFCFLabel12.asString <> '' then  qryMainCUSTFLD12.DisplayLabel := QrycFCFLabel12.asString;
    if QrycFCFLabel13.asString <> '' then  qryMainCUSTFLD13.DisplayLabel := QrycFCFLabel13.asString;
    if QrycFCFLabel14.asString <> '' then  qryMainCUSTFLD14.DisplayLabel := QrycFCFLabel14.asString;
    if QrycFCFLabel15.asString <> '' then  qryMainCUSTFLD15.DisplayLabel := QrycFCFLabel15.asString;
end;

function TsalesreportCustomercustomFieldsGUI.salesreportcustomfieldname: String;
begin
  result := 'Cust';
end;

procedure TsalesreportCustomercustomFieldsGUI.SetQrymainSQL;
begin
  inherited;
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select  Distinct ');
  Qrymain.SQL.add('CLIENTID as  CLIENTID , ');
  Qrymain.SQL.add('CUSTOMERNAME as  CUSTOMERNAME , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD1,"")) as  CUSTFLD1 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD2,"")) as  CUSTFLD2 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD3,"")) as  CUSTFLD3 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD4,"")) as  CUSTFLD4 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD5,"")) as  CUSTFLD5 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD6,"")) as  CUSTFLD6 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD7,"")) as  CUSTFLD7 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD8,"")) as  CUSTFLD8 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD9,"")) as  CUSTFLD9 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD10,"")) as  CUSTFLD10 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD11,"")) as  CUSTFLD11 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD12,"")) as  CUSTFLD12 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD13,"")) as  CUSTFLD13 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD14,"")) as  CUSTFLD14 , ');
  Qrymain.SQL.add('Trim(ifnull(CUSTFLD15,"")) as  CUSTFLD15  ');
  Qrymain.SQL.add('from '+fstablename);
end;
initialization
  RegisterClassOnce(TsalesreportCustomercustomFieldsGUI);

end.
