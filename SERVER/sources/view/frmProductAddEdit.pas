unit frmProductAddEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseAddEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  dxLayoutControlAdapters, System.Actions, Vcl.ActnList, cxClasses, dxBar,
  dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl, cTypes,
  cItemProduct, dxLayoutcxEditAdapters, cxContainer, cxEdit, cxMaskEdit,
  cxSpinEdit, cxTextEdit;

type
  TFormProductAddEdit = class(TFormBaseAddEdit)
    lgTop: TdxLayoutGroup;
    lgCenter: TdxLayoutGroup;
    imgTitle: TdxLayoutImageItem;
    liLblTitle: TdxLayoutLabeledItem;
    sprtr1: TdxLayoutSeparatorItem;
    liName: TdxLayoutItem;
    liCode: TdxLayoutItem;
    liPrice: TdxLayoutItem;
    edtName: TcxTextEdit;
    edtCode: TcxTextEdit;
    sePrice: TcxSpinEdit;
    lgPrice: TdxLayoutGroup;
    liLblPrice: TdxLayoutLabeledItem;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FEditMode : TFormEditType;
    FProduct : TItemProduct;
    FIsInEdit : Boolean;

    procedure FillComponents();
    procedure FillProductValues();
    function ValidateValues() : Boolean;

    procedure SetControlsReadOnly(pIsReadOnly: Boolean);
  public
    class function CreateAndShowModal(AOwner : TComponent;  AProduct: TItemProduct; AEditMode: TFormEditType) : Integer;

    constructor Create(AOwner: TComponent; AProduct: TItemProduct; AEditMode: TFormEditType); overload;
  end;

var
  FormProductAddEdit: TFormProductAddEdit;

implementation

uses
  cHelpFunctions, uConsts, frmAppMessage;

{$R *.dfm}

procedure TFormProductAddEdit.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormProductAddEdit.actOkExecute(Sender: TObject);
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

constructor TFormProductAddEdit.Create(AOwner: TComponent;
  AProduct: TItemProduct; AEditMode: TFormEditType);
begin
inherited Create(AOwner);

  Self.FEditMode := AEditMode;
  Self.FProduct := AProduct;

  case Self.FEditMode of
    fetAddNew: begin
      Self.Caption := 'Dodawanie nowego produktu';
      Self.actOk.Caption := 'Dodaj';
    end;

    fetEdit: begin
      Self.Caption := 'Edycja produktu: ' + Self.FProduct.Name;
      Self.actOk.Caption := 'Edytuj';
    end;
  end;

  liLblTitle.CaptionOptions.Text := Self.Caption;
  FIsInEdit := Self.FEditMode = fetAddNew;

  Self.sePrice.Properties.MinValue := 0.0;
  Self.sePrice.Properties.MaxValue := MaxCurrency;

  Self.FillComponents;
  Self.SetControlsReadOnly(not FIsInEdit);
end;

class function TFormProductAddEdit.CreateAndShowModal(AOwner: TComponent;
  AProduct: TItemProduct; AEditMode: TFormEditType): Integer;
begin
  Result := mrNone;
  if Assigned(FormProductAddEdit) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormProductAddEdit := TFormProductAddEdit.Create(AOwner, AProduct, AEditMode);
  try
    Result := FormProductAddEdit.ShowModal;
  finally
    FreeAndNil(FormProductAddEdit);
  end;
end;

procedure TFormProductAddEdit.FillComponents;
begin
  Self.edtName.Text := Self.FProduct.Name;
  Self.edtCode.Text := Self.FProduct.Code;
  Self.sePrice.Value := Self.FProduct.Price;
end;

procedure TFormProductAddEdit.FillProductValues;
begin
  Self.FProduct.Name := Self.edtName.Text;
  Self.FProduct.Code := Self.edtCode.Text;
  Self.FProduct.Price := Self.sePrice.Value;
end;

procedure TFormProductAddEdit.FormDestroy(Sender: TObject);
begin
  FormProductAddEdit := nil;
end;

procedure TFormProductAddEdit.SetControlsReadOnly(pIsReadOnly: Boolean);
begin
  Self.edtName.Properties.ReadOnly := pIsReadOnly;
  Self.edtCode.Properties.ReadOnly := pIsReadOnly;
  Self.sePrice.Properties.ReadOnly := pIsReadOnly;
end;

function TFormProductAddEdit.ValidateValues: Boolean;
begin
    Result := False;
  try
    if Self.edtName.Text = EMPTY_STR then
      raise Exception.Create('Nazwa produktu nie mo¿e byæ pusta');

    if Self.edtCode.Text = EMPTY_STR then
      raise Exception.Create('Kod produktu nie mo¿e byæ pusty');

    Result := True;
  except
    on E: Exception do
    begin
      TFormAppMessage.ShowWarning(E.Message);
    end;
  end;
end;

end.
