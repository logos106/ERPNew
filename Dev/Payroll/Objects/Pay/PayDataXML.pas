{ When processing pays: Grabs all the data for a pay and stores it as XML text in the pay rec in tblpays .
  When running verifyPay: Any pay recs with XML data will create and load tmp_tables to use for pay datasets.

  If adding fields keep the tblpays.PayXMLData the last field and any field containing 'date' will be treated as a date.

   }

unit PayDataXML;

interface

uses
  Classes, xmldom, XMLIntf, oxmldom, XMLDoc,DB,MyAccess,LibXMLParser,Dialogs;

type
  TLocalNode = class(Tobject)
  private
    fName:String;
    fParentName:String;
    fChildNode:TLocalNode;
    fChildName:string;
  public
    property Name:string read fName write fName;
    property ParentName:string read fParentName write fParentName;
    property ChildName:string read fChildName write fChildName;
    property ChildNode:TLocalNode read fChildNode write fChildNode;

  end;

type
  TDataXMLObj = class(TObject)
  private
    foOwner: TObject;
    fsXML : String;
//    procedure CreateTmp_Pays;
//    procedure CreateTmp_Paysallowances;
//    procedure CreateTmp_PayPayRates;
//    procedure CreateTmp_Paysdeductions;
//    procedure CreateTmp_Payssundries;
//    procedure CreateTmp_Payscommission;
//    procedure CreateTmp_Payssuperannuation;
    procedure CreateTmp_Paysleave;
//    procedure CreateTmp_PaysTax;
//    procedure CreateTmp_PaysSplits;

    procedure CreateTmp_Employees;
    procedure CreateTmp_EmployeePayRates;
    procedure CreateTmp_EmployeeAllowances;
    procedure CreateTmp_Employeedeductions;
    procedure CreateTmp_tblsuperannuation;
//    procedure CreateTmp_leave;
    procedure LoadTmp_table(const iPayID:integer; const sTableName:String);
    procedure LoadTmp_Employeetable(const sTableName:String);
    procedure DestroyTmpTable(const tmpTable:String);
    procedure AddEmployeePayData(const XMLDoc2: TXMLDocument; const EmployeeID:integer; const nNewPay:IXMLNode);
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure SnapshotXMLPayData;
    function PayHasXML(const iPayID:integer):Boolean;
    procedure CreateAndLoadTmpTables(const iPayID:integer);
    procedure DestroyTmpTables;
    property Owner: TObject read foOwner;
  end;

implementation
uses FastFuncs,SysUtils, PayObj,CommonDbLib, CommonLib, PayAllowancesObj, PayCommissionObj,
  PayDeductionsObj, PayLeaveObj, PayPayRatesObj, PaySundriesObj,
  PaySuperannuationObj,PayPaySplitsObj;

constructor TDataXMLObj.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
end;

destructor TDataXMLObj.Destroy;
begin

  inherited;
end;

procedure TDataXMLObj.DestroyTmpTables;
begin
  //DestroyTmpTable('tmp_tblpays');
  DestroyTmpTable('tmp_tblpayscommission');
  DestroyTmpTable('tmp_tblpaysdeductions');
  DestroyTmpTable('tmp_tblpaysleave');
  DestroyTmpTable('tmp_tblpayspayrates');
  DestroyTmpTable('tmp_tblpayssundries');
  DestroyTmpTable('tmp_tblpayssuperannuation');
  DestroyTmpTable('tmp_tblpaysallowances');
  DestroyTmpTable('tmp_tblpaystax');
  DestroyTmpTable('tmp_tblemployees');
  DestroyTmpTable('Tmp_tblEmployeePayRates');
  DestroyTmpTable('Tmp_tblEmployeeAllowances');
  DestroyTmpTable('Tmp_tblEmployeedeductions');
  DestroyTmpTable('Tmp_tblsuperannuation');
  DestroyTmpTable('tmp_tblpayssplits');
end;

procedure TDataXMLObj.DestroyTmpTable(const tmpTable:String);
var
  qry   :TMyCommand;
begin
  if not TableExists(tmpTable) then Exit;
  qry := TMyCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS ');
    qry.SQL.Add(tmpTable);
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

//procedure TDataXMLObj.LoadTmp_Employeetable(const sTableName:String);
//var
//  qry           :TMyQuery;
//  XMLDoc1       :TXMLDocument;
//  nPay,nChild1  :IXMLNode;
//  nChild2       :IXMLNode;
//  dm            :TDataModule;
//  i,j           :Integer;
//  sTempNodeName :String;
//begin
//    qry := TMyQuery.Create(nil);
//  try
//    qry.Options.FlatBuffers := True;  
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//
//    if qry.Active then qry.Close;
//    qry.SQL.Clear;
//    qry.SQL.Add('SELECT * FROM tmp_tbl' + sTableName);
//
//    qry.Open;
//
//    dm:=TDataModule.Create(nil);
//    XMLDoc1 := TXMLDocument.Create(dm);
//    XMLDoc1.XML.Add(fsXML);
//
//    XMLDoc1.Active := True;
//
//    nPay := XMLDoc1.ChildNodes.FindNode('Pay');
//    nChild1 := nPay.ChildNodes.FindNode(sTableName);
//
//    if nChild1 <> nil then begin
//      for j := 0 to nChild1.ChildNodes.Count -1 do
//      begin
//        nChild2 := nChild1.ChildNodes[j];
//
//        qry.Insert;
//
//        for i := 0 to nChild2.ChildNodes.Count -1 do
//        begin
//          sTempNodeName :=  nChild2.ChildNodes[i].NodeName;
//          if sTempNodeName = 'msTimeStamp' then continue;
//          if  nChild2.ChildNodes.FindNode(sTempNodeName).IsTextElement then begin    //ugly but it works
//            if ((FastFuncs.PosEx('date',sTempNodeName) > 0)
//                 or (FastFuncs.PosEx('Date',sTempNodeName) > 0)
//                 or (sTempNodeName = 'DOB')
//                 or (sTempNodeName = 'LastPaid'))
//                 and (sTempNodeName <> 'UseStartEndDates')
//                 then begin
//              qry.FieldByName(sTempNodeName).AsDateTime := MysqlDateStrToDate(nChild2.ChildNodes.FindNode(sTempNodeName).NodeValue) ;
//            end else begin
//              qry.FieldByName(sTempNodeName).AsString := nChild2.ChildNodes.FindNode(sTempNodeName).NodeValue ;
//            end;
//          end;
//        end;
//        qry.Post;
//      end;
//    end;
//
//  finally
//    FreeAndNil(qry);
//    FreeAndNil(dm);
//  end;
//end;
procedure TDataXMLObj.LoadTmp_Employeetable(const sTableName:String);
var
  qry           :TMyQuery;
  Parser :TXmlParser;
  bTableNameFound:Boolean;

  currentNode:string;
  currentAttribValue:string;
  currentAttribName:string;
begin
    qry := TMyQuery.Create(nil);
    Parser := TXmlParser.Create;
    currentNode := '';
    bTableNameFound := False;
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;

    if qry.Active then qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tmp_tbl' + sTableName);

    qry.Open;

    Parser.Normalize := True;
    Parser.LoadFromBuffer(pChar(fsXML));
    Parser.StartScan;
    try
      while Parser.Scan do
        case Parser.CurPartType of          // Here the parser tells you what it has found
          ptEmptyTag :
              begin
                if Parser.CurName = sTableName then exit;
              end;
          ptStartTag:  // Process Parser.CurName and Parser.CurAttr (see below) fields here
              begin
                if Parser.CurName = sTableName then begin
                  bTableNameFound := True;
                end else begin
                  currentNode := Parser.CurName;
                  currentAttribName  := Parser.CurAttr.Name(0);
                  currentAttribValue := Parser.CurAttr.Value(0);
                  if currentAttribValue <> '' then begin
                    qry.Insert;
                  end;
                end;
              end;
          ptContent,
          ptCData    : // Process Parser.CurContent field here
              begin
                if bTablenameFound then begin
                  if Parser.CurName = 'msTimeStamp' then continue;
                  qry.Edit;

                  if ((FastFuncs.PosEx('date',Parser.CurName) > 0)
                 or (FastFuncs.PosEx('Date',Parser.CurName) > 0)
                 or (Parser.CurName = 'DOB')
                 or (Parser.CurName = 'LastPaid'))
                 and (Parser.CurName <> 'UseStartEndDates')
                 then begin

               //   if (FastFuncs.PosEx('date',Parser.CurName) > 0) or (FastFuncs.PosEx('Date',Parser.CurName) > 0) and (Parser.CurName <> 'UseStartEndDates') then begin
                    qry.FieldByName(Parser.CurName).AsDateTime := MysqlDateStrToDate(Parser.CurContent) ;
                  end else begin
                    qry.FieldByName(Parser.CurName).AsString := Parser.CurContent ;
                  end;
                  qry.Post;
                end;
              end;
          ptEndTag   : // Process End-Tag here (Parser.CurName)
              begin
                if sTableName = Parser.CurName then begin
                  exit;
                end;
              end;
          ptPI       : // Process PI here (Parser.CurName is the target, Parser.CurContent)
              begin
              end;
      end;
    except

    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(Parser);
  end;

