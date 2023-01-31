// set this define is you are using Indy 10
{$define INDY100}
// set this define is you are using Indy 9
{.$define INDY90}

unit PerecorpThreadTask;

interface

uses
  ServerModuleThreadTask, Classes, LogThreadBase, LogMessageTypes,
  ScktComp, SBTypes, SBUtils,
  // If SBIdSFTP is not found, add <SecureBlackbox>\Classes\IndySftp\Client
  // directory to Directories\Search Path in the project options
  SBIdSFTP,
  SBSftpCommon,
  SBSSHConstants, SBSSHKeyStorage, StdCtrls, ImgList,
  IdComponent, IdGlobal, IdTcpClient, IdFTPList;

type

  TSFTPClient = class;
  TPerecorpThreadTask = class(TServerModuleThreadTask)
  private
//    procedure DoGoogleProgress(var Abort: boolean);
    FSFTPClient: TSFTPClient;
//    Processed : integer;
//    ToProcess : integer;
    FFtpSite: string;
    FAutoProcessStartTime: TDateTime;
    FERPDatabase: string;
    FAutoProcessEndTime: TDateTime;
    FExcludeSupplierList: string;
    FERPPassword: string;
    FReportEmailList: string;
    FFtpCertificate: string;
    FFtpPassword: string;
    FERPUser: string;
    FIncludeSupplierList: string;
    FFtpUserName: string;
    fDepartmentList: string;
    fPercentDone: integer;
    FProcessDateFrom: TDateTime;
    function CheckForNewFiles: boolean;
    function ProcessFiles: boolean;
    function ProcessFile(stream: TStream; report: TStringList; reportOnly: boolean = true): boolean;
    function SFTPClient: TSFTPClient;
    function FTPParamsOk: boolean;
  protected
    procedure DoWork; override;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltNone); override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property FtpSite: string read FFtpSite write FFtpSite;
    property FtpUserName: string read FFtpUserName write FFtpUserName;
    property FtpPassword: string read FFtpPassword write FFtpPassword;
    property FtpCertificate: string read FFtpCertificate write FFtpCertificate;
    property ERPDatabase: string read FERPDatabase write FERPDatabase;
    property ERPUser: string read FERPUser write FERPUser;
    property ERPPassword: string read FERPPassword write FERPPassword;
    { List of Supplier names to ignore in the import }
    property ExcludeSupplierList: string read FExcludeSupplierList write FExcludeSupplierList;
    { List of Supplier names to include in the import }
    property IncludeSupplierList: string read FIncludeSupplierList write FIncludeSupplierList;
    property ReportEmailList: string read FReportEmailList write FReportEmailList;
    property AutoProcessStartTime: TDateTime read FAutoProcessStartTime write FAutoProcessStartTime;
    property AutoProcessEndTime: TDateTime read FAutoProcessEndTime write FAutoProcessEndTime;
    property DepartmentList: string read fDepartmentList write fDepartmentList;
    property ProcessDateFrom: TDateTime read FProcessDateFrom write FProcessDateFrom;
  end;

  TSFTPClient = class
  private
    FSFTPClient : TElIdSFTPClient;
    FKeyStorage: TElSSHMemoryKeyStorage;
//    FLoggerBase: TLoggerBase;
    FFtpSite: string;
    FFtpCertificate: string;
    FFtpPassword: string;
    FFtpUserName: string;
    Processed : integer;
    ToProcess : integer;
    fPercentDone: integer;
    fOnLog: TThreadTaskLogEvent;
    procedure SftpClientWork(Sender: TObject; AWorkMode: TWorkMode; {$ifdef INDY90}const{$endif} AWorkCount: {$ifdef INDY90}Integer{$else}Int64{$endif});
    procedure SftpClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode; {$ifdef INDY90}const{$endif} AWorkCountMax: {$ifdef INDY90}Integer{$else}Int64{$endif});
    procedure SftpClientAuthenticationFailed(Sender: TObject;
      AuthenticationType: Integer);
    procedure SftpClientAuthenticationSuccess(Sender: TObject);
    procedure SftpClientCloseConnection(Sender: TObject);
    procedure SftpClientError(Sender: TObject; ErrorCode: Integer);
    procedure SftpClientKeyValidate(Sender: TObject; ServerKey: TElSSHKey;
      var Validate: Boolean);
    function Client: TElIdSFTPClient;
    procedure Log(const msg: string; const aType: TLogMessageType = ltNone);
  public
    DirList : TIdSFTPListItems;
    constructor Create;
    destructor Destroy; override;
    property FtpSite: string read FFtpSite write FFtpSite;
    property FtpUserName: string read FFtpUserName write FFtpUserName;
    property FtpPassword: string read FFtpPassword write FFtpPassword;
    property FtpCertificate: string read FFtpCertificate write FFtpCertificate;
    //property Logger: TLoggerBase read FLoggerBase write FLoggerBase;
    function Connect: boolean;
    procedure Disconnect;
    function ChangeDir(const newDir: string): boolean;
    function GetFileList: boolean;
    function GetFile(FileName: string; stream: TStream): boolean;
    property OnLog: TThreadTaskLogEvent read fOnLog write fOnLog;
  end;

implementation

uses
  SysUtils, LogThreadDbLib, JsonToObject, JsonRPCUtils, types, StrUtils,
  JsonRPCConst, ModuleFileNameUtils, MySQLUtils, DbSharedObjectsObj,
  XMLIntf, XMLDoc, XMLHelperUtils, Math,
  BusObjStock, AppEnvironment, ActiveX, BusObjClient, BusObjUOM,
  EmailUtilsSimple, ERPDbComponents, CommonLib, BusObjCommon, DB,
  BusObjProductBarcode;

const
  Ftp_File_Location = '/outbound';

{ TPerecorpThreadTask }

function TPerecorpThreadTask.CheckForNewFiles: boolean;
var
  x: integer;
  qry: TERPQuery;
  cmd: TERPCommand;
  strList: TStringDynArray;
  msg: string;
  aFileDate: TDateTime;
begin
  result := false;
  Log('Checking for new files on FTP site ..', ltInfo);
  try
    try
      if not self.FTPParamsOk then exit;
      if not SFTPClient.ChangeDir(Ftp_File_Location) then exit;
      if not SFTPClient.GetFileList then exit;
      //Connection.Connect;

      try
        AppEnv.AppDb.Database := ERPDatabase;
        AppEnv.AppDb.ConnectUser(ERPUser, ERPPassword);
      except
        on eusr: exception do begin
          Log('Error connecting to ERP: ' + eusr.Message,ltError);
          exit;
        end;
      end;
      try
        if not AppEnv.UtilsClient.ConnectUser(msg,'localhost',ERPDatabase,ERPUser,'','',true) then begin
          Log('Could not connect to ERP. ' + msg,ltError);
          exit;
        end;
        try


          qry := DbSharedObj.GetQuery(AppEnv.AppDb.Connection);
          cmd := DbSharedObj.GetCommand(AppEnv.AppDb.Connection);
          try
            AppEnv.AppDb.Connection.Connect;
            qry.SQL.Text := 'select * from tblstockupdatefiles where FileName = :FileName';
            for x:= 0 to SFTPClient.DirList.Count -1 do begin
              self.ProgressTime := now;
              if (SFTPClient.DirList[x].ItemType = ditFile) then begin
                strList := SplitString(ExtractFileName(SFTPClient.DirList[x].FileName),'_');
                aFileDate := EncodeDate(StrToInt(Copy(strList[2],1,4)), StrToInt(Copy(strList[2],5,2)), StrToInt(Copy(strList[2],7,2)));
                if aFileDate < Trunc(ProcessDateFrom) then
                  Continue;
                qry.ParamByName('FileName').AsString := SFTPClient.DirList[x].FileName;
                qry.Open;
                if qry.IsEmpty then begin
                  qry.Append;
                  qry.FieldByName('FileName').AsString := SFTPClient.DirList[x].FileName;
                  qry.FieldByName('FileDept').AsString := strList[1];
                  qry.FieldByName('FileDate').AsDateTime := aFileDate;
                  qry.Post;
                  Log('New file found on FTP site: ' +  SFTPClient.DirList[x].FileName, ltInfo);
                end;
                qry.Close;
              end;
            end;
          finally
            DbSharedObj.ReleaseObj(qry);
            DbSharedObj.ReleaseObj(cmd);
            //Connection.Disconnect;
          end;
          result := true;
        finally
          AppEnv.UtilsClient.Disconnect;
        end;
      finally
        //AppEnv.AppDb.TransConnection.Disconnect;
        AppEnv.AppDb.Connection.Disconnect;

      end;
    finally
      SFTPClient.Disconnect;
      Log('File check finished', ltInfo);
    end;
  except
    on e: exception do begin
      result := false;
      Log('Error checking for files: ' + e.Message);
    end;
  end;
