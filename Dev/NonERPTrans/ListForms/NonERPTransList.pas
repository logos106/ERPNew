unit NonERPTransList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TNonERPTransListGUI = class(TBaseListingGUI)
    qryMainid: TIntegerField;
    qryMainrownum: TIntegerField;
    qryMaintransID: TIntegerField;
    qryMainERPTransId: TIntegerField;
    qryMainclientName: TWideStringField;
    qryMainclientID: TIntegerField;
    qryMaintransdate: TDateField;
    qryMainProductName: TWideStringField;
    qryMaintransLineID: TIntegerField;
    qryMainShipped: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    btnMakeERPTrans: TDNMSpeedButton;
    qryMainType: TWideStringField;
    qryMainSource: TWideStringField;
    qryMainClassname: TWideStringField;
    btnImport: TDNMSpeedButton;
    qryMainTerms: TWideStringField;
    qryMainStatus: TWideStringField;
    procedure btnMakeERPTransClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure grdMainDblClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnImportClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    procedure DoBeforeshowImportDataMapping(Sender: TObject);
  Protected
    fsTablename:String;
    transtype :String;
    Procedure PopulateData; virtual;
    procedure MakeQrymain;virtual;
    procedure SetGridColumns; Override;
    Procedure MakeERPTrans(Const aTransID:Integer);virtual;abstract;
    Function ExtraFeilds:String;virtual;
    function getDataImportType: String;virtual;
  public
    Property DataImportType :String read getDataImportType;
  end;

implementation

uses CommonDbLib, CommonLib, IntegerListObj, tcConst, CommonFormLib,
  tcDataUtils, frmImportDataMapping;

{$R *.dfm}

{ TNonERPTransListGUI }

procedure TNonERPTransListGUI.btnImportClick(Sender: TObject);
begin
  inherited;
    OpenERPForm('TfmImportDataMapping',ImportDataMapIDFortype(DataImportType), nil, DoBeforeshowImportDataMapping);
    Self.close;
end;
procedure TNonERPTransListGUI.DoBeforeshowImportDataMapping(Sender:TObject);
begin
  if sender is TfmImportDataMapping then begin
    with TfmImportDataMapping(Sender) do
      IntforType(DataImportType , DataImportType);
  end;

end;
procedure TNonERPTransListGUI.btnMakeERPTransClick(Sender: TObject);
var
   St: TIntegerList;
   ctr:Integer;

begin
  inherited;

  if SelectedRecords =0 then begin
    MessageDlgXP_Vista('Please Select the records to be Converted', mtInformation, [mbOK], 0);
    Exit;
  end;
  KeyIdtoLocate := qrymainTransID.asInteger;
  try
       St:= TIntegerList.create;
       try
        SelectedIds('TransId' , st, TRue);
        if st.Count =0 then exit;
        showProgressbar(WAITMSG, St.count+1);
        try
          for ctr := 0 to st.Count-1 do begin
            StepProgressbar(inttostr(ctr+1) +' of ' + inttostr(st.count)+' : Converting Non ERPTrans # ' + inttostr(st[ctr])) ;
            MakeERPTrans(st[ctr]);
          end;
        finally
          HideProgressbar;
        end;
      finally
        freeandnil(st);
      end;
      RefreshQuery;
  finally
    KeyIdtoLocate := 0;
  end;

end;

function TNonERPTransListGUI.ExtraFeilds: String;
begin
  Result := '';
end;

procedure TNonERPTransListGUI.FormCreate(Sender: TObject);
begin
  if grpfilters.itemindex = -1 then grpfilters.itemindex:= 0;
  inherited;
  GroupFilterString := '';
  KeyIdfieldname := Qrymaintransid.fieldname;
end;

function TNonERPTransListGUI.getDataImportType: String;
begin
  REsult := '';
end;