//    if nChild1 <> nil then begin
//      for j := 0 to nChild1.ChildNodes.Count -1 do
//      begin
//        nChild2 := nChild1.ChildNodes[j];
//
//        qry.Insert;
//
//        for i := 0 to nChild2.ChildNodes.Count -1 do
//        begin
//          sTempNodeName :=  nChild2.ChildNodes[i].NodeName;
//          if sTempNodeName = 'msTimeStamp' then continue;
//          if  nChild2.ChildNodes.FindNode(sTempNodeName).IsTextElement then begin    //ugly but it works
//            if ((FastFuncs.PosEx('date',sTempNodeName) > 0)
//                 or (FastFuncs.PosEx('Date',sTempNodeName) > 0)
//                 or (sTempNodeName = 'DOB')
//                 or (sTempNodeName = 'LastPaid'))
//                 and (sTempNodeName <> 'UseStartEndDates')
//                 then begin
//              qry.FieldByName(sTempNodeName).AsDateTime := MysqlDateStrToDate(nChild2.ChildNodes.FindNode(sTempNodeName).NodeValue) ;
//            end else begin
//              qry.FieldByName(sTempNodeName).AsString := nChild2.ChildNodes.FindNode(sTempNodeName).NodeValue ;
//            end;
//          end;
//        end;
//        qry.Post;
//      end;
//    end;
//
//  finally
//    FreeAndNil(qry);
//    FreeAndNil(dm);
//  end;
end;


{ XMLDoc component caused access violations so replaced with  XMLParser.
  Relies on each record having an attribute. A bit weak. Improve later..
}
procedure TDataXMLObj.LoadTmp_table(const iPayID:integer; const sTableName:String);
var
  qry    :TMyQuery;
  Parser :TXmlParser;
  bTableNameFound:Boolean;

  currentNode:string;
  currentAttribValue:string;
  currentAttribName:string;
begin
    qry := TMyQuery.Create(nil);
    Parser := TXmlParser.Create;
    currentNode := '';
    bTableNameFound := False;
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;

    if qry.Active then qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tmp_tbl' + sTableName);
    if (sTableName <> 'Paysleave') and (sTableName <> 'PaysTax') then begin //the only tables without PayID
      qry.SQL.Add(' WHERE PayID = ');
      qry.SQL.Add(FastFuncs.IntToStr(iPayID));
    end;
    qry.Open;

    Parser.Normalize := True;
    Parser.LoadFromBuffer(pChar(fsXML));
    Parser.StartScan;
    try
      while Parser.Scan do
        case Parser.CurPartType of          // Here the parser tells you what it has found
          ptEmptyTag :
              begin
                if Parser.CurName = sTableName then exit;
              end;
          ptStartTag:  // Process Parser.CurName and Parser.CurAttr (see below) fields here
              begin
                if Parser.CurName = sTableName then begin
                  bTableNameFound := True;
                end else begin
                  currentNode := Parser.CurName;
                  currentAttribName  := Parser.CurAttr.Name(0);
                  currentAttribValue := Parser.CurAttr.Value(0);
                  if currentAttribValue <> '' then begin
                    qry.Insert;
                  end;
                end;
              end;
          ptContent,
          ptCData    : // Process Parser.CurContent field here
              begin
                if bTablenameFound then begin
                  qry.Edit;
                  if (FastFuncs.PosEx('date',Parser.CurName) > 0) or (FastFuncs.PosEx('Date',Parser.CurName) > 0) and (Parser.CurName <> 'UseStartEndDates') then begin
                    qry.FieldByName(Parser.CurName).AsDateTime := MysqlDateStrToDate(Parser.CurContent) ;
                  end else begin
                    qry.FieldByName(Parser.CurName).AsString := Parser.CurContent ;
                  end;
                  qry.Post;
                end;
              end;
          ptEndTag   : // Process End-Tag here (Parser.CurName)
              begin
                if sTableName = Parser.CurName then begin
                  exit;
                end;
              end;
          ptPI       : // Process PI here (Parser.CurName is the target, Parser.CurContent)
              begin
              end;
      end;
    except

    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(Parser);
  end;
end;


//procedure TDataXMLObj.LoadTmp_table(const iPayID:integer; const sTableName:String);
//var
//  qry           :TMyQuery;
//  XMLDoc1       :TXMLDocument;
//  nPay,nChild1  :IXMLNode;
//  nChild2       :IXMLNode;
//  dm            :TDataModule;
//  i,j           :Integer;
//  sTempNodeName :String;
//begin
//    qry := TMyQuery.Create(nil);
//  try
//    qry.Options.FlatBuffers := True;
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//
//    if qry.Active then qry.Close;
//    qry.SQL.Clear;
//    qry.SQL.Add('SELECT * FROM tmp_tbl' + sTableName);    //the only table without PayID
//    if (sTableName <> 'Paysleave') and (sTableName <> 'PaysTax') then begin
//      qry.SQL.Add(' WHERE PayID = ');
//      qry.SQL.Add(FastFuncs.IntToStr(iPayID));
//    end;
//
//    qry.Open;
//
//    dm:=TDataModule.Create(nil);
//    XMLDoc1 := TXMLDocument.Create(dm);
//    XMLDoc1.XML.Add(fsXML);
//
//    XMLDoc1.Active := True;
//
//    nPay := XMLDoc1.ChildNodes.FindNode('Pay');
//    nChild1 := nPay.ChildNodes.FindNode(sTableName);
//
//    if nChild1 <> nil then begin
//      for j := 0 to nChild1.ChildNodes.Count -1 do
//      begin
//        if j < 3 then nChild2 := nChild1.ChildNodes[j];
//        if nChild2 <> nil then begin
//          qry.Insert;
//          if (sTableName <> 'Paysleave') and (sTableName <> 'PaysTax') then begin
//            qry.FieldByName('PayID').AsInteger := iPayID ;
//          end;
//          for i := 0 to nChild2.ChildNodes.Count -1 do
//          begin
//            sTempNodeName :=  nChild2.ChildNodes[i].NodeName;
//            if  nChild2.ChildNodes.FindNode(sTempNodeName).IsTextElement then begin    //ugly but it works
//              if (FastFuncs.PosEx('date',sTempNodeName) > 0) or (FastFuncs.PosEx('Date',sTempNodeName) > 0) and (sTempNodeName <> 'UseStartEndDates') then begin
//                qry.FieldByName(sTempNodeName).AsDateTime := MysqlDateStrToDate(nChild2.ChildNodes.FindNode(sTempNodeName).NodeValue) ;
//              end else begin
//                qry.FieldByName(sTempNodeName).AsString := nChild2.ChildNodes.FindNode(sTempNodeName).NodeValue ;
//              end;
//            end;
//          end;
//          qry.Post;
//        end;
//      end;
//    end;
//
//  finally
//    FreeAndNil(qry);
//    FreeAndNil(dm);
//  end;
//end;

procedure TDataXMLObj.CreateTmp_tblsuperannuation;
var
  qry: TMyCommand;
begin
  qry := TMyCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblsuperannuation`;');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `tmp_tblsuperannuation` (');
    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
    qry.SQL.Add('`SuperID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`EmployeeID` int(11) NOT NULL default "0",');
    qry.SQL.Add('`SuperTypeID` int(11) NOT NULL default "0",');
    qry.SQL.Add('`ClientID` int(11) default "0",');
    qry.SQL.Add('`AccountNo` varchar(50) default NULL,');
    qry.SQL.Add('`DateJoined` date default NULL,');
    qry.SQL.Add('`Amount` double default NULL,');
    qry.SQL.Add('`CalcBy` enum("$","%") default "%",');
    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
    qry.SQL.Add('`TaxExempt` enum("T","F") default "T",');
    qry.SQL.Add('`TaxRate` double default "0",');
    qry.SQL.Add('`ClassID` int(11) default NULL,');
    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
    qry.SQL.Add('`AllClasses` enum("T","F") default "F",');
    qry.SQL.Add('`SuperFund` varchar(255) default NULL,');
    qry.SQL.Add('`AmountToPaid` double default "0",');
    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
    qry.SQL.Add('PRIMARY KEY  (`SuperID`),');
    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
    qry.SQL.Add('KEY `IndexEmployeeID` (`EmployeeID`)');
    qry.SQL.Add(') TYPE=MyISAM;');

    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDataXMLObj.CreateTmp_Employeedeductions;
var
  qry: TMyCommand;
begin
  qry := TMyCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblemployeedeductions`;');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `tmp_tblemployeedeductions` (');
    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
    qry.SQL.Add('`EDID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`EmployeeID` int(11) default "0",');
    qry.SQL.Add('`Deduction` varchar(255) default NULL,');
    qry.SQL.Add('`DeductionID` int(11) default "0",');
    qry.SQL.Add('`Qty` double default "0",');
    qry.SQL.Add('`Notes` varchar(50) default NULL,');
    qry.SQL.Add('`Amount` double default NULL,');
    qry.SQL.Add('`CalcBy` enum("$","%") default "$",');
    qry.SQL.Add('`Percentage` double default "0",');
    qry.SQL.Add('`TaxExempt` enum("T","F") default "F",');
    qry.SQL.Add('`UnionFees` enum("T","F") default "F",');
    qry.SQL.Add('`DisplayIn` set("Deductions","Gross","Do Not Display") default "Deductions",');
    qry.SQL.Add('`BasedOnID` int(11) default "0",');
    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
    qry.SQL.Add('`ClassID` int(11) default "1",');
    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
    qry.SQL.Add('`UseStartEndDates` enum("T","F") default "F",');
    qry.SQL.Add('`StartDate` date default NULL,');
    qry.SQL.Add('`EndDate` date default NULL,');
    qry.SQL.Add('PRIMARY KEY  (`EDID`),');
    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
    qry.SQL.Add('KEY `IndexEmployeeID` (`EmployeeID`)');
    qry.SQL.Add(') TYPE=MyISAM;');

    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;


procedure TDataXMLObj.CreateTmp_EmployeeAllowances;
var
  qry: TMyCommand;
