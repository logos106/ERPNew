unit LookupcomboLib;

interface

uses ERPdbComponents, wwDBGrid, UserCustomisedNames, classes, ERPDbLookupCombo, WwDbiGrd, Graphics,
  db, GuiPrefsObj, Dialogs , wwdblook;

Type
  TNamenPrintNameinGrid = record
    Grid: TwwDBGrid;
    Fieldname: String;
    PrintFieldName: String;
    GridCalcTitleAttributesEvent: TCalcTitleAttributesEvent;
    GridTitleButtonClickEvent: TTitleButtonClickEvent;
    Titlecolor: Tcolor;
    TitleFontcolor: Tcolor;
  end;

  TNamenPrintNameGridObj = Class(TComponent)
  Private
    NamenPrintNameinGrid: Array of TNamenPrintNameinGrid;
    fGuiPrefs: TFormGuiPrefs;
    procedure AddNamenPrintNameinGrid(Grid: TwwDBGrid; Fieldname, PrintFieldName: String);
    Procedure NamenPrintNameGridObjOnCalcTitleAttributes(Sender: TObject; AFieldName: string;AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure NamenPrintNameGridObjOnTitleButtonClick(Sender: TObject; AFieldName: string);
    function F6Search: String;
    function F7Search: String;
    function F6nF7SearchSQL(fieldNames: Array Of String): String;
    procedure SetDisplayLabel(ds: TERPQuery; Fieldname: String; Grid: TwwDBGrid;Captiontype: TCaptiontype; Displaylabel: String = '');
    function IsfieldInSelected(Grid: TwwDBGrid; const Fieldname: String): Boolean;
    Function SelectedItem(Grid: TwwDBGrid; Const Fieldname: String): String;
    Function ClientLookupSQL(supplierList, CustomerList, ProspectList, JobList: Boolean;SelectedcleintID: Integer): String;
    Function ProductLookupSQL(DescField: String; SearchonPreferredSupplier, SearchOnGroupfields: Boolean): String;
    Procedure UserMessage(const msg: String; Buttons: TMsgDlgButtons;DlgType: TMsgDlgType = mtConfirmation);
    Procedure CheckforField(ds:TERPQuery ; aFieldname:String);

  Protected

  Public
    Constructor Create(Aowner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure SetupProductNamenPrintNameinGrid(combo, Printcombo: TERPDbLookupcombo;
      Fieldname, PrintFieldName, DescField: String; Grid: TwwDBGrid;
      SearchonPreferredSupplier: Boolean = true; SearchOnPrintName: Boolean = true;
      SearchOnGroupfields: Boolean = true);
    procedure SetupClientNamenPrintNameinGrid(SelectedcleintID: Integer;
      combo, Printcombo: TERPDbLookupcombo; Fieldname, PrintFieldName: String; Grid: TwwDBGrid;
      supplierList, CustomerList, ProspectList, JobList: Boolean; SearchOnPrintName: Boolean);
    procedure SwapPairdField(ds: TDataset; grd: TwwDBGrid; fieldshown, fieldtobeshown: String);
    Property GuiPrefs: TFormGuiPrefs read fGuiPrefs write fGuiPrefs;
    { Client Combo Related }
    function Makecompany(var fbUpdatingcompanyonName: Boolean; QryClient: TERPQuery;PrintnameFieldname: String = 'Printname'): Boolean;
    function UpdatecompanyonNamechange(var fbUpdatingcompanyonName: Boolean;QryClient: TERPQuery): Boolean;
    procedure ClientLookupQueryWithSearchengine(SelectedcleintID: Integer;
      var combo: TERPDbLookupcombo; supplierList, CustomerList, ProspectList, JobList,
      SearchOnPrintName: Boolean; PrintNameDatafield: String; Grid: TwwDBGrid;
      IsPrintNameCombo: Boolean);
    { Product combo Related }
    Procedure ProductLookupQueryWithSearchengine(var combo: TERPDbLookupcombo; DescField: String;
      SearchonPreferredSupplier: Boolean; SearchOnPrintName: Boolean; PrintNameDatafield: String;
      SearchOnGroupfields: Boolean; Grid: TwwDBGrid; IsPrintNameCombo: Boolean);
    function MakePartname(var fbUpdatingcompanyonName: Boolean; Qryproduct: TERPQuery): Boolean;

    { Account combo Related }
    Function AccountLookupSQL(const SelectedcleintID: Integer): String;
    Procedure AccountLookupQueryWithSearchengine(SelectedcleintID: Integer;
      combo: TERPDbLookupcombo);
    { Taxcode Combo Related }
    Function TaxcodeLookupSQL(const SelectedTaxCodeID: Integer; FilterforLocation:Boolean=False): String;
    Procedure TaxcodeLookupQueryWithSearchengine(SelectedTaxCodeID: Integer;combo: TERPDbLookupcombo; FilterforLocation:Boolean= False);
  End;
TApproverCombo = Class(TComponent)
  Private
    fsApprovaltype :String;
    Procedure onApprovercomboDblclick(Sender:TObject);
    procedure initApprovalLevelList(Sender: TObject);
  public
    Procedure ApproverLookupQrySQL(Combo :TwwDBLookupcombo; aApprovaltype:String);
End;

function ApproverCombo : TApproverCombo;

var
  fApproverCombo : TApproverCombo;

implementation

uses Sysutils, CommonLib, tcConst,
  CommonDbLib, BaseInputForm, LogLib, AppEnvironment,
  DbSharedObjectsObj, BusObjClient, BusobjProduct, ProductQtyLib,
  Variants, frmBase, CommonFormLib, ApprovalLevelList;
function ApproverCombo : TApproverCombo;
begin
   if fApproverCombo = nil then
    fApproverCombo:=TApproverCombo.create(nil);
   result :=fApproverCombo;
end;

function VariantToStr(const val: Variant): string;
begin
  result := '';
  if VarIsNull(val) then
    exit
  else
    result := val;
end;

function TNamenPrintNameGridObj.F6Search: String;
begin
  result := ' LIKE Concat(:SearchValue,"%")';
end;

function TNamenPrintNameGridObj.F7Search: String;
begin
  result := ' LIKE Concat("%",:SearchValue,"%")';
end;

function TNamenPrintNameGridObj.F6nF7SearchSQL(fieldNames: Array Of String): String;
  function SearchSQL(IsF6Search: Boolean): String;
  var
    ctr: Integer;
  begin
    result := '';
    for ctr := low(fieldNames) to high(fieldNames) do
      if trim(fieldNames[ctr]) <> '' then begin
        if result <> '' then
          result := result + ' OR ';
        if IsF6Search then
          result := result + ' ( ' + fieldNames[ctr] + ' ' + F6Search + ') '
        else
          result := result + ' ( ' + fieldNames[ctr] + ' ' + F7Search + ') ';
      end;
  end;

begin
  result := '';
  if length(fieldNames) = 0 then
    exit;
  result := result + NL + '(';
  result := result + '    ((:SearchMode = 0) or (IsNull(:SearchMode))) ' + NL;
  result := result + ' or ((:SearchMode = 1) and (' + SearchSQL(true) + '  )) ' + NL;
  result := result + ' or ((:SearchMode = 2) and (' + SearchSQL(False) + '  )) ' + NL;
  result := result + ') AND ifnull(:SearchValue , "") <> ""';
end;

procedure TNamenPrintNameGridObj.SetDisplayLabel(ds: TERPQuery; Fieldname: String; Grid: TwwDBGrid;
  Captiontype: TCaptiontype; Displaylabel: String = '');
begin
  try
    if Captiontype <> cptNone then
      ds.FieldByName(Fieldname).Displaylabel := UserCustomisedName(Captiontype)
    else if Displaylabel <> '' then
      ds.FieldByName(Fieldname).Displaylabel := Displaylabel;
  Except
  end;
  try
    WwDbiGrd.UpdateSelectedProp(Grid.Selected, Fieldname, ds.FieldByName(Fieldname).Displaylabel,
      sptUpdateLabel);
  Except
  end;
end;

Function TNamenPrintNameGridObj.SelectedItem(Grid: TwwDBGrid; Const Fieldname: String): String;
var
  ctr: Integer;
begin
  result := '';
  if Grid.Selected.count = 0 then
    exit;
  for ctr := 0 to Grid.Selected.count - 1 do begin
    if pos(uppercase(trim(Fieldname) + #9), uppercase(trim(Grid.Selected[ctr]))) = 1 then begin
      result := Grid.Selected[ctr];
      exit;
    end;
  end;
end;

function TNamenPrintNameGridObj.IsfieldInSelected(Grid: TwwDBGrid; const Fieldname: String)
  : Boolean;
begin
  result := SelectedItem(Grid, Fieldname) <> '';
end;

{ TNamenPrintNameGridObj }

procedure TNamenPrintNameGridObj.AddNamenPrintNameinGrid(Grid: TwwDBGrid;
  Fieldname, PrintFieldName: String);
var
  ctr: Integer;
  fbAssignedGridEvent: Boolean;

  Procedure AssignGridEvent;
  var
    i: Integer;
  begin
    fbAssignedGridEvent := true;
    for i := low(NamenPrintNameinGrid) to high(NamenPrintNameinGrid) do
      if (NamenPrintNameinGrid[i].Grid = Grid) then
        exit;
    fbAssignedGridEvent := False;
  end;

begin
  for ctr := low(NamenPrintNameinGrid) to high(NamenPrintNameinGrid) do
    if (NamenPrintNameinGrid[ctr].Grid = Grid) and (NamenPrintNameinGrid[ctr].Fieldname = Fieldname)
      and (NamenPrintNameinGrid[ctr].PrintFieldName = PrintFieldName) then
      exit;
  AssignGridEvent;

  SetLength(NamenPrintNameinGrid, length(NamenPrintNameinGrid) + 1);
  NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].Fieldname := Fieldname;
  NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].PrintFieldName := PrintFieldName;
  NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].Grid := Grid;
  if Appenv.IsDBConnected and  Appenv.Employee.UseERPButtonColor then begin
    NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].Titlecolor := Appenv.Employee.ERPButtonColor;
    NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].TitleFontcolor := Appenv.Employee.ERPButtonFontColor;
  end else begin
    NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].Titlecolor := Inactivefontcolor;
    NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].TitleFontcolor := clBlack;
  end;
  NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].GridCalcTitleAttributesEvent := nil;
  NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].GridTitleButtonClickEvent := nil;
  if not fbAssignedGridEvent then begin
    NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].GridCalcTitleAttributesEvent :=
      Grid.OnCalcTitleAttributes;
    Grid.OnCalcTitleAttributes := NamenPrintNameGridObjOnCalcTitleAttributes;
    NamenPrintNameinGrid[ high(NamenPrintNameinGrid)].GridTitleButtonClickEvent :=
      Grid.OnTitleButtonClick;
    Grid.OnTitleButtonClick := NamenPrintNameGridObjOnTitleButtonClick;
  end;
