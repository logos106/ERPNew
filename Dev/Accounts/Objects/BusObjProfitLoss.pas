unit BusObjProfitLoss;
  {
   Date     Version  Who    What
  -------- -------- ------  ------------------------------------------------------
  24/03/22  1.00.00  Jacob  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, JsonObject, JsonToObject;


type
  TMoveModule = (mmUp=1, mmDown=2);


type
  TProfitLossLayout = class(TMSBusObj)

  private

    fbUp : Boolean;

    fsLayoutToUse : string;

    fsDirection : string;
    fsSteps : string;

    fsAccount : string;
    fsGroup : string;
    fsLevel : string;

    fsLevel0Group : string;
    fsLevel1Group : string;
    fsLevel2Group : string;


    level0GroupsOrders : TStringList;
    level1GroupsOrders : TStringList;
    level2GroupsOrders : TStringList;

//    iPosition : Integer;

    function GetRowID              : Integer   ;

    function GetParent              : Integer   ;

    function GetPos                 : string    ;
    function GetName                : string    ;

    function GetLevel2GroupName      : string;
    function GetLevel1GroupName      : string;
    function GetLevel0GroupName      : string;

    function  GetPosition      : Integer   ;

    function GetLevel0Order         : Integer   ;
    function GetLevel1Order         : Integer   ;
    function GetLevel2Order         : Integer   ;
    function GetLevel3Order         : Integer   ;

    function GetIsAccount           : Boolean   ;
    function GetIsRoot              : Boolean   ;
    function GetAccountID           : Integer   ;
    function GetLayoutID            : Integer   ;

 //   function GetUp              : Boolean   ;


    procedure SetRowID              (const Value: Integer   );

    procedure SetParent              (const Value: Integer   );

    procedure SetPos                 (const Value: string    );
    procedure SetName                (const Value: string    );

    procedure SetLevel0Order         (const Value: Integer   );
    procedure SetLevel1Order         (const Value: Integer   );
    procedure SetLevel2Order         (const Value: Integer   );
    procedure SetLevel3Order         (const Value: Integer   );

    procedure SetIsAccount           (const Value: Boolean   );
    procedure SetIsRoot              (const Value: Boolean   );
    procedure SetAccountID           (const Value: Integer   );
    procedure SetLayoutID            (const Value: Integer   );

 //   procedure SetUp              (const Value: Boolean   );

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

    procedure AssignParams(params: TJsonObject; id : Integer);

    procedure SaveLayout(RequestJson : TJsonObject);


    function GetLayoutToUse : Integer;
    procedure SetLayoutToUse (layoutToUse : Integer) ;

     procedure MoveLine(direction: TMoveModule; Seqnofieldname: String);

     function GetLevel0Groups : TStringList;
     function GetLevel1Groups : TStringList;
      function GetLevel2Groups : TStringList;

    function GetLevel0Group(level0Order : Integer) : String;
    function GetLevel1Group(level0Order : Integer; level1Order : Integer) : String;


    procedure MoveAccountToLevel0Group(accountID : string; groupName : string);
    procedure MoveAccountToLevel1Group(accountID : string; groupName : string);
    procedure MoveAccountToLevel2Group(accountID : string; groupName : string);

    procedure CreateNewGroup(groupName : string);
    procedure CreateNewLevel0Group(groupName : string);
    procedure CreateNewLevel1Group(groupName : string ; level0Group : string);
    procedure CreateNewLevel2Group(groupName : string; level1Group : string);

  published

    property ID               :Integer     read GetRowID             write SetRowID          ;

    property Parent               :Integer     read GetParent             write SetParent          ;
    property Pos                  :string      read GetPos                write SetPos             ;

    property AccountName          :string      read GetName               write SetName            ;
    property AccountLevel2GroupName          :string      read GetLevel2GroupName                           ;
    property AccountLevel1GroupName          :string      read GetLevel1GroupName                  ;
    property AccountLevel0GroupName          :string      read GetLevel0GroupName                           ;


    property Position             : Integer      read GetPosition                         ;

    property Level0Order          :Integer     read GetLevel0Order        write SetLevel0Order     ;
    property Level1Order          :Integer     read GetLevel1Order        write SetLevel1Order     ;
    property Level2Order          :Integer     read GetLevel2Order        write SetLevel2Order     ;
    property Level3Order          :Integer     read GetLevel3Order        write SetLevel3Order     ;

    property IsAccount            :Boolean     read GetIsAccount          write SetIsAccount       ;
    property IsRoot               :Boolean     read GetIsRoot             write SetIsRoot          ;
    property AccountID            :Integer     read GetAccountID          write SetAccountID       ;
    property LayoutID             :Integer     read GetLayoutID           write SetLayoutID        ;


    property LayoutToUse      : String    read fsLayoutToUse    write fsLayoutToUse   ;

    property Up            :Boolean     read fbUp          write fbUp       ;

    property Direction        : string     read fsDirection          write fsDirection       ;
    property Steps            : string     read fsSteps          write fsSteps       ;

    property Account          : string     read fsAccount          write fsAccount       ;
    property Group            : string     read fsGroup          write fsGroup       ;
    property Level            : string     read fsLevel          write fsLevel       ;

    property Level0Group      : string     read fsLevel0Group          write fsLevel0Group       ;
    property Level1Group      : string     read fsLevel1Group          write fsLevel1Group       ;
    property Level2Group      : string     read fsLevel2Group          write fsLevel2Group       ;

  end;






implementation


uses tcDataUtils, CommonLib, SysUtils, MyAccess, ErpDBComponents, AppEnvironmentVirtual, Dialogs, ClipBrd;

{ Tpnllayoutdata }

constructor TProfitLossLayout.Create(AOwner: TComponent);
var
    qryTemp: TERPQuery;

   k : Integer;
   iLevel : Integer;
   test: Boolean;

begin
   inherited Create(AOwner);
   fBusObjectTypeDescription := 'pnllayoutdata';


   test := true;

   if test then
   begin

//      fSQL := 'SELECT (@row_number := @row_number + 1) AS position, tblpnllayoutdata.* FROM tblpnllayoutdata, (SELECT @row_number := 0) AS t';

      fSQL := 'SELECT * FROM tblpnllayoutdata, tblpnllayouts';

      fSQL := fSQL +  ' WHERE tblpnllayouts.LayoutID = tblpnllayoutdata.LayoutID AND tblpnllayouts.IsCurrentLayout = "T" ';

      fSQLOrder := 'Level0Order, IsLevel0Total, Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total';

//      fSQL := 'SELECT * FROM tblpnllayoutdata';
//      fSQLOrder := 'Level0Order, Level1Order, Level2Order, Level3Order';

//      qryMain.SQL.Add(' ORDER BY Level0Order, IsLevel0Total, Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total');

//      fSQLOrder := 'LEFT(Pos, 2), Level1Order, Level2Order, Level3Order';
//      fSQLOrder := 'OrderNr';

   end
   else
   begin
     // Get max level

    qryTemp := TERPQuery.Create(nil);
   qryTemp.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);


  with qryTemp do begin
   // SQL.Clear;
    SQL.Text := 'SELECT (MAX(LENGTH(Pos)) DIV 2) AS MLevel FROM tblPnLLayoutData ld';
    SQL.Text := SQL.Text + ' LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID';
    SQL.Text := SQL.Text + ' WHERE ls.LayoutID=' + IntToStr(LayoutID);

    ClipBoard.AsText := SQL.Text;

    Open;

    iLevel := FieldByName('MLevel').AsInteger;
  end;


    //  fSQL.Clear;
      fSQL := 'SELECT (@row:=@row + 1) AS No, ID, Pos, Parent, IsRoot,';
      for k := 1 to iLevel - 1 do
      begin
         fSQL := fSQL + ' IF(LENGTH(Pos) = ' + IntToStr(k * 2) + ', `Name`, "") AS Level' +
           IntToStr(K) + ',';
      end;
      fSQL := fSQL + ' IF(LENGTH(Pos) = ' + IntToStr(k * 2) + ', `Name`, "") AS Level' + IntToStr(iLevel);
      fSQL := fSQL + ' FROM tblPnLLayoutData ld, (SELECT @row:=0) Dummy,';
      fSQL := fSQL + ' tblPnLLayouts ls WHERE ld.LayoutID=ls.LayoutID';
      fSQL := fSQL + ' AND ld.LayoutID=' + IntToStr(LayoutID);


      fSQLOrder := 'Pos';

     // ClipBoard.AsText := fSQL;

         fsLayoutToUse := '';

    fsDirection := '';
    fsSteps := '';

    fsAccount := '';
    fsGroup := '';
    fsLevel := '';


     fsLevel0Group := '';
     fsLevel1Group := '';
     fsLevel2Group := '';

   end;

