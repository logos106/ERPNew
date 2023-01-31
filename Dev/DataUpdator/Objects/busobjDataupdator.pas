unit busobjDataupdator;

interface

uses BusobjProductProperties,classes, BusObjBase, db, BusObjCommon;

type
  TDataupdatorExtraSellPrice = class(TProductExtraSellPrice)
  Private
    fsTablename:String;
    function getVariationOption :String;
    function getVariationtype :String;
    Function GetVariationAmt:Double;
    function getDeleted :Boolean;
    Procedure SetVariationOption(Const Value:String);
    Procedure SetVariationtype(Const Value:STring);
    Procedure SetVariationAmt(Const Value:Double);
    Procedure setDeleted(const Value:Boolean);
  Protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
    function DoBeforePost(Sender: TDatasetBusObj): boolean; Override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
  Public
    constructor Create(AOwner: TComponent); override;
    Property Tablename :String read fsTablename;
    function OverlapingESP: TDataset;
    function ValidateData: Boolean;Override;
  Published
    Property VariationOption :String read getVariationOption write setVariationOption;
    Property Variationtype :String read getVariationtype write setVariationtype;
    Property VariationAmt :double read getVariationAmt write setVariationAmt;
    Property Deleted :Boolean read getDeleted write setDeleted;
  end;
  TDataUpdatorForeignSellPrice = class(TProductForeignSellPrice)
  Private
    fsTablename:String;
    function getVariationOption :String;
    function getVariationtype :String;
    Function GetVariationAmt:Double;
    function getDeleted :Boolean;
    Procedure SetVariationOption(Const Value:String);
    Procedure SetVariationtype(Const Value:STring);
    Procedure SetVariationAmt(Const Value:Double);
    Procedure setDeleted(const Value:Boolean);
    function RecordExists: boolean;
  Protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
    function DoBeforePost(Sender: TDatasetBusObj): boolean; Override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
  Public
    constructor Create(AOwner: TComponent); override;
    Property Tablename :String read fsTablename;
    function ValidateData: Boolean;Override;
  Published
    Property VariationOption :String read getVariationOption write setVariationOption;
    Property Variationtype :String read getVariationtype write setVariationtype;
    Property VariationAmt :double read getVariationAmt write setVariationAmt;
    Property Deleted :Boolean read getDeleted write setDeleted;
  end;
  TDataUpdatorSpecialProducts = class(TSpecialProducts)
  Private
    fsTablename:String;
    function getVariationOption :String;
    function getVariationtype :String;
    Function GetVariationAmt:Double;
    function getDeleted :Boolean;
    Procedure SetVariationOption(Const Value:String);
    Procedure SetVariationtype(Const Value:STring);
    Procedure SetVariationAmt(Const Value:Double);
    Procedure setDeleted(const Value:Boolean);
    function RecordExists: boolean;
  Protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
    function DoBeforePost(Sender: TDatasetBusObj): boolean; Override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
  Public
    constructor Create(AOwner: TComponent); override;
    Property Tablename :String read fsTablename;
    function ValidateData: Boolean;Override;
  Published
    Property VariationOption :String read getVariationOption write setVariationOption;
    Property Variationtype :String read getVariationtype write setVariationtype;
    Property VariationAmt :double read getVariationAmt write setVariationAmt;
    Property Deleted :Boolean read getDeleted write setDeleted;
  end;
  TDataUpdatorExtraBuyPrice = class(TProductExtraBuyPrice)
  Private
    fsTablename:String;
    function getVariationOption :String;
    function getVariationtype :String;
    Function GetVariationAmt:Double;
    function getDeleted :Boolean;
    Procedure SetVariationOption(Const Value:String);
    Procedure SetVariationtype(Const Value:STring);
    Procedure SetVariationAmt(Const Value:Double);
    Procedure setDeleted(const Value:Boolean);
    function RecordExists: boolean;
  Protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
    function DoBeforePost(Sender: TDatasetBusObj): boolean; Override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
  Public
    constructor Create(AOwner: TComponent); override;
    Property Tablename :String read fsTablename;
    function ValidateData: Boolean;Override;
  Published
    Property VariationOption :String read getVariationOption write setVariationOption;
    Property Variationtype :String read getVariationtype write setVariationtype;
    Property VariationAmt :double read getVariationAmt write setVariationAmt;
    Property Deleted :Boolean read getDeleted write setDeleted;
  end;
  TDataUpdatorForeignBuyPrice = class(TProductForeignBuyPrice)
  Private
    fsTablename:String;
    function getVariationOption :String;
    function getVariationtype :String;
    Function GetVariationAmt:Double;
    function getDeleted :Boolean;
    Procedure SetVariationOption(Const Value:String);
    Procedure SetVariationtype(Const Value:STring);
    Procedure SetVariationAmt(Const Value:Double);
    Procedure setDeleted(const Value:Boolean);
    function RecordExists: boolean;
  Protected
    function DoAfterInsert(Sender: TDatasetBusObj): boolean; Override;
    function DoBeforePost(Sender: TDatasetBusObj): boolean; Override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
  Public
    constructor Create(AOwner: TComponent); override;
    Property Tablename :String read fsTablename;
    function ValidateData: Boolean;Override;
  Published
    Property VariationOption :String read getVariationOption write setVariationOption;
    Property Variationtype :String read getVariationtype write setVariationtype;
    Property VariationAmt :double read getVariationAmt write setVariationAmt;
    Property Deleted :Boolean read getDeleted write setDeleted;
  end;


