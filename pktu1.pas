unit pktu1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit,
  System.Net.URLClient,  System.Net.HttpClientComponent,
  FMX.WebBrowser, FMX.StdCtrls, FMX.Layouts, FMX.ScrollBox, FMX.Memo,

   system.ioutils, System.Permissions,
  FMX.Effects,
   System.Actions, FMX.ActnList, System.Net.HttpClient,
   FMX.Memo.Types,
     FMX.Platform.Android, FMX.StdActns, FMX.MediaLibrary.Actions,
    Androidapi.JNI.Embarcadero, Androidapi.JNI.support, Androidapi.JNI.App, Androidapi.JNI.GraphicsContentViewText, Androidapi.helpers,
  Androidapi.JNIBridge, FMX.Helpers.Android, Androidapi.JNI.JavaTypes,
   Androidapi.JNI.Net, FMX.ListBox, FMX.Advertising, FMX.Ani, FMX.MultiView,
    FMX.Platform, FMX.MediaLibrary, System.ImageList, FMX.ImgList,
  FMX.Filter.Effects;

type
  TForm1 = class(TForm)
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Layout1: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    SpeedButton1: TSpeedButton;
   // speedinfo: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton22: TSpeedButton;
    nhttp: TNetHTTPClient;
    ComboEdit1: TComboEdit;
    Label2: TLabel;
    ActionList1: TActionList;
    ShowShareSheetAction1: TShowShareSheetAction;
    GridPanelLayout2: TGridPanelLayout;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Image1: TImage;
    VertScrollBox1: TVertScrollBox;
    MultiView1: TMultiView;
    ToolBar1: TToolBar;
    Label1: TLabel;
    SpeedButton4: TSpeedButton;
    SpeedButton9: TSpeedButton;
    StyleBook1: TStyleBook;
    SpeedButton10: TSpeedButton;
    ImageList1: TImageList;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    Circle1: TCircle;
    FillRGBEffect1: TFillRGBEffect;
    FillRGBEffect2: TFillRGBEffect;
    Label4: TLabel;
    SpeedButton3: TSpeedButton;
    procedure oldhhpValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);

    procedure oldhhpRequestError(const Sender: TObject; const AError: string);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure speedinfoClick(Sender: TObject);
    procedure VertScrollBox1Click(Sender: TObject);
    procedure ComboEdit1ChangeTracking(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
   private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses brows,OpenViewUrl;



procedure openpdf();
var
  LIntent: JIntent;
  LFile: JFile;
  LFileName: string;
begin

       try
        // NOTE: You will need a PDF viewer installed on your device in order for this to work
        LFileName := TPath.Combine(TPath.GetDocumentsPath, UpperCase(trim(form1.ComboEdit1.Text))+'.pdf');
        LFile := TJFile.JavaClass.init(StringToJString(LFileName));
        LIntent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
        LIntent.setDataAndType(TAndroidHelper.JFileToJURI(LFile), StringToJString('application/pdf'));
        LIntent.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
        TAndroidHelper.Activity.startActivity(LIntent);

       form1.ComboEdit1.Items.SaveToFile(TPath.GetDocumentsPath+PathDelim +'fav.txt');
       except
       showmessage('Cant open the file');
       end;
end;



procedure indz();
var
HR : TmemoryStream;
para: Tstringlist;
s:string;
begin


      s:=UpperCase(trim(form1.ComboEdit1.Text));
      HR := TmemoryStream.Create;
      para := Tstringlist.Create;

         try

            para.Add('Codebarre=true');
            para.Add('searchByCustomerReference=false');
            para.Add('oss_languager=fr');
            para.Add('queryToken=2a091ff3-5c32-4bae-81be-56df7775e093');
            para.Add('includeOldItems=false');
            para.Add('itemCodes='+s);
            para.Add('code=azdf');
            para.Add('Rechercher=Rechercher');

           form1.nhttp.Post('https://aptracking.poste.dz/index.php',para);
           try
             form1.nhttp.get('https://aptracking.poste.dz/pdf/imp_tracking.php',HR);
            finally
            if HR.Size>100 then
            begin
              HR.SaveToFile(TPath.GetDocumentsPath+ PathDelim +s+'.pdf');
              openpdf;
            end else showmessage('Failed, please check your internet connection');
           end;


         finally
          HR.Free;
          para.Free ;
          form1.button1.Text:='In Dz';
          form1.button1.Tag:=0;
          form1.Image1.Visible:=false;
          end;

          ///////// add to fav --------------
            if not form1.ComboEdit1.Items.IndexOf(s)>=0 then
           try
           form1.ComboEdit1.Items.Append(s) ;
           finally
           form1.ComboEdit1.Items.SaveToFile(TPath.GetDocumentsPath+PathDelim +'fav.txt');
           end;
           ///////////////-------------------
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
 if (length(ComboEdit1.Text)>6) and (button1.Tag=0) then
     begin
        button1.Tag:=1;
        button1.Text:='......';
        Image1.Visible:=true;
        Timer1.Enabled:=true;
    end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
s:string;
begin

      s:=UpperCase(trim(form1.ComboEdit1.Text));
  if length (ComboEdit1.Text)>6 then
    begin
    form2.webbrowser1.Navigate('https://global.cainiao.com/detail.htm?mailNoList='+s) ;
      if not form1.ComboEdit1.Items.IndexOf(s)>=0 then
       try
       form1.ComboEdit1.Items.Append(s) ;
       finally
       form1.ComboEdit1.Items.SaveToFile(TPath.GetDocumentsPath+PathDelim +'fav.txt');
       end;
     form2.Show;
     end;
end;

procedure TForm1.ComboEdit1ChangeTracking(Sender: TObject);
begin
    ComboEdit1.UpdateEffects;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin

form2.webbrowser1.LoadFromStrings('Searching .....','Home') ;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

 Action:= TCloseAction.caNone;
 MainActivity.moveTaskToBack(true);
end;

procedure TForm1.FormShow(Sender: TObject);
var
s: string;
begin
s:=TPath.GetDocumentsPath+PathDelim +'fav.txt';
if FileExists(s) then ComboEdit1.Items.LoadFromFile(s);
if ComboEdit1.Items.Count>0 then ComboEdit1.Text:=ComboEdit1.Items.Strings[0];
end;

procedure TForm1.oldhhpRequestError(const Sender: TObject; const AError: string);
begin
//donothing
end;

procedure TForm1.oldhhpValidateServerCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const Certificate: TCertificate;
  var Accepted: Boolean);