end;


destructor TProfitLossLayout.Destroy;
begin
  inherited;
end;



procedure TProfitLossLayout.AssignParams(params: TJsonObject; id : Integer);
var

   level0Groups : TStringList;
   level1Groups : TStringList;
   level2Groups : TStringList;

   i , nSteps : Integer;

begin
   try

  // ShowMessage(params.ToString);

    LocateId(id);


   fbUp := params.B['Up'];

      // set layout to use for report
      fsLayoutToUse :=  params.S['LayoutToUse'];

      if not (fsLayoutToUse = '') then
      begin

         SetLayoutToUse(StrToInt(fsLayoutToUse));
      end;


      // move an account up or down
      fsDirection := params.S['Direction'];
      fsSteps := params.S['Steps'];


  //    ShowMessage('direction ' + fsDirection + '   steps ' + fsSteps);

    //  JsonToObj(params, self);

   //   if fbUp then
      if fsDirection = 'Up' then
      begin
    //     ShowMessage(' TProfitLossLayout  up  ' );
         if fsSteps = '' then
         begin
            MoveLine(mmUp, 'OrderNr');
         end
         else
         begin
           nSteps := StrToInt(fsSteps);


           for i := 1 to nSteps do
           begin
               LocateId(id);

               MoveLine(mmUp, 'OrderNr');
           end;
         end;
      end
      else if fsDirection = 'Down' then
      begin
     //    ShowMessage(' TProfitLossLayout  down  ' );
         if fsSteps = '' then
         begin
            MoveLine(mmDown, 'OrderNr');
         end
         else
         begin
            nSteps := StrToInt(fsSteps);

           for i := 1 to nSteps do
           begin
               LocateId(id);

               MoveLine(mmDown, 'OrderNr');
           end;
         end;
     end;


      // move an account to a group
      fsAccount := params.S['Account'];
      fsGroup := params.S['Group'];
      fsLevel := params.S['Level'];


      if not (fsAccount = '') and not (fsGroup = '') and not (fsLevel = '') then
      begin

    //     ShowMessage('moving account ' + fsAccount + '  to group ' + fsGroup);

         if fsLevel = '0' then
            MoveAccountToLevel0Group(fsAccount, fsGroup)
         else if fsLevel = '1' then
            MoveAccountToLevel1Group(fsAccount, fsGroup)
         else if fsLevel = '2' then
            MoveAccountToLevel2Group(fsAccount, fsGroup);

      end;


      // create a new group
      fsLevel0Group := params.S['Level0Group'];
      fsLevel1Group := params.S['Level1Group'];
      fsLevel2Group := params.S['Level2Group'];



      if not (fsLevel0Group = '') then
      begin

        level0Groups := GetLevel0Groups;

        if level0Groups.IndexOf(fsLevel0Group) < 0 then     // create new group
        begin

            CreateNewLevel0Group(fsLevel0Group);

        end;

      end;


      if not (fsLevel1Group = '') and not (fsLevel0Group = '') then
      begin

        level1Groups := GetLevel1Groups;

        if level1Groups.IndexOf(fsLevel1Group) < 0 then     // create new group
        begin

            CreateNewLevel1Group(fsLevel1Group, fsLevel0Group);

        end;

      end;


      if not (fsLevel2Group = '') and not (fsLevel1Group = '') then
      begin


        level2Groups := GetLevel2Groups;


        if level2Groups.IndexOf(fsLevel2Group) < 0 then     // create new group
        begin

            CreateNewLevel2Group(fsLevel2Group, fsLevel1Group);

        end;

      end;


   except
      on E: Exception do
      begin
        // Errormsg := E.Message;
         ShowMessage(E.Message);
      end;

   end;
end;



procedure TProfitLossLayout.SaveLayout(RequestJson: TJsonObject);
var
   layoutArray: TJSONArray;
   layoutArray1: TJSONArray;
   layoutArray2: TJSONArray;
   layoutArray3: TJSONArray;

   layoutObject: TJsonObject;
   layoutObject1: TJsonObject;
   layoutObject2: TJsonObject;
   layoutObject3: TJsonObject;

   i, j, k, l, m, n, o: Integer;

   AccountName : string;

   Level0Group : string;
   Level1Group : string;
   Level2Group : string;
   Level3Account : string;

   qryInsert : TERPQuery;
   insertSQL : string;

   Level0Order : Integer;
   Level1Order : Integer;
   Level2Order : Integer;
   Level3Order : Integer;

begin

   // ShowMessage( '  RequestJson ' +  RequestJson.AsString);


   // ShowMessage(RequestJson.O['JsonIn'].A['layout'].ClassName);

 //  Self.Connection.BeginTransaction;
   qryInsert := TERPQuery.Create(nil);
   qryInsert.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

    insertSQL := 'DELETE tblpnllayoutdata FROM tblpnllayoutdata, tblpnllayouts  '
       +  ' WHERE tblpnllayouts.LayoutID = tblpnllayoutdata.LayoutID AND tblpnllayouts.IsCurrentLayout = "T" ';

//               ShowMessage(insertSQL) ;


   qryInsert.SQL.Text := insertSQL;
   qryInsert.Execute;


   layoutArray := RequestJson.o['JsonIn'].A['layout'];

   Level0Order := 0;
    Level1Order := 0;
   Level2Order := 0;


   for i := 0 to layoutArray.Count - 1 do
   begin
      // ShowMessage('array item ' + layoutArray.Items[i].ClassName);

      // ShowMessage(layoutArray.Items[i].AsString);

      layoutObject := layoutArray.Items[i].AsObject;

      // ShowMessage('accountType ' + layoutObject.StringByName['accountType']);


      for j := 0 to layoutObject.Count - 1 do
      begin
      //   ShowMessage(layoutObject.Items[j].Value.ClassName + ' : ' + layoutObject.Items[j].Name +
      //     ' = ' + layoutObject.Items[j].Value.AsString);

         // layoutObject.;
         //
         // layoutObject.Items[j]
         // if layoutObject.Items[j].Name = 'accountName' then
         // AccountName := layoutObject.Items[j].Value.AsString;

         if layoutObject.Items[j].Value.IsTypeArray then
         begin

            layoutArray1 := TJSONArray(layoutObject.Items[j].Value);

//            if layoutArray1.Count = 0 then
//            begin
//               ShowMessage(layoutObject.ValueByName['accountType'].AsString +
//                 ' is empty level 0 group ');
//            end
//            else
//            begin
//               ShowMessage(layoutObject.ValueByName['accountType'].AsString + ' is level 0 group ');
//            end;

            Level0Group := layoutObject.ValueByName['accountType'].AsString;


            Level0Order := Level0Order + 100;

            insertSQL := 'INSERT INTO tblpnllayoutdata '
                      + ' (`Pos`, `Name`, `Level0Order`, `NewOrder`, `IsRoot`, `AccountID`, `LayoutID`) '
                      + ' VALUES ("", "' + Level0Group + '", ' + IntToStr(Level0Order) + ', ' + IntToStr(Level0Order) + ', "F", 1, 3)';

//               ShowMessage(insertSQL) ;


               qryInsert.SQL.Text := insertSQL;
               qryInsert.Execute;


          //     Self.GetNewDataSet(insertSQL, true);

    //     ShowMessage('insert done');

//               Self.PostDB;
//               Self.Save;


            for k := 0 to layoutArray1.Count - 1 do
            begin

           //    ShowMessage('sub 1 ' + layoutArray1.Items[k].AsString + ' class  ' +
           //      layoutArray1.Items[k].ClassName);

               layoutObject1 := layoutArray1.Items[k].AsObject;

               for l := 0 to layoutObject1.Count - 1 do
               begin
                  if layoutObject1.Items[l].Value.IsTypeArray then
                  begin

                     layoutArray2 := TJSONArray(layoutObject1.Items[l].Value);

                  //   ShowMessage('sub 2  layoutArray2.Count ' + IntToStr(layoutArray2.Count));

