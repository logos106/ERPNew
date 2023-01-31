unit frmAllocationExtender;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Grids, Wwdbigrd, Wwdbgrid, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, DNMSpeedButton, ProductQtyLib, Buttons, StdCtrls, wwcheckbox,
  ExtCtrls, DNMPanel , GuiPrefsObj, Menus, SelectionDialog;

type
  TProc = Procedure (formExt: TForm) of Object;
  TfmAllocationExt = class(TBaseForm)
    qrymain: TERPQuery;
    dsmain: TDataSource;
    pnlDetails: TDNMPanel;
    grdmain: TwwDBGrid;
    pnlBottom: TDNMPanel;
    btnclose: TDNMSpeedButton;
    btncancel: TDNMSpeedButton;
    btnViewStock: TDNMSpeedButton;
    lblNote: TLabel;
    DNMPanel1: TDNMPanel;
    Bevel6: TBevel;
    lblSelect: TLabel;
    lblExtra: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure grdmainKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure grdMainDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdmainRowChanged(Sender: TObject);
    procedure btnViewStockClick(Sender: TObject);
    procedure grdmainKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fiProductID   : Integer;
    fiClassID     : Integer;
    fsBatchno     : String;
    fsPQAType     : TFiltertype;
    fExpiryDate   : TDatetime;
    fTransDate    : TDatetime;
    fsBinnumber   : String;
    fsBinLocation : String;
    fMyConnection : TERPConnection;
    fsUOM         : String;
    fMoveForms    : TProc;
    fbEnbleMultisel:Boolean;
    fbautoSelect  : Boolean;
    fdQty         : double;
    fsSearchField : String;
    fsSearchData:String;
    fsAllocType: String;
    fbIsSubObject: Boolean;
    GuiPrefs: TFormGuiPrefs;
    Procedure AssignSearchfield;
    Procedure DoSearch;
    function CheckforClass(const ClassID: Integer): Integer;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure initProductQtyBinETA(Sender: TObject);
  Protected
    Procedure DoExtraTranslation;Override;
  public
    Property ProductID    : Integer       Read fiProductID      Write fiProductID;
    Property ClassID      : Integer       Read fiClassID        Write fiClassID;
    Property Batchno      : String        Read fsBatchno        Write fsBatchno;
    Property ExpiryDate   : TDatetime     Read fExpiryDate      Write fExpiryDate;
    Property PQAType      : TFiltertype   Read fsPQAType        Write fsPQAType;
    Property TransDate    : TDatetime     Read fTransDate       Write fTransDate;
    Property BinLocation  : String        Read fsBinLocation    Write fsBinLocation;
    Property Binnumber    : String        Read fsBinnumber      Write fsbinnumber;
    Property Qty          : double        Read fdQty            Write fdQty;
    Property MyConnection : TERPConnection REad fMyConnection   Write fMyConnection;
    Property UOM          : String        Read fsUOM            Write fsUOM;
    Property MoveForms    : TProc         read fMoveForms       Write fMoveforms;
    Property EnbleMultisel: Boolean       Read fbEnbleMultisel  Write fbEnbleMultisel;
    Property autoSelect   : Boolean       REad fbautoSelect     Write fbautoSelect;
    Property AllocType    : String        read fsAllocType      Write fsAllocType;
    Property IsSubObject  : Boolean       read fbIsSubObject    Write fbIsSubObject;

  end;

implementation

uses CommonLib, busobjPQA,  FastFuncs, frmAllocation, graphUtil, MAIN,
  AppEnvironment, StockQtysLocationsReport, frmProductQtysBinsETAs , tcConst,
  PQALib, CommonFormLib;

{$R *.dfm}
function  TFmAllocationExt.CheckforClass(const ClassID:Integer):Integer;
begin
  Result := ClassId;
  if appenv.CompanyPrefs.AllowAlocationFromOtherClasses then
    if AllocType = 'OUT' then
      if IsSubObject =False then
          Result  := 0 ;
end;
procedure TfmAllocationExt.FormShow(Sender: TObject);
var
  strSQL:String;
  ctr:Integer;
  Key: Word;
  Shift: TShiftState;
  fclassID:Integer;
