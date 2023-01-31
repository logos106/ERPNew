unit StatementListDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingDM, DB, MemDS, DBAccess, MyAccess, ERPdbComponents;

type
  TStatementListDat = class(TBaseListingDat)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StatementListDat: TStatementListDat;

implementation

{$R *.dfm}

end.
