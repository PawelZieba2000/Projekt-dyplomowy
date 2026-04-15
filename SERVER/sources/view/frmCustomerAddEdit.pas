unit frmCustomerAddEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseAddEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  dxLayoutControlAdapters, System.Actions, Vcl.ActnList, cxClasses, dxBar,
  dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl, cTypes,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxMaskEdit,
  cxSpinEdit, cxTextEdit, cItemCustomer;

type
  TFormCustomerAddEdit = class(TFormBaseAddEdit)
    lgTop: TdxLayoutGroup;
    lgCenter: TdxLayoutGroup;
    imgTitle: TdxLayoutImageItem;
    liLblTitle: TdxLayoutLabeledItem;
    sprtr1: TdxLayoutSeparatorItem;
    liName: TdxLayoutItem;
    liCode: TdxLayoutItem;
    edtName: TcxTextEdit;
    edtCode: TcxTextEdit;
    liNIP: TdxLayoutItem;
    liPhoneNo: TdxLayoutItem;
    liStreet: TdxLayoutItem;
    liHouseNo: TdxLayoutItem;
    liLocalNo: TdxLayoutItem;
    liPostCode: TdxLayoutItem;
    liCity: TdxLayoutItem;
    liCountry: TdxLayoutItem;
    lgAddress1: TdxLayoutGroup;
    lgAddress2: TdxLayoutGroup;
    edtNIP: TcxTextEdit;
    edtPhoneNo: TcxTextEdit;
    edtStreet: TcxTextEdit;
    edtHouseNo: TcxTextEdit;
    edtLocalNo: TcxTextEdit;
    edtPostCode: TcxTextEdit;
    edtCity: TcxTextEdit;
    edtCountry: TcxTextEdit;
    lgAddress: TdxLayoutGroup;
    lgAddData: TdxLayoutGroup;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FEditMode : TFormEditType;
    FCustomer : TItemCustomer;
    FIsInEdit : Boolean;

    procedure FillComponents();
    procedure FillProductValues();
    function ValidateValues() : Boolean;

    procedure SetControlsReadOnly(pIsReadOnly: Boolean);
  public
    class function CreateAndShowModal(AOwner : TComponent;  ACustomer: TItemCustomer; AEditMode: TFormEditType) : Integer;

    constructor Create(AOwner: TComponent; ACustomer: TItemCustomer; AEditMode: TFormEditType); overload;
  end;

var
  FormCustomerAddEdit: TFormCustomerAddEdit;

implementation

uses
  cHelpFunctions, uConsts, frmAppMessage;

{$R *.dfm}

procedure TFormCustomerAddEdit.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormCustomerAddEdit.actOkExecute(Sender: TObject);
begin
  if (Self.FEditMode = fetEdit) and (not Self.FISInEdit) then
  begin
    Self.FIsInEdit := True;
    Self.SetControlsReadOnly(not Self.FIsInEdit);

    Self.actOk.Caption := 'OK';
    Exit;
  end;

  if (Self.FISInEdit) then
  begin
    if not Self.ValidateValues then
      Exit;

    Self.FillProductValues();
    Self.ModalResult := mrOk;
  end;
end;

constructor TFormCustomerAddEdit.Create(AOwner: TComponent;
  ACustomer: TItemCustomer; AEditMode: TFormEditType);
begin
inherited Create(AOwner);

  Self.FEditMode := AEditMode;
  Self.FCustomer := ACustomer;

  case Self.FEditMode of
    fetAddNew: begin
      Self.Caption := 'Dodawanie nowego kontrahenta';
      Self.actOk.Caption := 'Dodaj';
    end;

    fetEdit: begin
      Self.Caption := 'Edycja kontrahenta: ' + Self.FCustomer.Name;
      Self.actOk.Caption := 'Edytuj';
    end;
  end;

  liLblTitle.CaptionOptions.Text := Self.Caption;
  FIsInEdit := Self.FEditMode = fetAddNew;

  Self.FillComponents;
  Self.SetControlsReadOnly(not FIsInEdit);
