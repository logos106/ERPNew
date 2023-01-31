unit AuditTrialTreeLib;

interface

uses BusObjBase,Contnrs , BusObjProcess;

type
  TAuditEntry = class(TObject)
  Private
    fiSeq: Integer;
    fsNewValue: String;
    fsOldValue: String;
    fsfieldName: String;
    fsDescription: String;
  Public
    Property Description:String read fsDescription write fsDescription;
    Property fieldName:String read fsfieldName write fsfieldName;
    Property OldValue:String read fsOldValue write fsOldValue;
    Property NewValue:String read fsNewValue write fsNewValue;
    Property Seq:Integer read fiSeq write fiSeq;
  end;

  TPropEntry = class(TObject)
  Private
    fsPropValue: String;
    fsPropname: String;
  Public
    Property Propname:String read fsPropname write fsPropname;
    Property PropValue:String read fsPropValue write fsPropValue;
  end;

  Procedure  InspectObj(Obj: TObject; PropEntrylist :TObjectList);
  Function DoAuditTrial(Clean, current: TProcTreeNode;MasterRef, MasterType:String ;transRef:STring=''):Boolean;
  procedure AddAuditEntry(Description:String;fieldName:String='';OldValue:String='';NewValue:String='');
  Function AuditTrial(OldNode,NewNode: TProcTreeNode):Boolean;
  Function CompareTreeNodes(Clean, current: TProcTreeNode):Boolean;
  function findnode(xNode: TProcTreeNode; xProcTreeID:Integer): TProcTreeNode;
  function Leveled(Text:String;Levelno:Integer):String;
  function TreeCaption(Node:TProcTreeNode):String;
  function AuditChangeDescription:String;
  Procedure SaveAuditTrial(MasterRef, MasterType,transRef:STring);

var
  AuditEntryList :TObjectList;

implementation

uses Typinfo, sysutils, Variants, CommonLib, BusObjAudit, tcConst, classes;



Procedure InspectObj(Obj: TObject; PropEntrylist :TObjectList);
var
  iIndex, Propcount: integer;
  PropList: PPropList ;
  PropName:String;
  PropValue:String;
  Val:Variant;
  subObj: TObject;
const
  Propstoignore : Array [1..8] of string = ('Tag','ParentID' , 'ProctreeId' , 'MasterID', 'isdirty' , 'TreeRootId','msTimeStamp', 'ExportExcludeList');
begin
  if obj = nil then exit;
  Propcount:= GetPropList(PTypeInfo(obj.ClassInfo) , PropList);
  if (not(Assigned(PropList))) or (Propcount = 0 ) then else begin
    for iIndex := 0 to Propcount-1 do begin
      PropName := string(PropList[iIndex].Name);
      if SearchArray(Propstoignore ,PropName)>=0 then continue;
      PropValue:= '';
      case PropList[iIndex].PropType^.Kind of
        (* tkEnumeration     : PropValue:= GetPropValue(obj, propName);
        tkInteger,tkInt64 : PropValue:= inttostr(GetInt64Prop(obj,propName));
        tkFloat           : PropValue:= floatToStr(GetFloatProp(obj,propName));
        tkChar,tkString,tkWChar,tkLString,tkWString,tkUString : PropValue:= GetStrProp(obj,propName);
        tkSet,tkMethod,tkVariant,tkArray,tkRecord,tkInterface,tkDynArray, *)
        tkEnumeration,tkInteger,tkInt64,tkFloat,tkChar,tkString,tkWChar,tkLString,tkWString,tkUString : PropValue:= GetPropValue(obj,Propname);
        tkSet,tkMethod,tkVariant,tkArray,tkRecord,tkInterface,tkDynArray,
        tkUnknown         : begin
            val:= GetPropValue(obj, propName);
            if (not VarIsNull(val)) then begin
              PropValue:= val;
            end;
          end;
      end;
      if PropValue <> '' then begin
         PropEntrylist.add(TPropEntry.create);
         TPropEntry(PropEntrylist.items[PropEntrylist.count-1]).PropName := PropName;
         TPropEntry(PropEntrylist.items[PropEntrylist.count-1]).PropValue:= PropValue;
      end;
    end;

    {sub objects}
    for iIndex := 0 to Propcount-1 do begin
      PropName := string(PropList[iIndex].Name);
      if SearchArray(Propstoignore ,PropName)>=0 then continue;
      if PropList[iIndex].PropType^.Kind =tkClass then begin
            PropEntrylist.add(TPropEntry.create);
            TPropEntry(PropEntrylist.items[PropEntrylist.count-1]).PropName := PropName;
            subObj:= GetObjectProp(obj, propName);
            InspectObj(SubObj , PropEntrylist);
        end;
      end;
    end;
