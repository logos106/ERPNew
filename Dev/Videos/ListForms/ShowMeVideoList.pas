unit ShowMeVideoList;
{TERPVideosGUI
      |-----TERPVideoConfigurationListGUI
          |-----TShowMeVideoListGUI}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPVideoConfigurationList, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, DBCtrls;

type
  TShowMeVideoListGUI = class(TERPVideoConfigurationListLISt)
    btnPhone: TDNMSpeedButton;
    qryMainTaskDetails: TWideMemoField;
    lblTaskDetails: TLabel;
    shpTaskDetails: TShape;
    procedure FormCreate(Sender: TObject);
    procedure btnPhoneClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainAfterScroll(DataSet: TDataSet);
  private
    fsPageName: String;
    procedure setPageName(const Value: String);
  Protected
    procedure InitFilter;Override;
  public
    Property Pagename :String read fsPageName write setPageName;
  end;


implementation

uses CommonLib, busobjERPVideo, frmShowMeERPOffices{, frmShowMe};

{$R *.dfm}
{ TShowMeVideoListGUI }

procedure TShowMeVideoListGUI.btnPhoneClick(Sender: TObject);
begin
  inherited;
  TfmShowMeERPOffices.ShowMe;
end;

procedure TShowMeVideoListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  CanOpenEditform := False;
end;

procedure TShowMeVideoListGUI.grdMainDblClick(Sender: TObject);
begin
  (*  Do not understand what for. Click on the video - results in Training video form shown with
      selected row for this video
  if Sametext(ActiveFieldname , qryMainPagecaption.FieldName) then begin
    if Assigned(Owner) then
      if owner is TfmShowMe then begin
        TfmShowMe(Owner).btnList.Click;
        Exit;
      end;
    //grdmain.SetActiveField(qrymainplayvideo.FieldName);
  end;
  *)
  inherited;

end;

procedure TShowMeVideoListGUI.InitFilter;
begin
  inherited;
  if fsPagename <> '' then begin
     if groupfilterstring <> '' then groupfilterstring := groupfilterstring + ' and ';
     groupfilterstring  := groupfilterstring +  ' Pagename =' +Quotedstr(fsPagename);
  end;
end;

procedure TShowMeVideoListGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  lblTaskDetails.Caption := qryMainTaskDetails.AsString;
  lblTaskDetails.Refresh;
  if qryMainTaskDetails.AsString = '' then begin
    lblTaskDetails.visible := False;
  end else begin
    lblTaskDetails.visible := TRue;
    While lblTaskDetails.height > grdmain.Height do lblTaskDetails.height  := lblTaskDetails.height -1;
    shpTaskDetails.Left := 0;
    shpTaskDetails.width :=grdmain.Width;
    shpTaskDetails.height :=lblTaskDetails.height;
    shpTaskDetails.top :=lblTaskDetails.top;
  end;
  shpTaskDetails.visible :=lblTaskDetails.visible;
end;

procedure TShowMeVideoListGUI.setPageName(const Value: String);
begin
  if Value <> '' then begin
    fsPageName := Value;
    grpfiltersclick(grpfilters);
  end;
end;

initialization
  RegisterClassOnce(TShowMeVideoListGUI);
end.
