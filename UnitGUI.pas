unit UnitGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB
  , ICDsearcher
  ;

type
  TApplicationGUIForm = class(TForm)
    lbCriteria: TLabel;
    edCriteria: TEdit;
    btSearch: TButton;
    cbLng: TComboBox;
    lbResults: TLabel;
    memoResults: TMemo;
    lbNResults: TLabel;
    edNResults: TEdit;
    lbxResults: TListBox;
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbxResultsClick(Sender: TObject);
  private
    { Déclarations privées }
    FSearcher: TICDSearcher;
    function getLngChoosen: string;
  public
    { Déclarations publiques }
  end;

var
  ApplicationGUIForm: TApplicationGUIForm;

implementation

uses
  ICDrecord;

{$R *.dfm}

procedure TApplicationGUIForm.btSearchClick(Sender: TObject);
var
  vnRecords: integer;
  vCriteria: string;
  vCode: string;
  vLng: string;
  vRec: TICDRecord;
begin
  lbxResults.Items.Clear;
  vLng := getLngChoosen;
  vnRecords := strtoint(edNResults.Text);
  vCriteria := edCriteria.Text;

  FSearcher.criteria := vCriteria;
  FSearcher.lng := vLng;
  FSearcher.top := vnRecords;

  FSearcher.ComputeResult;
  for vRec in FSearcher.results do
  begin
    lbxResults.AddItem(vRec.codeICD10, vRec);
  end;
end;

procedure TApplicationGUIForm.FormCreate(Sender: TObject);
begin
  FSearcher := TICDSearcher.Create('choléra', 'FR_DESCRIPTION', 10);
end;

procedure TApplicationGUIForm.FormDestroy(Sender: TObject);
begin
  FSearcher.Free;
end;

function TApplicationGUIForm.getLngChoosen: string;
begin
  if cbLng.ItemIndex = 0 then
  begin
    result := 'FR_DESCRIPTION';
  end
  else
  begin
    result := 'NL_DESCRIPTION';
  end;
end;

procedure TApplicationGUIForm.lbxResultsClick(Sender: TObject);
var
  vcode: string;
  vDescription: string;
  vLng: string;
  vmes: string;
begin
  vcode := FSearcher.results.Items[lbxResults.ItemIndex].codeICD10;
  vLng := getLngChoosen;
  if vLng = 'FR_DESCRIPTION' then
    vDescription := FSearcher.results.Items[lbxResults.ItemIndex].frDescription
  else
    vDescription := FSearcher.results.Items[lbxResults.ItemIndex].nlDescription;
  vmes := format('code %s = %s',[vcode, vDescription]);
  showmessage(vmes);
end;

end.
