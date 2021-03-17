clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')
% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  



%************************************************************************
%   
%   As the ridge width is decreased the electric field present is 
%   higher in magnitude across each boundry in the Y direction. 
%   As the ridge width is increased this magnitude is not decreased 
%   exactly, it is however much more contained within the material.
%   
%   The neff increased as the width increases, however it begins to
%   roll off, indicating that increasing the width further would have
%   little to no effect on the response.
%   
%   Making the mesh 8 times less dense increased the run speed of the
%   simulation. Surprisingly the results obtained are still viable,
%   however the accuracy and the rigid nature of the contours take away
%   some information.
%   
%************************************************************************



% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
% rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute


allneffs = 0;
i=0;
for rw = 0.325:0.0675:1
    i=i+1;
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                                rh,rw,side,dx,dy); 

    % First consider the fundamental TE mode:

    [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

    fprintf(1,'neff = %.6f\n',neff);
    allneffs(1,i) = neff;
    
    figure('name', sprintf('rw= %f', rw));
    subplot(121);
    contourmode(x,y,Hx);
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy);
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
end

figure('name', 'neffs');
plot(0.325:0.0675:1,allneffs);
