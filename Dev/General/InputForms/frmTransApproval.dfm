inherited fmTransApproval: TfmTransApproval
  Left = 540
  Top = 348
  Caption = 'Approvals'
  ClientHeight = 361
  ClientWidth = 673
  ExplicitLeft = 540
  ExplicitTop = 348
  ExplicitWidth = 689
  ExplicitHeight = 400
  DesignSize = (
    673
    361)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 361
    Width = 673
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 80
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 176
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object Shbox: TShape [5]
    Left = 0
    Top = 0
    Width = 673
    Height = 361
    Anchors = [akLeft, akTop, akRight, akBottom]
    Brush.Style = bsClear
    Pen.Width = 2
    ExplicitWidth = 770
  end
  object pnlMain: TDNMPanel [6]
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 669
    Height = 357
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlDetails: TDNMPanel
      AlignWithMargins = True
      Left = 1
      Top = 0
      Width = 667
      Height = 306
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblTimerMsg: TLabel
        Left = 1
        Top = 289
        Width = 665
        Height = 16
        Cursor = crHandPoint
        Align = alBottom
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        GlowSize = 2
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 4
      end
      object grdmain: TwwDBGrid
        Left = 1
        Top = 1
        Width = 665
        Height = 288
        ControlType.Strings = (
          'Approved;CheckBox;T;F'
          'CanApprove;CheckBox;T;F')
        Selected.Strings = (
          'EmployeeName'#9'20'#9'Employee'#9#9
          'ValueFrom'#9'10'#9'Value From'#9#9
          'ValueTo'#9'10'#9'Value To'#9#9
          'Approved'#9'9'#9'Approved ?'#9#9
          'ApprovedOn'#9'18'#9'On'#9#9
          'Approvedby'#9'11'#9'By'#9#9
          'ApprovalOrder'#9'7'#9'Approval~Order'#9#9)
        MemoAttributes = [mSizeable]
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Align = alClient
        DataSource = dsApprovalList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgAllowInsert]
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgRowResize]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = True
        OnCalcCellColors = grdmainCalcCellColors
        OnDblClick = grdmainDblClick
        PaintOptions.BackgroundOptions = [coBlendFixedRow]
      end
    end
    object pnlBottom: TDNMPanel
      AlignWithMargins = True
      Left = 1
      Top = 306
      Width = 667
      Height = 50
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        667
        50)
      object Shape1: TShape
        AlignWithMargins = True
        Left = 587
        Top = 4
        Width = 76
        Height = 42
        Anchors = [akTop, akRight, akBottom]
        Brush.Style = bsClear
      end
      object lblcheckPref: TLabel
        AlignWithMargins = True
        Left = 592
        Top = 4
        Width = 67
        Height = 42
        Cursor = crHandPoint
        HelpContext = 1638007
        Margins.Right = 7
        Align = alRight
        Alignment = taCenter
        Caption = 'Check Preferences'
        Color = 13487565
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnClick = lblcheckPrefClick
        ExplicitHeight = 30
      end
      object cmdClose: TDNMSpeedButton
        Left = 173
        Top = 11
        Width = 93
        Height = 29
        HelpContext = 251008
        Anchors = []
        Caption = '&Save'
        Default = True
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ModalResult = 1
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = cmdCloseClick
      end
      object cmdCancel: TDNMSpeedButton
        Left = 402
        Top = 11
        Width = 93
        Height = 29
        HelpContext = 251005
        Anchors = []
        Cancel = True
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
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ModalResult = 2
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = cmdCancelClick
      end
      object btnApprove: TDNMSpeedButton
        Left = 287
        Top = 11
        Width = 93
        Height = 29
        HelpContext = 251008
        Anchors = []
        Caption = 'Approve'
        Default = True
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = btnApproveClick
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 95
    Top = 173
  end
  inherited tmrdelay: TTimer
    Left = 96
    Top = 208
  end
  inherited popSpelling: TPopupMenu
    Left = 62
    Top = 173
  end
  inherited tmrdelayMsg: TTimer
    Left = 64
    Top = 208
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 128
    Top = 173
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 293
    Top = 173
  end
  inherited MyConnection: TERPConnection
    Database = 'sample_company'
    Server = 'localhost'
    Connected = True
    Left = 64
    Top = 103
  end
  inherited DataState: TDataState
    Left = 194
    Top = 173
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 326
    Top = 173
  end
  inherited imgsort: TImageList
    Left = 227
    Top = 173
    Bitmap = {
      494C010102009400D80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 165
    Top = 98
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 359
    Top = 173
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 161
    Top = 173
  end
  inherited qryMemTrans: TERPQuery
    Left = 132
    Top = 98
  end
  inherited tmrOnshow: TTimer
    Left = 128
    Top = 208
  end
  object Actionlist: TActionList
    Left = 260
    Top = 173
  end
  object dsApprovalList: TDataSource
    DataSet = qryApprovalList
    Left = 99
    Top = 130
  end
  object qryApprovalList: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      
        'if(:Amount BETWEEN  AL.ValueFrom AND AL.ValueTo , "T", "F") CanA' +
        'pprove,'
      
        '@rownum:=if(:Amount BETWEEN  AL.ValueFrom AND AL.ValueTo , @rown' +
        'um+1 , @rownum) AS ApprovalOrder,'
      'AL.ID AS ALID,'#9
      'AL.ApprovalType,'#9
      'AL.EmployeeID,'#9
      'AL.EmployeeName,'#9
      'AL.ValueFrom,'#9
      'AL.ValueTo,'#9
      'AL.ValueLeeway,'#9
      'AL.EnteredByEmployeeName,'
      'TA.TransType,'
      'TA.TransID,'
      'TA.Employeeid as ApprovedbyID,'
      'TA.Approved,'
      'TA.ApprovedOn, '
      'E.EmployeeName AS Approvedby,'
      'TA.ID AS TAID'
      'from  (SELECT @rownum:=0) r ,'
      ' (SELECT @SaleId:=0) s,'
      'tblapprovallevels AL'
      
        'LEFT JOIN tbltransapprovals TA ON AL.employeeId = TA.Employeeid ' +
        'AND TA.TransType = ApprovalType AND TA.TransID = :TransID'
      'LEFT JOIN tblemployees E ON TA.Employeeid = E.EmployeeID'
      'where ApprovalType = :Approvaltype'
      'and AL.Active = "T"'
      'ORDER BY ValueTo')
    Active = True
    Left = 99
    Top = 98
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Amount'
      end
      item
        DataType = ftUnknown
        Name = 'Amount'
      end
      item
        DataType = ftUnknown
        Name = 'TransID'
      end
      item
        DataType = ftUnknown
        Name = 'Approvaltype'
      end>
    object qryApprovalListEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 20
      FieldName = 'EmployeeName'
      Origin = 'AL.EmployeeName'
      Size = 255
    end
    object qryApprovalListValueFrom: TFloatField
      DisplayLabel = 'Value From'
      DisplayWidth = 10
      FieldName = 'ValueFrom'
      Origin = 'AL.ValueFrom'
      currency = True
    end
    object qryApprovalListValueTo: TFloatField
      DisplayLabel = 'Value To'
      DisplayWidth = 10
      FieldName = 'ValueTo'
      Origin = 'AL.ValueTo'
      currency = True
    end
    object qryApprovalListApproved: TWideStringField
      DisplayLabel = 'Approved ?'
      DisplayWidth = 9
      FieldName = 'Approved'
      Origin = 'TA.Approved'
      OnChange = qryApprovalListApprovedChange
      FixedChar = True
      Size = 1
    end
    object qryApprovalListApprovedOn: TDateTimeField
      DisplayLabel = 'On'
      DisplayWidth = 18
      FieldName = 'ApprovedOn'
      Origin = 'TA.ApprovedOn'
    end
    object qryApprovalListApprovedby: TWideStringField
      DisplayLabel = 'By'
      DisplayWidth = 11
      FieldName = 'Approvedby'
      Origin = 'E.EmployeeName'
      Size = 255
    end
    object qryApprovalListApprovalOrder: TLargeintField
      DisplayLabel = 'Approval~Order'
      DisplayWidth = 7
      FieldName = 'ApprovalOrder'
      Origin = 'ApprovalOrder'
    end
    object qryApprovalListCanApprove: TWideStringField
      DisplayLabel = 'Can Approve?'
      DisplayWidth = 1
      FieldName = 'CanApprove'
      Origin = 'CanApprove'
      Visible = False
      Size = 1
    end
    object qryApprovalListALID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ALID'
      Origin = 'AL.ID'
      Visible = False
    end
    object qryApprovalListApprovalType: TWideStringField
      DisplayWidth = 16
      FieldName = 'ApprovalType'
      Origin = 'AL.ApprovalType'
      Visible = False
      FixedChar = True
      Size = 16
    end
    object qryApprovalListEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'AL.EmployeeID'
      Visible = False
    end
    object qryApprovalListValueLeeway: TFloatField
      DisplayWidth = 10
      FieldName = 'ValueLeeway'
      Origin = 'AL.ValueLeeway'
      Visible = False
    end
    object qryApprovalListEnteredByEmployeeName: TWideStringField
      DisplayWidth = 255
      FieldName = 'EnteredByEmployeeName'
      Origin = 'AL.EnteredByEmployeeName'
      Visible = False
      Size = 255
    end
    object qryApprovalListTransType: TWideStringField
      DisplayWidth = 255
      FieldName = 'TransType'
      Origin = 'TA.TransType'
      Visible = False
      Size = 255
    end
    object qryApprovalListTransID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TransID'
      Origin = 'TA.TransID'
      Visible = False
    end
    object qryApprovalListTAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'TAID'
      Origin = 'TA.ID'
      Visible = False
    end
    object qryApprovalListApprovedbyID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ApprovedbyID'
      Origin = 'TA.EmployeeId'
      Visible = False
    end
  end
end
