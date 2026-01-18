unit frmConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxLayoutControlAdapters,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, System.ImageList, Vcl.ImgList,
  cxImageList, dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxLabel, uModDispatcher,
  dxCoreGraphics, cxButtonEdit, cxMaskEdit, cxSpinEdit, cxTextEdit;

type
  TFormConfig = class(TFormBase)
    lgTop: TdxLayoutGroup;
    lgCenter: TdxLayoutGroup;
    imgTittle: TdxLayoutImageItem;
    liLblTitle: TdxLayoutLabeledItem;
    sprtrTop: TdxLayoutSeparatorItem;
    liApiUrl: TdxLayoutItem;
    lgApiConfig: TdxLayoutGroup;
    lgScaleConfig: TdxLayoutGroup;
    liScaleIp: TdxLayoutItem;
    liScalePort: TdxLayoutItem;
    edtApiUrl: TcxTextEdit;
    edtScaleIp: TcxTextEdit;
    seScalePort: TcxSpinEdit;
    liApiLogPath: TdxLayoutItem;
    edtbtnApiLogPath: TcxButtonEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConfig: TFormConfig;

implementation

{$R *.dfm}

end.