end;

constructor TNamenPrintNameGridObj.Create(Aowner: TComponent);
begin
  inherited;
  SetLength(NamenPrintNameinGrid, 0);
  fGuiPrefs := nil;
end;

destructor TNamenPrintNameGridObj.Destroy;
var
  ctr: Integer;
begin
  for ctr := low(NamenPrintNameinGrid) to high(NamenPrintNameinGrid) do begin
    if NamenPrintNameinGrid[ctr].Grid <> nil then begin
      if Assigned(NamenPrintNameinGrid[ctr].GridTitleButtonClickEvent) then
        NamenPrintNameinGrid[ctr].Grid.OnTitleButtonClick := NamenPrintNameinGrid[ctr]
          .GridTitleButtonClickEvent;
      if Assigned(NamenPrintNameinGrid[ctr].GridCalcTitleAttributesEvent) then
        NamenPrintNameinGrid[ctr].Grid.OnCalcTitleAttributes := NamenPrintNameinGrid[ctr]
          .GridCalcTitleAttributesEvent;
    end;
  end;
  inherited;
end;

procedure TNamenPrintNameGridObj.SetupClientNamenPrintNameinGrid(SelectedcleintID: Integer;
  combo, Printcombo: TERPDbLookupcombo; Fieldname, PrintFieldName: String; Grid: TwwDBGrid;
  supplierList, CustomerList, ProspectList, JobList, SearchOnPrintName: Boolean);
begin
  combo.options := combo.options + [loTitles];
  ClientLookupQueryWithSearchengine(SelectedcleintID, combo, supplierList, CustomerList,
    ProspectList, JobList, SearchOnPrintName, Fieldname, Grid, False);
  ClientLookupQueryWithSearchengine(SelectedcleintID, Printcombo, supplierList, CustomerList,
    ProspectList, JobList, SearchOnPrintName, PrintFieldName, Grid, true);
  AddNamenPrintNameinGrid(Grid, Fieldname, PrintFieldName);
  Try
    if Grid.datasource.dataset.FieldByName(Fieldname).Index < Grid.Selected.Count then
      WwDbiGrd.UpdateSelectedProp(Grid.Selected, PrintFieldName,
        inttostr(Grid.datasource.dataset.FieldByName(Fieldname).index), sptUpdateIndex);
  Except
  end;
  Try
    WwDbiGrd.UpdateSelectedProp(Grid.Selected, PrintFieldName,
      inttostr(Grid.datasource.dataset.FieldByName(Fieldname).displayWidth), sptUpdateWidth);
  Except
  end;
end;

procedure TNamenPrintNameGridObj.SetupProductNamenPrintNameinGrid(combo,
  Printcombo: TERPDbLookupcombo; Fieldname, PrintFieldName, DescField: String; Grid: TwwDBGrid;
  SearchonPreferredSupplier, SearchOnPrintName, SearchOnGroupfields: Boolean);
begin
  combo.options := combo.options + [loTitles];
  if Printcombo <> nil then
    Printcombo.options := Printcombo.options + [loTitles];
  try
    ProductLookupQueryWithSearchengine(combo, DescField, SearchonPreferredSupplier,
      SearchOnPrintName, Fieldname, SearchOnGroupfields, Grid, False);
  Except
  end;
  try
    if Printcombo <> nil then
      ProductLookupQueryWithSearchengine(Printcombo, DescField, SearchonPreferredSupplier,
        SearchOnPrintName, PrintFieldName, SearchOnGroupfields, Grid, true);
  Except
  end;
  if Grid <> nil then begin
    AddNamenPrintNameinGrid(Grid, Fieldname, PrintFieldName);
    Try
      if Grid.datasource.dataset.FieldByName(Fieldname).Index < Grid.Selected.Count then
        WwDbiGrd.UpdateSelectedProp(Grid.Selected, PrintFieldName,
          inttostr(Grid.datasource.dataset.FieldByName(Fieldname).index), sptUpdateIndex);
    Except
    end;
    Try
      WwDbiGrd.UpdateSelectedProp(Grid.Selected, PrintFieldName,
        inttostr(Grid.datasource.dataset.FieldByName(Fieldname).displayWidth), sptUpdateWidth);
    Except
    end;
  end;
end;

procedure TNamenPrintNameGridObj.NamenPrintNameGridObjOnTitleButtonClick(Sender: TObject;
  AFieldName: string);
var
  ctr: Integer;
begin
  if length(NamenPrintNameinGrid) = 0 then
    exit;
  for ctr := low(NamenPrintNameinGrid) to high(NamenPrintNameinGrid) do begin
    if NamenPrintNameinGrid[ctr].Grid = TwwDBGrid(Sender) then
      if sametext(NamenPrintNameinGrid[ctr].Fieldname, AFieldName) then begin
        SwapPairdField(TwwDBGrid(Sender).datasource.dataset, TwwDBGrid(Sender),
          NamenPrintNameinGrid[ctr].Fieldname, NamenPrintNameinGrid[ctr].PrintFieldName);
        break;
      end
      else if sametext(NamenPrintNameinGrid[ctr].PrintFieldName, AFieldName) then begin
        SwapPairdField(TwwDBGrid(Sender).datasource.dataset, TwwDBGrid(Sender),
          NamenPrintNameinGrid[ctr].PrintFieldName, NamenPrintNameinGrid[ctr].Fieldname);
        break;
      end;
  end;
  for ctr := low(NamenPrintNameinGrid) to high(NamenPrintNameinGrid) do
    if NamenPrintNameinGrid[ctr].Grid = TwwDBGrid(Sender) then
      if Assigned(NamenPrintNameinGrid[ctr].GridTitleButtonClickEvent) then begin
        NamenPrintNameinGrid[ctr].GridTitleButtonClickEvent(Sender, AFieldName);
        break;
      end;