end;

constructor TPerecorpThreadTask.Create;
begin
  inherited;

end;

destructor TPerecorpThreadTask.Destroy;
begin
  FSFTPClient.Free;
  inherited;
end;

procedure TPerecorpThreadTask.DoWork;
begin
  inherited;
  JsonToObj(Params,Self);
  CheckForNewFiles;
  ProcessFiles;
end;


function TPerecorpThreadTask.FTPParamsOk: boolean;
var
  KeyFileName: string;
begin
  result := false;
  if self.ERPDatabase = '' then begin
    Log('ERP Database has not been specified.', ltError);
    exit;
  end;
  if self.FFtpSite = '' then begin
    Log('FTP Site has not been specified.', ltError);
    exit;
  end;
  if self.FFtpPassword = '' then begin
    Log('FTP Password has not been specified.', ltError);
    exit;
  end;
  if self.FFtpUserName = '' then begin
    Log('FTP User Name has not been specified.', ltError);
    exit;
  end;
  if self.FFtpCertificate = '' then begin
    Log('FTP Certificate has not been specified.', ltError);
    exit;
  end;
  KeyFileName := ModuleFileNameUtils.GetCurrentModulePath + self.FFtpCertificate;
  if not FileExists(KeyFileName) then begin
    Log('FTP Certificate File not found.', ltError);
    exit;
  end;
  if self.ERPDatabase = '' then begin
    Log('ERP Database has not been specified.', ltError);
    exit;
  end;
  if self.ERPUser = '' then begin
    Log('ERP User Name has not been specified.', ltError);
    exit;
  end;
  if self.ERPPassword = '' then begin
    Log('ERP User Password has not been specified.', ltError);
    exit;
  end;
  result := true;
end;

procedure TPerecorpThreadTask.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  inherited;
  self.ProgressTime := now;
end;

function TPerecorpThreadTask.ProcessFile(stream: TStream; report: TStringList;
  reportOnly: boolean): boolean;
var
  XMLDoc: IXMLDocument;
  node, barCodes: IXMLNode;
  BarcodeList: TStringList;
  PrimaryBarcode, Barcode: string;
  x, i: integer;
  s: string;
  msg: string;
  prod: TProduct;
  supp: TSupplier;
  uom: TUnitOfMeasure;
  ClientType: BusObjCommon.TClientType;
  newProd: boolean;
  price: double;
  taxRate: double;
  CurrentID: string;
  uomId, baseUomId: integer;
  NumberOfPieces: integer;
  IncludeSuppLIst, ExcludeSuppList: TStringList;
  PercentDone: integer;
  cmd: TERPCommand;
  qry: TERPQuery;
  PB: TProductBarcode;
const
  indent = '    ';

  procedure AddLine(str: string);
  begin
    if CurrentId <> GetNodeVal(node,'ID') then begin
      CurrentId := GetNodeVal(node,'ID');
      report.Add(GetNodeVal(node,'ID') + ' ' + GetNodeVal(node,'Description'));
      Log(GetNodeVal(node,'ID') + ' ' + GetNodeVal(node,'Description'),ltDetail);
    end;
    report.Add(indent + str);
    Log(indent + str, ltDetail);
  end;

  function FmtAmt(amt: double): string;
  begin
    result := FormatFloat('#,##0.0000;-#,##0.0000',amt);
  end;

  function FmtTax(amt: double): string;
  begin
    result := FormatFloat('#0.00',amt);
  end;

begin
  result := false;
  CoInitialize(nil);
  try
    prod := TProduct.CreateWithNewConn(nil);
    supp := TSupplier.CreateWithNewConn(nil);
    uom := TUnitOfMeasure.CreateWithNewConn(nil);
    ClientType := BusObjCommon.TClientType.CreateWithNewConn(nil);
    cmd := DbSharedObj.GetCommand(AppEnv.AppDb.TransConnection);
    qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);

    try
      prod.Connection.Connection := AppEnv.AppDb.TransConnection;
      prod.SilentMode := true;
      supp.Connection.Connection := prod.Connection.Connection; //AppEnv.AppDb.TransConnection;
      supp.SilentMode := true;
      uom.Connection.Connection := prod.Connection.Connection; //AppEnv.AppDb.TransConnection;
      uom.SilentMode := true;
      ClientType.Connection.Connection := prod.Connection.Connection;
      ClientType.SilentMode := true;

      BarcodeList := TStringList.Create;
      IncludeSuppList := TStringList.Create;
      ExcludeSuppList := TStringList.Create;
      XMLDoc := TXMLDocument.Create(nil);
      try
        stream.Position := 0;
        IncludeSuppList.CaseSensitive := false;
        IncludeSuppList.CommaText := self.IncludeSupplierList;
        ExcludeSuppList.CommaText := self.ExcludeSupplierList;
        XMLDoc.LoadFromStream(stream);
        XMLDoc.Active := true;
        fPercentDone := -1;
        for x := 0 to RootNode(XMLDoc).ChildNodes.Count -1 do begin
          if terminated then exit;
          self.ProgressTime := now;

          PercentDone := System.Round((x / RootNode(XMLDoc).ChildNodes.Count) * 100);
          if Frac(PercentDone / 5) = 0 then begin
            if fPercentDone <> PercentDone then begin
              fPercentDone := PercentDone;
              Log('Percent processed ' + IntToStr(PercentDone) + '%', ltInfo);
            end;
          end;

          node := RootNode(XMLDoc).ChildNodes[x];
          newProd := false;
          if IncludeSuppList.Count > 0 then
            if (GetNodeVal(node,'SupplierName') <> '') and (IncludeSuppList.IndexOf(GetNodeVal(node,'SupplierName')) < 0) then
              continue;
            if (GetNodeVal(node,'SupplierName') <> '') and (ExcludeSuppList.IndexOf(GetNodeVal(node,'SupplierName')) >= 0) then
              continue;


          { do we have this product .. }
          prod.LoadSelect('partname = ' + QuotedStr(GetNodeVal(node,'ID')));
          if prod.Count = 0 then begin
            if SameText(GetNodeVal(node,'Status'),'Deleted') then
              { deleted so ignore this entry }
              continue;
            { new product }
            AddLine('New Product');
            if reportOnly then continue;
            newProd := true;
            prod.Connection.BeginNestedTransaction;
            prod.New;
            prod.ProductName := GetNodeVal(node,'ID');
            prod.ProductType := 'INV';
            prod.SalesDescription := GetNodeVal(node,'Description');
            prod.PurchaseDescription := GetNodeVal(node,'Description');
          end;
          if not newProd then
            prod.Connection.BeginNestedTransaction;
          { tax purchase code }
