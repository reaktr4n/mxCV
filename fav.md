# Matlab
* https://de.mathworks.com/help/matlab/creating_guis/app-or-gui-with-graphical-table.html;jsessionid=72c7ebd10741b9f7d19ac8609a99
* https://www.mathworks.com/help/parallel-computing/gpu-computing-in-matlab.html
* https://www.mathworks.com/company/newsletters/articles/gpu-programming-in-matlab.html
* https://de.mathworks.com/help/matlab/data-type-identification.html
* https://de.mathworks.com/help/matlab/ref/double.html
* https://www.mathworks.com/help/matlab/ref/getenv.html
* https://www.mathworks.com/help/matlab/ref/strcat.html
* https://www.mathworks.com/help/matlab/ref/reshape.html
* https://www.mathworks.com/help/matlab/ref/strip.html
* https://www.mathworks.com/help/matlab/ref/ispc.html
* https://www.cs.cmu.edu/~16385/s17/
* https://www.mathworks.com/help/matlab/matlab_prog/measure-performance-of-your-program.html
* https://www.mathworks.com/help/matlab/ref/axis.html
* https://www.mathworks.com/help/matlab/ref/scatter.html

# Troubleshoot

# Excerpts
(1) Store a range of values in an array
```matlab
%start:increment:end
a = 0:1:10;
```
(2) Creating Integer Data
```matlab
>> x = 12
x =
    12
>> class(x)
ans =
    'double'
>> x = int8 (x);
>> class (x)
ans =
    'int8'
```
(3) Reshaping the matrix row-major wise
```matlab
>> d = 1:1:9
d =
     1     2     3     4     5     6     7     8     9
>> d_cm = reshape(d, 3, []) % reshaping column-major wise
d_cm =
     1     4     7
     2     5     8
     3     6     9
>> d_rm = reshape(d, 3, [])' % reshaping row-major wise
d_rm =
     1     2     3
     4     5     6
     7     8     9
```
(4) Remove leading and trailing characters from string
```matlab
>> s = ' this is a string '
>> stripped_s = strip (s)
stripped_s =
    'this is a string'
```
(5) Determine if version is for Windows (PC) platform
```matlab
% using a Windows PC
>> isunix
ans =
  logical
   0
>> ispc
ans =
  logical
   1
>> ismac
ans =
  logical
   0
```
(6) Subplots
```matlab
r = 3;
c = 3;
% The total number of subplots = rxc
% subplot (r,c,<1,2,3,...,rxc>)
% do_something
subplot (1,2,1)
imshow (imgs);
title ('Original');
subplot (1,2,2)
imshow (gbimage);
title ('gbimage');
```
(7) Value of floor function of intX and double variables are different
```matlab
>> l = 3
l =
     3
>> l = int8(l)
l =
  int8
   3
>> floor (l/2)
ans =
  int8
   2
>> l = 3
l =
     3
>> class(l)
ans =
    'double'
>> floor (l/2)
ans =
     1
```
(8) Convert NaN to zeros
```matlab
>> h=zeros(3,3);
>> k=zeros(3,3);
>> hk=atand(h./k);
>> hk
hk =
   NaN   NaN   NaN
   NaN   NaN   NaN
   NaN   NaN   NaN
>> hk (isnan (hk)) = 0; % hk (isnan (hk(:))) = 0 works too
>> hk
hk =
     0     0     0
     0     0     0
     0     0     0
```
(9) Inverse tangent in degrees
```matlab
>> a
a =
     1     2     3
     4     5     6
     7     8     9
>> b
b =
     1     2     3
     4     5     6
     7     8     9
>> atand(b./a)
ans =
    45    45    45
    45    45    45
    45    45    45
```
(10) Measure Performance of Your Program

To measure the time required to run a function, use the timeit function. The timeit function calls the specified function multiple times, and returns the median of the measurements. It takes a handle to the function to be measured and returns the typical execution time, in seconds. Suppose that you have defined a function, computeFunction, that takes two inputs, x and y, that are defined in your workspace. You can compute the time to execute the function using timeit.
```matlab
f = @() myComputeFunction(x,y); % handle to function
timeit(f)
```
(11) PLot two or more arrays in the same scatter plot
```matlab
t_ssim = [0.754235, 0.755368 ,0.7518, 0.7979, 1.386524, 1.358653, 10.844451, 1.469667, 2.554084, 1.367075];
t_wossim = [0.520721, 0.529283, 0.5263, 0.5637, 0.968055, 0.984102, 7.609721, 1.009758, 1.770150, 0.980870];
figure
% to know more about markers visit - https://www.mathworks.com/help/matlab/ref/scatter.html
h1 = plot (t_ssim, '-o'); % plot handle for the first plot
hold on
h2 = plot (t_wossim, '-x'); % plot handle for the second plot
legend([h1,h2], 'With shape shifting image and kernels', 'With border treatment')
xlim([0.9 11]) % x-axis limits
ylim([0 15])   % y-axis limits
```
# Results
(1) Performance comparison of shape-shiftng kernel/image and without shape-shiftng (with border treatment). Although, the shape-shifting function takes longer than border treated convolution, there were no artifacts observed. 
![t_ssim_t_wossim.jpg](t_ssim_t_wossim.jpg)