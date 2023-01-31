object Form1: TForm1
  Left = 312
  Top = 206
  Width = 868
  Height = 710
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 657
    Width = 860
    Height = 19
    Panels = <
      item
        Width = 200
      end>
    SimplePanel = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 860
    Height = 657
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'XML Request'
      object Splitter1: TSplitter
        Left = 0
        Top = 375
        Width = 852
        Height = 8
        Cursor = crVSplit
        Align = alBottom
      end
      object Panel1: TPanel
        Left = 0
        Top = 591
        Width = 852
        Height = 38
        Align = alBottom
        TabOrder = 0
        object Label2: TLabel
          Left = 96
          Top = 12
          Width = 28
          Height = 13
          Caption = 'In File'
        end
        object Button2: TButton
          Left = 8
          Top = 5
          Width = 73
          Height = 25
          Caption = 'Process'
          TabOrder = 0
          OnClick = Button2Click
        end
        object edtInFile: TEdit
          Left = 129
          Top = 8
          Width = 477
          Height = 21
          TabOrder = 1
          OnChange = edtInFileChange
        end
        object btnInFile: TButton
          Left = 608
          Top = 8
          Width = 33
          Height = 25
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btnInFileClick
        end
      end
      object memOut: TMemo
        Left = 0
        Top = 383
        Width = 852
        Height = 208
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object memIn: TMemo
        Left = 0
        Top = 0
        Width = 852
        Height = 375
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Property SQL'
      ImageIndex = 1
      object Label1: TLabel
        Left = 17
        Top = 19
        Width = 56
        Height = 13
        Caption = 'Class Name'
      end
      object Button3: TButton
        Left = 16
        Top = 56
        Width = 137
        Height = 25
        Caption = 'Build Class Property Sql '
        TabOrder = 0
        OnClick = Button3Click
      end
      object edtClassName: TEdit
        Left = 80
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'TInvoice'
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 512
    Top = 424
  end
end
