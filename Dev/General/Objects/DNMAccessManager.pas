unit DNMAccessManager;
{
Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 12/04/03 1.00.00  ML - Initial version
                        This component has been established to handle form access levels.
                        It merely attaches itself into the relevant OnBeforeBlahBlah events
                        for a TERPQuery and TMyTable.

                        It requires the developer to implement the necessary business logic
                        according to the access levels.

 15/08/06 1.00.01 BJ  1) Initialise gets the names of dataset components in the form
                        which are used by any busniess object. Business object has a propery of
                        accessmanager within it which handles the lock for these tables, so is
                        ignored by the access manager.
                      2) made Do.. procedures which is called from the dataset event procs.
                        Business objects using these public procs to check the access levels.  
}

interface

uses
  Windows, Messages, SysUtils, Classes, DB,  MyAccess,ERPdbComponents;

type

  TDNMAccessManager = class(TComponent)
  private
    { Private declarations }
    isInitialized: boolean;
    fiAccessLevel: integer;
    procedure setBeforeDelete(ds: TDataSet);
    procedure setBeforeInsert(ds: TDataSet);
    procedure setBeforeOpen(ds: TDataSet);
    procedure setBeforePost(ds: TDataSet);
    procedure setBeforeEdit(ds: TDataSet);

    procedure BeforeDelete(DataSet: TDataSet);
    procedure BeforeInsert(DataSet: TDataSet);
    procedure BeforeOpen(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet);
    procedure BeforeEdit(DataSet: TDataSet);
    procedure setAccesslevel(const Value: integer);

  protected
    { Protected declarations }
  public
    { Public declarations }
      {the arBefore... dynamic arrays hold preset on... EventHandlers.
       After we have chained the DNMAccessManager into the Dataset Event
       our Before... Events get called and after checking accesslevels
       then in turn call the Handler found in the dynamic array
       ATTENTION:
       to be fast we use the DataSet.Tag as index for each event type
       into the dynamic array - that is entry[0] would have 1 in the tag.
       0 in the tag means no prior Handler
       Tag is split up into 5 six bit words:
        delete entry : tag shr 0 AND 063
        insert entry : tag shr 6 AND 063}

    arBeforeDelete: array of TDataSetNotifyEvent;
    arBeforeInsert: array of TDataSetNotifyEvent;
    arBeforeOpen: array of TDataSetNotifyEvent;
    arBeforePost: array of TDataSetNotifyEvent;
    arBeforeEdit: array of TDataSetNotifyEvent;
    property AccessLevel: integer read fiAccesslevel write setAccesslevel;

    procedure Initialize(AccessLevel: integer; const BusObjqueries :Array of String);

    
    Function DoBeforeDelete(DataSet: TDataSet):Boolean;
    Function DoBeforeInsert(DataSet: TDataSet):Boolean;
    Function DoBeforeOpen(DataSet: TDataSet):Boolean;
    Function DoBeforePost(DataSet: TDataSet):Boolean;
    Function DoBeforeEdit(DataSet: TDataSet):Boolean;

    constructor Create(AOwner: TComponent); override;

    //    function GetTag(Tag: Integer; tagEntry: TTagEntry): Integer;
  published
    { Published declarations }
  end;

implementation

const
  NOTAGBITS = 6;
  TAGBITS   = $03F;
type
  TagNo = 0..TAGBITS;
  TTagEntry = (teDelete, teInsert, teOpen, teEdit, tePost);

{ SetTag-----------------------------------------------------------}
function SetTag(Tag: integer; tagEntry: TTagEntry; no: TagNo): integer;
var 
  mask, negmask: cardinal;
begin
  mask := TAGBITS shl (Ord(tagEntry) * NOTAGBITS);    // create mask eg tagEntry=1 : 0111111000000
  negmask := not mask;
  Result := Tag and negmask;     // blank out
  Result := Result or (no shl (Ord(tagEntry) * NOTAGBITS));   // insert no into position
end;

{ TDNMAccessManager.GetTag-----------------------------------------------------------}
function GetTag(Tag: integer; tagEntry: TTagEntry): integer;
begin
  Result := (Tag shr (Ord(tagEntry) * NOTAGBITS)) and TAGBITS;
end;


{ TDNMAccessManager.setBeforeDelete-----------------------------------------------------------}
procedure TDNMAccessManager.setBeforeDelete(ds: TDataSet);
var 
  no: integer;
begin
  if GetTag(ds.Tag, teDelete) = 0 then // avoids recursion
  begin
    if Assigned(ds.BeforeDelete) then begin
      no := Length(arBeforeDelete) + 1;            // get current length of array
      ASSERT(no < TagBits, 'Cannot have more than 62 DataSets');
      SetLength(arBeforeDelete, no);             // increase by one slot
      arBeforeDelete[no - 1] := ds.BeforeDelete;   // store existing Handler
      ds.Tag := SetTag(ds.Tag, teDelete, no);    // and make position persistent
    end else ds.Tag := SetTag(ds.Tag, teDelete, TagBits);// mark that we have been here
    ds.BeforeDelete := BeforeDelete;        // Hook in our Event
  end;