implementation

uses CommonDbLib , SysUtils, MySQLConst;



{ TDataupdatorExtraSellPrice }

constructor TDataupdatorExtraSellPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fsTablename := commondbLib.CreateUserTemporaryTable('tblExtraPriceSell' , '');
  ExecuteSQL('ALTER TABLE `'+fsTablename +'` ' +
              ' Add column deleted enum("T","F") default "F",'+
	            ' ADD COLUMN `VariationOption` ENUM("I","D","U") NULL DEFAULT "U" , ' +
	            ' ADD COLUMN `Variationtype` ENUM("P","A") NULL DEFAULT "P" , ' +
	            ' ADD COLUMN `VariationAmt` DOUBLE NULL DEFAULT 0 ;');
  fSQL:= 'Select * from '+fsTablename ;
end;
function TDataupdatorExtraSellPrice.getVariationOption :String; begin result:= getStringField('VariationOption');end;
function TDataupdatorExtraSellPrice.getVariationtype :String;begin result:= getStringField('Variationtype');end;
function TDataupdatorExtraSellPrice.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  VariationOption :='U';
  Variationtype := 'A';
  Deleted:= False;
  (*PostDb;
  EditDB;*)
end;

function TDataUpdatorExtraSellPrice.ValidateData:Boolean;
begin
  Result := False;
  if (ClientTypeID = 0) and (UOMID = 0) and (not AllClients) then begin
    REsultstatus.addItem(False, rssWarning, 0, 'No Client Type or UOM, Extra Sell Price requires a UOM or Client Type or All Clients to be selected');
    Exit;
  end;
  if (VariationOption ='U') and (QtyPercent1=0) and (Price1=0) then begin
    REsultstatus.addItem(False, rssWarning, 0, 'Please provide a ''% Discount'' or ''Price (EX)''');
    Exit;
  end;
  if (Variationoption <> 'U') and (VariationAmt =0) then begin
    REsultstatus.addItem(False, rssWarning, 0, 'Please provide a Variation Amount');
    Exit;
  end;
  result := true;
end;
function TDataUpdatorExtraSellPrice.OverlapingESP:TDataset;
var
  strSQL:String;
begin
  strSQL:='Select * from  ' +Tablename+
          ' where Deleted ="F" and   ((ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateFrom)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateFrom)) +' ) '+
          ' Or ( ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateTo)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateTo)) +'  )'+
          ' Or ( ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') >=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateFrom)) +'  and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')<=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateTo)) +'  ))'+
          ' and ifnull(UOM,"")= '+Quotedstr(UOMname) +
          ' and ifnull(ClienttypeID,0)='+IntToStr(ClientTypeID) +
          ' and ifnull(priceID,0)<> ' + IntToStr(ID);
  result := GetNewDataset(strSQL,true);

