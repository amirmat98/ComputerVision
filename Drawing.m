function Drawing(ImageName , Noise_Name , Filter_Name , Filter_Size)

figure
subplot(1,2,1), imagesc(ImageName), colormap gray(256)
 
title("Filtered Image with " + Noise_Name +  " Noise" , "(" + num2str(Filter_Size) +" by "+  num2str(Filter_Size)+" "+ Filter_Name + ")")

subplot(1,2,2) , imhist(uint8(ImageName))
title("Filtered Image with " + Noise_Name +  " Noise Histogram", "(" + num2str(Filter_Size) +" by "+  num2str(Filter_Size)+" "+ Filter_Name + " )")

end 