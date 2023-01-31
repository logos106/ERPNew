library ozedi;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  utOzEDI in 'utOzEDI.pas',
  JSONObject in '..\..\Common\JSONObject.pas',
  UpdaterConst in '..\ERPUpdater\UpdaterConst.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  ModuleFileNameUtils in '..\..\Common\ModuleFileNameUtils.pas',
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  LogThreadBase in '..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  MultiEventObj in '..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  HTTPConst in '..\..\Common\HTTPConst.pas';

{$R *.res}

  function ExGetToken: PChar; //stdcall;
  begin
    //result := PChar(TOzEDI.Inst.GetToken);
    result := PChar(OzEDIInst.GetToken);
  end;

  procedure ExSetSandpitMode(Value: boolean); //stdcall;
  begin
    //TOzEDI.Inst.SandpitMode := value;
    OzEDIInst.SandpitMode := value;
  end;

  function ExGetSandpitMode: boolean; //stdcall;
  begin
    //result := TOzEDI.Inst.SandpitMode;
    result := OzEDIInst.SandpitMode;
  end;

  function ExGetClientID: PChar; //stdcall;
  begin
    //result := PChar(TOzEDI.Inst.ClientID);
    result := PChar(OzEDIInst.ClientID);
  end;

  procedure ExSetClientID(Value: PChar); //stdcall;
  begin
    //TOzEDI.Inst.ClientID := Value;
    OzEDIInst.ClientID := Value;
  end;

  function ExGetABN: PChar; stdcall;
  begin
    //result := PChar(TOzEDI.Inst.ABN);
    result := PChar(OzEDIInst.ABN);
  end;

  procedure ExSetABN(Value: PChar); //stdcall;
  begin
    //TOzEDI.Inst.ABN := Value;
    OzEDIInst.ABN := Value;
  end;

  function ExUpload(aMessageType: integer; aFileName: PChar): PChar; //stdcall;
  begin
    //result := PChar(TOzEDI.Inst.Upload(aMessageType, aFileName));
    result := PChar(OzEDIInst.Upload(aMessageType, aFileName));
  end;

  function ExGetMessageStatus(aMessageUuid: PChar): PChar; //stdcall;
  begin
    //result := PChar(TOzEDI.Inst.GetMessageStatus(aMessageUuid));
    result := PChar(OzEDIInst.GetMessageStatus(aMessageUuid));
  end;

  function ExGetResponseHeader(aMessageUuid: PChar): PChar; //stdcall;
  begin
    //result := PChar(TOzEDI.Inst.GetResponseHeader(aMessageUuid));
    result := PChar(OzEDIInst.GetResponseHeader(aMessageUuid));
  end;

  { returns the file name of the response }
  function ExGetResponsePayload(aMessageUuid: PChar): PChar; //stdcall;
  begin
    //result := PChar(TOzEDI.Inst.GetResponsePayload(aMessageUuid));
    result := PChar(OzEDIInst.GetResponsePayload(aMessageUuid));
  end;

  function ExGetLastErrorMessage: PChar;
  begin
    //result := PChar(TOzEDI.Inst.LastErrorMessage);
    result := PChar(OzEDIInst.LastErrorMessage);
  end;

  function ExGetDebugMode: boolean;
  begin
    //result := TOzEDI.Inst.DebugMode;
    result := OzEDIInst.DebugMode;
  end;

  procedure ExSetDebugMode(Value: boolean);
  begin
    try
//      TOzEDI.Inst.DebugMode := Value;
      OzEDIInst.DebugMode := Value;
    except
      on e: exception  do begin
        Log(e.Message, ltError);
        raise;
      end;
    end;
  end;


exports
  ExGetToken,

  ExGetSandpitMode,
  ExSetSandpitMode,

  ExGetClientID,
  ExSetClientID,

  ExGetABN,
  ExSetABN,

  ExUpload,
  ExGetMessageStatus,
  ExGetResponseHeader,
  ExGetResponsePayload,
  ExGetLastErrorMessage,

  ExGetDebugMode,
  ExSetDebugMode;

begin
end.
