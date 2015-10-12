N = length(lut{1,5}.altElemanlar{1,1}.deger);


%yarislarInd 5.1 ve 5.2 'yi birleþtir, Handikap 16 ve diþi gibi
for i = 1 : 2 : 2*N
    analizLut{1,1}.deger(i,1) = lut{1,5}.altElemanlar{1,1}.deger((i-1)/2 +1 );
    analizLut{1,1}.deger{i+1,1} = [lut{1,5}.altElemanlar{1,1}.deger{(i-1)/2 +1 }  ' Disi'];
end

%yarislar 6.1 lut'u buraya al

analizLut{1,2}.deger = (lut{1,6}.altElemanlar{1,1}.deger)';
analizLut{1,3}.deger = (lut{1,6}.altElemanlar{1,2}.deger)';
analizLut{1,4}.deger = (lut{1,1}.deger)';
analizLut{1,5}.deger = (lut{1,9}.deger)';
analizLut{1,6}.deger = (lut{1,16}.deger)';