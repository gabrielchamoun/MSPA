clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')
% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  



%************************************************************************
%   
%   The example was obtaining the TE an TM solutions for a single mode
%   in both the x and y direction of the E and M field produced.
%   
%   
%   By changing the number of modes to 10, one can observe the possible
%   permutations in the material and the result.
%   
%   
%   The program was plotting contour plots to visualize what is going on.
%   Changing this to a surface plot can provide a 3D image of what is
%   happening in the material.
%   Neither one is necessairily better than the other, looking at a 
%   contour plot can make it easier to make calculations; however,
%   the surf plot will give a much better view of the magnitude and
%   shape of the mode created.
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
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 10;         % number of modes to compute

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

[HxTE,HyTE,neffTE] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

fprintf(1,'neff = %.6f\n',neffTE);
% Next consider the fundamental TM mode
% (same calculation, but with opposite symmetry)
[HxTM,HyTM,neffTM] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');

fprintf(1,'neff = %.6f\n',neffTM);

for i = 1:nmodes
    figure('name', sprintf('mode: %i', i));
    subplot(221);
    contourmode(x,y,HxTE(:,:,i));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end

    subplot(222);
    contourmode(x,y,HyTE(:,:,i));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end
    

    subplot(223);
    contourmode(x,y,HxTM(:,:,i));
    title('Hx (TM mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end

    subplot(224);
    contourmode(x,y,HyTM(:,:,i));
    title('Hy (TM mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end
end