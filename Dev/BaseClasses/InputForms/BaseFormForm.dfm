inherited BaseForm: TBaseForm
  Left = 1236
  Top = 326
  Caption = 'BaseForm'
  ClientHeight = 179
  ClientWidth = 284
  OldCreateOrder = True
  OnPaint = FormPaint
  ExplicitLeft = 1236
  ExplicitTop = 326
  ExplicitWidth = 300
  ExplicitHeight = 218
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 179
    Width = 284
    ExplicitTop = 155
    ExplicitWidth = 284
  end
  object dlgReportSelect: TSelectionDialog
    Caption = 'Report Selection'
    Message = 'Please select a report to print/preview..'
    MessageFont.Charset = ANSI_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -12
    MessageFont.Name = 'Arial'
    MessageFont.Style = [fsBold]
    Buttons = [sbOK, sbCancel]
    MultiSelect = False
    Width = 370
    Height = 250
    Color = 15527129
    Left = 33
    Top = 48
  end
end
