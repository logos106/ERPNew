object fmMagentoTest: TfmMagentoTest
  Left = 0
  Top = 0
  Caption = 'fmMagentoTest'
  ClientHeight = 634
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    794
    634)
  PixelsPerInch = 96
  TextHeight = 16
  object memLog: TMemo
    Left = 8
    Top = 70
    Width = 778
    Height = 556
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Synch'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 192
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Post Test'
    TabOrder = 3
    OnClick = Button3Click
  end
  object btnGetTest: TButton
    Left = 273
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Get Test'
    TabOrder = 4
    OnClick = btnGetTestClick
  end
  object btnGetSalesOrder: TButton
    Left = 354
    Top = 8
    Width = 127
    Height = 25
    Caption = 'Get Sales Order'
    TabOrder = 5
    OnClick = btnGetSalesOrderClick
  end
  object btnGetSOList: TButton
    Left = 487
    Top = 8
    Width = 127
    Height = 25
    Caption = 'Get SO List'
    TabOrder = 6
    OnClick = btnGetSOListClick
  end
  object btnPaymentMethods: TButton
    Left = 8
    Top = 39
    Width = 127
    Height = 25
    Caption = 'Get Payment Meths'
    TabOrder = 7
    OnClick = btnPaymentMethodsClick
  end
  object btnGetProduct: TButton
    Left = 141
    Top = 39
    Width = 92
    Height = 25
    Caption = 'Get Procuct'
    TabOrder = 8
    OnClick = btnGetProductClick
  end
  object btAttributeSets: TButton
    Left = 239
    Top = 39
    Width = 109
    Height = 25
    Caption = 'Get Attribute Sets'
    TabOrder = 9
    OnClick = btAttributeSetsClick
  end
  object btnEntityType: TButton
    Left = 354
    Top = 39
    Width = 109
    Height = 25
    Caption = 'Get Entity Type'
    TabOrder = 10
    OnClick = btnEntityTypeClick
  end
  object btnGetImage: TButton
    Left = 469
    Top = 39
    Width = 109
    Height = 25
    Caption = 'Get Image'
    TabOrder = 11
    OnClick = btnGetImageClick
  end
end