begin
  qry := TMyCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblemployeeallowances`;');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `tmp_tblemployeeallowances` (');
    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
    qry.SQL.Add('`EAID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`EmployeeID` int(11) default NULL,');
    qry.SQL.Add('`Allowance` varchar(255) default NULL,');
    qry.SQL.Add('`AllowanceID` int(11) default NULL,');
    qry.SQL.Add('`Qty` double default NULL,');
    qry.SQL.Add('`BasedOnID` int(11) default "0",');
    qry.SQL.Add('`Amount` double default "0",');
    qry.SQL.Add('`CalcBy` enum("$","%") default "$",');
    qry.SQL.Add('`SuperInc` enum("T","F") default "F",');
    qry.SQL.Add('`TaxExempt` enum("T","F") default "T",');
    qry.SQL.Add('`ClientID` int(11) default "0",');
    qry.SQL.Add('`ClassID` int(11) default "0",');
    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
    qry.SQL.Add('`UseStartEndDates` enum("T","F") default "F",');
    qry.SQL.Add('`StartDate` date default NULL,');
    qry.SQL.Add('`EndDate` date default NULL,');
    qry.SQL.Add('PRIMARY KEY  (`EAID`),');
    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
    qry.SQL.Add('KEY `IndexEmployeeID` (`EmployeeID`)');
    qry.SQL.Add(') TYPE=MyISAM;');

    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDataXMLObj.CreateTmp_EmployeePayRates;
var
  qry: TMyCommand;
begin
  qry := TMyCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblemployeepayrates`;');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `tmp_tblemployeepayrates` (');
    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
    qry.SQL.Add('`EmployeeRateID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`EmployeeID` int(11) default NULL,');
    qry.SQL.Add('`PayRateID` int(11) default NULL,');
    qry.SQL.Add('`TypeID` int(11) default NULL,');
    qry.SQL.Add('`Qty` double default "0",');
    qry.SQL.Add('`Amount` double default "0",');
    qry.SQL.Add('`Super` enum("T","F") default "T",');
    qry.SQL.Add('`ClientID` int(11) default NULL,');
    qry.SQL.Add('`ClassID` int(11) default NULL,');
    qry.SQL.Add('`HourlyRate` double default "0",');
    qry.SQL.Add('`LineTotal` double default "0",');
    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
    qry.SQL.Add('PRIMARY KEY  (`EmployeeRateID`),');
    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
    qry.SQL.Add('KEY `IndexEmployeeID` (`EmployeeID`)');
    qry.SQL.Add(') TYPE=MyISAM;');

    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDataXMLObj.CreateTmp_Employees;
var
  qry: TMyCommand;
begin
  qry := TMyCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblemployees`;');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE `tmp_tblemployees` (');
    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
    qry.SQL.Add('`EmployeeID` int(11) NOT NULL auto_increment,');
    qry.SQL.Add('`Title` varchar(5) default NULL,');
    qry.SQL.Add('`FirstName` varchar(40) default NULL,');
    qry.SQL.Add('`MiddleName` varchar(40) default NULL,');
    qry.SQL.Add('`LastName` varchar(40) default NULL,');
    qry.SQL.Add('`Street` varchar(255) default NULL,');
    qry.SQL.Add('`Street2` varchar(255) default NULL,');
    qry.SQL.Add('`Suburb` varchar(255) default NULL,');
    qry.SQL.Add('`Postcode` varchar(255) default NULL,');
    qry.SQL.Add('`State` varchar(255) default NULL,');
    qry.SQL.Add('`Country` varchar(255) default NULL,');
    qry.SQL.Add('`Phone` varchar(255) default NULL,');
    qry.SQL.Add('`AltPhone` varchar(255) default NULL,');
    qry.SQL.Add('`FaxNumber` varchar(255) default NULL,');
    qry.SQL.Add('`Mobile` varchar(255) default NULL,');
    qry.SQL.Add('`Email` varchar(80) default NULL,');
    qry.SQL.Add('`AltContact` varchar(255) default NULL,');
    qry.SQL.Add('`Company` varchar(35) default NULL,');
    qry.SQL.Add('`Position` varchar(30) default NULL,');
    qry.SQL.Add('`ABN` varchar(15) default NULL,');
    qry.SQL.Add('`Canvasser` enum("T","F") default "F",');
    qry.SQL.Add('`Rep` enum("T","F") default "F",');
    qry.SQL.Add('`CreationDate` date default NULL,');
    qry.SQL.Add('`DateStarted` date default NULL,');
    qry.SQL.Add('`DateFinished` date default NULL,');
    qry.SQL.Add('`Notes` text,');
    qry.SQL.Add('`Active` enum("T","F") default "T",');
    qry.SQL.Add('`CUSTFLD1` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD2` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD3` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD4` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD5` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD6` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD7` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD8` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD9` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD10` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD11` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD12` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD13` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD14` varchar(50) default NULL,');
    qry.SQL.Add('`CUSTFLD15` varchar(50) default NULL,');
    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
    qry.SQL.Add('`EmployeeNo` int(11) default NULL,');
    qry.SQL.Add('`TFN` varchar(9) default NULL,');
    qry.SQL.Add('`DOB` date default NULL,');
    qry.SQL.Add('`Initials` char(3) default NULL,');
    qry.SQL.Add('`Sex` varchar(32) default NULL,');
    qry.SQL.Add('`OptionNo` tinyint(1) default NULL,');
    qry.SQL.Add('`Tax` double default "0",');
    qry.SQL.Add('`Gross` double default "0",');
    qry.SQL.Add('`Net` double default "0",');
    qry.SQL.Add('`Wages` double default "0",');
    qry.SQL.Add('`Commission` double default "0",');
    qry.SQL.Add('`Deductions` double default "0",');
    qry.SQL.Add('`Allowances` double default "0",');
    qry.SQL.Add('`Sundries` double default "0",');
    qry.SQL.Add('`Super` double default "0",');
    qry.SQL.Add('`LumpSumA` double default "0",');
    qry.SQL.Add('`LumpSumB` double default "0",');
    qry.SQL.Add('`LumpSumD` double default "0",');
    qry.SQL.Add('`LumpSumE` double default "0",');
    qry.SQL.Add('`CDEProject` enum("T","F") default "F",');
    qry.SQL.Add('`OtherIncome` double default "0",');
    qry.SQL.Add('`FringeBenefits` double default "0",');
    qry.SQL.Add('`DaysPre01071983` int(11) default "0",');
    qry.SQL.Add('`DaysPost30061983` int(11) default "0",');
    qry.SQL.Add('`CGTExempt` float(10,2) default NULL,');
    qry.SQL.Add('`NonQualifyingComponent` float(10,2) default NULL,');
    qry.SQL.Add('`UndeductedContribution` float(10,2) default NULL,');
    qry.SQL.Add('`ConcessionalComponent` float(10,2) default NULL,');
    qry.SQL.Add('`Pre071983` double default "0",');
    qry.SQL.Add('`Post061983Untaxed` double default "0",');
    qry.SQL.Add('`Post061983Taxed` double default "0",');
    qry.SQL.Add('`Post061994Component` double default "0",');
    qry.SQL.Add('`GrossTermination` double default "0",');
    qry.SQL.Add('`TaxTermination` double default "0",');
    qry.SQL.Add('`AssessableTermination` double default "0",');
    qry.SQL.Add('`DeathBenefit` enum("T","F") default "F",');
    qry.SQL.Add('`TypeOfDeathBenefit` varchar(255) default NULL,');
    qry.SQL.Add('`RepCode` varchar(25) default NULL,');
    qry.SQL.Add('`Resident` enum("Y","N") default "Y",');
    qry.SQL.Add('`TFNApplicationMade` enum("Y","N") default "N",');
    qry.SQL.Add('`Under18` enum("Y","N") default "N",');
    qry.SQL.Add('`Pensioner` enum("Y","N") default "N",');
    qry.SQL.Add('`IncomeType` enum("S","P") default "S",');
    qry.SQL.Add('`BasisOfPayment` enum("F","P","C","L","S") default "F",');
    qry.SQL.Add('`TaxFreeThreshold` enum("Y","N") default "N",');
    qry.SQL.Add('`FamilyTaxBenefit` enum("Y","N") default "N",');
    qry.SQL.Add('`ZoneDependentSpecial` enum("Y","N") default "N",');
    qry.SQL.Add('`HECSIndicator` enum("T","F") default "F",');
    qry.SQL.Add('`StudentLoanIndicator` enum("T","F") default "F",');
    qry.SQL.Add('`UseOfTFNForSuper` enum("Y","N") default "N",');
    qry.SQL.Add('`AnnuitySuperPension` enum("Y","N") default "N",');
    qry.SQL.Add('`SignaturePresent` enum("Y","N") default "N",');
    qry.SQL.Add('`DateSigned` date default "1899-12-30",');
    qry.SQL.Add('`EmployeeName` varchar(255) default NULL, ');
    qry.SQL.Add('`PayVia` enum("N","S","T") default "N",');
    qry.SQL.Add('`ReportsTo` int(11) default NULL,');
    qry.SQL.Add('`PayPeriod` set("Weekly","Fortnightly","Monthly","Bi-Monthly","None") default NULL,');
    qry.SQL.Add('`Award` int(11) default NULL,');
    qry.SQL.Add('`Classification` varchar(255) default NULL,');
    qry.SQL.Add('`Department` int(11) default NULL,');
    qry.SQL.Add('`WorkersCompInsurer` int(11) default NULL,');
    qry.SQL.Add('`UseAward` enum("T","F") default "F",');
    qry.SQL.Add('`NextOfKin` varchar(150) default NULL,');
    qry.SQL.Add('`NextOfKinRelationship` varchar(100) default NULL,');
    qry.SQL.Add('`NextOfKinPhone` varchar(20) default NULL,');
    qry.SQL.Add('`TaxScaleID` int(11) default "2",');
    qry.SQL.Add('`WorkcoverID` int(11) default "0",');
    qry.SQL.Add('`LeaveLoading` double NOT NULL default "0",');
    qry.SQL.Add('`SickHours` double default "0",');
    qry.SQL.Add('`ALHours` double default "0",');
    qry.SQL.Add('`LastPaid` date default NULL,');
    qry.SQL.Add('`LastPayPeriod` tinyint(3) default "1",');
    qry.SQL.Add('`CommissionOnValue` enum("PROFIT","TOTALSALE") default "PROFIT",');
    qry.SQL.Add('`CommissionOnPaid` enum("T","F") default "T",');
    qry.SQL.Add('`CommissionLastPaid` date default NULL,');
    qry.SQL.Add('`PayNotes` text,');
    qry.SQL.Add('`IsOnTheRoster` enum("T","F") default "F",');
    qry.SQL.Add('`LoadHoursFromRoster` enum("T","F") default "F",');
    qry.SQL.Add('`LoadLeaveFromRoster` enum("T","F") default "F",');
    qry.SQL.Add('`MealBreakHours` double default "0",');
    qry.SQL.Add('`MealBreakThreshold` double default "0",');
    qry.SQL.Add('`AreaRange` varchar(255) default NULL,');
 //   qry.SQL.Add('`EmpPicture` longblob,');
    qry.SQL.Add('`PhotoIDVaildFromDate` date default NULL,');
    qry.SQL.Add('`PhotoIDVaildToDate` date default NULL,');
    qry.SQL.Add('`CDEPWageTotal` double default "0",');
    qry.SQL.Add('`IsTerminated` enum("T","F") default "F",');
    qry.SQL.Add('`DefaultClassName` varchar(255) default NULL,');
    qry.SQL.Add('`DefaultClassID` int(11) default "0",');
    qry.SQL.Add('`ExtraTaxOptions` enum("$","%","Fixed") default "$",');
    qry.SQL.Add('`ExtraTax` double default "0",');
    qry.SQL.Add('`UseClassificationAdvance` enum("T","F") default "F",');
    qry.SQL.Add('`CommissionInvoiceValue` enum("T","F") default "T",');
    qry.SQL.Add('`CommissionOnInvoices` enum("T","F") default "T",');
    qry.SQL.Add('`CommissionFlatRate` double default "0",');
    qry.SQL.Add('`CommissionOnGP` enum("T","F") default "F",');
    qry.SQL.Add('`CommissionInvoiceExPrice` enum("T","F") default "F",');
    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
    qry.SQL.Add('`CommissionUseEmp` enum("T","F") NOT NULL default "F",');
    qry.SQL.Add('`CommissionUseProd` enum("T","F") NOT NULL default "F",');
    qry.SQL.Add('`CommissionUseBoth` enum("T","F") NOT NULL default "F",');
    qry.SQL.Add('`PaySuperOnLeaveLoading` enum("T","F") default "F",');
    qry.SQL.Add('`DefaultInvoiceTemplateID` int(11) default NULL,');
    qry.SQL.Add('`LastUpdated` datetime default NULL,');
    qry.SQL.Add('`SalesTarget` double default NULL,');
    qry.SQL.Add('`SendPaySlipViaEmail` enum("T","F","B") default "F",');
    qry.SQL.Add('`EmailsFromEmployeeAddress` enum("T","F") default "T",');
    qry.SQL.Add('PRIMARY KEY  (`EmployeeID`),');
    qry.SQL.Add('UNIQUE KEY `Secondary` (`FirstName`,`LastName`),');
    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
    qry.SQL.Add('KEY `DefaultClassIDIndex` (`DefaultClassID`),');
    qry.SQL.Add('KEY `AwardIndex` (`Award`),');
    qry.SQL.Add('KEY `DepartmentIndex` (`Department`),');
    qry.SQL.Add('KEY `ReportsToIndex` (`ReportsTo`),');
    qry.SQL.Add('KEY `TaxScaleIDIndex` (`TaxScaleID`),');
    qry.SQL.Add('KEY `WorkcoverIDIndex` (`WorkcoverID`)');
    qry.SQL.Add(') TYPE=MyISAM;');

    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