//          taxRate := 0;
          if GetNodeVal(node,'CostGSTRate') <> '' then begin
            try
              taxRate := StrToFloat(GetNodeVal(node,'CostGSTRate'));
            except
              taxRate := -1;
              AddLine('Invalid Cost GST Rate value in file "' + GetNodeVal(node,'CostGSTRate') + '"');
            end;
            if (taxRate > -1) and (not Math.SameValue((prod.TaxPurchase.Rate * 100), taxRate, 0.000001)) then begin
              if not newProd then
                AddLine('Cost Tax Rate changed, old rate: '  + FmtTax(prod.TaxPurchase.Rate * 100) + ' new rate: ' + FmtTax(taxRate));
              if not reportOnly then begin
                if taxRate = 0 then
                  prod.TaxCodePurchase := AppEnv.RegionalOptions.TaxCodePurchaseEx
                else begin
                  prod.TaxCodePurchase := AppEnv.RegionalOptions.TaxCodePurchaseInc;
                  if (prod.TaxPurchase.Rate * 100) <> taxRate then begin
                    AddLine('The Cost GST Rate (' + FmtTax(taxRate) +
                      ') does not match the rate in ERP for tax code ' +
                      AppEnv.RegionalOptions.TaxCodePurchaseInc + ' (' +
                      FmtTax(prod.TaxPurchase.Rate * 100) + ')');
                  end;
                end;
              end;
            end;
          end;

          { tax sell code }
//          taxRate := 0;
          if GetNodeVal(node,'SellGSTRate') <> '' then begin
            try
              taxRate := StrToFloat(GetNodeVal(node,'SellGSTRate'));
            except
              taxRate := -1;
              AddLine('Invalid Sell GST Rate value in file "' + GetNodeVal(node,'SellGSTRate') + '"');
            end;
            if (taxRate > -1) and (not Math.SameValue(prod.TaxSales.Rate * 100, taxRate, 0.000001)) then begin
              if not newProd then
                AddLine('Sell Tax Rate changed, old rate: '  + FmtTax(prod.TaxSales.Rate * 100) + ' new rate: ' + FmtTax(taxRate));
              if not reportOnly then begin
                if taxRate = 0 then
                  prod.TaxCodeSales := AppEnv.RegionalOptions.TaxCodeSalesEx
                else begin
                  prod.TaxCodeSales := AppEnv.RegionalOptions.TaxCodeSalesInc;
                  if (prod.TaxSales.Rate * 100) <> taxRate then begin
                    AddLine('The Sell GST Rate (' + FmtTax(taxRate) +
                      ') does not match the rate in ERP for tax code ' +
                      AppEnv.RegionalOptions.TaxCodeSalesInc + ' (' +
                      FmtTax(prod.TaxSales.Rate * 100) + ')');
                  end;
                end;
              end;
            end;
          end;

          { Prefered supplier }
          if (GetNodeVal(node,'SupplierName') <> '') and (not SameText(GetNodeVal(node,'SupplierName'), 'UNKNOWN')) then begin
            supp.LoadSelect('Company = ' + QuotedStr(GetNodeVal(node,'SupplierName')));
            if supp.Count = 0 then begin
              AddLine('New Supplier: ' +  GetNodeVal(node,'SupplierName'));
              if not reportOnly then begin
                { create new supplier .. }
                supp.Connection.BeginNestedTransaction;
                supp.New;
                supp.ClientName := GetNodeVal(node,'SupplierName');
                supp.PostDb;
                if not supp.Save then begin
                  supp.Connection.RollbackNestedTransaction;
                  AddLine('Unable to create new supplier with error: '  + supp.ResultStatus.Messages);
                end
                else
                  supp.Connection.CommitNestedTransaction;
              end;
            end;
            if not reportOnly then
              prod.PreferedSupplierName := GetNodeVal(node,'SupplierName');
          end;

          { general values }
          s:= '';
          if Pos('GIFTS -',Trim(GetNodeVal(node,'DepartmentName'))) = 1 then begin
            s:= Trim(GetNodeVal(node,'DepartmentName'));
            s := Trim(Copy(s,8,Length(s)));
          end;

          if (Trim(GetNodeVal(node,'FamilyName')) <> prod.ProductGroup2) and (s = '') then begin
            if not newProd then
              AddLine('Family Name Changed, old value: [' + prod.ProductGroup2 + '] new value [' + Trim(GetNodeVal(node,'FamilyName')) + ']');
            if not reportOnly then
              prod.ProductGroup2 := Trim(GetNodeVal(node,'FamilyName'));
          end;

          if Trim(GetNodeVal(node,'ProductVarietyName')) <> prod.ProductGroup3 then begin
            if not newProd then
              AddLine('Product Variety Name Changed, old value: [' + prod.ProductGroup3 + '] new value [' + Trim(GetNodeVal(node,'ProductVarietyName')) + ']');
            if not reportOnly then
              prod.ProductGroup3 := Trim(GetNodeVal(node,'ProductVarietyName'));
          end;

          if Pos('GIFTS -',Trim(GetNodeVal(node,'DepartmentName'))) = 1 then begin
            if prod.ProductGroup1 <> 'GIFTS' then begin
              if not newProd then
                AddLine('Department Name Changed, old value: [' + prod.ProductGroup1 + '] new value [GIFTS]');
              if not reportOnly then
                prod.ProductGroup1 := 'GIFTS';
            end;
            { need to split this down further }
            if (prod.ProductGroup2 <> '') and (prod.ProductGroup3 = '') then begin
              { move it .. }
              if not newProd then
                AddLine('Product Variety Name Changed, old value: [' + prod.ProductGroup3 + '] new value [' + prod.ProductGroup2 + ']');
              if not reportOnly then begin
                prod.ProductGroup3 := prod.ProductGroup2;
                //prod.ProductGroup2 := '';
              end;
            end;
            if s <> prod.ProductGroup2 then begin
              if not newProd then
                AddLine('Family Name Changed, old value: [' + prod.ProductGroup2 + '] new value [' + s + ']');
              if not reportOnly then
                prod.ProductGroup2 := s;
            end;
          end
          else begin
            if Trim(GetNodeVal(node,'DepartmentName')) <> prod.ProductGroup1 then begin
              if not newProd then
                AddLine('Department Name Changed, old value: [' + prod.ProductGroup1 + '] new value [' + Trim(GetNodeVal(node,'DepartmentName')) + ']');
              if not reportOnly then
                prod.ProductGroup1 := Trim(GetNodeVal(node,'DepartmentName'));
            end;
          end;

          if Trim(GetNodeVal(node,'GroupName')) <> prod.CUSTFLD1 then begin
            if not newProd then
              AddLine('Group Name Changed, old value: [' + prod.CUSTFLD1 + '] new value [' + Trim(GetNodeVal(node,'GroupName')) + ']');
            if not reportOnly then
              prod.CUSTFLD1 := Trim(GetNodeVal(node,'GroupName'));
          end;

          if Trim(GetNodeVal(node,'WallCode')) <> prod.CUSTFLD2 then begin
            if not newProd then
              AddLine('Wall Code Changed, old value: [' + prod.CUSTFLD2 + '] new value [' + Trim(GetNodeVal(node,'WallCode')) + ']');
            if not reportOnly then
              prod.CUSTFLD2 := Trim(GetNodeVal(node,'WallCode'));
          end;

          if Trim(GetNodeVal(node,'ShelfCode')) <> prod.CUSTFLD3 then begin
            if not newProd then
              AddLine('Shelf Code Changed, old value: [' + prod.CUSTFLD3 + '] new value [' + Trim(GetNodeVal(node,'ShelfCode')) + ']');
            if not reportOnly then
              prod.CUSTFLD3 := Trim(GetNodeVal(node,'ShelfCode'));
          end;

          { units of measure }
          NumberOfPieces := 0;
