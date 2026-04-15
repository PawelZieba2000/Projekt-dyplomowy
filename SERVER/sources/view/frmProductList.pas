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
  Vcl.StdCtrls, cxButtons, dxLayoutControl, cItemProduct;

type
  TFormProductList = class(TFormBaseList)
    clmnIdErp: TcxGridColumn;
    clmnProdCode: TcxGridColumn;
    clmnProdName: TcxGridColumn;
    clmnProdPrice: TcxGridColumn;
    clmnProdLocationId: TcxGridColumn;
    clmnProdModifDT: TcxGridColumn;
    procedure FormDestroy(Sender: TObject);
    procedure gGridListTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure actOkExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actRemoveExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    FProduct: TItemProduct;

    procedure SelectProduct();
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
    class function CreateAndSelectOne(AOwner : TComponent) : TItemProduct;

    constructor Create(AOwner: TComponent); overload;
    constructor Create(AOwner: TComponent; AProduct: TItemProduct); overload;
  end;

var
  FormProductList: TFormProductList;

implementation

uses
  cHelpFunctions, cManagerProducts, frmProductAddEdit, cTypes, frmAppMessage;

{$R *.dfm}

procedure TFormProductList.actAddExecute(Sender: TObject);
begin
  var tmpProduct : TItemProduct := TItemProduct.Create();

  if TFormProductAddEdit.CreateAndShowModal(nil, tmpProduct, fetAddNew) = mrOk then
    TManagerProducts.Instance.InsertUpdateProduct(tmpProduct)
  else
    tmpProduct.Free;
end;

procedure TFormProductList.actEditExecute(Sender: TObject);
begin
  if (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var tmpID : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnIdErp.Index];
  for var product : TItemProduct in TManagerProducts.Instance.ProductList do
  begin
    if tmpID <> product.Id then
      Continue;

    if TFormProductAddEdit.CreateAndShowModal(nil, product, fetEdit) <> mrOk then
      Exit;

    TManagerProducts.Instance.InsertUpdateProduct(product);
    actRefreshExecute(nil);
    Break;
  end;
end;

procedure TFormProductList.actOkExecute(Sender: TObject);
begin
  if Assigned(Self.FProduct) then
  begin
    Self.SelectProduct;
    Self.ModalResult := mrOk;
  end;
end;

procedure TFormProductList.actRefreshExecute(Sender: TObject);
begin
  TManagerProducts.Instance.GetProductsFromDb;
  Self.gGridListTableView1.DataController.CustomDataSource.DataChanged;
end;

procedure TFormProductList.actRemoveExecute(Sender: TObject);
begin
  var tmpID : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnIdErp.Index];
  var product : TItemProduct := nil;
  for var tmpProduct : TItemProduct in TManagerProducts.Instance.ProductList do
  begin
    if tmpID <> tmpProduct.Id then
      Continue;

    product := tmpProduct;
    Break;
  end;

  if not Assigned(product) then
    Exit;

  if not TFormAppMessage.ShowQusetion('Czy na pewno chcesz usun¹æ produkt ' + product.Name + '?') then
    Exit;

  product.IsDeleted := True;
  TManagerProducts.Instance.InsertUpdateProduct(product);
  actRefreshExecute(nil);
end;

constructor TFormProductList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.FProduct := nil;
  Self.gGridListTableView1.DataController.CustomDataSource := TManagerProducts.Instance.ProductsDS;
  actRefreshExecute(nil);
end;

constructor TFormProductList.Create(AOwner: TComponent; AProduct: TItemProduct);
begin
  Self.Create(AOwner);
  Self.FProduct := AProduct;
end;

class function TFormProductList.CreateAndSelectOne(
  AOwner: TComponent): TItemProduct;
begin
  Result := nil;

  if Assigned(FormProductList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  Result := TItemProduct.Create;
  FormProductList := TFormProductList.Create(AOwner, Result);
  try
    if FormProductList.ShowModal <> mrOk then
      FreeAndNil(Result);
  finally
    FreeAndNil(FormProductList);
  end;
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

procedure TFormProductList.gGridListTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if Assigned(Self.FProduct) then
    Self.SelectProduct;
end;

procedure TFormProductList.SelectProduct;
begin
  if (not Assigned(Self.FProduct))
     or (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var idErp : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnIdErp.Index];
  for var product : TItemProduct in TManagerProducts.Instance.ProductList do
  begin
    if idErp <> product.IdErp then
      Continue;

    Self.FProduct.AssignValues(product);
    Break;
  end;
end;

end.