//procedure TDataXMLObj.CreateTmp_PaysTax;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpaystax`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpaystax` (');
//    qry.SQL.Add('`GlobalRef` char(255) default NULL,');
//    qry.SQL.Add('`ID` int(10) NOT NULL auto_increment,');
//    qry.SQL.Add('`TaxID` int(10) ,');
//    qry.SQL.Add('`ScaleID` int(8) NOT NULL default "0",');
//    qry.SQL.Add('`Threshold` double NOT NULL default "0",');
//    qry.SQL.Add('`A` double default NULL,');
//    qry.SQL.Add('`B` double default NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//  finally
//    FreeAndNil(qry);
//  end;
//end;
//
//procedure TDataXMLObj.CreateTmp_Payssuperannuation;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpayssuperannuation`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpayssuperannuation` (');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`PaySuperID` int(11)  ,');
//    qry.SQL.Add('`PayID` int(11) default "0",');
//    qry.SQL.Add('`SuperID` int(11) default "0",');
//    qry.SQL.Add('`SuperTypeID` int(11) default "0",');
//    qry.SQL.Add('`ClientID` int(11) default "0",');
//    qry.SQL.Add('`AccountNo` varchar(50) default NULL,');
//    qry.SQL.Add('`DateJoined` date default NULL,');
//    qry.SQL.Add('`Amount` double default "0",');
//    qry.SQL.Add('`CalcBy` enum("$","%") default "%",');
//    qry.SQL.Add('`AmountPaid` double default "0",');
//    qry.SQL.Add('`BelowThreshold` enum("T","F") default "F",');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`ClassID` int(11) default "1",');
//    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
//    qry.SQL.Add('`AllClasses` enum("T","F") default "F",');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
//    qry.SQL.Add('KEY `IndexPayID` (`PayID`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//  finally
//    FreeAndNil(qry);
//  end;
//end;
//
//procedure TDataXMLObj.CreateTmp_Payscommission;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpayscommission`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpayscommission` (');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`PayCommissionID` int(11) unsigned, ');
//    qry.SQL.Add('`PayID` int(11) default "0",');
//    qry.SQL.Add('`CommissionID` int(11) default "0",');
//    qry.SQL.Add('`Gross` double default "0",');
//    qry.SQL.Add('`CommissionPercent` double default "0",');
//    qry.SQL.Add('`Net` double default "0",');
//    qry.SQL.Add('`PeriodID` int(11) default "0",');
//    qry.SQL.Add('`SuperInc` enum("T","F") default "F",');
//    qry.SQL.Add('`TaxExempt` enum("T","F") default "F",');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`CommissionDesc` varchar(255) default NULL,');
//    qry.SQL.Add('`EmployeeID` int(11) default "0",');
//    qry.SQL.Add('`ClassID` int(11) default "1",');
//    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
//    qry.SQL.Add('KEY `IndexPayID` (`PayID`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//  finally
//    FreeAndNil(qry);
//  end;
//end;
//
//procedure TDataXMLObj.CreateTmp_Payssundries;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpayssundries`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpayssundries` (');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`PaySundryID` int(11) ,');
//    qry.SQL.Add('`PayID` int(11) default "0",');
//    qry.SQL.Add('`SundryID` int(11) default "0",');
//    qry.SQL.Add('`Sundry` varchar(255) default NULL,');
//    qry.SQL.Add('`Amount` double default "0",');
//    qry.SQL.Add('`GST` double default "0",');
//    qry.SQL.Add('`SuperInc` enum("T","F") default "F",');
//    qry.SQL.Add('`TaxExempt` enum("T","F") default "F",');
//    qry.SQL.Add('`ClientID` int(11) default "0",');
//    qry.SQL.Add('`ClassID` int(11) default "0",');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
//    qry.SQL.Add('KEY `IndexPayID` (`PayID`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//  finally
//    FreeAndNil(qry);
//  end;
//end;
//
//procedure TDataXMLObj.CreateTmp_Paysdeductions;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpaysdeductions`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpaysdeductions` (');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`PayDeductionID` int(11) ,');
//    qry.SQL.Add('`PayID` int(11) default "0",');
//    qry.SQL.Add('`DeductionID` int(11) default "0",');
//    qry.SQL.Add('`Notes` varchar(50) default NULL,');
//    qry.SQL.Add('`Qty` double default "0",');
//    qry.SQL.Add('`BasedOnID` int(11) default "0",');
//    qry.SQL.Add('`Amount` double default NULL,');
//    qry.SQL.Add('`CalcBy` enum("$","%") default "$",');
//    qry.SQL.Add('`TaxExempt` enum("T","F") default "F",');
//    qry.SQL.Add('`UnionFees` enum("T","F") default "F",');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`ClassID` int(11) default "1",');
//    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
//    qry.SQL.Add('KEY `IndexPayID` (`PayID`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//  finally
//    FreeAndNil(qry);
//  end;
//
//end;

//procedure TDataXMLObj.CreateTmp_Paysallowances;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpaysallowances`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpaysallowances` (');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`PayAllowanceID` int(11) unsigned,');
//    qry.SQL.Add('`PayID` int(11) default "0",');
//    qry.SQL.Add('`AllowanceID` int(11) default "0",');
//    qry.SQL.Add('`Qty` double default "0",');
//    qry.SQL.Add('`BasedOnID` int(11) default "0",');
//    qry.SQL.Add('`Amount` double default "0",');
//    qry.SQL.Add('`CalcBy` enum("$","%") default "$",');
//    qry.SQL.Add('`SuperInc` enum("T","F") default "F",');
//    qry.SQL.Add('`TaxExempt` enum("T","F") default "F",');
//    qry.SQL.Add('`ClientID` int(11) default "0",');
//    qry.SQL.Add('`ClassID` int(11) default "0",');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
//    qry.SQL.Add('KEY `IndexPayID` (`PayID`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//  finally
//    FreeAndNil(qry);
//  end;
//
//end;

procedure TDataXMLObj.CreateTmp_Paysleave;
var
  qry: TMyCommand;