end;

{ TDNMAccessManager.setBeforeInsert-----------------------------------------------------------}
procedure TDNMAccessManager.setBeforeInsert(ds: TDataSet);
var 
  no: integer;
begin
  if GetTag(ds.Tag, teInsert) = 0 then // avoids recursion
  begin
    if Assigned(ds.BeforeInsert) then begin
      no := Length(arBeforeInsert) + 1;   // get current length of array
      ASSERT(no < TagBits, 'Cannot have more than 62 DataSets');
      SetLength(arBeforeInsert, no);    // increase by one slot
      arBeforeInsert[no - 1] := ds.BeforeInsert;  // put in existing Handler
      ds.Tag := SetTag(ds.Tag, teInsert, no);             // and make position persistent
    end else ds.Tag := SetTag(ds.Tag, teInsert, TagBits);// mark that we have been here
    ds.BeforeInsert := BeforeInsert; // Hook in our Event
  end;
end;

{ TDNMAccessManager.setBeforeOpen-----------------------------------------------------------}
procedure TDNMAccessManager.setBeforeOpen(ds: TDataSet);
var 
  no: integer;
begin
  if GetTag(ds.Tag, teOpen) = 0 then // avoids recursion
  begin
    if Assigned(ds.BeforeOpen) then begin
      no := Length(arBeforeOpen) + 1;   // get current length of array
      ASSERT(no < TagBits, 'Cannot have more than 62 DataSets');
      SetLength(arBeforeOpen, no);    // increase by one slot
      arBeforeOpen[no - 1] := ds.BeforeOpen;  // put in existing Handler
      ds.Tag := SetTag(ds.Tag, teOpen, no);             // and make position persistent
    end else ds.Tag := SetTag(ds.Tag, teOpen, TagBits);// mark that we have been here
    ds.BeforeOpen := BeforeOpen; // Hook in our Event
  end;
end;

{ TDNMAccessManager.setBeforePost-----------------------------------------------------------}
procedure TDNMAccessManager.setBeforePost(ds: TDataSet);
var 
  no: integer;
begin
  if GetTag(ds.Tag, tePost) = 0 then // avoids recursion
  begin
    if Assigned(ds.BeforePost) then begin
      no := Length(arBeforePost) + 1;   // get current length of array
      ASSERT(no < TagBits, 'Cannot have more than 62 DataSets');
      SetLength(arBeforePost, no);    // increase by one slot
      arBeforePost[no - 1] := ds.BeforePost;  // put in existing Handler
      ds.Tag := SetTag(ds.Tag, tePost, no);             // and make position persistent
    end else ds.Tag := SetTag(ds.Tag, tePost, TagBits);// mark that we have been here
    ds.BeforePost := BeforePost; // Hook in our Event
  end;
end;

{ TDNMAccessManager.setBeforeEdit-----------------------------------------------------------}
procedure TDNMAccessManager.setBeforeEdit(ds: TDataSet);
var 
  no: integer;
begin                      
  if GetTag(ds.Tag, teEdit) = 0 then // avoids recursion
  begin
    if Assigned(ds.BeforeEdit) then begin
      no := Length(arBeforeEdit) + 1;   // get current length of array
      ASSERT(no < TagBits, 'Cannot have more than 62 DataSets');
      SetLength(arBeforeEdit, no);    // increase by one slot
      arBeforeEdit[no - 1] := ds.BeforeEdit;  // put in existing Handler
      ds.Tag := SetTag(ds.Tag, teEdit, no);             // and make position persistent
    end else ds.Tag := SetTag(ds.Tag, teEdit, TagBits);// mark that we have been here
    ds.BeforeEdit := BeforeEdit; // Hook in our Event
  end;
end;

{ TDNMAccessManager.Initialize-----------------------------------------------------------}
procedure TDNMAccessManager.Initialize(AccessLevel: integer; const BusObjqueries :Array of String);
var
  iIndex: integer;
  iCount: integer;
  IsBusObjectTable :Boolean;
