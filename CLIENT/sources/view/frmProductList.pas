unit frmProductList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseList, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData,
  dxLayoutControlAdapters, dxLayoutContainer, cxTextEdit, System.Actions,
  Vcl.ActnList, dxBar, cxBarEditItem, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, cxButtons, dxLayoutControl;

type
  TFormProductList = class(TFormBaseList)
    clmnIdErp: TcxGridColumn;
    clmnProdCode: TcxGridColumn;
    clmnProdName: TcxGridColumn;
    clmnProdPrice: TcxGridColumn;
    clmnProdLocationId: TcxGridColumn;
    clmnProdModifDT: TcxGridColumn;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;

    constructor Create(AOwner: TComponent); override;
  end;

var
  FormProductList: TFormProductList;

implementation

uses
  cHelpFunctions, cManagerProducts;

{$R *.dfm}

constructor TFormProductList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.gGridListTableView1.DataController.CustomDataSource := TManagerProducts.Instance.ProductsDS;
end;

class function TFormProductList.CreateAndShowModal(
  AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormProductList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormProductList := TFormProductList.Create(AOwner);
  try
    Result := FormProductList.ShowModal;
  finally
    FreeAndNil(FormProductList);
  end;
end;

procedure TFormProductList.FormDestroy(Sender: TObject);
begin
  FormProductList := nil;
end;

end.