//                     if layoutArray2.Count = 0 then
//                     begin
//                        ShowMessage(layoutObject1.ValueByName['accountName'].AsString +
//                          ' is level 1 account in ' + Level0Group);
//                    end
//                     else
//                     begin
//                        ShowMessage(layoutObject1.ValueByName['accountName'].AsString +
//                          ' is level 1 group in ' + Level0Group);
//
//                     end;


                     Level1Group := layoutObject1.ValueByName['accountName'].AsString;


                     Level1Order := Level1Order + 100;

            insertSQL := 'INSERT INTO tblpnllayoutdata '
                      + ' (`Pos`, `Name`, `Level0Order`, `Level1Order`, `NewOrder`, `IsRoot`, `AccountID`, `LayoutID`) '
                      + ' VALUES ("", "' + Level1Group + '", ' + IntToStr(Level0Order) + ', ' + IntToStr(Level1Order) + ', ' + IntToStr(Level0Order) + ', "F", 1, 3)';

//               ShowMessage(insertSQL) ;


               qryInsert.SQL.Text := insertSQL;
               qryInsert.Execute;


          //     Self.GetNewDataSet(insertSQL, true);

     //    ShowMessage('insert done');

                     for m := 0 to layoutArray2.Count - 1 do
                     begin

              //          ShowMessage('sub 2 ' + layoutArray2.Items[m].AsString  + '  Level0Group ' + Level0Group + '  Level1Group ' + Level1Group);

                        layoutObject2 := layoutArray2.Items[m].AsObject;

                        for n := 0 to layoutObject2.Count - 1 do
                        begin
                           if layoutObject2.Items[n].Value.IsTypeArray then
                           begin

                              layoutArray3 := TJSONArray(layoutObject2.Items[n].Value);

                      //        ShowMessage('sub 3  layoutArray3.Count ' +  IntToStr(layoutArray3.Count));

//                              if layoutArray3.Count = 0 then
//                              begin
//                                 ShowMessage(layoutObject2.ValueByName['accountName'].AsString +
//                                   ' is level 2 account in ' + Level1Group + ' in ' + Level0Group);
//                              end
//                              else
//                              begin
//                                 ShowMessage(layoutObject2.ValueByName['accountName'].AsString +
//                                   ' is level 2 group in ' + Level1Group + ' in ' + Level0Group);
//                              end;


                             Level2Group := layoutObject2.ValueByName['accountName'].AsString;

                             Level2Order := Level2Order + 100;


            insertSQL := 'INSERT INTO tblpnllayoutdata '
                      + ' (`Pos`, `Name`, `Level0Order`, `Level1Order` , `Level2Order`, `NewOrder`, `IsRoot`, `AccountID`, `LayoutID`) '
                      + ' VALUES ("", "' + Level2Group + '", ' + IntToStr(Level0Order) + ', ' + IntToStr(Level1Order) + ', ' + IntToStr(Level2Order) + ', ' + IntToStr(Level0Order) + ', "F", 1, 3)';

//               ShowMessage(insertSQL) ;


               qryInsert.SQL.Text := insertSQL;
               qryInsert.Execute;


                              for o := 0 to layoutArray3.Count - 1 do
                              begin

                                 layoutObject3 := layoutArray3.Items[o].AsObject;


                            //     ShowMessage('sub 3 ' + layoutObject3.ValueByName['accountName'].AsString  + '   ' + Level0Group + '   ' + Level1Group + '   ' + Level2Group);
                           //      ShowMessage('sub 3 ' + layoutArray3.Items[o].AsString + '   ' + Level0Group + '   ' + Level1Group + '   ' + Level2Group);

                                 Level3Account := layoutObject3.ValueByName['accountName'].AsString;

                                 Level3Order := Level2Order + 100;

                                            insertSQL := 'INSERT INTO tblpnllayoutdata '
                      + ' (`Pos`, `Name`, `Level0Order`, `Level1Order` , `Level2Order` , `Level3Order`, `NewOrder`, `IsRoot`, `AccountID`, `LayoutID`) '
                      + ' VALUES ("", "' + Level3Account + '", ' + IntToStr(Level0Order) + ', ' + IntToStr(Level1Order) + ', ' + IntToStr(Level2Order) + ', ' + IntToStr(Level3Order) + ', ' + IntToStr(Level0Order) + ', "F", 1, 3)';

        //       ShowMessage(insertSQL) ;


               qryInsert.SQL.Text := insertSQL;
               qryInsert.Execute;


                              end;

                           end;

                        end;


                     end;
                     // layoutObject := layoutArray.Items[i].AsObject;

                  end;

               end;

            end;

         end;

      end;
   end;
end;


procedure TProfitLossLayout.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Parent');
  SetPropertyFromNode(node,'Pos');
  SetPropertyFromNode(node,'Name');
  SetBooleanPropertyFromNode(node,'IsAccount');
  SetBooleanPropertyFromNode(node,'IsRoot');
  SetPropertyFromNode(node,'AccountID');
  SetPropertyFromNode(node,'LayoutID');
end;


procedure TProfitLossLayout.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Parent' ,Parent);
  AddXMLNode(node,'Pos' ,Pos);
  AddXMLNode(node,'Name' ,Name);
  AddXMLNode(node,'IsAccount' ,IsAccount);
  AddXMLNode(node,'IsRoot' ,IsRoot);
  AddXMLNode(node,'AccountID' ,AccountID);
  AddXMLNode(node,'LayoutID' ,LayoutID);
end;


function TProfitLossLayout.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Parent = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Parent should not be 0' , False );
    Exit;
  end;
  if AccountID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'AccountID should not be 0' , False );
    Exit;
  end;
  if LayoutID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'LayoutID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TProfitLossLayout.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProfitLossLayout.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProfitLossLayout.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProfitLossLayout.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProfitLossLayout.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProfitLossLayout.GetBusObjectTablename: string;
begin
  Result:= 'tblpnllayoutdata';
end;


function TProfitLossLayout.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProfitLossLayout.GetRowID          : Integer   ; begin Result := GetIntegerField('ID');end;

function  TProfitLossLayout.GetParent          : Integer   ; begin Result := GetIntegerField('Parent');end;

function  TProfitLossLayout.GetPos             : string    ; begin Result := GetStringField('Pos'); end;

function  TProfitLossLayout.GetName            : string    ; begin Result := GetStringField('Name');end;



function TProfitLossLayout.GetPosition                    : Integer;
var
   positionDataset : TCustomMyDataset;
   positionSQL: string;

   currentPosition : Integer;

begin

      positionSQL := 'SELECT postn , ID FROM ';

     positionSQL := positionSQL + '( SELECT (@row_number:=@row_number + 1) AS postn , tblpnllayoutdata.ID  FROM  tblpnllayoutdata, (SELECT @row_number:=0) AS t ';

      positionSQL := positionSQL + ' ORDER BY Level0Order, IsLevel0Total,  Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order ) AS layout '  ;

      positionSQL := positionSQL + ' WHERE layout.ID = ' + IntToStr(ID)  ;