//          uomId := 0;
//          if SameText(GetNodeVal(node,'GroupName'), 'PACKETS') or SameText(GetNodeVal(node,'GroupName'), 'PACKET') then
//            Log('This is a Packet type product',ltDetail);

          if (SameText(GetNodeVal(node,'GroupName'), 'PACKETS') and SameText(GetNodeVal(node,'DepartmentName'), 'CIG RETAIL PACKETS')) or
            (SameText(GetNodeVal(node,'GroupName'), 'PACKET') and SameText(GetNodeVal(node,'DepartmentName'), 'CIGARS')) then begin
            { base unit }
            baseUomId := 0;
            if prod.UOMList.LocateByName('Stick') then begin
              baseUomId := prod.UOMList.ID;
            end
            else begin
              if not newProd then
                AddLine('New Unit of Measure "Stick"');
              if not reportOnly then begin
                uom.Connection.BeginNestedTransaction;
                uom.New;
                uom.UOMName := 'Stick';
                uom.UnitDescription := 'Stick';
                uom.Multiplier := 1;
                uom.PartId := prod.ID;
                if uom.Save then begin
                  uom.Connection.CommitNestedTransaction;
                  baseUomId := uom.ID;
                  prod.UOMList.RefreshDB;
                end
                else begin
                  uom.Connection.RollbackNestedTransaction;
                  AddLine('Unable to create new UOM with error: ' + uom.ResultStatus.Messages);
                end;
              end;
            end;
            { pack unit }
            try
              if GetNodeVal(node,'NumberOfPieces') <> '' then
                NumberOfPieces := StrToInt(GetNodeVal(node,'NumberOfPieces'));
            except
              AddLine('Error: Invalid Number Of Pieces value: "' + GetNodeVal(node,'NumberOfPieces') + '"');
              AddLine('Unable to check/create "Pack" UOM');
            end;
            if NumberOfPieces > 0 then begin
              if prod.UOMList.LocateByName('Pack ' + IntToStr(NumberOfPieces)) then begin
//                UomId := prod.UOMList.ID;
              end
              else begin
                if not newProd then
                  AddLine('New Unit of Measure "Pack '+IntToStr(NumberOfPieces)+'"');
                if (not reportOnly) and (baseUomId > 0) then begin
                  uom.Connection.BeginNestedTransaction;
                  uom.New;
                  uom.UOMName := 'Pack ' + IntToStr(NumberOfPieces);
                  uom.UnitDescription := uom.UOMName;
                  uom.Multiplier := NumberOfPieces;
                  uom.PartId := prod.ID;
                  uom.BaseUnitID := baseUomId;
                  uom.PurchasesDefault := true;
                  uom.SalesDefault := true;
                  if uom.Save then begin
                    uom.Connection.CommitNestedTransaction;
//                    UomId := uom.ID;
                    prod.UOMList.RefreshDB;
                  end
                  else begin
                    uom.Connection.RollbackNestedTransaction;
                    AddLine('Unable to create new UOM with error: ' + uom.ResultStatus.Messages);
                  end;
                end;
              end;
            end;
          end
          else if ((SameText(GetNodeVal(node,'GroupName'), 'CARTONS') or SameText(GetNodeVal(node,'GroupName'), 'CARTONS-TP'))  and SameText(GetNodeVal(node,'DepartmentName'), 'CIG RETAIL CARTONS')) or
            (SameText(GetNodeVal(node,'GroupName'), 'BOXES') and SameText(GetNodeVal(node,'DepartmentName'), 'CIGARS')) then begin
            { base unit }
            baseUomId := 0;
            if prod.UOMList.LocateByName('Stick') then begin
              baseUomId := prod.UOMList.ID;
            end
            else begin
              if not newProd then
                AddLine('New Unit of Measure "Stick"');
              if not reportOnly then begin
                uom.Connection.BeginNestedTransaction;
                uom.New;
                uom.UOMName := 'Stick';
                uom.UnitDescription := 'Stick';
                uom.Multiplier := 1;
                uom.PartId := prod.ID;
                if uom.Save then begin
                  uom.Connection.CommitNestedTransaction;
                  baseUomId := uom.ID;
                  prod.UOMList.RefreshDB;
                end
                else begin
                  uom.Connection.RollbackNestedTransaction;
                  AddLine('Unable to create new UOM with error: ' + uom.ResultStatus.Messages);
                end;
              end;
            end;
            { pack unit }
            try
              if GetNodeVal(node,'NumberOfPieces') <> '' then
                NumberOfPieces := StrToInt(GetNodeVal(node,'NumberOfPieces'));
            except
              AddLine('Error: Invalid Number Of Pieces value: "' + GetNodeVal(node,'NumberOfPieces') + '"');
              AddLine('Unable to check/create "Carton" UOM');
            end;
            if NumberOfPieces > 0 then begin
              if prod.UOMList.LocateByName('Carton ' + IntToStr(NumberOfPieces)) then begin
//                UomId := prod.UOMList.ID;
              end
              else begin
                if not newProd then
                  AddLine('New Unit of Measure "Carton '+IntToStr(NumberOfPieces)+'"');
                if (not reportOnly) and (baseUomId > 0) then begin
                  uom.Connection.BeginNestedTransaction;
                  uom.New;
                  uom.UOMName := 'Carton ' + IntToStr(NumberOfPieces);
                  uom.UnitDescription := uom.UOMName;
                  uom.Multiplier := NumberOfPieces;
                  uom.PartId := prod.ID;
                  uom.BaseUnitID := baseUomId;
                  uom.PurchasesDefault := true;
                  uom.SalesDefault := true;
                  if uom.Save then begin
                    uom.Connection.CommitNestedTransaction;
//                    UomId := uom.ID;
                    prod.UOMList.RefreshDB;
                  end
                  else begin
                    uom.Connection.RollbackNestedTransaction;
                    AddLine('Unable to create new UOM with error: ' + uom.ResultStatus.Messages);
                  end;
                end;
              end;
            end;
          end
          else begin
            { all other products }
//            if prod.UOMList.LocateByName(AppEnv.DefaultClass.DefaultUOM) then begin
//              if prod.UOMList.PartId <> 0 then
//                uomId := prod.UOMList.ID;
//            end;
//            if uomId = 0 then begin
//              if not newProd then
//                AddLine('New unit of measure "' + AppEnv.DefaultClass.DefaultUOM + '"');
//              if not reportOnly then begin
//                prod.ProductUOMLocate(AppEnv.DefaultClass.DefaultUOM);
//                prod.UOMList.RefreshDB;
//                if prod.UOMList.LocateByName(AppEnv.DefaultClass.DefaultUOM) then begin
//                  if prod.UOMList.PartId <> 0 then
//                    uomId := prod.UOMList.ID;
//                end;
//              end;
//            end;
          end;