end;
function TDataupdatorExtraSellPrice.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  Result:= inherited DoBeforePost(Sender);
  if not result then exit;
  if REcordEmpty(Dataset , 'ClientTypeName,Price1,UOM,QtyPercent1') then
    deleted := True;

  AllClients := ClientTypeID=0;

  With OverlapingESP do try
      if recordcount > 0 then begin
        ResultStatus.Clear;
        ResultStatus.AddItem(False, rsswarning, 0 , 'you have already added an entry for An Overlaping Period and Same Unit Of Measure.' );
        abort;
      end;
  finally
      if active then close;
      Free;
  end;
end;


procedure TDataupdatorExtraSellPrice.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'QtyPercent1') then begin
    if QtyPercent1<> 0 then Price1:= 0;
  end else if SysUtils.SameText(Sender.fieldName, 'Price1') then begin
    if Price1<> 0 then QtyPercent1:= 0;
  end;
end;

function TDataupdatorExtraSellPrice.GetSQL: string;
begin
  result:= inherited GetSQL;
end;

Function TDataupdatorExtraSellPrice.GetVariationAmt:Double;begin result:= getfloatField('VariationAmt');end;
Function TDataupdatorExtraSellPrice.Getdeleted:Boolean; begin result := GetBooleanField('Deleted');end;
Procedure TDataupdatorExtraSellPrice.SetVariationOption(Const Value:String);begin SetStringField('VariationOption',Value);end;
Procedure TDataupdatorExtraSellPrice.SetVariationtype(Const Value:STring);begin SetStringfield('Variationtype' ,Value);end;
Procedure TDataupdatorExtraSellPrice.SetVariationAmt(Const Value:Double);begin SetFloatField('VariationAmt', value);end;
Procedure TDataupdatorExtraSellPrice.SetDeleted(const Value:Boolean);begin setBooleanField('Deleted',Value);end;

{ TDataUpdatorForeignSellPrice }

constructor TDataUpdatorForeignSellPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fsTablename := commondbLib.CreateUserTemporaryTable('tblForeignPrice' , 'Sell');
  ExecuteSQL('ALTER TABLE `'+fsTablename +'` ' +
              ' Add column deleted enum("T","F") default "F",'+
	            ' ADD COLUMN `VariationOption` ENUM("I","D","U") NULL DEFAULT "U" , ' +
	            ' ADD COLUMN `Variationtype` ENUM("P","A") NULL DEFAULT "P" , ' +
	            ' ADD COLUMN `VariationAmt` DOUBLE NULL DEFAULT 0 ;'+
              ' ALTER TABLE `'+fsTablename +'` 	DROP INDEX `Secondary`;');
  fSQL:= 'Select * from '+fsTablename ;
end;
function TDataUpdatorForeignSellPrice.getVariationOption :String; begin result:= getStringField('VariationOption');end;
function TDataUpdatorForeignSellPrice.getVariationtype :String;begin result:= getStringField('Variationtype');end;
function TDataUpdatorForeignSellPrice.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  VariationOption :='U';
  Variationtype := 'A';
  Deleted:= False;
  Qty1:= 1;
  (*PostDb;
  EditDB;*)
end;

function TDataUpdatorForeignSellPrice.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  Result:= inherited DoBeforePost(Sender);
  if not result then exit;
  if REcordEmpty(Dataset , 'Price1,Code') then
    deleted := True
  else if recordexists then begin
        ResultStatus.Clear;
        ResultStatus.AddItem(False, rsswarning, 0 , 'you have already added an entry for the same.' );
        abort;
  end;
end;
function TDataUpdatorForeignSellPrice.RecordExists: boolean;
begin
  With getNewDataset('Select * from ' + fstablename +' where   ClientID = ' + inttostr(ClientID) +
                                                      ' and UOM =' +Quotedstr(UOMName) +
                                                      ' and CurrencyId = ' + inttostr(CurrencyId) +
                                                      ' and ForeignPriceID <> ' + inttostr(ID) , true) do try
    result:= recordcount>0;
  finally
    if active then close;
    free;
  end;
end;

procedure TDataUpdatorForeignSellPrice.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, '') then begin
  end;
end;

function TDataUpdatorForeignSellPrice.GetSQL: string;
begin
  result:= inherited GetSQL;
