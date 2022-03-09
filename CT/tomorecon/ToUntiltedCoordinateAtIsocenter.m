function untitled = ToUntiltedCoordinateAtIsocenter(coord, sid, sdd, sx, px)

    
% double
% rtk::ThreeDCircularProjectionGeometry::
% ToUntiltedCoordinateAtIsocenter(const unsigned int noProj,
%                                 const double tiltedCoord) const
% {
%   // Aliases / constant
%   const double sid  = this->GetSourceToIsocenterDistances()[noProj];
%   const double sid2 = sid*sid;
%   const double sdd  = this->GetSourceToDetectorDistances()[noProj];
%   const double sx   = this->GetSourceOffsetsX()[noProj];
%   const double px   = this->GetProjectionOffsetsX()[noProj];
% 
%   // sidu is the distance between the source and the virtual untilted detector
%   const double sidu = sqrt(sid2 + sx*sx);
%   // l is the coordinate on the virtual detector parallel to the real detector
%   // and passing at the isocenter
%   const double l    = (tiltedCoord + px - sx) * sid / sdd + sx;
% 
%   // a is the angle between the virtual detector and the real detector
%   const double cosa = sx/sidu;
% 
%   // the following relation refers to a note by R. Clackdoyle, title
%  // "Samping a tilted detector"
%   return l * std::abs(sid) / (sidu - l*cosa);
% }


sid2 = sid * sid;
sidu = sqrt(sid2 + sx * sx);
l = (coord + px - sx) * sid / sdd + sx;
cosa = sx / sidu;
untitled = l * abs(sid) / (sidu - l * cosa);


return



