inherited FormBaseList: TFormBaseList
  Caption = 'FormBaseList'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    Top = 58
    Height = 383
    ExplicitTop = 58
    ExplicitHeight = 383
    inherited btnOk: TcxButton
      Top = 346
      TabOrder = 1
      ExplicitTop = 346
    end
    inherited btnCancel: TcxButton
      Top = 346
      TabOrder = 2
      ExplicitTop = 346
    end
    object gGridList: TcxGrid [2]
      Left = 12
      Top = 25
      Width = 600
      Height = 301
      TabOrder = 0
      object gGridListTableView1: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object gGridListLevel1: TcxGridLevel
        GridView = gGridListTableView1
      end
    end
    inherited lgBottom: TdxLayoutGroup
      Index = 2
    end
    object liGrid: TdxLayoutItem
      Parent = lgMain
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = gGridList
      ControlOptions.OriginalHeight = 200
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object sprtrTop: TdxLayoutSeparatorItem
      Parent = lgMain
      CaptionOptions.Text = 'Separator'
      Index = 0
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      58
      0)
    object barmngMainBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Top'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 652
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'baredtFilter'
        end
        item
          Visible = True
          ItemName = 'btnSearch'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object btnRefresh: TdxBarLargeButton
      Action = actRefresh
      Category = 0
    end
    object btnSearch: TdxBarLargeButton
      Action = actSearch
      Category = 0
    end
    object baredtFilter: TcxBarEditItem
      Caption = 'Filtry'
      Category = 0
      Hint = 'Filtry'
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxTextEditProperties'
      InternalEditValue = ''
    end
  end
  inherited actlstMain: TActionList
    object actRefresh: TAction
      Caption = 'Od'#347'wie'#380
      ImageIndex = 10
      OnExecute = actRefreshExecute
    end
    object actSearch: TAction
      Caption = 'Szukaj'
      ImageIndex = 11
      OnExecute = actSearchExecute
    end
  end
end
