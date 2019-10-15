b=imread('input.bmp'); % 24-bit BMP image RGB888
imshow(b);

k=1;
for i=480:-1:1 % image is written from the last row to the first row
for j=1:640
a(k)=b(i,j,1);
a(k+1)=b(i,j,2);
a(k+2)=b(i,j,3);
k=k+3;
end
end
fid = fopen('input.hex', 'wt');
fprintf(fid, '%x\n', a);
disp('Text file write done');disp(' ');
fclose(fid);
% fpga4student.com FPGA projects, Verilog projects, VHDL projects