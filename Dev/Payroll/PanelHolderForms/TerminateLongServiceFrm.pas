unit TerminateLongServiceFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DNMPanel, wwcheckbox,BusObjTermination,
  Mask, wwdbedit, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, frmBase;

type
  TfrmTerminateLongService = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label12: TLabel;
    Bevel8: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    chkOverrideLongService: TwwCheckBox;
    DSEmpTerminate: TDataSource;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;

    procedure SetSubTerminate(Const Value :Temployeeterminations   );
  private
    fSubTerminate:Temployeeterminations;
  public
    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
  end;



implementation

uses
  CommonLib;


procedure TfrmTerminateLongService.SetSubTerminate(Const Value :Temployeeterminations);
begin
  fSubTerminate := Value;

//  if fSubTerminate.IsETPEntitled then
//    rgETP.Itemindex:= 0
//  else
//    rgETP.Itemindex:= 1;
end;
{$R *.dfm}


initialization
RegisterClassOnce(TfrmTerminateLongService);
end.
