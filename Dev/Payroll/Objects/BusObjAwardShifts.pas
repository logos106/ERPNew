unit BusObjAwardShifts;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/08/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   Tawardshifts = class(TMSBusObj)
   private
      Function GetAwardid              :Integer   ;
      Function GetPayrateid            :Integer   ;
      Function GetStartday             :String    ;
      Function GetStarttime            :TDatetime ;
      Function GetEndday               :String    ;
      Function GetEndtime              :TDatetime ;
      Function GetRate1afterhours      :Double    ;
      Function GetRate1payrate         :Integer   ;
      Function GetRate2afterhours      :Double    ;
      Function GetRate2payrate         :Integer   ;
      Function GetSuperinc             :String    ;
      Procedure SetAwardid              (Const Value :Integer   );
      Procedure SetPayrateid            (Const Value :Integer   );
      Procedure SetStartday             (Const Value :String    );
      Procedure SetStarttime            (Const Value :TDatetime );
      Procedure SetEndday               (Const Value :String    );
      Procedure SetEndtime              (Const Value :TDatetime );
      Procedure SetRate1afterhours      (Const Value :Double    );
      Procedure SetRate1payrate         (Const Value :Integer   );
      Procedure SetRate2afterhours      (Const Value :Double    );
      Procedure SetRate2payrate         (Const Value :Integer   );
      Procedure SetSuperinc             (Const Value :String    );
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;


      Property Awardid               :Integer      Read getAwardid            Write SetAwardid        ;
      Property Payrateid             :Integer      Read getPayrateid          Write SetPayrateid      ;
      Property Startday              :String       Read getStartday           Write SetStartday       ;
      Property Starttime             :TDatetime    Read getStarttime          Write SetStarttime      ;
      Property Endday                :String       Read getEndday             Write SetEndday         ;
      Property Endtime               :TDatetime    Read getEndtime            Write SetEndtime        ;
      Property Rate1afterhours       :Double       Read getRate1afterhours    Write SetRate1afterhours;
      Property Rate1payrate          :Integer      Read getRate1payrate       Write SetRate1payrate   ;
      Property Rate2afterhours       :Double       Read getRate2afterhours    Write SetRate2afterhours;
      Property Rate2payrate          :Integer      Read getRate2payrate       Write SetRate2payrate   ;
      Property Superinc              :String       Read getSuperinc           Write SetSuperinc       ;
   End;


implementation


uses BusObjAwards, CommonLib;


{========================================================
         Tawardshifts
========================================================}
constructor Tawardshifts.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblawardshifts';
end;


destructor Tawardshifts.Destroy;
begin
   inherited;
end;

Function  Tawardshifts.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if Assigned(Self.Owner) then
        if Self.Owner is TAward then
                AwardId := TAward(Self.Owner).Id;
    Result := inherited DoAfterInsert(Sender);
end;


procedure   Tawardshifts.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Awardid');
  SetPropertyFromNode(Node,'Payrateid');
  SetPropertyFromNode(Node,'Startday');
  SetDateTimePropertyFromNode(Node,'Starttime');
  SetDateTimePropertyFromNode(Node,'Endday');
  SetDateTimePropertyFromNode(Node,'Endtime');
  SetPropertyFromNode(Node,'Rate1afterhours');
  SetPropertyFromNode(Node,'Rate1payrate');
  SetPropertyFromNode(Node,'Rate2afterhours');
  SetPropertyFromNode(Node,'Rate2payrate');
  SetPropertyFromNode(Node,'Superinc');
end;


procedure   Tawardshifts.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Awardid' ,Awardid);
      AddXMLNode(node,'Payrateid' ,Payrateid);
      AddXMLNode(node,'Startday' ,Startday);
      AddXMLNode(node,'Starttime' ,Starttime);
      AddXMLNode(node,'Endday' ,Endday);
      AddXMLNode(node,'Endtime' ,Endtime);
      AddXMLNode(node,'Rate1afterhours' ,Rate1afterhours);
      AddXMLNode(node,'Rate1payrate' ,Rate1payrate);
      AddXMLNode(node,'Rate2afterhours' ,Rate2afterhours);
      AddXMLNode(node,'Rate2payrate' ,Rate2payrate);
      AddXMLNode(node,'Superinc' ,Superinc);
end;


