unit PackageControl;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 16/03/05  1.00.00 IJB  Initial verson.
  // 01/04/05  1.00.01 IJB  Added GetLoadedModules procedure and logic to skip
  //                        loading of dynamic packages if exe noy built with packages.

interface

uses
  Classes, ExtCtrls, ActnList, Controls, Menus, AdvMenus, Forms,
  AddinPackageInfoObj, AppEnvironment, DNMAction, Contnrs,BaseGUIDatamodule;

type
  TInitializeDllPackage = procedure(const ModuleInfo: TAddinPackageInfo;
                                    const MainAppEnv: TAppEnvironment;
                                    const MainApp: TApplication;
                                    const MainScreen: TScreen);

procedure GetLoadedModules;
function GetPreferenceFrm(Const packagename: string): TFormClass; {Retrieve Pref frm}
procedure AppendMenu(Const Src, Dest: TAdvMainMenu);
Function makeMenuItem(Parentmnu:TComponent;nameprefix:String='mnu'):TMenuItem;
procedure MergeMenus(Const Src, Dest: TAdvMainMenu; DestActionList: TActionList);
procedure RemoveImageFromMenu(const Sender: TComponent; const Menu: TAdvMainMenu);
procedure RemovePackageByName(Const PackageName:String);
procedure LoadAddinDLLPackages;
Function DataModuleByPackageName(PackageName:String) : TdtmGUI;
//procedure UnloadAddinPackages;

var
  AddinPackageList: TObjectList;
//  AddinInfo: TAddinPackageInfo;

implementation

uses
  SysUtils, dialogs,  Windows, FastFuncs, CommonLib,

{TEMP SOLUTION FOR PACKAGES WITHIN THE EXECUTABLE
 Add module name below}
  datBudgetAddin,
//  datAssessment,
  datManufacturingAddin,
  datPriceSchemeAddin,
  datMarketing,
  datERP,
  tcConst, datRepairs, datTraining, DNMLib,systemlib,  JsonObject, datWorkflow,
  ERPLib, datHire, datStS, datVs1;
{temp solution for EXE packages}


const
  AddinPackageSubDir = 'Addin';

var
  PakagesLoaded: boolean = false;
  DLLPakagesLoaded: boolean = false;
  LoadedModuleList: TStringList;

procedure RemovePackageByName(Const PackageName: String);
Var
  i: Integer;
  AddinInfo: TAddinPackageInfo;
Begin
  if Assigned(AddInPackageList) then begin
    for i := 0 to AddinPackageList.Count - 1 do begin
      AddinInfo := TAddinPackageInfo(AddinPackageList[i]);
      If Sysutils.SameText(PackageName, AddinInfo.PackageName) then Begin
        AddinPackageList.Delete(i);
        Exit;
      end;
    end;
  end;
end;
Function DataModuleByPackageName(PackageName:String) : TdtmGUI;
Var
  i: Integer;
  AddinInfo: TAddinPackageInfo;
Begin
  REsult :=  nil;
  if Assigned(AddInPackageList) then begin
    for i := 0 to AddinPackageList.Count - 1 do begin
      AddinInfo := TAddinPackageInfo(AddinPackageList[i]);
      If Sysutils.SameText(PackageName, AddinInfo.PackageName) then Begin
        REsult :=  AddinInfo.GuiDataModule;
        Exit;
      end;
    end;
  end;
end;

procedure UseEXEPackages;
  //TEMP MEASURE FOR EXE PACKAGES
(*var
  CustConfig: TJsonObject;*)
begin
  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Budgets';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdmBudgetAddin;
  AddinPackageList.Add(AddinInfo);

  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := REPORT_GROUP_SeedToSale;
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdmStS;
  AddinPackageList.Add(AddinInfo);

  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Manufacturing';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdtmManufacturingAddin;
  AddinPackageList.Add(AddinInfo);
  AddinInfo.GuiDataModule;

