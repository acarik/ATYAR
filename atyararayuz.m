function varargout = atyararayuz(varargin)
% ATYARARAYUZ M-file for atyararayuz.fig
%      ATYARARAYUZ, by itself, creates a new ATYARARAYUZ or raises the existing
%      singleton*.
%
%      H = ATYARARAYUZ returns the handle to a new ATYARARAYUZ or the handle to
%      the existing singleton*.
%
%      ATYARARAYUZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATYARARAYUZ.M with the given input arguments.
%
%      ATYARARAYUZ('Property','Value',...) creates a new ATYARARAYUZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before atyararayuz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to atyararayuz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help atyararayuz

% Last Modified by GUIDE v2.5 12-Mar-2015 19:17:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @atyararayuz_OpeningFcn, ...
                   'gui_OutputFcn',  @atyararayuz_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before atyararayuz is made visible.
function atyararayuz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to atyararayuz (see VARARGIN)
global sehirSecenekAciklama grupSecenekAciklama kosuCinsiSecenekAciklama pistSecenekAciklama
% Choose default command line output for atyararayuz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% coktan secmeli her nesnenin altini doldur

% sehir
sehirSecenek = {...
    'Hepsi'
    'Adana'
    'Ýzmir'
    'Ýstanbul'
    'Bursa'
    'Ankara'};
sehirSecenekAciklama = {...
    sehirSecenek(2:5)
    sehirSecenek(2)
    sehirSecenek(3)
    sehirSecenek(4)
    sehirSecenek(5)
    sehirSecenek(6)};
set(handles.popupmenuSehir,'String',sehirSecenek);

% grup
grupSecenek = {...
    'Hepsi'
    '3 Yasli Araplar'
    '4 Yasli Araplar'
    '3 ve Yukari Araplar'
    '4 ve Yukari Araplar'
    '5 ve Yukari Araplar'
    '2 Yasli Ingilizler'
    '3 Yasli Ingilizler'
    '2 ve Yukari Ingilizler'
    '3 ve Yukari Ingilizler'
    '4 ve Yukari Ingilizler'};
grupSecenekAciklama{1} = {...
    {'4 Yaþlý'  '3 Yaþlý'  '5 ve Yukarý'  '4 ve Yukarý'  '2 Yaþlý'  '3 ve Yukarý'  '2 ve Yukarý'}
    '3 Yaþlý'
    '4 Yaþlý'
    '3 ve Yukarý'
    '4 ve Yukarý'
    '5 ve Yukarý'
    '2 Yaþlý'
    '3 Yaþlý'
    '3 ve Yukarý'
    '4 ve Yukarý'};
grupSecenekAciklama{2} = {...
    {'Araplar'  'Ýngilizler'}
    'Araplar'
    'Araplar'
    'Araplar'
    'Araplar'
    'Araplar'
    'Ýngilizler'
    'Ýngilizler'
    'Ýngilizler'
    'Ýngilizler'
    'Ýngilizler'
    };
set(handles.popupmenuGrup,'String',grupSecenek);

% kosu cinsi
kosuCinsiSecenek = {...
    'Hepsi'
    'Acik Hepsi'
    'Acik GR 1'
    'Acik GR 2'
    'Acik GR 3'
    'Acik A 2'
    'Acik A 3'
    'KV Hepsi'
    'KV 6'
    'KV 7'
    'KV 8'
    'KV 9'
    'KV 10'
    'KV 11'
    'KV 18'
    'KV 21'
    'KV 22'
    'KV 23'
    'KV 24'
    'KV 25'
    'Sartli Hepsi'
    'Sartli 1'
    'Sartli 2'
    'Sartli 3'
    'Sartli 4'
    'Sartli 5'
    'Maiden Hepsi'
    'Maiden Disi'
    'Handikap Hepsi'
    'Handikap 13'
    'Handikap 14'
    'Handikap 15'
    'Handikap 16'
    'Handikap 17'
    'D. Sartli Hepsi'
    'D. Sartli 1'
    'D. Sartli 2'
    'D. Sartli 3'
    'D. Sartli 4'
    'D. Sartli 5'
    'D. Handikap Hepsi'
    'D. Handikap 13'
    'D. Handikap 14'
    'D. Handikap 15'
    'D. Handikap 16'
    'D. Handikap 17'
    'D. KV Hepsi'
    'D. KV 6'
    'D. KV 7'
    'D. KV 8'
    'D. KV 9'
    'D. KV 10'
    'D. KV 11'
    'D. KV 18'
    'D. KV 21'
    'D. KV 22'
    'D. KV 23'
    'D. KV 24'
    'D. KV 25'
    'Satis Hepsi'
    'Satis 1'
    'Satis 2'
    'Satis 3'
    'Satis 4'};
