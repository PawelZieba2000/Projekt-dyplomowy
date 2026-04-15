inherited FormUserList: TFormUserList
  Caption = 'Lista u'#380'ytkownik'#243'w'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    inherited gGridList: TcxGrid
      inherited gGridListTableView1: TcxGridTableView
        OnCellDblClick = gGridListTableView1CellDblClick
        OptionsView.ColumnAutoWidth = True
        object clmnId: TcxGridColumn
          Caption = 'ID'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
        end
        object clmnLogin: TcxGridColumn
          Caption = 'LOGIN'
          HeaderAlignmentHorz = taCenter
        end
        object clmnFullName: TcxGridColumn
          Caption = 'IMI'#280' I NAZWISKO'
          HeaderAlignmentHorz = taCenter
        end
      end
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
    inherited btnRefresh: TdxBarLargeButton
      AutoGrayScale = False
    end
    inherited btnAddNew: TdxBarLargeButton
      AutoGrayScale = False
    end
    inherited btnEdit: TdxBarLargeButton
      AutoGrayScale = False
    end
    inherited btnRemove: TdxBarLargeButton
      AutoGrayScale = False
    end
  end
end