//  AddinInfo := TAddinPackageInfo.Create;
//  AddinInfo.PackageName := 'Assessment';
//  AddinInfo.PackageType := ptStatic;
//  AddinInfo.Version := 1;
//  AddinInfo.GuiDataModuleClass:= TdmAssessmentAddin;
//  AddinPackageList.Add(AddinInfo);

  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Price Schemes';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdtmPriceSchemeAddin;
  AddinPackageList.Add(AddinInfo);


  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Marketing';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdtmMarketingAddin;
  AddinPackageList.Add(AddinInfo);

  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Repairs';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdtRepairs;
  AddinPackageList.Add(AddinInfo);


  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Hire';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdtHire;
  AddinPackageList.Add(AddinInfo);


  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Workflow';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdtWorkflow;
  AddinPackageList.Add(AddinInfo);

  AddinInfo := TAddinPackageInfo.Create;
  AddinInfo.PackageName := 'Training';
  AddinInfo.PackageType := ptStatic;
  AddinInfo.Version := 1;
  AddinInfo.GuiDataModuleClass:= TdtTraining;
  AddinPackageList.Add(AddinInfo);

  if IsERPCustomEnabled then begin
        AddinInfo := TAddinPackageInfo.Create;
        AddinInfo.PackageName := 'ERP';
        AddinInfo.PackageType := ptStatic;
        AddinInfo.Version := 1;
        AddinInfo.GuiDataModuleClass:= TdmERP;
        AddinPackageList.Add(AddinInfo);
  end;
  if IsVS1_ProductionAdminDatabase  then begin
        AddinInfo := TAddinPackageInfo.Create;
        AddinInfo.PackageName := 'VS1 Cloud (Production)';
        AddinInfo.PackageType := ptStatic;
        AddinInfo.Version := 1;
        AddinInfo.GuiDataModuleClass:= TdmVs1;
        AddinPackageList.Add(AddinInfo);
  end;
  if IsVS1_SandBoxAdminDatabase then begin
        AddinInfo := TAddinPackageInfo.Create;
        AddinInfo.PackageName := 'VS1 Cloud (SandBox)';
        AddinInfo.PackageType := ptStatic;
        AddinInfo.Version := 1;
        AddinInfo.GuiDataModuleClass:= TdmVs1;
        AddinPackageList.Add(AddinInfo);
  end;
(*  if FileExists(ExtractFilePath(Application.ExeName)+ 'ERPCustomConfig.txt') then begin
    CustConfig := JO;
    try
      CustConfig.LoadFromFile(ExtractFilePath(Application.ExeName)+ 'ERPCustomConfig.txt');
      if CustConfig.O['Modules'].ObjectExists('ERP') and SameText(CustConfig.O['Modules'].O['ERP'].S['Database'], AppEnv.AppDb.Database) then begin

        AddinInfo := TAddinPackageInfo.Create;
        AddinInfo.PackageName := 'ERP';
        AddinInfo.PackageType := ptStatic;
        AddinInfo.Version := 1;
        AddinInfo.GuiDataModuleClass:= TdmERP;
        AddinPackageList.Add(AddinInfo);
      end;
    finally
      CustConfig.Free;
    end;
  end;*)
end;

procedure LoadAddinPackages;
var
  dir: string;
  sr: TSearchRec;
  s: string;
begin
  GetLoadedModules;
  // if only one item in list (i.e. the exe) we are not using packages
  // so don't try and load any dynamic packages.
  if LoadedModuleList.Count < 3 then begin
    {just EXE mode}
    UseEXEPackages;
    Exit;
  end;
  if not PakagesLoaded then begin
    dir := SystemLib.ExeDir + AddinPackageSubDir + '\';
    if DirectoryExists(dir) then begin
      if FindFirst(dir + '*.bpl', faAnyFile, sr) = 0 then begin
        repeat

          AddinInfo := TAddinPackageInfo.Create;
          AddinInfo.PackageName := sr.Name;
          AddinInfo.PackageType := ptDynamic;
          AddinInfo.Version := 1;

          try
            AddinInfo.Handle := LoadPackage(dir + sr.Name);
          except
            on E: Exception do begin
              // error loading package
              s := 'Error loading addin dll package "' + AddinInfo.PackageName + '": ' + E.Message;
              FreeAndNil(AddinInfo);
              //AddinInfo := nil;
              CommonLib.MessageDlgXP_Vista(s, mtWarning, [mbOK], 0);
            end;
          end;
          if Assigned(AddinInfo) then begin


            AddinInfo.PrefPage := AddinInfo.GetPrefPanel;
            if Assigned(AddinInfo.PrefPage) then begin
              AddinInfo.HasPreference := true;
            end else begin
              AddinInfo.HasPreference := false;
              AddinInfo.PrefPage := nil;
            end;
            //
            AddinPackageList.Add(AddinInfo);
          end;
        until FindNext(sr) <> 0;
        SysUtils.FindClose(sr);
      end;
    end;

    PakagesLoaded := true;
  end;
end;

procedure LoadAddinDLLPackages;
var
  dir: string;
  sr: TSearchRec;
  s: string;
  InitializeDllPackage: TInitializeDllPackage;