begin
try
  inherited;
  grdMain.ShowHint := true;

  if  fbEnbleMultisel then begin
    grdmain.hint :=    'Double click to select one item.' + chr(13) +
                       'Hold Down shift/Ctrl and select multiple and Press CTRL+ENTER to Allocate'+ chr(13) +
                       'Hold down ALT and Press A  for Auto Select and Press CTRL+ENTER to Allocate.'
  end else begin
    grdmain.hint:= 'Double click or Press ENTER to select';
    //grdmain.height := 325;
  end;



  fClassID:= CheckforClass(ClassID);
  if not (AutoSelect) then
    strSQL:= SQL4ProductAvailableQty(Transdate, UOM , PQAtype , ProductID, fclassId, Batchno , ExpiryDate, binLocation, Binnumber ,'' , tAvailable,'PQABatch.CustFLD1 , PQABatch.CustFLD2, PQABatch.CustFLD3, PQABatch.CustFLD4, PQABatch.CustFLD5,PQABatch.CustFLD6,PQABatch.CustFLD7','', 0, true )
  else
    strSQL:= SQL4ProductAvailableQty(Transdate, '' , PQAtype , ProductID, fclassId, Batchno , ExpiryDate, binLocation, Binnumber,'' , tAvailable,'PQABatch.CustFLD1 , PQABatch.CustFLD2, PQABatch.CustFLD3, PQABatch.CustFLD4, PQABatch.CustFLD5,PQABatch.CustFLD6,PQABatch.CustFLD7','', 0, true);


  with Qrymain do begin
      if Active then close;
      connection := MyConnection;
      SQL.clear;

      SQL.add(strSQL);
      open;
           if PQAtype = tDEtails        then Qrymain.filter := 'UOMQty <> 0 and UOMQty <> null and Batchno      <> '''' and Batchno       <> null'
      else if PQAtype = tExtraDetails   then Qrymain.filter := 'UOMQty <> 0 and UOMQty <> null and binLocation  <> '''' and binLocation   <> null'
      else if PQAtype = tDetailswithSno then Qrymain.filter := 'UOMQty <> 0 and UOMQty <> null and Serialnumber <> '''' and Serialnumber  <> null';
      qrymain.filtered := true;
  end;
  AssignSearchfield;
  if Autoselect = False then begin
    for ctr := 0 to qrymain.FieldCount-1 do begin
      Qrymain.Fields[ctr].Visible :=
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'Batchno'))       and (PQAtype = tDEtails)) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'CUSTFLD1'))       and (PQAtype = tDEtails)) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'ExpiryDate'))    and (PQAtype = tDEtails) and appenv.Companyprefs.ShowAllocationBatchExpiryDate ) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'TruckLoadNo'))    and (PQAtype = tDEtails) and appenv.Companyprefs.ShowAllocationBatchTruckLoadNo ) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'Binlocation'))   and (PQAType = tExtraDetails)) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'Binnumber'))     and (PQAType = tExtraDetails)) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'Serialnumber'))  and (PQAType = tDetailswithSno) ) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'Classname'))  and (PQAType >= tDEtails) ) OR
          ((Sysutils.SameText(Qrymain.Fields[ctr].fieldname, 'UOMQty'))        and (PQAType <> tDetailswithSno) );
    end;
    if Qrymain.findfield('Batchno')     <> nil then begin Qrymain.fieldbyname('Batchno').displayLabel     := AppEnv.DefaultClass.AllocationBatchnoName;  Qrymain.fieldbyname('Batchno').DisplayWidth     := 18; end;
    if Qrymain.findfield('CUSTFLD1')     <> nil then begin Qrymain.fieldbyname('CUSTFLD1').displayLabel     := AppEnv.CompanyPrefs.PQADEtailsCUSTFLD1;  Qrymain.fieldbyname('CUSTFLD1').DisplayWidth     := 18; end;
    if Qrymain.findfield('ExpiryDate')  <> nil then begin Qrymain.fieldbyname('ExpiryDate').displayLabel  := AppEnv.DefaultClass.AllocationExpiryDateName;   Qrymain.fieldbyname('ExpiryDate').DisplayWidth  := 10; end;
    if Qrymain.findfield('TruckLoadNo') <> nil then begin Qrymain.fieldbyname('TruckLoadNo').displayLabel := AppEnv.DefaultClass.AllocationTruckLoadNoName; Qrymain.fieldbyname('TruckLoadNo').DisplayWidth  := 10; end;
    if Qrymain.findfield('Binlocation') <> nil then begin Qrymain.fieldbyname('Binlocation').displayLabel := 'Bin Location';  Qrymain.fieldbyname('Binlocation').DisplayWidth := 15; end;
    if Qrymain.findfield('Binnumber')   <> nil then begin Qrymain.fieldbyname('Binnumber').displayLabel   := 'Bin Number';    Qrymain.fieldbyname('Binnumber').DisplayWidth   := 15; end;
    if Qrymain.findfield('Serialnumber')<> nil then begin Qrymain.fieldbyname('Serialnumber').displayLabel:= 'Serial Number'; Qrymain.fieldbyname('Serialnumber').DisplayWidth:= 20; end;
    if Qrymain.findfield('Serialnumber')<> nil then begin Qrymain.fieldbyname('UOM').displayLabel         := 'UOM';           Qrymain.fieldbyname('UOM').DisplayWidth         := 10; end;
    if Qrymain.findfield('UOMQty')      <> nil then begin
      Qrymain.fieldbyname('UOMQty').displayLabel      := 'Qty';
      Qrymain.fieldbyname('UOMQty').DisplayWidth      := 8;
      TFloatField(Qrymain.fieldbyname('UOMQty')).Displayformat := '###,###,###,##0.0#####';
    end;
    if fclassId = 0 then begin
        if Qrymain.findfield('DepartmentID') <> nil then Qrymain.findfield('DepartmentID').visible := False;
        if Qrymain.findfield('Classname') <> nil then begin Qrymain.fieldbyname('Classname').DisplayLabel := appenv.DefaultClass.ClassHeading ;Qrymain.fieldbyname('Classname').DisplayWidth := 10; end;
    end else begin
      if Qrymain.findfield('Classname') <> nil then Qrymain.findfield('Classname').visible := False;
    end;
    if PQAtype = tDEtails then begin
      grdmain.TitleFont.Color := clNavy;
      lblSelect.Caption := 'Batches';
    end else if PQAtype = tExtraDetails then begin
      lblSelect.Caption := 'Bins';
      grdmain.TitleFont.Color := clMaroon;
    end else if PQAtype = tDetailswithSno then begin
      lblSelect.Caption := 'Serial Numbers';
      grdmain.TitleFont.Color := clGreen;
    end;
    btnViewStock.ShowHint    := true;
    btnViewStock.hint        :=
        'List above shows the ' + lblselect.Caption+' with  available quantity in ''' +UOM +'''' + chr(13)+
        'Select ''View All'' to see the complete stock in all Unit of measures';

    lblSelect.Caption := 'Select to Allocate ' + lblselect.Caption ;
    lblSelect.Font.Color :=grdmain.TitleFont.Color;



    if (Assigned(Self.Owner)) then begin
      if (Self.Owner is TfmAllocation) then begin
        Self.Top      := TfmAllocation(Self.Owner).top;
        Self.Left     := TfmAllocation(Self.Owner).Left+TfmAllocation(Self.Owner).Width;
        Self.height   := TfmAllocation(Self.Owner).height;
        Self.Color    := TfmAllocation(Self.Owner).color;
      end else if Self.Owner is TForm then begin
        Self.Color    := TForm(Self.Owner).color;
        Left          := (Application.MainForm.ClientWidth - Self.Width) shr 1;
        Top           := ((Application.MainForm.ClientHeight + StatusAndToolbarHeight) - Self.Height) shr 1;
      end;
    end;
    //Setcolwidth(grdMain, true);
    if Assigned(fMoveForms) then fMoveForms(Self);
  end;
  if qrymain.recordcount > 0 then  begin
    qrymain.first;
    grdmain.SelectRecord;
  end;
  if autoSelect then begin
    if Qrymain.recordcount > 0 then begin
        Qrymain.first;
        Key   := VK_RETURN;
        shift := [ssctrl]; 
        grdmainKeyUp(grdmain, Key, Shift);
    end;
    autoSelect := False;
  end;
finally
  ReadGuipref;
  //Setcolwidth(grdMain, true);
  TimerMsg(lblExtra , 'SHIFT + ALT + CTRL + RIGHT/LEFT to resize the form.' +NL+'Form size and column widths gets saved as user preference' , 10);
end;
end;

procedure TfmAllocationExt.FormPaint(Sender: TObject);
begin
// kill formpaint which changes the color
//  inherited;
end;

procedure TfmAllocationExt.grdmainKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
var
  xQty :Double;
  i:Integer;
  (*function SearchCharpressed:Boolean;
  begin
      result := ((Key>=32) and (Key<= 126))
  end;*)
begin
  inherited;
  if Key = VK_ESCAPE then begin
    grdmain.UnselectAll;
    modalresult := mrcancel;
  end else if (Shift = [ssShift]) and (Key=VK_space) then begin
    if grdmain.isSelected then grdmain.UnselectRecord else grdmain.SelectRecord;
  end else if ((Shift = [ssctrl]) and (Key=VK_RETURN)) then begin
    if grdmain.SelectedList.Count=0 then grdmain.SelectRecord;
    modalResult := mrOK;
  end else if ((Shift = [ssAlt]) and ((Chr(Key)='A') or (Chr(Key)='a'))) then begin
    xQty:= 0;
    for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qrymain.GotoBookmark(grdMain.SelectedList.Items[i]);
      xQty := xQty +qrymain.fieldbyname('UOMQty').asFloat;
    end;
    if xQty < qty then begin
      qrymain.first;
      while (qrymain.eof = False) and (xQty<qty) do begin
        if grdmain.IsSelected = False then begin
          grdmain.SelectRecord;
          xQty := xQty +qrymain.fieldbyname('UOMQty').asFloat;
        end;
        qrymain.Next;
      end;
    end;
  end else if (Key = VK_DELETE) and (Shift = [ssAlt]) then begin
    fsSearchData := '';
    Qrymain.First;
    grdmain.UnselectAll;
(*  end else if SearchCharpressed then begin 
    fsSearchData:=fsSearchData +Chr(Key);
    DoSearch; *)
  end;
end;

procedure TfmAllocationExt.grdmainDblClick(Sender: TObject);
begin
  inherited;
  grdmain.UnselectAll;
  grdmain.SelectRecord;
  modalResult := mrOK;
end;


procedure TfmAllocationExt.FormCreate(Sender: TObject);
begin
  inherited;
  fMoveForms      := nil;
  fbEnbleMultisel := true;
  autoSelect      := False;
  fsAllocType     := '';
  fbIsSubObject   := False;
end;

procedure TfmAllocationExt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    if  (ssShift in shift) and (ssAlt in shift) and (ssCtrl in Shift) then begin
      if key = VK_RIGHT then Self.Width := Self.Width +1
      else if key = VK_LEFT then Self.Width := Self.Width -1;
    end;
end;

procedure TfmAllocationExt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuipref;
  inherited;
  grdMain.ShowHint := False;
end;

procedure TfmAllocationExt.grdmainRowChanged(Sender: TObject);
begin
  inherited;
  //grdmain.SelectRecord;
end;

procedure TfmAllocationExt.ReadGuipref;
var
  ctr:Integer;
begin
  GuiPrefs:= TFormGuiPrefs.Create(self);
  GuiPrefs.Active := true;
  if GuiPrefs.Node.Exists('Options') then begin
    if GuiPrefs.Node['Options.formWidth'].asInteger <> 0 then Self.Width :=GuiPrefs.Node['Options.formWidth'].asInteger;
    for ctr := 0 to qrymain.FieldCount -1 do
        if GuiPrefs.Node['Options.'+qrymain.fields[ctr].fieldname].asInteger <> 0 then
          qrymain.fields[ctr].displaywidth :=GuiPrefs.Node['Options.'+qrymain.fields[ctr].fieldname].asInteger;
  end;
end;

procedure TfmAllocationExt.WriteGuiPref;
var
  ctr:Integer;
begin
  GuiPrefs.Node['Options.formWidth'].asInteger:= Self.Width;
  for ctr := 0 to Qrymain.FieldCount-1 do
    if (Qrymain.fields[ctr].visible) then
      GuiPrefs.Node['Options.'+Qrymain.fields[ctr].fieldname].asInteger := Qrymain.fields[ctr].displaywidth ;
end;
procedure TfmAllocationExt.initProductQtyBinETA(Sender: TObject);
begin
    with TfrmProductQtyBinETA(Sender) do begin
      TfrmProductQtyBinETA(Sender).KeyID := Self.ProductID;
      TfrmProductQtyBinETA(Sender).ClassID := Self.ClassID;
      TfrmProductQtyBinETA(Sender).SalesOrderMode := false;
      TfrmProductQtyBinETA(Sender).BlockMode := true;
//@@      showmodal;
//@@      Exit;
    end;
end;
procedure TfmAllocationExt.btnViewStockClick(Sender: TObject);
begin
  OpenERPFormModal('TfrmProductQtyBinETA' , 0 , initProductQtyBinETA);
end;

procedure TfmAllocationExt.AssignSearchfield;
begin
  fsSearchData := '';
  fsSearchField := '';
       if PQAtype = tDEtails then fsSearchField := 'Batchno'
  else if PQAType = tExtraDetails then fsSearchField := 'BinLocNum'
  else if PQAType = tDetailswithSno then fsSearchField := 'Serialnumber';
end;

procedure TfmAllocationExt.DoExtraTranslation;
begin
  inherited;
  Guiprefs.DoTranslate;
end;


procedure TfmAllocationExt.DoSearch;
begin
  if   fsSearchData  = '' then exit;
  if   fsSearchField = '' then exit;
  Qrymain.Locate(fsSearchField , fsSearchData , [loCaseInsensitive, loPartialKey]);
  grdmain.UnselectAll;
  grdmain.SelectRecord;
end;

procedure TfmAllocationExt.grdmainKeyPress(Sender: TObject; var Key: Char);
function SearchCharpressed:Boolean;
  begin
      result := ((Key>=' ') and (Key<= '~'))
  end;
begin
  inherited;
  if SearchCharpressed then begin
    fsSearchData:=fsSearchData +Key;
    DoSearch;
  end;
end;

initialization
    RegisterClassOnce(TfmAllocationExt);

end.