end;

procedure TNamenPrintNameGridObj.NamenPrintNameGridObjOnCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
var
  ctr: Integer;
begin
  if length(NamenPrintNameinGrid) = 0 then
    exit;
  for ctr := low(NamenPrintNameinGrid) to high(NamenPrintNameinGrid) do begin
    if NamenPrintNameinGrid[ctr].Grid = TwwDBGrid(Sender) then
      if sametext(NamenPrintNameinGrid[ctr].Fieldname, AFieldName) or
        sametext(NamenPrintNameinGrid[ctr].PrintFieldName, AFieldName) then begin
        ABrush.Color := NamenPrintNameinGrid[ctr].Titlecolor;
        AFont.Color := NamenPrintNameinGrid[ctr].TitleFontcolor;
        break;
      end;
  end;
  for ctr := low(NamenPrintNameinGrid) to high(NamenPrintNameinGrid) do
    if NamenPrintNameinGrid[ctr].Grid = TwwDBGrid(Sender) then
      if Assigned(NamenPrintNameinGrid[ctr].GridCalcTitleAttributesEvent) then begin
        NamenPrintNameinGrid[ctr].GridCalcTitleAttributesEvent(Sender, AFieldName, AFont, ABrush,
          ATitleAlignment);
        break;
      end;
end;

procedure TNamenPrintNameGridObj.UserMessage(const msg: String; Buttons: TMsgDlgButtons;
  DlgType: TMsgDlgType = mtConfirmation);
begin
  if (trim(msg) <> '') and Assigned(Owner) and (Owner is TBaseInputGUI) then
    TBaseInputGUI(Owner).ConfirmFromGUI(msg, Buttons, DlgType);
end;

procedure TNamenPrintNameGridObj.SwapPairdField(ds: TDataset; grd: TwwDBGrid;
  fieldshown, fieldtobeshown: String);
begin
  grd.RemoveField(fieldshown);
  grd.AddField(fieldtobeshown);
  if (fGuiPrefs <> nil) and (fGuiPrefs.active) then
    fGuiPrefs.DbGridElement[grd].UnHideField(fieldtobeshown);
  ds.FieldByName(fieldtobeshown).index := ds.FieldByName(fieldshown).index;
  grd.SetActiveField(fieldtobeshown);
end;

{ Client Combo related }
{ ----- }


function TNamenPrintNameGridObj.Makecompany(var fbUpdatingcompanyonName: Boolean;QryClient: TERPQuery; PrintnameFieldname: String = 'Printname'): Boolean;
var
  fsCompanyfieldname: String;
  qryC: TERPQuery;
  function Cleanclient :TERPQuery;
  begin
      if qryC = nil then begin
          qryc := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
          qryC.sql.text := 'Select clientId as clientId, ' +
                            fsCompanyfieldname + ' as clientname , ' +
                            PrintnameFieldname + ' as Printname '+
                            ' from tblclients '+
                            ' where ClientId= ' + inttostr(QryClient.FieldByName('ClientId').AsInteger);
          qryC.open;
      end;
      Result := QryC;
  end;
  function IsNewClient     : Boolean; begin result := Cleanclient.fieldbyname('ClientID').asInteger =0;  end;
  function IsCleanNamesSame: Boolean; begin result := sametext(Cleanclient.FieldByName('clientname').asString, Cleanclient.FieldByName('Printname').asString);  end;
begin
  qryC := nil;
  try
      result := true;
      if fbUpdatingcompanyonName then  exit;

      fbUpdatingcompanyonName := true;
      try
        if (QryClient.FieldByName('ClientId').AsInteger <> 0) then begin
          EditDB(QryClient);
          { 1: Setglobalref }
          if QryClient.findField('Globalref') <> nil then
            if (QryClient.FieldByName('Globalref').asString = '') then
              QryClient.FieldByName('Globalref').asString := AppEnv.Branch.SiteCode +
                inttostr(QryClient.FieldByName('ClientId').AsInteger);

          { 2: Set jobname }

          if (QryClient.findField('isjob') <> nil) and (QryClient.FieldByName('isjob').asBoolean) then
            fsCompanyfieldname := 'jobname'
          else
            fsCompanyfieldname := 'Company';

          if AppEnv.companyprefs.CopyClientPrintNameToName then
            if QryClient.FieldByName(PrintnameFieldname).asString <> '' then
              if TClient.IsUnique(QryClient.FieldByName('ClientId').AsInteger,
                fsCompanyfieldname + ' = ' + QuotedStr(StringDataForSQL(QryClient.FieldByName(PrintnameFieldname).asString))) then begin
                if sametext(VariantToStr(QryClient.FieldByName(PrintnameFieldname).oldValue),
                  QryClient.FieldByName(fsCompanyfieldname).asString) or
                  (QryClient.FieldByName(fsCompanyfieldname).asString = '') or
                  sametext(QryClient.FieldByName('Globalref').asString,
                  QryClient.FieldByName(fsCompanyfieldname).asString) or IsCleanNamesSame then
                  if IsNewClient then QryClient.FieldByName(fsCompanyfieldname).asString := QryClient.FieldByName(PrintnameFieldname).asString;
              end else begin
                UserMessage('Preference to Copy ''Description'' To ''Client Name'' is Turned on.  ' +
                  'But there is already Another Client Record with the name ' +
                  QuotedStr(QryClient.FieldByName(PrintnameFieldname).asString) + '.' + NL + NL +
                  'It is not Possible to Copy Description to Name.' + NL +
                  'Please Change the Name if Needed.', [mbok], mtinformation);
              end;

          if (trim(QryClient.FieldByName(fsCompanyfieldname).asString) = '') then begin
            QryClient.FieldByName(fsCompanyfieldname).asString :=
              trim(QryClient.FieldByName('Globalref').asString);
          end;
          PostDB(QryClient);
        end;
      finally
        fbUpdatingcompanyonName := False;
      end;
  finally
    if qryC <> nil then
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryC);
  end;
end;

{ ----- } function TNamenPrintNameGridObj.UpdatecompanyonNamechange(var fbUpdatingcompanyonName  : Boolean; QryClient: TERPQuery): Boolean;
var
  s: String;
  function IsNewClient :Boolean;
  var
    qryC: TERPQuery;
  begin
          qryc := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
          try
            if qryC.active then qryC.close;
            qryC.sql.text := 'Select clientId as clientId ' +
                              ' from tblclients '+
                              ' where ClientId= ' + inttostr(QryClient.FieldByName('ClientId').AsInteger);
            qryC.open;
            Result := QryC.FieldByName('clientID').AsInteger=0;
          finally
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryc);
          end;
  end;
  Function istoUpdatePrintname:Boolean;
  var
    s, fs, ls:String;
  begin
    Result := False;
    if Empty(QryClient.FieldByName('printname').asString) then begin
      REsult := True;
      Exit;
    end;
    if  (QryClient.FieldByName('printname').asString = QryClient.FieldByName('FirstName').asString)  then begin
      REsult := True;
      Exit;
    end;
    if (QryClient.FieldByName('printname').asString = QryClient.FieldByName('LastName').asString)  then begin
      REsult := True;
      Exit;
    end;
    try s:=StringDataForSQL(QryClient.FieldByName('printname').oldValue);Except on E:Exception do begin S:=''; end; end;

    if  (s = QryClient.FieldByName('Globalref').asString)  then begin
      REsult := True;
      Exit;
    end;
    if  ((QryClient.FieldByName('printname').asString = QryClient.FieldByName('Globalref').asString) and  (trim(s)=''))  then begin
      REsult := True;
      Exit;
    end;
    try fs:=QryClient.FieldByName('FirstName').OldValue; Except on E:Exception do begin fS:=''; end; end;
    try ls:=QryClient.FieldByName('LastName').OldValue; Except on E:Exception do begin lS:=''; end; end;
    if  (QryClient.FieldByName('printname').asString = trim(fs+' ' + ls)) then begin
      REsult := True;
      Exit;
    end;


  end;
