load('yarislarInd.mat');
global lut
%% yaris programi oku ve lut yapisini da kullanarak indeksleri don
% yarislarInd gibi bir yapida idafe et
yarisProgramiInd = YarisProgamiVerisiCek(4,27,4,2015);

%     'Adana';         2
%     '%c4%b0zmir';    1
%     '%c4%b0stanbul'; 5
%     'Bursa';          4
%     'Ankara';};       3
% http://www.tjk.org/TR/yarissever/Info/GetCSV/GunlukYarisProgrami?SehirId=2&QueryParameter_Tarih=29/03/2015&Sehir=%c4%b0zmir
save('yarisProgramiInd.mat','yarisProgramiInd','lut');

%% neuralDataProg olustur
cd neural
neuralYarisProgram
cd ..