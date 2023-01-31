unit ExportRepairsObj;

interface

Uses classes, IntegerListObj,BusObjBase;

type
  TExportRepairsObj = class(Tcomponent)
    Private
      fsRepairIds: String;
      RepairIdList :TIntegerList;
      RepairsLocked:boolean;
      procedure SetRepairIds(const Value: String);
      Procedure FlagRepairs;
      Procedure lockrepairs(Const Sender: TBusObj; var Abort: boolean);
      Procedure flagDetailExported(Const Sender: TBusObj; var Abort: boolean);
    Public
      Property RepairIDs:String Read fsRepairIds Write SetRepairIds;
      constructor Create(AOwner:Tcomponent); override;
      Destructor Destroy; Override;
      Function ExportData(const Filename:String):String;

  end;
implementation

uses Dialogs, FastFuncs, CommonDbLib, SysUtils, CommonLib, busobjrepairs,
  BusobjRepairsExportConfig, tcDataUtils;

{ TExportRepairsObj }

constructor TExportRepairsObj.Create(AOwner: Tcomponent);
begin
  inherited;
  fsRepairIds :='';
  RepairIdList :=TIntegerList.create;
end;

destructor TExportRepairsObj.Destroy;
begin
  Freeandnil(RepairIdList);
  inherited;
end;