//          if uomId > 0 then begin
//            if not reportOnly then begin
//
//              //prod.uom UOMPurchasesID := uomId;
//              //prod.UOMSalesID := uomId;
//            end;
//          end;

          { check costs }
          if GetNodeVal(node,'MPLPrice') <> '' then begin
            try
              price := StrToFloat(GetNodeVal(node,'MPLPrice'));
              if NumberOfPieces > 0 then
                price := CommonLib.Round(price / NumberOfPieces, 5);
            except
              price := 0;
              if not newProd then
                AddLine('Invalid Cost Price value in file "' + GetNodeVal(node,'MPLPrice') + '"');
            end;
            if (price <> 0) and (prod.BuyQty1CostInc <> price) then begin
              if not newProd then
                AddLine('Cost Price changed, old cost: '  + FmtAmt(prod.BuyQty1CostInc) + ' new cost: ' + FmtAmt(price));
              if not reportOnly then begin
                prod.BuyQty1CostInc := price;
                prod.BuyQty2CostInc := price;
                prod.BuyQty3CostInc := price;
                prod.BuyQTY1 := 1;
                if prod.BuyQty2CostInc = 0 then begin
                  //prod.BuyQty2CostInc := price;
                  prod.BuyQTY2 := 1;
                end;
                if prod.BuyQty3CostInc = 0 then begin
                  //prod.BuyQty3CostInc := price;
                  prod.BuyQTY3 := 1;
                end;
              end;
            end;
          end;
          { check prices }
          if GetNodeVal(node,'SellPrice') <> '' then begin
            try
              price := StrToFloat(GetNodeVal(node,'SellPrice'));
              if NumberOfPieces > 0 then begin
                price := CommonLib.Round(price / NumberOfPieces, 5);
                { Extra Sell price is Ex ... }
                if prod.TaxSales.Rate <> 0 then
                  price := CommonLib.Round(price / (1 + prod.TaxSales.Rate), 5);
              end;

            except
              price := 0;
              AddLine('Invalid Sell Price value in file "' + GetNodeVal(node,'SellPrice') + '"');
            end;
            if (price <> 0) and (prod.SellQty1PriceInc <> price) then begin
              if not newProd then
                AddLine('Sell Price changed, old price: '  + FmtAmt(prod.SellQty1PriceInc) + ' new price: ' + FmtAmt(price));
              if not reportOnly then begin
                prod.SellQty1PriceInc := price;
                prod.SellQty2PriceInc := price;
                prod.SellQty3PriceInc := price;
                prod.SellQTY1 := 1;
                if prod.SellQty2PriceInc = 0 then begin
                  //prod.SellQty2PriceInc := price;
                  prod.SellQTY2 := 1;
                end;
                if prod.SellQty3PriceInc = 0 then begin
                  //prod.SellQty3PriceInc := price;
                  prod.SellQTY3 := 1;
                end;
              end;
            end;
          end;

          { Wholesale1 Extra Sell Price }
          if GetNodeVal(node,'WholesalePrice') <> '' then begin
            price := StrToFloat(GetNodeVal(node,'WholesalePrice'));

            if not SameText(ClientType.TypeName, 'Wholesale1') then begin
              ClientType.LoadSelect('TypeName = ' + QuotedStr('Wholesale1'));
              if (not reportOnly) and (not SameText(ClientType.TypeName, 'Wholesale1')) then begin
                ClientType.Connection.BeginNestedTransaction;
                ClientType.New;
                ClientType.TypeName := 'Wholesale1';
                ClientType.TypeDescription := 'Wholesale 1';
                ClientType.PostDb;
                if ClientType.Save then begin
                  ClientType.Connection.CommitNestedTransaction;
                  AddLine('Created new "Wholesale1" Client Type.');
                end
                else begin
                  ClientType.Connection.RollbackNestedTransaction;
                  AddLine('Unable to create new Client Type with error: ' + ClientType.ResultStatus.Messages);
                  Log('Unable to create new Client Type with error: ' + ClientType.ResultStatus.Messages, ltError);
                end;
              end;
            end;
          end;

          if SameText(ClientType.TypeName, 'Wholesale') then begin

            if price <> 0 then
              price := CommonLib.Round(price / prod.UOMSalesMultiplier, 5);

            if prod.ExtraSellPrice.Dataset.Locate('ClientTypeId', ClientType.ID, []) then begin
              if prod.ExtraSellPrice.Price1 <> price then begin
                if not newProd then
                  AddLine('Wholesale1 Price changed, old price: '  + FmtAmt(prod.ExtraSellPrice.Price1) + ' new price: ' + FmtAmt(price));
                if (not reportOnly) then begin
                  prod.ExtraSellPrice.Price1 := price;
                  prod.ExtraSellPrice.PostDb;
                end;
              end;
            end
            else begin
              { Wholesale not found so add it }
              if not newProd then begin
                AddLine('Added Wholesale1 Price: ' + FmtAmt(price));
                if (not reportOnly) then begin
                  //prod.UOMList.LocateByID(prod.u)
                  prod.ExtraSellPrice.Connection.BeginNestedTransaction;
                  prod.ExtraSellPrice.New;
                  prod.ExtraSellPrice.ClientTypeID := ClientType.ID;
                  prod.ExtraSellPrice.Price1 := price;
                  if prod.UOMSales <> '' then begin
                    prod.ExtraSellPrice.UOMID := prod.UOMSalesID;
//                    prod.ExtraSellPrice.UOMName := prod.UOMSales;
//                    prod.ExtraSellPrice.UOMMultiplier := prod.UOMSalesMultiplier;
                  end
                  else if prod.UOMList.Count > 0 then begin
                    prod.UOMList.First;
                    prod.ExtraSellPrice.UOMID := prod.UOMList.ID;
//                    prod.ExtraSellPrice.UOMName := prod.UOMList.UOMName;
//                    prod.ExtraSellPrice.UOMMultiplier := prod.UOMList.Multiplier;
                  end;
                  prod.ExtraSellPrice.PostDb;
                  if prod.ExtraSellPrice.Save then
                    prod.ExtraSellPrice.Connection.CommitNestedTransaction
                  else begin
                    prod.ExtraSellPrice.Connection.RollbackNestedTransaction;
                    AddLine('Unable to create new Wholesale1 Extra Sell Price for Product '+prod.ProductName+' with error: ' + prod.ExtraSellPrice.ResultStatus.Messages);
                    Log('Unable to create new Wholesale1 Extra Sell Price for Product '+prod.ProductName+' with error: ' + prod.ExtraSellPrice.ResultStatus.Messages, ltError);
                  end;
                end;
              end;
            end;
          end;

          { Wholesale Extra Sell Price }
          if GetNodeVal(node,'TradePrice') <> '' then begin
            price := StrToFloat(GetNodeVal(node,'TradePrice'));

            if not SameText(ClientType.TypeName, 'Wholesale') then begin
              ClientType.LoadSelect('TypeName = ' + QuotedStr('Wholesale'));
              if (not reportOnly) and (not SameText(ClientType.TypeName, 'Wholesale')) then begin
                ClientType.Connection.BeginNestedTransaction;
                ClientType.New;
                ClientType.TypeName := 'Wholesale';
                ClientType.TypeDescription := 'Wholesale';
                ClientType.PostDb;
                if ClientType.Save then begin
                  ClientType.Connection.CommitNestedTransaction;
                  AddLine('Created new "Wholesale" Client Type.');
                end
                else begin
                  ClientType.Connection.RollbackNestedTransaction;
                  AddLine('Unable to create new Client Type with error: ' + ClientType.ResultStatus.Messages);
                  Log('Unable to create new Client Type with error: ' + ClientType.ResultStatus.Messages, ltError);
                end;
              end;
            end;
          end;

          if SameText(ClientType.TypeName, 'TradePrice') then begin

            if price <> 0 then
              price := CommonLib.Round(price / prod.UOMSalesMultiplier, 5);

            if prod.ExtraSellPrice.Dataset.Locate('ClientTypeId', ClientType.ID, []) then begin
              if prod.ExtraSellPrice.Price1 <> price then begin
                if not newProd then
                  AddLine('Wholesale Price changed, old price: '  + FmtAmt(prod.ExtraSellPrice.Price1) + ' new price: ' + FmtAmt(price));
                if (not reportOnly) then begin
                  prod.ExtraSellPrice.Price1 := price;
                  prod.ExtraSellPrice.PostDb;
                end;
              end;
            end
            else begin
              { Wholesale not found so add it }
              if not newProd then begin
                AddLine('Added Wholesale Price: ' + FmtAmt(price));
                if (not reportOnly) then begin
                  //prod.UOMList.LocateByID(prod.u)
                  prod.ExtraSellPrice.Connection.BeginNestedTransaction;
                  prod.ExtraSellPrice.New;
                  prod.ExtraSellPrice.ClientTypeID := ClientType.ID;
                  prod.ExtraSellPrice.Price1 := price;
                  if prod.UOMSales <> '' then begin
                    prod.ExtraSellPrice.UOMID := prod.UOMSalesID;
