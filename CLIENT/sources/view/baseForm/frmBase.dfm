object FormBase: TFormBase
  Left = 0
  Top = 0
  Caption = 'FormBase'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  TextHeight = 15
  object lcMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 528
    ExplicitTop = 160
    ExplicitWidth = 300
    ExplicitHeight = 250
    object btnOk: TcxButton
      Left = 455
      Top = 404
      Width = 75
      Height = 25
      Action = actOk
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 537
      Top = 404
      Width = 75
      Height = 25
      Action = actCancel
      TabOrder = 1
    end
    object lgMain: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      AllowRemove = False
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object lgBottom: TdxLayoutGroup
      Parent = lgMain
      AlignVert = avBottom
      CaptionOptions.Text = 'New Group'
      AllowRemove = False
      ItemIndex = 1
      ShowBorder = False
      Index = 0
    end
    object sprtrBottom: TdxLayoutSeparatorItem
      Parent = lgBottom
      AllowRemove = False
      CaptionOptions.Text = 'Separator'
      Index = 0
    end
    object lgBottomButtons: TdxLayoutGroup
      Parent = lgBottom
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object liOk: TdxLayoutItem
      Parent = lgBottomButtons
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnOk
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liCancel: TdxLayoutItem
      Parent = lgBottomButtons
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnCancel
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
  object barmngMain: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = ModDispatcher.imgList
    ImageOptions.LargeImages = ModDispatcher.imgList
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 16
    Top = 16
    PixelsPerInch = 96
  end
  object actlstMain: TActionList
    Images = ModDispatcher.imgList
    Left = 80
    Top = 16
    object actOk: TAction
      Caption = 'OK'
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = 'Anuluj'
      OnExecute = actCancelExecute
    end
  end
end
