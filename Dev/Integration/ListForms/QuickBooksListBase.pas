unit QuickBooksListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,JSONObject , QuickBooksList , QuickBooksIDListObj ;

type
  TQuickBooksListBaseGUI = class(TBaseListingGUI)
    qryMainTID: TIntegerField;
    qryMainId: TWideStringField;
    qryMainERID: TIntegerField;
    qryMainSynchstatus: TWideStringField;
    qryMainERPID: TIntegerField;
    btntest: TDNMSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject); override;
  private

    procedure SetData(const Value: String);
    function Ownerform :TQuickBooksListGUI;
    procedure AfterShowERPList(Sender: TObject);
    procedure InitERPList(Sender: TObject);
    procedure SetSubItems(aJo: TJsonObject);
    function getAccounts: TQuickBooksListBaseGUI;
    function getTaxcodes: TQuickBooksListBaseGUI;
    function getTaxRates: TQuickBooksListBaseGUI;
    function getTerms: TQuickBooksListBaseGUI;
  Protected
    fstablename :String;
    fdata: String;
    reccount:Integer;
    QBitem :TQBitem;


    function GetJsonListName: String;Virtual;abstract;
    procedure Extrafields(const Value: TJsonObject);Virtual;
    function FieldsSQL(QBFieldList:TQBFieldList): String;Virtual;
    procedure SetGridColumns; Override;
    Procedure LoaddataFromfile(const Filename:String);
    Function QuickBooksListSearchDescription:String;Virtual;
    procedure AfterFormShow;Override;
    procedure SetDataSQL(const Value: TJsonObject; aTablename:STring;QBFieldList:TQBFieldList; HeaderIDField:String = '');Virtual;
    Procedure MakeQrymain;Virtual;
    procedure MakeTable;Virtual;
    procedure DoUpdatenDeleteTempTable;Virtual;
    procedure OnSelectERP(Sender: TwwDbGrid);Virtual;
    Procedure ERPTableFields;Virtual;
    Procedure ERPTable;Virtual;
  public
    Property Data : String read fdata write SetData;
    Property JsonListName:String read getjsonListName;
    procedure RefreshnLocate;
    Procedure RemoveXRef;
    Property ReportTableName:String read fsTablename;
    Procedure RefreshQuery;Override;

    property AccountsForm :TQuickBooksListBaseGUI Read getAccounts;
    property TaxCodesForm :TQuickBooksListBaseGUI Read getTaxcodes;
    property TaxRatesForm :TQuickBooksListBaseGUI Read getTaxRates;
    property TermsForm    :TQuickBooksListBaseGUI Read getTerms;

  end;

const
  SynchtypeTerm = 'Term';
  SynchtypeTaxCode = 'TaxCode';
  SynchtypeTaxRate = 'TaxRate';
  SynchtypeAccount = 'Account';
  SynchtypePaymethod = 'PaymentMethod';

  QuickBooks_ExternalType ='Quickbooks';
  Magento_ExternalType ='Magento';

implementation

uses CommonDbLib, CommonFormLib, CommonLib, tcConst, BusobjExternalXRef, LogLib;



{$R *.dfm}

{ TQuickBooksListBaseGUI }
procedure TQuickBooksListBaseGUI.FormCreate(Sender: TObject);
begin
  fdata := '';
  fsTablename := '';
  makeqrymain;
  btntest.visible := Devmode;
  grdmain.titlelines := 2;
  inherited;
  fbShowcustomiseonMenu := True;
  QBitem := TQBitem.create(Self);
  HaveDateRangeSelection := false;
  KeyIdfieldname := qrymainTID.Fieldname;

end;
procedure TQuickBooksListBaseGUI.FormDestroy(Sender: TObject);
begin
  DoUpdatenDeleteTempTable;
  FreeandNil(QBitem);
  inherited;
end;
procedure TQuickBooksListBaseGUI.DoUpdatenDeleteTempTable;
var
  ctr:Integer;