function TExportRepairsObj.ExportData(const Filename:String):String;
var
  strSQL:String;
  Exportfields :Array of Array of String;
  I, x:Integer;
  MaxCols :Integer;
  DataLine :String;
  Exportfilename:String;
  F: TextFile;
  Records:Integer;
  Totalcols:Integer;
  SaveDialog1: TSaveDialog;

  Procedure AddParts(const Repairno:Integer);
  begin
      strSQL:= 'SELECT ' +
              ' RP.PartName, ' +
              ' RP.Qty, ' +
              ' SL.SaleID ' +
              ' FROM ' +
              ' tblrepairparts AS RP ' +
              ' Left Join tblsaleslines SL ON RP.InvoiceLineRef = SL.GlobalRef'+
              ' WHERE RP.RepairID = ' + IntToStr(Repairno) ;
      with CommonDbLib.TempMyQuery do try
        Sql.add(strSQL);
        open;
        if recordcount > 0 then begin
               First;
               while Eof = False do begin
                if MaxCols+3 > Totalcols then begin
                   Setlength(Exportfields[0], Totalcols+3);
                   Setlength(Exportfields[1], Totalcols+3);
                   Setlength(Exportfields[2], Totalcols+3);
                   Totalcols := Totalcols +3;
                end;
                   Exportfields[0,MaxCols+0]:= 'Part Number'         ;Exportfields[1,MaxCols+0]:= 'PartName'      ;Exportfields[2,MaxCols+0]:= Fieldbyname('PartName').asString;
                   Exportfields[0,MaxCols+1]:= 'Part Qty'            ;Exportfields[1,MaxCols+1]:= 'Qty'           ;Exportfields[2,MaxCols+1]:= Fieldbyname('Qty').asString;
                   Exportfields[0,MaxCols+2]:= 'Part Invoice Number' ;Exportfields[1,MaxCols+2]:= 'SaleId'        ;Exportfields[2,MaxCols+2]:= Fieldbyname('SaleID').asString;
                   MaxCols:= MaxCols +3;
                   Next;
               end;
        Next;
        end;
      finally
        if active then close;
        free;
      end;
  end;
  Function ManufacturedateFormat(Const REpairNo:Integer):String;
  begin
    result := tcdatautils.ManufacturedateFormat(REpairNo);
         if Sysutils.SameText(result , 'DDMMYYYY')   then result := '%d%m%Y'
    else if Sysutils.SameText(result , 'MMDDYYYY')   then result := '%m%d%Y'
    else if Sysutils.SameText(result , 'YYYYMMDD')   then result := '%Y%m%d'
    else if Sysutils.SameText(result , 'DD-MM-YYYY') then result := '%d-%m-%Y'
    else if Sysutils.SameText(result , 'MM-DD-YYYY') then result := '%m-%d-%Y'
    else if Sysutils.SameText(result , 'YYYY-MM-DD') then result := '%Y-%m-%d';
    REsult := QuotedStr(Result);
  end;
  Procedure AddEquipments(Const REpairNo:Integer);
  var
    ctr:Integer;
  begin
      MaxCols:= 36(*33*);
      strSQL:= 'SELECT r.RepairID,  ' +
              ' RD.GSFSReceiptNo, ' +
              ' R.RepairID ClaimNo, ' +
              ' RD.Model, ' +
              ' RD.Serialno, ' +
              ' C.Company, ' +
              ' concat_WS(" " , C.Street,C.Street2,C.Street3)as Address, ' +
              ' C.Suburb as City, ' +
              ' C.State , ' +
              ' C.Postcode, ' +
              ' R.Phone, ' +
              ' Date_Format(RD.ManInvDate,'+ManufacturedateFormat(REpairNo)+') as DateofPurchase, ' +
              ' Date_Format(R.CreationDate,'+ManufacturedateFormat(REpairNo)+') as RepairReceiptdate, ' +
              ' DateDiff((Select Date_Format(min(AppDate),'+ManufacturedateFormat(REpairNo)+')  from tblappointments RA  where RA.RepairID = RE.RepairID) , R.CreationDate) as CustomerDelay , ' +
              ' (Select Date_Format(min(AppDate),'+ManufacturedateFormat(REpairNo)+')  from tblappointments RA  where RA.RepairID = RE.RepairID)  AppDate , ' +
              ' (Select Date_Format(min(AppDate),'+ManufacturedateFormat(REpairNo)+')  from tblappointments RA  where RA.RepairID = RE.RepairID) as ScheduleDate, ' +
              ' (Select Date_Format(min(Actual_Appdate),'+ManufacturedateFormat(REpairNo)+')  from tblappointments RA  where RA.RepairID = RE.RepairID) as StartDate, ' +
              ' (Select Date_Format(max(Actual_Endtime),'+ManufacturedateFormat(REpairNo)+')  from tblappointments RA  where RA.RepairID = RE.RepairID) as EndDate, ' +
              ' RD.FaultConditionCode, ' +
              ' RD.FaultSymptomcode, ' +
              ' RD.FaultDefectCode, ' +
              ' RD.FaultRepairCode, ' +
              ' RD.FaultSectionCode, ' +
              ' Sum(T.Total)  Labourcost, ' +
              ' (Select Sum(totalInc) from tblappointments RA  where RA.RepairID = RE.RepairID) as ApptAmount, ' +
              ' RD.Materialcost, ' +
              ' RD.Freightcost, ' +
              ' RD.Otheramount, ' +
              ' RD.Servicetype, ' +
              ' RD.Authorisationnumber, ' +
              ' RD.AscClaimRemarks, ' +
              ' R.FeedbackNotes, Re.Quantity,  ' +
              'if(ifnull(P.PARTNAME,"") ="" , E.EquipmentName,P.PartName) as Partname,  ' +
              'RD.ManInvNo' +
              ' FROM ' +
              ' tblrepairs AS R ' +
              ' INNER JOIN tblequipmentxref  AS RE ON R.RepairID         = RE.RepairID ' +
              ' LEFT  JOIN tblcustomerequip  AS CE ON CE.Id              = RE.CustomerEquipmentId ' +
              ' LEFT  JOIN tblEquipment      AS E  ON E.EquipmentId      = CE.EquipmentId ' +
              ' LEFT  JOIN tblParts          AS P  ON P.PartsId          = E.ProductID ' +
              ' LEFT  JOIN tblrepairdetails  AS RD ON RE.RepairID        = RD.RepairID ' +
              ' LEFT  JOIN tblclients        AS C  ON R.CusID            = C.ClientID ' +
              ' LEFT  JOIN tblTimesheetentry AS TE ON TE.TypeID          = RE.RepairID         and TE.Type =  "Repair" ' +
              ' LEFT  JOIN tbltimesheets     AS T  ON T.TimeSheetEntryId = TE.timesheetEntryID and T.CustomerEquipmentID = RE.CustomerEquipmentID ' +
              ' WHERE R.RepairID = ' + IntToStr(RepairNo) +
              ' group by RE.ID ' ;

      with CommonDbLib.TempMyQuery do try
        Sql.add(strSQL);
        open;

        if recordcount >0 then begin
          First;
          While Eof = False do begin
            Records := Records +1;
            Setlength(Exportfields , 3 +Records);
            Setlength(Exportfields[2 +Records] , Totalcols);
            for ctr := Low(Exportfields[0]) to high(Exportfields[0]) do begin
              Exportfields[2 +Records,ctr] := '';
               if Exportfields[1,ctr]<> '' then
                if findfield(Exportfields[1,ctr]) <> nil then
                  Exportfields[2 +Records,ctr] := fieldByname(Exportfields[1,ctr]).asString;
            end;
            AddParts(FieldByname('RepairID').asInteger);
           Next;
          end;
        end;
      finally
        if active then close;
        free;
      end;
  end;
  Procedure SetFieldnames;
  var
    ctr,x:Integer;
  begin
    Setlength(Exportfields , 3 );
    Setlength(Exportfields[0] , 36(*33*) );
    Setlength(Exportfields[1] , 36(*33*));
    Setlength(Exportfields[2] , 36(*33*));
    With TRepairsExportConfig.create(Self) do try
      loadForManufacture(  Repairmanufacure(RepairIdList[i]));
      for ctr:= 1 to 36 do begin
         for x:= 1 to 36 do begin
            if Dataset.fieldbyname('F' +Trim(IntToStr(x)) +'Order').asInteger = ctr then begin
              Exportfields[0, ctr-1]:= Dataset.fieldbyname('F' +Trim(IntToStr(x))).asString;
              if (Dataset.fieldbyname('ShowF' +Trim(IntToStr(x))).asString <> 'F') and
                 (Dataset.fieldbyname('F' +Trim(IntToStr(x))+'Order').AsInteger <> 0) then
                 Exportfields[2, ctr-1]:= 'T' else Exportfields[2, ctr-1]:= 'F';
              (*Exportfields[2, ctr-1]:= Dataset.fieldbyname('ShowF' +Trim(IntToStr(x))).asString;*)
                   if x = 1 then Exportfields[1, ctr-1]:= 'GSFSReceiptNo'
              else if x = 2 then Exportfields[1, ctr-1]:= 'ClaimNo'
              else if x = 3 then Exportfields[1, ctr-1]:= 'Model'
              else if x = 4 then Exportfields[1, ctr-1]:=  ''
              else if x = 5 then Exportfields[1, ctr-1]:= 'Serialno'
              else if x = 6 then Exportfields[1, ctr-1]:=  ''
              else if x = 7 then Exportfields[1, ctr-1]:=  'Company'
              else if x = 8 then Exportfields[1, ctr-1]:=  'Address'
              else if x = 9 then Exportfields[1, ctr-1]:=  'City'
              else if x = 10 then Exportfields[1, ctr-1]:=  'State'
              else if x = 11 then Exportfields[1, ctr-1]:=  'Postcode'
              else if x = 12 then Exportfields[1, ctr-1]:=  'Phone'
              else if x = 13 then Exportfields[1, ctr-1]:=  'DateofPurchase'
              else if x = 14 then Exportfields[1, ctr-1]:=  'RepairReceiptdate'
              else if x = 15 then Exportfields[1, ctr-1]:=  'AppDate'
              else if x = 16 then Exportfields[1, ctr-1]:=  'StartDate'
              else if x = 17 then Exportfields[1, ctr-1]:=  'EndDate'
              else if x = 18 then Exportfields[1, ctr-1]:=  ''
              else if x = 19 then Exportfields[1, ctr-1]:=  'FaultConditionCode'
              else if x = 20 then Exportfields[1, ctr-1]:= 'FaultSymptomcode'
              else if x = 21 then Exportfields[1, ctr-1]:= 'FaultDefectCode'
              else if x = 22 then Exportfields[1, ctr-1]:= 'FaultRepairCode'
              else if x = 23 then Exportfields[1, ctr-1]:= 'FaultSectionCode'
              else if x = 24 then Exportfields[1, ctr-1]:= 'Labourcost'
              else if x = 25 then Exportfields[1, ctr-1]:= 'ApptAmount'
              else if x = 26 then Exportfields[1, ctr-1]:= 'Materialcost'
              else if x = 27 then Exportfields[1, ctr-1]:= 'Freightcost'
              else if x = 28 then Exportfields[1, ctr-1]:= 'Otheramount'
              else if x = 29 then Exportfields[1, ctr-1]:=  'Servicetype'
              else if x = 30 then Exportfields[1, ctr-1]:= 'Authorisationnumber'
              else if x = 31 then Exportfields[1, ctr-1]:= 'AscClaimRemarks'
              else if x = 32 then Exportfields[1, ctr-1]:= ''
              else if x = 33 then Exportfields[1, ctr-1]:= ''
              else if x = 34 then Exportfields[1, ctr-1]:= 'PARTNAME'
              else if x = 35 then Exportfields[1, ctr-1]:= 'Quantity'
              else if x = 36 then Exportfields[1, ctr-1]:= 'ManInvNo'           ;
            end;
         end;
      end;
    finally
        Free;
    end;
    Totalcols := 36(*33*);
  end;