begin
Accepted:=true;
end;




procedure TForm1.Timer1Timer(Sender: TObject);
begin
timer1.Enabled:=false;
indz();
end;

procedure TForm1.VertScrollBox1Click(Sender: TObject);
begin
button1.SetFocus;
end;

procedure TForm1.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
ShowShareSheetAction1.TextMessage:='https://play.google.com/store/apps/details?id=com.barbary.InDzTracker';
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
OpenURL('https://play.google.com/store/apps/dev?id=9176633282380448986');
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
OpenURL('market://details?id=com.barbary.InDzTracker');
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
begin
ActionList1.Actions[0].Execute;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
 OpenURL('https://www.facebook.com/Barbary.Studio');
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
if ComboEdit1.ItemIndex>=0 then
openpdf;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
OpenURL('https://github.com/soheyb-roukas/InDzTracker');
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
close;
end;

procedure TForm1.speedinfoClick(Sender: TObject);
var
s:string;
begin

s:= trim(ComboEdit1.Text);
  if length(s)>3 then
if  ComboEdit1.Items.IndexOf(s)>=0 then
      try
     DeleteFile(TPath.GetDocumentsPath+PathDelim +s+'.pdf');
     comboedit1.Items.Delete(ComboEdit1.Items.IndexOf(s));
    finally
    ComboEdit1.Items.SaveToFile(TPath.GetDocumentsPath+PathDelim +'fav.txt');
    end;
     ComboEdit1.ItemIndex:=0;

    ComboEdit1.Text:=' ';
    button1.SetFocus;
end;

end.
