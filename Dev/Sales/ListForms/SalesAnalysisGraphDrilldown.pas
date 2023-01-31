unit SalesAnalysisGraphDrilldown;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox;

type
  TSalesAnalysisGraphDrilldownGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fsIdsTofilter: String;
    ftIds:TStringlist;
    fscontactTablename: String;
  Protected
    function Idsfieldname :String;virtual;abstract;
    procedure SetGridColumns; override;
  public
    Property IdsTofilter:String read fsIdsTofilter write fsIdsTofilter;
    Procedure RefreshQuery;override;
    Property contactTablename :String read fscontactTablename write fscontactTablename;

  end;


implementation

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TSalesAnalysisGraphDrilldownGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ftIds:=TStringlist.Create;
  //ClientHeight := 500; // to make the form slightly smaller to fit inside the chart form as its shown as modal as well
  //ClientWidth := 900;
end;

procedure TSalesAnalysisGraphDrilldownGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(ftIds);
  inherited;
end;

procedure TSalesAnalysisGraphDrilldownGUI.FormShow(Sender: TObject);
begin
  RefreshOrignalSQL;
  inherited;
end;

procedure TSalesAnalysisGraphDrilldownGUI.RefreshQuery;
begin
(*  Qrymain.ParamByName('Datefrom').AsDateTime  := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime    := FilterDateTo;*)
  inherited;
end;

procedure TSalesAnalysisGraphDrilldownGUI.SetGridColumns;
begin
  inherited;
end;
end.