end;

Function TDataUpdatorForeignSellPrice.GetVariationAmt:Double;begin result:= getfloatField('VariationAmt');end;
Function TDataUpdatorForeignSellPrice.Getdeleted:Boolean; begin result := GetBooleanField('Deleted');end;
Procedure TDataUpdatorForeignSellPrice.SetVariationOption(Const Value:String);begin SetStringField('VariationOption',Value);end;
Procedure TDataUpdatorForeignSellPrice.SetVariationtype(Const Value:STring);begin SetStringfield('Variationtype' ,Value);end;
function TDataUpdatorForeignSellPrice.ValidateData: Boolean;
begin
  Result := False;
  if CurrencyId =0 then begin
    REsultstatus.addItem(False, rssWarning, 0, 'Currency should not be blank');
    Exit;
  end;
  if (Price1 =0) and (Variationoption ='U') then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Price(Ex)'' should not be blank');
    Exit;
  end;
  if  (Variationoption <>'U') and (VariationAmt=0) then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Variation amount'' should not be blank');
    Exit;
  end;
  REsult:= True;
end;

Procedure TDataUpdatorForeignSellPrice.SetVariationAmt(Const Value:Double);begin SetFloatField('VariationAmt', value);end;
Procedure TDataUpdatorForeignSellPrice.SetDeleted(const Value:Boolean);begin setBooleanField('Deleted',Value);end;

{ TDataUpdatorExtraBuyPrice }

constructor TDataUpdatorExtraBuyPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fsTablename:= commondbLib.CreateUserTemporaryTable('tblExtraPrice' , '');
  ExecuteSQL('ALTER TABLE `'+fsTablename +'` ' +
              ' Add column deleted enum("T","F") default "F",'+
	            ' ADD COLUMN `VariationOption` ENUM("I","D","U") NULL DEFAULT "U" , ' +
	            ' ADD COLUMN `Variationtype` ENUM("P","A") NULL DEFAULT "P" , ' +
	            ' ADD COLUMN `VariationAmt` DOUBLE NULL DEFAULT 0 ;'+
              ' ALTER TABLE `'+fsTablename +'` 	DROP INDEX `Secondary`;');
  fSQL:= 'Select * from '+fsTablename ;
end;
function TDataUpdatorExtraBuyPrice.getVariationOption :String; begin result:= getStringField('VariationOption');end;
function TDataUpdatorExtraBuyPrice.getVariationtype :String;begin result:= getStringField('Variationtype');end;
function TDataUpdatorExtraBuyPrice.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  VariationOption :='U';
  Variationtype := 'A';
  Deleted:= False;
  BuyQty1:= 1;
  (*PostDb;
  EditDB;*)
end;

function TDataUpdatorExtraBuyPrice.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  Result:= inherited DoBeforePost(Sender);
  if not result then exit;
  if REcordEmpty(Dataset , 'SupplierName,Price,UOM') then
    deleted := True
  else if recordexists then begin
        ResultStatus.Clear;
        ResultStatus.AddItem(False, rsswarning, 0 , 'you have already added an entry for the same.' );
        abort;
  end;

end;
function TDataUpdatorExtraBuyPrice.RecordExists: boolean;
begin
  With getNewDataset('Select * from ' + fstablename +
                    ' where   SUPPLIERID = ' + inttostr(SupplierID) +
                    ' and UOM =' +Quotedstr(uomname) +
                    ' and EXTRAPARTPRICEID <> ' + inttostr(ID) , true) do try
    result:= recordcount>0;
  finally
    if active then close;
    free;
  end;
end;

procedure TDataUpdatorExtraBuyPrice.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, '') then begin
  end;
end;

function TDataUpdatorExtraBuyPrice.GetSQL: string;
begin
  result:= inherited GetSQL;
end;