end;




function findnode(xNode:TProcTreeNode ; xProcTreeID:Integer):TProcTreeNode;
var
  x:Integer;
begin
  Result := nil;
  if xnode.Children.count =0 then exit;
  for x:= 0 to xnode.Children.Count -1 do begin
    if TProcTreeNode(xnode.Children[x]).ProctreeId = xProctreeId then begin
      REsult :=TProcTreeNode(xnode.Children[x]);
      Exit;
    end;
  end;
end;
Procedure AddAuditEntry(Description:String;fieldName:String='';OldValue:String='';NewValue:String='');
var
  i:Integer;
begin
    i:=0;
   if AuditEntryList.count >0 then i := TAuditEntry(AuditEntryList.items[AuditEntryList.count-1]).Seq;
   AuditEntryList.add(TAuditEntry.Create);
   TAuditEntry(AuditEntryList.items[AuditEntryList.count-1]).Description:=Description;
   TAuditEntry(AuditEntryList.items[AuditEntryList.count-1]).fieldName:=fieldName;
   TAuditEntry(AuditEntryList.items[AuditEntryList.count-1]).OldValue:=OldValue;
   TAuditEntry(AuditEntryList.items[AuditEntryList.count-1]).NewValue:=NewValue;
   TAuditEntry(AuditEntryList.items[AuditEntryList.count-1]).Seq:=i+1;
end;
function Leveled(Text:String;Levelno:Integer):String;
begin
  Result := replicatestr('  ' , Levelno) + text;
end;
function TreeCaption(Node:TProcTreeNode):String;
begin

  if Assigned(Node.Owner) and (Node.Owner is TProcTreeNode) then Result :=TreeCaption(TProcTreeNode(Node.Owner))+'->' +node.Caption
  else REsult := node.caption;
end;
Function AuditTrial(OldNode,NewNode: TProcTreeNode):Boolean;
var
  PropEntrylist1, PropEntrylist2 :TObjectList;
  ctr:Integer;
begin
  REsult := False;;
  PropEntrylist1:= TObjectList.Create(false);
  PropEntrylist2:= TObjectList.Create(false);
  try
    if (newNode  = nil ) and (oldnode<> nil) then begin
      AuditTrialTreeLib.InspectObj(Oldnode ,PropEntrylist1);
      for ctr := 0 to PropEntrylist1.count-1 do
        AddAuditEntry((* Leveled(Oldnode.Caption, Oldnode.Level) *)TreeCaption(OldNode) , TPropEntry(PropEntrylist1.items[ctr]).PropName , TPropentry(PropEntrylist1.items[ctr]).PropValue);
      REsult := true;
    end else if (newNode  <> nil ) and (oldnode= nil) then begin
      AuditTrialTreeLib.InspectObj(NewNode ,PropEntrylist1);
      for ctr := 0 to PropEntrylist1.count-1 do
        AddAuditEntry((* Leveled(NewNode.Caption, NewNode.Level) *)TreeCaption(NewNode) , TPropEntry(PropEntrylist1.items[ctr]).PropName , '', TPropentry(PropEntrylist1.items[ctr]).PropValue);
      REsult := true;
    end else begin
      AuditTrialTreeLib.InspectObj(NewNode ,PropEntrylist1);
      AuditTrialTreeLib.InspectObj(OldNode ,PropEntrylist2);
      for ctr := 0 to PropEntrylist1.count-1 do begin
        if ctr > (PropEntrylist2.Count -1) then begin
          AddAuditEntry(TreeCaption(NewNode) , TPropEntry(PropEntrylist1.items[ctr]).PropName , '', TPropentry(PropEntrylist1.items[ctr]).PropValue);
          result := true;
        end
        else if TPropentry(PropEntrylist1.items[ctr]).PropValue <> TPropentry(PropEntrylist2.items[ctr]).PropValue then begin
          AddAuditEntry(TreeCaption(NewNode) , TPropEntry(PropEntrylist1.items[ctr]).PropName , TPropentry(PropEntrylist2.items[ctr]).PropValue, TPropentry(PropEntrylist1.items[ctr]).PropValue);
          result := true;
        end;
      end;
    end;
  finally
    Freeandnil(PropEntrylist1);
    Freeandnil(PropEntrylist2);
  end;
