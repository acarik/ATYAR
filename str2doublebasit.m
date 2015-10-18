function ret = str2doublebasit(in)
switch in
    case '0'
        ret = 0;
    case '1'
        ret = 1;
    case '2'
        ret = 2;
    case '3'
        ret = 3;
    case '4'
        ret = 4;
    case '5'
        ret = 5;
    case '6'
        ret = 6;
    case '7'
        ret = 7;
    case '8'
        ret = 8;
    case '9'
        ret = 9;
    case '10'
        ret = 10;
    case '11'
        ret = 11;
    case '12'
        ret = 12;
    case '13'
        ret = 13;
    case '14'
        ret = 14;
    case '15'
        ret = 15;
    case '16'
        ret = 16;
    case '17'
        ret = 17;
    case '18'
        ret = 18;
    case '19'
        ret = 19;
    case '20'
        ret = 20;
    case '21'
        ret = 21;
    case '22'
        ret = 22;
    case '23'
        ret = 23;
    case '24'
        ret = 24;
    otherwise
        ret = str2double(in);
end