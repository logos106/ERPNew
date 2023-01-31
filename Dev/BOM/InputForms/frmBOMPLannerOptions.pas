unit frmBOMPLannerOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMPanel, Shader, DNMSpeedButton;

type
  TfmBOMPLannerOptions = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
 		chkshowSaleId        : TCheckBox;
    chkCustomerName      : TCheckBox;
    chkSaleDate          : TCheckBox;
    chkShowProductName: TCheckBox;
    chkUOM               : TCheckBox;
    chkshipped           : TCheckBox;
    DNMPanel4: TDNMPanel;
    Label3: TLabel;
    chkCaption: TCheckBox;
    chkProcessStep: TCheckBox;
    chkTotalduration: TCheckBox;
    chkSchdDuration: TCheckBox;
    chkProcessStatus: TCheckBox;
    chkResourcename: TCheckBox;
    chkREsourceDetailName: TCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Label2: TLabel;
    chkShowSchdtime: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    chkShowProductDesc: TCheckBox;
    procedure chkshippedClick(Sender: TObject);
  private
    Function getshowSaleId	:boolean;
    Function getCustomerName	:boolean;
    Function getSaleDate	:boolean;
    Function getShowProductName	:boolean;
    Function getShowProductDesc	:boolean;
    Function getUOM	:boolean;
    Function getshipped	:boolean;
    Function getCaption	:boolean;
    Function getProcessStep	:boolean;
    Function getTotalduration	:boolean;
    Function getSchdDuration	:boolean;
    Function getResourcename	:boolean;
    Function getREsourceDetailName	:boolean;
    Function getShowSchdtime	:boolean;
    Function getProcessStatus	:boolean;


    Procedure SetshowSaleId	(Const Value:Boolean);
    Procedure SetCustomerName	(Const Value:Boolean);
    Procedure SetSaleDate	(Const Value:Boolean);
    Procedure SetShowProductName	(Const Value:Boolean);
    Procedure SetShowProductDesc	(Const Value:Boolean);
    Procedure SetUOM	(Const Value:Boolean);
    Procedure Setshipped	(Const Value:Boolean);
    Procedure SetCaption	(Const Value:Boolean);
    Procedure SetProcessStep	(Const Value:Boolean);
    Procedure SetTotalduration	(Const Value:Boolean);
    Procedure SetSchdDuration	(Const Value:Boolean);
    Procedure SetResourcename	(Const Value:Boolean);
    Procedure SetREsourceDetailName	(Const Value:Boolean);
    Procedure SetShowSchdtime	(Const Value:Boolean);
    Procedure SetProcessStatus	(Const Value:Boolean);


  public
    Property showSaleId        	:Boolean read getshowSaleId        	Write SetshowSaleId        	;
    Property CustomerName      	:Boolean read getCustomerName      	Write SetCustomerName      	;
    Property SaleDate          	:Boolean read getSaleDate          	Write SetSaleDate          	;
    Property ShowProductName    :Boolean read getShowProductName    Write SetShowProductName    ;
    Property ShowProductDesc    :Boolean read getShowProductDesc    Write SetShowProductDesc    ;
    Property UOM               	:Boolean read getUOM               	Write SetUOM               	;
    Property shipped           	:Boolean read getshipped           	Write Setshipped           	;

    Property Caption           	:Boolean read getCaption           	Write SetCaption           	;
    Property ProcessStep       	:Boolean read getProcessStep       	Write SetProcessStep       	;
    Property Totalduration     	:Boolean read getTotalduration     	Write SetTotalduration     	;
    Property SchdDuration      	:Boolean read getSchdDuration      	Write SetSchdDuration      	;
    Property Resourcename      	:Boolean read getResourcename      	Write SetResourcename      	;
    Property REsourceDetailName	:Boolean read getREsourceDetailName	Write SetREsourceDetailName	;
    Property ShowSchdtime      	:Boolean read getShowSchdtime      	Write SetShowSchdtime      	;
    Property ProcessStatus      :Boolean read getProcessStatus      Write SetProcessStatus      ;

  end;

implementation

{$R *.dfm}

