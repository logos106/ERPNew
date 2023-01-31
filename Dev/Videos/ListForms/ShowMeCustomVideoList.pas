unit ShowMeCustomVideoList;
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
  TShowMeCustomVideoListGUI = class(TERPVideoConfigurationListLISt)
    qryMainTaskDetails: TWideMemoField;
    lblTaskDetails: TLabel;
    shpTaskDetails: TShape;
    procedure FormCreate(Sender: TObject);
    procedure btnPhoneClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fsPageName: String;
    procedure setPageName(const Value: String);
  Protected
    procedure InitFilter;Override;
  public
    Property Pagename :String read fsPageName write setPageName;
  end;


implementation

uses CommonLib, busobjERPVideo, frmShowMeERPOffices, baseListingForm;

{$R *.dfm}
{ TShowMeVideoListGUI }

procedure TShowMeCustomVideoListGUI.btnPhoneClick(Sender: TObject);
begin
  inherited;
  TfmShowMeERPOffices.ShowMe;
end;

procedure TShowMeCustomVideoListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  CanOpenEditform := False;
  SearchMode := smFullList;
end;

procedure TShowMeCustomVideoListGUI.FormResize(Sender: TObject);
var
  lWidth : integer;
begin
  inherited;
  pnlHeader.Left := (pnlHeader.Parent.Width - pnlHeader.Width) div 2;
  lWidth := btnDownloadAll.Width + cmdClose.Width + 16;
  btnDownloadAll.Left := (FooterPanel.Width - lWidth) div 2;
  cmdClose.Left := btnDownloadAll.Left + btnDownloadAll.Width + 16;
end;

procedure TShowMeCustomVideoListGUI.FormShow(Sender: TObject);
begin
  inherited;
//


end;

procedure TShowMeCustomVideoListGUI.grdMainDblClick(Sender: TObject);
begin
  (*
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

procedure TShowMeCustomVideoListGUI.InitFilter;
begin
  inherited;
  if fsPagename <> '' then
  begin
     if groupfilterstring <> '' then
       groupfilterstring := groupfilterstring + ' and ';
     groupfilterstring  := groupfilterstring +  ' Pagename =' +Quotedstr(fsPagename);
  end;
end;

procedure TShowMeCustomVideoListGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  lblTaskDetails.Caption := qryMainTaskDetails.AsString;
  lblTaskDetails.Refresh;
  if qryMainTaskDetails.AsString = '' then
  begin
    lblTaskDetails.visible := False;
  end
  else
  begin
    lblTaskDetails.visible := TRue;
    While lblTaskDetails.height > grdmain.Height do
      lblTaskDetails.height  := lblTaskDetails.height -1;
    shpTaskDetails.Left := 0;
    shpTaskDetails.width :=grdmain.Width;
    shpTaskDetails.height :=lblTaskDetails.height;
    shpTaskDetails.top :=lblTaskDetails.top;
  end;
  shpTaskDetails.visible :=lblTaskDetails.visible;
end;

procedure TShowMeCustomVideoListGUI.setPageName(const Value: String);
begin
  if Value <> '' then begin
    fsPageName := Value;
    grpfiltersclick(grpfilters);
  end;
end;

initialization
  RegisterClassOnce(TShowMeCustomVideoListGUI);

end.
