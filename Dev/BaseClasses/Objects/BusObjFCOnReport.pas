unit BusObjFCOnReport;
   {
    Date      Version   Who  What
   ---------- --------  ---  ------------------------------------------------------
   04/07/07   1.00.01   BS   Initial Version.
   }


interface


Uses TypesLib, BusObjBase, DB, Classes,  MyAccess,ERPdbComponents, XMLDoc, XMLIntf, BusObjCurrency;


type

  TForeignCurrencyFieldsOnReport = class(TMSBusObj)
  private
    fCurrency                 : TCurrency;
    function getCurrency      : TCurrency;
    Function GetFormId             : Integer   ;
    Function GetTempTypeID         : Integer   ;
    Function GetQuerySeqNo         : Integer   ;
    Function GetAmountfieldName    : string    ;
    Function GetAmountCaption      : string    ;
    Function GetIsDeptRelated      : Boolean;
    Procedure SetFormId             (const Value: Integer   );
    Procedure SetTempTypeID         (const Value: Integer   );
    Procedure SetQuerySeqNo         (const Value: Integer   );
    Procedure SetAmountfieldName    (const Value: string    );
    Procedure SetAmountCaption      (const Value: string    );
    Procedure SetIsDeptRelated      (const Value: boolean    );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
  Public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
    Property     Currency :TCurrency read getCurrency write fCurrency;
  Published
    property FormId              :Integer     read GetFormId            write SetFormId         ;
    property TempTypeID          :Integer     read GetTempTypeID        write SetTempTypeID     ;
    property QuerySeqNo          :Integer     read GetQuerySeqNo        write SetQuerySeqNo     ;
    property AmountfieldName     :string      read GetAmountfieldName   write SetAmountfieldName;
    property AmountCaption       :string      read GetAmountCaption     write SetAmountCaption  ;
    property IsDeptRelated       :Boolean     read GetIsDeptRelated     write SetIsDeptRelated  ;
  end;

   TForeignCurrencyOnReport = class(TMSBusObj)
   private
      flkTblCurrencyConversion                   :TERPQuery;
      fLoadmemtable                              :TGeneralProc;
      fbCheckingForfields :Boolean;
      Function GetCurrencyid                     :Integer;
      Function GetFormid                         :Integer;
      Function GetListname                       :String ;
      Function GetBuyRate                        :Double ;
      Function GetSellRate                       :Double ;
      Function GetCurrency                       :String ;
      Function GetCode                           :String ;
      function GetSymbol                         :String;
      //function GetRecno                          :String;
      Function GetCountry                        :String ;
      Function GetActive                         :Boolean;
      Function GetShowinthereport                :Boolean;
      Function GetUserid                         :Integer;
      function getlkTblCurrencyConversion        :TERPQuery;
      Procedure SetCurrencyid                    (Const Value :Integer);
      Procedure SetFormid                        (Const Value :Integer);
      Procedure SetListname                      (Const Value :String );
      Procedure SetActive                        (Const Value :Boolean);
      Procedure SetShowinthereport               (Const Value :Boolean);
      Procedure SetUserid                        (Const Value :Integer);
      procedure CheckForfields;
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);Override;
      procedure DoFieldOnChange(Sender: TField);                        Override;
      Function  GetSQL : STring;                                        Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;           Override;
      Function  DoAfterOpen(Sender :TDatasetBusObj ):Boolean;           Override;
   Public
      class function GetBusObjectTablename: string; override;
      class function GetIDField: string; override;
      Constructor  Create(AOwner: TComponent);                          override;
      Destructor   Destroy;                                             override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);               override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                 override;
      Function     ValidateData :Boolean ;                              Override;
      Function     Save :Boolean ;                                      Override;
      Procedure    LoadFCPref;overload;
      Procedure    LoadFCPref(const ListClassName:String);overload;
      Procedure    Load(const fIsReadonly:boolean =False);override;
      Property Loadmemtable :TGeneralProc read fLoadmemtable write fLoadmemtable;
      Property lkTblCurrencyConversion :TERPQuery Read getlkTblCurrencyConversion Write flkTblCurrencyConversion;
   published
      Property Currencyid       :Integer    Read getCurrencyid      Write SetCurrencyid     ;
      Property Formid           :Integer    Read getFormid          Write SetFormid         ;
      Property Listname         :String     Read getListname        Write SetListname       ;
      Property BuyRate          :Double     Read getBuyRate         ;
      Property SellRate         :Double     Read getSellRate        ;
      Property Currency         :String     Read getCurrency        ;
      Property Code             :String     Read getCode            ;
      Property Symbol           :String     Read getSymbol          ;
      Property Country          :String     Read getCountry         ;
      Property Active           :Boolean    Read getActive          Write SetActive         ;
      Property Showinthereport  :Boolean    Read getShowinthereport Write SetShowinthereport;
      Property Userid           :Integer    Read getUserid          Write SetUserid         ;
      //Property Recno            :String     Read GetRecno;
   End;


