
% 


% - try to calc individual subset
% - 
% 
% 
% 
% 



%raw = loadMetaImage('c:\scans\pena\0\img_.mhd');
%imagesc(raw(:, :, 1)')

%m_raw = mean(raw, 3);
%imagesc(m_raw)



perc = zeros(size(m_raw, 1), size(m_raw, 2));
spans = zeros(size(m_raw, 1), size(m_raw, 2));

outs = zeros(size(raw, 3), 1);

% thr = 0.1;
% 
% tic
% MaxSpan = 1;
% for i1=1+MaxSpan:size(m_raw, 1)-MaxSpan
%     parfor i2=1+MaxSpan:size(m_raw, 2)-MaxSpan
%         
% %         span = 1;
% %         p = 0;
% %         while (p < thr) && (span < MaxSpan)
% %             span = span + 1;
% %             p = std(reshape(m_raw(i1-span:i1+span, i2-span:i2+span), [(2*span+1)^2, 1])) / m_raw(i1, i2);
% %         end
% %         spans(i1, i2) = span;
% 
% 
%         %perc(i1, i2) = p;
%     end
% end
% 
% toc
% imagesc(spans);

span = 1;
i1 = 160;
i2 = 160;
for i=1:size(raw, 3)
    outs(i) = mean(reshape(raw(i1-span:i1+span, i2-span:i2+span, i), [(2*span+1)^2, 1])) / double(raw(i1, i2, i));
end

outs2 = zeros(size(raw, 3), 1);

for i=10:size(raw, 3)-9
    outs2(i) = median(outs(i-2:i+2));
end

plot(10:numel(outs2)-9, outs2(10:end-9), '.-b');