begin
  if not DLLPakagesLoaded then begin
    dir := SystemLib.ExeDir + AddinPackageSubDir + '\';
    if DirectoryExists(dir) then begin
      if FindFirst(dir + '*.dll', faAnyFile, sr) = 0 then begin
        repeat

          AddinInfo := TAddinPackageInfo.Create;
          AddinInfo.PackageName := sr.Name;
          AddinInfo.PackageType := ptDynamicDLL;
          AddinInfo.Version := 1;

          try
            AddinInfo.Handle := LoadLibrary(PChar(dir + sr.Name));
          except
            on E: Exception do begin
              // error loading package
              s := 'Error loading addin package "' + AddinInfo.PackageName + '": ' + E.Message;
              FreeAndNil(AddinInfo);
              AddinInfo := nil;
              CommonLib.MessageDlgXP_Vista(s, mtWarning, [mbOK], 0);
            end;
          end;
          if Assigned(AddinInfo) then begin
            AddinInfo.PrefPage := nil;

            @InitializeDllPackage:= GetProcAddress(AddinInfo.Handle, 'InitializeDllPackage');
            InitializeDllPackage(AddinInfo, AppEnv, Application, Screen);

            AddinPackageList.Add(AddinInfo);
          end;
        until FindNext(sr) <> 0;
        SysUtils.FindClose(sr);
      end;
    end;

    DLLPakagesLoaded := true;
  end;
end;

function GetModuleName(HInstance: integer): string;
var
  szFileName: array[0..MAX_PATH] of char;