Function TfmBOMPLannerOptions.GetshowSaleId	        :boolean;	begin result := 	chkshowSaleId.Checked         ; end;
Function TfmBOMPLannerOptions.GetCustomerName	      :boolean;	begin result := 	chkCustomerName.checked       ; end;
Function TfmBOMPLannerOptions.GetSaleDate	          :boolean;	begin result := 	chkSaleDate.Checked           ; end;
Function TfmBOMPLannerOptions.GetShowProductName    :boolean;	begin result := 	chkShowProductName.Checked    ; end;
Function TfmBOMPLannerOptions.GetShowProductDesc    :boolean;	begin result := 	chkShowProductDesc.Checked    ; end;
Function TfmBOMPLannerOptions.GetUOM	              :boolean;	begin result := 	chkUOM.Checked                ; end;
Function TfmBOMPLannerOptions.Getshipped	          :boolean;	begin result := 	chkshipped.Checked            ; end;
Function TfmBOMPLannerOptions.GetCaption	          :boolean;	begin result := 	chkCaption.Checked            ; end;
Function TfmBOMPLannerOptions.GetProcessStep	      :boolean;	begin result := 	chkProcessStep.Checked        ; end;
Function TfmBOMPLannerOptions.GetTotalduration	    :boolean;	begin result := 	chkTotalduration.Checked      ; end;
Function TfmBOMPLannerOptions.GetSchdDuration	      :boolean;	begin result := 	chkSchdDuration.Checked       ; end;
Function TfmBOMPLannerOptions.GetResourcename	      :boolean;	begin result := 	chkResourcename.Checked       ; end;
Function TfmBOMPLannerOptions.GetREsourceDetailName	:boolean;	begin result := 	chkREsourceDetailName.checked ;end;
Function TfmBOMPLannerOptions.GetShowSchdtime       :boolean;	begin result := 	chkShowSchdtime.Checked       ; end;
Function TfmBOMPLannerOptions.GetProcessStatus      :boolean;	begin result := 	chkProcessStatus.Checked      ; end;



Procedure TfmBOMPLannerOptions.SetshowSaleId	      (Const Value:Boolean);	begin 	    ChkshowSaleId.checked         := Value; end;
Procedure TfmBOMPLannerOptions.SetCustomerName	    (Const Value:Boolean);	begin 	    ChkCustomerName.checked       := Value; end;
Procedure TfmBOMPLannerOptions.SetSaleDate	        (Const Value:Boolean);	begin 	    ChkSaleDate.checked           := Value; end;
Procedure TfmBOMPLannerOptions.SetShowProductName   (Const Value:Boolean);	begin 	    ChkShowProductName.checked    := Value; end;
Procedure TfmBOMPLannerOptions.SetShowProductDesc   (Const Value:Boolean);	begin 	    ChkShowProductDesc.checked    := Value; end;
Procedure TfmBOMPLannerOptions.SetUOM	              (Const Value:Boolean);	begin 	    ChkUOM.checked                := Value; end;
Procedure TfmBOMPLannerOptions.Setshipped	          (Const Value:Boolean);	begin 	    Chkshipped.checked            := Value; end;
Procedure TfmBOMPLannerOptions.SetCaption	          (Const Value:Boolean);	begin 	    ChkCaption.checked            := Value; end;
Procedure TfmBOMPLannerOptions.SetProcessStep	      (Const Value:Boolean);	begin 	    ChkProcessStep.checked        := Value; end;
Procedure TfmBOMPLannerOptions.SetTotalduration	    (Const Value:Boolean);	begin 	    ChkTotalduration.checked      := Value; end;
Procedure TfmBOMPLannerOptions.SetSchdDuration	    (Const Value:Boolean);	begin 	    ChkSchdDuration.checked       := Value; end;
Procedure TfmBOMPLannerOptions.SetResourcename	    (Const Value:Boolean);	begin 	    ChkResourcename.checked       := Value; end;
Procedure TfmBOMPLannerOptions.SetREsourceDetailName(Const Value:Boolean);	begin 	    ChkREsourceDetailName.checked := Value; end;
Procedure TfmBOMPLannerOptions.SetShowSchdtime      (Const Value:Boolean);	begin 	    ChkShowSchdtime.checked       := Value; end;
Procedure TfmBOMPLannerOptions.SetProcessStatus	    (Const Value:Boolean);	begin 	    ChkProcessStatus.checked      := Value; end;

procedure TfmBOMPLannerOptions.chkshippedClick(Sender: TObject);
begin
  inherited;
  chkUOM.enabled := chkshipped.checked;
end;

end.
