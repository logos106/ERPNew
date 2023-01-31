unit RegionLocations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TRegionLocationsGUI = class(TBaseListingGUI)
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

Procedure OpenRegionLocationList(const Category :String; SingleSelect :Boolean;  onGridSelection : TOnGridDataSelect; EnableFilters:Boolean);

implementation

uses AppEnvironment, RegionLocationCities, RegionLocationcountries, RegionlocationPostcodes, regionlocationStates, CommonFormLib, AppContextObj, SystemLib;

{$R *.dfm}
Procedure OpenRegionLocationList(const Category :String; SingleSelect :Boolean;  onGridSelection : TOnGridDataSelect; EnableFilters:Boolean);
var
  s:String;
begin
       if sametext(Category , 'C') then  s:= 'TRegionLocationcountriesGUI'
  else if sametext(Category , 'S') then  s:= 'TregionlocationStatesGUI'
  else if sametext(Category , 'L') then  s:= 'TRegionLocationCitiesGUI'
  else if sametext(Category , 'P') then  s:= 'TRegionlocationPostcodesGUI'
  else exit;
  AppContext['RegionLocations'].VarByName['EnableFilters'] := BooleanTostr(EnableFilters);
  try
    if assigned(onGridSelection) =false then
      OpenERPListForm(s , nil)
    else if SingleSelect then OpenERPListFormSingleselectModal(s , onGridSelection)
         else OpenERPListFormultiselectModal(s,nil,  onGridSelection);
  finally
      Appcontext['RegionLocations'].DeleteVar('EnableFilters');
  end;
end;

procedure TRegionLocationsGUI.FormCreate(Sender: TObject);
var
  s:String;
begin
       if Self is TRegionLocationcountriesGUI   then s:= 'Country List'
  else if self is TregionlocationStatesGUI      then s:= Appenv.RegionalOptions.StateName   + ' List'
  else if self is TRegionLocationCitiesGUI      then s:= Appenv.RegionalOptions.SuburbName  + ' List'
  else if self is TRegionlocationPostcodesGUI   then s:='Postcode List'
  else exit;

  Self.Caption        := s;
  TitleLabel.Caption  := s;
  if Qrymain.findfield('state')     <> nil then Qrymain.findfield('state').displayLabel     :=  Appenv.RegionalOptions.StateName;
  if Qrymain.findfield('City_sub')  <> nil then Qrymain.findfield('City_sub').displayLabel  :=  Appenv.RegionalOptions.SuburbName;
  inherited;
end;

procedure TRegionLocationsGUI.FormShow(Sender: TObject);
begin
  inherited;
  if AppContext['RegionLocations'].VarExists('EnableFilters') then
    grpfilters.visible := sametext(AppContext['RegionLocations'].VarByname['EnableFilters'] , 'T' );
end;

procedure TRegionLocationsGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
       if (grpfilters.itemindex = 0) and (Self is TRegionLocationcountriesGUI ) then exit
  else if (grpfilters.itemindex = 1) and (Self is TregionlocationStatesGUI    ) then exit
  else if (grpfilters.itemindex = 2) and (Self is TRegionLocationCitiesGUI    ) then exit
  else if (grpfilters.itemindex = 3) and (Self is TRegionlocationPostcodesGUI ) then exit;

       if (grpfilters.itemindex = 0) then CreatenOpenERPListForm('TRegionLocationcountriesGUI')
  else if (grpfilters.itemindex = 1) then CreatenOpenERPListForm('TregionlocationStatesGUI')
  else if (grpfilters.itemindex = 2) then CreatenOpenERPListForm('TRegionLocationCitiesGUI')
  else if (grpfilters.itemindex = 3) then CreatenOpenERPListForm('TRegionlocationPostcodesGUI');

end;

procedure TRegionLocationsGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Qrymain.ParamByName('RegionId').AsInteger := AppEnv.RegionalOptions.ID;
end;


end.