begin
  qry := TMyCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpaysleave`;');
    qry.Execute;

    qry.SQL.Clear;

    qry.SQL.Add('CREATE TABLE `tmp_tblpaysleave` (');
    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
    qry.SQL.Add('`LeaveID` int(11) default NULL,');
    qry.SQL.Add('`EmployeeID` int(11) default "0",');
    qry.SQL.Add('`Type` varchar(255) NOT NULL default "",');
    qry.SQL.Add('`AccrueAfterNo` double default NULL,');
    qry.SQL.Add('`AccrueAfterPeriod` varchar(255) default NULL,');
    qry.SQL.Add('`AccrueNo` double default NULL,');
    qry.SQL.Add('`AccruePeriod` varchar(255) default NULL,');
    qry.SQL.Add('`AccrueHours` double default NULL,');
    qry.SQL.Add('`AccruedHours` double default NULL,');
    qry.SQL.Add('`AccruedDate` date default NULL,');
    qry.SQL.Add('`MaxHours` double default "0",');
    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
    qry.SQL.Add('`TypeID` int(11) default "0",');
    qry.SQL.Add('`ClassID` int(11) default "1",');
    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
    qry.SQL.Add('`OpenningBalanceHrs` double default "0",');
    qry.SQL.Add('`OpenningBalanceDate` date default NULL,');
    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
    qry.SQL.Add('`StartDate` date default NULL,');
    qry.SQL.Add('`EndDate` date default NULL,');
    qry.SQL.Add('`UseStartEndDates` enum("T","F") default "F",');
    qry.SQL.Add('`LeaveLoading` double default "0",');
    qry.SQL.Add('PRIMARY KEY  (`ID`),');
    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`),');
    qry.SQL.Add('KEY `IndexEmployeeID` (`EmployeeID`)');
    qry.SQL.Add(') TYPE=MyISAM;');
    
    qry.Execute;

  finally
    FreeAndNil(qry);
  end;
end;

//procedure TDataXMLObj.CreateTmp_PayPayRates;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpayspayrates`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpayspayrates` (');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`PaysPayRateID` int(11) default "0",');
//    qry.SQL.Add('`PayID` int(11) default NULL,');
//    qry.SQL.Add('`PayRateID` int(11) default NULL,');
//    qry.SQL.Add('`TypeID` int(11) default NULL,');
//    qry.SQL.Add('`Qty` double default NULL,');
//    qry.SQL.Add('`Amount` double default NULL,');
//    qry.SQL.Add('`LineTotal` double default NULL,');
//    qry.SQL.Add('`SuperInc` enum("T","F") default "T",');
//    qry.SQL.Add('`ClientID` int(11) default NULL,');
//    qry.SQL.Add('`ClassID` int(11) default NULL,');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`ClassName` varchar(255) default NULL,');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//    qry.SQL.Add('`TimeSheetId` int(11) default NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//
//  finally
//    FreeAndNil(qry);
//  end;
//end;
//
//
//procedure TDataXMLObj.CreateTmp_PaysSplits;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpayssplits`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpayssplits` (');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`PaySplitID` int(11) default "0",');
//    qry.SQL.Add('`PayID` int(11) default NULL,');
//    qry.SQL.Add('`Type` varchar(32) default NULL,');
//    qry.SQL.Add('`Split` enum("Cash","Cheque","Bank") default "Bank",');
//    qry.SQL.Add('`BankID` int(11) default NULL,');
//    qry.SQL.Add('`Branch` varchar(64) default NULL,');
//    qry.SQL.Add('`BSB` varchar(16) default NULL,');
//    qry.SQL.Add('`AccountNo` varchar(32) default NULL,');
//    qry.SQL.Add('`Amount` double default 0.00,');
//    qry.SQL.Add('`AccountName` varchar(64) default NULL,');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//
//  finally
//    FreeAndNil(qry);
//  end;
//end;
//procedure TDataXMLObj.CreateTmp_Pays;
//var
//  qry: TMyCommand;
//begin
//  qry := TMyCommand.Create(nil);
//  try
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('DROP TABLE IF EXISTS `tmp_tblpays`;');
//    qry.Execute;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('CREATE TABLE `tmp_tblpays` (');
//    qry.SQL.Add('`ID` int(11) NOT NULL auto_increment ,');
//    qry.SQL.Add('`GlobalRef` varchar(255) default NULL,');
//    qry.SQL.Add('`PayID` int(11) default "0",');
//    qry.SQL.Add('`EmployeeID` int(11) default "0",');
//    qry.SQL.Add('`PayDate` date default NULL,');
//    qry.SQL.Add('`DatePaid` date default NULL,');
//    qry.SQL.Add('`PayPeriods` tinyint(3) default "1",');
//    qry.SQL.Add('`Wages` double default "0",');
//    qry.SQL.Add('`Commission` double default "0",');
//    qry.SQL.Add('`Deductions` double default "0",');
//    qry.SQL.Add('`Allowances` double default "0",');
//    qry.SQL.Add('`AllowancesBeforeTax` double default "0",');
//    qry.SQL.Add('`Sundries` double default "0",');
//    qry.SQL.Add('`Superannuation` double default "0",');
//    qry.SQL.Add('`Gross` double default "0",');
//    qry.SQL.Add('`GrossTaxable` double default "0",');
//    qry.SQL.Add('`Tax` double default "0",');
//    qry.SQL.Add('`Net` double default "0",');
//    qry.SQL.Add('`Pay` enum("T","F") default "T",');
//    qry.SQL.Add('`Paid` enum("T","F") default "F",');
//    qry.SQL.Add('`EditedFlag` enum("T","F") default "T",');
//    qry.SQL.Add('`Printed` enum("T","F") default "F",');
//    qry.SQL.Add('`EmpName` varchar(50) default NULL,');
//    qry.SQL.Add('`LeaveLoading` double default "0",');
//    qry.SQL.Add('`ClassID` int(11) default NULL,');
//    qry.SQL.Add('`Class` varchar(255) default NULL,');
//    qry.SQL.Add('`IsTimesheet` enum("T","F") default "F",');
//    qry.SQL.Add('`PayPeriod` varchar(255) default NULL,');
//    qry.SQL.Add('`AnnualLeaveRate` double default NULL,');
//    qry.SQL.Add('`CDEPGross` double default "0",');
//    qry.SQL.Add('`LumpA` double default "0",');
//    qry.SQL.Add('`LumpB` double default "0",');
//    qry.SQL.Add('`LumpD` double default "0",');
//    qry.SQL.Add('`LumpE` double default "0",');
//    qry.SQL.Add('`ETP` double default "0",');
//    qry.SQL.Add('`ManualTax` enum("T","F") default "F",');
//    qry.SQL.Add('`Deleted` enum("T","F") default "F",');
//    qry.SQL.Add('`IsNewTypePay` enum("T","F") default "T",');
//    qry.SQL.Add('`msTimeStamp` timestamp(14) NOT NULL,');
//    qry.SQL.Add('`PaySuperOnLeaveLoading` enum("T","F") default "T",');
//    qry.SQL.Add('`PayNotes` text,');
//    qry.SQL.Add('`PayVersion` int(11) default NULL,');
//    qry.SQL.Add('PRIMARY KEY  (`ID`),');
//    qry.SQL.Add('KEY `GlobalRefIndex` (`GlobalRef`)');
//    qry.SQL.Add(') TYPE=MyISAM;');
//
//    qry.Execute;
//
//  finally
//    FreeAndNil(qry);
//  end;
//end;


procedure TDataXMLObj.CreateAndLoadTmpTables(const iPayID:integer);
begin
  //CreateTmp_Pays;
  //CreateTmp_PayPayRates;
//  CreateTmp_Paysdeductions;
//  CreateTmp_Payssundries;
//  CreateTmp_Payscommission;
//  CreateTmp_Payssuperannuation;
  CreateTmp_Paysleave;
 // CreateTmp_Paysallowances;
//  CreateTmp_PaysTax;
//  CreateTmp_PaysSplits;

  CreateTmp_Employees;
  CreateTmp_EmployeePayRates ;
  CreateTmp_Employeedeductions;
  CreateTmp_EmployeeAllowances;
  CreateTmp_tblsuperannuation;

//  LoadTmp_table(iPayID,'Pays');
  //LoadTmp_table(iPayID,'PaysPayRates');
//  LoadTmp_table(iPayID,'Paysdeductions');
//  LoadTmp_table(iPayID,'Payssundries');
//  LoadTmp_table(iPayID,'Payscommission');
//  LoadTmp_table(iPayID,'Payssuperannuation');
  LoadTmp_table(iPayID,'Paysleave');
 // LoadTmp_table(iPayID,'Paysallowances');
//  LoadTmp_table(iPayID,'PaysTax');
//  LoadTmp_table(iPayID,'PaysSplits');

  LoadTmp_Employeetable('Employees');
  LoadTmp_Employeetable('EmployeePayRates');
  LoadTmp_Employeetable('EmployeeDeductions');
  LoadTmp_Employeetable('Superannuation');
  LoadTmp_Employeetable('EmployeeAllowances');

end;

procedure TDataXMLObj.SnapshotXMLPayData;
var
  nNewPay,nLeaves,nLeaveType, ValueNode,nPayRec,nIndent: IXMLNode;
  nPaysPayRates,nPaysPayRateID,nPaysPaySplits,nPaysPaySplitID,nTaxScales,nTaxScaleID: IXMLNode;
  nMiscVars,nSuper,nPaySuperID,nAllowances,nPayAllowanceID: IXMLNode;
  nDeductions,nPayDeductionID,nSundries,nPaySundryID : IXMLNode;
  nCommissions,nCommissionID: IXMLNode;
  XMLDoc2: TXMLDocument;
  i : integer;
  bm: TBookmark;
  qry: TMyQuery;
