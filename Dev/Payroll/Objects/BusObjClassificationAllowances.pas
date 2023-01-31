unit BusObjClassificationAllowances;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   17/08/07   1.00.01   A.   Initial Version.
   }

interface

uses BusObjBase, DB, Classes, BusObjAllowances, XMLDoc, XMLIntf;

type
   Tclassificationallowances = class(TMSBusObj)
   private
      fAllowance: TAllowance;
      Function GetClassificationid      :Integer   ;
      Function GetAllowid               :Integer   ;
      Function GetAmount                :Double    ;
      Function GetCalcby                :String   ;
      Function GetBasedonid             :Integer   ;
      Function GetAwardid               :Integer   ;
      Procedure SetClassificationid      (Const Value :Integer   );
      Procedure SetAllowid               (Const Value :Integer   );
      Procedure SetAmount                (Const Value :Double    );
      Procedure SetCalcby                (Const Value :String   );
      Procedure SetBasedonid             (Const Value :Integer   );
      Procedure SetAwardid               (Const Value :Integer   );
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
      Function  DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;           Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      procedure    AddAllowanceDetails;

      Property Classificationid       :Integer      Read getClassificationid    Write SetClassificationid;
      Property Allowid                :Integer      Read getAllowid             Write SetAllowid         ;
      Property Amount                 :Double       Read getAmount              Write SetAmount          ;
      Property Calcby                 :String       Read getCalcby              Write SetCalcby          ;
      Property Basedonid              :Integer      Read getBasedonid           Write SetBasedonid       ;
      Property Awardid                :Integer      Read getAwardid             Write SetAwardid         ;
   End;

implementation


uses BusObjAwardClassificationDetail,SysUtils,BusObjConst, CommonLib;


{========================================================
         Tclassificationallowances
========================================================}
constructor Tclassificationallowances.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblclassificationallowances';
   fAllowance := TAllowance.Create(Self);
end;


destructor Tclassificationallowances.Destroy;
begin
   inherited;
end;

Function  Tclassificationallowances.DoBeforeInsert(Sender :TDatasetBusObj ):Boolean;
begin
  Result := inherited DoBeforeInsert(Sender);
  if not ValidateData then begin
    SendEvent(BusobjEventVal_HandleIncompleteRecord,BusObjEvent_Change );
    Abort;
  end;
end;

procedure   Tclassificationallowances.AddAllowanceDetails;
begin
  try
    fAllowance.Load(AllowID);
    Amount := fAllowance.Amount;
    CalcBy := fAllowance.Calcby;
    BasedOnID := fAllowance.Basedonid;  
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

Function  Tclassificationallowances.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is Tawardclassificationdetails then begin
          ClassificationId := Tawardclassificationdetails(Self.Owner).Id;
          AwardID :=  Tawardclassificationdetails(Self.Owner).Awardid;
        end;
    Result := inherited DoAfterInsert(Sender);
end;

procedure   Tclassificationallowances.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Classificationid');
  SetPropertyFromNode(Node,'Allowid');
  SetPropertyFromNode(Node,'Amount');
  SetPropertyFromNode(Node,'Calcby');
  SetPropertyFromNode(Node,'Basedonid');
  SetPropertyFromNode(Node,'Awardid');
end;


procedure   Tclassificationallowances.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Classificationid' ,Classificationid);
  AddXMLNode(node,'Allowid' ,Allowid);
  AddXMLNode(node,'Amount' ,Amount);
  AddXMLNode(node,'Calcby' ,Calcby);
  AddXMLNode(node,'Basedonid' ,Basedonid);
  AddXMLNode(node,'Awardid' ,Awardid);
end;


function    Tclassificationallowances.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin //don't force em to have an allowance
     Result := True;
     exit;
   end;

   Result := False;
   Resultstatus.Clear;
//   if Classificationid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Classificationid should not be 0' );
//      Exit;
//   end;
   if Allowid = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationAllowance_Err_NoAllowance,  'Allowance should not be blank'  );
      Exit;
   end;
   if Amount = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationAllowance_Err_NoAmount,  'Amount should not be 0'  );
      Exit;
   end;
   if Basedonid = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_ClassificationAllowance_Err_NoBasedOn,  'Based on should not be blank'  );
      Exit;
   end;
//   if Awardid = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Awardid should not be 0'  );
//      Exit;
//   end;
   Result := true;
end; 

function    Tclassificationallowances.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tclassificationallowances.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tclassificationallowances.DoFieldOnChange(Sender: TField);
begin
   inherited;
   if Sysutils.SameText(Sender.FieldName , 'AllowID') then begin
     AddAllowanceDetails;
   end;
end;


Function Tclassificationallowances.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tclassificationallowances.GetIDField : String;
begin
   Result := 'Allowanceid'
end;

class function Tclassificationallowances.GetBusObjectTablename: string;
begin
  Result := 'tblclassificationallowances';
end;

Function  Tclassificationallowances.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tclassificationallowances.GetClassificationid:Integer   ; begin Result := GetIntegerField('Classificationid');End;
Function  Tclassificationallowances.GetAllowid         :Integer   ; begin Result := GetIntegerField('Allowid');End;
Function  Tclassificationallowances.GetAmount          :Double    ; begin Result := GetFloatField('Amount');End;
Function  Tclassificationallowances.GetCalcby          :String   ; begin Result := GetStringField('Calcby');End;
Function  Tclassificationallowances.GetBasedonid       :Integer   ; begin Result := GetIntegerField('Basedonid');End;
Function  Tclassificationallowances.GetAwardid         :Integer   ; begin Result := GetIntegerField('Awardid');End;
Procedure Tclassificationallowances.SetClassificationid(Const Value :Integer   ); begin SetIntegerField('Classificationid' , Value);End;
Procedure Tclassificationallowances.SetAllowid         (Const Value :Integer   ); begin SetIntegerField('Allowid'          , Value);End;
Procedure Tclassificationallowances.SetAmount          (Const Value :Double    ); begin SetFloatField('Amount'           , Value);End;
Procedure Tclassificationallowances.SetCalcby          (Const Value :String   ); begin SetStringField('Calcby'           , Value);End;
Procedure Tclassificationallowances.SetBasedonid       (Const Value :Integer   ); begin SetIntegerField('Basedonid'        , Value);End;
Procedure Tclassificationallowances.SetAwardid         (Const Value :Integer   ); begin SetIntegerField('Awardid'          , Value);End;


initialization
RegisterClassOnce(Tclassificationallowances);


end.