//                    prod.ExtraSellPrice.UOMName := prod.UOMSales;
//                    prod.ExtraSellPrice.UOMMultiplier := prod.UOMSalesMultiplier;
                  end
                  else if prod.UOMList.Count > 0 then begin
                    prod.UOMList.First;
                    prod.ExtraSellPrice.UOMID := prod.UOMList.ID;
//                    prod.ExtraSellPrice.UOMName := prod.UOMList.UOMName;
//                    prod.ExtraSellPrice.UOMMultiplier := prod.UOMList.Multiplier;
                  end;
                  prod.ExtraSellPrice.PostDb;
                  if prod.ExtraSellPrice.Save then
                    prod.ExtraSellPrice.Connection.CommitNestedTransaction
                  else begin
                    prod.ExtraSellPrice.Connection.RollbackNestedTransaction;
                    AddLine('Unable to create new Wholesale Extra Sell Price for Product '+prod.ProductName+' with error: ' + prod.ExtraSellPrice.ResultStatus.Messages);
                    Log('Unable to create new Wholesale Extra Sell Price for Product '+prod.ProductName+' with error: ' + prod.ExtraSellPrice.ResultStatus.Messages, ltError);
                  end;
                end;
              end;
            end;
          end;

          { now barcodes }
          { get list of barcodes }
          BarcodeList.Clear;
          PrimaryBarcode := '';
          barCodes := GetNode(node, 'BarCodes');
          if Assigned(barCodes) then begin
            for i := 0 to BarCodes.ChildNodes.Count - 1 do begin
              Barcode := Trim(GetNodeVal(BarCodes.ChildNodes[i]));
              if Barcode <> '' then
                BarcodeList.Add(Barcode);
            end;
          end;
          barCodes := GetNode(node, 'WholesaleCode');
          if Assigned(barCodes) then begin
            for i := 0 to BarCodes.ChildNodes.Count - 1 do begin
              Barcode := Trim(GetNodeVal(BarCodes.ChildNodes[i]));
              if Barcode <> '' then
                BarcodeList.Add(Barcode);
            end;
          end;
          if not reportOnly then begin
            { add new barcodes }
            for i := 0 to BarcodeList.Count -1 do begin
              if not prod.ProductBarcodes.LocateBarCode(BarcodeList[i]) then begin
                if not newProd then
                  AddLine('New Barcode [' + BarcodeList[i] + ']');
                if not reportOnly then begin
                  s := '';
                  qry.SQL.Clear;
                  qry.SQL.Add('select tblpartbarcodes.ProductBarcodeID, tblpartbarcodes.BarCode,');
                  qry.SQL.Add('tblparts.PARTNAME, tblparts.PARTSDESCRIPTION from tblpartbarcodes, tblparts');
                  qry.SQL.Add('where tblpartbarcodes.PartsID = tblparts.PARTSID');
                  qry.SQL.Add('and tblpartbarcodes.Active = "T"');
                  qry.SQL.Add('and tblpartbarcodes.BarCode = '+ QuotedStr(BarcodeList[i]));
                  qry.SQL.Add('and tblpartbarcodes.PartsID <> ' + IntToStr(Prod.ID));
                  qry.Open;
                  if not qry.IsEmpty then begin
                    AddLine('Barcode "' + BarcodeList[i] + '" has allready been used for the following products so will be made inactive for these.');
                    while not qry.Eof do begin
                      AddLine('    Product: "' + qry.FieldByName('PARTNAME').AsString + '" Description: "' + qry.FieldByName('PARTSDESCRIPTION').AsString + '"');
                      if s <> '' then s := s + ',';
                      s := s + IntToStr(qry.FieldByName('ProductBarcodeID').AsInteger);
                      qry.Next;
                    end;
                    cmd.SQL.Clear;
                    cmd.SQL.Add('update tblpartbarcodes');
                    cmd.SQL.Add('set Active = "F"');
                    cmd.SQL.Add(', IsPrimaryBarcode = "F"');
                    cmd.SQL.Add('where ProductBarcodeID in (' + s + ')');
                    cmd.Execute;

                    cmd.SQL.Clear;
                    cmd.SQL.Add('update tblparts');
                    cmd.SQL.Add('set Barcode = ""');
                    cmd.SQL.Add('where Barcode = ' + QuotedStr(BarcodeList[i]));
                    cmd.SQL.Add('and PartsID <> ' + IntToStr(Prod.ID));
                    cmd.Execute;
                  end;
                  qry.Close;

                  PB := prod.ProductBarcodes;