end;

class function TFormCustomerAddEdit.CreateAndShowModal(AOwner: TComponent;
  ACustomer: TItemCustomer; AEditMode: TFormEditType): Integer;
begin
  Result := mrNone;
  if Assigned(FormCustomerAddEdit) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormCustomerAddEdit := TFormCustomerAddEdit.Create(AOwner, ACustomer, AEditMode);
  try
    Result := FormCustomerAddEdit.ShowModal;
  finally
    FreeAndNil(FormCustomerAddEdit);
  end;
end;

procedure TFormCustomerAddEdit.FillComponents;
begin
  Self.edtName.Text := Self.FCustomer.Name;
  Self.edtCode.Text := Self.FCustomer.Code;
  Self.edtNIP.Text := Self.FCustomer.NIP;
  Self.edtPhoneNo.Text := Self.FCustomer.PhoneNo;
  Self.edtStreet.Text := Self.FCustomer.Address.Street;
  Self.edtHouseNo.Text := Self.FCustomer.Address.HouseNo;
  Self.edtLocalNo.Text := Self.FCustomer.Address.LocalNo;
  Self.edtPostCode.Text := Self.FCustomer.Address.PostCode;
  Self.edtCity.Text := Self.FCustomer.Address.City;
  Self.edtCountry.Text := Self.FCustomer.Address.Country;
end;

procedure TFormCustomerAddEdit.FillProductValues;
begin
  Self.FCustomer.Name := Self.edtName.Text;
  Self.FCustomer.Code := Self.edtCode.Text;
  Self.FCustomer.NIP := Self.edtNIP.Text;
  Self.FCustomer.PhoneNo := Self.edtPhoneNo.Text;
  Self.FCustomer.Address.Street := Self.edtStreet.Text;
  Self.FCustomer.Address.HouseNo := Self.edtHouseNo.Text;
  Self.FCustomer.Address.LocalNo := Self.edtLocalNo.Text;
  Self.FCustomer.Address.PostCode := Self.edtPostCode.Text;
  Self.FCustomer.Address.City := Self.edtCity.Text;
  Self.FCustomer.Address.Country := Self.edtCountry.Text;
end;

procedure TFormCustomerAddEdit.FormDestroy(Sender: TObject);
begin
  FormCustomerAddEdit := nil;
end;

procedure TFormCustomerAddEdit.SetControlsReadOnly(pIsReadOnly: Boolean);
begin
  Self.edtName.Properties.ReadOnly := pIsReadOnly;
  Self.edtCode.Properties.ReadOnly := pIsReadOnly;
  Self.edtNIP.Properties.ReadOnly := pIsReadOnly;
  Self.edtPhoneNo.Properties.ReadOnly := pIsReadOnly;
  Self.edtStreet.Properties.ReadOnly := pIsReadOnly;
  Self.edtHouseNo.Properties.ReadOnly := pIsReadOnly;
  Self.edtLocalNo.Properties.ReadOnly := pIsReadOnly;
  Self.edtPostCode.Properties.ReadOnly := pIsReadOnly;
  Self.edtCity.Properties.ReadOnly := pIsReadOnly;
  Self.edtCountry.Properties.ReadOnly := pIsReadOnly;
end;

function TFormCustomerAddEdit.ValidateValues: Boolean;
begin
    Result := False;
  try
    if Self.edtName.Text = EMPTY_STR then
      raise Exception.Create('Nazwa kontrahenta nie mo¿e byæ pusta');

    if Self.edtCode.Text = EMPTY_STR then
      raise Exception.Create('Kod kontrahenta nie mo¿e byæ pusty');

    Result := True;
  except
    on E: Exception do
    begin
      TFormAppMessage.ShowWarning(E.Message);
    end;
  end;
end;

end.
