unit frmBOMSchedulewhenReadytoScheduleOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, StdCtrls, DNMSpeedButton, Shader, ExtCtrls,
  SelectionDialog, Menus;

type
  TfmBOMSchedulewhenReadytoScheduleOptions = class(TBaseForm)
    pnlTop: TPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    chkOktoScheduleWhenProcessesnotScheduled: TCheckBox;
    chkOktoScheduleWhenGoodsReceived: TCheckBox;
    chkOktoScheduleWhenSubBOMsDone: TCheckBox;
    Label1: TLabel;
    chkOktoScheduleWhenStockAvailable: TCheckBox;
    pnlEnableSingleclickSelection: TPanel;
    lblEnableSingleclickSelection: TLabel;
    chkEnableSingleclickSelection: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    function getOktoScheduleWhenGoodsReceived: boolean;
    function getOktoScheduleWhenProcessesnotScheduled: boolean;
    function getOktoScheduleWhenStockAvailable: boolean;
    function getEnableSingleclickSelection: boolean;
    function getOktoScheduleWhenSubBOMsDone: boolean;
    procedure setOktoScheduleWhenGoodsReceived(const Value: boolean);
    procedure setOktoScheduleWhenProcessesnotScheduled(const Value: boolean);
    procedure setOktoScheduleWhenStockAvailable(const Value: boolean);
    procedure setEnableSingleclickSelection(const Value: boolean);
    procedure setOktoScheduleWhenSubBOMsDone(const Value: boolean);
  Protected
    Function DoReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;
                                 var fbOktoScheduleWhenGoodsReceived:boolean;
                                 var fbOktoScheduleWhenProcessesnotScheduled:boolean;
                                 var fbOktoScheduleWhenStockAvailable:boolean ;
                                 var fbEnableSingleclickSelection:boolean ; HavesingleclickOption:Boolean =True):Boolean;Virtual;
  public
    Property OktoScheduleWhenSubBOMsDone :boolean Read getOktoScheduleWhenSubBOMsDone write setOktoScheduleWhenSubBOMsDone ;
    Property OktoScheduleWhenGoodsReceived:boolean Read getOktoScheduleWhenGoodsReceived write setOktoScheduleWhenGoodsReceived ;
    Property OktoScheduleWhenProcessesnotScheduled:boolean Read getOktoScheduleWhenProcessesnotScheduled write setOktoScheduleWhenProcessesnotScheduled ;
    Property OktoScheduleWhenStockAvailable:boolean Read getOktoScheduleWhenStockAvailable write setOktoScheduleWhenStockAvailable ;
    Property EnableSingleclickSelection:boolean Read getEnableSingleclickSelection write setEnableSingleclickSelection ;

    class function ReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;
                                 var fbOktoScheduleWhenGoodsReceived:boolean;
                                 var fbOktoScheduleWhenProcessesnotScheduled:boolean;
                                 var fbOktoScheduleWhenStockAvailable:boolean ;
                                 var fbEnableSingleclickSelection:boolean ; HavesingleclickOption:Boolean =True):boolean;Overload;Virtual;

    class function ReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;
                                 var fbOktoScheduleWhenGoodsReceived:boolean;
                                 var fbOktoScheduleWhenProcessesnotScheduled:boolean;
                                 var fbOktoScheduleWhenStockAvailable:boolean ):boolean;Overload;Virtual;

  end;


implementation

uses tcConst;

{$R *.dfm}

{ TfmBOMJobDetailsOptions }

Function TfmBOMSchedulewhenReadytoScheduleOptions.getOktoScheduleWhenSubBOMsDone :boolean          ; begin result := chkOktoScheduleWhenSubBOMsDone.checked          ; end;
Function TfmBOMSchedulewhenReadytoScheduleOptions.getOktoScheduleWhenGoodsReceived:boolean         ; begin result := chkOktoScheduleWhenGoodsReceived.checked        ; end;
Function TfmBOMSchedulewhenReadytoScheduleOptions.getOktoScheduleWhenProcessesnotScheduled:boolean ; begin result := chkOktoScheduleWhenProcessesnotScheduled.checked; end;
Function TfmBOMSchedulewhenReadytoScheduleOptions.getOktoScheduleWhenStockAvailable:boolean        ; begin result := chkOktoScheduleWhenStockAvailable.checked       ; end;
Function TfmBOMSchedulewhenReadytoScheduleOptions.getEnableSingleclickSelection:boolean            ; begin result := chkEnableSingleclickSelection.checked           ; end;

