unit frmTranssProtocolAddEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseAddEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  dxLayoutControlAdapters, System.Actions, Vcl.ActnList, cxClasses, dxBar,
  dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  cItemTranssProtocol, cTypes;

type
  TFormTranssProtocolAddEdit = class(TFormBaseAddEdit)
    lgTop: TdxLayoutGroup;
    liLblTitle: TdxLayoutLabeledItem;
    imgTitle: TdxLayoutImageItem;
    sprtr1: TdxLayoutSeparatorItem;
    lgCenter: TdxLayoutGroup;
    procedure actOkExecute(Sender: TObject);
  private
    FEditMode : TFormEditType;
    FTranssProtocol : TItemTranssProtocol;
    FIsInEdit : Boolean;

    procedure FillComponents;
    procedure FillProtocolValues;

    procedure SetControlsReadOnly(pIsReadOnly: Boolean);
  public
    class function CreateAndShowModal(AOwner : TComponent;  AProtocol: TItemTranssProtocol; AEditMode: TFormEditType) : Integer;

    constructor Create(AOwner: TComponent; AProtocol: TItemTranssProtocol; AEditMode: TFormEditType); overload;
  end;

var
  FormTranssProtocolAddEdit: TFormTranssProtocolAddEdit;

implementation

{$R *.dfm}

{ TFormTranssProtocolAddEdit }

procedure TFormTranssProtocolAddEdit.actOkExecute(Sender: TObject);
begin
  if (Self.FEditMode = fetEdit) and (not Self.FISInEdit) then
  begin
    Self.FIsInEdit := True;
    Self.SetControlsReadOnly(Self.FIsInEdit);

    Self.actOk.Caption := 'OK';
    Exit;
  end;

end;

constructor TFormTranssProtocolAddEdit.Create(AOwner: TComponent;
  AProtocol: TItemTranssProtocol; AEditMode: TFormEditType);
begin
  inherited Create(AOwner);

  Self.FEditMode := AEditMode;
  Self.FTranssProtocol := AProtocol;

  case Self.FEditMode of
    fetAddNew: begin
      Self.Caption := 'Dodawanie nowego protoko³u komunikacyjnego';
      Self.actOk.Caption := 'Dodaj';
    end;

    fetEdit: begin
      Self.Caption := 'Edycja protoko³u: ' + Self.FTranssProtocol.Name;
      Self.actOk.Caption := 'Edytuj';
    end;
  end;

  liLblTitle.CaptionOptions.Text := Self.Caption;
  FIsInEdit := Self.FEditMode = fetEdit;
  Self.SetControlsReadOnly(FIsInEdit);
end;

class function TFormTranssProtocolAddEdit.CreateAndShowModal(AOwner: TComponent;
  AProtocol: TItemTranssProtocol; AEditMode: TFormEditType): Integer;
begin

end;

procedure TFormTranssProtocolAddEdit.FillComponents;
begin

end;

procedure TFormTranssProtocolAddEdit.FillProtocolValues;
begin

end;

procedure TFormTranssProtocolAddEdit.SetControlsReadOnly(pIsReadOnly: Boolean);
begin
//
end;

end.
