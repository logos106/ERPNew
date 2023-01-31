unit BusobjDoorLookups;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  09/01/08  1.00.01  bS  Initial Version.
  }


interface
uses BusObjNDSGenDb, classes;

type
  TBusobjDoorLookups = class(TBusObjNDSGenDb)
  private
    fActive :boolean;

    Procedure SetActive(const Value :Boolean);
  Public

    Constructor Create(AOwner :TComponent); override;
    procedure New; override;
  Published  
    Property Active :Boolean Read fActive write setActive;
  Protected
  end;

  TCompDet = class(TBusobjDoorLookups)
  private
    fCompRef                    : string    ;
    fSizeNo                     : Double    ;
    fHeight                     : Double    ;
    fWidth                      : Double    ;
    fThickness                  : Double    ;
    fTolerance                  : Double    ;
    fCost                       : Double    ;
    fUnit                       : string    ;
    procedure SetCompRef        (const Value: string    );
    procedure SetSizeNo         (const Value: Double    );
    procedure SetHeight         (const Value: Double    );
    procedure SetWidth          (const Value: Double    );
    procedure SetThickness      (const Value: Double    );
    procedure SetTolerance      (const Value: Double    );
    procedure SetCost           (const Value: Double    );
    procedure SetUnit           (const Value: string    );
  published
    property CompRef            : string      Read fCompRef     Write SetCompRef  ;
    property SizeNo             : Double      Read fSizeNo      Write SetSizeNo   ;
    property Height             : Double      Read fHeight      Write SetHeight   ;
    property Width              : Double      Read fWidth       Write SetWidth    ;
    property Thickness          : Double      Read fThickness   Write SetThickness;
    property Tolerance          : Double      Read fTolerance   Write SetTolerance;
    property Cost               : Double      Read fCost        Write SetCost     ;
    property CompDetUnit        : string      Read fUnit        Write SetUnit     ;
  end;


  TDoorComp = class(TBusobjDoorLookups)
  private
    fCompRef                    : string    ;
    fDoorType                   : string    ;
    fFinish                     : string    ;
    fQuantity                   : Double    ;
    fWidMats                    : Double    ;
    fHghtMats                   : Double    ;
    fPosition                   : string    ;
    procedure SetCompRef        (const Value: string    );
    procedure SetDoorType       (const Value: string    );
    procedure SetFinish         (const Value: string    );
    procedure SetQuantity       (const Value: Double    );
    procedure SetWidMats        (const Value: Double    );
    procedure SetHghtMats       (const Value: Double    );
    procedure SetPosition       (const Value: string    );
  published
    property CompRef            : string      Read fCompRef     Write SetCompRef  ;
    property DoorType           : string      Read fDoorType    Write SetDoorType ;
    property Finish             : string      Read fFinish      Write SetFinish   ;
    property Quantity           : Double      Read fQuantity    Write SetQuantity ;
    property WidMats            : Double      Read fWidMats     Write SetWidMats  ;
    property HghtMats           : Double      Read fHghtMats    Write SetHghtMats ;
    property Position           : string      Read fPosition    Write SetPosition ;
  end;


  TDoorDetail = class(TBusobjDoorLookups)
  private
    fDoorType                   : string    ;
    fFinish                     : string    ;
    fShortType                  : string    ;
    fInternalExternal           : string    ;
    fThickness                  : Double    ;
    fDescription                : string    ;
    fMaxHeight                  : Double    ;
    fMaxWidth                   : Double    ;
    fMinHeight                  : Double    ;
    fMinWidth                   : Double    ;
    fNoComp                     : Double    ;
    fLabCost                    : Double    ;
    fSundries                   : Double    ;
    fLamLabCost                 : Double    ;
    fAddGoCost                  : Double    ;
    fStandard                   : Integer   ;
    fMonoLux                    : Integer   ;
    fSystem90                   : Integer   ;
    fBcsCostSt                  : Double    ;
    fBcsCostM                   : Double    ;
    fBcsCostSy                  : Double    ;
    fFrameType                  : Integer   ;
    fComputerCode               : string    ;
    fRebated                    : Integer   ;
    fBcsCostRb                  : Double    ;
    fPlyDepth                   : Integer   ;
    fLippingStile               : Integer   ;
    fTwinFastScrews             : Integer   ;
    fReportNotes                : string    ;
    procedure SetDoorType       (const Value: string    );
    procedure SetFinish         (const Value: string    );
    procedure SetShortType      (const Value: string    );
    procedure SetIntEx          (const Value: string    );
    procedure SetThickness      (const Value: Double    );
    procedure SetDescription    (const Value: string    );
    procedure SetMaxHeight      (const Value: Double    );
    procedure SetMaxWidth       (const Value: Double    );
    procedure SetMinHeight      (const Value: Double    );
    procedure SetMinWidth       (const Value: Double    );
    procedure SetNoComp         (const Value: Double    );
    procedure SetLabCost        (const Value: Double    );
    procedure SetSundries       (const Value: Double    );
    procedure SetLamLabCost     (const Value: Double    );
    procedure SetAddGoCost      (const Value: Double    );
    procedure SetStandard       (const Value: Integer   );
    procedure SetMonoLux        (const Value: Integer   );
    procedure SetSystem90       (const Value: Integer   );
    procedure SetBcsCostSt      (const Value: Double    );
    procedure SetBcsCostM       (const Value: Double    );
    procedure SetBcsCostSy      (const Value: Double    );
    procedure SetFrameType      (const Value: Integer   );
    procedure SetComputerCode   (const Value: string    );
    procedure SetRebated        (const Value: Integer   );
    procedure SetBcsCostRb      (const Value: Double    );
    procedure SetPlyDepth       (const Value: Integer   );
    procedure SetLippingStile   (const Value: Integer   );
    procedure SetTwinFastScrews (const Value: Integer   );
    procedure SetReportNotes    (const Value: string    );
  published
    property DoorType           : string      Read fDoorType           Write SetDoorType        ;
    property Finish             : string      Read fFinish             Write SetFinish          ;
    property ShortType          : string      Read fShortType          Write SetShortType       ;
    property InternalExternal   : string      Read fInternalExternal   Write SetIntEx           ;
    property Thickness          : Double      Read fThickness          Write SetThickness       ;
    property Description        : string      Read fDescription        Write SetDescription     ;
    property MaxHeight          : Double      Read fMaxHeight          Write SetMaxHeight       ;
    property MaxWidth           : Double      Read fMaxWidth           Write SetMaxWidth        ;
    property MinHeight          : Double      Read fMinHeight          Write SetMinHeight       ;
    property MinWidth           : Double      Read fMinWidth           Write SetMinWidth        ;
    property NoComp             : Double      Read fNoComp             Write SetNoComp          ;
    property LabCost            : Double      Read fLabCost            Write SetLabCost         ;
    property Sundries           : Double      Read fSundries           Write SetSundries        ;
    property LamLabCost         : Double      Read fLamLabCost         Write SetLamLabCost      ;
    property AddGoCost          : Double      Read fAddGoCost          Write SetAddGoCost       ;
    property Standard           : Integer     Read fStandard           Write SetStandard        ;
    property MonoLux            : Integer     Read fMonoLux            Write SetMonoLux         ;
    property System90           : Integer     Read fSystem90           Write SetSystem90        ;
    property BcsCostSt          : Double      Read fBcsCostSt          Write SetBcsCostSt       ;
    property BcsCostM           : Double      Read fBcsCostM           Write SetBcsCostM        ;
    property BcsCostSy          : Double      Read fBcsCostSy          Write SetBcsCostSy       ;
    property FrameType          : Integer     Read fFrameType          Write SetFrameType       ;
    property ComputerCode       : string      Read fComputerCode       Write SetComputerCode    ;
    property Rebated            : Integer     Read fRebated            Write SetRebated         ;
    property BcsCostRb          : Double      Read fBcsCostRb          Write SetBcsCostRb       ;
    property PlyDepth           : Integer     Read fPlyDepth           Write SetPlyDepth        ;
    property LippingStile       : Integer     Read fLippingStile       Write SetLippingStile    ;
    property TwinFastScrews     : Integer     Read fTwinFastScrews     Write SetTwinFastScrews  ;
    property ReportNotes        : string      Read fReportNotes        Write SetReportNotes     ;
  end;


  TFinish = class(TBusobjDoorLookups)
  private
    ffinishName                 : string    ;
    fCost                       : Double    ;
    procedure SetFinishName     (const Value: string    );
    procedure SetCost           (const Value: Double    );
  published
    property FinishName         : string      Read ffinishName     Write SetFinishName            ;
    property Cost               : Double      Read fCost           Write SetCost            ;
  end;


  TFireRating = class(TBusobjDoorLookups)
  private
    fFireRating                 : string    ;
    fHardwoodFrame              : Integer   ;
    fQuoteText                  : string    ;
    procedure SetFireRating     (const Value: string    );
    procedure SetHardwoodFrame  (const Value: Integer   );
    procedure SetQuoteText      (const Value: string    );
  published
    property FireRating         : string      Read fFireRating         Write SetFireRating      ;
    property HardwoodFrame      : Integer     Read fHardwoodFrame      Write SetHardwoodFrame   ;
    property QuoteText          : string      Read fQuoteText          Write SetQuoteText       ;
  end;


  TGlazing = class(TBusobjDoorLookups)
  private
    fGlazingShape               : string    ;
    fGlazingType                : string    ;
    fGlazingMats                : string    ;
    fGlazingCost                : Double    ;
    fGlazingUnit                : string    ;
    fChannelMats                : Integer   ;
    fGlazingProformaText        : string    ;
    fManufacturer               : string    ;
    procedure SetGlazingShape   (const Value: string    );
    procedure SetGlazingType    (const Value: string    );
    procedure SetGlazingMats    (const Value: string    );
    procedure SetGlazingCost    (const Value: Double    );
    procedure SetGlazingUnit    (const Value: string    );
    procedure SetChannelMats    (const Value: Integer   );
    procedure SetGlazingProforma(const Value: string    );
    procedure SetManufacturer   (const Value: string    );
  published
    property GlazingShape       : string      Read fGlazingShape          Write SetGlazingShape       ;
    property GlazingType        : string      Read fGlazingType           Write SetGlazingType        ;
    property GlazingMats        : string      Read fGlazingMats           Write SetGlazingMats        ;
    property GlazingCost        : Double      Read fGlazingCost           Write SetGlazingCost        ;
    property GlazingUnit        : string      Read fGlazingUnit           Write SetGlazingUnit        ;
    property ChannelMats        : Integer     Read fChannelMats           Write SetChannelMats        ;
    property GlazingProformaText: string      Read fGlazingProformaText   Write SetGlazingProforma    ;
    property Manufacturer       : string      Read fManufacturer          Write SetManufacturer       ;
  end;


  THandingDetails = class(TBusobjDoorLookups)
  private
    fHandingAbbrev              : string    ;
    fDescription                : string    ;
    procedure SetHandingAbbrev  (const Value: string    );
    procedure SetDescription    (const Value: string    );
  published
    property HandingAbbrev      : string      Read fHandingAbbrev         Write SetHandingAbbrev      ;
    property Description        : string      Read fDescription           Write SetDescription        ;
  end;


  TIsDescriptions = class(TBusobjDoorLookups)
  private
    fCode                       : string    ;
    fDescription                : string    ;
    procedure SetCode           (const Value: string    );
    procedure SetDescription    (const Value: string    );
  published
    property Code               : string      Read fCode                  Write SetCode               ;
    property Description        : string      Read fDescription           Write SetDescription        ;
  end;


  TJoinery = class(TBusobjDoorLookups)
  private
    fDescription                : string    ;
    fUnitOfCharge               : string    ;
    fCost                       : Double    ;
    procedure SetDescription    (const Value: string    );
    procedure SetUnitOfCharge   (const Value: string    );
    procedure SetCost           (const Value: Double    );
  published
    property Description        : string      Read fDescription           Write SetDescription        ;
    property UnitOfCharge       : string      Read fUnitOfCharge          Write SetUnitOfCharge       ;
    property Cost               : Double      Read fCost                  Write SetCost               ;
  end;


  TLippings = class(TBusobjDoorLookups)
  private
    fLipType                    : string    ;
    fLipSize                    : string    ;
    fLipCost                    : Double    ;
    procedure SetLipType        (const Value: string    );
    procedure SetLipSize        (const Value: string    );
    procedure SetLipCost        (const Value: Double    );
  published
    property LipType            : string      Read fLipType               Write SetLipType            ;
    property LipSize            : string      Read fLipSize               Write SetLipSize            ;
    property LipCost            : Double      Read fLipCost               Write SetLipCost            ;
  end;


  TStiles = class(TBusobjDoorLookups)
  private
    fCode                       : string    ;
    fStiles                     : string    ;
    fCostPerMetre               : Double    ;
    procedure SetCode           (const Value: string    );
    procedure SetStiles         (const Value: string    );
    procedure SetCostPerMetre   (const Value: Double    );
  published
    property Code               : string      Read fCode                  Write SetCode               ;
    property Stiles             : string      Read fStiles                Write SetStiles             ;
    property CostPerMetre       : Double      Read fCostPerMetre          Write SetCostPerMetre       ;
  end;


  TStopType = class(TBusobjDoorLookups)
  private
    fStopType                   : string    ;
    procedure SetStopType       (const Value: string    );
  published
    property StopType           : string      Read fStopType              Write SetStopType           ;
  end;


  TSundry = class(TBusobjDoorLookups)
  private
    fCode                       : string    ;
    fDescription                : string    ;
    fCost                       : Double    ;
    procedure SetCode           (const Value: string    );
    procedure SetDescription    (const Value: string    );
    procedure SetCost           (const Value: Double    );
  published
    property Code               : string      Read fCode                  Write SetCode               ;
    property Description        : string      Read fDescription           Write SetDescription        ;
    property Cost               : Double      Read fCost                  Write SetCost               ;
  end;


  TVeneer = class(TBusobjDoorLookups)
  private
    fVeneerName                 : string    ;
    fCostPerSq                  : Double    ;
    procedure SetVeneerName     (const Value: string    );
    procedure SetCostPerSq      (const Value: Double    );
  published
    property VeneerName         : string      Read fVeneerName            Write SetVeneerName         ;
    property CostPerSq          : Double      Read fCostPerSq             Write SetCostPerSq          ;
  end;


