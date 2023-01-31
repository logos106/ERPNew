inherited fmNewClientEdit: TfmNewClientEdit
  Caption = 'Client'
  ClientHeight = 433
  ClientWidth = 857
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 873
  ExplicitHeight = 471
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlBottom: TPanel
    Top = 392
    Width = 857
    ExplicitTop = 392
    ExplicitWidth = 857
  end
  inherited alMain: TActionList
    inherited actOk: TAction
      OnExecute = actOkExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
  end
end