begin
  try
    SaveDialog1:= TSaveDialog.create(Self);
    SaveDialog1.DefaultExt := 'pdi';
    SaveDialog1.Filter := 'ERP Data Import (*.pdi)|*.pdi|All Files (*.*)|*.*';
    SaveDialog1.filename :=Filename;
    
    if not SaveDialog1.Execute then Exit;

    Exportfilename := SaveDialog1.FileName;
  finally
      Freeandnil(SaveDialog1);
  end;
  if not (DirectoryExists(ExtractFileDir(Exportfilename))) then Exit;

    try
      Records := 0;

      for i := 0 to RepairIdList.Count -1 do begin
        if i = 0 then SetfieldNames;
        AddEquipments(RepairIdList[i]);
      end;
      {$I-}
      AssignFile(F, ExportFileName);
      Rewrite(F);
      IOResult;
      DataLine:= Exportfields[0,0];
      for i := Low(Exportfields[0])+1 to high(Exportfields[0]) do begin
        if Exportfields[2,i] ='T' then begin
          DataLine:= DataLine + ',' + Exportfields[0,i];
        end;
      end;
      Writeln(F, DataLine);
      if high(exportfields) >= 3 then
        for x := 3 to high(exportfields) do begin
          DataLine:= Exportfields[x,0];
          for i := Low(Exportfields[x])+1 to high(Exportfields[x]) do begin
            if Exportfields[2,i] ='T' then
              DataLine:= DataLine + ',' + Exportfields[x,i];
          end;
          Writeln(F, DataLine);
        end;
      IOResult;
      Flush(F);
      CloseFile(F);
      IOResult;
      {$I+}
      result :=Exportfilename;
      FlagRepairs;
    except
        on E:Exception do begin
            CommonLib.MessageDlgXP_Vista('Export Failed' + chr(13) +e.Message, mtWarning, [mbok],0);
        end;
    end;
