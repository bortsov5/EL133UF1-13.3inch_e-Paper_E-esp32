unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.JSON,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar,
  Vcl.ExtCtrls, Math, cxSplitter, cxCheckBox, HTTPSend, WinInet, synacode,
  SuperObject, rfJson, cxMemo, synautil, dxSkinsdxStatusBarPainter, dxStatusBar,
  cxMaskEdit, cxDropDownEdit, cxColorComboBox, DiscordApi, Vcl.OleCtrls,
  SHDocVw, uCEFWorkScheduler, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,
  cxPC, uCEFWinControl, uCEFLinkedWinControlBase, JPEG, cxTextEdit, ssl_openssl,
  uCEFChromium, uCEFWindowParent, uCEFTypes, uCEFConstants, uCEFInterfaces,
  uCEFChromiumCore, uCEFChromiumWindow, Registry, System.Threading, cxImage,
  System.Actions, Vcl.ActnList, Vcl.ImgList, cxImageList, dxSkinLilian,
  Vcl.PlatformDefaultStyleActnCtrls, IdCoder, IdCoderMIME, IdGlobal,
  dxSkinsCore, Vcl.Menus, cxClasses, dxSkinsForm, cxButtons, dxBar, dxBarExtItems,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, cxBarEditItem, dxSkinDevExpressDarkStyle;

type
  TGetRequestThread = class(TThread)
  private
    FURL: string;
    FResponse: string;
    FOnComplete: TNotifyEvent;
  protected
    procedure Execute; override;
    procedure DoOnComplete;
  public
    constructor Create(const AURL: string; AOnComplete: TNotifyEvent);
  end;

type
  PRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = array [0 .. 0] of TRGBQuad;

