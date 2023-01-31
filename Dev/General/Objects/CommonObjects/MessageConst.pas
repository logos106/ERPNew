unit MessageConst;
// Windows message constants

interface

uses Messages;

const
//  WM_ThreadDoneMsg   = WM_User + 8;
//  WM_MacroFormErrorMsg = WM_User + 9;
//  WM_MacroComponentErrorMsg = WM_User + 10;
//  WM_MacroDisplayTextMsg = WM_User + 11;
//  WM_RunMultiSite    = WM_User + 12;
//  WM_HowToHintNext   = WM_User + 13;
//  WM_HowToHintCancelled = WM_User + 14;
//  WM_HowToHintPrev   = WM_User + 15;
//  WM_HowToRun        = WM_User + 16;
//  WM_MacroErrorMsg   = WM_User + 17;
//  WM_MacroRelocateDateMsg = WM_User + 18;

  WM_InvoiceHasClosed = WM_User + 19;
  WM_SetFocus         = WM_User + 20;
  WM_AfterPaint       = WM_User + 21;
  WM_BringToFrontSoon = WM_USER + 22;
  WM_PostMsgToSelf    = WM_USER + 23;

  WM_SetGridFocus     = WM_USER + 24;

  SX_RefreshTotalsMsg   = WM_USER + 114;
  (*SX_MemTransMsg        = WM_USER + 115;*)
  (*SX_MemTransMsgJournal = WM_USER + 116;*)
  SX_RefreshTotals      = WM_USER + 117;
  SX_DatechangeMsg      = WM_USER + 130;

  TX_PerformStartup    = WM_USER + 400;
  TX_PerformFinish     = WM_USER + 401;
  TX_CancelFinish      = WM_USER + 402;
  TX_PerformTextSearch = WM_USER + 403;
  TX_SetCheckBox       = WM_USER + 404;
  TX_PerformRefresh    = WM_USER + 405;
  TX_PerformCommit     = WM_USER + 406;

  SX_CustomChartDeleted = WM_USER + 500;
  SX_InvalidatePanelHolderFrm = WM_USER + 501;

implementation

end.