begin
  DeleteTable(fsTablename);
  if length(QBitem.SubItem)>0 then
    for ctr := low(QBitem.SubItem) to high(QBitem.SubItem) do
      if QBitem.SubItem[ctr].tablename <> '' then
        DeleteTable(QBitem.SubItem[ctr].tablename);
end;
procedure TQuickBooksListBaseGUI.FormShow(Sender: TObject);
begin
  MakeTable;
  inherited;
end;

function TQuickBooksListBaseGUI.getAccounts: TQuickBooksListBaseGUI;
begin
  Result := TQuickBooksListBaseGUI(Ownerform.AccountsForm);
end;

function TQuickBooksListBaseGUI.getTaxcodes: TQuickBooksListBaseGUI;
begin
  Result := TQuickBooksListBaseGUI(Ownerform.TaxCodesForm);
end;

function TQuickBooksListBaseGUI.getTaxRates: TQuickBooksListBaseGUI;
begin
  Result := TQuickBooksListBaseGUI(Ownerform.TaxratesForm);
end;

function TQuickBooksListBaseGUI.getTerms: TQuickBooksListBaseGUI;
begin
  Result := TQuickBooksListBaseGUI(Ownerform.TermsForm);
end;

procedure TQuickBooksListBaseGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainSynchStatus.asString = 'Done' then GreennFont(AFont)
  else if qryMainSynchStatus.asString = 'New' then RedFont(AFont);
end;

procedure TQuickBooksListBaseGUI.grdMainDblClick(Sender: TObject);
var
  fsList  :String;
begin
  if Qrymainid.asString = '' then exit;
  fsList := '';
       if sametext(jsonListName , SynchtypeTerm    ) then fsList := 'TTermsListGUI'
  else if sametext(jsonListName , SynchtypeTaxCode ) then fsList := 'TTaxCodeListGUI'
  else if sametext(jsonListName , SynchtypeAccount ) then fsList := 'TChartOfAccountsListGUI'
  else if sametext(jsonListName , SynchtypeTaxrate ) then fsList := 'TSubTaxcodesGUI'
  else if sametext(jsonListName , SynchtypePaymethod ) then fsList := 'TPaymentMethodListGUI'
  else begin
    inherited;
    Exit;
  end;
  if fsList <> '' then
    OpenERPListFormSingleselect(fsList, OnSelectERP , InitERPList, AfterShowERPList , False);
end;
Procedure TQuickBooksListBaseGUI.RefreshnLocate;
begin
    KeyIdtoLocate := qrymainTId.asInteger;
    try
      RefreshQuery;
    finally
      KeyIdtoLocate := 0;
    end;
end;
procedure TQuickBooksListBaseGUI.RefreshQuery;
begin
  inherited;
end;

procedure TQuickBooksListBaseGUI.RemoveXRef;
begin
Processingcursor(true);
  try
      if qryMainERPID.asInteger <> 0 then begin
          if TExternalXRef.RemoveXRef(QuickBooks_ExternalType,jsonListName    ,qryMainERPID.asInteger, Qrymainid.asString) then begin
            MessageDlgXP_vista('Quickbooks - ERP Link Removed', mtInformation, [mbOK], 0);
            RefreshnLocate;
          end;
      end else begin
        MessageDlgXP_vista('Selected Item is not Linked', mtInformation, [mbOK], 0);
      end;
  finally
    Processingcursor(False);
  end;
end;

Procedure TQuickBooksListBaseGUI.OnSelectERP(Sender: TwwDbGrid);
var
//  senderform: TBaseListingGUI;
  fiid:Integer;
