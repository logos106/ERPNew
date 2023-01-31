unit EmbroideryPositionList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/11/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, MessageConst,
  CustomInputBox, wwdblook, Shader;

type
  TEmbroideryPositionListGUI = class(TBaseListingGUI)
    qryMainEmbroideryPositionID: TIntegerField;
    qryMainGlobalRef: TStringField;
    qryMainDescription: TStringField;
    qryMainImage: TBlobField;
    qryMainmsTimeStamp: TDateTimeField;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); reintroduce;
    procedure FormCreate(Sender: TObject);
  private
    procedure DisplayInputForm(const RecordID: Integer);
    procedure PerformRefresh(var Msg); message TX_PerformRefresh;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib;

{$R *.dfm}

procedure TEmbroideryPositionListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  LabelGridFromFieldNames := False;
end;

procedure TEmbroideryPositionListGUI.cmdNewClick(Sender: TObject);
begin
  DisplayInputForm(0);
end;

procedure TEmbroideryPositionListGUI.DisplayInputForm(const RecordID: Integer);
var
  tmpForm: TForm;
begin
  inherited;
  tmpForm := TForm(GetComponentByClassName('TEmbroideryPositionGUI'));

  if Assigned(tmpForm) then begin
    with TForm(tmpForm) do begin
      SendMessage(Handle, TX_PerformStartup, RecordID, Self.Handle);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TEmbroideryPositionListGUI.grdMainDblClick(Sender: TObject);
begin
  DisplayInputForm(qryMain.FieldByName('EmbroideryPositionID').AsInteger);
end;

procedure TEmbroideryPositionListGUI.PerformRefresh(var Msg);
begin
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TEmbroideryPositionListGUI);
finalization
  UnRegisterClass(TEmbroideryPositionListGUI);
end.
