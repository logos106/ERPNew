inherited ScopingDefinitionEditor: TScopingDefinitionEditor
  Left = 136
  Top = 180
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlTop: TDNMPanel
    inherited DNMPanel1: TDNMPanel
      inherited edtName: TEdit
        Font.Style = []
        ParentFont = False
      end
      inherited edtDescription: TEdit
        Font.Style = []
        ParentFont = False
      end
    end
  end
  inherited UserDefinedGrid: TAdvStringGrid
    OnEnter = UserDefinedGridEnter
    ShowModified.Enabled = True
    ColWidths = (
      162
      162
      162
      162
      162
      161
      21)
  end
  inherited pnlBottom: TDNMPanel
    inherited btnSave: TDNMSpeedButton
    end
    inherited btnNew: TDNMSpeedButton
      Font.Charset = ANSI_CHARSET
    end
    inherited btnCancel: TDNMSpeedButton
    end
  end
end
