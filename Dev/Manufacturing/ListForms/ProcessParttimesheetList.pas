unit ProcessParttimesheetList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, Mask, wwdbedit;

type
  TProcessParttimesheetListGUI = class(TBaseListingGUI)
    qryMainppid: TIntegerField;
    qryMaincaption: TWideStringField;
    qryMaindescription: TWideStringField;
    qryMainemployeename: TWideStringField;
    qryMaintimestart: TDateTimeField;
    qryMaintimeend: TDateTimeField;
    qryMaincomment: TWideStringField;
    qryMainactive: TWideStringField;
    pnlprocesstep: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    qryMainpptid: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiPPId: Integer;
    fiPPTID: Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
    Property PPId :Integer read fiPPId write fiPPId;
    Property PPTID :Integer read fiPPTID write fiPPTID;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TProcessParttimesheetListGUI }

procedure TProcessParttimesheetListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  PPId := 0;
  PPTID := 0;
end;

procedure TProcessParttimesheetListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (PPTID<>0) and (PPTID =  qrymainpptID.AsInteger) then
        DoGreenhighlight(Afont,ABrush);
end;

procedure TProcessParttimesheetListGUI.RefreshQuery;
begin
  Qrymain.parambyname('ppid').asInteger := ppid;
  inherited;
end;

procedure TProcessParttimesheetListGUI.SetGridColumns;
begin
  inherited;
  if ppid <> 0 then begin
    RemoveFieldfromGrid(qryMaincaption.fieldname);
    RemoveFieldfromGrid(qryMaindescription.fieldname);
    RemoveFieldfromGrid(qryMainppid.fieldname);
    RemoveFieldfromGrid(qryMainPPTID.fieldname);
  end;
  pnlprocesstep.visible :=ppid <> 0 ;
end;

initialization

  RegisterClassOnce(TProcessParttimesheetListGUI);

end.
