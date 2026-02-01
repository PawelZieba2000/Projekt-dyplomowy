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

const
  WM_SET_SCALE_MASS = WM_USER + 101;
  WM_SET_SCALE_STATUS = WM_USER + 102;

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
    procedure actSelectProductExecute(Sender: TObject);
    procedure actSelectCutomerExecute(Sender: TObject);
    procedure actClearProductExecute(Sender: TObject);
    procedure actClearCustomerExecute(Sender: TObject);
    procedure actDoWeighingExecute(Sender: TObject);
    procedure actSearchCarExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    FWeighingItem : TItemWeighing;

    function ValidateWeighingData() : Boolean;

    procedure SetScaleConnection(const pConnected : Boolean);
    procedure SetScaleStable(const pMassStable : Boolean);
    procedure SetScaleMass(const pMass : Integer);
  public

    constructor Create(AOwner: TComponent); overload;
    destructor Destroy(); override;

    procedure wmSetScaleMass(var pMessage: TMessage); message WM_SET_SCALE_MASS;
    procedure wmSetScaleStatus(var pMessage: TMessage); message WM_SET_SCALE_STATUS;
  end;

var
  FormWeighing: TFormWeighing;

implementation

uses
  uConsts, cManagerScale, frmAppMessage, cTypes, cHelpFunctions;

{$R *.dfm}

{ TFormWeighing }

procedure TFormWeighing.actClearCustomerExecute(Sender: TObject);
begin
  Self.cmbCustomer.ItemIndex := -1;
  Self.FWeighingItem.Customer.SetDefaultValues;
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
  inherited;
//
end;

procedure TFormWeighing.actSelectProductExecute(Sender: TObject);
begin
  inherited;
//
end;

constructor TFormWeighing.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.FWeighingItem := TItemWeighing.Create;

  THelpFunctions.FillWeighingTypeCombo(Self.cmbWeighingType);
  THelpFunctions.FillCustomersCombo(Self.cmbCustomer);
  THelpFunctions.FillProductsCombo(Self.cmbProduct);
end;

destructor TFormWeighing.Destroy;
begin
  Self.FWeighingItem.Free;

  inherited;
end;

procedure TFormWeighing.FormActivate(Sender: TObject);
begin
  TManagerScale.Instance.ConnectWithScale;
end;

procedure TFormWeighing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TManagerScale.Instance.DisconnectWithScale;
  inherited;
end;

procedure TFormWeighing.FormDestroy(Sender: TObject);
begin
  FormWeighing := nil;
end;

procedure TFormWeighing.SetScaleConnection(const pConnected: Boolean);
begin
  var scaleStatusInfo : String := '';
  var scaleUnit : String := '';

  if pConnected then
  begin
    lblScaleMass.Style.Font.Color := clBlack;
    pnlScaleMass.Color := clLime;
    scaleStatusInfo := 'Po≥πczono z miernikiem wagowym';
    scaleUnit := 'kg';
  end else
  begin
    lblScaleMass.Style.Font.Color := clYellow;
    pnlScaleMass.Color := clRed;
    scaleStatusInfo := 'Brak po≥πczenia z miernikiem wagowym';
    var scaleMass : String := '---';
    lblScaleMass.Caption := scaleMass;
  end;

  lblScaleUnit.Style.Font.Color := lblScaleMass.Style.Font.Color;
  stsbrBottom.Font.Color := lblScaleMass.Style.Font.Color;
  pnlScaleStatusInfo.Color := pnlScaleMass.Color;

  lblScaleUnit.Caption := scaleUnit;
  stsbrBottom.Panels[0].Text := scaleStatusInfo;
end;

procedure TFormWeighing.SetScaleMass(const pMass: Integer);
begin
  Self.lblScaleMass.Caption := pMass.ToString;
end;

procedure TFormWeighing.SetScaleStable(const pMassStable: Boolean);
begin
  if pMassStable then
  begin
    lblScaleMass.Style.Font.Color := clBlack;
    pnlScaleMass.Color := clLime;
  end else
  begin
    lblScaleMass.Style.Font.Color := clYellow;
    pnlScaleMass.Color := clRed;
  end;
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

  // sprawdz czy produkt zosta≥ wybrany
  if Self.cmbProduct.ItemIndex = -1 then
  begin
    TFormAppMessage.ShowWarning('Produkt nie zosta≥ wybrany!');
    Exit;
  end;

  Result := True;
end;

procedure TFormWeighing.wmSetScaleMass(var pMessage: TMessage);
begin
  var strMsg : String := PChar(pMessage.LParam);
  var scaleMassArr : TArray<String> := strMsg.Split([SCALE_STATUS_SEPARATOR]);

  var scaleMass : Integer := SCALE_WRONG_MASS;
  var scaleStable : Boolean := False;
  if Length(scaleMassArr) = 2 then
  begin
    scaleMass := Round(StrToFloatDef(scaleMassArr[0], SCALE_WRONG_MASS));
    scaleStable := StrToIntDef(scaleMassArr[1], 0).ToBoolean;
  end;

  var connected : Boolean := scaleMass = SCALE_WRONG_MASS;
  Self.SetScaleConnection(connected);
  if connected then
  begin
    Self.SetScaleStable(scaleStable);
    Self.SetScaleMass(scaleMass);
  end;
end;

procedure TFormWeighing.wmSetScaleStatus(var pMessage: TMessage);
begin
  var strMsg : String := PChar(pMessage.LParam);
  var connected : Boolean := StrToIntDef(strMsg, 0).ToBoolean;
  Self.SetScaleConnection(connected);
end;

end.
