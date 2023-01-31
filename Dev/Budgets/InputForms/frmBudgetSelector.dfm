inherited fmBudgetSelector: TfmBudgetSelector
  Left = 438
  Top = 327
  HelpContext = 146000
  Caption = 'Select Budget'
  ClientHeight = 90
  ClientWidth = 223
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 146001
  end
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 223
    Height = 90
    HelpContext = 146002
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      223
      90)
    object Label1: TLabel
      Left = 10
      Top = 5
      Width = 40
      Height = 15
      HelpContext = 146003
      Caption = 'Budget'
    end
    object btnSave: TDNMSpeedButton
      Left = 16
      Top = 51
      Width = 87
      Height = 27
      HelpContext = 146004
      Anchors = [akBottom]
      Caption = '&Ok'
      Default = True
      DisableTransparent = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object cboBudget: TwwDBLookupCombo
      Left = 8
      Top = 20
      Width = 211
      Height = 23
      HelpContext = 146005
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'25'#9'Name'#9'F')
      LookupTable = QryBudgets
      LookupField = 'BudgetID'
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object btnCancel: TDNMSpeedButton
      Left = 124
      Top = 51
      Width = 87
      Height = 27
      HelpContext = 146006
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 80
    Top = 104
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 16
    Top = 104
  end
  inherited MyConnection: TERPConnection
    Left = 112
    Top = 103
  end
  inherited DataState: TDataState
    Left = 16
    Top = 128
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 144
    Top = 104
  end
  object QryBudgets: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DISTINCT  tblbudgets.BudgetID , tblbudgets.Name'
      
        'FROM tblbudgets INNER JOIN tblbudgetperiodlines ON tblbudgets.Bu' +
        'dgetID = tblbudgetperiodlines.BudgetID'
      'WHERE tblbudgets.Active="T" '
      'AND tblbudgetperiodlines.Active="T" ')
    Left = 263
    Top = 60
    object QryBudgetsName: TWideStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 25
    end
    object QryBudgetsBudgetID: TIntegerField
      FieldName = 'BudgetID'
      Visible = False
    end
  end
end