//                    if prod.ProductBarcodes.Locate('BarCode',BarcodeList[i],[loCaseInsensitive]) then begin
//                      if not prod.ProductBarcodes.Active then begin
//                        prod.ProductBarcodes.Connection.BeginNestedTransaction;
//                        prod.ProductBarcodes.Active := true;
//                        prod.ProductBarcodes.PostDb;
//                        prod.ProductBarcodes.Connection.CommitNestedTransaction;
//                      end;
//
//                    end
//                    else begin
//                      { not found }
//                      prod.ProductBarcodes.Connection.BeginNestedTransaction;
//                      prod.ProductBarcodes.New;
//                      prod.ProductBarcodes.BarCode := BarcodeList[i];
//                      prod.ProductBarcodes.PostDb;
//                      if prod.ProductBarcodes.ValidateUnique then begin
//                        prod.ProductBarcodes.Connection.CommitNestedTransaction;
//                      end
//                      else begin
//                        prod.ProductBarcodes.CancelDb;
//                        prod.ProductBarcodes.Connection.RollbackNestedTransaction;
//                        AddLine('Unable to add Barcode to Product '+prod.ProductName+' with message: ' + prod.ProductBarcodes.ResultStatus.Messages);
//                        Log('Unable to add Barcode to Product  '+prod.ProductName+' with message: ' + prod.ProductBarcodes.ResultStatus.Messages, ltError);
//                        prod.ProductBarcodes.RefreshDB;
//                      end;
//                    end;
                    if PB.Locate('BarCode',BarcodeList[i],[loCaseInsensitive]) then begin
                      if not PB.Active then begin
                        PB.Connection.BeginNestedTransaction;
                        PB.Active := true;
                        PB.PostDb;
                        PB.Connection.CommitNestedTransaction;
                      end;

                    end
                    else begin
                      { not found }
                      PB.Connection.BeginNestedTransaction;
                      PB.New;
                      PB.BarCode := BarcodeList[i];
                      PB.PostDb;
                      if PB.ValidateUnique then begin
                        PB.Connection.CommitNestedTransaction;
                      end
                      else begin
                        PB.CancelDb;
                        PB.Connection.RollbackNestedTransaction;
                        AddLine('Unable to add Barcode to Product '+prod.ProductName+' with message: ' + PB.ResultStatus.Messages);
                        Log('Unable to add Barcode to Product  '+prod.ProductName+' with message: ' + PB.ResultStatus.Messages, ltError);
                        PB.RefreshDB;
                      end;
                    end;
                end;
              end;
            end;
            { make any existing barcodes inactive if they are not in this update }
            if prod.ProductBarcodes.Count > 0 then
              prod.ProductBarcodes.Dataset.First;
            while not prod.ProductBarcodes.Dataset.Eof do begin
              if BarcodeList.IndexOf(prod.ProductBarcodes.BarCode) < 0 then begin
                prod.ProductBarcodes.Active := false;
                prod.ProductBarcodes.PostDb;
              end
              else begin
                if not prod.ProductBarcodes.Active then begin
                  prod.ProductBarcodes.Active := true;;
                  prod.ProductBarcodes.PostDb;
                end;
                if prod.ProductBarcodes.IsprimaryBarcode then begin
                  if PrimaryBarcode = '' then
                    PrimaryBarcode := prod.ProductBarcodes.BarCode
                  else begin
                    prod.ProductBarcodes.IsprimaryBarcode := false;
                    prod.ProductBarcodes.PostDb;
                  end;
                end;
              end;
              prod.ProductBarcodes.Dataset.Next;
            end;
            { find the primary code }
            if PrimaryBarcode = '' then begin
              prod.ProductBarcodes.Dataset.First;
              while not prod.ProductBarcodes.Dataset.Eof do begin
                if prod.ProductBarcodes.Active then begin
                  PrimaryBarcode := prod.ProductBarcodes.BarCode;
                  prod.ProductBarcodes.IsprimaryBarcode := true;
                  prod.ProductBarcodes.PostDb;
                  break;
                end;
                prod.ProductBarcodes.Dataset.Next;
              end;
            end;
            { make sure product barcode is correct }
            if prod.BARCODE <> PrimaryBarcode then begin
              prod.BARCODE := PrimaryBarcode;
              prod.PostDb;
            end;

          end;

          { deleted }
          if SameText(GetNodeVal(node,'Status'),'Deleted') then begin
            if prod.Active and (not prod.IsDiscontinued) then begin

            if not newProd then
              AddLine('Product deleted');
            if not reportOnly then
              prod.IsDiscontinued := true;
            end;
          end;



          if not reportOnly then begin
            if prod.SellQty1Price <> 0 then begin
              if (prod.SellQty2Price = 0) then
                prod.SellQty2Price := prod.SellQty1Price;
              if (prod.SellQty3Price = 0) then
                prod.SellQty3Price := prod.SellQty1Price;

            end;
            prod.PostDb;
            if prod.Save then begin
              prod.Connection.CommitNestedTransaction;
            end
            else begin
              AddLine('Could not update product, Error: ' + prod.ResultStatus.Messages);
              Log('Could not update product, Error: ' + prod.ResultStatus.Messages, ltError);
              prod.Connection.RollbackNestedTransaction;
            end;
          end;
        end;
        result := true;
        Log('Finished processing file',ltInfo);

      finally
        XMLDoc := nil;
        BarcodeList.Free;
        IncludeSuppList.Free;
        ExcludeSuppList.Free;
      end;
    finally
      prod.UserLock.UnlockAllCurrentInstance;
      prod.Free;
      supp.Free;
      uom.Free;
      ClientType.Free;
      DbSharedObj.ReleaseObj(cmd);
      DbSharedObj.ReleaseObj(qry);
    end;
  finally
    CoUninitialize();
  end;
end;

function TPerecorpThreadTask.ProcessFiles: boolean;
var
  qry: TERPQuery;
  stream: TMemoryStream;
  msg: string;
  report, DeptList: TStringList;
  reportOnly: boolean;
  FileNeedsProcessing: boolean;
begin
  result := false;
  Log('Checking for files that need to be processed ..', ltInfo);
  try
    try
      AppEnv.AppDb.Database := ERPDatabase;
      AppEnv.AppDb.ConnectUser(ERPUser, ERPPassword);
    except
      on eusr: exception do begin
        Log('Error connecting to ERP: ' + eusr.Message,ltError);
        exit;
      end;
    end;
    try
      if not AppEnv.UtilsClient.ConnectUser(msg,'localhost',ERPDatabase,ERPUser,'','',true) then begin
        Log('Could not connect to ERP. ' + msg,ltError);
        exit;
      end;
      try
        report := TStringList.Create;
        DeptList := TStringList.Create;
        stream := TMemoryStream.Create;
        qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
        try
          DeptList.CommaText := DepartmentList;
          qry.SQL.Add('select * from tblstockupdatefiles');
          qry.SQL.Add('where ((Processed = "F") or (Reported = "F"))');
          qry.SQL.Add('order by FileDate ASC');
          qry.Open;
          if qry.IsEmpty then begin
            result := true;
            exit;
          end;
          if not self.FTPParamsOk then exit;
          if not SFTPClient.ChangeDir(Ftp_File_Location) then exit;

          reportOnly := not ((Frac(now) >= Frac(self.AutoProcessStartTime)) and (Frac(now) <= Frac(self.AutoProcessEndTime)));
          if self.Params.B['ProcessNowClicked'] then
            reportOnly := false;
          while not qry.Eof do begin
            if terminated then exit;
            self.ProgressTime := now;


            if (ReportOnly and (not qry.FieldByName('Reported').AsBoolean)) or
               ((not ReportOnly) and (not qry.FieldByName('Processed').AsBoolean)) then begin

              FileNeedsProcessing :=  (DeptList.Count = 0) or (DeptList.IndexOf(qry.FieldByName('FileDept').AsString) > -1);

              stream.Clear;
              Log('Downloading file ' + qry.FieldByName('FileName').AsString, ltInfo);
              if not SFTPClient.GetFile(qry.FieldByName('FileName').AsString,stream) then begin
                Log('Unable to download file ' + qry.FieldByName('FileName').AsString, ltWarning);
                Log('Trying again ..', ltInfo);
                try
                  FreeAndNil(FSFTPClient);
                  if not SFTPClient.ChangeDir(Ftp_File_Location) then exit;
                //  SFTPClient.Connect;
                except;
                end;
                if not SFTPClient.GetFile(qry.FieldByName('FileName').AsString,stream) then begin
                  Log('Unable to download file ' + qry.FieldByName('FileName').AsString, ltWarning);
                  exit;
                end;
              end;
              Log('Download finished.', ltInfo);
              report.Clear;

              if FileNeedsProcessing then begin
                report.Add('');
                if ReportOnly then  begin
                  report.Add('The following changes where found in stock file: ' + qry.FieldByName('FileName').AsString);
                  report.Add('(No changes will be made to inventory at this stage)');
                  Log('The following changes where found in stock file: ' + qry.FieldByName('FileName').AsString, ltDetail);
                end
                else begin
                  { update it }
                  report.Add('Updating Inventory from stock file: ' + qry.FieldByName('FileName').AsString);
                  Log('Updating Inventory from stock file: ' + qry.FieldByName('FileName').AsString, ltInfo);
                end;
              end;

              report.Add('');
              if not reportOnly then
                AppEnv.AppDb.TransConnection.StartTransaction;
              try
                if FileNeedsProcessing then
                  if not ProcessFile(stream, report, reportOnly) then exit;
                if not AppEnv.AppDb.TransConnection.InTransaction then
                  AppEnv.AppDb.TransConnection.StartTransaction;
                qry.Edit;
                qry.FieldByName('Reported').AsBoolean := true;
                if not reportOnly then begin
                  qry.FieldByName('Processed').AsBoolean := true;
                  qry.FieldByName('ProcessedDate').AsDateTime := now;
                end;
                qry.Post;
                AppEnv.AppDb.TransConnection.Commit;
              finally
                if AppEnv.AppDb.TransConnection.InTransaction then
                  AppEnv.AppDb.TransConnection.Rollback;
                report.Add('Finished processing: ' + qry.FieldByName('FileName').AsString);
              end;

              { email the report }
              if FileNeedsProcessing then begin
                try
                  SendEmail(ReportEmailList,'Perecorp file ' + qry.FieldByName('FileName').AsString, report.Text, false);
                except
                  on e: exception do begin
                    Log('Error emailing report for file ' + qry.FieldByName('FileName').AsString + ': ' + e.Message, ltError);
                  end;
                end;
              end;
            end;

            qry.Next;
          end;
          result := true;
        finally
          DbSharedObj.ReleaseObj(qry);
          stream.Free;
          Report.Free;
          DeptList.Free;
        end;
      finally
        AppEnv.UtilsClient.Disconnect;
      end;

    finally
      AppEnv.AppDb.TransConnection.Disconnect;
      AppEnv.AppDb.Connection.Disconnect;
    end;
  finally