begin
  if isInitialized then Exit;
  isInitialized := true;
  fiAccessLevel := AccessLevel;
  for iIndex := 0 to Self.Owner.ComponentCount - 1 do
      if (Self.Owner.Components[iIndex] is TCustomMyDataSet) then begin
          IsBusObjectTable := False;
        if High(BusObjqueries) <> 0 then
            for iCount := Low(BusObjqueries) to High(BusObjqueries) do
                if uppercase(BusObjqueries[icount]) = uppercase(TDataSet(Self.Owner.Components[iIndex]).Name) then
                    IsBusObjectTable := True;
          if IsBusObjectTable = False then begin
              setBeforeOpen(TDataSet(Self.Owner.Components[iIndex]));
              setBeforeInsert(TDataSet(Self.Owner.Components[iIndex]));
              setBeforeDelete(TDataSet(Self.Owner.Components[iIndex]));
              setBeforeEdit(TDataSet(Self.Owner.Components[iIndex]));
              setBeforePost(TDataSet(Self.Owner.Components[iIndex]));
              //Log('AccessManager-' + TDataSet(Self.Owner.Components[iIndex]).Name, 'Debug');
          end else //Log( TDataSet(Self.Owner.Components[iIndex]).Name + '- locked by businessobj', 'Debug');
        end;
end;

{ TDNMAccessManager.BeforeDelete-----------------------------------------------------------}
Function TDNMAccessManager.DoBeforeDelete(DataSet: TDataSet):Boolean;
begin
  REsult := False;
  case fiAccessLevel of
    2: Abort; {Full Access, no delete}
    3: Abort; {Create + Read Access}
    5: Abort; {ReadOnly Access}
    else Result := True;
  end;
end;
procedure TDNMAccessManager.BeforeDelete(DataSet: TDataSet);
begin
  if DoBeforeDelete(Dataset) then
    if GetTag(DataSet.Tag, teDelete) in [1..TagBits - 1] then arBeforeDelete[GetTag(DataSet.Tag, teDelete) - 1](DataSet);
end;

{ TDNMAccessManager.BeforeInsert-----------------------------------------------------------}
Function TDNMAccessManager.DoBeforeInsert(DataSet: TDataSet):Boolean;
Begin
  Result := False;
  case fiAccessLevel of
    5: Abort; {ReadOnly Access}
    else Result := True;
  end;
End;
procedure TDNMAccessManager.BeforeInsert(DataSet: TDataSet);
begin
  if DoBeforeInsert(Dataset) then
    if GetTag(DataSet.Tag, teInsert) in [1..TagBits - 1] then arBeforeInsert[GetTag(DataSet.Tag, teInsert) - 1](DataSet);
end;

{ TDNMAccessManager.BeforeOpen-----------------------------------------------------------}
Function TDNMAccessManager.DoBeforeOpen(DataSet: TDataSet): boolean;
begin
    Result := False;
    if (fiAccessLevel <> 6) then
        Result := True;
    (*else
        raise ENoAccess.Create('You don''t have access to ' + {TForm(Owner).Caption); }
            AppEnv.AccessLevels.GetFormDescription(Self.Owner.ClassName));*)
end;
procedure TDNMAccessManager.BeforeOpen(DataSet: TDataSet);
begin
    if DoBeforeOpen(Dataset) then
        if GetTag(DataSet.Tag, teOpen) in [1..TagBits - 1] then arBeforeOpen[GetTag(DataSet.Tag, teOpen) - 1](DataSet);
end;

{ TDNMAccessManager.BeforePost-----------------------------------------------------------}
Function TDNMAccessManager.DoBeforePost(DataSet: TDataSet):Boolean;
begin
  Result := False;
  case fiAccessLevel of
    5: Abort; {ReadOnly Access}
    Else Result := True;
  end;
end;
procedure TDNMAccessManager.BeforePost(DataSet: TDataSet);
begin
    if DoBeforePost(DataSet) then
        if GetTag(DataSet.Tag, tePost) in [1..TagBits - 1] then arBeforePost[GetTag(DataSet.Tag, tePost) - 1](DataSet);
end;

{ TDNMAccessManager.BeforeEdit-----------------------------------------------------------}
Function TDNMAccessManager.DoBeforeEdit(DataSet: TDataSet):Boolean ;
begin
  //Log('AccessManager-BeforeEdit' + Self.Classname +'-' + Dataset.Name, 'Debug');
  Result := False;
  case fiAccessLevel of
    3: Abort; {Create + Read Access}
    5: Abort; {ReadOnly Access}
    else Result := True;
  end;
End;
procedure TDNMAccessManager.BeforeEdit(DataSet: TDataSet);
begin

    if DoBeforeEdit(DataSet) then
        if GetTag(DataSet.Tag, teEdit) in [1..TagBits - 1] then arBeforeEdit[GetTag(DataSet.Tag, teEdit) - 1](DataSet);
end;
constructor TDNMAccessManager.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
//    if AOwner is TBaseInputGUI then Accesslevel := TBaseInputGUI(AOwner).Accesslevel;
end;

procedure TDNMAccessManager.setAccesslevel(const Value: integer);
begin
  fiAccesslevel :=value;
  if (fiAccesslevel <1) or (fiAccesslevel >6) then begin
    raise(Exception.create('Access level Outside the Valid Range of 1 to 6'));
  end;
end;

end.
