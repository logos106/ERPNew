unit CustomerJobFollowupList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TfrmCustomerJobFollowupList = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainFollowUpDate: TDateTimeField;
    qryMainDone: TWideStringField;
    qryMainHours: TFloatField;
    qryMainCustomer: TWideStringField;
    qryMainSupplier: TWideStringField;
    qryMainOtherContact: TWideStringField;
    qryMainTitle: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainMiddleName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostCode: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFax: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainNotes: TWideMemoField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject);Override; 

  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;

  end;

//var
//  frmCustomerJobFollowupList: TfrmCustomerJobFollowupList;

implementation

uses commonLib;

{$R *.dfm}

{ TfrmCustomerJobFollowupList }

procedure TfrmCustomerJobFollowupList.RefreshQuery;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.ParamCheck := true;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('C.Company, OFU.ClientID, OFU.FollowupDate AS "Follow Up Date", OFU.Notes, OFU.Done, OFU.Hours,');
  qryMain.SQL.Add('OFU.IsCustomer AS "Customer", OFU.IsSupplier AS "Supplier", OFU.IsOtherContact AS "Other Contact",');
  qryMain.SQL.Add('C.Title, C.FirstName, C.MiddleName, C.Lastname, C.IsJob,');
  qryMain.SQL.Add('C.Phone, C.Mobile, C.FaxNumber AS "Fax", C.Email, C.Street, C.Street2, C.Suburb, C.State, C.PostCode');

  qryMain.SQL.Add('FROM tblotherfollowup AS OFU');
  qryMain.SQL.Add('INNER JOIN tblclients AS C Using(ClientID)');

  case grpFilters.ItemIndex of
    0: 
      begin
        qryMain.SQL.Add('WHERE C.IsJob = "F" AND (OFU.FollowupDate BETWEEN :xDate1 AND :xDate2)');
      end;

    1: 
      begin
        qryMain.SQL.Add('WHERE C.IsJob = "T" AND (OFU.FollowupDate BETWEEN :xDate1 AND :xDate2)');
      end;

    2: 
      begin
        qryMain.SQL.Add('WHERE OFU.Done = "T" AND (OFU.FollowupDate BETWEEN :xDate1 AND :xDate2)');
      end;
  end;

  qryMain.SQL.Add('ORDER BY C.Company;');

  qryMain.Params.ParamByName('xDate1').AsDateTime := dtFrom.DateTime;
  qryMain.Params.ParamByName('xDate2').AsDateTime := dtTo.DateTime;
  RefreshOrignalSQL;
  // Refresh our query.
  inherited;
end;

procedure TfrmCustomerJobFollowupList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmCustomerJobFollowupList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmCustomerJobFollowupList.grdMainDblClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0: 
      begin
        SubsequentID := Chr(95) + 'Customer';
      end;

    1: 
      begin
        SubsequentID := Chr(95) + 'Job';
      end;

    2: 
      begin
        if qryMain.FieldByName('IsJob').AsString = 'T' then begin
          SubsequentID := Chr(95) + 'Job';
        end else begin
          SubsequentID := Chr(95) + 'Customer';
        end;
      end;
  end;

  inherited;
end;

initialization
  RegisterClassOnce(TfrmCustomerJobFollowupList);
end.