begin
  result := true;
  if fbUpdatingcompanyonName then
    exit;
  fbUpdatingcompanyonName := true;
  try
    (*if Empty(QryClient.FieldByName('printname').asString) or
      (QryClient.FieldByName('printname').asString = QryClient.FieldByName('FirstName').asString) or
      (QryClient.FieldByName('printname').asString = QryClient.FieldByName('LastName').asString) or
      (VariantToStr(StringDataForSQL(QryClient.FieldByName('printname').oldValue)) = QryClient.FieldByName('Globalref').asString) or
      ((QryClient.FieldByName('printname').asString = QryClient.FieldByName('Globalref').asString) and (trim(VariantToStr(StringDataForSQL(QryClient.FieldByName('printname').oldValue)))='')) OR
      (QryClient.FieldByName('printname').asString = trim(QryClient.FieldByName('FirstName').OldValue +' ' + QryClient.FieldByName('LastName').OldValue))      then begin*)
    if istoUpdatePrintname then begin
      s := '';
      if QryClient.FieldByName('FirstName').asString <> '' then s := QryClient.FieldByName('FirstName').asString;
      if QryClient.FieldByName('LastName').asString <> '' then s := trim(s + ' ' + QryClient.FieldByName('LastName').asString);

      EditDB(QryClient);
      QryClient.FieldByName('printname').asString := s;
      PostDB(QryClient);
    end;
    fbUpdatingcompanyonName := False;
    try
      Makecompany(fbUpdatingcompanyonName, QryClient);
    finally
      EditDB(QryClient);
      fbUpdatingcompanyonName := true;
    end;

    if IsNewClient then
    if (QryClient.FieldByName('Company').asString = VariantToStr(StringDataForSQL(QryClient.FieldByName('printname').oldValue))) then
      if IsClientNameUnique(QryClient.FieldByName('printname').asString,
        QryClient.FieldByName('clientID').AsInteger) then begin
        QryClient.FieldByName('Company').asString := QryClient.FieldByName('printname').asString;
        PostDB(QryClient);
      end;
  finally
    fbUpdatingcompanyonName := False;
  end;

end;

procedure TNamenPrintNameGridObj.CheckforField(ds: TERPQuery; aFieldname: String);
begin
    try
      if ds.fields.count >0 then // if the dataset doesn't have any fields selected, all fields form the SQL is dynamically assigned
        if ds.findfield(aFieldname) = nil then begin
            with TWideStringField.Create(ds) do begin
              fieldKind := fkData;
              fieldname := aFieldname;
              size := 255;
              name := MakeName(ds.owner,ds.name + Fieldname);
              DataSet := ds;
            end;
        end;
    Except
      on E:Exception do begin
        Raise Exception.Create(E.Message + Chr(13) + 'Errors occured in CheckforField, adding '+ afieldname +' in  '+ds.Owner.name +':' + ds.name);
      end;
    end;

end;

procedure TNamenPrintNameGridObj.ClientLookupQueryWithSearchengine
  (SelectedcleintID: Integer; var combo: TERPDbLookupcombo;
  supplierList, CustomerList, ProspectList, JobList, SearchOnPrintName: Boolean;
  PrintNameDatafield: String; Grid: TwwDBGrid; IsPrintNameCombo: Boolean);
var
  s: String;
begin
  combo.options := combo.options + [loTitles];
  { This is to email to erp if there is any with the id initialisation }
  if not(Assigned(combo.OnCloseUpIdUpdateError)) then
    if Assigned(combo.Owner) and (combo.Owner is TBaseInputGUI) then
      combo.OnCloseUpIdUpdateError := TBaseInputGUI(combo.Owner).CloseUpIdUpdateError;

  try
    With TERPQuery(combo.Lookuptable).sql do begin
      s := ClientLookupSQL(supplierList, CustomerList, ProspectList, JobList, SelectedcleintID);
      if not(sametext(s, text)) then begin
        Closedb(combo.Lookuptable);
        Clear;
        Add(s);
        TERPQuery(combo.Lookuptable).parambyname('searchmode').AsInteger := 1;
      end;
    end;
    if IsPrintNameCombo then begin
      if TERPQuery(combo.Lookuptable).FieldCount > 0 then
        if TERPQuery(combo.Lookuptable).findField('PrintName') = nil then begin
          if TERPQuery(combo.Lookuptable).active then
            TERPQuery(combo.Lookuptable).close;
          With TWideStringField.Create(TERPQuery(combo.Lookuptable).Owner) do begin
            FieldKind := fkData;
            Fieldname := 'Printname';
            Size := 100;
            Displaylabel := 'Print Name';
            Name := TERPQuery(combo.Lookuptable).name + 'Printname';
            dataset := TERPQuery(combo.Lookuptable);
          end;
        end;

      if (combo.Lookupfield <> 'PrintName') and
        (TERPQuery(combo.Lookuptable).findField('Printname') <> nil) then begin
        TERPQuery(combo.Lookuptable).findField('Printname').displayWidth :=
          FieldDisplayWidth(combo.Lookuptable, combo.Lookupfield);
        if (TERPQuery(combo.Lookuptable).findField('Printname').displayWidth = 0) or
          (TERPQuery(combo.Lookuptable).findField('Printname').displayWidth = 255) or
          ((TERPQuery(combo.Lookuptable).findField('Printname').Size = TERPQuery(combo.Lookuptable)
          .findField('Printname').displayWidth) and
          (TERPQuery(combo.Lookuptable).findField('Printname').displayWidth >= 60)) then
          TERPQuery(combo.Lookuptable).findField('Printname').displayWidth := 20;
      end;

      if Grid <> nil then
        if not(sametext(combo.Datafield, PrintNameDatafield)) then
          Grid.SetControlType(PrintNameDatafield, fctLookupCombo, combo.name);

      if SearchOnPrintName and (PrintNameDatafield <> '') then begin
        if TERPQuery(combo.datasource.dataset).FieldCount > 0 then
          if TERPQuery(combo.datasource.dataset).findField(PrintNameDatafield) = nil then begin
            With TWideStringField.Create(TERPQuery(combo.datasource.dataset).Owner) do begin
              FieldKind := fkData;
              Fieldname := PrintNameDatafield;
              Size := 255;
              Displaylabel := UserCustomisedName(cpClientPrintName);
              Name := TERPQuery(combo.datasource.dataset).name + PrintNameDatafield;
              dataset := TERPQuery(combo.datasource.dataset);
              if combo.Lookupfield <> PrintNameDatafield then
                displayWidth := combo.displayWidth(combo.Lookupfield);
              if (displayWidth = 0) or (displayWidth = 255) then
                displayWidth := 10;
            end;
          end;
        combo.Datafield := PrintNameDatafield;
        combo.Lookupfield := 'PrintName';
      end;
      try
        (*if combo.IsfieldInSelected('Printname') = False then
          combo.Selected.Insert(0, SelectedText('Printname', UserCustomisedName(cpClientPrintName),
            FieldDisplayWidth(combo.Lookuptable, 'Printname'), ''));*)
            combo.MoveField('Printname', 0, true, SelectedText('Printname', UserCustomisedName(cpClientPrintName),
            FieldDisplayWidth(combo.Lookuptable, 'Printname'), ''));
      Except
      end;
      if Grid <> nil then begin
        CheckforField(TERPQuery(Grid.datasource.dataset), PrintNameDatafield);
        Grid.Selected.Insert(0, SelectedText(PrintNameDatafield,
          UserCustomisedName(cpClientPrintName), FieldDisplayWidth(Grid.datasource.dataset,
          PrintNameDatafield), ''));
      end;
    end
    else begin
      CheckforField(TERPQuery(combo.Lookuptable), 'Printname');
      if combo.IsfieldInSelected('Printname') = False then
        combo.Selected.Insert(1, SelectedText('Printname', UserCustomisedName(cpClientPrintName),
          FieldDisplayWidth(combo.Lookuptable, 'Printname'), ''));
    end;

  Finally
    if TERPQuery(combo.Lookuptable).connection = nil then
      TERPQuery(combo.Lookuptable).connection := CommonDbLib.GetSharedMyDacConnection;
    try
      Opendb(TERPQuery(combo.Lookuptable));
    except
    end;
  End;

  if Grid <> nil then
    SetDisplayLabel(TERPQuery(combo.datasource.dataset), combo.Datafield, Grid, cptNone,
      UserCustomisedClientName(supplierList, CustomerList, ProspectList, JobList,
      IsPrintNameCombo));