Procedure TfmBOMSchedulewhenReadytoScheduleOptions.SetOktoScheduleWhenSubBOMsDone          (const Value:Boolean); begin chkOktoScheduleWhenSubBOMsDone.checked := Value          ; End;
Procedure TfmBOMSchedulewhenReadytoScheduleOptions.SetOktoScheduleWhenGoodsReceived        (const Value:Boolean); begin chkOktoScheduleWhenGoodsReceived.checked := Value        ; End;
Procedure TfmBOMSchedulewhenReadytoScheduleOptions.SetOktoScheduleWhenProcessesnotScheduled(const Value:Boolean); begin chkOktoScheduleWhenProcessesnotScheduled.checked := Value; End;
Procedure TfmBOMSchedulewhenReadytoScheduleOptions.SetOktoScheduleWhenStockAvailable       (const Value:Boolean); begin chkOktoScheduleWhenStockAvailable.checked := Value       ; End;
Procedure TfmBOMSchedulewhenReadytoScheduleOptions.SetEnableSingleclickSelection           (const Value:Boolean); begin chkEnableSingleclickSelection.checked := Value           ; End;

procedure TfmBOMSchedulewhenReadytoScheduleOptions.FormCreate(Sender: TObject);
begin
  inherited;
  lblEnableSingleclickSelection.caption :=  '(Default Option to Choose a Process is to Double-click.'+NL+
                                            ' Also Right-click for More Options to choose Process(es))';
end;

class Function TfmBOMSchedulewhenReadytoScheduleOptions.ReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;var fbOktoScheduleWhenGoodsReceived:boolean;var fbOktoScheduleWhenProcessesnotScheduled:boolean;var fbOktoScheduleWhenStockAvailable:boolean ):boolean;
var
  fb:Boolean;
begin
  fb:= false;
  Result :=  TfmBOMSchedulewhenReadytoScheduleOptions.ReadOptions( fbOktoScheduleWhenSubBOMsDone,fbOktoScheduleWhenGoodsReceived,fbOktoScheduleWhenProcessesnotScheduled,fbOktoScheduleWhenStockAvailable,fb, false);
end;

class Function TfmBOMSchedulewhenReadytoScheduleOptions.ReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;var fbOktoScheduleWhenGoodsReceived:boolean;var fbOktoScheduleWhenProcessesnotScheduled:boolean;var fbOktoScheduleWhenStockAvailable:boolean ;var fbEnableSingleclickSelection:boolean;HavesingleclickOption:Boolean =True):boolean;
var
  form : TfmBOMSchedulewhenReadytoScheduleOptions;
begin
  form := TfmBOMSchedulewhenReadytoScheduleOptions.Create(nil);
  try
      result := form.DoReadOptions(fbOktoScheduleWhenSubBOMsDone,fbOktoScheduleWhenGoodsReceived,fbOktoScheduleWhenProcessesnotScheduled,fbOktoScheduleWhenStockAvailable,fbEnableSingleclickSelection,HavesingleclickOption);
  finally
    FreeandNil(Form);
  end;

end;


Function TfmBOMSchedulewhenReadytoScheduleOptions.DoReadOptions(var fbOktoScheduleWhenSubBOMsDone:boolean;var fbOktoScheduleWhenGoodsReceived:boolean;var fbOktoScheduleWhenProcessesnotScheduled:boolean;var fbOktoScheduleWhenStockAvailable:boolean ;var fbEnableSingleclickSelection:boolean ; HavesingleclickOption:Boolean =True):Boolean;
begin
    result :=False;
    if not HavesingleclickOption then begin
      pnlEnableSingleclickSelection.visible := False;
      height := height - (pnlEnableSingleclickSelection.height + pnlEnableSingleclickSelection.Margins.top + pnlEnableSingleclickSelection.Margins.bottom);
    end;

    OktoScheduleWhenSubBOMsDone := fbOktoScheduleWhenSubBOMsDone;
    OktoScheduleWhenGoodsReceived := fbOktoScheduleWhenGoodsReceived;
    OktoScheduleWhenProcessesnotScheduled := fbOktoScheduleWhenProcessesnotScheduled;
    OktoScheduleWhenStockAvailable := fbOktoScheduleWhenStockAvailable;
    EnableSingleclickSelection := fbEnableSingleclickSelection;
    showModal;
    if modalResult = mrOk then begin
      fbOktoScheduleWhenSubBOMsDone := OktoScheduleWhenSubBOMsDone;
      fbOktoScheduleWhenGoodsReceived := OktoScheduleWhenGoodsReceived;
      fbOktoScheduleWhenProcessesnotScheduled := OktoScheduleWhenProcessesnotScheduled;
      fbOktoScheduleWhenStockAvailable := OktoScheduleWhenStockAvailable;
      fbEnableSingleclickSelection := EnableSingleclickSelection;
      Result := True;
    end;
end;
end.
