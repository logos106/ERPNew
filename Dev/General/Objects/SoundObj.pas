unit SoundObj;

interface

uses Classes;

const
  DONK_SOUND_FILENAME = 'donksound.wav';


type
  TSoundObj= class(TComponent)
  Private
    fDonkSoundFilename:String;

    function getDonkSoundFilename: String;
  Public
    Constructor Create(AOwner:TComponent); override;
    Property DonkSoundFilename :String read getDonkSoundFilename;
  end;
implementation

uses tcConst, sysUtils, forms, DNMLib, SystemLib;

{ TSoundObj }

constructor TSoundObj.Create(AOwner: TComponent);
begin
  inherited;
  fDonkSoundFilename := '';
end;

function TSoundObj.getDonkSoundFilename: String;
begin
  if fDonkSoundFilename = '' then
    fDonkSoundFilename := SystemLib.ExeDIR+DONK_SOUND_FILENAME;
  result :=fDonkSoundFilename;
end;

end.
