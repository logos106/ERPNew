// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
  //01/11/05  1.00.01 DLS Added RegisterClass

unit UnitsOfMeasureListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  DBAccess, MyAccess,ERPdbComponents, MemDS, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  wwdbdatetimepicker, ProgressDialog, kbmMemTable, 
  BusobjUOM,  MergeObj, wwdblook, Shader, DNMAction, UnitsOfMeasureBaseList,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TUnitsOfMeasureListGUI = class(TUnitsOfMeasureBaseListGUI)
    mnuMerge: TMenuItem;
    qryMainUnitID: TIntegerField;
    qryMainUnitName: TWideStringField;
    qryMainUnitDescription: TWideStringField;
    qryMainProduct: TWideStringField;
    qryMainSalesDefault: TWideStringField;
    qryMainPurchasesDefault: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainPartID: TIntegerField;
    N1: TMenuItem;
    qryMainBaseUnitID: TIntegerField;
    btnuomsummary: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    qryMainWeight: TFloatField;
    qryMainheight: TFloatField;
    qryMainwidth: TFloatField;
    qryMainLength: TFloatField;
    qryMainvolume: TFloatField;
    qryMainBaseUnitName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure actMergeExecute(Sender: TObject);
    procedure btnuomsummaryClick(Sender: TObject);
  private
    (*UOMMulitplier :double;
    PartsID:Integer;*)
    UOM:TUnitOfMeasure;
    InvalidUOMSelected:Boolean;
    MergeObj: TMergeObj;
    PrincipleName: string;
    PrincipleID: integer;
    SecordaryName: string;
    SecordaryID: integer;
  Protected
    Procedure SetGridColumns;Override;
    Procedure IterateselectedRecordsCallback(Var abort:Boolean;SelIndex:Integer);Override;
  public
    { Public declarations }
  end;

implementation

uses
  UnitsOfMeasureForm, CommonLib, Forms, {tcMessaging,} MAIN,
  dmMainGUI, frmMessage, FastFuncs, tcConst,
  BusObjBase, CommonDbLib, CommonFormLib, Appenvironment, UserUtilsClientObj;

{$R *.dfm}

procedure TUnitsOfMeasureListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
    OpenERPForm('TUnitsOfMeasureGUI', 0);
end;

procedure TUnitsOfMeasureListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Active=' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'Active=' + QuotedStr('F');
      end;
  end;
  inherited;
end;

procedure TUnitsOfMeasureListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PartID');
  RemoveFieldfromGrid('BaseUnitID');

end;

procedure TUnitsOfMeasureListGUI.actMergeExecute(Sender: TObject);
var
  msg: string;
  s:String;
begin
  inherited;
  s:= '';
  if grdMain.SelectedList.Count <=1  then exit;


  if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Merge Unit of Measure') then begin
    try
      MergeObj := TMergeObj.Create;
      try
        PrincipleName     := qryMainUnitName.asString;
        PrincipleID       := qryMainUnitID.asInteger;
        (*UOMMulitplier     := qryMainMultiplier.asFloat;
        PartsId           := qryMainPartID.AsInteger;*)
        UOM:=TUnitOfMeasure.create(Self);
        try
          UOM.Connection := TMyDacDataConnection.create(UOM);
          UOM.Connection.Connection:= qryMain.Connection;
          UOM.load(qryMainUnitID.asInteger);

          InvalidUOMSelected:= False;

          qryMain.DisableControls;
          try
            IterateProcNo:= 1;
            IterateselectedRecordsReverse(True, 'Validating Selected UOM for Merging');
          finally
            Qrymain.Enablecontrols;
          end;
          if InvalidUOMSelected  then
            s:= 'Only Unit of Measures With the Same' +chr(13) +'Multiplier' +chr(13) +'Height / Length / Width' +chr(13) +'Weight' +chr(13) +'Product' +chr(13) +' (or Blank Product) Can Be Copied.' +chr(13)+
              'Removed the UOms From Selection where Any of the Above doesn''t Match.'+chr(13)+chr(13);

          if grdMain.SelectedList.Count > 1 then begin
            if CommonLib.MessageDlgXP_Vista(s + 'Are You Sure You Wish To Merge These Unit Of Measures into ' + PrincipleName, mtConfirmation,
             [mbYes, mbNo], 0) = mrNo then Exit;

            qryMain.DisableControls;
            try
              IterateProcNo:= 2;
              IterateselectedRecords(True, 'Merging Unit of Measure');
            Finally
              Qrymain.EnableControls;
            end;

            grdMain.SelectedList.Clear;
            UpdateMe;

          end
          else if s<> '' then begin
            CommonLib.MessageDlgXP_Vista(s+ 'Please Select At Least Two (2) Unit of Measures with Same Multiplier and Same Product(or Blank Product).' + chr(13) +
                                       '(Hold down ''CTRL'' and click on row to toggle selection.)',
                                       mtInformation, [mbOK], 0);
          end else begin
            CommonLib.MessageDlgXP_Vista('Please Select At Least Two (2) Unit of Measures.' + chr(13) +
                                       '(Hold down ''CTRL'' and click on row to toggle selection.)',
                                       mtInformation, [mbOK], 0);
          end;
        finally
          FreeandNil(UOM);
        end;
      finally
        FreeandNil(MergeObj);
      end;
    finally
      AppEnv.UtilsClient.UnlockLogon;
    end;
  end
  else begin
    if msg = USERS_IN_SYSTEM_MESSAGE then begin
      MainForm.GetCurrentUserCount;
      dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Unit of Measure';
      dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
      dtmMainGUI.dlgCurrentUsers.Execute;
    end
    else begin
      MessageDlgXP_Vista('Unable to merge Unit of Measure, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TUnitsOfMeasureListGUI.IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);
var
  Msg:String;
begin
  inherited;
  if IterateProcNo = 1 then begin
    if PrincipleID   <> qryMainUnitID.asInteger then
      if not UOM.IsOkToMerge(Qrymain, Msg) then begin
        grdmain.UnselectRecord;
        InvalidUOMSelected:= true;
      end;
  end else if iterateProcNo = 2 then begin
      if PrincipleID   = qryMainUnitID.asInteger then Exit;
      SecordaryName := qryMainUnitName.asString;
      SecordaryID := qryMainUnitID.asInteger;
      MergeObj.Merge(mUOM, PrincipleName, PrincipleID, SecordaryName, SecordaryID);
   end;
end;


procedure TUnitsOfMeasureListGUI.btnuomsummaryClick(
  Sender: TObject);
begin
  inherited;
  OpenERPListForm('TUnitsOfMeasuresList');
  Self.Close;
end;

initialization
  RegisterClassOnce(TUnitsOfMeasureListGUI);
end.
