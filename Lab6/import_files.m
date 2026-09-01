function [img1, img2, points1, points2] = import_files(address)

if (address == "Mire")
    img1 = imread('Mire\Mire1.pgm');
    img2 = imread('Mire\Mire2.pgm');
    points1 = importdata('Mire\Mire1.points'); 
    points2 = importdata('Mire\Mire2.points'); 

elseif (address == "Rubik")
    img1 = imread('Rubik\Rubik1.pgm'); 
    img2 = imread('Rubik\Rubik2.pgm');
    points1 = importdata('Rubik\Rubik1.points'); 
    points2 = importdata('Rubik\Rubik2.points'); 
end

end