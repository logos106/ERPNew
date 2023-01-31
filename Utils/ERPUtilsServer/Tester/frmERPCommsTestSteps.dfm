inherited fmERPCommsTestSteps: TfmERPCommsTestSteps
  Caption = 'ERP Head Office Comms Test'
  ClientHeight = 533
  ClientWidth = 915
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ExplicitWidth = 931
  ExplicitHeight = 571
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TDNMPanel
    Width = 915
    Height = 533
    ExplicitWidth = 915
    ExplicitHeight = 533
    inherited btnTest: TDNMSpeedButton
      OnClick = btnTestClick
    end
  end
end