implementation

uses CommonLib, sysutils, BusObjNDSBase;
{TBusobjDoorLookups}
procedure TBusobjDoorLookups.New;
begin
    inherited;
    active := True;
end;
Constructor TBusobjDoorLookups.Create(AOwner :TComponent);
begin
    Inherited create(Aowner);
    ObjTableName                := 'tbldoorLookups';
    ObjTypeFieldName            := 'Objname';
    ObjPropNameFieldName        := 'PropName';
    ObjPropTypeFieldName        := 'Proptype';
    ObjPropValueFieldName       := 'PropValue';
    ObjInstGlobalrefFieldName   := 'ObjinstGlobalRef';
    ObjPropSizeFieldName        := 'PropSize';
end;
Procedure TBusobjDoorLookups.SetActive      (Const Value: boolean   ); begin if Value <> fActive              then begin fActive              := Value; Makedirty;end;end;
{ TCompDet }
procedure TCompDet.SetCompRef               (const Value: string    ); begin if Value <> fCompRef             then begin fCompRef             := Value; Makedirty;end;end;
procedure TCompDet.SetSizeNo                (const Value: Double    ); begin if Value <> fSizeNo              then begin fSizeNo              := Value; Makedirty;end;end;
procedure TCompDet.SetHeight                (const Value: Double    ); begin if Value <> fHeight              then begin fHeight              := Value; Makedirty;end;end;
procedure TCompDet.SetWidth                 (const Value: Double    ); begin if Value <> fWidth               then begin fWidth               := Value; Makedirty;end;end;
procedure TCompDet.SetThickness             (const Value: Double    ); begin if Value <> fThickness           then begin fThickness           := Value; Makedirty;end;end;
procedure TCompDet.SetTolerance             (const Value: Double    ); begin if Value <> fTolerance           then begin fTolerance           := Value; Makedirty;end;end;
procedure TCompDet.SetCost                  (const Value: Double    ); begin if Value <> fCost                then begin fCost                := Value; Makedirty;end;end;
procedure TCompDet.SetUnit                  (const Value: string    ); begin if Value <> fUnit                then begin fUnit                := Value; Makedirty;end;end;
{ TDoorComp }
procedure TDoorComp.SetCompRef              (const Value: string    ); begin if Value <> fCompRef             then begin fCompRef             := Value; Makedirty;end;end;
procedure TDoorComp.SetDoorType             (const Value: string    ); begin if Value <> fDoorType            then begin fDoorType            := Value; Makedirty;end;end;
procedure TDoorComp.SetFinish               (const Value: string    ); begin if Value <> fFinish              then begin fFinish              := Value; Makedirty;end;end;
procedure TDoorComp.SetQuantity             (const Value: Double    ); begin if Value <> fQuantity            then begin fQuantity            := Value; Makedirty;end;end;
procedure TDoorComp.SetWidMats              (const Value: Double    ); begin if Value <> fWidMats             then begin fWidMats             := Value; Makedirty;end;end;
procedure TDoorComp.SetHghtMats             (const Value: Double    ); begin if Value <> fHghtMats            then begin fHghtMats            := Value; Makedirty;end;end;
procedure TDoorComp.SetPosition             (const Value: string    ); begin if Value <> fPosition            then begin fPosition            := Value; Makedirty;end;end;
{ TDoorDetail }
procedure TDoorDetail.SetDoorType           (const Value: string    ); begin if Value <> fDoorType            then begin fDoorType            := Value; Makedirty;end;end;
procedure TDoorDetail.SetFinish             (const Value: string    ); begin if Value <> fFinish              then begin fFinish              := Value; Makedirty;end;end;
procedure TDoorDetail.SetShortType          (const Value: string    ); begin if Value <> fShortType           then begin fShortType           := Value; Makedirty;end;end;
procedure TDoorDetail.SetIntEx              (const Value: string    ); begin if Value <> fInternalExternal    then begin fInternalExternal    := Value; Makedirty;end;end;
procedure TDoorDetail.SetThickness          (const Value: Double    ); begin if Value <> fThickness           then begin fThickness           := Value; Makedirty;end;end;
procedure TDoorDetail.SetDescription        (const Value: string    ); begin if Value <> fDescription         then begin fDescription         := Value; Makedirty;end;end;
procedure TDoorDetail.SetMaxHeight          (const Value: Double    ); begin if Value <> fMaxHeight           then begin fMaxHeight           := Value; Makedirty;end;end;
procedure TDoorDetail.SetMaxWidth           (const Value: Double    ); begin if Value <> fMaxWidth            then begin fMaxWidth            := Value; Makedirty;end;end;
procedure TDoorDetail.SetMinHeight          (const Value: Double    ); begin if Value <> fMinHeight           then begin fMinHeight           := Value; Makedirty;end;end;
procedure TDoorDetail.SetMinWidth           (const Value: Double    ); begin if Value <> fMinWidth            then begin fMinWidth            := Value; Makedirty;end;end;
procedure TDoorDetail.SetNoComp             (const Value: Double    ); begin if Value <> fNoComp              then begin fNoComp              := Value; Makedirty;end;end;
procedure TDoorDetail.SetLabCost            (const Value: Double    ); begin if Value <> fLabCost             then begin fLabCost             := Value; Makedirty;end;end;
procedure TDoorDetail.SetSundries           (const Value: Double    ); begin if Value <> fSundries            then begin fSundries            := Value; Makedirty;end;end;
procedure TDoorDetail.SetLamLabCost         (const Value: Double    ); begin if Value <> fLamLabCost          then begin fLamLabCost          := Value; Makedirty;end;end;
procedure TDoorDetail.SetAddGoCost          (const Value: Double    ); begin if Value <> fAddGoCost           then begin fAddGoCost           := Value; Makedirty;end;end;
procedure TDoorDetail.SetStandard           (const Value: Integer   ); begin if Value <> fStandard            then begin fStandard            := Value; Makedirty;end;end;
procedure TDoorDetail.SetMonoLux            (const Value: Integer   ); begin if Value <> fMonoLux             then begin fMonoLux             := Value; Makedirty;end;end;
procedure TDoorDetail.SetSystem90           (const Value: Integer   ); begin if Value <> fSystem90            then begin fSystem90            := Value; Makedirty;end;end;
procedure TDoorDetail.SetBcsCostSt          (const Value: Double    ); begin if Value <> fBcsCostSt           then begin fBcsCostSt           := Value; Makedirty;end;end;
procedure TDoorDetail.SetBcsCostM           (const Value: Double    ); begin if Value <> fBcsCostM            then begin fBcsCostM            := Value; Makedirty;end;end;
procedure TDoorDetail.SetBcsCostSy          (const Value: Double    ); begin if Value <> fBcsCostSy           then begin fBcsCostSy           := Value; Makedirty;end;end;
procedure TDoorDetail.SetFrameType          (const Value: Integer   ); begin if Value <> fFrameType           then begin fFrameType           := Value; Makedirty;end;end;
procedure TDoorDetail.SetComputerCode       (const Value: string    ); begin if Value <> fComputerCode        then begin fComputerCode        := Value; Makedirty;end;end;
procedure TDoorDetail.SetRebated            (const Value: Integer   ); begin if Value <> fRebated             then begin fRebated             := Value; Makedirty;end;end;
procedure TDoorDetail.SetBcsCostRb          (const Value: Double    ); begin if Value <> fBcsCostRb           then begin fBcsCostRb           := Value; Makedirty;end;end;
procedure TDoorDetail.SetPlyDepth           (const Value: Integer   ); begin if Value <> fPlyDepth            then begin fPlyDepth            := Value; Makedirty;end;end;
procedure TDoorDetail.SetLippingStile       (const Value: Integer   ); begin if Value <> fLippingStile        then begin fLippingStile        := Value; Makedirty;end;end;
procedure TDoorDetail.SetTwinFastScrews     (const Value: Integer   ); begin if Value <> fTwinFastScrews      then begin fTwinFastScrews      := Value; Makedirty;end;end;
procedure TDoorDetail.SetReportNotes        (const Value: string    ); begin if Value <> fReportNotes         then begin fReportNotes         := Value; Makedirty;end;end;
{ TFinish }
procedure TFinish.SetFinishName             (const Value: string    ); begin if Value <> ffinishName          then begin ffinishName          := Value; Makedirty;end;end;
procedure TFinish.SetCost                   (const Value: Double    ); begin if Value <> fCost                then begin fCost                := Value; Makedirty;end;end;
{ TFireRating }
procedure TFireRating.SetFireRating         (const Value: string    ); begin if Value <> fFireRating          then begin fFireRating          := Value; Makedirty;end;end;
procedure TFireRating.SetHardwoodFrame      (const Value: Integer   ); begin if Value <> fHardwoodFrame       then begin fHardwoodFrame       := Value; Makedirty;end;end;
procedure TFireRating.SetQuoteText          (const Value: string    ); begin if Value <> fQuoteText           then begin fQuoteText           := Value; Makedirty;end;end;
{ TGlazing }
procedure TGlazing.SetGlazingShape          (const Value: string    ); begin if Value <> fGlazingShape        then begin fGlazingShape        := Value; Makedirty;end;end;
procedure TGlazing.SetGlazingType           (const Value: string    ); begin if Value <> fGlazingType         then begin fGlazingType         := Value; Makedirty;end;end;
procedure TGlazing.SetGlazingMats           (const Value: string    ); begin if Value <> fGlazingMats         then begin fGlazingMats         := Value; Makedirty;end;end;
procedure TGlazing.SetGlazingCost           (const Value: Double    ); begin if Value <> fGlazingCost         then begin fGlazingCost         := Value; Makedirty;end;end;
procedure TGlazing.SetGlazingUnit           (const Value: string    ); begin if Value <> fGlazingUnit         then begin fGlazingUnit         := Value; Makedirty;end;end;
procedure TGlazing.SetChannelMats           (const Value: Integer   ); begin if Value <> fChannelMats         then begin fChannelMats         := Value; Makedirty;end;end;
procedure TGlazing.SetGlazingProforma       (const Value: string    ); begin if Value <> fGlazingProformaText then begin fGlazingProformaText := Value; Makedirty;end;end;
procedure TGlazing.SetManufacturer          (const Value: string    ); begin if Value <> fManufacturer        then begin fManufacturer        := Value; Makedirty;end;end;
{ THandingDetails }
procedure THandingDetails.SetHandingAbbrev  (const Value: string    ); begin if Value <> fHandingAbbrev       then begin fHandingAbbrev       := Value; Makedirty;end;end;
procedure THandingDetails.SetDescription    (const Value: string    ); begin if Value <> fDescription         then begin fDescription         := Value; Makedirty;end;end;
{ TIsDescriptions }
procedure TIsDescriptions.SetCode           (const Value: string    ); begin if Value <> fCode                then begin fCode                := Value; Makedirty;end;end;
procedure TIsDescriptions.SetDescription    (const Value: string    ); begin if Value <> fDescription         then begin fDescription         := Value; Makedirty;end;end;
{ TJoinery }
procedure TJoinery.SetDescription           (const Value: string    ); begin if Value <> fDescription         then begin fDescription         := Value; Makedirty;end;end;
procedure TJoinery.SetUnitOfCharge          (const Value: string    ); begin if Value <> fUnitOfCharge        then begin fUnitOfCharge        := Value; Makedirty;end;end;
procedure TJoinery.SetCost                  (const Value: Double    ); begin if Value <> fCost                then begin fCost                := Value; Makedirty;end;end;
{ TLippings }
procedure TLippings.SetLipType              (const Value: string    ); begin if Value <> fLipType             then begin fLipType             := Value; Makedirty;end;end;
procedure TLippings.SetLipSize              (const Value: string    ); begin if Value <> fLipSize             then begin fLipSize             := Value; Makedirty;end;end;
procedure TLippings.SetLipCost              (const Value: Double    ); begin if Value <> fLipCost             then begin fLipCost             := Value; Makedirty;end;end;
{ TStiles }
procedure TStiles.SetCode                   (const Value: string    ); begin if Value <> fCode                then begin fCode                := Value; Makedirty;end;end;
procedure TStiles.SetStiles                 (const Value: string    ); begin if Value <> fStiles              then begin fStiles              := Value; Makedirty;end;end;
procedure TStiles.SetCostPerMetre           (const Value: Double    ); begin if Value <> fCostPerMetre        then begin fCostPerMetre        := Value; Makedirty;end;end;
{ TStopType }
procedure TStopType.SetStopType             (const Value: string    ); begin if Value <> fStopType            then begin fStopType            := Value; Makedirty;end;end;
{ TSundry }
procedure TSundry.SetCode                   (const Value: string    ); begin if Value <> fCode                then begin fCode                := Value; Makedirty;end;end;
procedure TSundry.SetDescription            (const Value: string    ); begin if Value <> fDescription         then begin fDescription         := Value; Makedirty;end;end;
procedure TSundry.SetCost                   (const Value: Double    ); begin if Value <> fCost                then begin fCost                := Value; Makedirty;end;end;
{ TVeneer }
procedure TVeneer.SetVeneerName             (const Value: string    ); begin if Value <> fVeneerName          then begin fVeneerName          := Value; Makedirty;end;end;
procedure TVeneer.SetCostPerSq              (const Value: Double    ); begin if Value <> fCostPerSq           then begin fCostPerSq           := Value; Makedirty;end;end;


initialization
  RegisterClassOnce(TCompDet);
  RegisterClassOnce(TDoorComp);
  RegisterClassOnce(TDoorDetail);
  RegisterClassOnce(TFinish);
  RegisterClassOnce(TFireRating);
  RegisterClassOnce(TGlazing);
  RegisterClassOnce(THandingDetails);
  RegisterClassOnce(TIsDescriptions);
  RegisterClassOnce(TJoinery);
  RegisterClassOnce(TLippings);
  RegisterClassOnce(TStiles);
  RegisterClassOnce(TStopType);
  RegisterClassOnce(TSundry);
  RegisterClassOnce(TVeneer);
end.