//    fProcessNowClicked := false;
    Log('Finished checking for files that need to be processed', ltInfo);
  end;
end;

function TPerecorpThreadTask.SFTPClient: TSFTPClient;
begin
  if not Assigned(FSFTPClient) then begin
    FSFTPClient := TSFTPClient.Create;
    FSFTPClient.FFtpSite := FtpSite;
    FSFTPClient.FFtpCertificate := FtpCertificate;
    FSFTPClient.FFtpPassword := FtpPassword;
    FSFTPClient.FFtpUserName := FtpUserName;
    FSFTPClient.OnLog := self.Log;
  end;
  result := FSFTPClient;
end;

{ TSFTPClient }

function TSFTPClient.ChangeDir(const newDir: string): boolean;
begin
  result := false;
  if not Client.Connected then begin
    try
      Client.Connect;
    except
      Log('Could not connect to FTP site', ltError);
      exit;
    end;
  end;
  try
    Client.ChangeDir(newDir);
    result := true;
  except
    Log('Could not change FTP directory to: ' + newDir, ltError);
    exit;
  end;
end;

function TSFTPClient.Client: TElIdSFTPClient;
var
  Key : TElSSHKey;
  KeyFileName: string;
begin
  if not Assigned(FSFTPClient) then begin
    FSFTPClient := TElIdSFTPClient.Create(nil);
    FKeyStorage := TElSSHMemoryKeyStorage.Create(nil);
    FSFTPClient.OnAuthenticationFailed := SftpClientAuthenticationFailed;
    FSFTPClient.OnAuthenticationSuccess := SftpClientAuthenticationSuccess;
    FSFTPClient.OnWork := SftpClientWork;
    FSFTPClient.OnWorkBegin := SftpClientWorkBegin;
    FSFTPClient.OnCloseConnection := SftpClientCloseConnection;
    FSFTPClient.OnError := SftpClientError;
    FSFTPClient.OnKeyValidate := SftpClientKeyValidate;


    FSFTPClient.KeyStorage := FKeyStorage;
    FSFTPClient.OnKeyValidate := SftpClientKeyValidate;

    FSFTPClient.OnWork := SftpClientWork;
    FSFTPClient.OnWorkBegin := SftpClientWorkBegin;

    FSFTPClient.Host := Self.FFtpSite;
    FSFTPClient.Port := 22;

    FSFTPClient.Versions := [sbSFTP0, sbSFTP1, sbSFTP2, sbSFTP3, sbSFTP4, sbSFTP5, sbSFTP6];
    FSFTPClient.Username := self.FFtpUserName;
    FSFTPClient.Password := self.FFtpPassword;

    FKeyStorage.Clear;
    KeyFileName := ModuleFileNameUtils.GetCurrentModulePath + self.FFtpCertificate;
    Key := TElSSHKey.Create;
    try
      Key.LoadPrivateKey(KeyFileName);
      FKeyStorage.Add(Key);
      FSFTPClient.AuthenticationTypes := FSFTPClient.AuthenticationTypes or SSH_AUTH_TYPE_PUBLICKEY;
    finally
      Key.Free;
    end;
    FSFTPClient.AuthenticationTypes := FSFTPClient.AuthenticationTypes or SSH_AUTH_TYPE_KEYBOARD;

    Log('Connecting to ' + FSFTPClient.Address, ltDetail);

    try
      FSFTPClient.Connect;
    except
      on E: Exception do begin
        Log('Sftp connection failed with message [' + E.Message + ']', ltDetail);
      end;
    end;
    Log('Sftp connection established', ltDetail);

  end;
  result := FSFTPClient;
end;

function TSFTPClient.Connect: boolean;
begin
  result := false;
  DirList.Clear;
  if not Client.Connected then begin
    try
      Client.Connect;
    except
      Log('Could not connect to FTP site', ltError);
      exit;
    end;
  end;
  result := true;
end;

constructor TSFTPClient.Create;
begin
  DirList := TIdSFTPListItems.Create;
  AppEnv.AppDb.Server:= 'localhost';
  AppEnv.UtilsClient.OnLog := Log;
end;

destructor TSFTPClient.Destroy;
begin
  FSFTPClient.Free;
  DirList.Free;
  FKeyStorage.Free;

  inherited;
end;

procedure TSFTPClient.Disconnect;
begin
  if Assigned(FSFTPClient) and FSFTPClient.Connected then
    FSFTPClient.Disconnect;
end;

function TSFTPClient.GetFile(FileName: string; stream: TStream): boolean;
begin
  result := false;
  if not Connect then exit;
  try
    Client.Get(FileName,stream);
    result := true;
  except
    on e: exception do begin
      Log('Error downloading file [' + FileName + ']: ' + e.Message, ltError);
    end;
  end;
end;

function TSFTPClient.GetFileList: boolean;
begin
  result := false;
  DirList.Clear;
  if not Client.Connected then begin
    try
      Client.Connect;
    except
      Log('Could not connect to FTP site', ltError);
      exit;
    end;
  end;
  try
    Client.List(DirList);;
    result := true;
  except
    Log('Could not get list of files from FTP site', ltError);
    exit;
  end;
end;

procedure TSFTPClient.Log(const msg: string; const aType: TLogMessageType);
begin
  if Assigned(fOnLog) then
    fOnLog(msg, aType);
end;

procedure TSFTPClient.SftpClientAuthenticationFailed(Sender: TObject;
  AuthenticationType: Integer);
begin
  Log('Authentication type [' + IntToStr(AuthenticationType) + '] failed', ltError);
end;

procedure TSFTPClient.SftpClientAuthenticationSuccess(Sender: TObject);
begin
  Log('Authentication succeeded', ltDetail);
end;

procedure TSFTPClient.SftpClientCloseConnection(Sender: TObject);
begin
  Log('Sftp connection closed', ltDetail);
end;

procedure TSFTPClient.SftpClientError(Sender: TObject; ErrorCode: Integer);
begin
  Log('Error ' + IntToStr(ErrorCode), ltError);
end;

procedure TSFTPClient.SftpClientKeyValidate(Sender: TObject;
  ServerKey: TElSSHKey; var Validate: Boolean);
begin
  Log('Server key [' + DigestToStr(ServerKey.FingerprintMD5) + '] received', ltDetail);
  Validate := true;
end;

procedure TSFTPClient.SftpClientWork(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
  Percent: integer;
begin
  Processed := AWorkCount;
  Percent := System.Round((Processed / ToProcess) * 100);
  if Frac(Percent / 10) = 0 then begin
    if fPercentDone <> Percent then begin
      fPercentDone := Percent;
      Log('Downloaded: ' + IntToStr(Percent) + ' %', ltInfo);
    end;
  end;
//  frmProgress.lProgress.Caption := IntToStr(Processed) + ' / ' + IntToStr(ToProcess);
//  frmProgress.pbProgress.Position := Processed;
end;

procedure TSFTPClient.SftpClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  ToProcess := AWorkCountMax;
  Processed := 0;
  Log('File size: ' + IntToStr(AWorkCountMax), ltDetail);
//  frmProgress.pbProgress.Max := AWorkCountMax;
end;


end.
