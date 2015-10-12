myLut = {...
    'a';
    'ab';
    'b';
    'f';
    'c';
    'emmanuel emenike';};

maxlen = 0;
for i = 1:length(myLut)
    if maxlen < length(myLut{i})
        maxlen = length(myLut{i});
    end
end

siralamaDegeri = zeros(length(myLut),1);
t = 512;
for i = 1:length(myLut)
    curr = myLut{i};
    for j = 1:length(curr)
        u = maxlen-j+1;
        siralamaDegeri(i) = siralamaDegeri(i) + curr(j) * t^u;
    end
end

[~, index] = sort(siralamaDegeri);

% siralanmisi olustur
myLutSirali = myLut(index);