implementation


uses sysutils, AppEnvironment, CommonDbLib, CommonLib, FCOnreportLib;


{========================================================
         TForeignCurrencyonReport
========================================================}

constructor TForeignCurrencyonReport.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fLoadmemtable := nil;
   fSQL := 'SELECT FCR.* FROM tblforeigncurrencyonreport FCR inner join tblcurrencyconversion CC on FCR.CurrencyID = CC.CurrencyID and CC.Active = "T"';
   fbCheckingForfields := False;
end;


destructor TForeignCurrencyonReport.Destroy;
begin
    inherited;
end;


procedure   TForeignCurrencyonReport.LoadFromXMLNode(Const node: IXMLNode);
begin
    inherited;
    Currencyid                      :=GetXMLNodeIntegerValue(Node,'Currencyid');
    Formid                          :=GetXMLNodeIntegerValue(Node,'Formid');
    Listname                        :=GetXMLNodeStringValue(Node,'Listname');
    Active                          :=GetXMLNodeBooleanValue(Node,'Active');
    Showinthereport                 :=GetXMLNodeBooleanValue(Node,'Showinthereport');
    Userid                          :=GetXMLNodeIntegerValue(Node,'Userid');
end;


procedure   TForeignCurrencyonReport.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    AddXMLNode(node,'Currencyid' ,Currencyid);
    AddXMLNode(node,'Formid' ,Formid);
    AddXMLNode(node,'Listname' ,Listname);
    AddXMLNode(node,'BuyRate',BuyRate);
    AddXMLNode(node,'SellRate',SellRate);
    AddXMLNode(node,'Currency',Currency);
    AddXMLNode(node,'Code',Code);
    AddXMLNode(node,'Symbol',Symbol);
    AddXMLNode(node,'Country',Country);
    AddXMLNode(node,'Active' ,Active);
    AddXMLNode(node,'Showinthereport' ,Showinthereport);
    AddXMLNode(node,'Userid' ,Userid);
end;


function    TForeignCurrencyonReport.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;
Procedure    TForeignCurrencyonReport.Load(const fIsReadonly:boolean =False);
begin
    inherited;
    CheckForfields;
end;
Procedure    TForeignCurrencyonReport.CheckForfields;
var
    Fldcode, fldCurrency, fldcountry, FldSymbol:TWideStringField;
    FldForeignCurrencyonReportID,fldCurrencyID, fldformID,fldUserId :TIntegerField;
    fldListName, fldActive, fldShowinthereport  :TWideStringField;
    FldBuyRate, fldSellRate                    :TFloatField;
    fDataset :TDataset;