//   Self.Connection.BeginTransaction;

 //  ShowMessage(positionSQL);


   positionDataset := Self.GetNewDataSet(positionSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

   while  not positionDataset.Eof do
   begin

      currentPosition := positionDataset.FieldByName('postn').AsInteger;

  //       ShowMessage('currentPosition ' + IntToStr(currentPosition));



      positionDataset.Next;

   end;


  result := currentPosition;

end;



function TProfitLossLayout.GetLevel2GroupName                    : string;
var
   level2GroupDataset : TCustomMyDataset;
   level2GroupSQL: string;

   currentLevel2Group : string;

begin

     level2GroupSQL := 'SELECT tblpnllayoutdata.Name FROM tblpnllayoutdata WHERE LEVEL1Order = ' + IntToStr(Level1Order) + ' AND Level2Order > 0 AND tblpnllayoutdata.Name LIKE "Total%"'  ;

//   Self.Connection.BeginTransaction;


   level2GroupDataset := Self.GetNewDataSet(level2GroupSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

   while  not level2GroupDataset.Eof do
   begin

      currentLevel2Group := level2GroupDataset.FieldByName('Name').AsString;


      level2GroupDataset.Next;

   end;


  result := currentLevel2Group;

end;


function TProfitLossLayout.GetLevel1GroupName                    : string;
var
   level1GroupDataset : TCustomMyDataset;
   level1GroupSQL: string;

   currentLevel1Group : string;

begin

     level1GroupSQL := 'SELECT tblpnllayoutdata.Name FROM tblpnllayoutdata WHERE LEVEL1Order = ' + IntToStr(Level1Order) + ' AND tblpnllayoutdata.Name LIKE "Total%"'  ;

//   Self.Connection.BeginTransaction;


   level1GroupDataset := Self.GetNewDataSet(level1GroupSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

   while  not level1GroupDataset.Eof do
   begin

      currentLevel1Group := level1GroupDataset.FieldByName('Name').AsString;


      level1GroupDataset.Next;

   end;


  result := currentLevel1Group;

end;


function TProfitLossLayout.GetLevel0GroupName                    : string;
var
   pos : string;

   currentLevel0Group : string;

begin

    pos :=  GetStringField('Pos');

    if Copy(pos, 0, 2) = '01' then
      currentLevel0Group := 'Income'
    else if Copy(pos, 0, 2) = '02' then
      currentLevel0Group := 'Cost of Sales'
    else if Copy(pos, 0, 2) = '03' then
      currentLevel0Group := 'Expense'
      ;


  result := currentLevel0Group;

end;



// function  TProfitLossLayout.GetPosition      : Integer   ; begin Result := Self.Recno  end;

function  TProfitLossLayout.GetLevel0Order      : Integer   ; begin Result := GetIntegerField('Level0Order');end;
function  TProfitLossLayout.GetLevel1Order      : Integer   ; begin Result := GetIntegerField('Level1Order');end;
function  TProfitLossLayout.GetLevel2Order      : Integer   ; begin Result := GetIntegerField('Level2Order');end;
function  TProfitLossLayout.GetLevel3Order      : Integer   ; begin Result := GetIntegerField('Level3Order');end;

function  TProfitLossLayout.GetIsAccount       : Boolean   ; begin Result := GetBooleanField('IsAccount');end;
function  TProfitLossLayout.GetIsRoot          : Boolean   ; begin Result := GetBooleanField('IsRoot');end;
function  TProfitLossLayout.GetAccountID       : Integer   ; begin Result := GetIntegerField('AccountID');end;
function  TProfitLossLayout.GetLayoutID        : Integer   ; begin Result := GetIntegerField('LayoutID');end;



procedure TProfitLossLayout.SetRowID          (const Value: Integer   ); begin SetIntegerField('ID'           , Value);end;

procedure TProfitLossLayout.SetParent          (const Value: Integer   ); begin SetIntegerField('Parent'           , Value);end;
procedure TProfitLossLayout.SetPos             (const Value: string    ); begin SetStringField('Pos'              , Value);end;
procedure TProfitLossLayout.SetName            (const Value: string    ); begin SetStringField('Name'             , Value);end;

procedure TProfitLossLayout.SetLevel0Order     (const Value: Integer   ); begin SetIntegerField('Level0Order' , Value);end;
procedure TProfitLossLayout.SetLevel1Order     (const Value: Integer   ); begin SetIntegerField('Level1Order' , Value);end;
procedure TProfitLossLayout.SetLevel2Order     (const Value: Integer   ); begin SetIntegerField('Level2Order' , Value);end;
procedure TProfitLossLayout.SetLevel3Order     (const Value: Integer   ); begin SetIntegerField('Level3Order' , Value);end;

procedure TProfitLossLayout.SetIsAccount       (const Value: Boolean   ); begin SetBooleanField('IsAccount'        , Value);end;
procedure TProfitLossLayout.SetIsRoot          (const Value: Boolean   ); begin SetBooleanField('IsRoot'           , Value);end;
procedure TProfitLossLayout.SetAccountID       (const Value: Integer   ); begin SetIntegerField('AccountID'        , Value);end;
procedure TProfitLossLayout.SetLayoutID        (const Value: Integer   ); begin SetIntegerField('LayoutID'         , Value);end;



function TProfitLossLayout.GetLayoutToUse : Integer;
var
   layoutsDataset : TCustomMyDataset;
   layoutsSQL: string;

   currentLayout : Integer;

begin

   layoutsSQL := 'SELECT LayoutID FROM tblpnllayouts WHERE IsCurrentLayout = "T"'  ;

//   Self.Connection.BeginTransaction;


   layoutsDataset := Self.GetNewDataSet(layoutsSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

   while  not layoutsDataset.Eof do
   begin

      currentLayout := layoutsDataset.FieldByName('LayoutID').AsInteger;


      layoutsDataset.Next;

   end;


  result := currentLayout;

end;


procedure TProfitLossLayout.SetLayoutToUse (layoutToUse : Integer) ;
var
   layoutsDataset : TCustomMyDataset;
   layoutsSQL: string;

begin

    layoutsSQL := 'UPDATE tblPnLLayouts SET IsCurrentLayout="F" WHERE 1;'
               + ' UPDATE tblPnLLayouts SET IsCurrentLayout="T" WHERE LayoutID = ' + IntToStr(layoutToUse) + ';';

   layoutsDataset := Self.GetNewDataSet(layoutsSQL, true);

               Self.PostDB;
               Self.Save;

               Self.CloseDb;

               Self.OpenDB;


end;



procedure TProfitLossLayout.MoveLine(direction: TMoveModule; Seqnofieldname: String);
//procedure TProfitLossLayout.MoveLine(direction: TMoveModule; busobj: TBusobj; Seqnofieldname: String);
var
   bm: Tbookmark;
   moveSQL: String;

   id_old, id_new: Integer;

   level0Order_old : Integer;
   level1Order_old : Integer;
   level2Order_old : Integer;
   level3Order_old : Integer;

   level0Order_new : Integer;
   level1Order_new : Integer;
   level2Order_new : Integer;
   level3Order_new : Integer;

   moveField: TStringlist;
   c: Integer;

   moveLevel0 : Boolean;
   moveLevel1 : Boolean;
   moveLevel2 : Boolean;
   moveLevel3 : Boolean;

begin

 //  id_old := 0;
  // Self.Dataset.DisableControls;

   try

   //   bm := Self.Dataset.GetBookmark;

      try

         id_old := Self.Id;


         level0Order_old := Self.Level0Order;
         level1Order_old := Self.Level1Order;
         level2Order_old := Self.Level2Order;
         level3Order_old := Self.Level3Order;

//         ShowMessage('Self.Level0Order ' + IntToStr(Self.Level0Order) + '   Self.Level1Order ' + IntToStr(Self.Level1Order) + '   Self.Level2Order ' + IntToStr(Self.Level2Order));
//
         moveLevel0 := (Self.Level0Order > 0) and (Self.Level1Order = 0) and (Self.Level2Order = 0) and (Self.Level3Order = 0);
         moveLevel1 := (Self.Level0Order > 0) and (Self.Level1Order > 0) and (Self.Level2Order = 0) and (Self.Level3Order = 0);
         moveLevel2 := (Self.Level0Order > 0) and (Self.Level1Order > 0) and (Self.Level2Order > 0) and (Self.Level3Order = 0);
         moveLevel3 := (Self.Level0Order > 0) and (Self.Level1Order > 0) and (Self.Level2Order > 0) and (Self.Level3Order > 0);


//         if moveLevel0 then
//            ShowMessage('moveLevel0')
//         else if moveLevel1 then
//            ShowMessage('moveLevel1')
//         else if moveLevel2 then
//            ShowMessage('moveLevel2')
//         else if moveLevel3 then
//            ShowMessage('moveLevel3') ;


         if (direction = mmUp) and moveLevel0 then
         begin
            while ((Self.Level0Order = level0Order_old) or (not Self.IsAccount)) and (not Self.BOF)  do
            begin
               Self.Prior;
   //      ShowMessage('Self.Level0Order ' + IntToStr(Self.Level0Order) + '   ' + IntToStr(Self.Id));
           end;
         end
         else if (direction = mmUp) and moveLevel1 then
         begin
            while ((Self.Level1Order = level1Order_old) or (not Self.IsAccount)) and (not Self.BOF) do
               Self.Prior;
         end
         else if (direction = mmUp) and moveLevel2 then
         begin
            while ((Self.Level2Order = level2Order_old) or (not Self.IsAccount)) and (not Self.BOF)  do
               Self.Prior;
         end
         else if (direction = mmUp) and moveLevel3 then
         begin
            while ((Self.Level3Order = level3Order_old) or (not Self.IsAccount)) and (not Self.BOF) do
               Self.Prior;
         end

         else if (direction = mmDown) and moveLevel0 then
         begin
            while ((Self.Level0Order = level0Order_old) or (not Self.IsAccount)) and (not Self.EOF)  do
               Self.Next;
         end
         else if (direction = mmDown) and moveLevel1 then
         begin
            while ((Self.Level1Order = level1Order_old) or (not Self.IsAccount)) and (not Self.EOF)  do
               Self.Next;
         end
         else if (direction = mmDown) and moveLevel2 then
         begin
            while ((Self.Level2Order = level2Order_old) or (not Self.IsAccount)) and (not Self.EOF)  do
               Self.Next;
         end
         else if (direction = mmDown) and moveLevel3 then
         begin
            while ((Self.Level3Order = level3Order_old) or (not Self.IsAccount)) and (not Self.EOF)  do
               Self.Next;
         end;

         id_new := Self.Id;

    //      ShowMessage('id_old ' + IntToStr(id_old) + 'id_new ' + IntToStr(id_new) );


 //        id_old := Self.Id;



         level0Order_new := Self.Level0Order;
         level1Order_new := Self.Level1Order;
         level2Order_new := Self.Level2Order;
         level3Order_new := Self.Level3Order;

 //        iPosition := id_new;

//         if moveLevel1 then
//            ShowMessage('moving ' + IntToStr(id_old) + ' ' +  IntToStr(level1Order_old) + ' -> ' + IntToStr(id_new) + ' '  + IntToStr(level1Order_new))
//         else if moveLevel2 then
//            ShowMessage('moving ' + IntToStr(id_old) + ' ' +  IntToStr(level1Order_old) + ' -> ' + IntToStr(id_new) + ' '  + IntToStr(level1Order_new))
//         else if moveLevel3 then
//            ShowMessage('moving ' + IntToStr(id_old) + ' ' +  IntToStr(level1Order_old) + ' -> ' + IntToStr(id_new) + ' '  + IntToStr(level1Order_new))  ;


//         if busobj.Classname = 'TProfitLossLayout' then
//            ShowMessage('busobj ' + IntToStr(id1) + ' -> ' + IntToStr(id2) + '  ' + busobj.FieldByName('Pos').AsString )
//         else
//            ShowMessage('busobj ' + IntToStr(id1) + ' -> ' + IntToStr(id2) + '  ' + busobj.FieldByName('EmployeeName').AsString + '  ' +busobj.FieldByName('ModuleName').AsString );


         Self.Connection.BeginTransaction;
//          Self.Connection.CommitTransaction;

         try
            try
               moveField := TStringlist.Create;
               try
                  moveField.CommaText := Seqnofieldname;

            //      ShowMessage('Seqnofieldname ' + Seqnofieldname);

                  moveSQL := '';

           //       for c := 0 to moveField.count - 1 do
           //       begin
           //          if direction = mmUp then
            //         begin

                        if moveLevel0 then
                        begin
                           moveSQL := 'UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level0Order_new)
                                    + ' WHERE Level0Order = ' + IntToStr(level0Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level0Order_old)
                                    + ' WHERE Level0Order = ' + IntToStr(level0Order_new) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level0Order = NewOrder '
                                    + ' WHERE Level0Order = ' + IntToStr(level0Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level0Order = NewOrder '
                                    + ' WHERE Level0Order = ' + IntToStr(level0Order_new) + ';'

                        end
                        else if moveLevel1 then
                        begin

   //  ShowMessage('level 0 = ' + IntToStr(Self.Level0Order) + 'level 1 = ' + IntToStr(Self.Level1Order)
   //        + 'level 2 = ' + IntToStr(Self.Level2Order) + 'level 3 = ' + IntToStr(Self.Level3Order));

                           moveSQL := 'UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level1Order_new)
                                    + ' WHERE Level1Order = ' + IntToStr(level1Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level1Order_old)
                                    + ' WHERE Level1Order = ' + IntToStr(level1Order_new) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level0Order = ' + IntToStr(Self.Level0Order) + ', Level1Order = NewOrder '
                                    + ' WHERE Level1Order = ' + IntToStr(level1Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level1Order = NewOrder '
                                    + ' WHERE Level1Order = ' + IntToStr(level1Order_new) + ';'

                        end
                        else if moveLevel2 then
                        begin
                           moveSQL := 'UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level2Order_new)
                                    + ' WHERE Level2Order = ' + IntToStr(level2Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level2Order_old)
                                    + ' WHERE Level2Order = ' + IntToStr(level2Order_new) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level0Order = ' + IntToStr(Self.Level0Order) + ', Level1Order = ' + IntToStr(Self.Level1Order) + ', Level2Order = NewOrder '
                                    + ' WHERE Level2Order = ' + IntToStr(level2Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level2Order = NewOrder '
                                    + ' WHERE Level2Order = ' + IntToStr(level2Order_new) + ';'

                        end
                        else if moveLevel3 then
                        begin

                           moveSQL := 'UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level3Order_new)
                                    + ' WHERE Level3Order = ' + IntToStr(level3Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET NewOrder =  ' + IntToStr(level3Order_old)
                                    + ' WHERE Level3Order = ' + IntToStr(level3Order_new) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level0Order = ' + IntToStr(Self.Level0Order) + ', Level1Order = ' + IntToStr(Self.Level1Order) + ', Level2Order = ' + IntToStr(Self.Level2Order) + ', Level3Order = NewOrder '
                                    + ' WHERE Level3Order = ' + IntToStr(level3Order_old) + ';'

                                    + ' UPDATE ' + Self.BusObjectTableName
                                    + ' SET Level3Order = NewOrder '
                                    + ' WHERE Level3Order = ' + IntToStr(level3Order_new) + ';'

                        end;


            //            ShowMessage('moveSQL ' + moveSQL);
         //            end     // up
        //          end;
               finally
                  freeandnil(moveField);
               end;

       //         ShowMessage('getting new');

               Self.GetNewDataSet(moveSQL, true);

               Self.PostDB;
               Self.Save;

       //         ShowMessage('GetNewDataSet done');

               // busobj.Connection.CommitNestedTransaction;
               Self.CloseDb;

       //         ShowMessage('closeDb done');

               Self.OpenDB;

        //                       ShowMessage('OpenDB done');

            except
               on E: Exception do
               begin
                  // busobj.Connection.RollbackNestedTransaction;
               end;
            end;
         finally
          Self.Connection.CommitTransaction;

        //    Self.Connection.beginTransaction;
         end;
      finally
     //    Self.Dataset.GotoBookmark(bm);
     //    Self.Dataset.FreeBookmark(bm);
     //    if id_old <> 0 then
     //       Self.Dataset.Locate(Self.IDFieldName, id_old, []);


      end;
   finally
      Self.Dataset.enableControls;
   end;
end;


function TProfitLossLayout.GetLevel0Groups : TStringList;
var

   level0GroupsDataset : TCustomMyDataset;
   level0GroupsSQL: string;

   level0Order : Integer;
    sLevel0Order : string;

   groupDataset : TCustomMyDataset;

   groupSQL: string;

   groupName : String;

   groupNames : TStringList;

begin

   groupNames := TStringList.Create;
   level0GroupsOrders  := TStringList.Create;

   level0GroupsSQL := 'SELECT DISTINCT Level0Order FROM tblpnllayoutdata WHERE Level0Order > 0'  ;

   Self.Connection.BeginTransaction;


   level0GroupsDataset := Self.GetNewDataSet(level0GroupsSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

   while  not level0GroupsDataset.Eof do
   begin

      level0Order := level0GroupsDataset.FieldByName('Level0Order').AsInteger;



      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level0Order = ' + IntToStr(level0Order);

      groupDataset := Self.GetNewDataSet(groupSQL, false);

      if groupDataset.RecordCount > 1 then
      begin
    //       ShowMessage('level1OrderNr ' + IntToStr(level1OrderNr));

          groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level0Order = ' + IntToStr(level0Order) + ' AND Level1Order = 0 AND IsLevel0Total = 0';

        groupDataset := Self.GetNewDataSet(groupSQL, false);

        sLevel0Order := groupDataset.FieldByName('Level0Order').AsString;
         groupName :=  groupDataset.FieldByName('Name').AsString;

    //     ShowMessage('groupName ' + groupName);

         groupNames.Add(groupName);

    //     ShowMessage(groupName + '=' + sLevel1Order);

         level0GroupsOrders.Add(groupName + '=' + sLevel0Order);

      end;;

      level0GroupsDataset.Next;

   end;

     //             Self.CloseDb;

       //         ShowMessage('closeDb done');

      //         Self.OpenDB;


   Self.Connection.CommitTransaction;


   result := groupNames;


end;


function TProfitLossLayout.GetLevel0Group(level0Order : Integer) : String;
var

 //  level0GroupsDataset : TCustomMyDataset;
 //  level0GroupsSQL: string;

//   level0Order : Integer;
    sLevel0Order : string;

   groupDataset : TCustomMyDataset;

   groupSQL: string;

   groupName : String;

 //  groupNames : TStringList;

begin

 //  groupNames := TStringList.Create;
 //  level0GroupsOrders  := TStringList.Create;

//   level0GroupsSQL := 'SELECT DISTINCT Level0Order FROM tblpnllayoutdata WHERE Level0Order > 0'  ;

   Self.Connection.BeginTransaction;


//   level0GroupsDataset := Self.GetNewDataSet(level0GroupsSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

//   while  not level0GroupsDataset.Eof do
//   begin

  //    level0Order := level0GroupsDataset.FieldByName('Level0Order').AsInteger;



      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level0Order = ' + IntToStr(level0Order);

      groupDataset := Self.GetNewDataSet(groupSQL, false);

      if groupDataset.RecordCount > 1 then
      begin
    //       ShowMessage('level1OrderNr ' + IntToStr(level1OrderNr));

          groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level0Order = ' + IntToStr(level0Order) + ' AND Level1Order = 0 AND IsLevel0Total = 0';

        groupDataset := Self.GetNewDataSet(groupSQL, false);

        sLevel0Order := groupDataset.FieldByName('Level0Order').AsString;
         groupName :=  groupDataset.FieldByName('Name').AsString;

    //     ShowMessage('groupName ' + groupName);

    //     groupNames.Add(groupName);

    //     ShowMessage(groupName + '=' + sLevel1Order);

    //     level0GroupsOrders.Add(groupName + '=' + sLevel0Order);

      end;;

   //   level0GroupsDataset.Next;

  // end;

     //             Self.CloseDb;

       //         ShowMessage('closeDb done');

      //         Self.OpenDB;


   Self.Connection.CommitTransaction;


   result := groupName;


end;




function TProfitLossLayout.GetLevel1Groups : TStringList;
var

   level1GroupsDataset : TCustomMyDataset;
   level1GroupsSQL: string;

   level1Order : Integer;
    sLevel1Order : string;

   groupDataset : TCustomMyDataset;

   groupSQL: string;

   groupName : String;

   groupNames : TStringList;

begin

   groupNames := TStringList.Create;
   level1GroupsOrders  := TStringList.Create;

   level1GroupsSQL := 'SELECT DISTINCT Level1Order FROM tblpnllayoutdata WHERE Level1Order > 0'  ;

   Self.Connection.BeginTransaction;


   level1GroupsDataset := Self.GetNewDataSet(level1GroupsSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

   while  not level1GroupsDataset.Eof do
   begin

      level1Order := level1GroupsDataset.FieldByName('Level1Order').AsInteger;



      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level1Order = ' + IntToStr(level1Order);

      groupDataset := Self.GetNewDataSet(groupSQL, false);

      if groupDataset.RecordCount > 1 then
      begin
    //       ShowMessage('level1OrderNr ' + IntToStr(level1OrderNr));

          groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level1Order = ' + IntToStr(level1Order) + ' AND Level2Order = 0 AND IsLevel1Total = 0';

        groupDataset := Self.GetNewDataSet(groupSQL, false);

        sLevel1Order := groupDataset.FieldByName('Level1Order').AsString;
         groupName :=  groupDataset.FieldByName('Name').AsString;

    //     ShowMessage('groupName ' + groupName);

         groupNames.Add(groupName);

    //     ShowMessage(groupName + '=' + sLevel1Order);

         level1GroupsOrders.Add(groupName + '=' + sLevel1Order);

      end;;

      level1GroupsDataset.Next;

   end;

     //             Self.CloseDb;

       //         ShowMessage('closeDb done');

      //         Self.OpenDB;


   Self.Connection.CommitTransaction;


   result := groupNames;


end;


function TProfitLossLayout.GetLevel1Group(level0Order : Integer; level1Order : Integer) : String;
var

 //  level1GroupsDataset : TCustomMyDataset;
 //  level1GroupsSQL: string;

 //  level1Order : Integer;
    sLevel1Order : string;

   groupDataset : TCustomMyDataset;

   groupSQL: string;

   groupName : String;

   groupNames : TStringList;

begin

//   groupNames := TStringList.Create;
//   level1GroupsOrders  := TStringList.Create;

//   level1GroupsSQL := 'SELECT DISTINCT Level1Order FROM tblpnllayoutdata WHERE Level1Order > 0'  ;

   Self.Connection.BeginTransaction;


 //  level1GroupsDataset := Self.GetNewDataSet(level1GroupsSQL, false);

 //  ShowMessage('level1GroupsDataset.RecordCount ' + IntToStr(level1GroupsDataset.RecordCount));

 //  while  not level1GroupsDataset.Eof do
 //  begin

  //    level1Order := level1GroupsDataset.FieldByName('Level1Order').AsInteger;



      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level0Order = ' + IntToStr(level0Order) + ' AND Level1Order = ' + IntToStr(level1Order);

      groupDataset := Self.GetNewDataSet(groupSQL, false);

      if groupDataset.RecordCount > 1 then
      begin
    //       ShowMessage('level1OrderNr ' + IntToStr(level1OrderNr));

          groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level0Order = ' + IntToStr(level0Order) + ' AND Level1Order = ' + IntToStr(level1Order) + ' AND Level2Order = 0 AND IsLevel1Total = 0';

        groupDataset := Self.GetNewDataSet(groupSQL, false);

        sLevel1Order := groupDataset.FieldByName('Level1Order').AsString;
         groupName :=  groupDataset.FieldByName('Name').AsString;

    //     ShowMessage('groupName ' + groupName);

    //     groupNames.Add(groupName);

    //     ShowMessage(groupName + '=' + sLevel1Order);

    //     level1GroupsOrders.Add(groupName + '=' + sLevel1Order);

      end;;

  //    level1GroupsDataset.Next;

  // end;

     //             Self.CloseDb;

       //         ShowMessage('closeDb done');

      //         Self.OpenDB;


   Self.Connection.CommitTransaction;


   result := groupName;


end;



function TProfitLossLayout.GetLevel2Groups : TStringList;
var

   level2GroupsDataset : TCustomMyDataset;
   level2GroupsSQL: String;

   level2Order : Integer;

   groupDataset : TCustomMyDataset;

   groupSQL: String;

   groupName : String;

   groupNames : TStringList;

begin

   groupNames := TStringList.Create;


   level2GroupsSQL := 'SELECT DISTINCT Level2Order FROM tblpnllayoutdata WHERE Level2Order > 0'  ;

 //  ShowMessage('level2GroupsSQL   ' + level2GroupsSQL);

   Self.Connection.BeginTransaction;


   level2GroupsDataset := Self.GetNewDataSet(level2GroupsSQL, false);

 //  ShowMessage('level2GroupsDataset.RecordCount ' + IntToStr(level2GroupsDataset.RecordCount));

   while  not level2GroupsDataset.Eof do
   begin

      level2Order := level2GroupsDataset.FieldByName('Level2Order').AsInteger;


       groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level2Order = ' + IntToStr(level2Order);

     // groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level1Order = ' + level1GroupsOrders.Values[level1Group] + ' AND Level2Order = ' + IntToStr(level2OrderNr);

      groupDataset := Self.GetNewDataSet(groupSQL, false);

      if groupDataset.RecordCount > 1 then
      begin
    //       ShowMessage('level1OrderNr ' + IntToStr(level1OrderNr));

          groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level2Order = ' + IntToStr(level2Order) + ' AND Level3Order = 0 AND IsLevel2Total = 0';

    //      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Level1Order = ' + level1GroupsOrders.Values[level1Group] + ' AND Level2Order = ' + IntToStr(level2OrderNr) + ' AND Level3Order = 0 AND IsLevel2Total = 0';

        groupDataset := Self.GetNewDataSet(groupSQL, false);

         groupName :=  groupDataset.FieldByName('Name').AsString;

    //     ShowMessage('groupName ' + groupName);

         groupNames.Add(groupName);

      end;;

      level2GroupsDataset.Next;

   end;

     //             Self.CloseDb;

       //         ShowMessage('closeDb done');

      //         Self.OpenDB;


   Self.Connection.CommitTransaction;


   result := groupNames;


end;


procedure TProfitLossLayout.CreateNewGroup(groupName : string);
var
   level0Group : String;
   level1Group : String;
begin

 // ShowMessage('CreateNewGroup : ID ' + IntToStr(ID) + '   Level0Order ' + IntToStr(Level0Order) + '   Level1Order ' + IntToStr(Level1Order) + '   Level2Order ' + IntToStr(Level2Order) + '   Level3Order ' + IntToStr(Level3Order) );


   if Level1Order = 0 then
   begin
  //    ShowMessage('creating new level 0 group');

      CreateNewLevel0Group(groupName);
   end
   else if Level2Order = 0 then
   begin

        level0Group :=  GetLevel0Group(Level0Order);

  //       ShowMessage('creating new level 1 group under ' + level0Group);

      CreateNewLevel1Group(groupName, level0Group);
   end
   else  if Level3Order = 0 then
   begin

         level1Group :=  GetLevel1Group(Level0Order, Level1Order);

  //       ShowMessage('creating new level 2 group under '+ level1Group);

      CreateNewLevel2Group(groupName, AccountName);
   end;

end;


procedure TProfitLossLayout.CreateNewLevel0Group(groupName : string);
var

   maxLevel0OrderSQL : string;
 maxLevel0OrderDataset : TCustomMyDataset;
 maxLevel0Order : Integer;

   insertNewGroupSQL : string;

begin

     Self.Connection.BeginTransaction;


   //      ShowMessage('groupLevel1Order ' + groupLevel1Order);


        maxLevel0OrderSQL := 'SELECT MAX(Level0Order) AS MaxLevel0Order FROM tblpnllayoutdata' ;

       maxLevel0OrderDataset := Self.GetNewDataSet(maxLevel0OrderSQL, true);

         maxLevel0Order := maxLevel0OrderDataset.FieldByName('MaxLevel0Order').AsInteger;



      insertNewGroupSQL := 'INSERT INTO ' + Self.BusObjectTableName
                           + ' ( Name , Level0Order , IsNewGroup ) '
                           + ' VALUES ( "' + groupName + '" , ' + IntToStr(maxLevel0Order + 100) + ' , "T" )'
                           + ';'
                           + 'INSERT INTO ' + Self.BusObjectTableName
                           + ' ( Name , Level0Order , IsLevel0Total , IsNewGroup ) '
                           + ' VALUES ( "Total ' + groupName + '" , ' + IntToStr(maxLevel0Order + 100) + ' , 1 , "T" )'
                           + ';'
                          ;

  //    ShowMessage(insertNewGroupSQL);

      // TO DO : insert Group Total row

                Self.GetNewDataSet(insertNewGroupSQL, true);

               Self.PostDB;
               Self.Save;

       //         ShowMessage('GetNewDataSet done');

               // busobj.Connection.CommitNestedTransaction;
               Self.CloseDb;

       //         ShowMessage('closeDb done');

               Self.OpenDB;


     Self.Connection.CommitTransaction;
end;



procedure TProfitLossLayout.CreateNewLevel1Group(groupName : string ; level0Group : string);
var

   maxLevel1OrderSQL : string;
 maxLevel1OrderDataset : TCustomMyDataset;
 maxLevel1Order : Integer;

    level0OrderSQL : string;
 level0OrderDataset : TCustomMyDataset;
 level0Order : Integer;


   insertNewGroupSQL : string;

begin

     Self.Connection.BeginTransaction;


   //      ShowMessage('groupLevel1Order ' + groupLevel1Order);


        maxLevel1OrderSQL := 'SELECT MAX(Level1Order) AS MaxLevel1Order FROM tblpnllayoutdata WHERE Level0Order = ' + IntToStr(Level0Order) + ' AND IsLevel0Total < 1 ';
       maxLevel1OrderDataset := Self.GetNewDataSet(maxLevel1OrderSQL, true);
         maxLevel1Order := maxLevel1OrderDataset.FieldByName('MaxLevel1Order').AsInteger;

                 level0OrderSQL := 'SELECT Level0Order FROM tblpnllayoutdata WHERE Name = "' + level0Group + '"' ;
       level0OrderDataset := Self.GetNewDataSet(level0OrderSQL, true);
         level0Order := level0OrderDataset.FieldByName('Level0Order').AsInteger;



      insertNewGroupSQL := 'INSERT INTO ' + Self.BusObjectTableName
                           + ' ( Name , Level0Order, Level1Order , IsNewGroup ) '
                           + ' VALUES ( "' + groupName + '" , ' + IntToStr(level0Order) + ' , ' + IntToStr(maxLevel1Order + 10) + ' , "T" )'
                           + ';'
                           + 'INSERT INTO ' + Self.BusObjectTableName
                           + ' ( Name , Level0Order, Level1Order , IsLevel1Total , IsNewGroup ) '
                           + ' VALUES ( "Total ' + groupName + '" , ' + IntToStr(level0Order) + ' , '  + IntToStr(maxLevel1Order + 10) + ' , 1 , "T" )'
                           + ';'
                          ;

  //    ShowMessage(insertNewGroupSQL);

      // TO DO : insert Group Total row

                Self.GetNewDataSet(insertNewGroupSQL, true);

               Self.PostDB;
               Self.Save;

       //         ShowMessage('GetNewDataSet done');

               // busobj.Connection.CommitNestedTransaction;
               Self.CloseDb;

       //         ShowMessage('closeDb done');

               Self.OpenDB;


     Self.Connection.CommitTransaction;
end;


procedure TProfitLossLayout.CreateNewLevel2Group(groupName : string; level1Group : string);
var

   maxLevel2OrderSQL : string;
 maxLevel2OrderDataset : TCustomMyDataset;
 maxLevel2Order : Integer;

     level01OrderSQL : string;
 level01OrderDataset : TCustomMyDataset;
 level1Order : Integer;
 level0Order : Integer;


   insertNewGroupSQL : string;

begin

     Self.Connection.BeginTransaction;




        maxLevel2OrderSQL := 'SELECT MAX(Level2Order) AS MaxLevel2Order FROM tblpnllayoutdata' ;
       maxLevel2OrderDataset := Self.GetNewDataSet(maxLevel2OrderSQL, true);
         maxLevel2Order := maxLevel2OrderDataset.FieldByName('MaxLevel2Order').AsInteger;

    //      ShowMessage('maxLevel2Order ' + IntToStr(maxLevel2Order));

                 level01OrderSQL := 'SELECT Level0Order, Level1Order FROM tblpnllayoutdata WHERE Name = "' + level1Group + '"' ;
       level01OrderDataset := Self.GetNewDataSet(level01OrderSQL, true);
         level0Order := level01OrderDataset.FieldByName('Level0Order').AsInteger;
         level1Order := level01OrderDataset.FieldByName('Level1Order').AsInteger;

               //    ShowMessage('level0Order ' + IntToStr(level0Order));
    //      ShowMessage('insertNewGroupSQL ' + insertNewGroupSQL);


      insertNewGroupSQL := 'INSERT INTO ' + Self.BusObjectTableName
                           + ' ( Name , Level0Order, Level1Order, Level2Order , IsNewGroup ) '
                           + ' VALUES ( "' + groupName + '" , ' + IntToStr(level0Order) + ' , ' + IntToStr(level1Order) + ' , ' + IntToStr(maxLevel2Order + 100) + ' , "T" )'
                           + ';'
                           + 'INSERT INTO ' + Self.BusObjectTableName
                           + ' ( Name , Level0Order, Level1Order , Level2Order, IsLevel2Total , IsNewGroup ) '
                           + ' VALUES ( "Total ' + groupName + '" , '+ IntToStr(level0Order) + ' , ' + IntToStr(level1Order) + ' , '  + IntToStr(maxLevel2Order + 100) + ' , 1 , "T" )'
                           + ';'
                          ;

  //    ShowMessage(insertNewGroupSQL);

      // TO DO : insert Group Total row

                Self.GetNewDataSet(insertNewGroupSQL, true);

               Self.PostDB;
               Self.Save;

       //         ShowMessage('GetNewDataSet done');

               // busobj.Connection.CommitNestedTransaction;
               Self.CloseDb;

       //         ShowMessage('closeDb done');

               Self.OpenDB;


     Self.Connection.CommitTransaction;
end;



procedure TProfitLossLayout.MoveAccountToLevel0Group(accountID : string; groupName : string);
var
   groupSQL : string;
   groupDataset : TCustomMyDataset;
   groupLevel0Order : string;

   maxLevel1OrderSQL : string;
 maxLevel1OrderDataset : TCustomMyDataset;
 maxLevel1Order : Integer;

   moveToGroupSQL : string;

begin

     Self.Connection.BeginTransaction;


      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Name = "' + groupName + '"' ;

        //    ShowMessage(groupSQL);

      groupDataset := Self.GetNewDataSet(groupSQL, true);

            //      ShowMessage('groupDataset.RecordCount ' + IntToStr(groupDataset.RecordCount));


      if groupDataset.RecordCount > 0 then
      begin

         groupLevel0Order :=  groupDataset.FieldByName('Level0Order').AsString;

   //      ShowMessage('groupLevel1Order ' + groupLevel1Order);


        maxLevel1OrderSQL := 'SELECT MAX(Level1Order) AS MaxLevel1Order FROM tblpnllayoutdata WHERE Level0Order = "' + groupLevel0Order + '"' ;

       maxLevel1OrderDataset := Self.GetNewDataSet(maxLevel1OrderSQL, true);

         maxLevel1Order := maxLevel1OrderDataset.FieldByName('MaxLevel1Order').AsInteger;

   //      ShowMessage('maxLevel2Order ' + IntToStr(maxLevel2Order));

      end;;


      moveToGroupSQL := 'UPDATE ' + Self.BusObjectTableName
               + ' SET Level0Order =  ' + groupLevel0Order
               + ' , Level1Order = ' + intToStr(maxLevel1Order + 10)
               + ' , Level2Order = 0'
               + ' , Level3Order = 0'
               + ' WHERE ID = ' + accountID + ';' ;

   //   ShowMessage(moveToGroupSQL);

                Self.GetNewDataSet(moveToGroupSQL, true);

               Self.PostDB;
               Self.Save;

       //         ShowMessage('GetNewDataSet done');

               // busobj.Connection.CommitNestedTransaction;
               Self.CloseDb;

       //         ShowMessage('closeDb done');

               Self.OpenDB;


     Self.Connection.CommitTransaction;

end;




procedure TProfitLossLayout.MoveAccountToLevel1Group(accountID : string; groupName : string);
var
   groupSQL : string;
   groupDataset : TCustomMyDataset;
   groupLevel1Order : string;

   maxLevel2OrderSQL : string;
 maxLevel2OrderDataset : TCustomMyDataset;
 maxLevel2Order : Integer;

   moveToGroupSQL : string;

begin

     Self.Connection.BeginTransaction;


      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Name = "' + groupName + '"' ;

        //    ShowMessage(groupSQL);

      groupDataset := Self.GetNewDataSet(groupSQL, true);

            //      ShowMessage('groupDataset.RecordCount ' + IntToStr(groupDataset.RecordCount));


      if groupDataset.RecordCount > 0 then
      begin

         groupLevel1Order :=  groupDataset.FieldByName('Level1Order').AsString;

   //      ShowMessage('groupLevel1Order ' + groupLevel1Order);


        maxLevel2OrderSQL := 'SELECT MAX(Level2Order) AS MaxLevel2Order FROM tblpnllayoutdata WHERE Level1Order = "' + groupLevel1Order + '"' ;

       maxLevel2OrderDataset := Self.GetNewDataSet(maxLevel2OrderSQL, true);

         maxLevel2Order := maxLevel2OrderDataset.FieldByName('MaxLevel2Order').AsInteger;

   //      ShowMessage('maxLevel2Order ' + IntToStr(maxLevel2Order));

      end;;


      moveToGroupSQL := 'UPDATE ' + Self.BusObjectTableName
               + ' SET Level1Order =  ' + groupLevel1Order
               + ' , Level2Order = ' + intToStr(maxLevel2Order + 10)
               + ' , Level3Order = 0'
               + ' WHERE ID = ' + accountID + ';' ;

   //   ShowMessage(moveToGroupSQL);

                Self.GetNewDataSet(moveToGroupSQL, true);

               Self.PostDB;
               Self.Save;

       //         ShowMessage('GetNewDataSet done');

               // busobj.Connection.CommitNestedTransaction;
               Self.CloseDb;

       //         ShowMessage('closeDb done');

               Self.OpenDB;


     Self.Connection.CommitTransaction;

end;



procedure TProfitLossLayout.MoveAccountToLevel2Group(accountID : string; groupName : string);
var
   groupSQL : string;
   groupDataset : TCustomMyDataset;
   groupLevel1Order : string;
   groupLevel2Order : string;

   maxLevel3OrderSQL : string;
 maxLevel3OrderDataset : TCustomMyDataset;
 maxLevel3Order : Integer;

   moveToGroupSQL : string;

begin

     Self.Connection.BeginTransaction;


      groupSQL := 'SELECT * FROM tblpnllayoutdata WHERE Name = "' + groupName + '"' ;

        //    ShowMessage(groupSQL);

      groupDataset := Self.GetNewDataSet(groupSQL, true);

            //      ShowMessage('groupDataset.RecordCount ' + IntToStr(groupDataset.RecordCount));


      if groupDataset.RecordCount > 0 then
      begin

         groupLevel1Order :=  groupDataset.FieldByName('Level1Order').AsString;
         groupLevel2Order :=  groupDataset.FieldByName('Level2Order').AsString;

   //      ShowMessage('groupLevel1Order ' + groupLevel1Order);


        maxLevel3OrderSQL := 'SELECT MAX(Level3Order) AS MaxLevel3Order FROM tblpnllayoutdata WHERE Level1Order = "' + groupLevel1Order + '" AND Level2Order = "' + groupLevel2Order + '"' ;

       maxLevel3OrderDataset := Self.GetNewDataSet(maxLevel3OrderSQL, true);

         maxLevel3Order := maxLevel3OrderDataset.FieldByName('MaxLevel3Order').AsInteger;

   //      ShowMessage('maxLevel2Order ' + IntToStr(maxLevel2Order));

      end;;


      moveToGroupSQL := 'UPDATE ' + Self.BusObjectTableName
               + ' SET Level1Order =  ' + groupLevel1Order
               + ' , Level2Order = ' + groupLevel2Order
               + ' , Level3Order = ' + intToStr(maxLevel3Order + 10)
               + ' WHERE ID = ' + accountID + ';' ;

   //   ShowMessage(moveToGroupSQL);

                Self.GetNewDataSet(moveToGroupSQL, true);

               Self.PostDB;
               Self.Save;

       //         ShowMessage('GetNewDataSet done');

               // busobj.Connection.CommitNestedTransaction;
               Self.CloseDb;

       //         ShowMessage('closeDb done');

               Self.OpenDB;


     Self.Connection.CommitTransaction;

end;




initialization

  RegisterClass(TProfitLossLayout);


end.
