unit frmBulkPayBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel,TypesLib;

type
  TfmBulkPayBase = class(TBaseInputGUI)
    dsMain: TDataSource;
    qryMain: TERPQuery;
    pnlfooter: TDNMPanel;
    lblFilter: TLabel;
    bbOK: TDNMSpeedButton;
    btnSelectAll: TDNMSpeedButton;
    btnClear: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    bbCancel: TDNMSpeedButton;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    fbSelectingAll:Boolean;
    fbdeselectingAll:Boolean;
    dBalance, dSelected : double;
    dAmtTendered        : currency;
    sBaseIndexFieldNames: string;
    sFilter             : string;
    fbSwapBaseIndex     : boolean;
    fsSecondaryIndex    : string;

    dSelectedBalance    : currency;
    dRunningBalance     : currency;
    fbCalculatingRunningBalance:Boolean;
  const
    filtercaption = 'Filter : ';
    Procedure IterateQrymain(Const IterateProc :TGeneralProc; Const fsFilter :STring = ''; IterateMsg:String = 'Check All Transactions');
    Procedure EditQrymain;
    Procedure PostQrymain;
    Procedure DeSelectall;Virtual;
    Procedure SelectAll;Virtual;
    Procedure DoDeSelectall;Virtual;Abstract;
    Procedure DoSelectAll;Virtual;Abstract;
    procedure DoCalculateRunningBalance;Virtual;abstract;
    procedure CalcBalance;Virtual;Abstract;
    procedure CalculateRunningBalance;Virtual;
    Procedure ShowFilter(Const Value:String);
  public
    property AmountTendered     : currency  read dAmtTendered           write dAmtTendered;
    property SelectedBalance    : currency  read dSelectedBalance       write dSelectedBalance;
    property RunningBalance     : currency  read dRunningBalance        write dRunningBalance;
    property BaseIndexFieldNames: string    read sBaseIndexFieldNames   write sBaseIndexFieldNames;
    property Filter             : string    read sFilter                write sFilter;
    property SwapBaseIndex      : boolean   read fbSwapBaseIndex        write fbSwapBaseIndex default false;
    property SecondaryIndex     : string    read fsSecondaryIndex       write fsSecondaryIndex;
  end;

implementation

uses tcConst;

{$R *.dfm}

procedure TfmBulkPayBase.CalculateRunningBalance;
begin
  if fbCalculatingRunningBalance then exit;
  if fbselectingAll then exit;
  if fbdeselectingall then exit;

  fbCalculatingRunningBalance:= True;
  try
    DoCalculateRunningBalance;
  finally
    fbCalculatingRunningBalance:= False;
  end;
end;

procedure TfmBulkPayBase.DeSelectall;
begin
  fbdeselectingAll:= true;
  try
    DoDeSelectall;
  finally
    fbdeselectingAll:= False;
  end;

end;

procedure TfmBulkPayBase.EditQrymain;
begin
    if Qrymain.state in [dsEdit,dsInsert] then else
        Qrymain.Edit;
end;
procedure TfmBulkPayBase.PostQrymain;
begin
    if Qrymain.state in [dsEdit,dsInsert] then
        Qrymain.post;
end;

procedure TfmBulkPayBase.SelectAll;
begin
  fbselectingAll:= true;
  try
    DoSelectAll;
  finally
    fbselectingAll:= False;
  end;
end;

procedure TfmBulkPayBase.ShowFilter(const Value: String);
begin
  lblFilter.caption := Value;
  lblFilter.visible := not(sametext(lblFilter.caption , filtercaption));
end;

procedure TfmBulkPayBase.FormCreate(Sender: TObject);
begin
  inherited;
  fbSelectingAll:=False;
  fbdeselectingAll:=False;
  fbCalculatingRunningBalance:= False;
  ShowFilter('');
end;

Procedure TfmBulkPayBase.IterateQrymain(Const IterateProc :TGeneralProc; Const fsFilter :STring = ''; IterateMsg:String = 'Check All Transactions');
var
    Bookmark :TBookmark;
begin
ShowProgressbar(IterateMsg , Qrymain.RecordCount+10);
try
    if Qrymain.active = False then exit;
    StepProgressbar;
    PostQrymain;
    Bookmark:= Qrymain.GetBookmark;
    StepProgressbar;
    Qrymain.DisableControls;
    try
        if fsFilter <> '' then begin
           Qrymain.filter :=fsFilter;
           Qrymain.Filtered := True;
        end;
        StepProgressbar;
        if Qrymain.RecordCount > 0 then begin
            Qrymain.First;
            While Qrymain.Eof = False do begin
                StepProgressbar(inttostr(Qrymain.recno)+' of ' + inttostr(Qrymain.RecordCount));
                IterateProc;
                Qrymain.Next;
            end;
        end;
    finally
        StepProgressbar;
        if fsFilter <> '' then Qrymain.Filtered    := False;
        Qrymain.GotoBookmark(Bookmark);
        Qrymain.FreeBookmark(Bookmark);
        Qrymain.EnableControls;
    end;
finally
  HideProgressbar;
end;
end;

end.