procedure TNonERPTransListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainrownum.asInteger >1 then
    if sametext(field.fieldname, qrymainTransId.fieldname) or
       sametext(field.fieldname, qrymainClientName.fieldname) or
       sametext(field.fieldname, qrymainSource.fieldname) or
       sametext(field.fieldname, qrymainTerms.fieldname) or
       sametext(field.fieldname, qrymainstatus.fieldname) or
       sametext(field.fieldname, qrymainTransDate.fieldname) then
    Afont.color := ABrush.color;
end;

procedure TNonERPTransListGUI.grdMainDblClick(Sender: TObject);
begin
  if (sametext(activefieldname , qrymainerptransid.fieldname) or
      sametext(activefieldname , qryMainType.fieldname)) and
      (qryMainType.AsString<>'') and
      (qrymainerptransid.asInteger <>0) then
  SubsequentID := Chr(95) + qryMainType.AsString;
  try
    inherited;
  finally
    SubsequentID := '';
  end;
end;

procedure TNonERPTransListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Selecting and (qrymainerptransid.asInteger<>0) then Accept := False;
end;

procedure TNonERPTransListGUI.grpFiltersClick(Sender: TObject);
begin
  if grpfilters.itemindex in [0,1] then begin
       if groupfilterstring  <> '' then groupfilterstring  := '(' + groupfilterstring  +') and ';
         if grpfilters.itemindex =0 then groupfilterstring := groupfilterstring + qryMainERPTransId.fieldname +' <> 0'
    else if grpfilters.itemindex =1 then groupfilterstring := groupfilterstring + qryMainERPTransId.fieldname +' = 0';
  end;
  inherited;
  GroupFilterString := '';
end;

procedure TNonERPTransListGUI.MakeQrymain;
begin
  fsTableName := GetUserTemporaryTableName('nonERP'+transtype);

  With Scriptmain do begin
    SQL.clear;
    SQL.add('DROP TABLE IF EXISTS ' + fstablename +';');
    SQL.add('CREATE TABLE ' + fstablename +' ( '+
            ' id INT(11) NOT NULL AUTO_INCREMENT, '+
            ' rownum INT(11) DEFAULT NULL, '+
            ' aTransId int(11) NULL DEFAULT 0, '+
            ' TransId int(11) NULL DEFAULT 0, '+
            ' ERPTransId int(11) NULL DEFAULT 0, '+
            ' ClientName varchar(255) DEFAULT NULL, '+
            ' Source varchar(255) DEFAULT NULL, '+
            ' Terms varchar(255) DEFAULT NULL, '+
            ' status varchar(255) DEFAULT NULL, '+
            ' clientID int(11) DEFAULT NULL, '+
            ' TransDate date DEFAULT NULL, '+
            ' ProductName varchar(60) DEFAULT NULL, '+
            ' TranslineID int(11) NULL DEFAULT 0, '+
            ' Shipped double NULL DEFAULT 0, '+
            ' TotalLineAmountInc double NULL default 0, '+
            ' Classname varchar(255) null default null,'+
            ' Type varchar(50) DEFAULT NULL, '+
            ExtraFeilds +
            ' PRIMARY KEY (id) )  ENGINE=MyISAM DEFAULT CHARSET=utf8;');
    Execute;
  end;

  Qrymain.SQL.clear;
  Qrymain.SQL.adD('Select *');
//  Qrymain.SQL.add('id, rownum, aTransId, ERPTransId, ClientName, Source, Terms, status, clientID,');
//  Qrymain.SQL.add('TransDate, ProductName, TranslineID, Shipped, TotalLineAmountInc, Classname, Type');
  Qrymain.SQL.adD('from '+ fstablename);
  Qrymain.SQL.adD('order by id');
end;

procedure TNonERPTransListGUI.PopulateData;
begin

end;

procedure TNonERPTransListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainTranslineID.fieldname);
  RemoveFieldfromGrid(qryMainrownum.fieldname);
  RemoveFieldfromGrid(qryMainclientID.fieldname);

end;

end.
