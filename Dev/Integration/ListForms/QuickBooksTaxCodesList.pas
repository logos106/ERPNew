unit QuickBooksTaxCodesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickBooksListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TQuickBooksTaxCodesListGUI = class(TQuickBooksListBaseGUI)
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainHidden: TWideStringField;
    qryMainTaxable: TWideStringField;
    qryMainTaxGroup: TWideStringField;
    dsTaxRAtes: TDataSource;
    QryTaxRAtes: TERPQuery;
    QryTaxRAtesName: TWideStringField;
    QryTaxRAtesValue: TWideStringField;
    QryTaxRAtesSubTID: TLargeintField;
    QryTaxRAtesTID: TLargeintField;
    QryTaxRAtesseqno: TLargeintField;
    pnlTaxCodeRate: TDNMPanel;
    grdTaxRAtes: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryMainERPName: TWideStringField;
    QryTaxRAtesCode: TWideStringField;
    QryTaxRAtesDescription: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btntestClick(Sender: TObject);
    procedure QryTaxRAtesBeforeClose(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure QryTaxRAtesAfterOpen(DataSet: TDataSet);
    procedure grdTaxRAtesDblClick(Sender: TObject);
  private
    fsRAteTablename:String;
    procedure SynchRate;
  Protected
    function GetJsonListName: String;Override;
    function QuickBooksListSearchDescription:String;Override;
    //procedure DoUpdatenDeleteTempTable;Override;
    procedure MakeTable;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure OnSelectERP(Sender: TwwDbGrid);Override;
    Procedure ERPTableFields;Override;
    Procedure ERPTable;Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses  JSONObject, CommonLib, CommonDbLib, DbSharedObjectsObj, BusObjTaxCodes,
  tcConst, BusobjExternalXRef, CommonFormLib;



{$R *.dfm}

{ TQuickBooksTaxCodesListGUI }

procedure TQuickBooksTaxCodesListGUI.btntestClick(Sender: TObject);
begin
  inherited;
  LoaddataFromfile('i:\temp\to be deleted\TaxCode_List.json');
end;

{procedure TQuickBooksTaxCodesListGUI.DoUpdatenDeleteTempTable;
var
    qry: TERPQuery;
    fs:String;
    fsmsg:String;
begin
  if fstablename <> '' then begin
      fs:= fstablename+'1';
        With scriptmain do begin
          SQL.clear;
          SQL.AdD('DROP TABLE if EXISTS '+ fs +' ;');
          SQL.AdD('CREATE TABLE '+ fs +'  LIKE tbltaxcodelines;');
(*          if (fsPOTablename<> '') and (Tableexists(fsPOTablename)) then
            SQL.AdD('INSERT IGNORE INTO '+ fs +'  (TaxCodeID,SubTaxID) '+
                    ' SELECT '+
                    ' ERT.ERPID taxcodeId, '+
                    ' ERTS.ERPID subtaxcodeId '+
                    ' from '+ fstablename +'  T '+
                    ' inner join tblexternalxref ERT on T.Id = ERT.ExternalID and ERT.ObjectType ="TaxCode" and ERT.ExternalType ="Quickbooks" '+
                    ' inner JOIN '+fsPOTablename+' TS ON TS.TID = T.TID '+
                    ' inner join tblexternalxref ERTS on trim(Ts.Value) = trim(ERTs.ExternalID) and ERTs.ObjectType ="TaxRate" and ERTs.ExternalType ="Quickbooks";');
          if (fsSaleSTablename<> '') and (Tableexists(fsSaleSTablename)) then
            SQL.AdD('INSERT IGNORE INTO '+ fs +'  (TaxCodeID,SubTaxID) '+
                    ' SELECT '+
                    ' ERT.ERPID taxcodeId, '+
                    ' ERTS.ERPID subtaxcodeId '+
                    ' from '+ fstablename +' T '+
                    ' inner join tblexternalxref ERT on T.Id = ERT.ExternalID and ERT.ObjectType ="TaxCode" and ERT.ExternalType ="Quickbooks" '+
                    ' inner JOIN '+fsSaleSTablename+' TS ON TS.TID = T.TID '+
                    ' inner join tblexternalxref ERTS on trim(Ts.Value) = trim(ERTs.ExternalID) and ERTs.ObjectType ="TaxRate" and ERTs.ExternalType ="Quickbooks";');*)
    if (fsRAteTablename<> '') and (Tableexists(fsRAteTablename)) then
            SQL.AdD('INSERT IGNORE INTO '+ fs +'  (TaxCodeID,SubTaxID) '+
                    ' SELECT '+
                    ' ERT.ERPID taxcodeId, '+
                    ' ERTS.ERPID subtaxcodeId '+
                    ' from '+ fstablename +'  T '+
                    ' inner join tblexternalxref ERT on T.Id = ERT.ExternalID and ERT.ObjectType ="TaxCode" and ERT.ExternalType ="Quickbooks" '+
                    ' inner JOIN '+fsRAteTablename+' TS ON TS.TID = T.TID '+
                    ' inner join tblexternalxref ERTS on trim(Ts.Value) = trim(ERTs.ExternalID) and ERTs.ObjectType ="TaxRate" and ERTs.ExternalType ="Quickbooks";');

          if SQL.count >2 then begin
(*            SQL.AdD('update '+ fs +'  T INNER JOIN tblsubtaxcode ST ON T.SubTaxID = ST.ID SET T.SubTaxCode = ST.Code;');
            SQL.AdD('update '+ fs +'  T INNER JOIN tbltaxcodes ST ON T.taxcodeId = ST.TaxCodeID SET T.Percentage = ST.Rate*100;');*)
            ExecutewithProgress(False);
            qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
            try
              qry.SQL.text := 'Select * from '+ fs ;
              qry.open;
              if qry.recordcount >0 then begin
                qry.First;
                fsmsg:='';
                While qry.EOF = False do begin
                  TTaxCode.MakeaTaxcodeLine(self,fsmsg,
                                            qry.fieldbyname('TaxCodeID').asInteger,
                                            qry.fieldbyname('SubTaxID').asInteger);
                  qry.Next;
                end;
                if fsmsg <> '' then
                  MessageDlgXP_Vista('Following Taxcode / SubTaxCodes  are linked'+NL+NL+fsMsg, mtInformation, [mbOK], 0);
              end;
            finally
              DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
            end;
          end;
      end;
  end;
  if fs <> '' then DeleteTable(fs);
  inherited;
end;  }

procedure TQuickBooksTaxCodesListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  QBitem.QBFieldList.Stringfields.Add('Name');
  QBitem.QBFieldList.Stringfields.Add('Description');
  QBitem.QBFieldList.Stringfields.Add('Id');
  QBitem.QBFieldList.Stringfields.Add('TaxTypeApplicable');

  QBitem.QBFieldList.Booleanfield.Add('Active');
  QBitem.QBFieldList.Booleanfield.Add('Hidden');
  QBitem.QBFieldList.Booleanfield.Add('Taxable');
  QBitem.QBFieldList.Booleanfield.Add('TaxGroup');

  QBitem.QBFieldList.IntegerFields.Add('TaxOrder');
  fsRAteTablename :=GetUserTemporaryTableName(jsonListName+'Rates');;
  with QBitem.NewSubItem do begin
      ITemName := 'PurchaseTaxRateList';
      ArrayName := 'TaxRateDetail';
      ArrayItemname:= 'TaxRateRef';
      HeaderIDField := 'TID';
      //fsPOTablename :=fsRAteTablename;//GetUserTemporaryTableName(jsonListName+'PO');;
      Tablename := fsRAteTablename;
      QbFieldList.Stringfields.Add('value');
      QbFieldList.Stringfields.Add('name');
  end;

  with QBitem.NewSubItem do begin
      ITemName := 'SalesTaxRateList';
      ArrayName := 'TaxRateDetail';
      ArrayItemname:= 'TaxRateRef';
      HeaderIDField := 'TID';
      //fsSaleSTablename := fsRAteTablename;//GetUserTemporaryTableName(jsonListName+'Sales');
      Tablename := fsRAteTablename;
      QbFieldList.Stringfields.Add('value');
      QbFieldList.Stringfields.Add('name');
  end;

end;
procedure TQuickBooksTaxCodesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  grdTaxRAtes.TitleColor := Self.Color;
  grdTaxRAtes.FooterColor := Self.Color;
  splMultiSelectList.visible := true;
  splMultiSelectList.left := 0;
end;

function TQuickBooksTaxCodesListGUI.getjsonListName: String;
begin
  Result := SynchtypeTaxCode;
end;

procedure TQuickBooksTaxCodesListGUI.grdTaxRAtesDblClick(Sender: TObject);
begin
  SynchRate;
end;
procedure TQuickBooksTaxCodesListGUI.SynchRate;
var
  SubTaxCode :TSubTaxCode;
  fsmsg:String;
  //TaxCodeDetailList :TComponent;
begin
    if TaxratesForm = nil then exit;

    SubTaxCode := TSubTaxCode.Load4code(self, QryTaxRAtesname.asString);
    if (SubTaxCode.Count = 1) then begin
          TExternalXRef.MakeXRef(QuickBooks_ExternalType,SynchtypeTaxrate ,SubTaxCode.id , QryTaxRAtesValue.asString );
    closedb(TaxratesForm.Qrymain);
    TaxratesForm.RefreshQuery;
    if TaxratesForm.qrymain.Locate('ID' ,QryTaxRAtesValue.asString , []) then begin
      TTaxCode.MakeaTaxcodeLine(self,fsmsg,qrymainERPID.asInteger,SubTaxCode.ID , TaxratesForm.qrymain.Fieldbyname('RateValue').asfloat);
    end;
    end;
end;

procedure TQuickBooksTaxCodesListGUI.MakeTable;
begin
  inherited;
  Closedb(QryTaxRAtes);
  QryTaxRAtes.Connection := Qrymain.Connection;
  QryTaxRAtes.SQL.clear;
if (fsRAteTablename <> '') and (tableexists(fsRAteTablename)) then begin
      QryTaxRAtes.SQL.Add('SELECT');
      QryTaxRAtes.SQL.Add('CONVERT(T.SubTID , signed) AS SubTID,');
      QryTaxRAtes.SQL.Add('CONVERT(T.TID , signed)    AS TID,');
      QryTaxRAtes.SQL.Add('T.VALUE                    as VALUE,');
      QryTaxRAtes.SQL.Add('T.NAME                     as NAME,');
      QryTaxRAtes.SQL.Add('ERP.Code                   AS CODE,');
      QryTaxRAtes.SQL.Add('ERP.Description            AS Description,');
      QryTaxRAtes.SQL.Add('CONVERT(T.seqno , signed)  AS seqno');
      QryTaxRAtes.SQL.Add('FROM ' + fsRAteTablename +' T ');
      QryTaxRAtes.SQL.Add('LEFT JOIN tblexternalxref ER on T.VAlue = ER.ExternalID '+
                                                        ' and ER.ObjectType =' +quotedstr(SynchtypeTaxRate) +
                                                        ' and ER.ExternalType =' + Quotedstr(QuickBooks_ExternalType));
      QryTaxRAtes.SQL.Add('LEFT JOIN tblsubtaxcode ERP ON ERP.id = ER.ERPID');

  end else begin
      QryTaxRAtes.SQL.Add('SELECT ""            as TYPE, ');
      QryTaxRAtes.SQL.Add('CONVERT(0 , signed)  AS SubTID, ');
      QryTaxRAtes.SQL.Add('CONVERT(0 , signed)  AS TID, ');
      QryTaxRAtes.SQL.Add('""                   AS VALUE, ');
      QryTaxRAtes.SQL.Add('""                   AS NAME , ');
      QryTaxRAtes.SQL.Add('CONVERT(0 , signed)  AS seqno ');
      QryTaxRAtes.SQL.Add('FROM dual ');
      QryTaxRAtes.SQL.Add('LIMIT 0 ');
  end;
end;

procedure TQuickBooksTaxCodesListGUI.OnSelectERP(Sender: TwwDbGrid);
begin
  inherited;
  if QrymainERPID.asInteger <> 0 then
    if QryTaxRAtes.recordcount >0 then begin
      QryTaxRAtes.first;
      While QryTaxRAtes.eof = False do begin
        SynchRate;
        QryTaxRAtes.next;
      end;
      CLOSEDB(QryTaxRAtes);
      OPENDB(QryTaxRAtes);
    end;
end;

procedure TQuickBooksTaxCodesListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  Opendb(QryTaxRAtes);
end;

procedure TQuickBooksTaxCodesListGUI.QryTaxRAtesAfterOpen(DataSet: TDataSet);
var
  x:Integer;
begin
  inherited;
  x := 10;
  if GuiPrefs.Node.Exists('Options.'+ QryTaxRatesName.fieldname+'.DisplayWidth')  then
    x:= GuiPrefs.Node['Options.'+ QryTaxRatesName.fieldname+'.DisplayWidth'].asInteger;
  QryTaxRAtesName.displaywidth := x;

  x := 10;
  if GuiPrefs.Node.Exists('Options.'+ QryTaxRAtesCode.fieldname+'.DisplayWidth')  then
    x:= GuiPrefs.Node['Options.'+ QryTaxRAtesCode.fieldname+'.DisplayWidth'].asInteger;
  QryTaxRAtesCode.displaywidth := x;

  x := 10;
  if GuiPrefs.Node.Exists('Options.'+ QryTaxRAtesDescription.fieldname+'.DisplayWidth')  then
    x:= GuiPrefs.Node['Options.'+ QryTaxRAtesDescription.fieldname+'.DisplayWidth'].asInteger;
  QryTaxRAtesDescription.displaywidth := x;
end;

procedure TQuickBooksTaxCodesListGUI.QryTaxRAtesBeforeClose(DataSet: TDataSet);
begin
  inherited;
  Closedb(QryTaxRAtes);
end;

function TQuickBooksTaxCodesListGUI.QuickBooksListSearchDescription: String;
begin
    Result := Qrymainname.AsString;
end;

procedure TQuickBooksTaxCodesListGUI.RefreshQuery;
begin
  inherited;
end;

procedure TQuickBooksTaxCodesListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  x := 260;
  if GuiPrefs.Node.Exists('Options.MultiSelectItemsWidth')  then
    x:= GuiPrefs.Node['Options.MultiSelectItemsWidth'].asInteger;
  pnlMultiSelectList.Width  := x;
end;

procedure TQuickBooksTaxCodesListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.MultiSelectItemsWidth'].asInteger:= pnlMultiSelectList.Width;
  GuiPrefs.Node['Options.'+ QryTaxRatesName.fieldname+'.DisplayWidth'].asInteger := QryTaxRAtesName.displaywidth ;
  GuiPrefs.Node['Options.'+ QryTaxRAtesCode.fieldname+'.DisplayWidth'].asInteger := QryTaxRAtesCode.displaywidth ;
  GuiPrefs.Node['Options.'+ QryTaxRAtesDescription.fieldname+'.DisplayWidth'].asInteger := QryTaxRAtesDescription.displaywidth ;

end;
Procedure  TQuickBooksTaxCodesListGUI.ERPTableFields;
begin
  Qrymain.SQL.add('ERP.Name AS ERPName,');
end;
Procedure  TQuickBooksTaxCodesListGUI.ERPTable;
begin
  Qrymain.SQL.add('LEFT JOIN tblTaxcodes ERP ON ERP.TaxCodeID = ER.ERPID');
end;

initialization
  RegisterClassOnce(TQuickBooksTaxCodesListGUI);

end.
