unit frmBaseList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxLayoutControlAdapters, Vcl.Menus,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, cxButtons, dxLayoutContainer,
  cxClasses, dxBar, System.ImageList, Vcl.ImgList, cxImageList, dxLayoutControl,
  dxSkinsCore, dxSkinBasic, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxBarEditItem;

type
  TFormBaseList = class(TFormBase)
    liGrid: TdxLayoutItem;
    gGridListLevel1: TcxGridLevel;
    gGridList: TcxGrid;
    sprtrTop: TdxLayoutSeparatorItem;
    barmngMainBar1: TdxBar;
    btnRefresh: TdxBarLargeButton;
    actRefresh: TAction;
    actSearch: TAction;
    btnSearch: TdxBarLargeButton;
    baredtFilter: TcxBarEditItem;
    gGridListTableView1: TcxGridTableView;
    procedure actRefreshExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  FormBaseList: TFormBaseList;

implementation

uses
  cHelpFunctions;

{$R *.dfm}

procedure TFormBaseList.actRefreshExecute(Sender: TObject);
begin
//
end;

procedure TFormBaseList.actSearchExecute(Sender: TObject);
begin
//
end;

constructor TFormBaseList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  THelpFunctions.SetGridDefaultOptions(Self.gGridListTableView1);
end;

end.
