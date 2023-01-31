inherited frStockAnalysisGuiEdit: TfrStockAnalysisGuiEdit
  Width = 623
  Height = 334
  inherited lblMsg: TLabel
    Top = 318
    Width = 623
  end
  object pnlmain: TDNMPanel [1]
    Left = 0
    Top = 60
    Width = 623
    Height = 258
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 435
    ExplicitHeight = 189
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = 0
      Width = 274
      Height = 258
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitHeight = 189
      DesignSize = (
        274
        258)
      object Label5: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 266
        Height = 15
        HelpContext = 596003
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Qunatity Types'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 83
      end
      object lstGridColumns: TCheckListBox
        AlignWithMargins = True
        Left = 1
        Top = 20
        Width = 272
        Height = 237
        HelpContext = 597017
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        OnClickCheck = lstGridColumnsClickCheck
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BevelWidth = 2
        BorderStyle = bsNone
        Columns = 1
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemHeight = 20
        Items.Strings = (
          'Quotes'
          'Sales Order'
          'Sales Order Back Order'
          'Future Sales Order'
          'Future Sales Order Back Order'
          'Non-ERP Sales'
          'Invoice'
          'Invoice Back Order'
          'On Build Raw'
          'Building'
          'Stock Transfers'
          'PO'
          'PO BO')
        ParentColor = True
        ParentFont = False
        Style = lbOwnerDrawFixed
        TabOrder = 0
        ExplicitHeight = 168
      end
      object btnSelectall: TDNMSpeedButton
        Left = 209
        Top = 6
        Width = 59
        Height = 27
        Hint = 'Save changes and close'
        HelpContext = 169002
        Anchors = [akTop, akRight]
        Caption = 'Select All'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Style = bsModern
        TabOrder = 1
        OnClick = btnSelectallClick
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 274
      Top = 0
      Width = 349
      Height = 258
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 161
      ExplicitHeight = 189
      object Shape2: TShape
        Left = 1
        Top = 101
        Width = 347
        Height = 1
        Align = alTop
        Pen.Color = clGray
        ExplicitLeft = 6
        ExplicitTop = 69
        ExplicitWidth = 386
      end
      object Shape3: TShape
        Left = 1
        Top = 59
        Width = 347
        Height = 1
        Align = alTop
        Pen.Color = clGray
        ExplicitTop = 54
        ExplicitWidth = 269
      end
      object pnlReportduration: TDNMPanel
        Left = 1
        Top = 60
        Width = 347
        Height = 41
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 159
        object Label3: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 345
          Height = 15
          HelpContext = 596003
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 'Report Duration : '
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 98
        end
        object optREportduration: TwwRadioGroup
          AlignWithMargins = True
          Left = 1
          Top = 20
          Width = 345
          Height = 15
          Margins.Left = 1
          Margins.Right = 1
          Margins.Bottom = 1
          DisableThemes = False
          ShowBorder = False
          ShowGroupCaption = False
          ShowFocusRect = False
          Align = alTop
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Weekly'
            'Monthly')
          ParentFont = False
          TabOrder = 0
          OnClick = optREportdurationClick
          ExplicitWidth = 157
        end
      end
      object DNMPanel4: TDNMPanel
        AlignWithMargins = True
        Left = 2
        Top = 103
        Width = 345
        Height = 66
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ExplicitWidth = 157
        DesignSize = (
          345
          66)
        object Label6: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 339
          Height = 15
          HelpContext = 596003
          Align = alTop
          Caption = 'Smart Order Options : '
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 127
        end
        object optIncreaseDecrease: TwwRadioGroup
          AlignWithMargins = True
          Left = 1
          Top = 22
          Width = 322
          Height = 18
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 22
          Margins.Bottom = 1
          DisableThemes = False
          ItemIndex = 0
          ShowBorder = False
          ShowGroupCaption = False
          ShowFocusRect = False
          Align = alTop
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Increase'
            'Decrease')
          ParentFont = False
          TabOrder = 0
          OnClick = optIncreaseDecreaseClick
          ExplicitWidth = 134
        end
        object optPercentageQty: TwwRadioGroup
          AlignWithMargins = True
          Left = 1
          Top = 42
          Width = 322
          Height = 18
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 22
          Margins.Bottom = 1
          DisableThemes = False
          ItemIndex = 0
          ShowBorder = False
          ShowGroupCaption = False
          ShowFocusRect = False
          Align = alTop
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Percentage'
            'Quantity')
          ParentFont = False
          TabOrder = 1
          OnClick = optPercentageQtyClick
          ExplicitWidth = 134
        end
        object edtSOQtyPeercent: TEdit
          Left = 272
          Top = 41
          Width = 66
          Height = 23
          Alignment = taRightJustify
          Anchors = [akRight, akBottom]
          TabOrder = 2
          Text = '0'
          OnExit = edtSOQtyPeercentExit
          OnKeyUp = edtAvailableKeyUp
          ExplicitLeft = 358
        end
      end
      object pnlapplyto: TDNMPanel
        AlignWithMargins = True
        Left = 4
        Top = 173
        Width = 341
        Height = 214
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        ExplicitWidth = 153
        object lblApplyto: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 339
          Height = 15
          HelpContext = 596003
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alTop
          Caption = 'Apply To'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          ExplicitWidth = 47
        end
        object optApplyTo: TwwRadioGroup
          AlignWithMargins = True
          Left = 1
          Top = 18
          Width = 339
          Height = 145
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          DisableThemes = False
          ShowBorder = False
          ShowGroupCaption = False
          ShowFocusRect = False
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Make Available '
            'Make In-Stock'
            'Sales Order'
            'SO and SO BO'
            'SO and Future SO'
            'SO , Future SO and BOs')
          ParentFont = False
          TabOrder = 1
          OnClick = optApplyToClick
          ExplicitWidth = 151
        end
        object edtAvailable: TEdit
          Left = 148
          Top = 18
          Width = 66
          Height = 23
          Alignment = taRightJustify
          TabOrder = 0
          Text = '0'
          OnEnter = edtAvailableEnter
          OnExit = edtAvailableExit
          OnKeyUp = edtAvailableKeyUp
        end
        object edtinstock: TEdit
          Left = 148
          Top = 42
          Width = 66
          Height = 23
          Alignment = taRightJustify
          TabOrder = 2
          Text = '0'
          OnEnter = edtinstockEnter
          OnExit = edtinstockExit
          OnKeyUp = edtinstockKeyUp
        end
      end
      object pnlStatencountry: TDNMPanel
        Left = 1
        Top = 1
        Width = 347
        Height = 58
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        ExplicitWidth = 159
        object Label4: TLabel
          Left = 0
          Top = 0
          Width = 80
          Height = 42
          HelpContext = 596003
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 1
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Calculate SO Qty for '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitLeft = 2
          ExplicitTop = 2
          ExplicitHeight = 38
        end
        object lblcountyrnstate: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 43
          Width = 345
          Height = 14
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alBottom
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 3
        end
        object chkAllStatenCountries: TCheckBox
          AlignWithMargins = True
          Left = 83
          Top = 3
          Width = 41
          Height = 36
          Align = alLeft
          Alignment = taLeftJustify
          Caption = ': All'
          TabOrder = 0
          WordWrap = True
          OnClick = chkAllStatenCountriesClick
        end
        object btnAllStatenCountries: TDNMSpeedButton
          AlignWithMargins = True
          Left = 130
          Top = 3
          Width = 214
          Height = 36
          Hint = 'Save changes and close'
          HelpContext = 169002
          Align = alClient
          Caption = 'Choose Country / State'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Style = bsModern
          TabOrder = 1
          WordWrap = True
          OnClick = btnAllStatenCountriesClick
          ExplicitWidth = 26
        end
      end
    end
  end
  object DNMPanel1: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 623
    Height = 60
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 435
    object DNMPanel3: TDNMPanel
      Left = 1
      Top = 1
      Width = 274
      Height = 58
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 5
        Width = 80
        Height = 34
        HelpContext = 596003
        Margins.Top = 5
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Product'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitHeight = 20
      end
      object lblProducts: TLabel
        AlignWithMargins = True
        Left = 1
        Top = 43
        Width = 272
        Height = 14
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alBottom
        Alignment = taCenter
        Caption = '10 Products Selected'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 103
      end
      object chkAllProducts: TCheckBox
        AlignWithMargins = True
        Left = 89
        Top = 5
        Width = 41
        Height = 34
        Margins.Top = 5
        Align = alLeft
        Alignment = taLeftJustify
        Caption = ': All'
        TabOrder = 0
        OnClick = chkAllProductsClick
      end
      object btnchooseproducts: TDNMSpeedButton
        AlignWithMargins = True
        Left = 136
        Top = 3
        Width = 135
        Height = 36
        Hint = 'Save changes and close'
        HelpContext = 169002
        Align = alClient
        Caption = 'Choose Products'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Style = bsModern
        TabOrder = 1
        OnClick = btnChooseProductsClick
      end
    end
    object pnlclass: TDNMPanel
      Left = 275
      Top = 1
      Width = 347
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 159
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 80
        Height = 42
        HelpContext = 596003
        Margins.Top = 5
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Department'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitHeight = 20
      end
      object lblClasses: TLabel
        AlignWithMargins = True
        Left = 1
        Top = 43
        Width = 345
        Height = 14
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alBottom
        Alignment = taCenter
        Caption = '10 Classes Selected'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 99
      end
      object chkAllClasses: TCheckBox
        AlignWithMargins = True
        Left = 83
        Top = 3
        Width = 41
        Height = 36
        Align = alLeft
        Alignment = taLeftJustify
        Caption = ': All'
        TabOrder = 0
        OnClick = chkAllClassesClick
      end
      object btnChooseclasses: TDNMSpeedButton
        AlignWithMargins = True
        Left = 130
        Top = 3
        Width = 214
        Height = 36
        Hint = 'Save changes and close'
        HelpContext = 169002
        Align = alClient
        Caption = 'Choose Departments'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Style = bsModern
        TabOrder = 1
        OnClick = btnChooseclassesClick
        ExplicitWidth = 26
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 233
    Top = 203
  end
end
