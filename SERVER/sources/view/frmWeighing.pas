unit frmWeighing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  dxLayoutControlAdapters, System.Actions, Vcl.ActnList, cxClasses, dxBar,
  dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxTextEdit, Vcl.ExtCtrls,
  dxGDIPlusClasses, cxImage, cxLabel, cxMaskEdit, cxSpinEdit, cxDropDownEdit,
  dxStatusBar, cItemWeighing;

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
    liWeighingType: TdxLayoutItem;
    cmbWeighingType: TcxComboBox;
    pnlScaleMass: TPanel;
    lblScaleMass: TcxLabel;
    lblScaleUnit: TcxLabel;
    pnlScaleStatusInfo: TPanel;
    liStatusBar: TdxLayoutItem;
    stsbrBottom: TdxStatusBar;
    lgCar: TdxLayoutGroup;
    liSearchCars: TdxLayoutItem;
    btnSearchCar: TcxButton;
    actSearchCar: TAction;
    cmbCustomer: TcxComboBox;
    cmbProduct: TcxComboBox;
    liClearData: TdxLayoutItem;
    btnClearData: TcxButton;
    actClearData: TAction;
    procedure actSelectProductExecute(Sender: TObject);
    procedure actSelectCutomerExecute(Sender: TObject);
    procedure actClearProductExecute(Sender: TObject);
    procedure actClearCustomerExecute(Sender: TObject);
    procedure actDoWeighingExecute(Sender: TObject);
    procedure actSearchCarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbWeighingTypePropertiesChange(Sender: TObject);
    procedure actClearDataExecute(Sender: TObject);
  private
    FWeighingItem : TItemWeighing;

    function ValidateWeighingData() : Boolean;
    procedure AssignDataToWeighing();
    procedure FillFormData();
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;

    constructor Create(AOwner: TComponent); overload;
    destructor Destroy(); override;
  end;

var
  FormWeighing: TFormWeighing;

implementation

uses
  uConsts, frmAppMessage, cTypes, cHelpFunctions, cItemCustomer,
  cItemProduct, frmCustomerList, frmProductList, frmWeighingList;

{$R *.dfm}

{ TFormWeighing }

procedure TFormWeighing.actClearCustomerExecute(Sender: TObject);
begin
  Self.cmbCustomer.ItemIndex := -1;
  Self.FWeighingItem.Customer.SetDefaultValues;
end;

procedure TFormWeighing.actClearDataExecute(Sender: TObject);
begin
  Self.FWeighingItem.SetDefaultValues;
  Self.FillFormData;
end;

procedure TFormWeighing.actClearProductExecute(Sender: TObject);
begin
  Self.cmbProduct.ItemIndex := -1;
  Self.FWeighingItem.Product.SetDefaultValues;
end;

procedure TFormWeighing.actDoWeighingExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TFormWeighing.actSearchCarExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TFormWeighing.actSelectCutomerExecute(Sender: TObject);
begin
  var customer : TItemCustomer := TFormCustomerList.CreateAndSelectOne(nil);
  if not Assigned(customer) then
  begin
    actClearCustomerExecute(nil);
    Exit;
  end;

  try
    for var I : Integer := Self.cmbCustomer.Properties.Items.Count - 1 downto 0 do
    begin
      var tmpCustomer : TItemCustomer := Self.cmbCustomer.Properties.Items.Objects[I] as TItemCustomer;
      if tmpCustomer.IdErp <> customer.IdErp then
        Continue;

      Self.cmbCustomer.ItemIndex := I;
      Break;
    end;
  finally
    customer.Free;
  end;
end;

procedure TFormWeighing.actSelectProductExecute(Sender: TObject);
begin
  var product : TItemProduct := TFormProductList.CreateAndSelectOne(nil);
  if not Assigned(product) then
  begin
    actClearProductExecute(nil);
    Exit;
  end;

  try
    for var I : Integer := Self.cmbProduct.Properties.Items.Count - 1 downto 0 do
    begin
      var tmpProduct : TItemProduct := Self.cmbProduct.Properties.Items.Objects[I] as TItemProduct;
      if tmpProduct.IdErp <> product.IdErp then
        Continue;

      Self.cmbProduct.ItemIndex := I;
      Break;
    end;
  finally
    product.Free;
  end;
end;

procedure TFormWeighing.AssignDataToWeighing;
begin
  var customer : TItemCustomer := TItemCustomer(Self.cmbCustomer.ItemObject);
  Self.FWeighingItem.Customer.AssignValues(customer);

  var product : TItemProduct := TItemProduct(Self.cmbProduct.ItemObject);
  Self.FWeighingItem.Product.AssignValues(product);

  Self.FWeighingItem.WeighingType := TWeighingType.FromInteger(Self.cmbWeighingType.ItemIndex);