type
  TForm2 = class(TForm)
    OpenDialog1: TOpenDialog;
    cxSplitter1: TcxSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Image3: TImage;
    Image2: TImage;
    cxSplitter2: TcxSplitter;
    cxSplitter3: TcxSplitter;
    dxSkinController1: TdxSkinController;
    Timer1: TTimer;
    dxStatusBar1: TdxStatusBar;
    cxButton2: TcxButton;
    cxPageControl1: TPanel;
    Timer2: TTimer;
    Chromium1: TChromium;
    CEFWindowParent1: TCEFWindowParent;
    cxButton4: TcxButton;
    TimerRun: TTimer;
    TimUpdateRun: TTimer;
    TimerRun2: TTimer;
    PopupMenu1: TPopupMenu;
    pexelscom1: TMenuItem;
    nealfun1: TMenuItem;
    N1: TMenuItem;
    pexelscomid1: TMenuItem;
    Panel4: TPanel;
    pexelscomviev1: TMenuItem;
    N2: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    pexelscomviev101: TMenuItem;
    Action5: TAction;
    ilLarge: TcxImageList;
    cxSplitter4: TcxSplitter;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    cxBar60s: TcxBarEditItem;
    N3: TMenuItem;
    N4: TMenuItem;
    cxChFloydSteinberg: TcxBarEditItem;
    cxChDitheringRiemersma: TcxBarEditItem;
    Panel5: TPanel;
    cxLog: TcxMemo;
    cxCBnotText: TcxCheckBox;
    Panel6: TPanel;
    cxCbBW: TcxBarEditItem;
    dxBarStatic1: TdxBarStatic;
    cxChJ2000: TcxBarEditItem;
    cxChJ2001: TcxBarEditItem;
    Panel7: TPanel;
    cxProgressBar1: TcxProgressBar;
    cxCheckBox3: TcxCheckBox;
    cxColorComboBox1: TcxColorComboBox;
    Panel8: TPanel;
    Image1: TImage;
    CheckBox1: TcxCheckBox;
    dxBarStatic2: TdxBarStatic;
    CheckBox2: TCheckBox;
    edHost: TdxBarEdit;
    dxBarClear: TdxBarButton;
    ButUpl: TdxBarButton;
    dxBarButShow: TdxBarButton;
    dxBarStatic3: TdxBarStatic;
    procedure Button1Click(Sender: TObject);
    procedure UploadFFile(fp: String);
    procedure Imstop();
    procedure FloydSteinbergDither(Bitmap: TBitmap);
    procedure SendFile(url_media, fn, sfn, path: string);
    procedure RequestCompleted(Sender: TObject);
    procedure ShowMessageF(S: string);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure cxCheckBox2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

    procedure Chromium1AfterCreated(Sender: TObject;
      const browser: ICefBrowser);
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1BeforePopup(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; popup_id: Integer;
      const targetUrl, targetFrameName: ustring;
      targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
      const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
      var client: ICefClient; var settings: TCefBrowserSettings;
      var extra_info: ICefDictionaryValue; var noJavascriptAccess: Boolean;
      var Result: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cxButton4Click(Sender: TObject);
    procedure LoadFromRegistry;
    procedure SaveToRegistry;
    procedure TimerRunTimer(Sender: TObject);
    procedure TimUpdateRunTimer(Sender: TObject);
    procedure imPaint(fn: string);
    procedure TimerRun2Timer(Sender: TObject);
    function FileToBase64(const AFileName: string): string;
    procedure LoadImageFromDisk(const AImagePath: string);
    procedure pexelscom1Click(Sender: TObject);
    procedure nealfun1Click(Sender: TObject);
    procedure pexelscomid1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure UpdateImagePosition;
    procedure SetScale(AScale: Double);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function LoadImageFromURLToBitmap(const AURL: string): Boolean;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure cxBarEditItem1PropertiesChange(Sender: TObject);
    procedure dxBarClearClick(Sender: TObject);
    procedure ButUplClick(Sender: TObject);
    procedure dxBarButShowClick(Sender: TObject);
  private
    { Private declarations }
    Data: TBytes;

    FCanClose: Boolean;
    FClosing: Boolean;
    FScale: Double;
    FDragging: Boolean;
    FStartPos: TPoint;
    FImageStartPos: TPoint;
    flstop: Boolean;

    procedure BrowserCreatedMsg(var aMessage: TMessage);
      message CEF_AFTERCREATED;
    procedure WMMove(var aMessage: TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage: TMessage); message WM_MOVING;
    procedure WMEnterMenuLoop(var aMessage: TMessage); message WM_ENTERMENULOOP;
    procedure WMExitMenuLoop(var aMessage: TMessage); message WM_EXITMENULOOP;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

procedure CreateGlobalCEFApp;

implementation

{$R *.dfm}

uses
  uCEFApplication;

const

  Cname = 'E-inc screen loader';
  RegistryPath = 'Software\EIncWeb\Settings';
  // Определяем палитру как массив байтов
  palette: array [0 .. 5] of array [0 .. 2] of Byte = ((0, 0, 0), // ч         0
    (255, 255, 255), // б        1
    (255, 243, 56), // ж         2
    (191, 0, 0), // r         3
    (100, 64, 255), // b         6
    (67, 138, 28) // g         5
    );

  palette2: array [0 .. 6] of array [0 .. 2] of Byte = ((0, 0, 0),
    // ч         0
    (255, 255, 255), // б        1
    (255, 243, 56), // ж         2
    (191, 0, 0), // r         3
    (120, 120, 120), (100, 64, 255), // b         5
    (67, 138, 28) // g         6
    );

  Colors: array [0 .. 5] of TColor = (clBlack, clWhite, clYellow, clRed,
    clBlue, clGreen);

var
  JsObject: ISuperObject;
  flSw: Boolean;
  fng: String;
  imcnt: Int64;

procedure GlobalCEFApp_OnScheduleMessagePumpWork(const aDelayMS: Int64);
begin
  if (GlobalCEFWorkScheduler <> nil) then
    GlobalCEFWorkScheduler.ScheduleMessagePumpWork(aDelayMS);
end;

procedure CreateGlobalCEFApp;
begin
  GlobalCEFWorkScheduler := TCEFWorkScheduler.Create(nil);
  GlobalCEFApp := TCefApplication.Create;
  GlobalCEFApp.ExternalMessagePump := True;
  GlobalCEFApp.MultiThreadedMessageLoop := False;
  GlobalCEFApp.OnScheduleMessagePumpWork :=
    GlobalCEFApp_OnScheduleMessagePumpWork;
end;

constructor TGetRequestThread.Create(const AURL: string;
  AOnComplete: TNotifyEvent);
begin
  inherited Create(True); // Создаем поток в приостановленном состоянии
  FURL := AURL;
  FOnComplete := AOnComplete;
  FreeOnTerminate := True; // Освобождаем поток автоматически после завершения
end;

procedure TGetRequestThread.Execute;
var
  http: THTTPSend;
  res: Boolean;
begin
  http := THTTPSend.Create;
  try
    try
      res := http.HTTPMethod('GET', FURL);
    except
      on E: Exception do
        FResponse := 'Error: ' + E.Message; // Обработка ошибок
    end;
  finally
    http.Free;
  end;

  Synchronize(DoOnComplete);
end;

procedure TGetRequestThread.DoOnComplete;
begin
  if Assigned(FOnComplete) then
    FOnComplete(Self);
end;

function Depalette(R, G, B: Byte): Integer;
var
  p: Integer;
  mindiff: Integer;
  bestc: Integer;
  diffr, diffg, diffb, diff: Integer;
begin
  mindiff := MaxInt; // Инициализируем минимальную разницу
  bestc := 0; // Инициализируем лучший цвет
  for p := 0 to High(palette) do
  begin
    // Вычисляем разницу по компонентам
    diffr := Integer(R) - Integer(palette[p][0]);
    diffg := Integer(G) - Integer(palette[p][1]);
    diffb := Integer(B) - Integer(palette[p][2]);
    // Вычисляем квадратичную разницу
    diff := (diffr * diffr) + (diffg * diffg) + (diffb * diffb);

    // Если текущая разница меньше минимальной, обновляем
    if diff < mindiff then
    begin
      mindiff := diff;
      // Определяем индекс лучшего цвета
      if p > 3 then
        bestc := p + 1
      else
        bestc := p;
    end;
  end;
  Result := bestc; // Возвращаем индекс лучшего цвета
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  Bitmap, BitmapConv: TBitmap;
  Color: TColor;
  ColorString: string;
  i, j, X, Y, N: Integer;
  c1, c2: Integer;
  uc: Byte;

  z: Integer;
begin
  if OpenDialog1.Execute then
  begin
    Bitmap := TBitmap.Create;
    BitmapConv := TBitmap.Create;

    try
      Bitmap.LoadFromFile(OpenDialog1.FileName);

      cxLog.Clear;
      X := Bitmap.Width;
      Y := Bitmap.Height;

      cxProgressBar1.Properties.Max := Y;

      BitmapConv.PixelFormat := pf24bit;
      BitmapConv.Width := X;
      BitmapConv.Height := Y;

      // Проходим по всем пикселям изображения
      ColorString := Format('//Width %d Height %d' + sLineBreak, [X, Y]);
      ColorString := ColorString +
        Format('const unsigned char Image6color[%d] = {' + sLineBreak,
        [X * Y div 2]);
      z := 0;
      for j := 0 to Y - 1 do // Height
      begin
        for i := 0 to (X div 2) - 1 do // Width
        begin
          // Color := Bitmap.Canvas.Pixels[x, y];
          c1 := Depalette(Bitmap.Canvas.Pixels[i * 2, j] and $FF,
            (Bitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
            (Bitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
          c2 := Depalette(Bitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
            (Bitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
            (Bitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

          BitmapConv.Canvas.Pixels[i * 2, j] :=
            RGB(palette2[c1][0], palette2[c1][1], palette2[c1][2]);
          // palette[c1];
          BitmapConv.Canvas.Pixels[i * 2 + 1, j] :=
            RGB(palette2[c2][0], palette2[c2][1], palette2[c2][2]);;

          ColorString := ColorString + '0x' + IntToStr(c1) + '' +
            IntToStr(c2) + ',';

          z := z + 1;

          if (z > 9) then
          begin
            ColorString := ColorString + #13;
            z := 0;
          end;

        end;

        cxProgressBar1.Position := j + 1;
        Application.ProcessMessages;
      end;

      // Удаляем последний символ запятой
      if ColorString.Length > 0 then
        ColorString := ColorString.Substring(0, ColorString.Length - 1);
      ColorString := ColorString + '};';

      // Выводим строку в Memo
      cxLog.lines.Text := ColorString;

    finally
      Bitmap.Free;
      Image1.Picture.Assign(BitmapConv);
      BitmapConv.Free;
    end;
  end;
end;

procedure RotateBitmap90CW(b1, b2: TBitmap);
var
  X, Y: Integer;
  p: array [0 .. 2] of TPoint;
begin
  X := b1.Width;
  Y := b1.Height;
  b2.Width := Y;
  b2.Height := X;
  p[0].X := Y;
  p[0].Y := 0;
  p[1].X := Y;
  p[1].Y := X;
  p[2].X := 0;
  p[2].Y := 0;
  PlgBlt(b2.Canvas.Handle, p, b1.Canvas.Handle, 0, 0, X, Y, 0, 0, 0);
end;

function HexToByte(const HexStr: string): Byte;
begin
  if (Length(HexStr) <> 4) or (Copy(HexStr, 1, 2) <> '0x') then
    Result := $11
  else
    Result := StrToInt('$' + Copy(HexStr, 3, 2));
end;

function ConvertImageToTargetSize(const FileName: string;
  cutSize: Boolean = False): TBitmap;
var
  Picture: TPicture;
  SourceBitmap: TBitmap;
  TargetWidth, TargetHeight: Integer;
  SourceRatio, TargetRatio: Double;
  Scale: Double;
  NewWidth, NewHeight: Integer;
  DestRect: TRect;
  JpegImage: TJPEGImage;
  Orientation: Integer;
begin
  Result := nil;
  Picture := TPicture.Create;
  try
    Picture.LoadFromFile(FileName);

    SourceBitmap := TBitmap.Create;
    try
      SourceBitmap.Assign(Picture.Graphic);
      SourceBitmap.PixelFormat := pf24bit;

      SourceRatio := SourceBitmap.Width / SourceBitmap.Height;
      TargetRatio := 1600 / 1200; // Соотношение 4:3

      if SourceRatio >= TargetRatio then
      begin
        // Альбомная ориентация
        TargetWidth := 1600;
        TargetHeight := 1200;
      end
      else
      begin
        // Портретная ориентация
        TargetWidth := 1200;
        TargetHeight := 1600;
      end;

      Result := TBitmap.Create;
      Result.Width := TargetWidth;
      Result.Height := TargetHeight;
      Result.PixelFormat := pf32bit;

      // Заливаем фон
      Result.Canvas.Brush.Color := Form2.cxColorComboBox1.colorValue;
      Result.Canvas.FillRect(Rect(0, 0, TargetWidth, TargetHeight));

      if cutSize then
      begin
        // Обрезаем изображение
        Scale := Max(TargetWidth / SourceBitmap.Width,
          TargetHeight / SourceBitmap.Height);
        NewWidth := Round(SourceBitmap.Width * Scale);
        NewHeight := Round(SourceBitmap.Height * Scale);

        // Позиционируем по центру
        DestRect := Rect((TargetWidth - NewWidth) div 2,
          (TargetHeight - NewHeight) div 2, (TargetWidth - NewWidth) div 2 +
          NewWidth, (TargetHeight - NewHeight) div 2 + NewHeight);
      end
      else
      begin
        // Вычисляем масштабирование
        Scale := Min(TargetWidth / SourceBitmap.Width,
          TargetHeight / SourceBitmap.Height);
        NewWidth := Round(SourceBitmap.Width * Scale);
        NewHeight := Round(SourceBitmap.Height * Scale);

        // Позиционируем по центру
        DestRect := Rect((TargetWidth - NewWidth) div 2,
          (TargetHeight - NewHeight) div 2, (TargetWidth - NewWidth) div 2 +
          NewWidth, (TargetHeight - NewHeight) div 2 + NewHeight);
      end;

      // Настройка качества растягивания
      SetStretchBltMode(Result.Canvas.Handle, HALFTONE);
      SetBrushOrgEx(Result.Canvas.Handle, 0, 0, nil);

      // Рисуем масштабированное изображение
      Result.Canvas.StretchDraw(DestRect, SourceBitmap);
    finally
      SourceBitmap.Free;
    end;

  finally
    Picture.Free;
  end;
end;

procedure TForm2.UploadFFile(fp: String);
var
  Bitmap, BitmapConv, LeftBitmap, RightBitmap: TBitmap;
  X, Y, z, j, i: Integer;
  ColorString: String;
  c1, c2: Integer;
  z_pos: Integer;
begin
  flSw := True;

  Bitmap := TBitmap.Create;
  LeftBitmap := TBitmap.Create;
  RightBitmap := TBitmap.Create;
  SetLength(Data, 1200 * 1600);
  z_pos := 0;

  try
    Bitmap := ConvertImageToTargetSize(fp);

    if cxChFloydSteinberg.EditValue then
      FloydSteinbergDither(Bitmap);

    X := Bitmap.Width;
    Y := Bitmap.Height;

    // Проверяем размеры изображения
    if X > Y then
    begin
      // Поворачиваем изображение на 90 градусов
      BitmapConv := TBitmap.Create;
      try
        BitmapConv.Width := Y;
        BitmapConv.Height := X;
        RotateBitmap90CW(Bitmap, BitmapConv);
        Bitmap.Assign(BitmapConv);
      finally
        BitmapConv.Free;
      end;
    end;

    Image1.Picture.Assign(Bitmap);

    LeftBitmap.Width := Bitmap.Width div 2;
    LeftBitmap.Height := Bitmap.Height;
    RightBitmap.Width := Bitmap.Width div 2;
    RightBitmap.Height := Bitmap.Height;

    BitmapConv := TBitmap.Create;
    BitmapConv.PixelFormat := pf24bit;
    BitmapConv.Width := X div 2;
    BitmapConv.Height := Y;

    LeftBitmap.Canvas.CopyRect(Rect(0, 0, LeftBitmap.Width, LeftBitmap.Height),
      Bitmap.Canvas, Rect(0, 0, LeftBitmap.Width, Bitmap.Height));

    RightBitmap.Canvas.CopyRect(Rect(0, 0, RightBitmap.Width,
      RightBitmap.Height), Bitmap.Canvas, Rect(LeftBitmap.Width, 0,
      Bitmap.Width, Bitmap.Height));

    cxLog.Clear;
    X := LeftBitmap.Width;
    Y := LeftBitmap.Height;

    BitmapConv.Width := LeftBitmap.Width;
    BitmapConv.Height := LeftBitmap.Height;

    cxProgressBar1.Properties.Max := Y;

    ColorString := Format('//Width %d Height %d' + sLineBreak, [X, Y]);
    ColorString := ColorString +
      Format('const unsigned char Image6colorL[%d] = {' + sLineBreak,
      [X * Y div 2]);
    z := 0;
    for j := 0 to Y - 1 do // Height
    begin
      for i := 0 to (X div 2) - 1 do // Width
      begin
        c1 := Depalette(LeftBitmap.Canvas.Pixels[i * 2, j] and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
        c2 := Depalette(LeftBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

        BitmapConv.Canvas.Pixels[i * 2, j] :=
          RGB(palette2[c1][0], palette2[c1][1], palette2[c1][2]);
        BitmapConv.Canvas.Pixels[i * 2 + 1, j] :=
          RGB(palette2[c2][0], palette2[c2][1], palette2[c2][2]);;

        ColorString := ColorString + '0x' + IntToStr(c1) + '' +
          IntToStr(c2) + ',';
        Data[z_pos] := HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));
        z_pos := z_pos + 1;

        z := z + 1;

        if (z > 19) then
        begin
          ColorString := ColorString + #13;
          z := 0;
        end;

      end;

      cxProgressBar1.Position := j + 1;
      Application.ProcessMessages;
    end;

    if ColorString.Length > 0 then
      ColorString := ColorString.Substring(0, ColorString.Length - 2);
    ColorString := ColorString + '};';

    Image2.Picture.Assign(BitmapConv);

    // -------------
    X := RightBitmap.Width;
    Y := RightBitmap.Height;

    cxProgressBar1.Properties.Max := Y;

    ColorString := ColorString + #13 + #13 + #13 +
      Format('//Width %d Height %d' + sLineBreak, [X, Y]);
    ColorString := ColorString +
      Format('const unsigned char Image6colorR[%d] = {' + sLineBreak,
      [X * Y div 2]);
    z := 0;
    for j := 0 to Y - 1 do // Height
    begin
      for i := 0 to (X div 2) - 1 do // Width
      begin
        c1 := Depalette(RightBitmap.Canvas.Pixels[i * 2, j] and $FF,
          (RightBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
          (RightBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
        c2 := Depalette(RightBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
          (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
          (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

        BitmapConv.Canvas.Pixels[i * 2, j] :=
          RGB(palette2[c1][0], palette2[c1][1], palette2[c1][2]);
        BitmapConv.Canvas.Pixels[i * 2 + 1, j] :=
          RGB(palette2[c2][0], palette2[c2][1], palette2[c2][2]);;

        ColorString := ColorString + '0x' + IntToStr(c1) + '' +
          IntToStr(c2) + ',';

        Data[z_pos] := HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));
        z_pos := z_pos + 1;

        z := z + 1;

        if (z > 19) then
        begin
          ColorString := ColorString + #13;
          z := 0;
        end;

      end;

      cxProgressBar1.Position := j + 1;
      Application.ProcessMessages;
    end;

    // Удаляем последний символ запятой
    if ColorString.Length > 0 then
      ColorString := ColorString.Substring(0, ColorString.Length - 2);
    ColorString := ColorString + '};';

    // Выводим строку в Memo
    cxLog.lines.Text := ColorString;
    Image3.Picture.Assign(BitmapConv);

  finally
    Bitmap.Free;
    LeftBitmap.Free;
    RightBitmap.Free;
    BitmapConv.Free;

    ButUpl.Enabled := True;
  end;
  flSw := False;
  dxBarClear.Click;
end;

procedure DitheringRiemersma(Bitmap: TBitmap);
type
  TError = record
    R, G, B: Single;
  end;

  PError = ^TError;

  TRGBTriple = packed record
    B, G, R: Byte;
  end;

  PRGBTriple = ^TRGBTriple;

  TRGBTripleArray = array [0 .. 0] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;

const
MODIFIED_COEFFS:
array [0 .. 11] of record dx, dy: Integer;
weight:
Single;
end
= ((dx: 1; dy: 0; weight: 0.25), (dx: - 1; dy: 1; weight: 0.25), (dx: 0; dy: 1;
  weight: 0.2), (dx: 1; dy: 1; weight: 0.1), (dx: 2; dy: 0; weight: 0.05),
  (dx: - 2; dy: 1; weight: 0.05), (dx: - 1; dy: 2; weight: 0.03), (dx: 0; dy: 2;
  weight: 0.03), (dx: 1; dy: 2; weight: 0.02), (dx: 2; dy: 1; weight: 0.02),
  (dx: - 1; dy: 0; weight: 0.01), (dx: 0; dy: - 1; weight: 0.01));

BALANCED_COEFFS:
array [0 .. 7] of record dx, dy: Integer;
weight:
Single;
end
= ((dx: 1; dy: 0; weight: 0.3), // Основное право
  (dx: - 1; dy: 1; weight: 0.25), // Диагональ влево-вниз
  (dx: 0; dy: 1; weight: 0.2), // Прямо вниз
  (dx: 1; dy: 1; weight: 0.15), // Диагональ вправо-вниз
  (dx: - 2; dy: 0; weight: 0.05), // Слабое влияние влево
  (dx: 0; dy: 2; weight: 0.03), // Очень слабое вниз через строку
  (dx: - 1; dy: 0; weight: 0.01), // Минимальное влево
  (dx: 1; dy: - 1; weight: 0.01) // Обратное направление
  );

function Clamp(Value, Min, Max: Integer): Integer;
begin
  if Value < Min then
    Result := Min
  else if Value > Max then
    Result := Max
  else
    Result := Value;
end;

function QuantizeMono(Color: TRGBTriple): TRGBTriple;
begin
  if (Color.R + Color.G + Color.B) div 3 > 128 then
  begin
    Result.R := 255;
    Result.G := 255;
    Result.B := 255;
  end
  else
  begin
    Result.R := 0;
    Result.G := 0;
    Result.B := 0;
  end;
end;

function QuantizeColor(Color: TRGBTriple): TRGBTriple;
begin
  if Color.R > 118 then
    Result.R := 255
  else
    Result.R := 0;
  if Color.G > 118 then
    Result.G := 255
  else
    Result.G := 0;
  if Color.B > 118 then
    Result.B := 255
  else
    Result.B := 0;
end;

var
  X, Y, i, Width, Height: Integer;
  CurrentErrors, NextErrors: array of TError;
  Row: PRGBTripleArray;
  OldColor, NewColor: TRGBTriple;
  ErrR, ErrG, ErrB: Single;
  IsEvenLine: Boolean;

begin
  if not Assigned(Bitmap) or Bitmap.Empty then
    Exit;

  Bitmap.PixelFormat := pf24bit;
  Width := Bitmap.Width;
  Height := Bitmap.Height;

  SetLength(CurrentErrors, Width + 4);
  SetLength(NextErrors, Width + 4);

  for Y := 0 to Height - 1 do
  begin
    IsEvenLine := (Y mod 2) = 0;
    Row := Bitmap.ScanLine[Y];

    if IsEvenLine then
    begin
      // Обработка слева-направо
      for X := 0 to Width - 1 do
      begin
        OldColor := Row[X];
        OldColor.R := Clamp(Round(OldColor.R + CurrentErrors[X].R), 0, 255);
        OldColor.G := Clamp(Round(OldColor.G + CurrentErrors[X].G), 0, 255);
        OldColor.B := Clamp(Round(OldColor.B + CurrentErrors[X].B), 0, 255);

        if Form2.cxCbBW.EditValue then
          NewColor := QuantizeMono(OldColor)
        else
          NewColor := QuantizeColor(OldColor);

        Row[X] := NewColor;

        ErrR := OldColor.R - NewColor.R;
        ErrG := OldColor.G - NewColor.G;
        ErrB := OldColor.B - NewColor.B;

        for i := 0 to High(MODIFIED_COEFFS) do
        begin
          with MODIFIED_COEFFS[i] do
          begin
            if (X + dx >= 0) and (X + dx < Width) and (Y + dy >= 0) and
              (Y + dy < Height) then
            begin
              if dy = 0 then
              begin
                CurrentErrors[X + dx].R := CurrentErrors[X + dx].R +
                  ErrR * weight;
                CurrentErrors[X + dx].G := CurrentErrors[X + dx].G +
                  ErrG * weight;
                CurrentErrors[X + dx].B := CurrentErrors[X + dx].B +
                  ErrB * weight;
              end
              else if dy > 0 then
              begin
                NextErrors[X + dx].R := NextErrors[X + dx].R + ErrR * weight;
                NextErrors[X + dx].G := NextErrors[X + dx].G + ErrG * weight;
                NextErrors[X + dx].B := NextErrors[X + dx].B + ErrB * weight;
              end;
            end;
          end;
        end;

        CurrentErrors[X] := Default (TError);
      end;
    end
    else
    begin
      // Обработка справа-налево
      for X := Width - 1 downto 0 do
      begin
        OldColor := Row[X];
        OldColor.R := Clamp(Round(OldColor.R + CurrentErrors[X].R), 0, 255);
        OldColor.G := Clamp(Round(OldColor.G + CurrentErrors[X].G), 0, 255);
        OldColor.B := Clamp(Round(OldColor.B + CurrentErrors[X].B), 0, 255);

        if Form2.cxCbBW.EditValue then
          NewColor := QuantizeMono(OldColor)
        else
          NewColor := QuantizeColor(OldColor);

        Row[X] := NewColor;

        ErrR := OldColor.R - NewColor.R;
        ErrG := OldColor.G - NewColor.G;
        ErrB := OldColor.B - NewColor.B;

        for i := 0 to High(MODIFIED_COEFFS) do
        begin
          with MODIFIED_COEFFS[i] do
          begin
            if (X - dx >= 0) and (X - dx < Width) and (Y + dy >= 0) and
              (Y + dy < Height) then
            begin
              if dy = 0 then
              begin
                CurrentErrors[X - dx].R := CurrentErrors[X - dx].R +
                  ErrR * weight;
                CurrentErrors[X - dx].G := CurrentErrors[X - dx].G +
                  ErrG * weight;
                CurrentErrors[X - dx].B := CurrentErrors[X - dx].B +
                  ErrB * weight;
              end
              else if dy > 0 then
              begin
                NextErrors[X - dx].R := NextErrors[X - dx].R + ErrR * weight;
                NextErrors[X - dx].G := NextErrors[X - dx].G + ErrG * weight;
                NextErrors[X - dx].B := NextErrors[X - dx].B + ErrB * weight;
              end;
            end;
          end;
        end;

        CurrentErrors[X] := Default (TError);
      end;
    end;

    // Перенос ошибок для следующей строки
    if Y < Height - 1 then
    begin
      CurrentErrors := Copy(NextErrors, 0, Length(CurrentErrors));
      FillChar(NextErrors[0], Length(NextErrors) * SizeOf(TError), 0);
    end;
  end;
end;

procedure DitheringRiemersma_old(Bitmap: TBitmap);
type
  TError = record
    R, G, B: Single;
  end;

  PRGBTriple = ^TRGBTriple;

  TRGBTriple = packed record
    B, G, R: Byte;
  end;

  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array [0 .. 4095] of TRGBTriple;
const
  // Коэффициенты распространения ошибки Римерсма (упрощенный набор)
RIEMERSMA_COEFFS:
array [0 .. 15] of record dx, dy: Integer;
weight:
Single;
end
= ((dx: 1; dy: 0; weight: 0.4375), (dx: 2; dy: 0; weight: 0.1875), (dx: - 1;
  dy: 1; weight: 0.125), (dx: 0; dy: 1; weight: 0.0625), (dx: 1; dy: 1;
  weight: 0.03125), (dx: 2; dy: 1; weight: 0.015625), (dx: - 2; dy: 2;
  weight: 0.0078125), (dx: - 1; dy: 2; weight: 0.00390625), (dx: 0; dy: 2;
  weight: 0.001953125), (dx: 1; dy: 2; weight: 0.0009765625), (dx: 2; dy: 2;
  weight: 0.00048828125), (dx: - 2; dy: 3; weight: 0.000244140625), (dx: - 1;
  dy: 3; weight: 0.0001220703125), (dx: 0; dy: 3; weight: 0.00006103515625),
  (dx: 1; dy: 3; weight: 0.000030517578125), (dx: 2; dy: 3;
  weight: 0.0000152587890625));

const
SPIRAL_COEFFS:
array [0 .. 7] of record dx, dy: Integer;
weight:
Single;
end
= ((dx: 1; dy: 0; weight: 0.35), (dx: 1; dy: 1; weight: 0.2), (dx: 0; dy: 1;
  weight: 0.2), (dx: - 1; dy: 1; weight: 0.1), (dx: - 1; dy: 0; weight: 0.05),
  (dx: - 1; dy: - 1; weight: 0.05), (dx: 0; dy: - 1; weight: 0.03), (dx: 1;
  dy: - 1; weight: 0.02));

function Clamp(Value, Min, Max: Integer): Integer;
begin
  if Value < Min then
    Result := Min
  else if Value > Max then
    Result := Max
  else
    Result := Value;
end;

var
  X, Y, i, Width, Height: Integer;
  CurrentErrors, NextErrors: array of TError;
  Row: PRGBTripleArray;
  OldColor, NewColor: TRGBTriple;
  ErrR, ErrG, ErrB: Single;

begin
  if not Assigned(Bitmap) or Bitmap.Empty then
    Exit;

  // Установка 24-битного формата для упрощения доступа к пикселям
  Bitmap.PixelFormat := pf24bit;
  Width := Bitmap.Width;
  Height := Bitmap.Height;

  // Инициализация массивов ошибок
  SetLength(CurrentErrors, Width + 2);
  SetLength(NextErrors, Width + 2);

  for Y := 0 to Height - 1 do
  begin
    Row := Bitmap.ScanLine[Y];
    for X := 0 to Width - 1 do
    begin
      // Получаем текущий цвет с учетом накопленной ошибки
      OldColor := Row[X];
      OldColor.R := Clamp(Round(OldColor.R + CurrentErrors[X].R), 0, 255);
      OldColor.G := Clamp(Round(OldColor.G + CurrentErrors[X].G), 0, 255);
      OldColor.B := Clamp(Round(OldColor.B + CurrentErrors[X].B), 0, 255);

      if Form2.cxCbBW.EditValue then
      begin
        // Квантование цвета (пример для черно-белого)
        if (OldColor.R + OldColor.G + OldColor.B) div 3 > 128 then
        begin
          NewColor.R := 255;
          NewColor.G := 255;
          NewColor.B := 255;
        end
        else
        begin
          NewColor.R := 0;
          NewColor.G := 0;
          NewColor.B := 0;
        end;
      end
      else
      begin
        // Квантование цвета (пример для черно-белого)
        if (OldColor.R) > 128 then
          NewColor.R := 255
        else
          NewColor.R := 0;
        if (OldColor.G) > 128 then
          NewColor.G := 255
        else
          NewColor.G := 0;
        if (OldColor.B) > 128 then
          NewColor.B := 255
        else
          NewColor.B := 0;
      end;

      // Установка нового цвета
      Row[X] := NewColor;

      // Вычисление ошибки
      ErrR := OldColor.R - NewColor.R;
      ErrG := OldColor.G - NewColor.G;
      ErrB := OldColor.B - NewColor.B;

      // Распределение ошибки
      for i := 0 to High(SPIRAL_COEFFS) do
      begin
        with SPIRAL_COEFFS[i] do
        begin
          if (X + dx >= 0) and (X + dx < Width) and (Y + dy < Height) then
          begin
            if (Y + dy = Y) then // Текущая строка
            begin
              CurrentErrors[X + dx].R := CurrentErrors[X + dx].R + ErrR
                * weight;
              CurrentErrors[X + dx].G := CurrentErrors[X + dx].G + ErrG
                * weight;
              CurrentErrors[X + dx].B := CurrentErrors[X + dx].B + ErrB
                * weight;
            end
            else if (Y + dy = Y + 1) then // Следующая строка
            begin
              NextErrors[X + dx].R := NextErrors[X + dx].R + ErrR * weight;
              NextErrors[X + dx].G := NextErrors[X + dx].G + ErrG * weight;
              NextErrors[X + dx].B := NextErrors[X + dx].B + ErrB * weight;
            end;
          end;
        end;
      end;

      // Сброс текущей ошибки
      CurrentErrors[X] := Default (TError);
    end;

    // Перенос ошибок для следующей строки
    if Y < Height - 1 then
    begin
      CurrentErrors := Copy(NextErrors, 0, Length(CurrentErrors));
      FillChar(NextErrors[0], Length(NextErrors) * SizeOf(TError), 0);
    end;
  end;
end;

procedure TForm2.Imstop();
begin
  Timer1.Enabled := False;
  Timer2.Enabled := False;
  TimerRun.Enabled := False;
  TimerRun2.Enabled := False;
  TimUpdateRun.Enabled := False;
end;

procedure RasterizeBitmap(Bitmap: TBitmap; Method: Integer = 0);
var
  X, Y: Integer;
  GrayR, GrayG, GrayB, Gray, Threshold: Byte;
  Row: PRGBQuad;
  DitherMatrix: array [0 .. 7, 0 .. 7] of Integer;
begin
  // Инициализация матрицы Байера для упорядоченного растрирования
  DitherMatrix[0, 0] := 0;
  DitherMatrix[0, 1] := 32;
  DitherMatrix[0, 2] := 8;
  DitherMatrix[0, 3] := 40;
  DitherMatrix[1, 0] := 48;
  DitherMatrix[1, 1] := 16;
  DitherMatrix[1, 2] := 56;
  DitherMatrix[1, 3] := 24;
  DitherMatrix[2, 0] := 12;
  DitherMatrix[2, 1] := 44;
  DitherMatrix[2, 2] := 4;
  DitherMatrix[2, 3] := 36;
  DitherMatrix[3, 0] := 60;
  DitherMatrix[3, 1] := 28;
  DitherMatrix[3, 2] := 52;
  DitherMatrix[3, 3] := 20;

  Bitmap.PixelFormat := pf32bit;

  for Y := 0 to Bitmap.Height - 1 do
  begin
    Row := Bitmap.ScanLine[Y];
    for X := 0 to Bitmap.Width - 1 do
    begin
      // Преобразование в градации серого (упрощенно)
      GrayR := (Row.rgbRed);
      GrayG := (Row.rgbGreen);
      GrayB := (Row.rgbBlue);

      // Применение растрирования
      case Method of
        0: // Упорядоченное растрирование
          begin
            Threshold := DitherMatrix[Y mod 4, X mod 4] * 255 div 64;
            if GrayR > Threshold then
            begin
              Row.rgbRed := 255;
            end
            else
            begin
              Row.rgbRed := 0;
            end;

            if GrayG > Threshold then
            begin
              Row.rgbGreen := 255;
            end
            else
            begin
              Row.rgbGreen := 0;
            end;

            if GrayB > Threshold then
            begin
              Row.rgbBlue := 255;
            end
            else
            begin
              Row.rgbBlue := 0;
            end;

          end;
        1: // Стохастическое растрирование
          begin
            GrayR := (Row.rgbRed);
            GrayG := (Row.rgbGreen);
            GrayB := (Row.rgbBlue);

            Threshold := Random(256);
            if GrayR > Threshold then
            begin
              Row.rgbRed := 255;
            end
            else
            begin
              Row.rgbRed := 0;
            end;
            Threshold := Random(256);
            if GrayG > Threshold then
            begin
              Row.rgbGreen := 255;
            end
            else
            begin
              Row.rgbGreen := 0;
            end;
            Threshold := Random(256);
            if GrayB > Threshold then
            begin
              Row.rgbBlue := 255;
            end
            else
            begin
              Row.rgbBlue := 0;
            end;
          end;
      end;

      Inc(Row);
    end;
  end;
end;

function Clamp(Value: Integer): Byte;
begin
  Result := Byte(EnsureRange(Value, 0, 255));
end;

function GetClosestColor(R, G, B: Byte): Byte;
var
  i: Integer;
  MinDistance, Distance: Integer;
  ClosestColorIndex: Integer;
  ColorR: Byte;
  ColorG: Byte;
  ColorB: Byte;
begin
  MinDistance := MaxInt;
  ClosestColorIndex := 0;

  for i := 0 to High(Colors) do
  begin
    // Преобразуйте значение цвета в RGB
    ColorR := GetRValue(Colors[i]);
    ColorG := GetGValue(Colors[i]);
    ColorB := GetBValue(Colors[i]);

    // Вычисление расстояния по формуле Евклидова расстояния
    Distance := Sqr(R - ColorR) + Sqr(G - ColorG) + Sqr(B - ColorB);

    if Distance < MinDistance then
    begin
      MinDistance := Distance;
      ClosestColorIndex := i;
    end;
  end;

  Result := Colors[ClosestColorIndex];
end;

procedure TForm2.FloydSteinbergDither(Bitmap: TBitmap);
var
  X, Y: Integer;
  OldR, OldG, OldB: Integer;
  NewColorR, NewColorG, NewColorB, NewColor: Byte;
  ErrorR, ErrorG, ErrorB: Integer;
  CurrentRow, NextRow: PRGBQuadArray;
begin
  // Преобразование в 32-битный формат для прямого доступа к пикселям
  Bitmap.PixelFormat := pf32bit;

  for Y := 0 to Bitmap.Height - 1 do
  begin
    CurrentRow := Bitmap.ScanLine[Y];
    if Y < Bitmap.Height - 1 then
      NextRow := Bitmap.ScanLine[Y + 1]
    else
      NextRow := nil;

    for X := 0 to Bitmap.Width - 1 do
    begin
      // Получаем исходные значения цветов
      OldR := CurrentRow[X].rgbRed;
      OldG := CurrentRow[X].rgbGreen;
      OldB := CurrentRow[X].rgbBlue;

      // Квантование в черно-белый (можно изменить порог)
      if Form2.cxCbBW.EditValue then
      begin
        NewColor := IfThen(((OldR + OldG + OldR) div 3) > 128, 255, 0);

        ErrorR := OldR - NewColor;
        ErrorG := OldG - NewColor;
        ErrorB := OldB - NewColor;

        CurrentRow[X].rgbRed := NewColor;
        CurrentRow[X].rgbGreen := NewColor;
        CurrentRow[X].rgbBlue := NewColor;

      end
      else
      begin

        NewColorR := IfThen((OldR) > 128, 255, 0);
        NewColorG := IfThen((OldG) > 128, 255, 0);
        NewColorB := IfThen((OldB) > 128, 255, 0);

        // Вычисление ошибки
        ErrorR := OldR - NewColorR;
        ErrorG := OldG - NewColorG;
        ErrorB := OldB - NewColorB;

        // Устанавливаем новое значение пикселя
        CurrentRow[X].rgbRed := NewColorR;
        CurrentRow[X].rgbGreen := NewColorG;
        CurrentRow[X].rgbBlue := NewColorB;

      end;

      // Распределение ошибки
      if X < Bitmap.Width - 1 then
      begin
        CurrentRow[X + 1].rgbRed :=
          Clamp(CurrentRow[X + 1].rgbRed + ErrorR * 7 div 16);
        CurrentRow[X + 1].rgbGreen :=
          Clamp(CurrentRow[X + 1].rgbGreen + ErrorG * 7 div 16);
        CurrentRow[X + 1].rgbBlue :=
          Clamp(CurrentRow[X + 1].rgbBlue + ErrorB * 7 div 16);
      end;

      if (X > 0) and (Y < Bitmap.Height - 1) then
      begin
        NextRow[X - 1].rgbRed :=
          Clamp(NextRow[X - 1].rgbRed + ErrorR * 3 div 16);
        NextRow[X - 1].rgbGreen :=
          Clamp(NextRow[X - 1].rgbGreen + ErrorG * 3 div 16);
        NextRow[X - 1].rgbBlue :=
          Clamp(NextRow[X - 1].rgbBlue + ErrorB * 3 div 16);
      end;

      if Y < Bitmap.Height - 1 then
      begin
        NextRow[X].rgbRed := Clamp(NextRow[X].rgbRed + ErrorR * 5 div 16);
        NextRow[X].rgbGreen := Clamp(NextRow[X].rgbGreen + ErrorG * 5 div 16);
        NextRow[X].rgbBlue := Clamp(NextRow[X].rgbBlue + ErrorB * 5 div 16);
      end;

      if (X < Bitmap.Width - 1) and (Y < Bitmap.Height - 1) then
      begin
        NextRow[X + 1].rgbRed :=
          Clamp(NextRow[X + 1].rgbRed + ErrorR * 1 div 16);
        NextRow[X + 1].rgbGreen :=
          Clamp(NextRow[X + 1].rgbGreen + ErrorG * 1 div 16);
        NextRow[X + 1].rgbBlue :=
          Clamp(NextRow[X + 1].rgbBlue + ErrorB * 1 div 16);
      end;
    end;
  end;
end;

procedure TForm2.Chromium1AfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  PostMessage(Handle, CEF_AFTERCREATED, 0, 0);
end;

procedure TForm2.Chromium1BeforeClose(Sender: TObject;
  const browser: ICefBrowser);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TForm2.Chromium1BeforePopup(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; popup_id: Integer;
  const targetUrl, targetFrameName: ustring;
  targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean;
  const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo;
  var client: ICefClient; var settings: TCefBrowserSettings;
  var extra_info: ICefDictionaryValue; var noJavascriptAccess: Boolean;
  var Result: Boolean);
begin
  Result := (targetDisposition in [CEF_WOD_NEW_FOREGROUND_TAB,
    CEF_WOD_NEW_BACKGROUND_TAB, CEF_WOD_NEW_POPUP, CEF_WOD_NEW_WINDOW]);
end;

procedure TForm2.Action1Execute(Sender: TObject);
begin
  flstop := False;
  try
    // Инициализация SSL (нужны библиотеки libeay32.dll и ssleay32.dll в папке с exe)
    imcnt := imcnt + 1;
    Caption := Cname + ' ' + IntToStr(imcnt) + ' +1';
    if LoadImageFromURLToBitmap('https://images.pexels.com/photos/' +
      IntToStr(imcnt) + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg') then
    begin
      Image1.Picture.LoadFromFile('upl.jpg');
      cxLog.lines.Text := 'https://images.pexels.com/photos/' + IntToStr(imcnt)
        + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg';
    end
    else
    begin
      imcnt := imcnt + 1;
      Action1Execute(Sender);
    end;

  except
    // on E: Exception do
    // ShowMessage('Ошибка: ' + E.Message);
  end;
end;

procedure TForm2.Action2Execute(Sender: TObject);
begin
  flstop := False;
  try
    // Инициализация SSL (нужны библиотеки libeay32.dll и ssleay32.dll в папке с exe)
    imcnt := imcnt + 10;
    Caption := Cname + ' ' + IntToStr(imcnt) + ' +10';
    if LoadImageFromURLToBitmap('https://images.pexels.com/photos/' +
      IntToStr(imcnt) + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg') then
    begin
      Image1.Picture.LoadFromFile('upl.jpg');
      cxLog.lines.Text := 'https://images.pexels.com/photos/' + IntToStr(imcnt)
        + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg';
    end
    else
    begin
      imcnt := imcnt + 1;
      Action1Execute(Sender);
    end;
  except
    // on E: Exception do
    // ShowMessage('Ошибка: ' + E.Message);
  end;
end;

procedure TForm2.Action3Execute(Sender: TObject);
begin
  flstop := False;
  try
    // Инициализация SSL (нужны библиотеки libeay32.dll и ssleay32.dll в папке с exe)
    imcnt := imcnt + 50;
    Caption := Cname + ' ' + IntToStr(imcnt) + ' +50';
    if LoadImageFromURLToBitmap('https://images.pexels.com/photos/' +
      IntToStr(imcnt) + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg') then
    begin
      Image1.Picture.LoadFromFile('upl.jpg');
      cxLog.lines.Text := 'https://images.pexels.com/photos/' + IntToStr(imcnt)
        + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg';
    end
    else
    begin
      imcnt := imcnt + 1;
      Action1Execute(Sender);
    end;

  except
    // on E: Exception do
    // ShowMessage('Ошибка: ' + E.Message);
  end;
end;

procedure TForm2.Action4Execute(Sender: TObject);
begin
  flstop := False;
  try
    // Инициализация SSL (нужны библиотеки libeay32.dll и ssleay32.dll в папке с exe)

    imcnt := imcnt - 1;
    if LoadImageFromURLToBitmap('https://images.pexels.com/photos/' +
      IntToStr(imcnt) + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg') then
    begin
      Image1.Picture.LoadFromFile('upl.jpg');
      Caption := Cname + ' ' + IntToStr(imcnt) + ' -1';
      cxLog.lines.Text := 'https://images.pexels.com/photos/' + IntToStr(imcnt)
        + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg';
    end
    else
    begin
      imcnt := imcnt - 1;
      Action4Execute(Sender);
    end;

  except
    // on E: Exception do
    // ShowMessage('Ошибка: ' + E.Message);
  end;
end;

procedure TForm2.Action5Execute(Sender: TObject);
begin
  cxChDitheringRiemersma.Properties.OnChange := nil;
  cxChFloydSteinberg.Properties.OnChange := nil;
  cxChDitheringRiemersma.EditValue := False;
  cxChFloydSteinberg.EditValue := False;
  cxChDitheringRiemersma.Properties.OnPropertiesChanged := cxCheckBox2Click;
  cxChFloydSteinberg.Properties.OnChange := cxBarEditItem1PropertiesChange;

end;

procedure TForm2.BrowserCreatedMsg(var aMessage: TMessage);
begin
  CEFWindowParent1.UpdateSize;
end;

procedure TForm2.WMMove(var aMessage: TWMMove);
begin
  inherited;
  if (Chromium1 <> nil) then
    Chromium1.NotifyMoveOrResizeStarted;
end;

procedure TForm2.WMMoving(var aMessage: TMessage);
begin
  inherited;
  if (Chromium1 <> nil) then
    Chromium1.NotifyMoveOrResizeStarted;
end;

procedure TForm2.WMEnterMenuLoop(var aMessage: TMessage);
begin
  inherited;
  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then
    GlobalCEFApp.OsmodalLoop := True;
end;

procedure TForm2.WMExitMenuLoop(var aMessage: TMessage);
begin
  inherited;
  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then
    GlobalCEFApp.OsmodalLoop := False;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SaveToRegistry;

  CanClose := FCanClose;

  if not(FClosing) then
  begin
    FClosing := True;
    Visible := False;
    Chromium1.CloseBrowser(True);
    CEFWindowParent1.Free;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FCanClose := False;
  FClosing := False;

  FScale := 1.0;
  Image1.AutoSize := False;
  Image1.Align := alNone;
  Image1.Proportional := True;
  Image1.Center := False;
  Image1.Stretch := True;
  Image1.Width := Panel4.Width;
  Image1.Height := Panel4.Height;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    flstop := True;
  end;
end;

procedure TForm2.SaveToRegistry;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_WRITE);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey(RegistryPath, True) then
    begin
      Registry.WriteString('edHost', edHost.Text);
      Registry.WriteInteger('imcnt', imcnt);
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

procedure TForm2.LoadFromRegistry;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey(RegistryPath, False) then
    begin
      if Registry.ValueExists('edHost') then
        edHost.Text := Registry.ReadString('edHost');

      if Registry.ValueExists('imcnt') then
        imcnt := Registry.ReadInteger('imcnt');
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

procedure TForm2.nealfun1Click(Sender: TObject);
begin
  flstop := False;
  Chromium1.LoadURL('https://randomstreetview.com/');
  TimerRun.Enabled := cxBar60s.EditValue;
  TimUpdateRun.Enabled := True;
end;

function TForm2.LoadImageFromURLToBitmap(const AURL: string): Boolean;
var
  http: THTTPSend;
  Stream: TMemoryStream;
begin
  Result := False;
  http := THTTPSend.Create;
  Stream := TMemoryStream.Create;
  try
    // Для HTTPS-соединений нужно добавить OpenSSL библиотеки
    http.Sock.CreateWithSSL(TSSLOpenSSL);

    if http.HTTPMethod('GET', AURL) and (http.ResultCode = 200) then
    begin
      http.Document.Position := 0;

      Stream.CopyFrom(http.Document, http.Document.Size);
      Stream.Position := 0;

      Stream.SaveToFile('upl.jpg');
      LoadImageFromDisk('upl.jpg');
      Result := True;
    end
    else
      Result := False;
  finally
    Stream.Free;
    http.Free;
  end;
end;

procedure TForm2.N4Click(Sender: TObject);
var
  Bitmap, BitmapConv, LeftBitmap, RightBitmap: TBitmap;
  X, Y, z, j, i: Integer;
  ColorString: String;
  c1, c2: Integer;
  z_pos: Integer;
begin
  flstop := False;
  dxStatusBar1.Panels[0].Text := 'Открываем картинку';

  if CheckBox2.Checked then
  begin
    flSw := False;
  end
  else
  begin
    flSw := True;
  end;

  // Открываем диалог выбора файла
  if OpenDialog1.Execute then
  begin
    cxBar60s.EditValue := False;

    Bitmap := TBitmap.Create;
    LeftBitmap := TBitmap.Create;
    RightBitmap := TBitmap.Create;
    SetLength(Data, 1200 * 1600);
    z_pos := 0;

    try
      // Загружаем изображение
      Bitmap := ConvertImageToTargetSize(OpenDialog1.FileName,
        cxCheckBox3.Checked);

      if cxChFloydSteinberg.EditValue then
      begin
        dxStatusBar1.Panels[0].Text := 'FloydSteinberg преобразование';
        FloydSteinbergDither(Bitmap);
      end;

      if cxChDitheringRiemersma.EditValue then
      begin
        DitheringRiemersma(Bitmap);
      end;

      if (cxChJ2000.EditValue) then
      begin
        RasterizeBitmap(Bitmap, 0);
      end;

      if (cxChJ2001.EditValue) then
      begin
        RasterizeBitmap(Bitmap, 1);
      end;

      X := Bitmap.Width;
      Y := Bitmap.Height;

      // Проверяем размеры изображения
      if X > Y then
      begin
        // Поворачиваем изображение на 90 градусов
        BitmapConv := TBitmap.Create;
        try
          BitmapConv.Width := Y;
          BitmapConv.Height := X;
          RotateBitmap90CW(Bitmap, BitmapConv);
          Bitmap.Assign(BitmapConv);
        finally
          BitmapConv.Free;
        end;
      end;

      Image1.Picture.Assign(Bitmap);

      dxStatusBar1.Panels[0].Text := 'Разрезаем на 2  (1/2)';

      // Разрезаем изображение по середине
      LeftBitmap.Width := Bitmap.Width div 2;
      LeftBitmap.Height := Bitmap.Height;
      RightBitmap.Width := Bitmap.Width div 2;
      RightBitmap.Height := Bitmap.Height;

      BitmapConv := TBitmap.Create;
      BitmapConv.PixelFormat := pf24bit;
      BitmapConv.Width := X div 2;
      BitmapConv.Height := Y;

      // Копируем левую и правую половины
      LeftBitmap.Canvas.CopyRect(Rect(0, 0, LeftBitmap.Width,
        LeftBitmap.Height), Bitmap.Canvas, Rect(0, 0, LeftBitmap.Width,
        Bitmap.Height));

      RightBitmap.Canvas.CopyRect(Rect(0, 0, RightBitmap.Width,
        RightBitmap.Height), Bitmap.Canvas, Rect(LeftBitmap.Width, 0,
        Bitmap.Width, Bitmap.Height));

      cxLog.Clear;
      X := LeftBitmap.Width;
      Y := LeftBitmap.Height;

      BitmapConv.Width := LeftBitmap.Width;
      BitmapConv.Height := LeftBitmap.Height;

      cxProgressBar1.Properties.Max := Y;
      // Проходим по всем пикселям изображения
      if not cxCBnotText.Checked then
        ColorString := Format('//Width %d Height %d' + sLineBreak, [X, Y]);
      if not cxCBnotText.Checked then
        ColorString := ColorString +
          Format('const unsigned char Image6colorL[%d] = {' + sLineBreak,
          [X * Y div 2]);
      z := 0;
      for j := 0 to Y - 1 do // Height
      begin
        for i := 0 to (X div 2) - 1 do // Width
        begin

          if flstop then
          begin
            Break;
            Imstop();
          end;

          c1 := Depalette(LeftBitmap.Canvas.Pixels[i * 2, j] and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
          c2 := Depalette(LeftBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

          if not cxCBnotText.Checked then
            ColorString := ColorString + '0x' + IntToStr(c1) + '' +
              IntToStr(c2) + ',';
          Data[z_pos] := HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));

          // ----
          c1 := Depalette(RightBitmap.Canvas.Pixels[i * 2, j] and $FF,
            (RightBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
            (RightBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
          c2 := Depalette(RightBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
            (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
            (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

          Data[z_pos + 600 * 800] :=
            HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));

          // ----

          z_pos := z_pos + 1;

          z := z + 1;

          if (z > 19) then
          begin
            if not cxCBnotText.Checked then
              ColorString := ColorString + #13;
            z := 0;
          end;

        end;

        if (j / 10 = j div 10) then
        begin
          cxProgressBar1.Position := j + 1;
          Application.ProcessMessages;
        end;
      end;

      // Удаляем последний символ запятой
      if not cxCBnotText.Checked then
        if ColorString.Length > 0 then
          ColorString := ColorString.Substring(0, ColorString.Length - 2);
      if not cxCBnotText.Checked then
        ColorString := ColorString + '};';

      Image2.Picture.Assign(LeftBitmap);

      if not cxCBnotText.Checked then
        if ColorString.Length > 0 then
          ColorString := ColorString.Substring(0, ColorString.Length - 2);
      if not cxCBnotText.Checked then
        ColorString := ColorString + '};';

      if not cxCBnotText.Checked then
        cxLog.lines.Text := ColorString;

      Image3.Picture.Assign(RightBitmap);

    finally
      Bitmap.Free;
      LeftBitmap.Free;
      RightBitmap.Free;
      BitmapConv.Free;

      ButUpl.Enabled := True;

      Application.ProcessMessages;
      if not flSw then
        dxBarClear.Click;

    end;
  end;
end;

function TForm2.FileToBase64(const AFileName: string): string;
var
  Stream: TFileStream;
  Encoder: TIdEncoderMIME;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Encoder := TIdEncoderMIME.Create(nil);
    try
      Result := 'data:image/' + ExtractFileExt(AFileName).Replace('.', '') +
        ';base64,' + Encoder.EncodeStream(Stream);
    finally
      Encoder.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TForm2.LoadImageFromDisk(const AImagePath: string);
var
  jsCode: string;
begin
  if not FileExists(AImagePath) then
  begin
    ShowMessage('Файл не существует: ' + AImagePath);
    Exit;
  end;

  jsCode := 'try {' + #13#10 + '  var img = new Image();' + #13#10 + '  ' +
    #13#10 + '  img.onload = function() {' + #13#10 +
    '    document.body.innerHTML = "";' + #13#10 +
    '    document.body.appendChild(img);' + #13#10 + '    ' + #13#10 +
    '    // Устанавливаем стили' + #13#10 + '    img.style.maxWidth = "100%";' +
    #13#10 + '    img.style.maxHeight = "100%";' + #13#10 +
    '    img.style.display = "block";' + #13#10 +
    '    img.style.margin = "0 auto";' + #13#10 + '    ' + #13#10 +
    '    // Устанавливаем фон' + #13#10 +
    '    document.body.style.backgroundColor = "#585858";' + #13#10 +
    '    document.documentElement.style.backgroundColor = "#585858";' + #13#10 +
    '  };' + #13#10 + '  ' + #13#10 + '  img.onerror = function() {' + #13#10 +
    '    document.body.innerHTML = "<div style=''color: white; text-align: center; padding: 20px;''>Ошибка загрузки изображения</div>";'
    + #13#10 + '  };' + #13#10 + '  ' + #13#10 + '  img.src = "' +
    FileToBase64(AImagePath) + '";' + #13#10 + '  ' + #13#10 + '} catch (e) {' +
    #13#10 + '  console.error("Error loading image:", e);' + #13#10 + '}';

  if Chromium1.browser <> nil then
  begin
    Chromium1.browser.MainFrame.ExecuteJavaScript(jsCode, 'about:blank', 0);
  end;
end;

procedure TForm2.pexelscom1Click(Sender: TObject);
begin
  flstop := False;
  try
    // Инициализация SSL (нужны библиотеки libeay32.dll и ssleay32.dll в папке с exe)
    if LoadImageFromURLToBitmap('https://images.pexels.com/photos/' +
      IntToStr(imcnt) + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg') then
    begin
      imPaint('upl.jpg');
      imcnt := imcnt + 1;
      cxLog.lines.Text := 'https://images.pexels.com/photos/' + IntToStr(imcnt)
        + '/pexels-photo-' + IntToStr(imcnt) + '.jpeg';
      TimerRun2.Enabled := cxBar60s.EditValue;
    end
    else
    begin
      imcnt := imcnt + 1;
      pexelscom1Click(Sender);
    end;
  except
    //
  end;
end;

procedure TForm2.pexelscomid1Click(Sender: TObject);
var
  S: String;
begin
  S := IntToStr(imcnt);
  if InputQuery('id', 'id картинки: ', S) then
    imcnt := StrToInt(S);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  flSw := True;
  if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) then
    Timer2.Enabled := True;
  imcnt := 20071011;
  LoadFromRegistry;

  if Chromium1.browser <> nil then
  begin
    Chromium1.browser.MainFrame.ExecuteJavaScript
      ('document.body.style.backgroundColor = "#585858";' +
      'document.documentElement.style.backgroundColor = "#585858";',
      'about:blank', 0);
  end;

end;

procedure TForm2.UpdateImagePosition;
var
  NewWidth, NewHeight: Integer;
begin
  // Устанавливаем новые размеры изображения
  NewWidth := Round(Image1.Picture.Width * FScale);
  NewHeight := Round(Image1.Picture.Height * FScale);

  Image1.Width := NewWidth;
  Image1.Height := NewHeight;

  // Корректируем положение, чтобы изображение не выходило за границы панели
  if Image1.Left > Panel4.Width - Image1.Width then
    Image1.Left := Panel4.Width - Image1.Width;
  if Image1.Left < 0 then
    Image1.Left := 0;

  if Image1.Top > Panel4.Height - Image1.Height then
    Image1.Top := Panel4.Height - Image1.Height;
  if Image1.Top < 0 then
    Image1.Top := 0;
end;

procedure TForm2.SetScale(AScale: Double);
begin
  if AScale < 0.1 then
    AScale := 0.1; // Минимальный масштаб
  if AScale > 10 then
    AScale := 10; // Максимальный масштаб

  FScale := AScale;
  UpdateImagePosition;
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    FDragging := True;
    FStartPos := Point(X, Y);
    FImageStartPos := Point(Image1.Left, Image1.Top);
    Image1.Cursor := crHandPoint;
  end;
end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  NewLeft, NewTop: Integer;
  CanDragHorz, CanDragVert: Boolean;
begin
  if FDragging then
  begin
    // Проверяем, нужно ли вообще перемещение по осям
    CanDragHorz := Image1.Width > Panel4.Width;
    CanDragVert := Image1.Height > Panel4.Height;

    // Вычисляем новое положение
    NewLeft := Image1.Left;
    NewTop := Image1.Top;

    if CanDragHorz then
    begin
      NewLeft := FImageStartPos.X + (X - FStartPos.X);
      if NewLeft > 0 then
        NewLeft := 0;
      if NewLeft < Panel4.Width - Image1.Width then
        NewLeft := Panel4.Width - Image1.Width;
    end;

    if CanDragVert then
    begin
      NewTop := FImageStartPos.Y + (Y - FStartPos.Y);
      if NewTop > 0 then
        NewTop := 0;
      if NewTop < Panel4.Height - Image1.Height then
        NewTop := Panel4.Height - Image1.Height;
    end;

    // Применяем новые координаты
    Image1.Left := NewLeft;
    Image1.Top := NewTop;
  end;
end;

procedure TForm2.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    FDragging := False;
    Image1.Cursor := crDefault;
  end;
end;

procedure TForm2.Image2Click(Sender: TObject);
begin
  SetScale(FScale * 0.8);
end;

procedure TForm2.Image3Click(Sender: TObject);
begin
  SetScale(FScale * 1.2);
end;

function SendGetRequest(const url: string): string;
var
  http: THTTPSend;
  response: string;
  res: Boolean;
begin
  http := THTTPSend.Create;
  try
    res := http.HTTPMethod('GET', url);
    response := http.ResultString;

  finally
    http.Free;
  end;
  Result := response;
end;

procedure TForm2.ShowMessageF(S: string);
begin
  if flSw then
    ShowMessage(S)
  else
  begin
    dxStatusBar1.Panels[0].Text := S;
    Application.ProcessMessages;
  end;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  Form2.UploadFFile(fng);
end;

procedure TForm2.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  if not(Chromium1.CreateBrowser(CEFWindowParent1, '')) and
    not(Chromium1.Initialized) then
    Timer2.Enabled := True;
end;

procedure TForm2.TimerRun2Timer(Sender: TObject);
begin
  TimerRun2.Enabled := False;
  pexelscom1.Click;
end;

procedure TForm2.TimerRunTimer(Sender: TObject);
begin
  nealfun1.Click;
end;

procedure TForm2.TimUpdateRunTimer(Sender: TObject);
begin
  TimUpdateRun.Enabled := False;
  cxButton4.Click;
end;

procedure TForm2.RequestCompleted(Sender: TObject);
begin
  // ShowMessageF('Завершено!');
end;

procedure SaveBytesToFile(const Data: TBytes; const FileName: string);
var
  Stream: TBytesStream;
begin
  Stream := TBytesStream.Create(Data);
  try
    Stream.SaveToFile(FileName);
  finally
    Stream.Free;
  end;
end;

procedure GetProxyData(var ProxyEnabled: Boolean; var ProxyServer: string;
  var ProxyPort: Integer);
var
  ProxyInfo: PInternetProxyInfo;
  Len: LongWord;
  i, j: Integer;
begin
  Len := 4096;
  ProxyEnabled := False;
  GetMem(ProxyInfo, Len);
  try
    if InternetQueryOption(nil, INTERNET_OPTION_PROXY, ProxyInfo, Len) then
      if ProxyInfo^.dwAccessType = INTERNET_OPEN_TYPE_PROXY then
      begin
        ProxyEnabled := True;
        ProxyServer := ProxyInfo^.lpszProxy;
      end
  finally
    FreeMem(ProxyInfo);
  end;

  if ProxyEnabled and (ProxyServer <> '') then
  begin
    i := Pos('http=', ProxyServer);
    if (i > 0) then
    begin
      Delete(ProxyServer, 1, i + 5);
      j := Pos(';', ProxyServer);
      if (j > 0) then
        ProxyServer := Copy(ProxyServer, 1, j - 1);
    end;
    i := Pos(':', ProxyServer);
    if (i > 0) then
    begin
      ProxyPort := StrToIntDef(Copy(ProxyServer, i + 1,
        Length(ProxyServer) - i), 0);
      ProxyServer := Copy(ProxyServer, 1, i - 1)
    end
  end;
end;

function HttpPostFileForm(const url, FieldName, FileName: string;
  const Data: TStream; const FormFields: TStrings; const ResultData: TStrings;
  var res_txt: string): Boolean;
var
  http: THTTPSend;
  Bound, S: AnsiString;
  i: Integer;
  ProxyEnabled: Boolean;
  ProxyServer: string;
  ProxyPort: Integer;
const
  CRLF = #13#10;
  FIELD_MASK = CRLF + '--%s' + CRLF +
    'Content-Disposition: form-data; name="%s"' + CRLF + CRLF + '%s';
begin
  Bound := IntToHex(Random(MaxInt), 8) + '_Synapse_boundary';
  http := THTTPSend.Create;

  GetProxyData(ProxyEnabled, ProxyServer, ProxyPort);

  if ProxyEnabled then
  begin
    http.ProxyHost := ProxyServer;
    http.ProxyPort := IntToStr(ProxyPort);
  end;

  try
    S := '--' + Bound + CRLF;
    S := S + 'content-disposition: form-data; name="' + FieldName + '";';
    S := S + ' filename="' + FileName + '"' + CRLF;
    S := S + 'Content-Type: Application/octet-string' + CRLF + CRLF;
    http.Document.Write(Pointer(S)^, Length(S));
    http.Document.CopyFrom(Data, 0);
    // Include formfield
    for i := 0 to FormFields.Count - 1 do
    begin
      S := Format(FIELD_MASK, [Bound, FormFields.Names[i],
        FormFields.Values[FormFields.Names[i]]]);
      http.Document.Write(Pointer(S)^, Length(S));
    end;
    S := CRLF + '--' + Bound + '--' + CRLF;
    http.Document.Write(Pointer(S)^, Length(S));
    http.MimeType := 'multipart/form-data, boundary=' + Bound;
    Result := http.HTTPMethod('POST', url);
    res_txt := http.ResultString;

    Form2.ShowMessageF(res_txt);

    ResultData.LoadFromStream(http.Document);
  finally
    http.Free;
  end;
end;

procedure TForm2.SendFile(url_media, fn, sfn, path: string);
var
  Data: TFileStream;
  FormFields, lines: TStrings;
  FileName: string;
  res_txt: string;
begin
  try
    FileName := fn;

    Data := TFileStream.Create(FileName, fmOpenRead);
    // Авторизация
    FormFields := TStringList.Create;
    lines := TStringList.Create;

    HttpPostFileForm(url_media, // url
      'uploadedfile', ExtractFileName(FileName), Data, FormFields, lines,
      res_txt); // then
    lines.Free;
    Data.Free;
    FormFields.Free;
  except
    // showmessage(fn);
  end;
end;

procedure returnF(user_id, user_name, user_message: String);
begin
  Form2.cxLog.lines.add(user_id);
  Form2.cxLog.lines.add(user_name);
  Form2.cxLog.lines.add(user_message);
end;

procedure TForm2.cxBarEditItem1PropertiesChange(Sender: TObject);
begin
  cxChFloydSteinberg.EditValue := not cxChFloydSteinberg.EditValue;
end;

procedure CropBitmap(var BitmapWeb: TBitmap);
var
  CroppedBitmap: TBitmap;
  SourceRect, DestRect: TRect;
begin
  // Создаем новый битмап для обрезанного изображения
  CroppedBitmap := TBitmap.Create;
  try
    // Задаем размер нового битмапа
    CroppedBitmap.SetSize(BitmapWeb.Width - 100, BitmapWeb.Height - 100);
    // 40 слева и 40 справа, 40 сверху и 40 снизу

    // Определяем область, которую хотим скопировать
    SourceRect := Rect(50, 80, BitmapWeb.Width - 50, BitmapWeb.Height - 20);
    DestRect := Rect(0, 0, CroppedBitmap.Width, CroppedBitmap.Height);

    // Копируем нужную область из BitmapWeb в CroppedBitmap
    CroppedBitmap.Canvas.CopyRect(DestRect, BitmapWeb.Canvas, SourceRect);

    // Пример: заменяем оригинальный BitmapWeb на обрезанный
    BitmapWeb.Assign(CroppedBitmap);

  finally
    CroppedBitmap.Free; // Освобождаем память
  end;
end;

procedure TForm2.cxButton4Click(Sender: TObject);
var
  Bitmap, BitmapConv, LeftBitmap, RightBitmap: TBitmap;
  X, Y, z, j, i: Integer;
  ColorString: String;
  c1, c2: Integer;
  z_pos: Integer;
  BitmapWeb: TBitmap;
begin
  dxStatusBar1.Panels[0].Text := 'Открываем картинку';

  if CheckBox2.Checked then
  begin
    flSw := False;
  end
  else
  begin
    flSw := True;
  end;

  BitmapWeb := TBitmap.Create;
  // Открываем диалог выбора файла
  if CEFWindowParent1.TakeSnapshot(BitmapWeb) then
  begin
    CropBitmap(BitmapWeb);

    BitmapWeb.SaveToFile('screenshot.png');

    Bitmap := TBitmap.Create;
    LeftBitmap := TBitmap.Create;
    RightBitmap := TBitmap.Create;
    SetLength(Data, 1200 * 1600);
    z_pos := 0;

    try
      // Загружаем изображение
      Bitmap := ConvertImageToTargetSize('screenshot.png', cxCheckBox3.Checked);

      if cxChFloydSteinberg.EditValue then
      begin
        dxStatusBar1.Panels[0].Text := 'FloydSteinberg преобразование';
        FloydSteinbergDither(Bitmap);
      end;

      if cxChDitheringRiemersma.EditValue then
      begin
        DitheringRiemersma(Bitmap);
      end;

      if (cxChJ2000.EditValue) then
      begin
        RasterizeBitmap(Bitmap, 0);
      end;

      if (cxChJ2001.EditValue) then
      begin
        RasterizeBitmap(Bitmap, 1);
      end;

      X := Bitmap.Width;
      Y := Bitmap.Height;

      // Проверяем размеры изображения
      if X > Y then
      begin
        // Поворачиваем изображение на 90 градусов
        BitmapConv := TBitmap.Create;
        try
          BitmapConv.Width := Y;
          BitmapConv.Height := X;
          RotateBitmap90CW(Bitmap, BitmapConv);
          Bitmap.Assign(BitmapConv);
          // Заменяем оригинальный Bitmap на повернутый
        finally
          BitmapConv.Free;
        end;
      end;

      Image1.Picture.Assign(Bitmap);

      dxStatusBar1.Panels[0].Text := 'Разрезаем на 2  (1/2)';

      // Разрезаем изображение по середине
      LeftBitmap.Width := Bitmap.Width div 2;
      LeftBitmap.Height := Bitmap.Height;
      RightBitmap.Width := Bitmap.Width div 2;
      RightBitmap.Height := Bitmap.Height;

      BitmapConv := TBitmap.Create;
      BitmapConv.PixelFormat := pf24bit;
      BitmapConv.Width := X div 2;
      BitmapConv.Height := Y;

      // Копируем левую и правую половины
      LeftBitmap.Canvas.CopyRect(Rect(0, 0, LeftBitmap.Width,
        LeftBitmap.Height), Bitmap.Canvas, Rect(0, 0, LeftBitmap.Width,
        Bitmap.Height));

      RightBitmap.Canvas.CopyRect(Rect(0, 0, RightBitmap.Width,
        RightBitmap.Height), Bitmap.Canvas, Rect(LeftBitmap.Width, 0,
        Bitmap.Width, Bitmap.Height));

      cxLog.Clear;
      X := LeftBitmap.Width;
      Y := LeftBitmap.Height;

      BitmapConv.Width := LeftBitmap.Width;
      BitmapConv.Height := LeftBitmap.Height;

      cxProgressBar1.Properties.Max := Y;

      // Проходим по всем пикселям изображения
      if not cxCBnotText.Checked then
        ColorString := Format('//Width %d Height %d' + sLineBreak, [X, Y]);
      if not cxCBnotText.Checked then
        ColorString := ColorString +
          Format('const unsigned char Image6colorL[%d] = {' + sLineBreak,
          [X * Y div 2]);
      z := 0;
      for j := 0 to Y - 1 do // Height
      begin
        for i := 0 to (X div 2) - 1 do // Width
        begin
          c1 := Depalette(LeftBitmap.Canvas.Pixels[i * 2, j] and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
          c2 := Depalette(LeftBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
            (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

          BitmapConv.Canvas.Pixels[i * 2, j] :=
            RGB(palette2[c1][0], palette2[c1][1], palette2[c1][2]);
          BitmapConv.Canvas.Pixels[i * 2 + 1, j] :=
            RGB(palette2[c2][0], palette2[c2][1], palette2[c2][2]);;

          if not cxCBnotText.Checked then
            ColorString := ColorString + '0x' + IntToStr(c1) + '' +
              IntToStr(c2) + ',';
          Data[z_pos] := HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));
          z_pos := z_pos + 1;

          z := z + 1;

          if (z > 19) then
          begin
            if not cxCBnotText.Checked then
              ColorString := ColorString + #13;
            z := 0;
          end;

        end;

        cxProgressBar1.Position := j + 1;
        Application.ProcessMessages;
      end;

      // Удаляем последний символ запятой
      if not cxCBnotText.Checked then
        if ColorString.Length > 0 then
          ColorString := ColorString.Substring(0, ColorString.Length - 2);
      if not cxCBnotText.Checked then
        ColorString := ColorString + '};';

      Image2.Picture.Assign(BitmapConv);
      dxStatusBar1.Panels[0].Text := 'Разрезаем на 2  (2/2)';

      // -------------
      X := RightBitmap.Width;
      Y := RightBitmap.Height;

      cxProgressBar1.Properties.Max := Y;

      // Проходим по всем пикселям изображения
      if not cxCBnotText.Checked then
        ColorString := ColorString + #13 + #13 + #13 +
          Format('//Width %d Height %d' + sLineBreak, [X, Y]);
      if not cxCBnotText.Checked then
        ColorString := ColorString +
          Format('const unsigned char Image6colorR[%d] = {' + sLineBreak,
          [X * Y div 2]);
      z := 0;
      for j := 0 to Y - 1 do // Height
      begin
        for i := 0 to (X div 2) - 1 do // Width
        begin
          c1 := Depalette(RightBitmap.Canvas.Pixels[i * 2, j] and $FF,
            (RightBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
            (RightBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
          c2 := Depalette(RightBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
            (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
            (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

          BitmapConv.Canvas.Pixels[i * 2, j] :=
            RGB(palette2[c1][0], palette2[c1][1], palette2[c1][2]);

          BitmapConv.Canvas.Pixels[i * 2 + 1, j] :=
            RGB(palette2[c2][0], palette2[c2][1], palette2[c2][2]);;

          if not cxCBnotText.Checked then
            ColorString := ColorString + '0x' + IntToStr(c1) + '' +
              IntToStr(c2) + ',';

          Data[z_pos] := HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));
          z_pos := z_pos + 1;

          z := z + 1;

          if (z > 19) then
          begin
            if not cxCBnotText.Checked then
              ColorString := ColorString + #13;
            z := 0;
          end;

        end;

        cxProgressBar1.Position := j + 1;
        Application.ProcessMessages;
      end;

      // Удаляем последний символ запятой
      if not cxCBnotText.Checked then
        if ColorString.Length > 0 then
          ColorString := ColorString.Substring(0, ColorString.Length - 2);
      if not cxCBnotText.Checked then
        ColorString := ColorString + '};';

      if not cxCBnotText.Checked then
        cxLog.lines.Text := ColorString;

      Image3.Picture.Assign(BitmapConv);

    finally
      // Освобождаем ресурсы
      Bitmap.Free;
      LeftBitmap.Free;
      RightBitmap.Free;
      BitmapConv.Free;

      ButUpl.Enabled := True;

      Application.ProcessMessages;
      if not flSw then
        dxBarClear.Click;

    end;
  end;

  BitmapWeb.Free;
end;

procedure TForm2.imPaint(fn: string);
var
  Bitmap, BitmapConv, LeftBitmap, RightBitmap: TBitmap;
  X, Y, z, j, i: Integer;
  ColorString: String;
  c1, c2: Integer;
  z_pos: Integer;
  Row, ConvRow: PRGBQuad;
begin
  dxStatusBar1.Panels[0].Text := 'Открываем картинку';

  if CheckBox2.Checked then
  begin
    flSw := False;
  end
  else
  begin
    flSw := True;
  end;

  Bitmap := TBitmap.Create;
  LeftBitmap := TBitmap.Create;
  RightBitmap := TBitmap.Create;
  SetLength(Data, 1200 * 1600);
  z_pos := 0;

  try
    Bitmap := ConvertImageToTargetSize(fn, cxCheckBox3.Checked);

    if cxChFloydSteinberg.EditValue then
    begin
      dxStatusBar1.Panels[0].Text := 'FloydSteinberg преобразование';
      FloydSteinbergDither(Bitmap);
    end;

    if cxChDitheringRiemersma.EditValue then
    begin
      DitheringRiemersma(Bitmap);
    end;

    if (cxChJ2000.EditValue) then
    begin
      RasterizeBitmap(Bitmap, 0);
    end;

    if (cxChJ2001.EditValue) then
    begin
      RasterizeBitmap(Bitmap, 1);
    end;

    X := Bitmap.Width;
    Y := Bitmap.Height;

    // Проверяем размеры изображения
    if X > Y then
    begin
      // Поворачиваем изображение на 90 градусов
      BitmapConv := TBitmap.Create;
      BitmapConv.PixelFormat := pf32bit;
      try
        BitmapConv.Width := Y;
        BitmapConv.Height := X;
        RotateBitmap90CW(Bitmap, BitmapConv);
        Bitmap.Assign(BitmapConv);
      finally
        BitmapConv.Free;
      end;
    end;

    Image1.Picture.Assign(Bitmap);

    dxStatusBar1.Panels[0].Text := 'Разрезаем на 2  (1/2)';

    // Разрезаем изображение по середине
    LeftBitmap.Width := Bitmap.Width div 2;
    LeftBitmap.Height := Bitmap.Height;
    RightBitmap.Width := Bitmap.Width div 2;
    RightBitmap.Height := Bitmap.Height;

    BitmapConv := TBitmap.Create;
    BitmapConv.PixelFormat := pf32bit;
    BitmapConv.Width := X div 2;
    BitmapConv.Height := Y;

    // Копируем левую и правую половины
    LeftBitmap.Canvas.CopyRect(Rect(0, 0, LeftBitmap.Width, LeftBitmap.Height),
      Bitmap.Canvas, Rect(0, 0, LeftBitmap.Width, Bitmap.Height));

    RightBitmap.Canvas.CopyRect(Rect(0, 0, RightBitmap.Width,
      RightBitmap.Height), Bitmap.Canvas, Rect(LeftBitmap.Width, 0,
      Bitmap.Width, Bitmap.Height));

    cxLog.Clear;
    X := LeftBitmap.Width;
    Y := LeftBitmap.Height;

    BitmapConv.Width := LeftBitmap.Width;
    BitmapConv.Height := LeftBitmap.Height;

    cxProgressBar1.Properties.Max := Y;

    // Проходим по всем пикселям изображения
    if not cxCBnotText.Checked then
      ColorString := Format('//Width %d Height %d' + sLineBreak, [X, Y]);
    if not cxCBnotText.Checked then
      ColorString := ColorString +
        Format('const unsigned char Image6colorL[%d] = {' + sLineBreak,
        [X * Y div 2]);
    z := 0;
    for j := 0 to Y - 1 do // Height
    begin

      Row := LeftBitmap.ScanLine[j];
      ConvRow := BitmapConv.ScanLine[j];
      if flstop then
      begin
        Break;
        Imstop();
      end;

      for i := 0 to (X div 2) - 1 do // Width
      begin
        c1 := Depalette(LeftBitmap.Canvas.Pixels[i * 2, j] and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
        c2 := Depalette(LeftBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
          (LeftBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

        if not cxCBnotText.Checked then
          ColorString := ColorString + '0x' + IntToStr(c1) + '' +
            IntToStr(c2) + ',';
        Data[z_pos] := HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));

        // ----
        c1 := Depalette(RightBitmap.Canvas.Pixels[i * 2, j] and $FF,
          (RightBitmap.Canvas.Pixels[i * 2, j] shr 8) and $FF,
          (RightBitmap.Canvas.Pixels[i * 2, j] shr 16) and $FF);
        c2 := Depalette(RightBitmap.Canvas.Pixels[i * 2 + 1, j] and $FF,
          (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 8) and $FF,
          (RightBitmap.Canvas.Pixels[i * 2 + 1, j] shr 16) and $FF);

        Data[z_pos + 600 * 800] :=
          HexToByte('0x' + IntToStr(c1) + '' + IntToStr(c2));
        // ----

        z_pos := z_pos + 1;

        z := z + 1;

        if (z > 19) then
        begin
          if not cxCBnotText.Checked then
            ColorString := ColorString + #13;
          z := 0;
        end;

      end;

      cxProgressBar1.Position := j + 1;
      Application.ProcessMessages;
    end;

    // Удаляем последний символ запятой
    if not cxCBnotText.Checked then
      if ColorString.Length > 0 then
        ColorString := ColorString.Substring(0, ColorString.Length - 2);
    if not cxCBnotText.Checked then
      ColorString := ColorString + '};';

    // Выводим строку в Memo
    Image2.Picture.Assign(LeftBitmap);

    // Удаляем последний символ запятой
    if not cxCBnotText.Checked then
      if ColorString.Length > 0 then
        ColorString := ColorString.Substring(0, ColorString.Length - 2);
    if not cxCBnotText.Checked then
      ColorString := ColorString + '};';

    // Выводим строку в Memo
    if not cxCBnotText.Checked then
      cxLog.lines.Text := ColorString;

    Image3.Picture.Assign(RightBitmap);

  finally
    // Освобождаем ресурсы
    Bitmap.Free;
    LeftBitmap.Free;
    RightBitmap.Free;
    BitmapConv.Free;

    ButUpl.Enabled := True;

    Application.ProcessMessages;
    if not flSw then
      dxBarClear.Click;
  end;

end;

procedure TForm2.cxCheckBox2Click(Sender: TObject);
begin
  cxChFloydSteinberg.EditValue := not cxChFloydSteinberg.EditValue;
end;

procedure TForm2.dxBarButton1Click(Sender: TObject);
begin
  PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TForm2.dxBarButShowClick(Sender: TObject);
var
  url: string;
  response: string;
  dblfl: String;
begin
  if flstop then
    Exit;
  dxStatusBar1.Panels[0].Text := 'Комманда на отображение картинки на esp32';
  Application.ProcessMessages;

  dblfl := '';
  if CheckBox1.Checked then
    dblfl := '2';

  url := trim(edHost.Text) + '/view' + dblfl; // Укажите ваш URL
  try
    TGetRequestThread.Create(url, RequestCompleted).Start;

    if not flSw then
      flSw := True;
  except
    on E: Exception do
      ShowMessageF(E.Message);
  end;
end;

procedure TForm2.ButUplClick(Sender: TObject);
var
  f_name: String;
  url_media: String;
begin
  if flstop then
    Exit;
  dxStatusBar1.Panels[0].Text := 'Загрузка на esp32';
  Application.ProcessMessages;
  f_name := 'arrayadr.bin';
  SaveBytesToFile(Data, f_name);
  url_media := trim(edHost.Text) + '/upload';
  if FileExists(f_name) then
    SendFile(url_media, f_name, f_name, '');

  if not flSw then
    dxBarButShow.Click;
end;

procedure TForm2.dxBarClearClick(Sender: TObject);
var
  url: string;
  response: string;
  Thread: TGetRequestThread;
begin
  if flstop then
    Exit;

  dxStatusBar1.Panels[0].Text := 'Подготовка места для загрузки на esp32';
  Application.ProcessMessages;

  url := trim(edHost.Text) + '/erase';
  try
    TGetRequestThread.Create(url, ButUplClick).Start;
  except
    on E: Exception do
      ShowMessageF(E.Message);
  end;
end;

end.
