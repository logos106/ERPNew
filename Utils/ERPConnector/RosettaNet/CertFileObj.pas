unit CertFileObj;

interface

type

  TCertFileRec = class(TObject)
  public
    CertType: string;
    CertFileName: string;
    PrivateKeyFileName: string;
  end;

implementation

end.
