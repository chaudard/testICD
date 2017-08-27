unit ICDsearcher;

interface

uses
  ADODB,
  generics.collections,
  ICDrecord;

type TICDSearcher = class
  private
    FADOquery: TADOQuery;
    FCriteria: string;
    FLng: string;
    FTop: integer;
    FResults: TList<TICDRecord>;
  published
    property adoQuery: TADOQuery read FADOquery write FADOquery;
    property criteria: string read FCriteria write FCriteria;
    property lng: string read FLng write FLng;
    property top: integer read FTop write FTop;
    property results: TList<TICDRecord> read FResults write FResults;
  public
    constructor Create; overload;
    constructor Create(const aADOquery: TADOQuery;
                       const aCriteria: string;
                       const aLng: string;
                       const aTop: integer); overload;
    destructor  Destroy; override;
    procedure   ClearResults;
    procedure   ComputeResult;
  public
end;

implementation

uses
  sysUtils;

{ TICDSearcher }

constructor TICDSearcher.Create;
begin
  aDOquery := nil;
  criteria := '';
  lng := '';
  top := 1;
  results := TList<TICDRecord>.Create;
end;

constructor TICDSearcher.Create(const aADOquery: TADOQuery;
  const aCriteria: string;
  const aLng: string;
  const aTop: integer);
begin
  aDOquery := aADOquery;
  if assigned(aDOquery) then
  begin
    aDOquery.ConnectionString :=
    'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=testICD;Data Source=DEV-DANY';
  end;
  criteria := aCriteria;
  lng := aLng;
  top := aTop;
  results := TList<TICDRecord>.Create;
end;

destructor TICDSearcher.Destroy;
begin
  ClearResults;
  FResults.Free;
  inherited;
end;

procedure TICDSearcher.ClearResults;
var
  i: Integer;
begin
  for i := 0 to FResults.count - 1 do
    FResults.Items[i].Free;
  FResults.Clear;
end;

procedure TICDSearcher.ComputeResult;
const
  cQuery: string = 'SELECT TOP %d * FROM ICD_10 WHERE %s LIKE %s';
var
  vCode: string;
  vFrDes: string;
  vNlDes: string;
  vICDRecord: TICDRecord;
begin
  ClearResults;
  aDOQuery.SQL.Text := format(cQuery, [top, lng, QuotedStr(criteria+'%')]);
  aDOQuery.Open;
  aDOQuery.First;
  while not aDOQuery.Eof do
  begin
    vCode := aDOQuery.FieldByName('ICD_10_CODE').AsString;
    vFrDes := aDOQuery.FieldByName('FR_DESCRIPTION').AsString;
    vnLDes := aDOQuery.FieldByName('NL_DESCRIPTION').AsString;
    vICDRecord := TICDRecord.Create(vCode, vFrDes, vNlDes);
    results.Add(vICDRecord);
    aDOQuery.Next;
  end;
end;


end.