end;

{ ----- } function TNamenPrintNameGridObj.ClientLookupSQL(supplierList, CustomerList, ProspectList,
  JobList: Boolean; SelectedcleintID: Integer): String;
  function CllientTypefilter: String;
  begin
    result := '';
    if supplierList then begin
      result := 'C1.Supplier ="T"';
    end;
    if CustomerList then begin
      if result <> '' then
        result := result + ' OR ';
      result := result + 'C1.Customer ="T"';
    end;
    if ProspectList then begin
      if result <> '' then
        result := result + ' OR ';
      result := result + 'C1.OtherContact ="T"';
    end;
    if JobList then begin
      if result <> '' then
        result := result + ' OR ';
      result := result + 'C1.IsJob ="T"';
    end;
    if result <> '' then
      result := ' AND (' + result + ')';
  end;

begin
  result := '';
  result := result + '  SELECT';
  result := result + '  CT.DefaultPostAccount    AS DefaultPostAccount,';
  result := result + '  CT.DefaultPostAccountID  AS DefaultPostAccountID,';
  result := result + '  C1.ClientID              as ClientID,';
  result := result + '  C1.Company               as Company,';
  result := result + '  C1.PrintName             as PrintName,';
  result := result + '  C1.JobNumber             as JobNumber,';
  result := result + '  C1.isjob                 as isjob, ';
  result := result + '  C1.JobName               as JobName, ';
  result := result + '  C1.ParentClientID        as ParentClientID, ';
  result := result + '  C1.ForcePOOnCustomer     as ForcePOOnCustomer,';
  result := result + '  C1.StopCredit            as StopCredit,';
  result := result + '  C1.Mobile                as Mobile,';
  result := result + '  C1.Title                 as Title,';
  result := result + '  C1.Lastname              as Lastname,';
  result := result + '  C1.FirstName             as FirstName,';
  result := result + '  C1.FaxNumber             as FaxNumber, ';
  result := result + '  C1.Supplier              as Supplier, ';
  result := result + '  C1.Customer              as Customer, ';
  result := result + '  C1.OtherContact          as OtherContact, ';
  result := result + '  C1.Street                as Street,';
  result := result + '  C1.Street2               as Street2,';
  result := result + '  C1.Street3               as Street3,';
  result := result + '  C1.Suburb                as Suburb,';
  result := result + '  C1.State                 as State,';
  result := result + '  C1.Country               as Country,';
  result := result + '  C1.Postcode              as Postcode,';
  result := result + '  C1.BillStreet            as BillStreet,';
  result := result + '  C1.BillStreet2           as BillStreet2,';
  result := result + '  C1.BillStreet3           as BillStreet3,';
  result := result + '  C1.BillSuburb            as BillSuburb,';
  result := result + '  C1.BillState             as BillState,';
  result := result + '  C1.BillPostcode          as BillPostcode,';
  result := result + '  C1.BillCountry           as BillCountry,';
  result := result + '  C1.TERMS                 as TERMS,';
  result := result + '  C1.TermsID               as TermsID,';
  result := result + '  C1.ShippingMethod        as ShippingMethod,';
  result := result + '  C1.ShippingID            as ShippingID,';
  result := result + '  C1.RepID                 as RepID,';
  result := result + '  C1.TaxID                 as TaxID,';
  result := result + '  C1.Phone                 as Phone,';
  result := result + '  C1.FaxNumber             as Fax,';
  result := result + '  C1.AltPhone              as AltPhone,';
  result := result + '  IF(C1.IsJob = "T",C2.StopCredit,C1.StopCredit) AS StopCredits,';
  result := result + '  C1.ForcePOOnInvoice      as ForcePOOnInvoice,';
  result := result + '  C1.UseInvBase            as UseInvBase,';
  result := result + '  C1.InvBaseNumber         as InvBaseNumber,';
  result := result + '  C1.WarrantyFinishDate    as WarrantyFinishDate, ';
  result := result + '  C1.IsJob                 as IsJob, ';
  if CustomerList then
    result := result + '  C1.ARBalance             as Balance, '
  else
    result := result + '  C1.APBalance             as Balance, ';
  result := result + '  C1.PayMethodID           as PayMethodID, ';
  result := result + '  C1.ClientNo              as ClientNo, ';
  result := result + '  C1.BankAccountNo         as BankAccountNo, ';
  result := result + '  C1.BankAccountBSB        as BankAccountBSB, ';
  result := result + '  C1.BankAccountName       as BankAccountName, ';
  result := result + '  C1.ForeignExchangeSellCode as ForeignExchangeSellCode, ';
  result := result +
    '  IF((SELECT Count(*) FROM tblPurchaseOrders WHERE tblPurchaseOrders.Approved = "F" AND tblPurchaseOrders.ClientID = C1.ClientId) > 0,"F","T")  as All_Approved';
  result := result + NL + '  FROM tblclients as C1';
  result := result + NL + '  LEFT JOIN tblClientType AS CT on C1.ClientTypeID = CT.ClientTypeID';
  result := result + NL + '  LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID';
  result := result + NL + '  WHERE (' + inttostr(SelectedcleintID) + ' <> 0 and C1.clientId =  ' +
    inttostr(SelectedcleintID) + ' ) or  (char_length(C1.Company)>0)';
  result := result + ' ' + CllientTypefilter;
  result := result + '  AND C1.Active = "T"';
  result := result + NL + '   AND (' + F6nF7SearchSQL(['C1.Company', 'C1.Printname ']) + ')';
  result := result + '   Order by Company ASC';

end;

{ Product combo Related }
{ ----- } Procedure TNamenPrintNameGridObj.ProductLookupQueryWithSearchengine
  (var combo: TERPDbLookupcombo; DescField: String; SearchonPreferredSupplier: Boolean;
  SearchOnPrintName: Boolean; PrintNameDatafield: String; SearchOnGroupfields: Boolean;
  Grid: TwwDBGrid; IsPrintNameCombo: Boolean);
var
  s: String;
