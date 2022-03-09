

path = '/home/fna/scans/GOS/char';

import mlreportgen.dom.*
import mlreportgen.report.*
rpt = Report('dump/Report_Application1_IFFC', 'pdf');


tp = TitlePage();
tp.Title = 'Prodis GOS X-Ray Detector Characterization. Application 1 (IFFC)';
tp.Image = which('LOGO_NDT_SITE.png');
tp.PubDate = date();
rpt.add(tp);
br = PageBreak();
rpt.add(br);


t = [{'SDD' '448.4 mm' ;
     'SID' '32.49 mm';
     'M' '13.8'
     'Vox Size' '3.57 um'
     'HV' '120 kV' ;
     'Current' '50 mkA' ;
     'Focus size' 'Small (8 um)' ;
     'Exposure' '450 ms';
     'Shots' '720';
     'Rotation Step (deg)' '0.5';
     'Avg' '10';
     'FFC avg' '200';
     'Preprocessing' 'ffc/iffc';
     }];
table = BaseTable(t);
table.Title = 'Tomography configuration';
add(rpt,table);

t = [{'Filters set' 'al-1mm al-2mm al-3mm al-4mm al-5mm al-6mm al-7mm al-8mm al-9mm';
     'FFC avg' '200';
     }];
table = BaseTable(t);
table.Title = 'IFFC Configuration';
add(rpt,table);

br = PageBreak();
rpt.add(br);


slice = loadMetaImage('/home/fna/scans/GOS/char/tomo/beton/V/slice.mha');
%imagesc(slice);
slice = slice(913:1000, 2117:2160);
slice = reshape(slice, [numel(slice) 1]);
rpt.add(Text(sprintf("mean %.3f std %.3f (%.2f %%)", mean(slice), std(slice), (std(slice) / mean(slice)) * 100))); 
plot1 = Image("/home/fna/piter/GOS/iffc/beton1.png");
in = 4.2;
plot1.Width = sprintf("%.3fin", in * 1.0625);
plot1.Height = sprintf("%.3fin", in);
rpt.add(plot1);

slice = loadMetaImage('/home/fna/scans/GOS/char/tomo/beton/corr/V/slice.mha');
%imagesc(slice);
slice = slice(913:1000, 2117:2160);
slice = reshape(slice, [numel(slice) 1]);
rpt.add(Text(sprintf("mean %.3f std %.3f (%.2f %%)", mean(slice), std(slice), (std(slice) / mean(slice)) * 100 ))); 
plot1 = Image("/home/fna/piter/GOS/iffc/beton2.png");
plot1.Width = sprintf("%.3fin", in * 1.0625);
plot1.Height = sprintf("%.3fin", in);
rpt.add(plot1);



t = [{'SDD' '448.4 mm' ;
     'SID' '20.13 mm';
     'M' '22.27'
     'Vox Size' '2.22 um'
     'HV' '70 kV' ;
     'Current' '50 mkA' ;
     'Focus size' 'Small (5 um)' ;
     'Exposure' '3000 ms';
     'Shots' '1200';
     'Rotation Step (deg)' '0.3';
     'Avg' '5';
     'FFC avg' '200';
     'Preprocessing' 'ffc/iffc';
     }];
table = BaseTable(t);
table.Title = 'Tomography configuration';
add(rpt,table);
t = [{'Filters set' 'al-1mm al-2mm al-3mm al-4mm al-5mm al-6mm al-7mm al-8mm al-9mm';
     'FFC avg' '200';
     }];
table = BaseTable(t);
table.Title = 'IFFC Configuration';
add(rpt,table);

br = PageBreak();
rpt.add(br);

slice = loadMetaImage('/home/fna/scans/GOS/char/tomo/max-beton/V/slice.mha');
%imagesc(slice(:, 1:2000));
slice = slice(1459:1525, 1030:1080);
slice = reshape(slice, [numel(slice) 1]);
rpt.add(Text(sprintf("mean %.3f std %.3f (%.2f %%)", mean(slice), std(slice), (std(slice) / mean(slice)) * 100))); 
plot1 = Image("/home/fna/piter/GOS/iffc/max-beton1.png");
in = 4.2;
plot1.Width = sprintf("%.3fin", in * 1.0625);
plot1.Height = sprintf("%.3fin", in);
rpt.add(plot1);

slice = loadMetaImage('/home/fna/scans/GOS/char/tomo/max-beton/corr/V/slice.mha');
%imagesc(slice);
slice = slice(1459:1525, 1030:1080);
slice = reshape(slice, [numel(slice) 1]);
rpt.add(Text(sprintf("mean %.3f std %.3f (%.2f %%)", mean(slice), std(slice), (std(slice) / mean(slice)) * 100 ))); 
plot1 = Image("/home/fna/piter/GOS/iffc/max-beton2.png");
plot1.Width = sprintf("%.3fin", in * 1.0625);
plot1.Height = sprintf("%.3fin", in);
rpt.add(plot1);



close(rpt);


