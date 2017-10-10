function spliting_rgb_mat_file_data(rgb_data_source_dir, rgb_mat_file_name, rgb_data_var_name,rgb_destination_dir)

%######################################################################################################
% Since we got the normalized data of RGB and Hyper Spectral Intensity
% (HSI) together, we need to split those MAT files as individual NOR files.
% Here each individual NOR file is kept inside the "rgb_destination_dir" and
% 

%                   In this Matlab code, I have split the RGB data 
%######################################################################################################
clc;


dir_name=rgb_data_source_dir;
mat_file=rgb_mat_file_name;
var_name=rgb_data_var_name;

filename=fullfile(dir_name, mat_file);

rgb_data = load(filename,var_name);  % Function output form of LOAD
rgb_data = rgb_data.(var_name);


total_file=size(rgb_data,4);

nor_rgb_data=[];

%------------------------------------------------------------------------
%| To store the RGB pixels for each frame  
%------------------------------------------------------------------------

red_pixel=[];
green_pixel=[];
blue_pixel=[];

avg_red=0;
avg_red=0;
avg_red=0;

for indx=1:total_file
   
    %------------------------------------------------------------------------
    %| Making the saving location of the averaged RGB pixel information
    %------------------------------------------------------------------------

    
    mat_file = sprintf('nor_rgb_%d.mat', indx);
    filename=fullfile(rgb_destination_dir, mat_file);
 
    %------------------------------------------------------------------------
    %| Extracting the red, green and blue pixels individually
    %------------------------------------------------------------------------

    red_pixels=rgb_data(:,:,1,indx);
    green_pixels=rgb_data(:,:,2,indx);
    blue_pixels=rgb_data(:,:,3,indx);
    
    %------------------------------------------------------------------------
    %| Averaging each frame's read, green and blue pixels
    %------------------------------------------------------------------------

    avg_red=mean2(red_pixels);
    avg_green=mean2(green_pixels);
    avg_blue=mean2(blue_pixels);
    
    
    %------------------------------------------------------------------------
    %| Organizing the averaged RGB pixel information
    %| For example in this format  131.8745  132.8863  116.4164
    %------------------------------------------------------------------------

    nor_rgb_data=[avg_red avg_green avg_blue];
    
    save(filename,'nor_rgb_data');
    
    nor_rgb_data=[];
    
end