begin
  if Assigned(Sender.Owner) then
    if (Sender.Owner is TBaseListingGUI) and
       (TBaseListingGUI(Sender.Owner).KeyIdfieldname <> '') and
       (TBaseListingGUI(Sender.Owner).qrymain.findfield(TBaseListingGUI(Sender.Owner).KeyIdfieldname)<>nil) then begin
      fiid := TBaseListingGUI(Sender.Owner).qrymain.fieldbyname(TBaseListingGUI(Sender.Owner).KeyIdfieldname).asInteger;
      if fiid <> 0 then begin
        if QrymainERPID.asInteger = fiid then exit;
                 if sametext(jsonListName , SynchtypeTerm    ) then begin TExternalXRef.MakeXRef(QuickBooks_ExternalType,SynchtypeTerm    ,fiid , Qrymainid.asString);
        end else if sametext(jsonListName , SynchtypeTaxCode ) then begin TExternalXRef.MakeXRef(QuickBooks_ExternalType,SynchtypeTaxCode ,fiid , Qrymainid.asString);
        end else if sametext(jsonListName , SynchtypeAccount ) then begin TExternalXRef.MakeXRef(QuickBooks_ExternalType,SynchtypeAccount ,fiid , Qrymainid.asString);
        end else if sametext(jsonListName , SynchtypeTaxrate ) then begin TExternalXRef.MakeXRef(QuickBooks_ExternalType,SynchtypeTaxrate ,fiid , Qrymainid.asString);
        end else if sametext(jsonListName , SynchtypePaymethod ) then begin TExternalXRef.MakeXRef(QuickBooks_ExternalType,SynchtypePaymethod ,fiid , Qrymainid.asString);
        end else begin Exit;
        end;
        RefreshnLocate;
      end;
    end;
end;
Procedure TQuickBooksListBaseGUI.InitERPList(Sender: TObject);
begin
if sender is TBaseListingGUI then begin
  TBaseListingGUI(Sender).KeyIdtoLocate := QrymainERPID.asInteger;
end;
end;

procedure TQuickBooksListBaseGUI.LoaddataFromfile(const Filename: String);
var
  aJo : TJsonObject;
begin
  aJo := JO;
  try
    aJo.LoadFromFile(Filename);
    Data :=aJo.asString;
  finally
    aJo.Free;
  end;
end;

procedure TQuickBooksListBaseGUI.AfterFormShow;
begin
  inherited;
end;

Procedure TQuickBooksListBaseGUI.AfterShowERPList(Sender: TObject);
begin
if sender is TBaseListingGUI then begin
  if TBaseListingGUI(Sender).KeyNamefieldname <> '' then TBaseListingGUI(Sender).grdmain.SetActivefield(TBaseListingGUI(Sender).KeyNamefieldname);
  TBaseListingGUI(Sender).edtSearch.Text := QuickBooksListSearchDescription;
end;

end;

Procedure TQuickBooksListBaseGUI.MakeTable;
var
  ctr:Integer;
begin
    with scriptmain do begin
      SQL.Clear;
      SQL.add('Create table if not exists '+ fstablename +'( '+
        ' TID INT(11) NOT NULL AUTO_INCREMENT, '+
        fieldsSQL(QBitem.QBFieldList)+
        'Seqno int(11) null default null , '+
        'PRIMARY KEY (TID),'+
        'INDEX IDIdx (ID))'+
        'ENGINE=MyIsam;');
      if length(QBitem.SubItem)>0 then
        for ctr := low(QBitem.SubItem) to high(QBitem.SubItem) do begin
          SQL.add('Create table if not exists '+ QBitem.SubItem[ctr].tablename +'( '+
          ' SubTID INT(11) NOT NULL AUTO_INCREMENT, '+
          QBitem.SubItem[ctr].HeaderIDField + ' int(11) null default null , '+
          fieldsSQL(QBitem.SubItem[ctr].QBFieldList)+
          'Seqno int(11) null default null , '+
          'PRIMARY KEY (SubTID),'+
          'INDEX '+trim(QBitem.SubItem[ctr].HeaderIDField) +'Idx ('+QBitem.SubItem[ctr].HeaderIDField+'))'+
          'ENGINE=MyIsam;');
        end;
      logtext(SQL.text);
      Execute;
    end;
end;

procedure TQuickBooksListBaseGUI.SetData(const Value: String);
var
  aJo : TJsonObject;
  ctr:Integer;
  fi:Integer;
