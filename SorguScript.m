load('yarislarInd.mat');
global lut yarislarInd

formatIn = 'yy/mm/dd';
sorgu = {};

% yaris
% sorgu{end+1} = sorguElemaniOlustur('Sehir',{'Ýzmir','Ankara'},'or');
% sorgu{end+1} = sorguElemaniOlustur('YarisGunNo',[],[]);
% sorgu{end+1} = sorguElemaniOlustur('Tarih',{datenum('2006/01/01',formatIn), datenum('2007/01/01',formatIn)},'aralik');

% kosu
% sorgu{end+1} = sorguElemaniOlustur('KosuNo',true,{... 
%     sorguElemaniOlustur('KosuNo',false,{}),...
%     sorguElemaniOlustur('Saat',false,{}),...
%     });
% sorgu{end+1} = sorguElemaniOlustur('KosuNo>KosuNo',{1, 2, 3,},'or');
% sorgu{end+1} = sorguElemaniOlustur('KosuCinsi>Diþi',1,'and');
% sorgu{end+1} = sorguElemaniOlustur('KosuCinsi>Y1',1,'and');
% sorgu{end+1} = sorguElemaniOlustur('KosuCinsi>Y2',[],[]);
% sorgu{end+1} = sorguElemaniOlustur('KosuCinsi>Y3',[],[]);

% sorgu{end+1} = sorguElemaniOlustur('Grup>GrupYas',[],[]);
% sorgu{end+1} = sorguElemaniOlustur('Grup>GrupCins',[],[]);

% sorgu{end+1} = sorguElemaniOlustur('Agirlik',false,{
%     sorguElemaniOlustur('Agirlik1',false,{}),...
%     sorguElemaniOlustur('Agirlik2',false,{}),...
%     });
% sorgu{end+1} = sorguElemaniOlustur('Mesafe',{1599 1601},'aralik');
% sorgu{end+1} = sorguElemaniOlustur('Mesafe',1600,[]);
% sorgu{end+1} = sorguElemaniOlustur('Pist',true,{});
% 
% % at
% sorgu{end+1} = sorguElemaniOlustur('At No',false,{});
% sorgu{end+1} = sorguElemaniOlustur('At Ýsmi',true,{
%     sorguElemaniOlustur('Isim',true,{}),...
%     sorguElemaniOlustur('UlkeOrijin',true,{}),...
%     sorguElemaniOlustur('KG',false,{}),...
%     sorguElemaniOlustur('K',false,{}),...
%     sorguElemaniOlustur('SK',false,{}),...
%     sorguElemaniOlustur('SKG',false,{}),...
%     sorguElemaniOlustur('DB',false,{}),...
%     });
% sorgu{end+1} = sorguElemaniOlustur('Yaþ',true,{
%     sorguElemaniOlustur('Yas',false,{}),...
%     sorguElemaniOlustur('Renk',true,{}),...
%     sorguElemaniOlustur('Cinsiyet',false,{}),...
%     });
% sorgu{end+1} = sorguElemaniOlustur('Orijin(Baba)',true,{
%     sorguElemaniOlustur('Isim',true,{}),...
%     sorguElemaniOlustur('UlkeOrijin',true,{}),...
%     });
% sorgu{end+1} = sorguElemaniOlustur('Orijin(Anne)',true,{
%     sorguElemaniOlustur('Isim',true,{}),...
%     sorguElemaniOlustur('UlkeOrijin',true,{}),...
%     });
% sorgu{end+1} = sorguElemaniOlustur('Kilo',true,{
%     sorguElemaniOlustur('Kilo',false,{}),...
%     sorguElemaniOlustur('Sapma',false,{}),...
%     });
% sorgu{end+1} = sorguElemaniOlustur('Jokey Adý',true,{});
% sorgu{end+1} = sorguElemaniOlustur('Sahip Adý',true,{});
% sorgu{end+1} = sorguElemaniOlustur('Antrenör Adý',true,{});
% sorgu{end+1} = sorguElemaniOlustur('HK',false,{});
% sorgu{end+1} = sorguElemaniOlustur('Derece',false,{});
% sorgu{end+1} = sorguElemaniOlustur('Ganyan',false,{});
% sorgu{end+1} = sorguElemaniOlustur('Fark',false,{});

sorgu{end+1} = sorguElemaniOlustur('Mesafe',{889 901},'aralik');
sorgu{end+1} = sorguElemaniOlustur('Tarih',{datenum('2014/04/01',formatIn), datenum('2014/09/01',formatIn)},'aralik');
sorgu{end+1} = sorguElemaniOlustur('Sehir',{'Ankara'},[]);
sorgu{end+1} = sorguElemaniOlustur('Pist',{'Çim'},[]);
sorgu{end+1} = sorguElemaniOlustur('KosuCinsi>KosuCinsi',{'Maiden'},[]);
% sorgu{end+1} = sorguElemaniOlustur('Grup>GrupYas',{'5 ve Yukarý'},[]);
sorgu{end+1} = sorguElemaniOlustur('Grup>GrupCins',{'Araplar'},[]);
sorgu{end+1} = sorguElemaniOlustur('At No',{1 3},'aralik');

indL = olayIndSorgula(sorgu);

% simdi bulunanlari dok
sorguSonucInd = find(indL);
% for i = 1:length(sorguSonucInd)
    kosuBilgiDokum(sorguSonucInd);
    
% end