end;

procedure TFormWeighing.cmbWeighingTypePropertiesChange(Sender: TObject);
begin
  var tmpWT : TWeighingType := TWeighingType.FromInteger(Self.cmbWeighingType.ItemIndex);

  Self.liTare.Visible := tmpWT in [wtSecond, wtSingle];
  Self.liNetto.Visible := Self.liTare.Visible;
end;

constructor TFormWeighing.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.FWeighingItem := TItemWeighing.Create;

  THelpFunctions.FillWeighingTypeCombo(Self.cmbWeighingType);
  THelpFunctions.FillCustomersCombo(Self.cmbCustomer);
  THelpFunctions.FillProductsCombo(Self.cmbProduct);
end;

class function TFormWeighing.CreateAndShowModal(AOwner: TComponent): Integer;
begin
  Result := mrNone;
  if Assigned(FormWeighing) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormWeighing := TFormWeighing.Create(AOwner);
  try
    Result := FormWeighing.ShowModal;
  finally
    FreeAndNil(FormWeighing);
  end;
end;

destructor TFormWeighing.Destroy;
begin
  Self.FWeighingItem.Free;

  inherited;
end;

procedure TFormWeighing.FillFormData;
begin
  Self.edtCarNo.Text := Self.FWeighingItem.CarNo;
  Self.edtTrailerNo.Text := Self.FWeighingItem.TrailerNo;

  Self.cmbWeighingType.ItemIndex := Self.FWeighingItem.WeighingType.ToInteger;

  for var I : Integer := Self.cmbCustomer.Properties.Items.Count - 1 downto 0 do
  begin
    var tmpCustomer : TItemCustomer := Self.cmbCustomer.Properties.Items.Objects[I] as TItemCustomer;
    if tmpCustomer.IdErp <> Self.FWeighingItem.Customer.IdErp then
      Continue;

    Self.cmbCustomer.ItemIndex := I;
    Break;
  end;

  for var I : Integer := Self.cmbProduct.Properties.Items.Count - 1 downto 0 do
  begin
    var tmpProduct : TItemProduct := Self.cmbProduct.Properties.Items.Objects[I] as TItemProduct;
    if tmpProduct.IdErp <> Self.FWeighingItem.Product.IdErp then
      Continue;

    Self.cmbProduct.ItemIndex := I;
    Break;
  end;
end;

procedure TFormWeighing.FormDestroy(Sender: TObject);
begin
  FormWeighing := nil;
end;

function TFormWeighing.ValidateWeighingData: Boolean;
begin
  Result := False;
  // sprawdü rodzaj waøenia
  if Self.cmbWeighingType.ItemIndex = wtNone.ToInteger then
  begin
    TFormAppMessage.ShowWarning('Rodzaj waøenia nie zosta≥ wybrany!');
    Exit;
  end;

  // dla waøenia pojedynczego - sprawdü tarÍ
  if (Self.cmbWeighingType.ItemIndex = wtSingle.ToInteger) and (Self.seTare.Value < 1) then
  begin
    TFormAppMessage.ShowWarning('Tara pojazdu nie zosta≥a uzupe≥niona!');
    Exit;
  end;

  // sprawdz numer rejestracyjny
  if Self.edtCarNo.Text = EMPTY_STR then
  begin
    TFormAppMessage.ShowWarning('Nr rejestracyjny pojazdu nie zosta≥ uzupe≥niony!');
    Exit;
  end;

  // sprawdz czy kontrahent zosta≥ wybrany
  if Self.cmbCustomer.ItemIndex = -1 then
  begin
    TFormAppMessage.ShowWarning('Kontrahent nie zosta≥ wybrany!');
    Exit;
  end;
  if not (Assigned(Self.cmbCustomer.ItemObject) and (Self.cmbCustomer.ItemObject is TItemCustomer)) then
  begin
    TFormAppMessage.ShowError('Wybrany kontrahent nie jest obiektem typu TItemCustomer');
    Exit;
  end;

  // sprawdz czy produkt zosta≥ wybrany
  if Self.cmbProduct.ItemIndex = -1 then
  begin
    TFormAppMessage.ShowWarning('Produkt nie zosta≥ wybrany!');
    Exit;
  end;
  if not (Assigned(Self.cmbProduct.ItemObject) and (Self.cmbProduct.ItemObject is TItemProduct)) then
  begin
    TFormAppMessage.ShowError('Wybrany produkt nie jest obiektem typu TItemProduct');
    Exit;
  end;

  Result := True;
end;

end.