begin
  combo.options := combo.options + [loTitles];
  { This is to email to erp if there is any with the id initialisation }
  if not(Assigned(combo.OnCloseUpIdUpdateError)) then
    if Assigned(combo.Owner) and (combo.Owner is TBaseInputGUI) then
      combo.OnCloseUpIdUpdateError := TBaseInputGUI(combo.Owner).CloseUpIdUpdateError;

  Closedb(combo.Lookuptable);
  Try
    With TERPQuery(combo.Lookuptable).sql do begin
      s := ProductLookupSQL(DescField, SearchonPreferredSupplier, SearchOnGroupfields);
      if not(sametext(s, text)) then begin
        Closedb(combo.Lookuptable);
        Clear;
        Add(s);
      end;
    end;

    With combo do begin
      if TERPQuery(Lookuptable).FieldCount > 0 then
        if TERPQuery(Lookuptable).findField('ProductPrintName') = nil then begin
          if TERPQuery(combo.Lookuptable).active then
            TERPQuery(combo.Lookuptable).close;
          With TWideStringField.Create(TERPQuery(Lookuptable).Owner) do begin
            FieldKind := fkData;
            Fieldname := 'ProductPrintName';
            Size := 255;
            Displaylabel := AppEnv.companyprefs.ProductPrintNameHeading;
            Name := TERPQuery(Lookuptable).name + 'Printname';
            dataset := TERPQuery(Lookuptable);
            displayWidth := 10;
            Visible := true;
          end;
        end;
    end;

    if (combo.Lookupfield <> 'ProductPrintName') and
      (TERPQuery(combo.Lookuptable).findField('ProductPrintName') <> nil) then begin
      TERPQuery(combo.Lookuptable).findField('ProductPrintName').displayWidth :=
        FieldDisplayWidth(combo.Lookuptable, combo.Lookupfield);
      if (TERPQuery(combo.Lookuptable).findField('ProductPrintname').displayWidth = 0) or
        (TERPQuery(combo.Lookuptable).findField('ProductPrintname').displayWidth = 255) then
        TERPQuery(combo.Lookuptable).findField('ProductPrintname').displayWidth := 20;
    end;

    if IsPrintNameCombo then begin
      if Grid <> nil then
        if not(sametext(combo.Datafield, PrintNameDatafield)) then begin
          // grid.SetControlType(Combo.Datafield ,fctNone ,'' );
          Grid.SetControlType(PrintNameDatafield, fctLookupCombo, combo.name);
        end;

      if SearchOnPrintName and (PrintNameDatafield <> '') then begin
        if TERPQuery(combo.datasource.dataset).FieldCount > 0 then
          if TERPQuery(combo.datasource.dataset).findField(PrintNameDatafield) = nil then begin
            With TWideStringField.Create(TERPQuery(combo.datasource.dataset).Owner) do begin
              FieldKind := fkData;
              Fieldname := PrintNameDatafield;
              Size := 255;
              Displaylabel := AppEnv.companyprefs.ProductPrintNameHeading;
              Name := TERPQuery(combo.datasource.dataset).name + PrintNameDatafield;
              dataset := TERPQuery(combo.datasource.dataset);
              displayWidth := AppEnv.companyprefs.ProductNameDropdownWidth;
              if (displayWidth = 0) or (displayWidth = 255) then
                displayWidth := 10;
            end;
          end;
        combo.Datafield := PrintNameDatafield;
        combo.Lookupfield := 'ProductPrintName';

      end;
      if Grid <> nil then
        if not IsfieldInSelected(Grid, PrintNameDatafield) then begin
          CheckforField(TERPQuery(Grid.datasource.dataset), PrintNameDatafield);
          Grid.Selected.Insert(0, SelectedText(PrintNameDatafield,
            UserCustomisedName(cpProductPrintName), FieldDisplayWidth(Grid.datasource.dataset,
            PrintNameDatafield), ''));
        end;
    end;

    if (PrintNameDatafield <> '') and Assigned(combo.datasource) and
      Assigned(combo.datasource.dataset) then
      if TERPQuery(combo.datasource.dataset).findField(PrintNameDatafield) <> nil then
        TERPQuery(combo.datasource.dataset).findField(PrintNameDatafield).Displaylabel :=
          AppEnv.companyprefs.ProductPrintNameHeading;

    combo.Selected.Clear;
    if IsPrintNameCombo then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'ProductPrintName');
      combo.Selected.Add(SelectedText('ProductPrintName', UserCustomisedName(cpProductPrintName),
        AppEnv.companyprefs.ProductNameDropdownWidth, ''));
      CheckforField(TERPQuery(combo.Lookuptable), 'Partname');
      combo.Selected.Add(SelectedText('Partname', UserCustomisedName(cpProductname),
        AppEnv.companyprefs.ProductNameDropdownWidth, ''));
    end
    else begin
      CheckforField(TERPQuery(combo.Lookuptable), 'Partname');
      combo.Selected.Add(SelectedText('Partname', UserCustomisedName(cpProductname),
        AppEnv.companyprefs.ProductNameDropdownWidth, ''));
      CheckforField(TERPQuery(combo.Lookuptable), 'ProductPrintName');
      combo.Selected.Add(SelectedText('ProductPrintName', UserCustomisedName(cpProductPrintName),
        AppEnv.companyprefs.ProductNameDropdownWidth, ''));
    end;

    if SearchOnGroupfields then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'Manuf');
      combo.Selected.Add(SelectedText('Manuf', UserCustomisedName(cpPrductfirstcolumn),
        AppEnv.companyprefs.ProductFirstcolumnDropdownWidth, ''));
    end;
    if SearchOnGroupfields then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'Type');
      combo.Selected.Add(SelectedText('Type ', UserCustomisedName(cpProdutSecondcolumn),
        AppEnv.companyprefs.ProductSecondcolumnDropdownWidth, ''));
    end;
    if SearchOnGroupfields then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'Dept');
      combo.Selected.Add(SelectedText('Dept', UserCustomisedName(cpProductthirdcolumn),
        AppEnv.companyprefs.ProductThirdcolumnDropdownWidth, ''));
    end;
    if sametext(DescField, 'PARTSDESCRIPTION') then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'PARTSDESCRIPTION');
      combo.Selected.Add(SelectedText('PARTSDESCRIPTION', 'Description',
        AppEnv.companyprefs.ProductSalesDescDropdownWidth, ''));
    end;
    if sametext(DescField, 'PurchaseDesc') then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'PurchaseDesc');
      combo.Selected.Add(SelectedText('PurchaseDesc', 'Description',
        AppEnv.companyprefs.ProductSalesDescDropdownWidth, ''));
    end;
    if SearchonPreferredSupplier then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'PreferedSupp');
      combo.Selected.Add(SelectedText('PreferedSupp', 'Prefered Supplier',
        AppEnv.companyprefs.ProductPreferedSupDropdownWidth, ''));
    end;
    if SearchonPreferredSupplier then begin
      CheckforField(TERPQuery(combo.Lookuptable), 'SupplierProductCode');
      combo.Selected.Add(SelectedText('SupplierProductCode', 'Supplier Code',
        AppEnv.companyprefs.ProductSupplierProductCodeDropdownWidth, ''));
    end;
  Finally
    if TERPQuery(combo.Lookuptable).connection = nil then
      TERPQuery(combo.Lookuptable).connection := CommonDbLib.GetSharedMyDacConnection;
    Try
      Opendb(TERPQuery(combo.Lookuptable));
    Except
    end;
  End;

  if Grid <> nil then
    if IsPrintNameCombo then
      SetDisplayLabel(TERPQuery(combo.datasource.dataset), combo.Datafield, Grid,
        cpProductPrintName)
    else
      SetDisplayLabel(TERPQuery(combo.datasource.dataset), combo.Datafield, Grid, cpProductname);
end;

{ ----- }
function TNamenPrintNameGridObj.MakePartname(var fbUpdatingcompanyonName: Boolean; Qryproduct: TERPQuery): Boolean;
var
  QryP:TERPQuery;
  Function CleanProdut:TERPQuery;
  begin
    if QryP = nil then begin
      QryP := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      QryP.sql.text := 'Select partsId, Partname, ProductPrintname from tblparts where partsId = ' +
        inttostr(Qryproduct.FieldByName('PartsId').AsInteger);
      QryP.open;
    end;
    result := QryP;
  end;
  function IsNewProduct: Boolean;  begin      result := CleanProdut.FieldByName('partsId').AsInteger = 0;  end;
  function IsCleanNamesSame: Boolean;  begin     if qryp = nil then CleanProdut; result := sametext(QryP.FieldByName('Partname').asString, QryP.FieldByName('ProductPrintname').asString);  end;
begin
  QryP := nil;
  try
    result := true;
    if fbUpdatingcompanyonName then
      exit;
    fbUpdatingcompanyonName := true;
    try
      if (Qryproduct.FieldByName('PartsId').AsInteger <> 0) then begin
        EditDB(Qryproduct);

        if Qryproduct.findField('Globalref') <> nil then
          if (Qryproduct.FieldByName('Globalref').asString = '') then
            Qryproduct.FieldByName('Globalref').asString := AppEnv.Branch.SiteCode +
              inttostr(Qryproduct.FieldByName('PartsId').AsInteger);
        if Qryproduct.FieldByName('ProductPrintName').asString <> '' then begin
          if AppEnv.companyprefs.CopyProductPrintNameToName then
            if TProductSimple.IsUnique(Qryproduct.FieldByName('PartsId').AsInteger,
              'Partname' + ' = ' + QuotedStr(StringDataForSQL(Qryproduct.FieldByName('ProductPrintName').asString))) then begin
              if sametext(VariantToStr(Qryproduct.FieldByName('ProductPrintName').oldValue),
                Qryproduct.FieldByName('Partname').asString) or
                (Qryproduct.FieldByName('Partname').asString = '') or
                sametext(Qryproduct.FieldByName('Globalref').asString,
                Qryproduct.FieldByName('Partname').asString) or IsCleanNamesSame  then
                if IsNewProduct then  Qryproduct.FieldByName('Partname').asString := Qryproduct.FieldByName('ProductPrintName').asString;
            end
            else begin
                 if Qryproduct.FieldByName('Partname').asString = '' then
                  UserMessage('Preference to Copy ''Description'' To ''Product Name'' is Turned on.  ' +
                    'But there is already Another Product with the name ' +
                    QuotedStr(Qryproduct.FieldByName('ProductPrintName').asString) + '.' + NL + NL +
                    'It is not Possible to Copy Description to Name.' + NL +
                    'Please Change the Name if Needed.', [mbok], mtinformation);
            end;

        if trim(Qryproduct.FieldByName('Partname').asString) = '' then
          Qryproduct.FieldByName('Partname').asString :=
            trim(Qryproduct.FieldByName('Globalref').asString);
        PostDB(Qryproduct);
      end;
      end;
    finally
      fbUpdatingcompanyonName := False;
    end;

  finally
      if qryP <> nil then
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryP);
  end;
