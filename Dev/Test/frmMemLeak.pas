unit frmMemLeak;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, ProgressDialog;

type
  TfmMemLeak = class(TBaseInputGUI)
    Button1: TButton;
    memLog: TMemo;
    Timer1: TTimer;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    fLastPhysicalBytes,
    fLastPageBytes: integer;
    fLastMemUsageBytes: integer;
    function ShowMemory: string;
  public
    { Public declarations }
  end;

var
  fmMemLeak: TfmMemLeak;

implementation

uses
  BusObjSales, BusObjBase, CommonDbLib, frmInvoice, XMLDoc,
  frmProcResourceEdit, frmChartOfAccountsFrm, frmShippingFrm, BusObjCommon,
  PsAPI, SystemLib; { used for CurrentMemoryUsage }

{$R *.dfm}


//current memory size of the current process in bytes
function CurrentMemoryUsage: Cardinal;
var
 pmc: TProcessMemoryCounters;
begin
  result:= 0;
 pmc.cb := SizeOf(pmc) ;
 if GetProcessMemoryInfo(GetCurrentProcess, @pmc, SizeOf(pmc)) then
   Result := pmc.WorkingSetSize
 else
   RaiseLastOSError;
end;

procedure TrimWorkingSet;
begin
  systemlib.TrimWorkingSet
(*var
  MainHandle : THandle;
begin
 MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
 SetProcessWorkingSetSize(MainHandle,DWORD(-1),DWORD(-1));
 CloseHandle(MainHandle);*)
end;

function SecondsIdle: DWord;
var
   liInfo: TLastInputInfo;
begin
   liInfo.cbSize := SizeOf(TLastInputInfo) ;
   GetLastInputInfo(liInfo) ;
   Result := (GetTickCount - liInfo.dwTime) DIV 1000;
end;

procedure TfmMemLeak.Button1Click(Sender: TObject);
var
  x: integer;
//  Invoice: TInvoice;
//  ShipMethod: TShippingMethod;
  memStart: string;
  form: TInvoiceGUI;
//  form: TfmProcResourceEdit;
//  form: TfrmChartOfAccounts;
//  form: TfrmShipping;
//  XMLDoc: TXMLDocument;
//  fLastPhysicalBytesSave,
//  fLastPageBytesSave: integer;
  fLastMemUsageBytesStart: integer;
  CurrMemUsage: integer;
begin
  inherited;
  memStart:=  ShowMemory;
  x:= 0;
  memLog.Lines.Add('Count: ' + IntToStr(x) + '  ' + ShowMemory);
  TrimWorkingSet;
//  fLastPhysicalBytesSave:= fLastPhysicalBytes;
//  fLastPageBytesSave:= fLastPageBytes;
  fLastMemUsageBytes:= CurrentMemoryUsage;
  fLastMemUsageBytesStart:= fLastMemUsageBytes;
  memLog.Lines.Add('Start Mem Usage: ' + FormatFloat('#,##0',fLastMemUsageBytesStart));
  for x:= 1 to 100 do begin
//    memLog.Lines.Add('Count: ' + IntToStr(x) + '  ' + ShowMemory);
    CurrMemUsage:= CurrentMemoryUsage;
    memLog.Lines.Add('Count: ' + IntToStr(x) +
      '  Used Mem: ' + FormatFloat('#,##0',CurrMemUsage) + '  Diff: ' + FormatFloat('#,##0',CurrMemUsage - fLastMemUsageBytes));
    fLastMemUsageBytes:= CurrMemUsage;
//    Invoice:= TInvoice.Create(nil);
//    try
//      Invoice.Connection:= TMyDacDataConnection.Create(Invoice);
//      Invoice.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
//      Invoice.Load(837);
//      Invoice.Closedb;
//    finally
//      Invoice.Free;
//    end;

    form:= TInvoiceGUI.Create(application);
    try
      form.KeyID:= 0; //837;
      form.Show;

    finally
      form.Release;
    end;

//    form:= TfrmShipping.Create(application);
//    try
//      form.KeyID:= 1;
//      form.Show;
//
//    finally
//      form.Release;
//    end;

//    ShipMethod:= TShippingMethod.Create(nil);
//    try
//      ShipMethod.Connection:= TMyDacDataConnection.Create(ShipMethod);
//      ShipMethod.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
//      ShipMethod.Load(1);
//      ShipMethod.Closedb;
//    finally
//      ShipMethod.Free;
//    end;

//    form:= TfmProcResourceEdit.Create(application);
//    try
//      form.KeyID:= 1;
//      form.Show;
//
//    finally
//      form.Release;
//    end;

//    form:= TfrmChartOfAccounts.Create(application);
//    try
//      form.KeyID:= 1;
//      form.Show;
//
//    finally
//      form.Release;
//    end;

//    XMLDoc:= TXMLDocument.Create('');
//    try
//      XMLDoc.Create(nil);
//      XMLDoc.LoadFromFile('c:\temp\temp.xml');
//
//    finally
//      XMLDoc.Free;
//    end;

  end;
  memLog.Lines.Add('');
//  memLog.Lines.Add('Memory at start: ' + memStart);
//  fLastPhysicalBytes:= fLastPhysicalBytesSave;
//  fLastPageBytes:= fLastPageBytesSave;
//  memLog.Lines.Add('Memory at end:   ' + ShowMemory);

  CurrMemUsage:= CurrentMemoryUsage;
  memLog.Lines.Add('Total Diff: ' + FormatFloat('#,##0',CurrMemUsage - fLastMemUsageBytesStart));

  TrimWorkingSet;
  CurrMemUsage:= CurrentMemoryUsage;
  memLog.Lines.Add('Total Diff after trim: ' + FormatFloat('#,##0',CurrMemUsage - fLastMemUsageBytesStart));

end;

function TfmMemLeak.ShowMemory: string;
var
  MemStat: TMemoryStatus;
  PhysicalBytes,
  PageBytes: integer;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  PhysicalBytes:= MemStat.dwTotalPhys - MemStat.dwAvailPhys;
  PageBytes:= MemStat.dwTotalPageFile - MemStat.dwAvailPageFile;
  result:= 'Used Physical Bytes: ' + FormatFloat('#,##0',PhysicalBytes) +
    '    Diff: ' + FormatFloat('#,##0',PhysicalBytes - fLastPhysicalBytes) +
    '    Used Paging Bytes: ' + FormatFloat('#,##0',PageBytes) +
    '    Diff: ' + FormatFloat('#,##0',PageBytes - fLastPageBytes);
  fLastPhysicalBytes:= PhysicalBytes;
  fLastPageBytes:= PageBytes;
end;

procedure TfmMemLeak.FormCreate(Sender: TObject);
begin
  inherited;
  fLastPhysicalBytes:= 0;
  fLastPageBytes:= 0;
end;

procedure TfmMemLeak.Timer1Timer(Sender: TObject);
begin
  inherited;
  Caption:= 'Seconds Idle: ' + FormatFloat('#,##0',SecondsIdle);
end;

procedure TfmMemLeak.Button2Click(Sender: TObject);
begin
  inherited;
  memLog.Lines.Add('Current Mem Usage: ' + FormatFloat('#,##0',CurrentMemoryUsage));
  TrimWorkingSet;
  memLog.Lines.Add('Current Mem Usage After Trim: ' + FormatFloat('#,##0',CurrentMemoryUsage));

end;

initialization
  RegisterClass(TfmMemLeak);

end.
