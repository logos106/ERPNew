unit EmployeeExpresslist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TGeneralIntProc       = Procedure (const Value:Integer) of Object;
  TEmployeeExpresslistGUI = class(TBaseListingGUI)
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltContact: TWideStringField;
    qryMainAddress: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainEmployeeshortName: TWideStringField;
    qryMainEmployeeFullName: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fShowERPHint: TGeneralIntProc;
    fsEmployeeIdstoSelect: String;
    Procedure ERPHint(const Value:Integer);
  public
    Property ShowERPHint :TGeneralIntProc read fShowERPHint write fShowERPHint;
    Property EmployeeIdstoSelect :String read fsEmployeeIdstoSelect Write fsEmployeeIdstoSelect;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, IntegerListObj;

{$R *.dfm}

procedure TEmployeeExpresslistGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmEmployeeInfo' , 0);
end;

procedure TEmployeeExpresslistGUI.grdMainDblClick(Sender: TObject);
begin
      try
        if Assigned(fOnGridDataSelect) then begin
          fOnGridDataSelect(TwwDbGrid(Sender));
          if CloseOnRecSelect then CloseList;
          exit;
        end;
      except
        on e: Exception do begin
          CloseList;
        end;
      end;
  OpenERPFormModal('TfmEmployeeInfo' , qryMainEmployeeID.asInteger);
end;

procedure TEmployeeExpresslistGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsEmployeeIdstoSelect := '';
end;

procedure TEmployeeExpresslistGUI.FormShow(Sender: TObject);
begin
  inherited;
  cmdNew.Enabled := True;
  if Assigned(fOnGridDataSelect) then begin
    ERPHint(4);
    HighlightControl(cmdPrint);
  end
  else begin

  end;
end;

procedure TEmployeeExpresslistGUI.ERPHint(const Value: Integer);
begin
  if assigned(fShowERPHint) then begin
     ShowERPHint(Value);
     shapehint.visible := True;
//     cmdClose.Invalidate;
  end;
end;

procedure TEmployeeExpresslistGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  ERPHint(6);

end;


procedure TEmployeeExpresslistGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if Qrymain.recordcount =0 then
    if Sametext(Qrymain.filter , '(Email <> '''')') then
      TimerMsg(FilterLabel,'There are no employee(s) with email address');
end;

procedure TEmployeeExpresslistGUI.RefreshQuery;
var
  fEmployeeIdstoSelect :TIntegerlist;
  ctr:Integer;
begin
  inherited;
  if fsEmployeeIdstoSelect <> '' then begin
    fEmployeeIdstoSelect :=TIntegerlist.Create;
    try
      fEmployeeIdstoSelect.CommaText:=fsEmployeeIdstoSelect;
      for ctr:= 0 to fEmployeeIdstoSelect.Count-1 do
        if Qrymain.Locate('EmployeeID', fEmployeeIdstoSelect[ctr],[]) then
          Grdmain.SelectRecord;
    finally
      Freeandnil(fEmployeeIdstoSelect);
      fsEmployeeIdstoSelect:= '';
    end;
  end;

end;


initialization
  RegisterClassOnce(TEmployeeExpresslistGUI);

end.