end;

{ ----- } Function TNamenPrintNameGridObj.ProductLookupSQL(DescField: String;
  SearchonPreferredSupplier, SearchOnGroupfields: Boolean): String;
begin
  result := '';
  result := result + '  SELECT Distinct ';
  result := result + ' ' + Firstcolumn('P') + ' AS Manuf  , ';
  result := result + ' ' + Secondcolumn('P') + ' AS Type  ,';
  result := result + ' ' + Thirdcolumn('P') + ' AS Dept  ,';
  result := result + '  P.PARTSID               as PARTSID,';
  result := result + '  P.PARTTYPE              as PARTTYPE,';
  result := result + '  P.PRODUCTGROUP          as PRODUCTGROUP,';
  result := result + '  P.PARTNAME              as PARTNAME,';
  result := result + '  P.ProductPrintName      as ProductPrintName,';
  result := result + '  P.PARTSDESCRIPTION      as PARTSDESCRIPTION,';
  result := result + '  P.INCOMEACCNT           as INCOMEACCNT,';
  result := result + '  P.PurchaseDesc          as PurchaseDesc,';
  result := result + '  P.ASSETACCNT            as ASSETACCNT,';
  result := result + '  P.COGSACCNT             as COGSACCNT,';
  result := result + '  P.BARCODE               as BARCODE,';
  result := result + '  P.PRODUCTCODE           as PRODUCTCODE,';
  result := result + '  P.PURCHTAXCODE          as PURCHTAXCODE,';
  result := result + '  P.PREFEREDSUPP          as PREFEREDSUPP,';
  result := result + '  P.Batch                 as Batch,';
  result := result + '  P.SpecialDiscount       as SpecialDiscount,';
  result := result + '  P.SNTracking            as SNTracking,';
  result := result + '  P.BuyQTY1               as BuyQTY1,';
  result := result + '  P.BuyQTY2               as BuyQTY2,';
  result := result + '  P.BuyQTY3               as BuyQTY3,';
  result := result + '  P.COST1                 as COST1,';
  result := result + '  P.COST2                 as COST2,';
  result := result + '  P.COST3                 as COST3,';
  result := result + '  P.SellQTY1              as SellQTY1,';
  result := result + '  P.SellQTY2              as SellQTY2,';
  result := result + '  P.SellQTY3              as SellQTY3,';
  result := result + '  P.PRICE1                as PRICE1,';
  result := result + '  P.PRICE2                as PRICE2,';
  result := result + '  P.PRICE3                as PRICE3,';
  result := result + '  P.WHOLESALEPRICE        as WHOLESALEPRICE,';
  result := result + '  P.Active                as Active,';
  result := result + '  P.EditedFlag            as EditedFlag,';
  result := result + '  P.MultipleBins          as MultipleBins,';
  result := result + '  P.AvgCost               as AvgCost,';
  result := result + '  P.Discontinued          as Discontinued,';
  result := result + '  P.Attrib1Purchase       as Attrib1Purchase,';
  result := result + '  P.Attrib2Purchase       as Attrib2Purchase,';
  result := result + '  P.Attrib1PurchaseRate   as Attrib1PurchaseRate,';
  result := result + '  if (ifnull(LatestCost ,0) = 0 , cost1, LatestCost ) as LatestCostPrice ,';
  result := result + '  P.taxcode               as TaxCode,';
  result := result + '  p.LatestCost            as LatestCost,';
  result := result + '  p.AutoBatch             as AutoBatch, ';
  result := result + '  p.Attrib1Sale           as Attrib1Sale,';
  result := result + '  p.Attrib2Sale           as Attrib2Sale,';
  result := result + '  p.Attrib1SaleRate       as Attrib1SaleRate,';
  result := result + '  P.LatestCostDate        as LatestCostDate,';
  result := result + '  SupplierProductCode     as SupplierProductCode,';
  result := result + '  P.Multibuy              as Multibuy,';
  // New field - nobody knows where it's to be used though
  result := result + '  p.GeneralNotes          as GeneralNotes,';
  result := result + '  `P`.`CUSTFLD1`,';
  result := result + '  `P`.`CUSTFLD2`,';
  result := result + '  `P`.`CUSTFLD3`,';
  result := result + '  `P`.`CUSTFLD4`,';
  result := result + '  `P`.`CUSTFLD5`,';
  result := result + '  `P`.`CUSTFLD6`,';
  result := result + '  `P`.`CUSTFLD7`,';
  result := result + '  `P`.`CUSTFLD8`,';
  result := result + '  `P`.`CUSTFLD9`,';
  result := result + '  `P`.`CUSTFLD10`,';
  result := result + '  `P`.`CUSTFLD11`,';
  result := result + '  `P`.`CUSTFLD12`,';
  result := result + '  `P`.`CUSTFLD13`,';
  result := result + '  `P`.`CUSTFLD14`,';
  result := result + '  `P`.`CUSTFLD15`,';
  result := result + '  `P`.`CUSTDATE1`,';
  result := result + '  `P`.`CUSTDATE2`,';
  result := result + '  `P`.`CUSTDATE3`';
  result := result + NL + '  FROM `tblParts` P';
  result := result + NL + '  WHERE P.Active = "T"';
  result := result + NL + '   AND Partname <> ' + QuotedStr(PART_PROGRESSPAYMENT_TERMS);
  result := result + NL + '   AND (' + F6nF7SearchSQL(['Partname', 'ProductPrintName', DescField,
    iif(SearchonPreferredSupplier, 'PREFEREDSUPP', ''), iif(SearchOnGroupfields, Firstcolumn, ''),
    iif(SearchOnGroupfields, Secondcolumn, ''), iif(SearchOnGroupfields, Thirdcolumn, '')]) + ')';

end;

{ Account Combo Related }
{ ----- } procedure TNamenPrintNameGridObj.AccountLookupQueryWithSearchengine
  (SelectedcleintID: Integer; combo: TERPDbLookupcombo);
