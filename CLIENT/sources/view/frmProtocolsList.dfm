inherited FormProtocolsList: TFormProtocolsList
  Caption = 'Lista protoko'#322#243'w komunikacyjnych'
  ClientWidth = 878
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 894
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Width = 878
    ExplicitWidth = 878
    inherited btnOk: TcxButton
      Left = 709
      ExplicitLeft = 709
    end
    inherited btnCancel: TcxButton
      Left = 791
      ExplicitLeft = 791
    end
    inherited gGridList: TcxGrid
      Width = 854
      ExplicitWidth = 854
      inherited gGridListTableView1: TcxGridTableView
        OnCellDblClick = gGridListTableView1CellDblClick
        OptionsView.ColumnAutoWidth = True
        object clmnId: TcxGridColumn
          Caption = 'ID'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnName: TcxGridColumn
          Caption = 'NAZWA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnMsgToDevice: TcxGridColumn
          Caption = 'WIADOMOSC DO MIERNIKA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnFrameBegin: TcxGridColumn
          Caption = 'POCZATEK RAMKI'
          HeaderAlignmentHorz = taCenter
        end
        object clmnFrameEnd: TcxGridColumn
          Caption = 'KONIEC RAMKI'
          HeaderAlignmentHorz = taCenter
        end
      end
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
    inherited barmngMainBar1: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnAddNew'
        end
        item
          Visible = True
          ItemName = 'btnEdit'
        end
        item
          Visible = True
          ItemName = 'btnRemove'
        end>
    end
    inherited btnRefresh: TdxBarLargeButton
      Visible = ivNever
    end
    inherited baredtFilter: TcxBarEditItem
      Visible = ivNever
    end
    object btnAddNew: TdxBarLargeButton
      Action = actAdd
      Category = 0
      AutoGrayScale = False
    end
    object btnEdit: TdxBarLargeButton
      Action = actEdit
      Category = 0
      AutoGrayScale = False
    end
    object btnRemove: TdxBarLargeButton
      Action = actRemove
      Category = 0
      AutoGrayScale = False
    end
  end
  inherited actlstMain: TActionList
    object actAdd: TAction
      Caption = 'Dodaj'
      ImageIndex = 13
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = 'Edytuj'
      ImageIndex = 15
      OnExecute = actEditExecute
    end
    object actRemove: TAction
      Caption = 'Usus'#324
      ImageIndex = 14
      OnExecute = actRemoveExecute
    end
  end
end