begin
  XMLDoc2 := TXMLDocument.Create(nil);
  XMLDoc2.Active := True;

  nNewPay :=  XMLDoc2.AddChild('Pay');

  nNewPay.Attributes['PayID'] := FastFuncs.IntToStr(TPayObj(foOwner).DataSet.FieldByName('PayID').AsInteger);  //FPayRates.DataSet.FieldByName('PayID').AsString;

  nPayRec := nNewPay.AddChild('Pays',0);
  nIndent := nPayRec.AddChild('Indent');  //keep the structure the same as others so can use generic function later
  //Add Pay details
  ValueNode := nIndent.AddChild('PayDate');
  ValueNode.Text := FormatDateTime('yyyy-mm-dd',TPayObj(foOwner).DataSet.FieldByName('PayDate').asDateTime);
  ValueNode :=  nIndent.AddChild('DatePaid');
  ValueNode.Text := FormatDateTime('yyyy-mm-dd',TPayObj(foOwner).DataSet.FieldByName('DatePaid').asDateTime);

  for i := 0 to TPayObj(foOwner).DataSet.FieldCount- 1 do begin  
    if TPayObj(foOwner).DataSet.FieldList.Fields[i].FieldName = 'PayXMLData' then continue; //we don't want the PayXMLData field as this will be the xml data
    if (TPayObj(foOwner).DataSet.FieldList.Fields[i].FieldName <> 'PayDate') and (TPayObj(foOwner).DataSet.FieldList.Fields[i].FieldName <> 'DatePaid')
         and not (TPayObj(foOwner).DataSet.FieldList.Fields[i].IsNull) then begin
      ValueNode := nIndent.AddChild(TPayObj(foOwner).DataSet.FieldList.Fields[i].FieldName);
      try
        ValueNode.Text := TPayObj(foOwner).DataSet.FieldList.Fields[i].Value;
      except

      end;
    end;
  end;

  //Add Tax Scale
  nTaxScales :=  nNewPay.AddChild('PaysTax',0);

  qry := TMyQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tbltax WHERE ScaleID = ');
    qry.SQL.Add(FastFuncs.IntToStr(TPayObj(foOwner).Employee.EmployeeSettings.TaxScale));
    qry.SQL.Add(' ORDER BY TaxID');    
    qry.Open;

    qry.First;
    with qry do begin
      while not Eof do begin
        nTaxScaleID := nTaxScales.AddChild('TaxID');
        nTaxScaleID.Attributes['TaxID'] := FieldByName('TaxID').AsString;

        ValueNode :=  nTaxScaleID.AddChild('ScaleID');
        ValueNode.Text :=  FieldByName('ScaleID').AsString;
        ValueNode :=  nTaxScaleID.AddChild('TaxID');
        ValueNode.Text := FieldByName('TaxID').AsString;
        ValueNode :=  nTaxScaleID.AddChild('Threshold');
        ValueNode.Text := FieldByName('Threshold').AsString;
        ValueNode :=  nTaxScaleID.AddChild('A');
        ValueNode.Text := FieldByName('A').AsString;
        ValueNode :=  nTaxScaleID.AddChild('B');
        ValueNode.Text := FieldByName('B').AsString;
          
        Next;
      end;
    end;
  finally

    FreeAndNil(qry);
  end;

  //Add PayRate details

  nPaysPayRates :=  nNewPay.AddChild('PaysPayRates',0);
  bm := TPayObj(foOwner).PayRates.DataSet.GetBookmark;

  try
    TPayObj(foOwner).PayRates.DataSet.First;
    while not TPayObj(foOwner).PayRates.DataSet.Eof do begin
      nPaysPayRateID := nPaysPayRates.AddChild('PaysPayRateID');
      nPaysPayRateID.Attributes['PaysPayRateID'] := TPayObj(foOwner).PayRates.DataSet.FieldByName('PaysPayRateID').AsString;

      ValueNode :=  nPaysPayRateID.AddChild('PayRateID');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('PayRateID').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('PayID');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('PayID').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('TypeID');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('TypeID').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('Qty');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('Qty').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('Amount');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('Amount').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('SuperInc');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('SuperInc').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('LineTotal');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('LineTotal').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('ClientID');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('ClientID').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('ClassID');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('ClassID').AsString;
      ValueNode :=  nPaysPayRateID.AddChild('TimeSheetID');
      ValueNode.Text := TPayObj(foOwner).PayRates.DataSet.FieldByName('TimeSheetID').AsString;

      TPayObj(foOwner).PayRates.DataSet.Next;
    end;
    TPayObj(foOwner).PayRates.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).PayRates.DataSet.FreeBookmark(bm);
  end;

  //Add PaySplit details

  nPaysPaySplits :=  nNewPay.AddChild('PaysSplits',0);
  bm := TPayObj(foOwner).PayPaySplits.DataSet.GetBookmark;

  try
    TPayObj(foOwner).PayPaySplits.DataSet.First;
    while not TPayObj(foOwner).PayPaySplits.DataSet.Eof do begin
      nPaysPaySplitID := nPaysPaySplits.AddChild('PaySplitID');
      nPaysPaySplitID.Attributes['PaySplitID'] := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('PaySplitID').AsString;

      ValueNode :=  nPaysPaySplitID.AddChild('PaySplitID');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('PaySplitID').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('PayID');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('PayID').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('Type');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('Type').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('Split');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('Split').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('BankID');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('BankID').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('Branch');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('Branch').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('BSB');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('BSB').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('AccountNo');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('AccountNo').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('Amount');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('Amount').AsString;
      ValueNode :=  nPaysPaySplitID.AddChild('AccountName');
      ValueNode.Text := TPayObj(foOwner).PayPaySplits.DataSet.FieldByName('AccountName').AsString;

      TPayObj(foOwner).PayPaySplits.DataSet.Next;
    end;
    TPayObj(foOwner).PayPaySplits.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).PayPaySplits.DataSet.FreeBookmark(bm);
  end;

       //Add MiscVars details
  nMiscVars :=  nNewPay.AddChild('MiscVars',0);
  ValueNode :=  nMiscVars.AddChild('EmploymentBasis');
  ValueNode.Text := TPayObj(foOwner).Employee.EmployeeSettings.EmploymentBasis;

        //Add Super details
  nSuper :=  nNewPay.AddChild('Payssuperannuation',0);

  bm := TPayObj(foOwner).Superannuation.DataSet.GetBookmark;

  try
    TPayObj(foOwner).Superannuation.DataSet.First;
    while not TPayObj(foOwner).Superannuation.DataSet.Eof do begin
      nPaySuperID :=  nSuper.AddChild('PaySuperID');
      nPaySuperID.Attributes['PaySuperID'] := TPayObj(foOwner).Superannuation.DataSet.FieldByName('PaySuperID').AsString;
      ValueNode :=  nPaySuperID.AddChild('SuperID');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('SuperID').AsString;
      ValueNode :=  nPaySuperID.AddChild('SuperTypeID');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('SuperTypeID').AsString;
      ValueNode :=  nPaySuperID.AddChild('ClientID');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('ClientID').AsString;
      ValueNode :=  nPaySuperID.AddChild('AccountNo');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('AccountNo').AsString;
      ValueNode :=  nPaySuperID.AddChild('DateJoined');
      ValueNode.Text := FormatDateTime('yyyy-mm-dd',TPayObj(foOwner).Superannuation.DataSet.FieldByName('DateJoined').AsDateTime);
      ValueNode :=  nPaySuperID.AddChild('AmountPaid');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('AmountPaid').AsString;
      ValueNode :=  nPaySuperID.AddChild('ClassID');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('ClassID').AsString;
      ValueNode :=  nPaySuperID.AddChild('ClassName');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('ClassName').AsString;
      ValueNode :=  nPaySuperID.AddChild('AllClasses');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('AllClasses').AsString;
      ValueNode :=  nPaySuperID.AddChild('Amount');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('Amount').AsString;
      ValueNode :=  nPaySuperID.AddChild('CalcBy');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('CalcBy').AsString;
      ValueNode :=  nPaySuperID.AddChild('BelowThreshold');
      ValueNode.Text := TPayObj(foOwner).Superannuation.DataSet.FieldByName('BelowThreshold').AsString;

      TPayObj(foOwner).Superannuation.DataSet.Next;
    end;
    TPayObj(foOwner).Superannuation.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).Superannuation.DataSet.FreeBookmark(bm);
  end;

         //Add Allowances details
  nAllowances :=  nNewPay.AddChild('Paysallowances',0);
  bm := TPayObj(foOwner).Allowances.DataSet.GetBookmark;

  try
    TPayObj(foOwner).Allowances.DataSet.First;
    while not TPayObj(foOwner).Allowances.DataSet.Eof do begin
      nPayAllowanceID :=  nAllowances.AddChild('PayAllowanceID');
      nPayAllowanceID.Attributes['PayAllowanceID'] := TPayObj(foOwner).Allowances.DataSet.FieldByName('PayAllowanceID').AsString;

      ValueNode :=  nPayAllowanceID.AddChild('AllowanceID');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('AllowanceID').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('Qty');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('Qty').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('BasedOnID');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('BasedOnID').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('Amount');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('Amount').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('CalcBy');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('CalcBy').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('SuperInc');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('SuperInc').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('TaxExempt');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('TaxExempt').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('ClassID');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('ClassID').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('ClassName');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('ClassName').AsString;
      ValueNode :=  nPayAllowanceID.AddChild('ClientID');
      ValueNode.Text := TPayObj(foOwner).Allowances.DataSet.FieldByName('ClientID').AsString;

      TPayObj(foOwner).Allowances.DataSet.Next;
    end;
    TPayObj(foOwner).Allowances.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).Allowances.DataSet.FreeBookmark(bm);
  end;
         //Add Deduction details
  nDeductions :=  nNewPay.AddChild('Paysdeductions',0);
  bm := TPayObj(foOwner).Deductions.DataSet.GetBookmark;

  try
    TPayObj(foOwner).Deductions.DataSet.First;
    while not TPayObj(foOwner).Deductions.DataSet.Eof do begin
      nPayDeductionID := nDeductions.AddChild('PayDeductionID');
      nPayDeductionID.Attributes['PayDeductionID'] := TPayObj(foOwner).Deductions.DataSet.FieldByName('PayDeductionID').AsString;

      ValueNode :=  nPayDeductionID.AddChild('DeductionID');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('DeductionID').AsString;
      ValueNode :=  nPayDeductionID.AddChild('Qty');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('Qty').AsString;
      ValueNode :=  nPayDeductionID.AddChild('BasedOnID');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('BasedOnID').AsString;
      ValueNode :=  nPayDeductionID.AddChild('Amount');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('Amount').AsString;
      ValueNode :=  nPayDeductionID.AddChild('CalcBy');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('CalcBy').AsString;
      ValueNode :=  nPayDeductionID.AddChild('TaxExempt');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('TaxExempt').AsString;
      ValueNode :=  nPayDeductionID.AddChild('UnionFees');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('UnionFees').AsString;
      ValueNode :=  nPayDeductionID.AddChild('ClassID');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('ClassID').AsString;
      ValueNode :=  nPayDeductionID.AddChild('ClassName');
      ValueNode.Text := TPayObj(foOwner).Deductions.DataSet.FieldByName('ClassName').AsString;

      TPayObj(foOwner).Deductions.DataSet.Next;
    end;
    TPayObj(foOwner).Deductions.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).Deductions.DataSet.FreeBookmark(bm);
  end;

          //Add Sundry details
  nSundries :=  nNewPay.AddChild('Payssundries',0);
  bm := TPayObj(foOwner).Sundries.DataSet.GetBookmark;

  try
    TPayObj(foOwner).Sundries.DataSet.First;
    while not TPayObj(foOwner).Sundries.DataSet.Eof do begin
      nPaySundryID := nSundries.AddChild('PaySundryID');
      nPaySundryID.Attributes['PaySundryID'] := TPayObj(foOwner).Sundries.DataSet.FieldByName('PaySundryID').AsString;
      ValueNode :=  nPaySundryID.AddChild('SundryID');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('SundryID').AsString;
      ValueNode :=  nPaySundryID.AddChild('Sundry');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('Sundry').AsString;
      ValueNode :=  nPaySundryID.AddChild('Amount');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('Amount').AsString;
      ValueNode :=  nPaySundryID.AddChild('GST');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('GST').AsString;
      ValueNode :=  nPaySundryID.AddChild('SuperInc');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('SuperInc').AsString;
      ValueNode :=  nPaySundryID.AddChild('TaxExempt');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('TaxExempt').AsString;
      ValueNode :=  nPaySundryID.AddChild('ClassID');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('ClassID').AsString;
      ValueNode :=  nPaySundryID.AddChild('ClassName');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('ClassName').AsString;
      ValueNode :=  nPaySundryID.AddChild('ClientID');
      ValueNode.Text := TPayObj(foOwner).Sundries.DataSet.FieldByName('ClientID').AsString;

      TPayObj(foOwner).Sundries.DataSet.Next;
    end;
    TPayObj(foOwner).Sundries.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).Sundries.DataSet.FreeBookmark(bm);
  end;

       //Add Commission details
  nCommissions := nNewPay.AddChild('Payscommission',0);
  bm := TPayObj(foOwner).Commission.DataSet.GetBookmark;

  try
    TPayObj(foOwner).Commission.DataSet.First;
    while not TPayObj(foOwner).Commission.DataSet.Eof do begin
      nCommissionID := nCommissions.AddChild('CommissionID');
      nCommissionID.Attributes['CommissionID'] := TPayObj(foOwner).Commission.DataSet.FieldByName('CommissionID').AsString;
      ValueNode :=  nCommissionID.AddChild('CommissionID');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('CommissionID').AsString;
      ValueNode :=  nCommissionID.AddChild('Gross');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('Gross').AsString;
      ValueNode :=  nCommissionID.AddChild('CommissionPercent');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('CommissionPercent').AsString;
      ValueNode :=  nCommissionID.AddChild('Net');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('Net').AsString;
      ValueNode :=  nCommissionID.AddChild('PeriodID');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('PeriodID').AsString;
      ValueNode :=  nCommissionID.AddChild('SuperInc');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('SuperInc').AsString;
      ValueNode :=  nCommissionID.AddChild('TaxExempt');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('TaxExempt').AsString;
      ValueNode :=  nCommissionID.AddChild('CommissionDesc');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('CommissionDesc').AsString;
      ValueNode :=  nCommissionID.AddChild('EmployeeID');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('EmployeeID').AsString;
      ValueNode :=  nCommissionID.AddChild('ClassID');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('ClassID').AsString;
      ValueNode :=  nCommissionID.AddChild('ClassName');
      ValueNode.Text := TPayObj(foOwner).Commission.DataSet.FieldByName('ClassName').AsString;

      TPayObj(foOwner).Commission.DataSet.Next;
    end;
    TPayObj(foOwner).Commission.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).Commission.DataSet.FreeBookmark(bm);
  end;

  //add leave
  bm := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.GetBookmark;
  try
    TPayObj(foOwner).Leave.LeaveAccrued.DataSet.First;
    nLeaves :=  nNewPay.AddChild('Paysleave',0);
    //with TPayObj(foOwner).Leave.LeaveAccrued.DataSet do begin
      while not TPayObj(foOwner).Leave.LeaveAccrued.DataSet.Eof do begin
        nLeaveType :=  nLeaves.AddChild('LeaveType');
        nLeaveType.Attributes['LeaveID'] :=  TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('LeaveID').AsString;
        ValueNode :=  nLeaveType.AddChild('LeaveID');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('LeaveID').AsString;
        ValueNode :=  nLeaveType.AddChild('EmployeeID');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('EmployeeID').AsString;
        ValueNode :=  nLeaveType.AddChild('Type');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('Type').AsString;
        ValueNode :=  nLeaveType.AddChild('AccrueAfterNo');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('AccrueAfterNo').AsString;
        ValueNode :=  nLeaveType.AddChild('AccrueAfterPeriod');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('AccrueAfterPeriod').AsString;
        ValueNode :=  nLeaveType.AddChild('AccrueNo');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('AccrueNo').AsString;
        ValueNode :=  nLeaveType.AddChild('AccruePeriod');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('AccruePeriod').AsString;
        ValueNode :=  nLeaveType.AddChild('AccrueHours');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('AccrueHours').AsString;
        ValueNode :=  nLeaveType.AddChild('AccruedHours');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('AccruedHours').AsString;
        ValueNode :=  nLeaveType.AddChild('AccruedDate');
        ValueNode.Text := FormatDateTime('yyyy-mm-dd',TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('AccruedDate').AsDateTime);
        ValueNode :=  nLeaveType.AddChild('MaxHours');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('MaxHours').AsString;
        ValueNode :=  nLeaveType.AddChild('TypeID');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('TypeID').AsString;
        ValueNode :=  nLeaveType.AddChild('ClassID');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('ClassID').AsString;
        ValueNode :=  nLeaveType.AddChild('ClassName');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('ClassName').AsString;
        ValueNode :=  nLeaveType.AddChild('OpenningBalanceHrs');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('OpenningBalanceHrs').AsString;
        ValueNode :=  nLeaveType.AddChild('OpenningBalanceDate');
        ValueNode.Text := FormatDateTime('yyyy-mm-dd',TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('OpenningBalanceDate').AsDateTime);
        ValueNode :=  nLeaveType.AddChild('StartDate');
        ValueNode.Text := FormatDateTime('yyyy-mm-dd',TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('StartDate').AsDateTime);
        ValueNode :=  nLeaveType.AddChild('EndDate');
        ValueNode.Text := FormatDateTime('yyyy-mm-dd',TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('EndDate').AsDateTime);
        ValueNode :=  nLeaveType.AddChild('UseStartEndDates');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('UseStartEndDates').AsString;
        ValueNode :=  nLeaveType.AddChild('LeaveLoading');
        ValueNode.Text := TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FieldByName('LeaveLoading').AsString;

        TPayObj(foOwner).Leave.LeaveAccrued.DataSet.Next;
      end;
    //end;
      TPayObj(foOwner).Leave.LeaveAccrued.DataSet.GotoBookmark(bm);
  finally
    TPayObj(foOwner).Leave.LeaveAccrued.DataSet.FreeBookmark(bm);
  end;

  //add employeePayData

  AddEmployeePayData(XMLDoc2, TPayObj(foOwner).Employee.EmployeeID,nNewPay);

  with TPayObj(foOwner).DataSet do begin
    Edit;
    FieldByName('PayXMLData').AsString := XMLDoc2.XML.Text;
    Post;
  end;
