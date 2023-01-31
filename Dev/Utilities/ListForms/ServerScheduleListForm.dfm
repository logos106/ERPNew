inherited ServerScheduleListGUI: TServerScheduleListGUI
  Left = 98
  Top = 128
  HelpContext = 492000
  Caption = 'Server Schedule List'
  OldCreateOrder = True
  ExplicitLeft = 98
  ExplicitTop = 128
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 492001
  end
  inherited FooterPanel: TPanel
    HelpContext = 492002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 492003
    end
    inherited lblTotal: TLabel
      HelpContext = 492004
    end
    inherited lblNote: TLabel
      HelpContext = 492005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 492006
    end
    inherited lblTime: TLabel
      HelpContext = 492007
    end
    object Label4: TLabel [5]
      Left = 13
      Top = 10
      Width = 280
      Height = 15
      HelpContext = 492020
      Caption = '(Display of repeat alarms is limited to next fortnight)'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 492008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 492009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 492010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 492011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 492012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 492013
      inherited LblChooseTemplate: TLabel
        HelpContext = 492014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 492015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 492016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 492017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 492018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 492019
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 492021
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 492022
    end
    inherited lblTo: TLabel
      HelpContext = 492023
    end
    inherited pnlHeader: TPanel
      HelpContext = 492024
      Caption = 'Server Schedule List'
      inherited TitleShader: TShader
        HelpContext = 492025
        inherited TitleLabel: TLabel
          HelpContext = 492026
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 492027
      inherited grpFilters: TRadioGroup
        HelpContext = 492028
      end
      inherited pnlButtons: TPanel
        HelpContext = 492029
        inherited lblcustomReport: TLabel
          HelpContext = 492030
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 492031
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 492032
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 492033
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 492034
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 492035
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 492036
      inherited Label1: TLabel
        HelpContext = 492037
      end
      inherited Label2: TLabel
        HelpContext = 492038
      end
      inherited cboFilter: TComboBox
        HelpContext = 492039
      end
      inherited edtSearch: TEdit
        HelpContext = 492040
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 492041
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 492042
    end
    inherited cboDateRange: TComboBox
      HelpContext = 492043
    end
  end
  inherited Panel1: TPanel
    HelpContext = 492044
    inherited grdMain: TwwDBGrid
      HelpContext = 492045
      Selected.Strings = (
        'ID'#9'5'#9'ID'#9'F'#9
        'Due'#9'20'#9'Due'#9#9
        'Mode'#9'50'#9'Mode'#9'F'#9
        'Description'#9'40'#9'Description'#9#9
        'Xml'#9'40'#9'Xml'#9#9
        'LogWhenDone'#9'14'#9'LogWhenDone'#9#9
        'LogWhenDropped'#9'14'#9'LogWhenDropped'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly, mDisableDialog]
      TitleColor = 15527129
      ExplicitTop = 1
      inherited btnGrid: TwwIButton
        Width = 25
        Glyph.Data = {
          C6030000424DC603000000000000360000002800000010000000130000000100
          18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
          666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
          99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
          CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
          333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
          99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
          C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
          C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
          77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
          8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
          B2B2B2808080333366000080333366777777777777333366000080333399C0C0
          C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
          0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
          CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
          0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
          868686808080666699333399333399000080333366666666808080969696C0C0
          C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
          8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
          B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
          80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
          CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
          99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
          D7CCCCCCCCCCCCCCCCCC}
        ExplicitWidth = 25
      end
    end
  end
  inherited qryMain: TERPQuery
    Connection = ConnectionServices
    SQL.Strings = (
      'SELECT'
      
        'ID, Due, Description, Xml, LogWhenDone, LogWhenDropped, repeatAl' +
        'armID ,Mode'
      'FROM'
      '  tblschedule'
      'WHERE'
      '   DatabaseName = :DatabaseName '
      'AND Due Between :txtfrom AND :txtto'
      'ORDER BY'
      '   Due')
    FetchRows = 1
    Left = 167
    Top = 145
    ParamData = <
      item
        DataType = ftString
        Name = 'DatabaseName'
      end
      item
        DataType = ftUnknown
        Name = 'txtfrom'
      end
      item
        DataType = ftUnknown
        Name = 'txtto'
      end>
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 5
      FieldName = 'ID'
      Origin = 'tblschedule.ID'
    end
    object qryMainDue: TDateTimeField
      DisplayWidth = 20
      FieldName = 'Due'
      Origin = 'tblschedule.Due'
    end
    object qryMainMode: TWideStringField
      DisplayWidth = 50
      FieldName = 'Mode'
      Origin = 'tblschedule.Mode'
      Size = 50
    end
    object qryMainDescription: TWideStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblschedule.Description'
      Size = 255
    end
    object qryMainXml: TWideMemoField
      DisplayWidth = 40
      FieldName = 'Xml'
      Origin = 'tblschedule.Xml'
      BlobType = ftWideMemo
    end
    object qryMainLogWhenDone: TWideStringField
      DisplayWidth = 14
      FieldName = 'LogWhenDone'
      Origin = 'tblschedule.LogWhenDone'
      FixedChar = True
      Size = 1
    end
    object qryMainLogWhenDropped: TWideStringField
      DisplayWidth = 14
      FieldName = 'LogWhenDropped'
      Origin = 'tblschedule.LogWhenDropped'
      FixedChar = True
      Size = 1
    end
    object qryMainrepeatAlarmID: TIntegerField
      DisplayWidth = 15
      FieldName = 'repeatAlarmID'
      Origin = 'tblschedule.repeatAlarmID'
      Visible = False
    end
  end
  object ConnectionServices: TERPConnection
    Database = 'services'
    Options.UseUnicode = True
    LoginPrompt = False
    Left = 104
    Top = 152
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 888
    Top = 24
  end
end
