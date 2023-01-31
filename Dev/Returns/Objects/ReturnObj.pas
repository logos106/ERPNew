unit ReturnObj;

interface

uses
  ERPdbComponents, Classes, BusobjReturns, dbCtrls, db,
  WwDbiGrd,Generics.Collections , DNMLib;

const
  tPTMonthly    = 'Monthly';
  tPTTwoMonthly = 'Two Monthly';
  tPTQuarterly  = 'Quarterly';
  tPTSixMonthly  = 'Six Monthly';

type
  TObjType = (ftTax, ftAcc);

  TReturnObj = class(TObject)
    procedure qryMainBeforeOpen(DataSet: TDataSet);

  Private
    fOwnerForm: TComponent;
    fReturnsObj: TReturns;
    fFrom: TDBEdit;
    fsAccountingMethod: string;
    fFromTo: TDateTime;
    fFromDate: TDateTime;
    fsClassName: string;
    fbAll: boolean;
    fObjType: TObjType;
    fFromName: string;

    procedure SetqryMain(const Value: TERPQuery);
    function StrExtStr(const HSrc, Delim: string; const Count: integer): string;


  Protected
    fBMList: TList<TBookmark>;
    fqryMain: TERPQuery;
    fbExternalQueryUsed :Boolean;
    BasisMode: TBASBasisMode;
    procedure ReSelect;
    procedure AmountToField(Amount: double; From: TDBEdit);

  Public
    constructor Create;virtual;
    destructor Destroy; override;
    procedure AssignBookmarks(List: TwwBookmarkList);
    procedure Initialize;Virtual;

    property qryMain: TERPQuery read fqryMain write SetqryMain;
    Property OwnerForm :TComponent read fOwnerForm write fOwnerForm;
    Property ReturnsObj :TReturns read fReturnsObj write fReturnsObj;
    property From: TDBEdit read fFrom write fFrom;
    property BMList: TList<TBookmark> read fBMList; // write SetBMList;
    property AccountingMethod: string read fsAccountingMethod write fsAccountingMethod;
    property FromDate: TDateTime read fFromDate write fFromDate;
    property ToDate: TDateTime read fFromTo write fFromTo;
    property Department: string read fsClassName write fsClassName;
    property All: boolean read fbAll write fbAll;
    property ObjType: TObjType read fObjType write fObjType; //Change to ObjType when finished
    property FromName: string read fFromName write fFromName;
    procedure RefreshCalcFields;Virtual;


  end;
implementation

uses Sysutils, CommonDbLib, ReturnsBase, FastFuncs, CommonLib, AppEnvironment;

{ TReturnObj }

constructor TReturnObj.Create;
begin
  fbExternalQueryUsed := false;
  fOwnerForm:= nil;
  fReturnsObj:= nil;
  fBMList := TList<TBookmark>.Create;
  fqryMain := TempMyQuery;
end;

destructor TReturnObj.Destroy;
begin
  if not fbExternalQueryUsed then FreeandNil(fqryMain);
  FreeandNil(fBMList);
  inherited;
end;

procedure TReturnObj.Initialize;
begin
  if not (AccountingMethod = 'Cash') then begin
    BasisMode := Accrual_Basis;
  end else begin
    BasisMode := Cash_Basis;
  end;
with qryMain do begin
    case ObjType of
      ftTax:
        begin
          sql.Clear;
          sql.add('SELECT Name as "TaxCode Name", Description ,TaxCodeID FROM tbltaxcodes Where RegionID= :xRegionID and Active = "T";');
          qryMain.BeforeOpen := qryMainBeforeOpen;
          Active := true;
          FieldByName('TaxCode Name').DisplayWidth := 15;
          FieldByName('TaxCode Name').Visible := true;
          FieldByName('TaxCode Name').Index := 0;
          FieldByName('Description').DisplayWidth := 55;
          FieldByName('Description').Visible := true;
          FieldByName('Description').Index := 1;
          FieldByName('TaxCodeID').Visible := false;
          ReSelect;
        end;
    end;
end;

end;

procedure TReturnObj.qryMainBeforeOpen(DataSet: TDataSet);
begin
  qryMain.ParamByName('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TReturnObj.RefreshCalcFields;
begin

end;

procedure TReturnObj.ReSelect;
var
  Count, I, G, F, C: integer;
  TempFieldName, TempSelectedStrings, TempSelectedStr: string;
begin
  if not Empty(FromName) then begin
    TempFieldName := FromName + 'Selected';
    // Are we using Australian or New Zealand system?
    if Assigned(OwnerForm) then
          if OwnerForm is TReturnsBaseGUI then begin
            TempSelectedStrings := TReturnsBaseGUI(OwnerForm).QryReturns.FieldByName(TempFieldName).AsString;
          end;

    C := 0;

    //Get Selected Count
    if TempSelectedStrings <> '' then
      for F := 1 to 100 do begin
        if StrExtStr(TempSelectedStrings, #44, F) <> '' then begin
          C := C + 1;
        end;
      end;

    //Reselect
    fBMList.Clear;
    if C > 0 then begin
      for G := 1 to C do begin
        TempSelectedStr := StrExtStr(TempSelectedStrings, #44, G);

          Count := qryMain.RecordCount - 1;
          qryMain.First;

          for I := 0 to Count do begin
            if Trim(TempSelectedStr) = Trim(qryMain.Fields[0].AsString) then begin
              fBMList.Add(qryMain.GetBookmark);
            end;
            qryMain.Next;
          end;

      end;
    end;
    qryMain.First;
  end;
end;

procedure TReturnObj.SetqryMain(const Value: TERPQuery);
begin

  if not fbExternalQueryUsed then FreeandNil(fqryMain);
  fqryMain := Value;
  fbExternalQueryUsed := true;

end;

procedure TReturnObj.AmountToField(Amount: double; From: TDBEdit);
begin
  if Assigned(OwnerForm) then
    if OwnerForm is TReturnsBaseGUI then begin
      EditDb(TReturnsBaseGUI(OwnerForm).QryReturns);
      TReturnsBaseGUI(OwnerForm).QryReturns.FieldByName(From.Name).AsCurrency := FloatToCurr(Amount);
    end;
  RefreshCalcFields;
end;

procedure TReturnObj.AssignBookmarks(List: TwwBookmarkList);
var
  x: integer;
begin
  fBMList.Clear;
  for x:= 0 to List.Count-1 do
    fBMList.Add(List[x]);
end;
function TReturnObj.StrExtStr(const HSrc, Delim: string;
  const Count: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := HSrc + Delim;
  S := 1;
  for L9 := 1 to Count - 1 do begin
    S := FastFuncs.PosEx(Delim, Src);
    if S > 0 then Delete(Src, S, char_length(Delim))
    else Break;
  end;
  Result := '';
  if S > 0 then begin
    E      := FastFuncs.PosEx(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

end.

