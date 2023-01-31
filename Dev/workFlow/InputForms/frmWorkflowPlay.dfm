inherited fmWorkflowPlay: TfmWorkflowPlay
  Left = 444
  Top = 370
  HelpContext = 1201002
  BorderStyle = bsNone
  Caption = 'Worflow Play'
  ClientHeight = 80
  ClientWidth = 480
  Color = clSilver
  TransparentColor = True
  TransparentColorValue = clSilver
  FormStyle = fsStayOnTop
  Position = poDefaultPosOnly
  ExplicitLeft = 444
  ExplicitTop = 370
  ExplicitWidth = 496
  ExplicitHeight = 119
  DesignSize = (
    480
    80)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 80
    Width = 480
    HelpContext = 1201003
    ExplicitTop = 105
    ExplicitWidth = 554
  end
  object pnlMain: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 480
    Height = 80
    HelpContext = 1201004
    Align = alClient
    Anchors = [akLeft, akRight]
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      480
      80)
    object Bevel1: TBevel
      Left = 2
      Top = 1
      Width = 550
      Height = 77
      HelpContext = 1201005
      Anchors = [akLeft, akTop, akRight, akBottom]
      ExplicitHeight = 90
    end
    object DBText1: TDBText
      AlignWithMargins = True
      Left = 2
      Top = 53
      Width = 476
      Height = 22
      HelpContext = 1201006
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Alignment = taCenter
      AutoSize = True
      Color = clNavy
      DataField = 'EventName'
      DataSource = dsworkflowLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
      ExplicitWidth = 79
    end
    object lblDetails: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 472
      Height = 45
      HelpContext = 1201007
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'lblDetails lblDetails lblDetails lblDetails lblDetails lblDetail' +
        's lblDetails lblDetails '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object cmdCancel: TDNMSpeedButton
      Left = 179
      Top = 49
      Width = 123
      Height = 27
      HelpContext = 1201008
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Cancel'
      Color = 9211135
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Layout = blGlyphTop
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object btnPreviousStep: TDNMSpeedButton
      Left = 21
      Top = 49
      Width = 123
      Height = 27
      HelpContext = 1201009
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Previous'
      Color = 11075496
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = 11075496
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Layout = blGlyphTop
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnPreviousStepClick
    end
    object btnNextStep: TDNMSpeedButton
      Left = 337
      Top = 49
      Width = 123
      Height = 27
      HelpContext = 1201010
      ParentCustomHint = False
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Next'
      Color = 11075496
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = 11075496
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Layout = blGlyphTop
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Style = bsModern
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnNextStepClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 302
    Top = 15
  end
  inherited tmrdelay: TTimer
    Left = 421
    Top = 15
  end
  inherited popSpelling: TPopupMenu
    Left = 123
    Top = 15
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 212
    Top = 15
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 272
    Top = 15
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 331
    Top = 15
  end
  inherited DataState: TDataState
    Left = 182
    Top = 15
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 391
    Top = 15
  end
  inherited imgsort: TImageList
    Left = 242
    Top = 15
    Bitmap = {
      494C010102006401780110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 361
    Top = 15
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 451
    Top = 15
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 504
    Top = 15
  end
  inherited qryMemTrans: TERPQuery
    Left = 153
    Top = 15
  end
  object qryworkflow: TERPQuery
    SQL.Strings = (
      'select'
      '* '
      'from tblworkflow')
    Left = 63
    Top = 15
    object qryworkflowID: TIntegerField
      FieldName = 'ID'
    end
    object qryworkflowDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryworkflowCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 255
    end
    object qryworkflowActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryworkflowIsERpWorkflow: TWideStringField
      FieldName = 'IsERpWorkflow'
      FixedChar = True
      Size = 1
    end
    object qryworkflowCreatedBy: TIntegerField
      FieldName = 'CreatedBy'
    end
    object qryworkflowmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qryworkflowmsupdateSitecode: TWideStringField
      FieldName = 'msupdateSitecode'
      Size = 3
    end
  end
  object qryworkflowLines: TERPQuery
    SQL.Strings = (
      
        'SELECT * , if(eventtype ="H" or eventtype="B" , "T" , "F") as sh' +
        'owhint, if(eventtype ="P" or eventtype="B" , "T" , "F") as showP' +
        'oint FROM tblworkflowlines')
    AfterOpen = qryworkflowLinesAfterScroll
    AfterScroll = qryworkflowLinesAfterScroll
    Left = 93
    Top = 15
    object qryworkflowLinesSeqno: TIntegerField
      DisplayWidth = 1
      FieldName = 'Seqno'
      Origin = 'tblworkflowlines.Seqno'
    end
    object qryworkflowLinesformName: TWideStringField
      DisplayLabel = 'Form'
      DisplayWidth = 15
      FieldName = 'formName'
      Origin = 'tblworkflowlines.formName'
      Size = 255
    end
    object qryworkflowLinesControlname: TWideStringField
      DisplayLabel = 'Control'
      DisplayWidth = 15
      FieldName = 'Controlname'
      Origin = 'tblworkflowlines.Controlname'
      Size = 3000
    end
    object qryworkflowLinesfieldname: TWideStringField
      DisplayLabel = 'Field Name'
      DisplayWidth = 15
      FieldName = 'fieldname'
      Origin = 'tblworkflowlines.fieldname'
      Size = 3000
    end
    object qryworkflowLinesGridcomboname: TWideStringField
      DisplayLabel = 'Combo'
      DisplayWidth = 15
      FieldName = 'Gridcomboname'
      Origin = 'tblworkflowlines.Gridcomboname'
      Size = 3000
    end
    object qryworkflowLinesPropname: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 10
      FieldName = 'Propname'
      Origin = 'tblworkflowlines.Propname'
      Size = 3000
    end
    object qryworkflowLinesvalue: TWideStringField
      DisplayWidth = 15
      FieldName = 'value'
      Origin = 'tblworkflowlines.value'
      Size = 255
    end
    object qryworkflowLinesshowhint: TWideStringField
      DisplayLabel = 'Hint?'
      DisplayWidth = 1
      FieldName = 'showhint'
      Origin = 'showhint'
      Size = 1
    end
    object qryworkflowLinesshowPoint: TWideStringField
      DisplayLabel = 'Point?'
      DisplayWidth = 1
      FieldName = 'showPoint'
      Origin = 'showPoint'
      Size = 1
    end
    object qryworkflowLinesEventName: TWideStringField
      DisplayLabel = 'Event Name'
      DisplayWidth = 22
      FieldName = 'EventName'
      Origin = 'tblworkflowlines.EventName'
      Size = 3000
    end
    object qryworkflowLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblworkflowlines.ID'
      Visible = False
    end
    object qryworkflowLinesWorkflowID: TIntegerField
      DisplayWidth = 10
      FieldName = 'WorkflowID'
      Origin = 'tblworkflowlines.WorkflowID'
      Visible = False
    end
    object qryworkflowLinesControlParent: TWideStringField
      DisplayWidth = 20
      FieldName = 'ControlParent'
      Origin = 'tblworkflowlines.ControlParent'
      Visible = False
      Size = 3000
    end
    object qryworkflowLineseventtype: TWideStringField
      FieldName = 'eventtype'
      Origin = 'tblworkflowlines.eventtype'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryworkflowLinesFormClassName: TWideStringField
      FieldName = 'FormClassName'
      Origin = 'tblworkflowlines.FormClassName'
      Visible = False
      Size = 255
    end
    object qryworkflowLinesmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblworkflowlines.mstimestamp'
      Visible = False
    end
    object qryworkflowLinesmsupdateSitecode: TWideStringField
      FieldName = 'msupdateSitecode'
      Origin = 'tblworkflowlines.msupdateSitecode'
      Visible = False
      Size = 3
    end
    object qryworkflowLinesControlclassname: TWideStringField
      FieldName = 'Controlclassname'
      Size = 255
    end
    object qryworkflowLinesbuttonActionName: TWideStringField
      FieldName = 'buttonActionName'
      Size = 255
    end
    object qryworkflowLinesHelpcontextID: TWideStringField
      FieldName = 'HelpcontextID'
      Size = 255
    end
    object qryworkflowLinesBaselistingGridDataSelectAssigned: TWideStringField
      FieldName = 'BaselistingGridDataSelectAssigned'
      FixedChar = True
      Size = 1
    end
    object qryworkflowLinesMenuName: TWideStringField
      FieldName = 'MenuName'
      Size = 255
    end
    object qryworkflowLinesMenuClassname: TWideStringField
      FieldName = 'MenuClassname'
      Size = 255
    end
  end
  object dsworkflow: TDataSource
    DataSet = qryworkflow
    Left = 4
    Top = 15
  end
  object dsworkflowLines: TDataSource
    DataSet = qryworkflowLines
    Left = 33
    Top = 15
  end
end