Function TDataUpdatorExtraBuyPrice.GetVariationAmt:Double;begin result:= getfloatField('VariationAmt');end;
Function TDataUpdatorExtraBuyPrice.Getdeleted:Boolean; begin result := GetBooleanField('Deleted');end;
Procedure TDataUpdatorExtraBuyPrice.SetVariationOption(Const Value:String);begin SetStringField('VariationOption',Value);end;
Procedure TDataUpdatorExtraBuyPrice.SetVariationtype(Const Value:STring);begin SetStringfield('Variationtype' ,Value);end;
function TDataUpdatorExtraBuyPrice.ValidateData: Boolean;
begin
  Result := False;
  if (BuyQty1Price =0) and (Variationoption ='U')  then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Price(Ex)'' should not be blank');
    Exit;
  end;
  if  (Variationoption <>'U') and (VariationAmt=0) then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Variation amount'' should not be blank');
    Exit;
  end;
  REsult:= True;
end;

Procedure TDataUpdatorExtraBuyPrice.SetVariationAmt(Const Value:Double);begin SetFloatField('VariationAmt', value);end;
Procedure TDataUpdatorExtraBuyPrice.SetDeleted(const Value:Boolean);begin setBooleanField('Deleted',Value);end;

{ TDataUpdatorSpecialProducts }

constructor TDataUpdatorSpecialProducts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fsTablename:= commondbLib.CreateUserTemporaryTable('tblCustomerLines' , '');
  ExecuteSQL('ALTER TABLE `'+fsTablename +'` ' +
              ' Add column deleted enum("T","F") default "F",'+
	            ' ADD COLUMN `VariationOption` ENUM("I","D","U") NULL DEFAULT "U" , ' +
	            ' ADD COLUMN `Variationtype` ENUM("P","A") NULL DEFAULT "P" , ' +
	            ' ADD COLUMN `VariationAmt` DOUBLE NULL DEFAULT 0 ;'+
              ' ALTER TABLE `'+fsTablename +'` 	DROP INDEX `Secondary`;');
  fSQL:= 'Select * from '+fsTablename ;
end;
function TDataUpdatorSpecialProducts.getVariationOption :String; begin result:= getStringField('VariationOption');end;
function TDataUpdatorSpecialProducts.getVariationtype :String;begin result:= getStringField('Variationtype');end;
function TDataUpdatorSpecialProducts.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  VariationOption :='U';
  Variationtype := 'A';
  Deleted:= False;
  (*PostDb;
  EditDB;*)
end;

function TDataUpdatorSpecialProducts.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  Result:= inherited DoBeforePost(Sender);
  if not result then exit;
  if REcordEmpty(Dataset , 'ProductID,Price,UOM,VariationAmt') then
    deleted := True
  else if recordexists then begin
        ResultStatus.Clear;
        ResultStatus.AddItem(False, rsswarning, 0 , 'you have already added an entry for the same.' );
        abort;
  end;

end;
function TDataUpdatorSpecialProducts.RecordExists: boolean;
begin
  With getNewDataset('Select * from ' + fstablename +
                    ' where   CustomerId = ' + inttostr(CustomerId) +
                    ' and UOM =' +Quotedstr(UOM) +
                    ' and CustomerLinesID <> ' + inttostr(ID) , true) do try
    result:= recordcount>0;
  finally
    if active then close;
    free;
  end;
end;

procedure TDataUpdatorSpecialProducts.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, '') then begin
  end;
end;

function TDataUpdatorSpecialProducts.GetSQL: string;
begin
  result:= inherited GetSQL;
end;

Function TDataUpdatorSpecialProducts.GetVariationAmt:Double;begin result:= getfloatField('VariationAmt');end;
Function TDataUpdatorSpecialProducts.Getdeleted:Boolean; begin result := GetBooleanField('Deleted');end;
Procedure TDataUpdatorSpecialProducts.SetVariationOption(Const Value:String);begin SetStringField('VariationOption',Value);end;
Procedure TDataUpdatorSpecialProducts.SetVariationtype(Const Value:STring);begin SetStringfield('Variationtype' ,Value);end;
function TDataUpdatorSpecialProducts.ValidateData: Boolean;
begin
  Result := False;
  if (LinePrice =0) and (Variationoption ='U')  then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Price(Ex)'' should not be blank');
    Exit;
  end;
  if  (Variationoption <>'U') and (VariationAmt=0) then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Variation amount'' should not be blank');
    Exit;
  end;
  REsult:= True;
end;

