function tline = fgetl(fid)
tline = fgets(fid);
tline = tline(1:end-2);

% 
% narginchk(1,1)
% 
% [tline,lt] = fgets(fid);
% tline = tline(1:end-length(lt));
% if isempty(tline)
%     tline = '';
% end
% 
% end
