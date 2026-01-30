unit frmWeighing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  dxLayoutControlAdapters, System.Actions, Vcl.ActnList, cxClasses, dxBar,
  dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxTextEdit, Vcl.ExtCtrls,
  dxGDIPlusClasses, cxImage, cxLabel, cxMaskEdit, cxSpinEdit;

type
  TFormWeighing = class(TFormBase)
    lgCustomer: TdxLayoutGroup;
    lgProduct: TdxLayoutGroup;
    liCustomer: TdxLayoutItem;
    liProduct: TdxLayoutItem;
    liSelectProduct: TdxLayoutItem;
    liSelectCustomer: TdxLayoutItem;
    liClearCustomer: TdxLayoutItem;
    liClearProduct: TdxLayoutItem;
    btnSelectProduct: TcxButton;
    btnSelectCustomer: TcxButton;
    btnClearCustomer: TcxButton;
    btnClearProduct: TcxButton;
    edtCustomer: TcxTextEdit;
    edtProduct: TcxTextEdit;
    actSelectProduct: TAction;
    actSelectCutomer: TAction;
    actClearProduct: TAction;
    actClearCustomer: TAction;
    pnlTop: TPanel;
    liTop: TdxLayoutItem;
    sprtrTop: TdxLayoutSeparatorItem;
    imgTitle: TcxImage;
    lblTitle: TcxLabel;
    lgWeighing: TdxLayoutGroup;
    lgWeighingData: TdxLayoutGroup;
    liScaleValue: TdxLayoutItem;
    liDoWeighing: TdxLayoutItem;
    pnlScaleInfo: TPanel;
    btnDoWeighing: TcxButton;
    lgScale: TdxLayoutGroup;
    lgScaleMass: TdxLayoutGroup;
    liScaleStatus: TdxLayoutItem;
    pnlScaleStatus: TPanel;
    actDoWeighing: TAction;
    sprtrTop2: TdxLayoutSeparatorItem;
    lgTop: TdxLayoutGroup;
    lgRegNo: TdxLayoutGroup;
    liCarNo: TdxLayoutItem;
    liTrailerNo: TdxLayoutItem;
    edtCarNo: TcxTextEdit;
    edtTrailerNo: TcxTextEdit;
    lgTopRight: TdxLayoutGroup;
    liTare: TdxLayoutItem;
    seTare: TcxSpinEdit;
    liNetto: TdxLayoutItem;
    seNetto: TcxSpinEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWeighing: TFormWeighing;

implementation

{$R *.dfm}

end.
