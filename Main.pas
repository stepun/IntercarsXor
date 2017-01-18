unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    ProgressBar1: TProgressBar;
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure decoder( const AName: String );
type
  PByteArray = Array of Byte;
var
  ii: Integer;
  y: Integer;
begin
  with TMemoryStream.Create do
  try
    LoadFromFile( AName );
    if (UpperCase(ExtractFileName(AName)) <> 'I_STA.DBF') then
    begin
    for ii := 0 to Size - 1 do
       PByteArray( Memory )[ ii ] := PByteArray( Memory )[ ii ] xor 65 {p};
    end;
    createDir('decoded');
    SaveToFile( ChangeFileExt( 'decoded\'+AName, '.dbf' ));

  finally
    Free;
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
var
  SR: TSearchRec;
begin
Form1.ProgressBar1.Min := 1;
Form1.ProgressBar1.Max := 35;
Form1.ProgressBar1.Step := 1;
Form1.ProgressBar1.StepBy(1);
if FindFirst('*.dbf', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        decoder(SR.Name);
        Form1.ProgressBar1.StepIt;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
  Form1.ProgressBar1.StepBy(35);
  ShowMessage('Decoded completed!');
end;

end.