end;

procedure TDataXMLObj.AddEmployeePayData(const XMLDoc2: TXMLDocument; const EmployeeID:Integer; const nNewPay:IXMLNode);
var
  bm                    :TBookmark;
  DSEmployee            :TDataSet;
  DSEmployeePayRates    :TDataSet;
  DSEmployeeAllowances  :TDataSet;
  DSEmployeeDeductions  :TDataSet;
  DSEmployeeSuper       :TDataSet;
  DSEmployeePaySplits   :TDataSet;

  ValueNode,nIndent,nIndent2 : IXMLNode;
  i:integer;
begin
  DSEmployee := RetrieveDataset('tblEmployees', 'EmployeeID',EmployeeID);
  DSEmployeePayRates := RetrieveDataset('tblemployeepayrates', 'EmployeeID',EmployeeID);
  DSEmployeeAllowances := RetrieveDataset('tblemployeeallowances', 'EmployeeID',EmployeeID);
  DSEmployeeDeductions := RetrieveDataset('tblemployeedeductions', 'EmployeeID',EmployeeID);
  DSEmployeeSuper := RetrieveDataset('tblsuperannuation', 'EmployeeID',EmployeeID);
  DSEmployeePaySplits := RetrieveDataset('tblpaysplit', 'EmployeeID',EmployeeID);
  //Add Employee details

  nIndent :=  nNewPay.AddChild('Employees',0);
  nIndent2 := nIndent.AddChild('EmployeeDetails',0);
  for i := 0 to DSEmployee.FieldCount- 1 do begin
    if (DSEmployee.FieldList.Fields[i].FieldName = 'EmpPicture')
          or (DSEmployee.FieldList.Fields[i].FieldName = 'msTimeStamp')  then continue;
    if  not (DSEmployee.FieldList.Fields[i].IsNull) then begin
      if (FastFuncs.PosEx('date',DSEmployee.FieldList.Fields[i].FieldName) = 0) and (FastFuncs.PosEx('Date',DSEmployee.FieldList.Fields[i].FieldName) = 0)
              and not (DSEmployee.FieldList.Fields[i].FieldName = 'DOB')
              and not (DSEmployee.FieldList.Fields[i].FieldName = 'DateSigned')
              and not (DSEmployee.FieldList.Fields[i].FieldName = 'LastPaid') then
      begin
        ValueNode := nIndent2.AddChild(DSEmployee.FieldList.Fields[i].FieldName);
        try
          ValueNode.Text := DSEmployee.FieldList.Fields[i].Value;
        except

        end;
      end else begin        //dates
        ValueNode := nIndent2.AddChild(DSEmployee.FieldList.Fields[i].FieldName);
        ValueNode.Text := FormatDateTime('yyyy-mm-dd',DSEmployee.FieldByName(DSEmployee.FieldList.Fields[i].FieldName).asDateTime);
      end;
    end;
  end;

  //Add EmployeePayRates

  nIndent :=  nNewPay.AddChild('EmployeePayRates',0);
  bm := DSEmployeePayRates.GetBookmark;

  try
    DSEmployeePayRates.First;
    while not DSEmployeePayRates.Eof do begin
      nIndent2 := nIndent.AddChild('EmployeeRateID');
      nIndent2.Attributes['EmployeeRateID'] := DSEmployeePayRates.FieldByName('EmployeeRateID').AsString;

      for i := 0 to DSEmployeePayRates.FieldCount- 1 do begin
        if  not (DSEmployeePayRates.FieldList.Fields[i].IsNull) then begin
          if DSEmployeePayRates.FieldList.Fields[i].FieldName = 'msTimeStamp' then continue;
          ValueNode := nIndent2.AddChild(DSEmployeePayRates.FieldList.Fields[i].FieldName);
          try
            ValueNode.Text := DSEmployeePayRates.FieldList.Fields[i].Value;
          except

          end;
        end
      end;
      DSEmployeePayRates.Next;
    end;

    DSEmployeePayRates.GotoBookmark(bm);
  finally
    DSEmployeePayRates.FreeBookmark(bm);
  end;

  //Add EmployeePaySplits

  nIndent :=  nNewPay.AddChild('EmployeePaySplits');  //,0);
  bm := DSEmployeePaySplits.GetBookmark;

  try
    DSEmployeePaySplits.First;
    while not DSEmployeePaySplits.Eof do begin
      nIndent2 := nIndent.AddChild('EmployeeSplitID');
      nIndent2.Attributes['EmployeeSplitID'] := DSEmployeePaySplits.FieldByName('SplitID').AsString;

      for i := 0 to DSEmployeePaySplits.FieldCount- 1 do begin
        if  not (DSEmployeePaySplits.FieldList.Fields[i].IsNull) then begin
          if DSEmployeePaySplits.FieldList.Fields[i].FieldName = 'msTimeStamp' then continue;
          ValueNode := nIndent2.AddChild(DSEmployeePaySplits.FieldList.Fields[i].FieldName);
          try
            ValueNode.Text := DSEmployeePaySplits.FieldList.Fields[i].Value;
          except

          end;
        end
      end;
      DSEmployeePaySplits.Next;
    end;

    DSEmployeePaySplits.GotoBookmark(bm);
  finally
    DSEmployeePaySplits.FreeBookmark(bm);
  end;
  //Add employeeAllowances
  nIndent :=  nNewPay.AddChild('EmployeeAllowances',0);
  bm := DSEmployeeAllowances.GetBookmark;

  try
    DSEmployeeAllowances.First;
    while not DSEmployeeAllowances.Eof do begin
      nIndent2 := nIndent.AddChild('AllowanceID');
      nIndent2.Attributes['AllowanceID'] := DSEmployeeAllowances.FieldByName('AllowanceID').AsString;

      for i := 0 to DSEmployeeAllowances.FieldCount- 1 do begin
        if  not (DSEmployeeAllowances.FieldList.Fields[i].IsNull) then begin
          if DSEmployeeAllowances.FieldList.Fields[i].FieldName = 'msTimeStamp' then continue;
          if (FastFuncs.PosEx('date',DSEmployeeAllowances.FieldList.Fields[i].FieldName) = 0)
                           and (FastFuncs.PosEx('Date',DSEmployeeAllowances.FieldList.Fields[i].FieldName) = 0)
                           or (DSEmployeeAllowances.FieldList.Fields[i].FieldName = 'UseStartEndDates' )
                           then begin
            ValueNode := nIndent2.AddChild(DSEmployeeAllowances.FieldList.Fields[i].FieldName);
            try
              ValueNode.Text := DSEmployeeAllowances.FieldList.Fields[i].Value;
            except

            end;
          end else begin        //dates
            ValueNode := nIndent2.AddChild(DSEmployeeAllowances.FieldList.Fields[i].FieldName);
            ValueNode.Text := FormatDateTime('yyyy-mm-dd',DSEmployeeAllowances.FieldByName(DSEmployeeAllowances.FieldList.Fields[i].FieldName).asDateTime);
          end;
        end;
      end;
      DSEmployeeAllowances.Next;
    end;
    DSEmployeeAllowances.GotoBookmark(bm);
  finally
    DSEmployeeAllowances.FreeBookmark(bm);
  end;

  //Add employee deductions
  nIndent :=  nNewPay.AddChild('EmployeeDeductions',0);
  bm := DSEmployeeDeductions.GetBookmark;

  try
    DSEmployeeDeductions.First;
    while not DSEmployeeDeductions.Eof do begin
      nIndent2 := nIndent.AddChild('DeductionID');
      nIndent2.Attributes['DeductionID'] := DSEmployeeDeductions.FieldByName('DeductionID').AsString;

      for i := 0 to DSEmployeeDeductions.FieldCount- 1 do begin
        if  not (DSEmployeeDeductions.FieldList.Fields[i].IsNull) then begin
          if DSEmployeeDeductions.FieldList.Fields[i].FieldName = 'msTimeStamp' then continue;
          if (FastFuncs.PosEx('date',DSEmployeeDeductions.FieldList.Fields[i].FieldName) = 0)
                           and (FastFuncs.PosEx('Date',DSEmployeeDeductions.FieldList.Fields[i].FieldName) = 0)
                           or (DSEmployeeDeductions.FieldList.Fields[i].FieldName = 'UseStartEndDates' )
                           then begin
            ValueNode := nIndent2.AddChild(DSEmployeeDeductions.FieldList.Fields[i].FieldName);
            try
              ValueNode.Text := DSEmployeeDeductions.FieldList.Fields[i].Value;
            except

            end;
          end else begin        //dates
            ValueNode := nIndent2.AddChild(DSEmployeeDeductions.FieldList.Fields[i].FieldName);
            ValueNode.Text := FormatDateTime('yyyy-mm-dd',DSEmployeeDeductions.FieldByName(DSEmployeeDeductions.FieldList.Fields[i].FieldName).asDateTime);
          end;
        end;
      end;
      DSEmployeeDeductions.Next;
    end;

    DSEmployeeDeductions.GotoBookmark(bm);
  finally
    DSEmployeeDeductions.FreeBookmark(bm);
  end;


  //Add Employee super
  nIndent :=  nNewPay.AddChild('Superannuation',0);
  bm := DSEmployeeSuper.GetBookmark;

  try
    DSEmployeeSuper.First;
    while not DSEmployeeSuper.Eof do begin
      nIndent2 := nIndent.AddChild('SuperID');
      nIndent2.Attributes['SuperID'] := DSEmployeeSuper.FieldByName('SuperID').AsString;

      for i := 0 to DSEmployeeSuper.FieldCount- 1 do begin
        if  not (DSEmployeeSuper.FieldList.Fields[i].IsNull) then begin
          if (FastFuncs.PosEx('date',DSEmployeeSuper.FieldList.Fields[i].FieldName) = 0)
               and (FastFuncs.PosEx('Date',DSEmployeeSuper.FieldList.Fields[i].FieldName) = 0) then begin
            ValueNode := nIndent2.AddChild(DSEmployeeSuper.FieldList.Fields[i].FieldName);
            try
              ValueNode.Text := DSEmployeeSuper.FieldList.Fields[i].Value;
            except

            end;
          end else begin        //dates
            ValueNode := nIndent2.AddChild(DSEmployeeSuper.FieldList.Fields[i].FieldName);
            ValueNode.Text := FormatDateTime('yyyy-mm-dd',DSEmployeeSuper.FieldByName(DSEmployeeSuper.FieldList.Fields[i].FieldName).asDateTime);
          end;
        end;
      end;
      DSEmployeeSuper.Next;
    end;
    DSEmployeeSuper.GotoBookmark(bm);
  finally
    DSEmployeeSuper.FreeBookmark(bm);
  end;
end;

function TDataXMLObj.PayHasXML(const iPayID:integer):Boolean;
var
  qryPays: TMyQuery;
begin
  qryPays := TMyQuery.Create(nil);  //The tables for the pay object have not been loaded yet so use qry.
  try
    qryPays.Options.FlatBuffers := True;  
    result := False;
    qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryPays.SQL.Clear;
    qryPays.SQL.Add('SELECT PayID,PayXMLData FROM tblpays WHERE PayID = ');
    qryPays.SQL.Add(FastFuncs.IntToStr(iPayID));
    qryPays.Open;

    fsXML := qryPays.FieldByName('PayXMLData').AsString;
    if fsXML <> '' then result := True;

  finally
    FreeAndNil(qryPays);
  end;
end;

end.

