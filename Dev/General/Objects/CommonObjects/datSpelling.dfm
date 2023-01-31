object dmSpelling: TdmSpelling
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object AddictSpell: TAddictSpell
    ConfigStorage = csRegistry
    ConfigID = '%UserName%'
    ConfigFilename = '%AppDir%\Spell.cfg'
    ConfigRegistryKey = 'Software\Addictive Software\%AppName%'
    ConfigDictionaryDir.Strings = (
      '%AppDir%\Dictionary')
    ConfigAvailableOptions = [soLiveSpelling, soLiveCorrect, soUpcase, soNumbers, soHTML, soInternet, soQuoted, soAbbreviations, soPrimaryOnly, soRepeated, soDUalCaps]
    ConfigUseMSWordCustom = True
    ConfigDefaultMain.Strings = (
      'aussie.adm')
    ConfigDefaultCustom.Strings = (
      'Autocorrect.adu')
    ConfigDefaultActiveCustomPrevent.Strings = (
      'autocorrect.adu'
      'autocorrect-british.adu')
    ConfigDefaultActiveCustom = '%ConfigID%.adu'
    ConfigDefaultOptions = [soLiveSpelling, soLiveCorrect, soInternet, soAbbreviations, soRepeated, soDUalCaps]
    ConfigDefaultUseMSWordCustom = False
    SuggestionsAutoReplace = False
    SuggestionsLearning = True
    SuggestionsLearningDict = '%AppDir%\%UserName%_sp.adl'
    QuoteChars = '>'
    DialogInitialPos = ipLastUserPos
    DialogSelectionAvoid = saAvoid
    DialogShowImmediate = False
    DialogShowModal = False
    EndMessage = emExceptCancel
    EndCursorPosition = epOriginal
    EndMessageWordCount = False
    MaxUndo = -1
    MaxSuggestions = -1
    KeepDictionariesActive = False
    SynchronousCheck = True
    UseHourglassCursor = True
    CommandsVisible = [sdcIgnore, sdcIgnoreAll, sdcChange, sdcChangeAll, sdcAdd, sdcAutoCorrect, sdcUndo, sdcHelp, sdcCancel, sdcOptions, sdcCustomDictionary, sdcCustomDictionaries, sdcConfigOK, sdcAddedEdit, sdcAutoCorrectEdit, sdcExcludedEdit, sdcInternalEdit, sdcMainDictFolderBrowse, sdcResetDefaults, sdcConfigCancel, sdcConfigLearningLink, sdcConfigDownloadLink]
    CommandsEnabled = [sdcIgnore, sdcIgnoreAll, sdcChange, sdcChangeAll, sdcAdd, sdcAutoCorrect, sdcUndo, sdcHelp, sdcCancel, sdcOptions, sdcCustomDictionary, sdcCustomDictionaries, sdcConfigOK, sdcAddedEdit, sdcAutoCorrectEdit, sdcExcludedEdit, sdcInternalEdit, sdcMainDictFolderBrowse, sdcResetDefaults, sdcConfigCancel]
    PhoneticSuggestions = True
    PhoneticMaxDistance = 4
    PhoneticDivisor = 2
    PhoneticDepth = 1
    MappingAutoReplace = True
    UseExcludeWords = True
    UseAutoCorrectFirst = True
    RecheckReplacedWords = True
    ResumeFromLastPosition = True
    AllowedCases = cmInitialCapsOrUpcase
    UILanguage = ltEnglish
    UIType = suiDialog
    UILanguageFontControls.Charset = DEFAULT_CHARSET
    UILanguageFontControls.Color = clWindowText
    UILanguageFontControls.Height = -11
    UILanguageFontControls.Name = 'Tahoma'
    UILanguageFontControls.Style = []
    UILanguageFontText.Charset = DEFAULT_CHARSET
    UILanguageFontText.Color = clWindowText
    UILanguageFontText.Height = -11
    UILanguageFontText.Name = 'Tahoma'
    UILanguageFontText.Style = []
    UILanguageUseFonts = False
    ParentFont = False
    DialogTypeSpelling = sdOffice
    DialogTypeConfiguration = sdOffice
    DialogMisspelledWordColor = clRed
    DialogMisspelledWordStyle = [fsBold]
    URLDownloadDictionaries = 
      'http://www.addictivesoftware.com/dl-dictionaries.htm?app=%AppNam' +
      'e%'
    URLEditDictionaries = 
      'http://www.addictivesoftware.com/ed-dictionaries.htm?app=%AppNam' +
      'e%'
    DoubleBuffered = False
    TimingWindow = 800
    TimingBadTimeCount = 2
    TimingNoActivityRestart = 1600
    TimingCutoff = 300
    Left = 40
    Top = 24
  end
end
