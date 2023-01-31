object fmMain: TfmMain
  Left = 277
  Top = 188
  Caption = 'Help Contexts'
  ClientHeight = 549
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 639
    Height = 549
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'XML Contexts'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        631
        521)
      object Label2: TLabel
        Left = 16
        Top = 77
        Width = 78
        Height = 13
        Caption = 'Form Context Dir'
      end
      object Label1: TLabel
        Left = 16
        Top = 40
        Width = 73
        Height = 13
        Caption = 'Form Increment'
      end
      object btnGo: TButton
        Left = 16
        Top = 480
        Width = 129
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Update Help Contexts'
        TabOrder = 0
        OnClick = btnGoClick
      end
      object btnStop: TButton
        Left = 160
        Top = 480
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Stop'
        TabOrder = 1
        OnClick = btnStopClick
      end
      object memLog: TMemo
        Left = 16
        Top = 144
        Width = 593
        Height = 321
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object chkReassign: TCheckBox
        Left = 112
        Top = 112
        Width = 241
        Height = 17
        Caption = 'Reassign All Contexts'
        TabOrder = 3
      end
      object edtFormInc: TAdvEdit
        Left = 113
        Top = 37
        Width = 72
        Height = 21
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        TabOrder = 4
        Text = '0'
        Visible = True
        OnChange = edtFormIncChange
        Version = '2.8.6.9'
      end
      object edtContextDir: TEdit
        Left = 112
        Top = 72
        Width = 449
        Height = 21
        TabOrder = 5
        OnChange = edtContextDirChange
      end
      object btnContextFile: TBitBtn
        Left = 559
        Top = 71
        Width = 33
        Height = 25
        Caption = '...'
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 6
        OnClick = btnContextFileClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Project'
      ImageIndex = 1
      DesignSize = (
        631
        521)
      object Label3: TLabel
        Left = 16
        Top = 40
        Width = 76
        Height = 13
        Caption = 'Project File (dpr)'
      end
      object edtProjectFile: TEdit
        Left = 104
        Top = 36
        Width = 481
        Height = 21
        TabOrder = 0
        OnChange = edtProjectFileChange
      end
      object btnProjectFile: TBitBtn
        Left = 578
        Top = 35
        Width = 33
        Height = 25
        Caption = '...'
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 1
        OnClick = btnProjectFileClick
      end
      object memProj: TMemo
        Left = 24
        Top = 88
        Width = 585
        Height = 361
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object btnGetForms: TButton
        Left = 24
        Top = 472
        Width = 113
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Get Forms List'
        TabOrder = 3
        OnClick = btnGetFormsClick
      end
      object grpFormType: TRadioGroup
        Left = 168
        Top = 456
        Width = 377
        Height = 49
        Anchors = [akLeft, akBottom]
        Caption = ' Form Type '
        Columns = 2
        ItemIndex = 2
        Items.Strings = (
          'All Forms'
          'Forms With No Help Context'
          'No Help or Invalid Contexts'
          'Forms with Invalid Contexts')
        TabOrder = 4
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'DFM List'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        631
        521)
      object Label5: TLabel
        Left = 16
        Top = 8
        Width = 38
        Height = 13
        Caption = 'Dfm List'
      end
      object lstForms: TCheckListBox
        Left = 16
        Top = 24
        Width = 593
        Height = 449
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
      object Button1: TButton
        Left = 16
        Top = 488
        Width = 105
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Assigne Contexts'
        TabOrder = 1
        OnClick = Button1Click
      end
      object chkReplaceContext: TCheckBox
        Left = 152
        Top = 492
        Width = 233
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = 'Replace contexts for existing components'
        TabOrder = 2
      end
      object btnCheckAll: TButton
        Left = 391
        Top = 488
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Check All'
        TabOrder = 3
        OnClick = btnCheckAllClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'ExcludeList'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        631
        521)
      object Label4: TLabel
        Left = 24
        Top = 8
        Width = 57
        Height = 13
        Caption = 'Exclude List'
      end
      object memExcludeList: TMemo
        Left = 24
        Top = 24
        Width = 585
        Height = 481
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          'BaseClasses\Module\BaseAddinModule.dfm'
          'Budgets\Module\datBudgetAddin.dfm '
          'TemplateReports\Module\datReports.dfm'
          'ERP\Modules\datERP.dfm '
          'General\Objects\CommonObjects\datSpelling.dfm'
          'BaseClasses\Module\dmImagesGirly.dfm'
          'BaseClasses\Module\dmImagesGlossy.dfm'
          'BaseClasses\Module\dmImagesMisc.dfm'
          'BaseClasses\Module\dmImagesSmiley.dfm'
          'BaseClasses\Module\dmImagesSuperHero.dfm'
          'BaseClasses\Module\dmImagesBase.dfm '
          'BaseClasses\Module\dmImagesDefault.dfm')
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Fix Properties'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 480
        Width = 631
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnFixProps: TButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Go'
          TabOrder = 0
          OnClick = btnFixPropsClick
        end
        object Button2: TButton
          Left = 552
          Top = 6
          Width = 75
          Height = 25
          Caption = 'test'
          TabOrder = 1
        end
      end
      object memFixProps: TMemo
        Left = 0
        Top = 0
        Width = 631
        Height = 480
        Align = alClient
        Lines.Strings = (
          '')
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 256
    Top = 16
  end
  object ActionList1: TActionList
    Left = 336
    Top = 24
  end
end