begin
  GetModuleFileName(HInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;


function EnumModuleFunc(HInstance: integer; Data: Pointer): boolean;
begin
  Result := true;
  LoadedModuleList.AddObject(GetModuleName(HInstance), TObject(HInstance));
end;

procedure GetLoadedModules;
begin
  LoadedModuleList.Clear;
  EnumModules(EnumModuleFunc, nil);
end;

function GetPreferenceFrm(Const packagename: string): TFormClass;
var
  i: integer;
var
  SelAddInfo: TAddinPackageInfo;
begin
  Result := nil;
  for i := 0 to AddInPackageList.Count - 1 do begin
    SelAddInfo := TAddinPackageInfo(AddInPackageList[i]);
    if SelAddInfo.packagename = packagename then begin
      Result := SelAddInfo.PrefPage;
    end;
  end;
end;

procedure RemoveImageFromMenu(const Sender: TComponent; const Menu: TAdvMainMenu);
var
  I: integer;
begin
  Menu.BeginUpdate;
  try
    for I := 0 to Sender.ComponentCount - 1 do begin
      if Sender.Components[I] is TMenuItem then TMenuItem(Sender.Components[I]).ImageIndex := -1;
    end;
  finally
    Menu.EndUpdate;
  end;
end;
Function makeMenuItem(Parentmnu:TComponent;nameprefix:String='mnu'):TMenuItem;
var
  ctr:Integer;
  sName:String;
begin
  REsult:= TMenuItem.Create(Parentmnu.Owner);
  Result.autohotkeys := maManual(*maAutomatic*);
  ctr:= 1;
  sname :=nameprefix +inttostr(ctr);
  While Parentmnu.Owner.FindComponent(sname) <> nil do begin
    ctr:= ctr+1;
    sname :=nameprefix +inttostr(ctr);
  end;
  try
    Result.Name := sname;
  Except
    // kill the exception if name already exists
  end;
end;
procedure AppendMenu(Const Src, Dest: TAdvMainMenu);
var
  i, j, desti, addindex: integer;
var
  Mi, tmi: TMenuItem;
var
  inserted,parentmenu: boolean;
begin
  tmi := nil;
  Dest.BeginUpdate;
  try
    // assimilate the menu items
    for i := 0 to Src.Items.Count - 1 do begin
      inserted := false;
      AddIndex := 0;
      parentmenu:=false;
      for j := 0 to Src.Items[i].Count - 1 do begin

        mi := makeMenuItem(Dest);
        with Src.Items[i].Items[j] do begin
          mi.Caption := Caption;
          mi.Bitmap.Assign(Bitmap);
          mi.Checked := Checked;
          mi.GroupIndex := GroupIndex;
          mi.RadioItem := RadioItem;
          mi.Action := Action;
          mi.ImageIndex := -1;
          if not Assigned(mi.Action) then mi.ImageIndex := -1;
          if assigned(mi.action)and mi.visible then parentmenu:=true;
          mi.OnClick := OnClick;
          mi.OnDrawItem := OnDrawItem;
          mi.OnMeasureItem := OnMeasureItem;
          mi.SubMenuImages := SubmenuImages;
          mi.Tag := Tag;

          for desti := 0 to Dest.Items.Count - 2 do begin
            if Src.Items[i].GroupIndex = Dest.Items[desti].GroupIndex then begin
              if not inserted then begin
                tmi:=Dest.Items[desti].Find(Src.Items[i].Caption);      {found an existing menu item}
                if tmi <> nil then begin
                    tmi.Clear;
                    tmi.Destroy;
                end;
                tmi := makeMenuItem(Dest);                          {create it first time or again}
                tmi.Caption := Src.Items[i].Caption;
                tmi.Tag := Src.Items[i].Tag;
                Dest.Items[desti].Insert(tmi.Tag,tmi);
                inserted := true;
              end;
              if assigned(tmi) then tmi.Add(mi);                           {add menu}
              if parentmenu then tmi.visible:=true else tmi.visible:=false;
              System.Break;
            end else if (Src.Items[i].GroupIndex > Dest.Items[desti].GroupIndex) and
              (Src.Items[i].GroupIndex < Dest.Items[desti + 1].GroupIndex) then begin
              if not inserted then begin                                {new menu}
                tmi:=Dest.Items[desti].Find(Src.Items[i].Caption);      {found an existing menu item}
                if tmi <> nil then begin
                    tmi.Clear;
                    tmi.Destroy;
                end;
                tmi := makeMenuItem(Dest);
                tmi.Caption := Src.Items[i].Caption;

                tmi.GroupIndex := Src.Items[i].GroupIndex;
                Dest.Items.Insert(desti + 1, tmi);
                addindex := Src.Items[i].GroupIndex;
                inserted := true;
              end;
              mi.GroupIndex := addindex;
              Dest.Items[desti + 1].Add(mi);
              if parentmenu then tmi.visible:=true else tmi.visible:=false;
              System.Break;
            end; {if}
          end;   {for}

          if not inserted then begin                                    {add to the end}
            tmi:=Dest.Items[desti].Find(Src.Items[i].Caption);          {found an existing menu item}
            if tmi <> nil then begin
                tmi.Clear;
                tmi.Destroy;
            end;

            tmi := makeMenuItem(Dest);
            tmi.Caption := Src.Items[i].Caption;

            tmi.GroupIndex := Src.Items[i].GroupIndex;
            Dest.Items.Add(tmi);
            addindex := Dest.Items.Count - 1;
            inserted := true;
            mi.GroupIndex := Src.Items[i].GroupIndex;
            if parentmenu then tmi.visible:=true else tmi.visible:=false;
            Dest.Items[addindex].Add(mi);
          end;
        end;     {with}
      end;       {for}
    end;         {for}
  finally
    Dest.EndUpdate;
  end;
end;

procedure MergeMenus(Const Src, Dest: TAdvMainMenu; DestActionList: TActionList);
var
  MainIdx, SubIdx: integer;
  mnu, SrcSubMnu, mnuNew: TMenuItem;
  actNew, actSrc: TDNMAction;

  function FindMenuItem(Const aCaption: string): TMenuItem;
  var
    srchStr, mnuStr: string;
    x: integer;
  begin
    result:= nil;
    srchStr:= StringReplace(aCaption,'&','',[rfReplaceAll,rfIgnoreCase]);
    for x:= 0 to Dest.Items.Count -1 do begin
      mnuStr:= StringReplace(Dest.Items[x].Caption,'&','',[rfReplaceAll,rfIgnoreCase]);
      if mnuStr = srchStr then begin
        result:= Dest.Items[x];
        break;
      end;
    end;
  end;
begin
  Dest.BeginUpdate;
  try
    for MainIdx:= 0 to Src.Items.Count -1 do begin
      mnu:= FindMenuItem(Src.Items[MainIdx].Caption);
      if not Assigned(mnu) then begin
        mnu:= makeMenuItem(Dest);
        mnu.Caption:= Src.Items[MainIdx].Caption;
        Dest.Items.Add(mnu);
      end;
      for SubIdx:= 0 to Src.Items[MainIdx].Count-1 do begin
        SrcSubMnu:= Src.Items[MainIdx].Items[SubIdx];
        if Assigned(SrcSubMnu.Action) then begin
          mnuNew:= makeMenuItem(Dest);
          actNew:= TDNMAction.Create(DestActionList);
          actSrc:= TDNMAction(SrcSubMnu.Action);
          actNew.ClassExecute:= actSrc.ClassExecute;
          actNew.Description:= actSrc.Description;
          actNew.Caption:= actSrc.Caption;
          actNew.Checked:= actSrc.Checked;
          actNew.Enabled:= actSrc.Enabled;
          actNew.GroupIndex:= actSrc.GroupIndex;
          actNew.OnExecute:= actSrc.OnExecute;
          actNew.Name:= actSrc.Name;
          actNew.ActionList:= DestActionList;
          mnuNew.Action:= actNew;
          mnu.Add(mnuNew);
        end;
      end;
    end;
  finally
    Dest.EndUpdate;
  end;
end;


// -----------------------------------------------------------------------------
initialization
  LoadedModuleList := TStringList.Create;
  AddinPackageList := TObjectList.Create(true);
  LoadAddinPackages;
finalization
  FreeAndNil(AddinPackageList);
  FreeAndNil(LoadedModuleList);
end.