begin
  MakeTable;
  With scriptmain do begin
    SQL.Clear;
    SQL.add('truncate '+ fstablename +';');
    if length(QBitem.SubItem)>0 then
      for ctr := low(QBitem.SubItem) to high(QBitem.SubItem) do
        if QBitem.SubItem[ctr].tablename <> '' then
          SQL.add('truncate '+ QBitem.SubItem[ctr].tablename +';');
    fi := SQL.count;

    fdata := Value;
    aJo := JO;
    try
      aJo.asString := Value;
      if aJO.A[jsonListName].Count > 0 then begin
          For Ctr := 0 to aJO.A[jsonListName].Count -1 do begin
            reccount := ctr+1;
            try
              SetDataSQL(aJO.A[jsonListName][ctr].AsObject , fstablename, QBitem.QBFieldList);
              SetSubItems(aJO.A[jsonListName][ctr].AsObject);
            Except
              on E:Exception do begin
                  MessageDlgXP_vista('Importing ' + quotedstr(jsonListName) +' Data Failed.'+NL+E.message, mtWarning, [mbOK], 0);
              end;
            end;
          end;
      end;
    finally
      aJo.Free;
    end;
    if SQL.count >fi then begin
      ExecutewithProgress(False);
      RefreshQuery;
    end;
  end;
end;
procedure TQuickBooksListBaseGUI.SetSubItems(ajo: TJsonObject);
var
  ctr1, ctr2:Integer;
  aSubJo: TJsonObject;
  fsArrayname:String;
begin
  if length(QBitem.SubItem)=0 then exit;

  for ctr1 := low(QBitem.SubItem) to high(QBitem.SubItem) do begin
    if QBitem.SubItem[ctr1].ArrayName <> '' then begin
       fsArrayname :=QBitem.SubItem[ctr1].ArrayName;
      aSubJo := JO;
      try
        aSubJo.asString := ajo.asString;
        if QBitem.SubItem[ctr1].ITemName <> '' then aSubJo :=aSubJo.O[QBitem.SubItem[ctr1].ITemName];
        if aSubJo.A[fsArrayname].Count > 0 then begin
              For Ctr2 := 0 to aSubJo.A[fsArrayname].Count -1 do begin
                try
                  if QBitem.SubItem[ctr1].ArrayItemname <> '' then
                       SetDataSQL(aSubJo.A[fsArrayname][ctr2].AsObject.O[QBitem.SubItem[ctr1].ArrayItemname].AsObject , QBitem.SubItem[ctr1].tablename, QBitem.SubItem[ctr1].QBFieldList, QBitem.SubItem[ctr1].HeaderIDField)
                  else SetDataSQL(aSubJo.A[fsArrayname][ctr2].AsObject                                                , QBitem.SubItem[ctr1].tablename, QBitem.SubItem[ctr1].QBFieldList, QBitem.SubItem[ctr1].HeaderIDField);
                Except
                  on E:Exception do begin
                      MessageDlgXP_vista('Importing ' + quotedstr(jsonListName) +' Data Failed.'+NL+E.message, mtWarning, [mbOK], 0);
                  end;
                end;
              end;

        end;
      finally
         aSubJo.free;
      end;
    end;
  end;

end;
function TQuickBooksListBaseGUI.fieldsSQL(QBFieldList:TQBFieldList):String;
var
  ctr:Integer;
begin
  Result := '';

  if QBFieldList.Stringfields.Count >0 then
    for ctr := 0 to QBFieldList.Stringfields.Count-1 do
      REsult := result +QBFieldList.Stringfields[ctr]+ ' varchar(255) null default null,';

  if QBFieldList.Booleanfield.Count >0 then
    for ctr := 0 to QBFieldList.Booleanfield.Count-1 do
      REsult := result +QBFieldList.Booleanfield[ctr]+ ' Enum("T","F") default "F",';

  if QBFieldList.IntegerFields.Count >0 then
    for ctr := 0 to QBFieldList.IntegerFields.Count-1 do
      REsult := result +QBFieldList.IntegerFields[ctr]+ ' Int(11) null default null,';

  if QBFieldList.Doublefields.Count >0 then
    for ctr := 0 to QBFieldList.Doublefields.Count-1 do
      REsult := result +QBFieldList.Doublefields[ctr]+ ' Double null default null,';


