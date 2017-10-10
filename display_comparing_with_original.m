function display_comparing_with_original(training_testing_dir, index_dir, Pdegree, image_dir)
%clc;

filename=fullfile(training_testing_dir, 'refl_spec_test.mat');
var_name='refl_spec_te';
%------------------------------------------------------------------------
%| Loading the data into different Variable name
%------------------------------------------------------------------------
hsi_original = load(filename,var_name);  
hsi_original = hsi_original.(var_name);

filename=fullfile(training_testing_dir, 'estimated_reflection_test.mat');
var_name='estimated_reflection_test';
%------------------------------------------------------------------------
%| Loading the data into different Variable name
%------------------------------------------------------------------------
hsi_estimated = load(filename,var_name);  
hsi_estimated = hsi_estimated.(var_name);



MSE=[];

no_of_curve=size(hsi_original,1);

for i=1:no_of_curve
    X=[]; % Storing the original HSI data 
    Y=[]; % Storing the estimated HSI data 

    X= hsi_original(i,:);
    Y= hsi_estimated(i,:);
    s=0;
    a=0;
    for k=1:1024
        d = abs(X(k)- Y(k)); % Abslute differece between original and estimated one
        s=s+d^2; % Squaring the differences and adding them for one spectrum
        a=a+abs(d); % Adding the absolute difference for one spectrum
    end
    
    avg=s/1024; 
    MSE(i)=sqrt(avg); % Calculating the Mean Square Error (MSE) for each spectrum and store it in MSE []
    avg_a=a/1024;
    AVG(i)=a;
end

prob=MSE./AVG;

%------------------------------------------------------------------------
%| We are calculating the probability using the equation
% Prob ( MSE/d  < 0.1) = 0.80
% Prob ( MSE/d  < 0.01) = 0.40
% Prob ( MSE/d  < 0.001) = 0.30
% If the generated Prob values are found using the Plynomial regression
% then we can consider the method as ACCEPTED in Statistics--Dr. Navin
% Bansal, MSCS
%------------------------------------------------------------------------

total_val_p1 = (sum(prob< 0.1))/(no_of_curve);
total_val_p01 = sum(prob< 0.01)/(no_of_curve);
total_val_p001 = sum(prob< 0.00125)/(no_of_curve);

[total_val_p1 total_val_p01 total_val_p001]
%------------------------------------------------------------------------
%| We are making the filename for Original and Estimated reflection spectra
%  here
%------------------------------------------------------------------------

index_file = fullfile(index_dir, 'total_index.mat');
load(index_file);
filename1=sprintf('-%d',testing_set_indx); % adding the testing index followed by -
filename1=strcat(filename1,'deg='); % the degree of plynomial is added in the file name
filename1=strcat(filename1,int2str(Pdegree)); 

filename2=strcat('Ori-Est',filename1); % One file name sholud be for Original spectra
filenameO=strcat(filename2,'');
filename3=strcat('Estimated',filename1);% Another file name sholud be for Estimated spectra
filenameE=strcat(filename3,'');

%------------------------------------------------------------------------
%| We are making the TITLE of the Figures
%------------------------------------------------------------------------
str_title = sprintf('\n P(MSE(i)/d(i) < 0.1 )= %0.2f, \n P(MSE(i)/d(i) < 0.01 )= %0.2f, \n P(MSE(i)/d(i) < 0.00125 )= %0.2f,',total_val_p1, total_val_p01,total_val_p001);
str_OT=sprintf('Original (Deg = %d)', Pdegree);
str_ET=sprintf('Estimated (Deg = %d)', Pdegree);
str_ET=strcat(str_ET,str_title);
%------------------------------------------------------------------------
%| We are drawing the Figure here
%----------------------PLOTTING 1ST FIGURE--------------------------------------------------

x_axis = linspace(294.632,816.582,1024); 

h1=figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1) 
plot(x_axis,hsi_original');
title(str_OT,'fontsize',12);
lgd=legend(int2str(testing_set_indx(1)),int2str(testing_set_indx(2)),int2str(testing_set_indx(3)),int2str(testing_set_indx(4)),int2str(testing_set_indx(5)),int2str(testing_set_indx(6)),int2str(testing_set_indx(7)),int2str(testing_set_indx(8)));
lgd.FontSize = 12;
lgd.Location='southeast';
xlabel('Wavelength (nm)');
ylabel('Intensity (a.u.)');
%---------------------PLOTTING 2ND FIGURE------------------------------------------
subplot(1,2,2) 
plot(x_axis,hsi_estimated');
title(str_ET,'fontsize',12);
lgd=legend(int2str(testing_set_indx(1)),int2str(testing_set_indx(2)),int2str(testing_set_indx(3)),int2str(testing_set_indx(4)),int2str(testing_set_indx(5)),int2str(testing_set_indx(6)),int2str(testing_set_indx(7)),int2str(testing_set_indx(8)));
lgd.FontSize = 12;
lgd.Location='southeast';
xlabel('Wavelength (nm)');
ylabel('Intensity (a.u.)');


%---------------------------------------------------------------
%pos = get(figh,'position');
%set(figh,'position',[pos(1:2)/5 pos(3:4)*3])
%saveas(gcf,filename,'epsc');

%---------------------------------------------------------------
%print(h1,'-depsc',filename);
%h1.PaperPositionMode = 'auto';
%print('ScreenSizeFigure','-dpng','-r0')
%print('-fillpage','FillPageFigure','-dpng')

%---------------------------------------------------------------
%| Saving the Plot in the image folder
%---------------------------------------------------------------

filename=fullfile(image_dir, filenameO);
gcf=h1;
oldscreenunits = get(gcf,'Units');
oldpaperunits = get(gcf,'PaperUnits');
oldpaperpos = get(gcf,'PaperPosition');
set(gcf,'Units','pixels');
scrpos = get(gcf,'Position');
newpos = scrpos/100;

%---------------------------------------------------------------
set(gcf,'PaperUnits','inches', 'PaperPosition',newpos)
print('-depsc', filename, '-r100');
drawnow
set(gcf,'Units',oldscreenunits, 'PaperUnits',oldpaperunits, 'PaperPosition',oldpaperpos);








end