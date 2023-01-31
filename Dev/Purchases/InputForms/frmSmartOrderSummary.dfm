inherited fmSmartOrderSummary: TfmSmartOrderSummary
  Left = 861
  Top = 74
  Caption = 'Smart Order Summary'
  ClientHeight = 372
  ClientWidth = 503
  KeyPreview = True
  Position = poScreenCenter
  ExplicitLeft = 861
  ExplicitTop = 74
  ExplicitWidth = 511
  ExplicitHeight = 399
  DesignSize = (
    503
    372)
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1018002
  inherited lblSkingroupMsg: TLabel
    Top = 57
    Width = 503
    ExplicitTop = 68
    ExplicitWidth = 503
    HelpContext = 1018003
  end
  object pnlTitle: TDNMPanel [3]
    Left = 63
    Top = 6
    Width = 377
    Height = 45
    HelpContext = 1018004
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 373
      Height = 41
      HelpContext = 1018005
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 373
        Height = 41
        HelpContext = 1018006
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Smart Order Summary'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 235
      end
    end
  end
  object pnlFooter: TDNMPanel [4]
    Left = 0
    Top = 57
    Width = 503
    Height = 265
    HelpContext = 1018007
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    object grdLines: TwwDBGrid
      Left = 0
      Top = 0
      Width = 503
      Height = 265
      HelpContext = 1018008
      ControlType.Strings = (
        'CusJobID;CustomEdit;cboCustomerJob;T'
        'ClassID;CustomEdit;cboClass;T'
        'SupplierID;CustomEdit;cboClient;T'
        'className;CustomEdit;cboClass;T'
        'UnitofMeasure;CustomEdit;cboUnitOfMeasure;F'
        'IsAvailable;CustomEdit;edtAvailable;F'
        'PARTSNAME;CustomEdit;cboProductR;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'SupplierName;CustomEdit;cboClientR;F'
        'CusJobName;CustomEdit;cboCustomerJob;F'
        'ClassName;CustomEdit;cboClass;F'
        'Deleted;CheckBox;T;F'
        'EquipmentName;CustomEdit;cboEquipmentname;F'
        'converted;CheckBox;T;F')
      Selected.Strings = (
        'SupplierName'#9'40'#9'Supplier'
        'ex'#9'10'#9'Total cost (Ex)'
        'Inc'#9'10'#9'Total Cost (Inc)')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnHighlight
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      PaintOptions.AlternatingRowRegions = [arrFixedColumns]
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      ExplicitHeight = 228
    end
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 322
    Width = 503
    Height = 50
    HelpContext = 1018009
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    ExplicitTop = 321
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 203
      Top = 13
      Width = 93
      Height = 27
      HelpContext = 1018010
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
    end
  end
  object tblMaster: TERPQuery
    Connection = SmartOrderGUI.MyConnection
    SQL.Strings = (
      
        'Select if(ifnull(SupplierName,'#39#39')  ='#39#39' , "Not Specified" , Suppl' +
        'ierName) as SupplierName, CostEx * qty ex, CostInc*Qty as Inc '
      'from tblsmartorderlines SOL '
      'where smartOrderID =:SmartOrderID'
      'group by SOL.suppliername '
      'order by supplierName')
    AutoCalcFields = False
    Left = 95
    Top = 125
    ParamData = <
      item
        DataType = ftInteger
        Name = 'SmartOrderID'
        Value = 0
      end>
    object tblMasterSupplierName: TWideStringField
      DisplayLabel = 'Supplier'
      DisplayWidth = 40
      FieldName = 'SupplierName'
      Origin = 'SupplierName'
      Size = 255
    end
    object tblMasterex: TFloatField
      DisplayLabel = 'Total cost (Ex)'
      DisplayWidth = 10
      FieldName = 'ex'
      Origin = 'ex'
      currency = True
    end
    object tblMasterInc: TFloatField
      DisplayLabel = 'Total Cost (Inc)'
      DisplayWidth = 10
      FieldName = 'Inc'
      Origin = 'Inc'
      currency = True
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 96
    Top = 156
  end
end