end;
procedure TQuickBooksListBaseGUI.MakeQryMain;
begin
  if fsTableName = '' then begin
    fsTableName := GetUserTemporaryTableName(jsonListName);
    Qrymain.SQL.Clear;
    Qrymain.SQL.Add('Select');
    Qrymain.SQL.Add('T.*,');
    Qrymain.SQL.Add('ER.ID as ERID, ');
    Qrymain.SQL.Add('ER.ERPID as ERPID, ');
    ERPTableFields;
    Qrymain.SQL.Add('if(ifnull(ER.ID,0)=0 , "New" , "Done") as SynchStatus');
    Qrymain.SQL.Add('from ' + fsTablename +'  T ');
    Qrymain.SQL.Add('Left join tblexternalxref ER on T.Id = ER.ExternalID and ER.ObjectType =' +quotedstr(jsonListName) +' and ER.ExternalType =' + Quotedstr(QuickBooks_ExternalType));
    ERPTable;
    if QuickBooksListSearchDescription <> '' then Qrymain.SQL.Add('Order by ' + QuickBooksListSearchDescription);
  end;
end;
procedure TQuickBooksListBaseGUI.SetDataSQL(const Value: TJsonObject; aTablename:String; QBFieldList:TQBFieldList; HeaderIDField:String = '');
var
  ctr:Integer;
begin
  with scriptmain do begin
    SQL.add('insert into '+aTablename +' set');
    if QBFieldList.Stringfields.count >0 then
      for ctr:= 0 to QBFieldList.Stringfields.count-1 do
        SQL.add(QBFieldList.Stringfields[ctr] +'= '+ QuotedStr(Value.S[QBFieldList.Stringfields[ctr]])            +',');

    if QBFieldList.IntegerFields.count >0 then
      for ctr:= 0 to QBFieldList.IntegerFields.count-1 do
        SQL.add(QBFieldList.IntegerFields[ctr] +'= '+ Inttostr(Value.I[QBFieldList.IntegerFields[ctr]])            +',');

    if QBFieldList.Booleanfield.count >0 then
      for ctr:= 0 to QBFieldList.Booleanfield.count-1 do
        if Value.B[QBFieldList.Booleanfield[ctr]] then
             SQL.add(QBFieldList.Booleanfield[ctr] +'= '+ QuotedStr('T')+',')
        else SQL.add(QBFieldList.Booleanfield[ctr] +'= '+ QuotedStr('F')+',');

    if QBFieldList.Doublefields.count >0 then
      for ctr:= 0 to QBFieldList.Doublefields.count-1 do
        SQL.add(QBFieldList.Doublefields[ctr] +'= '+ Floattostr(Value.I[QBFieldList.Doublefields[ctr]])            +',');


    if HeaderIDField <> '' then SQL.add(HeaderIDField +'= '+ inttostr(reccount)           +';')
    else begin
      Extrafields(Value);
      SQL.add('Seqno =' + inttostr(reccount)+';');
    end;

  end;

end;

procedure TQuickBooksListBaseGUI.SetGridColumns;
begin
  inherited;
 RemoveFieldfromGrid(qryMainTID.fieldname);
 RemoveFieldfromGrid(qryMainId.fieldname);
 RemoveFieldfromGrid(qryMainERID.fieldname);
 RemoveFieldfromGrid(qryMainERPID.fieldname);
 RemoveFieldfromGrid(qryMainSynchStatus.fieldname);
end;

Procedure TQuickBooksListBaseGUI.ERPTable;
begin
end;

Procedure TQuickBooksListBaseGUI.ERPTableFields;
begin
end;

procedure TQuickBooksListBaseGUI.Extrafields(const Value: TJsonObject);
begin
end;

function TQuickBooksListBaseGUI.Ownerform: TQuickBooksListGUI;
begin
  result := nil;
  if assigned(Owner) then
    if owner is TQuickBooksListGUI then
      result := TQuickBooksListGUI(Owner);
end;
function TQuickBooksListBaseGUI.QuickBooksListSearchDescription: String;
begin
  Result := '';
end;



end.