end;
function AuditChangeDescription:String;
var
  ctr:Integer;
begin
  REsult := '';
  if not(Assigned(AuditEntryList)) then exit;
  for ctr:= 0 to AuditEntryList.count-1 do begin
    if result <> '' then Result := Result + chr(13);
    Result := Result + TAuditEntry(AuditEntryList.items[ctr]).fieldName+
              AuditTrialOldValue + TAuditEntry(AuditEntryList.items[ctr]).OldValue+
              AuditTrialNewValue +TAuditEntry(AuditEntryList.items[ctr]).NewValue;
  end;
end;
Procedure SaveAuditTrial(MasterRef, MasterType,transRef:STring);
var
  ctr:Integer;
  Audit:  TAudit;
begin
  if AuditEntryList.count > 0 then begin
      Audit:= TAudit.Create(nil);
      try
        Audit.Load(0);
        Audit.New;
        Audit.TransType:= MasterType;
        Audit.DataDescription:= 'BOM Tree';
        Audit.AuditDate:= now;
        if transREf <> '' then   Audit.TransGlobalref := TransRef else Audit.TransGlobalref := MasterRef;
        Audit.ChangeDescription:= AuditChangeDescription;
        Audit.PostDB;
        try
            for ctr:= 0 to AuditEntryList.count-1 do begin
              Audit.Lines.New;
              Audit.Lines.AuditId := Audit.ID;
              Audit.Lines.Description     :=TAuditEntry(AuditEntryList.items[ctr]).Description;
              Audit.Lines.fieldName       :=TAuditEntry(AuditEntryList.items[ctr]).fieldName;
              Audit.Lines.OldValue        :=TAuditEntry(AuditEntryList.items[ctr]).OldValue;
              Audit.Lines.NewValue        :=TAuditEntry(AuditEntryList.items[ctr]).NewValue;
              Audit.Lines.Seqno           :=TAuditEntry(AuditEntryList.items[ctr]).Seq;
              Audit.Lines.PostDB;
            end;
            Audit.Save;
        Except
            // kill the exception when ChangeDescription is more than 255 chars
        end;
      finally
        FreeandNil(Audit);
      end;
    end;
end;
Function DoAuditTrial(Clean, current: TProcTreeNode;MasterRef, MasterType:String ;transRef:STring=''):Boolean;
begin
  Result := True;
  AuditEntryList:= TObjectList.Create(false);
  try
    CompareTreeNodes(Clean, Current );
    SAveAuditTrial(MasterRef,Mastertype,transRef);
  finally
    Freeandnil(AuditentryList);
  end;
end;
Function CompareTreeNodes(Clean, Current:TProcTreeNode ):Boolean;
var
  x:Integer;
  currentchild, cleanChild: TProcTreeNode;
begin
 Result:= True;
Try
  if Assigned(Clean) and (not Assigned(Current)) then begin
      AddAuditEntry((* Leveled(clean.Caption, Clean.Level) *)TreeCaption(Clean) + ' - Deleted');
      if AuditTrial(Clean,nil) then result:= false;
  end else if (not(Assigned(Clean))) and Assigned(Current) then begin
      AddAuditEntry((* Leveled(Current.Caption, Current.Level) *)TreeCaption(Current) + ' - Added');
      if AuditTrial(nil,Current) then result:= false;
  end else begin
    if AuditTrial(Clean,Current) then result := False;
  end;

  if Assigned(Current) then begin
    for x:= 0 to Current.Children.Count -1 do begin
      currentchild:= TProcTreeNode(Current.Children[x]);
      if clean = nil then cleanChild :=nil else cleanChild :=findNode(Clean, currentchild.ProcTreeId);
      CompareTreeNodes(cleanChild, currentchild);
    end;
  end;
  if Assigned(Clean) then begin
    for x:= 0 to Clean.Children.Count -1 do begin
      Cleanchild:= TProcTreeNode(Clean.Children[x]);
      if Current = nil then CurrentChild :=nil else CurrentChild :=findNode(Current, Cleanchild.ProcTreeId);
      if CurrentChild = nil then CompareTreeNodes(cleanChild, currentchild);
    end;
  end;
Except
  // ignore exception
End;
end;

end.