begin
  if not(Assigned(combo.OnCloseUpIdUpdateError)) then
    if Assigned(combo.Owner) and (combo.Owner is TBaseInputGUI) then
      combo.OnCloseUpIdUpdateError := TBaseInputGUI(combo.Owner).CloseUpIdUpdateError;

  Closedb(combo.Lookuptable);
  try
    With TERPQuery(combo.Lookuptable).sql do begin
      Clear;
      Add(AccountLookupSQL(SelectedcleintID));
    end;
  Finally
    if TERPQuery(combo.Lookuptable).connection = nil then
      TERPQuery(combo.Lookuptable).connection := CommonDbLib.GetSharedMyDacConnection;
    try
      Opendb(TERPQuery(combo.Lookuptable));
    Except
    end;
  End;

  combo.Selected.Clear;
  if SameText(combo.LookupField,'AccountNumber') then begin
    CheckforField(TERPQuery(combo.Lookuptable), 'AccountNumber');
    CheckforField(TERPQuery(combo.Lookuptable), 'AccountName');
    CheckforField(TERPQuery(combo.Lookuptable), 'AccountTree');
    CheckforField(TERPQuery(combo.Lookuptable), 'Type');
    CheckforField(TERPQuery(combo.Lookuptable), 'Description');

    combo.Selected.Add(SelectedText('AccountNumber' , 'Account Number', 20        , ''));
    combo.Selected.Add(SelectedText('AccountName' , 'Account Name', AppEnv.companyprefs.AccountNamecolumnDropdownWidth        , ''));
    combo.Selected.Add(SelectedText('AccountTree' , 'Account Tree', 20        , ''));
    combo.Selected.Add(SelectedText('Type'        , 'Type'        , AppEnv.companyprefs.AccountTypecolumnDropdownWidth        , ''));
    combo.Selected.Add(SelectedText('Description' , 'Description' , AppEnv.companyprefs.AccountDescriptioncolumnDropdownWidth , ''));
  end
  else begin
    CheckforField(TERPQuery(combo.Lookuptable), 'AccountName');
    CheckforField(TERPQuery(combo.Lookuptable), 'Type');
    CheckforField(TERPQuery(combo.Lookuptable), 'Description');
    combo.Selected.Add(SelectedText('AccountName' , 'Account Name', AppEnv.companyprefs.AccountNamecolumnDropdownWidth        , ''));
    combo.Selected.Add(SelectedText('Type'        , 'Type'        , AppEnv.companyprefs.AccountTypecolumnDropdownWidth        , ''));
    combo.Selected.Add(SelectedText('Description' , 'Description' , AppEnv.companyprefs.AccountDescriptioncolumnDropdownWidth , ''));
  end;
end;

{ ----- } function TNamenPrintNameGridObj.AccountLookupSQL(const SelectedcleintID: Integer): String;
begin
  result := ' SELECT ';
  result := result + ' COA.AccountID,';
  result := result + ' COA.AccountName,';
  result := result + ' COA.AccountGroup,';
  result := result + ' COA.AccountNumber,';
  result := result + ' COA.AccountNumber as AccountNo,';
  result := result + ' tblacctypedesc.AccDesc AS Type,';
  result := result + ' COA.Description,';
  result := result + ' COA.Taxcode,';
  result := result + ' COA.Active,';
  result := result +
    ' Concat(If( char_length(Level4)>0,Space(15), If( char_length(Level3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),AccountName) as AccountTree,';
  result := result +
    ' SUBSTRING(If((char_length(COA.AccountGroup)>0),Concat(REPLACE(COA.AccountGroup,"^"," - ")," - ",COA.AccountName),COA.AccountName),1,255) as FullAccountName';
  result := result + ' FROM tblChartofAccounts COA';
  result := result + ' LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = COA.AccountType';
  result := result + ' WHERE (Active = "T") and (IsHeader = "F")';
  if SelectedcleintID <> 0 then
    result := result + ' COA.AccountId =' + inttostr(SelectedcleintID);
  result := result + NL + '   AND (' +
    F6nF7SearchSQL(['COA.AccountNumber', 'COA.AccountName']) + ')';
  result := result + ' ORDER BY Type, AccountNumber';
end;

{ taxcode Related }
{ ----- } procedure TNamenPrintNameGridObj.TaxcodeLookupQueryWithSearchengine  (SelectedTaxCodeID: Integer; combo: TERPDbLookupcombo; FilterforLocation:Boolean= False);
begin
  if not(Assigned(combo.OnCloseUpIdUpdateError)) then
    if Assigned(combo.Owner) and (combo.Owner is TBaseInputGUI) then
      combo.OnCloseUpIdUpdateError := TBaseInputGUI(combo.Owner).CloseUpIdUpdateError;

  Closedb(combo.Lookuptable);
  try
    With TERPQuery(combo.Lookuptable).sql do begin
      Clear;
      Add(TaxcodeLookupSQL(SelectedTaxCodeID, FilterforLocation));
    end;
  Finally
    if TERPQuery(combo.Lookuptable).connection = nil then
      TERPQuery(combo.Lookuptable).connection := CommonDbLib.GetSharedMyDacConnection;
    try
      Opendb(TERPQuery(combo.Lookuptable));
    except
    end;
  End;
end;

{ ----- } function TNamenPrintNameGridObj.TaxcodeLookupSQL(const SelectedTaxCodeID: Integer; FilterforLocation:Boolean= False): String;
begin
  result := '';
  result := result + ' SELECT T.TaxCodeID, T.Name as Name, T.Description, T.Rate ';
  if FilterforLocation then result := result + ' , LOC.LocationValue as Location ';
  result := result + ' FROM tbltaxcodes T';
  if FilterforLocation then result := result + ' Left join tbltaxcodelocations LOC on T.TaxCodeID = LOC.TaxCodeID';
  result := result + ' Where T.RegionID=:xRegionID';
  result := result + ' AND T.Active <>"F"';
  if FilterforLocation then result := result + ' and  ((ifnull(LOC.ID,0)=0) or ( :filterTaxcodeforClient ="F") or '+
                                                     ' (LOc.active ="T" and '+
                                                     ' (T.TaxcodeLocationCategory ="C" and LOC.LocationValue = :Clientcountry ) or '+
                                                     ' (T.TaxcodeLocationCategory ="S" and LOC.LocationValue = :ClientState ) or '+
                                                     ' (T.TaxcodeLocationCategory ="L" and LOC.LocationValue = :clientLocation ) or '+
                                                     ' (T.TaxcodeLocationCategory ="P" and LOC.LocationValue = :ClientPostcode ) '+
                                                     ' ))';
  if SelectedTaxCodeID <> 0 then result := result + ' T.TaxCodeID=' + inttostr(SelectedTaxCodeID);
  result := result + NL + '   AND (' + F6nF7SearchSQL(['T.Name', 'T.Description']) + ')';
  result := result + ' ORDER BY Name';
end;
procedure TApproverCombo.onApprovercomboDblclick(Sender: TObject);
begin
  fsApprovaltype :=TERPQuery(TwwDBLookupcombo(Sender).LookupTable).Parambyname('Approvaltype').asString;
  OpenERPListForm('TApprovalLevelListGUI' , initApprovalLevelList);
end;
procedure TApproverCombo.initApprovalLevelList(Sender: TObject);
begin
   if sender is TApprovalLevelListGUI then begin
     TApprovalLevelListGUI(Sender).filterString := 'Approvaltype = ' + quotedstr(fsApprovaltype);
   end;
end;
Procedure TApproverCombo.ApproverLookupQrySQL(Combo :TwwDBLookupcombo; aApprovaltype:String);
var
  fbActive:Boolean;
  fs:String;
begin
  fs:= 'select distinct al.EmployeeID, al.EmployeeName, e.Email '+
      ' FROM tblapprovallevels al  '+
      ' INNER join tblemployees e on e.EmployeeID = al.EmployeeID and e.active ="T"  '+
      ' WHERE (:OrderTotal >= (al.ValueFrom - al.ValueLeeway))  '+
      ' AND (:OrderTotal <= (al.ValueTo + al.ValueLeeway))   '+
      ' AND al.ApprovalType = :Approvaltype '+
      ' Order by EmployeeName';
  if sametext(TERPQuery(Combo.LookupTable).sql.text , fs) and (TERPQuery(Combo.LookupTable).Parambyname('Approvaltype').asString = aApprovaltype) then exit;

  combo.ondblclick := onApprovercomboDblclick;
  fbactive := TERPQuery(Combo.LookupTable).active;
  try
    closedb(TERPQuery(Combo.LookupTable));
    TERPQuery(Combo.LookupTable).sql.text := fs;
    TERPQuery(Combo.LookupTable).Parambyname('Approvaltype').asString := aApprovaltype;
  finally
    try
      if TERPQuery(Combo.LookupTable).active <> fbactive then TERPQuery(Combo.LookupTable).active := fbactive;
    Except
    end;
  end;
  TfrmBaseGUI(Combo.Owner).Showcontrolhint(Combo, 'List of Active Users Who Can Approve '+ quotedstr(aApprovaltype) +' For the Total Transaction Amount.'+NL+NL+
                                                  'Double Click for the List of Approvers for  '+ quotedstr(aApprovaltype) +'.');
end;

initialization
  fApproverCombo:=TApproverCombo.create(nil);
finalization
  Freeandnil(fApproverCombo);

end.