% burasi yazilacak daha!!!
kosuCinsiSecenekAciklama = {...
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek
    kosuCinsiSecenek};
set(handles.popupmenuKosu,'String',kosuCinsiSecenek);

% Pist
pistSecenek = {...
    'Hepsi'
    'Cim'
    'Kum'
    'Sentetik Kum'};
pistSecenekAciklama = {...
    pistSecenek;
    'Cim'
    'Kum'
    'Sentetik Kum'};
set(handles.popupmenuPist,'String',pistSecenek)


% UIWAIT makes atyararayuz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = atyararayuz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenuGrup.
function popupmenuGrup_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuGrup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuGrup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuGrup


% --- Executes during object creation, after setting all properties.
function popupmenuGrup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuGrup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuSehir.
function popupmenuSehir_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuSehir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuSehir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuSehir


% --- Executes during object creation, after setting all properties.
function popupmenuSehir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuSehir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTarihBit_Callback(hObject, eventdata, handles)
% hObject    handle to editTarihBit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTarihBit as text
%        str2double(get(hObject,'String')) returns contents of editTarihBit as a double


% --- Executes during object creation, after setting all properties.
function editTarihBit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTarihBit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTarihBas_Callback(hObject, eventdata, handles)
% hObject    handle to editTarihBas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTarihBas as text
%        str2double(get(hObject,'String')) returns contents of editTarihBas as a double


% --- Executes during object creation, after setting all properties.
function editTarihBas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTarihBas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuKosu.
function popupmenuKosu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuKosu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuKosu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuKosu


% --- Executes during object creation, after setting all properties.
function popupmenuKosu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuKosu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMesafeBit_Callback(hObject, eventdata, handles)
% hObject    handle to editMesafeBit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMesafeBit as text
%        str2double(get(hObject,'String')) returns contents of editMesafeBit as a double


% --- Executes during object creation, after setting all properties.
function editMesafeBit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMesafeBit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMesafeBas_Callback(hObject, eventdata, handles)
% hObject    handle to editMesafeBas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMesafeBas as text
%        str2double(get(hObject,'String')) returns contents of editMesafeBas as a double


% --- Executes during object creation, after setting all properties.
function editMesafeBas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMesafeBas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuPist.
function popupmenuPist_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuPist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuPist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuPist


% --- Executes during object creation, after setting all properties.
function popupmenuPist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuPist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAtIsmi_Callback(hObject, eventdata, handles)
% hObject    handle to editAtIsmi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAtIsmi as text
%        str2double(get(hObject,'String')) returns contents of editAtIsmi as a double


% --- Executes during object creation, after setting all properties.
function editAtIsmi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAtIsmi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editJokey_Callback(hObject, eventdata, handles)
% hObject    handle to editJokey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editJokey as text
%        str2double(get(hObject,'String')) returns contents of editJokey as a double


% --- Executes during object creation, after setting all properties.
function editJokey_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editJokey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yarislarInd lut
global sehirSecenekAciklama grupSecenekAciklama kosuCinsiSecenekAciklama pistSecenekAciklama

% tarih
tarihBasStr = get(handles.editTarihBas,'String');
tarihBitStr = get(handles.editTarihBit,'String');
formatIn = 'yy/mm/dd';
tarihBas = datenum(tarihBasStr,formatIn);
tarihBit = datenum(tarihBitStr,formatIn);
ind = getLutInd('Tarih');
bulunanInd{1} = and(yarislarInd(:,ind)>=tarihBas,yarislarInd(:,ind)<=tarihBit);

% sehir
sehirSecilenInd = get(handles.popupmenuSehir,'Value');
[ind, ustInd, altInd] = getLutInd('Sehir');
bulunanInd{2} = lutSorgu([ind, ustInd, altInd],sehirSecenekAciklama{sehirSecilenInd});


aranacaklar{ind}{1} = 'yaris'; % neyin bilgisi
aranacaklar{ind}{2} = 3; % kacinci indeks
aranacaklar{ind}{3} = tarihBasStr;
aranacaklar{ind}{4} = tarihBitStr;

% sehir
ind = ind + 1;
sehirId = get(handles.popupmenuSehir,'Value');
aranacaklar{ind}{1} = 'yaris';
aranacaklar{ind}{2} = 1;
aranacaklar{ind}{3} = sehirId;

% grup
ind = ind + 1;
sehirId = get(handles.popupmenuSehir,'Value');
aranacaklar{ind}{1} = 'yaris';
aranacaklar{ind}{2} = 1;
aranacaklar{ind}{3} = sehirId;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yarislarInd lut
if isempty(lut)
    tic
    load('yarislarInd.mat')
    toc
end
disp('yukluyor');