begin
    if fbCheckingForfields then exit;
    fbCheckingForfields := True;
    Try
        fDataset := Self.Dataset;
        if Assigned(fDataset) then begin
            Try
                if fDataset.active then fDataset.close;
                if Dataset.findfield('ForeignCurrencyonReportID') = nil then begin
                    if fDataset.active then fDataset.close;
                    fldForeignCurrencyonReportID                     :=  TIntegerField.Create(fDataset.Owner);
                    fldForeignCurrencyonReportID.FieldKind           := fkData;
                    fldForeignCurrencyonReportID.FieldName           := 'ForeignCurrencyonReportID';
                    fldForeignCurrencyonReportID.Lookup              := False;
                    fldForeignCurrencyonReportID.Name                := fdataset.name + 'ForeignCurrencyonReportID';
                    fldForeignCurrencyonReportID.DataSet             := fDataset;
                end;

                if Dataset.findfield('CurrencyID') = nil then begin
                    if fDataset.active then fDataset.close;
                    fldCurrencyID                     :=  TIntegerField.Create(fDataset.Owner);
                    fldCurrencyID.FieldKind           := fkData;
                    fldCurrencyID.FieldName           := 'CurrencyID';
                    fldCurrencyID.Lookup              := False;
                    fldCurrencyID.Name                := fdataset.name + 'CurrencyID';
                    fldCurrencyID.DataSet             := fDataset;
                end;
                if Dataset.findfield('formID') = nil then begin
                    if fDataset.active then fDataset.close;
                    fldformID                     :=  TIntegerField.Create(fDataset.Owner);
                    fldformID.FieldKind           := fkData;
                    fldformID.FieldName           := 'formID';
                    fldformID.Lookup              := False;
                    fldformID.Name                := fdataset.name + 'formID';
                    fldformID.DataSet             := fDataset;
                end;
                if Dataset.findfield('UserId') = nil then begin
                    if fDataset.active then fDataset.close;
                    fldUserId                     :=  TIntegerField.Create(fDataset.Owner);
                    fldUserId.FieldKind           := fkData;
                    fldUserId.FieldName           := 'UserId';
                    fldUserId.Lookup              := False;
                    fldUserId.Name                := fdataset.name + 'UserId';
                    fldUserId.DataSet             := fDataset;
                end;
                if Dataset.findfield('ListName') = nil then begin
                    if fDataset.active then fDataset.close;
                    FldListName                     :=  TWideStringField.Create(fDataset.Owner);
                    FldListName.FieldKind           := fkData;
                    FldListName.FieldName           := 'ListName';
                    FldListName.Size                := 255;
                    FldListName.Lookup              := False;
                    FldListName.Name                := fdataset.name + 'ListName';
                    FldListName.DataSet             := fDataset;
                end;
                if Dataset.findfield('Active') = nil then begin
                    if fDataset.active then fDataset.close;
                    FldActive                     :=  TWideStringField.Create(fDataset.Owner);
                    FldActive.FieldKind           := fkData;
                    FldActive.FieldName           := 'Active';
                    FldActive.Size                := 1;
                    FldActive.Lookup              := False;
                    FldActive.Name                := fdataset.name + 'Active';
                    FldActive.DataSet             := fDataset;
                end;
                if Dataset.findfield('Showinthereport') = nil then begin
                    if fDataset.active then fDataset.close;
                    FldShowinthereport                     :=  TWideStringField.Create(fDataset.Owner);
                    FldShowinthereport.FieldKind           := fkData;
                    FldShowinthereport.FieldName           := 'Showinthereport';
                    FldShowinthereport.Size                := 1;
                    FldShowinthereport.Lookup              := False;
                    FldShowinthereport.Name                := fdataset.name + 'Showinthereport';
                    FldShowinthereport.DataSet             := fDataset;
                end;
                if Dataset.findfield('code') = nil then begin
                    if fDataset.active then fDataset.close;
                    Fldcode :=  TWideStringField.Create(fDataset.Owner);
                    Fldcode.FieldKind           := fkLookup;
                    Fldcode.FieldName           := 'code';
                    Fldcode.LookupDataSet       := lkTblCurrencyConversion;
                    Fldcode.LookupKeyFields     := 'CurrencyID';
                    Fldcode.LookupResultField   := 'Code';
                    Fldcode.KeyFields           := 'CurrencyID' ;
                    Fldcode.Size                := 10;
                    Fldcode.Lookup              := True;
                    Fldcode.Name                := 'Code';
                    Fldcode.DataSet             := fDataset;
                end;
                if Dataset.findfield('Symbol') = nil then begin
                    if fDataset.active then fDataset.close;
                    FldSymbol :=  TWideStringField.Create(fDataset.Owner);
                    FldSymbol.FieldKind           := fkLookup;
                    FldSymbol.FieldName           := 'Symbol';
                    FldSymbol.LookupDataSet       := lkTblCurrencyConversion;
                    FldSymbol.LookupKeyFields     := 'CurrencyID';
                    FldSymbol.LookupResultField   := 'CurrencySymbol';
                    FldSymbol.KeyFields           := 'CurrencyID' ;
                    FldSymbol.Size                := 10;
                    FldSymbol.Lookup              := True;
                    FldSymbol.Name                := 'Symbol';
                    FldSymbol.DataSet             := fDataset;
                end;
                if Dataset.findfield('Currency') = nil then begin
                    if fDataset.active then fDataset.close;
                    fldCurrency := TWideStringField.Create(fDataset.Owner);
                    fldCurrency.FieldKind           := fkLookup;
                    fldCurrency.FieldName           := 'Currency';
                    fldCurrency.LookupDataSet       := lkTblCurrencyConversion;
                    fldCurrency.LookupKeyFields     := 'CurrencyID';
                    fldCurrency.LookupResultField   := 'Currency';
                    fldCurrency.KeyFields           := 'CurrencyID';
                    fldCurrency.Size                := 100;
                    fldCurrency.Lookup              := True;
                    fldCurrency.Name                := 'Currency';
                    fldCurrency.DataSet             := fDataset;
                end;
                if Dataset.findfield('Country') = nil then begin
                    if fDataset.active then fDataset.close;
                    fldcountry:= TWideStringField.Create(fDataset.Owner);
                    fldcountry.FieldKind           := fkLookup;
                    fldcountry.FieldName           := 'Country';
                    fldcountry.LookupDataSet       := lkTblCurrencyConversion;
                    fldcountry.LookupKeyFields     := 'CurrencyID';
                    fldcountry.LookupResultField   := 'Country';
                    fldcountry.KeyFields           := 'CurrencyID';
                    fldcountry.Size                := 100;
                    fldcountry.Lookup              := True;
                    fldcountry.Name                := 'Country';
                    fldcountry.DataSet             := fDataset;
                end;
                if Dataset.findfield('BuyRate') = nil then begin
                    if fDataset.active then fDataset.close;
                    FldBuyRate := TFloatfield.Create(fDataset.Owner);
                    FldBuyRate.FieldKind           := fkLookup;
                    FldBuyRate.FieldName           := 'BuyRate';
                    FldBuyRate.LookupDataSet       := lkTblCurrencyConversion;
                    FldBuyRate.LookupKeyFields     := 'CurrencyID';
                    FldBuyRate.LookupResultField   := 'BuyRate';
                    FldBuyRate.KeyFields           := 'CurrencyID';
                    FldBuyRate.Lookup              := True;
                    FldBuyRate.Name                := 'BuyRate';
                    FldBuyRate.DataSet             := fDataset;
                end;
                if Dataset.findfield('SellRate') = nil then begin
                    if fDataset.active then fDataset.close;
                    fldSellRate:= TFloatfield.Create(fDataset.Owner);
                    fldSellRate.FieldKind           := fkLookup;
                    fldSellRate.FieldName           := 'SellRate';
                    fldSellRate.LookupDataSet       := lkTblCurrencyConversion;
                    fldSellRate.LookupKeyFields     := 'CurrencyID';
                    fldSellRate.LookupResultField   := 'SellRate';
                    fldSellRate.KeyFields           := 'CurrencyID';
                    fldSellRate.Lookup              := True;
                    fldSellRate.Name                := 'SellRate';
                    fldSellRate.DataSet             := fDataset;
                end;
            finally
                if not fDataset.active then fDataset.open;
            end;
          end;
    Finally
        fbCheckingForfields := False;
    end;