Procedure TDataUpdatorSpecialProducts.SetVariationAmt(Const Value:Double);begin SetFloatField('VariationAmt', value);end;
Procedure TDataUpdatorSpecialProducts.SetDeleted(const Value:Boolean);begin setBooleanField('Deleted',Value);end;
{ TDataUpdatorForeignBuyPrice }

constructor TDataUpdatorForeignBuyPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fsTablename:= commondbLib.CreateUserTemporaryTable('tblForeignPrice' , 'Buy');
  ExecuteSQL('ALTER TABLE `'+fsTablename +'` ' +
              ' Add column deleted enum("T","F") default "F",'+
	            ' ADD COLUMN `VariationOption` ENUM("I","D","U") NULL DEFAULT "U" , ' +
	            ' ADD COLUMN `Variationtype` ENUM("P","A") NULL DEFAULT "P" , ' +
	            ' ADD COLUMN `VariationAmt` DOUBLE NULL DEFAULT 0 ;'+
              ' ALTER TABLE `'+fsTablename +'` 	DROP INDEX `Secondary`;');
  fSQL:= 'Select * from '+fsTablename ;
end;
function TDataUpdatorForeignBuyPrice.getVariationOption :String; begin result:= getStringField('VariationOption');end;
function TDataUpdatorForeignBuyPrice.getVariationtype :String;begin result:= getStringField('Variationtype');end;
function TDataUpdatorForeignBuyPrice.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  VariationOption :='U';
  Variationtype := 'A';
  Deleted:= False;
  Qty1:= 1;
  (*PostDb;
  EditDB;*)
end;

function TDataUpdatorForeignBuyPrice.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  Result:= inherited DoBeforePost(Sender);
  if not result then exit;
  if REcordEmpty(Dataset , 'SupplierName,CurrencyCode,Price1,UOM') then
    deleted := True
  else if recordexists then begin
        ResultStatus.Clear;
        ResultStatus.AddItem(False, rsswarning, 0 , 'you have already added an entry for the same.' );
        abort;
  end;

end;
function TDataUpdatorForeignBuyPrice.RecordExists: boolean;
begin
  With getNewDataset('Select * from ' + fstablename +
                      ' where   ClientID = ' + inttostr(ClientID) +
                      ' and UOM =' +Quotedstr(uomname) +
                      ' and CurrencyId = ' + inttostr(CurrencyId) +
                      ' and ForeignPriceID <> ' + inttostr(ID) , true) do try
    result:= recordcount>0;
  finally
    if active then close;
    free;
  end;
end;

procedure TDataUpdatorForeignBuyPrice.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, '') then begin
  end;
end;

function TDataUpdatorForeignBuyPrice.GetSQL: string;
begin
  result:= inherited GetSQL;
end;

Function TDataUpdatorForeignBuyPrice.GetVariationAmt:Double;begin result:= getfloatField('VariationAmt');end;
Function TDataUpdatorForeignBuyPrice.Getdeleted:Boolean; begin result := GetBooleanField('Deleted');end;
Procedure TDataUpdatorForeignBuyPrice.SetVariationOption(Const Value:String);begin SetStringField('VariationOption',Value);end;
Procedure TDataUpdatorForeignBuyPrice.SetVariationtype(Const Value:STring);begin SetStringfield('Variationtype' ,Value);end;
function TDataUpdatorForeignBuyPrice.ValidateData: Boolean;
begin
  Result := False;
  if CurrencyId =0 then begin
    REsultstatus.addItem(False, rssWarning, 0, 'Currency should not be blank');
    Exit;
  end;
  if (Price1 =0) and (Variationoption ='U') then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Price(Ex)'' should not be blank');
    Exit;
  end;
  if  (Variationoption <>'U') and (VariationAmt=0) then begin
    REsultstatus.addItem(False, rssWarning, 0, '''Variation amount'' should not be blank');
    Exit;
  end;
  REsult:= True;
end;

Procedure TDataUpdatorForeignBuyPrice.SetVariationAmt(Const Value:Double);begin SetFloatField('VariationAmt', value);end;
Procedure TDataUpdatorForeignBuyPrice.SetDeleted(const Value:Boolean);begin setBooleanField('Deleted',Value);end;

end.

