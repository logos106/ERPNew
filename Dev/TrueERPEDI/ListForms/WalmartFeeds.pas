unit WalmartFeeds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, WalmartListBase;

type
  TWalmartFeedsGUI = class(TWalmartListBaseGUI)
    qryMainID: TIntegerField;
    qryMainFeeddate: TDateTimeField;
    qryMainFeedID: TWideStringField;
    qryMainFeedType: TWideStringField;
    qryMainStatusDate: TDateTimeField;
    qryMainFeedStatus: TWideStringField;
    qryMainShipNode: TWideStringField;
    qryMainSubmittedBy: TWideStringField;
    qryMainFeedSubmissionDate: TWideStringField;
    qryMainItemsReceived: TIntegerField;
    qryMainItemsSucceeded: TIntegerField;
    qryMainItemsFailed: TIntegerField;
    qryMainItemsProcessing: TIntegerField;
    qryMainOffset: TIntegerField;
    qryMainApilimit: TIntegerField;
    qryMainErrorType: TWideStringField;
    qryMainErrorCode: TWideStringField;
    qryMainErrorField: TWideStringField;
    qryMainErrorDescription: TWideStringField;
    qryMainWFSId: TIntegerField;
    qryMainWFSEID: TIntegerField;
    btnSynchAll: TDNMSpeedButton;
    btnCheckFeeds: TDNMSpeedButton;
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure btnSynchAllClick(Sender: TObject);
    procedure btnCheckFeedsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ProcessFeedStatuses(const Value: String);
    procedure ShowFeedData;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CK_DLL_WalmartLib, BusObjWalmartFeeds, DbSharedObjectsObj,
  CommonDbLib, LogLib, SystemLib , ShellAPI , DNMLib;

{$R *.dfm}

procedure TWalmartFeedsGUI.btnCheckFeedsClick(Sender: TObject);
begin
  inherited;
  iterateprocno := 1;
  Iterateselectedrecords;
  RefreshQuery;
end;

procedure TWalmartFeedsGUI.btnSynchAllClick(Sender: TObject);
begin
  inherited;
  FeedsStatus(ProcessFeedStatuses,LoginList);
  RefreshQuery;
end;
procedure TWalmartFeedsGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('');
end;

procedure TWalmartFeedsGUI.ProcessFeedStatuses(Const Value:String);
begin
  if Value <> '' then
    TWalmartFeeds.PartnerFeedResponses(Self, DoBusinessObjectEvent,   Value);
end;
procedure TWalmartFeedsGUI.grdMainDblClick(Sender: TObject);
begin
  if trim(qrymainfeedid.asString) <> '' then begin
     FeedStatus(qrymainfeedid.asString, LoginList);
     ShowFeedData;
     RefreshQuery;
     Exit;
  end;
  inherited;
end;
procedure TWalmartFeedsGUI.ShowFeedData;
var
  qry: TERPQuery;
  fsFileName:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    if trim(qrymainfeedid.asString) <> '' then begin
      qry.sql.text := 'Select feeddata from tblwalmartfeeds where Id = ' + inttostr(qrymainid.asInteger);
      qry.open;
      if qry.fieldbyname('feeddata').asString <> '' then begin
        fsFileName := SystemLib.ExeDir+'feeddata.xml';
        clog(qry.fieldbyname('feeddata').asString, fsFileName);
        ShellExecute(Handle, 'Open', PChar(fsfilename) , '', '', SW_SHOWNORMAL);
        sleep(500);
        SetfocusToERP;
        DeleteFile(fsFileName);

      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TWalmartFeedsGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
begin
  if iterateprocno =1 then begin
    if trim(qrymainfeedid.asString) <> '' then begin
       FeedStatus(qrymainfeedid.asString, LoginList);
       Exit;
    end;
  end;
  inherited;
end;

procedure TWalmartFeedsGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainFeeddate.displayformat := FormatSettings.ShortDateformat;
end;

procedure TWalmartFeedsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TWalmartFeedsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainWFSId.fieldname);
  RemoveFieldfromGrid(qryMainWFSEID.fieldname);
end;

initialization
  RegisterClassOnce(TWalmartFeedsGUI);

end.
