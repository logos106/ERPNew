unit frameSite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrSite = class(TFrame)
    pnlMain: TPanel;
    lblName: TLabel;
    chkActive: TCheckBox;
    lblStatus: TLabel;
  private
    { Private declarations }
  public
//    property SiteName: string read GetSiteName write SetSiteName;
//    property Active: boolean read GetActive write SetActive;
//    property StatusMessage: string read GetStatusMessage write SetStatusMessage;
  end;

implementation

{$R *.dfm}

end.
