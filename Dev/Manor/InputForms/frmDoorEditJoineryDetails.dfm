inherited frmDoorEditJoineryDetailsGUI: TfrmDoorEditJoineryDetailsGUI
  Left = 1489
  Top = 419
  HelpContext = 301000
  Caption = 'Joinery Service Details'
  ClientHeight = 428
  ClientWidth = 658
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 625
    Height = 285
    HelpContext = 301001
  end
  object Label1: TLabel [1]
    Left = 224
    Top = 336
    Width = 102
    Height = 15
    HelpContext = 301007
    Caption = 'Total Joinery Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object imgDelete: TImage [2]
    Left = 88
    Top = 24
    Width = 25
    Height = 25
    HelpContext = 301008
    Picture.Data = {
      07544269746D6170C6030000424DC60300000000000036000000280000001000
      000013000000010018000000000090030000120B0000120B0000000000000000
      0000CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCB
      CBCBCBCBCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCC
      CCCCD7D7D7C0C0C0666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCC
      CCCCCCCBCBCB999999868686999999CBCBCBDDDDDDB2B2B23333996666667777
      77868686C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CB
      CBCBDDDDDDB2B2B2333399333366666666808080969696CBCBCBCCCCCCCCCCCC
      D7D7D7C0C0C0333399777777999999CBCBCBD7D7D7CBCBCB8080803333660000
      80333366868686C0C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CC
      CCCCCBCBCBE6E6E6C0C0C0333399000080333366808080999999C0C0C0666699
      333399333366777777C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC3333990000
      80333399666666868686B2B2B2333399000080333366969696CBCBCBD7D7D7CC
      CCCCCBCBCCCCCCCCB2B2B2808080333366000080333366777777777777333366
      000080333399C0C0C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C03333
      99000080000080000080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCC
      CCCCC9C9CBCCCCCCCCCCD1CCCCCC9696966666660000800000800000805F5F5F
      969696CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C09696
      96666666000080000080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCC
      CCCCC3C3CCB8B8B8868686808080666699333399333399000080333366666666
      808080969696C0C0C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2
      B2CCCCCCC0C0C0808080333366333366333366777777969696C0C0C0CCCCCCCC
      CCCCC0C0C0C0C0C0B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C0777777333366
      000080333366808080868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCC
      CCCCCCCCCCCCCCCCCCCC999999666699333399333366777777868686999999CB
      CBCBCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCC
      B2B2B2333399336699B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCC
      CCCCCCCCCCCCCCCCCCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCC
      CCCCCCD7D7D7D7D7D7CCCCCCCCCCCCCCCCCC}
    Transparent = True
    Visible = False
  end
  inherited pnlHeader: TPanel
    Left = 143
    Width = 393
    HelpContext = 301002
    TabOrder = 4
    inherited TitleShader: TShader
      Width = 391
      HelpContext = 301003
      inherited TitleLabel: TLabel
        Width = 391
        HelpContext = 301004
        Caption = 'Joinery Service Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 190
    Top = 386
    HelpContext = 301005
    TabOrder = 2
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 379
    Top = 386
    HelpContext = 301006
    TabOrder = 3
  end
  object asgJoineryDetails: TAdvStringGrid
    Left = 33
    Top = 104
    Width = 593
    Height = 209
    Cursor = crDefault
    HelpContext = 301009
    DefaultRowHeight = 25
    RowCount = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goColMoving, goEditing, goTabs]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    OnKeyDown = asgJoineryDetailsKeyDown
    OnGetEditorType = asgJoineryDetailsGetEditorType
    ActiveCellFont.Charset = ANSI_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -12
    ActiveCellFont.Name = 'Arial'
    ActiveCellFont.Style = []
    ColumnHeaders.Strings = (
      ''
      'Quantity'
      'Description'
      'Cost'
      'Unit of Charge')
    Filter = <>
    FixedColWidth = 19
    FixedRowHeight = 25
    FixedColAlways = True
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -12
    FixedFont.Name = 'Arial'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    Multilinecells = True
    Navigation.InsertPosition = pInsertAfter
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    RowIndicator.Data = {
      2E010000424D2E01000000000000760000002800000010000000170000000100
      040000000000B800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF
      FFFFFFFF00FFFFFFFFFFFFFF000FFFFFFFFFFFFF0000FFFFFFFFFFFF00000FFF
      FFFFFFFF000000FFFFFFFFFF0000000FFFFFFFFF00000000FFFFFFFF0000000F
      FFFFFFFF000000FFFFFFFFFF00000FFFFFFFFFFF0000FFFFFFFFFFFF000FFFFF
      FFFFFFFF00FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ScrollWidth = 16
    SearchFooter.FindNextCaption = 'Find next'
    SearchFooter.FindPrevCaption = 'Find previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    Version = '3.6.0.2'
    ColWidths = (
      19
      85
      295
      96
      94)
  end
  object edtTotalJoineryCost: TAdvEdit
    Left = 336
    Top = 328
    Width = 65
    Height = 21
    HelpContext = 301010
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 1
    Text = '0.00'
    Visible = True
    OnEnter = edtTotalJoineryCostEnter
    Version = '2.7.5.0'
  end
  object tmrFocus: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrFocusTimer
    Left = 88
    Top = 56
  end
  object qryJoinery: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW * '
      'FROM vwdoorjoineryList'
      'ORDER BY Description')
    Left = 552
    Top = 16
  end
end