end;
Procedure    TForeignCurrencyonReport.LoadFCPref(const ListClassName:String);
var
  aDataset :TERPQuery;
begin
  if not datasetassigned then load(0);
  aDataset := TERPQuery(dataset);
  FCOnreportLib.LoadFCPref(aDataset, ListClassName, false);
(*var
    strSQL :String;
begin
    CloseDB;
    strSQL :=   'CC.Active = "T" and FCR.ListName = ' + quotedStr(ListClassName) +
                ' and FCR.Active = "T" and Showinthereport = "T" ' +
                ' and FCR.USerID = ' + IntToStr(Appenv.employee.employeeID) +
                ' and CC.code <> ' + quotedStr(appenv.RegionalOptions.ForeignExDefault);
    Loadselect(strSQL);
    if Dataset.Recordcount = 0 then begin
        strSQL :=   'FCR.ListName = ' + quotedStr(Listclassname) +
                ' and FCR.Active = "T" and Showinthereport = "T" ' +
                ' and FCR.USerID = 0' ;
        Loadselect(strSQL);
        if Dataset.recordcount > 0 then begin
            strSQL := ' insert into tblForeigncurrencyonReport ' +
                        ' (CurrencyID   , formID  , ListName   , Active  ,Showinthereport , userId)' +
                        ' select CurrencyID   , formID  , ListName   , Active  ,Showinthereport , ' + IntToStr(Appenv.employee.employeeID) +
                        ' from tblForeigncurrencyonReport FCR where ' + strSQL;
            getnewdataset(strSQL , False);
            strSQL :=   'CC.Active = "T" and FCR.ListName = ' + quotedStr(Listclassname) +
                ' and FCR.Active = "T" and FCR.Showinthereport = "T" ' +
                ' and FCR.USerID = ' + IntToStr(Appenv.employee.employeeID)+
                ' and CC.code <> ' + quotedStr(appenv.RegionalOptions.ForeignExDefault);
            Loadselect(strSQL);
        end;
    end;*)