function    Tawardshifts.ValidateData :Boolean ;
begin
   if Self.Dataset.RecordCount = 0 then begin //don't force em to have a shift
     Result := True;
     exit;
   end;

   Result := False;
   Resultstatus.Clear;
   if Awardid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Award id should not be 0'  );
      Exit;
   end;
   if Payrateid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Payrate id should not be 0' );
      Exit;
   end;
   if Startday = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Start day should not be blank' );
      Exit;
   end;
   if Starttime = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Start time should not be blank' );
      Exit;
   end;
   if Endday = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'End day should not be blank'  );
      Exit;
   end;
   if Endtime = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'End time should not be blank'  );
      Exit;
   end;
   if Rate1afterhours = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Rate1afterhours should not be 0'  );
      Exit;
   end;
   if Rate1payrate = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Rate1 payrate should not be 0'  );
      Exit;
   end;
   if Rate2afterhours = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Rate2afterhours should not be 0' );
      Exit;
   end;
   if Rate2payrate = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Rate2 payrate should not be 0'  );
      Exit;
   end;
 //  if Superinc = '' then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Superinc should not be blank'  );
//      Exit;
//   end;
   Result := true;
end;


function    Tawardshifts.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure Tawardshifts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Tawardshifts.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function Tawardshifts.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Tawardshifts.GetIDField : String;
begin
   Result := 'Shiftid'
end;

class function Tawardshifts.GetBusObjectTablename: string;
begin
  Result := 'tblawardshifts';
end;


Function  Tawardshifts.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Tawardshifts.GetAwardid        :Integer   ; begin Result := GetIntegerField('Awardid');End;
Function  Tawardshifts.GetPayrateid      :Integer   ; begin Result := GetIntegerField('Payrateid');End;
Function  Tawardshifts.GetStartday       :String    ; begin Result := GetStringField('Startday');End;
Function  Tawardshifts.GetStarttime      :TDatetime ; begin Result := GetDatetimeField('Starttime');End;
Function  Tawardshifts.GetEndday         :String    ; begin Result := GetStringField('Endday');End;
Function  Tawardshifts.GetEndtime        :TDatetime ; begin Result := GetDatetimeField('Endtime');End;
Function  Tawardshifts.GetRate1afterhours:Double    ; begin Result := GetFloatField('Rate1afterhours');End;
Function  Tawardshifts.GetRate1payrate   :Integer   ; begin Result := GetIntegerField('Rate1payrate');End;
Function  Tawardshifts.GetRate2afterhours:Double    ; begin Result := GetFloatField('Rate2afterhours');End;
Function  Tawardshifts.GetRate2payrate   :Integer   ; begin Result := GetIntegerField('Rate2payrate');End;
Function  Tawardshifts.GetSuperinc       :String    ; begin Result := GetStringField('Superinc');End;
Procedure Tawardshifts.SetAwardid        (Const Value :Integer   ); begin SetIntegerField('Awardid'         , Value);End;
Procedure Tawardshifts.SetPayrateid      (Const Value :Integer   ); begin SetIntegerField('Payrateid'       , Value);End;
Procedure Tawardshifts.SetStartday       (Const Value :String    ); begin SetStringField('Startday'        , Value);End;
Procedure Tawardshifts.SetStarttime      (Const Value :TDatetime ); begin SetDatetimeField('Starttime'       , Value);End;
Procedure Tawardshifts.SetEndday         (Const Value :String    ); begin SetStringField('Endday'          , Value);End;
Procedure Tawardshifts.SetEndtime        (Const Value :TDatetime ); begin SetDatetimeField('Endtime'         , Value);End;
Procedure Tawardshifts.SetRate1afterhours(Const Value :Double    ); begin SetFloatField('Rate1afterhours' , Value);End;
Procedure Tawardshifts.SetRate1payrate   (Const Value :Integer   ); begin SetIntegerField('Rate1payrate'    , Value);End;
Procedure Tawardshifts.SetRate2afterhours(Const Value :Double    ); begin SetFloatField('Rate2afterhours' , Value);End;
Procedure Tawardshifts.SetRate2payrate   (Const Value :Integer   ); begin SetIntegerField('Rate2payrate'    , Value);End;
Procedure Tawardshifts.SetSuperinc       (Const Value :String    ); begin SetStringField('Superinc'        , Value);End;


initialization
RegisterClassOnce(Tawardshifts);


end.