end;

procedure TExportRepairsObj.flagDetailExported(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (sender is TRepairs) then exit;
  TRepairs(Sender).DetailsExported:= true;
  TRepairs(Sender).PostDB;
end;

procedure TExportRepairsObj.FlagRepairs;
var
  RepairsObj:TRepairs;
begin
  RepairsObj:=TRepairs.create(Self);
  try
    RepairsObj.connection := TMyDacDataConnection.Create(RepairsObj);
    RepairsObj.Connection.Connection := GetNewMyDacConnection(RepairsObj);
    RepairsObj.Loadselect('repairId in (' + fsRepairIds+')');
    if RepairsObj.count = 0 then exit;
    RepairsLocked := true;
    RepairsObj.iteraterecords(lockrepairs);
    if RepairsLocked then begin
    RepairsObj.Connection.BeginTransaction;
    try
      RepairsObj.iteraterecords(flagDetailExported);
      RepairsObj.Connection.CommitTransaction;
    except
        on E:Exception do begin
            RepairsObj.Connection.RollbackTransaction;
        end;
    end;
    end;
  finally
      freeandnil(RepairsObj);
  end;
end;

procedure TExportRepairsObj.lockrepairs(const Sender: TBusObj;  var Abort: boolean);
begin
  if not (sender is TRepairs) then exit;
  if not TRepairs(Sender).Lock('ExportingDetials') then
    RepairsLocked:= False;
end;

procedure TExportRepairsObj.SetRepairIds(const Value: String);
begin
  fsRepairIds := Value;
  RepairIdList.commatext := Value;  
end;

end.