end;
Procedure     TForeignCurrencyonReport.LoadFCPref;
begin
  LoadFCPref(self.owner.classname);
end;
function    TForeignCurrencyonReport.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TForeignCurrencyonReport.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TForeignCurrencyonReport.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TForeignCurrencyonReport.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function TForeignCurrencyonReport.GetBusObjectTablename: string;
begin
  Result := 'tblforeigncurrencyonreport';
end;

class function  TForeignCurrencyonReport.GetIDField : String;
begin
   Result := 'Foreigncurrencyonreportid'
end;

Function  TForeignCurrencyonReport.DoAfterOpen(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterPost(sender);
    if not result then Exit;
    CheckForfields;
    if Assigned(fLoadmemtable) then Loadmemtable; 
end;
Function  TForeignCurrencyonReport.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;
function TForeignCurrencyonReport.getlkTblCurrencyConversion        :TERPQuery;
begin
    if not assigned( flkTblCurrencyConversion) then begin
        flkTblCurrencyConversion := TERPQuery.Create(self);
        flkTblCurrencyConversion.connection := GetSharedMyDacConnection;
        flkTblCurrencyConversion.SQL.Add('Select * from tblCurrencyConversion');
        flkTblCurrencyConversion.Open;
    end;
    result := flkTblCurrencyConversion; 
end;

{Property functions}
Function  TForeignCurrencyonReport.GetCurrencyid     :Integer   ; begin Result := GetIntegerField('Currencyid');End;
Function  TForeignCurrencyonReport.GetFormid         :Integer   ; begin Result := GetIntegerField('Formid');End;
Function  TForeignCurrencyonReport.GetListname       :String    ; begin Result := GetStringField('Listname');End;
Function  TForeignCurrencyonReport.GetBuyRate        :Double    ; begin Result := getFloatField('BuyRate');end;
Function  TForeignCurrencyonReport.GetSellRate       :Double    ; begin result := Getfloatfield('SellRate');end;
Function  TForeignCurrencyonReport.GetCurrency       :String    ; begin Result := GetStringField('Currency');End;
Function  TForeignCurrencyonReport.GetCode           :String    ; begin Result := GetStringField('Code');End;
Function  TForeignCurrencyonReport.GetSymbol         :String    ; begin Result := GetStringField('Symbol');End;
Function  TForeignCurrencyonReport.GetCountry        :String    ; begin Result := GetStringField('Country');End;
Function  TForeignCurrencyonReport.GetActive         :Boolean   ; begin Result := GetBooleanField('Active');End;
Function  TForeignCurrencyonReport.GetShowinthereport:Boolean   ; begin Result := GetBooleanField('Showinthereport');End;
Function  TForeignCurrencyonReport.GetUserid         :Integer   ; begin Result := GetIntegerField('Userid');End;
//function  TForeignCurrencyonReport.GetRecno          :String    ; begin Result := IntToStr(Dataset.Recno);End;
Procedure TForeignCurrencyonReport.SetCurrencyid     (Const Value :Integer   ); begin SetIntegerField('Currencyid',Value);End;
Procedure TForeignCurrencyonReport.SetFormid         (Const Value :Integer   ); begin SetIntegerField('Formid',Value);End;
Procedure TForeignCurrencyonReport.SetListname       (Const Value :String    ); begin SetStringField('Listname',Value);End;
Procedure TForeignCurrencyonReport.SetActive         (Const Value :Boolean   ); begin SetBooleanField('Active',Value);End;
Procedure TForeignCurrencyonReport.SetShowinthereport(Const Value :Boolean   ); begin SetBooleanField('Showinthereport',Value);End;
Procedure TForeignCurrencyonReport.SetUserid         (Const Value :Integer   ); begin SetIntegerField('Userid',Value);End;


      {TForeignCurrencyFieldsonReport}

Constructor TForeignCurrencyFieldsonReport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'FCFieldsonReport';
  fSQL := 'SELECT * FROM tblforeigncurrencyfieldsonreport';
end;


Destructor TForeignCurrencyFieldsonReport.Destroy;
begin
    FreeandNil(fCurrency);
    inherited;
end;


Procedure TForeignCurrencyFieldsonReport.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FormId');
  SetPropertyFromNode(node,'TempTypeID');
  SetPropertyFromNode(node,'QuerySeqNo');
  SetPropertyFromNode(node,'AmountfieldName');
  SetPropertyFromNode(node,'AmountCaption');
  SetPropertyFromNode(node,'IsDeptRelated');
end;


Procedure TForeignCurrencyFieldsonReport.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormId' ,FormId);
  AddXMLNode(node,'TempTypeID' ,TempTypeID);
  AddXMLNode(node,'QuerySeqNo' ,QuerySeqNo);
  AddXMLNode(node,'AmountfieldName' ,AmountfieldName);
  AddXMLNode(node,'AmountCaption' ,AmountCaption);
  AddXMLNode(node,'IsDeptRelated' ,IsDeptRelated);
end;


Function TForeignCurrencyFieldsonReport.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


Function TForeignCurrencyFieldsonReport.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


Procedure TForeignCurrencyFieldsonReport.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TForeignCurrencyFieldsonReport.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


Function TForeignCurrencyFieldsonReport.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TForeignCurrencyFieldsonReport.GetBusObjectTablename: string;
begin
  Result := 'tblforeigncurrencyfieldsonreport';
end;

class Function TForeignCurrencyFieldsonReport.GetIDField: string;
begin
  Result := 'ID'
end;


Function TForeignCurrencyFieldsonReport.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TForeignCurrencyFieldsonReport.getCurrency :TCurrency;
begin
    if not Assigned(fCurrency) then begin
        fCurrency :=  TCurrency.Create(Self);
        if Assigned(Self.connection) then fCurrency.connection := Self.connection;
        fCurrency.Load;
    end;
    result :=  fCurrency;
end;
{Property Functions}
Function  TForeignCurrencyFieldsonReport.GetFormId         : Integer   ; begin Result := GetIntegerField('FormId');end;
Function  TForeignCurrencyFieldsonReport.GetTempTypeID     : Integer   ; begin Result := GetIntegerField('TempTypeID');end;
Function  TForeignCurrencyFieldsonReport.GetQuerySeqNo     : Integer   ; begin Result := GetIntegerField('QuerySeqNo');end;
Function  TForeignCurrencyFieldsonReport.GetAmountfieldName: string    ; begin Result := GetStringField('AmountfieldName');end;
Function  TForeignCurrencyFieldsonReport.GetAmountCaption  : string    ; begin Result := GetStringField('AmountCaption');end;
Function  TForeignCurrencyFieldsonReport.GetIsDeptRelated  : Boolean   ; begin Result := GetBooleanField('IsDeptRelated');end;
Procedure TForeignCurrencyFieldsonReport.SetFormId         (const Value: Integer   ); begin SetIntegerField('FormId'          , Value);end;
Procedure TForeignCurrencyFieldsonReport.SetTempTypeID     (const Value: Integer   ); begin SetIntegerField('TempTypeID'      , Value);end;
Procedure TForeignCurrencyFieldsonReport.SetQuerySeqNo     (const Value: Integer   ); begin SetIntegerField('QuerySeqNo'      , Value);end;
Procedure TForeignCurrencyFieldsonReport.SetAmountfieldName(const Value: string    ); begin SetStringField('AmountfieldName'  , Value);end;
Procedure TForeignCurrencyFieldsonReport.SetAmountCaption  (const Value: string    ); begin SetStringField('AmountCaption'   , Value);end;
Procedure TForeignCurrencyFieldsonReport.SetIsDeptRelated  (const Value: boolean   ); begin SetBooleanField('IsDeptRelated'   , Value);end;


initialization
    RegisterClassOnce(TForeignCurrencyFieldsonReport);
    RegisterClassOnce(TForeignCurrencyonReport);
end.
